# -*- coding: utf-8 -*-
"""BOOT-SIM v3 for v0.5.1：stub 微信环境，结构化五页 + 用户九点令全量检查。

v0.5.0（用户令）：语音全撤 / 示范性问题 / AI优化提问 / 免费规则 6+四动作赠次 /
打破砂锅 / 批量导出 / 总包AI智库 / 精美小按钮 / 分享标题 / 锅圈页。
v0.5.1（教训级）：home/home 兼容跳板页——线上 1.0.7 老页面表只有 home/home，
无路径入口（体验码/最近使用/会话卡）一律按线上老表解析默认页 → 老表有 home/home
而新包没有 = 页面不存在。修法=包内补 home/home 落地即 reLaunch 咨询首页。
"""
import json
import os
import re
import sys

ROOT = r"E:\AI-Station\WeAppForge\projects\zongbao-ai"

checks = []


def check(name, cond, detail=""):
    checks.append((name, bool(cond), detail))


def read(path):
    return open(os.path.join(ROOT, path), encoding="utf-8").read()


# 1) app.json 结构：五页（问/锅/答/我 + home 兼容跳板）+ 三页签
app_json = json.load(open(os.path.join(ROOT, "app.json"), encoding="utf-8"))
check("app.json pages 五页（问/锅/答/我+home 兼容）", app_json["pages"] == [
    "pages/ask/ask", "pages/pot/pot", "pages/answer/answer", "pages/my/my",
    "pages/home/home"])
check("app.json 入口页仍是 ask（第一位）", app_json["pages"][0] == "pages/ask/ask")
check("app.json tabBar.custom=true", app_json["tabBar"].get("custom") is True)
check("app.json lazyCodeLoading", app_json.get("lazyCodeLoading") == "requiredComponents")
check("app.json 无插件声明（语音插件撤除）", "plugins" not in app_json or "WechatSI" not in app_json.get("plugins", {}))
tab_texts = [it["text"] for it in app_json["tabBar"]["list"]]
check("app.json tabBar 三签=咨询/锅圈/我的", tab_texts == ["咨询", "锅圈", "我的"])
check("app.json tab2=我的（锅圈居中）", app_json["tabBar"]["list"][2]["pagePath"] == "pages/my/my")

for p in app_json["pages"]:
    wxml = read(p + ".wxml")
    js = read(p + ".js")
    json_ = json.load(open(os.path.join(ROOT, p + ".json"), encoding="utf-8"))
    check(f"{p} json navigationStyle=custom", json_.get("navigationStyle") == "custom")
    check(f"{p} js Page() 工厂", "Page({" in js)
    for binder in re.findall(r'bindtap="(\w+)"', wxml):
        check(f"{p} wxml bindtap:{binder} 在 js 有实现", binder in js, binder)
    check(f"{p} nav 绑定存在", "nav.statusBarHeight" in wxml)

# tab 页选中态：问=0 锅=1 我=2
for p, sel in [("pages/ask/ask", 0), ("pages/pot/pot", 1), ("pages/my/my", 2)]:
    js = read(p + ".js")
    check(f"{p} onShow 设置 tabBar selected={sel}", f"selected: {sel}" in js)

# 2) custom-tab-bar 四件套 + 三项
for ext in ["js", "json", "wxml", "wxss"]:
    check(f"custom-tab-bar/index.{ext} 存在", os.path.exists(os.path.join(ROOT, "custom-tab-bar", f"index.{ext}")))
tb_json = json.load(open(os.path.join(ROOT, "custom-tab-bar", "index.json"), encoding="utf-8"))
check("tabBar 组件声明 component:true", tb_json.get("component") is True)
tb_js = read("custom-tab-bar/index.js")
check("tabBar 三项（问/锅/我）", "'锅圈'" in tb_js and "'咨询'" in tb_js and "'我的'" in tb_js)

