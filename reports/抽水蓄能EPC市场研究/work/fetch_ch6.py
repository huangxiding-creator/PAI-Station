# -*- coding: utf-8 -*-
"""第6章资料核读抓取器: DDG检索 + 页面正文提取(代理可选)"""
import sys, re, urllib.parse as up
from curl_cffi import requests

PROXY = {'http': 'http://127.0.0.1:7890', 'https': 'http://127.0.0.1:7890'}

def get(url, use_proxy=False, timeout=25):
    p = PROXY if use_proxy else None
    r = requests.get(url, impersonate='chrome', timeout=timeout, proxies=p)
    raw = r.content
    # charset sniff
    m = re.search(rb'charset=["\']?([\w-]+)', raw[:2000])
    enc = m.group(1).decode() if m else 'utf-8'
    try:
        return raw.decode(enc, 'ignore')
    except Exception:
        return raw.decode('utf-8', 'ignore')

def text_of(html):
    html = re.sub(r'<(script|style)[\s\S]*?</\1>', ' ', html, flags=re.I)
    txt = re.sub(r'<[^>]+>', ' ', html)
    txt = re.sub(r'&nbsp;?', ' ', txt)
    txt = re.sub(r'\s+', ' ', txt)
    return txt

def ddg(q, n=10):
    t = get('https://html.duckduckgo.com/html/?q=' + up.quote(q), use_proxy=True)
    out = []
    for m in re.finditer(r'result__a" href="([^"]+)"[^>]*>(.*?)</a>', t):
        u = m.group(1); title = re.sub(r'<[^>]+>', '', m.group(2))
        real = up.unquote(u.split('uddg=')[1].split('&')[0]) if 'uddg=' in u else u
        out.append((real, title))
        if len(out) >= n:
            break
    return out

if __name__ == '__main__':
    mode = sys.argv[1]
    if mode == 'search':
        for u, t in ddg(sys.argv[2]):
            print(u[:150], '|', t[:80])
    elif mode == 'read':
        url = sys.argv[2]
        use_proxy = '--proxy' in sys.argv
        txt = text_of(get(url, use_proxy=use_proxy))
        kw = [k for k in sys.argv[3:] if not k.startswith('--')]
        if kw:
            # print sentences containing keywords, else full text head
            sents = re.split(r'(?<=[。！？；])', txt)
            shown = 0
            for s in sents:
                if any(k in s for k in kw):
                    print(s.strip()[:400])
                    shown += 1
                    if shown > 120:
                        break
            if shown == 0:
                print('[no keyword hit, head dump]', txt[:1500])
        else:
            print(txt[:4000])
