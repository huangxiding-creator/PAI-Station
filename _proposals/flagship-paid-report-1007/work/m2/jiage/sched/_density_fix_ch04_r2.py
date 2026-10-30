# -*- coding: utf-8 -*-
"""_density_fix_ch04_r2 — 第4章深改轮R2主脚本: 区间前缀手术+断言.
op = (start_prefix, end_prefix|None, new_text): 替换 [start行, end行) 或仅 start行.
铁律: 数字token不增 / P锚SET不变 / 表格不动 / 标题不动 / CJK>=18000 / dup=0 / slop=0.
用法: py -X utf8 _density_fix_ch04_r2.py
"""
import re, sys, collections
from pathlib import Path
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\reforge_factory")
sys.path.insert(0, str(Path(__file__).parent))
from density_gate import metrics, SLOP_PATTERNS
import _r2_c4_ops1, _r2_c4_ops2, _r2_c4_ops3

MD = Path(r"E:\AI-Station\_proposals\flagship-paid-report-1007\work\m2\jiage\sched\_ch04_final.md")
t0 = MD.read_text(encoding="utf-8")

def digits_counter(t):
    t = re.sub(r"\[来源:[^\]]*\]", " ", t)
    t = re.sub(r"P\d{6}", " ", t)
    t = re.sub(r"表\d+[-．.]\d+[A-Za-z]?", " ", t)
    t = re.sub(r"第\d+(至\d+)?[章节]", " ", t)
    t = re.sub(r"\d+(?:\.\d+)+\s*节", " ", t)
    t = re.sub(r"第[一二三四五六七八九十]+条", " ", t)
    return collections.Counter(re.findall(r"\d[\d.,%/－—~\-]*\d|\d", t))
def anchors_set(t):
    return set(re.findall(r"P\d{6}", t))
def dup_count(t):
    return sum(v - 1 for v in collections.Counter(
        l.strip() for l in t.splitlines()
        if len(l.strip()) >= 30 and not l.strip().startswith("| :")).values() if v > 1)

D0, A0 = digits_counter(t0), anchors_set(t0)
OPS = (_r2_c4_ops1.OPS + _r2_c4_ops2.OPS + _r2_c4_ops3.OPS)

text = t0
for op in OPS:
    start, end, new = (op[0], None, op[1]) if len(op) == 2 else op
    lines = text.split("\n")
    starts = [i for i, l in enumerate(lines) if l.startswith(start)]
    if len(starts) != 1:
        print(f"OP_FAIL start {start[:26]!r}: {len(starts)} hits")
        sys.exit(1)
    i0 = starts[0]
    if end is None:
        i1 = i0 + 1
    else:
        ends = [i for i, l in enumerate(lines[i0 + 1:], i0 + 1) if l.startswith(end)]
        if not ends:
            print(f"OP_FAIL end {end[:26]!r} not found after start")
            sys.exit(1)
        i1 = ends[0]
    lines[i0:i1] = new.split("\n")
    text = "\n".join(lines)
print(f"ops applied: {len(OPS)}")

D1, A1 = digits_counter(text), anchors_set(text)
# 数字守门: 与 _audit_ch04_final.py 同口径 — 新增token必须存在于bank
FW = "０１２３４５６７８９．，－／％＋（）［］"
HW = "0123456789.,-/%+()[]"
TRANS = str.maketrans(FW, HW)
def _norm(x):
    x = x.translate(TRANS)
    x = re.sub(r"(?<=\d)\s+(?=\d)", "", x)
    x = re.sub(r"(?<=\d)[一一—–−]+(?=\d)", "-", x)
    return x
bank = open("bank_ch05.md", encoding="utf-8").read()
bank_n = _norm(bank); bank_nc = bank_n.replace(",", "")
bad_toks = []
for tok in set(D1) - set(D0):
    t_ = _norm(tok).strip("%+")
    variants = {t_, t_.replace(",", ""), t_.rstrip("."), re.sub(r"[.,]+$", "", t_)}
    if t_ and re.search(r"\d", t_) and not any(v in bank_n or v in bank_nc for v in variants if v):
        bad_toks.append(tok)
assert not bad_toks, f"new digits not in bank: {bad_toks}"
assert A1 == A0, f"anchor set changed: lost {A0 - A1} new {A1 - A0}"
assert dup_count(text) == 0, "dup paragraphs found"
slop = sum(len(re.findall(pat, text)) for _, pat in SLOP_PATTERNS)
assert slop == 0, f"slop_hits={slop}"
cjk = len(re.findall(r"[\u4e00-\u9fff]", text))
assert cjk >= 18000, f"cjk={cjk}"
h0 = [l for l in t0.split("\n") if l.startswith("#")]
h1 = [l for l in text.split("\n") if l.startswith("#")]
assert h0 == h1, "heading lines changed"

MD.write_text(text, encoding="utf-8", newline="\n")
m = metrics(text)
print(f"R2 metrics: cjk={m['cjk_chars']} (net {m['cjk_chars'] - len(re.findall(r'[\u4e00-\u9fff]', t0)):+d}) "
      f"rate={m['new_ngram_rate']} redund={m['redundancy_ratio']} slop={m['slop_hits']}")
print("gate ngram>=0.5401:", m["new_ngram_rate"] >= 0.5401)
print("ASSERTIONS ALL PASS")
