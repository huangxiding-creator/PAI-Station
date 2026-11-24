# -*- coding: utf-8 -*-
"""ch08 收编选锚画像: 每锚 案号/法院/日期/字数 + 关键词命中 + 判决主体段头尾摘录"""
import re, io, sys

t = io.open('bank_ch08.md', encoding='utf-8').read()
blocks = re.split(r'\n## ', t)[1:]
mode = sys.argv[1] if len(sys.argv) > 1 else 'kw'
kws = ['合并处理','一并处理','合并审理','另案处理','另循途径','另案主张','反诉','法律关系','诉的合并',
       '变更','签证','索赔','增加工程','零星用工','合同外','补偿款','停工','窝工','工期延误','利息','鉴定']
for b in blocks:
    aid = b.split(' ')[0]
    m = re.search(r'案号: ([^\n]+)', b)
    d = re.search(r'裁判日期: ([^\n]+)', b)
    c = re.search(r'法院: ([^\n]+)', b)
    sz = re.search(r'\(([\d,]+)字\)', b.split('\n')[0])
    paras = b.split('\n\n')
    body = max(paras, key=len)
    if mode == 'kw':
        hits = {k: body.count(k) for k in kws if body.count(k) >= 2}
        print('%s|%s|%s|%s|%s' % (aid, sz.group(1) if sz else '', m.group(1) if m else '',
                                  c.group(1) if c else '', ';'.join('%s=%d' % (k, v) for k, v in
                                  sorted(hits.items(), key=lambda x: -x[1]))))
    else:  # head/tail mode: arg2=anchor id
        if sys.argv[2] != aid:
            continue
        print('HEAD:', body[:2000].replace('\n', ' '))
        print()
        print('TAIL:', body[-3000:].replace('\n', ' '))
