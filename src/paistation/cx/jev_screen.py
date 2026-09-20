# -*- coding: utf-8 -*-
"""金标准 Jev 语义复核腿（P0-J4，2026-09-20 提案批准后产品化）。

E3 实验（tmp/jev_exp3_verify.py，SELF_PROFILE/golden_set/jev_e3_20260920.md）
实证的分离结构产品化：Jev Noul@0.5 对「检索片段是否含答案事实」的判定与
词面判定正交互补——

  词面 hit + Jev≥0.5 → confirmed   真阳（双路共识）
  词面 hit + Jev<0.5 → hollow       悬空（词面撞词但语义不答；E3 实测
                                     17/90 假阳注水全在此象限，noul≤0.48）
  词面 miss + Jev≥0.5 → semantic    语义等价命中（同义转述；E3 实测 3 题
                                     0.58-0.97，与 judge_v2 引文判翻中题一致）
  Jev 缺席（关/熔断/坏载荷/异常）→ lexical_only，词面口径原样（fail-soft
  契约：开关关掉=零影响，绝不反噬跑分主链）。

问句措辞钉死为 E3 实测版——措辞漂移会移动分离缝（needs_screen 四变体
实测教训：抽象问句诱导保守 0.17-0.27，具体问句 0.94/0.08）。
"""
from __future__ import annotations

from collections.abc import Callable

# 分离缝阈值：E3 实测 0.5 正切、两侧零跨界（真阳 min 0.58 / 假阳 max 0.48）
JEV_HIT_TH = 0.5

# jev_ask 契约：同 JudgmentClient.ask —— (state, questions) -> answers dict | None
JevAsk = Callable[[dict, dict], "dict | None"]


def build_question() -> dict:
    """E3 实测问句（钉字不改——见模块 docstring 措辞漂移教训）。"""
    return {
        "type": "noul",
        "instructions": "以下检索片段中是否包含能直接回答问题的内容？",
        "criteria": {
            "true": "某片段含答案所陈述的事实本身（同义表述、数字写法"
                    "变体、措辞改写也算）",
            "false": "片段只是与问题主题相关，但不含答案事实本身",
        },
    }


def screen(question: str, snippets: list[str], lexical_hit: bool,
           jev_ask: JevAsk) -> tuple[str, "float | None"]:
    """单题双判定 → (verdict, noul)。

    verdict ∈ confirmed / hollow / semantic / lexical_only。
    Jev 任何形态的缺席（None/坏载荷/抛异常）都落 lexical_only、
    noul=None——词面口径原样保留在行内（lexical_hit），复核腿绝不反噬主链。
    """
    state = {"问题": question, "检索片段top8": snippets}
    noul: float | None = None
    try:
        answers = jev_ask(state, {"hit": build_question()})
        if isinstance(answers, dict):
            noul = float(answers["hit"]["noul"])
    except (KeyError, TypeError, ValueError, OSError, RuntimeError):
        noul = None
    if noul is None:
        return "lexical_only", None
    jev_hit = noul >= JEV_HIT_TH
    if lexical_hit and jev_hit:
        return "confirmed", noul
    if lexical_hit and not jev_hit:
        return "hollow", noul
    if not lexical_hit and jev_hit:
        return "semantic", noul
    return "lexical_only", noul


def verdict_matrix(rows: list[dict]) -> dict:
    """逐题 verdict 行 → 汇总（含筛查面：Jev 实际参判的题数）。"""
    m = {k: 0 for k in ("confirmed", "hollow", "semantic", "lexical_only")}
    for r in rows:
        m[r["verdict"]] += 1
    m["total"] = len(rows)
    m["jev_screened"] = sum(1 for r in rows if r.get("noul") is not None)
    return m
