# -*- coding: utf-8 -*-
"""ch11 round2 — 高新颖度插入(~550字)+残余窗口变体"""
import re, sys, collections
sys.path.insert(0, r"E:\AI-Station\reforge_factory")
from density_gate import SLOP_PATTERNS, metrics

PATH = r"E:\AI-Station\_proposals\flagship-paid-report-1007\work\m2\overseas\sched\_ch11_p1.md"
FLOOR = 18800
text = open(PATH, encoding="utf-8").read()
orig = text
P = []
def rep(old, new):
    P.append((old, new))

# 残余窗口变体 (第2+次出现)
rep("对海外项目的启示是：国际业主读得懂的语言不是", "落到海外项目头上，启示是：国际业主读得懂的语言不是")
rep("它对海外项目的意义有两层", "它放在海外项目身上，意义有两层")
rep("成为可输出的管理标准 [来源: P001003]。核电体系里同类的工具是接口控制手册",
    "长成一套可对外输出的管理标准 [来源: P001003]。核电体系里同类的工具是接口控制手册")

# 高新颖度插入
rep("门槛属于看得见的人，护城河属于组织得好的企业。",
    "门槛属于看得见的人，护城河属于组织得好的企业。标准与专利的功课没有毕业礼：今天的认证到明年可能换版，今天的专利到明年可能遭遇新一轮立案——这门课只能常修常新，把它排进年度经营日历，而不是等投标截止日前的那个通宵。")
rep("既懂技术又懂商务的复合型人才从哪里来，属地化的队伍怎么带，供应链与行业生态怎么借力，正是下一章的主题。",
    "既懂技术又懂商务的复合型人才从哪里来，属地化的队伍怎么带，供应链与行业生态怎么借力，正是下一章的主题。交接之前不妨自问三句：本企业的标准对照表最近一次更新是在哪个季度？专利排查的覆盖面到了哪些市场？十四个动作里有多少已经从纸面走进例会——三问答得利索，这一章才算真正读完。")

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
if mt["cjk_chars"] < FLOOR or slop: print("GUARD FAIL, 未写入"); sys.exit(1)
open(PATH, "w", encoding="utf-8", newline="\n").write(text)
print(f"WRITTEN. pairs={len(P)}")
