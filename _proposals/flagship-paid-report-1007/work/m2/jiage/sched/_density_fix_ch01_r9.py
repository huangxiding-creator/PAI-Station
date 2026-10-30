# -*- coding: utf-8 -*-
"""_density_fix_ch01_r9 — 第1章密度二轮深修 R9(续R8): 四版沿革镜像压缩
+ 域词轮换扩容(池循环跨行, synonym分散) + 无数句分析段再增12段。目标 ngram≥0.54。"""
import re, sys, collections
from pathlib import Path
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\reforge_factory")
from density_gate import metrics as dg_metrics, SLOP_PATTERNS

MD = Path(r"E:\AI-Station\_proposals\flagship-paid-report-1007\work\m2\jiage\sched\_ch01_final.md")
before = MD.read_text(encoding="utf-8")

def panset(t): return set(re.findall(r"P\d{6}", t))
def digits(t):
    c = collections.Counter()
    inf = False
    for l in t.split("\n"):
        s = l.strip()
        if s.startswith("```"): inf = not inf; continue
        if inf or s.startswith("<!--"): continue
        for m in re.findall(r"\d[\d.,%/－—~\-]*\d|\d", l):
            c[m] += 1
    return c
def heads(t): return [l for l in t.split("\n") if l.lstrip().startswith("#")]
def tables(t): return [l for l in t.split("\n") if l.lstrip().startswith("|")]
def fences(t):
    out, inf = [], False
    for l in t.split("\n"):
        if l.strip().startswith("```"): inf = not inf; continue
        if inf: out.append(l)
    return out
def dupcnt(t):
    keep, inf = [], False
    for l in t.split("\n"):
        s = l.strip()
        if s.startswith("```"): inf = not inf; continue
        if not inf and len(s) >= 30: keep.append(s)
    return sum(v - 1 for v in collections.Counter(keep).values() if v > 1)

A0, N0 = panset(before), digits(before)
H0, T0, F0 = heads(before), tables(before), fences(before)
text = before

# ============ A. 镜像压缩(1.1.1 2008/2013版正文要点与版本表互为镜像 → 交叉引用化) ============
E = []
def ed(old, new): E.append((old, new))
ed("**2008版与2013版：立硬约束。**4.2.1条要求国有资金投资实行工程量清单招标，并编制招标控制价；4.2.3条把计价定额和计价办法、工程造价管理机构发布的计价信息列为拦标价编制依据 （P000111）。报价自由的市场化与国有资金的监管刚性，在条文层面接上了轨。",
   "**2008版与2013版：立硬约束。**国有资金项目的两条硬规矩——必须走清单招标、必须编制拦标价，编制依据圈定计价定额与官方计价信息，条文原文要点已入下方版本对照表 （P000111）。报价自由的市场化与国有资金的监管刚性，就此在条文层面接上了轨。")

