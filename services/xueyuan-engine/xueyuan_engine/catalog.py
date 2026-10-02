# -*- coding: utf-8 -*-
"""报告目录域——/catalog /reports/{id}：榜单/筛选/决策卡数据/预览三件套（ARCHITECTURE §六）。

三维关联推荐=结构化字段精确匹配（同省/同业主/同行业），不用 AI（REQUIREMENTS 4.2）。
hot 榜=阅读榜（read_log 聚合，无阅读数据回退上新序）；new=上新序；praise 在评分数据
上线前服务端置不可见（API_DESIGN P0-2）。条目序列化与 search 共用（fts.py）。
"""
from __future__ import annotations

import json
from pathlib import Path

from fastapi import APIRouter, Request

from . import config, store, wechat
from .errors import ApiError

router = APIRouter(prefix="/api/v1", tags=["catalog"])

_PAGE_SIZE_MAX = 50
REFUND_POLICY_URL = "/pages/agreement/index#refund"


def apply_off_sidecar(content_dir: Path | None = None) -> int:
    """运营下架旁挂位（RL 决策③）：content/off.json={"off":[slug,...]}——产线永不写此文件。
    幂等对齐全库 status：在列=off（列表/详情/关联/搜索全屏蔽），移出即复上架；返回 off 数。
    生产翻此位后 systemctl restart 生效（admin/resync 为 dev 闸）；fts 查询态过滤 status 无需重建。"""
    off_file = Path(content_dir or config.CONTENT_DIR) / "off.json"
    offs: set[str] = set()
    if off_file.exists():
        try:
            offs = {str(s).strip() for s in
                    json.loads(off_file.read_text(encoding="utf-8")).get("off", [])
                    if str(s).strip()}
        except Exception:  # noqa: BLE001 —— sidecar 损坏按空处理（全上架），不阻塞 sync
            offs = set()
    marks = ",".join("?" * len(offs))
    params = tuple(sorted(offs))
    store.init()
    with store._LOCK, store._db() as c:
        if offs:
            c.execute(f"UPDATE reports SET status='off' WHERE id IN ({marks})", params)
            c.execute(f"UPDATE reports SET status='on' WHERE status='off'"
                      f" AND id NOT IN ({marks})", params)
        else:
            c.execute("UPDATE reports SET status='on' WHERE status='off'")
    return len(offs)


def get_report(rid: str) -> dict | None:
    store.init()
    with store._db() as c:
        row = c.execute("SELECT * FROM reports WHERE id=? AND status='on'", (rid,)).fetchone()
    return dict(row) if row else None


def chapter_rows(rid: str) -> list[dict]:
    store.init()
    with store._db() as c:
        rows = c.execute(
            "SELECT * FROM chapters WHERE report_id=? ORDER BY idx", (rid,)
        ).fetchall()
    return [dict(r) for r in rows]


def item_of(row: dict) -> dict:
    """catalog 条目序列化（/catalog 与 /search 共用；cover 暂空串待 A 线封面产物）。"""
    return {
        "id": row["id"], "title": row["title"], "summary": row["summary"],
        "price_fen": row["price_fen"], "province": row["province"],
        "owner_type": row["owner_type"], "industry": row["industry"],
        "chapter_count": row["chapter_count"], "trial_chapters": row["trial_chapters"],
        "tags": json.loads(row["tags"] or "[]"), "published_at": row["published_at"],
        "cover": "",
    }


def _read_counts() -> dict[str, int]:
    with store._db() as c:
        rows = c.execute(
            "SELECT report_id, COUNT(*) n FROM read_log GROUP BY report_id"
        ).fetchall()
    return {r["report_id"]: r["n"] for r in rows}


def _query_reports(province: str, owner_type: str, industry: str, order_sql: str,
                   limit: int, offset: int) -> tuple[list[dict], int]:
    where, params = "WHERE status='on'", []
    for col, val in (("province", province), ("owner_type", owner_type),
                     ("industry", industry)):
        if val:
            where += f" AND {col}=?"
            params.append(val)
    with store._db() as c:
        total = c.execute(f"SELECT COUNT(*) n FROM reports {where}", params).fetchone()["n"]
        rows = c.execute(
            f"SELECT * FROM reports {where} ORDER BY {order_sql} LIMIT ? OFFSET ?",
            (*params, limit, offset),
        ).fetchall()
    return [dict(r) for r in rows], total


