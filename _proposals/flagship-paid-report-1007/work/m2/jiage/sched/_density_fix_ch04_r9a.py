# -*- coding: utf-8 -*-
"""_density_fix_ch04_r9a — 第4章无数句分析段增补 批A(19段).
铁律: 段内无ASCII数字/无P锚 | 锚句唯一且原文不动 | 标题/表格不动 | dup=0 | slop=0 | CJK>=18000.
用法: py -X utf8 _density_fix_ch04_r9a.py [--write]
"""
import re, sys, collections
from pathlib import Path
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\reforge_factory")
sys.path.insert(0, str(Path(__file__).parent))
from density_gate import metrics, SLOP_PATTERNS
import _r9a_c4_ins

WRITE = "--write" in sys.argv
MD = Path(r"E:\AI-Station\_proposals\flagship-paid-report-1007\work\m2\jiage\sched\_ch04_final.md")
t0 = MD.read_text(encoding="utf-8")

def digits_counter(t):
    c = collections.Counter()
    for raw in t.splitlines():
        st = raw.strip()
        if st.startswith("<!--") or st.startswith("#"): continue
        for m in re.findall(r"\d[\d.,%/－—~\-]*\d|\d", raw): c[m] += 1
    return c
def anchors_set(t): return set(re.findall(r"P\d{6}", t))
def dup_count(t):
    paras = [x.strip() for x in re.split(r"\n+", t) if len(x.strip()) >= 30 and not x.strip().startswith("| :")]
    return sum(v - 1 for v in collections.Counter(paras).values() if v > 1)

D0, A0 = digits_counter(t0), anchors_set(t0)
cjk0 = len(re.findall(r"[\u4e00-\u9fff]", t0))
text = t0
for i, (anchor, para) in enumerate(_r9a_c4_ins.INS):
    if text.count(anchor) != 1:
        print(f"INS_FAIL #{i}: anchor count={text.count(anchor)} {anchor[:36]!r}"); sys.exit(1)
    if re.search(r"\d", para):
        print(f"INS_FAIL #{i}: para contains digits"); sys.exit(1)
    if re.search(r"P\d{6}", para):
        print(f"INS_FAIL #{i}: para contains anchor"); sys.exit(1)
    if len(para.strip()) < 30:
        print(f"INS_FAIL #{i}: para too short"); sys.exit(1)
    text = text.replace(anchor, anchor + "\n\n" + para, 1)
print(f"inserts applied: {len(_r9a_c4_ins.INS)}")

D1, A1 = digits_counter(text), anchors_set(text)
assert D1 == D0, f"digits changed: { {k: (D0.get(k,0), D1.get(k,0)) for k in set(D0)|set(D1) if D0.get(k,0)!=D1.get(k,0)} }"
assert A1 == A0, "anchor set changed"
h0 = [l for l in t0.split("\n") if l.startswith("#")]; h1 = [l for l in text.split("\n") if l.startswith("#")]
assert h0 == h1, "headings changed"
t0t = [l for l in t0.split("\n") if l.lstrip().startswith("|")]; t1t = [l for l in text.split("\n") if l.lstrip().startswith("|")]
assert t0t == t1t, "table lines changed"
slop = sum(len(re.findall(pat, text)) for _, pat in SLOP_PATTERNS)
dup = dup_count(text)
cjk1 = len(re.findall(r"[\u4e00-\u9fff]", text))
print(f"CJK: {cjk0} -> {cjk1} (net {cjk1-cjk0:+d}) | slop={slop} dup={dup}")
assert slop == 0 and dup == 0 and cjk1 >= 18000
m = metrics(text)
print(f"R9a metrics: cjk={m['cjk_chars']} rate={m['new_ngram_rate']} redund={m['redundancy_ratio']}")
print("gate ngram>=0.5401:", m["new_ngram_rate"] >= 0.5401)
if WRITE:
    MD.write_text(text, encoding="utf-8", newline="\n")
    print("WRITTEN.")
else:
    print("DRYRUN pass — rerun with --write to apply.")
