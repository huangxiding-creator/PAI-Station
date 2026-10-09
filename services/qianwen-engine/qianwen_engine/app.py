# -*- coding: utf-8 -*-
"""总包千问引擎 API（FastAPI）。

P0 端点：
  POST /api/login          {code} → {token, quota}
  POST /api/ask            {question} → {id, status, quota}（异步流水线）
  GET  /api/answer/{id}    → 答案详情（未解锁只给 preview；锅圈答案全员可见）
  POST /api/answer/{id}/like        → 有用 +1 次（每答案一次）
  POST /api/answer/{id}/criticize   {text} → 存证 + 具体纠错意见赠 1 次
  POST /api/answer/{id}/export      → 导出文件（base64）；v0.7.3 起不赠次
  POST /api/question/optimize       → AI 优化提问（递进式三小问，10 次/天）
  POST /api/answers/export_all      → 全部咨询记录批量导出（docx/pdf/md）
  GET  /api/pot/list                → 锅圈热点问题列表（100 字预览）
  GET  /api/history        → 我的提问
  GET  /api/engine/status  → 引擎护栏状态

v0.6.0 100× 弧线（全免费：智谱接地，绝不烧 KB 积分）：
  POST /api/answer/{aid}/followup   {question} → {id,status} 免费追问（异步回答）
  GET  /api/answer/{aid}/followups  → 本人的追问对话流
  GET  /api/answer/{aid}/digest     → 要点速览 tldr + 相关问题 related（每答案缓存一次）
  GET  /api/answer/{aid}/poster     → 分享海报 PNG（base64；问题+要点+品牌+小程序码）

v0.7.0（用户十一点令 0930）：
  GET  /api/answer/{aid}            → pending 态携带 partial（SSE 流式增量正文，打字机素材）
  POST /api/answer/{aid}/share_on   → 共享入锅圈 + 赠 1 次咨询（本人已完成答案）
  POST /api/answer/{aid}/share_off  → 取消共享：撤出锅圈 + 扣 1 次咨询
  GET  /api/answer/{aid}/citations/{n} → 依据来源全文展开（智谱接地，aid+n 永久缓存）
  公益免费：付费墙拆除（unlocked 恒真，全文直接下发）
"""
from __future__ import annotations

import base64
import hashlib
import json
import logging
import os
import re
import secrets
import threading
import time
from typing import Optional

from fastapi import FastAPI, HTTPException, Request
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import FileResponse
from pydantic import BaseModel

from . import config, exporter, metaso_kb, poster, potcat, report_catalog, store, wechat, zhipu

_log = logging.getLogger("qianwen.app")

app = FastAPI(title="qianwen-engine", version="0.4.0")
app.add_middleware(
    CORSMiddleware, allow_origins=["*"], allow_methods=["*"], allow_headers=["*"]
)

# 串行闸：KB 引擎一次一问（网页会话共享 + 节流铁律）
_ask_lock = threading.Semaphore(1)

# v0.2.2 透明化：每问的阶段事件流（内存态，随进程；落库为终态 status）
# v0.7.0：新增 partial（流式增量正文——打字机素材）与 chars（实时字数）
_PROGRESS: dict = {}
_PROG_LOCK = threading.Lock()


def _openid(req: Request) -> str:
    auth = req.headers.get("Authorization", "")
    token = auth[7:] if auth.startswith("Bearer ") else ""
    openid = wechat.verify_token(token)
    if not openid:
        raise HTTPException(401, "未登录或凭证过期")
    return openid


class LoginIn(BaseModel):
    code: str


class AskIn(BaseModel):
    question: str


class CriticizeIn(BaseModel):
    text: str


@app.post("/api/login")
def login(body: LoginIn):
    # 测试双闸（默认关，仅自动化测试进程开）：code 直映射 dev openid + 假答案
    if os.environ.get("QW_DEV_LOGIN") == "1":
        openid = "dev-" + body.code
        return {"token": wechat.issue_token(openid), "quota": store.quota_left(openid)}
    try:
        sess = wechat.code2session(body.code)
    except Exception as exc:  # noqa: BLE001
        raise HTTPException(502, f"微信登录失败: {exc}") from exc
    openid = sess["openid"]
    # v0.8.0 虚拟支付回归：session_key 服务端留存是支付双签名刚需（对抗审计
    # CRITICAL-1：不落盘=签名腿恒 401 死锁）。仅存服务端用于 HMAC 签名，
    # 绝不下发客户端、绝不出现在任何 API 响应——合规面等价于微信官方推荐形态。
    store.save_session(openid, sess.get("session_key") or "")
    return {
        "token": wechat.issue_token(openid),
        "quota": store.quota_left(openid),
    }


@app.post("/api/ask")
def ask(body: AskIn, request: Request):
    """v0.2.2 异步流水线：校验+扣次+落 pending 行后秒回，KB 在后台线程跑。"""
    openid = _openid(request)
    q = (body.question or "").strip()
    if not q:
        raise HTTPException(400, "问题不能为空")
    if len(q) > 500:
        raise HTTPException(400, "问题过长（≤500字）")
    if not store.consume_one(openid):
        raise HTTPException(
            402, "今日免费次数已用完；点「有用/纠错」或把自己的问答「共享」进锅圈可再获次数",
        )
    aid = store.create_pending(openid, q)
    with _PROG_LOCK:
        _PROGRESS[aid] = {"t0": time.time(), "events": []}
    _ev(aid, "已提交，进入队列")
    threading.Thread(target=_run_answer, args=(aid, openid, q), daemon=True).start()
    return {"id": aid, "status": "pending", "quota": store.quota_left(openid)}


def _ev(aid: str, text: str) -> None:
    with _PROG_LOCK:
        p = _PROGRESS.get(aid)
        if p is not None:
            p["events"].append({"t": round(time.time() - p["t0"], 1), "text": text})


def _ev_stream(aid: str, chars: int, partial: str, tail: str) -> None:
    """流式进度：合并同一阶段为单行（进度列表不膨胀），并刷新 partial 正文。"""
    with _PROG_LOCK:
        p = _PROGRESS.get(aid)
        if p is None:
            return
        p["partial"] = partial or ""
        p["chars"] = int(chars or 0)
        entry = {"t": round(time.time() - p["t0"], 1), "text": tail, "stream": True}
        if p["events"] and p["events"][-1].get("stream"):
            p["events"][-1] = entry
        else:
            p["events"].append(entry)


