# -*- coding: utf-8 -*-
"""远征军团调度池 (Expedition Corps pool) — 提案 09-22 批准 MVP 第一件.

用户拍板参数链 (全部硬编码为不可漂移边界):
  - 267 免费账号底座, 每账号 300 积分/日, 北京 08:00 刷新 (积分不过夜)
  - 任务小而具体 (10-60 积分/任务)
  - 每账号每批次最多 2 项任务; 试点期每账号每日 1 批
  - 广度轮换不压榨单账号 (账号是不可再生资源, 健康度 > 积分用满)

数据源: Manus账号（全部）260922_明细.tsv (邮箱|密码|状态|总包组|出现次数)
账本: data/pool/ledger_YYYY-MM-DD.jsonl (每任务一行: 时间/账号/积分/结果)
池态: data/pool/pool_state.json (健康度/轮换指针/摘池名单)

用法:
  python manus_pool.py init                    # 从明细.tsv 建池
  python manus_pool.py plan --tasks 20         # 今日批次分配 (每账号≤2)
  python manus_pool.py record <email> <credits> <ok|fail|ban> [task_id]
  python manus_pool.py status                  # 池态总览
密码纪律: 明细.tsv 只在建池时读一次入池态; 派发方自行读文件, 账本绝不落密码.
"""
from __future__ import annotations

import argparse
import json
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

ROOT = Path(__file__).parent
DETAIL_TSV = ROOT / "Manus账号（全部）260922_明细.tsv"
POOL_DIR = ROOT / "data" / "pool"
STATE = POOL_DIR / "pool_state.json"

# --- 用户拍板硬边界 ---
DAILY_CREDITS = 300          # 免费额度/日/账号 (08:00 刷新)
MAX_TASKS_PER_BATCH = 2      # 每账号每批次最多 2 项 (用户令)
MAX_BATCHES_PER_DAY = 1      # 试点期每日 1 批
TASK_CREDIT_BUDGET = 60      # 单任务积分预算上限 (10-60 区间取顶)
EXCLUDE_STATES = ("作废",)   # 不入池的状态
# 试点爬坡: M1=10 账号 → M2=40 → M3=160 (提案里程碑)
ACTIVE_RAMP = {"M1": 10, "M2": 40, "M3": 160}


def _load_state() -> dict:
    if STATE.is_file():
        return json.loads(STATE.read_text(encoding="utf-8"))
    return {"accounts": {}, "ramp": "M1", "rotation": [], "created": None}


def _save_state(s: dict) -> None:
    POOL_DIR.mkdir(parents=True, exist_ok=True)
    tmp = STATE.with_suffix(".tmp")
    tmp.write_text(json.dumps(s, ensure_ascii=False, indent=1), encoding="utf-8")
    tmp.replace(STATE)


def _ledger_path(day: str | None = None) -> Path:
    day = day or time.strftime("%Y-%m-%d")
    return POOL_DIR / f"ledger_{day}.jsonl"


def _ledger_rows(day: str | None = None) -> list[dict]:
    p = _ledger_path(day)
    if not p.is_file():
        return []
    return [json.loads(x) for x in p.read_text(encoding="utf-8").splitlines() if x.strip()]


def _append_ledger(row: dict) -> None:
    POOL_DIR.mkdir(parents=True, exist_ok=True)
    with _ledger_path().open("a", encoding="utf-8") as f:
        f.write(json.dumps(row, ensure_ascii=False) + "\n")


def init_pool() -> int:
    """从明细.tsv 建池 — 状态感知入池, 密码不进池态."""
    if not DETAIL_TSV.is_file():
        print(f"[pool] 找不到 {DETAIL_TSV.name}", file=sys.stderr)
        return 1
    s = _load_state()
    prev = s.get("accounts", {})
    n = 0
    for line in DETAIL_TSV.read_text(encoding="utf-8").splitlines():
        if line.startswith("#") or not line.strip():
            continue
        parts = line.split("|")
        if len(parts) < 3 or "@" not in parts[0]:
            continue
        email, _pw, status = parts[0].strip(), parts[1], parts[2].strip()
        if status in EXCLUDE_STATES:
            continue
        acct = prev.get(email, {})  # 保留既有健康度/摘池标记
        acct.setdefault("health", 1.0)
        acct.setdefault("banned", False)
        acct.setdefault("verified", status == "已完成")  # 已完成=验证过可用
        acct["status"] = status
        acct["state"] = "active" if not acct["banned"] else "banned"
        prev[email] = acct
        n += 1
    s["accounts"] = prev
    s["created"] = time.strftime("%Y-%m-%d %H:%M")
    _save_state(s)
    banned = sum(1 for a in prev.values() if a["banned"])
    verified = sum(1 for a in prev.values() if a.get("verified"))
    print(f"[pool] 建池: {n} 账号入池 (已验证 {verified} | 摘池 {banned} | "
          f"ramp={s['ramp']})", flush=True)
    return 0


def _today_usage(email: str) -> tuple[int, int]:
    """今日该账号已用积分/已派任务数."""
    credits, tasks = 0, 0
    for r in _ledger_rows():
        if r.get("email") == email:
            credits += int(r.get("credits", 0))
            tasks += 1
    return credits, tasks


