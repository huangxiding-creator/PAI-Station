# -*- coding: utf-8 -*-
"""ResearchTicket 七环总线 (融合蓝图 F0 大脑件) — Super-Skill V4.1.16 缝合怪中央对象.

蓝图: corps_factory/FUSION_BLUEPRINT.md (用户 2026-09-22 批准 v2)
职责: 需求单 intake → 路由(own/manus/dual) → context_pack 查库注入 → 派发记账.
七环: intake→planning→collecting→verifying→drafting→published (stage 字段流转)
三方: 现有能力体系(own) · Jev 判断层(接口位, 网络恢复后接 jev_ask.py) · Manus 军团(manus)

数据:
  data/bus/tickets/RT-*.json       每单一文件 (只增不删)
  data/bus/route_rules.json        路由规则表 (可改=达尔文进化落点)
  data/bus/ledger_YYYY-MM-DD.jsonl 日账本 (engine/credits/结果)

用法:
  python ticket_bus.py intake --need "..." --origin "EPC100"
  python ticket_bus.py route <ticket_id> [--corpus <dir>]
  python ticket_bus.py plan-mock <ticket_id>
  python ticket_bus.py dispatch-mock <ticket_id>
  python ticket_bus.py record <ticket_id> --engine manus --credits 40 --result ok
  python ticket_bus.py show <ticket_id>
  python ticket_bus.py stats

红线: 零网络 (manus 派发只做本地 pool 规划, 不 dispatch); 密码/凭据绝不进 ticket.
"""
from __future__ import annotations

import argparse
import json
import re
import subprocess
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

ROOT = Path(__file__).parent
BUS_DIR = ROOT / "data" / "bus"
TICKETS_DIR = BUS_DIR / "tickets"
STAGES = ["intake", "planning", "collecting", "verifying",
          "drafting", "published"]

# 默认路由规则 (判据表落盘; 修改 route_rules.json 即进化, 无需改代码)
DEFAULT_RULES = [
    {"pattern": "日常增量|RSS|公众号|盯梢|日报", "engine": "own",
     "reason": "日常增量收割: 零账号成本已自动化"},
    {"pattern": "扫描|桥接|166|opencli", "engine": "own",
     "reason": "桥接内定向扫描: 边际成本≈0"},
    {"pattern": "招投标|合同额|财务|渠道外|补盲", "engine": "manus",
     "reason": "渠道外定向找源/数据钻探: 我方渠道覆盖不到"},
    {"pattern": "深钻|深度调研|对标|竞对|专题", "engine": "manus",
     "reason": "深度单主题钻探: Manus 三强项(规划/调研/分析)"},
    {"pattern": "分析|洞察|章节|撰写|初稿", "engine": "manus",
     "reason": "分析输出主力: 用户定三大强项"},
    {"pattern": "核验|验证|关键数字|金额确认", "engine": "dual",
     "reason": "关键事实双跑交叉验证"},
    {"pattern": "排版|发布|终稿|整合", "engine": "own",
     "reason": "成稿主权: EPC100 工厂终稿链"},
    {"pattern": "拆解|矩阵|规划|策划", "engine": "manus",
     "reason": "任务规划: 参谋会话"},
]


def _load_rules() -> list[dict]:
    p = BUS_DIR / "route_rules.json"
    if not p.is_file():
        BUS_DIR.mkdir(parents=True, exist_ok=True)
        p.write_text(json.dumps(DEFAULT_RULES, ensure_ascii=False, indent=1),
                     encoding="utf-8")
        return DEFAULT_RULES
    try:
        rules = json.loads(p.read_text(encoding="utf-8"))
        return rules if isinstance(rules, list) and rules else DEFAULT_RULES
    except (json.JSONDecodeError, OSError):
        return DEFAULT_RULES


def _ticket_path(tid: str) -> Path:
    if not re.fullmatch(r"RT-\d{8}-\d{3}", tid):
        raise ValueError(f"非法 ticket_id: {tid} (期望 RT-YYYYMMDD-NNN)")
    return TICKETS_DIR / f"{tid}.json"


def _load_ticket(tid: str) -> dict:
    p = _ticket_path(tid)
    if not p.is_file():
        raise FileNotFoundError(f"找不到工单 {tid}")
    try:
        return json.loads(p.read_text(encoding="utf-8"))
    except json.JSONDecodeError as e:
        raise ValueError(f"工单 {tid} JSON 损坏: {e}") from e


