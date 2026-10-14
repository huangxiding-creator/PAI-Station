# -*- coding: utf-8 -*-
r"""8440 服务入口（T-075/REQ-005.AC2）：FastAPI POST /enqueue + API Key 鉴权。

设计注（队列归属）：本服务与 monitor 同进程共享 responder 单例；发送循环由
responder.start() 驱动——callback 命令在 RE_CALLBACK_AUTOSTART=1 时经 startup
事件自动拉起（生产部署用），默认关闭以便测试。军团自启注册脚本：
revenue-engine/deploy/register_callback_task.ps1（部署时执行一次）。
"""
from __future__ import annotations

import os
import threading

from fastapi import FastAPI, Header, HTTPException
from fastapi.responses import JSONResponse
from pydantic import BaseModel

from .auto_responder import responder

app = FastAPI(title="revenue-engine enqueue", version="0.2")
_LOCK = threading.Lock()
_BAD = {"n": 0}  # 连续 401 计数；恰在第 10 次落一次告警标记


class EnqueueBody(BaseModel):
    group: str
    text: str
    priority: int = 3          # 1=问答 2=推荐 3=推送（预算裁决序）
    dedup_key: str | None = None
    source: str = "manual"


def _check_key(key: str | None) -> None:
    want = os.environ.get("RE_ENQUEUE_KEY", "")
    with _LOCK:
        bad = not want or key != want
        if not bad:
            _BAD["n"] = 0
            return
        _BAD["n"] += 1
        hit = _BAD["n"] == 10  # 只在过阈那一刻记一次
    if hit:
        from . import audit_log
        audit_log.record("auth", "__auth_bruteforce__", "10 consecutive 401")
    raise HTTPException(status_code=401, detail="bad key")


@app.post("/enqueue")
def enqueue(body: EnqueueBody, x_api_key: str | None = Header(None)):
    _check_key(x_api_key)
    ok = responder.enqueue(body.group, body.text, priority=body.priority,
                           dedup_key=body.dedup_key, source=body.source)
    return JSONResponse(status_code=202 if ok else 429, content={
        "queued": bool(ok),
        "position": len(responder.queue) if ok else None})


@app.on_event("startup")
async def _autostart_responder():
    if os.environ.get("RE_CALLBACK_AUTOSTART") == "1":
        import asyncio
        asyncio.get_event_loop().create_task(responder.start())
