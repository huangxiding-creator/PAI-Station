"""六维理解框架：事实×行为×关系×观点×节律×演化。

2026-09-16 用户拍板为 CX 工程顶层方法。每个维度三件套：
- 数据源映射（DIMENSION_FEEDS：新源接入时登记）
- 成熟度等级（L0-L4，附证据）
- 量化探针（从主时间轴/资产 census 实读数字）
"""

from __future__ import annotations

import json
import sqlite3
from enum import Enum
from pathlib import Path

LEVEL_NAMES = {
    0: "L0 无数据",
    1: "L1 数据在位",
    2: "L2 管线化",
    3: "L3 融合可检索",
    4: "L4 可评测",
}


class Dimension(str, Enum):
    FACT = "fact"            # 事实：有什么（装机/工作账户/文件；个人消费不入，目的边界 2026-09-16）
    BEHAVIOR = "behavior"    # 行为：做什么（应用流/文档/命令行/浏览）
    RELATION = "relation"    # 关系：和谁（人/组织图谱）
    OPINION = "opinion"      # 观点：信什么（划线/收藏/发言）
    RHYTHM = "rhythm"        # 节律：何时（作息/周期/季节）
    EVOLUTION = "evolution"  # 演化：怎么变（主题迁移/技能成长）


DIMENSION_FEEDS: dict[Dimension, list[str]] = {
    Dimension.FACT: [
        "static_inventory", "localfiles_index", "installed_apps",
        "work_accounts",
    ],
    Dimension.BEHAVIOR: [
        "activities_cache", "recent_lnk", "git", "browser_history",
        "shell_history", "signal_service",
    ],
    Dimension.RELATION: [
        "wechat_contacts", "wechat_db", "feishu", "wecom", "contacts",
        "meetings", "entity_registry", "git_authors",
    ],
    Dimension.OPINION: [
        "weread_notes", "bookmarks", "favorites", "chat_statements",
    ],
    Dimension.RHYTHM: [
        "power_system", "activities_daily", "presence",
    ],
    Dimension.EVOLUTION: [
        "git_history", "activities_history", "profile_versions",
        "timeline_longitudinal",
    ],
}

# 当前等级（诚实定级：证据见 tools/cx_dimensions.py 输出）
CURRENT_LEVELS: dict[Dimension, int] = {
    Dimension.FACT: 2,
    Dimension.BEHAVIOR: 2,
    Dimension.RELATION: 2,
    Dimension.OPINION: 1,
    Dimension.RHYTHM: 1,
    Dimension.EVOLUTION: 1,
}

LEVEL_EVIDENCE: dict[Dimension, str] = {
    Dimension.FACT: "静态清点两波（143程序/20扩展/184Recent）+ localfiles 29.6万文件 L0-L4 提取夜跑；工作账户未采（个人消费/订阅按目的边界不采）",
    Dimension.BEHAVIOR: "主时间轴 10601 事件 8 源（活动/git/Recent/电源/浏览器三套/会议），幂等可重跑；信号流未入轴",
    Dimension.RELATION: "实体登记表 27142（person 26948/org 177/project 17；四渠道：微信好友 2832+微信 166 群成员+飞书 29 p2p 与 12 群+企微会议参与人+git 作者）+ 边 34388（friend_of 2746/member_of 31608/associate_of 30/alter_ego_of 4）；主人身份簇 12 标识五渠道闭环（真名黄细丁=git邮箱=微信号=3个wxid=企微=飞书open_id=QQ号），AI 分身族挂 alter_ego_of；活跃度加权 v1：22833 人计分（会话新鲜度+会议同场+群摊派封顶）；企微 77 场会议详情已入 20 场（频控断点续跑中），钉钉未登录",
    Dimension.OPINION: "浏览器书签三套已采；微信读书划线首次拉取为空(reviews.jsonl 0条，需按weread渠道重拉)",
    Dimension.RHYTHM: "电源+活动事件可算作息（首登07:22已出首个洞察），未常态化月度产出",
    Dimension.EVOLUTION: "git 两年史+活动史纵向数据在轴，未做主题迁移/成长曲线分析",
}


def probe_timeline(db_path: str | Path) -> dict:
    """从主时间轴实读量化信号（文件缺失时返回空 dict，不炸）。"""
    p = Path(db_path)
    if not p.exists():
        return {}
    conn = sqlite3.connect(str(p))
    try:
        def one(sql: str, args: tuple = ()) -> int:
            row = conn.execute(sql, args).fetchone()
            return int(row[0]) if row and row[0] is not None else 0

        by_source = {
            str(s): one("SELECT COUNT(*) FROM events WHERE source=?", (s,))
            for s in (r[0] for r in conn.execute("SELECT DISTINCT source FROM events"))
        }
        return {
            "total_events": one("SELECT COUNT(*) FROM events"),
            "by_source": by_source,
            "distinct_days": one("SELECT COUNT(DISTINCT substr(start,1,10)) FROM events"),
            "git_months": one(
                "SELECT COUNT(DISTINCT substr(start,1,7)) FROM events WHERE source='git'"
            ),
            "power_days": one(
                "SELECT COUNT(DISTINCT substr(start,1,10)) FROM events WHERE source='power_system'"
            ),
            "activity_days": one(
                "SELECT COUNT(DISTINCT substr(start,1,10)) FROM events WHERE source='activities_cache'"
            ),
        }
    finally:
        conn.close()


def probe_assets(static_dir: str | Path, weread_notes: str | Path | None = None) -> dict:
    """从静态清点/划线资产实读计数（缺文件记 None，诚实呈现）。"""
    out: dict = {}
    sd = Path(static_dir)
    for key, name in (
        ("installed_apps", "uninstall.json"),
        ("browser_extensions", "extensions.json"),
        ("recent_lnk", "recent.json"),
    ):
        f = sd / name
        try:
            data = json.loads(f.read_text(encoding="utf-8-sig"))
            if isinstance(data, dict) and key == "recent_lnk":
                out[key] = data.get("total_lnk")
            else:
                out[key] = len(data)
        except (OSError, ValueError):
            out[key] = None
    if weread_notes and Path(weread_notes).exists():
        try:
            out["weread_note_lines"] = sum(
                1 for _ in Path(weread_notes).open(encoding="utf-8", errors="replace")
            )
        except OSError:
            out["weread_note_lines"] = None
    else:
        out["weread_note_lines"] = None
    return out


def coverage_report(timeline_probe: dict, asset_probe: dict) -> dict:
    """六维记分卡：等级 + 证据 + 探针，供报告生成与后续月度对比。"""
    return {
        dim.value: {
            "level": CURRENT_LEVELS[dim],
            "level_name": LEVEL_NAMES[CURRENT_LEVELS[dim]],
            "evidence": LEVEL_EVIDENCE[dim],
            "feeds": DIMENSION_FEEDS[dim],
        }
        for dim in Dimension
    } | {"probe_timeline": timeline_probe, "probe_assets": asset_probe}
