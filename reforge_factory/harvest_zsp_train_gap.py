# -*- coding: utf-8 -*-
"""harvest_zsp_train_gap — EPC-TRAIN 饱和收口·bing_cn 齐射 (anysearch 熔断备源)."""
from __future__ import annotations

import re
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, str(Path(__file__).resolve().parent))
import harvest_zh_search_pro as zs              # noqa: E402

# (检索词, 面词, 面, 正则, EEI) — 面词与检索同 (bing 精确词友好)
_Q = [
    ("产教融合型城市 名单", "Q2-E2"),
    ("教育培训 行业 年鉴", "Q5-E2"),
    ("国投 培训 基地", "Q8-E3"),
    ("行动教育 定位", "Q9-E2"),
    ("量子之歌 投诉", "Q12-E3"),
    ("职业培训 退费 判决", "Q14-E2"),
    ("教育培训 纠纷 数据", "Q14-E3"),
    ("职业技能培训 风险", "Q15-E1"),
    ("人社部 能力建设", "Q15-E3"),
    ("东方教育 财报", "Q16-E3"),
    ("培训机构 预收费 监管", "Q17-E3"),
    ("在线课程 完课率", "Q19-E2"),
    ("人才 证书 目录", "Q20-E2"),
    ("技能人才 总量", "Q21-E3"),
    ("名师 工作室", "Q22-E2"),
    ("职教 专家", "Q22-E3"),
    ("ISO 29993", "Q23-E3"),
    ("中建 海外 培训", "Q24-E2"),
    ("鲁班工坊", "Q24-E3"),
    ("企业培训 采购", "Q25-E2"),
    ("企业培训 生态", "Q25-E3"),
    ("学堂在线", "Q26-E1"),
    ("腾讯课堂 关闭", "Q26-E2"),
]
zs.PLAN = [(q, q.split()[0], "市场规模", re.escape(q.split()[0]), eei)
           for q, eei in _Q]
zs.DOMAIN_RE = re.compile(r"培训|教育|人才|课程|EPC|工程|建造|企业|职业|学习|认证|营收|纠纷|年报")

if __name__ == "__main__":
    import argparse
    ap = argparse.ArgumentParser()
    ap.add_argument("--campaign", default="EPC-TRAIN")
    ap.add_argument("--max-files", type=int, default=40)
    ap.add_argument("--limit-queries", type=int, default=0)
    ap.add_argument("--engines", default="bing_cn")
    ns = ap.parse_args()
    raise SystemExit(zs.run(ns.campaign, ns.engines.split(","), ns.max_files,
                            False, ns.limit_queries))
