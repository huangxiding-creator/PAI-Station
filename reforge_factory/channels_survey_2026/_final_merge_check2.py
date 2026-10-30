# -*- coding: utf-8 -*-
import json,re,ast,sys
sys.stdout.reconfigure(encoding='utf-8')
B=r'E:/AI-Station/reforge_factory'
S=B+'/channels_survey_2026'
# --- reuse integration script logic (constants + funcs only, no main) ---
src=open(S+'/_integrate_round2_1025.py',encoding='utf-8').read()
head=src.split('def main(')[0]
ns={'__file__': r'E:/AI-Station/reforge_factory/channels_survey_2026/_integrate_round2_1025.py', '__name__':'integ_head'}; exec(compile(head,'integ','exec'),ns)
slugify,entry_id,STOP,LEG_OVERRIDES=ns['slugify'],ns['entry_id'],ns['STOP'],ns['LEG_OVERRIDES']
# --- data ---
reg=json.load(open(S+'/MASTER_REGISTRY.json',encoding='utf-8'))
plan=json.load(open(S+'/btier_plan.json',encoding='utf-8'))
be=[e for e in reg['entries'] if e.get('tier')=='B']
used=set(); bids=[entry_id(e,used) for e in be]
# --- channel_matrix aliases via ast ---
cm=ast.parse(open(B+'/completeness/channel_matrix.py',encoding='utf-8').read())
sa={};ca={}
for node in cm.body:
    if isinstance(node,ast.Assign) and isinstance(node.value,ast.Dict):
        for t in node.targets:
            if isinstance(t,ast.Name) and t.id=='SURVEY_ALIASES': sa=ast.literal_eval(node.value)
            if isinstance(t,ast.Name) and t.id=='CHANNEL_ALIASES': ca=ast.literal_eval(node.value)
merged=dict((k,list(v)) for k,v in ca.items())
for k,v in sa.items():
    merged.setdefault(k,[])
    for a in v:
        if a not in merged[k]: merged[k].append(a)
allalias={}
for k,v in merged.items():
    for a in v: allalias.setdefault(a.lower(),k)
print('SURVEY_ALIASES keys:',len(sa),'| CHANNEL_ALIASES keys:',len(ca),'| merged keys:',len(merged))
bids_in_sa=[i for i in bids if i in merged]
print('B-tier registry ids present in merged alias map:',len(bids_in_sa),'/',len(bids))
# --- parse register ledger LIT + USER_ACTION ---
reg_led=open(S+'/btier_register_ledger.md',encoding='utf-8').read()
def section(txt,a,b):
    i=txt.find(a); j=txt.find(b); return txt[i:j] if i>=0 and j>i else txt[i:]
secA=section(reg_led,'## A. ','## B. ')
secB=section(reg_led,'## B. ','## C. ')
lit_rows=[]
for ln in secA.splitlines():
    m=re.match(r'^\|\s*(\d+)\s*\|\s*([^|]+?)\s*\|\s*(https?://[^|\s]+)',ln)
    if m: lit_rows.append((int(m.group(1)),m.group(2).strip(),m.group(3)))
ua_rows=[]
for ln in secB.splitlines():
    m=re.match(r'^\|\s*(\d+)\s*\|\s*([^|]+?)\s*\|',ln)
    if m: ua_rows.append((int(m.group(1)),m.group(2).strip()))
names=[n for _,n,_ in lit_rows]
uniq=set(names)
print('register LIT rows:',len(lit_rows),'unique names:',len(uniq))
print('register USER_ACTION rows:',len(ua_rows))
dups=[n for n in uniq if names.count(n)>1]
print('dup LIT names:',dups)
# idx-based LIT coverage in alias map
miss_lit=[]
for idx,n,u in lit_rows:
    bid=bids[idx] if idx<len(bids) else '?'
    okk= bid in merged or bid in sa
    if not okk: miss_lit.append((idx,n,bid))
print('register LIT missing alias key:',len(miss_lit))
for x in miss_lit[:15]: print('  MISS',x)
# also check site domain alias presence for lit
import urllib.parse as up
miss_dom=[]
for idx,n,u in lit_rows:
    bid=bids[idx] if idx<len(bids) else ''
    host=up.urlparse(u).netloc.lower(); host=host[4:] if host.startswith('www.') else host
    has=host and (host in allalias or any(host==a or host in str(merged.get(bid,[])) for a in [host]))
    if not has: miss_dom.append((idx,n,host))
print('register LIT domain not among any aliases:',len(miss_dom))
for x in miss_dom[:20]: print('  DOM',x)
# --- freekey ledger ---
fk=open(S+'/btier_freekey_ledger.md',encoding='utf-8').read()
sec1=section(fk,'## ① ','## ② ')
fk_engines=[]
for ln in sec1.splitlines():
    m=re.match(r'^\|\s*([a-z0-9_]+)\s*\(',ln)
    if m: fk_engines.append(m.group(1))
print('freekey LIT engines:',len(fk_engines),fk_engines)
sec3=section(fk,'## ③ ','## ④ ')
fk_ua=[]
for ln in sec3.splitlines():
    m=re.match(r'^\|\s*(\d+)\s*\|\s*([^|]+?)\s*\|',ln)
    if m: fk_ua.append((int(m.group(1)),m.group(2).strip()))
print('freekey USER_ACTION rows:',len(fk_ua))
# fk engine alias presence
for eng in fk_engines:
    ink= eng in merged or eng in sa
    viac= allalias.get(eng)
    print('  FK',eng,'key:',ink,'| as-alias-of:',viac)
# user action dedup by idx set + names
reg_idx=set(i for i,_ in ua_rows)
fk_idx=set(i for i,_ in fk_ua)
inter=reg_idx & fk_idx
print('UA idx sets: register',len(reg_idx),'freekey',len(fk_idx),'intersection',sorted(inter))
