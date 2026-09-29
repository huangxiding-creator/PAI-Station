# -*- coding: utf-8 -*-
"""一次性冒烟：AI优化提问提示词对真实 KB 的效果（烧免费池约 3 点，验证后即弃）。"""
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

from qianwen_engine import metaso_kb
from qianwen_engine.app import OPTIMIZE_PROMPT

q = "EPC 固定总价合同下材料暴涨，我能调价吗？"
print("STATUS:", metaso_kb.engine_status())
res = metaso_kb.ask(OPTIMIZE_PROMPT.format(q=q))
print("ELAPSED:", round(res.elapsed_sec, 1), "s  CHARS:", len(res.answer))
print("CITES:", len(res.citations))
print("=" * 50)
print(res.answer)
print("=" * 50)
