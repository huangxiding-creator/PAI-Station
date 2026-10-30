# -*- coding: utf-8 -*-
"""_pfinder - 在 bank_chNN.md 中定位查询串所在的 P 锚块; ch04-06 收编编辑段辅助件.
用法: py -X utf8 _pfinder.py <bank.md> "查询1" "查询2" ...
输出: 每个查询 -> 命中锚列表 (或 MISS); 数字串自动去逗号双形态检索.
"""
import re
import sys

sys.stdout.reconfigure(encoding="utf-8")
path = sys.argv[1]
queries = sys.argv[2:]
text = open(path, encoding="utf-8", errors="ignore").read()

blocks = {}
cur = None
buf = []
for ln in text.splitlines():
    m = re.match(r"^## (P\d{6})\b", ln)
    if m:
        if cur:
            blocks[cur] = "\n".join(buf)
        cur, buf = m.group(1), [ln]
    elif cur:
        buf.append(ln)
if cur:
    blocks[cur] = "\n".join(buf)


def variants(q: str):
    q = q.strip()
    out = {q}
    if "," in q:
        out.add(q.replace(",", ""))
        out.add(q.replace(",", ","))
    # 全角数字形态
    fw = "０１２３４５６７８９"
    hw = "0123456789"
    tq = q.translate(str.maketrans(fw, hw))
    out.add(tq)
    return out


for q in queries:
    hits = []
    for a, t in blocks.items():
        for v in variants(q):
            if v in t:
                hits.append(a)
                break
    print(("[" + ",".join(hits) + "]") if hits else "[MISS]", q)
