# -*- coding: utf-8 -*-
r"""8440 服务入口（T-075/REQ-005.AC2）：FastAPI POST /enqueue + API Key 鉴权。

设计注（队列归属）：生产进程=main.py callback 与 monitor 同进程拉起共享单例；
安全网四约束（日3/全局20/冷却/熔断）在 auto_responder.enqueue 内部生效（T-076 补测）。
军团自启（部署时注册，schtasks）：schtasks /Create /TN RE-Callback8440 /SC ONSTART
  /TR "py -I E:\AI-Station\私域运营\zbops\main.py callback"
"""
from __future__ import annotations

import os

from fastapi import FastAPI, Header, HTTPException
from pydantic import BaseModel

from .auto_responder import responder

app = FastAPI(title="revenue-engine enqueue", version="0.1")
_BAD_KEYS = {"n": 0}  # 连续 401 计数；≥10 触发告警标记


class EnqueueBody(BaseModel):
    group: str
    text: str
    priority: int = 3
    dedup_key: str | None = None
    source: str = "manual"


def _check_key(key: str | None) -> None:
    want = os.environ.get("RE_ENQUEUE_KEY", "")
    if not want or key != want:
        _BAD_KEYS["n"] += 1
        if _BAD_KEYS["n"] >= 10:
            from . import audit_log
            audit_log.record("8440", "__auth_bruteforce__", f"bad key x{_BAD_KEYS['n']}")
        raise HTTPException(status_code=401, detail="bad key")


@app.post("/enqueue")
def enqueue(body: EnqueueBody, x_api_key: str | None = Header(None)):
    _check_key(x_api_key)
    _BAD_KEYS["n"] = 0
    ok = responder.enqueue(body.group, body.text, priority=body.priority)
    return {"queued": bool(ok), "position": len(responder.queue) if ok else None}