def _run_answer(aid: str, openid: str, q: str) -> None:
    """后台跑总包智库：一次一问（串行闸），全程事件外送，失败自动退次。"""
    try:
        if not _ask_lock.acquire(timeout=300):
            raise metaso_kb.EngineError("排队超时（前面的问题占用了引擎），请稍后重试")
        _ev(aid, "开始处理")
        try:
            if os.environ.get("QW_FAKE_ASK") == "1":
                time.sleep(0.3)
                result = metaso_kb.KbAnswer(
                    question=q,
                    answer=(
                        "【测试答案】用于自动化回归，不烧秘塔积分。\n\n"
                        "## 关键要点\n\n"
                        "- 要点一：配额与退次全链验证\n"
                        "- 要点二：**结构化渲染**不得有裸符号\n\n"
                        "1. 查招标文件专用合同条款\n"
                        "2. 核对金额上限\n\n"
                        "> 依据《测试规范》第 12 条\n\n"
                        "| 情形 | 限额 |\n|---|---|\n| 依法必须招标 | 2% |\n\n"
                        + "段落内容。" * 30
                    ),
                    cid="test-cid",
                    url="https://example.invalid/test",
                    citations=[{"n": 1, "source": "测试规范", "loc": 12}],
                    elapsed_sec=0.3,
                )
            else:
                def cb(kind: str, data: dict) -> None:
                    if kind == "delivered":
                        _ev(aid, "问题已送达总包智库")
                    elif kind == "session_refreshing":
                        _ev(aid, "会话续期中…")
                    elif kind == "streaming":
                        _ev_stream(aid, data.get("chars", 0), data.get("partial", ""),
                                   "总包智库检索中 · 已生成 {} 字".format(data.get("chars", 0)))
                    elif kind == "polling":
                        _ev_stream(aid, data.get("chars", 0), "",  # 兜底线无 partial 素材
                                   "总包智库检索中 · 第{}轮 · 已生成 {} 字".format(
                                       data.get("round", 1), data.get("chars", 0)))
                result = metaso_kb.ask(q, on_event=cb)
            store.complete_answer(aid, result.answer, result.citations, result.elapsed_sec)
            _ev(aid, "回答完成")
        finally:
            _ask_lock.release()
    except Exception as exc:  # noqa: BLE001
        store.fail_answer(aid, str(exc))
        store.refund_one(openid)
        _ev(aid, "处理失败，已自动退回提问次数")


@app.get("/api/answer/{aid}")
def answer(aid: str, request: Request):
    openid = _openid(request)
    row = store.get_answer_visible(aid, openid)
    if row is None:
        raise HTTPException(404, "答案不存在")
    status = row["status"]
    is_pot = row["openid"] == config.POT_OPENID
    # 锅圈=公共内容：点赞态按人走 rewards 表；本人答案=行级 flag
    liked = (store.reward_exists(openid, aid, "like") if is_pot else bool(row["liked"]))
    # v0.7.0 公益免费令：付费墙拆除——全文直接下发，unlocked 恒真（列留作兼容）
    d = {"id": aid, "question": row["question"], "status": status,
         "error_text": row["error_text"] if "error_text" in row.keys() else "",
         "unlocked": True,
         "preview": row["answer_full"][: config.PREVIEW_CHARS],
         "answer": row["answer_full"],
         "citations": row["citations"],
         "full_chars": len(row["answer_full"]),
         "liked": liked, "criticized": bool(row["criticized"]) if not is_pot else False,
         "is_pot": is_pot,
         # v0.8.0 导出收费：仅本人答案可付费导出（is_owner + export_paid 驱动客户端付费墙）
         "is_owner": row["openid"] == openid,
         "export_paid": bool(row["export_paid"]) if "export_paid" in row.keys() else False,
         "shares": (row["shares"] if "shares" in row.keys() else 0) or 0,
         "shared": bool(row["shared"]) if "shared" in row.keys() else False,
         "can_share": (not is_pot and status == "ready" and bool(row["answer_full"])),
         }
    if status == "pending":
        with _PROG_LOCK:
            prog = _PROGRESS.get(aid)
            if prog:
                d["progress"] = list(prog["events"])
                d["elapsed"] = round(time.time() - prog["t0"], 1)
                # v0.7.0 流式正文：打字机素材（生成中即见增量）
                d["partial"] = prog.get("partial", "")
                d["stream_chars"] = prog.get("chars", 0)
            else:
                d["progress"], d["elapsed"], d["partial"], d["stream_chars"] = [], 0, "", 0
    else:
        # v0.7.3（用户令）观看计数：看到全文即 +1（同人重复看持续累计；pending 轮询不计）
        d["views"] = store.bump_views(aid)
    return d


@app.post("/api/answer/{aid}/like")
def like(aid: str, request: Request):
    openid = _openid(request)
    row = store.get_answer_visible(aid, openid)
    if row is None:
        raise HTTPException(404, "答案不存在")
    if row["openid"] == openid:
        # 本人答案：行级 flag 去重 + 赠次
        if not store.mark_liked(aid, openid):
            raise HTTPException(400, "已点赞过")
        granted = store.grant_reward(openid, aid, "like")
    else:
        # 锅圈公共答案：按人走 rewards UNIQUE 去重（人人可赞）
        granted = store.grant_reward(openid, aid, "like")
        if not granted:
            raise HTTPException(400, "已点赞过")
    return {"granted": granted, "quota": store.quota_left(openid)}


@app.post("/api/answer/{aid}/criticize")
def criticize(aid: str, body: CriticizeIn, request: Request):
    openid = _openid(request)
    text = (body.text or "").strip()
    if not text:
        raise HTTPException(400, "请写具体的纠错意见")
    if not store.save_criticism(aid, openid, text):
        raise HTTPException(400, "本答案已反馈过（每答案限一次）")
    # 用户令 v0.5.0：给出具体纠错意见 = 奖励 1 次免费咨询
    granted = store.grant_reward(openid, aid, "criticize")
    return {"received": True, "granted": granted, "quota": store.quota_left(openid)}


# v0.8.0 审计整改：旧「分享赠次」端点 /api/answer/{aid}/share 已下线
# （0.7.6 起分享不赠次、客户端零调用——留着徒增「诱导分享」翻旧账风险）。


# ── v0.7.0 用户共享入锅圈（用户令 0930 第 8 条）：共享赠 1 次 / 取消共享扣 1 次 ──
@app.post("/api/answer/{aid}/share_on")
def share_on(aid: str, request: Request):
    """本人的已完成问答 → 共享进锅圈（公共展区）+ 赠 1 次咨询机会。
    v0.7.4 提审合规：入库前过 security.msgSecCheck（UGC 公开展示门，fail-closed）。"""
    openid = _openid(request)
    row = store.get_answer_visible(aid, openid)
    if row is None or row["openid"] != openid or row["status"] != "ready":
        raise HTTPException(400, "本篇暂不可共享（仅本人已完成解答，且未共享过）")
    try:
        ok_q = wechat.msg_sec_check(row["question"], openid)
        ok_a = wechat.msg_sec_check(row["answer_full"], openid)
    except Exception as exc:  # noqa: BLE001
        raise HTTPException(503, "内容安全检测暂不可用，请稍后再试") from exc
    if not (ok_q and ok_a):
        raise HTTPException(400, "内容未通过安全检测，暂不能共享")
    if not store.share_on(aid, openid):
        raise HTTPException(400, "本篇暂不可共享（仅本人已完成解答，且未共享过）")
    return {"shared": True, "quota": store.quota_left(openid)}


class PotReportIn(BaseModel):
    aid: str
    reason: str


@app.post("/api/pot/report")
def pot_report(body: PotReportIn, request: Request):
    """v0.7.4 提审合规：锅圈 UGC 内容举报入口（每用户每条限一次，无奖励）。"""
    openid = _openid(request)
    reason = (body.reason or "").strip()
    if not reason:
        raise HTTPException(400, "请填写举报原因")
    if len(reason) > 500:
        raise HTTPException(400, "举报原因过长（≤500字）")
    if not store.save_pot_report((body.aid or "").strip(), openid, reason):
        raise HTTPException(400, "该内容不存在或您已举报过")
    return {"received": True}


