# -*- coding: utf-8 -*-
"""15 字段元数据垫片（Dublin Core × FAIR 子集）。

引擎只造槽位：本模块按字段清单给出确定性占位默认值；真实值
（source / checksum_slot / date 等）由后续 channel adapter 在文件落盘后回填，
回填不改变蓝图结构。date 采用固定占位纪元 1970-01-01，保证同输入同输出。
"""
import re

# FR2 规定的 15 字段（顺序即输出顺序）
FIELDS = ["title", "creator", "date", "format", "size_kb", "source", "badge", "perm",
          "language", "relation", "coverage", "rights", "identifier", "checksum_slot",
          "description"]

# 来源徽章 / 权限级（枚举闭集，来自已批准提案 FR2）
BADGES = ["green_free", "wenku_vip", "ima_public", "gb_free", "self_owned"]
PERM_LEVELS = ["green", "yellow", "red"]
PERM_BY_BADGE = {"green_free": "green", "wenku_vip": "yellow", "ima_public": "green",
                 "gb_free": "green", "self_owned": "green"}

# 三档配比（phi-1）与占位扩展名规则：core→pdf；field→docx/pdf/xlsx 轮转；guide→md
TIER_EXTS = {"core": ["pdf"], "field": ["docx", "pdf", "xlsx"], "guide": ["md"]}
TIER_LABEL = {"core": "主干教材级", "field": "领域补充", "guide": "合成导读"}

# 保守字节估算（每槽按类型，宁可低估不可虚标——数字零造假）
EXT_BYTES = {"pdf": 2_000_000, "docx": 800_000, "xlsx": 600_000, "md": 60_000}
EXT_MIME = {
    "pdf": "application/pdf",
    "docx": "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
    "xlsx": "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
    "md": "text/markdown",
}

DEFAULT_CREATOR = "总包智库研究团队"
PLACEHOLDER_DATE = "1970-01-01"  # 占位纪元：确定性优先，真实日期由 adapter 回填
RIGHTS_BY_PERM = {"green": "绿色通道·可自由使用", "yellow": "文库VIP授权·会员可用",
                  "red": "红色受限·单独审批"}


def sanitize_filename(name: str) -> str:
    """去掉 Windows 路径非法字符与空白，主题名可安全进占位文件名。"""
    return re.sub(r'[\\/:*?"<>|\s]+', "", name)


def pick_ext(tier: str, seq: int) -> str:
    """tier 档第 seq 个槽的扩展名（field 三轮转，确定性）。"""
    exts = TIER_EXTS[tier]
    return exts[(seq - 1) % len(exts)]


def badge_for_index(i: int) -> str:
    """按全局槽位序号轮转徽章（确定性分配，adapter 回填真实来源时可覆盖）。"""
    return BADGES[i % len(BADGES)]


def make_slot(*, name: str, tier: str, ext: str, theme: str, l1_name: str, domain: str,
              path: str, badge: str, perm: str, idx: int, need_hash8: str) -> dict:
    """造一个 15 字段元数据槽位（占位默认值，字段顺序=FIELDS）。"""
    if badge not in BADGES:
        raise ValueError(f"badge 越界: {badge}")
    if perm not in PERM_LEVELS:
        raise ValueError(f"perm 越界: {perm}")
    stem = name.rsplit(".", 1)[0]
    return {
        "title": stem,
        "creator": DEFAULT_CREATOR,
        "date": PLACEHOLDER_DATE,
        "format": EXT_MIME[ext],
        "size_kb": EXT_BYTES[ext] // 1024,
        "source": "channel_adapter_pending",
        "badge": badge,
        "perm": perm,
        "language": "zh-CN",
        "relation": path,
        "coverage": domain,
        "rights": RIGHTS_BY_PERM[perm],
        "identifier": f"KBC1-{need_hash8}-{idx:06d}",
        "checksum_slot": None,  # 真实文件落盘后由 adapter 回填校验和
        "description": f"{l1_name}/{theme} · {tier} 档占位槽位（{TIER_LABEL[tier]}），真实文件由渠道适配器回填",
    }
