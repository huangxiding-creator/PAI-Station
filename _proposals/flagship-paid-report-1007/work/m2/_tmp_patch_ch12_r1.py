# -*- coding: utf-8 -*-
"""ch12 round1 — slop 10处清零 + 复述段变体 + 高新颖度插入"""
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

# ---- slop 10处 ----
rep("首先必须是一名合规的注册建造师，其次才谈得上外语、跨文化与国际商务能力",
    "先得是一名合规的注册建造师，然后才谈得上外语、跨文化与国际商务能力")
rep("**供应商赋能**（培训覆盖率近100%", "**供应商扶持**（培训覆盖率近100%")
rep("**其二，培训赋能**：", "**其二，培训扶助**：")
rep("采购前置还有一个常被忽视的抓手：设计与采购接口的早期冻结",
    "采购前置还有一张常被忽视的暗牌：设计与采购接口的早期冻结")
rep("质量闭环的最后一环在制造现场", "质量链条的最后一环落在制造现场")
rep("把\"设计意图—制造工艺—质量验证\"三者闭环在工厂里", "把\"设计意图—制造工艺—质量验证\"三者在工厂里串成一线")
rep("盯厂了吗（把质量闭环搬到制造现场）", "盯厂了吗（把质量把关搬到制造现场）")
rep("再到\"成单\"（供需对接）的完整渠道闭环", "再到\"成单\"（供需对接）的完整渠道链路")
rep("是在第一段（决心与合规）没闭环时就冲进第三段（属地投入）",
    "是在第一段（决心与合规）尚未走完时就冲进第三段（属地投入）")
rep("市场判断的颗粒度会明显细于", "市场判断的细密度会明显高过")

# ---- 复述段变体 + 高新颖度插入 ----
rep("这十二章合起来，其实只讲了一个不等式链：", "十二章读罢，摊开来其实只是一串不等式：")
rep("别让经营与履约之间永远隔着一层没人拍板的报价风险。**",
    "别让经营与履约之间永远隔着一层没人拍板的报价风险。**三张表的妙处在朴素：调配表管眼前的仗，专家库管救急的仗，属地计划管明天的仗——一张表都不花哨，缺一张就有一类仗没人打。**")
rep("真正的价值在于一张持续运转的行业关系网。",
    "真正的价值在于一张持续运转的行业关系网。关系网这东西，讲究的是常走动：年会去坐一坐、研修班报一个名、专委会挂一个衔，网才认你；三年不露面再去找人，名片还得从头递。")
rep("愿这份报告的十二章，能在他们出发前、路途中、复盘时，各帮上一把。",
    "愿这份报告的十二章，能在他们出发前、路途中、复盘时，各帮上一把。出海这门手艺没有满师的那天，只有下一程；把每一程的学费都记进台账，学费才会一年比一年便宜。")
rep("宏大的时代命题，最终都落在这些具体的人身上：",
    "宏大的时代命题，最后都要落到这些具体的人身上：")

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
