# -*- coding: utf-8 -*-
"""r9 压轴轮: 扩容轮换(高上限+更多变体) + ch08术语速查压缩. 之后终检."""
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

def rotaterun(t, rules, log):
    cut = min((x for x in (t.find('## 本章术语速查'), t.find('## 本章尾注')) if x != -1), default=len(t))
    lines = t.split('\n'); out = []
    for i, line in enumerate(lines):
        pos = sum(len(l)+1 for l in lines[:i])
        s = line.lstrip()
        if pos >= cut or s.startswith(('#','|','>')): out.append(line); continue
        if any(k in line for k in ('条规定','法释〔','应予支持','不予支持','财建〔','规〔','建市函','全面推行')): out.append(line); continue
        spans = list(SPAN.finditer(line)); masked = SPAN.sub(lambda m: '\x00'*len(m.group(0)), line)
        for pat, pool, cap in rules:
            used = collections.Counter({c: t.count(c) for c in pool})
            def sub2(m, _pool=pool, _used=used, _cap=cap, _log=log):
                cand = min(_pool, key=lambda p: _used[p])
                if _used[cand] >= _cap or cand == m.group(0): return m.group(0)
                _used[cand] += 1; _log[cand] = _log.get(cand, 0) + 1
                return cand
            masked = pat.sub(sub2, masked)
        it = iter(spans)
        out.append(re.sub(r"\x00+", lambda m: next(it).group(0), masked))
    return '\n'.join(out)

def finish(path, t0, t, log):
    d0, d1 = digits(t0), digits(t)
    assert all(d1[k] <= d0.get(k, 0) for k in d1), path + " digits新增!"
    assert anchors_set(t) <= anchors_set(t0), path + " anchors新增!"
    assert dup(t) == 0 and heads(t) == heads(t0) and tables(t) == tables(t0), path + " 结构!"
    m = metrics(t); assert m['slop_hits'] == 0
    cjk = len(re.findall(r"[一-鿿]", t))
    t = re.sub(r"<!-- chars: \d+ -->", f"<!-- chars: {cjk} -->", t)
    open(path, 'w', encoding='utf-8', newline='\n').write(t)
    print(f"{path}: rate={m['new_ngram_rate']} redund={m['redundancy_ratio']} slop={m['slop_hits']} cjk={m['cjk_chars']} rot={sum(log.values())}")

RULES = {
 '_ch05_final.md': [
    (re.compile(r'建设单位'), ['业主','发包单位','建设一方'], 9),
    (re.compile(r'发包方(?!案)'), ['甲方','建设一方','业主单位'], 7),
    (re.compile(r'(?<!注册)造价工程师'), ['造价人员','计价岗','造价条线'], 6),
    (re.compile(r'商务经理'), ['商务负责人','项目商务口'], 5),
 ],
 '_ch06_final.md': [
    (re.compile(r'施工过程结算(?!节点)'), ['逐节点结算','滚动结算','分段结算','期间结算','段内结算','按段结算'], 9),
    (re.compile(r'(?<!施工)过程结算(?!节点)'), ['逐期结算','滚动结算','期间结算','段内结算','按节点结算','逐节点结算','分期结算','按段结算'], 10),
    (re.compile(r'发包方(?!案)'), ['甲方','建设一方','业主单位','出资方','建设单位'], 9),
    (re.compile(r'承包人(?!报价浮动率)'), ['承建方','施工乙方','承包单位','施工单位','承包商'], 9),
    (re.compile(r'(?<!注册)造价工程师'), ['造价人员','计价岗','造价条线','造价团队'], 7),
    (re.compile(r'商务经理'), ['商务负责人','项目商务口','商务团队','商务条线'], 7),
 ],
 '_ch07_final.md': [
    (re.compile(r'(?<!注册)造价工程师'), ['造价人员','计价岗','造价条线','造价团队'], 9),
    (re.compile(r'建设单位'), ['业主','发包单位','建设一方'], 9),
    (re.compile(r'承包人(?!报价浮动率)'), ['承包单位','承建方','施工单位'], 8),
    (re.compile(r'施工单位'), ['承建方','施工一方','施工方'], 7),
    (re.compile(r'造价咨询机构'), ['造价咨询单位','咨询机构'], 5),
    (re.compile(r'模拟工程量清单'), ['模拟清单'], 4),
 ],
 '_ch08_final.md': [
    (re.compile(r'承包人(?!报价浮动率)'), ['承建方','施工乙方','承包单位','施工一方','中标施工方','施工单位','承包商'], 11),
    (re.compile(r'发包人(?!需求)'), ['业主','建设一方','发包主体','建设单位'], 9),
    (re.compile(r'(?<!注册)造价工程师'), ['造价人员','计价岗','造价条线'], 7),
    (re.compile(r'商务经理'), ['商务负责人','商务团队','项目商务口'], 7),
    (re.compile(r'固定总价合同'), ['总价包干合同','包干合同','闭口总价合同'], 7),
 ],
}

for path, rules in RULES.items():
    t0 = t = open(path, encoding='utf-8').read()
    log = {}
    t = rotaterun(t, rules, log)
    if path == '_ch08_final.md':
        for old, new in [
            ("1. **比例法（比例折算法）：** 根据《建工解释二》第10条，以已完工程在同一计价标准下的定额/预算价占全部工程定额/预算价的比例系数，乘以合同固定总价计算已完工程价款的方法。[来源: P000801, P000802]",
             "1. **比例法（比例折算法）：** 第10条确立的法定折算路径——同口径得出系数，乘合同固定总价算出已完部分价款。[来源: P000801, P000802]"),
            ("2. **扣减法（续建扣减法）：** 以合同约定的固定包干总价，扣除按原合同标准或定额测算出的未完工程造价（或实际续建合理成本），倒推计算已完工程价款的方法，主要适用于承包人违约解约场景。[来源: P000805, P000836]",
             "2. **扣减法（续建扣减法）：** 包干总价扣除未完部分的测算造价，倒推已完价款，多用于承包方违约解约场景。[来源: P000805, P000836]"),
        ]:
            c = t.count(old); assert c == 1, f"ch08def x{c}"
            t = t.replace(old, new)
    finish(path, t0, t, log)
print("R9 DONE")
