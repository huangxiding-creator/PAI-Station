# -*- coding: utf-8 -*-
"""报告生长模式挖掘 (四层研究·第二层核心) — 主矿脉: 77% text_editor.

重建每个任务的「报告怎么长出来」:
  - 文件操作时间线 (read/write/edit × 文件名 × 计划步骤归属)
  - write/edit 节奏画像 (增量式写作证据)
  - 计划↔执行映射 (哪步计划干了哪些活)
  - outline.json 最终大纲 (报告结构样本)
产出: analysis/growth_patterns.json
"""
import json
import sys
import time
from collections import Counter, defaultdict
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

ROOT = Path("harvest_sessions")
OUT = Path("analysis")


def mine_one(msg_path: Path) -> dict:
    d = json.loads(msg_path.read_text(encoding="utf-8"))["data"]
    steps = {}           # stepId -> title (newPlanStep)
    ops = []             # 文件操作时间线
    tool_by_step = defaultdict(Counter)
    for seg in d.get("segments", []):
        for ev in seg.get("events", []):
            if ev.get("type") == "newPlanStep":
                steps[ev.get("stepId")] = (ev.get("title") or "")[:50]
            elif ev.get("type") == "toolUsed":
                sid = ev.get("planStepId")
                tool = ev.get("tool") or "?"
                if sid:
                    tool_by_step[sid][tool] += 1
                if tool == "text_editor":
                    det = ((ev.get("detail") or {}).get("textEditor") or {})
                    act = det.get("action", "?")
                    fp = (det.get("path") or "").split("/")[-1][:50]
                    ops.append({"a": act, "f": fp, "ts": ev.get("timestamp"),
                                "step": steps.get(sid, "")[:30]})
                elif tool in ("terminal",):
                    det = ((ev.get("detail") or {}).get("terminal") or {})
                    cmd = (det.get("command") or "")[:60]
                    if any(x in cmd for x in (">", ">>", "tee", "cp ",
                                              "mv ", "cat >")):
                        ops.append({"a": "shell_write", "f": cmd,
                                    "ts": ev.get("timestamp"),
                                    "step": steps.get(sid, "")[:30]})
    return {"sid": d.get("id"), "title": (d.get("title") or "")[:60],
            "n_steps": len(steps), "steps": steps,
            "ops": ops[:600], "tool_by_step": {
                k: dict(v) for k, v in tool_by_step.items()}}


def main():
    files = sorted(ROOT.glob("*/*.messages.json"))
    seen, results = set(), []
    t0 = time.time()
    for i, p in enumerate(files, 1):
        try:
            head = json.loads(p.read_text(encoding="utf-8"))["data"]
            sid = head.get("id")
            if sid in seen:
                continue
            seen.add(sid)
            results.append(mine_one(p))
        except Exception:
            continue
        if i % 100 == 0:
            print(f"[growth] {i}/{len(files)} ({time.time()-t0:.0f}s)",
                  flush=True)

    # 全局画像
    act_counter = Counter()
    write_rhythm = []      # 每任务 write/edit 总数
    files_per_task = []
    for r in results:
        ac = Counter(o["a"] for o in r["ops"])
        act_counter.update(ac)
        w = ac.get("write", 0) + ac.get("edit", 0) + ac.get("str_replace", 0) \
            + ac.get("shell_write", 0)
        write_rhythm.append(w)
        files_per_task.append(len({o["f"] for o in r["ops"]
                                   if not o["f"].startswith(("cat", "echo"))}))
    write_rhythm.sort()
    files_per_task.sort()

    # outline 大纲样本 (最终报告结构)
    outlines = []
    for op in sorted(ROOT.glob("*/*.outline.json"))[:400]:
        try:
            o = json.loads(op.read_text(encoding="utf-8"))
            txt = json.dumps(o, ensure_ascii=False)
            outlines.append(op.parent.name + "|" + op.name.split(".")[0])
            if len(outlines) >= 200:
                break
        except Exception:
            continue

    OUT.mkdir(exist_ok=True)
    (OUT / "growth_patterns.json").write_text(json.dumps({
        "generated": time.strftime("%Y-%m-%d %H:%M"),
        "n_tasks": len(results),
        "action_distribution": act_counter.most_common(),
        "write_per_task_median": write_rhythm[len(write_rhythm) // 2],
        "files_per_task_median": files_per_task[len(files_per_task) // 2],
        "tasks": results,
    }, ensure_ascii=False), encoding="utf-8")

    print(f"[growth] 完成: {len(results)} 任务 | 操作分布 "
          f"{dict(act_counter.most_common(6))}", flush=True)
    print(f"[growth] 每任务写操作中位 {write_rhythm[len(write_rhythm)//2]}"
          f" | 涉及文件中位 {files_per_task[len(files_per_task)//2]}",
          flush=True)
    print("[growth] 产出: analysis/growth_patterns.json", flush=True)


if __name__ == "__main__":
    main()
