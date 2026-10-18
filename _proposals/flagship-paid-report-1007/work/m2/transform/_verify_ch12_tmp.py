# -*- coding: utf-8 -*-
import re, io
base = r"E:/AI-Station/_proposals/flagship-paid-report-1007/work/m2/transform/"
text = io.open(base + "ch12.md", encoding="utf-8").read()
bank = io.open(base + "bank_ch12.md", encoding="utf-8", errors="replace").read()
NUM_RE = re.compile(
    r"\d+(?:\.\d+)?\s*(?:万亿元|亿元|万元|亿|万|元|%|％|家|条|个|项|件|人|"
    r"次|起|例|宗|号|年|月|日|页|款|MWh|千瓦时|千瓦|公里|字|台|座|美元|BP|项)")
miss = []
checked = 0
for para in re.split(r"\n+", text):
    if "own_calc" in para:
        continue
    p = para.replace(",", "")
    for m in NUM_RE.finditer(p):
        tok = re.sub(r"\s", "", m.group(0))
        checked += 1
        if re.fullmatch(r"\d{1,2}(条|个|项|款|年)", tok):
            continue
        if tok in bank or tok.replace("年", "") in bank:
            continue
        miss.append(tok)
print("TOKENS_CHECKED", checked)
print("MISS_COUNT", len(miss))
for t in sorted(set(miss)):
    print("MISS:", t)
