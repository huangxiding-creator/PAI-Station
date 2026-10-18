import json, io
d = json.load(io.open(r'E:/AI-Station/WeAppForge/work/rlist_tmp.json', encoding='utf-8'))
items = d.get('reports') or d.get('items') or d
sell = [i for i in items if i.get('sellable')]
prices = sorted({i.get('price') for i in sell if i.get('price')})
print('total', len(items), 'sellable', len(sell))
print('price_set', prices[:12])
