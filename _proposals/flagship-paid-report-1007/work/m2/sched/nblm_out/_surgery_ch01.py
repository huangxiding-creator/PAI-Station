# -*- coding: utf-8 -*-
"""ch01 编辑稿 拼版手术：去重(后半A vs 后半B) + AI残留剥离 + 源索引合并"""
import re, json

P = r'e:/AI-Station/_proposals/flagship-paid-report-1007/work/m2/sched/nblm_out/ch01_编辑稿.md'
raw = open(P, encoding='utf-8', newline='').read().lstrip('\ufeff')
crlf = raw.count('\r\n')
lf_only = raw.count('\n') - crlf
print('line-endings: crlf=%d lf-only=%d' % (crlf, lf_only))
s = raw.replace('\r\n', '\n')  # normalize in-memory; CRLF restored on write
lines = s.split('\n')

def L(n): return lines[n-1]
def span(a, b): return lines[a-1:b]
def chars(a, b): return len('\n'.join(span(a, b)))

# ---- boundary assertions (fail loudly, write nothing) ----
assert L(3).startswith('# 第1章'), L(3)
assert L(119) == '---', repr(L(119))
assert L(121).lstrip().startswith('*(由于篇幅限制'), L(121)[:20]
assert L(123) == '---'
assert L(125) == '### 本半章引用的笔记本资料来源编号索引：', L(125)
assert L(126).startswith('[63]')
assert L(187).startswith('[5] 90_判例合集1')
assert L(191).lstrip().startswith('💡')
assert L(195).startswith('# 第1章') and '（下）' in L(195)
assert L(362) == '## 本章小结要点'
assert L(372) == '## 本章证据边界'
assert L(385) == '### 本半章引用的笔记本资料来源编号索引：'
assert L(448).startswith('至此')
assert L(450).lstrip().startswith('💡')
assert L(455) == '《工程工期管理与延误索赔实战指南·2026版》', L(455)
assert L(457).startswith('# 第1章') and '（下）' in L(457)
assert L(459) == '---'
assert L(460) == ''
assert L(461).startswith('## 3.')
assert L(626) == '## 本章小结要点'
assert L(636) == '## 本章证据边界'
assert L(645).endswith('50]。'), L(645)[-10:]
assert L(647) == '---'
assert L(649) == '### 本半章引用的笔记本资料来源编号索引：'
assert L(650).startswith('- `[5]`')
assert L(695).startswith('- `[46]`')
assert L(699).startswith('至此')

# ---- assemble new document ----
seg1 = span(1, 119)      # 书名+章H1+导语+第1、2节 + ---
seg2 = span(460, 647)    # 后半B正文: ## 3 ... ## 本章证据边界 + ---
idx1 = span(126, 187)    # 前半 源索引条目 (编号体系A)
idx3 = span(650, 695)    # 后半B 源索引条目 (编号体系B)

out_lines = (seg1 + seg2 + ['']
             + ['### 本章引用的笔记本资料来源编号索引：', '']
             + ['**（第1—2节 引用编号体系）**', ''] + idx1 + ['']
             + ['**（第3—4节 引用编号体系）**', ''] + idx3 + [''])
out = '\n'.join(out_lines)

# ---- in-memory final-state checks before writing ----
def cjk(t): return len(re.findall('[一-鿿]', t))
checks = {
    '小结要点_h2': len(re.findall(r'^## 本章小结要点$', out, re.M)),
    '证据边界_h2': len(re.findall(r'^## 本章证据边界$', out, re.M)),
    '源索引类标题': len(re.findall(r'^#{1,6}[^\n]*来源编号索引', out, re.M)),
    '章H1数': len(re.findall(r'^# 第1章', out, re.M)),
}
residue = ['请回复', '输入"继续"', '「继续」', '至此结束', '至此，', '💡',
           '下一步建议', '后续建议', '后续\n', '我可以为您', '由我为您', '撰写完毕', '（下）']
residue = ['请回复', '「继续」', '至此结束', '至此，', '💡', '下一步建议',
           '后续建议', '我可以为您', '由我为您', '撰写完毕', '（下）']
for pat in residue:
    checks['残留:' + pat] = out.count(pat)

ok = (checks['小结要点_h2'] == 1 and checks['证据边界_h2'] == 1
      and checks['源索引类标题'] == 1 and checks['章H1数'] == 1
      and all(v == 0 for k, v in checks.items() if k.startswith('残留:')))
print(json.dumps(checks, ensure_ascii=False, indent=1))
assert ok, 'final-state check failed, nothing written'

# ---- removed-span accounting (old line ranges) ----
removed = [
    ('AI残留: 前半末尾「请回复继续」括注+多余分隔线', '120-123', chars(120, 123)),
    ('前半源索引原标题行(条目整体迁移至章末合并区)', '124-125', chars(124, 125)),
    ('AI残留: 💡回复「继续」输出后半部话术块', '188-192', chars(188, 192)),
    ('后半A劣版整段删除(第3/4节+小结+边界+索引#2+尾部残留, 与后半B重复)', '193-456', chars(193, 456)),
    ('后半B生成段包装头: 重复书名行已在193-456内, 含重复章H1「(下)」+悬挂分隔线', '457-459', chars(457, 459)),
    ('后半B源索引原标题行(条目保留, 并入章末合并区新标题)', '648-649', chars(648, 649)),
    ('AI残留: 「至此…全章完整初稿已全部撰写完毕」+尾部空行', '696-701', chars(696, 701)),
]
report = {
    'cjk_before': cjk(s),
    'cjk_after': cjk(out),
    'chars_before': len(s),
    'chars_after': len(out),
    'lines_before': len(lines),
    'lines_after': len(out_lines),
    'removed': removed,
    'added_heading_chars': len('### 本章引用的笔记本资料来源编号索引：') + len('**（第1—2节 引用编号体系）**') + len('**（第3—4节 引用编号体系）**') + 2,
}
print(json.dumps(report, ensure_ascii=False, indent=1))

out_disk = out.replace('\n', '\r\n') if crlf > 0 else out
open(P, 'w', encoding='utf-8', newline='').write(out_disk)
print('WRITTEN OK')