@app.post("/api/answer/{aid}/share_off")
def share_off(aid: str, request: Request):
    """取消共享：撤出锅圈 + 扣 1 次咨询机会。"""
    openid = _openid(request)
    if not store.share_off(aid, openid):
        raise HTTPException(400, "本篇当前不在共享状态")
    return {"shared": False, "quota": store.quota_left(openid)}


class ExportIn(BaseModel):
    fmt: str  # docx | pdf（md 由小程序本地生成，不走引擎）


@app.post("/api/answer/{aid}/export")
def export_answer(aid: str, body: ExportIn, request: Request):
    """v0.4.0 导出：Word/PDF 文件（base64 回传）。v0.7.0 公益免费：全文开放。
    v0.7.3（用户令）：导出不再赠次——赠次动作=like/criticize/share 三件。
    v0.8.0（用户令 1008）：咨询全免费，导出按条收费 ¥0.1——仅本人答案、须已解锁。"""
    openid = _openid(request)
    row = store.get_answer(aid, openid)
    if row is None:
        raise HTTPException(404, "答案不存在")
    if row["status"] != "ready":
        raise HTTPException(400, "回答尚未完成，稍后再试")
    if not (row["export_paid"] if "export_paid" in row.keys() else 0):
        raise HTTPException(402, "导出未解锁（¥0.1/条），请先在导出弹窗完成支付")
    try:
        out = exporter.build((body.fmt or "").strip().lower(), row)
    except exporter.FontMissing as exc:
        raise HTTPException(503, str(exc)) from exc
    except exporter.FormatNotSupported as exc:
        raise HTTPException(400, str(exc)) from exc
    except Exception as exc:  # noqa: BLE001
        raise HTTPException(500, f"导出失败: {exc}") from exc
    return out


class ExportAllIn(BaseModel):
    fmt: str  # docx | pdf | md


@app.post("/api/answers/export_all")
def export_all(body: ExportAllIn, request: Request):
    """v0.5.0 批量导出：用户全部已完成问答（docx/pdf/md）。不参与赠次（防刷）。
    v0.8.0（用户令 1008）：须全部条目已解锁（批量支付 N×¥0.1），否则 402。"""
    openid = _openid(request)
    rows = store.history_all(openid)
    if not rows:
        raise HTTPException(404, "还没有完成的咨询记录")
    unpaid = sum(1 for r in rows if not r.get("export_paid"))
    if unpaid:
        total_yuan = unpaid * config.EXPORT_PRICE_FEN / 100
        raise HTTPException(402, f"还有 {unpaid} 条未解锁（¥0.1/条，共 ¥{total_yuan:g}），请先完成批量支付")
    try:
        return exporter.build_all((body.fmt or "").strip().lower(), rows)
    except exporter.FontMissing as exc:
        raise HTTPException(503, str(exc)) from exc
    except exporter.FormatNotSupported as exc:
        raise HTTPException(400, str(exc)) from exc
    except Exception as exc:  # noqa: BLE001
        raise HTTPException(500, f"批量导出失败: {exc}") from exc


# ── v0.5.0 AI 优化提问：把问题改写成递进式三小问（更深入/更清晰/更究竟/更根本） ──
OPTIMIZE_PROMPT = (
    "你是资深工程总包咨询专家，也是提问教练。请把下面这个工程咨询问题改写成一个"
    "更深入、更清晰、更究竟、更根本的新问题：新问题采用递进式结构，至少由三个"
    "层层深入的小问组成（第一问问定性结论，第二问问法律与合同依据，第三问及以上"
    "问具体操作步骤、证据准备与风险防范）。只输出改写后的新问题本身，不要回答"
    "这个问题，不要任何解释、前言或后缀，控制在 200 字以内。\n\n原问题：{q}"
)


@app.post("/api/question/optimize")
def question_optimize(body: AskIn, request: Request):
    """AI 优化提问：智谱免费链主引擎（用户令 0929，不烧 KB 积分池）；
    无 key/全链失败回落总包智库 KB 免费池（串行闸）。每用户每天 10 次。"""
    openid = _openid(request)
    q = (body.question or "").strip()
    if len(q) < 2 or len(q) > 500:
        raise HTTPException(400, "请先输入 2-500 字的咨询问题再优化")
    if not store.consume_optimize(openid):
        raise HTTPException(
            429, f"今日 AI 优化次数已用完（每天 {config.OPTIMIZE_DAILY_CAP} 次），明天再来",
        )
    if zhipu.configured():
        try:
            optimized = zhipu.rewrite(OPTIMIZE_PROMPT.format(q=q))
        except Exception as exc:  # noqa: BLE001
            store.refund_optimize(openid)
            raise HTTPException(502, f"AI 优化失败: {exc}") from exc
    else:
        if not _ask_lock.acquire(timeout=150):
            store.refund_optimize(openid)
            raise HTTPException(503, "总包智库正忙，请稍后再试")
        try:
            result = metaso_kb.ask(OPTIMIZE_PROMPT.format(q=q))
        except Exception as exc:  # noqa: BLE001
            store.refund_optimize(openid)
            raise HTTPException(502, f"AI 优化失败: {exc}") from exc
        finally:
            _ask_lock.release()
        optimized = (result.answer or "").strip()
    if len(optimized) < 10:
        store.refund_optimize(openid)
        raise HTTPException(502, "优化结果异常，已退还本次次数，请稍后再试")
    return {
        "optimized": optimized[:500],
        "left": max(0, config.OPTIMIZE_DAILY_CAP - store.opt_used_today(openid)),
    }


@app.get("/api/stats")
def public_stats():
    """v0.9.10 用户令 1010：首页社会信任面——注册用户总数+咨询总数。
    公开聚合数（非个人信息，未登录可看）；官方种子账号（POT_OPENID）不计入。"""
    return store.public_stats()


# ── v0.5.0 锅圈：打破砂锅问到底（公共热点问题展区） ──
@app.get("/api/pot/list")
def pot_list(request: Request):
    """v0.9.10 用户令 1009：锅圈分类标签——读时纯函数打标（存量/新增即打即得，
    规则升级全员自动重标）；cats=全量计数（切筛不清 chips）；?cat= 过滤。"""
    _openid(request)
    cat = (request.query_params.get("cat") or "").strip()
    items = store.pot_list()
    for it in items:
        it["cat"] = potcat.classify(it.get("question") or "")
    cats = []
    for name, _kws in potcat.CATEGORY_RULES + ((potcat.FALLBACK_CATEGORY, ()),):
        n = sum(1 for it in items if it["cat"] == name)
        if n:
            cats.append({"name": name, "n": n})
    if cat:
        items = [it for it in items if it["cat"] == cat]
    return {"items": items, "cats": cats}


@app.get("/api/history")
def my_history(request: Request):
    openid = _openid(request)
    # export_unpaid_all=服务端权威未解锁计数（审计 MEDIUM-5：客户端只看 20 条
    # 截断列表会算错批量弹窗金额，与实际扣款不符）
    all_rows = store.history_all(openid)
    unpaid_n = len([r for r in all_rows if not r.get("export_paid")])
    return {"items": store.history(openid), "quota": store.quota_left(openid),
            "export_unpaid_all": unpaid_n}


