# -*- coding: utf-8 -*-
"""demand_signals_wechat — 需求信号源③微信群聊采集器 (L1, 1016 用户令).

群聊=私有真话。**只采群名含「总包」二字的群** (用户令, 其余群一律不看)。
源: wechat-intelligence-hub (本地只读库) — hub.sh db-index 出群清单后,
对「总包」系群取近期消息; hub 不可用时报 blocker 如实退出。

用法: py -X utf8 tools/demand_signals_wechat.py [--hours 72]
"""
from __future__ import annotations

import argparse
import json
import subprocess
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
REPO = Path(__file__).resolve().parents[1]
HUB = REPO / ".claude" / "skills" / "wechat-intelligence-hub" / "scripts" / "hub.sh"
OUT = REPO / "data" / "demand_signals"
KEY = "总包"          # 1016 用户令: 只看总包系群


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--hours", type=int, default=72)
    ns = ap.parse_args()
    OUT.mkdir(parents=True, exist_ok=True)
    if not HUB.is_file():
        print("[wx] hub.sh 不在 — blocker 如实退出", file=sys.stderr)
        return 2
    r = subprocess.run(["bash", HUB.as_posix(), "db-index", "--scope", "sessions",
                        "--session-type", "group", "--session-limit", "200",
                        "--per-chat-limit", "50",
                        "--since",
                        time.strftime("%Y-%m-%d %H:%M",
                                      time.localtime(time.time() - ns.hours * 3600)),
                        "--out", str(OUT / "_hub_index")],
                       capture_output=True, text=True, timeout=900)
    if r.returncode != 0:
        print(f"[wx] hub db-index 失败: {r.stderr[-160:]}")
        return 2
    # 解析索引产物里的「总包」群 → 逐群拉消息
    idx_dir = OUT / "_hub_index"
    picked = []
    for f in idx_dir.rglob("*.json*"):
        try:
            d = json.loads(f.read_text(encoding="utf-8"))
        except Exception:
            continue
        chats = d if isinstance(d, list) else d.get("chats", d.get("sessions", []))
        for ch in chats if isinstance(chats, list) else []:
            name = str(ch.get("name", ch.get("display_name", "")) or "")
            if KEY in name:
                picked.append((name, ch.get("chat_id", ch.get("id", ""))))
    print(f"[wx] 总包系群 {len(picked)} 个: {[n[:16] for n, _ in picked][:6]}")
    n = 0
    out = OUT / f"raw_wechat_{time.strftime('%Y%m%d')}.jsonl"
    with out.open("a", encoding="utf-8") as f:
        for name, cid in picked:
            r2 = subprocess.run(
                ["bash", HUB.as_posix(), "chat-history", "--chat", str(cid),
                 "--since", time.strftime(
                     "%Y-%m-%d %H:%M",
                     time.localtime(time.time() - ns.hours * 3600)),
                 "--out", str(OUT / "_hub_chats")],
                capture_output=True, text=True, timeout=600)
            if r2.returncode != 0:
                continue
            for cf in (OUT / "_hub_chats").rglob("*.json*"):
                try:
                    d = json.loads(cf.read_text(encoding="utf-8"))
                except Exception:
                    continue
                msgs = d if isinstance(d, list) else d.get("messages", [])
                for m in msgs if isinstance(msgs, list) else []:
                    t = str(m.get("text", m.get("content", "")) or "").strip()
                    if len(t) < 8:
                        continue
                    f.write(json.dumps({
                        "ts": str(m.get("ts", m.get("time", "")))[:19],
                        "source": "wechat_group",
                        "channel": f"group:{name[:24]}",
                        "actor": str(m.get("sender", m.get("who", "")))[:16],
                        "text": t[:500], "meta": {}}, ensure_ascii=False) + "\n")
                    n += 1
    print(f"[wx] {n} 条「总包」系群消息 → {out.name}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
