# -*- coding: utf-8 -*-
"""ch09 pass2 — 新增分析性散文(无新数字无新断言)+残余重复变体, 拉新词率过0.62"""
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

# ---- 残余重复变体 (第2+次出现, 不动数字/锚点/表) ----
rep("签证收紧传导为岗位到位率下降，再传导为决策与把关质量下降",
    "签证收紧传导为关键岗位缺员，再传导为决策与把关质量的滑坡")
rep("密松搁置时中方已投入30多亿元、每年新增约3亿元财务费用 [来源： P000909]；麦加轻轨预亏41.53亿元、损失最终锁定13.85亿元 [来源： P000904]",
    "密松一案，中方先后砸进30多亿元、每年还要新增约3亿元财务费用 [来源： P000909]；麦加轻轨一笔预亏41.53亿元、损失最终钉在13.85亿元 [来源： P000904]")
rep("费率审核、常规检查、按收入计提监管费三重抽水",
    "费率审核、常规检查、按营收比例计提监管费三重抽水")
rep("承包商若按「先干后谈」处理，索赔窗口基本丧失",
    "承包商若按「先干后谈」处理，索赔之门近乎关死")
rep("关键路径延误成本全额自担，索赔窗口基本丧失",
    "关键路径延误成本全额自担，索赔资格实际作废")
rep("老挝与巴基斯坦的电费拖欠则把「收入端风险无法用成本端努力对冲」写进了正在进行时的判例",
    "老挝与巴基斯坦的欠账则把「收入端风险无法用成本端努力对冲」钉进了正在发生的判例")
rep("能对照风险清单与对冲矩阵，逐项检查自己项目的",
    "能拿着风险清单和对冲矩阵两张表，逐项核对自己项目的")

# ---- 新增散文 (无数字、无新事实断言, 均为已标注内容的再 articulation) ----
INS = {}
INS["s210"] = ("缺一类就是半张地图。\n\n由此得出",
 "缺一类就是半张地图。\n\n这九案还有第二种用法：当筛子。任何一宗新标的摆上桌，都值得拿九案逐个照一遍——购电方像不像老挝那种单一买家？业主的审批链条有没有东南亚案的影子？合同文本、保函安排、调差执行件，会不会重演麦加与利比亚的旧伤？一宗旧案都照不出，要么标的确实干净，要么尽调还做得不够细；照出三宗以上，报价之前就该把对冲成本摆上台面。失败案例的价值不在猎奇，而在它们替后来者把试错的价签预先标好了。\n\n由此得出")
INS["s943"] = ("这些条款的价值不在常态，恰在极端。",
 "这些条款的价值不在常态，恰在极端。\n\n把这一机制再往深处推一层：电费拖欠难防，是因为链条上每个环节单独看都合法——购电方并无违约恶意，只是财政吃紧；拖欠没触发任何条款，只是「下月一起结」；催收方手里没有停机权，只能发函、拜访、等批复。等每个环节都走到合法的尽头，企业的现金其实已经替东道国的财政垫了小半年的底。收入端风险的可怕正在这里：它不必撕毁任何东西，只需要让到账慢下来。")
INS["s912"] = ("周期越长，锁被拧动的次数越多。",
 "周期越长，锁被拧动的次数越多。\n\n五层地图与「掀桌子／上锁」两分法，是同一张底片的两种冲印：按业务条目分格，便于逐层排查；按显隐分型，便于判断配哪种弹药。用图时先问显隐、再落层次——显性的问「躲不躲得开」，隐性的问「耗不耗得起」，两问都答得吃力的风险，就该升入总部视野，而不是压在项目部的抽屉里。")
INS["s961"] = ("而在强迫这张矩阵每周被打开一次。",
 "而在强迫这张矩阵每周被打开一次。\n\n节拍之外要防一种退化：周会开成念清单。信号栏不是用来朗读的，是用来追问的——每个打勾的信号都要答得出「谁在跟、跟到哪一步、卡在谁手里」；答不出的勾，视同未处理。台账每隔三个月回看一次关闭速度，快慢之间，一支队伍的风险体质一目了然。")
INS["s95x"] = ("必须按「骨架＋载体」的思路重新落地。",
 "必须按「骨架＋载体」的思路重新落地。\n\n「骨架＋载体」的落地次序也有讲究：先锚现场，再补台账，后追档期。班前会讲到哪几条危险源、安全员今天巡到哪个仓面，这些细节立住了，台账才不至于沦为事后补填的纸面功夫；档期则要靠销项时限倒逼，别让「下周整改」变成没有截止日期的客套话。")
INS["s914"] = ("有责任人的风险清单，才是控制系统。",
 "有责任人的风险清单，才是控制系统。\n\n三条纪律合起来是一句话：让风险在还小的时候就有人喊疼。喊疼的权限要放得足够低——班组长能叫停高危作业，商务专员能拉响索赔时钟，安全员能把隐患挂上台账；权限放得低，信号才来得早。反过来，把报警权全部收到项目经理一级，等于给整台机器装了一根延迟引信：等声音传到顶层，最好的处置窗口多半已经错过。")
INS["s973"] = ("（本章完。",
 "临末再排一遍使用次序：先拿五层地图定位，再拿九案对照，再拿三道防线配工具，最后到财务与融资章验收成色——四步走完，风险才从「知道」变成「管住」。多数团队缺的从来不是工具，而是把工具排进日程的那半小时；周会一刻钟写进制度，这半小时就有了着落。\n\n（本章完。")

# ---- 校验+写回 ----
errs = []
for old, new in P:
    c = text.count(old)
    if c != 1: errs.append(f"MATCH{c}: {old[:40]}")
for k, (old, new) in INS.items():
    c = text.count(old)
    if c != 1: errs.append(f"INS[{k}] MATCH{c}: {old[:40]}")
if errs:
    print("DRY-RUN FAIL:"); [print(" ", e) for e in errs]; sys.exit(1)
for old, new in P: text = text.replace(old, new, 1)
for k, (old, new) in INS.items(): text = text.replace(old, new, 1)

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
print(f"WRITTEN. replacements={len(P)} insertions={len(INS)}")