# 3) wxml 标签配对粗检
for p in app_json["pages"]:
    wxml = read(p + ".wxml")
    for tag in ["view", "block", "scroll-view", "template"]:
        opens = len(re.findall(rf"<{tag}[\s>]", wxml))
        closes = len(re.findall(rf"</{tag}>", wxml))
        selfclosed = len(re.findall(rf"<{tag}[^>]*/>", wxml))
        check(f"{p} <{tag}> 配对 {opens}=={closes}+{selfclosed}", opens == closes + selfclosed, f"{opens}/{closes}/{selfclosed}")

# ══ 用户九点令 v0.5.0 全量检查 ══
ask_js = read("pages/ask/ask.js")
ask_wxml = read("pages/ask/ask.wxml")
ans_wxml = read("pages/answer/answer.wxml")
ans_js = read("pages/answer/answer.js")
my_wxml = read("pages/my/my.wxml")
my_js = read("pages/my/my.js")
pot_js = read("pages/pot/pot.js")
pot_wxml = read("pages/pot/pot.wxml")
api_js = read("utils/api.js")

# 第 1 点：语音全撤
check("utils/voice.js 已删除", not os.path.exists(os.path.join(ROOT, "utils", "voice.js")))
check("ask 无语音残留（onVoiceStart/asrStart）", "onVoiceStart" not in ask_js and "asrStart" not in ask_js)
check("answer 无语音残留（onSpeak/voice.）", "onSpeak" not in ans_js and "voice." not in ans_js)
check("wxml 无语音条（voice-bar/speak-btn）", "voice-bar" not in ask_wxml and "speak-btn" not in ans_wxml)

# 第 2 点：示范性问题
check("ask 常用咨询→示范性问题", "示范性问题 · SAMPLE QUESTIONS" in ask_wxml and "常用咨询" not in ask_wxml)

# 第 3 点：AI优化提问（左）+ 立即咨询（右），按钮在输入框下方
check("ask AI优化提问按钮+实现", 'bindtap="onOptimize"' in ask_wxml and "onOptimize" in ask_js)
check("ask AI优化采用/保留原问（用户过目）", "采用" in ask_js and "保留原问" in ask_js)
check("ask 立即咨询 CTA", "立即咨询" in ask_wxml)
_opt = ask_wxml.find("opt-btn")
_cta = ask_wxml.find("ask-btn")
_inp = ask_wxml.find("ask-input")
check("ask 布局=输入框→按钮排（AI优化左|咨询右）", 0 <= _inp < _opt < _cta, f"{_inp}/{_opt}/{_cta}")

# 第 4 点：免费规则文案（6 次/四动作赠次/0 点清零）
check("ask 规则文案=6次+四动作+0点清零", "免费 6 次" in ask_wxml and "0 点清零" in ask_wxml)
check("my 规则文案=6次+四动作+上不封顶", "每天免费 6 次" in my_wxml and "上不封顶" in my_wxml)

# 第 5 点：打破砂锅 + 批量导出
check("my 工程档案→打破砂锅", "打破砂锅 · FOLDER" in my_wxml and "工程档案" not in my_wxml)
check("my 批量导出按钮+实现", 'bindtap="onExportAll"' in my_wxml and "onExportAll" in my_js)
check("my 批量导出三格式 ActionSheet", "Word" in my_js and "PDF" in my_js and "Markdown" in my_js)
check("api exportAll 客户端", "exportAll" in api_js)

# 第 6 点：总包AI智库专业解答
check("answer 工程大脑→总包AI智库", "总包AI智库 · 专业解答" in ans_wxml and "工程大脑 · 专业解答" not in ans_wxml)
check("answer 绘制中=总包AI智库", "总包AI智库 · 绘制中" in ans_wxml)
check("answer 定位=背后是顶级总包智库", "顶级总包智库" in ask_wxml or "顶级总包智库" in ans_wxml)

