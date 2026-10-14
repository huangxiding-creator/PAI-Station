# -*- coding: utf-8 -*-
"""callback-service：企微回调接收（FastAPI）。

P0 仅做 echostr 验证与事件落库（欢迎语/客户联系 P1 启用）。
经 frp/cloudflared 隧道映射到公网域名（该域名同时配置为可信域名）。
"""
from __future__ import annotations

import json
import logging
import xml.etree.ElementTree as ET

from fastapi import FastAPI, Request, Response

from .crypto import WeComCrypto

log = logging.getLogger("zbops.callback")
app = FastAPI()

_crypto: WeComCrypto | None = None
_event_bus = None   # async callable(event_type, xml_dict)


def init(crypto: WeComCrypto, event_bus=None):
    global _crypto, _event_bus
    _crypto = crypto
    _event_bus = event_bus


@app.get("/wecom/callback/{agent_key}")
async def verify_url(agent_key: str, msg_signature: str = "",
                     timestamp: str = "", nonce: str = "", echostr: str = ""):
    try:
        plain = _crypto.verify_echo(msg_signature, timestamp, nonce, echostr)
        return Response(content=plain, media_type="text/plain")
    except Exception as e:  # noqa: BLE001
        log.error("echostr 验证失败: %s", e)
        return Response(content="fail", status_code=403)


@app.post("/wecom/callback/{agent_key}")
async def receive(agent_key: str, request: Request,
                  msg_signature: str = "", timestamp: str = "", nonce: str = ""):
    body = await request.body()
    try:
        encrypt = ET.fromstring(body).findtext("Encrypt") or ""
        if not _crypto.verify(msg_signature, timestamp, nonce, encrypt):
            return Response(content="fail", status_code=403)
        xml_text = _crypto.decrypt(encrypt)
        root = ET.fromstring(xml_text)
        event = {c.tag: (c.text or "") for c in root}
        log.info("回调事件: %s", json.dumps(event, ensure_ascii=False)[:300])
        if _event_bus:
            await _event_bus(event.get("Event", event.get("MsgType", "")), event)
        return Response(content="success", media_type="text/plain")
    except Exception as e:  # noqa: BLE001
        log.exception("回调处理失败: %s", e)
        return Response(content="fail", status_code=500)