@app.get("/api/quota")
def my_quota(request: Request):
    openid = _openid(request)
    return {"quota": store.quota_left(openid)}


@app.get("/api/engine/status")
def engine_status():
    return metaso_kb.engine_status()


# ── v0.8.0 虚拟支付·导出收费（用户令 1008）：咨询全免费；导出 ¥0.1/条（单条/批量同价） ──
# 旧 ¥1 整篇解锁已按用户令下线；道具 export_once 10 分（货架），buyQuantity=条数。
def _vp_config() -> dict:
    f = config.VIRTUAL_PAY_FILE
    if not f.exists():
        return {}
    out: dict = {}
    for line in f.read_text(encoding="utf-8").splitlines():
        line = line.strip()
        if line and "=" in line and not line.startswith("#"):
            k, v = line.split("=", 1)
            out[k.strip()] = v.strip()
    return out


def _make_otn(prefix: str, anchor: str) -> str:
    """outTradeNo：合法字符 [0-9A-Za-z_-|*@]，8-32 位，不以下划线开头；
    尾接毫秒 base36（6 位）+ 4 位随机熵（审计 LOW-6：防同毫秒双开单碰撞
    与尾 5 位截断的复用窗口）。"""
    base = re.sub(r"[^0-9A-Za-z_\-|*@]", "x", anchor)[:24]
    tail = format(int(time.time() * 1000), "36")[-6:] + secrets.token_hex(2)
    otn = (prefix + base + "-" + tail)[:32]
    return ("q" + otn[1:]) if otn.startswith("_") else otn


def _order_status_paid(d: dict) -> tuple:
    """从微信查单应答提取 (status, paid)。明确成功枚举 → True；明确未付/关闭 →
    False；字段缺失或陌生枚举 → None（对账中——fail-closed，绝不猜）。"""
    o = d.get("order") if isinstance(d.get("order"), dict) else d
    status = ""
    for k in ("status", "pay_status", "order_status", "trade_state"):
        v = o.get(k) if isinstance(o, dict) else None
        if v:
            status = str(v).upper()
            break
    if status in ("SUCCESS", "PAYED", "PAID"):
        return status, True
    if status in ("NOTPAY", "NOT_PAY", "CLOSED", "PAYERROR", "REFUND", "USERPAYING"):
        return status, False
    return status or "UNKNOWN", None


def _query_paid(openid: str, otn: str, vp: dict, env_val: int,
                app_key: str, session_key: str) -> bool | None:
    """微信侧查单 → True已付/False未付/None查不出（复用单与回调核验共用的探测腿）。"""
    try:
        d = wechat.xpay_query_order(openid, otn, vp["offer_id"],
                                    env_val, app_key, session_key)
    except wechat.XpayError:
        return None
    return _order_status_paid(d)[1]


def _verify_order_paid(order: dict, openid: str, vp: dict, env_val: int,
                       app_key: str, session_key: str) -> None:
    """回调腿核验（审计 CRITICAL-2）：微信查单确认已付才放行，绝不裸信客户端。

    生产（env=0）fail-closed：查单失败/状态不明一律 503 对账中——宁可让用户
    稍后重试，不给「零支付解锁」留门。沙箱（env=1）查单基础设施不可用时信任
    回调：沙箱本就是模拟支付无真实资金，且 env 由服务端配置决定，客户端无法
    自选环境伪造。"""
    try:
        d = wechat.xpay_query_order(openid, order["out_trade_no"], vp["offer_id"],
                                    env_val, app_key, session_key)
    except wechat.XpayError as exc:
        if env_val == 1:
            return
        raise HTTPException(
            503, "支付对账中，请稍后重新点击导出完成解锁") from exc
    status, paid = _order_status_paid(d)
    if paid is True:
        return
    if paid is False:
        raise HTTPException(400, "该订单尚未支付成功，请在支付完成后重试")
    if env_val == 1:
        return
    raise HTTPException(503, "支付对账中，请稍后重新点击导出完成解锁")


def _vpay_env(openid: str, vp: dict) -> tuple:
    """支付环境三验（offer/AppKey/session_key）公共腿；通过返回
    (env, app_key, session_key)。道具级配置由各业务腿先行校验。"""
    if not vp.get("offer_id"):
        raise HTTPException(503, "虚拟支付尚未开通")
    env_val = int(vp.get("env", "0") or 0)
    app_key = (vp.get("prod_appkey") if env_val == 0 else vp.get("sandbox_appkey")) or ""
    if not app_key:
        raise HTTPException(503, "虚拟支付AppKey未配置")
    session_key = store.get_session(openid)
    if not session_key:
        # 401 → 客户端自动静默重登（刷新 session_key）后重试
        raise HTTPException(401, "登录态需要刷新")
    return env_val, app_key, session_key


def _export_pay_env(openid: str, vp: dict) -> tuple:
    """导出腿支付环境（v0.8.0）：道具 export_product_id 先行校验。"""
    if not vp.get("export_product_id"):
        raise HTTPException(503, "导出支付尚未开通")
    return _vpay_env(openid, vp)


class ExportPaidIn(BaseModel):
    out_trade_no: str = ""


@app.post("/api/answer/{aid}/export_sign")
def export_sign(aid: str, request: Request):
    """签名腿（单条导出）：仅本人答案；签名即落单，客户端原样透传拉起支付。
    同一答案重复发起时复用同一未付订单（审计 HIGH-3：根治二次扣款）；
    若该单微信侧已付成功，当场补标记并以 409 收口（已扣款必解锁）。"""
    openid = _openid(request)
    row = store.get_answer(aid, openid)
    if row is None:
        raise HTTPException(404, "答案不存在")
    if row["status"] != "ready":
        raise HTTPException(409, "回答尚未完成，暂不可导出")
    if row.get("export_paid"):
        raise HTTPException(409, "本篇导出已解锁")
    vp = _vp_config()
    env_val, app_key, session_key = _export_pay_env(openid, vp)
    open_o = store.open_pay_order(openid, "single", aid)
    if open_o:
        # 复用未付单：先探微信侧——已付则补标记收口；未付/查不出则同单续付
        if _query_paid(openid, open_o["out_trade_no"], vp, env_val,
                       app_key, session_key) and store.mark_order_paid(
                           open_o["out_trade_no"]):
            store.mark_export_paid(aid, openid, open_o["out_trade_no"])
            raise HTTPException(409, "支付已到账，本篇导出已解锁")
        otn = open_o["out_trade_no"]
    else:
        otn = _make_otn("e", aid)
        store.create_pay_order(otn, openid, "single", aid=aid,
                               buy_quantity=1, total_fen=config.EXPORT_PRICE_FEN)
    sign_data = {
        "offerId": vp["offer_id"],
        "buyQuantity": 1,
        "env": env_val,
        "currencyType": "CNY",
        "productId": vp["export_product_id"],
        "goodsPrice": config.EXPORT_PRICE_FEN,
        "outTradeNo": otn,
        "attach": hashlib.sha256(openid.encode()).hexdigest()[:16],
        "mode": "short_series_goods",
    }
    body, pay_sig, signature = wechat.virtual_pay_sign(
        app_key, session_key, sign_data)
    return {
        "mode": "short_series_goods",
        "sign_data": body,
        "pay_sig": pay_sig,
        "signature": signature,
        "out_trade_no": otn,
        "price_fen": config.EXPORT_PRICE_FEN,
    }


