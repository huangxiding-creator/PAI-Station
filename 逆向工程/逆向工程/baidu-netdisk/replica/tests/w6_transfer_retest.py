#!/usr/bin/env python
# -*- coding: utf-8 -*-
r"""W6 任务二：transfer 复测（1 发写，围栏内）。

W5 诊断结论：/share/transfer 缺 bdstoken → errno 2；携带形态已实装（api.share_transfer
(bdstoken=…)+CLI 贯通+单测）。本件真发 1 次：本账号既有分享 → /API复刻测试_1029/
transfer_in/ → ls 复核落盘。

- 成功 → PROTOCOL 漂移账 #15 转正（share/transfer 活性 A 级）+ README 遗留 #11 改写；
- 失败 → errno+响应原文归档，维持 N/A 结论（不硬闯）。
铁律：/share/transfer POST ≤1；归档前过 scrub_payload（judge #2 新纪律）；产物留围栏。
"""
from __future__ import annotations

import importlib.util
import json
import os
import subprocess
import sys
import time

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8")

from bdncore import BdnApi, BdnError, BdnSession, mask  # noqa: E402

REPLICA = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
BDN_PY = os.path.join(REPLICA, "bdn.py")
ARCHIVE = os.path.join(os.path.dirname(os.path.abspath(__file__)),
                       "_diag_archive", "w6_qa_gate")
TRANSFER_DST = "/API复刻测试_1029/transfer_in"

_spec = importlib.util.spec_from_file_location(
    "diag_scrub", os.path.join(os.path.dirname(os.path.abspath(__file__)),
                               "_diag_archive", "scrub.py"))
scrub = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(scrub)


def dump(name: str, obj) -> str:
    os.makedirs(ARCHIVE, exist_ok=True)
    clean, _n, _h = scrub.scrub_payload(obj)          # 归档清洗（judge #2 纪律）
    p = os.path.join(ARCHIVE, name)
    with open(p, "w", encoding="utf-8") as f:
        json.dump(clean, f, ensure_ascii=False, indent=2, default=str)
    return p


def cli(args, timeout=300):
    t0 = time.perf_counter()
    proc = subprocess.run([sys.executable, BDN_PY] + args + ["--json"],
                          capture_output=True, text=True, encoding="utf-8",
                          cwd=REPLICA, timeout=timeout)
    elapsed = round(time.perf_counter() - t0, 1)
    payload = None
    lines = proc.stdout.splitlines()
    for i in range(len(lines) - 1, -1, -1):
        if lines[i].startswith("{"):
            try:
                payload = json.loads("\n".join(lines[i:]))
            except ValueError:
                payload = None
            break
    return proc.returncode, payload, (proc.stderr or "").strip()[-500:], elapsed


def main() -> int:
    sess = BdnSession()
    api = BdnApi(sess)
    print(f"# 凭据 bduss={mask(sess.bduss)} | 落档 {ARCHIVE}")
    t_all = time.perf_counter()

    # [1] 选本账号既有分享（优先无码文件型；排除 W5 已取消的测试 shareid）
    recs = api.share_records()
    entries = [e for e in recs.get("entries") or []
               if e["shareid"] != 65048642201]
    files_first = [e for e in entries if e.get("typical_path") and "." in
                   e["typical_path"].rsplit("/", 1)[-1]]
    pick = next((e for e in files_first if not e["passwd"]), None) \
        or (files_first or entries or [None])[0]
    dump("transfer_retest_pick.json", {"picked": pick, "total": len(entries)})
    if pick is None:
        print("[1] 分享记录为空 → N/A（无可转存项）")
        return 1
    print(f"[1] 选中 shareid={pick['shareid']} {pick['typical_path']} "
          f"passwd={'有' if pick['passwd'] else '无'}")

    # [2] CLI 真发 1 次（实装携带形态：loginStatus bdstoken → verify → list → transfer）
    rc, tr, err, elapsed = cli(["transfer", pick["shortlink"], TRANSFER_DST])
    errno = (tr or {}).get("errno", "?")
    dump("transfer_retest.json", {"rc": rc, "payload": tr, "stderr": err,
                                  "picked": pick, "elapsed_s": elapsed,
                                  "requests_selfreport":
                                      (tr or {}).get("requests")})
    print(f"[2] transfer errno={errno} rc={rc} {elapsed}s "
          f"自报requests={(tr or {}).get('requests')}"
          + ("" if err == "" else f" err={err}"))

    # [3] ls 复核落盘
    r = api.list_dir(TRANSFER_DST)
    landed = [e["name"] for e in r.get("entries") or []]
    tp_base = (pick.get("typical_path") or "").rsplit("/", 1)[-1]
    hit = any(tp_base in n for n in landed) if tp_base else bool(landed)
    dump("transfer_retest_ls_verify.json", {"landed": landed, "hit": hit})
    print(f"[3] ls 复核 transfer_in: {len(landed)} 项 命中={hit} {landed[:8]}")

    ok = errno == 0 and hit
    verdict = ("成功——PROTOCOL 漂移账 #15 转正（share/transfer 活性 A 级）" if ok
               else "失败——维持 N/A 结论（errno 原文已归档，不硬闯）")
    print(f"# 结论: {verdict}")
    print(f"# 控制面（库会话）: {sess.requests_sent} 发 | 总耗时 "
          f"{time.perf_counter()-t_all:.0f}s")
    return 0 if ok else 1


if __name__ == "__main__":
    try:
        sys.exit(main())
    except BdnError as e:
        print(f"\n# 失败: {e}", file=sys.stderr)
        sys.exit(1)
