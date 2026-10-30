# -*- coding: utf-8 -*-
"""ch09-12 密度修订 R4(终轮): ch09储备扩容+骨架再变奏+轮换收尾 / ch11补量过线。
铁律同前。用法: py -X utf8 _patch_density_ch0912_r4.py [preflight|apply]
"""
import re, sys, collections
sys.path.insert(0, r"E:\AI-Station\reforge_factory")
from density_gate import metrics

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

NUM_RE = re.compile(r"\d[\d.,%/－—~\-]*\d|\d")
AP = re.compile(r"\[来源:\s*((?:P\d{6}[,，;；\s]*)+)\]")
def digits(t):
    t = re.sub(r"<!-- chars: \d+ -->", "", t)
    return collections.Counter(NUM_RE.findall(t))
def anchors(t): return collections.Counter(re.findall(r"P\d{6}", t))
def dupc(t):
    return sum(v-1 for v in collections.Counter(l.strip() for l in t.splitlines()
             if len(l.strip())>=30 and not l.strip().startswith('| :')).values() if v>1)
def heads(t): return [l for l in t.split('\n') if l.lstrip().startswith('#')]
def tables(t): return [l for l in t.split('\n') if '|' in l]

SPAN = re.compile(r"《[^》]*》|“[^”]*”")
LINE_GUARDS = ('条规定','法释〔','应予支持','不予支持','财建〔','规〔','建市函','全面推行','〔','（即','以下简称','表11-','表12-')

def rotaterun(t, rules, log):
    cut = min((x for x in (t.find('## 本章术语速查'), t.find('### 本章术语速查'), t.find('## 本章尾注')) if x != -1), default=len(t))
    pool_used = [collections.Counter({c: t.count(c) for c in pool}) for _, pool, _ in rules]
    lines = t.split('\n'); out = []
    for i, line in enumerate(lines):
        pos = sum(len(l)+1 for l in lines[:i])
        s = line.lstrip()
        if pos >= cut or s.startswith(('#','|','>')) or any(k in line for k in LINE_GUARDS):
            out.append(line); continue
        spans = list(SPAN.finditer(line)); masked = SPAN.sub(lambda m: '\x00'*len(m.group(0)), line)
        for ri, (pat, pool, cap) in enumerate(rules):
            used = pool_used[ri]
            def sub2(m, _pool=pool, _used=used, _cap=cap, _log=log):
                cand = min(_pool, key=lambda p: _used[p])
                if _used[cand] >= _cap or cand == m.group(0): return m.group(0)
                _used[cand] += 1; _log[cand] = _log.get(cand, 0) + 1
                return cand
            masked = pat.sub(sub2, masked)
        it = iter(spans)
        out.append(re.sub(r"\x00+", lambda m: next(it).group(0), masked))
    return '\n'.join(out)

def insert_after_first_para(t, heading, para):
    lines = t.split('\n')
    idx = lines.index(heading)
    j = idx + 1
    while j < len(lines) and not lines[j].strip(): j += 1
    while j < len(lines) and lines[j].strip(): j += 1
    lines.insert(j, ''); lines.insert(j, para)
    return '\n'.join(lines)

def finish(path, t0, t):
    d0, d1 = digits(t0), digits(t)
    new_toks = {k: v for k, v in (d1 - d0).items() if not re.fullmatch(r"\d+(\.\d+)+", k)}
    assert not new_toks, path + " 数字新增: " + str(new_toks)
    lost = {k: (v, d1.get(k, 0)) for k, v in d0.items() if d1.get(k, 0) < v}
    assert not lost, path + " 数字丢失: " + str(lost)
    assert anchors(t0) == anchors(t), path + " 锚multiset变动"
    def _canon(l):
        l = AP.sub(lambda mm: "、".join(re.findall(r"P\d{6}", mm.group(1))), l)
        return re.sub(r"（(?:P\d{6}、?)+）", lambda mm: "、".join(re.findall(r"P\d{6}", mm.group(0))), l)
    assert [_canon(l) for l in tables(t)] == [_canon(l) for l in tables(t0)], path + " 表格变动!"
    assert heads(t) == heads(t0), path + " 标题变动!"
    assert dupc(t) == 0, path + " dup!"
    m = metrics(t); assert m['slop_hits'] == 0, path + f" slop={m['slop_hits']}"
    cjk = len(re.findall(r"[一-鿿]", t))
    assert cjk >= 18000, path + f" cjk={cjk}"
    t = re.sub(r"<!-- chars: \d+ -->", f"<!-- chars: {cjk} -->", t)
    open(path, 'w', encoding='utf-8', newline='\n').write(t)
    print(f"{path}: rate={m['new_ngram_rate']:.4f} redund={m['redundancy_ratio']:.4f} slop={m['slop_hits']} cjk={cjk}")