def plan(tasks_needed: int) -> list[dict]:
    """批次分配 — 广度轮换 + 三维选号 (余额/健康度/轮换指针).

    返回 [{email, slots, credits_left}], 每账号 slots ≤ MAX_TASKS_PER_BATCH.
    """
    s = _load_state()
    ramp = ACTIVE_RAMP.get(s.get("ramp", "M1"), 10)
    # 候选: 活跃+未摘池; 今日批次未用满; 余额够 1 个任务预算
    cands = []
    for email, a in s["accounts"].items():
        if a.get("banned") or a.get("state") != "active":
            continue
        used_c, used_t = _today_usage(email)
        if used_t >= MAX_TASKS_PER_BATCH * MAX_BATCHES_PER_DAY:
            continue
        slots = min(MAX_TASKS_PER_BATCH - used_t,
                    (DAILY_CREDITS - used_c) // TASK_CREDIT_BUDGET,
                    MAX_TASKS_PER_BATCH)
        if slots <= 0:
            continue
        cands.append({"email": email, "slots": int(slots),
                      "credits_left": DAILY_CREDITS - used_c,
                      "health": a.get("health", 1.0),
                      "verified": a.get("verified", False)})
    # 试点爬坡: 只取前 ramp 个 (已验证优先, 再按健康度)
    cands.sort(key=lambda c: (not c["verified"], -c["health"]))
    cands = cands[:ramp]
    # 广度轮换: 昨日出场过的排后 (rotation 列表尾=最近出场)
    rot = s.get("rotation", [])
    cands.sort(key=lambda c: rot.index(c["email"]) if c["email"] in rot else -1)
    out, assigned = [], 0
    for c in cands:
        if assigned >= tasks_needed:
            break
        take = min(c["slots"], tasks_needed - assigned)
        out.append({"email": c["email"], "slots": take,
                    "credits_left": c["credits_left"]})
        assigned += take
    # 更新轮换指针 (出场过的挪到列表尾)
    for o in out:
        if o["email"] in rot:
            rot.remove(o["email"])
        rot.append(o["email"])
    s["rotation"] = rot[-400:]
    _save_state(s)
    return out


def record(email: str, credits: int, result: str, task_id: str = "") -> int:
    """回写账本 + 健康度维护 (ok=不动, fail=-0.3, ban=摘池)."""
    if result not in ("ok", "fail", "ban"):
        print("result 必须是 ok|fail|ban", file=sys.stderr)
        return 2
    _append_ledger({"ts": time.strftime("%Y-%m-%dT%H:%M:%S"),
                    "email": email, "credits": credits, "result": result,
                    "task_id": task_id})
    s = _load_state()
    a = s["accounts"].get(email)
    if a is None:
        print(f"[pool] 未知账号 {email[:3]}*** — 先 init", file=sys.stderr)
        return 1
    if result == "fail":
        a["health"] = round(max(0.0, a.get("health", 1.0) - 0.3), 2)
    elif result == "ban":
        a["banned"] = True
        a["state"] = "banned"
        a["health"] = 0.0
    else:
        a["health"] = round(min(1.0, a.get("health", 1.0) + 0.05), 2)
        a["verified"] = True
    _save_state(s)
    print(f"[pool] 记账: {email[:3]}*** {result} -{credits}积分 "
          f"健康度={a['health']}", flush=True)
    return 0


def status() -> int:
    s = _load_state()
    accts = s.get("accounts", {})
    if not accts:
        print("[pool] 空池 — 先 init", flush=True)
        return 1
    rows = _ledger_rows()
    used_today = sum(r.get("credits", 0) for r in rows)
    tasks_today = len(rows)
    fails = sum(1 for r in rows if r["result"] == "fail")
    active = [a for a in accts.values() if a.get("state") == "active"]
    verified = sum(1 for a in active if a.get("verified"))
    print(f"[pool] 池: {len(accts)} 账号 (活跃 {len(active)} | 已验证 {verified} | "
          f"摘池 {len(accts)-len(active)}) | ramp={s.get('ramp')} "
          f"(上限 {ACTIVE_RAMP.get(s.get('ramp','M1'),10)})")
    print(f"[pool] 今日账本: 任务 {tasks_today} | 积分 {used_today} | "
          f"失败 {fails}", flush=True)
    return 0


def main() -> int:
    ap = argparse.ArgumentParser(description="远征军团调度池")
    ap.add_argument("cmd", choices=["init", "plan", "record", "status"])
    ap.add_argument("--tasks", type=int, default=10)
    ap.add_argument("rest", nargs="*")  # record: email credits result [task_id]
    args = ap.parse_args()

    if args.cmd == "init":
        return init_pool()
    if args.cmd == "plan":
        for o in plan(args.tasks):
            print(f"{o['email'][:3]}*** slots={o['slots']} "
                  f"余额={o['credits_left']}")
        return 0
    if args.cmd == "record":
        if len(args.rest) < 3:
            print("用法: record <email> <credits> <ok|fail|ban> [task_id]",
                  file=sys.stderr)
            return 2
        return record(args.rest[0], int(args.rest[1]), args.rest[2],
                      args.rest[3] if len(args.rest) > 3 else "")
    return status()


if __name__ == "__main__":
    sys.exit(main())
