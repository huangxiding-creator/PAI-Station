import urllib.request, json, sys
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
r = urllib.request.urlopen('https://ai.epcschool.top/api/report/catalog', timeout=15)
d = json.loads(r.read())
items = d if isinstance(d, list) else d.get('reports', d.get('data', []))
from collections import Counter
prices = Counter()
for it in items:
    p = it.get('price_yuan') or it.get('price') or it.get('price_fen', 0)
    if isinstance(p, (int, float)):
        prices[int(p)] += 1
print('价格分布:', dict(sorted(prices.items())))
for it in items:
    if it.get('sku') in ('CNNC-EPC', 'R50-SNEI'):
        print(f"  {it['sku']}: price={it.get('price_yuan') or it.get('price')}")
