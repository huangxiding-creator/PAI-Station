# -*- coding: utf-8 -*-
"""research_methodology.py — P0-6 (1028) 三技能蒸馏收编·产线件.

蒸馏源 (super-skill references/research-methodology.md, 双源):
  桌研 = 万维钢: 五本书梯度 (①通俗畅销书建基本盘 ②热门书记下最激发想象力的
          细节 ③专家视角书建大局观 ④硬书=专家写给专家识别当前专家最感兴趣
          话题 ⑤未来走向书感知前沿) + 思维密集度选源 + 读书抓三点
          (领域历史叙事/行话术语/让自己兴奋的东西);
  田野 = 何晓斌《怎么做调研，如何写报告》: 报告五步
          (立好意→定好题→理思路→搭架子→用资料[精/准/新]).

产线挂点 (函数级, 零重型依赖, 纯 stdlib):
  选题时 → five_books_gradient(topic, sources)  五本书梯度扫描+选源建议
  写报时 → report_five_steps_check(meta)        报告五步自查 (立意/题/思/架/料)

铁律: 只做方法层检查与建议, 不编数据; 判定结果全部给 rule+evidence 可审计.
CLI:
  py reforge_factory/research_methodology.py gradient --topic "EPC 海外计价"
  py reforge_factory/research_methodology.py fivecheck --meta-json meta.json
"""
from __future__ import annotations

import argparse
import json
import re
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

# ---------- 万维钢五本书梯度 (原文要义, 逐级verbatim锚定) ----------
GRADIENT = [
    {"level": "L1", "name": "通俗畅销书", "purpose": "建基本盘",
     "hunt": "领域全貌与非专业读者的共识叙述; 思维密集度低, 用来快速入门",
     "signals": ["科普", "畅销", "入门", "通俗", "漫画", "大众", "媒体转述",
                 "公众号", "新闻稿", "白话"]},
    {"level": "L2", "name": "热门书", "purpose": "记下最激发想象力的细节",
     "hunt": "领域当下热度最高的细节与案例 (为立意储备'让自己兴奋的东西')",
     "signals": ["热点", "案例集", "风口", "热门", "实战笔记", "复盘"]},
    {"level": "L3", "name": "专家视角书", "purpose": "建大局观",
     "hunt": "领域专家面向从业者写的体系书/教材/综述 — 主要矛盾与领域历史叙事",
     "signals": ["教材", "综述", "专著", "教科书", "概论", "原理", "导论",
                 "手册", "行业报告"]},
    {"level": "L4", "name": "硬书 (专家写给专家)", "purpose": "识别当前专家最感兴趣的话题",
     "hunt": "一手硬源: 标准/规范/官方文档/源码/学术文献/定额 — 硬书层结论优先",
     "signals": ["标准", "规范", "GB", "定额", "官方", "政府", "部委", "政策",
                 "学术", "论文", "journal", "源码", "技术规范", "白皮书",
                 "statistics", "统计局", "年报", "法规"]},
    {"level": "L5", "name": "未来走向书", "purpose": "感知前沿",
     "hunt": "前沿交叉点 (教科书空白处, 最有争议=最活跃处), 未来5-10年走势",
     "signals": ["前沿", "趋势", "未来", "展望", "预测", "2030", "2035",
                 "路线图", "颠覆", "新兴"]},
]

READING_THREE_TAKES = ["领域历史叙事 (主要矛盾)", "行话术语", "让自己兴奋的东西"]
DENSITY_RULE = "思维密集度 = 准备这份读物所需总时间 ÷ 阅读它所需时间 (选源性价比排序)"


def _classify(source: str) -> list[str]:
    """按信号词归类到梯度层 (一个源可命中多层 — 如'标准'兼为 L4 与立意锚)."""
    s = str(source)
    return [g["level"] for g in GRADIENT
            if any(sig.lower() in s.lower() for sig in g["signals"])]