def _save_ticket(t: dict) -> None:
    """原子写回 — 读改写不共享可变引用, tmp+replace 防半写."""
    TICKETS_DIR.mkdir(parents=True, exist_ok=True)
    tmp = _ticket_path(t["ticket_id"]).with_suffix(".tmp")
    tmp.write_text(json.dumps(t, ensure_ascii=False, indent=1),
                   encoding="utf-8")
    tmp.replace(_ticket_path(t["ticket_id"]))


def _append_ledger(row: dict) -> None:
    BUS_DIR.mkdir(parents=True, exist_ok=True)
    path = BUS_DIR / f"ledger_{time.strftime('%Y-%m-%d')}.jsonl"
    with path.open("a", encoding="utf-8") as f:
        f.write(json.dumps(row, ensure_ascii=False) + "\n")


def _next_ticket_id() -> str:
    day = time.strftime("%Y%m%d")
    n = 1
    if TICKETS_DIR.is_dir():
        for p in TICKETS_DIR.glob(f"RT-{day}-*.json"):
            m = re.search(r"-(\d{3})\.json$", p.name)
            if m:
                n = max(n, int(m.group(1)) + 1)
    return f"RT-{day}-{n:03d}"


def jev_verdict_stub(need: str) -> dict:
    """Jev 判断位 (F0 stub). 网络恢复后接线 jev_ask.py, 免费模型可判的不上 Jev."""
    return {"jev": "pending_wire", "priority": "P1",
            "note": "F0 stub: 真实判定待 jev_ask.py 接线 (网络恢复后)"}


def scan_context_pack(need: str, corpus_dirs: list[Path]) -> list[str]:
    """查库注入 — 语料目录文件名/首行关键词匹配, 防重复扫描."""
    packs: list[str] = []
    kws = [w for w in re.split(r"[\s,，、;；]+", need)
           if len(w) >= 2 and not w.isdigit()][:8]
    if not kws:
        return packs
    for d in corpus_dirs:
        if not d.is_dir():
            continue
        for p in sorted(d.rglob("*"))[:500]:
            if p.suffix.lower() not in (".md", ".txt", ".json"):
                continue
            try:
                head = (p.read_text(encoding="utf-8", errors="ignore")
                        [:500])
            except OSError:
                continue
            text = p.name + " " + head
            hits = [k for k in kws if k in text]
            if len(hits) >= 2:
                packs.append(f"库内已有: {p.name} (命中 {len(hits)} 词)")
                if len(packs) >= 5:
                    return packs
    return packs


def route_ticket(tid: str, corpus: list[Path]) -> dict:
    """路由决策 — 判据表首条命中; 拿不准走 own 兜底 (Jev 价值判断待接线)."""
    t = _load_ticket(tid)
    need = t["intake"]["need"]
    engine, reason = "own", "兜底: 无规则命中, 先 own 试 30 分钟不成再升格"
    for r in _load_rules():
        if re.search(r["pattern"], need):
            engine, reason = r["engine"], r["reason"]
            break
    packs = scan_context_pack(need, corpus)
    return {
        **t,
        "route": {"engine": engine, "route_reason": reason,
                  "routed_at": time.strftime("%Y-%m-%d %H:%M")},
        "context_pack": packs or ["(库内无已有资料, 全新课题)"],
    }


def plan_mock(t: dict) -> dict:
    """参谋矩阵 mock — 本地模板, 不碰网. 真实矩阵走 corps_prompts.md 参谋会话."""
    need = t["intake"]["need"]
    matrix = [
        {"id": "T01", "question": f"{need} — 2024-2025 官方动态与权威信源",
         "acceptance": "每条记录有可访问信源 URL", "est_credits": 40},
        {"id": "T02", "question": f"{need} — 关键数据点 (金额/规模/排名) 汇总",
         "acceptance": "数据点带出处, 金额口径标注官方/媒体", "est_credits": 40},
    ]
    return {**t,
            "planning": {"task_matrix": matrix,
                         "source": "mock (真实参谋会话待网络恢复)",
                         "planned_at": time.strftime("%Y-%m-%d %H:%M")}}


