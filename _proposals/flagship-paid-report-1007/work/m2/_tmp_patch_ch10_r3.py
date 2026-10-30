# -*- coding: utf-8 -*-
"""ch10 round3(终轮) — 高新颖度内容插入(~1300字)收口0.649"""
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

rep("画像先于业务升级，制度先于规模扩张，这是本章的第一句话。",
    "画像先于业务升级，制度先于规模扩张，这是本章的第一句话。画像还有一层用处常被忽略：它是谈判桌上的一面镜子——对方拿什么币种付款、按什么节奏付款、拖起款来有什么底牌，都在你该提前照见的范围里；照不见的部分，就用对价（预付款比例、保函条件）把它买回来。")
rep("省下的那点材料价差，覆盖不了半年账期的资金成本，这是无数项目用亏损验证过的算术。",
    "省下的那点材料价差，覆盖不了半年账期的资金成本，这是无数项目用亏损验证过的算术。给这两栏一个粗刻度的估法：资金占用按同期贷款利率乘以平均垫资天数，风险溢价按风险章的五层地图逐层打分——刻度可以粗，栏目不能缺；粗刻度会被评审会打磨，缺栏目连被打磨的机会都没有。")
rep("同时在内部把票据开具的时限纳入考核，别让自己成为自己回款的障碍。",
    "同时在内部把票据开具的时限纳入考核，别让自己成为自己回款的障碍。票据这东西平时像纸，出事时像铁：安静履约的年份没人多看它一眼，对簿公堂的那一天，一张按时开出的发票、一枚清晰的签收章，抵得过十封措辞恳切的催款函。")
rep("易踩的坑是只谈贷款不谈保险——保险条款里的除外责任清单，常常才是真正的风险所在。",
    "易踩的坑是只谈贷款不谈保险——保险条款里的除外责任清单，常常才是真正的风险所在。挑出口信用保险有个土办法：把除外责任从头到尾念一遍，念到哪一条让你心口一紧，哪一条就是你项目的命门；命门之外的便宜，都不算真便宜。")
rep("海外项目由于司法救济更远、执行更难，把功夫下在事前信号识别上，比国内项目更加必要。",
    "海外项目由于司法救济更远、执行更难，把功夫下在事前信号识别上，比国内项目更加必要。读这些卷宗不妨带着一个习惯：每见一处败诉理由，就回头看看自家在建项目有没有同款漏洞——别人的判决书，是自家最便宜的体检报告。")
rep("证据补救专项，同时冻结对该主体的一切新交易 |",
    "证据补救专项，同时冻结对该主体的一切新交易 |\n\n仪表盘怕的不是红，怕的是灰——信号定义含糊、责任人空缺、升级路径没写，仪表盘就成了装饰画。给每一格信号补上\"谁来看、多久看一次、看到之后第一天做什么\"，它才算装上了指针；指针转不转，月度例会一听便知。")
rep("都会折成下一轮融资的速度与价钱。",
    "都会折成下一轮融资的速度与价钱。机制这东西，建的时候像负担，跑起来像惯性，出事的时候才像救生索——三者之间隔的，不过是几个月的坚持。")

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
