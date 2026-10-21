# -*- coding: utf-8 -*-
"""ch11 编辑稿 拼版手术：
①删劣版下篇v1(11.6~11.11+源对照20条, 引用对照较疏; B版v2含段落级映射与更全案例事实)
②前半小结(11.5.1五条)并入全章小结、前半证据边界独有条(178万案/分包界面)并入全章证据边界, 标题壳删除
③节号重排 11.6~11.9→11.5~11.8(编号连续; 全文无 11.x 交叉引用, 已核)
④A版独有零引用编号实质件移植: 工程类型风险矩阵 + 信函编号格式示例
⑤AI残留剥离 + NBLM来源口径中性化 + 数据驱动术语裁决(模型/闭环均管理数学义KEEP)
引用编号[N]全程未改值(token数守恒断言)。"""
import re, json

P = r'e:/AI-Station/_proposals/flagship-paid-report-1007/work/m2/sched/nblm_out/ch11_编辑稿.md'
raw = open(P, encoding='utf-8', newline='').read().lstrip('\ufeff')
crlf = raw.count('\r\n')
s = raw.replace('\r\n', '\n')
lines = s.split('\n')

def L(n): return lines[n-1]
def span(a, b): return lines[a-1:b]
def chars(a, b): return len('\n'.join(span(a, b)))

# ---- boundary assertions (fail loudly, write nothing) ----
assert len(lines) == 620, len(lines)
assert L(1) == '## 第11章 国际对标：FIDIC工期条款与海外工程实践（上篇）', L(1)
assert L(190) == '---' and L(191) == ''
assert L(192) == '### 11.5 本章前半部分小结与证据边界'
assert L(193) == '' and L(194) == '#### 11.5.1 小结要点' and L(195) == ''
assert L(196).startswith('1. **工期分类与EOT本质**'), L(196)[:20]
assert L(200).startswith('5. **分包界面实行总包快裁**'), L(200)[:20]
assert L(202) == '#### 11.5.2 本章证据边界（前半部分）'
assert L(209).find('178万元签证失效') >= 0 and L(209).find('[3]') >= 0
assert L(214).find('分包界面快裁') >= 0 and L(214).find('[7, 40-42]') >= 0
assert L(216).startswith('*(本章前半部分撰写完毕'), L(216)[:16]
assert L(218) == '## 第11章 国际对标：FIDIC工期条款与海外工程实践（下篇）'
assert L(288) == '```' and L(306) == '```'
assert '海外不同工程类型工期关键风险与防控矩阵' in '\n'.join(span(288, 306))
assert L(434).startswith('*(第11章《国际对标'), L(434)[:16]
assert L(436) == '### 11.6 境外工程保险理赔与见索即付保函风险防控'
assert L(500).startswith('不同工程领域的海外EPC项目'), L(500)[:15]
assert L(502).startswith('#### 11.8.1 海外光伏与变电EPC'), L(502)[:20]
assert L(559) == '---' and L(560) == '' and L(561) == '### 11.10 本章小结要点'
assert L(563).startswith('1. **保险理赔讲究时效') and L(567).startswith('5. **启动期30天')
assert L(571) == '### 11.11 本章证据边界' and L(572) == ''
assert L(573).find('本笔记本已导入的20份源文件与文献') >= 0
assert L(575) == '* **判例与实操案例**：' and L(579).find('哥伦比亚') >= 0
assert L(584) == '* **规则、公式与制度数据**：' and L(587).find('10项制度清单') >= 0
assert L(591) == '### 《源引用对照》清单'
assert L(593).find('本笔记本全部源文件') >= 0
assert L(595).startswith('| 映射编号 | 笔记本源文件名称 | 源码类型 |')
assert L(615).find('数据驱动的技术话语权') >= 0
assert L(616).startswith('| **20**') and L(617) == '' and L(618) == '---'
assert L(620).startswith('💡')

# relocated bullets (上篇证据边界独有条, 引用编号[N]原值保留, 书名自带消歧)
B178 = L(209)
Bsub = L(214).replace('过错追赏原则', '过错追责原则')  # 显见笔误: 上下文均为追责/追偿
NEWPREAMBLE = ('本章的所有判例案卷、法律规则、行业数据及管理制度，'
               '**严格限制并完全锚定于本章引用的20份参考资料与文献**。具体证据边界对照如下：')

