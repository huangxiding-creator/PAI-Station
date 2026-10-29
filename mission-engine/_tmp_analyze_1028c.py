import json, datetime as dt
NOW = dt.datetime(2026, 10, 28, 8, 5, 44)
sigs = []
for l in open('ledger/signals.jsonl', encoding='utf-8'):
    try: r = json.loads(l)
    except Exception: continue
    s = r.get('signal', r)
    if isinstance(s, dict): sigs.append(s)

from collections import Counter
today = [s for s in sigs if str(s.get('ts','')).startswith('2026-10-28')]
w3h = [s for s in today if '05:05' <= str(s.get('ts',''))[11:16]]
print('today total:', len(today), '| in 3h window (05:05-08:05):', len(w3h))
print('today by source:', Counter(s.get('source_type') for s in today))
# non-demand_ledger anything today?
for s in today:
    if s.get('source_type') != 'demand_ledger':
        print('NON-DL today:', json.dumps(s, ensure_ascii=False)[:200])
# 24h bucket: since 10-27 08:05
w24 = [s for s in sigs if str(s.get('ts','')) >= '2026-10-27 08:05']
print('24h bucket:', len(w24), Counter(s.get('source_type') for s in w24))
# urgency/jtbd of 3h window
print('3h urg:', Counter(s['payload'].get('urgency') for s in w3h if s.get('source_type')=='demand_ledger'))
# distinct jtbd outcome tags in today's 63
print('3h jtbd outcomes:', Counter(s['payload'].get('jtbd',{}).get('outcome','?') for s in w3h if s.get('source_type')=='demand_ledger'))
