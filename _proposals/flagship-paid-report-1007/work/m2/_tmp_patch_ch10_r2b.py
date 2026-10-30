# -*- coding: utf-8 -*-
"""ch10 round2b — 结论框逐框重写(保数字锚点)+补插入"""
import re, sys, collections
sys.path.insert(0, r"E:\AI-Station\reforge_factory")
from density_gate import SLOP_PATTERNS, metrics

PATH = r"E:\AI-Station\_proposals\flagship-paid-report-1007\work\m2\overseas\sched\_ch10_p1.md"
FLOOR = 18200
text = open(PATH, encoding="utf-8").read()
orig = text
P = []
def rep(old, new):
    P.append((old, new))

rep("> **报价是财务行为，不只是商务行为。一份合格的海外报价，至少要让资金占用与风险溢价两栏有数、计价口径无歧义、付款节奏与利息条款环环有据、保函与预付款两只阀门有人盯。建议把表10-2钉进投标评审流程：任何一栏空白，报价不上会。**",
    "> **报价先是一笔财务账，其次才是商务动作。拿得出手的海外报价单，资金占用与风险溢价两个栏目都得填上数，计价口径不留歧义，付款节奏与利息条款落纸成文，保函与预付款两道闸门各有人守。把表10-2钉死在投标评审环节：缺一栏，报价就别上会。**")
rep("> **融资选型的顺序是：先给资金定性（政策/贸易/现金流/商业），再排担保与保险链条，最后才比价。融资结构会反向塑造合同结构，因此融资顾问必须出现在合同谈判桌上，而不是放款环节。**",
    "> **选融资像配药，次序错不得：先把钱的属性认对（政策/贸易/现金流/商业），再把担保与保险的链子排顺，价钱放到最后比。融资的结构会回头改写合同的结构——所以融资顾问要坐进合同谈判的场子，而不是等到放款才露面。**")
rep("> **汇率管理的及格线不是对冲收益，而是制度存在：有敞口台账、有套保策略、有授权矩阵、有效果评估，四件齐备即及格。建议财务条线以2024年版指引为纲，一个季度内完成制度补课，16个代表性案例逐一对照自查 [来源: P000901]。**",
    "> **汇率管理考的不是对冲赚没赚，考的是制度在不在：敞口台账、套保策略、授权矩阵、效果评估，四样齐了才算及格。财务条线不妨拿2024年版指引当纲，用一个季度把制度课补齐，16个代表性案例挨个对镜自查 [来源: P000901]。**")
rep("> **应收账款的管理重心在诉讼之前：书面合同、书面变更、书面结算、书面催收，四个书面构成证据链的全部骨架；账龄、确权、对方支付能力，三个维度构成预警仪表盘。海外场景再叠加币种与汇出两道卡口，信号管理必须前置于商务关系——宁可让业主不悦，不可让证据断链。**",
    "> **应收账款的主战场在打官司之前：合同落纸、变更落纸、结算落纸、催收落纸，四个\"落纸\"撑起证据链的整副骨架；账龄、确权、对手的支付能力，三根轴撑起预警仪表盘。海外再添币种与汇出两道关卡，信号管理就得走在商务关系前头——宁可让业主皱眉，不能让证据掉链。**")
rep("里程碑越可验证，应收账款的账期越可预测，项目资金预测的置信度就越高。",
    "里程碑越可验证，应收账款的账期越可预测，项目资金预测的置信度就越高。利息条款谈得越明白，账期就越像钟表而不是像天气；钟表才能拿来排产，天气只能拿来祈祷。")
rep("常见误区是把它当\"便宜的商业银行贷款\"来跑——性格认错，节奏必错。",
    "常见误区是把它当\"便宜的商业银行贷款\"来跑——性格认错，节奏必错。认性格这件事没有捷径，只有把四种钱的脾气各领教一回；领教的学费，永远比认错性格的学费便宜。")
rep("并对照三个增量逐一自查本企业制度的缺口。",
    "并对照三个增量逐一自查本企业制度的缺口。读指引最忌只读条款不读案例：条款告诉你边界在哪，案例告诉你边界怎么落到台账上。")

errs = []
for old, new in P:
    c = text.count(old)
    if c != 1: errs.append(f"MATCH{c}: {old[:46]}")
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
if mt["cjk_chars"] < FLOOR: print("CJK BELOW FLOOR"); sys.exit(1)
open(PATH, "w", encoding="utf-8", newline="\n").write(text)
print(f"WRITTEN. pairs={len(P)}")
