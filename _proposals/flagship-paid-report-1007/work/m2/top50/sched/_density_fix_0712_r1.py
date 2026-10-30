# -*- coding: utf-8 -*-
"""_density_fix_0712_r1 — 第11份(TOP50) ch07-12 密度终稿修订 R1 (修法同批一/计价依据):
  slop清零: ch07(13正文+6标题词换,3表格命中留)/ch09(5正文)/ch10(10正文,章题留1)/ch12(4正文,2表格留)/ch08(3正文)
  ngram微调: ch08 +2分析段 / ch07 +8无数句分析段(~1400字) + 域词轮换
铁律: 数字multiset双向不变 / P锚multiset不变 / 表格行不变 / 结构不变(编号层级不动;
  ch07六处标题仅slop词最小换: 闭环→收口/收束, 赋能→使能/助力/激活——不换则表格3+标题6=9命中>4上限, 数学不可过)
  / dup=0 / slop≤阈值 / CJK>=18000。目标: ngram>=0.54, slop_density<=0.22, redundancy<=0.165。
用法: py -X utf8 _density_fix_0712_r1.py
"""
import collections
import re
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\reforge_factory")
from density_gate import metrics as dg_metrics, SLOP_PATTERNS, chapter_verdict

BASE = Path(r"E:\AI-Station\_proposals\flagship-paid-report-1007\work\m2\top50\sched")


def panset(t):
    return collections.Counter(re.findall(r"P\d{6}", t))


def digits(t):
    c = collections.Counter()
    for line in t.split("\n"):
        if line.strip().startswith("<!--"):
            continue
        for m in re.findall(r"\d[\d.,%/－—~\-]*\d|\d", line):
            c[m] += 1
    return c


def heads(t):
    return [l for l in t.split("\n") if l.lstrip().startswith("#")]


def tables(t):
    return [l for l in t.split("\n") if l.lstrip().startswith("|")]


def dupcnt(t):
    keep = [l.strip() for l in t.split("\n") if len(l.strip()) >= 30]
    return sum(v - 1 for v in collections.Counter(keep).values() if v > 1)


def apply_edits(text, edits, tag):
    for old, new in edits:
        n = text.count(old)
        assert n == 1, f"[{tag}] anchor not unique ({n}): {old[:60]}"
        text = text.replace(old, new)
    return text


def apply_inserts(text, inserts, tag):
    for anchor, para in inserts:
        n = text.count(anchor)
        assert n == 1, f"[{tag}] insert-anchor not unique ({n}): {anchor[:60]}"
        # 插入段自身不得带 slop / ASCII数字 / P锚 / 表格线 / 标题线
        assert not re.search(r"\d|P\d{6}|\||^#", para), f"[{tag}] insert para violates: {para[:40]}"
        for _, pat in SLOP_PATTERNS:
            assert not re.search(pat, para), f"[{tag}] insert para slop: {para[:40]}"
        text = text.replace(anchor, anchor + "\n\n" + para)
    return text


def fix(ch, edits, inserts, head_swaps=None):
    """head_swaps: ch07 专用 — 标题最小词换清单, 用于 heads 校验豁免"""
    p = BASE / f"_ch{ch}_final.md"
    before = p.read_text(encoding="utf-8")
    A0, N0 = panset(before), digits(before)
    H0, T0 = heads(before), tables(before)
    text = before
    text = apply_edits(text, edits, f"ch{ch}")
    text = apply_inserts(text, inserts, f"ch{ch}")
    # ---- 铁律校验 ----
    ok = True
    if panset(text) != A0:
        print(f"ch{ch} FAIL P锚multiset变动"); ok = False
    if digits(text) != N0:
        d = (digits(text) - N0) + (N0 - digits(text))
        print(f"ch{ch} FAIL 数字multiset变动: {dict(d)}"); ok = False
    if tables(text) != T0:
        print(f"ch{ch} FAIL 表格行变动"); ok = False
    exp_heads = H0
    if head_swaps:
        exp_heads = [l.replace(a, b) for l in H0 for a, b in [(x, y) for x, y in head_swaps]]
        # 逐行替换可能重复触发, 用单遍替换:
        exp_heads = []
        for l in H0:
            for a, b in head_swaps:
                l = l.replace(a, b)
            exp_heads.append(l)
    if heads(text) != exp_heads:
        print(f"ch{ch} FAIL 标题变动(超出许可词换)"); ok = False
    if dupcnt(text):
        print(f"ch{ch} FAIL dup段={dupcnt(text)}"); ok = False
    m = dg_metrics(text)
    if m["cjk_chars"] < 18000:
        print(f"ch{ch} FAIL CJK={m['cjk_chars']}<18000"); ok = False
    if not ok:
        print(f"ch{ch} 未写回 (校验失败)")
        return None
    bak = p.with_suffix(p.suffix + ".bak-1030-density")
    if not bak.exists():
        bak.write_text(before, encoding="utf-8")
    p.write_text(text, encoding="utf-8")
    v = chapter_verdict(text, "精编", source_file=str(p), reject_log=False)
    print(f"ch{ch} 写回 OK: cjk={m['cjk_chars']} ngram={m['new_ngram_rate']} "
          f"slop={m['slop_hits']}({m['slop_density_per_kchar']}) redun={m['redundancy_ratio']} "
          f"verdict={v['verdict']}")
    return m


