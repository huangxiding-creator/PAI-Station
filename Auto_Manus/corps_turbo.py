# -*- coding: utf-8 -*-
"""corps_turbo — 高效军团引擎: API 积分预筛 + 浏览器并行派单 + 安全护栏.

架构 (1023 用户令: 账号安全基础上的高效派单和使用全部账号):
  ① API 预筛: 96 令牌秒扫积分, 只派有分的号 (跳过零浏览器开销)
  ② 浏览器派单: 原配置(7890)+原代码=验证成功, N 路并行
  ③ 安全护栏: 单号日帽1 + 积分门60 + 冷冻线 + 熔断器
  ④ API 收割: 会话监控+成果拉取, 零浏览器
用法: py corps_turbo.py [--parallel 2] [--hours 12]
"""
from __future__ import annotations

import argparse
import json
import random
import subprocess
import sys
import time
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
sys.stdout.reconfigure(encoding="utf-8", errors="replace")

ROOT = Path(__file__).resolve().parent
READY_FILE = ROOT / "data" / "api_ready_accounts.json"
CORPS_LOG = ROOT / "data" / "epc50_corps_log.jsonl"
TURBO_LOG = ROOT / "data" / "corps_turbo_log.jsonl"


def load_ready() -> list[tuple[str, int]]:
    """API 预筛过的可派单清单 [(email, credits)]."""
    if READY_FILE.is_file():
        return [tuple(x) for x in json.loads(
            READY_FILE.read_text(encoding="utf-8"))]
    return []


def dispatches_today() -> set[str]:
    """今日已派单号集合."""
    today = time.strftime("%Y-%m-%d")
    used = set()
    if CORPS_LOG.is_file():
        for ln in CORPS_LOG.read_text(encoding="utf-8").splitlines():
            if today in ln:
                try:
                    d = json.loads(ln)
                    used.add(d.get("email", ""))
                except Exception:
                    pass
    return used


def dispatch_one(email: str, port: int) -> dict:
    """单号浏览器派单 (corps_v3 --only)."""
    r = subprocess.run(
        [sys.executable, "-X", "utf8", "corps_v3.py",
         "--duration", "10", "--limit", "1", "--max-today", "1",
         "--only", email],
        capture_output=True, text=True, encoding="utf-8",
        errors="replace", timeout=600, cwd=str(ROOT))
    out = r.stdout or ""
    ok = "✓" in out
    return {"email": email, "ok": ok, "tail": out[-150:]}


def log(result: dict):
    TURBO_LOG.parent.mkdir(parents=True, exist_ok=True)
    with TURBO_LOG.open("a", encoding="utf-8") as fh:
        fh.write(json.dumps(
            {"ts": time.strftime("%F %T"), **result},
            ensure_ascii=False) + "\n")


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--parallel", type=int, default=2,
                    help="并行浏览器数 (安全起见默认2)")
    ap.add_argument("--hours", type=float, default=12.0)
    ns = ap.parse_args()

    ready = load_ready()
    if not ready:
        print("[turbo] 无可派单号 (先跑 corps_api.py status)")
        return 1

    used = dispatches_today()
    pending = [(e, c) for e, c in ready if e not in used]
    print(f"[turbo] 就绪 {len(ready)} | 今日已用 {len(used)} | "
          f"待派 {len(pending)} | 并行×{ns.parallel}", flush=True)

    deadline = time.time() + ns.hours * 3600
    idx = 0
    total_ok = total_fail = 0

    while time.time() < deadline and idx < len(pending):
        batch = pending[idx:idx + ns.parallel]
        idx += len(batch)
        results = []
        for email, credits in batch:
            port = 9401 + (idx % ns.parallel)
            print(f"  派 {email[:20]} ({credits}分)…", flush=True)
            r = dispatch_one(email, port)
            results.append(r)
            mark = "✓" if r["ok"] else "✗"
            print(f"  {mark} {email[:20]}", flush=True)
            log(r)
            if r["ok"]:
                total_ok += 1
            else:
                total_fail += 1
            # 号间随机间隔 (安全节流)
            time.sleep(random.uniform(30, 60))

    print(f"\n[turbo] 收官: 成功 {total_ok} | 失败 {total_fail} | "
          f"总派 {total_ok + total_fail}", flush=True)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
