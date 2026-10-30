# -*- coding: utf-8 -*-
"""_nb_pin_probe — 钉选候选篇内容实证探针 (只读).

按 sched_nb_draft.py 同口径切篇+去重, 对候选篇头部8000字统计章关键词实占,
为钉选理由提供真实词频依据。输出到 stdout。
"""
from __future__ import annotations

import re
import sys
from pathlib import Path

NB = Path(r"E:\AI-Station\ResearchFactory-Eng\NB_MD_library_v2")
VOLS = ["90_研究报告成果合集_vol001.md", "90_研究报告成果合集_vol002.md",
        "90_研究报告成果合集_vol003.md", "91_法规共性资料_vol001.md"]
BLOCK_HEAD = "\n\n---\n\n# "
MIN_CHARS = 2000


def norm_title(s: str) -> str:
    s = re.sub(r"^《[^》]*》\s*/\s*", "", s.strip())
    s = re.sub(r"_(citefixed|conf)(?=\.md$|$)", "", s)
    s = re.sub(r"\s*\[目标字数[^\]]*\]", "", s)
    s = re.sub(r"\.md$", "", s)
    s = s.replace("_", " ").replace("　", " ")
    s = re.sub(r"\s+", " ", s)
    return s.strip()[:60]


segs: dict[str, tuple[str, str]] = {}
for vol in VOLS:
    raw = (NB / vol).read_text(encoding="utf-8", errors="replace")
    for seg in raw.split(BLOCK_HEAD)[1:]:
        nl = seg.find("\n", 1)
        title = seg[:nl].strip() if nl > 0 else seg.strip()[:80]
        if len(seg) < MIN_CHARS:
            continue
        k = norm_title(title)
        if k not in segs or len(seg) > len(segs[k][1]):
            segs[k] = (vol, BLOCK_HEAD + seg)

TERMS = ["招标", "投标", "报价", "评标", "控制价", "工程量清单", "综合单价", "措施",
         "不平衡", "信息价", "市场价", "材料", "价差", "造价指数", "定额", "计价",
         "管理办法", "住建部", "政策", "法规", "中标", "结算", "组价", "单价", "预算"]

PROBES = {
    "中国中原海外核工程项目总承包管理实践": ["招标", "投标", "报价", "合同", "费用"],
    "完整报告": ["清单", "单价", "计价", "费用", "报价"],
    "正文 14章": ["清单", "单价", "计价", "费用", "报价"],
    "渠道调研成果报告": ["信息价", "市场价", "材料", "价", "调研"],
    "知识库总览与学习指南": ["法规", "政策", "定额", "计价", "体系"],
    "工程总承包能力建设卓越绩效应用实践": ["投标", "报价", "定额", "计价", "管理"],
    "避坑清单": ["清单", "单价", "计价", "费用", "报价", "措施"],
    "第11章 多项目标杆矩阵与方法论": ["市场价", "材料", "价", "指数", "方法"],
    "第6章 商务防线与EVM挣值硬约束：坚守“算清账再派工”彻底封堵“先干后算”的资金黑洞": ["价", "费用", "报价", "单价", "预算"],
    "建工司法解释演进与新旧条文对照": ["招标", "法规", "政策", "条文", "计价"],
    "各地法院建工纠纷裁判指引汇编": ["招标", "法规", "政策", "裁判", "计价"],
    "关联法律法规体系": ["招标投标法", "计价", "定额", "法规", "清单"],
    "第9章 合同商务与风险管控": ["报价", "清单", "单价", "计价", "合同价"],
    "第5章 采购与核电设备供应链": ["材料", "价格", "市场", "采购", "价"],
    "第8章 四控 进度·费用·质量·安全": ["措施", "费用", "安全文明", "单价", "计价"],
    "2026年建工解释二 法释2026 12号 核心条文框架与制度要点": ["招标", "中标", "计价", "结算", "政策"],
    "最高法发布《关于审理建设工程施工合同纠纷案件适用法律问题的解释（二）》": ["招标", "政策", "条文", "计价", "结算"],
    "第1章 核电产业格局与中核工程的战略坐标": ["清单", "单价", "计价", "费用", "报价"],
}

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
for name, terms in PROBES.items():
    if name not in segs:
        print(f"--- {name[:44]} | NOT FOUND")
        continue
    vol, text = segs[name]
    head = text[:8000]
    hits = {t: head.count(t) for t in terms if t in head}
    print(f"--- {name[:44]} | {vol[:3]} | {hits}")