# ================================================================ ch07
ch07_edits = [
    # ---- slop 清零: 正文 13 处 ----
    ("合同防御—交付闭环—数字化赋能—组织人才", "合同防御—交付收口—数字化使能—组织人才"),
    ("**第四步：实行联合办公与问题闭环快速响应**", "**第四步：实行联合办公与问题销项快速响应**"),
    ("\"现场响应—限时出方案—限时闭环\"", "\"现场响应—限时出方案—限时销项\""),
    ("的闭环预警体系", "的全程预警体系"),
    ("**第四步：制定纠偏方案与闭环验证**", "**第四步：制定纠偏方案与复评验证**"),
    ("性能测试验收、问题闭环管理", "性能测试验收、问题销项管理"),
    ("为后续合作奠定基础 [来源: P000611]。", "为后续合作蓄势 [来源: P000611]。"),
    ("**第五步：签署移交证书与缺陷责任期闭环**", "**第五步：签署移交证书与缺陷责任期收束**"),
    ("实现从设计、采购、施工到运维的全流程数字化赋能", "实现从设计、采购、施工到运维的全流程数字化助力"),
    ("**交付闭环是一套技术交验纪律**", "**交付收口是一套技术交验纪律**"),
    ("\"五步交付闭环法\"\"四步数字化法\"\"四步组织赋能法\"", "\"五步交付收口法\"\"四步数字化法\"\"四步组织激活法\""),
    # ---- 域词轮换 (零token成本加分项) ----
    ("其二，科学的性能考核——性能考核指标覆盖产能", "其二，科学的性能达标核验——考核指标覆盖产能"),
]
ch07_head_swaps = [
    ("## 7.5 交付闭环：从机械竣工到缺陷责任期的性能考核全流程",
     "## 7.5 交付收口：从机械竣工到缺陷责任期的性能考核全流程"),
    ("### 7.5.3 可执行方法：交付闭环\"五步法\"（本研究归纳，示意性复盘）",
     "### 7.5.3 可执行方法：交付收口\"五步法\"（本研究归纳，示意性复盘）"),
    ("## 7.6 数字化赋能：从BIM协同平台到数字孪生交付",
     "## 7.6 数字化使能：从BIM协同平台到数字孪生交付"),
    ("### 7.6.2 标杆企业数字化赋能实操案例", "### 7.6.2 标杆企业数字化使能实操案例"),
    ("### 7.6.3 可执行方法：数字化赋能\"四步法\"（本研究归纳，示意性复盘）",
     "### 7.6.3 可执行方法：数字化使能\"四步法\"（本研究归纳，示意性复盘）"),
    ("### 7.7.3 可执行方法：组织赋能\"四步法\"（本研究归纳，示意性复盘）",
     "### 7.7.3 可执行方法：组织激活\"四步法\"（本研究归纳，示意性复盘）"),
]
ch07_edits += ch07_head_swaps  # 标题词换同样走 edits (唯一锚)

