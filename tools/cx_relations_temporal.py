# -*- coding: utf-8 -*-
"""关系时序画像：高频协作人 × 月活跃矩阵 + 关系生命线。

graphiti 时序图的核心价值（关系边带时间演化）用已有栈落地：
- entities.db interaction_scores → Top 协作人名单
- timeline.db wechat_chat/wecom_meeting/tencent_meeting/git → 按月同框

零新依赖（Neo4j 不装）；bitemporal 双时间戳 entities.db 本就有，
本工具补的是查询/画像层。产出 SELF_PROFILE/cx_关系时序_<date>.md。
用法：python tools/cx_relations_temporal.py [--top 20]
"""
from __future__ import annotations

import argparse
import json
import sqlite3
from datetime import datetime
from pathlib import Path

REPO = Path(__file__).resolve().parents[1]
CX = REPO / "data" / "cx"
OUT = REPO / "SELF_PROFILE" / f"cx_关系时序_{datetime.now():%Y%m%d}.md"


def month_of(ts_iso: str) -> str:
    try:
        return datetime.fromisoformat(ts_iso).astimezone().strftime("%Y-%m")
    except ValueError:
        return ""


def active_months(tl: sqlite3.Connection, name: str) -> dict[str, int]:
    """某人按月活跃度：群聊 senders（引号键精确）+ 会议/git payload。

    短名（<3 字）跳过会议/git 裸 LIKE——一个点的昵称会匹配一切
    含点 payload（焦点窗口 process 名），纯噪声。
    """
    out: dict[str, int] = {}
    rows = tl.execute(
        'SELECT start, json_extract(payload, \'$.senders."\' || ? || \'"\' ) '
        "FROM events WHERE source='wechat_chat' AND payload LIKE ?",
        (name, f'%"{name}"%')).fetchall()
    for start, n in rows:
        m = month_of(start)
        if m and n:
            out[m] = out.get(m, 0) + 1
    if len(name) >= 3:
        rows = tl.execute(
            "SELECT start FROM events WHERE source IN "
            "('wecom_meeting','tencent_meeting','git') AND payload LIKE ?",
            (f"%{name}%",)).fetchall()
        for (start,) in rows:
            m = month_of(start)
            if m:
                out[m] = out.get(m, 0) + 1
    return out


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--top", type=int, default=20)
    args = ap.parse_args()

    sco = sqlite3.connect(CX / "scores.db")
    tl = sqlite3.connect(CX / "timeline.db")
    pool = sco.execute(
        "SELECT entity_id, name, score, components FROM interaction_scores "
        "ORDER BY score DESC LIMIT ?", (args.top * 8,)).fetchall()
    top = []
    for eid, name, score, comp in pool:
        if len(name) < 2 or not any("一" <= ch <= "鿿" or ch.isalnum()
                                    for ch in name):
            continue  # 纯符号昵称（如".");
        comps = json.loads(comp)
        if comps and all(k.startswith("group") for k in comps):
            continue
        top.append((name, score))
        if len(top) >= args.top:
            break

    L = ["# 关系时序画像（协作人 × 月活跃 + 生命线）", ""]
    L.append(f"> {datetime.now():%Y-%m-%d %H:%M} · tools/cx_relations_temporal.py · "
             f"Top{args.top} 协作人 × 聊天轴/会议/git 按月同框；"
             "graphiti bitemporal 思想用已有 SQLite 落地")
    L.append("")
    months_all: set[str] = set()
    per_person: dict[str, dict[str, int]] = {}
    for name, _ in top:
        am = active_months(tl, name)
        per_person[name] = am
        months_all |= set(am)
    months = sorted(m for m in months_all if m >= "2025-01")

    L.append("## 月活跃矩阵（行=人，列=月，格=当月同框事件数）")
    L.append("")
    L.append("| 人 | " + " | ".join(m[2:] for m in months) + " | 合计 |")
    L.append("|---|" + "---:" * (len(months) + 1))
    ranked = sorted(per_person.items(), key=lambda kv: -sum(kv[1].values()))
    for name, am in ranked:
        cells = [str(am.get(m, "")) for m in months]
        L.append(f"| {name} | " + " | ".join(cells)
                 + f" | {sum(am.values())} |")
    L.append("")

    L.append("## 关系生命线（首同框 → 最近同框 × 活跃月数）")
    L.append("")
    L.append("| 人 | 首同框 | 最近同框 | 活跃月数 | 判读 |")
    L.append("|---|---|---|---:|---|")
    for name, am in ranked:
        if not am:
            L.append(f"| {name} | — | — | 0 | 时间轴无同框（静态关系） |")
            continue
        ms = sorted(am)
        first, last = ms[0], ms[-1]
        span = (datetime.strptime(last, "%Y-%m") - datetime.strptime(first, "%Y-%m")).days // 30 + 1
        density = len(ms) / max(span, 1)
        verdict = ("持续高频" if density >= 0.6 and len(ms) >= 6 else
                   "近期活跃" if last >= "2026-08" else
                   "已淡出" if last < "2026-06" else "间歇互动")
        L.append(f"| {name} | {first} | {last} | {len(ms)} | {verdict} |")

    OUT.write_text("\n".join(L), encoding="utf-8")
    print(f"关系时序画像 → {OUT}")
    sco.close()
    tl.close()
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
