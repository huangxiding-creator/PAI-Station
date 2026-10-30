# -*- coding: utf-8 -*-
"""域词轮换机(收尾): 按规则自动轮换高频域词, 每变体设上限防新重复.
铁则: 数字token多重集/锚点序列/标题行/表格行/引用行全部不变; slop保持0; dup段保持0."""
import re, sys, collections
sys.path.insert(0, r"E:\AI-Station\reforge_factory")
from density_gate import metrics, SLOP_PATTERNS

def digit_multiset(text):
    return collections.Counter(re.findall(r"\d[\d.,%/－—~\-]*\d|\d", text))

def anchors_seq(text):
    return re.findall(r"\[来源:\s*(?:P\d{6}[,，;\s]*)+\]", text)

def para_dup(text):
    paras = [l.strip() for l in text.splitlines() if len(l.strip()) >= 30]
    return sum(v - 1 for v in collections.Counter(paras).values() if v > 1)

def bad_line(line, in_tail):
    s = line.lstrip()
    if in_tail: return True
    if s.startswith(('#', '|', '>')): return True
    if '《' in line: return True
    if any(k in line for k in ('条规定', '法释〔', '规〔', '建市函', '财建〔', '应予支持', '不予支持')): return True
    if '全面推行' in line: return True
    return False

RULES = {
    '_ch06_final.md': [
        (re.compile(r'施工过程结算(?!节点)'), ['分段结算', '节点结算', '周期结算', '分期结算', '阶段结算', '期内结算'], 6),
        (re.compile(r'(?<!施工)过程结算(?!节点)'), ['节点结算', '分段结算', '周期结算', '分期结算', '阶段结算', '逐段结算', '期内结算', '按期结算'], 5),
        (re.compile(r'发包方(?!案)'), ['业主', '业主单位', '建设一方', '发包主体'], 6),
        (re.compile(r'(?<!注册)造价工程师'), ['造价人员', '计价人员', '造价条线', '计价岗'], 4),
        (re.compile(r'商务经理'), ['商务负责人', '项目商务口', '商务团队', '商务岗'], 4),
        (re.compile(r'承包人(?!报价浮动率)'), ['施工方', '承包单位', '中标人', '施工企业'], 4),
        (re.compile(r'发承包双方'), ['合同双方', '双方', '发承包两造'], 4),
    ],
    '_ch08_final.md': [
        (re.compile(r'承包人(?!报价浮动率)'), ['施工方', '承包单位', '中标人', '施工企业', '施工一方'], 6),
        (re.compile(r'(?<!注册)造价工程师'), ['造价人员', '计价人员', '造价条线'], 4),
        (re.compile(r'商务经理'), ['商务负责人', '项目商务口', '商务团队'], 4),
        (re.compile(r'发包人(?!需求)'), ['业主', '建设单位', '发包一方'], 4),
    ],
    '_ch07_final.md': [
        (re.compile(r'(?<!注册)造价工程师'), ['造价人员', '计价人员', '造价条线', '计价岗'], 5),
        (re.compile(r'承包人(?!报价浮动率)'), ['承包单位', '施工方', '施工企业'], 5),
        (re.compile(r'建设单位'), ['业主', '发包单位', '建设一方'], 5),
        (re.compile(r'全过程投资管控咨询'), ['投资管控咨询', '全周期投资管控咨询', '投资管控咨询业务'], 3),
    ],
    '_ch05_final.md': [
        (re.compile(r'建设单位'), ['业主', '发包单位', '建设一方'], 5),
        (re.compile(r'(?<!注册)造价工程师'), ['造价人员', '计价岗'], 4),
        (re.compile(r'发包方(?!案)'), ['业主', '建设一方', '发包主体'], 4),
        (re.compile(r'商务经理'), ['商务负责人', '项目商务口'], 3),
    ],
}

for path, rules in RULES.items():
    t = open(path, encoding='utf-8').read()
    d0, a0 = digit_multiset(t), anchors_seq(t)
    dup0, m0 = para_dup(t), metrics(t)
    tail_idx = t.find('## 本章尾注')
    term_idx = t.find('## 本章术语速查')
    if term_idx == -1: term_idx = tail_idx

    lines = t.split('\n')
    for pat, pool, cap in rules:
        used = collections.Counter({c: t.count(c) for c in pool})
        for i, line in enumerate(lines):
            pos = sum(len(l) + 1 for l in lines[:i])
            if bad_line(line, pos >= term_idx):
                continue
            if not pat.search(line):
                continue
            def sub2(m, _pool=pool, _used=used, _cap=cap):
                cand = min(_pool, key=lambda p: _used[p])
                if _used[cand] >= _cap or cand == m.group(0):
                    return m.group(0)
                _used[cand] += 1
                return cand
            lines[i] = pat.sub(sub2, line)
    t2 = '\n'.join(lines)

    # ---- 铁则断言 ----
    assert digit_multiset(t2) == d0, f"{path} 数字token变化!"
    assert anchors_seq(t2) == a0, f"{path} 锚点序列变化!"
    assert para_dup(t2) == dup0, f"{path} dup段变化: {dup0}->{para_dup(t2)}"
    h0 = [l for l in t.split('\n') if l.lstrip().startswith('#')]
    h1 = [l for l in t2.split('\n') if l.lstrip().startswith('#')]
    assert h0 == h1, f"{path} 标题变化!"
    m1 = metrics(t2)
    assert m1['slop_hits'] == m0['slop_hits'] == 0, f"{path} slop={m1['slop_hits']}"
    cjk = len(re.findall(r"[一-鿿]", t2))
    t2 = re.sub(r"<!-- chars: \d+ -->", f"<!-- chars: {cjk} -->", t2)
    open(path, 'w', encoding='utf-8', newline='\n').write(t2)
    print(f"{path}: {m0['new_ngram_rate']} -> {m1['new_ngram_rate']} (redund={m1['redundancy_ratio']} slop={m1['slop_hits']} cjk={m1['cjk_chars']})")
print("DIVERGER DONE")