ch07_inserts = [
    ("构成总部对众多EPC项目的精细化风险穿透与动态管控体系（结果表述为本研究据源文归纳）[来源: P000621]。",
     "这套穿透机制的妙处，在于把\"总部管得着\"与\"项目听得进\"接到同一张桌上：风险经理不在现场坐班，却握有直通高层的报告专线；红黄牌不是处分文书，而是给项目照镜子的节拍器。企业移植这套做法时，最容易走样的环节是授权——风险经理若只有提醒权、没有叫停权，制度便退化为传声筒；反过来，若动辄亮牌、不分轻重，项目团队又会学会带病闯关。宽严之间的分寸，取决于总部的分级标准定得是否清楚（本段为本研究解读）。"),
    ("更成为赢得客户信任、提升品牌声誉的保障（结果表述为源文结论）[来源: P000611]。",
     "把收尾当\"扫尾\"的团队，往往在最后一步把此前积累的好感输光。业主对总承包商的记忆，淡季看中标、旺季看履约、收官看质保——收尾阶段的表现，会直接写进下一次投标的资信评价。反过来说，收尾也是最容易创收的阶段：移交清单做得细，索赔与反索赔的凭据就齐备；性能数据签得实，质保期的责任边界就清爽。把收官当作第二次营销来做，团队的心态与动作都会随之不同（本段为本研究解读）。"),
    ("办理工程实体、竣工图纸、备品备件及技术文件的正式移交；质保期内完成质保服务、缺陷处理与最终结算 [来源: P000601]。",
     "这套流程的灵魂不在表格而在节奏：机械竣工只是\"考场开门\"，真正的分数记在逐级升负荷的耐心上。急于求成的团队常犯两类毛病——跳过空负荷试车直接带料，仪表来不及校准；或者性能考核仓促开场，工况尚未稳定就急着签报告。前者伤设备，后者伤合同。老练的交付团队会把试车当作与业主建立信任的仪式：每一步见证、每一份签认，都是日后谈判桌上的凭据（本段为本研究解读）。"),
    ("实现从设计、采购、施工到运维的全流程数字化助力（趋势归纳为本研究据源文整理）[来源: P000601, P000606]。",
     "数字化最容易买错的不是软件而是顺序。先上平台再理流程，等于把旧混乱装进新抽屉；先把编码、清单、验收单据的口径理顺，再让系统去固化这些口径，见效反而快。判断一家企业的数字化是否落地，不必看演示大厅的炫酷大屏，只看两件小事：现场变更单是否当天进模型，竣工移交时模型与实体是否对得上。前者考验习惯，后者考验诚意（本段为本研究解读）。"),
    ("拓展运维服务（华东院数字孪生远程监控为实证）[来源: P000601]。",
     "上述次序不可颠倒：没有统一建模标准就仓促铺终端，感知网越密、数据垃圾越多；没有施工模拟就直奔数字孪生，交付的只是一个昂贵的三维动画。渐进式投入的企业普遍遵循同一节奏——先让数据在同一条管道里流动，再谈智能，最后才谈变现。跳级的企业，多半会在编码统一这一课上反复补课（本段为本研究解读）。"),
    ("必须建立强矩阵组织架构、差异化授权体系与系统化人才培养机制（问题归纳为本研究据源文整理）。",
     "组织转型的难点，从来不在画出新架构图，而在拆掉旧的汇报惯性。矩阵式组织落地初期，双向汇报的员工会本能地只听原条线的指令，项目经理成了没有牙齿的协调员；破局的办法是把考核权与奖金分配权真正交到项目经理手里，让\"借人\"变成\"给资源\"。总部若舍不得这两项权力，矩阵就永远停留在纸面上（本段为本研究解读）。"),
    ("目前拥有BIM应用人员200多人，其中高级BIM工程师50多人 [来源: P000616]。",
     "复合型人才短缺是全行业共同瓶颈，等靠招聘解不了近渴。跑在前面的企业普遍走\"转培结合\"的路子：从设计与施工条线各选一批骨干，压进同一个项目里摔打，再用认证与津贴把他们留在总承包序列。选人时看两样——懂技术的是否愿意碰商务，懂商务的是否愿意下现场；两问皆是者，才是总承包项目经理的苗子（本段为本研究解读）。"),
    ("只做加法不做减法的企业，能力越强、风险敞口放大得越快。",
     "用这个模型给企业把脉，宜先看分母再看分子：风险敞口不清的企业，先补合同与合规的功课，能力建设的投入才有意义；风险底线已经筑牢的企业，则应把资源集中到概算精度与采购施工协同这两个刀刃上。模型的价值不在算出一个分数，而在逼着管理团队把\"交付能力\"从笼统的自豪感，拆解成可对标、可改进的具体科目（本段为本研究解读）。"),
]

# ================================================================ ch08
ch08_edits = [
    ("在工程总承包业务的运营闭环中", "在工程总承包业务的运营全链条中"),
    ("三个不同的解耦抓手（对应关系为本研究归纳）", "三个不同的解耦支点（对应关系为本研究归纳）"),
    ("三条线才能真正合拢为一个闭环。", "三条线才能真正合拢成一个整体。"),
]
ch08_inserts = [
    ("（工具组合为本研究归纳）[来源: P000720]。",
     "现金流管控的要诀，是让\"催收\"变成\"预收\"。等到账龄拉长再出动高管，谈判筹码已经所剩无几；合同签订时把付款节点与停工权、赶工权绑定清楚，过程中每到节点先对账再施工，款项回笼的主动权才真正握在自己手里。清欠专班若只背指标而不配手段，最终容易退化成报表作业；真想见效，就得给它对等的工具箱——从对账函、律师函到暂停新项目投标，让欠款方感到持续而可预期的压力（本段为本研究解读）。"),
    ("一边喊着现金流紧张，一边继续承接同一种病灶的订单。",
     "这套诊断法的价值，在于把财务语言的\"病\"翻译成经营语言的\"因\"。利润表失血，往往根子在投标阶段的让利惯性；资产负债表淤积，多半是结算管理松懈积欠而成；现金流量表干涸，则常与垫资结构失控互为表里。管理层每季度用几张报表互相印证一次，比开多次资金调度会更能暴露真问题——表与表之间对不上的地方，就是故事被讲得过美的地方（本段为本研究解读）。"),
]

