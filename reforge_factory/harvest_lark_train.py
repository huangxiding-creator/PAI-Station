# -*- coding: utf-8 -*-
"""harvest_lark_train — EPC-TRAIN lark 收割 (复用 harvest_lark 机械, TRAIN 面词)."""
from __future__ import annotations

import re
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, str(Path(__file__).resolve().parent))
import harvest_lark as hlk                     # noqa: E402

hlk.PLAN = [
    ("EPC培训", "Q7-E1"),
    ("企业大学", "Q7-E1"),
    ("项目经理培养", "Q21-E1"),
    ("建造师", "Q21-E1"),
    ("培训市场", "Q1-E1"),
    ("产教融合", "Q2-E1"),
    ("人才培养体系", "Q22-E1"),
    ("在线学习", "Q19-E1"),
    ("知识付费", "Q25-E1"),
    ("FIDIC培训", "Q23-E1"),
    ("继续教育", "Q21-E1"),
    ("培训课程", "Q4-E1"),
]
hlk.DOMAIN_RE = re.compile(r"培训|教育|人才|课程|EPC|工程|建造|企业|职业|学习|认证")

if __name__ == "__main__":
    import argparse
    ap = argparse.ArgumentParser()
    ap.add_argument("--campaign", default="EPC-TRAIN")
    ap.add_argument("--dry", action="store_true")
    ns = ap.parse_args()
    raise SystemExit(hlk.run(ns.campaign, ns.dry))
