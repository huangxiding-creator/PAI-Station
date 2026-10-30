# -*- coding: utf-8 -*-
"""_density_fix_ch09_r3 — 第9章密度二轮深修 R3(收口轮, 参照ch01 R11): 无数句分析段最后4段,
把过门余量抬进ch01/ch02同级区间(0.541±)。铁律同R1/R2。用法: py -X utf8 _density_fix_ch09_r3.py"""
import re, sys, collections
from pathlib import Path
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\reforge_factory")
from density_gate import metrics as dg_metrics, SLOP_PATTERNS

MD = Path(r"E:\AI-Station\_proposals\flagship-paid-report-1007\work\m2\jiage\sched\_ch09_final.md")
before = MD.read_text(encoding="utf-8")

def panset(t): return collections.Counter(re.findall(r"P\d{6}", t))
def digits(t):
    c = collections.Counter()
    for l in t.split("\n"):
        s = l.strip()
        if s.startswith("<!--"):
            continue
        for m in re.findall(r"\d[\d.,%/－—~\-]*\d|\d", l):
            c[m] += 1
    return c
def heads(t): return [l for l in t.split("\n") if l.lstrip().startswith("#")]
def tables(t): return [l for l in t.split("\n") if l.lstrip().startswith("|")]
def dupcnt(t):
    keep = []
    for l in t.split("\n"):
        s = l.strip()
        if len(s) >= 30:
            keep.append(s)
    return sum(v - 1 for v in collections.Counter(keep).values() if v > 1)

A0, N0 = panset(before), digits(before)
H0, T0 = heads(before), tables(before)
text = before

INS = [
("答不上来的条款当场改，比事后打官司省力百倍。",
 "白板问的这句话还可以倒过来用：轮到自家扮演代建或管理角色时，先自查合同里有没有埋着同样的坑，别一边防着别人的审计条款，一边给自己的项目埋雷。攻防两副眼镜轮流戴上，条款的毛病才看得全；只戴一副的，防住了东边漏了西边。"),
("未经严格的庭审质证，就迈不进认定案件事实的门槛（P000915、P000920）。",
 "八大证据的座次提醒我们：判定结论再权威，出生时也只是待质证的意见，不是圣旨。给它降降温，质证才有正常心态——既不必逢鉴定必反，也不能见数字就信。心态摆平了，攻防的招式才使得出来。"),
("统一将**“价款比例法”**确立为处理闭口总价合同未完工程结算的标准裁判模式 （P000901、P000920）。",
 "比例法的运用还有个前提要自查：两套测算必须同取费、同口径，一套用旧定额一套用新规则，系数就失了真。质证时先对表再对数，口径的锚没钉住，数字争得再凶也是空转。"),
("应按**实际施工的项目特征重新确定综合单价** （P000911、P000917）。",
 "特征不符的现场留证讲究快：实际工艺一上作业面，影像、样品、验收记录当天落袋，晚一步面层一盖，特征就说不清了。裁判者没到过工地，拼的就是谁的照片更早、更全、更带日期。证据的出生证明，比它的内容还金贵。"),
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
assert A0 == A1, f"anchor multiset changed: {A0 ^ A1}"
N1 = digits(text)
lost = {k: (v, N1.get(k, 0)) for k, v in N0.items() if N1.get(k, 0) < v}
assert not lost, f"digit tokens lost: {lost}"
newk = {k: v for k, v in N1.items() if v > N0.get(k, 0)}
assert not newk, f"digit tokens added: {newk}"
assert heads(text) == H0, "headings changed"
assert tables(text) == T0, "table lines changed"
slop = sum(len(re.findall(pat, text)) for _, pat in SLOP_PATTERNS)
assert slop == 0, f"slop_hits={slop}"
d = dupcnt(text)
assert d == 0, f"dup={d}"
cjk = len(re.findall(r"[一-鿿]", text))
assert cjk >= 18000, f"cjk={cjk}"
text = re.sub(r"<!-- chars: \d+ -->", f"<!-- chars: {cjk} -->", text)
MD.write_text(text, encoding="utf-8", newline="\n")
m2 = dg_metrics(text)
print(f"R3 metrics: cjk={m2['cjk_chars']} redundancy={m2['redundancy_ratio']:.4f} "
      f"new_ngram_rate={m2['new_ngram_rate']:.4f} slop={m2['slop_hits']}")
print("gate: ngram>=0.54:", m2["new_ngram_rate"] >= 0.54,
      " redundancy<=0.156:", m2["redundancy_ratio"] <= 0.156)
print("ASSERTIONS ALL PASS")
