# -*- coding: utf-8 -*-
"""_density_fix_ch04_r5 — 第4章净删轮R10: 4.1/4.2 复述镜像段压缩(段落级合并).
铁律: 数字token种类不减/多集不增 | P锚SET不变且每锚留痕 | 表格不动 | 标题不动 | CJK>=18000 | dup=0 | slop=0.
用法: py -X utf8 _density_fix_ch04_r5.py [--write]  (缺省DRYRUN只报数)
"""
import re, sys, collections
from pathlib import Path
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\reforge_factory")
sys.path.insert(0, str(Path(__file__).parent))
from density_gate import metrics, SLOP_PATTERNS
import _r10_c4_ops

WRITE = "--write" in sys.argv
MD = Path(r"E:\AI-Station\_proposals\flagship-paid-report-1007\work\m2\jiage\sched\_ch04_final.md")
t0 = MD.read_text(encoding="utf-8")
FW = "０１２３４５６７８９．，－／％＋（）［］"; HW = "0123456789.,-/%+()[]"
TRANS = str.maketrans(FW, HW)

def _norm(x):
    x = x.translate(TRANS)
    x = re.sub(r"(?<=\d)\s+(?=\d)", "", x)
    x = re.sub(r"(?<=\d)[一一—–−]+(?=\d)", "-", x)
    return x

def digits_counter(t):
    c = collections.Counter()
    for raw in t.splitlines():
        st = raw.strip()
        if st.startswith("<!--") or st.startswith("#"):
            continue
        line = raw
        if st.startswith("|"):
            line = re.sub(r"第\d+章", " ", line)
        line = re.sub(r"\[来源:[^\]]*\]", " ", line)
        line = re.sub(r"P\d{6}", " ", line)
        line = re.sub(r"表\d+[-．.]\d+[A-Za-z]?", " ", line)
        line = re.sub(r"第\d+(至\d+)?[章节]", " ", line)
        line = re.sub(r"\d+(?:\.\d+)+\s*节", " ", line)
        line = re.sub(r"^\s*\d+(\.\d+)*\s*$", " ", line)
        for tok in re.findall(r"\d[\d.,%/－—~\-]*\d|\d", line):
            tt = _norm(tok).strip("%+")
            if tt and re.search(r"\d", tt):
                c[tt] += 1
    return c

def anchors_set(t):
    return set(re.findall(r"P\d{6}", t))

def anchor_multiset(t):
    return collections.Counter(re.findall(r"P\d{6}", t))

def dup_count(t):
    paras = [x.strip() for x in re.split(r"\n+", t) if len(x.strip()) >= 30 and not x.strip().startswith("| :")]
    return sum(v - 1 for v in collections.Counter(paras).values() if v > 1)

D0, A0, AM0 = digits_counter(t0), anchors_set(t0), anchor_multiset(t0)
cjk0 = len(re.findall(r"[\u4e00-\u9fff]", t0))
text = t0
applied = 0
for op in _r10_c4_ops.OPS:
    if op[0] == "S":
        _, old_s, new_s = op
        c = text.count(old_s)
        if c != 1:
            print(f"OP_FAIL S count={c} old={old_s[:30]!r}"); sys.exit(1)
        text = text.replace(old_s, new_s, 1)
        applied += 1
        continue
    _, start, end, new = op
    lines = text.split("\n")
    starts = [i for i, l in enumerate(lines) if l.startswith(start)]
    if len(starts) != 1:
        print(f"OP_FAIL start {start[:24]!r}: {len(starts)} hits"); sys.exit(1)
    i0 = starts[0]
    if end is None:
        i1 = i0 + 1
    else:
        ends = [i for i, l in enumerate(lines[i0 + 1:], i0 + 1) if l.startswith(end)]
        if not ends:
            print(f"OP_FAIL end {end[:24]!r} not found after start"); sys.exit(1)
        i1 = ends[0]
    lines[i0:i1] = new.split("\n") if new else []
    text = "\n".join(lines)
    applied += 1
print(f"ops applied: {applied}/{len(_r10_c4_ops.OPS)}")

D1, A1, AM1 = digits_counter(text), anchors_set(text), anchor_multiset(text)
lost_kinds = set(D0) - set(D1)
inc = {k: D1[k] - D0.get(k, 0) for k in D1 if D1[k] > D0.get(k, 0)}
anc_lost = A0 - A1; anc_new = A1 - A0
zero_anchor = sorted([a for a in A1 if AM1[a] == 0])
cjk1 = len(re.findall(r"[\u4e00-\u9fff]", text))
h0 = [l for l in t0.split("\n") if l.startswith("#")]
h1 = [l for l in text.split("\n") if l.startswith("#")]
t0t = [l for l in t0.split("\n") if l.lstrip().startswith("|")]
t1t = [l for l in text.split("\n") if l.lstrip().startswith("|")]
slop = sum(len(re.findall(pat, text)) for _, pat in SLOP_PATTERNS)
dup = dup_count(text)

print(f"数字种类: {len(D0)} -> {len(D1)}  lost_kinds={sorted(lost_kinds)}")
print(f"数字多集增量: {inc}")
print(f"锚SET: lost={sorted(anc_lost)} new={sorted(anc_new)} 零引用锚={zero_anchor}")
print(f"锚引用总次数: {sum(AM0.values())} -> {sum(AM1.values())}")
print(f"CJK: {cjk0} -> {cjk1} (net {cjk1 - cjk0:+d})")
print(f"标题一致: {h0 == h1} | 表格行一致: {t0t == t1t} | slop={slop} dup={dup}")

ok = (not lost_kinds and not inc and not anc_lost and not anc_new and not zero_anchor
      and h0 == h1 and t0t == t1t and slop == 0 and dup == 0 and cjk1 >= 18000)
m = metrics(text)
print(f"R10 metrics: cjk={m['cjk_chars']} rate={m['new_ngram_rate']} redund={m['redundancy_ratio']} slop={m['slop_hits']}")
print("gate ngram>=0.5401:", m["new_ngram_rate"] >= 0.5401)
if not ok:
    print("ASSERTIONS FAIL — DRYRUN only, file untouched"); sys.exit(1)
if WRITE:
    MD.write_text(text, encoding="utf-8", newline="\n")
    print("WRITTEN.")
else:
    print("DRYRUN pass — rerun with --write to apply.")