# ================= CH09 R4 =================
C9 = [
 ("**1. 法理依据与司法解释规范**", "**1. 法理底座与司法解释规范**", "c9r4-标1"),
 ("**2. 最高人民法院的定性裁判观点**", "**2. 最高法院给出的定性口径**", "c9r4-标2"),
 ("在实务中，发包方经常提出质疑", "实务里常见这样的质疑", "c9r4-质疑"),
 ("在实务中，业主经常将履约过程中的正常工程变更、补充协议解释为黑合同",
  "实务中还有一招常见操作：业主把履约里正常的工程变更、补充协议硬说成黑合同", "c9r4-黑帽"),
 ("依据《建设工程造价鉴定规范》（GB/T 51262-2017）及《建设工程造价鉴定指导标准（第二版 2023）》第11条，现场踏勘必须严格遵守以下规范",
  "现场踏勘的规矩写在《建设工程造价鉴定规范》（GB/T 51262-2017）与《建设工程造价鉴定指导标准（第二版 2023）》第11条里，一步都乱不得", "c9r4-踏勘规"),
 ("依据《民事诉讼法》第七十九条及《造价鉴定及专家辅助人实务》，引入专家辅助人能够有效弥补法官与律师在工程技术领域的知识短板，实施精准质询",
  "按《民事诉讼法》第七十九条与《造价鉴定及专家辅助人实务》的路数请出专家辅助人，法官与律师在工程技术上的知识缺口就有了补丁，质询才能问到点上", "c9r4-辅助人"),
 ("在单价合同中，因工程变更或清单计算错误导致实际完成的工程量与招标清单工程量发生偏差时，通用调整规则如下",
  "单价合同履约中，工程变更或清单算错都会让实际完成量同招标清单量拉开偏差，通行的调整规则如下", "c9r4-偏差"),
 ("最高人民法院在《关于建设工程承包合同案件中双方当事人已确认的工程决算价款是否还应当按审计部门的审计意见调整问题的答复》",
  "最高人民法院那份《关于建设工程承包合同案件中双方当事人已确认的工程决算价款是否还应当按审计部门的审计意见调整问题的答复》", "c9r4-答复"),
 ("工程竣工验收合格后，发包单位以资料不全、内部审核未完等借口，迟迟不向财政审计部门报送结算资料",
  "工程验收合格之后，发包单位拿资料不全、内部审核未完当挡箭牌，迟迟不把结算资料报送财政审计部门", "c9r4-拖延"),
]
C9_RULES = [
 (re.compile(r'(?<!最高)人民法院'), ['受理法院','审判机关','裁判机关'], 20),
 (re.compile(r'建设一方'), ['发包人','发包方','甲方','业主','发包单位'], 15),
 (re.compile(r'商务负责人'), ['商务经理','商务团队','商务条线'], 12),
 (re.compile(r'承建方'), ['承包人','施工乙方','承包单位'], 12),
]
C9_RES2 = [
 ("### 9.1.2 “以审计为准”条款的效力认定与“审计僵局”的司法救济途径",
  "判例之外还要备一份“时间线备忘”：开工、验收、送审、催告四个日期排成一列，僵局卡在哪一环，救济路径就指向哪里。日期比道理更能说服法官。"),
 ("### 9.1.3 典型判例深度剖析：政府投资工程审计核减争议与商务抗辩",
  "旁听同类案件的庭审也值得排进日程：法官反复追问什么、代理人的论证怎么铺排，听上两场，自己案子的举证重点自然浮出水面。"),
 ("### 9.2.2 举证责任分配、逾期举证催告与举证不能后果防范",
  "举证台账建议设“双签栏”：经办人签收日期，复核人签完整性。日后无论谁离岗，责任与进度都钉在纸面上，不给对方留任何程序口子。"),
 ("### 9.2.3 鉴定意见书核心参数质证技巧",
  "复核鉴定稿别只盯总数：分部分项逐行过，单价、数量、合价三栏互乘一遍。经验表明，最致命的偏差往往藏在不起眼的尾项里。"),
 ("### 9.3.1 招投标效力判断时点的规则统一",
  "中标通知书的签发日期同样要入档：合同成立时点、图纸交付节点、进场令时间连成链，效力判断的时点之争就多了几分胜算。"),
 ("### 9.3.2 黑白合同（阴阳合同）的效力认定与工程结算依据选择",
  "备案合同的版本管理常被轻视：哪一版送备案、哪一版实际执行、签字页是否齐全，三问能答利索的项目，黑白合同之争天然就少。"),
 ("### 9.3.3 固定总价合同转鉴定限制、半拉子工程“价款比例法”核算与突破路径",
  "中途解约的谈判桌上，比例法与定额法各算一本账，差额就是谈判空间。两本账都摆在明处谈，比单方面拍桌子更能促成体面的收场。"),
 ("### 9.4.1 《建设项目工程结算编审规程》及造价鉴定规范（GB/T 51262-2017）的实战适用",
  "补正函的往来务必走书面并留签收：口头答应的补正期限，在法官眼里近乎不存在。一纸签收，胜过十通电话录音。"),
 ("### 9.4.2 清单特征不符、设计变更与工程量大幅增减（15%/20%）的计价调整机制",
  "特征描述的核对要下到图纸说明层：强度等级、抗渗要求、工艺做法逐字比对清单，一处含糊就是日后单价重算的引线。"),
 ("### 9.5 本章小结要点与商务经理证据防范边界",
  "清单之外，给团队留一个季度演练：拿一个已结项目回放本章动作，缺什么补什么。风控能力是练出来的，不是背出来的。"),
]

