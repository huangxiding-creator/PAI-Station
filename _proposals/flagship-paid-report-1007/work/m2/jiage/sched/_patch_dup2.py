# -*- coding: utf-8 -*-
"""Line-splice repair of the dup surgery region in _build_ch0708_final.py."""
import ast

P = "_build_ch0708_final.py"
lines = open(P, encoding="utf-8").read().split("\n")

a = next(i for i, l in enumerate(lines) if "# ---- dup手术" in l)
b = next(i for i, l in enumerate(lines) if "# ---- 7.4.1 ASCII架构树" in l)

clean = [
    '    # ---- dup手术: 7.3.2 重复的报价浮动率公式 → 交叉引用',
    '    head_part, sep, tail_part = body.partition("## 7.3 ")',
    '    assert sep, "7.3 split failed"',
    '    BS = chr(92)',
    '    pat_src = ("(?m)^" + BS + "s*" + BS*4 + BS + "[" + BS*2 + "text" + BS + "{承包人报价浮动率 L"',
    '               + BS + "}[^" + BS + "n]*" + BS*4 + BS + "]" + BS + "n")',
    '    ms = list(re.finditer(pat_src, tail_part))',
    '    assert ms, "dup公式锚点未命中"',
    '    mm = ms[0]',
    '    new_line = ("   浮动率L按本章7.2.2节公式计算——即中标价相对招标控制价的下浮比例，计算基数不得扣除暂列金额及暂估价。" + chr(10))',
    '    tail_part = tail_part[:mm.start()] + new_line + tail_part[mm.end():]',
    '    body = head_part + sep + tail_part',
    '',
    '    # ---- 7.4.1 ASCII架构树 → 表格 (dup手术/体裁)',
]

lines[a:b] = clean
src = "\n".join(lines)
open(P, "w", encoding="utf-8").write(src)
ast.parse(src)
print("spliced, syntax OK")