def five_books_gradient(topic: str, sources: list | None = None) -> dict:
    """选题时五本书梯度扫描.

    sources: 候选源清单 (str 或 {name,...}); 缺省只出梯度模板+选源指引.
    返回 {topic, ladder[{level,name,purpose,hunt,coverage,items}], gaps,
    recommendations, reading_takes, density_rule}.
    """
    ladder = {g["level"]: {**g, "coverage": 0, "items": []} for g in GRADIENT}
    for src in sources or []:
        name = src if isinstance(src, str) else str(
            src.get("name") or src.get("title") or src)
        levels = _classify(name) or ["L1"]        # 未命中信号词按 L1 保守归
        for lv in levels:
            ladder[lv]["coverage"] += 1
            ladder[lv]["items"].append(name)
    gaps = [lv for lv, g in ladder.items() if g["coverage"] == 0]
    recs = []
    if "L4" in gaps:
        recs.append("L4 硬书层缺位 — 选题未锚定一手硬源 (标准/官方文档/学术), "
                    "硬书层结论优先原则落空, 补齐后再进可行性")
    if "L3" in gaps:
        recs.append("L3 大局观缺位 — 无综述/教材级体系书, 领域主要矛盾易误判")
    if "L5" in gaps:
        recs.append("L5 前沿缺位 — 无趋势/展望源, 到达前沿 (交叉点=机遇) 无着力点")
    if "L2" in gaps:
        recs.append("L2 热门细节缺位 — 无热门案例/复盘源, 立意缺'最激发想象力的细节'储备")
    if not gaps:
        recs.append("五层梯度齐备 — 按 " + DENSITY_RULE + " 排序消化, "
                    "硬书层 (L4) 结论优先, 转述层 (L1) 只作背景")
    return {"topic": topic,
            "ladder": [ladder[g["level"]] for g in GRADIENT],
            "gaps": gaps, "recommendations": recs,
            "reading_takes": READING_THREE_TAKES,   # 每层读书抓三点
            "density_rule": DENSITY_RULE,
            "ts": time.strftime("%Y-%m-%d %H:%M")}


# ---------- 何晓斌报告五步 (原文要义) ----------
FIVE_STEPS = [
    ("立好意", "立意是报告的魂: 明确·集中·新颖; 聚焦锁定一个核心问题组织全部资料"),
    ("定好题", "标题交代调研对象+主题事由; 设问式主标题+范围副标题优于描述式; 文字简短"),
    ("理思路", "资料去粗取精/去伪存真/由此及彼/由表及里后形成组织主线"),
    ("搭架子", "先定报告类型再定四梁八柱 (一二三级标题树); 防不分主次与资料错用"),
    ("用资料", "精 (只选与主题框架密切相关) · 准 (来源可查, 标注时间地点出处) · "
               "新 (量化数据用最新, 定性用一手)"),
]


