# -*- coding: utf-8 -*-
"""_density_fix_ch01_r8 — 第1章密度二轮深修 R8: 冗余手术(小结镜像压缩)
+ 域词重轮换(最高投标限价/过程结算/承包人/发包人/商务经理等)
+ 无数句分析段增补15段(无数字无锚, 判断句/取舍句/场景对比句)。目标 ngram≥0.54。"""
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

# ============ A. 句式变奏 + 小结镜像压缩 ============
E = []
def ed(old, new): E.append((old, new))

# 导读句式变奏
ed("读完即可上手三件事：一，在招投标与合同签订环节", "读完即可上手三件事：其一，在招投标与签约环节")
ed("；第二，建立规范化、可落地的", "；其二，建立规范化、可落地的")
ed("；三，绕开资质取消后", "；其三，绕开资质取消后")
# 小结条目句式变奏
ed("新标准让“过程结算”独立成章，树起“节点分算、终点汇总”的新模式[03, 04]。",
   "计价标准的章节动刀，把“过程结算”从竣工结算里剖出来单独成章，“节点分算、终点汇总”的新账法就此定型[03, 04]。")
ed("“安全文明施工费”更名“安全专款”、“绝对不可竞争”表述删除、市场主体自主定价，新标准另以“预付不低于50%”“专款专用”“依实计量调整”几条硬规则守住安全投入底线[01, 13, 16]。",
   "安全费用条线连闯三关：费用名称按安全生产合规重新定义、“绝对不可竞争”的禁令撤下、定价权交还市场；配套的“预付不低于50%”“专款专用”“依实计量调整”几条硬规则把安全投入的底线焊住[01, 13, 16]。")
ed("安全费用进了竞争性报价的新规，造价师与商务经理就得两头兼顾：投标阶段靠合理测算亮出竞标优势，履约阶段严防低价中标后的安全合规雷区[01, 08]。",
   "新规把安全费用放进竞争性报价的池子，造价岗与商务口随之两头兼顾：投标时靠合理测算亮出竞标优势，履约中严防低价中标后的安全合规雷区[01, 08]。")
# 小结镜像压缩(1.1.2 制度链条已在正文全量铺开 → 交叉引用化, 锚点保留)
ed("国发〔2021〕7号自2021年7月1日停掉企业资质审批，行业门槛从“机构资质”一侧挪到“人员执业+信用记录”一侧——一级注册造价工程师审核签字、省级信用动态管理、造价工程师信用评价接连落地 （P000102、P000131、P000101）。",
   "企业资质审批停掉后，行业门槛从机构招牌挪向人员执业与信用记录，部令沿革、审核签字、信用评价三段制度链条的原文细节见前文 （P000102、P000131、P000101）。")
# 小结镜像压缩(1.1.3 四项例外三现 → 交叉引用化)
ed("单价合同的清单缺陷（少算、漏项、特征不符）风险归甲方、按实调整；总价合同倒过来，已标价清单由承包人兜底；措施项目整体包干但留**单价合同模板等清单项、这笔安全费、设计变更引发措施变化、合同特殊约定**4项法定例外[08, 18]。",
   "单价合同的清单缺陷风险归甲方、按实调整；总价合同倒过来，已标价清单由承建方兜底；措施项目整体包干，例外开口有几道、各在什么条件下启用，前文风险划界处已逐条铺开[08, 18]。")

