import re
p = r'E:/AI-Station/_proposals/flagship-paid-report-1007/work/m2/transform/ch04.md'
t = open(p, encoding='utf-8').read()
han = re.findall(r'[\u4e00-\u9fff]', t)
cjk_punct = re.findall(r'[\u3000-\u303f\uff00-\uffef]', t)
print('total_chars:', len(t))
print('hanzi:', len(han))
print('hanzi+cjk_punct:', len(han) + len(cjk_punct))
anchors = re.findall(r'（P4\d{3}）', t)
print('anchor_refs:', len(anchors))
uniq = sorted(set(a.strip('（）') for a in anchors))
print('unique_anchors:', len(uniq), uniq)
own = re.findall(r'own_calc', t)
print('own_calc:', len(own))
bad = []
for ln in t.split('\n'):
    s = ln.strip()
    if not s:
        continue
    if s.startswith('#') or s.startswith('|') or s.startswith('**表'):
        continue
    for sent in re.split(r'(?<=[。！？；])', ln):
        if re.search(r'\d', sent) and ('P4' not in sent) and ('own_calc' not in sent):
            bad.append(sent.strip()[:120])
out = open(r'E:/AI-Station/_proposals/flagship-paid-report-1007/work/m2/transform/_bad_ch04.txt', 'w', encoding='utf-8')
out.write('BAD_sent_count: %d\n' % len(bad))
for b in bad:
    out.write('BAD: ' + b + '\n')
out.close()
print('written _bad_ch04.txt, count =', len(bad))
