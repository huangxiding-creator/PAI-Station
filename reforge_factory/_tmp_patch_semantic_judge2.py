# -*- coding: utf-8 -*-
"""fresh surgical patch v2 — plain-string replaces + occurrence asserts."""
import ast, io

PATH = "ammo_pool.py"
src = io.open(PATH, encoding="utf-8").read()
orig_len_lines = len(src.splitlines())

def rep1(s, old, new, what):
    n = s.count(old)
    assert n == 1, f"ANCHOR[{what}] count={n}"
    return s.replace(old, new)

# A. import semantic_judge (fail-soft) after urllib.parse import
src = rep1(src,
    "from urllib.parse import urlsplit, urlunsplit, parse_qsl\n",
    "from urllib.parse import urlsplit, urlunsplit, parse_qsl\n"
    "try:                                    # P1-1 语义判层第二道 (fail-soft)\n"
    "    import semantic_judge               # 缺件不拖垮弹药池, 退纯启发式\n"
    "except Exception:                       # noqa: BLE001\n"
    "    semantic_judge = None\n",
    "import")

# B. counters + sem_on after n_snap_fix = 0
src = rep1(src,
    "\nn_snap_fix = 0\n",
    "\nn_snap_fix = 0\n"
    "    # P1-1 语义判层第二道 (世界顶级差距#4): L1 判废 ∧ 外文材料信号\n"
    "    # → GLM 复核; SEMANTIC_JUDGE 环境变量激活, 默认关 (保守上线,\n"
    "    # 不开不动既有账). 旧账不重写 — 只影响本轮起的新判.\n"
    "    n_sem = n_sem_flip = n_sem_hold = n_sem_err = 0\n"
    "    sem_on = bool(semantic_judge and semantic_judge.semantic_enabled())\n"
    "    if (semantic_judge is None and os.environ.get(\n"
    "            'SEMANTIC_JUDGE', '0').strip().lower()\n"
    "            in ('1', 'true', 'yes', 'on')):\n"
    "        print('[判断·语义二道] ⚠ SEMANTIC_JUDGE=1 但 semantic_judge '\n"
    "              '不可用 — 维持纯启发式', file=sys.stderr)\n",
    "counters")

# C. semantic second pass after judge_heuristic call (loop body, 8-space indent)
src = rep1(src,
    "        verdict, reason = judge_heuristic(text, kws)\n",
    "        verdict, reason = judge_heuristic(text, kws)\n"
    "        sem_engine = 'heuristic'\n"
    "        if (verdict == 'rejected' and sem_on\n"
    "                and semantic_judge.foreign_ratio(\n"
    "                    text[:semantic_judge.HEAD_CHARS])\n"
    "                >= semantic_judge.FOREIGN_RATIO_GATE):  # 外文材料信号\n"
    "            n_sem += 1\n"
    "            res = semantic_judge.judge_semantic(\n"
    "                row.get('title') or fp.stem,\n"
    "                text[:semantic_judge.HEAD_CHARS], kws)\n"
    "            if (res.get('verdict') == 'valid'\n"
    "                    and float(res.get('score', 0))\n"
    "                    >= semantic_judge.SCORE_GATE):\n"
    "                verdict = 'valid'    # L2 翻案 (judge_reason 记双层)\n"
    "                reason = (f\"sem_overturn[L1:{reason}|L2:glm@\"\n"
    "                          f\"{res.get('model')} score={res.get('score')} \"\n"
    "                          f\"{str(res.get('reason', ''))[:60]}\")\n"
    "                sem_engine = 'semantic_glm'\n"
    "                n_sem_flip += 1\n"
    "            elif res.get('verdict') == 'rejected':\n"
    "                n_sem_hold += 1   # GLM 维持 L1 判废 — 保守维持\n"
    "            else:\n"
    "                n_sem_err += 1    # GLM 出错 — fail-soft 维持 rejected\n",
    "second_pass")

# D. row.update engine literal -> variable
src = rep1(src,
    'judge_engine="heuristic",\n',
    "judge_engine=sem_engine,\n",
    "engine_literal")

# E. report print after the 废弃/留审 print closing line
src = rep1(src,
    '(文件缺失)")\n',
    '(文件缺失)")\n'
    '    if sem_on:\n'
    '        _st = semantic_judge.STATS\n'
    '        print(f"[判断·语义二道] 复核 {n_sem} 外文件 | 翻案 {n_sem_flip} "\n'
    '              f"(score>={semantic_judge.SCORE_GATE}) | 维持 {n_sem_hold} | "\n'
    '              f"GLM错误 {n_sem_err} | glm {_st[\'ok\']}ok/{_st[\'err\']}err "\n'
    '              f"模型{_st[\'models\']} 双钥{_st[\'keys\']}把轮换"\n'
    '              f"{_st[\'key_rotations\']}")\n',
    "report_print")

ast.parse(src)                                # 先验证后落盘
io.open(PATH, "w", encoding="utf-8", newline="\n").write(src)
print("PATCH_OK", orig_len_lines, "->", len(src.splitlines()))