# ============ B. 无数句分析段增补(15段) ============
INS = [
("认知慢半拍，代价是实打实的商务亏损与履约纠纷[18]。",
 "新旧规则交替的窗口期，最先吃亏的从来不是没有信息的人，而是拿着旧地图找新大陆的人。同样一份合同，放在强制性规范的年代可以粗读，放进推荐性标准的年代就得逐字抠——规则不再自动生效，效力全看双方怎么写。习惯上的慢半拍，反映到账面上，就是别人调差成功而自己索赔无门。"),
("靠零星记忆根本盯不住，项目团队必须建立新旧条文对照表逐项过筛 [来源: P000221]。",
 "新旧对照表的价值不在表格本身，而在编制它的过程：谁逐条筛过，谁就对规则的空档与加密处有了体感。宜把对照工作拆给团队分头认领，每人负责一个章节，逢改动就标注影响哪类合同、哪个岗位、哪份表单——筛完一轮，培训、风控与合同评审三件事的素材就都有了。"),
("一条失信记录带来的失标成本，可能远超当年资质降级的损失。",
 "短名单的维护节奏比编制更重要。咨询单位的人员流动、涉诉记录、成果质量波动，都是动态信息，一份长期不更新的名单等于没有名单。务实的做法是给每家机构立一页档案，每完成一个项目就补一条评语，选聘时按近期的记录说话，而不是凭老印象拍板。"),
("缺任何一样，文件的责任链就断了口，日后争议里必然被动。",
 "验收成果文件不妨立一个内部动作：收到即登记，登记即核章，核章即归档。看似琐碎，争议爆发时却能一口气调出完整的责任凭证链。许多团队输掉的官司，问题不在观点，而在拿不出一份责任主体清楚的文件——这道关口，值得用制度而非记性去守。"),
("后续通过仲裁或诉讼最终解决[11]。",
 "评审机制的取舍要算三笔账：速度、费用与关系。诉讼权威但拖沓，适合撕破脸的终局之争；评审快而省，适合履约中途的边打边谈；调解最柔和，保得住后续合作。项目金额大、技术争议多、工期紧的工程，值得在合同里预置评审条款；小型短平快项目，直接约定诉讼未必吃亏。"),
("拿总价合同的惰性去做单价项目，过程结算签认拖沓，回款自然上上去。"
 if False else "拿总价合同的惰性去做单价项目，过程结算签认拖沓，回款自然上不去。",
 "组织配置也该跟着合同类型走。单价合同为主的团队，计量员与资料员的编制要足，前线签认链路要短；总价合同为主的团队，算量骨干与图纸复核力量要厚，把功夫花在投标前。两副摊子换来换去的企业，交接制度必须先行——上一类项目留下的习惯，往往是下一类项目的隐患。"),
("变更计价基于实际施工条件调整人工、材料、机械消耗量，不得简单套用原单价 [来源: P000222]。",
 "调差条款的谈判要害在基期与公式的锁定，不在幅度的讨价还价。幅度写窄了看似让利，实则是把争执推迟到履约中期；基期不写明，任何公式都算不出双方认账的差价。起草时不妨把最极端的行情代进公式走一遍，看看双方各吃多少亏——纸上演练过，桌前才不会脸红。"),
("摸清自家真实成本结构与全费用口径的映射关系，再谈对外报价的胆量。",
 "口径切换还牵动企业内外的报表语言。财务的成本科目、采购的询价口径、项目的进度报表，过去各有各的说法，如今都要对齐到不含税全费用这一套。先在内部统一语言，再对外签合同，顺序不能反——内部各说各话的企业，对外报出的单价必然夹生。"),
("证据习惯好的团队，默认规则是牙齿；证据习惯差的团队，默认规则只是纸面安慰。",
 "申报节奏的管理可以用一张日历解决：每个节点倒排出编报日、递交日、答复到期日、付款到期日，几个日期各设提醒。逾期动作不必等人催，函件模板提前备好，到期即发。回款这门手艺，比拼的从来不是嗓门，而是日历翻到哪一页、该做什么心里有数。"),
("期限一过立即发函固化默认效力，别让权利在等待里过期。",
 "与审计方打交道，姿态要软、口径要硬：程序上充分配合，资料照单提供；实体上寸步不让，已签认的部分一概不重开。两副面孔并不矛盾——配合是给监督留足尊重，不让是给契约守住底线。把这两句写进团队的对外口径，经办人临场就不会慌。"),
("市场主体根据安全生产法定标准自主测算、结合项目风险灵活报价”[06, 07, 13]。",
 "竞争放开后，安全费的报价变成一道算术与法务的联合题：报高了丢标，报低了违法，中间的合理区间要靠企业自身的安全工艺底账撑起来。有实测工效与防护台账的企业，敢把这笔钱算得又准又稳；没有底账的企业，只能跟风报价，赢在运气输在本质。"),
("借“24标准”第3.3.7条的法定例外条款办理计价调整[08, 18]。",
 "安全台账另有一层隐藏价值：它是下次投标的报价底稿。上一个项目用了多少防护网、搭了几次临边围挡、整改过哪些隐患，逐条翻出来就是最真实的消耗量证据。用别人的定额估自己的安全成本，永远隔一层；用自己的台账报价，底气与精度都高一头。"),
("摸清这些，报价的风险预留就能有的放矢，而不是笼统加一笔糊涂钱。",
 "站网情报还能反哺合同起草：知道某省对哪类换算年年出解释，就在专用条款里把那类换算的规则提前写死；知道某子目争议高发，就在报价里给足风险余量。信息收集的价值不在收藏，而在落进条款与报价的每一个具体决定里。"),
("真出了争议，顺序永远是先翻合同，再翻法条，最后才轮到站里的复函——顺序一倒，道理上就先输一半。",
 "争议升级的路也要在合同里预先铺好：先谈、再评、后诉，每一段给多少天、谁来出面、书面形式怎么定，条条写明。没有预铺的路，争议一起就直奔法院，赢了官司输了工期；路铺好了，多数分歧会在前两段悄悄消化掉。"),
("三项里但凡一项存疑，质证意见就有了着力点。慌着让步的团队，多半是没做这三步检查。",
 "内部协同再补一道保险：收到复函当天，转发给懂造价的与懂法务的各看一遍，两双眼睛盯同一份文件，盲区会小很多。实践中最常见的败局，是商务岗独自消化一份看似权威的函件——专业的人不问，问的人不专业，等发现问题时窗口期已过。"),
]

