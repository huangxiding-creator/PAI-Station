# -*- coding: utf-8 -*-
"""金标准命中口径纯函数（extract_tokens/is_hit/classify_miss）。

从 tools/cx_golden_score.py 抽出进 src——诊断工具与跑分器共用同一口径，
不许出现两套判定逻辑。
"""

from __future__ import annotations

import re

TOKEN_RE = re.compile(r"[一-龥]{2,}|[A-Za-z][A-Za-z0-9_-]{2,}|\d{2,}")

# 判定 v1.1（标点归一）：中文卷宗的标点变体（，'"「」与直引号混用、
# 手写卡 76 字折行断词）不构成语义差异——归一化对语料文本与答案 token
# 同规则适用，零裁量空间（区别于 LLM 判定的自由度）。
_PUNCT_STRIP_RE = re.compile(
    r"[\s，。、；：？！…·—\-~～「」『』“”‘’（）()【】\[\]{}<>《》*#>|/\\_=+&%$@^`'\"]+")
# 答案里的通用词（命中也不证明检对了文档）
GENERIC = {
    "什么", "如何", "我的", "自己", "关系", "岗位", "单位", "公司", "有限",
    "有限公司", "股份有限", "工程院", "研究院", "事业部", "信息化", "副业",
    "主业", "工作", "项目", "系统", "平台", "数据", "时间", "开始", "使用",
}


def _residual(token: str) -> str:
    """token 剔除全部通用子词与虚词后的残值——残值<2 字=整词皆通用，弃。"""
    r = token
    for g in GENERIC:
        if g in r:
            r = r.replace(g, "")
    for f in "与和的是了在及或为中":
        r = r.replace(f, "")
    return r


def extract_tokens(answer: str) -> list[str]:
    """答案 → 区分度 token（长词优先，剔通用词）。纯函数，测试覆盖。

    中文连续 run 不分词，故通用性判定用"剔通用子词看残值"：整串通用
    （如"我的主业单位与岗位是什么"）残值空 → 弃；含专名残值留 → 保。
    注：超长 run 滑窗细化（防语料标点变体切断匹配）已试并实测劣化
    （65→60：6 字窗挤掉真区分度短 token，如"黄河院"），弃用——
    标点变体缺口留给语义路由（嵌入天然容忍表述变体）。
    """
    toks = [t for t in TOKEN_RE.findall(answer)
            if t not in GENERIC and len(_residual(t)) >= 2]
    if not toks:
        return []
    longs = sorted((t for t in toks if len(t) >= 3), key=len, reverse=True)
    if longs:
        return longs[:3]
    shorts = sorted(toks, key=len, reverse=True)
    return shorts[:3]


def norm_text(t: str) -> str:
    """判定用归一化：剥标点/空白（中英文标点、引号家族、md 记号）。"""
    return _PUNCT_STRIP_RE.sub("", t)


def is_hit(hits: list, tokens: list[str], norm: bool = False) -> bool:
    """top-k 块任一含任一 token。hits=带 .text 属性的对象列表。

    norm=True 走 v1.1 标点归一判定（语料与 token 同规则，零裁量）。
    """
    if not tokens:
        return False
    if not norm:
        return any(tok in h.text for tok in tokens for h in hits)
    return any(norm_text(tok) in norm_text(h.text)
               for tok in tokens for h in hits)


def classify_miss(hits: list, tokens: list[str]) -> str:
    if not hits:
        return "零结果（索引无此词汇面）"
    if not tokens:
        return "答案无区分 token（考题待修）"
    return "词面不匹配（问答鸿沟：问题词≠文档词）"


# 考卷泄漏修复（09-20 用户裁决：查询侧排除）——金标准题面/答案/旧报告
# 被 localfiles 索引收录（实锤：#9 命中片段即旧跑分报告的未命中清单），
# 词面满分含「考卷进考场」成分。跑分检索一律先滤考卷来源。
EXAM_PATH_MARKERS = ("golden_set",)


def drop_exam_chunks(hits: list, markers: tuple = EXAM_PATH_MARKERS) -> list:
    """滤掉考卷来源 chunk（path 含任一 marker）。诊断工具与跑分器共用。"""
    return [h for h in hits
            if not any(m in (getattr(h, "path", "") or "") for m in markers)]