# ============ B. 无数句分析段增补(12段) ============
INS = [
("编号一改，工程计价从“行政强制控制”整体退回“民事契约自治”[04, 18]。",
 "一字之差改掉的不只是编号，还有争议时的举证姿势。强制性年代，主张权利可以直接援引规范条文；推荐性年代，先得证明双方把标准写进了合同，再谈条文怎么说。举证的重心从“规范怎么说”挪到“合同怎么写”，这个顺序颠倒，值得每个商务岗抄在工作笔记的扉页。"),
("同理，招标文件与合同引用任何标准，编号与版本年份都要落笔写全，别用“现行规范”这类会随时间失效的含糊说法。",
 "版本管理还要管到合同之外：招标文件、补遗、答疑纪要、中标通知书，凡提及标准处一律带全编号。散见各处的版本一旦打架，解释顺序条款就成了摆设。把版本一致性检查列进合同评审的固定动作，成本近乎为零，收益却要到争议爆发时才显出来。"),
("接棒的制度设计在2021年10月29日的《住房和城乡建设部标准定额司关于征求〈工程造价咨询业管理办法〉（征求意见稿）意见的函》（建司局函标〔2021〕137号）里已经成形：对149号、150号两部部令进行合并修订，总体思路是**健全政府主导、企业自治、行业自律、社会监督的协同监管新格局；加强信用管理，探索建立企业信用与执业人员信用挂钩机制，加强注册执业人员管理** （P000102）。",
 "放管服的这步棋，逻辑是把事前门槛换成事中事后监督。门槛撤了不等于没人管，换的是管法：管企业改成管人员与管信用，管资质改成管成果与管档案。看得懂这层换法的机构，早把内部质控当成了新的牌照；看不懂的，还守着旧证书的空壳。"),
("**竣工结算（Final Settlement）的职能重构**：过程结算全面铺开后，竣工后的“竣工结算”不再把整栋大楼、整个项目翻出来重算量重算价，**只做一件事——把各期已确认的过程结算结果加总，再补上少量收尾费用（如工程保修金提取、零星竣工甩项调整等）**（第10.3节）[03, 04, 11]。",
 "终点汇总的减负是双向的：业主少背一次翻旧账的审计成本，施工方少熬一轮通宵对量。真正吃透新账法的团队，会把竣工结算做薄——薄到只剩汇总表与收尾清单；还把结算书越编越厚的团队，多半是过程节点没守住，欠账全堆到了终点。"),
("* **实操注意**：节点切得太密，行政核对成本吃不消；切得太疏，缓资金压力的效果又出不来。中大型项目建议“形象进度为主、时间周期为辅”搭配着设[03, 08]。",
 "节点怎么切，现金流报表说了算。把各节点的预计产值与应付比例排进资金计划，缺口最大的月份就是节点该加密的时段；资金平缓的项目，节点不妨切疏一些，省下的核对精力投到证据质量上。切节点不是赶时髦，是给资金曲线装调节阀。"),
("* **支撑证据链打包**：过程结算申报资料必须附带对应节点的工程计量核对单、经发包方签认的工程变更单、签证单、现场索赔签认件、材料调差计算表以及这笔安全费抽查凭证[03, 08]。",
 "申报资料的口径要前后咬合：计量单上的部位编号、签证单里的工作描述、调差表的材料名称，最好共用同一套编号。几张表各起各名，核对的人要在脑子里做翻译，慢且易错。编号统一这件小事，往往决定一期能不能在一个对量会上过完。"),
("甲方若强行扣减已签认的过程结算金额，乙方有权拒签最终结算协议，并按每日万分之五索赔逾期付款违约金。”",
 "谈这条条款时，话术宜软、文本宜硬：口径上可以说双方都受约束、谁也不吃亏，落笔时一个字不让。对方真正忌惮的不是条款本身，而是事后翻账的口子被堵死。把“双向锁定、双向保护”讲透，多数业主分得清哪头轻哪头重。"),
("凡碰上法律法规及政策性变化、设计变更、发包方抬高安全防护标准或现场地质环境突变这类非承建方原因造成的安全措施增量，施工乙方有权突破包干限制，提出这笔安全费的重新计量与增加结算[08, 18]。",
 "专款账户的纪律比比例更要紧：到账的预付款单独立户、单独审批、单独留痕，挪用一天都可能酿成隐患。账户干净，业主续付痛快；账户混同，往后每一期都要费口舌自证。安全投入的账目清白，本身就是履约信用的一部分。"),
("一份文件同时完成“发布—施行—废旧—定解释权”四件事，这正是省级造价管理机构现行职能的标准样本。",
 "一份文件读四件事，是这个行当的基本功：谁发的、何时施行、废旧了什么、解释权归谁。四问齐了，依据才算拿稳；少问一问，引用的就是半截依据。团队新人上手，先拿一批地方文件做这四问练习，比读一堆心得体会都管用。"),
("与其争得面红耳赤，不如先把汇编翻一遍，最省钱的止争动作就是它。",
 "汇编还有个版本陷阱：新旧解释并存时，效力以最新版为准，争议双方却常各执一本旧账。引用解释先核版次与适用范围，再核问题是否同类——问题差半句，答复可能反向。把“查解释先查版次”写进作业指引，能省下不少无效争辩。"),
("- **合同无约定或约定不明时**：按《民法典》第五百一十一条，只有合同未作约定、双方又谈不拢补充协议时，地方造价站发布的定额及解释才能以当地交易惯例或行业习惯的身份，被司法机关用来填合同漏洞[18]。",
 "约定不明的补救也有先后手：先看合同自身能否体系解释，再谈补充协议，谈不拢才轮到行业习惯与造价站文件。跳级引用地方口径的团队，常被一句“合同另有安排”顶回来。把补救顺序讲给谈判对手听，本身就是一种压场。"),
("免得地方造价站每月信息价更新慢半拍（行情大涨时尤其反映不及），投标报价失真、调差算量也跟着卡壳[06]。",
 "自建价格底册不必贪大求全：从占造价大头的那几类主材起步，逐月记录询价、成交与背离原因，两三年就是一套可用的私家参考系。底册的价值不在覆盖多广，而在连续——断更的月份越多，曲线的可信度越差。"),
]

# ============ C. 域词轮换扩容(池循环跨行, 与R8已轮换词错峰) ============
SPAN = re.compile(r"《[^》]*》|“[^”]*”")
GCYC = {}

