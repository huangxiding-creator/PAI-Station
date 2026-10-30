# -*- coding: utf-8 -*-
import re, sys, io
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', errors='replace')
d = r'E:\AI-Station\_proposals\flagship-paid-report-1007\work\m2\jiage\sched\_ch02_p1.md'
bankf = r'E:\AI-Station\_proposals\flagship-paid-report-1007\work\m2\jiage\sched\bank_ch02.md'
t = open(d, encoding='utf-8').read()
bank = open(bankf, encoding='utf-8').read()

# 1) citation anchors
anchors_used = {}
for m in re.finditer(r'\[来源:\s*([^\]]+)\]', t):
    for a in re.findall(r'P\d{6}', m.group(1)):
        anchors_used[a] = anchors_used.get(a, 0) + 1
anchors_in_bank = set(re.findall(r'^## (P\d{6})', bank, re.M))
print('distinct anchors used:', len(anchors_used))
for a, n in sorted(anchors_used.items()):
    status = 'IN-BANK' if a in anchors_in_bank else '*** NOT-IN-BANK ***'
    print(f'  {a} x{n} {status}')
bad = [a for a in anchors_used if a not in anchors_in_bank]
print('bad anchors:', bad if bad else 'none')

# 2) banned/tech terms + AI mention
for w in ['AI', '人工智能', '大模型', 'GPT', 'API', '接口', '爬虫', '脚本', '算法', 'OCR', '语料', '底料库' , '服务器', '数据库', '数字化']:
    hits = [t.count(w)]
    if hits[0]:
        # show contexts
        ctxs = [t[max(0,m.start()-18):m.end()+18].replace('\n',' ') for m in re.finditer(re.escape(w), t)]
        print(f'TERM {w}: {hits[0]} -> ' + ' | '.join(ctxs[:6]))

# 3) final counts
cjk = len(re.findall(r'[\u4e00-\u9fff\u3400-\u4dbf]', t))
total = len(t)
print('CJK:', cjk, '| total chars:', total, '| lines:', t.count(chr(10))+1)
print('tail:', repr(t[-40:]))
