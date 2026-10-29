# -*- coding: utf-8 -*-
"""voice_feedback — 反馈→评分→退款队列→改版飞轮 API (1017 用户令: 全自动闭环 v2).

v2 (1017 重制, 修线上断点; 17:2x 曾被并行部署回滚至原版致 500, 本件为最终恢复版):
  ① store.get_report_meta 不存在 → AttributeError 500 → 改 report_catalog.get_report
  ② httpx 不在容器依赖 → 评分腿死 → 改 zhipu.py 免费链 (deep_answer)
  ③ 反馈落容器 fs 重部署即丢 → 落 MySQL report_feedback 表 (store._db 双方言)
  ④ 企微 webhook 读 F:/We-AIPO/.env (容器无此盘) → 改 SECRETS_DIR/invoice_wecom_webhook.txt
管理面 (X-Admin-Key = qianwen_engine_hmac.key 的 hex; 该 key 是 32 字节裸二进制):
  GET  /api/feedback/pending?since=<epoch>   待处理反馈
  GET  /api/feedback/all?limit=500           全量反馈 (周报聚合)
  GET  /api/quality/orders                   解锁/复购聚合 (周报)
  POST /api/feedback/ack {"fids":[],"status":"addressed|ignored"}
便捷令: chips 一键标签 — 只点标签也可提交, 服务端组规范句过评分。
退款: 评分即入队落库; 真实打款腿待 xpay 契约核验后放行, 本版只算不打款。
端点同步 def (FastAPI 线程池跑 zhipu 阻塞调用; 引擎单 worker)。MySQL 方言纪律:
TEXT 列禁 DEFAULT / 无隐式 rowid / LIMIT ? 参数化。
"""
from __future__ import annotations

import json
import re
import threading
import time
from pathlib import Path
from typing import Optional

from fastapi import APIRouter, Request
from pydantic import BaseModel

from . import config, report_catalog, store, zhipu

router = APIRouter()

FEEDBACK_DIR = Path(config.DATA_DIR) / "feedback"

SCORE_SYSTEM = "你是研究报告质量评审专家，只输出严格JSON，不输出任何其他文本。"
SCORE_PROMPT = """请对以下研究报告买家反馈进行六维评分。

评分维度（各维度满分不同，总分100）：
1. 真实性（15分）：反馈是否基于实际阅读，是否引用了具体页码/章节/数据
2. 针对性（15分）：是否指出了具体章节/段落的问题，位置是否精确
3. 专业性（15分）：是否使用了行业术语/法律条文/技术标准
4. 证据支持（15分）：是否引用了外部数据/法规/判例来支持观点
5. 可操作性（20分）：是否提出了具体可执行的改进建议
6. 改进价值（20分）：反馈被采纳后对报告质量的提升程度

退款比例单独判断，衡量的是「报告自身缺陷的严重程度与可归责性」，与反馈的文采、
总分（total_score）无必然关系：反馈写得再专业，若报告本身无误，退款=0；
只有反馈坐实的报告错误/重大遗漏才产生退款（轻微瑕疵低比例，硬伤高比例）；
闲聊/与报告无关/纯情绪 → 0。

报告标题：{report_title}
买家反馈：{transcript}

请输出严格JSON（无其他文本）：
{{"authenticity": 0-15, "specificity": 0-15, "professionalism": 0-15,
"evidence_support": 0-15, "actionability": 0-20, "improvement_value": 0-20,
"total_score": 0-100, "refund_percentage": 0-100,
"scoring_rationale": "每维度一句话理由",
"improvement_suggestion": "基于反馈的具体改进建议",
"feedback_category": "data_error|content_gap|depth_insufficient|actionability|dissatisfaction"}}"""


class VoiceFeedbackRequest(BaseModel):
    transcript: str = ""
    openid: str = ""
    order_id: Optional[str] = None
    channel: str = "voice"      # voice | text | chips
    chips: list[str] = []       # 一键快捷反馈标签 (便捷令1017)


class EmailRequest(BaseModel):
    email: str = ""
    feedback_id: str = ""
    openid: str = ""


class AckRequest(BaseModel):
    fids: list[str] = []
    status: str = "addressed"   # addressed | ignored


# ── 表初始化（sqlite 语句, store._sql 自动转 mysql 方言；TEXT 禁 DEFAULT）──
_INIT_SQL = ("""CREATE TABLE IF NOT EXISTS report_feedback (
        fid VARCHAR(64) PRIMARY KEY,
        sku VARCHAR(64) NOT NULL,
        openid VARCHAR(64) DEFAULT '',
        transcript MEDIUMTEXT,
        scores_json TEXT,
        refund_pct INT DEFAULT 0,
        refund_amount INT DEFAULT 0,
        order_id VARCHAR(128) DEFAULT '',
        email VARCHAR(255) DEFAULT '',
        status VARCHAR(16) DEFAULT 'pending',
        channel VARCHAR(8) DEFAULT 'voice',
        created_at TEXT DEFAULT (datetime('now','localtime')))""",)
