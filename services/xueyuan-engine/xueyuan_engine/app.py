# -*- coding: utf-8 -*-
"""总包学园引擎 API（FastAPI）——装配层：路由注册+统一错误体+启动腿，无业务逻辑。

业务端点按 API_DESIGN §二挂 /api/v1 前缀（Base URL 契约；/health 前缀外无鉴权）。
启动腿（lifespan）：XY_FAKE_PAY 生产禁启自检 → store.init → 进库钩子自动 sync
（内容区未就位不阻塞启动，catalog 空态可服务——503 降级哲学同款）。
"""
from __future__ import annotations

import logging
import os
import sys
from contextlib import asynccontextmanager

from fastapi import FastAPI, HTTPException, Request
from fastapi.exceptions import RequestValidationError
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse
from pydantic import BaseModel

from . import (
    ai_chat, cards, catalog, chapters, criticize, download, fts, gift, invite,
    leaderboard, me, notify, owned_search, poster, refund, store, subscribe,
    team, transfer, virtual_pay, voucher, wechat,
)
from .errors import ApiError

logger = logging.getLogger("xueyuan.app")


@asynccontextmanager
async def lifespan(_app: FastAPI):
    from . import config

    assert_fake_pay_allowed()  # 生产禁启自检先行（失败=进程起不来=最硬的闸）
    try:
        store.init()  # 26 表全量 DDL（P2 增值簇+invite_dwell/card_code/rank_week 走末尾追加块）
        stat = store.sync_from_catalog(config.CONTENT_DIR, config.SERVER_CONTENT_DIR)
        stat["off"] = catalog.apply_off_sidecar(config.CONTENT_DIR)
        logger.info("startup sync: %s", stat)
    except Exception:  # noqa: BLE001 —— 内容区故障不阻塞引擎（catalog 空态可服务）
        logger.exception("startup sync failed (engine continues)")
    yield


app = FastAPI(title="xueyuan-engine", version="0.2.0", lifespan=lifespan)
app.add_middleware(
    CORSMiddleware, allow_origins=["*"], allow_methods=["*"], allow_headers=["*"]
)

# 业务域路由注册（各域自带 /api/v1 前缀；criticize/refund/poster 为空 router 零副作用；
# cards.h5_router 为前缀外公开 H5 长尾页）
for _router in (
    catalog.router, chapters.router, virtual_pay.router, download.router, me.router,
    fts.router, poster.router, criticize.router, refund.router, voucher.router,
    team.router, gift.router, invite.router,
    transfer.router, owned_search.router, subscribe.router, ai_chat.router,
    cards.router, cards.h5_router, leaderboard.router,
):
    app.include_router(_router)


@app.exception_handler(ApiError)
async def _api_error(request: Request, exc: ApiError) -> JSONResponse:
    """对外错误体统一 {code,message}（机器码+中文；堆栈只进日志）。"""
    body = {"code": exc.code, "message": exc.message, **exc.extra}
    return JSONResponse(status_code=exc.status, content=body)


@app.exception_handler(HTTPException)
async def _http_error(request: Request, exc: HTTPException) -> JSONResponse:
    return JSONResponse(status_code=exc.status_code,
                        content={"code": exc.status_code, "message": exc.detail})


@app.exception_handler(RequestValidationError)
async def _validation_error(request: Request, exc: RequestValidationError) -> JSONResponse:
    return JSONResponse(status_code=400,
                        content={"code": "INVALID_PARAM", "message": "请求参数不合法"})


@app.exception_handler(Exception)
async def _unhandled_error(request: Request, exc: Exception) -> JSONResponse:
    logger.exception("unhandled error on %s", request.url.path)
    return JSONResponse(status_code=500,
                        content={"code": 500, "message": "服务内部错误，请稍后重试"})


