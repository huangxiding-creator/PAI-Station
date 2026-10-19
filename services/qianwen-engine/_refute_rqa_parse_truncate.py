# -*- coding: utf-8 -*-
"""code-repro（review lens）：_parse_rqa_reply 是否按 finding 所述吞掉多段结论/第4-5条论据。

调用真实函数（app.py:1049），输入为 v0.9.23 提示词（config.py:96）完全合规的 LLM 输出：
①首行起≥1000字深度结论 ②随后3-5条「第N章：」论据（每条80-120字）。
运行：py _refute_rqa_parse_truncate.py
"""
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

from qianwen_engine.app import _parse_rqa_reply  # 被审真实函数

ok_fail = []


def check(name, cond, detail):
    print(f"  [{'FIRES' if cond else 'no'}] {name} — {detail}")
    ok_fail.append((name, cond))


# ── Shape A：合规多段结论（GLM 写 1000+ 汉字的典型形态：分段）+ 5 条论据 ──
para1, para2, para3 = "一" * 300, "二" * 300, "三" * 450      # 合计 1050 字 ≥1000
points = [f"第{i}章：" + "摘" * 110 for i in range(1, 6)]     # 5 条 × 110 字（提示词 3-5 条/80-120 字）
reply_a = "\n\n".join([para1, para2, para3] + points)
concl_a, pts_a = _parse_rqa_reply(reply_a)

print("A) 多段合规回答（结论 1050 字分 3 段 + 5 条论据）")
written = sum(map(len, (para1, para2, para3)))
check("结论仅存活第一段", concl_a == para1,
      f"写入 {written} 字，实际交付 {len(concl_a)} 字")
check("第2/3段整段被静默丢弃", para2 not in concl_a and para3 not in concl_a, "")
check("交付结论不足提示词承诺的1000字", len(concl_a) < 1000,
      f"交付 {len(concl_a)} < 1000（提示词=至少1000字）")
check("5条论据只存活3条", len(pts_a) == 3, f"交付 {len(pts_a)} 条（提示词 3-5 条）")
check("合规110字论据不受120上限影响", all(len(p["text"]) == 110 for p in pts_a),
      f"交付 {[len(p['text']) for p in pts_a]}（[:120] 对 80-120 字合规输出无损）")

# ── Shape D：论据超写 150 字（提示词 80-120 字的越界情形）──
concl_d, pts_d = _parse_rqa_reply("结论\n第1章：" + "摘" * 150)
print("D) 论据越界 150 字")
check("论据在120字处硬切无标记", len(pts_d[0]["text"]) == 120,
      f"写入 150，交付 {len(pts_d[0]['text'])}，末字符={pts_d[0]['text'][-1]!r}")

# ── Shape B：单行 1500 字结论（提示词「至少1000字」→ >1200 在分布内）──
reply_b = "结" * 1500 + "\n第1章：" + "摘" * 100
concl_b, pts_b = _parse_rqa_reply(reply_b)
print("B) 单行 1500 字结论")
check("恰在1200字处拦腰截断", len(concl_b) == 1200,
      f"写入 1500，交付 {len(concl_b)}")
check("无任何截断标记（省略号等）",
      not concl_b.endswith(("…", "...", "。", "！", "？")),
      f"末字符={concl_b[-1]!r}")

# ── 对照：现行测试唯一覆盖的形态（单行短结论+2论据）不受影响 ──
concl_c, pts_c = _parse_rqa_reply("结论行\n第1章：论据一\n第2章：论据二")
print("C) 现网测试形态（对照，应全部正常）")
check("对照：单行短结论不受影响", concl_c == "结论行" and len(pts_c) == 2, "现行 14 用例绿的形态")

fires = sum(1 for _, c in ok_fail if c)
print(f"\n合计 {len(ok_fail)} 项断言，命中（缺陷触发）{fires} 项")
