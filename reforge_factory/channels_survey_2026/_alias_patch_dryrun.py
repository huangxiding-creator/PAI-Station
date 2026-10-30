# -*- coding: utf-8 -*-
import json,re,ast,sys
sys.stdout.reconfigure(encoding='utf-8')
B=r'E:/AI-Station/reforge_factory'; S=B+'/channels_survey_2026'
src=open(S+'/_integrate_round2_1025.py',encoding='utf-8').read()
ns={'__file__': S+'/_integrate_round2_1025.py','__name__':'h'}
exec(compile(src.split('def main(')[0],'i','exec'),ns)
entry_id=ns['entry_id']
reg=json.load(open(S+'/MASTER_REGISTRY.json',encoding='utf-8'))
be=[e for e in reg['entries'] if e.get('tier')=='B']
used=set(); bids=[entry_id(e,used) for e in be]
cm=ast.parse(open(B+'/completeness/channel_matrix.py',encoding='utf-8').read())
sa={}
for node in cm.body:
    if not isinstance(node,(ast.Assign,ast.AnnAssign)): continue
    tgts=[node.target] if isinstance(node,ast.AnnAssign) else node.targets
    for t in tgts:
        if isinstance(t,ast.Name) and t.id=='SURVEY_ALIASES' and isinstance(node.value,ast.Dict):
            sa=ast.literal_eval(node.value)
ca={}
for node in cm.body:
    if not isinstance(node,(ast.Assign,ast.AnnAssign)): continue
    tgts=[node.target] if isinstance(node,ast.AnnAssign) else node.targets
    for t in tgts:
        if isinstance(t,ast.Name) and t.id=='CHANNEL_ALIASES' and isinstance(node.value,ast.Dict):
            ca=ast.literal_eval(node.value)
# engine ids from bridge
br=open(B+'/legs/api_replica_bridge.py',encoding='utf-8').read()
engs=set(re.findall(r'^\s{4}"([A-Za-z0-9_]+)":\s*\{',br,re.M))
allids=set(sa)|set(ca)|engs
allalias={}
for k,v in list(sa.items())+list(ca.items()):
    for a in v: allalias.setdefault(str(a).lower(),k)
# 19 lit domains: (plan idx, host) from check3 output
doms=[(41,'mojeek.com'),(87,'so.com'),(88,'4get.ca'),(102,'bing.com'),(104,'boardreader.com'),(130,'google.com'),(134,'scholar.google.com'),(135,'trends.google.com'),(149,'mwmbl.org'),(165,'qwant.com'),(168,'docs.rsshub.app'),(176,'startpage.com'),(177,'stract.com'),(178,'swisscows.com'),(179,'teclis.com'),(188,'yandex.com'),(221,'tiangong.cn'),(222,'so.toutiao.com'),(231,'news.baidu.com')]
print('engine ids found in bridge:',len(engs))
adds=[];skipped=[]
for idx,dom in doms:
    key=bids[idx]
    coll = dom in allalias and allalias[dom]!=key
    engcoll = dom in engs
    if coll or engcoll: skipped.append((idx,key,dom,'alias_of:'+str(allalias.get(dom)),'engine:'+str(dom in engs)))
    else: adds.append((idx,key,dom))
print('ADD candidates:',len(adds))
for a in adds: print('  ADD',a)
print('SKIP (collision):',len(skipped))
for s in skipped: print('  SKIP',s)
newkeys=[('nasa_images',['nasa images','images-api.nasa.gov']),('noaa_nws',['noaa nws','api.weather.gov','weather.gov'])]
for k,al in newkeys:
    print('NEWKEY',k,'exists:',k in allids,'| alias collisions:',[(a,allalias.get(a),a in engs) for a in al if a.lower() in allalias or a in engs])
