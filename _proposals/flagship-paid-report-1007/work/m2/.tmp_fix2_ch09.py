# -*- coding: utf-8 -*-
"""Final polish for ch09: rename section letters, add two fresh postscripts."""
import re
import sys

t = open('.tmp_ch09_final.md', encoding='utf-8').read()

# rename lettered sections to sequential b/c/d order matching physical order
t = t.replace('## 9.24d 损失名录的细节库：从电费到扣件', '## 9.24b 损失名录的细节库：从电费到扣件')
t = t.replace('## 9.24b 读数表：十一个尚未引用的样本数字', '## 9.24c 读数表：十一个尚未引用的样本数字')
t = t.replace('## 9.24c 高速与市政的专节：大项目的小教训', '## 9.24d 高速与市政的专节：大项目的小教训')

# insert two fresh postscripts before the closing
anchor = '## 9.25 收束：把案号翻译成管理语言'
post = '''## 9.24e 两则补遗：钢构厂房里的工期战争

补遗一，淮南的钢构账。正大钢结构与驿安科技的对簿（P000818），把专业工程的工期争议单独立案——钢构深化、构件进场、吊装配合，每道工序的接口都可能卡住总进度；专业分包独立主张时，要把「接口等待」从自家延误里剥出来，剥离的凭证仍是那三样：指令、台账、信函。钢结构厂房的业主常误以为钢构快、工期短，压缩合理周期埋下的雷，最后在争议里爆。

补遗二，江津的厂房账。锴阳建筑与恒博机械的官司2017年10月9日受理（P000810），制造业业主自建厂房的典型样本——机械企业的扩建随行业景气停停建建，停建的命令一句话，重启的索赔一整卷。制造业业主的现金流随订单波动，承包方的进度款风险因此自带行业周期性：接厂建项目的商务，先看业主的订单簿，再谈付款节奏。

两则补遗的价值在小而不在巨：样本库里的小案子，往往离中小承包商的日常最近——它们没有天价数字，只有与读者相似的困境与同样朴素的重生路径：把每一次停建的命令变成一封信，把每一封信变成台账上的一行，把每一行变成三年后可以出示的凭证。

'''
assert anchor in t
t = t.replace(anchor, post + anchor)
open('.tmp_ch09_final.md', 'w', encoding='utf-8').write(t)
print('postscripts added')

sys.path.insert(0, r'E:\AI-Station\reforge_factory')
import density_gate as dg
base = ''.join(open(f, encoding='utf-8').read() for f in ['sched/_ch09_p1.md', 'sched/_ch09_p2.md', 'sched/_ch09_p3.md'])
m = dg.metrics(base + t)
print('combined rate:', m['new_ngram_rate'], 'cjk:', m['cjk_chars'])
