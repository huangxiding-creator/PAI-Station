# -*- coding: utf-8 -*-
"""军团 v3 全账号名册生成器 — 2026-10-10 用户令「Manus 军团有很多账号, 要全部用起来」.

把小队试点 (10 号) 扩为全账号名册. 纪律不变 (v3 安全章程全保留):
  独立 profile/端口, 单号日 1 单, 串行+随机间隔, 停用文案全队停,
  2 次登录失败冷冻 7 天, 美东 23-07 窗口铁律 (corps_v3.py 硬闸).

入册口径 (明细 TSV 260922):
  tier1 = 已完成 (验证能用) + 实证存活 4 号置顶
  tier2 = 暂停 (0928 保守暂停, 未判死 — 熔断线兜底)
  tier3 = 无标识/未标注 (从未验证, 排队探活; 失败即冷冻出队)
永不入册: 停止 (0928 风控阵亡批次) / 作废 / 人工干预 (须人工过码, 另册) /
  51817@qq.com (主账号红线) / @midkk.uk (摸底负债号域).

排序内层键 = 近 4 日派单数升序 (低姿态画像优先).

用法: pythonw/python corps_v3_roster.py [--dry]   (幂等, 重跑即刷新)
"""
import argparse
import json
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
ROOT = Path(__file__).parent
TSV = ROOT / "Manus账号（全部）260922_明细.tsv"
SQUAD_FILE = ROOT / "data" / "corps_v3_squad.json"
V3_LOG = ROOT / "data" / "epc50_corps_log.jsonl"
VERIFIED_ALIVE = [                      # 0928 摸底实证存活 (置顶)
    "5nemn9mj0t@hema.edu.kg",
    "xwd8lu0drf@manus.edu.kg",
    "t2nkj09o92@manus.edu.kg",
    "sl1vme8uez@manus.edu.kg",
]
HARD_EXCLUDE = ("51817@qq.com",)        # 主账号永不入队
DOMAIN_EXCLUDE = ("@midkk.uk",)         # 摸底负债号域
TIER1 = ("已完成",)
TIER2 = ("暂停",)
TIER3 = ("无标识", "未标注")


def recent_usage() -> dict:
    usage = {}
    try:
        for ln in V3_LOG.read_text(encoding="utf-8").splitlines():
            if not ln.strip():
                continue
            try:
                r = json.loads(ln)
            except Exception:
                continue
            if r.get("ts", "") >= "2026-09-24":
                usage[r["email"]] = usage.get(r["email"], 0) + 1
    except FileNotFoundError:
        pass
    return usage


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--dry", action="store_true", help="只打印不写盘")
    args = ap.parse_args()

    tiers = {1: [], 2: [], 3: []}
    seen = set()
    for ln in TSV.read_text(encoding="utf-8").splitlines()[1:]:
        parts = ln.split("|")
        if len(parts) < 3:
            continue
        email, _pwd, status = parts[0].strip(), parts[1], parts[2].strip()
        if email in seen or email in HARD_EXCLUDE:
            continue
        if any(email.endswith(d) for d in DOMAIN_EXCLUDE):
            continue
        if status in TIER1:
            tiers[1].append(email)
        elif status in TIER2:
            tiers[2].append(email)
        elif status in TIER3:
            tiers[3].append(email)
        if status in TIER1 + TIER2 + TIER3:
            seen.add(email)

    usage = recent_usage()
    for t in (1, 2, 3):
        tiers[t].sort(key=lambda e: (usage.get(e, 0), e))

    head = [e for e in VERIFIED_ALIVE if e in seen]
    t1 = [e for e in tiers[1] if e not in head]
    t2, t3 = tiers[2], tiers[3]
    squad = head + t1 + t2 + t3

    out = {
        "generated": time.strftime("%Y-%m-%dT%H:%M:%S"),
        "rule": ("1010 用户令全账号上阵: 实证存活4号置顶+已完成"
                 "+暂停+未验证殿后; 停止/作废/人工干预/主账号永不入册; "
                 "美东23-07窗口铁律+单号日1单不变"),
        "verified_alive": head,
        "tiers": {"tier1_已完成": len(t1) + len(head),
                  "tier2_暂停": len(t2), "tier3_未验证": len(t3)},
        "squad": squad,
    }
    print(f"名册: {len(squad)} 号 = 置顶{len(head)} + 一档{len(t1)} "
          f"+ 二档{len(t2)} + 三档{len(t3)}")
    print(f"  头 6: {squad[:6]}")
    print(f"  尾 3: {squad[-3:]}")
    if args.dry:
        print("(dry, 未写盘)")
        return 0
    tmp = SQUAD_FILE.with_suffix(".tmp")
    tmp.write_text(json.dumps(out, ensure_ascii=False, indent=1),
                   encoding="utf-8")
    tmp.replace(SQUAD_FILE)
    print(f"✓ 已写 {SQUAD_FILE.name} (旧 10 号小队名册被替换, "
          f"账号口径见 tiers)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
