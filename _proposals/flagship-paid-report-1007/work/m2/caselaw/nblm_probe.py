# -*- coding: utf-8 -*-
"""nblm_probe - NBLM 账户 chat 通道最小探针 (只读, 1 ask).

区分: 上传/列本通=RPC 正常, chat 全拒=账户级节流/边缘拒 (1031 21:24 实测).
用法: py -X utf8 nblm_probe.py   → exit 0=chat通, 1=仍拒, 2=连接/认证失败
"""
from __future__ import annotations

import asyncio
import os
import sys

os.environ.setdefault("NOTEBOOKLM_TRANSPORT", "curl_cffi")
PX = os.environ.get("NBLM_PROXY", "http://127.0.0.1:7892")
for _k in ("http_proxy", "https_proxy", "HTTP_PROXY", "HTTPS_PROXY"):
    os.environ.pop(_k, None)
os.environ["HTTP_PROXY"] = PX
os.environ["HTTPS_PROXY"] = PX


async def main() -> int:
    from notebooklm import NotebookLMClient
    try:
        async with await NotebookLMClient.from_storage(timeout=120.0) as c:
            nbs = await c.notebooks.list()
            target = next((n.id for n in nbs
                           if "CASELAW-第12份-00" in str(getattr(n, "title", ""))),
                          None)
            if not target:
                print("[probe] 无既有笔记本可探 — exit 2")
                return 2
            try:
                r = await c.chat.ask(target, "只回答两个字：正常")
                print("[probe] CHAT_OK:", (r.answer or "")[:40])
                return 0
            except Exception as e:  # noqa: BLE001
                print("[probe] CHAT_BLOCKED:", type(e).__name__, str(e)[:100])
                return 1
    except Exception as e:  # noqa: BLE001
        print("[probe] CONN_FAIL:", type(e).__name__, str(e)[:100])
        return 2


if __name__ == "__main__":
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    raise SystemExit(asyncio.run(main()))
