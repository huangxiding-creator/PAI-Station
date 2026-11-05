# -*- coding: utf-8 -*-
"""ess_nb_free_slots - 1105 用户批准令 A 方案执行件: 删 21 本腾位 (废屑8+SCHED工期13).
批准依据: nb_delete_candidates_1105.md + 会话明示批准 (清理铁律).
只删清单内 ID; 逐本打印; 末尾复核总数.
用法: py -3 -X utf8 ess_nb_free_slots.py
"""
from __future__ import annotations

import asyncio
import json
import os
import sys
from pathlib import Path

os.environ.setdefault("NOTEBOOKLM_TRANSPORT", "curl_cffi")
PX = os.environ.get("NBLM_PROXY", "http://127.0.0.1:7895")
for _k in ("http_proxy", "https_proxy", "HTTP_PROXY", "HTTPS_PROXY"):
    os.environ.pop(_k, None)
os.environ["HTTP_PROXY"] = PX
os.environ["HTTPS_PROXY"] = PX

DEBRIS = [  # 第一梯队: 纯废屑 8 本 (无 state 引用, 有活孪生)
    "67e3b595-fa3f-49a2-bc42-2d78c298227e",
    "3b227b9b-9217-4178-ad3d-e751ddd7dac5",
    "f453bbd3-c272-4ea7-a24b-2f023b414b82",
    "cbdb4d19-bf42-4f58-a15c-c08491d89a82",
    "42efafa1-fdee-4dcd-a8308-e21e48fdb0ce",
    "800c04ba-78b2-4807-989a-a2a3bfd1f581",
    "6c49504d-38cd-44bc-9487-411b1e379ed4",
    "afb5c8d3-9c7e-4a94-ac0a-1670d6869665",
]
SCHED_STATE = Path(r"E:\AI-Station\_proposals\flagship-paid-report-1007"
                   r"\work\m2\sched\nblm_state.json")


async def main() -> int:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    sched_ids = list(json.loads(
        SCHED_STATE.read_text(encoding="utf-8"))["notebooks"].values())
    targets = DEBRIS + sched_ids
    print(f"[plan] 删除目标 {len(targets)} 本 = 废屑{len(DEBRIS)} + SCHED{len(sched_ids)}")
    from notebooklm import NotebookLMClient
    async with await NotebookLMClient.from_storage(
        timeout=120.0, keepalive=60.0) as client:
        nbs = await client.notebooks.list()
        by_id = {n.id: str(getattr(n, "title", "")) for n in nbs}
        print(f"[now] 删前总数 {len(nbs)}")
        ok = fail = miss = 0
        for i, nid in enumerate(targets, 1):
            title = by_id.get(nid, "(不在账!)")
            if nid not in by_id:
                miss += 1
                print(f"[{i}/{len(targets)}] MISS {nid[:8]} {title}")
                continue
            try:
                await client.notebooks.delete(nid)
                ok += 1
                print(f"[{i}/{len(targets)}] DEL  {nid[:8]} {title[:44]}")
            except Exception as e:  # noqa: BLE001
                fail += 1
                print(f"[{i}/{len(targets)}] FAIL {nid[:8]} {title[:36]} "
                      f"| {type(e).__name__}: {str(e)[:60]}")
        final = await client.notebooks.list()
        print(f"[done] 成功{ok} 失败{fail} 不在账{miss} | 删后总数 {len(final)} "
              f"(预期 79)")
    return 0 if (fail == 0 and len(final) == 79) else 1


if __name__ == "__main__":
    raise SystemExit(asyncio.run(main()))
