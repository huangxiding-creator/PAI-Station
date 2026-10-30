# -*- coding: utf-8 -*-
"""ch09 pass3 微批E — 高新颖度比喻句插入(贴合既有文风), 收口0.62"""
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

rep("失败案例的价值不在猎奇，而在它们替后来者把试错的价签预先标好了。",
    "失败案例的价值不在猎奇，而在它们替后来者把试错的价签预先标好了。筛子的好处是快：半小时过完九案，比任何模型都便宜；筛子的短处是粗：漏网之鱼还得靠尽调的慢功夫去捞。快筛加慢捞，九案才算用透。")
rep("周会一刻钟写进制度，这半小时就有了着落。",
    "周会一刻钟写进制度，这半小时就有了着落。风浪不会因为你有海图就止息，但掌舵人心里装着礁石的位置，舵就稳得多。")
rep("台账每隔三个月回看一次关闭速度，快慢之间，一支队伍的风险体质一目了然。",
    "台账每隔三个月回看一次关闭速度，快慢之间，一支队伍的风险体质一目了然。每一条按时关闭的信号，都在给日后谈判桌上的分量添砖。")
rep("档期则要靠销项时限倒逼，别让「下周整改」变成没有截止日期的客套话。",
    "档期则要靠销项时限倒逼，别让「下周整改」变成没有截止日期的客套话。说到底这是个信任问题：台账造给检查组看，就容易变成应景文章；造给下一班作业者看，才会有人认真续写。")

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
print(f"WRITTEN. microE={len(P)}")
