"""成长周报（提案第 23 章 T14 首版）：PGI/UGI 双成长指数 + 四段式周报。

PGI（产品成长指数）：技能卡/免疫规则/代办完成/知识库四指标加权。
UGI（用户成长指数）：采纳/复习/纠正/挑战四指标加权。
零数据 → 指数 0 + 诚实占位（不编造）。
"""
import math


def _bounded(x: float, cap: float) -> float:
    return min(x, cap) / cap


def pgi_score(skill_cards: int, immune_rules: int, jobs_done: int,
              kb_docs: int) -> int:
    """产品成长指数 0-100（对数压缩防长尾失真）。"""
    raw = (0.35 * _bounded(math.log1p(skill_cards), math.log1p(50))
           + 0.25 * _bounded(math.log1p(immune_rules), math.log1p(30))
           + 0.25 * _bounded(math.log1p(jobs_done), math.log1p(200))
           + 0.15 * _bounded(math.log1p(kb_docs), math.log1p(500)))
    return round(raw * 100)


def ugi_score(adopted: int, fsrs_reviews: int, corrections: int,
              challenges: int) -> int:
    """用户成长指数 0-100。"""
    raw = (0.35 * _bounded(adopted, 30)
           + 0.35 * _bounded(fsrs_reviews, 60)
           + 0.20 * _bounded(corrections, 20)
           + 0.10 * _bounded(challenges, 10))
    return round(raw * 100)


def weekly_report(metrics: dict) -> str:
    """四段式周报：本周产出/本周学习/用户成长/下周聚焦。"""
    skill = metrics.get("skill_cards", 0)
    immune = metrics.get("immune_rules", 0)
    jobs = metrics.get("jobs_done", 0)
    kb = metrics.get("kb_docs", 0)
    reviews = metrics.get("fsrs_reviews", 0)
    adopted = metrics.get("adopted", 0)
    corrections = metrics.get("corrections", 0)
    pgi = pgi_score(skill, immune, jobs, kb)
    ugi = ugi_score(adopted, reviews, corrections,
                    metrics.get("challenges", 0))
    lines = [
        "## 本周产出",
        f"- 知识库 {kb} 篇 · 代办完成 {jobs} 件"
        + (f" · 热点：{metrics['hot_topic']}" if metrics.get("hot_topic")
           else ""),
        "## 本周学习",
        f"- 技能卡 {skill} 张 · 免疫规则 {immune} 条（PGI {pgi}）",
        "## 用户成长",
        f"- 复习 {reviews} 次 · 采纳 {adopted} 条 · 纠正 {corrections} 次"
        f"（UGI {ugi}）",
        "## 下周聚焦",
        (f"- 围绕『{metrics['hot_topic']}』沉淀第 {skill + 1} 张技能卡"
         if metrics.get("hot_topic")
         else "- 暂无明确热点——下周从高频任务中探测"),
    ]
    return "\n".join(lines)
