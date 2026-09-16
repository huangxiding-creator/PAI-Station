# -*- coding: utf-8 -*-
"""CX 域1 非代码项目实体化：群名业务线 + 会议主题项目 + 白龟湖目录项目。

数据驱动（规则表按今日实勘的群名/会议主题写定，不臆造）：
- 群名 → project 业务线（总包之声/学园/沙龙…联营群名含 ×总包之声 自动归并）
- 会议主题 → project（江巷灌区信息化/总包大家谈/EPC总裁培训班…）
  + topic（工程豹/工程大脑/水利安全AI眼镜——AI 产品概念）
- 白龟湖生态环境保护 EPC（D:\\20 白龟湖项目\\，含大浪河子项目）→ project + part_of
归属边：主业项目 operated_by → 黄河设计院；副业业务线 operated_by → 总包说(海南)。
"""

from __future__ import annotations

import re

# (子串, 业务线名) —— 有序，先具体后宽泛；匹配用子串包含
_GROUP_RULES: list[tuple[str, str]] = [
    ("总包学园", "总包学园"),
    ("总包读书", "总包读书会"),
    ("总包千问AI", "总包千问AI"),
    ("总包沙龙", "总包沙龙"),
    ("总包生态圈", "总包生态圈"),
    ("项目总包实战", "项目总包实战交流"),
    ("总包之声", "总包之声"),  # 含全部 ×总包之声 联营群
]

# 会议主题关键词 → (kind, name)
_MEETING_RULES: list[tuple[str, tuple[str, str]]] = [
    ("江巷灌区", ("project", "江巷灌区信息化")),
    ("总包大家谈", ("project", "总包大家谈")),
    ("EPC总裁培训班", ("project", "EPC总裁培训班")),
    ("总包生态圈", ("project", "总包生态圈")),
    ("工程豹", ("topic", "工程豹")),
    ("工程大脑", ("topic", "工程大脑")),
    ("水利安全AI眼镜", ("topic", "水利安全AI眼镜")),
]

_MAIN_EMPLOYER = "org/黄河勘测规划设计研究院"
_SIDE_COMPANY = "org/总包说-海南-教育科技有限公司"
# 主业项目（设计院总承包线）——其余已归属业务线默认副业
_MAIN_PROJECTS = {"江巷灌区信息化"}

_WHITEBAIGUIHU = ("project", "白龟湖生态环境保护EPC", ["白龟湖", "大浪河项目"])
_DALANGHE = ("project", "大浪河治理工程", ["大浪河"])


def classify_group_project(name: str) -> str | None:
    """群名 → 业务线 project 名；无法归属返回 None（克制不硬凑）。"""
    for key, line in _GROUP_RULES:
        if key in name:
            return line
    return None


def extract_meeting_projects(subject: str) -> list[tuple[str, str]]:
    """会议主题 → [(kind, name)]（可多命中）；快速会议等泛名返回空。"""
    hits: list[tuple[str, str]] = []
    for key, target in _MEETING_RULES:
        if key in subject and target not in hits:
            hits.append(target)
    return hits


def _operated_by_target(name: str) -> str:
    """业务线/项目归属：主业项目→设计院，其余→总包说（副业矩阵）。"""
    return _MAIN_EMPLOYER if name in _MAIN_PROJECTS else _SIDE_COMPANY


def _ensure_orgs(store) -> None:
    """归属目标先落地（幂等），避免边悬空指向不存在的实体。"""
    store.register("org", "黄河勘测规划设计研究院",
                   aliases=["黄河设计院"], source="owner_statement")
    store.register("org", "总包说(海南)教育科技有限公司",
                   aliases=["总包说"], source="feishu_group")


def register_group_projects(store) -> int:
    """扫 org 群实体 → 登记 project 业务线 + part_of + operated_by。返回新建边数。"""
    _ensure_orgs(store)
    created = 0
    rows = store._conn.execute(
        "SELECT entity_id, display_name FROM entities WHERE kind='org'"
    ).fetchall()
    for eid, name in rows:
        line = classify_group_project(str(name))
        if not line:
            continue
        store.register("project", line, source="group_line")
        created += int(store.register_link(
            str(eid), f"project/{line}", "part_of", "group_name"))
        created += int(store.register_link(
            f"project/{line}", _operated_by_target(line), "operated_by",
            "owner_context"))
    store._conn.commit()
    return created


def register_meeting_projects(store, subjects: list[str]) -> int:
    """会议主题列表 → 登记 project/topic。返回新建实体数。"""
    _ensure_orgs(store)
    created = 0
    for subj in subjects:
        for kind, name in extract_meeting_projects(subj):
            _, new = store.register(kind, name, source="meeting_subject")
            created += int(new)
            if kind == "project":
                store.register_link(
                    f"project/{name}", _operated_by_target(name),
                    "operated_by", "owner_context")
    store._conn.commit()
    return created


def register_baiguihu(store, exists: bool = True) -> int:
    """白龟湖生态环境保护 EPC（含大浪河子项目，主业线）。exists=False 供测试。"""
    _ensure_orgs(store)
    created = 0
    for kind, name, aliases in (_WHITEBAIGUIHU, _DALANGHE):
        _, new = store.register(kind, name, aliases=aliases,
                                source="local_directory")
        created += int(new)
    created += int(store.register_link(
        "project/大浪河治理工程", "project/白龟湖生态环境保护EPC",
        "part_of", "local_directory"))
    for pid in ("project/白龟湖生态环境保护EPC", "project/大浪河治理工程"):
        created += int(store.register_link(
            pid, _MAIN_EMPLOYER, "operated_by", "owner_context"))
    store._conn.commit()
    return created
