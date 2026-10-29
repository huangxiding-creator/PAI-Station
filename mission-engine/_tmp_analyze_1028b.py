import json
from collections import Counter
sigs = []
for l in open('ledger/signals.jsonl', encoding='utf-8'):
    try: r = json.loads(l)
    except Exception: continue
    s = r.get('signal', r)
    if isinstance(s, dict): sigs.append(s)

dl = [s for s in sigs if s.get('source_type')=='demand_ledger' and s.get('ts','').startswith('2026-10-28')]
print('today demand_ledger new:', len(dl))
print('distinct quotes:', len(set(s['payload'].get('demand_quote','') for s in dl)))
print('distinct source_face:', Counter(s['payload'].get('source_face') for s in dl))
print('distinct source_ref:', Counter(s['evidence'].get('source_ref') for s in dl))
print('distinct signal_id doc-prefix:', Counter(s['evidence'].get('signal_id','').rsplit('_',1)[0] for s in dl))
print('score dist:', Counter(s['payload'].get('score') for s in dl))
print()
# compare with 1027 08:05 batch of 63
prev = [s for s in sigs if s.get('source_type')=='demand_ledger' and s.get('ts','').startswith('2026-10-27')]
print('1027 demand_ledger count:', len(prev), '| ts range:', min((s['ts'] for s in prev), default=''), '->', max((s['ts'] for s in prev), default=''))
q_today = set(s['payload'].get('demand_quote','') for s in dl)
q_prev  = set(s['payload'].get('demand_quote','') for s in prev)
print('quote overlap with 1027 batch:', len(q_today & q_prev), '/', len(q_today))
print()
print('--- 12 sample quotes today ---')
for s in dl[:12]:
    print(' *', s['payload'].get('demand_quote','')[:100])
