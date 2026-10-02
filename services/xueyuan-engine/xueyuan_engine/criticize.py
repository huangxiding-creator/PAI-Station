# -*- coding: utf-8 -*-
"""批评评分域 [P1]——四层闸：资格/代码预筛（字数/查重/锚定分）→免费模型判断层
（异步线程）→确定性映射（refund.py 纯函数）（ARCHITECTURE §三 A6；链路④）。

L1 同步闸（API_DESIGN P1-2 顺序）：NOT_PURCHASED→NO_READ_RECORD→CRITICISM_DUP→
REFUND_MONTHLY_LIMIT→LENGTH_INVALID→ANCHOR_ZERO→SIMILARITY_HIGH（转人工不自动拒）。
L2 判断层异步：受理即回执、评分后台线程完成；失败降级=pending_score 可重试，
绝不丢批评。免费模型铁律：默认启发式（确定性词面+结构特征，诚实标注「待接免费
模型」）；XY_JUDGE_PROVIDER=openai_compat 可指免费端点（密钥仅 env/secret 路径
读，代码零密钥）——站内 qianwen-engine 两腿（metaso KB 网页积分池/search-api
按点计费）均为积分制付费资源，不得接入（判断层付费 API 调用数必须=0）。
AI 只有建议权无放款独裁量（refund.py 硬门收口）。
"""
from __future__ import annotations

import json
import logging
import os
import re
import threading
import uuid
from pathlib import Path

from curl_cffi import requests as cr
from fastapi import APIRouter, Request
from pydantic import BaseModel

from . import config, notify, refund, store, wechat
from .catalog import chapter_rows, get_report
from .errors import ApiError

logger = logging.getLogger("xueyuan.criticize")

router = APIRouter(prefix="/api/v1", tags=["criticize"])

_SIM_THRESHOLD = 0.6  # 查重线（env XY_SIMILARITY_THRESHOLD 可调）


def similarity_threshold() -> float:
    try:
        return float(os.environ.get("XY_SIMILARITY_THRESHOLD", str(_SIM_THRESHOLD)))
    except ValueError:
        return _SIM_THRESHOLD


# ── L1 确定性预筛（层②代码闸）────────────────────────────────
def char_count(content: str) -> int:
    """批评字数（去空白字符计；50-300 门，冗长偏差校正）。"""
    return len(re.sub(r"\s+", "", content or ""))


_CHAPTER_RE = re.compile(
    r"第\s*[0-9一二三四五六七八九十百零两]+\s*[章节回]|ch\d{1,2}\b|章节\s*\d+|附录")
_DATA_RE = re.compile(
    r"\d+(?:\.\d+)?\s*(?:%|％|亿|万|千|元|吨|公里|千米|km|米|GW|MW|kW|项|台|座)")


def anchor_score(content: str) -> float:
    """语义锚定分：引用具体章节→0.6；数据点→+0.4（上限 1.0）。
    模板化话术（无章节无数据点）=0 → L1 直接拒（ANCHOR_ZERO，不给退）。"""
    s = (0.6 if _CHAPTER_RE.search(content) else 0.0) \
        + (0.4 if _DATA_RE.search(content) else 0.0)
    return round(min(1.0, s), 2)


_STRIP_RE = re.compile(r"[\s，。、！？；：“”‘’（）()\[\]【】,.\!\?;:…\-—]+")


def _ngrams(text: str, n: int = 3) -> set:
    t = _STRIP_RE.sub("", text or "")
    if len(t) < n:
        return {t} if t else set()
    return {t[i:i + n] for i in range(len(t) - n + 1)}


