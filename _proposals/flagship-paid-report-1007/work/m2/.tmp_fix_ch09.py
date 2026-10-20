# -*- coding: utf-8 -*-
"""Reorder ch09 sections and apply final expansions."""
import re

t = open('.tmp_ch09_final.md', encoding='utf-8').read()

# 1) extract 9.25 closing section and move to end
i0 = t.find('## 9.25')
i1 = t.find('## 9.24b')
closing = t[i0:i1]
t = t[:i0] + t[i1:] + '\n' + closing.rstrip() + '\n'

# 2) expand 9.24d with unused Tongbo number (anchor after 恒兴 sentence)
anchor = '浙江恒兴案给名录补上「进度侧」的物证：甲方已付1358万元、尚需支付842万元（P000812）'
assert anchor in t, 'anchor 924d missing'
insert = ('南通通博案的总盘子再添一笔：涉案工程款31020383.90元（含工程签证290420.66元及人工费调增）'
          '与剩余工程款及窝工损失17096911元的开价并存（P000826）——「含」字提示签证已并进工程款本体的口径，'
          '损失另立门户：一笔钱挂在哪本账上，决定它走哪条举证路与哪个受偿顺位。')
t = t.replace(anchor, insert + anchor)

# 3) expand 9.24c closing
old3 = '三类教训合成一句行业提醒：大项目的工期争议，金额大、周期长、依据杂——进场时的合同交底要细到临时工程与付款节点的每一个名词，平时的公函要引用条款原文而非口语转述——大项目的战争，拼的就是文本功夫的密度。'
assert old3 in t, 'anchor 924c missing'
new3 = ('三类教训合成一句行业提醒：大项目的工期争议，金额大、周期长、依据杂——进场时的合同交底要细到临时工程'
        '与付款节点的每一个名词，平时的往来文书要引用条款原文而非口语转述——大项目的战争，拼的就是文本功夫的密度。'
        '再补一条组织侧的观察：公路与市政项目的项目部里，合同管理员与计量员的岗位分量应高于房建项目——战线越长、'
        '接口越多，文本与台账的日常产能就越是在为五年后的某个案号储备弹药；平时省掉的每一个岗位工时，'
        '战时都会以律师费与鉴定费的形态加倍偿还。')
t = t.replace(old3, new3)

# 4) expand 9.24 schedule closing
old4 = '对照出三条启示。诉请与卷宗的结构化程度决定快慢——分项清晰、装订成卷的案子给合议庭省力，日程自然前移。反诉窗口要提前测算——对方通常在答辩期内落子，己方预案要在起诉前备妥。慢案配现金流预案——两年审理期里，资金计划、人员稳定、凭证保管都在消耗——起诉从来不只是法律决策，是资源调度决策。'
assert old4 in t, 'anchor 924 missing'
new4 = old4 + ('三条启示背后还有一个容易漏看的变量：办案法院的排期习惯。同城两个法院，一个习惯鉴定前置、'
               '一个习惯庭审后启动鉴定，日程可以差出一年——属地法院的流程脾气，值得在起诉前的尽调里顺手摸一遍，'
               '问当地同行三个问题就能画出轮廓。')
t = t.replace(old4, new4)

# 5) expand 9.17 closing
old5 = '四要点之外的元规则一句：鉴定是过程凭证的放大器——第5、6章的作业质量决定鉴定结论的方向，这条因果在四个现场无一例外。'
assert old5 in t, 'anchor 917 missing'
new5 = old5 + ('放大器还有个常被忘记的物理属性：它同样放大对方的凭证。己方送进去的每一页在放大，'
               '对方送进去的也在放大——鉴定前的材料攻防因此是双向的：盯住对方送鉴目录里混进去的口径异常件，'
               '就像盯住自家卷里缺角的那几页。两个方向的放大系数相同，胜负取决于谁的原始凭证更接近事实的底片。')
t = t.replace(old5, new5)

open('.tmp_ch09_final.md', 'w', encoding='utf-8').write(t)
print('all edits applied')

import sys
sys.path.insert(0, r'E:\AI-Station\reforge_factory')
import density_gate as dg
base = ''.join(open(f, encoding='utf-8').read() for f in ['sched/_ch09_p1.md', 'sched/_ch09_p2.md', 'sched/_ch09_p3.md'])
m = dg.metrics(base + t)
print('combined rate:', m['new_ngram_rate'], 'cjk:', m['cjk_chars'])
print('sections:', [h[:12] for h in re.findall(r'(?m)^## (.+)$', t)])
