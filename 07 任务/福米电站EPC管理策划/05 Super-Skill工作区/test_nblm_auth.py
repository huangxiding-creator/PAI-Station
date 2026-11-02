# -*- coding: utf-8 -*-
"""test_nblm_auth - NBLM 认证面探针 v2: async with 上下文 (notebooklm 0.8.5 形态)."""
import asyncio
import os
import sys

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
os.environ.setdefault("NOTEBOOKLM_TRANSPORT", "curl_cffi")
PX = os.environ.get("NBLM_PROXY", "http://127.0.0.1:7892")
for k in ("http_proxy", "https_proxy", "HTTP_PROXY", "HTTPS_PROXY"):
    os.environ.pop(k, None)
os.environ["HTTP_PROXY"] = PX
os.environ["HTTPS_PROXY"] = PX


async def main() -> int:
    from notebooklm import NotebookLMClient
    try:
        async with await asyncio.wait_for(
                NotebookLMClient.from_storage(timeout=60.0), timeout=90) as c:
            nbs = await asyncio.wait_for(c.notebooks.list(), timeout=60)
            print("AUTH_OK notebooks=%d" % len(nbs))
            return 0
    except Exception as e:                             # noqa: BLE001
        print("AUTH_FAIL %s %s" % (type(e).__name__, str(e)[:110]))
        return 1


raise SystemExit(asyncio.run(main()))
