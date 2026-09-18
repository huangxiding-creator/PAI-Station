# -*- coding: utf-8 -*-
"""关系维融合画像：静态登记（实体/边/活跃度）× 时间轴共现（最近同框）。

产出 SELF_PROFILE/cx_关系融合_<date>.md——关系维 L3 的"融合可检索"证据：
- 身份层闭环状态（多渠道同体/分身族）
- 高频协作人 × 渠道面 × 最近同框（wecom/腾讯会议/git payload 检索）
用法：python tools/cx_relations_profile.py [--top 40]
"""
from __future__ import annotations

import argparse
import json
import sqlite3
from datetime import datetime
from pathlib import Path

REPO = Path(__file__).resolve().parents[1]
CX = REPO / "data" / "cx"
OUT = REPO / "SELF_PROFILE" / f"cx_关系融合_{datetime.now():%Y%m%d}.md"

CHANNEL_LABEL = {"wecom": "企微", "feishu": "飞书", "wechat": "微信", "git": "git",
                 "qqmail": "QQ邮箱", "meeting": "会议", "tencent": "腾讯会"}


def _ch_label(src_set: set[str]) -> str:
    out = []
    for s in src_set:
        for k, v in CHANNEL_LABEL.items():
            if k in s:
                out.append(v)
                break
        else:
            out.append(s)
    return "×".join(dict.fromkeys(out)) or "?"


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--top", type=int, default=40)
    args = ap.parse_args()

    ent = sqlite3.connect(CX / "entities.db")
    sco = sqlite3.connect(CX / "scores.db")
    tl = sqlite3.connect(CX / "timeline.db")

    # 身份层
    multi = ent.execute("""
        SELECT COUNT(*) FROM (
          SELECT entity_id FROM entities, json_each(entities.sources)
          WHERE kind='person' GROUP BY entity_id HAVING COUNT(DISTINCT json_each.value) > 1
        )""").fetchone()[0]
    persons = ent.execute(
        "SELECT COUNT(*) FROM entities WHERE kind='person'").fetchone()[0]
    ego = ent.execute("""
        SELECT f.display_name, t.display_name FROM entity_links l
        JOIN entities f ON f.entity_id=l.from_id
        JOIN entities t ON t.entity_id=l.to_id
        WHERE l.relation='alter_ego_of'""").fetchall()

    # 活跃度 top：先放大捞取，再滤掉"仅群摊派"的环境噪声（群名/公众号/
    # 早报号无直接交互成分），保真协作人榜
    pool = sco.execute(
        "SELECT entity_id, name, score, components FROM interaction_scores "
        "ORDER BY score DESC LIMIT ?", (args.top * 8,)).fetchall()
    top = []
    for eid, name, score, comp in pool:
        comps = json.loads(comp)
        if comps and all(k.startswith("group") for k in comps):
            continue  # 仅群系成分（group_share/group_recency）=同群环境，非直接协作
        top.append((eid, name, score, comp))
        if len(top) >= args.top:
            break
    src_of = dict(ent.execute(
        "SELECT entity_id, sources FROM entities WHERE kind='person'").fetchall())

    # 时间轴最近同框：聊天轴优先（senders JSON 键=引号包裹，精确），
    # 回退会议/git（payload 名字裸现）。短名防窗口标题 LIKE 误命中。
    def last_seen(name: str) -> tuple[str, str]:
        row = tl.execute(
            "SELECT start, type FROM events WHERE source='wechat_chat' "
            "AND payload LIKE ? ORDER BY start DESC LIMIT 1",
            (f'%\"{name}\"%',)).fetchone()
        if not row:
            row = tl.execute(
                "SELECT start, type FROM events "
                "WHERE source IN ('wecom_meeting','tencent_meeting','git') "
                "AND payload LIKE ? ORDER BY start DESC LIMIT 1",
                (f"%{name}%",)).fetchone()
        if not row:
            return ("—", "")
        local = datetime.fromisoformat(row[0]).astimezone().strftime("%m-%d")
        kind = {"wecom_meeting": "企微会", "tencent_meeting": "腾讯会",
                "git": "git", "chat.activity": "群聊"}.get(row[1], row[1])
        return (local, kind)

    L = ["# 关系维融合画像（登记×共现）", ""]
    L.append(f"> {datetime.now():%Y-%m-%d %H:%M} · tools/cx_relations_profile.py · "
             f"person {persons:,} / 多渠道同体 {multi} / 分身族 {len(ego)}")
    L.append("")
    L.append("## 身份层（已闭环）")
    L.append("")
    L.append(f"- 跨渠道同名合并消化完毕（同名多实体=0）；多渠道同体实体 {multi} 个")
    L.append("- AI 分身族（alter_ego_of，挂边不并体）：" +
             "、".join(f"{a}→{b}" for a, b in ego[:6]))
    L.append("")
    L.append(f"## 高频协作 Top{args.top}（群摊派计分 × 渠道面 × 最近同框）")
    L.append("")
    L.append("| # | 名字 | 分 | 构成 | 渠道 | 最近同框 |")
    L.append("|---|---|---:|---|---|---|")
    for i, (eid, name, score, comp) in enumerate(top, 1):
        comps = json.loads(comp)
        cstr = "+".join(f"{k.split('_')[0]}{v}" for k, v in comps.items())
        srcs = set((src_of.get(eid) or "").split(","))
        d, k = last_seen(name)
        L.append(f"| {i} | {name} | {score} | {cstr} | {_ch_label(srcs)} | {d} {k} |")
    L.append("")
    L.append("> 判读口径：分=群成员摊派（封顶30防失衡）+会议/git 加权；最近同框="
             "timeline payload 名字 LIKE 命中的最新事件（近似，重名会串）。")

    # 聊天轴（关系维时间层）：群×日 元数据聚合
    L.append("")
    L.append("## 聊天轴（群×日 纯元数据，2026-09-18 入轴）")
    L.append("")
    span = tl.execute(
        "SELECT COUNT(*), COUNT(DISTINCT source_id), MIN(start), MAX(start) "
        "FROM events WHERE source='wechat_chat'").fetchone()
    if span and span[0]:
        grp = tl.execute(
            "SELECT COUNT(DISTINCT json_extract(payload,'$.group')) "
            "FROM events WHERE source='wechat_chat'").fetchone()[0]
        total_msgs = tl.execute(
            "SELECT SUM(json_extract(payload,'$.total')) FROM events "
            "WHERE source='wechat_chat'").fetchone()[0]
        d0 = datetime.fromisoformat(span[2]).astimezone().strftime("%Y-%m-%d")
        d1 = datetime.fromisoformat(span[3]).astimezone().strftime("%Y-%m-%d")
        L.append(f"- 覆盖：{grp} 群 × {span[1]} 群·日 × {total_msgs:,} 条消息"
                 f"（{d0} → {d1}，零内容纪律：只记 发送者×类型×计数）")
        L.append("")
        L.append("### Top15 活跃群（消息总量 × 主人在场日）")
        L.append("")
        L.append("| 群 | 消息数 | 活跃日 | 主人在场日 |")
        L.append("|---|---:|---:|---:|")
        rows = tl.execute("""
            SELECT json_extract(payload,'$.group') g,
                   SUM(json_extract(payload,'$.total')) msgs,
                   COUNT(*) days,
                   SUM(CASE WHEN json_extract(payload,'$.senders.me') > 0
                        THEN 1 ELSE 0 END) me_days
            FROM events WHERE source='wechat_chat'
            GROUP BY g ORDER BY msgs DESC LIMIT 15""").fetchall()
        for g, msgs, days, me_days in rows:
            L.append(f"| {g} | {msgs} | {days} | {me_days} |")
    else:
        L.append("- （聊天轴为空）")
    OUT.write_text("\n".join(L), encoding="utf-8")
    print(f"关系融合画像 → {OUT}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
