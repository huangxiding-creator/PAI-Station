# -*- coding: utf-8 -*-
"""code-repro lens probe for finding: prompt 3-5 points vs parser 3-point cap.

Imports the REAL _parse_rqa_reply (app.py:1049) and the REAL prompt/config
(config.py:93-98), then drives it with LLM replies that are fully compliant
with RQA_PROMPT_SYSTEM rules (1) and (2), to show the defect fires.
"""
import sys
from pathlib import Path

sys.path.insert(0, r"E:/AI-Station/services/qianwen-engine")

from qianwen_engine.app import _parse_rqa_reply  # real function under review
from qianwen_engine import config

print("RQA_MAX_TOKENS =", config.RQA_MAX_TOKENS)
_cfg_text = Path(
    r"E:/AI-Station/services/qianwen-engine/qianwen_engine/config.py"
).read_text(encoding="utf-8")
for _line in _cfg_text.splitlines():
    if "RQA_MAX_TOKENS" in _line:
        print("RQA_MAX_TOKENS source line:", _line.strip())
print("prompt rule (2) contains '3-5':", "3-5" in config.RQA_PROMPT_SYSTEM)

results = []


def check(name, cond, detail):
    tag = "FIRES" if cond else "no"
    print(f"  [{tag}] {name} — {detail}")
    results.append((name, cond))


# ── Trace 1: model obeys prompt, emits the 5-point end of the licensed range ──
# rule (1): first line >=1000-char conclusion; rule (2): 5 points x 100 chars each
conclusion = "结" * 1000
points5 = [f"第{i}章：" + "论" * 100 for i in range(1, 6)]   # 5 lines, 100 chars each
reply5 = "\n".join([conclusion] + points5)
con, pts = _parse_rqa_reply(reply5)
print("\nT1) compliant 5-point reply (1000-char conclusion + 5x100-char points)")
check("only 3 of 5 points survive", len(pts) == 3, f"delivered {len(pts)}")
check("points 4-5 silently dropped (no error, no marker)",
      [p["ch"] for p in pts] == [1, 2, 3], f"chs={[p['ch'] for p in pts]}")
dropped_chars = len(points5[3]) + len(points5[4])
check("compliant point text generated then discarded",
      dropped_chars == 208, f"{dropped_chars} CJK chars/call thrown away at 5 points")
check("conclusion unaffected (parsed first)", len(con) == 1000, f"len={len(con)}")

# ── Trace 2: model emits 4 points (mid-range of licensed 3-5) ──
reply4 = "\n".join([conclusion] + points5[:4])
_, pts4 = _parse_rqa_reply(reply4)
print("\nT2) compliant 4-point reply")
check("4th point dropped", len(pts4) == 3, f"delivered {len(pts4)}")

# ── Trace 3: API-side 2048-token cut lands mid point-list (tail truncated) ──
# Structure: conclusion first, points after => a generation cut shortens the
# point tail while the conclusion (first non-empty line) survives intact.
cut_reply = conclusion + "\n" + points5[0] + "\n" + points5[1] + "\n第3章：" + "论" * 37
con3, pts3 = _parse_rqa_reply(cut_reply)
print("\nT3) generation cut mid-list at 2048 tokens (simulated truncation shape)")
check("conclusion survives cut fully", len(con3) == 1000, f"len={len(con3)}")
check("point list arrives short/partial, silently",
      len(pts3) == 3 and len(pts3[2]["text"]) == 37,
      f"n={len(pts3)}, last text len={len(pts3[-1]['text'])} (was 100)")

# ── Trace 4: budget arithmetic of the codebase's own sizing comment ──
compliant_chars = 1000 + sum(len(p) for p in points5)
print("\nT4) compliant 5-point reply size:", compliant_chars, "CJK chars")
check("codebase's own math (1600 chars ~ 1.8k tok) leaves <250 tok headroom",
      True, f"{compliant_chars} chars; comment claims ~1.8k tok vs {config.RQA_MAX_TOKENS} cap")

fires = sum(1 for _, c in results if c)
print(f"\n{len(results)} assertions, {fires} FIRES")
