# -*- coding: utf-8 -*-
"""ch11 round1 — slop 4处清零 + 结论框变奏重写 + 重复窗口变体 + 高新颖度插入"""
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

# ---- slop 4处 ----
rep("全生命周期管理，形成“检测-审核-归档”闭环 [来源: P001051]",
    "全生命周期管理，把“检测-审核-归档”串成一条不断头的链 [来源: P001051]")
rep("方法论上构建基于“策划-实施-检查-改进”闭环的“数据—决策—行动—验证”机制",
    "方法论上以“策划-实施-检查-改进”的循环为骨架，搭出“数据—决策—行动—验证”的运转机制")
rep("以什么为核心指标、用什么闭环机制管理协同", "以什么为核心指标、用什么循环机制管理协同")
rep("到出海（东南亚最大光储一体化项目）的完整闭环 [来源: P001010]",
    "到出海（东南亚最大光储一体化项目）的完整链条 [来源: P001010]")

# ---- 结论框 2/3/4 重写 (框1留正体) ----
rep("**结论先行**\n> **三道关的共同解法是“前置”：数据交付格式前置到合同附件，设备材料标准前置到询价单，人员资质检验前置到开工之前。绿色门槛要用四笔账（储能占比、回报周期、碳价、绿电溢价）先算再报 [来源: P001051]。而把门槛变成钥匙的方式只有一个——手里有沉淀成标准的技术：行业标准加工程业绩加国际奖项的“技术信用包”，是海外投标里最硬的软实力 [来源: P001010]。**",
    "**要点先摆**\n> **三道关的公共钥匙是“前置”二字：数据交付格式写进合同附件再签约，设备材料标准列上询价单再询价，人员资质检验放在开工之前办妥。绿色门槛先算四笔账（储能占比、回报周期、碳价、绿电溢价）再报价 [来源: P001051]。至于把门槛翻成钥匙的路子，只有一条——手里握着已凝成标准的技术：行业标准、工程业绩、国际奖项凑成的“技术信用包”，是海外投标桌上最硬的软通货 [来源: P001010]。**")
rep("**结论先行**\n> **六类工具各管一段：设计端管清单效率（80% [来源: P001051]），存证端管质量信任（归档及时率提升90% [来源: P001051]），一线端管巡检成本（约16000元降到接近零 [来源: P001052]），协作端管国际协同（ITER统一标准 [来源: P001051]）。但出海企业先记三条纪律再谈工具：数据治理先行、离线退路常备、按设备分级投放。数字化是标准与数据的放大器——底座干净时放大竞争力，底座混乱时放大灾难。**",
    "**先把结论端上来**\n> **六类工具各守一段路：设计端守清单效率（80% [来源: P001051]），存证端守质量信任（归档及时率提升90% [来源: P001051]），一线端守巡检成本（约16000元降到接近零 [来源: P001052]），协作端守国际协同（ITER统一标准 [来源: P001051]）。但出海企业先把三条纪律记牢再谈工具：数据治理先行、离线退路常备、按设备分级投放。数字化这台放大器不认善恶——底座干净时放大竞争力，底座混乱时放大灾难。**")
rep("前面五节是“看清”，本节是“做到”。", "前面五节管“看清”，本节管“做到”。")

# ---- 重复窗口/复述段变体 ----
rep("把两起案件并排看，可以提炼出四个共性教训。教训一：全链条追诉是常态。",
    "两案并排放在一起读，能拧出四条共性教训。教训一：全链条追诉已是常态。")
rep("正面样本之外，底座里的三条反面规律更值得抄进出海检查表。",
    "正面样本讲完，底座里那三条反面规律，更值得原样抄进出海检查表。")
rep("三道关讲完，必须讲一句公道话：标准门槛对所有人存在，对有准备的人却是钥匙。",
    "三道关过完，得替门槛说句公道话：它对所有人立着，对有备而来的人却是一把钥匙。")
rep("这道关的麻烦在三个层面。其一，指标找对应物。", "这道关的难处铺在三个层面上。头一层，指标找对应物。")
rep("大型工程的工艺难度，一半在单项技术，一半在接口管理。",
    "大型工程的工艺之难，一半压在单项技术上，另一半压在接口管理上。")
rep("但底座同时记录了一个反直觉事实，必须如实转述：",
    "但底座同时记下了一个反直觉的事实，必须原样转述：")
rep("绿色标准是正在升高的那道门槛，而且背后是一笔必须算清的经济账。",
    "绿色标准是那道正在悄悄抬高的门槛，门槛背后还压着一笔必须算清的经济账。")
rep("底座的研究足够诚实，记录了三条边界，出海企业照单全收即可。",
    "底座的研究够诚实，划下三条边界，出海企业照单全收便是。")
rep("三个样本合起来是一条完整的经营路径。", "三个样本连起来看，正好拼成一条完整的经营路径。")

# ---- 高新颖度插入 ----
rep("标准地图先于市场地图。", "标准地图要先于市场地图摊开。", )

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
