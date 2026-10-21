# -*- coding: utf-8 -*-
"""ch09 编辑稿 拼版手术：删劣版重复段(第四节~第六节+源对照 v1) + AI残留剥离 + 泄露中性化 + 标题去分段残留"""
import re, json

P = r'e:/AI-Station/_proposals/flagship-paid-report-1007/work/m2/sched/nblm_out/ch09_编辑稿.md'
raw = open(P, encoding='utf-8', newline='').read().lstrip('\ufeff')
crlf = raw.count('\r\n')
print('line-endings: crlf=%d' % crlf)
s = raw.replace('\r\n', '\n')
lines = s.split('\n')

def L(n): return lines[n-1]
def span(a, b): return lines[a-1:b]
def chars(a, b): return len('\n'.join(span(a, b)))

# ---- boundary assertions (fail loudly, write nothing) ----
assert len(lines) == 624 and lines[-1].lstrip().startswith('2. **开展具体案例'), (len(lines), lines[-1][:20])  # 无文件尾换行
assert L(3) == '## 第9章 判例图谱：八千万字判决书里的败诉原因与高频风险（上）', L(3)
assert '停工 losses' in L(124)
assert L(269) == '***', repr(L(269))
assert L(271).lstrip().startswith('*(注：本章前半部分至此结束'), L(271)[:24]
assert L(275).lstrip().startswith('💡'), L(275)[:16]
assert L(277) == '### 第四节 发包方违法超规建设与审计/时效引发的工期抗辩', L(277)
assert L(354) == '### 第五节 施工企业工期索赔败诉十大高频裁判规则总结'
assert L(390) == '### 第六节 小结要点与本章证据边界清单'
assert L(416) == '### 《源引用对照》清单'
assert '笔记本资料库' in L(418)
assert L(443) == '*(全章完)*', repr(L(443))
assert L(445) == '### 第四节 发包方违法超规建设与审计/时效引发的工期抗辩', L(445)
assert L(455).startswith('##### 案例10')
assert '2017年4月' in L(458) and '实际使用' in L(458)
assert L(522) == '### 第五节 施工企业工期索赔败诉十大高频裁判规则总结'
assert L(558) == '### 第六节 小结要点与本章证据边界清单'
assert L(560) == '#### 6.1 本章小结要点', L(560)
assert L(570) == '#### 6.2 本章证据边界清单（施工企业实战必备）', L(570)
assert L(584) == '### 《源引用对照》清单'
assert '笔记本资料库' in L(586) and '上、下两半部分' in L(586)
assert L(614) == '*(全章完)*', repr(L(614))
assert L(616) == '***', repr(L(616))
assert L(618) == '#### 本章总结与后续跟进建议', L(618)
assert L(624).lstrip().startswith('2.'), L(624)[:16]

# ---- assemble new document: 前半(导言+第一~三节) + --- + 后半B(第四节~第六节+源对照v2+全章完) ----
seg_a = span(1, 268)      # 书名/章题/导言/第一节~第三节, 止于3.3末空行
seg_c = span(445, 614)    # 后半B: 第四节~第六节 + 源引用对照(23条,引用对照更全) + *(全章完)*
out_lines = seg_a + ['---', ''] + seg_c
out = '\n'.join(out_lines)

# ---- in-place surgical fixes (unique anchors, verified count==1 each) ----
def fix_once(text, old, new, tag):
    assert text.count(old) == 1, (tag, text.count(old))
    return text.replace(old, new)

# 1) 章题去 NBLM 上下半生成残留「（上）」(全报告无第9章(下), ch10为另一主题; ch01手术同例剥「（下）」)
out = fix_once(out, '## 第9章 判例图谱：八千万字判决书里的败诉原因与高频风险（上）',
                   '## 第9章 判例图谱：八千万字判决书里的败诉原因与高频风险', 'title_shang')
# 2) 英文AI残留 losses -> 损失
out = fix_once(out, '停工 losses 纳入', '停工损失纳入', 'losses')
# 3) 案例10 占用日期回正: 语料90_判例合集1.md原文=「2016年12月，在工程未经竣工验收的情况下，被告因生产需要对工程进行了使用」; 劣版B(2016年12月)正确, 保留版C误作2017年4月
out = fix_once(out, '2017年4月，在工程未经竣工验收的情况下，恒博公司因生产需要强行对涉案厂房进行了实际使用',
                   '2016年12月，在工程未经竣工验收的情况下，恒博公司因生产需要强行对涉案厂房进行了实际使用', 'kaiyang_date')