# 第 7 点：精美小按钮（pill 排）
check("answer pill-row 五小按钮", "pill-row" in ans_wxml and ans_wxml.count('class="pill') >= 5)
check("answer 分享小按钮=open-type share", 'open-type="share"' in ans_wxml)
check("answer 纠错须写具体意见（必填才赠次）", "写点具体意见才能领次数" in ans_js)
check("answer 复制/导出/纠错实现齐", all(h in ans_js for h in ("onCopy", "onExport", "onCriticize")))

# 第 8 点：分享标题
check("answer 分享标题=总包AI顾问-免费咨询", "总包AI顾问-免费咨询" in ans_js)

# 第 9 点：锅圈页
check("pot 四件套存在", all(os.path.exists(os.path.join(ROOT, "pages", "pot", f"pot.{e}")) for e in ("js", "wxml", "wxss", "json")))
check("pot 锅圈=打破砂锅问到底", "打破砂锅问到底" in pot_wxml)
check("pot 列表 100 字预览+点开全文", "preview" in pot_wxml and "answer?id=" in pot_js)
check("api potList 客户端", "potList" in api_js)
check("api optimize/shareReward 客户端", "optimize" in api_js and "shareReward" in api_js)

# 版本与定位
check("my 版本标记 v0.5.1", "v0.5.1" in my_wxml)
pkg = json.load(open(os.path.join(ROOT, "package.json"), encoding="utf-8"))
check("package.json version=0.5.1", pkg["version"] == "0.5.1")

# ── 0929 教训级防线（沿用）：「页面不存在」根因=同 robot 再上传顶掉被钉体验版 ──
WORK = os.path.abspath(os.path.join(ROOT, "..", "..", "work"))
up_mjs = open(os.path.join(WORK, "upload_qianwen.mjs"), encoding="utf-8").read()
sf_py = open(os.path.join(WORK, "scheme_fire_030.py"), encoding="utf-8").read()
check("uploader robot 1..30 轮转（防钉位孤儿）", "robot_cursor" in up_mjs and "robot," in up_mjs)
check("uploader 上传后自动探针（通道体检）", "trial_health_probe" in up_mjs and "TRIAL_HEALTH_AFTER_UPLOAD" in up_mjs)
check("出码器=码内显式page+免老表校验（新解析）", '"pages/ask/ask"' in sf_py and 'check_path":false' in sf_py)

# ── v0.5.1 教训级防线：home/home 兼容跳板页（页面不存在根治） ──
check("home 兼容页已注册（线上老表 home/home 解析不再 404）", "pages/home/home" in app_json["pages"])
home_js = read("pages/home/home.js")
check("home.js 落地即 reLaunch 咨询首页", "reLaunch" in home_js and "'/pages/ask/ask'" in home_js)
check("home.js 带 switchTab 兜底（reLaunch 失败仍能进）", "switchTab" in home_js)
check("home.wxml 有 statusBarHeight 占位（nav 兼容）", "nav.statusBarHeight" in read("pages/home/home.wxml"))
legacy_hits = []
for _base, _dirs, _files in os.walk(ROOT):
    for _fn in _files:
        if _fn.rsplit(".", 1)[-1] in ("js", "wxml", "wxss", "json", "wxs"):
            _p = os.path.join(_base, _fn)
            try:
                _src = open(_p, encoding="utf-8").read()
            except Exception:
                continue
            if "总包标讯" in _src or "哈萨藏" in _src:
                legacy_hits.append(os.path.relpath(_p, ROOT))
check("包内零老标讯/哈萨藏字样", not legacy_hits, str(legacy_hits))

fails = [c for c in checks if not c[1]]
for name, ok, detail in checks:
    print(("PASS " if ok else "FAIL ") + name + (("  " + detail) if detail and not ok else ""))
print(f"\nBOOT-SIM: {len(checks) - len(fails)}/{len(checks)} PASS")
sys.exit(1 if fails else 0)
