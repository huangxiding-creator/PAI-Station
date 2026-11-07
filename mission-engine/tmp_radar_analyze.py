# -*- coding: utf-8 -*-
"""RadarCycle 轻量轮全量分析: 全史底账 + 近3h窗口加倍权重 + JTBD四步"""
import json, re, sys
from datetime import datetime, timedelta
from collections import Counter, defaultdict

NOW = datetime.now()
sig = []
with open('ledger/signals.jsonl', encoding='utf-8') as f:
    for line in f:
        line = line.strip()
        if not line:
            continue
        try:
            e = json.loads(line)
            if 'signal' in e:
                sig.append(e)
        except Exception:
            pass

def ts_of(e):
    t = e['signal'].get('ts') or e.get('ingested_at')
    try:
        return datetime.strptime(t, '%Y-%m-%d %H:%M:%S')
    except Exception:
        return None

def text_of(e):
    p = e['signal'].get('payload', {}) or {}
    for k in ('quote', 'text', 'title', 'content', 'summary', 'name'):
        if p.get(k):
            return str(p[k])
    return ''

print('=== 全史总量:', len(sig), '===')
c = Counter(e['signal'].get('source_type', '?') for e in sig)
for k, v in c.most_common():
    print(f'  {k}: {v}')

w3 = [e for e in sig if ts_of(e) and (NOW - ts_of(e)).total_seconds() < 3 * 3600]
w24 = [e for e in sig if ts_of(e) and (NOW - ts_of(e)).total_seconds() < 24 * 3600]
print(f'窗口: 3h={len(w3)}  24h={len(w24)}')
print('3h来源分布:', dict(Counter(e["signal"].get("source_type", "?") for e in w3)))

print('\n=== 近3h信号明细 ===')
for e in sorted(w3, key=lambda x: x.get('seq', 0)):
    s = e['signal']
    print(f"[{s.get('ts','')}] {s.get('source_type','')} | {text_of(e)[:110]}")

# 近7天主题词频(全史底账画像)
week = [e for e in sig if ts_of(e) and (NOW - ts_of(e)).total_seconds() < 7 * 86400]
STOP = set('的了和是在有对与及或等中为到说要在这个我们他们它也会就被可以把那个你我很还会不不上没但因此如果因为所以而且不过只是这样怎么什么这个那些一下一样一些进行通过关于以及目前最近'.split() + ['一个', '没有', '就是', '这个', '那个', '可以', '什么', '怎么'])
kw = Counter()
for e in week:
    for w in re.findall(r'[一-龥]{2,6}', text_of(e)):
        if w not in STOP:
            kw[w] += 1
print('\n=== 近7天高频词TOP40 ===')
for k, v in kw.most_common(40):
    print(f'  {k}: {v}')
