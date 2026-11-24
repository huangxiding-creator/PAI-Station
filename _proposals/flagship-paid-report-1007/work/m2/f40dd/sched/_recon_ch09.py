# -*- coding: utf-8 -*-
"""ch09 选锚侦察: 逐锚提取法律适用关键词上下文"""
import io, re, sys

bank = io.open('bank_ch09.md', encoding='utf-8').read()
# 切锚
parts = re.split(r'^## ([0-9a-f]{12})[^\n]*\n', bank, flags=re.M)
# parts[0] = 头, 之后 [anchor, body, anchor, body...]
anchors = {}
for i in range(1, len(parts), 2):
    anchors[parts[i]] = parts[i+1]

kws = ['效力性', '强制性规定', '交易习惯', '行业惯例', '计价规范', '定额',
       '司法解释', '部门规章', '规范性文件', '地方性法规', '法源', '位阶',
       '政策', '红头文件', '会议纪要', '审计', '国际', '外资', '港澳',
       '招标投标法', '建筑法', '民法典', '合同法']

focus = sys.argv[1:] if len(sys.argv) > 1 else sorted(anchors)
for a in focus:
    body = anchors[a]
    hits = []
    for kw in kws:
        cnt = body.count(kw)
        if cnt:
            hits.append(f'{kw}×{cnt}')
    if not hits:
        continue
    print(f'== {a}: ' + ' '.join(hits))
    # 每个高价值关键词给一处上下文
    for kw in ['效力性', '交易习惯', '行业惯例', '计价规范', '部门规章', '规范性文件', '招标投标法']:
        for m in re.finditer(re.escape(kw), body):
            s = max(0, m.start()-110)
            e = min(len(body), m.end()+190)
            ctx = body[s:e].replace('\n', ' ')
            print(f'  [{kw}] ...{ctx}...')
            break
