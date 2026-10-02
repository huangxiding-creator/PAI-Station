# -*- coding: utf-8 -*-
"""已购检索域 [P2]——GET /search/owned：用户已购库的章级检索（FR-P2-03）。

范围=entitlements 命中的报告（已购库语义：下架不除权，off 报告仍可检索）；
章级=试读章+已解锁付费章皆可命中（付费正文引擎侧全集已在库，链路①-4）。
实现=本地零外呼：jieba 切词（复用 fts.tokenize）→ SQLite LIKE 预筛（token
转义防通配注入）→ Python 去标签纯文本精确定位（LIKE 命中在标签内的假阳性
剔除）。40-200 份规模全扫 P95 可行（ARCHITECTURE A2 同判）。

防泄漏纪律（与 trial 空壳章同源，NFR-05 口径）：付费章 snippet 只返回
命中句 ±40 字（config.SEARCH_OWNED_SNIPPET_RADIUS）——本端点虽已锁已购，
仍按最小暴露面设计（截屏/抓包泄漏半径最小化），测试锁定窗口上限。

分页游标：cursor="{report_id}:{chapter_idx}"（结果按 (report_id, idx)
稳定排序，游标比较跳过已发条目）；响应 {items,total,next_cursor,has_more}。
限流：单 uid 30 次/分（API_DESIGN §一 search 档）→429 RATE_LIMITED+告警。
offset=命中词在该章去标签纯文本中的字符偏移（阅读器跳转锚；页位按
CHARS_PER_PAGE 口径估算）。
"""
from __future__ import annotations

import logging
import re

from fastapi import APIRouter, Request

from . import config, notify, store, wechat
from .chapters import SlidingWindowLimiter
from .errors import ApiError
from .fts import tokenize

router = APIRouter(prefix="/api/v1", tags=["search-owned"])
logger = logging.getLogger("xueyuan.owned_search")

_LIMITER = SlidingWindowLimiter()
_PAGE_MAX = 50

_TAG_RE = re.compile(r"<[^>]+>")
_WS_RE = re.compile(r"\s+")
_SENT_END_RE = re.compile(r"[。！？!?；;\n]")


def plain_text(html: str) -> str:
    """章 html → 纯文本（去标签+空白折叠；offset/snippet 的坐标空间）。"""
    return _WS_RE.sub(" ", _TAG_RE.sub("", html or "")).strip()


def _like(term: str) -> str:
    """LIKE 模式（% _ \ 转义，防通配注入；fts._like 同口径局部复用）。"""
    return "%" + term.replace("\\", "\\\\").replace("%", r"\%")\
        .replace("_", r"\_") + "%"


def make_snippet(plain: str, hit: int,
                 radius: int | None = None) -> tuple[str, int]:
    """命中句 ±radius 字（默认 40=config 锁定）。

    句界=最近句末标点；句子超窗时以命中点为中心截 [hit-radius, hit+radius]。
    返回 (snippet, offset)——offset=命中词字符位（不变式：hit ∈ 窗内）。
    泄漏控制不变式：len(snippet) ≤ 2*radius+1（测试锁定）。
    """
    radius = config.SEARCH_OWNED_SNIPPET_RADIUS if radius is None else radius
    hit = max(0, min(hit, max(0, len(plain) - 1)))
    start = 0
    for m in _SENT_END_RE.finditer(plain, 0, hit):
        start = m.end()
    m = _SENT_END_RE.search(plain, hit)
    end = m.end() if m else len(plain)
    s, e = max(start, hit - radius), min(end, hit + radius + 1)
    return plain[s:e].strip(), hit


def _owned_report_ids(uid: str) -> list[str]:
    """已购库报告清单（entitlements 命中即入，不限 status——已购不因下架除权）。"""
    with store._db() as c:
        rows = c.execute(
            "SELECT DISTINCT r.id FROM reports r JOIN entitlements e"
            " ON e.report_id=r.id WHERE e.user_id=? ORDER BY r.id", (uid,)
        ).fetchall()
    return [r["id"] for r in rows]


