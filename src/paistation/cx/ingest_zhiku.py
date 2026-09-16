# -*- coding: utf-8 -*-
"""CX 观点维：04 智库各渠道策展条目扫描入库（本人 9-16 指令：
观点维直接用项目智库各渠道内容——收藏/付费/策展=思想取向信号）。

粒度克制：渠道 topic + 书/课程/专题级条目；文章级（AGI 3398 篇）只计数不建实体。
"""

from __future__ import annotations

from pathlib import Path

OWNER_EID = "person/总包君"

CHANNELS = ("微信读书", "混沌学园", "一堂", "万维钢调研方法论",
            "通往AGI之路", "洞见研报")

_SKIP = {"README.md", "README.docx", "_mining", "_recon", "skills",
         "_state.json", "_credentials", "internal"}


def scan_zhiku(root: Path) -> list[tuple[str, str]]:
    """04 智库根 → [(渠道, 策展条目名)]。"""
    items: list[tuple[str, str]] = []
    weread = root / "微信读书"
    if weread.is_dir():
        items += [("微信读书", f"书：{p.name}")
                  for p in weread.iterdir() if p.is_dir()]
    hundun = root / "混沌学园"
    if hundun.is_dir():
        for p in hundun.glob("*.md"):
            if p.stem not in _SKIP and not p.stem.startswith("README"):
                items.append(("混沌学园", f"课：{p.stem}"))
    for chan, prefix in (("一堂", "课"), ("万维钢调研方法论", "文")):
        d = root / chan
        if d.is_dir():
            for p in sorted(d.iterdir()):
                if p.is_file() and p.stem not in _SKIP and not p.name.startswith("README"):
                    items.append((chan, f"{prefix}：{p.stem}"[:40]))
    dj = root / "洞见研报"
    if dj.is_dir():
        items += [("洞见研报", f"专题：{p.name}")
                  for p in dj.iterdir() if p.is_dir()]
    agi = root / "通往AGI之路"
    if agi.is_dir():
        items.append(("通往AGI之路", "知识地图：通往AGI之路（3398 篇镜像）"))
    return items


def register_zhiku(store, items: list[tuple[str, str]],
                   owner_eid: str = OWNER_EID) -> int:
    """策展条目 → topic 实体 + curated_by 边 + 渠道 part_of。返回新建边数。"""
    from paistation.cx.entities import _slug

    created = 0
    for chan, name in items:
        store.register("topic", chan, source="zhiku")
        store.register("topic", name, source="zhiku")
        item_eid = f"topic/{_slug(name)}"
        created += int(store.register_link(item_eid, f"topic/{chan}",
                                           "part_of", "zhiku"))
        created += int(store.register_link(item_eid, owner_eid,
                                           "curated_by", "zhiku"))
    store._conn.commit()
    return created
