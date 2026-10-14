# -*- coding: utf-8 -*-
"""aibot-gateway：企业微信智能机器人 WebSocket 长连接网关（aiohttp 版）。

用 aiohttp 替代 websockets 库——对非标 WS 帧更宽容（绕过 Clash TUN 帧篡改）。
协议（源码核实自 cywzzk/wecom-aibot-go-sdk）：
  连接 → cmd=aibot_subscribe{bot_id,secret} → 心跳 cmd=ping → 收发消息
"""
from __future__ import annotations

import asyncio
import json
import logging
import time
import uuid

import aiohttp

log = logging.getLogger("zbops.aibot")

WS_URL = "wss://openws.work.weixin.qq.com"
HEARTBEAT_SEC = 30


def _req_id(prefix: str) -> str:
    return f"{prefix}_{int(time.time()*1000)}_{uuid.uuid4().hex[:8]}"


class AiBotGateway:
    """长连接网关：认证→收消息→商机雷达→AI生成→流式回复。"""

    def __init__(self, bot_id: str, secret: str, ai_pipeline, guardian,
                 radar=None):
        self.bot_id = bot_id
        self.secret = secret
        self.ai = ai_pipeline
        self.guardian = guardian
        self.radar = radar   # RadarMiddleware 实例（可选）
        self._seen: set[str] = set()

    async def run(self) -> None:
        backoff = 1
        while True:
            try:
                await self._session()
                backoff = 1
            except asyncio.CancelledError:
                raise
            except Exception as e:  # noqa: BLE001
                log.error("aibot 会话异常: %s，%ss 后重连", e, backoff)
                await asyncio.sleep(backoff)
                backoff = min(backoff * 2, 60)

    async def _send(self, ws, frame: dict):
        await ws.send_str(json.dumps(frame, ensure_ascii=False))

    async def _recv(self, ws, timeout: float = 15) -> dict:
        msg = await asyncio.wait_for(ws.receive(), timeout)
        if msg.type == aiohttp.WSMsgType.TEXT:
            return json.loads(msg.data)
        if msg.type == aiohttp.WSMsgType.CLOSED:
            raise ConnectionError("连接已关闭")
        return {}

    async def _session(self) -> None:
        # 用 aiohttp——不走 Clash TUN 的帧重写
        async with aiohttp.ClientSession() as session:
            async with session.ws_connect(
                    WS_URL,
                    max_msg_size=10 * 1024 * 1024,
                    heartbeat=None,          # 禁用内置心跳
                    autoping=False,           # 禁用自动 ping/pong
                    compress=0,              # 禁用压缩
            ) as ws:
                # ── 鉴权 ──
                await self._send(ws, {
                    "cmd": "aibot_subscribe",
                    "headers": {"req_id": _req_id("aibot_subscribe")},
                    "body": {"bot_id": self.bot_id, "secret": self.secret},
                })
                auth_rsp = await self._recv(ws, 15)
                if auth_rsp.get("errcode"):
                    raise RuntimeError(f"认证失败: {auth_rsp.get('errmsg')}")
                log.info("智能机器人认证成功，长连接已建立")

                # ── 协议级心跳 ──
                async def heartbeat():
                    while True:
                        await asyncio.sleep(HEARTBEAT_SEC)
                        await self._send(ws, {
                            "cmd": "ping",
                            "headers": {"req_id": _req_id("ping")},
                        })
                hb = asyncio.create_task(heartbeat())

                try:
                    async for msg in ws:
                        if msg.type == aiohttp.WSMsgType.TEXT:
                            frame = json.loads(msg.data)
                            await self._dispatch(ws, frame)
                        elif msg.type in (aiohttp.WSMsgType.CLOSED,
                                          aiohttp.WSMsgType.ERROR):
                            raise ConnectionError(f"WS 关闭: {msg.type}")
                finally:
                    hb.cancel()

    # ── 分发 ──
    async def _dispatch(self, ws, frame: dict) -> None:
        cmd = frame.get("cmd", "")
        headers = frame.get("headers", {})
        body = frame.get("body", {})
        if cmd == "aibot_msg_callback":
            await self._on_msg(ws, headers, body)
        elif cmd == "aibot_event_callback":
            etype = body.get("event_type", "")
            if etype == "disconnected_event":
                log.warning("被新连接踢下线")
            else:
                log.info("事件: %s", etype)
        elif cmd == "pong":
            pass
        else:
            log.debug("帧: cmd=%s errcode=%s", cmd, frame.get("errcode"))

    # ── 消息处理 ──
    async def _on_msg(self, ws, headers: dict, body: dict) -> None:
        msg_id = headers.get("msg_id", "")
        if msg_id in self._seen:
            return
        self._seen.add(msg_id)

        chat_id = headers.get("chat_id", "")
        from_id = body.get("from", {}).get("userid", "")
        chat_type = body.get("chattype", "single")
        text = (body.get("text") or {}).get("content", "").strip()
        if not text:
            return

        log.info("收到 [%s] chat=%s from=%s text=%r", chat_type, chat_id,
                 from_id[:8], text[:80])

        # ── 商机雷达中间件 ──
        if self.radar:
            result = await self.radar.process(text, from_id, chat_id)
            action = result.get("action", "ignore")

            if action == "reply":
                # 雷达已生成回复（如求助信号的 AI 答疑）
                reply = result["reply_text"]
                await self._send_reply(ws, headers, reply)
                self._log_opportunities(result.get("opportunities", []))
                return

            if action == "alert":
                # 高价值商机 → 推送给主理人 + 群内简短回应
                alert = result["alert"]
                log.info("商机告警: %s", alert.get("title", ""))
                reply = (f"这个问题很有价值。{alert.get('recommendation', '')}"
                        f" 我整理了相关资料，稍后分享到群里。")
                await self._send_reply(ws, headers, reply)
                self._log_opportunities(result.get("opportunities", []))
                return

            # log_only 或 ignore：不回复，只记台账
            if result.get("opportunities"):
                self._log_opportunities(result["opportunities"])
                return  # 信号已处理，不再走默认 AI 回复

        # ── 文章检测：URL → 自动总结 ──
        from ..radar.article import extract_urls, is_wechat_article, fetch_article, summarize_article
        urls = extract_urls(text)
        wechat_urls = [u for u in urls if is_wechat_article(u)]
        if wechat_urls and self.ai:
            article = await fetch_article(wechat_urls[0])
            if article.get("body"):
                summary = await summarize_article(article, self.ai)
                if summary:
                    await self._send_reply(ws, headers, summary)
                    return

        # ── 默认：直接 AI 生成（流式）──
        stream_id = uuid.uuid4().hex[:16]
        full_reply = ""
        try:
            async for chunk in self.ai.answer(text, {
                "chat_id": chat_id, "sender": from_id, "chat_type": chat_type,
            }):
                p = self.guardian.permit("wecom_aibot", chat_id, "reply", chunk)
                if not p.ok:
                    log.warning("护栏拒绝: %s", p.reason)
                    await self._reply_text(ws, headers,
                                           "抱歉，这条回复未能通过内容审核")
                    return
                full_reply += chunk
                await self._reply_stream(ws, headers, stream_id, chunk,
                                         finish=False)
            if full_reply:
                await self._reply_stream(ws, headers, stream_id, full_reply,
                                         finish=True)
        except Exception as e:  # noqa: BLE001
            log.exception("处理消息失败: %s", e)
            await self._reply_text(ws, headers, f"处理出错: {e}")

    def _log_opportunities(self, opportunities: list):
        """记录检测到的商机。"""
        for opp in opportunities:
            log.info("[商机] %s | %s | 评分%.0f | %s",
                     opp.priority, opp.signal.type.value,
                     opp.score, opp.reason)

    async def _send_reply(self, ws, headers: dict, text: str):
        """非流式直接回复。"""
        await self._reply_text(ws, headers, text)

    # ── 回复原语 ──
    async def _reply_stream(self, ws, origin_headers, stream_id, content,
                            finish: bool) -> None:
        frame = {
            "cmd": "aibot_respond_msg",
            "headers": {
                "req_id": _req_id("aibot_respond_msg"),
                "chat_id": origin_headers.get("chat_id", ""),
                "msg_id": origin_headers.get("msg_id", ""),
            },
            "body": {
                "msgtype": "stream",
                "stream": {"id": stream_id, "finish": finish,
                           "content": content},
            },
        }
        await self._send(ws, frame)

    async def _reply_text(self, ws, origin_headers, content: str) -> None:
        frame = {
            "cmd": "aibot_respond_msg",
            "headers": {
                "req_id": _req_id("aibot_respond_msg"),
                "chat_id": origin_headers.get("chat_id", ""),
                "msg_id": origin_headers.get("msg_id", ""),
            },
            "body": {"msgtype": "text", "text": {"content": content}},
        }
        await self._send(ws, frame)