# 4) 生产来源泄露中性化: 笔记本资料库->参考资料库; 「上、下两半部分」->「全章」(ch08先例)
out = fix_once(out, '本章（上、下两半部分）所有案例、数据、裁判观点及法规标准均严格摄取自笔记本资料库',
                   '本章（全章）所有案例、数据、裁判观点及法规标准均严格摄取自参考资料库', 'bijiben')
# 5) 末段结构拍平: 合并版父标题删除, 6.1/6.2 升 ### 级并独立成节 (小结要点/证据边界标题各恰1)
out = fix_once(out, '### 第六节 小结要点与本章证据边界清单\n\n#### 6.1 本章小结要点',
                   '### 第六节 本章小结要点', 'flatten_a')
out = fix_once(out, '#### 6.2 本章证据边界清单（施工企业实战必备）',
                   '### 第七节 本章证据边界清单（施工企业实战必备）', 'flatten_b')

out_lines = out.split('\n')

# ---- in-memory final-state checks before writing ----
def cjk(t): return len(re.findall('[一-鿿]', t))
checks = {
    '小结要点标题': len(re.findall(r'^#{1,6}[^\n]*小结要点', out, re.M)),
    '证据边界标题': len(re.findall(r'^#{1,6}[^\n]*证据边界', out, re.M)),
    '源引用对照标题': len(re.findall(r'^#{1,6}[^\n]*源引用对照', out, re.M)),
    '第四节标题': out.count('### 第四节 '),
    '第五节标题': out.count('### 第五节 '),
    '第六节标题': out.count('### 第六节 '),
    '第七节标题': out.count('### 第七节 '),
    '全章完标记': out.count('*(全章完)*'),
    '章H2数': len(re.findall(r'^## 第9章', out, re.M)),
}
residue = ['请回复', '“继续”', '前半部分', '至此结束', '💡', '下一阶段建议', '下一步建议',
           '后续实务', '后续跟进', '后续可开展', '延伸应用', '我可以为您', '由我为您', '为您',
           '可随时告知', 'losses', 'monthly', '笔记本', '（上）', '（下）']
for pat in residue:
    checks['残留:' + pat] = out.count(pat)
# 引用编号[N]不改值: 终稿引用token集合必须原样来自保留段(构造上未触碰, 仍显式断言总数不增减)
tok = lambda t: re.findall(r'\[[0-9][0-9,\s\-]*\]', t)
kept_src = '\n'.join(seg_a + seg_c)
checks['引用token数_保留源'] = len(tok(kept_src))
checks['引用token数_终稿'] = len(tok(out))

ok = (checks['小结要点标题'] == 1 and checks['证据边界标题'] == 1
      and checks['源引用对照标题'] == 1 and checks['第四节标题'] == 1
      and checks['第五节标题'] == 1 and checks['第六节标题'] == 1 and checks['第七节标题'] == 1
      and checks['全章完标记'] == 1 and checks['章H2数'] == 1
      and checks['引用token数_保留源'] == checks['引用token数_终稿']
      and all(v == 0 for k, v in checks.items() if k.startswith('残留:')))
print(json.dumps(checks, ensure_ascii=False, indent=1))
assert ok, 'final-state check failed, nothing written'

# ---- removed-span accounting (old 1-based line ranges) ----
removed = [
    ('AI残留: 「*(注：本章前半部分至此结束…)*」上下半分段标记+包裹分隔线', '269-275', chars(269, 275)),
    ('💡「下一阶段建议…请直接回复“继续”」交互话术(含于269-275)', '269-275内', 0),
    ('重复劣版整段删除: 第四节~第六节+源引用对照v1(20条)+*(全章完)*, 与后半B重复且引用对照更疏', '277-443', chars(277, 443)),
    ('AI残留: 「#### 本章总结与后续跟进建议」营销尾段(定制文书集/案例诊断招揽)+包裹分隔线', '615-624', chars(615, 624)),
]
report = {
    'cjk_before': cjk(s),
    'cjk_after': cjk(out),
    'chars_before': len(s),
    'chars_after': len(out),
    'lines_before': len(lines) - 1,
    'lines_after': len(out_lines) - 1,
    'removed': removed,
}
print(json.dumps(report, ensure_ascii=False, indent=1))

out_disk = out.replace('\n', '\r\n') if crlf > 0 else out
open(P, 'w', encoding='utf-8', newline='').write(out_disk)
print('WRITTEN OK')
