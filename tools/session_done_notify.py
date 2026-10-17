# -*- coding: utf-8 -*-
"""会话任务清零 → 企微通知（用户令 2026-10-18）。

作为 Claude Code Stop 钩子运行：会话回合结束时检查在役 super-skill run 的
任务状态；若全部 done（无 pending/in_progress）→ 推企微通知。
幂等：完成指纹落 marker，同一完成事件只通知一次；出现新 pending 后指纹复位。
"""
from __future__ import annotations

import json
import time
from pathlib import Path

import requests

ROOT = Path(r"E:\AI-Station")
WEBHOOK_FILE = ROOT / "wechat-24h-ops" / "data" / "wecom_webhook.txt"
MARKER = ROOT / "wechat-24h-ops" / "data" / "session_done_marker.json"
RUNS = {
    "wechat-24h-ops": ROOT / "wechat-24h-ops" / ".super-skill",
    "revenue-engine": ROOT / ".super-skill",
}


def _task_state(run_dir: Path) -> dict:
    f = run_dir / "tasks.json"
    if not f.exists():
        return {"total": 0, "pending": 0, "done": 0}
    try:
        d = json.loads(f.read_text(encoding="utf-8"))
    except Exception:
        return {"total": 0, "pending": 0, "done": 0}
    tasks = d.get("tasks", [])
    pending = [t["id"] for t in tasks if t.get("status") in
               ("pending", "in_progress")]
    return {"total": len(tasks), "pending": len(pending),
            "done": sum(1 for t in tasks if t.get("status") == "done"),
            "pending_ids": pending}


def main() -> int:
    report, all_clear = {}, True
    for name, d in RUNS.items():
        st = _task_state(d)
        report[name] = st
        if st["total"] and st["pending"]:
            all_clear = False

    prev = {}
    if MARKER.exists():
        try:
            prev = json.loads(MARKER.read_text(encoding="utf-8"))
        except Exception:
            pass

    if all_clear:
        fingerprint = {n: s["done"] for n, s in report.items()}
        if prev.get("notified_clear") != fingerprint:      # 新的完成事件
            ok = _notify(report)
            MARKER.parent.mkdir(parents=True, exist_ok=True)
            MARKER.write_text(json.dumps(
                {"notified_clear": fingerprint, "ts": time.strftime("%FT%T"),
                 "delivered": ok}, ensure_ascii=False), encoding="utf-8")
    elif prev.get("notified_clear"):
        # 出现新任务 → 指纹复位,下次清零再通知
        MARKER.write_text(json.dumps({"notified_clear": None,
                                      "ts": time.strftime("%FT%T")}),
                          encoding="utf-8")
    return 0


def _notify(report: dict) -> bool:
    url = WEBHOOK_FILE.read_text(encoding="utf-8").strip()
    lines = ["## 🎉 会话任务清零——可安排下一步", ""]
    for n, s in report.items():
        if s["total"]:
            lines.append(f"- **{n}**: {s['done']}/{s['total']} done"
                         + ("" if not s["pending"] else
                            f"（余 {s['pending']}: {','.join(s['pending_ids'][:4])}）"))
    lines += ["", f"> {time.strftime('%Y-%m-%d %H:%M')} · 会话回合结束自动推送"]
    try:
        r = requests.post(url, json={"msgtype": "markdown", "markdown": {
            "content": "\n".join(lines)}}, timeout=10)
        return r.status_code == 200
    except Exception:
        return False


if __name__ == "__main__":
    sys_exit = main()
    raise SystemExit(sys_exit)