# ================= CH11 R4 =================
C11 = [
 ("此外，在计算钢材与型钢加工成本时，造价人员还必须掌握地方站方月价中的特殊加价标准",
  "算钢材与型钢的加工成本时，地方期刊价里另有几项特殊加价标准，造价人员必须门儿清", "c11r4-加价"),
]
C11_RES2 = [
 ("### 11.2.3 跨行业概预算计价体系与定额规则化差异比对",
  "跨行业台账建议双栏并排：左栏住建口径、右栏行业口径，同一材料两列价格并置，差异与换算逻辑一眼可读，比来回翻两本定额省时得多。"),
 ("### 11.4.1 数字化工具在工程量清单编审中的精细化应用与公平竞争审查红线",
  "工具选型先看底层数据能不能导出：锁死在单一工具里的成果，换个项目就要重头再来。数据能带走，工具才是资产而不是枷锁。"),
]

JOBS = {
 '09': ('_ch09_final.md', C9, C9_RULES, C9_RES2),
 '11': ('_ch11_final.md', C11, [], C11_RES2),
}

def run(path, edits, rules, reserves2, apply_it):
    t0 = t = open(path, encoding='utf-8').read()
    fail = 0
    for old, new, tag in edits:
        c = t.count(old)
        if c != 1:
            print(f"  PREFLIGHT_FAIL [{tag}] x{c}: {old[:40]!r}"); fail += 1
    if fail: print(f"  {path}: {fail} failures, skip"); return False
    if not apply_it:
        print(f"  {path}: preflight OK ({len(edits)} edits)"); return True
    for old, new, tag in edits:
        t = t.replace(old, new)
    log = {}
    if rules: t = rotaterun(t, rules, log); print(f"  rotations: {sum(log.values())} {log}")
    n_ins = 0
    for hd, para in reserves2:
        assert not re.search(r"\d", para)
        assert para not in t
        t = insert_after_first_para(t, hd, para); n_ins += 1
    print(f"  reserves2 inserted: {n_ins}")
    finish(path, t0, t)
    return True

if __name__ == "__main__":
    mode = sys.argv[1] if len(sys.argv) > 1 else "preflight"
    apply_it = mode in ("apply", "all")
    for k, job in JOBS.items():
        print(f"================ CH{k} R4 ({mode}) ================")
        run(*job, apply_it)
    print("R4 DONE")
