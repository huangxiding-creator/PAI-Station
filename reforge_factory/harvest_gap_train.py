# -*- coding: utf-8 -*-
"""harvest_gap_train — EPC-TRAIN 饱和缺口定向齐射 (复用 harvest_gap 机械)."""
from __future__ import annotations

import re
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, str(Path(__file__).resolve().parent))
sys.path.insert(0, r"E:\AI-Station\ResearchFactory-Eng")
sys.path.insert(0, r"E:\AI-Station\ResearchFactory-Eng\EPC100")
import harvest_gap as hg                                # noqa: E402

hg.PLAN = [
    # E3 权威槽 (near 差 1)
    ("人社部 职业技能提升行动 补贴", "Q1-E3", "official"),
    ("住建部 人员培训 继续教育 规定", "Q4-E3", "official"),
    ("企业培训 统计 数据 报告", "Q5-E3", "official"),
    ("培训行业 增速 市场规模 报告", "Q6-E3", "research"),
    ("央企 人才培养 培训 部署", "Q10-E3", "official"),
    ("EPC 合同 争议 计价 判例", "Q11-E3", "research"),
    ("建造师 继续教育 学时 要求", "Q17-E1", "official"),
    # E2 反证槽 (零件)
    ("培训 无效 企业 踩坑", "Q2-E2", "media"),
    ("培训补贴 骗取 处罚", "Q3-E2", "media"),
    ("培训市场 乱象 收费 投诉", "Q5-E2", "media"),
    ("人才流失 培养成本 企业", "Q8-E2", "media"),
    ("培训 效果差 质疑", "Q12-E2", "media"),
]
hg.MIN_CHARS = 350
OUT = Path(hg.REPO) / "data" / "harvest" / "gap" / "EPC-TRAIN"
hg.REPO  # noqa

if __name__ == "__main__":
    import argparse
    ap = argparse.ArgumentParser()
    ap.add_argument("--campaign", default="EPC-TRAIN")
    ap.add_argument("--dry", action="store_true")
    ns = ap.parse_args()
    # 原 run 用 REPO/"gap"/cid — TRAIN 版改挂 EPC-TRAIN 目录
    hg.run.__globals__["REPO"] = hg.REPO
    raise SystemExit(hg.run(ns.campaign, ns.dry))
