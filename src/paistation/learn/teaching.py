"""教学三档（提案第 23 章 T15）：L1 教我懂 / L2 带我练 / L3 一分钟复盘。

责任阶梯复用为教学档位——产品替用户做，也教用户会做（共成长外螺旋）。
纯规则首版；LLM 增强位留 deep_fn 注入（缺席不崩）。
"""


def socratic_questions(topic: str, depth: int = 3) -> list[str]:
    """L1 苏格拉底式追问：围绕主题的层层递进问题链。"""
    return [
        f"你说的『{topic}』，能用一句话说清它解决什么问题吗？",
        f"如果不用『{topic}』，你会怎么做？代价差在哪？",
        f"『{topic}』第一次实际用，你会挑什么场景试？为什么是它？",
    ][:max(1, depth)]


def scaffold_feedback(draft: str, exemplar: str,
                      checklist: tuple) -> dict:
    """L2 脚手架：初稿对照范本+检查单 → 覆盖/缺失反馈。"""
    items = [str(c) for c in checklist]
    covered = [c for c in items if c in draft]
    missing = [c for c in items if c not in draft]
    exemplar_steps = [c for c in items if c in exemplar]
    return {"covered": covered, "missing": missing,
            "draft_steps": [c for c in items if c in draft] or
            [w for w in draft.split() if w][:5],
            "exemplar_steps": exemplar_steps,
            "hint": f"对照范本缺：{'、'.join(missing)}" if missing
            else "检查单全覆盖"}


def minute_recap(task: str, outcome: str, lesson: str) -> str:
    """L3 替我做 + 一分钟复盘：做完即复盘（经验→显性知识）。"""
    return (f"【一分钟复盘】{task}\n"
            f"- 结果：{outcome}\n"
            f"- 下次更快一步的诀窍：{lesson}\n"
            f"- 这个诀窍值得变成技能卡吗？（≥3 次复用就出卡）")