_init_lock = threading.Lock()
_init_done = False


def _init_table() -> None:
    global _init_done
    with _init_lock:
        if _init_done:
            return
        store.init()
        with store._db() as c:
            for sql in _INIT_SQL:
                c.execute(sql)
        _init_done = True


def _admin_ok(req: Request) -> bool:
    key = (req.headers.get("x-admin-key") or "").strip().lower()
    if not key:
        return False
    kf = Path(config.SECRETS_DIR) / "qianwen_engine_hmac.key"
    if not kf.exists():
        return False
    raw = kf.read_bytes()
    # 密钥文件形态二选一: 32字节裸key(比hex) / 文本key(原样比)
    return key == raw.hex() or key == raw.decode("utf-8", "ignore").strip().lower()


def _score_with_llm(title: str, transcript: str) -> Optional[dict]:
    """智谱免费链六维评分 (同步阻塞, 端点为 def → 线程池)."""
    try:
        content = zhipu.deep_answer(
            SCORE_SYSTEM,
            SCORE_PROMPT.format(report_title=title, transcript=transcript),
            temperature=0.1)
        m = re.search(r"\{.*\}", content, re.DOTALL)
        if not m:
            return None
        d = json.loads(m.group())
        if not all(k in d for k in ("total_score", "refund_percentage")):
            return None
        return d
    except Exception:
        return None


def _save_feedback(sku: str, openid: str, transcript: str, scores: dict,
                   refund_amount: int, order_id: str, channel: str) -> str:
    fid = f"fb_{int(time.time())}_{sku[:8]}"
    _init_table()
    with store._db() as c:
        c.execute(
            "INSERT INTO report_feedback(fid, sku, openid, transcript,"
            " scores_json, refund_pct, refund_amount, order_id, status, channel)"
            " VALUES(?,?,?,?,?,?,?,?,?,?)",
            (fid, sku, openid[:16] + "…", transcript[:2000],
             json.dumps(scores, ensure_ascii=False),
             int(scores.get("refund_percentage", 0) or 0),
             refund_amount, order_id or "", "pending", channel))
    try:  # 容器 fs 副本（兼容旧读取方；真源=MySQL）
        FEEDBACK_DIR.mkdir(parents=True, exist_ok=True)
        rec = {"id": fid, "ts": time.strftime("%Y-%m-%dT%H:%M:%S"), "sku": sku,
               "openid": openid[:16] + "…", "transcript": transcript[:2000],
               "scores": scores, "refund_amount": refund_amount, "channel": channel}
        (FEEDBACK_DIR / f"{sku}_{int(time.time())}.json").write_text(
            json.dumps(rec, ensure_ascii=False, indent=1), encoding="utf-8")
    except Exception:
        pass
    return fid


def _notify_production_line(sku: str, scores: dict, refund: int, fid: str) -> None:
    try:
        import urllib.request
        wf = Path(config.SECRETS_DIR) / "invoice_wecom_webhook.txt"
        if not wf.exists():
            return
        webhook = wf.read_text(encoding="utf-8").strip()
        if not webhook.startswith("http"):
            return
        total = scores.get("total_score", 0)
        cat = scores.get("feedback_category", "?")
        rationale = str(scores.get("scoring_rationale", ""))[:200]
        msg = (f"📝 新买家反馈: {sku} ({fid})\n"
               f"评分: {total}/100 | 退款入队: ¥{refund}\n"
               f"类型: {cat}\n理由: {rationale}")
        data = json.dumps({"msgtype": "markdown",
                           "markdown": {"content": msg}}).encode()
        req = urllib.request.Request(webhook, data=data,
                                     headers={"Content-Type": "application/json"})
        urllib.request.urlopen(req, timeout=10)
    except Exception:
        pass


# ── 买家面（小程序契约）────────────────────────────────────────────
@router.post("/api/report/{sku}/voice_feedback")
def submit_voice_feedback(sku: str, body: VoiceFeedbackRequest):
    transcript = (body.transcript or "").strip()
    chips = [str(c).strip() for c in (body.chips or []) if str(c).strip()][:5]
    if len(transcript) < 20 and chips:
        # 便捷令: 只有标签也成反馈 — 服务端组规范句过评分
        transcript = "读者快捷反馈，问题类别：" + "；".join(chips) + \
            ("。补充说明：" + transcript if transcript else "。未留补充说明。")
        if body.channel in ("voice", "text"):
            body.channel = "chips"
    if len(transcript) < 20:
        return {"ok": False, "error": "反馈内容过短（至少20字，或点选一个问题标签）"}

    report = report_catalog.get_report(sku)
    title = report.get("title", sku) if report else sku

    scores = _score_with_llm(title, transcript)
    if not scores:
        return {"ok": False, "error": "评分服务暂时不可用，请稍后重试"}

    refund_pct = int(scores.get("refund_percentage", 0) or 0)
    price = int((report or {}).get("price") or 698)
    refund_amount = int(price * refund_pct / 100)

    fid = _save_feedback(sku, body.openid or "", transcript, scores,
                         refund_amount, body.order_id or "",
                         (body.channel or "voice"))
    _notify_production_line(sku, scores, refund_amount, fid)

    return {
        "ok": True,
        "feedback_id": fid,
        "scores": scores,
        "refund_percentage": refund_pct,
        "refund_amount": refund_amount,
        "message": f"反馈评分 {scores.get('total_score', 0)} 分，"
                   f"退款比例 {refund_pct}%（¥{refund_amount}，1-3个工作日原路退回）",
        "category": scores.get("feedback_category", "unknown"),
        "improvement_suggestion": scores.get("improvement_suggestion", ""),
    }


