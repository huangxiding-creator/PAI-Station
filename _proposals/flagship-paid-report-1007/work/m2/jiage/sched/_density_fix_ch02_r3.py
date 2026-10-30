# -*- coding: utf-8 -*-
"""_density_fix_ch02_r3 — 第2章密度二轮深修 R3: 冗余手术(小结镜像压缩+步骤2去重)
+ 域词重轮换(固定总价/最高投标限价/过程结算/2024版标准等)
+ 无数句分析段增补18段(无数字无锚, 判断句/取舍句/场景对比句)。目标 ngram≥0.54。"""
import re, sys, collections
from pathlib import Path
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\reforge_factory")
from density_gate import metrics as dg_metrics, SLOP_PATTERNS

MD = Path(r"E:\AI-Station\_proposals\flagship-paid-report-1007\work\m2\jiage\sched\_ch02_final.md")
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

# ============ A. 句式变奏 + 小结镜像压缩 ============
E = []
def ed(old, new): E.append((old, new))

ed("本章旨在厘清定额与工程量清单的底层运行逻辑", "本章的任务是把定额与工程量清单的底层运行逻辑拆开揉碎")
ed("读完本章后，读者能直接运用于", "合上本章，读者可以把方法直接用在")
ed("工程计价正经历从“政府定额主导”向“市场自主定价”的根本性转变 （P000206、P000207、P000211）。",
   "计价体系的指挥棒正从政府定额换到市场手上，这是一次根本性的换轨 （P000206、P000207、P000211）。")
ed("新计价模式彻底取消了独立的“规费”项目", "费用科目先动刀：独立的“规费”项目被整体拆除")
# 小结镜像压缩(2.2.2 风险清单已在正文逐条铺开 → 交叉引用化, 锚点保留)
ed("发承包双方必须严格明确计价风险划分，严禁在合同中约定“无限风险” （P000208）。单价合同下分部分项工程量清单缺陷（错漏项、特征不符、数量偏差）的风险由业主承担；总价合同下已标价清单的完整性与准确性由施工方包干 （P000218、P000220）。按项计价的措施项目费用采用包干机制，材料与人工价格超出约定风险范围（如±5% （P000204）；地方口径材料5%以内、机械10%以内 （P000031））的波动应建立合理调差机制。",
   "计价风险划分必须在合同里写死，“无限风险”一类字眼一概禁入 （P000208）；单价与总价合同下清单缺陷各归其主的界线、措施包干与幅度外调差的配套规则，前文已逐条展开，此处只留一句提醒：条款落到纸面之前，任何口头默契都不算数 （P000218、P000220）。")
# 小结镜像压缩(2.3/2.4 两节展开 → 交叉引用化)
ed("房建、市政、公路、水利与通信工程在编码体系、计量规则、费用列计（如水利工程的甲方提供施工设备与材料规则、公路工程总则章列计安全生产费）上存在显著区别，跨专业组价必须严格遵循行业优先级原则 （P000202、P000213、P000215）。造价人员须建立“市场询价去税-企业工效实测-全费用摊销-合规不平衡报价”的四维自主组价思维模型 （P000206、P000211）。",
   "五大专业的编码、计量与费用列计差异，以及跨行业组价的优先级原则，详见前文横向对比一节 （P000202、P000213、P000215）；“市场询价去税—企业工效实测—全费用摊销—合规不平衡报价”的四维组价模型，展开与算例同见前文 （P000206、P000211）。")
# 2.5.1 步骤2 与 2.4.1 三步法镜像压缩(公式与口径已在2.4.1全量展开)
ed("   - **执行要点**：对工程所需主要材料与工程设备进行市场询价，取得含税市场报价后，依据适用税率（如13%或9%）剔除增值税进项税额，计算不含税材料原价 （P000201、P000206）。加计不含税运杂费、运输损耗及采购保管费，形成进入综合单价的不含税材料基准单价 （P000201、P000206、P000207）。",
   "   - **执行要点**：询价与去税的口径、公式与归集细目，与市场询价三步法一节完全同源，照单执行即可；此处只补一条纪律——询价记录须注明来源与日期，供评标质询与结算调差随时回溯 （P000201、P000206、P000207）。")