def renum(seg, start):
    out = []
    for i, t in enumerate(seg):
        m = re.match(r'^(\d+)\. (.*)$', t)
        assert m, t[:24]
        out.append('%d. %s' % (start + i, m.group(2)))
    return out

# ---- assemble ----
out_lines = (span(1, 191)        # 章题 + 11.0~11.4 全文 + ---
             + span(436, 501)    # B版 11.6 起始 ~ 11.8节引句 + 空行
             + span(288, 306)    # A版独有: 工程类型风险矩阵(无引用编号, 零冲突移植)
             + ['']
             + span(502, 560)    # B版 11.8.1 ~ 11.9 末分隔线
             + ['### 11.9 本章小结要点', '']
             + span(196, 200)    # 上篇小结五条(原编号1-5)
             + renum(span(563, 567), 6)   # B版小结五条 → 6-10
             + span(568, 570)    # 空行 + --- + 空行
             + ['### 11.10 本章证据边界', '']
             + [NEWPREAMBLE]
             + span(574, 579)    # 空行 + 判例头 + UBC/A\B水电/墨西哥/哥伦比亚
             + [B178]            # 上篇独有: 178万/800万案源对照
             + span(580, 584)    # 菲律宾/帕德玛/卡西姆/波兰 + 规则公式头
             + span(585, 587)    # 三条规则数据
             + [Bsub]            # 上篇独有: 分包界面源对照
             + span(588, 618))   # --- + 《源引用对照》清单(B版20条) + ---
out = '\n'.join(out_lines)

# ---- in-place fixes (unique anchors, count==1 each) ----
def fix_once(old, new, tag):
    global out
    assert out.count(old) == 1, (tag, out.count(old))
    out = out.replace(old, new)

# 1) 章题剥 NBLM 上下篇分段残留「（上篇）」(ch09 剥「（上）」同例)
fix_once('## 第11章 国际对标：FIDIC工期条款与海外工程实践（上篇）',
         '## 第11章 国际对标：FIDIC工期条款与海外工程实践', 'title')
# 2) 节号重排(11.5壳并入章末后保持连续; 序号升序替换避免二次位移)
for old, new in [
    ('### 11.6 境外工程保险理赔', '### 11.5 境外工程保险理赔'),
    ('#### 11.6.1 ', '#### 11.5.1 '),
    ('#### 11.6.2 ', '#### 11.5.2 '),
    ('### 11.7 海外EPC设计风险控制', '### 11.6 海外EPC设计风险控制'),
    ('#### 11.7.1 ', '#### 11.6.1 '),
    ('#### 11.7.2 ', '#### 11.6.2 '),
    ('### 11.8 重点海外工程类型', '### 11.7 重点海外工程类型'),
    ('#### 11.8.1 ', '#### 11.7.1 '),
    ('#### 11.8.2 ', '#### 11.7.2 '),
    ('### 11.9 项目启动阶段', '### 11.8 项目启动阶段'),
    ('#### 11.9.1 ', '#### 11.8.1 '),
    ('#### 11.9.2 ', '#### 11.8.2 '),
]:
    fix_once(old, new, old[:14])
# 3) 术语裁决: 数据驱动(管理语境互联网腔)→以数据为依据; 模型×3/闭环×6均管理数学义KEEP
fix_once('数据驱动的技术话语权与样板段', '以数据为依据的技术话语权与样板段', 'shujuqudong')
# 4) A版独有操作细节移植: 信函统一编号格式示例(无引用编号)
fix_once('必须采用统一的受控编号格式 [52]。',
         '必须采用统一的受控编号格式（如：`ABC-EPC-OWN-LTR-001`） [52]。', 'bianhao')
# 5) NBLM 生产来源口径中性化(ch08/09/10判例: 笔记本→参考资料)
fix_once('所引用的本笔记本全部源文件', '所引用的全部参考资料', 'bijiben_qingdan')
fix_once('| 映射编号 | 笔记本源文件名称 | 源码类型 |',
         '| 映射编号 | 参考资料名称 | 资料类型 |', 'bijiben_header')

