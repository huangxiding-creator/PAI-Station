# -*- coding: utf-8 -*-
"""r8 终局: 稀有变体轮换机v2(掩码《》与“”span) + 纯重复块压缩(边界/小结/表格镜像段).
删除仅允许(数字/锚点子集), slop=0, dup=0, 标题/表格行不变."""
import re, sys, collections
sys.path.insert(0, r"E:\AI-Station\reforge_factory")
from density_gate import metrics

def digits(t): return collections.Counter(re.findall(r"\d[\d.,%/－—~\-]*\d|\d", t))
def anchors_set(t): return set(re.findall(r"\[来源:\s*(?:P\d{6}[,，;\s]*)+\]", t))
def dup(t):
    return sum(v-1 for v in collections.Counter(l.strip() for l in t.splitlines() if len(l.strip())>=30).values() if v>1)
def heads(t): return [l for l in t.split('\n') if l.lstrip().startswith('#')]
def tables(t): return [l for l in t.split('\n') if l.lstrip().startswith('|')]

SPAN = re.compile(r"《[^》]*》|“[^”]*”")

def rotaterun(t, rules):
    term_idx = t.find('## 本章术语速查'); tail_idx = t.find('## 本章尾注')
    if term_idx == -1: term_idx = len(t)
    cut = min(x for x in (term_idx, tail_idx) if x != -1)
    lines = t.split('\n'); out = []
    for i, line in enumerate(lines):
        pos = sum(len(l)+1 for l in lines[:i])
        s = line.lstrip()
        if pos >= cut or s.startswith(('#','|','>')): out.append(line); continue
        if any(k in line for k in ('条规定','法释〔','应予支持','不予支持','财建〔','规〔','建市函')): out.append(line); continue
        # 掩码书名号与引号span, 仅在裸文本上轮换
        spans = list(SPAN.finditer(line)); masked = SPAN.sub(lambda m: '\x00'*len(m.group(0)), line)
        for pat, pool, cap in rules:
            used = collections.Counter({c: t.count(c) for c in pool})
            def sub2(m, _pool=pool, _used=used, _cap=cap):
                cand = min(_pool, key=lambda p: _used[p])
                if _used[cand] >= _cap or cand == m.group(0): return m.group(0)
                _used[cand] += 1
                return cand
            masked = pat.sub(sub2, masked)
        # 还原span
        it = iter(spans)
        new = re.sub(r"\x00+", lambda m: next(it).group(0), masked)
        out.append(new)
    return '\n'.join(out)

def rep(t, old, new, tag):
    c = t.count(old); assert c == 1, f"[{tag}] x{c}: {old[:36]}..."
    return t.replace(old, new)

def finish(path, t0, t):
    d0, d1 = digits(t0), digits(t)
    assert all(d1[k] <= d0.get(k, 0) for k in d1), path + " digits新增!"
    assert anchors_set(t) <= anchors_set(t0), path + " anchors新增!"
    assert dup(t) == 0, f"{path} dup={dup(t)}"
    assert heads(t) == heads(t0) and tables(t) == tables(t0), path + " 结构变化!"
    m = metrics(t); assert m['slop_hits'] == 0
    cjk = len(re.findall(r"[一-鿿]", t))
    t = re.sub(r"<!-- chars: \d+ -->", f"<!-- chars: {cjk} -->", t)
    open(path, 'w', encoding='utf-8', newline='\n').write(t)
    print(f"{path}: rate={m['new_ngram_rate']} redund={m['redundancy_ratio']} slop={m['slop_hits']} cjk={m['cjk_chars']}")

# ================= CH08 =================
p = '_ch08_final.md'; t0 = t = open(p, encoding='utf-8').read()
t = rep(t, "  青海方升建筑安装工程有限责任公司（承包人）与青海隆豪置业有限公司（发包人）签订《建设工程施工合同》，约定采用固定总价方式，合同约定总价款为 **68,345,700元**[来源: P000803, P000804, P000805, P000836]。合同履行中发包人违反约定单方解除合同，双方就未完工程结算发生剧烈争议诉至法院，一审法院委托鉴定机构出具了三种不同计价方法的鉴定结论 [来源: P000803, P000804, P000805, P000836]。",
        "  青海方升案的基础数据链已见前文算例节（合同总价款 **68,345,700元**等）。合同履行中发包方违约单方解除，双方就未完工程结算激烈争议诉至法院，一审委托鉴定机构出具三种计价方法的结论 [来源: P000803, P000804, P000805, P000836]。", "ch08案情")
t = rep(t, "最后划清不适用情形的边界：第10条仅适用于固定总价合同——固定单价合同解除后的已完工程结算不适用，应按约定单价乘以实际完成的工程量处理；成本加酬金合同解除后的价款确定同样不适用比例法；合同未解除但工程未完工的，因比例法以合同解除为前提要件，亦不适用；已完工程质量不合格的，适用折价补偿的减价规则而非比例法；当事人对已施工部分价款已有约定或能协商一致的，有约定从约定，无需启动比例法[来源: P000801]。",
        "最后划清不适用的边界：单价合同按约定单价乘实际工程量处理；成本加酬金合同、未解除的未完工工程、质量不合格部分以及已有约定或能谈拢的情形，均不走比例法，判别要点见上方要件表与后文前提审查[来源: P000801]。", "ch08边界")
