# -*- coding: utf-8 -*-
import io
p = 'E:/AI-Station/WeAppForge/work/bootsim_v3.py'
s = io.open(p, encoding='utf-8').read()
a = 'check("answer 定位=AI 检索行业知识库（可证成口径）", "AI 检索行业知识库" in ask_wxml and "AI 检索行业知识库" in ans_js)'
b = 'check("answer 定位=AI 检索总包智库（可证成口径）", "检索「总包智库」" in ask_wxml and "AI 检索总包智库" in ans_js)'
assert a in s, 'gate136 anchor missing'
s = s.replace(a, b)
a2 = '''check("hero 口径=AI 检索行业知识库生成（可证成）",
      "AI 检索行业知识库" in ask_wxml and "AI 检索行业知识库" in read("pages/home/home.wxml")'''
b2 = '''check("hero 口径=AI 检索总包智库生成（可证成）",
      "检索「总包智库」" in ask_wxml and "AI 检索总包智库" in read("pages/home/home.wxml")'''
assert a2 in s, 'gate371 anchor missing'
s = s.replace(a2, b2)
MARK = '机构来源叙事门（总包之声/总包学园）'
if MARK not in s:
    anchor = 'check("支付降级文案通用化（报告/导出共用，不再误导为导出专属）"'
    assert anchor in s
    gate = '''check("机构来源叙事（总包之声 2023 公益 + 总包学园）",
      "总包之声" in ask_wxml and "2023 年至今公益运行" in ask_wxml
      and "总包学园" in ask_wxml and "总包之声" in read("pages/zhiku/zhiku.wxml"))
'''
    s = s.replace(anchor, gate + anchor)
    io.open(p, 'w', encoding='utf-8', newline='').write(s)
    print('wording gates reconciled + provenance gate')
else:
    io.open(p, 'w', encoding='utf-8', newline='').write(s)
    print('wording gates reconciled')
