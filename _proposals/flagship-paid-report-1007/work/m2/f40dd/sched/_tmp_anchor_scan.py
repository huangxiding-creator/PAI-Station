# -*- coding: utf-8 -*-
import re, io
lines = io.open('bank_ch03.md', encoding='utf-8').read().split('\n')
starts = [7+32*i for i in range(35)]
kws = ['停工','窝工','工期延误','顺延工期','索赔','利润','可得利益','预期利益','误期','违约金','因果关系','签证','损失','措施费','增加费用','反索赔','人工费','机械']
for idx, s in enumerate(starts):
    seg = lines[s-1:s+31]
    head = seg[0]
    m = re.match(r'## (\S+) \((\S+) ([\d,]+)字\)', head)
    aid, src, n = m.group(1), m.group(2), m.group(3)
    text = '\n'.join(seg)
    hits = {k: text.count(k) for k in kws if text.count(k)>=2}
    print('%02d|%s|%s|%s' % (idx+1, aid, n, ';'.join('%s=%d'%(k,v) for k,v in sorted(hits.items(), key=lambda x:-x[1]))))