def report_five_steps_check(meta: dict) -> dict:
    """写报时五步自查 (函数级启发式; 每条给 rule+evidence, 不编数据).

    meta 形状 (全部可选, 缺项如实报 fail):
      core_question: str            核心问题 (立意)
      title, subtitle: str          主标题/副标题
      thesis_line: str              组织主线一句话 (理思路)
      chapters: [{"title":.., "level":1|2|3, "key":..}]   标题树 (搭架子)
      evidence: [{"src":.., "date":"YYYY-MM-DD", "chapter_key":..}]  (用资料)
    """
    out = {"steps": [], "pass_all": True, "ts": time.strftime("%Y-%m-%d %H:%M")}

    def step(name, desc, ok, rule, evidence):
        s = {"step": name, "desc": desc, "pass": bool(ok),
             "rule": rule, "evidence": evidence}
        out["steps"].append(s)
        out["pass_all"] = out["pass_all"] and bool(ok)

    # 1 立好意: 单一明确核心问题
    cq = str(meta.get("core_question", "")).strip()
    step("立好意", FIVE_STEPS[0][1], len(cq) >= 8 and cq.count("？") + cq.count("?") <= 1,
         "core_question 非空且至多一个问号 (明确·集中; 新颖由人工判)",
         f"core_question={cq[:60]!r}" if cq else "core_question 缺失")

    # 2 定好题: 主标题简短 + 交代对象/事由; 设问式主标题或范围副标题加分
    t = str(meta.get("title", "")).strip()
    sub = str(meta.get("subtitle", "")).strip()
    ok_title = bool(t) and len(t) <= 30
    evidence = f"主标题 {len(t)} 字"
    if sub:
        evidence += f" + 范围副标题 {len(sub)} 字"
    elif "？" in t or "?" in t:
        evidence += " (设问式主标题)"
    else:
        ok_title = ok_title and False
        evidence += " — 既无设问式主标题也无范围副标题"
    step("定好题", FIVE_STEPS[1][1], ok_title,
         "标题<=30字且 (设问式主标题 或 范围副标题); 冗长标题暴露概括力不足", evidence)

    # 3 理思路: 一句话主线
    tl = str(meta.get("thesis_line", "")).strip()
    step("理思路", FIVE_STEPS[2][1], len(tl) >= 10,
         "thesis_line >=10字 (主线先于架子, '先想清楚建什么风格的房子')",
         f"thesis_line={tl[:60]!r}" if tl else "thesis_line 缺失")

    # 4 搭架子: >=3 个一级章 + 有二级细分 (三级树), 一级章无明显主次失衡
    chapters = meta.get("chapters") or []
    lv1 = [c for c in chapters if int(c.get("level", 1)) == 1]
    lv2 = [c for c in chapters if int(c.get("level", 2)) == 2]
    ok_frame = len(lv1) >= 3 and len(lv2) >= len(lv1)   # 每个承重墙内有细分
    step("搭架子", FIVE_STEPS[3][1], ok_frame,
         "一级章>=3 且二级节>=一级章数 (四梁八柱; 次要内容不得占承重墙)",
         f"一级 {len(lv1)} 章 / 二级 {len(lv2)} 节")

    # 5 用资料: 准 (出处+日期标注率) · 新 (数据时距) · 精 (挂章率)
    ev = meta.get("evidence") or []
    n = len(ev)
    dated = sum(1 for e in ev if re.search(r"\d{4}-\d{2}", str(e.get("date", ""))))
    sourced = sum(1 for e in ev if str(e.get("src", "")).strip())
    linked = sum(1 for e in ev if str(e.get("chapter_key", "")).strip())
    this_year = time.strftime("%Y")
    fresh = sum(1 for e in ev
                if str(e.get("date", ""))[:4] in
                (str(int(this_year) - 1), this_year))
    ok_evi = (n > 0 and sourced == n and dated / max(1, n) >= 0.8
              and linked / max(1, n) >= 0.8 and fresh / max(1, n) >= 0.5)
    step("用资料", FIVE_STEPS[4][1], ok_evi,
         "准=100%有源且>=80%有日期; 精=>=80%挂章; 新=>=50%数据在近两年",
         f"证据 {n} 条: 有源 {sourced}/{n}, 有日期 {dated}/{n}, "
         f"挂章 {linked}/{n}, 近两年 {fresh}/{n}" if n else "证据清单缺失")
    return out


def _cli() -> int:
    ap = argparse.ArgumentParser(description="P0-6 调研方法论产线件 (蒸馏自 super-skill)")
    ap.add_argument("cmd", choices=["gradient", "fivecheck"])
    ap.add_argument("--topic", default="")
    ap.add_argument("--sources", nargs="*", default=[],
                    help="候选源名清单 (空格分隔, 可带引号)")
    ap.add_argument("--meta-json", default="")
    ns = ap.parse_args()
    if ns.cmd == "gradient":
        print(json.dumps(five_books_gradient(ns.topic or "(未给课题)",
                                             ns.sources or None),
                         ensure_ascii=False, indent=1))
    else:
        meta = (json.loads(open(ns.meta_json, encoding="utf-8").read())
                if ns.meta_json else {})
        print(json.dumps(report_five_steps_check(meta),
                         ensure_ascii=False, indent=1))
    return 0


if __name__ == "__main__":
    raise SystemExit(_cli())
