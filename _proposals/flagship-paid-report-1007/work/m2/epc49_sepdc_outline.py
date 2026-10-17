# -*- coding: utf-8 -*-
"""epc49_sepdc_outline — 《四川电力设计咨询（中国电建四川院）EPC总承包全景研究》大纲 (S2)."""
from __future__ import annotations

import json
from pathlib import Path

REPO = Path(__file__).resolve().parents[4]
OUT = REPO / "_proposals" / "flagship-paid-report-1007" / "work" / "m2" / "epc49_sepdc"

CHAPTERS = [
    ("1", "公司总图景：身份、沿革与中国电建集团坐标", "融合",
     ["四川电力设计咨询", "中国电建四川院", "公司简介", "资质荣誉", "发展沿革"], ["Q1", "Q4"]),
    ("2", "政策坐标系：电力设计与工程总承包的规则环境", "精编",
     ["政策", "五年规划", "资质改革", "总承包管理办法"], ["Q2", "Q3"]),
    ("3", "市场底账：输变电、新能源与储能的规模与口径", "融合",
     ["市场规模", "输变电", "新能源", "储能", "统计口径"], ["Q4", "Q5", "Q6"]),
    ("4", "竞争格局：电力设计院系四层结构与川院位次", "精编",
     ["竞争格局", "设计院", "央企", "对标", "位次"], ["Q7", "Q8", "Q9"]),
    ("5", "财务透视：营收、净利与应收账款现金流真相", "融合",
     ["营收", "净利润", "应收账款", "现金流", "年报"], ["Q16", "Q17"]),
    ("6", "总承包版图：EPC 业务结构与合同模式", "精编",
     ["EPC", "总承包", "合同模式", "联合体", "特许经营"], ["Q10", "Q11"]),
    ("7", "旗舰项目库：特高压、储能与国内外标杆工程", "精编",
     ["特高压", "储能项目", "标杆工程", "中标", "投运"], ["Q10", "Q12"]),
    ("8", "风险档案：纠纷判例、失败案例与风险因子", "精编",
     ["纠纷", "判例", "失败案例", "风险", "处罚"], ["Q13", "Q14", "Q15"]),
    ("9", "技术底座：核心技术方案、数字化与专利标准", "精编",
     ["技术方案", "数字化", "专利", "标准", "BIM"], ["Q18", "Q19", "Q20"]),
    ("10", "组织与人才：人员规模、资质与专家格局", "精编",
     ["人员", "资质", "专家", "大师", "博士后"], ["Q21", "Q22"]),
    ("11", "国际对标：FIDIC 规则与海外市场实践", "精编",
     ["FIDIC", "海外", "国际", "出海", "准入"], ["Q23", "Q24"]),
    ("12", "2026-2029 预判：川院的十二个确定性趋势", "原创",
     ["趋势", "预判", "十五五", "新型电力系统", "出海"], ["Q6", "Q9", "Q25"]),
]


def main() -> int:
    OUT.mkdir(parents=True, exist_ok=True)
    lines = ["# 四川电力设计咨询（中国电建四川院）EPC总承包全景研究 — 大纲 (S2)", "",
             "> 章数 12 | 底料=池 5.5B 字级 valid (T1=1.3亿字) | 密度门主判+锚点门", ""]
    for no, title, ctype, kws, subqs in CHAPTERS:
        lines.append(f"## 第{no}章 {title} `[三态：{ctype}]`")
        lines.append(f"- 检索词: {' / '.join(kws)}")
        lines.append(f"- 树子问: {', '.join(subqs)}")
        lines.append("")
    (OUT / "OUTLINE.md").write_text("\n".join(lines), encoding="utf-8")
    (OUT / "chapters.json").write_text(
        json.dumps([{"no": n, "title": t, "type": c, "kws": k, "subqs": s}
                    for n, t, c, k, s in CHAPTERS], ensure_ascii=False, indent=1),
        encoding="utf-8")
    print(f"[outline] {len(CHAPTERS)} 章 → {OUT}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
