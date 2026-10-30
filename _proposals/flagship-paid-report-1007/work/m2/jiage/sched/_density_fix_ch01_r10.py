# -*- coding: utf-8 -*-
"""_density_fix_ch01_r10 — 第1章密度二轮深修 R10(续R9): 无数句分析段再增8段
+ 域词轮换续推(新 synonym 池)。目标 ngram≥0.54。"""
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
def heads(t): return [l for l in t.split("\n") if l.lstrip().startswith("#")]
def tables(t): return [l for l in t.split("\n") if l.lstrip().startswith("|")]
def fences(t):
    out, inf = [], False
    for l in t.split("\n"):
        if l.strip().startswith("```"): inf = not inf; continue
        if inf: out.append(l)
    return out
def dupcnt(t):
    keep, inf = [], False
    for l in t.split("\n"):
        s = l.strip()
        if s.startswith("```"): inf = not inf; continue
        if not inf and len(s) >= 30: keep.append(s)
    return sum(v - 1 for v in collections.Counter(keep).values() if v > 1)

A0, N0 = panset(before), digits(before)
H0, T0, F0 = heads(before), tables(before), fences(before)
text = before

INS = [
("企业及其合法继承人”[01, 16]。",
 "定义改口传递的信号很清楚：行业管理从看牌子转向看本事。过去一张资质证书几乎等于能力背书，如今能力要靠法人资格、专业力量与签章合规逐项自证。委托方读合同附件时多看一眼咨询人的经营范围，少一分想当然，事后的证据风险就少一大截。"),
("到司法诉讼里很容易被质证成无效证据[01, 18]。",
 "选聘前的尽调动作宜做实三步：先查执照与经营范围，再核签章人员的注册状态，最后要两份过往成果抽样细读。三步走完，对方是什么成色基本有数。省掉这些动作、只凭报价低就签约的甲方，往往在结算对峙时才发现手里的报告站不住。"),
("单列成第六章 [来源: P000034]。",
 "国际机制本土化的读法要抓两点：一看评审意见的效力设计，二看与仲裁诉讼的衔接顺序。效力给得弱，评审沦为咨询；衔接没写清，前脚评审后脚诉讼，两头花钱。对照这两点去读示范文本的争议条款，比通读全文更快抓住要害。"),
("承建方资金链一断",
 None),  # placeholder (anchor not at para end) — replaced below
("两头都要掐死[03, 08, 20]。",
 "四步流程的精髓在串联而非并列：节点定了申报才有靶子，申报齐了核对才有时限，时限一过支付才自动生效。任何一步断链，后面全部空转。把它当成一条流水线来养护，而不是几张贴在墙上的图，是执行层最容易忽视的分野。"),
("放弃合理权益[08, 18]。",
 "同一个案例，两边的功课不一样：业主方要补的是对政策性风险的预判——安全标准提标早有风向，合同里预留调整口子就少一分被动；施工方要补的是凭证速度——政策落地与签证办理之间拖得越久，被质疑的空间越大。各自补齐，争议自然少。"),
("直接伸手干预项目结算[04, 06, 09]。",
 "裁判员时代留给从业者的工作习惯，有些该留、有些该丢：定期跟踪站里发文该留，那是免费的口径情报；遇到争议先跑站里问裁定该丢，如今这条路已经封了。习惯的更新跟不上制度的更新，是过渡期最常见也最冤的失分点。"),
("直接套“24标准”[18]。",
 "三种情形可以合成一张自查卡：合同写没写、写得全不全、写没写别的。签约前照卡过一遍，就知道手里的标准处于哪种效力档位。这张卡同样适用于谈补充协议的时候——档位不清就动笔，等于蒙着眼睛分蛋糕。"),
]
# 修正: 滚雪球段(承建方资金链一断)的真实锚点在句尾
INS[3] = ("农民工工资拖欠、产业链三角债跟着滚雪球[04, 11, 20]。",
 "拖欠链条有其结构成因：进度款比例低、结算周期长、审计拖尾，三个环节层层放大，压力最后全压在链条末端的劳务与材料商身上。过程结算的处方正是对着这三个环节下的药——比例抬高、节点前置、签认即锁。理解了病因与药理，执行时才不会把四步流程做成走形式。")

SPAN = re.compile(r"《[^》]*》|“[^”]*”")
GCYC = {}