@app.post("/api/answer/{aid}/export_paid")
def export_paid(aid: str, body: ExportPaidIn, request: Request):
    """支付成功回调腿（单条导出）：凭服务端订单 + 微信查单核验（审计
    CRITICAL-2：绝不裸信客户端声称）；核验通过才幂等标记 + pay_log 对账。"""
    openid = _openid(request)
    row = store.get_answer(aid, openid)
    if row is None:
        raise HTTPException(404, "答案不存在")
    if row.get("export_paid"):
        return {"export_paid": True}
    otn = (body.out_trade_no or "").strip()
    order = store.get_pay_order(otn) if otn else None
    if (order is None or order["openid"] != openid
            or order["kind"] != "single" or order["aid"] != aid):
        raise HTTPException(404, "支付订单不存在")
    vp = _vp_config()
    env_val, app_key, session_key = _export_pay_env(openid, vp)
    _verify_order_paid(order, openid, vp, env_val, app_key, session_key)
    store.mark_order_paid(otn)
    if not store.mark_export_paid(aid, openid, otn):
        raise HTTPException(404, "答案不存在")
    return {"export_paid": True}


@app.post("/api/answers/export_all_sign")
def export_all_sign(request: Request):
    """签名腿（批量导出）：buyQuantity=未解锁条数快照，一单付清 N×¥0.1。
    快照落 aid_list（审计 MEDIUM-4：支付存续期新完成的咨询不被顺带解锁）；
    快照未变时复用同一未付订单（HIGH-3 防二次扣款），已付未标记当场补收口。"""
    openid = _openid(request)
    rows = store.history_all(openid)
    if not rows:
        raise HTTPException(404, "还没有完成的咨询记录")
    unpaid = [r for r in rows if not r.get("export_paid")]
    if not unpaid:
        raise HTTPException(409, "全部咨询导出均已解锁")
    if len(unpaid) > config.EXPORT_BATCH_MAX:
        raise HTTPException(400, f"一次最多解锁 {config.EXPORT_BATCH_MAX} 条，请分批处理")
    vp = _vp_config()
    env_val, app_key, session_key = _export_pay_env(openid, vp)
    snapshot = ",".join(r["id"] for r in unpaid)
    open_o = store.open_pay_order(openid, "batch")
    if open_o and (open_o.get("aid_list") or "") == snapshot:
        if _query_paid(openid, open_o["out_trade_no"], vp, env_val,
                       app_key, session_key) and store.mark_order_paid(
                           open_o["out_trade_no"]):
            n = store.mark_export_paid_many(
                openid, open_o["aid_list"].split(","), open_o["out_trade_no"])
            raise HTTPException(409, f"支付已到账，已解锁 {n} 条导出")
        otn = open_o["out_trade_no"]
    else:
        # 批量锚点用 openid 哈希片段（审计 WARN：otn 进用户账单详情，不留明文）
        otn = _make_otn("b", hashlib.sha256(openid.encode()).hexdigest()[:16])
        store.create_pay_order(otn, openid, "batch", aid_list=snapshot,
                               buy_quantity=len(unpaid),
                               total_fen=len(unpaid) * config.EXPORT_PRICE_FEN)
    sign_data = {
        "offerId": vp["offer_id"],
        "buyQuantity": len(unpaid),
        "env": env_val,
        "currencyType": "CNY",
        "productId": vp["export_product_id"],
        "goodsPrice": config.EXPORT_PRICE_FEN,
        "outTradeNo": otn,
        "attach": hashlib.sha256(openid.encode()).hexdigest()[:16],
        "mode": "short_series_goods",
    }
    body, pay_sig, signature = wechat.virtual_pay_sign(
        app_key, session_key, sign_data)
    return {
        "mode": "short_series_goods",
        "sign_data": body,
        "pay_sig": pay_sig,
        "signature": signature,
        "out_trade_no": otn,
        "quantity": len(unpaid),
        "total_fen": len(unpaid) * config.EXPORT_PRICE_FEN,
    }


@app.post("/api/answers/export_all_paid")
def export_all_paid(body: ExportPaidIn, request: Request):
    """支付成功回调腿（批量导出）：凭订单快照 + 微信查单核验；只解锁签名
    时刻的那批（新完成的咨询留给下一单）。"""
    openid = _openid(request)
    otn = (body.out_trade_no or "").strip()
    order = store.get_pay_order(otn) if otn else None
    if order is None or order["openid"] != openid or order["kind"] != "batch":
        raise HTTPException(404, "支付订单不存在")
    aids = [a for a in (order.get("aid_list") or "").split(",") if a]
    if not aids:
        raise HTTPException(404, "支付订单不存在")
    if order["status"] == "paid":
        return {"export_paid": store.mark_export_paid_many(openid, aids, otn)}
    vp = _vp_config()
    env_val, app_key, session_key = _export_pay_env(openid, vp)
    _verify_order_paid(order, openid, vp, env_val, app_key, session_key)
    store.mark_order_paid(otn)
    return {"export_paid": store.mark_export_paid_many(openid, aids, otn)}


# ── v0.9.0 报告商城（用户令 1008：研究报告售卖整合进总包AI顾问，wx5cee）──
# 链路同导出收费腿（签名即落单→客户端拉起→回调凭单+查单核验 fail-closed），
# kind='report'，pay_order.aid 存 sku；道具按价格分档 report_product_<元>。
# 可售判定在 report_catalog（PDF 存在且 ≤20MB；BLUEBOOK-2027 预售无货、
# TOPIC-06 PDF 143MB 生成事故均自动落「整理中」，可看不可买）。
def _openid_soft(req: Request) -> str:
    """软鉴权：目录/详情浏览不强制登录（漏斗前宽后严）；无凭证/过期返回 ''。"""
    try:
        return _openid(req)
    except HTTPException:
        return ""


def _report_product(vp: dict, sku: str) -> tuple:
    """价格分档道具（report_product_<元>）；未配档返回 (None, 0)。"""
    price_fen = report_catalog.price_fen(sku)
    pid = vp.get(f"report_product_{price_fen // 100}") or ""
    return (pid, price_fen) if pid else (None, price_fen)


@app.get("/api/reports")
def reports_list(request: Request):
    """报告目录（公开浏览）：sellable=false 为整理中（可看不可买）。"""
    openid = _openid_soft(request)
    unlocked = store.report_unlocked_skus(openid) if openid else set()
    return {"reports": [
        {**it, "unlocked": it["sku"] in unlocked}
        for it in report_catalog.catalog()
    ]}


@app.get("/api/report/{sku}")
def report_detail(sku: str, request: Request):
    """报告详情：章节目录/适用人群/简介全文 + 本人解锁态。"""
    d = report_catalog.get_report(sku)
    if d is None:
        raise HTTPException(404, "报告不存在")
    openid = _openid_soft(request)
    d["unlocked"] = bool(openid) and sku in store.report_unlocked_skus(openid)
    return d


