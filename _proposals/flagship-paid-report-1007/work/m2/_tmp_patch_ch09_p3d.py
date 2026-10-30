# -*- coding: utf-8 -*-
"""ch09 pass3 微批D — 最后 ~50 types"""
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

rep("**面对隐性制度性风险，企业通常有两类反应", "**面对这类不上台面的制度性风险，企业通常有两类反应")
rep("密松一案，中方先后砸进30多亿元、每年还要新增约3亿元财务费用", "密松一案，中方先后砸进30多亿元、每年还得多掏约3亿元财务费用")
rep("> - 累积代价：近五千亿卢比拖欠悬顶", "> - 累积代价：将近五千亿卢比的欠账悬顶")
rep("详细索赔报告通常要求在通知后42天内提交，经工程师或业主代表批准可延长",
    "详细索赔报告则通常要在通知后42天内交出，经工程师或业主代表批准可顺延")
rep("事故调查报告先定直接原因与管理原因", "由事故调查报告先行认定直接原因与管理原因")
rep("（验收结论造假实测风险值174.9）", "（验收结论造假一项实测出风险值174.9）")
rep("会传导为关键岗位到位率下降（第四层）", "会传导为关键岗位人手告急（第四层）")
rep("海外电力工程总承包项目的风险可以细分为五层", "海外电力工程总承包项目的风险能细分成五层")
rep("海外电力工程的风险管理，不是给项目买一份「保险」", "海外电力工程的风险管理，从来不是给项目买一份「保险」")

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
print(f"WRITTEN. microD={len(P)}")
