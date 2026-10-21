# -*- coding: utf-8 -*-
import re, io

P = r'sched/nblm_out/ch01_编辑稿.md'
t = io.open(P, encoding='utf-8', newline='').read().lstrip('﻿')
s = t.replace('\r\n', '\n')

print('cjk_basic(U+4E00-9FFF):', len(re.findall('[一-鿿]', s)))
print('cjk_incl_extA:', len(re.findall('[一-鿿㐀-䶿]', s)))
print('lines:', s.count('\n') + 1)

cite = re.compile(r'\[\d+(?:\s*[,，\-–]\s*\d+)*\]')
allc = cite.findall(s)
print('total [N] tokens:', len(allc))

head, idx = s.split('### 本章引用的笔记本资料来源编号索引')
print('body [N] tokens:', len(cite.findall(head)))
print('index [N]-lead entries:', len(re.findall(r'^\s*-?\s*`?\[\d+\]', idx, re.M)))
print('zhangH1:', len(re.findall(r'^# 第1章', s, re.M)))

for h in ['## 本章小结要点', '## 本章证据边界', '### 1.1 现金流视角下的工期逻辑',
          '### 2.2 技术与商务割裂', '### 3.3 现金流止损的4步可执行操作规程',
          '### 4.2 《工期延误索赔全过程证据链汇编清单》']:
    print('count[%s]:' % h[:18], len(re.findall('^' + re.escape(h) + r'\s*$', s, re.M)))

# five sample sentence-end citations with line numbers
lines = s.split('\n')
shown = 0
for i, ln in enumerate(lines, 1):
    m = re.search(r'\[\d+(?:\s*[,，\-–]\s*\d+)*\]\s*$', ln.rstrip('。；;. ') or ln)
    if m and shown < 5:
        print('sample_end_cite L%d: ...%s' % (i, m.group(0)))
        shown += 1
