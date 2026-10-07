# -*- coding: utf-8 -*-
"""总包千问引擎 API（FastAPI）。

P0 端点：
  POST /api/login          {code} → {token, quota}
  POST /api/ask            {question} → {id, status, quota}（异步流水线）
  GET  /api/answer/{id}    → 答案详情（未解锁只给 preview；锅圈答案全员可见）
  POST /api/answer/{id}/like        → 有用 +1 次（每答案一次）
  POST /api/answer/{id}/criticize   {text} → 存证 + 具体纠错意见赠 1 次
  POST /api/answer/{id}/share       → 分享赠 1 次（每答案一次）
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
import threading
import time

from fastapi import FastAPI, HTTPException, Request
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel

from . import config, exporter, metaso_kb, poster, store, wechat, zhipu

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
    # v0.7.4 合规卫生：session_key 不再落盘（虚拟支付已于 v0.7.0 拆除，全链路无解密场景）
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
            402, "今日免费次数已用完；点「有用/导出/分享/纠错」或把自己的问答「共享」进锅圈可再获次数",
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


@app.post("/api/answer/{aid}/share")
def share(aid: str, request: Request):
    """分享赠次（客户端 share 按钮 bindtap 调用；每答案一次）。
    v0.7.3（用户令）：转发计数与赠次解耦——每次分享动作 shares+1（持续累计）。"""
    openid = _openid(request)
    row = store.get_answer_visible(aid, openid)
    if row is None:
        raise HTTPException(404, "答案不存在")
    granted = store.grant_reward(openid, aid, "share")
    return {"granted": granted, "shares": store.bump_shares(aid),
            "quota": store.quota_left(openid)}


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
    v0.7.3（用户令）：导出不再赠次——赠次动作=like/criticize/share 三件。"""
    openid = _openid(request)
    row = store.get_answer_visible(aid, openid)
    if row is None:
        raise HTTPException(404, "答案不存在")
    if row["status"] != "ready":
        raise HTTPException(400, "回答尚未完成，稍后再试")
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
    """v0.5.0 批量导出：用户全部已完成问答（docx/pdf/md）。不参与赠次（防刷）。"""
    openid = _openid(request)
    rows = store.history_all(openid)
    if not rows:
        raise HTTPException(404, "还没有完成的咨询记录")
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


# ── v0.5.0 锅圈：打破砂锅问到底（公共热点问题展区） ──
@app.get("/api/pot/list")
def pot_list(request: Request):
    _openid(request)
    return {"items": store.pot_list()}


@app.get("/api/history")
def my_history(request: Request):
    openid = _openid(request)
    return {"items": store.history(openid), "quota": store.quota_left(openid)}


@app.get("/api/quota")
def my_quota(request: Request):
    openid = _openid(request)
    return {"quota": store.quota_left(openid)}


@app.get("/api/engine/status")
def engine_status():
    return metaso_kb.engine_status()


# ── v0.2.5 虚拟支付：¥1 解锁全文（道具直购 short_series_goods） ──
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


class UnlockPaidIn(BaseModel):
    out_trade_no: str = ""


@app.post("/api/answer/{aid}/pay_sign")
def pay_sign(aid: str, request: Request):
    """签名腿：服务端用虚拟支付 AppKey(env 定沙箱/现网)+session_key 出双签名，客户端原样透传拉起支付。"""
    openid = _openid(request)
    row = store.get_answer(aid, openid)
    if row is None:
        raise HTTPException(404, "答案不存在")
    if row["status"] != "ready":
        raise HTTPException(409, "回答尚未完成，暂不可解锁")
    if row["unlocked"]:
        raise HTTPException(409, "本篇已解锁")
    vp = _vp_config()
    if not vp.get("offer_id") or not vp.get("product_id"):
        # 未开通：客户端走优雅降级（引导点赞赠次）
        raise HTTPException(503, "虚拟支付尚未开通")
    env_val = int(vp.get("env", "0") or 0)
    app_key = (vp.get("prod_appkey") if env_val == 0 else vp.get("sandbox_appkey")) or ""
    if not app_key:
        raise HTTPException(503, "虚拟支付AppKey未配置")
    session_key = store.get_session(openid)
    if not session_key:
        # 401 → 客户端自动静默重登（刷新 session_key）后重试
        raise HTTPException(401, "登录态需要刷新")
    # outTradeNo 合法字符 [0-9A-Za-z_-|*@]，8-32 位，不能以下划线开头
    otn = re.sub(r"[^0-9A-Za-z_\-|*@]", "x", aid)[:32]
    if otn.startswith("_"):
        otn = "q" + otn[1:]
    sign_data = {
        "offerId": vp["offer_id"],
        "buyQuantity": 1,
        "env": int(vp.get("env", "0") or 0),
        "currencyType": "CNY",
        "productId": vp["product_id"],
        "goodsPrice": config.UNLOCK_PRICE_FEN,
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
        "price_fen": config.UNLOCK_PRICE_FEN,
    }


@app.post("/api/answer/{aid}/unlock_paid")
def unlock_paid(aid: str, body: UnlockPaidIn, request: Request):
    """支付成功回调腿：幂等解锁 + pay_log 对账（微信服务端推送对账=P1）。"""
    openid = _openid(request)
    if not store.mark_paid(aid, openid, body.out_trade_no):
        raise HTTPException(404, "答案不存在")
    return {"unlocked": True, "quota": store.quota_left(openid)}


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
    env_v = config.POSTER_QR_ENV_VERSION
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
        png = poster.build(
            row["question"], bullets, qr,
            meta={"chars": len(row["answer_full"] or ""),
                  "cites": len(row["citations"] or [])})
    except poster.LayoutError as exc:
        raise HTTPException(503, f"海报服务暂不可用: {exc}") from exc
    except Exception as exc:  # noqa: BLE001
        raise HTTPException(500, f"海报生成失败: {exc}") from exc
    store.save_poster(aid, png, env_v)
    return {"b64": base64.b64encode(png).decode()}


@app.get("/api/health")
def health():
    return {"ok": True}
