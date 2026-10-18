# -*- coding: utf-8 -*-
"""topic_signals_to_radar — 微信群聊/朋友圈需求洞察 → 报告选题雷达候选 (1018 用户令).

选题源之三: 「逆向个人微信」会话的 topic-signals (moments/group JTBD 信号)。
读 wechat-24h-ops/data/topic-signals/*.jsonl → 按需求短语聚类 → 生成/合并
reforge_factory/superline/radar_topics.json 候选 (标记 source=wechat_insight)。
用法: py -X utf8 tools/topic_signals_to_radar.py [--min 3]
"""
from __future__ import annotations

import argparse
import json
import re
import sys
from collections import Counter
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
REPO = Path(__file__).resolve().parents[1]
SIG_DIR = REPO / "wechat-24h-ops" / "data" / "topic-signals"
TOPICS = REPO / "reforge_factory" / "superline" / "radar_topics.json"

STOP = re.compile(r"注意|可能|正在|你的|这个|这样|可以|我们|他们")


def norm_topic(quote: str) -> str:
    t = re.sub(r"[，。！？、：；''\"()\[\]0-9]", " ", quote)
    t = STOP.sub(" ", t)
    words = [w for w in t.split() if len(w) >= 2]
    return "".join(words)[:18] or quote[:18]


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--min", type=int, default=1, help="入选最小信号数")
    ns = ap.parse_args()
    if not SIG_DIR.exists():
        print("[桥] 无信号目录"); return 1
    cnt: Counter[str] = Counter()
    sample: dict[str, str] = {}
    faces: Counter[str] = Counter()
    for fp in sorted(SIG_DIR.glob("*.jsonl")):
        for ln in fp.open(encoding="utf-8"):
            try:
                d = json.loads(ln)
            except json.JSONDecodeError:
                continue
            q = str(d.get("demand_quote") or "").strip()
            if not q:
                continue
            t = norm_topic(q)
            cnt[t] += 1
            faces[str(d.get("source_face", "?"))] += 1
            sample.setdefault(t, q)
    hot = [(t, n) for t, n in cnt.most_common() if n >= ns.min]
    print(f"[桥] 信号面={dict(faces)} | 聚类主题 {len(cnt)} → 入选 {len(hot)}")
    topics = json.loads(TOPICS.read_text(encoding="utf-8")) if TOPICS.exists() else []
    existed = {str(t.get("topic")) for t in topics}
    added = 0
    for t, n in hot:
        title = f"微信洞察·{t}"
        if title in existed:
            continue
        topics.append({"topic": title, "pool": "ammo_pool/EPC49-SEPDC",
                       "note": f"微信洞察信号x{n}（{sample[t][:40]}），源=逆向个人微信会话 topic-signals"})
        added += 1
    if added:
        TOPICS.write_text(json.dumps(topics, ensure_ascii=False, indent=1), encoding="utf-8")
    print(f"[桥] 新增候选 {added} → radar_topics.json (总 {len(topics)})")
    for t, n in hot[:8]:
        print(f"  · {t} ×{n} | {sample[t][:44]}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
