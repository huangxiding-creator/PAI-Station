"""人生工作年报（提案第 24 章⑥）：叙事引擎 + 英雄之旅六章固定结构。

纯本地永不代发；叙事不编造——数据缺席的章节诚实写"暂无"。
"""


def _fmt(metrics: dict, key: str, suffix: str = "") -> str:
    val = metrics.get(key)
    return f"{val}{suffix}" if val is not None else "暂无"


def annual_report(metrics: dict) -> str:
    """年度指标 → 英雄之旅六章（启程/试炼/盟友/深渊/宝藏/归来）。"""
    year = metrics.get("year", "今年")
    topics = metrics.get("top_topics") or []
    hard = metrics.get("hard_moments") or []
    chapters = [
        f"第一章 启程——{year}，你和这台电脑一起出发",
        f"这一年它看见你沉淀 {_fmt(metrics, 'kb_docs', ' 篇')}文档、"
        f"完成 {_fmt(metrics, 'jobs_done', ' 件')}待办。",
        "",
        "第二章 试炼——那些反复出现的高地",
        ("你最常打交道的三件事："
         + "、".join(topics[:3]) if topics else "暂无明确高频主题"),
        "",
        "第三章 盟友——方法开始站在你这边",
        f" {_fmt(metrics, 'skill_cards', ' 张')}技能卡、"
        f"{_fmt(metrics, 'immune_rules', ' 条')}免疫规则——"
        "你踩过的坑正在变成你不踩的坑。",
        "",
        "第四章 深渊——硬仗时刻",
        ("硬仗清单：" + "；".join(hard[:3]) if hard
         else "暂无登记的硬仗（明年记得让账本记下它们）"),
        "",
        "第五章 宝藏——复利开始可见",
        f" {_fmt(metrics, 'fsrs_reviews', ' 次')}间隔复习、"
        f"{_fmt(metrics, 'adopted', ' 条')}建议被你采纳——"
        "成长不是感觉，是账本上的数字。",
        "",
        "第六章 归来——带着方法回到明年",
        "这一年最大的变化：方法不再是外面学的，是你自己的电脑陪你长出来的。",
    ]
    return "\n".join(chapters)
