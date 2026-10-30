# -*- coding: utf-8 -*-
"""line-based surgical patch of ammo_pool.py (P1-1 语义判层接线).
anchors matched on stripped-line equality; indent copied from anchor line."""
import io, sys

PATH = "ammo_pool.py"
src = io.open(PATH, encoding="utf-8").read()
orig = src

def find_line(lines, needle, occurs=1):
    hits = [i for i, l in enumerate(lines) if l.strip() == needle.strip()]
    if len(hits) < occurs:
        raise SystemExit(f"ANCHOR_FAIL[{needle[:50]}] found {len(hits)}")
    return hits

lines = src.splitlines(keepends=False)

# --- A. import block (after urllib.parse import) ---
i = find_line(lines, "from urllib.parse import urlsplit, urlunsplit, parse_qsl")[0]
ind = lines[i][: len(lines[i]) - len(lines[i].lstrip())]
block_a = [
    "",
    "try:                                    # P1-1 语义判层第二道 (fail-soft)",
    "    import semantic_judge               # 缺件不拖垮弹药池, 退纯启发式",
    "except Exception:                       # noqa: BLE001",
    "    semantic_judge = None",
]
lines[i + 1:i + 1] = block_a

# --- B. counters + sem_on (after n_snap_fix = 0) ---
i = find_line(lines, "n_snap_fix = 0")[0]
ind = lines[i][: len(lines[i]) - len(lines[i].lstrip())]
block_b = [
    f"{ind}# P1-1 语义判层第二道 (世界顶级差距#4): L1 判废 ∧ 外文材料信号",
    f"{ind}# → GLM 复核; SEMANTIC_JUDGE 环境变量激活, 默认关 (保守上线,",
    f"{ind}# 不开不动既有账). 旧账不重写 — 只影响本轮起的新判.",
    f"{ind}n_sem = n_sem_flip = n_sem_hold = n_sem_err = 0",
    f"{ind}sem_on = bool(semantic_judge and semantic_judge.semantic_enabled())",
    f"{ind}if os.environ.get('SEMANTIC_JUDGE', '0').strip().lower() in (",
    f"{ind}        '1', 'true', 'yes', 'on') and semantic_judge is None:",
    f"{ind}    print('[判断·语义二道] ⚠ SEMANTIC_JUDGE=1 但 semantic_judge 不可用:",
    f"{ind}          维持纯启发式', file=sys.stderr)",
]
lines[i + 1:i + 1] = block_b

# --- C. semantic second pass (after judge_heuristic call) ---
i = find_line(lines, "verdict, reason = judge_heuristic(text, kws)")[0]
ind = lines[i][: len(lines[i]) - len(lines[i].lstrip())]
block_c = [
    f"{ind}sem_engine = 'heuristic'",
    f"{ind}if (verdict == 'rejected' and sem_on",
    f"{ind}        and semantic_judge.foreign_ratio(",
    f"{ind}            text[:semantic_judge.HEAD_CHARS])",
    f"{ind}        >= semantic_judge.FOREIGN_RATIO_GATE):  # 外文材料信号",
    f"{ind}    n_sem += 1",
    f"{ind}    res = semantic_judge.judge_semantic(",
    f"{ind}        row.get('title') or fp.stem,",
    f"{ind}        text[:semantic_judge.HEAD_CHARS], kws)",
    f"{ind}    if (res.get('verdict') == 'valid'",
    f"{ind}            and float(res.get('score', 0))",
    f"{{indent2}}>= semantic_judge.SCORE_GATE):",
    f"{ind}        verdict = 'valid'      # L2 翻案 (judge_reason 记双层)",
    f"{ind}        reason = (f\"sem_overturn[L1:{{reason}}|L2:glm@{{res.get('model')}} \"",
    f"{ind}                  f\"score={{res.get('score')}} \"",
    f"{ind}                  f\"{{str(res.get('reason', ''))[:60]}}]\")",
    f"{ind}        sem_engine = 'semantic_glm'",
    f"{ind}        n_sem_flip += 1",
    f"{ind}    elif res.get('verdict') == 'rejected':",
    f"{ind}        n_sem_hold += 1   # GLM 维持 L1 判废 — 保守维持",
    f"{ind}    else:",
    f"{ind}        n_sem_err += 1    # GLM 出错 — fail-soft 维持 rejected",
]
block_c = [l.replace("{indent2}", ind + "    ") for l in block_c]
lines[i + 1:i + 1] = block_c

# --- D. row.update judge_engine (replace 'heuristic' literal) ---
i = find_line(lines, "row.update(judge=verdict, judge_reason=reason, judge_engine=\"heuristic\",")[0]
assert "judge_engine=\"heuristic\"" in lines[i]
lines[i] = lines[i].replace("judge_engine=\"heuristic\"", "judge_engine=sem_engine")

# --- E. report print (after 废弃/留审 print's closing line) ---
i = find_line(lines, "f\"废弃 {n_rej} | 留审 {n_keep} (文件缺失)\")")[0]
ind = lines[i][: len(lines[i]) - len(lines[i].lstrip())]
ind1 = ind.replace("          ", "    ") if ind.startswith("          ") else "    "
block_e = [
    f"{ind1}if sem_on:",
    f"{ind1}    _st = semantic_judge.STATS",
    f"{ind1}    print(f\"[判断·语义二道] 复核 {{n_sem}} 外文件 | 翻案 {{n_sem_flip}} \"",
    f"{ind1}          f\"(score>={{semantic_judge.SCORE_GATE}}) | 维持 {{n_sem_hold}} | \"",
    f"{ind1}          f\"GLM错误 {{n_sem_err}} | glm {{_st['ok']}}ok/{{_st['err']}}err \"",
    f"{ind1}          f\"模型{{_st['models']}} 双钥{{_st['keys']}}把轮换{{_st['key_rotations']}}\")",
]
lines[i + 1:i + 1] = block_e

out = "\n".join(lines) + "\n"
assert out != orig
io.open(PATH, "w", encoding="utf-8", newline="\n").write(out)
import ast
ast.parse(out)
print("PATCH_OK lines", len(lines), "+", len(lines) - len(orig.splitlines()))
