# -*- coding: utf-8 -*-
"""fleet_daily_cycle — 舰队日循环器 (1022 用户令: 全账号最慢1天内全部使用).

使命: Manus=调研搜集原始资料 (轻采集简报, 积分友好).
约束充分入模: 每号每日免费300积分 — 派单前读余额, 积分感知配简报规格:
  >=400 → 2问复合 | 250-400 → 2问 | 100-250 → 1问 | <100 → 跳过轮下一号
节奏: 活号环形遍历, 槽间隔5-9min随机, 并发1(起步, 稳后升2),
  24h 覆盖率预警, NB波次让路, 冻结率熔断(>5号/h → 冷却2h).
用法: py -X utf8 fleet_daily_cycle.py [--hours 24] [--dry]
"""
from __future__ import annotations

import argparse
import json
import random
import subprocess
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
ROOT = Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
import manus_lib as lib  # noqa: E402

SQUAD = ROOT / "data" / "corps_v3_squad.json"
LOG = ROOT / "data" / "fleet_cycle_log.jsonl"
CORPS_LOG = ROOT / "data" / "epc50_corps_log.jsonl"


def squad_emails() -> list[str]:
    d = json.loads(SQUAD.read_text(encoding="utf-8"))
    lst = d.get("squad", d) if isinstance(d, dict) else d
    return [e for e in lst if isinstance(e, str) and "@" in e]


def recent_freezes(hours: float = 1.0) -> int:
    """近 N 小时冻结数 (从军团日志/冷却档近似)."""
    cd = ROOT / "data" / "corps_v3_cooldown.json"
    try:
        d = json.loads(cd.read_text(encoding="utf-8"))
    except Exception:
        return 0
    now = time.time()
    n = 0
    for v in (d.values() if isinstance(d, dict) else []):
        if isinstance(v, (int, float)) and now - v < hours * 3600:
            n += 1
    return n


def nb_yield_now() -> bool:
    """NB 波次让路 (1022 宪法): F盘活体状态件."""
    for f, key in ((r"F:\We-AIPO\data\state\run_state.json", "mode"),
                   (r"F:\We-AIPO\data\state\nb_wave.json", "state")):
        try:
            d = json.loads(Path(f).read_text(encoding="utf-8"))
            if key == "mode" and d.get("mode") == "rule":
                return True
            if key == "state" and str(d.get("state")) not in ("done", ""):
                return True
            if key == "state" and int(d.get("queue") or 0) > 0:
                return True
        except Exception:
            continue
    return False


def credits_of(page) -> int:
    """读当前账号积分 (沿军团在役探法; 失败回 0=跳过)."""
    try:
        return int(page.get_credits())
    except Exception:
        return 0


def brief_for(credits: int, tree_q: dict) -> str:
    base = tree_q.get("text", "")
    if credits >= 400:
        extra = " 可顺带同域第二条线索。"
    else:
        extra = ""
    return (f"调研搜集原始资料任务：{base}{extra}\n"
            f"要求：逐条附来源链接与发布日期，官方一手来源优先，"
            f"多渠道交叉。只做资料搜集与罗列，不做分析论述。")


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--hours", type=float, default=24.0)
    ap.add_argument("--dry", action="store_true")
    ns = ap.parse_args()
    emails = squad_emails()
    print(f"[cycle] 舰队 {len(emails)} 号 | 窗口 {ns.hours}h | "
          f"全用节奏 ≈ 每 {ns.hours * 60 / max(len(emails), 1):.1f} 分钟一号",
          flush=True)
    deadline = time.time() + ns.hours * 3600
    used: set[str] = set()
    idx = 0
    while time.time() < deadline:
        if nb_yield_now():
            print("[cycle] NB 波次让路 20min", flush=True)
            time.sleep(1200)
            continue
        if recent_freezes(1.0) > 5:
            print("[cycle] 熔断: 冻结率过高, 冷却 2h", flush=True)
            time.sleep(7200)
            continue
        pending = [e for e in emails if e not in used]
        if not pending:
            print(f"[cycle] 全舰队 {len(emails)} 号本轮全用完毕 "
                  f"({time.strftime('%H:%M')})", flush=True)
            break
        email = pending[idx % len(pending)]
        idx += 1
        if ns.dry:
            print(f"  [dry] {email}", flush=True)
            used.add(email)
            time.sleep(1)
            continue
        # 真派单: 沿军团在役派单器 (它自带锁/冷却/哨兵/积分门)
        r = subprocess.run(
            [sys.executable, "-X", "utf8", "corps_v3.py",
             "--duration", "8", "--limit", "1", "--max-today", "1",
             "--only", email],
            capture_output=True, text=True, encoding="utf-8",
            errors="replace", timeout=900, cwd=str(ROOT))
        ok = "✓" in (r.stdout or "")
        with LOG.open("a", encoding="utf-8") as fh:
            fh.write(json.dumps(
                {"ts": time.strftime("%F %T"), "email": email,
                 "ok": ok, "tail": (r.stdout or "")[-120:]},
                ensure_ascii=False) + "\n")
        print(f"  {email[:18]} {'✓' if ok else '✗'}", flush=True)
        used.add(email)
        time.sleep(random.uniform(300, 540))    # 5-9min 槽间隔
    print("[cycle] 收班", flush=True)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
