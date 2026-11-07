# -*- coding: utf-8 -*-
"""nb_lifecycle — NBLM战役笔记本生命周期执行件 (1108用户常令: 成书后台账即删).

权限源: 用户AskUserQuestion明示「成书后台账后即删」(清理铁律的常令化).
范围铁闸: 只删 nblm_state.json 在账的战役本(框架+章本); 用户自有知识库/他战役在役本绝不碰.
台账: m2/<slug>/nb_lifecycle_ledger.jsonl (只追加: 本ID/题/源数/成书sha/删除ts).
用法: py -X utf8 nb_lifecycle.py --battle m2/ess [--dry-run]
"""
from __future__ import annotations

import argparse
import asyncio
import json
import os
import sys
import time
from pathlib import Path

os.environ.setdefault("NOTEBOOKLM_TRANSPORT", "curl_cffi")
PX = os.environ.get("NBLM_PROXY", "http://127.0.0.1:7895")
for _k in ("http_proxy", "https_proxy", "HTTP_PROXY", "HTTPS_PROXY"):
    os.environ.pop(_k, None)
os.environ["HTTP_PROXY"] = PX
os.environ["HTTPS_PROXY"] = PX

REPO = Path(r"E:\AI-Station")


async def main() -> int:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    ap = argparse.ArgumentParser()
    ap.add_argument("--battle", required=True, help="如 m2/ess")
    ap.add_argument("--dry-run", action="store_true")
    ns = ap.parse_args()
    bdir = REPO / "_proposals" / "flagship-paid-report-1007" / "work" / ns.battle
    state_p = bdir / "sched" / "nblm_state.json"
    if not state_p.is_file():
        print(f"[!] 无 nblm_state.json: {state_p}")
        return 1
    st = json.loads(state_p.read_text(encoding="utf-8"))
    nbs = st.get("notebooks", {})
    if not nbs:
        print("[skip] 无在账笔记本")
        return 0
    man_p = bdir / "sched" / "out" / "s3_run_manifest.json"
    sha = ""
    if man_p.is_file():
        sha = json.loads(man_p.read_text(encoding="utf-8")).get("merge", {}).get("sha256_16", "")
    print(f"[battle] {ns.battle} 在账 {len(nbs)} 本 | 成书sha16={sha or 'N/A'}")
    from notebooklm import NotebookLMClient
    async with await NotebookLMClient.from_storage(timeout=120.0, keepalive=60.0) as client:
        live = {n.id: str(getattr(n, "title", "")) for n in await client.notebooks.list()}
        ledger_p = bdir / "nb_lifecycle_ledger.jsonl"
        ok = miss = 0
        for key, nid in nbs.items():
            title = live.get(nid, "(不在账)")
            rec = {"ts": time.strftime("%F %T"), "key": key, "id": nid,
                   "title": title, "book_sha16": sha, "action": ""}
            if nid not in live:
                miss += 1
                rec["action"] = "already-gone"
                print(f"[miss] {key} {title[:40]}")
            elif ns.dry_run:
                rec["action"] = "dry-run-keep"
                print(f"[dry] {key} {title[:40]}")
            else:
                try:
                    await client.notebooks.delete(nid)
                    ok += 1
                    rec["action"] = "deleted"
                    print(f"[del] {key} {title[:40]}")
                except Exception as e:  # noqa: BLE001
                    rec["action"] = f"FAIL {type(e).__name__}: {str(e)[:60]}"
                    print(f"[FAIL] {key} {str(e)[:60]}")
            with open(ledger_p, "a", encoding="utf-8") as f:
                f.write(json.dumps(rec, ensure_ascii=False) + "\n")
        after = len(await client.notebooks.list())
        print(f"[done] 删{ok} 已不在{miss} | 台账→{ledger_p.name} | 删后账号总数={after}")
    return 0


if __name__ == "__main__":
    raise SystemExit(asyncio.run(main()))
