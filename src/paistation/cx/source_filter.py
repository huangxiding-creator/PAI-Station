# -*- coding: utf-8 -*-
"""survey 后置信源筛（P0-J1，双百倍提案 2026-09-20）。

采集洪流里大量「仅提及企业名/纯行业泛谈」的噪声文件——打包前按
Jev noul@0.5 滤除（E3 分离缝同阈值；J1 阈值未经 E3 式实测校准，
落地为试点旗标，试点拿到分离结构后再定常开）。

fail-soft 方向与 J4 相反：Jev 缺席 → **全部保留**（src/paistation/cx/
jev_screen.py 的复核腿缺席=口径不变；过滤器缺席=不误杀信源——
滤掉一篇真信源的代价远大于多打包一篇噪声）。

免费优先纪律（用户 2026-09-20 重申）：Jev 是付费位，只对免费模型做不到
的概率判断使用；日常触发挂在自然 survey 收口顺带跑，不专门烧。
"""
from __future__ import annotations

from collections.abc import Callable

# 同 E3 分离缝（J1 试点后按实测分离结构校准）
JEV_KEEP_TH = 0.5

# 摘要截断：~500 字（提案 §2 J1 经济性估算口径）
HEAD_CHARS = 500

JevAsk = Callable[[dict, dict], "dict | None"]


def build_question() -> dict:
    """J1 问句：该文是否含目标企业的可引用事实。"""
    return {
        "type": "noul",
        "instructions": "以下文章内容中是否包含关于目标企业的可引用事实？",
        "criteria": {
            "true": "文章陈述了该企业名下的具体项目、业绩、人物、观点"
                    "或数据事实（中标/合同/技术/人事/财务等，同义表述也算）",
            "false": "文章仅提及企业名、纯行业泛谈或与他企业相关，"
                     "不含该企业自身的可引用事实",
        },
    }


def screen(text: str, enterprise: str,
           jev_ask: JevAsk) -> tuple[bool, "float | None"]:
    """单篇 → (keep, noul)。Jev 任何形态缺席 → (True, None) 全保留。"""
    state = {"目标企业": enterprise,
             "文章开头": (text or "").strip()[:HEAD_CHARS]}
    noul: float | None = None
    try:
        answers = jev_ask(state, {"hit": build_question()})
        if isinstance(answers, dict):
            noul = float(answers["hit"]["noul"])
    except (KeyError, TypeError, ValueError, OSError, RuntimeError):
        noul = None
    if noul is None:
        return True, None
    return noul >= JEV_KEEP_TH, noul


def filter_batch(rows: list[dict], enterprise: str,
                 jev_ask: JevAsk) -> tuple[list[dict], dict]:
    """rows=[{file,text},…] → (保留行, 汇总{total,kept,dropped,jev_screened})。"""
    kept: list[dict] = []
    m = {"total": len(rows), "kept": 0, "dropped": 0, "jev_screened": 0}
    for r in rows:
        keep, noul = screen(r.get("text", ""), enterprise, jev_ask)
        if keep:
            kept.append(r)
            m["kept"] += 1
        else:
            m["dropped"] += 1
        if noul is not None:
            m["jev_screened"] += 1
    return kept, m
