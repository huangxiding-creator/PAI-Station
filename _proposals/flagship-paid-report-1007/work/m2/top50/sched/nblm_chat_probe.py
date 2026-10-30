# -*- coding: utf-8 -*-
"""nblm_chat_probe - 单发探针: 账号 chat 配额是否解禁 (exit 0=通, 1=仍限)."""
import asyncio
import os
import sys

os.environ.setdefault("NOTEBOOKLM_TRANSPORT", "curl_cffi")
os.environ["HTTP_PROXY"] = os.environ.get("NBLM_PROXY", "http://127.0.0.1:7892")
os.environ["HTTPS_PROXY"] = os.environ["HTTP_PROXY"]


async def main() -> int:
    from notebooklm import NotebookLMClient
    async with await NotebookLMClient.from_storage(timeout=45.0) as client:
        r = await client.chat.ask(
            "727da5d8-d25b-4645-8903-292e6b8bd987", "只回复两个字：收到")
        print("CHAT OK:", (r.answer or "")[:20])
        return 0


try:
    raise SystemExit(asyncio.run(main()))
except Exception as e:  # noqa: BLE001
    print("CHAT BLOCKED:", type(e).__name__, str(e)[:90])
    raise SystemExit(1)