@app.get("/api/report/{sku}/sample")
def report_sample(sku: str):
    """试读正文（markdown 文本，公开——目录页/详情页试读窗）。"""
    text = report_catalog.sample_text(sku)
    if text is None:
        raise HTTPException(404, "试读整理中")
    return {"sku": sku, "text": text}


class ReportPaidIn(BaseModel):
    out_trade_no: str = ""


@app.post("/api/report/{sku}/unlock_sign")
def report_unlock_sign(sku: str, request: Request):
    """签名腿（报告解锁）：仅可售报告；签名即落单，复用同一未付单（防二次
    扣款）；已付未标记当场查单补收口。道具=价格分档 report_product_<元>。"""
    openid = _openid(request)
    if not report_catalog.sellable(sku):
        raise HTTPException(404, "报告不存在或整理中")
    if sku in store.report_unlocked_skus(openid):
        raise HTTPException(409, "本报告已解锁")
    vp = _vp_config()
    product_id, price_fen = _report_product(vp, sku)
    if not product_id:
        raise HTTPException(503, "报告支付尚未开通")
    env_val, app_key, session_key = _vpay_env(openid, vp)
    open_o = store.open_pay_order(openid, "report", aid=sku)
    if open_o:
        if _query_paid(openid, open_o["out_trade_no"], vp, env_val,
                       app_key, session_key) and store.mark_order_paid(
                           open_o["out_trade_no"]):
            store.mark_report_paid(openid, sku, open_o["out_trade_no"])
            raise HTTPException(409, "支付已到账，本报告已解锁")
        otn = open_o["out_trade_no"]
    else:
        otn = _make_otn("r", sku)
        store.create_pay_order(otn, openid, "report", aid=sku,
                               buy_quantity=1, total_fen=price_fen)
    sign_data = {
        "offerId": vp["offer_id"],
        "buyQuantity": 1,
        "env": env_val,
        "currencyType": "CNY",
        "productId": product_id,
        "goodsPrice": price_fen,
        "outTradeNo": otn,
        "attach": hashlib.sha256(openid.encode()).hexdigest()[:16],
        "mode": "short_series_goods",
    }
    body, pay_sig, signature = wechat.virtual_pay_sign(
        app_key, session_key, sign_data)
    return {
        "mode": "short_series_goods",
        "sign_data": body,
        "pay_sig": pay_sig,
        "signature": signature,
        "out_trade_no": otn,
        "price_fen": price_fen,
    }


@app.post("/api/report/{sku}/unlock_paid")
def report_unlock_paid(sku: str, body: ReportPaidIn, request: Request):
    """回调腿（报告解锁）：凭服务端订单 + 微信查单核验（fail-closed），
    核验通过才幂等标记解锁 + pay_log 对账。"""
    openid = _openid(request)
    if not report_catalog.sellable(sku):
        raise HTTPException(404, "报告不存在或整理中")
    if sku in store.report_unlocked_skus(openid):
        return {"unlocked": True}
    otn = (body.out_trade_no or "").strip()
    order = store.get_pay_order(otn) if otn else None
    if (order is None or order["openid"] != openid
            or order["kind"] != "report" or order["aid"] != sku):
        raise HTTPException(404, "支付订单不存在")
    vp = _vp_config()
    env_val, app_key, session_key = _vpay_env(openid, vp)
    _verify_order_paid(order, openid, vp, env_val, app_key, session_key)
    store.mark_order_paid(otn)
    store.mark_report_paid(openid, sku, otn)
    return {"unlocked": True}


@app.get("/api/report/{sku}/pdf")
def report_pdf(sku: str, request: Request):
    """PDF 全文（已解锁本人；流式 FileResponse，客户端 downloadFile+openDocument）。"""
    openid = _openid(request)
    p = report_catalog.pdf_path(sku)
    if p is None:
        raise HTTPException(404, "报告不存在或整理中")
    if sku not in store.report_unlocked_skus(openid):
        raise HTTPException(402, "购买后可查看完整报告")
    return FileResponse(p, media_type="application/pdf", filename=f"{sku}.pdf")


# ── v0.6.0 100× 弧线（全免费）：追问对话 / 要点速览 / 相关问题 / 分享海报 ──
# 产品语义：总包智库=正式咨询（唯一烧 KB 位）；以下全部以智谱免费链接地，
# 以本篇解答全文为上下文作答——贵的答案只买一次，便宜的解释无限次。
FOLLOWUP_PROMPT = (
    "你是总包AI智库的咨询助手。以下是工程师的原始咨询与智库专业解答全文。"
    "只依据【专业解答】回答用户的追问；先核对解答中的适用前提是否满足，再下结论；"
    "若解答未覆盖该追问，如实说明并建议就这一点发起新的正式咨询。"
    "要求：结论先行，条理清晰，可引用解答原文关键句，300 字以内，纯文本输出。\n\n"
    "【原始问题】{q}\n【专业解答】{a}\n【用户追问】{f}"
)

DIGEST_PROMPT = (
    "你是总包AI智库的编辑。基于下面的咨询问题与专业解答，产出两部分：\n"
    "1. tldr：3 条要点速览，每条不超过 40 字，覆盖解答最核心的结论、依据与操作；\n"
    "2. related：3 个用户可能想接着问的相关问题，每条不超过 30 字，用问句。\n"
    '只输出 JSON，格式 {{"tldr": ["…","…","…"], "related": ["…","…","…"]}}，'
    "不要任何其他文字。\n\n【咨询问题】{q}\n【专业解答】{a}"
)


def _visible_ready(request: Request, aid: str) -> tuple:
    """可见性（本人/锅圈）+ 已完成 校验；返回 (openid, row)。"""
    openid = _openid(request)
    row = store.get_answer_visible(aid, openid)
    if row is None:
        raise HTTPException(404, "答案不存在")
    if row["status"] != "ready" or not row["answer_full"]:
        raise HTTPException(400, "回答尚未完成，稍后再试")
    return openid, row


class FollowupIn(BaseModel):
    question: str


@app.post("/api/answer/{aid}/followup")
def followup(aid: str, body: FollowupIn, request: Request):
    """免费追问（智谱接地，异步流水线）：绝不烧 KB 积分。双日限防刷。"""
    openid, row = _visible_ready(request, aid)
    q = (body.question or "").strip()
    if len(q) < 2 or len(q) > config.FOLLOWUP_MAX_CHARS:
        raise HTTPException(400, f"追问需 2-{config.FOLLOWUP_MAX_CHARS} 字")
    if not zhipu.configured():
        raise HTTPException(503, "追问服务暂不可用，稍后再试")
    fid, reason, _left = store.create_followup(aid, openid, q)
    if fid is None:
        cap = (config.FOLLOWUP_PER_ANSWER_DAILY if reason == "per_answer"
               else config.FOLLOWUP_GLOBAL_DAILY)
        raise HTTPException(429, f"今日追问次数已用完（每答案 {config.FOLLOWUP_PER_ANSWER_DAILY} 次"
                                 f"/每天共 {cap} 次），明天再来")
    threading.Thread(
        target=_run_followup,
        args=(fid, row["question"], row["answer_full"], q), daemon=True).start()
    left_a, left_g = store.followup_left(aid, openid)
    return {"id": fid, "status": "pending", "left_answer": left_a, "left_global": left_g}