# ── XY_FAKE_* dev 闸生产禁启自检（与 QW_FAKE_ASK 同款纪律）──────────
# XY_FAKE_PAY 类 env 清单：新增假腿闸（如 XY_FAKE_NOTIFY）须在此登记，
# 生产端口携任一闸启动即拒绝启动（team.py 纪律：最硬的闸=进程起不来）。
FAKE_GATE_ENVS = ("XY_FAKE_PAY", "XY_FAKE_NOTIFY")


def detect_port(argv: list[str], env: dict) -> int | None:
    """从 uvicorn 命令行/env 探测监听端口（--port N / --port=N / XY_PORT / PORT）。"""
    for i, a in enumerate(argv):
        if a == "--port" and i + 1 < len(argv) and argv[i + 1].isdigit():
            return int(argv[i + 1])
        if a.startswith("--port=") and a[7:].isdigit():
            return int(a[7:])
    for k in ("XY_PORT", "PORT"):
        if str(env.get(k, "")).isdigit():
            return int(env[k])
    return None


def assert_fake_pay_allowed(env: dict | None = None, argv: list[str] | None = None) -> None:
    """XY_FAKE_PAY / XY_FAKE_NOTIFY=1 仅允许 dev 端口（config.DEV_FAKE_PAY_PORTS）；
    其余拒绝启动。"""
    env = dict(os.environ) if env is None else env
    tripped = [k for k in FAKE_GATE_ENVS if env.get(k) == "1"]
    if not tripped:
        return
    from . import config

    port = detect_port(argv if argv is not None else sys.argv, env)
    if port not in config.DEV_FAKE_PAY_PORTS:
        raise RuntimeError(
            f"{'/'.join(tripped)}=1 仅允许 dev 端口 {sorted(config.DEV_FAKE_PAY_PORTS)}"
            f"（当前 {port}）——生产进程严禁免验签假支付/假回执，拒绝启动"
        )


# ── POST /api/v1/auth/login（P0-1；T-P0-04）──────────────────────────
class LoginIn(BaseModel):
    code: str


@app.post("/api/v1/auth/login")
def login(body: LoginIn):
    """code→openid→Bearer token（链路②-1）。

    XY_DEV_LOGIN=1 双闸（默认关，仅自动化测试进程开）：code 直映射 dev openid，
    不外呼微信。session_key 仅服务端留存（users.session_key，绝不下发）；
    pay_configured 供前端预判支付灰置（API_DESIGN P0-1）。
    """
    if os.environ.get("XY_DEV_LOGIN") == "1":
        openid = "dev-" + body.code
        user = store.get_or_create_user(openid, wechat.dev_session_key(body.code))
    else:
        try:
            sess = wechat.code2session(body.code)
        except Exception as exc:  # noqa: BLE001
            raise ApiError(502, "WX_LOGIN_FAILED", f"微信登录失败: {exc}") from exc
        user = store.get_or_create_user(sess["openid"], sess.get("session_key") or "")
    return {
        "token": wechat.issue_token(user["openid"]),
        "uid": user["id"],
        "expires_in": 86400 * 30,
        "pay_configured": virtual_pay.pay_configured(),
    }


# ── POST /api/v1/admin/resync（T-P0-01 手动进库触发；Bearer+dev 闸保护）──
@app.post("/api/v1/admin/resync")
def admin_resync(request: Request):
    from . import config

    if os.environ.get("XY_DEV_LOGIN") != "1":  # dev 闸：生产进程本端点禁用
        raise ApiError(403, "ADMIN_DISABLED", "管理端点仅 dev 闸（XY_DEV_LOGIN=1）可用")
    openid = wechat.bearer_openid(request)
    if not openid:
        raise ApiError(401, "UNAUTHORIZED", "未登录或凭证过期")
    stat = store.sync_from_catalog(config.CONTENT_DIR, config.SERVER_CONTENT_DIR)
    stat["off"] = catalog.apply_off_sidecar(config.CONTENT_DIR)
    return {"ok": True, "sync": stat}


@app.get("/health")
def health():
    """公网健康探针（§七）：无鉴权、不泄内部态；与支付配置解耦（恒 200）。"""
    return {"ok": True}
