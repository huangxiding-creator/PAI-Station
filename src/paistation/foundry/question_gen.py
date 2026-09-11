"""问题清单生成器（PROPOSAL_V2.md 5.2③）：毛选问题定义法的管线化。

毛选：解决问题的第一步是把问题搞清楚——涉及什么人、与外部事物的
关系、背景是什么。本模块把 master_framework 的每个节点 × 5W1H ×
利益相关方视角展开成自然语言问题，去重、分级，≥300 条为出厂硬门槛。
"""
from __future__ import annotations

import re
from dataclasses import dataclass, asdict

DEFAULT_MIN_QUESTIONS = 300
DEFAULT_MAX_QUESTIONS = 600

# 5W1H 问式（万维钢"把问题问到点上" × 毛选"涉及什么人/关系/背景"）
_W1H_TEMPLATES = {
    "what": "{node}中，{who}最需要搞清楚的核心事项是什么？",
    "why": "为什么{node}对{who}重要？背后的机制是什么？",
    "who": "{node}中，{who}与哪些其他相关方存在依赖或冲突关系？",
    "when": "{node}中，{who}需要把握的关键时间节点有哪些？",
    "where": "{node}在哪些场景或环节中对{who}生效？边界在哪里？",
    "how": "{who}应如何应对{node}中的风险与机会？有哪些已验证做法？",
}

# 利益相关方视角（工程域默认集，课题可扩展）
DEFAULT_STAKEHOLDERS = ("业主", "承包商", "监理", "设计方", "政府监管",
                        "供应商", "终端用户", "一线人员")

_LEVEL_RULES = (("must", 0.7), ("should", 0.4))  # 频次 → 级别


@dataclass(frozen=True)
class Question:
    """一条调研问题（不可变）。"""

    qid: str
    node_id: str
    w1h: str
    stakeholder: str
    text: str
    level: str  # must 必答 / should 应答 / may 可答


def _norm(text: str) -> str:
    """文本归一化（去空白与标点）用于去重。"""
    return re.sub(r"[\s，。？！、；：""''（）\[\]【】,.?!;:()\"']+", "", text)


def _grade(frequency: float) -> str:
    for level, floor in _LEVEL_RULES:
        if frequency >= floor:
            return level
    return "may"


def generate_questions(nodes: list[dict],
                       stakeholders: tuple[str, ...] = DEFAULT_STAKEHOLDERS,
                       templates: dict[str, str] | None = None,
                       max_questions: int = DEFAULT_MAX_QUESTIONS) -> list[Question]:
    """节点 × 问式 × 视角 → 去重分级的问题清单。

    nodes: [{id, title, frequency}]，frequency 为框架合成频次（0-1）。
    空 nodes 显式拒绝；输出按（级别, 节点频次）优先截断到 max_questions。
    """
    if not nodes:
        raise ValueError("框架节点为空——先完成框架合成再生成问题清单")
    tmpl = templates or _W1H_TEMPLATES
    seen: set[str] = set()
    raw: list[tuple[float, str, Question]] = []
    for node in nodes:
        freq = float(node.get("frequency", 0.0))
        level = _grade(freq)
        title = str(node.get("title", "")).strip() or node["id"]
        for w1h, pattern in tmpl.items():
            for who in stakeholders:
                text = pattern.format(node=title, who=who)
                key = _norm(text)
                if key in seen:
                    continue
                seen.add(key)
                q = Question(qid=f"Q{len(raw) + 1:04d}",
                             node_id=str(node["id"]), w1h=w1h,
                             stakeholder=who, text=text, level=level)
                raw.append((freq, level, q))
    order = {"must": 0, "should": 1, "may": 2}
    raw.sort(key=lambda row: (order[row[1]], -row[0], row[2].qid))
    return [q for _, _, q in raw[:max_questions]]


def check_gate(questions: list[Question],
               minimum: int = DEFAULT_MIN_QUESTIONS) -> tuple[bool, int]:
    """≥300 出厂硬门槛（低于则框架合成回炉，PROPOSAL_V2.md 5.2③）。"""
    count = len(questions)
    return (count >= minimum, count)


def to_records(questions: list[Question]) -> list[dict]:
    """序列化为可落盘的 dict 列表（question_list.json 的 items 字段）。"""
    return [asdict(q) for q in questions]