def _run_followup(fid: int, q: str, answer_full: str, fq: str) -> None:
    """v0.7.0：瞬断重试一次（免费链冷却切换后常即恢复）+ 友好文案落库。"""
    err: Exception | None = None
    for attempt in range(2):
        try:
            reply = zhipu.rewrite(FOLLOWUP_PROMPT.format(q=q, a=answer_full, f=fq))
            if len(reply) < 5:
                raise RuntimeError("回答内容异常")
            store.finish_followup(fid, reply)
            return
        except Exception as exc:  # noqa: BLE001
            err = exc
            if attempt == 0:
                time.sleep(3)
    store.fail_followup(fid, zhipu.friendly_error(err))


@app.get("/api/answer/{aid}/followups")
def followups(aid: str, request: Request):
    """本人在本答案下的追问对话（时间正序）。"""
    openid = _openid(request)
    row = store.get_answer_visible(aid, openid)
    if row is None:
        raise HTTPException(404, "答案不存在")
    return {"items": store.list_followups(aid, openid)}


# ── v0.7.0 依据来源全文展开（用户令 0930 第 11 条）：点开即读条文/法条完整内容 ──
CITATION_PROMPT = (
    "你是总包智库的资料员。工程师正在阅读一篇工程咨询专业解答，"
    "其中「依据来源」第 {n} 条为：{c}。"
    "请依据【专业解答全文】中与该依据相关的论述，完整展开这条依据的核心内容："
    "它是什么文件/法规、关键条文或要点有哪些、对本文结论起到什么支撑作用。"
    "若全文信息不足以还原该依据的原文条款，请如实说明这一点，"
    "并给出查阅该依据原文的可靠途径（如官方发布渠道）。"
    "600 字以内，纯文本输出，不要使用任何 Markdown 符号。\n\n"
    "【专业解答全文】{a}"
)


@app.get("/api/answer/{aid}/citations/{n}")
def citation_fulltext(aid: str, n: int, request: Request):
    """依据条目全文展开（免费智谱接地，按 aid+n 永久缓存；诚实降级不编造）。"""
    _openid, row = _visible_ready(request, aid)
    cits = row["citations"] or []
    if n < 1 or n > len(cits):
        raise HTTPException(404, "依据不存在")
    cached = store.get_citation_ft(aid, n)
    if cached:
        return {"text": cached, "cached": True}
    c = cits[n - 1]
    src = (c.get("source") or "").strip() or "未具名依据"
    if c.get("loc"):
        src += f"（第 {c.get('loc')} 条/页）"
    if not zhipu.configured():
        raise HTTPException(503, "依据展开服务暂不可用，稍后再试")
    try:
        text = zhipu.rewrite(CITATION_PROMPT.format(n=n, c=src, a=row["answer_full"]))
    except Exception as exc:  # noqa: BLE001
        raise HTTPException(502, zhipu.friendly_error(exc)) from exc
    if len(text) < 10:
        raise HTTPException(502, "依据展开失败，请稍后再试")
    store.save_citation_ft(aid, n, text)
    return {"text": text, "cached": False}


def _digest_json(raw: str) -> tuple:
    """智谱 digest 输出 → ([tldr ≤3], [related ≤3])；非法结构抛 ValueError。"""
    t = (raw or "").strip()
    if t.startswith("```"):
        t = t.strip("`").lstrip(" \n").rstrip(" \n")
        if t.lower().startswith("json"):
            t = t[4:].lstrip(" \n")
    s, e = t.find("{"), t.rfind("}")
    if s < 0 or e <= s:
        raise ValueError("digest 输出非 JSON")
    d = json.loads(t[s:e + 1])
    tldr = [str(x).strip()[:60] for x in d.get("tldr", []) if str(x).strip()][:3]
    related = [str(x).strip()[:40] for x in d.get("related", []) if str(x).strip()][:3]
    if not tldr:
        raise ValueError("tldr 为空")
    return tldr, related


@app.get("/api/answer/{aid}/digest")
def digest(aid: str, request: Request):
    """要点速览 + 相关问题（免费智谱，每答案生成一次永久缓存；失败可重试）。"""
    _, row = _visible_ready(request, aid)
    tldr, related = store.get_digest(aid)
    if tldr or related:
        return {"tldr": tldr, "related": related, "cached": True}
    if not zhipu.configured():
        raise HTTPException(503, "要点生成服务暂不可用，稍后再试")
    try:
        raw = zhipu.rewrite(DIGEST_PROMPT.format(q=row["question"], a=row["answer_full"]))
        tldr, related = _digest_json(raw)
    except Exception as exc:  # noqa: BLE001
        raise HTTPException(502, f"要点生成失败，稍后再试（{exc}）") from exc
    store.save_digest(aid, tldr, related)
    return {"tldr": tldr, "related": related, "cached": False}


@app.get("/api/answer/{aid}/poster")
def share_poster(aid: str, request: Request):
    """分享海报（免费 Pillow）：问题+要点+品牌+小程序码；每答案×每 env 版本一次缓存
    （v0.7.0：提审切 release 后旧 trial 码海报自动失效重生成）。
    要点优先取缓存 digest，未缓存则现场生成；再失败用预览兜底——海报零失败姿态。"""
    _, row = _visible_ready(request, aid)
    store.bump_shares(aid)   # v0.7.3：海报传播=转发行为，转发数 +1
    # v0.9.8：版式版本进缓存键——重设计上线后旧缓存自动失效重生成
    env_v = f"{config.POSTER_QR_ENV_VERSION}:{poster.LAYOUT_VERSION}"
    cached = store.get_poster(aid, env_v)
    if cached:
        return {"b64": base64.b64encode(cached).decode()}
    bullets = []
    try:
        tldr, _related = store.get_digest(aid)
        if not tldr:
            raw = zhipu.rewrite(DIGEST_PROMPT.format(q=row["question"], a=row["answer_full"]))
            tldr, related = _digest_json(raw)
            store.save_digest(aid, tldr, related)
        bullets = tldr
    except Exception as exc:  # noqa: BLE001 — 要点缺席不废海报
        _log.warning("poster digest 兜底（用预览）: %s", exc)
    if not bullets:
        bullets = [store.strip_md((row["answer_full"] or ""))[:60].strip()
                   or "专业解答已就绪"]
    qr = None
    try:
        qr = wechat.wxacode_unlimited(f"s=p&a={aid}", "pages/ask/ask")
    except Exception as exc:  # noqa: BLE001 — 无码兜底版（搜一搜引导）
        _log.warning("poster 小程序码失败（无码兜底）: %s", exc)
    try:
        # v0.9.8（用户令 1009）：海报新增约 200 字解答摘录区——取完整解答开头
        # 连续段落（脱 Markdown），build 内按行优雅截断（末行省略号收口）
        png = poster.build(
            row["question"], bullets, qr,
            meta={"chars": len(row["answer_full"] or ""),
                  "cites": len(row["citations"] or [])},
            answer=store.strip_md(row["answer_full"] or "")[:240])
    except poster.LayoutError as exc:
        raise HTTPException(503, f"海报服务暂不可用: {exc}") from exc
    except Exception as exc:  # noqa: BLE001
        raise HTTPException(500, f"海报生成失败: {exc}") from exc
    store.save_poster(aid, png, env_v)
    return {"b64": base64.b64encode(png).decode()}


