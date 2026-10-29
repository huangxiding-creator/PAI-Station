# -*- coding: utf-8 -*-
"""配额窗自动贯通件：探测→绿窗即跑 5 会话验收（无人值守）。

用法（后台长跑）：py -3 -I work/accept_when_green.py [--gap-min 75] [--max-probes 8]
每次探测 1 发 newSearchApi（配额红窗时空响应零消耗——限流已耗尽，空发不增计数，
保守口径：探测间隔 ≥75min 防滑动窗自扰）；绿窗（docs>0）→ 立即
`accept_5sessions.py`（幂等，已过会话跳过）→ 汇总行 stdout 落账。
"""
import argparse
import json
import subprocess
import sys
import time
from pathlib import Path

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE.parent / "replica"))
from book118_api import Book118Client, SearchQuota  # noqa: E402

CAP = HERE.parent / "captures"
LOG = CAP / "quota_watch.jsonl"


def log(row: dict) -> None:
    with LOG.open("a", encoding="utf-8") as fh:
        fh.write(json.dumps(row, ensure_ascii=False) + "\n")


def probe() -> int:
    c = Book118Client()
    try:
        hits = c.search("国际工程EPC", 1, max_pages=1)
        return len(hits)
    except SearchQuota as e:
        log({"ts": time.strftime("%Y-%m-%d %H:%M:%S"), "state": "quota",
             "detail": e.detail[:80]})
        return 0


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--gap-min", type=float, default=75.0)
    ap.add_argument("--max-probes", type=int, default=8)
    args = ap.parse_args()
    for i in range(1, args.max_probes + 1):
        n = probe()
        print(f"[watch {time.strftime('%H:%M:%S')}] probe#{i} docs={n}", flush=True)
        if n > 0:
            print(f"[watch] GREEN window → running acceptance", flush=True)
            r = subprocess.run(
                [sys.executable, "-I", str(HERE / "accept_5sessions.py")],
                cwd=str(HERE), capture_output=True, text=True,
                encoding="utf-8", errors="replace")
            print(r.stdout[-3000:], flush=True)
            if r.returncode != 0:
                print(f"[watch] accept exit={r.returncode}\n{r.stderr[-800:]}",
                      flush=True)
                return r.returncode
            return 0
        if i < args.max_probes:
            time.sleep(args.gap_min * 60)
    print("[watch] probes exhausted, still quota — leave ledger to next window",
          flush=True)
    return 3


if __name__ == "__main__":
    raise SystemExit(main())
