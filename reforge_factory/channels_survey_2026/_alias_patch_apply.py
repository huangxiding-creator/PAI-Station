# -*- coding: utf-8 -*-
import re,ast,shutil,sys,py_compile
sys.stdout.reconfigure(encoding='utf-8')
p=r'E:/AI-Station/reforge_factory/completeness/channel_matrix.py'
bak=p+'.bak-1026-btotal-final'
import os
if not os.path.exists(bak): shutil.copy2(p,bak); print('BAK created:',bak)
txt=open(p,encoding='utf-8').read()
# locate SURVEY_ALIASES dict literal span
m=re.search(r'SURVEY_ALIASES(?::\s*dict\[str,\s*list\[str\]\])?\s*=\s*\{',txt)
start=m.end()-1  # at '{'
depth=0; i=start
while i<len(txt):
    if txt[i]=='{':depth+=1
    elif txt[i]=='}':
        depth-=1
        if depth==0: break
    i+=1
end=i  # index of closing '}'
sa_block=txt[start:end+1]
adds=[('mojeek','mojeek.com'),('360_360ai','so.com'),('4get','4get.ca'),('bing','bing.com'),('boardreader','boardreader.com'),('google','google.com'),('google_scholar','scholar.google.com'),('google_trends','trends.google.com'),('mwmbl','mwmbl.org'),('qwant','qwant.com'),('rsshub','docs.rsshub.app'),('startpage','startpage.com'),('stract','stract.com'),('swisscows','swisscows.com'),('teclis','teclis.com'),('yandex','yandex.com'),('ai','tiangong.cn'),('so_toutiao_com','so.toutiao.com'),('news_baidu_com','news.baidu.com')]
nb=sa_block; okc=0
for key,dom in adds:
    pat=re.compile(r'(\n\s+"'+re.escape(key)+r'": \[)([^\]]*)(\])')
    mm=pat.search(nb)
    if not mm: print('NOT FOUND:',key); continue
    inner=mm.group(2)
    if '"'+dom+'"' in inner: print('ALREADY:',key); continue
    newinner=(inner+', ' if inner.strip() else '')+'"'+dom+'"'
    nb=nb[:mm.start()]+mm.group(1)+newinner+mm.group(3)+nb[mm.end():]
    okc+=1
print('domain aliases inserted:',okc)
new_entries=(
'\n    #: ---- 1026 B级接入终账·点亮渠道别名补同步 (只增; 依据 btier_freekey_ledger.md / btier_register_ledger.md 实测点亮面):\n'
'    #: 上方 19 条为免费注册波点亮站点域名别名补齐 (键已存在, 域名别名缺失; 碰撞检查零冲突)。\n'
'    #: 下 2 条为免费钥波点亮引擎补录 — 注册表无独立条目, 按「引擎id=渠道id」惯例新建, 使入池 engine 标签直落渠道。\n'
'    "nasa_images": ["nasa images", "images-api.nasa.gov"],  # 免费钥波LIT·NASA Image and Video Library API (registry仅nasa_firms, 本面独立)\n'
'    "noaa_nws": ["noaa nws", "api.weather.gov", "weather.gov"],  # 免费钥波LIT·NOAA NWS 官方面 (ncei检索面400停用疑, 如实分流)\n'
)
# insert before closing brace, keeping prior last entry's trailing comma
nb2=nb[:len(nb)-1].rstrip('\n')
if not nb2.rstrip().endswith(','): nb2=nb2+','
nb2=nb2+'\n'+new_entries.strip('\n')+'\n}'
txt2=txt[:start]+nb2+txt[end+1:]
open(p,'w',encoding='utf-8',newline='').write(txt2)
print('written')
# verify
cm=ast.parse(open(p,encoding='utf-8').read())
sa={}
for node in cm.body:
    if not isinstance(node,(ast.Assign,ast.AnnAssign)): continue
    tg=[node.target] if isinstance(node,ast.AnnAssign) else node.targets
    for t in tg:
        if isinstance(t,ast.Name) and t.id=='SURVEY_ALIASES': sa=ast.literal_eval(node.value)
print('SA keys now:',len(sa),'| nasa_images:','nasa_images' in sa,'| noaa_nws:','noaa_nws' in sa)
for k,d in [('mojeek','mojeek.com'),('ai','tiangong.cn'),('bing','bing.com')]:
    print(' check',k,'→',d in sa.get(k,[]))
py_compile.compile(p,doraise=True); print('py_compile OK')
