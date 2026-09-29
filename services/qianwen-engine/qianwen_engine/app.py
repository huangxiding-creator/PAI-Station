# -*- coding: utf-8 -*-
"""总包千问引擎 API（FastAPI）。

P0 端点：
  POST /api/login          {code} → {token, quota}
  POST /api/ask            {question} → {id, status, quota}（异步流水线）
  GET  /api/answer/{id}    → 答案详情（未解锁只给 preview；锅圈答案全员可见）
  POST /api/answer/{id}/like        → 有用 +1 次（每答案一次）
  POST /api/answer/{id}/criticize   {text} → 存证 + 具体纠错意见赠 1 次
  POST /api/answer/{id}/share       → 分享赠 1 次（每答案一次）
  POST /api/answer/{id}/export      → 导出文件（base64）+ 导出赠 1 次
  POST /api/question/optimize       → AI 优化提问（递进式三小问，10 次/天）
  POST /api/answers/export_all      → 全部咨询记录批量导出（docx/pdf/md）
  GET  /api/pot/list                → 锅圈热点问题列表（100 字预览）
  GET  /api/history        → 我的提问
  GET  /api/engine/status  → 引擎护栏状态
"""
from __future__ import annotations

import hashlib
import json
import os
import re
import threading
import time

from fastapi import FastAPI, HTTPException, Request
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel

from . import config, exporter, metaso_kb, store, wechat, zhipu

app = FastAPI(title="qianwen-engine", version="0.4.0")
app.add_middleware(
    CORSMiddleware, allow_origins=["*"], allow_methods=["*"], allow_headers=["*"]
)

# 串行闸：KB 引擎一次一问（网页会话共享 + 节流铁律）
_ask_lock = threading.Semaphore(1)

# v0.2.2 透明化：每问的阶段事件流（内存态，随进程；落库为终态 status）
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
    # v0.2.5：session_key 服务端留存（虚拟支付用户态签名腿用，绝不下发）
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
            402, "今日免费次数已用完；点「有用/导出/分享/纠错」可再获次数，或1元解锁本问",
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


def _run_answer(aid: str, openid: str, q: str) -> None:
    """后台跑工程大脑：一次一问（串行闸），全程事件外送，失败自动退次。"""
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
                        _ev(aid, "问题已送达工程大脑")
                    elif kind == "session_refreshing":
                        _ev(aid, "会话续期中…")
                    elif kind == "polling":
                        _ev(aid, "知识库检索中… 第{}轮 · 已生成 {} 字".format(
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
    d = {"id": aid, "question": row["question"], "status": status,
         "error_text": row["error_text"] if "error_text" in row.keys() else "",
         "unlocked": bool(row["unlocked"]),
         "preview": row["answer_full"][: config.PREVIEW_CHARS],
         "answer": row["answer_full"] if row["unlocked"] else "",
         "citations": row["citations"],
         "full_chars": len(row["answer_full"]),
         "liked": liked, "criticized": bool(row["criticized"]) if not is_pot else False,
         "is_pot": is_pot}
    if status == "pending":
        with _PROG_LOCK:
            prog = _PROGRESS.get(aid)
            if prog:
                d["progress"] = list(prog["events"])
                d["elapsed"] = round(time.time() - prog["t0"], 1)
            else:
                d["progress"], d["elapsed"] = [], 0
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
    """分享赠次（客户端 share 按钮 bindtap 调用；每答案一次）。"""
    openid = _openid(request)
    row = store.get_answer_visible(aid, openid)
    if row is None:
        raise HTTPException(404, "答案不存在")
    granted = store.grant_reward(openid, aid, "share")
    return {"granted": granted, "quota": store.quota_left(openid)}


class ExportIn(BaseModel):
    fmt: str  # docx | pdf（md 由小程序本地生成，不走引擎）


@app.post("/api/answer/{aid}/export")
def export_answer(aid: str, body: ExportIn, request: Request):
    """v0.4.0 导出：Word/PDF 文件（base64 回传）。仅解锁全文可导出；导出成功赠 1 次（每答案一次）。"""
    openid = _openid(request)
    row = store.get_answer_visible(aid, openid)
    if row is None:
        raise HTTPException(404, "答案不存在")
    if row["status"] != "ready":
        raise HTTPException(400, "回答尚未完成，稍后再试")
    if not row["unlocked"]:
        raise HTTPException(403, "解锁全文后可导出")
    try:
        out = exporter.build((body.fmt or "").strip().lower(), row)
    except exporter.FontMissing as exc:
        raise HTTPException(503, str(exc)) from exc
    except exporter.FormatNotSupported as exc:
        raise HTTPException(400, str(exc)) from exc
    except Exception as exc:  # noqa: BLE001
        raise HTTPException(500, f"导出失败: {exc}") from exc
    store.grant_reward(openid, aid, "export")
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
    无 key/全链失败回落工程大脑 KB 免费池（串行闸）。每用户每天 10 次。"""
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
            raise HTTPException(503, "工程大脑正忙，请稍后再试")
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
    """签名腿：服务端用 appsecret+session_key 出双签名，客户端原样透传拉起支付。"""
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
        wechat.mp_secret(), session_key, sign_data)
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


@app.get("/api/health")
def health():
    return {"ok": True}
