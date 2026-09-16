# -*- coding: utf-8 -*-
"""CX 双角色视角层：主业（黄河设计院）× 副业（总包说）× 个人线。

归属由 operated_by/owned_by 边决定（本人 2026-09-16 判据：按报告落款单位）；
角色沿 part_of/member_of 边向群成员传导。查询层纯派生，不新增状态。
"""

from __future__ import annotations

MAIN_ORG = "org/黄河勘测规划设计研究院"
SIDE_ORG = "org/总包说-海南-教育科技有限公司"
OWNER_EID = "person/总包君"


def role_of_org(store, org_eid: str) -> str | None:
    """机构/群实体 → 角色（主/副）。群经 part_of→project→operated_by 传导。"""
    owner = store._conn.execute(
        "SELECT to_id FROM entity_links WHERE from_id=? AND relation='operated_by'",
        (org_eid,),
    ).fetchone()
    if owner:
        return ("main" if owner[0] == MAIN_ORG
                else "side" if owner[0] == SIDE_ORG else None)
    # 群 → 所属项目 → 项目归属
    proj = store._conn.execute(
        "SELECT to_id FROM entity_links WHERE from_id=? AND relation='part_of' "
        "AND to_id LIKE 'project/%'", (org_eid,)
    ).fetchone()
    if proj:
        return role_of_project(store, str(proj[0]))
    return None


def role_of_project(store, project_eid: str) -> str | None:
    """项目 → 角色：operated_by 主业机构=main / 副业公司=side；
    仅 owned_by 本人=personal。"""
    owner = store._conn.execute(
        "SELECT to_id FROM entity_links WHERE from_id=? AND relation='operated_by'",
        (project_eid,),
    ).fetchone()
    if owner:
        if owner[0] == MAIN_ORG:
            return "main"
        if owner[0] == SIDE_ORG:
            return "side"
        return None
    owned = store._conn.execute(
        "SELECT 1 FROM entity_links WHERE from_id=? AND relation='owned_by'",
        (project_eid,),
    ).fetchone()
    return "personal" if owned else None


def entity_roles(store, person_eid: str) -> set[str]:
    """人物 → 角色集合（member_of 群传导 + works_on 项目直挂；跨角色多值）。"""
    roles: set[str] = set()
    groups = store._conn.execute(
        "SELECT to_id FROM entity_links WHERE from_id=? AND relation='member_of' "
        "AND to_id LIKE 'org/%'", (person_eid,)
    ).fetchall()
    for (gid,) in groups:
        r = role_of_org(store, str(gid))
        if r:
            roles.add(r)
    projects = store._conn.execute(
        "SELECT to_id FROM entity_links WHERE from_id=? AND relation='works_on' "
        "AND to_id LIKE 'project/%'", (person_eid,)
    ).fetchall()
    for (pid,) in projects:
        r = role_of_project(store, str(pid))
        if r:
            roles.add(r)
    return roles


ROLE_LABELS = {"main": "主业 · 黄河设计院", "side": "副业 · 总包说",
               "personal": "个人线"}
