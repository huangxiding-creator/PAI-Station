# -*- coding: utf-8 -*-
import io
p = 'work/bootsim_v3.py'
s = io.open(p, encoding='utf-8').read()
a = 'check("pot 锅圈 AI 标识（公开展示面）", "内容由 AI 生成" in pot_wxml and "pot-ai-note" in pot_wxml)'
b = 'check("pot 锅圈 AI 标识（页首常驻=ai-flag）", "人工智能（AI）生成" in pot_wxml and \'class="ai-flag"\' in pot_wxml)'
assert a in s, 'old pot gate anchor missing'
s = s.replace(a, b)
a2 = 'check("研究页 变现数据带（在售/¥498起/已解锁，可证成实数）"'
b2 = 'check("研究页 变现数据带（在售/498元起/已解锁，可证成实数）"'
assert a2 in s, 'ux gate name anchor missing'
s = s.replace(a2, b2)
io.open(p, 'w', encoding='utf-8', newline='').write(s)
print('reconciled')