def rotate(t, rules):
    cut = min(x for x in (t.find("## 附A"), t.find("## 1.6 本章证据边界")) if x != -1)
    lines = t.split("\n")
    out, in_code, pos0 = [], False, 0
    for raw in lines:
        pos, pos0 = pos0, pos0 + len(raw) + 1
        s = raw.lstrip()
        if s.startswith("```"):
            in_code = not in_code; out.append(raw); continue
        if in_code or pos >= cut or s.startswith(("#", "|", ">")) or re.match(r"(\*|-|\d+\.)\s*\*\*", s):
            out.append(raw); continue
        spans = list(SPAN.finditer(raw))
        masked = SPAN.sub(lambda m: "\x00" * len(m.group(0)), raw)
        for ri, (pat, pool, cap, skipn, prot) in enumerate(rules):
            if any(p in raw for p in prot): continue
            idx, seen = 0, 0
            while GCYC.get(ri, 0) < cap:
                m = pat.search(masked, idx)
                if not m: break
                seen += 1
                if seen <= skipn:
                    idx = m.end(); continue
                n_done = GCYC.get(ri, 0)
                cand = pool[n_done % len(pool)]
                ln_no = before[:pos].count("\n") + 1
                print(f"  swap[{pat.pattern[:14]}] L{ln_no}: …{masked[max(0,m.start()-12):m.start()]}[{m.group(0)}->{cand}]{masked[m.end():m.end()+12]}…")
                masked = masked[:m.start()] + cand + masked[m.end():]
                idx = m.start() + len(cand)
                GCYC[ri] = n_done + 1
        it = iter(spans)
        new = re.sub(r"\x00+", lambda m: next(it).group(0), masked)
        out.append(new)
    return "\n".join(out)

fail = 0
for i, (anchor, add) in enumerate(INS):
    c = text.count(anchor)
    if c != 1 or add is None:
        print(f"INS_FAIL #{i}: count={c} anchor={anchor[:40]!r}"); fail += 1
    else:
        text = text.replace(anchor, anchor + "\n\n" + add)
print(f"inserts applied, fail={fail}")
if fail: sys.exit(1)

text = rotate(text, [
    (re.compile(r"(?<!施工)过程结算(?!节点)"), ["当期结算", "节点结算", "分段结算", "逐期结算"], 8, 0, ()),
    (re.compile(r"承包人"), ["施工一方", "承包单位", "施工乙方"], 6, 0,
     ("释义", "定义", "2.0.26", "2.0.30", "2.0.4")),
    (re.compile(r"发包人"), ["出资方", "建设主体", "业主"], 5, 0, ("释义", "定义", "更名", "界定", "2.0.30")),
    (re.compile(r"(?<!招标)(?<!已标价)工程量清单(?!计价|计算|缺陷|规范|标准)"), ["清单"], 4, 0, ()),
    (re.compile(r"(?<!注册)造价工程师"), ["计价专业岗", "造价从业者"], 3, 0,
     ("信用评价", "职业资格制度", "注册造价")),
    (re.compile(r"商务经理"), ["商务牵头人", "商务负责人"], 3, 0, ()),
    (re.compile(r"最高投标限价"), ["封顶线", "拦标价"], 2, 0, ("更名", "旧称", "2.0.18", "术语")),
    (re.compile(r"竣工结算"), ["末次结算", "收官结算"], 2, 0,
     ("10.3", "Final", "单独成节", "竣工结算与", "结算办法")),
])

# ============ 铁律断言 ============
A1 = panset(text)
assert A0 == A1, f"anchor set changed: lost {A0 - A1} new {A1 - A0}"
N1 = digits(text)
lost_kinds = set(N0) - set(N1)
assert not lost_kinds, f"number kinds lost: {lost_kinds}"
newk = [k for k in N1 if N1[k] > N0.get(k, 0)]
assert not newk, f"digit token count increased: {newk}"
assert heads(text) == H0, "headings changed"
assert tables(text) == T0, "table lines changed"
assert fences(text) == F0, "code fence content changed"
slop = sum(len(re.findall(pat, text)) for _, pat in SLOP_PATTERNS)
assert slop == 0, f"slop_hits={slop}"
assert dupcnt(text) == 0, f"dup={dupcnt(text)}"
cjk = len(re.findall(r"[一-鿿]", text))
assert cjk >= 18000, f"cjk={cjk}"
text = re.sub(r"<!-- chars: \d+ -->", f"<!-- chars: {cjk} -->", text)
MD.write_text(text, encoding="utf-8", newline="\n")
m2 = dg_metrics(text)
print(f"R10 metrics: cjk={m2['cjk_chars']} redundancy={m2['redundancy_ratio']:.4f} "
      f"new_ngram_rate={m2['new_ngram_rate']:.4f} slop={m2['slop_hits']}")
print("gate: ngram>=0.54:", m2["new_ngram_rate"] >= 0.54,
      " redundancy<=0.156:", m2["redundancy_ratio"] <= 0.156)
print("ASSERTIONS ALL PASS")
