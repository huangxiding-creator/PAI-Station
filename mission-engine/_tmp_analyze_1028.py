import json, time
from collections import Counter
now = time.time()
sigs = []
for l in open('ledger/signals.jsonl', encoding='utf-8'):
    try:
        r = json.loads(l)
    except Exception:
        continue
    s = r.get('signal', r)
    if isinstance(s, dict):
        sigs.append(s)
print('total parsed:', len(sigs))
print('adapters:', Counter(s.get('adapter') or s.get('source','?') for s in sigs))
print('fields of last:', sorted(sigs[-1].keys()))
print()
print('--- last 3 raw ---')
for s in sigs[-3:]:
    print(json.dumps(s, ensure_ascii=False)[:600])
    print()