# ---- in-memory final-state checks before writing ----
def cjk(t): return len(re.findall('[一-鿿]', t))
sec_nums = re.findall(r'^### (11\.\d+)', out, re.M)
checks = {
    '章H2数': len(re.findall(r'^## 第11章', out, re.M)),
    '小结要点标题': len(re.findall(r'^#{1,6}[^\n]*小结要点', out, re.M)),
    '证据边界标题': len(re.findall(r'^#{1,6}[^\n]*证据边界', out, re.M)),
    '源引用对照标题': len(re.findall(r'^#{1,6}[^\n]*源引用对照', out, re.M)),
    '二级节数': len(sec_nums),
    '二级节序列': ','.join(sec_nums),
    '代码栅栏奇偶': out.count('```') % 2,
}
residue = ['请回复', '继续', '前半部分', '后半部分', '上下篇', '上篇', '下篇', '至此',
           '撰写完毕', '撰写完成', '💡', '下一步建议', '下一阶段建议', '后续实务', '后续跟进',
           '我可以为您', '由我为您', '我将为您', '为您', '可随时告知', 'losses', 'monthly',
           '笔记本', '源文件', '源码', '全景框架', 'Tailored', 'slide', '您希望', '数据驱动']
for pat in residue:
    checks['残留:' + pat] = out.count(pat)

tok = lambda t: re.findall(r'\[[0-9][0-9,\s\-]*\]', t)
kept_src = '\n'.join(span(1, 191) + span(436, 501) + span(288, 306) + span(502, 560)
                     + span(196, 200) + span(563, 567) + span(568, 570)
                     + [NEWPREAMBLE] + span(574, 587) + [B178, Bsub] + span(588, 618))
checks['引用token数_保留源'] = len(tok(kept_src))
checks['引用token数_终稿'] = len(tok(out))

ok = (checks['章H2数'] == 1 and checks['小结要点标题'] == 1 and checks['证据边界标题'] == 1
      and checks['源引用对照标题'] == 1 and checks['二级节数'] == 11
      and checks['二级节序列'] == ','.join('11.%d' % i for i in range(11))
      and checks['代码栅栏奇偶'] == 0
      and checks['引用token数_保留源'] == checks['引用token数_终稿']
      and all(v == 0 for k, v in checks.items() if k.startswith('残留:')))
print(json.dumps(checks, ensure_ascii=False, indent=1))
assert ok, 'final-state check failed, nothing written'

# ---- removed-span accounting (old 1-based line ranges) ----
removed = [
    ('AI残留: 「*(本章前半部分撰写完毕…请回复「继续」，我将为您…)*」交互话术+包裹空行', '215-217', chars(215, 217)),
    ('重复壳与重复条目: 11.5前半小结/证据边界标题壳+与B版11.11重复条目(上篇小结5条移入11.9, 178万/分包2条移入11.10)', '192-214',
     chars(192, 215) - chars(196, 200) - len(L(209)) - len(L(214)) - 1),
    ('重复劣版: 下篇v1整段 11.6~11.11+源对照清单20条(引用对照较疏; B版v2含段落级映射与更全案例事实)', '218-433',
     chars(218, 433) - chars(288, 306)),
    ('AI残留: 「*(第11章…全章初稿撰写完毕。全章严格依据笔记本全部20份资料…)*」自宣尾注', '434', len(L(434))),
    ('AI残留: 💡「后续实务研讨建议」深度定制招揽+包裹空行', '619-620', len(L(619)) + 1 + len(L(620))),
]
report = {
    'cjk_before': cjk(s),
    'cjk_after': cjk(out),
    'chars_before': len(s),
    'chars_after': len(out),
    'lines_before': len(lines) - 1,
    'lines_after': len(out_lines) - 1,
    'removed': [{'what': w, 'span': sp, 'chars': c} for w, sp, c in removed],
}
print(json.dumps(report, ensure_ascii=False, indent=1))

out_disk = out.replace('\n', '\r\n') if crlf > 0 else out
open(P, 'w', encoding='utf-8', newline='').write(out_disk)
print('WRITTEN OK')
