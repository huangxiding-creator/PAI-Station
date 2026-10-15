# -*- coding: utf-8 -*-
"""bid26_outline — 《工程总承包招投标合规指南·2026版》大纲 (S2 骨架).

结构源: 问题树 26 子问 (十维) × A级存量《工程总承包招投标合规工作指南》
骨架 × 合规/法务买家动线。章型三态标注 (精编/融合/原创), 密度门+锚点门
逐章验收 (gates.json chapter_band.floor_per_type: 精编3000/融合5000/原创4000)。

产出: work/m2/bid26/OUTLINE.md + 章节×检索词表 (bank 抽取输入)
"""
from __future__ import annotations

import json
from pathlib import Path

REPO = Path(__file__).resolve().parents[4]   # E:/AI-Station
OUT = REPO / "_proposals" / "flagship-paid-report-1007" / "work" / "m2" / "bid26"

# (章号, 标题, 章型, 检索词[], 树子问[])
CHAPTERS = [
    ("1", "2026 合规总图景：政策坐标系与监管框架", "融合",
     ["招标投标法", "监管框架", "政策", "46号令", "主管部门"],
     ["Q1", "Q2", "Q3"]),
    ("2", "招标全流程合规节点地图（从立项到定标）", "精编",
     ["招标程序", "资格审查", "评标定标", "两阶段", "流程"],
     ["Q1", "Q18"]),
    ("3", "评标环节：专家库、评审规则与红线", "精编",
     ["评标专家", "评标系统", "智慧评审", "评标办法"],
     ["Q21", "Q18"]),
    ("4", "电子招投标与数字化平台合规", "精编",
     ["电子招投标", "数字化", "交易平台", "电子保函", "BIM"],
     ["Q19", "Q26"]),
    ("5", "围标串标与恶性竞争：识别、认定与处罚", "精编",
     ["围标", "串标", "行政处罚", "失信", "黑名单"],
     ["Q13", "Q15"]),
    ("6", "资质与准入：企业资格、人员资质改革动向", "精编",
     ["资质", "准入", "造价工程师", "注册建造师", "从业资格"],
     ["Q21", "Q22", "Q3"]),
    ("7", "合同模式与计价：EPC 合同条款风险解剖", "融合",
     ["合同模式", "计价", "固定总价", "FIDIC", "暂列金额"],
     ["Q11", "Q23"]),
    ("8", "纠纷与判例：败诉原因谱系（2015-2026）", "精编",
     ["纠纷", "判例", "败诉", "诉讼", "仲裁"],
     ["Q14", "Q13"]),
    ("9", "重大失败案例档案：超概算、烂尾与问责", "精编",
     ["超概算", "失败案例", "事故", "问责", "通报"],
     ["Q12", "Q15"]),
    ("10", "招标代理与采购生态：机构格局与选择", "精编",
     ["招标代理", "采购平台", "公共资源交易", "供应链"],
     ["Q25", "Q26"]),
    ("11", "国际对标：FIDIC 体系与世行规则下的中资企业", "融合",
     ["FIDIC", "国际工程", "对外承包", "世行", "ENR"],
     ["Q23", "Q24"]),
    ("12", "2026-2029 合规预判：十二个确定性趋势", "原创",
     ["预判", "趋势", "改革", "十四五", "政策动向"],
     ["Q2", "Q9"]),
]


def main() -> int:
    OUT.mkdir(parents=True, exist_ok=True)
    lines = ["# 工程总承包招投标合规指南·2026版 — 大纲 (S2)",
             "",
             f"> 章数 {len(CHAPTERS)} | 章型: "
             f"精编{sum(1 for c in CHAPTERS if c[2]=='精编')}/"
             f"融合{sum(1 for c in CHAPTERS if c[2]=='融合')}/"
             f"原创{sum(1 for c in CHAPTERS if c[2]=='原创')} | "
             "底料=池 5,801万字 valid + A级存量《合规工作指南》 | "
             "门: 密度门主判+gate2锚点+gate3互引+章型下限",
             ""]
    for no, title, ctype, kws, subqs in CHAPTERS:
        lines.append(f"## 第{no}章 {title} `[三态：{ctype}]`")
        lines.append(f"- 检索词: {' / '.join(kws)}")
        lines.append(f"- 树子问: {', '.join(subqs)}")
        lines.append("")
    (OUT / "OUTLINE.md").write_text("\n".join(lines), encoding="utf-8")
    (OUT / "chapters.json").write_text(
        json.dumps([{"no": n, "title": t, "type": c, "kws": k, "subqs": s}
                    for n, t, c, k, s in CHAPTERS],
                   ensure_ascii=False, indent=1), encoding="utf-8")
    print(f"[outline] {len(CHAPTERS)} 章 → {OUT / 'OUTLINE.md'}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