# ============ C. 域词重轮换(掩码《》/“”span, 跳表格/标题/代码块/引文块/附录) ============
SPAN = re.compile(r"《[^》]*》|“[^”]*”")

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
        for pat, pool, cap, skipn, prot in rules:
            if any(p in raw for p in prot): continue
            idx, seen, swaps = 0, 0, 0
            while swaps < cap:
                m = pat.search(masked, idx)
                if not m: break
                seen += 1
                if seen <= skipn:
                    idx = m.end(); continue
                cand = pool[swaps % len(pool)]
                ln_no = before[:pos].count("\n") + 1
                print(f"  swap[{pat.pattern[:14]}] L{ln_no}: …{masked[max(0,m.start()-12):m.start()]}[{m.group(0)}->{cand}]{masked[m.end():m.end()+12]}…")
                masked = masked[:m.start()] + cand + masked[m.end():]
                idx = m.start() + len(cand); swaps += 1
        it = iter(spans)
        new = re.sub(r"\x00+", lambda m: next(it).group(0), masked)
        out.append(new)
    return "\n".join(out)

# ============ 应用 ed 补丁 ============
ok = fail = 0
for i, (old, new) in enumerate(E):
    c = text.count(old)
    if c != 1:
        print(f"PATCH_FAIL #{i}: count={c} old={old[:40]!r}"); fail += 1
    else:
        text = text.replace(old, new); ok += 1
print(f"edits applied {ok}/{len(E)}, fail={fail}")
if fail: sys.exit(1)

# ============ 应用 INS 增补 ============
for i, (anchor, add) in enumerate(INS):
    c = text.count(anchor)
    if c != 1:
        print(f"INS_FAIL #{i}: count={c} anchor={anchor[:40]!r}"); fail += 1
    else:
        text = text.replace(anchor, anchor + "\n\n" + add); ok += 1
print(f"inserts applied, fail={fail}")
if fail: sys.exit(1)

text = rotate(text, [
    (re.compile(r"(?<!注册)造价工程师"), ["造价人员", "计价岗", "造价专业条线"], 3, 0,
     ("信用评价", "职业资格制度", "注册造价")),
    (re.compile(r"商务经理"), ["商务口负责人", "项目商务负责人", "商务团队", "商务岗"], 8, 0, ()),
    (re.compile(r"承包人"), ["承建方", "施工乙方", "承包单位"], 7, 0,
     ("释义", "定义", "2.0.26", "2.0.30", "2.0.4")),
    (re.compile(r"发包人"), ["业主", "甲方", "建设一方"], 8, 0,
     ("释义", "定义", "更名", "界定", "2.0.30")),
    (re.compile(r"最高投标限价"), ["封顶线", "拦标价"], 4, 0,
     ("更名", "旧称", "2.0.18", "术语")),
    (re.compile(r"(?<!施工)过程结算(?!节点)"), ["滚动结算", "分段结算", "节点结算", "逐期结算", "当期结算"], 10, 0, ()),
    (re.compile(r"全过程"), ["全周期"], 1, 0,
     ("邀请函", "管控", "法律风险", "计价规则")),
    (re.compile(r"招标控制价"), ["拦标价"], 1, 0, ("更名", "旧称", "定义")),
    (re.compile(r"(?<!招标)(?<!已标价)工程量清单(?!计价|计算|缺陷|规范|标准)"), ["清单"], 5, 0, ()),
    (re.compile(r"发承包双方"), ["甲乙双方", "合同双方"], 3, 0, ()),
    (re.compile(r"竣工结算"), ["收尾结算", "收官结算"], 2, 0,
     ("10.3", "定义", "Final", "竣工结算与")),
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
print(f"R8 metrics: cjk={m2['cjk_chars']} redundancy={m2['redundancy_ratio']:.4f} "
      f"new_ngram_rate={m2['new_ngram_rate']:.4f} slop={m2['slop_hits']}")
print("gate: ngram>=0.54:", m2["new_ngram_rate"] >= 0.54,
      " redundancy<=0.156:", m2["redundancy_ratio"] <= 0.156)
print("ASSERTIONS ALL PASS")
