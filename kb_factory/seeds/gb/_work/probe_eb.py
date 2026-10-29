# -*- coding: utf-8 -*-
"""eBiaozhun 链探针：关键词搜索是否可用 + 单件三步链(search->detail->paystatus)通不通.
只读不落盘, 不写 manifest."""
import re, sys, io
try:
    if sys.stdout.encoding and sys.stdout.encoding.lower() != 'utf-8':
        sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', errors='replace')
except Exception:
    pass
import requests

BASE = 'https://www.ebiaozhun.com'
UA = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0 Safari/537.36'
# 直连 Cloudflare 前置超时(1024实测), 走本机 7893 出口
PROX = {'http': 'http://127.0.0.1:7893', 'https': 'http://127.0.0.1:7893'}
s = requests.Session(); s.headers.update({'User-Agent': UA}); s.proxies.update(PROX)

def search(q):
    r = s.get(BASE + '/search.html', params={'q': q}, timeout=60)
    print('search q=%r HTTP %d len=%d' % (q, r.status_code, len(r.text)))
    pairs = re.findall(r'<a[^>]+href="/std/([0-9a-f]+)\.html"[^>]*>(.*?)</a>', r.text, re.DOTALL)
    print('  std links:', len(pairs))
    for h, t in pairs[:8]:
        print('   ', h[:12], re.sub(r'<[^>]+>', '', t).strip()[:60])
    return pairs

pairs = search('混凝土')

if pairs:
    h = pairs[0][0]
    r2 = s.get(BASE + '/std/%s.html' % h, timeout=60)
    m = re.search(r'var\s+pid\s*=\s*(\d+)\s*;', r2.text)
    title = re.search(r'<title>(.*?)</title>', r2.text, re.DOTALL)
    price = re.search(r'下载文档需要支付\s*<span[^>]*>(\d+)</span>\s*金币', r2.text)
    print('detail HTTP %d pid=%s price=%s title=%s' % (
        r2.status_code, m.group(1) if m else None,
        price.group(1) if price else '?',
        re.sub(r'<[^>]+>', '', title.group(1))[:60] if title else '?'))
    if m:
        pid = m.group(1)
        r3 = s.get(BASE + '/matrix/order/paystatus', params={'type': 'doc', 'pid': pid},
                   headers={'Referer': BASE + '/std/%s.html' % h,
                            'X-Requested-With': 'XMLHttpRequest',
                            'Accept': 'application/json, text/javascript, */*; q=0.01'},
                   timeout=60)
        print('paystatus HTTP %d body=%s' % (r3.status_code, r3.text[:300]))
print('PROBE_EB DONE')
