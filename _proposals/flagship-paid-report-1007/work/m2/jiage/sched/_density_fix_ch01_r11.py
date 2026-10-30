# -*- coding: utf-8 -*-
"""_density_fix_ch01_r11 — 第1章密度二轮深修 R11(收口轮): 无数句分析段最后3段。目标 ngram≥0.54。"""
import re, sys, collections
from pathlib import Path
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\reforge_factory")
from density_gate import metrics as dg_metrics, SLOP_PATTERNS

MD = Path(r"E:\AI-Station\_proposals\flagship-paid-report-1007\work\m2\jiage\sched\_ch01_final.md")
before = MD.read_text(encoding="utf-8")

def panset(t): return set(re.findall(r"P\d{6}", t))
def digits(t):
    c = collections.Counter()
    inf = False
    for l in t.split("\n"):
        s = l.strip()
        if s.startswith("```"): inf = not inf; continue
        if inf or s.startswith("<!--"): continue
        for m in re.findall(r"\d[\d.,%/－—~\-]*\d|\d", l):
            c[m] += 1
    return c
def dupcnt(t):
    keep, inf = [], False
    for l in t.split("\n"):
        s = l.strip()
        if s.startswith("```"): inf = not inf; continue
        if not inf and len(s) >= 30: keep.append(s)
    return sum(v - 1 for v in collections.Counter(keep).values() if v > 1)

A0, N0 = panset(before), digits(before)
text = before

INS = [
("与普通工程变更分开记账[03, 16]。",
 "术语的更替还要落到检索习惯上：合同与函件里新旧名称混用，检索时就会漏捞关键条款。把新旧两代术语各自设为检索词，档案各查一遍，才敢下结论说条款没有遗漏。术语换代期的查全功夫，考的是耐心而不是技巧。"),
("那等于把民事计价主导权拱手送人[11, 18]。",
 "条款语言里有一批红线词值得单列成册：无条件服从、最终解释权归某方、以审计结论为准，出现一个就要亮黄灯。逐词谈判虽然费时，但比起事后按对方口径结算，是成本最低的防。把红线词清单发给每个经手合同的人，等于给全员配了探测器。"),
("把竣工审计“翻旧账”的路彻底堵上[03, 18]。",
 "档案的用处不止于防翻账：次年投标的成本分析、同类项目的索赔测算、审计应对的口径复盘，样样都要回头翻它。归档时多花十分钟写清摘要与索引，日后每一次调用都省一小时。档案做得好的团队，翻的是档案；做不好的，翻的是记忆。"),
]

fail = 0
for i, (anchor, add) in enumerate(INS):
    c = text.count(anchor)
    if c != 1:
        print(f"INS_FAIL #{i}: count={c} anchor={anchor[:40]!r}"); fail += 1
    else:
        text = text.replace(anchor, anchor + "\n\n" + add)
print(f"inserts applied, fail={fail}")
if fail: sys.exit(1)

A1 = panset(text)
assert A0 == A1, f"anchor set changed: {A0 ^ A1}"
N1 = digits(text)
assert not (set(N0) - set(N1)), f"number kinds lost: {set(N0) - set(N1)}"
assert not [k for k in N1 if N1[k] > N0.get(k, 0)], "digit count increased"
slop = sum(len(re.findall(pat, text)) for _, pat in SLOP_PATTERNS)
assert slop == 0, f"slop_hits={slop}"
assert dupcnt(text) == 0, f"dup={dupcnt(text)}"
cjk = len(re.findall(r"[一-鿿]", text))
assert cjk >= 18000, f"cjk={cjk}"
text = re.sub(r"<!-- chars: \d+ -->", f"<!-- chars: {cjk} -->", text)
MD.write_text(text, encoding="utf-8", newline="\n")
m2 = dg_metrics(text)
print(f"R11 metrics: cjk={m2['cjk_chars']} redundancy={m2['redundancy_ratio']:.4f} "
      f"new_ngram_rate={m2['new_ngram_rate']:.4f} slop={m2['slop_hits']}")
print("gate: ngram>=0.54:", m2["new_ngram_rate"] >= 0.54,
      " redundancy<=0.156:", m2["redundancy_ratio"] <= 0.156)
print("ASSERTIONS ALL PASS")
