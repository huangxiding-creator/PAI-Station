# -*- coding: utf-8 -*-
"""ECS 生产运行时导出冒烟（纯函数，不碰 DB/不碰真实用户）。"""
from qianwen_engine import exporter

row = {
    "id": "prodsmoke",
    "question": "生产冒烟：EPC 固定总价材料暴涨能调价吗？",
    "answer_full": "## 一、定性\n\n- 材料暴涨可主张调价\n- 无条款走情势变更\n\n> 《民法典》第 533 条\n\n| 情形 | 能否 |\n|---|---|\n| 暴涨超5% | 可主张 |\n",
    "citations": [{"n": 1, "source": "民法典", "loc": 533}],
    "created_at": "2026-09-29 13:40:00",
}
for f in ("docx", "pdf"):
    r = exporter.build(f, row)
    print(f, r["bytes"], r["filename"])
print("PROD_EXPORT_SMOKE_OK")
