# -*- coding: utf-8 -*-
"""patch_v091_gates.py — v0.9.1 升版 + bootsim 三修回归门（幂等，带断言）。"""
import io

P = 'E:/AI-Station/微信小程序/zongbao-ai/'

# 1) 版本升 0.9.1（幂等：已升则跳过）
p = P + 'package.json'
s = io.open(p, encoding='utf-8').read()
if '"version": "0.9.0"' in s:
    io.open(p, 'w', encoding='utf-8', newline='').write(
        s.replace('"version": "0.9.0"', '"version": "0.9.1"'))

p = P + 'pages/my/my.wxml'
s = io.open(p, encoding='utf-8').read()
if 'v0.9.0 · 总包AI顾问' in s:
    io.open(p, 'w', encoding='utf-8', newline='').write(
        s.replace('v0.9.0 · 总包AI顾问', 'v0.9.1 · 总包AI顾问'))

# 2) bootsim 三处
p = 'work/bootsim_v3.py'
s = io.open(p, encoding='utf-8').read()
changed = 0

a = 'check("my 版本标记 v0.9.0", "v0.9.0" in my_wxml)'
if a in s:
    s = s.replace(a, 'check("my 版本标记 v0.9.1", "v0.9.1" in my_wxml)'); changed += 1

a = 'check("package.json version=0.9.0", pkg["version"] == "0.9.0")'
if a in s:
    s = s.replace(a, 'check("package.json version=0.9.1", pkg["version"] == "0.9.1")'); changed += 1

a = ('check("ask hero-ai 徽章文案=AI生成+人工智能全称句",\n'
     '      ">AI生成</text>" in ask_wxml and "人工智能（AI）生成" in ask_wxml)')
assert a in s, 'ask hero anchor missing'
gate_ask = ('check("ask 一页一处 AI 提示（重复 banner 已拆，hero 药丸唯一）",\n'
            '      "ai-flag" not in ask_wxml)')
if gate_ask not in s:
    s = s.replace(a, a + '\n' + gate_ask); changed += 1

a = 'check("研究页 AI 辅助研究口径注脚（可证成）", "AI 辅助研究方法" in rs_wxml)'
assert a in s, 'research anchor missing'
MARK = 'v0.9.1 用户令 1008 晚三修'
if MARK not in s:
    gate_mall = """
# ══ v0.9.1 用户令 1008 晚三修（标签空白/试读裸md/AI提示去重）══
check("研究页 badges 键值渲染（对象直渲染=空白标签根因）",
      "{{b.k}}" in rs_wxml and 'wx:key="k"' in rs_wxml and "{{b}}" not in rs_wxml)
check("报告页 badges 键值渲染 {{item.k}}", "{{item.k}}" in rp_wxml)
_rp_wxss = read("pages/report/report.wxss")
check("报告页 试读 md2blocks 结构化渲染（裸 md 符号根除）",
      "md2blocks" in rp_js and "sampleBlocks" in rp_js and "b.t === 'h2'" in rp_wxml
      and 'template is="inl"' in rp_wxml and ".md-p" in _rp_wxss)
check("报告页 试读折叠渐隐（max-height+mask 非 line-clamp）",
      "rp-sample-fold" in _rp_wxss and "-webkit-mask-image" in _rp_wxss)
check("报告页 载入骨架（防跳版式）", "rp-skel" in rp_wxml and "rp-skel" in _rp_wxss)
"""
    s = s.replace(a, a + gate_mall); changed += 1

io.open(p, 'w', encoding='utf-8', newline='').write(s)
print('patched, sections changed:', changed)
