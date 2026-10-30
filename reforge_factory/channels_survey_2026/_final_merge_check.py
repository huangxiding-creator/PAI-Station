# -*- coding: utf-8 -*-
import json, ast, re, sys
sys.stdout.reconfigure(encoding='utf-8')
base=r'E:/AI-Station/reforge_factory/channels_survey_2026'
reg=json.load(open(base+'/MASTER_REGISTRY.json',encoding='utf-8'))
plan=json.load(open(base+'/btier_plan.json',encoding='utf-8'))
ents=reg['entries']
from collections import Counter
tc=Counter(e.get('tier') for e in ents)
print('REG tiers:',dict(tc))
print('PLAN stats:',json.dumps(plan['stats'],ensure_ascii=False))
be=[e for e in ents if e.get('tier')=='B']
print('B entries:',len(be),'| first B entry keys:',list(be[0].keys()))
# match plan idx order to registry B order
ok=all(plan['entries'][i]['name'].split(' (')[0] in be[i].get('name','') or be[i].get('name','') in plan['entries'][i]['name'] for i in [0,1,50,100,233]) if len(be)==234 else False
print('plan<->registry B order sanity:',ok)
print('sample B entry:',json.dumps(be[0],ensure_ascii=False)[:300])
paid=[e for e in plan['entries'] if e['bucket']=='paid_only']
print('paid_only entries:',len(paid))
