# -*- coding: utf-8 -*-
"""train_outline — 《企业EPC培训市场深度洞察》大纲 (S2)."""
from __future__ import annotations

import json
from pathlib import Path

REPO = Path(__file__).resolve().parents[4]
OUT = REPO / "_proposals" / "flagship-paid-report-1007" / "work" / "m2" / "train"

CHAPTERS = [
    ("1", "2026 培训市场总图景：政策坐标系与规模底账", "融合",
     ["培训市场", "政策", "十四五", "产教融合", "市场规模"], ["Q1", "Q2", "Q3"]),
    ("2", "需求侧：企业为什么买培训（岗位×痛点×预算）", "精编",
     ["企业培训需求", "岗位胜任", "人才培养", "预算"], ["Q4", "Q21"]),
    ("3", "供给侧：机构格局与企业大学阵营", "精编",
     ["培训机构", "企业大学", "商学院", "头部企业"], ["Q7", "Q8"]),
    ("4", "课程与认证体系：从取证到能力模型", "精编",
     ["课程体系", "能力认证", "建造师", "继续教育"], ["Q21", "Q20"]),
    ("5", "数字化培训：在线平台、AI 与完课率之战", "精编",
     ["在线学习", "数字化培训", "AI培训", "完课率", "平台"], ["Q19", "Q26"]),
    ("6", "EPC 专项培训：项目经理培养的实战地图", "精编",
     ["项目经理培训", "EPC培训", "实战", "案例"], ["Q4", "Q10"]),
    ("7", "政策红利与补贴：产教融合的钱怎么拿", "融合",
     ["培训补贴", "产教融合", "职业技能提升", "补贴政策"], ["Q2", "Q3"]),
    ("8", "培训采购与合同：企业怎么买不吃亏", "精编",
     ["培训采购", "合同", "计价", "供应商"], ["Q11", "Q25"]),
    ("9", "风险档案：跑路、退费与纠纷判例", "精编",
     ["跑路", "退费", "纠纷", "判例", "预收费"], ["Q14", "Q15"]),
    ("10", "财务透视：培训机构的营收与现金流真相", "精编",
     ["营收", "毛利率", "现金流", "财报", "预收费"], ["Q16", "Q17"]),
    ("11", "国际对标：从鲁班工坊到全球认证体系", "融合",
     ["鲁班工坊", "海外培训", "国际认证", "FIDIC"], ["Q23", "Q24"]),
    ("12", "2026-2029 预判：培训市场的十二个确定性趋势", "原创",
     ["趋势", "预判", "AI", "政策", "市场"], ["Q9", "Q6"]),
]


def main() -> int:
    OUT.mkdir(parents=True, exist_ok=True)
    lines = ["# 企业EPC培训市场深度洞察 — 大纲 (S2)", "",
             f"> 章数 {len(CHAPTERS)} | 底料=池 {int(1170):,}万字级 valid | 密度门主判+锚点门", ""]
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
