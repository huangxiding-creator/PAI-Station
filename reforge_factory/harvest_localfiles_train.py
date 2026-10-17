# -*- coding: utf-8 -*-
"""harvest_localfiles_train — EPC-TRAIN 定向收割配置 (复用 harvest_localfiles 机械).

直接改调 harvest_localfiles 的 FACETS/ROOTS 常量后运行 (TRAiN 主题面词).
"""
from __future__ import annotations

import re
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, str(Path(__file__).resolve().parent))
import harvest_localfiles as hl                     # noqa: E402

# TRAIN 十面 (对齐 question_tree 十维, EEI 从树上取)
hl.FACETS = {
    "市场规模": ("培训市场|市场规模|培训行业|职业教育|继续教育|培训赛道|培训班|研修班|技能提升|职工教育",
             ("Q1-E1", "Q2-E1", "Q1-E3", "Q2-E3")),
    "政策监管": ("产教融合|职业技能提升|补贴政策|培训补贴|职教改革|培育政策",
             ("Q1-E1", "Q2-E1", "Q1-E3", "Q2-E3")),
    "竞争格局": ("企业大学|培训机构|商学院|EPC培训|总裁班|标杆企业培训",
             ("Q7-E1", "Q8-E1", "Q7-E3", "Q8-E3")),
    "组织人事": ("项目经理|建造师|造价工程师|岗位胜任|人才培养|人才梯队|师资|学员|岗前培训|取证",
             ("Q21-E1", "Q22-E1", "Q21-E3", "Q22-E3")),
    "技术方案": ("在线学习|数字化培训|AI培训|虚拟仿真|课程体系|微课",
             ("Q18-E1", "Q19-E1", "Q18-E3", "Q19-E3")),
    "渠道生态": ("知识付费|企业大学平台|培训采购|课程采购|E-learning",
             ("Q25-E1", "Q26-E1", "Q25-E3", "Q26-E3")),
    "国际对标": ("国际工程|海外培训|FIDIC培训|国际认证|PMP",
             ("Q23-E1", "Q24-E1", "Q23-E3", "Q24-E3")),
    "项目案例": ("培训案例|校企合作|实训基地|产教融合案例",
             ("Q4-E1", "Q5-E1", "Q4-E3", "Q5-E3")),
}
hl.DOMAIN_RE = re.compile(r"培训|教育|人才|课程|EPC|工程|建造|企业|职业|学习|认证")
hl.AGAINST_SLOTS = {k: v[1][0].replace("E1", "E2") for k, v in hl.FACETS.items()}

if __name__ == "__main__":
    import argparse
    ap = argparse.ArgumentParser()
    ap.add_argument("--campaign", default="EPC-TRAIN")
    ap.add_argument("--per-facet", type=int, default=40)
    ap.add_argument("--dry", action="store_true")
    ns = ap.parse_args()
    raise SystemExit(hl.run(ns.campaign, ns.per_facet, ns.dry))