def similarity_scan(content: str, report_id: str) -> dict:
    """与历史批评查重（字符 3-gram Jaccard 最高值；同报告库内比对）。"""
    grams = _ngrams(content)
    best, hit = 0.0, None
    if not grams:
        return {"score": 0.0, "matched_id": "", "matched_user": ""}
    with store._db() as c:
        rows = c.execute(
            "SELECT id,user_id,content FROM criticisms WHERE report_id=?",
            (report_id,),
        ).fetchall()
    for row in rows:
        other = _ngrams(row["content"])
        if not other:
            continue
        j = len(grams & other) / len(grams | other)
        if j > best:
            best, hit = j, row
    return {"score": round(best, 4), "matched_id": hit["id"] if hit else "",
            "matched_user": hit["user_id"] if hit else ""}


# ── L2 判断层（免费模型铁律：默认启发式零外呼）─────────────────────
_TEMPLATE_HINTS = ("不值这个价", "垃圾报告", "差评", "太差了", "上当", "浪费时间")
_SINCERE_HINTS = ("我觉得", "我认为", "我们项目", "我们公司", "实际经验", "亲历", "接触过")
_PROBLEM_HINTS = ("问题", "不足", "矛盾", "不符", "偏差", "缺", "错", "遗漏", "没讲清", "单薄")
_SUGGEST_HINTS = ("建议", "应该", "希望", "补充", "完善", "改进", "加上", "核实")
_EMOJI_RE = re.compile("[\U0001F300-\U0001FAFF☀-➿]")


def _repeat_ratio(content: str) -> float:
    """5-gram 重复率（复制粘贴/复读机特征；正常行文<0.3）。"""
    t = re.sub(r"\s+", "", content)
    grams = [t[i:i + 5] for i in range(max(0, len(t) - 4))]
    if len(grams) <= 1:
        return 0.0
    return 1 - len(set(grams)) / len(grams)


def _chapter_title_hit(content: str, chapters: list) -> float:
    """批评词面命中报告章节标题（真实度特征；命中→1.0）。"""
    for ch in chapters:
        title = re.sub(r"第[0-9一二三四五六七八九十百零两]+章|[0-9]+", "", ch["title"])
        for word in re.split(r"[\s、：:；;，,]+", title):
            if len(word) >= 2 and word in content:
                return 1.0
    return 0.0


def _clamp(v: int) -> int:
    return max(0, min(100, int(v)))


def heuristic_scores(content: str, chapters: list) -> dict:
    """确定性启发式评分（锚点词面+结构特征；诚实标注待接免费模型）。

    恶意样本（复制粘贴/乱码/纯表情）经重复率/表情占比/模板词三特征降分。
    """
    n = char_count(content)
    rep = _repeat_ratio(content)
    emoji_ratio = len(_EMOJI_RE.findall(content)) / max(1, n)
    anch = anchor_score(content)
    chap_hit = _chapter_title_hit(content, chapters)
    sincere_n = sum(1 for k in _SINCERE_HINTS if k in content)
    template_n = sum(1 for k in _TEMPLATE_HINTS if k in content)
    problem_n = sum(1 for k in _PROBLEM_HINTS if k in content)
    suggest_n = sum(1 for k in _SUGGEST_HINTS if k in content)
    anchor_desc = ("引用章节/数据点" if anch > 0 else "无锚点")
    return {
        "sincerity": _clamp(60 + 8 * min(sincere_n, 3) - 25 * min(template_n, 2)
                            - int(rep * 60) - int(emoji_ratio * 80)),
        "authenticity": _clamp(30 + int(anch * 45) + int(chap_hit * 25)),
        "constructiveness": _clamp(25 + 12 * min(problem_n, 3) + 12 * min(suggest_n, 3)
                                   - int(rep * 40) - int(emoji_ratio * 40)),
        "rationale": f"「{content[:24]}…」↔ {anchor_desc}"
                     "（启发式评分：确定性词面+结构特征，待接免费模型）",
        "provider": "heuristic",
    }


def judge_provider() -> str:
    return (os.environ.get("XY_JUDGE_PROVIDER") or "heuristic").strip().lower()


def run_judge(content: str, report: dict, chapters: list) -> dict:
    """L2 分发：默认 heuristic（零外呼）；openai_compat=免费端点适配（失败抛错
    →批评保持 pending_score 可重试，绝不丢批评）。"""
    if judge_provider() == "openai_compat":
        return _openai_compat_judge(content, report, chapters)
    return heuristic_scores(content, chapters)