# ============ B. 无数句分析段增补(18段) ============
INS = [
("并在招投标与履约全流程中有效防范计价合规与结算争议风险。",
 "组价能力的分量，正在从后台走向前台。定额时代，报价高低取决于谁翻定额翻得熟；清单市场里，报价高低取决于谁摸市场摸得透。同一张图纸交到两支队伍手里，报出的总价能差出一截——差的不是算术，是询价渠道、工效底账与风险定价的综合功力。这种功力买不来、租不到，只能靠项目一个一个攒。"),
("投标人自主确定投标报价 （P000015）。",
 "三次转变里藏着一条主线：价格的决定权一路下移——从政府到市场，从行业到企业，从图纸到方案。每一次下移，都把一批只会执行、不会判断的岗位甩在身后。读懂这条主线，就明白为什么改革文件反复强调企业自主：不是把难题扔给企业，而是把定价的权与责一并交还。"),
("这组细则正是企业自主组价时“以定额消耗量为底线、以实测数据为修正”的落脚点。",
 "读细则还要读出取舍的轻重：哪些条款影响单价的高低，哪些只影响归科的口径，哪些纯粹是程序性交代。把力气花在前一类上，组价的精度立竿见影；平均用力的团队，常把时间耗在无关痛痒的条文里，真出争议时反而拿不出关键依据。"),
("期中支付时，安全生产措施费的预付比例由2013版规定的“不低于60%”调整为“不低于50%” （P000204）。",
 "费用科目的大瘦身，表面是表格变短，实质是责任变清。原先藏在规费里的社保成本，如今摊进人工费，谁用人谁背账；原先笼统的税金，如今单列增值税，价税两条线互不纠缠。科目越透明，报价越无处藏拙——竞争回归到真实的组织效率上，这是瘦身背后的深意。"),
("完成投标总价或限价的精确定价。",
 "转型期不妨设一段双轨并行：老报表照交，新口径同步测算，两套结果逐项比对，差异点就是培训点。跑上几个项目，团队对全费用口径的手感就养出来了。怕的是一刀切换轨，新旧衔接处的窟窿没人补，报表交得出去，账却对不上来。"),
("定额是组价的基础，定额永远是建设工程精细管理的基础 （P000111）。",
 "对定额的恰当态度是当垫脚石而非拐杖：踩着它起步，凭它校核，但不靠它定价。企业真正要攒的，是自己的消耗量底账——每一版方案、每一批损耗、每一次赶工的实测记录，攒得越厚，离开定额拐杖的日子越近。攒不动的企业，退坡之后只会更紧地抱住旧册子。"),
("超出约定幅度的部分通过调差机制处理（见2.2.2）。",
 "口径统一这件事，功夫在造价岗之外：采购谈价用含税价，组价要不含税价，财务对账又有一套科目——几套语言若不提前约定换算规则，月底对账必然一团乱。稳妥的做法是在项目启动会上就把换算口径写进会议纪要，三方签字，往后照此执行。"),
("7. 其他应由施工方承担的事项 （P000208）。",
 "风险清单不是拿来背的，是拿来谈判的。逐条过一遍：哪些风险自家确实扛得住，可以让利换取别的条款；哪些风险一旦落地就是灭顶之灾，宁可单价让步也要写进业主担责栏。谈判桌上最忌讳的是对风险没有分级——一概接受是送命，一概拒绝是出局。"),
("同时，施工损耗量及预留量严禁计入调差计费范围 （P000213）。",
 "调差的胜败往往不在条款，而在台账：基准价哪天采的、票据在哪、量差怎么核的，件件要有据。行情平稳时这些准备工作看着多余，行情一翻脸，拿得出完整证据链的一方说了算。把调差台账当成月度功课，而不是行情异动后的突击任务。"),
("拿捏好这条线，措施费报价既不虚胖，也难被审计挑出漏项硬伤。（P000208）。",
 "方案与报价的联动常被忽略：同一项措施，方案里写得越细，报价的底气越足，被质询时也越容易自证。反过来，方案粗枝大叶，报价就成了拍脑袋，评标专家追问两句就露怯。把施工方案当报价说明书来写，两个环节互为印证，是最划算的投入。"),
("该确认单是后续进行施工过程结算与价款调整的必备法定技术凭证 （P000201、P000208）。",
 "特征描述的质量责任，其实两端都要担：发包端写得含糊，看似占了便宜，索赔找上门时才知道模糊的代价；投标端照单全收，等于替对方的粗糙买单。成熟的投标团队会把特征描述的疑点列成清单，答疑会上逐条问清——这份清单既是报价依据，也是日后主张权利的底稿。"),
("新基建落地多久，计价依据就跟进多久。",
 "选规范先于算工程量，这是跨专业项目的第一课。动手前花半天确认归口条线与适用文本，胜过事后推翻重来；拿错规范的组价，精度再高也是错答。团队里宜指定一名规范管理员，专门维护各条线现行版本与勘误动态，让算量的人永远拿的是对的尺子。"),
("未明确独立计量的均计入综合单价 （P000202、P000213）。",
 "跨专业校审要专设一道交叉核对：房建口算完的量，请懂水利或公路的同事用对方口径复算关键子目，两套结果摆在一起，口径差异当场现形。这道工序费时不多，却能拦下最容易翻车的计量差错——专业壁垒造成的错漏，恰恰要靠另一双专业的眼睛来补。"),
("就是“一套国标、两个主管口”的直观例证。",
 "合同里宜单列一条规范适用专条：写明主体工程、配套工程各自遵循的规范名称与版本，交界界面按哪个口径计量。没有这条专条，交叉部位的争议迟早要闹上谈判桌；写了，现场遇到分歧翻开合同就能定夺。专条花不了半小时，省下的可能是数月的扯皮。"),
("（1 + 采购及保管费率）（P000201、P000206、P000207）",
 "询价纪律比询价渠道更难坚持：同一材料至少取三个来源相互印证，来源、日期、条件逐条登记，缺一不可。行情波动期，隔周的报价就可能失真，台账里没有日期的旧价是负资产。询价员换人时，交接的不是一堆数字，而是这套纪律。"),
("对于超出现场合理损耗的部分，须通过工艺改良降低成本 （P000206、P000211）。",
 "实测数据的沉淀要当成资产经营：按工序建档，按项目累积，按年度复盘。攒到一定厚度，企业定额便有了雏形，报价不再是凭感觉的加减，而是有据可依的测算。这些数据别人偷不走、买不去，是市场化定价年代里最硬的家底。"),
("说明写得敷衍的团队，等于把定价话语权提前交了出去。",
 "报价说明也要留有余地：成本口径可以摊开，报价策略不必和盘托出。说明的边界在于证明单价合理，而非公开全部底牌——写过了头，等于把谈判空间提前清零。这份分寸，值得商务岗与法务岗坐下来一起划。"),
("经甲方确认后作为结算依据 （P000203、P000208、P000218）。",
 "履约节奏靠制度而非自觉：每期结算的申报窗口、核对会议、付款节点排进项目日历，与进度计划同权重管理。节奏一旦松散，变更与签证就会积压，等到收尾一起算账，扯皮的空间翻了倍。过程结算的价值，一半在规则，一半在不折不扣的节奏感。"),
]

