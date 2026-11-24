# -*- coding: utf-8 -*-
import re, io, os
d = os.path.dirname(os.path.abspath(__file__))
t = io.open(os.path.join(d, 'bank_ch02.md'), encoding='utf-8', errors='replace').read()
parts = re.split(r'(?m)^## (\S{6,16})\s*$', t)
kws = ['签证','变更','指令','确认','工程量','会议纪要','口头','监理','联系单','洽商','签收','签章','签字','补签','追认','默示','视为','工程洽商','设计变更','增加工程','实际发生','施工范围','范围外','增量','价款调整']
rows = []
for i in range(1, len(parts), 2):
    aid = parts[i]
    body = parts[i+1] if i+1 < len(parts) else ''
    cjk = len(re.findall(r'[一-鿿]', body))
    hits = {k: body.count(k) for k in kws}
    score = (hits.get('签证',0)*3 + hits.get('变更',0) + hits.get('指令',0)*2
             + hits.get('确认',0) + hits.get('工程量',0)*2 + hits.get('会议纪要',0)*2
             + hits.get('口头',0)*2 + hits.get('洽商',0)*3 + hits.get('联系单',0)*3
             + hits.get('监理',0) + hits.get('补签',0)*3 + hits.get('追认',0)*3
             + hits.get('默示',0)*3 + hits.get('视为',0) + hits.get('设计变更',0)*2)
    rows.append((score, aid, cjk, hits))
rows.sort(reverse=True)
for score, aid, cjk, hits in rows:
    top = sorted(hits.items(), key=lambda x: -x[1])[:8]
    top = ' '.join('%s:%d' % (k, v) for k, v in top if v > 0)
    print('%s score=%d cjk=%d | %s' % (aid, score, cjk, top))