def _candidate_chapters(rids: list[str], terms: list[str]) -> list[dict]:
    """SQL LIKE 预筛：已购报告的章节中 html 任一 token 命中（转义+参数化）。"""
    if not rids or not terms:
        return []
    rid_marks = ",".join("?" * len(rids))
    pat = " OR ".join("html LIKE ? ESCAPE '\\'" for _ in terms)
    with store._db() as c:
        rows = c.execute(
            f"SELECT ch.id AS slug, ch.report_id, ch.idx, ch.title, ch.html,"
            f" r.title AS report_title FROM chapters ch JOIN reports r"
            f" ON r.id=ch.report_id WHERE ch.report_id IN ({rid_marks})"
            f" AND ({pat}) ORDER BY ch.report_id, ch.idx",
            (*rids, *(_like(t) for t in terms)),
        ).fetchall()
    return [dict(r) for r in rows]


def _parse_cursor(cursor: str) -> tuple[str, int] | None:
    """游标 "{report_id}:{idx}" 解析（非法返回 None=从头起）。"""
    if not cursor or ":" not in cursor:
        return None
    rid, _, idx = cursor.rpartition(":")
    try:
        return rid, int(idx)
    except ValueError:
        return None


def search_owned(uid: str, q: str, cursor: str = "", limit: int | None = None) -> dict:
    """章级检索核心管线（HTTP 端点与运维脚本共用；q 须非空）。"""
    limit = config.SEARCH_OWNED_PAGE_SIZE if limit is None else limit
    limit = max(1, min(_PAGE_MAX, limit))
    toks = sorted({t.lower() for t in tokenize(q.strip()) if t.strip()})
    terms = toks or ([q.strip().lower()] if q.strip() else [])
    rids = _owned_report_ids(uid)
    hits: list[dict] = []
    if rids and terms:
        for ch in _candidate_chapters(rids, terms):
            plain = plain_text(ch["html"])
            low = plain.lower()
            pos = [low.find(t) for t in terms if low.find(t) >= 0]
            if not pos:
                continue  # LIKE 命中在标签内→假阳性剔除
            hit = min(pos)
            snippet, offset = make_snippet(plain, hit)
            hits.append({
                "report_id": ch["report_id"], "title": ch["report_title"],
                "chapter_id": ch["slug"].split("/")[-1],
                "chapter_title": ch["title"], "snippet": snippet, "offset": offset,
            })
    cur = _parse_cursor(cursor)
    if cur:
        hits = [h for h in hits
                if (h["report_id"], _idx_of(h)) > cur]
    total = len(hits)
    page = hits[:limit]
    last = page[-1] if page else None
    return {
        "items": page, "total": total,
        "next_cursor": f"{last['report_id']}:{_idx_of(last)}" if last and total > limit else "",
        "has_more": total > limit,
    }


def _idx_of(item: dict) -> int:
    """条目章序（游标比较键；chapter_id 形如 chNN）。"""
    cid = item["chapter_id"]
    digits = re.sub(r"\D", "", cid)
    return int(digits) if digits else 0


@router.get("/search/owned")
def search_owned_endpoint(request: Request, q: str = "", cursor: str = "",
                          limit: int | None = None):
    """已购库章级检索入口（FR-P2-03；Bearer）。空 q→400；未购库空结果不报错。"""
    openid = wechat.bearer_openid(request)
    if not openid:
        raise ApiError(401, "UNAUTHORIZED", "未登录或凭证过期")
    uid = store.get_or_create_user(openid)["id"]
    q = (q or "").strip()
    if not q:
        raise ApiError(400, "INVALID_PARAM", "缺少搜索词 q")
    if not _LIMITER.allow(uid, config.SEARCH_OWNED_RATE_PER_MIN):
        notify.alert(f"已购检索限流触发 uid={uid} 阈值="
                     f"{config.SEARCH_OWNED_RATE_PER_MIN}/min")
        raise ApiError(429, "RATE_LIMITED", "操作过快，请稍后再试")
    return search_owned(uid, q, cursor=cursor, limit=limit)
