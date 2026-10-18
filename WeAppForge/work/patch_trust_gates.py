# -*- coding: utf-8 -*-
import io
p = 'E:/AI-Station/WeAppForge/work/bootsim_v3.py'
s = io.open(p, encoding='utf-8').read()
MARK = 'v0.9.1 信任与智库背书门（1008 用户令）'
anchor = 'check("ask 页 清空键按压反馈"'
assert anchor in s, 'trust gate anchor missing'
if MARK not in s:
    gate = """
# ══ %s ══
check("ask 智库底座信任带（四数可证成=智库页盘点同数）",
      "kb-strip" in ask_wxml and "1855" in ask_wxml and "847" in ask_wxml
      and "906" in ask_wxml and "620" in ask_wxml and "kb-cred" in ask_wxml
      and ".kb-strip" in read("pages/ask/ask.wxss"))
check("ask hero 口径点名总包智库", "检索「总包智库」" in ask_wxml)
check("ask 信任承诺=每答附依据来源（answer 页 cite 栏背书）",
      "每条回答附依据来源" in ask_wxml
      and "依据来源" in read("pages/answer/answer.wxml"))
check("支付降级文案通用化（报告/导出共用，不再误导为导出专属）",
      "导出服务开通中" not in read("utils/pay.js"))
""" % MARK
    s = s.replace(anchor, gate + '\n' + anchor)
    io.open(p, 'w', encoding='utf-8', newline='').write(s)
    print('trust gates patched')
else:
    print('already')
