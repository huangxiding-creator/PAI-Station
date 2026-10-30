# -*- coding: utf-8 -*-
"""_density_fix_ch03_r3 — 第3章深改轮R3主脚本(对R2后文件行号).
用法: py -X utf8 _density_fix_ch03_r3.py
"""
import re, sys, collections
from pathlib import Path
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\reforge_factory")
sys.path.insert(0, str(Path(__file__).parent))
from density_gate import metrics, SLOP_PATTERNS
import _r3_c3_ops5, _r3_c3_ops6, _r3_c3_ops7

MD = Path(r"E:\AI-Station\_proposals\flagship-paid-report-1007\work\m2\jiage\sched\_ch03_final.md")
t0 = MD.read_text(encoding="utf-8")

def digits_counter(t):
    t = re.sub(r"\[来源:[^\]]*\]", " ", t)
    t = re.sub(r"P\d{6}", " ", t)
    t = re.sub(r"表\d+[-．.]\d+[A-Za-z]?", " ", t)
    t = re.sub(r"第\d+(至\d+)?[章节]", " ", t)
    t = re.sub(r"\d+(?:\.\d+)+\s*节", " ", t)
    return collections.Counter(re.findall(r"\d[\d.,%/－—~\-]*\d|\d", t))
def anchors_set(t):
    return set(re.findall(r"P\d{6}", t))
def dup_count(t):
    return sum(v - 1 for v in collections.Counter(
        l.strip() for l in t.splitlines()
        if len(l.strip()) >= 30 and not l.strip().startswith("| :")).values() if v > 1)

D0, A0 = digits_counter(t0), anchors_set(t0)
OPS = (_r3_c3_ops5.OPS + _r3_c3_ops6.OPS + _r3_c3_ops7.OPS)

lines = t0.split("\n")
for st, en, prefix, new in sorted(OPS, key=lambda o: -o[0]):
    body = lines[st - 1]
    if not body.startswith(prefix):
        print(f"OP_FAIL L{st}: expected {prefix[:24]!r} got {body[:36]!r}")
        sys.exit(1)
    lines[st - 1:en] = new.split("\n")
text = "\n".join(lines)
print(f"ops applied: {len(OPS)}")

D1, A1 = digits_counter(text), anchors_set(text)
inc = {k: D1[k] - D0.get(k, 0) for k in D1 if D1[k] > D0.get(k, 0)}
assert not inc, f"digits increased: {inc}"
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
print(f"R3 metrics: cjk={m['cjk_chars']} (net {m['cjk_chars'] - len(re.findall(r'[\u4e00-\u9fff]', t0)):+d}) "
      f"rate={m['new_ngram_rate']} redund={m['redundancy_ratio']} slop={m['slop_hits']}")
print("gate ngram>=0.5401:", m["new_ngram_rate"] >= 0.5401)
print("ASSERTIONS ALL PASS")
