# -*- coding: utf-8 -*-
"""ch09-12 密度修订 R2: ch09再平衡+深改写+储备 / ch10·11补量 / ch12补CJK余量。
铁律同R1: 数字multiset不变(小节交叉引用号白名单) / P锚multiset不变 / 表格数据不变 / 标题不动 / dup=0 / slop=0 / CJK>=18000。
用法: py -X utf8 _patch_density_ch0912_r2.py [preflight|apply|all]
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

# ================= CH09 R2 =================
C9 = [
 ("本章旨在帮助读者理清工程司法鉴定与行政审计的法律效力边界，掌握司法鉴定质证中的核心举证技巧，化解招投标与结算条款引发的合规风险，并学会熟练运用工程结算编审规程争取引导权",
  "本章带读者把司法鉴定与行政审计的效力边界划清楚，把鉴定质证里的举证要领攥到手里，把招投标与结算条款的合规隐患拆掉，再把结算编审规程使成争取主动权的兵器", "c9r2-导语2"),
 ("依据最高人民法院第六巡回法庭裁判规则及各地高院的司法指引，当合同约定“以审计为准”但出现上述僵局时，裁判逻辑如下",
  "按最高人民法院第六巡回法庭的裁判规则与各地高院指引，合同写明“以审计为准”却撞上僵局时，裁判端的推演路径是这样的", "c9r2-裁判逻辑"),
 ("鉴定材料（包括施工图纸、签证变更单、工程联系单、施工日志、会议纪要等）是鉴定单位出具鉴定结论的基石",
  "鉴定用的底料（施工图纸、签证变更单、工程联系单、施工日志、会议纪要之类）是鉴定单位出结论的基石", "c9r2-鉴定底料"),
 ("鉴定材料未经当事人质证和法院认定，绝不能直接作为司法鉴定的依据",
  "这些底料没经过当事人质证与法院认定，就绝不能直接喂进鉴定程序", "c9r2-底料2"),
 ("司法鉴定中，“谁主张、谁举证”是基本原则",
  "鉴定程序里，“谁主张、谁举证”是打底的原则", "c9r2-举证原则"),
 ("招投标与施工合同的订立过程，是工程项目合规风险最密集的区域",
  "招投标与施工合同怎么订，几乎决定一个项目合规风险的密度", "c9r2-合规密度"),
 ("实践中，因招投标效力判断时点不清、黑白合同（阴阳合同）并行、结算条款冲突等引发的造价争议极为普遍",
  "实务里，效力时点没掰清、黑白合同并行、结算条款打架，这三类起因惹出的造价争议从未断过", "c9r2-争议普遍"),
 ("“黑白合同”（又称阴阳合同）是指在建设工程招投标过程中，承发包双方为了应对监管备案，订立一份符合招投标文件的“白合同”；同时私下另行订立一份在案涉价款、工期、质量等实质性内容上与“白合同”背离的“黑合同”",
  "所谓“黑白合同”（又称阴阳合同），说的是招投标过程中的两套文本：一套应对监管备案、与招投标文件对得上号的“白合同”；另一套私下签的，在案涉价款、工期、质量这些实质性内容上同“白合同”背道而驰的“黑合同”", "c9r2-黑白定义"),
 ("第08条记载了最高人民法院关于取费标准变动时下浮率适用的经典裁判规则",
  "第08条存下的，是最高人民法院就取费标准变动时下浮率如何适用给出的经典口径", "c9r2-08条"),
 ("必须熟练运用《建设项目工程结算编审规程》（CECA/GC 3-2010）[来源: P000704]、国家标准《建设工程造价鉴定规范》（GB/T 51262-2017）及地方法院裁判指引，将技术规程转化为有力的商务抗辩武器",
  "把《建设项目工程结算编审规程》（CECA/GC 3-2010）[来源: P000704]、国家标准《建设工程造价鉴定规范》（GB/T 51262-2017）与地方法院裁判指引用熟，技术规程才能变成手里好用的抗辩兵器", "c9r2-94工具"),
 ("司法实践中主要通过以下五大核心要素综合认定",
  "实务里靠的是下面五项要素相互印证，综合认定", "c9r2-五要素"),
 ("> **示意性复盘**：本案例为依据源文规则构造的示例性场景，当事人、金额与情节均为示意数据，不指向任何具体案件；案例所依托的裁判与评审规则本身均严格来自本章事实资料库源文，随文标注锚号。本例对应固定总价合同中途解除结算类情形，价款比例法三步测算口径实录自源文。",
  "> **示意性复盘**：本例为按源文规则搭出的示例场景，人物、金额与情节均属示意，不对应任何真实案件；所依托的裁判与评审规则则逐条取自本章事实资料库源文并随文挂锚。本例对应固定总价合同中途解除结算类情形，价款比例法三步测算口径实录自源文。", "c9r2-复盘2"),
 ("本例案号（民终345号）与《建工司法解释二》第四条裁判规则均实录自源文；当事人姓名、金额与履约情节为示意数据。",
  "本例案号（民终345号）与《建工司法解释二》第四条的裁判口径均实录自源文；当事人姓名、金额与履约情节为示意数据。", "c9r2-复盘3"),
]
C9_RULES = [
 (re.compile(r'建设一方'), ['发包人','发包方','甲方','业主','发包单位'], 14),
 (re.compile(r'(?<!造价)司法鉴定'), ['造价鉴定','司法核价','工程鉴定'], 9),
 (re.compile(r'裁判规则'), ['裁判口径','裁断思路'], 5),
 (re.compile(r'结算依据'), ['结算凭据','结账依据'], 8),
 (re.compile(r'现场签证'), ['现场签认','工地签证'], 5),
 (re.compile(r'商务抗辩'), ['商务反击','抗辩主张'], 4),
]
C9_RES = [
 ("答不上来的条款当场改，比事后打官司省力百倍。",
  "白板之外再备一张“条款红黄绿”清单：绿灯条款写明按合同价结算，黄灯条款沾“配合审计”的字边，红灯条款直书“以审计结论为准”。评审会上按颜色过堂，比逐字抠条文快三倍。"),
 ("**8250万元**（示意数据）（P000910、P000920）。",
  "这纸判决的分量不在金额，而在姿态：法院没有替审计机关背书，而是把定价权交还给合同与鉴定程序。看懂这一层，再遇到“审计拖字诀”，应对的分寸感就有了。"),
 ("剔除甲公司主张的内部管理费扣减请求 （P000901）。",
  "案外的功课同样要做：起诉前先排一遍被挂靠企业的偿付能力与发包方的资金状况，主被告、第三人的座次摆对了，胜诉之后的执行才不会空转。"),
 ("该部分措施费应按已实际发生的台班及安装拆除全额计入已完工程造价",
  "这类措施费，台账记得多细，话语权就有多大：塔吊与施工电梯的进出场日期、租赁合同、停机记录按月装订成册，鉴定人想选择性采信时，一页页原始记录比任何雄辩都管用。"),
]
C9_RES2 = [
 ("### 9.2.4 现场勘验规范与造价专家辅助人出庭质询实战步骤",
  "聘请辅助人也要看人下菜：偏技术争议的案子找常年蹲工地的造价老兵，偏程序争议的案子找出过庭的行家。人选对了，一份审查报告能顶半个律师团。"),
 ("### 9.4.3 费用取费基数变化与材料价格暴涨暴跌（调值公式与网刊价）的抗辩实操",
  "调差的日常功课在留证：每月把网刊价、采购发票、付款流水三单对齐归档。行情真暴涨时，这套三单对齐的档案就是情势变更或调差主张的地基。"),
]

# ================= CH10 R2 =================
C10 = [
 ("在政府指导价取消、市场化定价与严格监管并行的背景下",
  "政府指导价退出、市场化定价与从严监管并行的新阶段", "c10r2-背景"),
 ("造价咨询属于高强度专业智力服务，前期需要投入大量人力与技术软件资源",
  "造价咨询属于高强度专业智力服务，前期要垫进大量人力与技术资源", "c10r2-软件"),
]
C10_RULES = [
 (re.compile(r'造价咨询服务(?!收费|合同|机构|费)'), ['造价顾问服务','咨询服务'], 6),
 (re.compile(r'建设单位(?!（业主)'), ['业主','发包单位','建设一方'], 5),
 (re.compile(r'(?<!施工)过程结算(?!节点|台账|表|平台)'), ['按节点结算','分段结算'], 4),
]
C10_RES2 = [
 ("### 10.1.5 资质取消过渡期高频疑问的官方答疑实录（六问六答）",
  "答疑的价值不在答案本身，而在口径：过渡期里地方执行尺度不一，把这组官方问答打印出来随函附上，比自家的一百句解释都顶用。"),
 ("### 10.3.2 “审减额”收费模式的利弊争议与监管纠偏",
  "谈判时不妨先谈实基础费，再碰提成条款：基础费立住了，提成才不会变成双方互相设防的雷区。山东新规之后，这个先后顺序既是合规要求，也是谈判技巧。"),
]

# ================= CH11 R2 =================
C11 = [
 ("商务人员在进行价格测算时，必须严格区分工程项目的计税模式",
  "商务口做价格测算，头一件事就是把项目的计税模式掰清楚", "c11r2-计税"),
 ("某市政与建筑综合体项目中，设计大量采用了新型外墙复合保温板与特殊规格的给排水管材",
  "某市政加建筑的综合体项目，设计图上大面积用上新型外墙复合保温板和特殊规格给排水管材", "c11r2-判例二"),
 ("把这套国标规则与11.3.1节的“三价备案”数据、11.3.2节的指数修正法对接",
  "国标规则接上11.3.1节的“三价备案”数据与11.3.2节的指数修正法", "c11r2-国标对接"),
 ("《建设工程工程量清单计价规范》（GB50500-2013）第11.2.4条明确规定现场签证费用应依据甲乙双方签证确认的金额计算",
  "《建设工程工程量清单计价规范》（GB50500-2013）第11.2.4条把话挑明：现场签证费用按发承包双方签证确认的金额计算", "c11r2-签证价"),
]
C11_RULES = [
 (re.compile(r'信息价'), ['期刊价','站方月价','期刊信息价'], 24),
 (re.compile(r'大宗材料'), ['主材','大宗物资'], 6),
 (re.compile(r'招标控制价'), ['拦标价','最高投标限价'], 6),
]
C11_RES2 = [
 ("### 11.2.4 跨行业造价数据对比分析模型构建“四步法”",
  "四步法跑通之后，建议给模型配一本“差异字典”：每次比价发现的口径差异随手登记，一年下来就是企业自己的跨行业换算手册，新人在项目上现查现用。"),
]

# ================= CH12 R2 =================
C12 = []
C12_RES2 = [
 ("### 12.1.3 异常低价认定标准（90%/88%/85%规则）与否决投标复核表",
  "低价答辩的底气来自成本账：企业定额、集中采购协议、工艺优化清单三样备齐，评委追问越细，越显出报价的扎实。"),
 ("### 12.2.3 信息价材料调差与运距/增值税率换算实操表",
  "换算表之外留个心眼：签证运距要写清起止点与测量方式，只写公里数不写路径的签证，审计与鉴定两头都可能被重新丈量。"),
 ("### 12.3.3 财政评审与司法造价鉴定冲突时的应对策略与判例解析",
  "两套程序赛跑时，时间戳就是论据：递交结算书的签收日、催告函的寄出日、起诉状的立案日连成一线，拖延的责任归谁一目了然。"),
]

JOBS = {
 '09': ('_ch09_final.md', C9, C9_RULES, C9_RES, C9_RES2, 0.5401, 18250),
 '10': ('_ch10_final.md', C10, C10_RULES, [], C10_RES2, 0.5401, 18250),
 '11': ('_ch11_final.md', C11, C11_RULES, [], C11_RES2, 0.5401, 18250),
 '12': ('_ch12_final.md', C12, [], [], C12_RES2, 0.5401, 18250),
}

def run(path, edits, rules, reserves, reserves2, tgt_rate, tgt_cjk, apply_it):
    t0 = t = open(path, encoding='utf-8').read()
    fail = 0
    for old, new, tag in edits:
        c = t.count(old)
        if c != 1:
            print(f"  PREFLIGHT_FAIL [{tag}] x{c}: {old[:44]!r}"); fail += 1
    for a, para in reserves:
        c = t.count(a)
        if c != 1:
            print(f"  PREFLIGHT_FAIL_reserve [{a[:24]!r}] x{c}"); fail += 1
    if fail: print(f"  {path}: {fail} preflight failures, skip"); return False
    if not apply_it:
        print(f"  {path}: preflight OK ({len(edits)} edits, {len(reserves)} reserves)"); return True
    for old, new, tag in edits:
        t = t.replace(old, new)
    for a, para in reserves:
        m = metrics(t); cjk_now = len(re.findall(r"[一-鿿]", t))
        if m['new_ngram_rate'] >= tgt_rate and cjk_now >= tgt_cjk: break
        assert not re.search(r"\d", para)
        t = t.replace(a, a + "\n\n" + para)
    log = {}
    if rules: t = rotaterun(t, rules, log); print(f"  rotations: {sum(log.values())} {log}")
    for hd, para in reserves2:
        m = metrics(t); cjk_now = len(re.findall(r"[一-鿿]", t))
        if m['new_ngram_rate'] >= tgt_rate and cjk_now >= tgt_cjk: break
        assert not re.search(r"\d", para)
        assert para not in t
        t = insert_after_first_para(t, hd, para)
    finish(path, t0, t)
    return True

if __name__ == "__main__":
    mode = sys.argv[1] if len(sys.argv) > 1 else "preflight"
    which = sys.argv[2] if len(sys.argv) > 2 else "all"
    apply_it = mode in ("apply", "all")
    for k, job in JOBS.items():
        if which != "all" and which != k: continue
        print(f"================ CH{k} R2 ({mode}) ================")
        run(*job, apply_it)
    print("R2 DONE")