def _judge_prompt(content: str, report: dict, chapters: list) -> str:
    toc = "；".join(f"{c['id'].split('/')[-1]} {c['title']}" for c in chapters[:30])
    return ("你是研报批评评分官。对下述批评打三维分（各0-100整数）：sincerity 真诚度"
            "（模板话术/复制粘贴/纯表情应低分）；authenticity 真实度（是否引用具体章节"
            "或数据点）；constructiveness 建设性（可用于改进的具体意见）。\n"
            f"报告：{report.get('title', '')}。目录：{toc}\n批评原文：{content}\n"
            '只输出 JSON：{"sincerity":0,"authenticity":0,"constructiveness":0,'
            '"rationale":"批评哪句↔报告哪节"}')


def _openai_compat_judge(content: str, report: dict, chapters: list) -> dict:
    """OpenAI 兼容端点适配（XY_JUDGE_BASE_URL/XY_JUDGE_MODEL/XY_JUDGE_API_KEY
    或 XY_JUDGE_KEY_FILE；密钥运行时从 env/secret 路径读，代码零密钥）。

    仅当站内确认**免费**端点后由运维显式配置启用；解析强校验三维 0-100。"""
    base = os.environ.get("XY_JUDGE_BASE_URL", "").rstrip("/")
    model = os.environ.get("XY_JUDGE_MODEL", "")
    key = os.environ.get("XY_JUDGE_API_KEY", "")
    keyfile = os.environ.get("XY_JUDGE_KEY_FILE", "")
    if not key and keyfile and Path(keyfile).exists():
        key = Path(keyfile).read_text(encoding="utf-8").strip()
    if not (base and model):
        raise RuntimeError("XY_JUDGE_* 未配置（openai_compat provider 不可用）")
    r = cr.post(
        f"{base}/chat/completions",
        headers={"Authorization": f"Bearer {key}"},
        json={"model": model, "temperature": 0,
              "messages": [{"role": "user", "content": _judge_prompt(
                  content, report, chapters)}]},
        timeout=60,
    )
    r.raise_for_status()
    raw = ((r.json().get("choices") or [{}])[0].get("message") or {}).get("content", "")
    m = re.search(r"\{.*\}", raw, re.S)
    data = json.loads(m.group(0) if m else "{}")
    out = {k: _clamp(float(data[k])) for k in
           ("sincerity", "authenticity", "constructiveness") if k in data}
    if len(out) != 3:
        raise RuntimeError(f"判断层回包缺三维分: {raw[:120]}")
    out["rationale"] = str(data.get("rationale", ""))[:500]
    out["provider"] = "openai_compat"
    return out


def compose_final(scores: dict) -> float:
    """合成分=三维等权均值一位小数（API_DESIGN P1-3 实样：78/82/70→76.7）。"""
    vals = [float(scores.get(k, 0)) for k in ("sincerity", "authenticity", "constructiveness")]
    return round(sum(vals) / 3.0, 1)


# ── 异步评分线程（受理即回执；失败=pending_score 可重试）──────────────
_scoring_lock = threading.Lock()
_inflight: set = set()


def _spawn_scoring(cid: str) -> None:
    with _scoring_lock:
        if cid in _inflight:
            return
        _inflight.add(cid)
    threading.Thread(target=_score_guarded, args=(cid,), daemon=True,
                     name=f"xy-score-{cid}").start()


def _score_guarded(cid: str) -> None:
    try:
        _score_one(cid)
    except Exception:  # noqa: BLE001 —— 评分失败保持待评分，绝不丢批评
        logger.exception("criticism %s 评分失败（pending_score 可重试）", cid)
    finally:
        with _scoring_lock:
            _inflight.discard(cid)