# ══ v0.9.4 发票（1009 用户令：累计消费满 ¥200 可申请增值税专用发票；申请即企业微信推送运营）══
class InvoiceApplyIn(BaseModel):
    title: str
    tax_no: str
    email: str
    addr_phone: str = ""
    bank_acct: str = ""
    note: str = ""


def _invoice_wecom_push(app_row: dict) -> None:
    """申请单企业微信推送（fail-open 旁路：推失败只记日志，绝不影响申请落库/返回）。"""
    import urllib.request
    try:
        hook = config.INVOICE_WECOM_WEBHOOK
        if not hook and config.INVOICE_WECOM_WEBHOOK_FILE.exists():
            hook = config.INVOICE_WECOM_WEBHOOK_FILE.read_text(encoding="utf-8").strip()
        if not hook:
            _log.warning("invoice wecom push skipped: no webhook configured")
            return
        content = ("**【发票申请】总包AI顾问**\n"
                   "> 类型：增值税专用发票\n"
                   f"> 累计消费：¥{app_row['total_fen'] / 100:.2f}\n"
                   f"> 抬头：{app_row['title']}\n"
                   f"> 税号：{app_row['tax_no']}\n"
                   f"> 地址电话：{app_row.get('addr_phone') or '—'}\n"
                   f"> 开户行账号：{app_row.get('bank_acct') or '—'}\n"
                   f"> 收票邮箱：{app_row['email']}\n"
                   f"> 备注：{app_row.get('note') or '—'}\n"
                   f"> 时间：{app_row.get('created_at') or ''}")
        payload = json.dumps({"msgtype": "markdown", "markdown": {"content": content}},
                             ensure_ascii=True).encode("ascii")
        req = urllib.request.Request(hook, data=payload,
                                     headers={"Content-Type": "application/json"})
        with urllib.request.urlopen(req, timeout=10) as resp:
            _log.info("invoice wecom push: %s", resp.read()[:120])
    except Exception as exc:  # noqa: BLE001 —— 推送是旁路，任何失败不阻断申请
        _log.warning("invoice wecom push failed: %s", exc)


@app.get("/api/invoice/status")
def invoice_status(request: Request):
    """发票状态：累计已付金额 + 门槛 + 本人申请记录（未登录只看门槛口径）。"""
    openid = _openid_soft(request)
    total = store.paid_total_fen(openid) if openid else 0
    apps = store.invoice_apps(openid) if openid else []
    return {
        "total_fen": total,
        "threshold_fen": config.INVOICE_THRESHOLD_FEN,
        "can_apply": total >= config.INVOICE_THRESHOLD_FEN
                     and not any(a["status"] == "pending" for a in apps),
        "applications": apps,
    }


@app.post("/api/invoice/apply")
def invoice_apply(body: InvoiceApplyIn, request: Request):
    """提交开票申请（增值税专用发票）：门槛 ¥200；待处理期间不重复提交；
    落库后企业微信推送运营（fail-open）。"""
    openid = _openid(request)   # 开票必须登录（openid 记账归属）
    title = body.title.strip()
    tax_no = body.tax_no.strip().upper()
    email = body.email.strip()
    addr_phone = body.addr_phone.strip()
    bank_acct = body.bank_acct.strip()
    note = body.note.strip()[:200]
    if not (2 <= len(title) <= 64):
        raise HTTPException(422, "发票抬头须为 2-64 字")
    if not re.fullmatch(r"[0-9A-Z]{15,20}", tax_no):
        raise HTTPException(422, "纳税人识别号须为 15-20 位数字/大写字母")
    if not re.fullmatch(r"[^@\s]+@[^@\s]+\.[^@\s]+", email):
        raise HTTPException(422, "收票邮箱格式不正确")
    total = store.paid_total_fen(openid)
    if total < config.INVOICE_THRESHOLD_FEN:
        raise HTTPException(
            403, f"累计消费满 ¥{config.INVOICE_THRESHOLD_FEN // 100} 元可申请发票"
                 f"（当前 ¥{total / 100:.2f}）")
    if any(a["status"] == "pending" for a in store.invoice_apps(openid)):
        raise HTTPException(409, "已有一笔发票申请在处理中，开票完成后可再次申请")
    if not store.create_invoice_app(openid, total, title, tax_no,
                                    addr_phone, bank_acct, email, note):
        raise HTTPException(500, "申请落库失败，请稍后重试")
    try:
        _invoice_wecom_push({
            "total_fen": total, "title": title, "tax_no": tax_no,
            "addr_phone": addr_phone, "bank_acct": bank_acct, "email": email,
            "note": note, "created_at": time.strftime("%Y-%m-%d %H:%M:%S"),
        })
    except Exception:  # noqa: BLE001 —— 双保险：推送旁路崩溃绝无可能伤申请主流程
        _log.warning("invoice wecom push crashed at call site", exc_info=True)
    apps = store.invoice_apps(openid)
    return {"ok": True, "application": apps[0] if apps else None}


@app.get("/api/health")
def health():
    return {"ok": True}


# ── v0.9.6 真机遥测（1009 真机根因战）：匿名执行轨迹上行/读数 ──────────────────
# 背景：wx.showModal confirmText >4 字符在真机静默 fail（devtools 宽松+e2e mock=双盲区），
# 三条主链（隐私门/导出/批量导出）死得无声无息。此端点=客户端 fire-and-forget 打点的
# 地面真值腿：事件是否真的在真机上发生，与弹窗/控制台完全解耦。
class TelemetryIn(BaseModel):
    event: str
    boot: str = ""
    ver: str = ""
    extra: Optional[dict] = None


_TEL_EVENT_RE = re.compile(r"[a-z0-9_]{1,40}")


@app.post("/api/telemetry")
def telemetry_post(body: TelemetryIn):
    """匿名打点（公开端点）：只收白名单形态事件名 + 截断字段，不收任何用户内容。"""
    event = (body.event or "").strip().lower()
    if not _TEL_EVENT_RE.fullmatch(event):
        raise HTTPException(422, "bad event")
    boot = (body.boot or "").strip()[:24]
    ver = (body.ver or "").strip()[:16]
    try:
        extra = json.dumps(body.extra or {}, ensure_ascii=False,
                           separators=(",", ":"))[:255]
    except Exception:  # noqa: BLE001 —— extra 序列化失败=丢 extra 不丢事件
        extra = ""
    store.save_telemetry(event, boot, ver, extra)
    return {"ok": True}


@app.get("/api/telemetry/recent")
def telemetry_recent(request: Request, limit: int = 200):
    """运营读数腿：X-Tel-Key == telemetry.secret 才放行（密钥文件缺失=503 不放行）。"""
    want = ""
    try:
        if config.TELEMETRY_SECRET_FILE.exists():
            want = config.TELEMETRY_SECRET_FILE.read_text(encoding="utf-8").strip()
    except Exception:  # noqa: BLE001
        want = ""
    if not want:
        raise HTTPException(503, "telemetry read not configured")
    got = request.headers.get("x-tel-key") or ""
    if not secrets.compare_digest(got, want):
        raise HTTPException(401, "bad tel key")
    limit = max(1, min(int(limit), 1000))
    return {"events": store.recent_telemetry(limit)}
