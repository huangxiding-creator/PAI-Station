# -*- coding: utf-8 -*-
import re, io, os
d = os.path.dirname(os.path.abspath(__file__))
t = io.open(os.path.join(d, 'bank_ch12.md'), encoding='utf-8', errors='replace').read()
parts = re.split(r'(?m)^## (\S{6,16})\s*$', t)
kws = ['质量','保修','返修','修复','渗漏','裂缝','主体结构','地基','竣工验收','鉴定','重新鉴定','缺陷',
       '变更','签证','索赔','停工','窝工','工期','逾期','违约金','利息','损失',
       '结算','决算','审计','审价','送审','下浮','取费','定额','信息价','市场价',
       '无效','转包','分包','挂靠','资质','实际施工人','优先受偿','保证金','垫资','发票','税']
idx = io.open(os.path.join(d, 'bank_ch12.index.md'), encoding='utf-8', errors='replace').read()
case = {}
for line in idx.split('\n'):
    line = line.strip()
    if '|' in line and re.match(r'^[0-9a-f]{12}\|', line):
        f = line.split('|')
        case[f[0]] = f[1] + ' ' + f[4][:38]
rows = []
for i in range(1, len(parts), 2):
    aid = parts[i]
    body = parts[i+1] if i+1 < len(parts) else ''
    cjk = len(re.findall(r'[一-鿿]', body))
    hits = {k: body.count(k) for k in kws}
    rows.append((aid, cjk, hits))
for aid, cjk, hits in rows:
    top = sorted(hits.items(), key=lambda x: -x[1])[:10]
    top = ' '.join('%s:%d' % (k, v) for k, v in top if v > 0)
    print('%s cjk=%d %s' % (aid, cjk, top))
    print('    %s' % case.get(aid, '?'))