def _score_one(cid: str) -> None:
    with store._db() as c:
        row = c.execute("SELECT * FROM criticisms WHERE id=?", (cid,)).fetchone()
    if not row or row["status"] != "pending_score":
        return
    report = get_report(row["report_id"]) or {}
    chapters = chapter_rows(row["report_id"])
    scores = run_judge(row["content"], report, chapters)
    final = compose_final(scores)
    with store._LOCK, store._db() as c:
        c.execute(
            "UPDATE criticisms SET llm_scores=?, final_score=?, refund_tier=?,"
            " status='scored' WHERE id=?",
            (json.dumps({k: scores.get(k) for k in
                         ("sincerity", "authenticity", "constructiveness",
                          "rationale", "provider")}, ensure_ascii=False),
             final, refund.tier_label(final), cid),
        )
    if final < refund.SCORE_THRESHOLD:  # <50 不退+感谢券（幂等）
        refund.grant_voucher(row["user_id"], _thanks_fen(), "criticism_thanks", cid)
        return
    manual = refund.tier_percent(final) > config.AUTO_REFUND_TIER_CAP
    with store._db() as c:
        manual = manual or c.execute(
            "SELECT is_blacklisted FROM users WHERE id=?", (row["user_id"],)
        ).fetchone()["is_blacklisted"] == 1
    if manual:  # 超50%档/黑名单→人工复核位（AN#8；放款仍走 refund 硬门）
        with store._LOCK, store._db() as c:
            c.execute("UPDATE criticisms SET manual_review=1 WHERE id=?", (cid,))


def _thanks_fen() -> int:
    """感谢券面值（AGREEMENT 未冻结金额——运营参数，env 可调；默认 ¥5）。"""
    try:
        return max(0, int(os.environ.get("XY_THANKS_VOUCHER_FEN", "500")))
    except ValueError:
        return 500


# ── POST /reports/{rid}/criticize（P1-2 四层闸·同步返回 pre_gate）────────
class CriticizeIn(BaseModel):
    content: str
    order_id: str = ""


def _paid_order(uid: str, rid: str, order_id: str) -> dict | None:
    with store._db() as c:
        if order_id:
            row = c.execute(
                "SELECT * FROM orders WHERE out_trade_no=? AND user_id=? AND"
                " report_id=? AND status IN ('paid','delivered')",
                (order_id, uid, rid)).fetchone()
            if row:
                return dict(row)
        row = c.execute(
            "SELECT * FROM orders WHERE user_id=? AND report_id=? AND status IN"
            " ('paid','delivered') ORDER BY id DESC LIMIT 1", (uid, rid)).fetchone()
    return dict(row) if row else None


