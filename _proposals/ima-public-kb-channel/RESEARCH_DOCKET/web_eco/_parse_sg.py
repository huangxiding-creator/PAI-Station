import re
import html
import sys

for f in sys.argv[1:]:
    print('=====', f.split('/')[-1])
    raw = open(f, encoding='utf-8', errors='ignore').read()
    if 'antispider' in raw:
        print('  CAPTCHA WALL')
        continue
    items = re.split(r'<div class="txt-box">', raw)[1:]
    print('  items:', len(items))
    for it in items[:10]:
        tm = re.search(r'<a[^>]*href="(/link\?url=[^"]+)"[^>]*>(.*?)</a>', it, re.S)
        if not tm:
            continue
        ti = html.unescape(re.sub(r'<!--.*?-->|<[^>]+>', '', tm.group(2))).strip()
        ps = re.search(r'<p[^>]*>(.*?)</p>', it, re.S)
        snip = html.unescape(re.sub(r'<[^>]+>', '', ps.group(1))).strip() if ps else ''
        acc = re.search(r'account_name[^>]*>([^<]+)<|<a[^>]*uigs="article_account_\d+"[^>]*>(.*?)</a>', it, re.S)
        account = ''
        if acc:
            account = html.unescape(re.sub(r'<[^>]+>', '', acc.group(1) or acc.group(2))).strip()
        dt = re.search(r'(\d{4}-\d{2}-\d{2})', it)
        print('  T:', ti[:90])
        print('  A:', account[:40], '| D:', dt.group(1) if dt else '?', '| S:', snip[:130])
        print('  -')
