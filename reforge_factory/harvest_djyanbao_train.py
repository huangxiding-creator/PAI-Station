# -*- coding: utf-8 -*-
"""harvest_djyanbao_train — EPC-TRAIN 洞见研报收割 (复用 harvest_djyanbao 机械)."""
from __future__ import annotations

import re
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, str(Path(__file__).resolve().parent))
import harvest_djyanbao as dj                     # noqa: E402

dj.PLAN = [
    ("教育培训 政策 规划", "Q2-E2"),
    ("教育 统计 年报", "Q5-E2"),
    ("央企 国企 培训 格局", "Q8-E3"),
    ("凯撒 教育 战略", "Q9-E2"),
    ("好未来 转型", "Q9-E3"),
    ("教育 破产 案例", "Q12-E3"),
    ("教育 纠纷 白皮书", "Q14-E3"),
    ("职业培训 风险 报告", "Q15-E3"),
    ("教育 预收费 现金流", "Q17-E3"),
    ("AI 教育 平台 落地", "Q19-E2"),
    ("职业 标准 目录", "Q20-E2"),
    ("技能人才 规模", "Q21-E3"),
    ("教师 名师 机构", "Q22-E2"),
    ("专家 学者 职教", "Q22-E3"),
    ("国际 教育 认证", "Q23-E3"),
    ("出海 教育 培训", "Q24-E2"),
    ("教育 产业 生态", "Q25-E3"),
    ("成人 学习 平台", "Q26-E2"),
]
dj.DOMAIN_RE = re.compile(r"培训|教育|人才|课程|EPC|工程|建造|企业|职业|学习|认证")

if __name__ == "__main__":
    import argparse
    ap = argparse.ArgumentParser()
    ap.add_argument("--campaign", default="EPC-TRAIN")
    ap.add_argument("--login-wait", type=int, default=30)
    ap.add_argument("--max-total", type=int, default=25)
    ap.add_argument("--dry", action="store_true")
    ns = ap.parse_args()
    raise SystemExit(dj.run(ns.campaign, per_query=3, max_total=ns.max_total,
                            login_wait=ns.login_wait, dry=ns.dry))