@router.post("/api/report/{sku}/feedback_email")
def submit_feedback_email(sku: str, body: EmailRequest):
    email = (body.email or "").strip()
    if "@" not in email or "." not in email.split("@")[1]:
        return {"ok": False, "error": "邮箱格式不正确"}

    _init_table()
    if body.feedback_id:
        with store._db() as c:
            c.execute("UPDATE report_feedback SET email=? WHERE fid=?",
                      (email, body.feedback_id))
    try:  # fs 副本（feedback_new_version_push.py 兼容读法）
        FEEDBACK_DIR.mkdir(parents=True, exist_ok=True)
        entry = {"ts": time.strftime("%Y-%m-%dT%H:%M:%S"), "sku": sku,
                 "openid": (body.openid or "")[:16] + "…", "email": email,
                 "feedback_id": body.feedback_id}
        with (FEEDBACK_DIR / "emails.jsonl").open("a", encoding="utf-8") as f:
            f.write(json.dumps(entry, ensure_ascii=False) + "\n")
    except Exception:
        pass
    return {"ok": True,
            "message": "邮箱已登记，报告根据您的反馈优化后将免费发送新版到该邮箱"}


# ── 管理面（X-Admin-Key 守门）──────────────────────────────────────
@router.get("/api/feedback/pending")
def feedback_pending(req: Request, since: int = 0):
    if not _admin_ok(req):
        return {"ok": False, "error": "admin key required"}
    _init_table()
    out = []
    with store._db() as c:
        rows = c.execute(
            "SELECT * FROM report_feedback WHERE status='pending'"
            " ORDER BY created_at, fid").fetchall()
        for r in rows:
            out.append(dict(r) if not hasattr(r, "keys")
                       else {k: r[k] for k in r.keys()})
    return {"ok": True, "count": len(out), "items": out}


@router.get("/api/feedback/all")
def feedback_all(req: Request, limit: int = 500):
    """管理面: 全量反馈(含已处理), 周报聚合用."""
    if not _admin_ok(req):
        return {"ok": False, "error": "admin key required"}
    limit = max(1, min(int(limit), 2000))
    _init_table()
    out = []
    with store._db() as c:
        rows = c.execute(
            "SELECT * FROM report_feedback ORDER BY created_at DESC, fid LIMIT ?",
            (limit,)).fetchall()
        for r in rows:
            out.append(dict(r) if not hasattr(r, "keys")
                       else {k: r[k] for k in r.keys()})
    return {"ok": True, "count": len(out), "items": out}


@router.get("/api/quality/orders")
def quality_orders(req: Request):
    """管理面: 质量证据周报的数据聚合腿 (解锁/复购, 只出聚合计数)."""
    if not _admin_ok(req):
        return {"ok": False, "error": "admin key required"}
    store.init()
    agg: dict = {}
    with store._db() as c:
        try:
            rows = c.execute(
                "SELECT sku, COUNT(*) n, COUNT(DISTINCT openid) u"
                " FROM report_unlocks GROUP BY sku").fetchall()
            agg["unlocks"] = [dict(r) if isinstance(r, dict)
                              else {k: r[k] for k in r.keys()} for r in rows]
        except Exception:
            agg["unlocks"] = []
        try:  # 复购: 同一 openid 解锁 >1 个 sku
            rows = c.execute(
                "SELECT openid, COUNT(DISTINCT sku) k FROM report_unlocks"
                " GROUP BY openid HAVING k > 1").fetchall()
            agg["multi_sku_buyers"] = len(rows)
        except Exception:
            agg["multi_sku_buyers"] = 0
    return {"ok": True, **agg}


@router.post("/api/feedback/ack")
def feedback_ack(req: Request, body: AckRequest):
    if not _admin_ok(req):
        return {"ok": False, "error": "admin key required"}
    if body.status not in ("addressed", "ignored"):
        return {"ok": False, "error": "bad status"}
    _init_table()
    n = 0
    with store._db() as c:
        for fid in body.fids:
            cur = c.execute("UPDATE report_feedback SET status=? WHERE fid=?",
                            (body.status, fid))
            n += getattr(cur, "rowcount", 1) or 0
    return {"ok": True, "updated": n}
