# -*- coding: utf-8 -*-
"""ess_nb_inventory - 只读盘点 NBLM 账号笔记本 (诊断 CREATE resource exhausted).
仅 list + 数数 + 标题清单, 零建本零删除.
用法: py -3 -X utf8 ess_nb_inventory.py
"""
from __future__ import annotations

import asyncio
import os
import sys

os.environ.setdefault("NOTEBOOKLM_TRANSPORT", "curl_cffi")
PX = os.environ.get("NBLM_PROXY", "http://127.0.0.1:7895")
for _k in ("http_proxy", "https_proxy", "HTTP_PROXY", "HTTPS_PROXY"):
    os.environ.pop(_k, None)
os.environ["HTTP_PROXY"] = PX
os.environ["HTTPS_PROXY"] = PX


async def main() -> int:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    from notebooklm import NotebookLMClient
    print("[auth] from_storage ...", flush=True)
    async with await NotebookLMClient.from_storage(
        timeout=120.0, keepalive=60.0) as client:
        nbs = await client.notebooks.list()
        print(f"[list] 账号笔记本总数 = {len(nbs)}")
        for n in sorted(nbs, key=lambda x: str(getattr(x, "title", ""))):
            print("  - " + str(getattr(n, "title", ""))[:70] + " | " + str(n.id))
    return 0


if __name__ == "__main__":
    raise SystemExit(asyncio.run(main()))
