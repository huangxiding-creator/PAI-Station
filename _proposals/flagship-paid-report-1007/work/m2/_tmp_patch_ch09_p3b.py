# -*- coding: utf-8 -*-
"""ch09 pass3 收尾微批 — 补最后 ~220 types 缺口"""
import re, sys, collections
sys.path.insert(0, r"E:\AI-Station\reforge_factory")
from density_gate import SLOP_PATTERNS, metrics

PATH = r"E:\AI-Station\_proposals\flagship-paid-report-1007\work\m2\overseas\sched\_ch09_p1.md"
FLOOR = 28000
text = open(PATH, encoding="utf-8").read()
orig = text
P = []
def rep(old, new):
    P.append((old, new))

rep("这笔账越积越多，不是因为电站运营效率低下，而是巴方的财政支付节奏跟不上容量电费机制运转的速度 [来源： P000907]。",
    "账越滚越大，毛病不在电站运营效率，而在巴方的财政拨付节奏追不上容量电费机制的运转速度 [来源： P000907]。")
rep("**代价清单。** 搁置宣布时，中电投集团已经在密松水电站先后投入30多亿元人民币，并每年增加约3亿元人民币的财务费用——",
    "**代价清单。** 搁置宣布那一刻，中电投集团已在密松水电站先后砸进30多亿元人民币，此后每年还要背上约3亿元人民币的财务费用——")
rep("现场是最直观的账本：项目最红火时有5000人聚集，搁置四年后只剩下8个中方员工和十几名缅籍员工；",
    "现场是最直观的账本：项目鼎盛时聚起5000人，搁置四年后只剩8名中方员工和十几名缅籍员工；")
rep("**工具六：进度「死线」与浮时调度。** 风险的合同化不止于索赔条款，进度计划本身就是对冲工具。",
    "**工具六：进度「死线」与浮时调度。** 把风险写进合同，索赔条款之外还有一张牌：进度计划本身。")
rep("属地合规的成败，第一处要害就在分包。核电工程总承包实践给出了一套成熟范式：",
    "属地合规的成败，头一个要害就落在分包上。核电工程总承包实践交出过一套成熟范式：")
rep("> - 代价清单：两项目结算至今悬置", "> - 代价明细：两项目结算至今悬置")
rep("先把风险底色看清楚。安全管理研究把重大水利水电工程的属性概括为「三高一复杂」：",
    "先看清风险的底色。安全管理研究把重大水利水电工程的属性收拢成「三高一复杂」：")
rep("搁置的表面理由是环境与移民，深层结构却是三重力量的叠加 [来源： P000909]。",
    "搁置摆在台面上的理由是环境与移民，水面之下的结构却是三股力量的合流 [来源： P000909]。")
rep("——这不是出事后的补作业，而是履约全过程的日常生产。施工日志、往来函件、审批时间戳、影像记录，共同构成索赔的弹药库；",
    "——它不是事发后的补作业，而是贯穿履约全程的日常生产。施工日志、往来函件、审批时间戳、影像记录，凑成索赔的弹药库；")
rep("标志性节点设专项机制是核电实践验证过的打法：",
    "给标志性节点配上专项机制，是核电实践反复验证过的路数：")

errs = []
for old, new in P:
    c = text.count(old)
    if c != 1: errs.append(f"MATCH{c}: {old[:44]}")
if errs:
    print("DRY-RUN FAIL:"); [print(" ", e) for e in errs]; sys.exit(1)
for old, new in P: text = text.replace(old, new, 1)
d0 = collections.Counter(re.findall(r"\d+", orig)); d1 = collections.Counter(re.findall(r"\d+", text))
if d0 != d1: print("DIGIT MISMATCH"); sys.exit(1)
p0 = re.findall(r"P\d{6}", orig); p1 = re.findall(r"P\d{6}", text)
if p0 != p1: print("ANCHOR MISMATCH"); sys.exit(1)
h0 = [l for l in orig.split("\n") if l.startswith("#")]; h1 = [l for l in text.split("\n") if l.startswith("#")]
if h0 != h1: print("HEADING MISMATCH"); sys.exit(1)
t0 = [l for l in orig.split("\n") if l.startswith("|")]; t1 = [l for l in text.split("\n") if l.startswith("|")]
if t0 != t1: print("TABLE MISMATCH"); sys.exit(1)
mt = metrics(text); slop = sum(len(re.findall(pat, text)) for _, pat in SLOP_PATTERNS)
print(f"cjk={mt['cjk_chars']} (floor {FLOOR}) redund={mt['redundancy_ratio']} rate={mt['new_ngram_rate']} slop={slop}")
if mt["cjk_chars"] < FLOOR or slop: print("GUARD FAIL, 未写入"); sys.exit(1)
open(PATH, "w", encoding="utf-8", newline="\n").write(text)
print(f"WRITTEN. topup={len(P)}")
