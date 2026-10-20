# -*- coding: utf-8 -*-
import sys, io, re, html
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', errors='replace')
from urllib.parse import quote_plus, unquote
from curl_cffi import requests
H={'Accept-Language':'zh-CN,zh;q=0.9'}
q=sys.argv[1]
def sogou():
    u='https://www.sogou.com/web?query='+quote_plus(q)
    r=requests.get(u,impersonate='chrome',headers={**H,'Referer':'https://www.sogou.com/'},timeout=25)
    if '验证码' in r.text or 'antispider' in r.url: return []
    out=[]
    for m in re.finditer(r'<h3[^>]*>\s*<a[^>]+href="(/link\?url=[^"]+|https?://[^"]+)"[^>]*>(.*?)</a>',r.text,re.S):
        t=re.sub(r'<[^>]+>','',m.group(2)).strip(); u2=m.group(1)
        if u2.startswith('/link'): u2='https://www.sogou.com'+u2
        if t: out.append((t,html.unescape(u2)))
    return out
def so():
    r=requests.get('https://www.so.com/s?q='+quote_plus(q),impersonate='chrome',headers=H,timeout=25)
    out=[]
    for m in re.finditer(r'<a[^>]+data-mdurl="([^"]+)"[^>]*>(.*?)</a>',r.text,re.S):
        t=re.sub(r'<[^>]+>','',m.group(2)).strip()
        if t: out.append((t,m.group(1)))
    if not out:
        for m in re.finditer(r'<h3[^>]*class="res-title[^"]*"[^>]*>\s*<a[^>]+href="([^"]+)"[^>]*>(.*?)</a>',r.text,re.S):
            t=re.sub(r'<[^>]+>','',m.group(2)).strip()
            if t: out.append((t,m.group(1)))
    return out
def bing():
    r=requests.get('https://www.bing.com/search?q='+quote_plus(q)+'&mkt=zh-CN&setlang=zh-CN',impersonate='chrome',headers={**H,'Referer':'https://www.bing.com/'},timeout=25)
    out=[]
    for m in re.finditer(r'<h2><a[^>]+href="(https?://[^"]+)"[^>]*>(.*?)</a></h2>',r.text,re.S):
        t=re.sub(r'<[^>]+>','',m.group(2)).strip()
        if t: out.append((t,html.unescape(m.group(1))))
    return out
for name,fn in [('sogou',sogou),('so360',so),('bing',bing)]:
    try:
        res=fn()
        print(f'[{name}] {len(res)}')
        for t,u in res[:9]: print('-',t,'|',u[:150])
    except Exception as e:
        print(f'[{name}] ERR',repr(e)[:100])
