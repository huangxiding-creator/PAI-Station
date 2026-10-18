# -*- coding: utf-8 -*-
"""patch_v091_ux_gates.py — v0.9.1 逐页深度优化回归门（1008 用户令：
顶级审美 / 极易使用 / 有利变现；幂等，带断言）。"""
import io

P = 'E:/AI-Station/微信小程序/zongbao-ai/'

p = 'work/bootsim_v3.py'
s = io.open(p, encoding='utf-8').read()

MARK = 'v0.9.1 逐页深度优化门（1008 用户令三标准）'
assert '报告页 载入骨架' in s, 'v0.9.1 三修 block anchor missing (先跑 patch_v091_gates.py)'
if MARK not in s:
    gate = """
# ══ %s ══
# 变现主杠杆：报告详情页吸底行动栏（读完目录/试读后随时可购）
_rp_wxml_2 = read("pages/report/report.wxml")
check("报告页 吸底行动栏（fixed 双 CTA：购买/打开PDF）",
      'class="rp-bar"' in _rp_wxml_2 and '打开 PDF 全文' in _rp_wxml_2
      and '购买解锁' in _rp_wxml_2 and 'page-has-bar' in _rp_wxml_2)
check("报告页 吸底栏 iOS 铁律（栏渲染门=unlocked || (sellable && paySupported)）",
      "d.unlocked || (d.sellable && paySupported)" in _rp_wxml_2)
check("报告页 试读尽头 CTA（读完即购，iOS 门控）",
      'rp-cta' in _rp_wxml_2 and 'sampleOpen && d.sellable && !d.unlocked && paySupported' in _rp_wxml_2)
_rp_wxss_2 = read("pages/report/report.wxss")
check("报告页 吸底栏样式（fixed+safe-area+让位 padding）",
      ".rp-bar {" in _rp_wxss_2 and ".page-has-bar" in _rp_wxss_2
      and "env(safe-area-inset-bottom)" in _rp_wxss_2)
_rp_js_2 = read("pages/report/report.js")
check("报告页 购买触感（vibrateShort）", "vibrateShort" in _rp_js_2)
# 商城目录页：变现数据带 + 载入骨架
check("研究页 变现数据带（在售/¥498起/已解锁，可证成实数）",
      "rs-hero-stats" in rs_wxml and "¥498" in rs_wxml
      and "stats.sellable" in rs_wxml and "stats.mine" in rs_wxml)
check("研究页 载入骨架（微光占位替代裸文本）",
      "rs-skel-item" in rs_wxml and "rs-skel-wave" in read("pages/research/research.wxss"))
# 一页一处显眼提示：pot 页只留页首 ai-flag，底部注脚不再重复 AI 生成
_pot_wxml_2 = read("pages/pot/pot.wxml")
check("pot 页 一页一处 AI 提示（页首 ai-flag 唯一，底注只留举报指引）",
      _pot_wxml_2.count('class="ai-flag"') == 1
      and 'pot-ai-note">发现不当内容可点「举报」</view>' in _pot_wxml_2)
check("my 页 咨询记录载入骨架", "my-skel-row" in read("pages/my/my.wxml") and "my-skel-wave" in read("pages/my/my.wxss"))
check("zhiku 页 复制触感（vibrateShort）", "vibrateShort" in read("pages/zhiku/zhiku.js"))
check("tab 栏 按压反馈（hover-class）", 'hover-class="tab-hover"' in read("custom-tab-bar/index.wxml")
      and ".tab-hover" in read("custom-tab-bar/index.wxss"))
check("ask 页 清空键按压反馈", 'hover-class="clear-hover"' in ask_wxml and ".clear-hover" in read("pages/ask/ask.wxss"))
""" % MARK
    # 插在三修 block 之后（文件级锚点：三修块的最后一行是 rp-skel 检查）
    anchor = 'check("报告页 载入骨架（防跳版式）", "rp-skel" in rp_wxml and "rp-skel" in _rp_wxss)'
    assert anchor in s, 'ux gate anchor missing'
    s = s.replace(anchor, anchor + '\n' + gate)
    io.open(p, 'w', encoding='utf-8', newline='').write(s)
    print('patched ux gates')
else:
    print('already patched')

# 版本注释顺带升位：bootsim 里 rp_wxml/rp_wxss/rp_js 变量在三修块已定义，直接复用
