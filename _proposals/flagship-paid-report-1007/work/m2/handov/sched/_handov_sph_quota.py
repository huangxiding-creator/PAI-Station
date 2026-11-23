# -*- coding: utf-8 -*-
import json
lines = open(r'E:\AI-Station\report_platform\promo\promo_ledger.jsonl', encoding='utf-8').read().strip().split('\n')
for ln in lines[-40:]:
    d = json.loads(ln)
    if d.get('src') == 'sph' or d.get('account') == '视频号':
        print(d.get('ts', '')[:16], d.get('title', '')[:44], d.get('media_id', ''))