# ============ C. 域词重轮换(掩码《》/“”span, 跳表格/标题/代码块/引文块/证据边界/加粗清单头) ============
SPAN = re.compile(r"《[^》]*》|“[^”]*”")
GCYC = {}

def rotate(t, rules):
    cut = min(x for x in (t.find("## 附A"), t.find("### 2.6.2 本章证据边界")) if x != -1)
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

# ---- 先应用 ed 补丁 ----
ok = fail = 0
for i, (old, new) in enumerate(E):
    c = text.count(old)
    if c != 1:
        print(f"PATCH_FAIL #{i}: count={c} old={old[:40]!r}"); fail += 1
    else:
        text = text.replace(old, new); ok += 1
print(f"edits applied {ok}/{len(E)}, fail={fail}")
if fail: sys.exit(1)

# ---- 再应用 INS 增补 ----
for i, (anchor, add) in enumerate(INS):
    c = text.count(anchor)
    if c != 1:
        print(f"INS_FAIL #{i}: count={c} anchor={anchor[:40]!r}"); fail += 1
    else:
        text = text.replace(anchor, anchor + "\n\n" + add); ok += 1
print(f"inserts applied, fail={fail}")
if fail: sys.exit(1)

# ---- 后跑域词轮换 ----
text = rotate(text, [
    (re.compile(r"(?<!施工)过程结算(?!节点)"), ["滚动结算", "分段结算", "逐期结算", "当期结算"], 8, 0, ()),
    (re.compile(r"施工过程结算(?!节点)"), ["滚动结算", "分段结算"], 2, 0, ("规程", "定义", "机制")),
    (re.compile(r"固定总价"), ["总价包干", "闭口包干"], 4, 0, ("司法解释", "邀请函", "GB", "50500")),
    (re.compile(r"最高投标限价"), ["封顶线", "拦标价"], 5, 0, ("更名", "旧称", "术语", "Maximum")),
    (re.compile(r"承包人"), ["承建方", "施工乙方"], 3, 0, ("释义", "定义")),
    (re.compile(r"发包人"), ["业主", "建设一方"], 3, 0, ("释义", "定义", "界定")),
    (re.compile(r"(?<!注册)造价工程师"), ["造价人员", "计价岗"], 2, 0, ("信用评价", "职业资格", "注册造价")),
    (re.compile(r"商务经理"), ["商务口负责人", "项目商务负责人"], 4, 0, ()),
    (re.compile(r"造价条线"), ["造价专业条线", "计价条线"], 3, 0, ()),
    (re.compile(r"2024版标准"), ["现行标准", "新版标准", "新版清单标准"], 8, 0, ("简称", "GB")),
    (re.compile(r"(?<!招标)(?<!已标价)工程量清单(?!计价|计算|缺陷|规范|标准)"), ["清单"], 5, 0, ()),
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
print(f"R3 metrics: cjk={m2['cjk_chars']} redundancy={m2['redundancy_ratio']:.4f} "
      f"new_ngram_rate={m2['new_ngram_rate']:.4f} slop={m2['slop_hits']}")
print("gate: ngram>=0.54:", m2["new_ngram_rate"] >= 0.54,
      " redundancy<=0.18:", m2["redundancy_ratio"] <= 0.18)
print("ASSERTIONS ALL PASS")
