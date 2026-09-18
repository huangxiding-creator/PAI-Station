# -*- coding: utf-8 -*-
"""主人事实速查卡（自动重算）——关键量化事实的机械汇总。

定位：卷宗通道的"事实层"语料——装机/扩展名单/微信生态规模/git 统计/
时间轴源分布/嵌入进度，全部从本地 db/json 机械读出，不手写不臆造。
夜刷（cx_fusion_refresh）自动重算，永远反映最新状态。

产出：SELF_PROFILE/cx_事实速查_自动.md
用法：python tools/cx_facts_card.py
"""
from __future__ import annotations

import json
import sqlite3
from collections import Counter
from datetime import datetime
from pathlib import Path

REPO = Path(__file__).resolve().parents[1]
CX = REPO / "data" / "cx"
STATIC = REPO / "SELF_PROFILE" / "static_inventory" / "2026-09-16"
OUT = REPO / "SELF_PROFILE" / "cx_事实速查_自动.md"


def wechat_stats(ent: sqlite3.Connection) -> dict:
    row = ent.execute("""
        SELECT COUNT(*) FROM entities WHERE kind='person'
          AND sources LIKE '%wechat%'""").fetchone()
    friends = row[0] if row else 0
    rooms = ent.execute("""
        SELECT COUNT(*) FROM entities WHERE kind='org'
          AND display_name LIKE '%@chatroom%'""").fetchone()[0]
    return {"friends": friends, "rooms_hint": rooms}


def main() -> int:
    L = ["# 主人事实速查卡（自动重算）", ""]
    L.append(f"> {datetime.now():%Y-%m-%d %H:%M} · tools/cx_facts_card.py · "
             "全部机械汇总，夜刷覆盖；判读见各融合画像卡")
    L.append("")

    # 装机与浏览器扩展
    ext_path = STATIC / "extensions.json"
    if ext_path.exists():
        exts = json.loads(ext_path.read_text(encoding="utf-8"))
        by_br = Counter(e.get("browser") for e in exts)
        L.append("## 浏览器扩展（全名单）")
        L.append("")
        L.append("共 " + str(len(exts)) + " 个：" +
                 "、".join(f"{b} {n}" for b, n in by_br.most_common()))
        L.append("")
        for e in exts:
            L.append(f"- [{e.get('browser')}] {e.get('name')} "
                     f"v{e.get('version')}")
        L.append("")

    # 微信生态（实体登记）
    ent = sqlite3.connect(CX / "entities.db")
    ws = wechat_stats(ent)
    persons = ent.execute(
        "SELECT COUNT(*) FROM entities WHERE kind='person'").fetchone()[0]
    orgs = ent.execute(
        "SELECT COUNT(*) FROM entities WHERE kind='org'").fetchone()[0]
    L.append("## 人际登记")
    L.append("")
    L.append(f"- 实体：person {persons:,}（微信渠道 {ws['friends']:,}）"
             f" / org {orgs}")
    ent.close()
    L.append("")

    # 时间轴源分布 + 聊天轴
    tl = sqlite3.connect(CX / "timeline.db")
    total = tl.execute("SELECT COUNT(*) FROM events").fetchone()[0]
    L.append("## 主时间轴（按源）")
    L.append("")
    L.append(f"共 {total:,} 事件：")
    for src, n in tl.execute(
            "SELECT source, COUNT(*) FROM events "
            "GROUP BY source ORDER BY 2 DESC"):
        L.append(f"- {src}: {n:,}")
    chat = tl.execute(
        "SELECT COUNT(*), SUM(json_extract(payload,'$.total')) "
        "FROM events WHERE source='wechat_chat'").fetchone()
    if chat and chat[0]:
        L.append("")
        L.append(f"聊天轴：{chat[0]:,} 群·日 × {chat[1]:,} 条消息"
                 "（纯元数据，零内容）")
    tl.close()
    L.append("")

    # 嵌入进度（语义路由就绪度）
    idx = sqlite3.connect(REPO / "data" / "local_index" / "index.db")
    emb = idx.execute(
        "SELECT embedding_status, COUNT(*) FROM chunks "
        "GROUP BY embedding_status").fetchall()
    L.append("## 本地索引与嵌入进度")
    L.append("")
    for st, n in emb:
        L.append(f"- {st}: {n:,}")
    idx.close()

    OUT.write_text("\n".join(L), encoding="utf-8")
    print(f"事实速查卡 → {OUT}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