@router.get("/catalog")
def catalog(tab: str = "hot", province: str = "", owner_type: str = "",
            industry: str = "", page: int = 1, page_size: int = 20):
    """商城目录（免登录）：榜单 tab + 三筛选（各自与组合均出正确子集）+ 分页。"""
    if tab not in ("hot", "new", "praise"):
        raise ApiError(400, "INVALID_PARAM", f"非法 tab：{tab}")
    if tab == "praise":  # 好评榜：评分数据上线前不可见（FR-P0-02）
        return {"items": [], "total": 0, "page": page, "page_size": page_size,
                "praise_visible": False}
    page = max(1, page)
    page_size = min(_PAGE_SIZE_MAX, max(1, page_size))
    # hot=阅读榜（read_log 聚合降序，无阅读数据回退上新序）；new=上新序
    order = ("(SELECT COUNT(*) FROM read_log WHERE read_log.report_id=reports.id) DESC, "
             "published_at DESC") if tab == "hot" else "published_at DESC"
    rows, total = _query_reports(province, owner_type, industry, order,
                                 page_size, (page - 1) * page_size)
    return {"items": [item_of(r) for r in rows], "total": total, "page": page,
            "page_size": page_size, "praise_visible": False}


def _pages(ch: dict) -> int:
    return max(1, -(-ch["char_count"] // config.CHARS_PER_PAGE)) if ch["char_count"] else 0


@router.get("/reports/{rid}")
def report_detail(rid: str, request: Request):
    """报告详情（鉴权可选：Bearer→owned/收藏态个性化；不带→游客视图）。"""
    row = get_report(rid)
    if not row:
        raise ApiError(404, "REPORT_NOT_FOUND", "报告不存在或已下架")
    openid = wechat.bearer_openid(request)
    owned = favorited = False
    uid = None
    if openid:
        uid = store.get_or_create_user(openid)["id"]
        with store._db() as c:
            owned = c.execute(
                "SELECT 1 FROM entitlements WHERE user_id=? AND report_id=? LIMIT 1",
                (uid, rid)).fetchone() is not None
            favorited = c.execute(
                "SELECT 1 FROM favorites WHERE user_id=? AND report_id=? LIMIT 1",
                (uid, rid)).fetchone() is not None
    chapters = chapter_rows(rid)
    trial = [ch for ch in chapters if ch["is_trial"]]
    paid = [ch for ch in chapters if not ch["is_trial"]]
    read_pages = sum(_pages(ch) for ch in trial)
    remaining_pages = sum(_pages(ch) for ch in paid)
    if not remaining_pages and trial and paid:  # 付费正文未入库时的比例投影（空壳期）
        remaining_pages = round(read_pages / len(trial) * len(paid))
    toc = [{"id": ch["id"].split("/")[-1], "title": ch["title"],
            "is_trial": ch["is_trial"]} for ch in chapters]
    counts = _read_counts()
    rank = sorted(counts, key=lambda r: (-counts[r], r)).index(rid) + 1 if counts.get(rid) else None
    return {
        "id": row["id"], "title": row["title"], "summary": row["summary"],
        "price_fen": row["price_fen"],
        "anchor_price_fen": config.ANCHOR_PRICE_FEN, "anchor_copy": config.ANCHOR_COPY,
        "chapter_count": row["chapter_count"], "trial_chapters": row["trial_chapters"],
        "trial_pages": read_pages, "province": row["province"],
        "owner_type": row["owner_type"], "industry": row["industry"],
        "tags": json.loads(row["tags"] or "[]"), "published_at": row["published_at"],
        "owned": owned, "favorited": favorited,
        "decision_card": {
            "read_pages": read_pages, "remaining_chapters": len(paid),
            "remaining_pages": remaining_pages,
            "locked_conclusions": [{"title": ch["title"], "blurred": True}
                                   for ch in paid[:config.LOCKED_PREVIEW_COUNT]],
            "toc": toc,
        },
        "preview_triad": {
            "related": _related(row), "readers_also": _readers_also(rid),
            "rank_badge": f"阅读榜 #{rank}" if rank and rank <= config.RANK_BADGE_TOP else None,
        },
        "refund_policy_url": REFUND_POLICY_URL,
        "disclosure": {"no_reason_refund": False, "invoice_entry": True},
    }


def _related(row: dict) -> list[dict]:
    """三维关联推荐（结构化精确匹配：同省/同业主/同行业；无数据返回空数组不报错）。"""
    dims = (("province", "同省"), ("owner_type", "同业主"), ("industry", "同行业"))
    out: list[dict] = []
    for col, why in dims:
        if not row[col]:
            continue
        with store._db() as c:
            hit = c.execute(
                f"SELECT id,title FROM reports WHERE {col}=? AND id<>? AND status='on' LIMIT 1",
                (row[col], row["id"])).fetchone()
        if hit:
            out.append({"id": hit["id"], "title": hit["title"], "why": why})
    return out[:3]


def _readers_also(rid: str) -> list[dict]:
    """「读过此报告的人还在看」：read_log 共读聚合；无数据→空数组（P0 试点常态）。"""
    with store._db() as c:
        rows = c.execute(
            """SELECT r.id, r.title FROM reports r WHERE r.id<>? AND r.status='on'
               AND EXISTS (SELECT 1 FROM read_log a JOIN read_log b
                 ON a.user_id=b.user_id AND b.report_id=? WHERE a.report_id=r.id)
               LIMIT 3""",
            (rid, rid)).fetchall()
    return [{"id": r["id"], "title": r["title"]} for r in rows]