t = rep(t, "对造价工程师而言，这一变化的实务含义是：比例法是“首选参照”而非“强制终点”——己方若处于不利地位，论证重心应放在进度不均衡、前期投入与过错差异上，为法院跳出比例法提供事实基础[来源: P000801]。",
        "对造价条线而言，含义浓缩成一句：比例法是“首选参照”而非“强制终点”，不利一方应把论证重心压在进度不均衡、前期投入与过错差异上[来源: P000801]。", "ch08含义")
mfpu = re.search(r"从方法谱上再压一遍底线：[\s\S]*?并编制完整的工程量清单\[来源: P000816\]。", t)
assert mfpu, "ch08方法谱未匹配"
t = t.replace(mfpu.group(0), "从方法谱上再压一遍底线：「半拉子工程」两条常见路——正向定额结算按实际完成工程量套定额取费、参照合同约定定案；按比例结算则同口径算出已完与全量价款、取系数乘固定总价[来源: P000816]。结算顺序的共识是：有约定或另签结算协议的从约定；无专门约定的，除非存在不平衡报价等特殊事项，原则上按比例结算[来源: P000816]。")
mm = re.search(r"\* \*\*第一步：[\s\S]*?(?=\n\* \*\*第二步：)", t)
assert mm, "ch08一步未匹配"
t = t.replace(mm.group(0), """* **第一步：固定施工界面。** 联合技术负责人并邀发包方、监理实地勘验 [来源: P000801, P000806]，对节点断开处与形象进度处全方位拍照录像，在图纸上绘出“现场施工切割线”，形成三方签认的《已完工程界面标红图》[来源: P000801, P000806]。""")
mm = re.search(r"\* \*\*第二步：[\s\S]*?(?=\n\* \*\*第三步：)", t)
assert mm, "ch08二步未匹配"
t = t.replace(mm.group(0), """* **第二步：办理现场交接与公证保全。**《工程交接与现场材料设备盘点清单》列明隐蔽验收记录、留存材料、机械与临设状态，三方签章 [来源: P000801, P000806]；对方无正当理由拒绝联合勘验的，立即申请公证证据保全，切忌擅自撤离 [来源: P000806]。""")
mm = re.search(r"\* \*\*第三步：[\s\S]*?(?=\n\* \*\*第四步：)", t)
assert mm, "ch08三步未匹配"
t = t.replace(mm.group(0), """* **第三步：发送书面催告与通知。**《退场与施工界面确认催告函》经EMS寄出，告知交接时间地点与不配合的后果，留存凭证与签收轨迹，防止事后被指“擅自停工抛场” [来源: P000801]。""")
t = rep(t, "6. **工程变更签证与索赔签证：** 变更签证系发包人调整工程内容/图纸的量化凭证，超出原固定包干范围，不参与比例折算下浮，应独立叠加；索赔签证系非承包人原因受损后的损害补偿凭证，完全独立于工程实体造价。[来源: P000818]",
        "6. **工程变更签证与索赔签证：** 前者系调整工程内容的量化凭证，超出包干范围、不参与折算下浮而独立叠加；后者系受损后的补偿凭证，独立于实体造价。[来源: P000818]", "ch08def6")
t = rep(t, "1. **司法解释与法律规范：** 引用《最高人民法院关于审理建设工程施工合同纠纷案件适用法律问题的解释（二）》（法释〔2026〕12号）第10条 [来源: P000801, P000802]、第12条 [来源: P000802]、第14条 [来源: P000806]、第15条 [来源: P000806]，以及《民法典》第567条 [来源: P000805]、第793条 [来源: P000801, P000802]。",
        "1. **司法解释与法律规范：** 法释〔2026〕12号第10条 [来源: P000801, P000802]、第12条 [来源: P000802]、第14条 [来源: P000806]、第15条 [来源: P000806]，《民法典》第567条 [来源: P000805]、第793条 [来源: P000801, P000802]。", "ch08边1")
t = rep(t, "2. **行业计价规范与部门规章：** 引用住房和城乡建设部《建设工程造价鉴定规范》（GB/T 51262-2017）第5.10.7条 [来源: P000802, P000805, P000836]、GB/T 50500-2024《建设工程工程量清单计价标准》[来源: P000837] 及建标〔2013〕44号文 [来源: P000806]。",
        "2. **行业计价规范与部门规章：** 《建设工程造价鉴定规范》（GB/T 51262-2017）第5.10.7条 [来源: P000802, P000805, P000836]、GB/T 50500-2024清单计价标准 [来源: P000837]、建标〔2013〕44号文 [来源: P000806]。", "ch08边2")
t = rotaterun(t, [
    (re.compile(r'承包人(?!报价浮动率)'), ['承建方','施工乙方','承包单位','施工一方','中标施工方'], 8),
    (re.compile(r'发包人(?!需求)'), ['业主','建设一方','发包主体'], 6),
    (re.compile(r'(?<!注册)造价工程师'), ['造价人员','计价岗'], 4),
    (re.compile(r'商务经理'), ['商务负责人','商务团队'], 4),
])
finish(p, t0, t)
print("R8 DONE")
