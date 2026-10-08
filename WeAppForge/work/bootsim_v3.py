# -*- coding: utf-8 -*-
"""BOOT-SIM v3 for v0.7.0：stub 微信环境，结构化五页 + 用户令全量检查。

v0.5.0（用户令）：语音全撤 / 示范性问题 / AI优化提问 / 免费规则 6+四动作赠次 /
打破砂锅 / 批量导出 / 总包AI智库 / 精美小按钮 / 分享标题 / 锅圈页。
v0.5.1（教训级）：home/home 兼容跳板页——线上 1.0.7 老页面表只有 home/home，
无路径入口（体验码/最近使用/会话卡）一律按线上老表解析默认页 → 老表有 home/home
而新包没有 = 页面不存在。修法=包内补 home/home 落地即 reLaunch 咨询首页。
v0.7.0（用户十一点令 0930）：付费墙拆除（公益免费）/ 打字机流式 / 深色模式 /
工程大脑→总包智库全局统一 / 快答撤名+接着问→继续追问 / 共享入锅圈按钮 /
锅圈 200 字脱符号预览 / 批量导出重设计 / 依据来源点击展开 / 拓思路文案。
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


# 1) app.json 结构：九页（问/锅/智/研/答/报/我 + legal + home 兼容跳板）+ 五页签
app_json = json.load(open(os.path.join(ROOT, "app.json"), encoding="utf-8"))
check("app.json pages 九页（问/锅/智/研/答/报/我+legal+home 兼容）", app_json["pages"] == [
    "pages/ask/ask", "pages/pot/pot", "pages/zhiku/zhiku", "pages/research/research",
    "pages/report/report", "pages/answer/answer",
    "pages/my/my", "pages/legal/privacy", "pages/home/home"])
check("app.json 入口页仍是 ask（第一位）", app_json["pages"][0] == "pages/ask/ask")
check("app.json tabBar.custom=true", app_json["tabBar"].get("custom") is True)
check("app.json lazyCodeLoading", app_json.get("lazyCodeLoading") == "requiredComponents")
check("app.json 无插件声明（语音插件撤除）", "plugins" not in app_json or "WechatSI" not in app_json.get("plugins", {}))
tab_texts = [it["text"] for it in app_json["tabBar"]["list"]]
check("app.json tabBar 五签=咨询/锅圈/智库/研究/我的", tab_texts == ["咨询", "锅圈", "智库", "研究", "我的"])
check("app.json 研究=倒数第二位、我的=末位（用户令 1008）",
      app_json["tabBar"]["list"][3]["pagePath"] == "pages/research/research"
      and app_json["tabBar"]["list"][4]["pagePath"] == "pages/my/my")

for p in app_json["pages"]:
    wxml = read(p + ".wxml")
    js = read(p + ".js")
    json_ = json.load(open(os.path.join(ROOT, p + ".json"), encoding="utf-8"))
    check(f"{p} json navigationStyle=custom", json_.get("navigationStyle") == "custom")
    check(f"{p} js Page() 工厂", "Page({" in js)
    for binder in re.findall(r'bindtap="(\w+)"', wxml):
        check(f"{p} wxml bindtap:{binder} 在 js 有实现", binder in js, binder)
    check(f"{p} nav 绑定存在", "nav.statusBarHeight" in wxml)

# tab 页选中态：问=0 锅=1 智=2 研=3 我=4
for p, sel in [("pages/ask/ask", 0), ("pages/pot/pot", 1), ("pages/zhiku/zhiku", 2),
               ("pages/research/research", 3), ("pages/my/my", 4)]:
    js = read(p + ".js")
    check(f"{p} onShow 设置 tabBar selected={sel}", f"selected: {sel}" in js)

# 2) custom-tab-bar 四件套 + 四项
for ext in ["js", "json", "wxml", "wxss"]:
    check(f"custom-tab-bar/index.{ext} 存在", os.path.exists(os.path.join(ROOT, "custom-tab-bar", f"index.{ext}")))
tb_json = json.load(open(os.path.join(ROOT, "custom-tab-bar", "index.json"), encoding="utf-8"))
check("tabBar 组件声明 component:true", tb_json.get("component") is True)
tb_js = read("custom-tab-bar/index.js")
check("tabBar 四项（问/锅/智/我）", "'锅圈'" in tb_js and "'咨询'" in tb_js and "'智库'" in tb_js and "'我的'" in tb_js)

# 2b) 智库页 v0.7.2（用户令：底部智库栏 → 飞书「总包智库」知识库）
zk_js = read("pages/zhiku/zhiku.js")
zk_wxml = read("pages/zhiku/zhiku.wxml")
check("智库页 链接=飞书总包智库知识库", "epctalkk.feishu.cn/wiki/space/7689289338592431383" in zk_js)
check("智库页 复制链接用 setClipboardData", "wx.setClipboardData" in zk_js)
# v0.7.4 提审合规：撤二维码/长按识别导流（只留低姿态复制链接）
check("智库页 无二维码放大导流（previewQr 已撤）", "previewQr" not in zk_js and "previewImage" not in zk_js)
check("智库页 无长按识别导流（show-menu-by-longpress 已撤）", "show-menu-by-longpress" not in zk_wxml)
check("智库页 QR 图片已出包（减包体+去导流素材）", not os.path.exists(os.path.join(ROOT, "images", "zhiku-qr.png")))
check("智库页 无「装飞书App/浏览器打开」引导文案", "飞书 App" not in zk_wxml and "手机浏览器" not in zk_wxml)
check("智库页 分享路径=zhiku", "path: '/pages/zhiku/zhiku'" in zk_js)
check("智库页 四库介绍（市场/企业/专家/知识）",
      all(k in zk_js for k in ["市场库", "企业库", "专家库", "知识库"]))

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

# 第 6 点：总包AI智库专业解答（v0.7.0：工程大脑字眼全局统一为总包智库）
check("answer 工程大脑→总包AI智库", "总包AI智库 · 专业解答" in ans_wxml and "工程大脑 · 专业解答" not in ans_wxml)
check("answer 绘制中=总包智库（v0.7.0 统一）", "总包智库 · 绘制中" in ans_wxml)
check("answer 定位=AI 检索行业知识库（可证成口径）", "AI 检索行业知识库" in ask_wxml and "AI 检索行业知识库" in ans_js)

# 第 7 点：精美小按钮（pill 排；v0.7.3 复制全文下线=五钮：有用/导出/纠错/分享/海报）
check("answer pill-row 五小按钮（复制全文已下线）", "pill-row" in ans_wxml and ans_wxml.count('class="pill-glyph"') == 5)
check("answer 分享小按钮=open-type share", 'open-type="share"' in ans_wxml)
check("answer 纠错须写具体意见（必填才赠次）", "写点具体意见才能领次数" in ans_js)
check("answer 导出/纠错实现齐（onCopy 已删）", all(h in ans_js for h in ("onExport", "onCriticize")) and "onCopy" not in ans_js)
check("answer 互动二动作文案（有用/纠错，v0.7.6 分享激励下线）",
      "有用 / 纠错（写具体意见）" in ans_wxml and "/ 分享" not in ans_wxml and "导出 —— " not in ans_wxml)

# 第 8 点：分享标题
check("answer 分享标题=总包AI顾问-免费咨询", "总包AI顾问-免费咨询" in ans_js)

# 第 9 点：锅圈页
check("pot 四件套存在", all(os.path.exists(os.path.join(ROOT, "pages", "pot", f"pot.{e}")) for e in ("js", "wxml", "wxss", "json")))
check("pot 锅圈=打破砂锅问到底", "打破砂锅问到底" in pot_wxml)
check("pot 列表 100 字预览+点开全文", "preview" in pot_wxml and "answer?id=" in pot_js)
check("api potList 客户端", "potList" in api_js)
check("api optimize 客户端（shareReward 已随分享激励下线）", "optimize" in api_js and "shareReward" not in api_js)

# 版本与定位（v0.9.0）
check("my 版本标记 v0.9.0", "v0.9.0" in my_wxml)
pkg = json.load(open(os.path.join(ROOT, "package.json"), encoding="utf-8"))
check("package.json version=0.9.0", pkg["version"] == "0.9.0")

# ══ v0.7.7 拒审 599847679 整改：AI 标识显著级（hero 内嵌 + 三页徽章升级）══
ask_wxss = open(os.path.join(ROOT, "pages", "ask", "ask.wxss"), encoding="utf-8").read()
ans_wxss = open(os.path.join(ROOT, "pages", "answer", "answer.wxss"), encoding="utf-8").read()
check("ask hero 内嵌 AI 显著标识（hero-ai 组件存在）",
      'class="hero-ai"' in ask_wxml and 'class="hero-ai-badge"' in ask_wxml)
check("ask hero-ai 位置=hero-title 与 hero-sub 之间（首屏必现）",
      0 < ask_wxml.find('class="hero-ai"') - ask_wxml.find('class="hero-title"')
      and ask_wxml.find('class="hero-ai"') < ask_wxml.find('class="hero-sub"'))
check("ask hero-ai 徽章文案=AI生成+人工智能全称句",
      ">AI生成</text>" in ask_wxml and "人工智能（AI）生成" in ask_wxml)
check("ask hero-ai 显著级样式（28rpx 白字+橙边深底药丸）",
      ".hero-ai-badge" in ask_wxss and "28rpx" in ask_wxss and "#ffffff" in ask_wxss
      and "rgba(255, 148, 50, 0.9)" in ask_wxss)
check("answer AI 标识徽章升级=AI生成（显著级 28rpx 实底警示条）",
      ">AI生成</view>" in ans_wxml and "font-size: 28rpx" in ans_wxss)
check("pot AI 标识徽章升级=AI生成", ">AI生成</view>" in pot_wxml)

# ══ v0.6.0 100× 弧线全量检查（全免费延伸层：追问/要点/相关/海报/等待）══
check("answer 要点速览卡（TL;DR 3 条）", "tldr-card" in ans_wxml and "要点速览" in ans_wxml)
check("answer 相关问题 chips（点按预填）", "related-card" in ans_wxml and "onRelatedTap" in ans_wxml)
check("answer 追问对话流（气泡+输入框）", "fu-card" in ans_wxml and 'bindinput="onFuInput"' in ans_wxml)
check("answer 追问免费边界话术（v0.7.0：快答撤名）", "快答" not in ans_wxml and "新的正式咨询" in ans_wxml)
check("answer 追问 pending 呼吸点+error 态", "fu-dotpulse" in ans_wxml and "fu-a-error" in ans_wxml)
check("answer 海报按钮+实现", "生成海报" in ans_wxml and "onPoster" in ans_js)
check("answer 海报走 showShareImageMenu+previewImage 兜底", "showShareImageMenu" in ans_js and "previewImage" in ans_js)
check("answer 海报 entrancePath=ask 显式页", "entrancePath: '/pages/ask/ask'" in ans_js)
check("answer digest 失败隐藏（优雅降级）", "_loadDigest" in ans_js and "tldr: []" in ans_js)
check("answer 追问轮询 2s 收敛", "_pollFollowups" in ans_js)
check("answer WXML 零方法调用绑定（WXML 禁 trim()）", ".trim()" not in ans_wxml)
check("ask 相关问题预填线（qw_prefill）", "qw_prefill" in ask_js)
check("api followup/followups/digest/poster 四端点", all(k in api_js for k in ("followup", "followups", "digest", "poster")))
check("answer 等待打勾（分段进度已完成标记）", "proc-check" in ans_wxml and "proc-check" in read("pages/answer/answer.wxss"))

# ══ v0.7.0 用户十一点令全量检查（0930）══
# 第 2 点：打字机流式输出 + 工程大脑→总包智库全局统一
check("answer 打字机流式（partialBlocks+caret）", "partialBlocks" in ans_wxml and "type-caret" in ans_wxml and "caret-bar" in read("pages/answer/answer.wxss"))
check("answer.js 流式渲染 d.partial→md2blocks", "partialBlocks" in ans_js and "stream_chars" in ans_js)
check("answer 已生成字数徽标", "已生成 {{streamChars}} 字" in ans_wxml)
_brain_hits = []
for _base, _dirs, _files in os.walk(ROOT):
    for _fn in _files:
        if _fn.rsplit(".", 1)[-1] in ("js", "wxml", "wxss", "json"):
            _p = os.path.join(_base, _fn)
            try:
                _src = open(_p, encoding="utf-8").read()
            except Exception:
                continue
            if "工程大脑" in _src:
                _brain_hits.append(os.path.relpath(_p, ROOT))
check("工程大脑字眼全局归零（→总包智库）", not _brain_hits, str(_brain_hits))

# 第 5 点：付费墙拆除（公益免费）
check("api 支付腿撤除（paySign/unlockPaid）", "paySign" not in api_js and "unlockPaid" not in api_js)
check("answer 虚拟支付 API 零引用", "requestVirtualPayment" not in ans_js and "paySign" not in ans_js)
check("wxml 付费墙 UI 拆除（lock-note/unlock-bar/onUnlock）",
      "lock-note" not in ans_wxml and "unlock-bar" not in ans_wxml and "onUnlock" not in ans_wxml)
check("answer 全文恒开（answer 字段直取）", "d.answer || d.preview" in ans_js)

# 第 7 点：快答撤名 + 接着问→继续追问
check("answer 接着问→继续追问", "接着问" not in ans_wxml and "继续追问 · 免费" in ans_wxml)
check("answer 相关问题卡标题=继续追问", 'rel-title">继续追问' in ans_wxml)
check("answer 追问输入 placeholder=继续追问", 'placeholder="继续追问（免费）"' in ans_wxml)

# 第 8 点：共享入锅圈（+1 次 / 取消扣 1 次）
check("api shareOn/shareOff 客户端", "shareOn" in api_js and "shareOff" in api_js)
check("answer 共享带 UI（canShare 门控）", "share-band" in ans_wxml and "canShare" in ans_wxml)
check("answer onShareOn/onShareOff 实现", "onShareOn" in ans_js and "onShareOff" in ans_js)
check("answer 取消共享明示扣次确认", "扣除 1 次咨询机会" in ans_js)
check("answer.js 捕获 shared/can_share", "d.can_share" in ans_js and "d.shared" in ans_js)

# 第 11 点：依据来源点击展开
check("api citationFulltext 客户端", "citationFulltext" in api_js)
check("answer 依据条目可点（onCiteTap）", 'bindtap="onCiteTap"' in ans_wxml and "onCiteTap" in ans_js)
check("answer 依据弹窗 showModal 全文", "citationFulltext" in ans_js and "知道了" in ans_js)
check("answer 依据区引导文案=点开看依据解读", "点开看依据解读" in ans_wxml and "点开看法条全文" not in ans_wxml)
check("answer 依据弹窗带 AI 整理口径", "AI 整理的依据解读" in ans_js)

# 第 4 点：锅圈 200 字脱符号预览（服务端已剥符号，前端仅截断处补省略号）
check("pot 预览省略号只在截断处（200 字判据）", "item.preview.length >= 200" in pot_wxml)
check("pot 预览 3 行线夹（-webkit-line-clamp: 3）", "-webkit-line-clamp: 3" in read("pages/pot/pot.wxss"))

# 第 6 点：批量导出重设计 + 拓思路
check("my 拓思路文案", "我来给您拓思路" in my_wxml and "开拓思路" not in my_wxml)
check("my 批量导出重设计（ea-icon 主视觉）", "ea-icon" in my_wxml and "ea-title" in my_wxml and "btn-ghost" not in my_wxml)

# 第 2 点（深色模式）：darkmode 开关 + 主题变量 + 各页收口
check("app.json darkmode=true + themeLocation", app_json.get("darkmode") is True and app_json.get("themeLocation") == "theme.json")
check("theme.json 双套色（light/dark bgColor）",
      os.path.exists(os.path.join(ROOT, "theme.json")) and
      json.load(open(os.path.join(ROOT, "theme.json"), encoding="utf-8"))["dark"]["bgColor"] == "#0c1322")
check("app.wxss 夜航图纸变量翻转块", "prefers-color-scheme: dark" in read("app.wxss") and "--paper: #0c1322" in read("app.wxss"))
for _pg in ("pages/answer/answer", "pages/ask/ask", "pages/my/my", "pages/pot/pot"):
    check(f"{_pg} wxss 深色收口块", "prefers-color-scheme: dark" in read(_pg + ".wxss"))
check("app.json 下拉底色绑主题变量", app_json["window"]["backgroundColor"] == "@bgColor")

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

# ══ v0.7.3 用户令全量检查（1001：导出撤奖/复制全文下线/10年沉淀/周换装主题/
# 观看转发计数/授勋动画/外观画廊）══
# 第 1 点：复制全文按钮+功能全局下线；导出不再赠次
copy_hits = []
for _base, _dirs, _files in os.walk(ROOT):
    for _fn in _files:
        if _fn.rsplit(".", 1)[-1] in ("js", "wxml", "wxss", "json"):
            _p = os.path.join(_base, _fn)
            try:
                _src = open(_p, encoding="utf-8").read()
            except Exception:
                continue
            if "onCopy" in _src or ("setClipboardData" in _src and "zhiku" not in _p) or "bindtap=\"onCopy\"" in _src:
                copy_hits.append(os.path.relpath(_p, ROOT))
check("复制全文/onCopy 全局归零（zhiku 复制链接除外）", not copy_hits, str(copy_hits))
check("answer 赠次只在真实互动（v0.7.6：有用/纠错/共享入锅圈三动作，无分享导出赠次）",
      ans_js.count("this._reward(") == 3 and "onExport" in ans_js)
check("answer.js 无 exportReward 调用", "exportReward" not in ans_js)

# 第 3 点：智库沉淀口径（v0.7.4 提审合规：10年沉淀→持续建设，可证成）
check("zhiku 说法=持续建设（夸大宣传归零）", "持续建设" in read("pages/zhiku/zhiku.wxml") and "10年沉淀" not in read("pages/zhiku/zhiku.wxml"))

# 第 4-6 点：周换装主题系统（七天轮换 + 用户可锁定 + 七套高级调色板）
theme_js = read("utils/theme.js")
check("utils/theme.js 存在", len(theme_js) > 5000)
check("theme 七套调色板", all(k in theme_js for k in ("navy", "graphite", "pine", "obsidian", "violet", "celadon", "forge")))
check("theme 星期映射（getDay 轮换）", "getDay" in theme_js and "weekdayLabel" in theme_js)
check("theme 偏好持久化（setPref/storage）", "setPref" in theme_js and "setStorageSync" in theme_js)
check("theme 导航栏染色（setNavigationBarColor）", "setNavigationBarColor" in theme_js)
for _pg in ("pages/ask/ask", "pages/pot/pot", "pages/zhiku/zhiku", "pages/answer/answer", "pages/my/my",
            "pages/legal/privacy", "pages/home/home"):
    check(f"{_pg} page-meta 注入主题变量", '<page-meta page-style="{{themeStyle}}" />' in read(_pg + ".wxml"))
theme_wired = []
for _pg in ("pages/ask/ask", "pages/pot/pot", "pages/zhiku/zhiku", "pages/answer/answer", "pages/my/my"):
    if "utils/theme" not in read(_pg + ".js") or "theme.apply" not in read(_pg + ".js"):
        theme_wired.append(_pg)
check("五页 onShow theme.apply 接线", not theme_wired, str(theme_wired))
tb_wxml = read("custom-tab-bar/index.wxml")
check("tab-bar 根节点挂 themeStyle", 'style="{{themeStyle}}"' in tb_wxml and "applyTheme" in read("custom-tab-bar/index.js"))

# 第 5 点：外观画廊（我的页可锁定心仪配色）
check("my 外观画廊卡（APPEARANCE）", "外观 · APPEARANCE" in my_wxml and "ap-grid" in my_wxml)
check("my 主题点选/跟随星期 实现", "onThemeTap" in my_js and "onThemeAuto" in my_js)
check("my.wxss 画廊样式（ap-swatch/ap-on）", "ap-swatch" in read("pages/my/my.wxss") and "ap-on" in read("pages/my/my.wxss"))

# 第 7-9 点：观看/转发计数（点开全文 +1 观看；分享/海报传播 +1 转发）
check("answer a-meta 观看/转发 chips", "观看 {{views}}" in ans_wxml and "转发 {{shares}}" in ans_wxml)
check("answer.js views/shares 状态位", "views: 0" in ans_js and "shares: 0" in ans_js)
check("pot 列表 观看/转发 计数展示", "观看 {{item.views}}" in pot_wxml and "转发 {{item.shares}}" in pot_wxml)
check("answer 分享成功同步转发数", "d.shares" in ans_js)

# 第 10 点：授勋动画（游戏级荣誉时刻）
check("answer 授勋动画 mask 结构", "rw-mask" in ans_wxml and "rw-medal" in ans_wxml and "rw-rays" in ans_wxml)
check("answer _reward 实现（震动+2.4s 自动收）", "_reward" in ans_js and "vibrateShort" in ans_js and "2400" in ans_js)
check("answer.wxss 授勋动画样式+关键帧", "rw-mask" in read("pages/answer/answer.wxss") and "@keyframes rwFade" in read("pages/answer/answer.wxss"))
check("answer onUnload 清授勋定时器", "_rwTimer" in ans_js)

# ══ v0.7.4 工程修复（1001：海报深链闭环/首帧主题/震动卫生）══
# 第 1 点：海报深链闭环——scene "s=p&a={aid}" 此前被 ask/home 双双丢弃（审计实锤）
check("ask onLoad 接 options + 解析 scene", "onLoad(options)" in ask_js and "decodeURIComponent" in ask_js and "s=p&a=" in ask_js)
check("ask 海报深链跳 answer?id=（_gotoPoster）", "_gotoPoster" in ask_js and "answer/answer?id=" in ask_js)
check("ask 深链重试有上限（3 次防循环）", "_posterTries" in ask_js and "> 3" in ask_js)
check("home 跳板页同样解析 scene 深链", "onLoad(options)" in home_js and "s=p&a=" in home_js and "decodeURIComponent" in home_js)
# 第 2 点：vibrateShort 全量带 fail 回调（基础库 <2.13 异步 fail 无回调会告警）
check("ask vibrateShort 恰 2 处调用且全带 fail", ask_js.count("wx.vibrateShort({ type: 'light', fail: () => {} })") == 2)
# 第 3 点：首帧主题（onLoad 即 theme.apply，消灭首帧闪白）
_firstframe = [pg for pg in ("pages/ask/ask", "pages/pot/pot", "pages/zhiku/zhiku", "pages/answer/answer", "pages/my/my")
               if read(pg + ".js").count("theme.apply(this)") < 2]
check("五页 onLoad+onShow 双 theme.apply（首帧不闪白）", not _firstframe, str(_firstframe))

# ══ v0.7.4 提审合规防线（1001 合规对抗审查 8 confirmed 全修）══
# A. 极限词/夸大宣传/法律咨询类目风险归零（广告法9条/28条 + 律所资质口径）
_jurisdiction_hits = []
for _base, _dirs, _files in os.walk(ROOT):
    for _fn in _files:
        if _fn.rsplit(".", 1)[-1] in ("js", "wxml", "wxss", "json"):
            _p = os.path.join(_base, _fn)
            try:
                _src = open(_p, encoding="utf-8").read()
            except Exception:
                continue
            if "顶级" in _src or "病毒" in _src or "裂变" in _src:
                _jurisdiction_hits.append(os.path.relpath(_p, ROOT))
check("极限词/敏感增长措辞全局归零（顶级/病毒/裂变）", not _jurisdiction_hits, str(_jurisdiction_hits))
check("ask hero 无「法务/诉讼」服务范围声明", "法务" not in ask_wxml and "诉讼" not in ask_wxml)
check("ask hero 无 7×24 时限承诺", "7×24" not in ask_wxml and "7×24" not in my_wxml)
check("hero 口径=AI 检索行业知识库生成（可证成）",
      "AI 检索行业知识库" in ask_wxml and "AI 检索行业知识库" in read("pages/home/home.wxml")
      and "顶级" not in pot_wxml)

# B. AI 生成标识三面（AI标识办法：正文/追问/锅圈公开展示面）
check("answer 正文卡常驻 AI 生成标识", "内容由 AI 生成" in ans_wxml and "ai-note" in ans_wxml)
check("answer 追问卡 AI 标识", "追问回答同样由 AI 生成" in ans_wxml)
check("pot 锅圈 AI 标识（公开展示面）", "内容由 AI 生成" in pot_wxml and "pot-ai-note" in pot_wxml)

# C. 隐私合规：legal 页 + 首次提问告知 + my 入口
check("legal 页四件套存在", all(os.path.exists(os.path.join(ROOT, "pages", "legal", f"privacy.{e}")) for e in ("js", "wxml", "wxss", "json")))
check("legal 页含用户协议+隐私政策双区块", "用户协议" in read("pages/legal/privacy.wxml") and "隐私政策" in read("pages/legal/privacy.wxml") and "openid" in read("pages/legal/privacy.wxml"))
check("ask 首次提问隐私告知（qw_privacy_ok 门）", "qw_privacy_ok" in ask_js and "隐私保护告知" in ask_js)
check("my 页用户协议·隐私政策入口", "goPrivacy" in my_js and "用户协议 · 隐私政策" in my_wxml)

# D. UGC 合规：锅圈举报入口 + 服务端 msgSecCheck 闸
check("pot 举报入口（onReport + catchtap 防冒泡）", 'catchtap="onReport"' in pot_wxml and "onReport" in pot_js)
check("pot 举报必填原因", "请填写举报原因" in pot_js)
check("api potReport 客户端", "potReport" in api_js)
ENGINE = r"E:\AI-Station\services\qianwen-engine"
_wx_py = open(os.path.join(ENGINE, "qianwen_engine", "wechat.py"), encoding="utf-8").read()
_app_py = open(os.path.join(ENGINE, "qianwen_engine", "app.py"), encoding="utf-8").read()
check("服务端 msg_sec_check v2 实现", "msg_sec_check" in _wx_py and '"version": "2"' in _wx_py)
check("share_on 入库前过安检门（fail-closed 503）", "msg_sec_check" in _app_py and "内容未通过安全检测" in _app_py and "503" in _app_py)
check("服务端 pot 举报端点", "/api/pot/report" in _app_py)
check("session_key 服务端落库供查单签名（不下发客户端）",
      "save_session" in _app_py and 'sess.get("session_key")' in _app_py
      and "session_key=\"," not in _app_py)

# E. 分享回流注释中性化 + 等待预期管理
check("answer 分享回流注释中性（无病毒环措辞）", "携带小程序入口" in ans_js and "病毒" not in ans_js)
check("answer 等待文案带高峰期预期", "高峰期可能排队稍久" in ans_wxml)

# ══ v0.8.0 用户令 1008（咨询全免费 + 导出 ¥0.1/条 + 智库四库 34 分组同步）══
pay_js_path = os.path.join(ROOT, "utils", "pay.js")
pay_js = open(pay_js_path, encoding="utf-8").read() if os.path.exists(pay_js_path) else ""
check("pay.js 存在（虚拟支付封装）", bool(pay_js))
check("pay.js iOS 隐藏付费入口（platform!=='ios' 闸）", "_platform !== 'ios'" in pay_js)
check("pay.js 签名三件套逐字节透传（不重序列化）",
      "signData: sign.sign_data" in pay_js and "paySig: sign.pay_sig" in pay_js
      and "signature: sign.signature" in pay_js)
check("pay.js 静默取消识别（cancel 不误报错）", "silentCancel" in pay_js)
check("pay.js 503 降级文案（未开通不硬崩）", "statusCode === 503" in pay_js)
check("api.js v0.8.0 四端点（exportSign/exportAllSign/requestRaw）",
      "exportSign" in api_js and "exportAllSign" in api_js and "requestRaw" in api_js)
check("answer 导出付费墙（¥0.1 弹窗+已解锁直通）",
      "支付 0.1 元" in ans_js and "_exportSheet" in ans_js and "exportPaid" in ans_js)
check("answer 导出 iOS 闸（payOk=false 时 toast 拒绝）",
      "payOk: pay.paySupported()" in ans_js and "暂不支持导出" in ans_js)
check("answer 导出 pill iOS 新付费隐藏+已解锁可见（payOk||exportPaid）",
      'wx:if="{{payOk || exportPaid}}"' in ans_wxml and "导出 ¥0.1" in ans_wxml)
check("my 批量导出付费墙（N×0.1 一单付清）",
      "payExportAll" in my_js and "0.1" in my_js and "_exportAllSheet" in my_js)
check("my 批量导出入口 iOS 新付费隐藏+全解锁可见（payOk||exportUnpaidAll===0）",
      'wx:if="{{payOk || exportUnpaidAll === 0}}"' in my_wxml and "¥0.1/条" in my_wxml)
# 智库 v2：四库 34 分组（5+4+7+18）+ 诚实库存
_zk_subs = re.findall(r"subs: \[([^\]]+)\]", zk_js)
_zk_counts = [len(re.findall(r"'", s)) // 2 for s in _zk_subs]
check("智库页 四库 34 分组（5+4+7+18）", _zk_counts == [5, 4, 7, 18], str(_zk_counts))
check("智库页 分组抽样（科思顿月度观察/SVIP私房课/政策法规资讯）",
      "科思顿·工程行业月度观察" in zk_js and "SVIP私房课" in zk_js and "政策法规资讯" in zk_js)
check("智库页 诚实库存四数（1855/847/906/620）",
      all(k in zk_js for k in ["1855", "847", "906", "620"]))
check("智库页 持续入库口径（不吹全量）", "持续迁移入库" in zk_wxml)
check("智库页 v0.7.4 合规防线仍在（无二维码/长按导流）",
      "previewQr" not in zk_js and "show-menu-by-longpress" not in zk_wxml)
# 引擎侧：导出收费闸门 + 旧 1 元解锁下线
_cfg_py = open(os.path.join(ENGINE, "qianwen_engine", "config.py"), encoding="utf-8").read()
check("引擎 EXPORT_PRICE_FEN=10（¥0.1/条）", "EXPORT_PRICE_FEN = 10" in _cfg_py)
check("引擎 EXPORT_BATCH_MAX=99（批量护栏）", "EXPORT_BATCH_MAX = 99" in _cfg_py)
check("引擎 导出四腿端点（export_sign/export_paid/export_all_sign/export_all_paid）",
      "/api/answer/{aid}/export_sign" in _app_py and "/api/answer/{aid}/export_paid" in _app_py
      and "/api/answers/export_all_sign" in _app_py and "/api/answers/export_all_paid" in _app_py)
check("引擎 导出闸门 402（未解锁不放行）", 'HTTPException(402' in _app_py)
check("引擎 旧 ¥1 解锁双腿已下线（pay_sign/unlock_paid 零引用）",
      "def pay_sign" not in _app_py and "def unlock_paid" not in _app_py)
check("引擎 buyQuantity=未解锁条数（批量计价走数量）", '"buyQuantity": len(unpaid)' in _app_py)
check("引擎 详情腿下发 export_paid/is_owner", '"export_paid":' in _app_py and '"is_owner":' in _app_py)
check("引擎 otn 时间戳后缀（跨次唯一）", "_make_otn" in _app_py and "time.time() * 1000" in _app_py)

# ══ v0.8.0 对抗审计整改（paychain+compliance 双审计全量收敛）══
# 订单核验链：pay_order 表 + 微信查单 + 生产 fail-closed
check("引擎 pay_order 订单表（otn 主键 dialect 双写）", "create_pay_order" in _app_py)
_store_py = open(os.path.join(ENGINE, "qianwen_engine", "store.py"), encoding="utf-8").read()
check("store pay_order 五件（create/get/open/mark_many）",
      "def create_pay_order" in _store_py and "def get_pay_order" in _store_py
      and "def open_pay_order" in _store_py and "def mark_order_paid" in _store_py
      and "def mark_export_paid_many" in _store_py)
check("wechat.xpay_query_order 查单核验（pay_sig+signature 双签）",
      "def xpay_query_order" in _wx_py and "XpayError" in _wx_py)
check("引擎 _verify_order_paid 生产 fail-closed（503 对账中）",
      "_verify_order_paid" in _app_py and "支付对账中" in _app_py)
check("引擎 409 已收口三态（单篇已解锁/单篇到账/批量到账）",
      'HTTPException(409, "本篇导出已解锁")' in _app_py
      and "支付已到账，本篇导出已解锁" in _app_py
      and "支付已到账，已解锁" in _app_py)
check("引擎 未支付订单复用同 otn（HIGH-3 防二次扣款）",
      "open_pay_order" in _app_py and "复用同一未付订单" in _app_py)
check("引擎 批量 otn/attach 不含 openid 明文（sha256 锚）",
      'hashlib.sha256(openid.encode()).hexdigest()[:16]' in _app_py)
check("引擎 otn 熵补齐（secrets.token_hex）", "secrets.token_hex(2)" in _app_py)
check("引擎 history 下发 export_unpaid_all（服务端权威计数）", "export_unpaid_all" in _app_py)
check("引擎 旧分享赠次端点已下线（/share 404 回归锚）",
      '@app.post("/api/answer/{aid}/share")' not in _app_py
      and "已下线" in _app_py)
# 客户端收口语义
check("pay.js 409 已解锁收口（不二次拉起支付）",
      "_catchSign" in pay_js and "statusCode === 409" in pay_js)
check("pay.js 已扣款核验抖断不谎报（reconciling 对账文案）",
      "reconciling: true" in pay_js and "正在对账" in pay_js)
check("answer.js reconciling 分支（重取详情自然解锁）",
      "res.reconciling" in ans_js)
check("my.js 服务端权威计数 exportUnpaidAll（弹窗金额不吃 20 条截断亏）",
      "exportUnpaidAll" in my_js and "export_unpaid_all" in my_js)
check("my.js 单笔 99 条上限引导（超量分批）",
      "一次最多解锁 99 条" in my_js)
check("my.js reconciling 分支（刷新不谎报）", "res.reconciling" in my_js)
check("ask.wxml 赠次口径无分享（诱导分享归零）", "有用/纠错 各+1次" in ask_wxml and "有用/分享/纠错" not in ask_wxml)
_pv = read("pages/legal/privacy.wxml")
check("legal 付费导出条款（收费说明+退款口径+iOS 不售）",
      "导出服务（收费说明）" in _pv and "¥0.1/条" in _pv and "不支持退款" in _pv and "iOS 端不提供" in _pv)
check("legal 隐私收集含商户订单号③（支付对账）", "商户订单号" in _pv)
check("legal 服务性质不再宣称免费公益（咨询免费+导出可选付费）",
      "免费公益" not in _pv and "可选付费服务" in _pv)
check("zhiku 分享标题去绝对化（无四库全通）", "四库全通" not in zk_js)
_exp_py = open(os.path.join(ENGINE, "qianwen_engine", "exporter.py"), encoding="utf-8").read()
check("exporter 三格式尾行 AI 检索口径", _exp_py.count("AI 检索行业知识库生成") >= 3)
# 服务端回归锚：审计整改测试套件在役
_tep = os.path.join(ENGINE, "tests", "test_export_pay.py")
check("test_export_pay.py 在役（订单核验回归 21 用例）",
      os.path.exists(_tep) and "test_prod_query_outage_fail_closed" in open(_tep, encoding="utf-8").read())

# ══ v0.9.0 用户令 1008（研究报告商城整合：tab 研究 + 目录/详情/试读/购买/PDF 六腿）══
rs_js = read("pages/research/research.js")
rs_wxml = read("pages/research/research.wxml")
rp_js = read("pages/report/report.js")
rp_wxml = read("pages/report/report.wxml")
check("研究页四件套存在", all(os.path.exists(os.path.join(ROOT, "pages", p, f"{p}.{e}"))
      for p in ("research", "report") for e in ("js", "wxml", "wxss", "json")))
check("自绘 tabBar 五 tab（研=倒数第二）",
      "pages/research/research" in read("custom-tab-bar/index.js")
      and read("custom-tab-bar/index.js").find("pages/research/research") < read("custom-tab-bar/index.js").find("pages/my/my"))
check("研究页 目录腿 api.reportList + 分类筛（含已购）",
      "reportList" in rs_js and "mine" in rs_js and "flagship" in rs_js)
check("研究页 整理中口径（可看不可买）", "整理中" in rs_wxml)
check("研究页 AI 辅助研究口径注脚（可证成）", "AI 辅助研究方法" in rs_wxml)
check("报告页 详情+试读腿（reportDetail/reportSample）",
      "reportDetail" in rp_js and "reportSample" in rp_js)
check("报告页 购买走 pay.payReport（vpay 通道）", "payReport" in rp_js)
check("报告页 PDF=downloadFile+openDocument（Bearer 头）",
      "wx.downloadFile" in rp_js and "openDocument" in rp_js and "Authorization" in rp_js)
check("报告页 iOS 购买入口隐藏（paySupported 闸在 wxml）",
      "paySupported" in rp_wxml and "iOS 暂不支持应用内购买" in rp_wxml)
check("报告页 整理中不可买态", "暂未开售" in rp_wxml)
check("报告页 一次解锁永久阅读口径", "永久阅读" in rp_wxml)
check("api.js 报告五端点（List/Detail/Sample/Sign/PdfUrl）",
      all(k in api_js for k in ("reportList", "reportDetail", "reportSample", "reportSign", "reportPdfUrl")))
check("pay.js payReport（报告解锁腿）", "payReport" in pay_js)
check("my 页 我的报告书架（reportMine+goReports）", "reportMine" in my_js and "goReports" in my_js and "goReports" in my_wxml)
check("research 分享标题（总包研究）", "总包研究" in rs_js)
# 引擎侧：报告商城六腿 + 可售判定 + 订单语义
_rc_py = open(os.path.join(ENGINE, "qianwen_engine", "report_catalog.py"), encoding="utf-8").read()
check("引擎 报告六腿端点（reports/detail/sample/unlock_sign/unlock_paid/pdf）",
      '@app.get("/api/reports")' in _app_py and '@app.get("/api/report/{sku}")' in _app_py
      and '@app.get("/api/report/{sku}/sample")' in _app_py
      and '@app.post("/api/report/{sku}/unlock_sign")' in _app_py
      and '@app.post("/api/report/{sku}/unlock_paid")' in _app_py
      and '@app.get("/api/report/{sku}/pdf")' in _app_py)
check("引擎 报告订单 kind='report' aid=sku（复用 pay_order）",
      '"report"' in _app_py and 'aid=sku' in _app_py)
check("引擎 价格分档道具 report_product_<元>",
      "report_product_{" in _app_py and "report_product_" in _cfg_py)
check("引擎 可售判定=PDF 存在且≤20MB（无货/超大自动整理中）",
      "REPORT_PDF_MAX_BYTES" in _cfg_py and "REPORT_PDF_MAX_BYTES" in _rc_py)
check("引擎 目录软鉴权（未登录可浏览）", "_openid_soft" in _app_py)
check("引擎 PDF 闸门 402（未购不放行）", 'HTTPException(402, "购买后可查看完整报告")' in _app_py)
check("store report_unlocks（openid×sku 幂等解锁）",
      "report_unlocks" in _store_py and "def mark_report_paid" in _store_py
      and "def report_unlocked_skus" in _store_py)
_trm = os.path.join(ENGINE, "tests", "test_report_mall.py")
check("test_report_mall.py 在役（商城回归）",
      os.path.exists(_trm) and "test_unlock_paid_forged_and_cross_user" in open(_trm, encoding="utf-8").read())

fails = [c for c in checks if not c[1]]
for name, ok, detail in checks:
    print(("PASS " if ok else "FAIL ") + name + (("  " + detail) if detail and not ok else ""))
print(f"\nBOOT-SIM: {len(checks) - len(fails)}/{len(checks)} PASS")
sys.exit(1 if fails else 0)
