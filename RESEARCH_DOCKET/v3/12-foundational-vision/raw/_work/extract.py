# -*- coding: utf-8 -*-
import re, json, sys, io
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')
W = r'E:\AI-Station\RESEARCH_DOCKET\v3\12-foundational-vision\raw\_work'

import os
def rd(name):
    p = name if (len(name) > 3 and name[1] == ':') else (W + '\\' + name)
    return open(p, encoding='utf-8', errors='ignore').read()

def dump(name, text):
    open(W + '\\' + name, 'w', encoding='utf-8').write(text)

# 1) 36kr Wang Xiaochuan
s = rd('wxc_36kr.html')
m = re.search(r'window\.initialState=\{.*?\}(?=</script>)', s, re.S)
raw = m.group(0) if m else s
raw = raw.replace('\\u002F', '/').replace('\\n', ' ')
raw = re.sub(r'\\u[0-9a-fA-F]{4}', ' ', raw)
raw = re.sub(r'<[^>]+>', '', raw)
out = []
for kw in ['All in', 'AGI', 'AI 医生', '生命', '数字分身', '助手', '王小川']:
    for mm in re.finditer('.{80}' + re.escape(kw) + '.{220}', raw):
        out.append(kw.upper() + ' >> ' + mm.group(0)[:320])
dump('wxc_extract.txt', '\n\n'.join(out[:16]))

# 2) Ng agents article
t = rd('ng_agents.html')
t = re.sub(r'<script.*?</script>', '', t, flags=re.S)
t = re.sub(r'<style.*?</style>', '', t, flags=re.S)
t = re.sub(r'<[^>]+>', ' ', t)
t = re.sub(r'\s+', ' ', t)
i = t.lower().find('reflection')
dump('ng_extract.txt', t[max(0, i-900):i+1600] if i > 0 else t[:2600])

# 3) Dario persisted tool-result json
dj = rd(r'C:\Users\91216\.claude\projects\e--AI-Station\743cb8f4-67f5-407d-b7f5-008ef4b9a8ea\tool-results\call_3704a7f851604be0ab0a709c.json')
res = []
for kw in ['assistant', 'geniuses in a datacenter', '5.1', '5.2', 'meaningful work', 'most important', 'two general']:
    for mm in re.finditer('.{110}' + re.escape(kw) + '.{260}', dj, re.I):
        res.append(kw.upper() + ' >> ' + mm.group(0)[:380])
dump('dario_extract.txt', '\n\n'.join(res[:20]))

# 4) balaji bj2 - find polytheistic slug
try:
    b = rd('bj2.json')
    i = b.find('polytheistic')
    dump('balaji_extract.txt', b[max(0, i-400):i+600])
except Exception as e:
    dump('balaji_extract.txt', 'ERR ' + str(e))

# 5) fortune jobs page
try:
    f = rd('fortune_jobs.html')
    f = re.sub(r'<script.*?</script>', '', f, flags=re.S)
    f = re.sub(r'<[^>]+>', ' ', f)
    f = re.sub(r'\s+', ' ', f)
    i = f.find('bicycle')
    dump('fortune_extract.txt', f[max(0, i-600):i+1200] if i > 0 else 'NO_KEYWORD len=' + str(len(f)))
except Exception as e:
    dump('fortune_extract.txt', 'ERR ' + str(e))

# 6) a16z save the world quote
try:
    a = rd('a16z_saveworld.html')
    a = re.sub(r'<script.*?</script>', '', a, flags=re.S)
    a = re.sub(r'<[^>]+>', ' ', a)
    a = re.sub(r'\s+', ' ', a)
    i = a.find('make everything')
    if i < 0:
        i = a.find('expand opportunity')
    if i < 0:
        i = a.find('I am here to bring')
    dump('a16z_extract.txt', a[max(0, i-800):i+1400] if i > 0 else a[:2500])
except Exception as e:
    dump('a16z_extract.txt', 'ERR ' + str(e))

# 7) sspai second brain
try:
    sp = rd('sspai_2n.html')
    sp = re.sub(r'<script.*?</script>', '', sp, flags=re.S)
    sp = re.sub(r'<[^>]+>', ' ', sp)
    sp = re.sub(r'\s+', ' ', sp)
    i = sp.find('第二大脑')
    dump('sspai_extract.txt', sp[max(0, i-500):i+1500] if i > 0 else sp[:2000])
except Exception as e:
    dump('sspai_extract.txt', 'ERR ' + str(e))

# 8) anthropic news agent titles
try:
    an = rd('anthropic_news.html')
    titles = re.findall(r'"title"\s*:\s*"([^"]{15,120})"', an)
    keep = [t for t in titles if re.search(r'agent|Claude|memory|personal', t, re.I)]
    dump('anthropic_extract.txt', '\n'.join(keep[:30]))
except Exception as e:
    dump('anthropic_extract.txt', 'ERR ' + str(e))

# 9) karpathy space of minds
try:
    km = rd('kp_minds.html')
    km = re.sub(r'<[^>]+>', ' ', km)
    km = re.sub(r'\s+', ' ', km)
    i = km.find('spirits')
    if i < 0:
        i = km.find('space of minds')
    dump('kpminds_extract.txt', km[max(0, i-700):i+1800] if i > 0 else km[:2500])
except Exception as e:
    dump('kpminds_extract.txt', 'ERR ' + str(e))

# 10) sequoia act two
try:
    sq = rd('seq_act2b.html')
    sq = re.sub(r'<script.*?</script>', '', sq, flags=re.S)
    sq = re.sub(r'<[^>]+>', ' ', sq)
    sq = re.sub(r'\s+', ' ', sq)
    i = sq.find('Towards Act Two')
    dump('seq_extract.txt', sq[max(0, i-200):i+2600] if i > 0 else sq[:2500])
except Exception as e:
    dump('seq_extract.txt', 'ERR ' + str(e))

# 11) toutiao yangzhilin
try:
    tt = rd('yzl_toutiao.html')
    tt = re.sub(r'<script.*?</script>', '', tt, flags=re.S)
    tt = re.sub(r'<[^>]+>', ' ', tt)
    tt = re.sub(r'\s+', ' ', tt)
    out2 = []
    for kw in ['杨植麟', '长文本', '记忆', 'Kimi']:
        mm = re.search('.{60}' + kw + '.{200}', tt)
        if mm:
            out2.append(kw.upper() + ' >> ' + mm.group(0)[:280])
    dump('yzl_tt_extract.txt', '\n\n'.join(out2))
except Exception as e:
    dump('yzl_tt_extract.txt', 'ERR ' + str(e))

# 12) network state quote
try:
    ns = rd('netstate.html')
    ns = re.sub(r'<script.*?</script>', '', ns, flags=re.S)
    ns = re.sub(r'<[^>]+>', ' ', ns)
    ns = re.sub(r'\s+', ' ', ns)
    i = ns.find('sovereign')
    dump('netstate_extract.txt', ns[max(0, i-500):i+1500] if i > 0 else ns[:2000])
except Exception as e:
    dump('netstate_extract.txt', 'ERR ' + str(e))

print('done2')
