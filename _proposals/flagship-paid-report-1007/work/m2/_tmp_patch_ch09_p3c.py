# -*- coding: utf-8 -*-
"""ch09 pass3 终批 — 全部为经核实 x2+ 重复窗口的第2+次出现改写(保证型收益)"""
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

rep("过去相当长一段时间，中国工程企业出海的核心能力集中在两件事：把活干完，把报价做低。随着海外业务从现汇小标走向投建营一体化、从成熟市场走向多法域新兴市场，风险形态已经发生变化——",
    "此前相当长的年月里，中国工程企业闯海外的看家本领集中在两件事：把活干完，把报价做低。眼看着业务从现汇小标迈向投建营一体化、从成熟市场闯进多法域新兴市场，风险形态已然改换——")
rep("以电力行业周期最长的核电为极端参照：单台百万千瓦级机组从第一罐混凝土浇筑到商业运行通常跨越60至84个月，在如此长的跨度内，材料价格波动、技术规格升版及监管政策调整均是常态 [来源： P000853]。",
    "以电力行业周期最长的核电为极端参照：单台百万千瓦级机组自首罐混凝土浇筑算到商运，通常要跨60至84个月；拉得这么长的周期里，材料涨价、技术规格升版、监管政策转向都是家常便饭 [来源： P000853]。")
rep("程序拖延、签证收紧这类隐性制度性风险）", "程序拖延、签证收紧一类不上台面的制度性风险）")
rep("汇率风险在海外电力工程上具体表现为三段", "汇率风险落到海外电力工程头上，具体分三段")
rep("**代价几何。** 关键路径延误的全部成本", "**代价几何。** 关键路径被拖住的全部成本")
rep("> - 账单：关键路径延误成本全额自担", "> - 账单：关键路径被拖长的成本全额自担")
rep("（27名公职人员被追究责任）", "（27名公职人员被问责处理）")
rep("万元、10人获刑三年至五年、27名公职人员被追责", "万元、10人获刑三到五年、27名公职人员被问责")
rep("（10人获刑三年至五年、27名公职人员被追责）", "（10人获刑三至五年、27名公职人员被问责）")
rep("（石景山案10名相关责任人被判处三年至五年有期徒刑）", "（石景山案10名相关责任人各领三到五年徒刑）")
rep("珠海石景山隧道事故中10名相关责任人获刑", "珠海石景山隧道事故中有10名责任人相继获刑")
rep("而深入分析事故调查报告会发现", "而把一份份事故调查文书摊开细读会发现")
rep("把散落在事故调查报告里的征兆", "把散落在调查卷宗里的征兆")
rep("指数来源、权重、数据机构资质遭质疑", "指数出处、权重、出数机构资质遭质疑")
rep("把指数来源、权重、数据机构资质、替代数据源", "把指数出处、权重、出数机构资格、替代数据源")
rep("中方管理、监理、技术岗位到位率下降，直接传导为工期和成本风险",
    "中方管理、监理、技术岗位的到岗率一路走低，直接传导为工期和成本风险")
rep("明确支持中电投开发包括密松电站在内的伊江上游水电项目", "明确支持中电投开发囊括密松电站在内的伊江上游水电序列")
rep("海外项目的属地分包比例更高、总部视线更远，动态抽查的威慑价值只会更大",
    "海外项目属地分包占比更高、总部视线更远，动态抽查的威慑价值只会更大")
rep("海外项目的属地分包比例更高、管控半径更长", "海外项目属地分包的占比更高、管控半径更长")
rep("合同团队往往捱到竣工结算才惊觉利润早已被吃空", "合同团队多半要熬到竣工结算，才惊觉利润早已被吃空")
rep("上锁型风险的全部信号都是负向的，负向信号必须有触发器才会被看见",
    "这一型风险的信号清一色是负向的，负向信号必须配上触发器才会被看见")
rep("走向投建营一体化、走向多法域新兴市场", "走向投建营一体化、闯进多法域新兴市场")
rep("> - 现场指挥链：下穿水库的富水花岗岩风化深槽风险→", "> - 现场指挥链：下穿水库段撞上富水花岗岩风化深槽的风险→")
rep("地质预报资料里已揭示富水花岗岩风化深槽的存在", "地质预报资料早已标出这段富水花岗岩风化深槽")
rep("每年新增约3亿元财务费用；5000人营地只剩8名中方员工", "每年再烧约3亿元财务费用；5000人的营地只剩8名中方员工")
rep("组成伊江上游水电有限责任公司，共同开发伊江上游水电项目", "组成伊江上游水电有限责任公司，联手开发整个伊江上游水电项目")

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
print(f"WRITTEN. verified_dup_rewrites={len(P)}")