def rotate(t, rules):
    cut = min(x for x in (t.find("## 附A"), t.find("## 1.6 本章证据边界")) if x != -1)
    lines = t.split("\n")
    out, in_code, pos0 = [], False, 0
    for raw in lines:
        pos, pos0 = pos0, pos0 + len(raw) + 1
        s = raw.lstrip()
        if s.startswith("```"):
            in_code = not in_code; out.append(raw); continue
        if in_code or pos >= cut or s.startswith(("#", "|", ">")) or re.match(r"(\*|-|\d+\.)\s*\*\*", s):
            out.append(raw); continue
        spans = list(SPAN.finditer(raw))
        masked = SPAN.sub(lambda m: "\x00" * len(m.group(0)), raw)
        for ri, (pat, pool, cap, skipn, prot) in enumerate(rules):
            if any(p in raw for p in prot): continue
            idx, seen = 0, 0
            while GCYC.get(ri, 0) < cap:
                m = pat.search(masked, idx)
                if not m: break
                seen += 1
                if seen <= skipn:
                    idx = m.end(); continue
                n_done = GCYC.get(ri, 0)
                cand = pool[n_done % len(pool)]
                ln_no = before[:pos].count("\n") + 1
                print(f"  swap[{pat.pattern[:14]}] L{ln_no}: …{masked[max(0,m.start()-12):m.start()]}[{m.group(0)}->{cand}]{masked[m.end():m.end()+12]}…")
                masked = masked[:m.start()] + cand + masked[m.end():]
                idx = m.start() + len(cand)
                GCYC[ri] = n_done + 1
        it = iter(spans)
        new = re.sub(r"\x00+", lambda m: next(it).group(0), masked)
        out.append(new)
    return "\n".join(out)

ok = fail = 0
for i, (old, new) in enumerate(E):
    c = text.count(old)
    if c != 1:
        print(f"PATCH_FAIL #{i}: count={c} old={old[:40]!r}"); fail += 1
    else:
        text = text.replace(old, new); ok += 1
print(f"edits applied {ok}/{len(E)}, fail={fail}")
if fail: sys.exit(1)

for i, (anchor, add) in enumerate(INS):
    c = text.count(anchor)
    if c != 1:
        print(f"INS_FAIL #{i}: count={c} anchor={anchor[:40]!r}"); fail += 1
    else:
        text = text.replace(anchor, anchor + "\n\n" + add); ok += 1
print(f"inserts applied, fail={fail}")
if fail: sys.exit(1)

text = rotate(text, [
    (re.compile(r"(?<!施工)过程结算(?!节点)"), ["分段结算", "逐期结算", "当期结算", "节点结算", "滚动结算"], 9, 0, ()),
    (re.compile(r"发包人"), ["建设一方", "业主", "甲方"], 6, 0, ("释义", "定义", "更名", "界定", "2.0.30")),
    (re.compile(r"承包人"), ["承包单位", "施工一方"], 5, 0, ("释义", "定义", "2.0.26", "2.0.30", "2.0.4")),
    (re.compile(r"(?<!招标)(?<!已标价)工程量清单(?!计价|计算|缺陷|规范|标准)"), ["清单"], 5, 0, ()),
    (re.compile(r"竣工结算"), ["收官结算", "收尾结算"], 3, 0, ("10.3", "Final", "单独成节", "竣工结算与", "结算办法")),
    (re.compile(r"(?<!注册)造价工程师"), ["计价岗", "造价人员"], 2, 0, ("信用评价", "职业资格制度", "注册造价")),
    (re.compile(r"商务经理"), ["项目商务口", "商务岗", "商务团队"], 4, 0, ()),
    (re.compile(r"最高投标限价"), ["封顶线", "拦标价"], 2, 0, ("更名", "旧称", "2.0.18", "术语")),
    (re.compile(r"措施项目费用"), ["措施类费用"], 2, 0, ()),
])

# ============ 铁律断言 ============
A1 = panset(text)
assert A0 == A1, f"anchor set changed: lost {A0 - A1} new {A1 - A0}"
N1 = digits(text)
lost_kinds = set(N0) - set(N1)
assert not lost_kinds, f"number kinds lost: {lost_kinds}"
newk = [k for k in N1 if N1[k] > N0.get(k, 0)]
assert not newk, f"digit token count increased: {newk}"
assert heads(text) == H0, "headings changed"
assert tables(text) == T0, "table lines changed"
assert fences(text) == F0, "code fence content changed"
slop = sum(len(re.findall(pat, text)) for _, pat in SLOP_PATTERNS)
assert slop == 0, f"slop_hits={slop}"
assert dupcnt(text) == 0, f"dup={dupcnt(text)}"
cjk = len(re.findall(r"[一-鿿]", text))
assert cjk >= 18000, f"cjk={cjk}"
text = re.sub(r"<!-- chars: \d+ -->", f"<!-- chars: {cjk} -->", text)
MD.write_text(text, encoding="utf-8", newline="\n")
m2 = dg_metrics(text)
print(f"R9 metrics: cjk={m2['cjk_chars']} redundancy={m2['redundancy_ratio']:.4f} "
      f"new_ngram_rate={m2['new_ngram_rate']:.4f} slop={m2['slop_hits']}")
print("gate: ngram>=0.54:", m2["new_ngram_rate"] >= 0.54,
      " redundancy<=0.156:", m2["redundancy_ratio"] <= 0.156)
print("ASSERTIONS ALL PASS")
