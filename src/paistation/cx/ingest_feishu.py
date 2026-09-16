# -*- coding: utf-8 -*-
"""CX 域2 飞书：会话列表/群成员 → 实体登记表。

- p2p 会话 → person 实体（open_id 强标识符进别名）+ 与主人 associate_of 边
  （飞书无好友概念，"有过直接对话渠道"即关联；系统助手不过滤——从不活跃，
  后续按互动度自然沉底，诚实保留）
- group 会话 → org 实体（chat_id 进别名）；成员 → member_of 边
- 拉取经 lark-cli（user 身份），账号安全：每请求间由 driver 节流。
"""

from __future__ import annotations

import json


def parse_lark_chats(json_text: str) -> tuple[list[dict], list[dict]]:
    """lark +chat-list 导出 → (p2p 列表, group 列表)。

    p2p: {chat_id, name, open_id}；group: {chat_id, name}。空名跳过。
    """
    try:
        rows = json.loads(json_text).get("data", {}).get("chats", [])
    except ValueError:
        return [], []
    p2p: list[dict] = []
    groups: list[dict] = []
    for c in rows:
        name = (c.get("name") or "").strip()
        cid = (c.get("chat_id") or "").strip()
        if not name or not cid:
            continue
        if c.get("chat_mode") == "p2p":
            p2p.append({
                "chat_id": cid,
                "name": name,
                "open_id": (c.get("p2p_target_id") or "").strip(),
            })
        else:
            groups.append({"chat_id": cid, "name": name})
    return p2p, groups


def parse_lark_members(json_text: str) -> list[dict]:
    """lark +chat-members-list 导出 → [{open_id, name}]（users+bots 合并）。"""
    try:
        data = json.loads(json_text).get("data", {})
    except ValueError:
        return []
    rows: list[dict] = []
    for bucket in ("users", "bots"):
        for m in data.get(bucket) or []:
            name = (m.get("name") or "").strip()
            mid = (m.get("member_id") or "").strip()
            if name and mid:
                rows.append({"open_id": mid, "name": name})
    return rows


def register_lark_chats(store, p2p: list[dict], groups: list[dict], owner_eid: str | None):
    """p2p → person+associate_of(→主人)；group → org。返回 (org_eids, stats)。"""
    persons_created = 0
    links = 0
    for c in p2p:
        aliases = [c["open_id"]] if c["open_id"] else None
        eid, is_new = store.register("person", c["name"], aliases=aliases, source="feishu")
        persons_created += int(is_new)
        if owner_eid:
            links += int(store.register_link(eid, owner_eid, "associate_of", "feishu"))
    org_eids: dict[str, str] = {}
    groups_created = 0
    for g in groups:
        eid, is_new = store.register(
            "org", g["name"], aliases=[g["chat_id"]], source="feishu_group"
        )
        org_eids[g["chat_id"]] = eid
        groups_created += int(is_new)
    return org_eids, {
        "persons_created": persons_created,
        "groups_created": groups_created,
        "links": links,
    }


def register_lark_members(store, group_eid: str, members: list[dict]) -> dict:
    """群成员（含 bot）→ person 实体 + member_of 边。幂等。"""
    links = 0
    for m in members:
        eid, _ = store.register(
            "person", m["name"], aliases=[m["open_id"]], source="feishu_group"
        )
        links += int(store.register_link(eid, group_eid, "member_of", "feishu_group"))
    return {"members": len(members), "links": links}