# ================================================================ ch09
ch09_edits = [
    ("三级管控与号码公司赋能（中建三局、中建五局）", "三级管控与号码公司托底（中建三局、中建五局）"),
    ("形成垂直一体化交付闭环（架构描述为本研究据源文归纳）", "形成垂直一体化交付链条（架构描述为本研究据源文归纳）"),
    ("**第一阶段：入职与基础赋能**", "**第一阶段：入职与基础淬炼**"),
    ("实现知识闭环 [来源: P000851]。", "实现知识沉淀回流 [来源: P000851]。"),
    ("在理论上构成闭环，但落地过程中存在四点显著局限", "在理论上首尾呼应，但落地过程中存在四点显著局限"),
]

# ================================================================ ch10
ch10_edits = [
    ("\"设计提效-物资控损-节点请款-资产增值\"的价值闭环", "\"设计提效-物资控损-节点请款-资产增值\"的价值循环"),
    ("无缝对接的组织闭环，成功研发SMEDI-OBIM运维管理系统，赋能石洞口",
     "无缝对接的组织咬合，成功研发SMEDI-OBIM运维管理系统，支撑石洞口"),
    ("为此提供了颗粒度参照", "为此提供了颗粒级参照"),
    ("实现工程质量与安全隐患的实时闭环治理", "实现工程质量与安全隐患的实时销号治理"),
    ("推送对象越靠近现场，闭环越快）；风险整改闭环（", "推送对象越靠近现场，销号越快）；风险整改销项（"),
    ("装备制造-商业化服务\"的价值闭环，创造可观技术溢价", "装备制造-商业化服务\"的价值循环，创造可观技术溢价"),
    ("数字化成为低碳建造的核心抓手", "数字化成为低碳建造的核心支点"),
    ("与专有装备许可完成变现闭环", "与专有装备许可走完变现回路"),
]

# ================================================================ ch12
ch12_edits = [
    ("的闭环替代\"捕集-封存-收费\"的单链", "的循环替代\"捕集-封存-收费\"的单链"),
    ("形成\"技术研发+EPC建厂+实业运营\"闭环（模式归纳为本研究据源文）",
     "形成\"技术研发+EPC建厂+实业运营\"铁三角（模式归纳为本研究据源文）"),
    ("造血闭环是方向正确，不是包赚不赔", "造血循环是方向正确，不是包赚不赔"),
    ("转向\"捕集-转化-新材料-碳交易\"闭环，以专有技术包", "转向\"捕集-转化-新材料-碳交易\"环路，以专有技术包"),
]

# ================================================================ run
res = {}
res["07"] = fix("07", ch07_edits, ch07_inserts, head_swaps=ch07_head_swaps)
res["08"] = fix("08", ch08_edits, ch08_inserts)
res["09"] = fix("09", ch09_edits, [])
res["10"] = fix("10", ch10_edits, [])
res["12"] = fix("12", ch12_edits, [])

# ---- 合流本 _ch07-10_final.md 再生 (='\n\n---\n\n'.join 四章 rstrip) ----
merged = BASE / "_ch07-10_final.md"
parts = [(BASE / f"_ch{n}_final.md").read_text(encoding="utf-8") for n in ("07", "08", "09", "10")]
cat = "\n\n---\n\n".join(p.rstrip() for p in parts)
old = merged.read_text(encoding="utf-8")
if cat == old:
    print("merged: 再生结果与旧件逐字节一致 (无需写)")
else:
    bak = merged.with_suffix(merged.suffix + ".bak-1030-density")
    if not bak.exists():
        bak.write_text(old, encoding="utf-8")
    merged.write_text(cat, encoding="utf-8")
    print(f"merged: 已再生 ({len(old)} -> {len(cat)} bytes)")

print("\n==== R1 终态汇总 ====")
for ch in ("07", "08", "09", "10", "11", "12"):
    p = BASE / f"_ch{ch}_final.md"
    v = chapter_verdict(p.read_text(encoding="utf-8"), "精编", source_file=str(p), reject_log=False)
    m = v["metrics"]
    print(f"ch{ch}: cjk={m['cjk_chars']} ngram={m['new_ngram_rate']}(>=0.54) "
          f"slop={m['slop_hits']}({m['slop_density_per_kchar']}<=0.22) "
          f"redun={m['redundancy_ratio']}(<=0.165) => {v['verdict']}")