def dispatch_mock(t: dict) -> dict:
    """双路模拟派发 — own 打印渠道命令; manus 调 manus_pool plan (本地只读)."""
    engine = t.get("route", {}).get("engine", "own")
    dispatch: dict = {"engine": engine,
                      "dispatched_at": time.strftime("%Y-%m-%d %H:%M")}
    if engine in ("manus", "dual"):
        r = subprocess.run(
            [sys.executable, str(ROOT / "manus_pool.py"), "plan", "--tasks", "2"],
            capture_output=True, text=True, encoding="utf-8",
            creationflags=0x08000000)  # CREATE_NO_WINDOW
        dispatch["manus_pool_plan"] = (r.stdout or r.stderr).strip()[:400]
    else:
        dispatch["own_channel_hint"] = "走既有渠道 CLI (opencli/RSS/SouGouWeDown...)"
    return {**t, "dispatch": dispatch, "stage": "collecting"}


def main() -> int:
    ap = argparse.ArgumentParser(description="ResearchTicket 七环总线 (F0)")
    ap.add_argument("cmd", choices=["intake", "route", "plan-mock",
                                    "dispatch-mock", "record", "show", "stats"])
    ap.add_argument("tid", nargs="?", default="")
    ap.add_argument("--need", default="")
    ap.add_argument("--origin", default="EPC100",
                    choices=["EPC100", "P5", "战略课题", "用户点名"])
    ap.add_argument("--corpus", action="append", default=[],
                    help="context_pack 扫描目录 (可多次)")
    ap.add_argument("--engine", choices=["own", "manus", "dual"])
    ap.add_argument("--credits", type=int, default=0)
    ap.add_argument("--result", choices=["ok", "fail"], default="ok")
    args = ap.parse_args()

    try:
        if args.cmd == "intake":
            if not args.need.strip():
                print("--need 不能为空", file=sys.stderr)
                return 2
            tid = _next_ticket_id()
            t = {"ticket_id": tid, "stage": "intake",
                 "created": time.strftime("%Y-%m-%d %H:%M"),
                 "intake": {"need": args.need.strip(), "origin": args.origin,
                            **jev_verdict_stub(args.need)}}
            _save_ticket(t)
            print(f"[bus] 工单建立: {tid} (stage=intake, origin={args.origin})")

        elif args.cmd in ("route", "plan-mock", "dispatch-mock"):
            corpus = [Path(x) for x in args.corpus] or [
                ROOT / "analysis", ROOT / "corps_factory"]
            t = _load_ticket(args.tid)
            if args.cmd == "route":
                t = route_ticket(args.tid, corpus)
                stage = "planning"
            elif args.cmd == "plan-mock":
                t = plan_mock(t)
                stage = "planning"
            else:
                t = dispatch_mock(t)
                stage = t["stage"]
            _save_ticket({**t, "stage": stage})
            print(f"[bus] {args.cmd} 完成: {args.tid} (stage={stage})")
            if args.cmd == "route":
                r = t["route"]
                print(f"     引擎={r['engine']} | 理由={r['route_reason']}")
                for c in t["context_pack"][:3]:
                    print(f"     context: {c}")

        elif args.cmd == "record":
            t = _load_ticket(args.tid)
            if not args.engine:
                print("--engine 必填", file=sys.stderr)
                return 2
            _append_ledger({"ts": time.strftime("%Y-%m-%dT%H:%M:%S"),
                            "ticket_id": args.tid, "engine": args.engine,
                            "credits": args.credits, "result": args.result})
            print(f"[bus] 记账: {args.tid} {args.engine} "
                  f"{args.credits}积分 {args.result}")

        elif args.cmd == "show":
            print(json.dumps(_load_ticket(args.tid), ensure_ascii=False,
                             indent=1))

        else:  # stats
            if not BUS_DIR.is_dir():
                print("[bus] 无数据 — 先 intake", flush=True)
                return 0
            tickets = list(TICKETS_DIR.glob("RT-*.json"))
            led = sorted(BUS_DIR.glob("ledger_*.jsonl"))
            n_rows = sum(1 for p in led for _ in p.open(encoding="utf-8"))
            print(f"[bus] 工单 {len(tickets)} 张 | 账本 {len(led)} 天 {n_rows} 行")
            for p in tickets[-5:]:
                t = json.loads(p.read_text(encoding="utf-8"))
                eng = t.get("route", {}).get("engine", "-")
                print(f"  {t['ticket_id']} [{t['stage']:<10}] "
                      f"engine={eng:<5} {t['intake']['need'][:30]}")
        return 0

    except (FileNotFoundError, ValueError) as e:
        print(f"[bus] 错误: {e}", file=sys.stderr)
        return 1


if __name__ == "__main__":
    sys.exit(main())
