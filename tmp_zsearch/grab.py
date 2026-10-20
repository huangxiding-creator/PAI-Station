# -*- coding: utf-8 -*-
import sys, io, re
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', errors='replace')
from curl_cffi import requests
u=sys.argv[1]
kw=sys.argv[2] if len(sys.argv)>2 else ''
r=requests.get(u,impersonate='chrome',headers={'Accept-Language':'zh-CN,zh;q=0.9'},timeout=30)
txt=re.sub(r'<script.*?</script>','',r.text,flags=re.S)
txt=re.sub(r'<style.*?</style>','',txt,flags=re.S)
txt=re.sub(r'<[^>]+>',' ',txt)
txt=re.sub(r'&nbsp;',' ',txt); txt=re.sub(r'\s+',' ',txt)
print('LEN',len(txt))
if kw:
    for m in re.finditer(re.escape(kw),txt):
        s=max(0,m.start()-250); print('...',txt[s:m.start()+450],'...\n---')
        break
else:
    print(txt[:4500])
