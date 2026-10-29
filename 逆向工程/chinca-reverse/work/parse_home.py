# -*- coding: utf-8 -*-
"""Parse passed homepage: nav columns + article URL patterns."""
import io, json, re, sys
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', errors='replace')

html = open(r'E:\AI-Station\逆向工程\chinca-reverse\captures\_p8_g1_passed.html', encoding='utf-8').read()
print('title:', re.search(r'<title>(.*?)</title>', html, re.S).group(1))

# all hrefs with counts
from collections import Counter
hrefs = re.findall(r'href="([^"]+)"', html)
pref = Counter()
for h in hrefs:
    m = re.match(r'^(/[A-Za-z]+/)', h)
    if m: pref[m.group(1)] += 1
print('path prefixes:', dict(pref.most_common(12)))

# column-ish links (list pages)
cols = Counter()
for h in hrefs:
    if re.search(r'/(list|channel|column|news|zhengce|shuju|enr)', h, re.I):
        cols[h] += 1
for h, c in list(cols.items())[:30]:
    print(c, h)

# nav menu block
nav = re.findall(r'<a[^>]+href="(/[^"]*(?:list|column)[^"]*)"[^>]*>([^<]{2,20})</a>', html)
print('nav:', nav[:20])

# info article ids
ids = re.findall(r'/CICA/info/(\d+)', html)
print('CICA/info count:', len(ids), 'sample:', ids[:5])

# look for typical column names in text
for kw in ['新闻', '政策', '数据', 'ENR', '榜单', '通知公告', '行业动态', '商会动态']:
    found = re.findall(r'href="([^"]+)"[^>]*>[^<]*' + kw, html)
    print(kw, '->', found[:4])
