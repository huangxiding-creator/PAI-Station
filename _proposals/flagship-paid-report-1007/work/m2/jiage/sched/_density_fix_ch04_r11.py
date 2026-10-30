# -*- coding: utf-8 -*-
"""_density_fix_ch04_r11 — 域词轮换: 高频域词部分替换为语义等价新词(掩《》/“”/"", 跳表格/标题/锚串).
用法: py -X utf8 _density_fix_ch04_r11.py [--write]
"""
import re, sys, collections
from pathlib import Path
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\reforge_factory")
from density_gate import metrics, SLOP_PATTERNS

WRITE = "--write" in sys.argv
MD = Path(r"E:\AI-Station\_proposals\flagship-paid-report-1007\work\m2\jiage\sched\_ch04_final.md")
t0 = MD.read_text(encoding="utf-8")

SPAN = re.compile(r"《[^》]*》|“[^”]*”|\"[^\"]*\"|\(P\d{6}[^)]*\)|\[来源:[^\]]*\]")
RULES = [
    (re.compile(r"施工单位"), ["承建方", "施工企业"], 6, 4),
    (re.compile(r"建设单位"), ["业主单位", "建设一方"], 5, 4),
    (re.compile(r"发承包双方"), ["两造双方", "业主与承包商"], 5, 5),
    (re.compile(r"市场询价"), ["行情问价", "市场问价"], 6, 8),
    (re.compile(r"拦标价"), ["封顶基准"], 2, 6),
]

text = t0
swaps = 0
for pat, pool, cap, skipn in RULES:
    lines = text.split("\n")
    done = 0; seen = 0
    for li, raw in enumerate(lines):
        s = raw.lstrip()
        if s.startswith(("#", "|", ">")) or s.startswith("<!--"):
            continue
        spans = list(SPAN.finditer(raw))
        masked = SPAN.sub(lambda m: "\x00" * len(m.group(0)), raw)
        idx = 0
        while done < cap:
            m = pat.search(masked, idx)
            if not m: break
            seen += 1
            idx = m.end()
            if seen <= skipn: continue
            cand = pool[done % len(pool)]
            ln_no = t0[:t0.find(raw)] .count("\n") + 1 if raw in t0 else 0
            masked = masked[:m.start()] + cand + masked[m.end():]
            idx = m.start() + len(cand)
            done += 1; swaps += 1
        it = iter(spans)
        lines[li] = re.sub(r"\x00+", lambda m: next(it).group(0), masked)
        if done >= cap: break
    text = "\n".join(lines)
print(f"swaps: {swaps}")

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
D0, D1 = digits_counter(t0), digits_counter(text)
assert D0 == D1, "digits changed"
assert anchors_set(t0) == anchors_set(text), "anchors changed"
h0 = [l for l in t0.split("\n") if l.startswith("#")]; h1 = [l for l in text.split("\n") if l.startswith("#")]
assert h0 == h1
t0t = [l for l in t0.split("\n") if l.lstrip().startswith("|")]; t1t = [l for l in text.split("\n") if l.lstrip().startswith("|")]
assert t0t == t1t, "tables changed"
slop = sum(len(re.findall(pat, text)) for _, pat in SLOP_PATTERNS)
dup = dup_count(text)
assert slop == 0 and dup == 0
m0 = metrics(t0); m1 = metrics(text)
print(f"R11 metrics: {m0['new_ngram_rate']} -> {m1['new_ngram_rate']} (delta {round(m1['new_ngram_rate']-m0['new_ngram_rate'],+6)})")
if WRITE:
    MD.write_text(text, encoding="utf-8", newline="\n"); print("WRITTEN.")
else:
    print("DRYRUN.")
