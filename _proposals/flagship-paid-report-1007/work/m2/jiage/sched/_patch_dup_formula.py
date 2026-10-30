# -*- coding: utf-8 -*-
"""Patch _build_ch0708_final.py: replace the broken dup-formula surgery block with a regex approach."""
import ast

P = "_build_ch0708_final.py"
s = open(P, encoding="utf-8").read()

i = s.find('head_part, sep, tail_part = body.partition("## 7.3 ")')
j = s.find("# ---- 7.4.1 ASCII架构树", i)
assert i > 0 and j > i, (i, j)

NL = chr(10)
BS = chr(92)
D = NL + chr(34)  # "\n (newline + double quote)

new_block_lines = [
    '    head_part, sep, tail_part = body.partition("## 7.3 ")',
    '    assert sep, "7.3 split failed"',
    '    BS = chr(92)',
    '    pat_src = ("(?m)^" + BS + "s*" + BS*4 + BS + "[" + BS*2 + "text" + BS + "{承包人报价浮动率 L"',
    '               + BS + "}[^" + BS + "n]*" + BS*4 + BS + "]" + BS + "n")',
    '    ms = list(re.finditer(pat_src, tail_part))',
    '    assert ms, "dup公式锚点未命中"',
    '    mm = ms[0]',
    '    new_line = ("   浮动率L按本章7.2.2节公式计算——即中标价相对招标控制价的下浮比例，',
    '                计算基数不得扣除暂列金额及暂估价。" + chr(10))',
    '    tail_part = tail_part[:mm.start()] + new_line + tail_part[mm.end():]',
    '    body = head_part + sep + tail_part',
    '',
    '    ',
]
new_block = NL.join(new_block_lines) + NL

s = s[:i] + new_block + s[j:]
# clean possible duplicated join lines
s = s.replace(
    '    body = head_part + sep + tail_part\n    body = head_part + sep + tail_part\n',
    '    body = head_part + sep + tail_part\n')
s = s.replace('\n\n\n    # ---- 7.4.1', '\n\n    # ---- 7.4.1')

open(P, "w", encoding="utf-8").write(s)
ast.parse(s)
print("patched, syntax OK")
print(repr(s[i:i + 800]))
