# -*- coding: utf-8 -*-
import json,re,ast,sys
import urllib.parse as up
sys.stdout.reconfigure(encoding='utf-8')
B=r'E:/AI-Station/reforge_factory'; S=B+'/channels_survey_2026'
src=open(S+'/_integrate_round2_1025.py',encoding='utf-8').read()
ns={'__file__': S+'/_integrate_round2_1025.py','__name__':'integ_head'}
exec(compile(src.split('def main(')[0],'integ','exec'),ns)
entry_id=ns['entry_id']
reg=json.load(open(S+'/MASTER_REGISTRY.json',encoding='utf-8'))
plan=json.load(open(S+'/btier_plan.json',encoding='utf-8'))
be=[e for e in reg['entries'] if e.get('tier')=='B']
used=set(); bids=[entry_id(e,used) for e in be]
cm=ast.parse(open(B+'/completeness/channel_matrix.py',encoding='utf-8').read())
sa={};ca={}
def grab(node):
    for t in ([node.target] if hasattr(node,'target') else node.targets):
        if isinstance(t,ast.Name):
            if t.id=='SURVEY_ALIASES': return 'SA',ast.literal_eval(node.value)
            if t.id=='CHANNEL_ALIASES': return 'CA',ast.literal_eval(node.value)
    return None,None
for node in cm.body:
    if isinstance(node,(ast.Assign,ast.AnnAssign)):
        k,v=grab(node)
        if k=='SA': sa=v
        if k=='CA': ca=v
merged={k:list(v) for k,v in ca.items()}
for k,v in sa.items():
    merged.setdefault(k,[])
    for a in v:
        if a not in merged[k]: merged[k].append(a)
allalias={}
for k,v in merged.items():
    for a in v: allalias.setdefault(str(a).lower(),k)
print('SA keys:',len(sa),'CA keys:',len(ca),'merged:',len(merged))
print('B ids in SA:',sum(1 for i in bids if i in sa),'| in merged:',sum(1 for i in bids if i in merged))
# register ledger LIT detail
reg_led=open(S+'/btier_register_ledger.md',encoding='utf-8').read()
def sec(txt,a,b):
    i=txt.find(a); j=txt.find(b); return txt[i:j] if i>=0 and j>i else txt[i:]
lit=[]
for ln in sec(reg_led,'## A. ','## B. ').splitlines():
    m=re.match(r'^\|\s*(\d+)\s*\|\s*([^|]+?)\s*\|\s*(https?://[^|\s]+)',ln)
    if m: lit.append((int(m.group(1)),m.group(2).strip(),m.group(3)))
hosts=[]
for i,n,u in lit:
    h=up.urlparse(u).netloc.lower(); h=h[4:] if h.startswith('www.') else h
    hosts.append((i,n,u,h))
uh=set(h for _,_,_,h in hosts)
print('LIT rows:',len(lit),'unique hosts:',len(uh),'unique names:',len(set(n for _,n,_ in lit)))
miss=[(i,n,bids[i],h) for i,n,u,h in hosts if bids[i] not in merged]
print('LIT ids missing from merged map:',len(miss))
for x in miss: print('  MISS',x)
dommiss=[(i,n,h) for i,n,u,h in hosts if h not in allalias]
print('LIT hosts not found as any alias value:',len(dommiss))
for x in dommiss: print('  DOMMISS',x)
# freekey engines
fk=open(S+'/btier_freekey_ledger.md',encoding='utf-8').read()
engines=['ecb_sdw','courtlistener_recap','nasa_images','open_canada','compras_gov_br_pncp','noaa_nws','hn_algolia_api']
for eng in engines:
    print('FK',eng,'key:',eng in merged,'alias_of:',allalias.get(eng))
# registry candidates for the 7 engines (search names/urls)
kw={'ecb_sdw':['sdw','ecb'],'courtlistener_recap':['courtlistener'],'nasa_images':['nasa'],'open_canada':['canada'],'compras_gov_br_pncp':['pncp','compras'],'noaa_nws':['nws','weather.gov','noaa'],'hn_algolia_api':['hn','algolia']}
for eng,ks in kw.items():
    hits=[]
    for e in reg['entries']:
        blob=(e.get('name','')+' '+str(e.get('entry',''))+' '+e.get('dedup_key','')).lower()
        if any(k in blob for k in ks): hits.append((entry_id(e,set()),e.get('tier'),e.get('name','')[:40]))
    hits=hits[:6]
    print('CAND',eng,'->',hits)
# user actions proper parse
uafk=[]
for ln in sec(fk,'## ③ ','## ④ ').splitlines():
    m=re.match(r'^\|\s*(\d+)\s*\|\s*([^|]+?)\s*\|\s*([^|]+?)\s*\|\s*([^|]+?)\s*\|',ln)
    if m: uafk.append((m.group(2).strip(),m.group(3).strip(),m.group(4).strip()))
uareg=[]
for ln in sec(reg_led,'## B. ','## C. ').splitlines():
    m=re.match(r'^\|\s*(\d+)\s*\|\s*([^|]+?)\s*\|\s*(https?://[^|\s]+)',ln)
    if m: uareg.append((int(m.group(1)),m.group(2).strip()))
def norm(n):
    n=re.sub(r'\(.*?\)','',n); n=re.sub(r'[^0-9a-z\u4e00-\u9fff]+',' ',n.lower()).strip()
    return n
fkn={norm(n):(n,a,u) for n,a,u in uafk}
regn={norm(n):(i,n) for i,n in uareg}
both=sorted(set(fkn)&set(regn))
print('FK UA rows:',len(uafk),'REG UA rows:',len(uareg),'| name-normalized intersection:',both)
planidx_fk=set()
for n,a,u in uafk:
    for m in re.finditer(r'(\d+)',n.split('(')[-1]): planidx_fk.add(int(m.group(1)))
print('FK UA plan-idx count:',len(planidx_fk),'| REG UA plan-idx count:',len({i for i,_ in uareg}),'| idx intersection:',sorted(planidx_fk & {i for i,_ in uareg}))
