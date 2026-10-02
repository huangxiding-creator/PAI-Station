# -*- coding: utf-8 -*-
"""章节下发域——按权益裁剪下发/空壳章/阅读行为落 read_log（A3；链路①-4/⑤）。

防泄漏主闸（NFR-05/FR-P0-07）：权益判定在服务端——未购请求付费章响应体
**不含 html 字段**（字段缺席而非空串，反编译与抓包双审计判据）；已购
（entitlements 命中）全量正文。单 Bearer 付费章拉取超阈值（60 次/分，配置项）
→429 RATE_LIMITED+告警钩子（notify.alert；企微实装 P1）。
"""
from __future__ import annotations

import threading
import time
from collections import deque

from fastapi import APIRouter, Request

from . import config, notify, store, wechat
from .catalog import chapter_rows, get_report
from .errors import ApiError

router = APIRouter(prefix="/api/v1", tags=["chapters"])


class SlidingWindowLimiter:
    """内存滑窗限流（单进程足够：单引擎单体，ARCHITECTURE A1）。"""

    def __init__(self) -> None:
        self._hits: dict[str, deque] = {}
        self._lock = threading.Lock()

    def allow(self, key: str, limit: int, window_sec: float = 60.0) -> bool:
        now = time.monotonic()
        with self._lock:
            q = self._hits.setdefault(key, deque())
            while q and q[0] <= now - window_sec:
                q.popleft()
            if len(q) >= limit:
                return False
            q.append(now)
            return True


_LIMITER = SlidingWindowLimiter()


def _check_rate_limit(uid: str) -> None:
    """付费章拉取限流（NFR-05）：超阈值 429+告警钩子（挂点勿删）。"""
    if not _LIMITER.allow(uid, config.RATE_LIMIT_PER_MIN):
        notify.alert(f"付费章拉取限流触发 uid={uid} 阈值={config.RATE_LIMIT_PER_MIN}/min")
        raise ApiError(429, "RATE_LIMITED", "操作过快，请稍后再试")


def _entitled(uid: str | None, rid: str) -> bool:
    if not uid:
        return False
    with store._db() as c:
        row = c.execute(
            "SELECT 1 FROM entitlements WHERE user_id=? AND report_id=? LIMIT 1",
            (uid, rid)).fetchone()
    return row is not None


@router.get("/reports/{rid}/chapters")
def chapters(rid: str, request: Request, with_content: str = "trial"):
    """章节目录（鉴权可选）。with_content=all 仅表示「请求含付费正文」——
    权益判定在服务端，未购仍裁剪（客户端不得自证权益）。
    """
    if with_content not in ("trial", "all"):
        raise ApiError(400, "INVALID_PARAM", "with_content 仅支持 trial|all")
    row = get_report(rid)
    if not row:
        raise ApiError(404, "REPORT_NOT_FOUND", "报告不存在或已下架")
    openid = wechat.bearer_openid(request)
    uid = store.get_or_create_user(openid)["id"] if openid else None
    if uid:  # 读腿（v1.2 §六有效带新判据①）：invitee 带 Bearer 首读即置 effective
        try:  # 纯副作用——归因域故障不得影响阅读下发（响应形状不变）
            from . import invite as _invite  # 局部导入防环（invite→me 链不回 chapters）
            _invite.mark_effective(uid, rid)
        except Exception:  # noqa: BLE001 —— 同 store.sync fts 钩子降级纪律
            pass
    wants_paid = with_content == "all"
    if wants_paid and uid:
        _check_rate_limit(uid)  # 付费章拉取为限流主落点（链路②/A3）
    owned = _entitled(uid, rid)
    items, last_slug = [], None
    for ch in chapter_rows(rid):
        cid = ch["id"].split("/")[-1]
        base = {"id": cid, "title": ch["title"], "idx": ch["idx"], "is_trial": ch["is_trial"]}
        if ch["is_trial"] or owned:
            base["html"] = ch["html"]
            base["pages"] = max(1, -(-ch["char_count"] // config.CHARS_PER_PAGE)) if ch["char_count"] else 1
            last_slug = ch["id"]
        else:  # 未购付费章：仅元数据，html 字段缺席（防泄漏判据）
            base["html_len"] = len(ch["html"])
            base["pages"] = max(1, -(-ch["char_count"] // config.CHARS_PER_PAGE)) if ch["char_count"] else 1
        items.append(base)
    if uid and last_slug:  # 阅读行为落 read_log（P1 批评资格闸判据；每次请求一条）
        _log_read(uid, rid, last_slug)
    return {"report_id": rid, "trial_chapters": row["trial_chapters"], "chapters": items}


@router.post("/reports/{rid}/chapters/{cid}")
def chapter_detail(rid: str, cid: str, request: Request):
    """单章下发（P0-6 防泄漏主闸+限流主落点；前端 reader.ts 已购付费章加载走此）。

    响应为 API_DESIGN 契约字段 {chapter_id,html,is_trial} 的超集（追加
    id/title/pages 便于前端渲染，超集不破坏契约判据）。试读章免登录判定在
    服务端；付费章：401 未登录→429 限流→403 NOT_ENTITLED（响应体不含
    html 字段）→200 全量。html 来自库内章节行（sync 时已由
    chapters_full.json 全集覆盖入库，未购只见空壳）。
    """
    if not get_report(rid):
        raise ApiError(404, "REPORT_NOT_FOUND", "报告不存在或已下架")
    with store._db() as c:
        ch = c.execute("SELECT * FROM chapters WHERE id=?", (f"{rid}/{cid}",)).fetchone()
    if not ch:
        raise ApiError(404, "CHAPTER_NOT_FOUND", "章节不存在")
    ch = dict(ch)
    pages = max(1, -(-ch["char_count"] // config.CHARS_PER_PAGE)) if ch["char_count"] else 1
    if not ch["is_trial"]:  # 付费章：登录→限流→权益（主闸单点语义）
        openid = wechat.bearer_openid(request)  # 伪/坏 Bearer 此处 401
        if not openid:
            raise ApiError(401, "UNAUTHORIZED", "未登录或凭证过期")
        uid = store.get_or_create_user(openid)["id"]
        _check_rate_limit(uid)
        if not _entitled(uid, rid):
            raise ApiError(403, "NOT_ENTITLED", "尚未解锁该研报")
        _log_read(uid, rid, ch["id"])
    elif (openid := wechat.bearer_openid(request)):
        _log_read(store.get_or_create_user(openid)["id"], rid, ch["id"])
    return {"chapter_id": cid, "id": cid, "title": ch["title"], "html": ch["html"],
            "is_trial": ch["is_trial"], "pages": pages}


def _log_read(uid: str, rid: str, slug: str) -> None:
    """阅读行为落 read_log（每次请求一条；P1 批评资格闸判据）。"""
    with store._LOCK, store._db() as c:
        c.execute("INSERT INTO read_log(user_id,report_id,chapter_id,ts) VALUES(?,?,?,?)",
                  (uid, rid, slug, store.now()))
