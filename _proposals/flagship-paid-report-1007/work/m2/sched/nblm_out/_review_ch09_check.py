# -*- coding: utf-8 -*-
"""ch09 编辑稿 零容忍复核（_review_ch01_check.py 同例扩展）"""
import re, io

P = r'e:/AI-Station/_proposals/flagship-paid-report-1007/work/m2/sched/nblm_out/ch09_编辑稿.md'
t = io.open(P, encoding='utf-8', newline='').read().lstrip('﻿')
s = t.replace('\r\n', '\n')
lines = s.split('\n')

# ---- 0) 规模 ----
print('lines:', len(lines), 'chars:', len(s))
print('cjk_basic(U+4E00-9FFF):', len(re.findall('[一-鿿]', s)))

# ---- 1) 全列标题 + 专项标题计数 ----
print('---- HEADINGS ----')
for i, ln in enumerate(lines, 1):
    if ln.startswith('#'):
        print('L%03d %s' % (i, ln[:60]))
h = lambda pat: len(re.findall(r'^#{1,6}[^\n]*' + pat, s, re.M))
print('小结要点标题数:', h('小结要点'))
print('证据边界标题数:', h('证据边界'))
print('源引用对照类标题数:', h('源引用对照'))

# ---- 2) 残留扫描（行号级） ----
print('---- RESIDUE ----')
for pat in ['继续', '至此结束', '下一步建议', '下一阶段建议', '我可以为您', 'losses', 'monthly',
            'LSTM', 'lstm', 'Losses', 'Monthly', '请回复', '前半部分', '笔记本', '（上）', '（下）',
            '后续跟进', '延伸应用', '💡']:
    hits = [(i, ln.strip()[:60]) for i, ln in enumerate(lines, 1) if pat in ln]
    if hits:
        print('PAT[%s] x%d:' % (pat, len(hits)), hits[:6])

# ---- 3) 小节标题两版并存抽查（含全量节标题计数） ----
print('---- SECTION TITLE COUNTS ----')
for pat in ['### 第一节 ', '### 第二节 ', '### 第三节 ', '### 第四节 ', '### 第五节 ', '### 第六节 ', '### 第七节 ']:
    print('count[%s]:' % pat.strip(), len(re.findall('^' + re.escape(pat.strip()) + r'[^\n]*$', s, re.M)))
for pat in ['#### 4.2 ', '#### 4.4 ', '#### 规则一', '#### 规则十']:
    print('count[%s]:' % pat.strip(), len(re.findall('^' + re.escape(pat.strip()) + r'[^\n]*$', s, re.M)))

# ---- 4) 句末[N]引用抽样(5处) + 章末源引用对照清单 ----
print('---- SENTENCE-END [N] SAMPLES ----')
cite = re.compile(r'\[\d+(?:\s*[,，\-–]\s*\d+)*\]')
shown = 0
for i, ln in enumerate(lines, 1):
    stripped = ln.rstrip('。；;. \t')
    m = re.search(r'\[\d+(?:\s*[,，\-–]\s*\d+)*\]$', stripped)
    if m and shown < 5:
        print('sample_end_cite L%d: ...%s' % (i, m.group(0)))
        shown += 1
print('total [N] tokens:', len(cite.findall(s)))
m = re.search(r'^### 《源引用对照》清单\s*$', s, re.M)
print('章末源引用对照标题在:', (s[:m.start()].count('\n') + 1) if m else 'MISSING')
if m:
    idx = s[m.end():]
    print('清单条目数:', len(re.findall(r'^\s*\d+\.\s+\*\*\[', idx, re.M)))

# ---- 5) CJK 计数 ----
print('---- CJK ----')
print('cjk_final:', len(re.findall('[一-鿿]', s)))