@router.post("/reports/{rid}/criticize")
def criticize_submit(rid: str, body: CriticizeIn, request: Request):
    openid = wechat.bearer_openid(request)
    if not openid:
        raise ApiError(401, "UNAUTHORIZED", "未登录或凭证过期")
    uid = store.get_or_create_user(openid)["id"]
    if not get_report(rid):
        raise ApiError(404, "REPORT_NOT_FOUND", "报告不存在或已下架")
    order = _paid_order(uid, rid, body.order_id)
    if not order:  # 层①：须有该报告已付订单
        raise ApiError(403, "NOT_PURCHASED", "须先购买该报告才可发起批评")
    with store._db() as c:
        read = c.execute("SELECT 1 FROM read_log WHERE user_id=? AND report_id=?"
                         " LIMIT 1", (uid, rid)).fetchone()
        dup = c.execute("SELECT id FROM criticisms WHERE user_id=? AND report_id=?",
                        (uid, rid)).fetchone()
    if not read:  # 层①：真实阅读行为（未读者不可发起）
        raise ApiError(400, "NO_READ_RECORD", "未检测到该报告的阅读记录，不可发起")
    if dup:  # 层①：每报告每用户 1 次
        raise ApiError(400, "CRITICISM_DUP", "每份报告每个账号限发起 1 次批评")
    if refund.refresh_month_counter(uid) >= config.REFUND_MONTHLY_LIMIT:
        raise ApiError(429, "REFUND_MONTHLY_LIMIT", "本月退款次数已达上限")
    n = char_count(body.content)
    if not (config.CRITICISM_MIN_CHARS <= n <= config.CRITICISM_MAX_CHARS):
        raise ApiError(400, "LENGTH_INVALID", "批评字数须为 50-300 字")
    anch = anchor_score(body.content)
    if anch <= 0:  # 层②：模板化话术锚定分=0 → 直接不给退
        raise ApiError(400, "ANCHOR_ZERO",
                       "批评须引用报告的具体章节或数据点，模板化话术无法通过")
    sim = similarity_scan(body.content, rid)
    cid = f"c{uuid.uuid4().hex[:16]}"
    if sim["score"] > similarity_threshold():  # 层②：查重超线→转人工（不自动拒）
        dup_flag = 1 if sim["matched_user"] and sim["matched_user"] != uid else 0
        with store._LOCK, store._db() as c:
            c.execute(
                "INSERT INTO criticisms(id,user_id,report_id,order_id,content,"
                "char_count,read_verified,anchor_score,similarity_score,dup_flag,"
                "manual_review,status,created_at)"
                " VALUES(?,?,?,?,?,?,1,?,?,?,1,'manual_pending',?)",
                (cid, uid, rid, order["out_trade_no"], body.content, n, anch,
                 sim["score"], dup_flag, store.now()),
            )
        if dup_flag:
            notify.alert(f"[xueyuan 查重] 跨账号批评高度雷同：{cid} ≈ {sim['matched_id']}")
        raise ApiError(409, "SIMILARITY_HIGH", "与历史批评相似度过高，已转人工复核",
                       extra={"stage": "manual_pending", "criticism_id": cid})
    with store._LOCK, store._db() as c:
        c.execute(
            "INSERT INTO criticisms(id,user_id,report_id,order_id,content,char_count,"
            "read_verified,anchor_score,similarity_score,status,created_at)"
            " VALUES(?,?,?,?,?,?,1,?,?, 'pending_score', ?)",
            (cid, uid, rid, order["out_trade_no"], body.content, n, anch,
             sim["score"], store.now()),
        )
    _spawn_scoring(cid)  # L2 异步：受理即回执
    return {"criticism_id": cid, "stage": "pre_gate_passed",
            "anchor_score": anch, "similarity_score": sim["score"],
            "scoring": "async", "poll": f"/api/v1/criticisms/{cid}"}


# ── GET /criticisms/{cid}（P1-3；仅作者）──────────────────────────
@router.get("/criticisms/{cid}")
def criticism_get(cid: str, request: Request):
    openid = wechat.bearer_openid(request)
    if not openid:
        raise ApiError(401, "UNAUTHORIZED", "未登录或凭证过期")
    uid = store.get_or_create_user(openid)["id"]
    with store._db() as c:
        row = c.execute("SELECT * FROM criticisms WHERE id=? AND user_id=?",
                        (cid, uid)).fetchone()
        refund_row = c.execute(
            "SELECT id,method,amount_fen,status FROM refunds WHERE criticism_id=?"
            " ORDER BY id DESC LIMIT 1", (cid,)).fetchone()
    if not row:  # 他人批评同 404（不泄漏存在性）
        raise ApiError(404, "CRITICISM_NOT_FOUND", "批评记录不存在")
    row = dict(row)
    if row["status"] == "pending_score":  # 待评分可重试（线程守卫防重）
        _spawn_scoring(cid)
    try:
        scores = json.loads(row["llm_scores"] or "{}")
    except ValueError:
        scores = {}
    return {
        "id": cid, "status": row["status"], "llm_scores": scores,
        "final_score": row["final_score"], "refund_tier": row["refund_tier"],
        "manual_review": row["manual_review"],
        "refund": ({"refund_id": refund_row["id"], "method": refund_row["method"],
                    "amount_fen": refund_row["amount_fen"],
                    "status": refund_row["status"]} if refund_row else None),
    }
