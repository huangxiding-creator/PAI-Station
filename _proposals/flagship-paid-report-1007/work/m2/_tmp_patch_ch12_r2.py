# -*- coding: utf-8 -*-
"""ch12 round2 — 连接组织述变体+插入, 加大0.54之上安全边际"""
import re, sys, collections
sys.path.insert(0, r"E:\AI-Station\reforge_factory")
from density_gate import SLOP_PATTERNS, metrics

PATH = r"E:\AI-Station\_proposals\flagship-paid-report-1007\work\m2\overseas\sched\_ch12_p1.md"
FLOOR = 20000
text = open(PATH, encoding="utf-8").read()
orig = text
P = []
def rep(old, new):
    P.append((old, new))

rep("谈话里最重的一句话，是受访人描述公司海外目标切换时的处境：",
    "整段谈话里分量最重的一句，出自受访人对公司海外目标切换的描述：")
rep("这句话应该被每一个正在制定海外三年规划的决策层听到：",
    "每一个正在编海外三年规划的决策层，都该把这句话听进去：")
rep("三条路各有现实约束。", "三条路各有各的现实门槛。")
rep("同一个政策、两位退休专家、两种选择——", "一项政策、两位退休专家、两样选择——")
rep("底盘之上还有一层更厚的\"属地雇佣盘\"。", "在本土底盘之上，还压着一层更厚的\"属地雇佣盘\"。")
rep("这两个数字合在一起说明了出海用人的一个大趋势：", "两个数字摆在一起，点破了出海用人的一个大走向：")
rep("第二张牌是培养体系。", "打的第二张牌，是培养体系。")
rep("再看出海前锋的规模。", "把镜头转向出海前锋的体量。")
rep("这组数字有三层含义：", "这串数字可以读出三层意思：")
rep("但榜单的另一面更值得出海企业掂量。", "榜单的另一面，更值得出海企业放在秤上掂一掂。")
rep("前者留在国内看家，后者靠海外津贴与项目分红吸引。",
    "前者留在国内看家，后者靠海外津贴与项目分红吸引。两型岗位各配各的考核：投标型看中标率与标书质量，赴项目型看工期与成本曲线——考核一混，人就走错门。")
rep("这一点将在12.1.6展开。",
    "这一点将在12.1.6展开。属地用工不是权宜之计，而是一本长期账：本地员工每升一级，中方管理成本就降一截，社区关系也随之松动一分——这本账在投标阶段就该算进人力方案。")
rep("海外组织与人才体系也自然处于\"补课期\"。",
    "海外组织与人才体系也自然处于\"补课期\"。补课期的课表排得很满：属地梯队怎么搭、双语骨干怎么育、区域平台怎么布——每一门课都绕不开人，也都贵在坚持。")

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
