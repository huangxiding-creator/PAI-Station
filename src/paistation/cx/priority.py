# -*- coding: utf-8 -*-
"""提取优先级打分：价值区 × 新近度 × 类型 − 体积 − 缓存出局。

F 组（Autopsy ingest 顺序+IFF 五条件）与 H 组（0.35 新近+0.25 频次+0.30 价值
−0.15 log 体积）公式的本地化简化。规则表为常量（同 _GROUP_RULES 风格），
膨胀后再 YAML 化（KapeFiles 式）。
"""
from __future__ import annotations

import math
import time

# 价值区：(路径子串, 加分, 理由)——主业>副业语料>智库>生成物>低价值
VALUE_ZONES: tuple[tuple[str, int, str], ...] = (
    ("07 任务", 40, "主业任务区"),
    ("白龟湖", 40, "主业项目"),
    ("江巷灌区", 40, "主业项目"),
    ("Com-Writer", 35, "主业写作语料"),
    ("总承包事业部", 35, "主业部门"),
    ("水利", 30, "主业水利线"),
    ("SELF_PROFILE", 30, "本人画像资产"),
    # 副业业务线（与图谱 _GROUP_RULES 同源词，须长于"07 任务"方能压过目录级）
    ("总包生态圈", 22, "副业生态圈"),
    ("总包学园", 22, "副业学园"),
    ("总包之声", 22, "副业媒体"),
    ("EPC总裁培训班", 22, "副业培训"),
    ("总包大家谈", 22, "副业栏目"),
    ("总包读书会", 22, "副业读书会"),
    ("总包千问", 22, "副业AI群"),
    ("总包沙龙", 22, "副业沙龙"),
    ("微信读书", 25, "副业阅读语料"),
    ("weread", 25, "副业阅读语料"),
    ("04 智库", 20, "智库语料"),
    ("Auto-wechat-article-exporter", 18, "副业公众号语料"),
    ("总包", 15, "副业内容线"),
    ("feishu", 20, "战略文档"),
    ("IdeaDig", 10, "创意生成物"),
    ("ResearchFactory-Eng", 8, "研究管线"),
    ("competitors-src", -30, "竞品源码低画像价值"),
)
# 出局区：缓存/自动化配置——直接建议 skipped
SKIP_ZONES: tuple[str, ...] = (
    ".chrome-profile", ".chrome_profile", ".browser_profile",
    "/Cache/", "/Code Cache/", "/GPUCache/",
)

# 扩展名类型分（文档为画像主力）
_EXT_SCORES: dict[str, int] = {
    ".md": 12, ".docx": 15, ".doc": 10, ".pdf": 15, ".xlsx": 14,
    ".xls": 8, ".pptx": 10, ".txt": 8, ".json": 6, ".csv": 8,
    ".html": 4, ".epub": 10, ".caj": 12, ".jpg": 2, ".png": 2,
    ".js": -5, ".dll": -20, ".exe": -20, ".so": -20, ".bin": -15,
}

_SKIP_THRESHOLD = -50  # ≤ 此分建议 status='skipped'


def score_file(path: str, size: float, mtime: float,
               now: float | None = None) -> tuple[float, str]:
    """单文件打分。返回 (priority, reason)；reason 拼出主因便于审计。"""
    now = time.time() if now is None else now
    p = path.replace("\\", "/")
    score = 0.0
    reasons: list[str] = []

    for zone in SKIP_ZONES:
        if zone in p:
            return -100.0, f"缓存区({zone})"
    if size <= 0:
        return -100.0, "空文件"
    # 价值区取最长关键词命中（等长时表中靠后者赢=更具体：07 任务/总包生态圈 → 副业）
    hits = [z for z in VALUE_ZONES if z[0] in p]
    hit = sorted(hits, key=lambda z: len(z[0]))[-1] if hits else None
    if hit:
        score += hit[1]
        reasons.append(hit[2])

    ext = p[p.rfind("."):].lower() if p.rfind(".") > p.rfind("/") else ""
    score += _EXT_SCORES.get(ext, 0)

    age_days = max(0.0, (now - mtime) / 86400)
    if age_days <= 90:
        score += 15
        reasons.append("新近")
    elif age_days <= 365:
        score += 8
    elif age_days <= 730:
        score += 3

    score -= 5 * math.log10(max(size, 1.0))  # 体积惩罚：1KB~1GB 差 15 分

    return round(score, 1), "+".join(reasons) if reasons else "常规"


def should_skip(score: float) -> bool:
    """缓存/负分文件建议直接 skipped（可逆，不删数据）。"""
    return score <= _SKIP_THRESHOLD
