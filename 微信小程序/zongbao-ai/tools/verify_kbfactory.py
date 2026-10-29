# -*- coding: utf-8 -*-
"""W4+W6 自检门（DoD）——知识库蓝图页挂载与支付/导出/整库下单校验。

检查项：
  1. app.json 可解析；pages 含 pages/kbfactory/kbfactory 且在尾部；原 10 页顺序不变（回归锚）
  2. 页面四件套存在（wxml/wxss/js/json）
  3. wxml 未闭合标签粗检（标签配对计数，自闭合不计开）
  4. js 语法：有 node 走 node --check；无 node 退化为括号配对粗查
  5. 样本 JSON 可解析、≤200KB、含 tree/ratio/stats/quote 四键
  5b. W3 evidence 真调研样本契约键（sample_evidence.json 的
      provenance.evidence.pool_size/real_file_ratio 在场）
  6. 敏感词自检：新页面/服务层/订单海报模块/样本全文 + zhiku 新增块，不得出现 渠道名/技术词
  7. W6 接线：付费按钮 iOS 分支（js 守卫+wxml 门控）· 邮箱校验 · 订单 payload 四键+摘要五键
     · 海报函数被导出按钮调用+相册拒绝预览降级 · 合规三句/履约中状态页文案
  8. W6 冒烟：node 在位时并入 DoD（支付成功/取消/409 三分支 + payload 组装 + 本地订单箱）
  11. 收口波A 呈现层：对比锚文案 · 价值条四计数（实测）· 三视图 tab（JS 直译映射表全名）
      · 平铺组单层列表 · 预览站点入口（端点置空如实）· 导览层旗 guided · iOS 双门不碰
  12. A 案真调研接线：三层兜底函数在场（callEvidence→callRemote→generateLocal）·
      KB_EVIDENCE_ENDPOINT 常量（本地实测位+ECS 上线注释）· 轮询节奏 3s/130s 封顶 ·
      三段直播映射 · 渠道计数不编造 · 失败带原因 · 页面换轨处理 ·
      价值条真调研计数（provenance.evidence_tree.pool_size 真值）· 模式徽章认得真调研树
  13. D 轴实时直播升级（2.0 版）：evidenceLiveLine 真值折算函数在场（直播键
      channels_live/clusters_forming 缺键 undefined 不编造）· 副文案逻辑（段0
      渠道名 n 件逐渠道滚动 · 段1 正在形成 N 个主题分组）
用法：py -3 tools/verify_kbfactory.py （于 zongbao-ai 根目录）
"""
import json
import re
import shutil
import subprocess
import sys
import sys as _sys
try:
    _sys.stdout.reconfigure(encoding="utf-8", errors="replace")
except Exception:
    pass
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]  # zongbao-ai/
PAGE = "pages/kbfactory"
ORIG_PAGES = [  # 挂载前既有页序（回归锚：顺序一根不动）
    "pages/ask/ask", "pages/pot/pot", "pages/zhiku/zhiku", "pages/research/research",
    "pages/report/report", "pages/answer/answer", "pages/my/my", "pages/legal/privacy",
    "pages/invoice/invoice", "pages/home/home",
]
BANNED = ["ima", "wenku", "文库", "飞书", "feishu", "api"]  # 渠道名/技术词（大小写不敏感）
# 英文词用字母边界匹配（防 animation/primary 等英文单词内部的假阳性；ima_public 这类真令牌仍命中）
BANNED_RE = {w: re.compile(r"(?<![a-zA-Z])" + w + r"(?![a-zA-Z])", re.IGNORECASE)
             for w in BANNED if w.isascii()}

RESULTS = []


def check(name, ok, detail=""):
    RESULTS.append(ok)
    print(("[PASS] " if ok else "[FAIL] ") + name + ((" · " + detail) if detail else ""))


def rel(p):
    return str(Path(p).relative_to(ROOT)).replace("\\", "/")


def scan_banned(name, text):
    hits = sorted({w for w in BANNED
                   if (BANNED_RE[w].search(text) if w in BANNED_RE else w in text)})
    check(name, not hits, "命中敏感词: " + ",".join(hits) if hits else "")


# ── 1. app.json ──
app = json.loads((ROOT / "app.json").read_text(encoding="utf-8"))
pages = app["pages"]
check("app.json 可解析且结构完整", isinstance(pages, list) and len(pages) >= 11)
check("pages 含新页且在尾部", pages[-1] == "pages/kbfactory/kbfactory")
check("原 pages 顺序不变（回归锚）", pages[:len(ORIG_PAGES)] == ORIG_PAGES)

# ── 2. 四件套 ──
quad = ["kbfactory.wxml", "kbfactory.wxss", "kbfactory.js", "kbfactory.json"]
missing = [f for f in quad if not (ROOT / PAGE / f).is_file()]
check("页面四件套存在", not missing, "缺: " + ",".join(missing) if missing else "")

# ── 3. wxml 标签配对粗检 ──
TAGS = ["view", "text", "button", "textarea", "input", "block", "image", "qw-pop", "br"]
for wxml in [ROOT / PAGE / "kbfactory.wxml", ROOT / "pages/zhiku/zhiku.wxml"]:
    src = wxml.read_text(encoding="utf-8")
    bad = []
    for t in TAGS:
        self_closed = len(re.findall(r"<%s\b[^>]*/>" % t, src))
        opens = len(re.findall(r"<%s\b" % t, src)) - self_closed
        closes = len(re.findall(r"</%s\s*>" % t, src))
        if opens != closes:
            bad.append(f"{t}:{opens}开/{closes}闭")
    check(f"wxml 标签配对粗检 {rel(wxml)}", not bad, " ".join(bad))

# ── 4. js 语法 ──
js_files = [ROOT / PAGE / "kbfactory.js", ROOT / "utils/kbfactory_service.js",
            ROOT / "utils/kbfactory_pay.js", ROOT / "utils/kbfactory_poster.js",
            ROOT / "pages/zhiku/zhiku.js"]
node = shutil.which("node")
if node:
    for js in js_files:
        r = subprocess.run([node, "--check", str(js)], capture_output=True, text=True,
                           encoding="utf-8", errors="replace")
        check(f"node --check {rel(js)}", r.returncode == 0, (r.stderr or "").strip().splitlines()[-1] if r.returncode else "")
else:
    for js in js_files:
        src = js.read_text(encoding="utf-8")
        pairs = {"(": ")", "[": "]", "{": "}"}
        stack, bad = [], False
        for ch in src:
            if ch in pairs:
                stack.append(pairs[ch])
            elif ch in pairs.values():
                if not stack or stack.pop() != ch:
                    bad = True
                    break
        check(f"括号配对粗查 {rel(js)}（无 node）", not bad and not stack)

# ── 5. 样本 ──
samples = sorted((ROOT / PAGE / "samples").glob("sample_*.json"))
check("三份样本存在（water/law/evidence）", len(samples) == 3, " ".join(rel(s) for s in samples))
for sp in samples:
    size = sp.stat().st_size
    check(f"样本 ≤200KB {rel(sp)}", size <= 200 * 1024, f"{size / 1024:.0f}KB")
    data = json.loads(sp.read_text(encoding="utf-8"))
    keys_ok = all(k in data for k in ("tree", "ratio", "stats", "quote"))
    check(f"样本含 tree/ratio/stats/quote {rel(sp)}", keys_ok)
    st, q = data["stats"], data["quote"]
    print(f"       ↳ {rel(sp)}: files={st['files']} gb={st['gb']} quote.total=¥{q['total']} "
          f"l1={st['l1_count']} l2={st['l2_count']}")

# 5b. W3 evidence 真调研样本契约键（编目树基于真实调研生成的验收锚）
_ev_path = ROOT / PAGE / "samples" / "sample_evidence.json"
_ev_data = json.loads(_ev_path.read_text(encoding="utf-8")) if _ev_path.is_file() else {}
_ev_prov = (_ev_data.get("provenance") or {}).get("evidence") or {}
check("W3 evidence 样本契约键（provenance.evidence.pool_size/real_file_ratio 在场）",
      _ev_path.is_file() and "pool_size" in _ev_prov and "real_file_ratio" in _ev_prov
      and isinstance(_ev_data.get("tree", {}).get("l1"), list))

# ── 6. 敏感词自检 ──
for f in [ROOT / PAGE / x for x in quad] + [ROOT / "utils/kbfactory_service.js",
                                            ROOT / "utils/kbfactory_pay.js",
                                            ROOT / "utils/kbfactory_poster.js"] + samples:
    scan_banned(f"敏感词 {rel(f)}", f.read_text(encoding="utf-8"))
zw = (ROOT / "pages/zhiku/zhiku.wxml").read_text(encoding="utf-8")
m = re.search(r"<!-- ══ 知识库蓝图设计[\s\S]*?总包智库[\s\S]*?六库图纸目录", zw)
scan_banned("敏感词 zhiku.wxml 新增入口卡块", m.group(0) if m else "MISSING-BLOCK")
check("zhiku.wxml 含 KB-FACTORY 入口卡", bool(m))
zj = (ROOT / "pages/zhiku/zhiku.js").read_text(encoding="utf-8")
m2 = re.search(r"// KB-FACTORY 入口[\s\S]*?\n  },", zj)
scan_banned("敏感词 zhiku.js 新增 handler 块", m2.group(0) if m2 else "MISSING-BLOCK")
check("zhiku.js 含 goKbFactory handler", bool(m2) and "navigateTo" in m2.group(0))
zcss = (ROOT / "pages/zhiku/zhiku.wxss").read_text(encoding="utf-8")
m3 = re.search(r"/\* ══ KB-FACTORY[\s\S]*?══ 蓝图头部", zcss)
scan_banned("敏感词 zhiku.wxss 新增样式块", m3.group(0) if m3 else "MISSING-BLOCK")

# ── 7. W6 接线：支付/导出/整库下单 ──
kbjs = (ROOT / PAGE / "kbfactory.js").read_text(encoding="utf-8")
kbwxml = (ROOT / PAGE / "kbfactory.wxml").read_text(encoding="utf-8")
kbpay = (ROOT / "utils/kbfactory_pay.js").read_text(encoding="utf-8")
kbposter = (ROOT / "utils/kbfactory_poster.js").read_text(encoding="utf-8")

# 7.1 付费按钮 iOS 分支：js 双门守卫 + wxml 至少两处 wx:if 门控（带走整库/导出蓝图）
check("W6 付费按钮 iOS 分支存在（js 守卫 + wxml 门控≥2）",
      "pay.paySupported()" in kbjs
      and len(re.findall(r'wx:if="\{\{paySupported\}\}"', kbwxml)) >= 2)
check("W6 导出件 iOS 可看（免费分享卡不挂付费门）",
      (lambda mp: bool(mp) and "paySupported" not in mp.group(0))(re.search(r'<button class="kf-poster".*?</button>', kbwxml, re.S)))

# 7.2 邮箱校验（必填+格式）
check("W6 邮箱格式校验存在（模块定义+页面调用）",
      "function isValidEmail" in kbpay and "@" in kbpay and ".test(" in kbpay
      and "isValidEmail" in kbjs)

# 7.3 订单 payload 四键 + 蓝图摘要五键
mb = re.search(r"function buildOrderPayload[\s\S]*?\n}", kbpay)
check("W6 订单 payload 四键 need_text/blueprint/email/version",
      bool(mb) and all(k in mb.group(0) for k in ("need_text", "blueprint", "email", "version")))
md = re.search(r"function digestOf[\s\S]*?\n}", kbpay)
check("W6 蓝图摘要五键 domain/files/gb/total/version_sha",
      bool(md) and all(k in md.group(0) for k in ("domain", "files", "gb", "total", "version_sha")))

# 7.4 海报函数被导出按钮调用（解锁成功后绘长图）+ 相册拒绝→预览降级
mexp = re.search(r"onExport\(\)\s*\{[\s\S]*?\n  \},", kbjs)
check("W6 海报函数被导出按钮调用",
      bool(mexp) and "generateBlueprintPoster" in mexp.group(0) and "payBlueprintExport" in mexp.group(0))
check("W6 海报模块定义长图/分享卡两函数",
      "function generateBlueprintPoster" in kbposter and "function generateShareCard" in kbposter)
check("W6 存相册拒绝→预览降级",
      "saveImageToPhotosAlbum" in kbjs and "previewImage" in kbjs)

# 7.5 合规三句 + 状态页文案（履约中·v1 无进度轮询，文案注明）
for s in ("公开资料", "邮箱与网盘双通道", "2 小时内"):
    check(f"W6 合规三句含「{s}」", s in kbwxml)
check("W6 状态页文案（履约中+无进度轮询注明）",
      "履约中" in kbwxml and "暂不支持进度查询" in kbwxml)

# ── 8. W6 冒烟并入 DoD（node 在位时；缺席则跳过不计败——与第 4 节同策略）──
if node:
    r = subprocess.run([node, "tools/kbfactory_pay_smoke.js"], cwd=str(ROOT),
                       capture_output=True, text=True, encoding="utf-8", errors="replace")
    out = (r.stdout or "").strip().splitlines()
    check("W6 支付/订单冒烟 node 全绿", r.returncode == 0, out[-1] if out else "")

# ── 9. v2 document_driven 渲染适配（模式检测·真实检索徽章·超越层配比条）──
kbwxss = (ROOT / PAGE / "kbfactory.wxss").read_text(encoding="utf-8")
check("v2 模式检测（页面 js+wxml 认得 document_driven）",
      "document_driven" in kbjs and "document_driven" in kbwxml)
check("v2 文件徽章 真实检索/占位（wxml 文案+wxss 徽章样式）",
      "✓ 真实检索" in kbwxml and "○ 占位" in kbwxml
      and ".kf-real" in kbwxss and ".kf-real.on" in kbwxss)
mrs = re.search(r"_buildRatioSegs\(bp\)\s*\{[\s\S]*?\n  \}", kbjs)
check("v2 配比按超越层名渲染（ratioSegs 派生·剔除 core/field/guide 兼容键）",
      bool(mrs) and "document_driven" in mrs.group(0)
      and all(k in mrs.group(0) for k in ("core", "field", "guide"))
      and re.search(r'wx:for="\{\{ratioSegs\}\}"', kbwxml) is not None)
check("v2 超越层第四段配色 + L1 名称/描述渲染锚",
      "kf-seg-plus" in kbwxss and "kf-dot-plus" in kbwxss
      and "{{l1.name}}" in kbwxml and "{{l1.theme}}" in kbwxml)

# ── 10. 轨A4 蓝图深度三档（标准版/专业版/旗舰版：控件+透传+档位如实可见）──
kbsvc = (ROOT / "utils/kbfactory_service.js").read_text(encoding="utf-8")
check("A4 三档控件存在（wxml 三档文案+点选器+js 处理器）",
      all(s in kbwxml for s in ("标准版", "专业版", "旗舰版"))
      and all(('data-d="%s"' % k) in kbwxml for k in ("standard", "pro", "flagship"))
      and "onDepthPick" in kbwxml and "onDepthPick" in kbjs)
check("A4 默认档=标准版（页面 data 默认 + 三档名映射）",
      "depth: 'standard'" in kbjs
      and all(("%s: '%s'" % (k, n)) in kbjs
              for k, n in (("standard", "标准版"), ("pro", "专业版"), ("flagship", "旗舰版"))))
check("A4 服务层透传 depth（远端数据带 text+depth+guided 导览旗，双入口收参）",
      re.search(r"data:\s*\{\s*text:\s*text,\s*depth:\s*depth\s*\|\|\s*'standard',\s*guided:\s*true\s*\}", kbsvc) is not None
      and "callRemote(text, depth)" in kbsvc and "generateRemote(needText, depth)" in kbsvc)
check("A4 生成链带档位（页面 generate 传所选档）",
      "this.data.depth" in kbjs and re.search(r"kbf\.generate\(t,", kbjs) is not None)
check("A4 蓝图档位如实可见（取蓝图 provenance.depth 真值渲染徽标）",
      "_depthBadge" in kbjs and "provenance.depth" in kbjs
      and "{{depthBadge}}" in kbwxml and "文件 ' + files + ' 项" in kbjs)

# ── 11. 收口波A 呈现层（对比锚·价值条·三视图 tab·预览入口·导览层旗）──
# 11.1 对比锚：报价卡静态文案（市场事实表述非 AI 词，muted 小字）
check("A锚 对比锚文案在报价区（人工代建≈8000 元/月起·一次性交付）",
      all(s in kbwxml for s in ("人工代建同类知识库", "≈8000 元/月起", "一次性交付"))
      and 'class="muted kf-anchor"' in kbwxml and ".kf-anchor" in kbwxss)

# 11.2 价值条四计数：全部实测（real 计数/stats 真值/徽章种类），禁手填
mvb = re.search(r"_buildValueBadges\(bp\)\s*\{[\s\S]*?\n  \},", kbjs)
check("A价值条四计数实测（真实文件 real:true 计数·总数/GB=stats 真值·来源=徽章种类）",
      bool(mvb) and "real === true" in mvb.group(0) and "stats" in mvb.group(0)
      and "badge" in mvb.group(0) and "srcMap" in mvb.group(0)
      and re.search(r'wx:for="\{\{valueBadges\}\}"', kbwxml) is not None)
check("A价值条四标签（真实文件/文件总数/GB/来源）",
      all(s in kbjs for s in ("'真实文件'", "'文件总数'", "'GB'", "'来源'")))

# 11.3 三视图 tab：三键 + JS 直译映射表（组名 verbatim 全名 + 待归类恒排尾 + 守恒账）
check("A tab 三键（主题/阶段/类型·data-v 三键·点选器）",
      all(('data-v="%s"' % k) in kbwxml for k in ("by_topic", "by_phase", "by_type"))
      and "主题" in kbwxml and "阶段" in kbwxml and "类型" in kbwxml
      and "onViewTabPick" in kbwxml and "onViewTabPick" in kbjs)
check("A 三视图 JS 直译在位（service 出 buildViews·页面消费·待归类+守恒 metrics）",
      "function buildViews" in kbsvc and "buildViews" in kbjs
      and all(s in kbsvc for s in ("PHASE_ORDER", "TYPE_ORDER", "UNMAPPED", "unmapped")))
check("A 三视图组名 verbatim（五阶段+五类型规约全名直译，不另起缩写）",
      all(s in kbsvc for s in ("前期报批", "勘察设计", "施工建造", "质量验收", "运维检修",
                                "标准规范", "合同范本", "研究报告", "案例实录", "数据报表")))

# 11.4 平铺组单层列表：主题视图零漂移（wx:if 分流）+ 平铺组渲染 + 复用文件行样式
check("A 平铺组单层列表（by_topic 分流零漂移·viewGroups 单层渲染·复用文件行）",
      re.search(r'wx:if="\{\{viewTab === .by_topic.\}\}"', kbwxml) is not None
      and "<block wx:else>" in kbwxml and "viewGroups" in kbwxml
      and "toggleViewGroup" in kbwxml and "toggleViewGroup" in kbjs
      and ".kf-vg-head" in kbwxss and ".kf-vtab.on" in kbwxss)

# 11.5 预览站点入口：built 态按钮 + service previewSite + 端点常量置空如实
check("A 预览入口（built 态按钮+service previewSite+端点常量置空=即将上线如实）",
      "生成预览站点" in kbwxml and 'wx:if="{{built}}"' in kbwxml
      and "onPreviewSite" in kbjs and "function previewSite" in kbsvc
      and "PREVIEW_ENDPOINT" in kbsvc and "即将上线" in kbsvc)

# 11.6 导览层旗：远端 depth 旁传 guided:true；本地样本腿不走远端腿
check("A 导览层开启（远端 guided:true·本地样本腿不涉）",
      re.search(r"guided:\s*true", kbsvc) is not None and "function generateLocal" in kbsvc)

# 11.7 iOS paySupported 双门不碰：付费门控件数恒 2（预览/分享卡为免费入口不挂门）
check("A iOS 双门不碰（paySupported 门控数=2 不增不减）",
      len(re.findall(r'wx:if="\{\{paySupported\}\}"', kbwxml)) == 2
      and re.search(r'<button class="kf-preview".*?</button>', kbwxml, re.S) is not None
      and "paySupported" not in re.search(r'<button class="kf-preview".*?</button>', kbwxml, re.S).group(0))

# ── 12. A 案真调研接线（三层兜底·三段直播·真调研价值计数；静态断言）──
# 12.1 三层兜底函数在场：真调研服务腿 → 云函数腿 → 本地样本腿（永不白屏）
check("A案 三层兜底函数在场（callEvidence/callRemote/generateLocal 定义齐）",
      "function callEvidence" in kbsvc and "function callRemote" in kbsvc
      and "function generateLocal" in kbsvc)

# 12.2 端点常量：本地实测位先置 127.0.0.1:8097 + ECS 上线位注释（换域名只动常量）
check("A案 KB_EVIDENCE_ENDPOINT 常量（127.0.0.1:8097 实测位 + ai.epcschool.top 上线注释）",
      "KB_EVIDENCE_ENDPOINT" in kbsvc and "http://127.0.0.1:8097" in kbsvc
      and "ai.epcschool.top" in kbsvc)

# 12.3 开关默认开 + 轮询节奏（每 3s 一查 / 100s 总预算封顶）
check("A案 开关默认开+轮询节奏（KB_EVIDENCE_ENABLED=true·3s 间隔·130s 封顶）",
      "KB_EVIDENCE_ENABLED = true" in kbsvc
      and "EVIDENCE_POLL_MS = 3000" in kbsvc and "EVIDENCE_MAX_MS = 130000" in kbsvc)

# 12.4 总入口三层回落接线：evidence 优先 → callRemote → generateLocal，腿标如实
mgen = re.search(r"function generate\(needText, onStage, depth\)\s*\{[\s\S]*?\n\}", kbsvc)
mloc = re.search(r"function generateLocal\(text, onStage\)\s*\{[\s\S]*?\n\}", kbsvc)
check("A案 generate 三层回落链（优先真调研·失败回落云函数·再回落本地·腿标 evidence/cloud/local）",
      bool(mgen) and all(s in mgen.group(0) for s in
          ("KB_EVIDENCE_ENABLED", "callEvidence(text, depth, emit)",
           "callRemote(text, depth)", "generateLocal(text, emit)",
           "'evidence'", "'cloud'"))
      and bool(mloc) and "'local'" in mloc.group(0))

# 12.5 三段直播映射：调研/设计两段进行中文案 + 交付段骨架（服务端真 stage 驱动）
check("A案 三段直播映射（正在调研真实资料源·正在根据调研结果设计目录·EVIDENCE_STAGES）",
      "EVIDENCE_STAGES" in kbsvc and "正在调研真实资料源" in kbsvc
      and "正在根据调研结果设计目录" in kbsvc)

# 12.6 渠道计数不编造：真值在场才显示（拿不到不带数字）
check("A案 渠道计数不编造（evidenceChannelsCount 真值折算·n>0 才带·否则 undefined）",
      "function evidenceChannelsCount" in kbsvc
      and re.search(r"n > 0 \? n \+ ' 个渠道' : undefined", kbsvc) is not None)

# 12.7 失败如实：status=failed 带原因透传回落（不吞不编）
check("A案 失败如实（status failed 分支带 reason 透传）",
      "status === 'failed'" in kbsvc and "d.reason" in kbsvc)

# 12.8 页面换轨处理：施工直播骨架随腿切换（真调研三段 ↔ 演示八阶段）
check("A案 页面换轨处理（onStage 收 reset 事件重置 stages 骨架）",
      "st.reset" in kbjs and "reset: EVIDENCE_STAGES" in kbsvc and "reset: STAGES" in kbsvc)

# 12.9 价值条真调研计数：provenance.evidence_tree.pool_size 真值追加「真实调研 N 件」
mvb2 = re.search(r"_buildValueBadges\(bp\)\s*\{[\s\S]*?\n  \},", kbjs)
check("A案 价值条真调研计数（evidence_tree.pool_size 真值·无键不追加不编造）",
      bool(mvb2) and "evidence_tree" in mvb2.group(0) and "pool_size" in mvb2.group(0)
      and "真实调研" in mvb2.group(0) and "provenance" in mvb2.group(0))

# 12.10 模式徽章认得真调研树（evidence_tree → 真实调研，非「通用骨架」误标）
check("A案 模式徽章认得真调研树（wxml evidence_tree 分支 → 真实调研）",
      "evidence_tree" in kbwxml and "真实调研" in kbwxml)

# 12.11 D 轴实时直播升级：live 渲染函数在场（服务端直播键真值折算）
mll = re.search(r"function evidenceLiveLine[\s\S]*?\n}", kbsvc)
check("D轴 live 渲染函数在场（evidenceLiveLine·channels_live/clusters_forming 真值折算·缺键 undefined）",
      bool(mll) and "channels_live" in mll.group(0) and "clusters_forming" in mll.group(0)
      and "undefined" in mll.group(0)
      and "evidenceLiveLine(d, 0)" in kbsvc and "evidenceLiveLine(d, 1)" in kbsvc)

# 12.12 D 轴副文案逻辑：段0 渠道名 n 件逐渠道滚动 + 段1 正在形成 N 个主题分组
check("D轴 副文案逻辑（段0 渠道名 n 件滚动·段1 正在形成 N 个主题分组·真值才显示）",
      "' 件'" in kbsvc and "正在形成 '" in kbsvc and "' 个主题分组'" in kbsvc
      and "_liveRotate" in kbsvc and "_liveRotate = -1" in kbsvc)

# ── 收口 ──
fails = RESULTS.count(False)
print(("ALL PASS (%d/%d checks) · W4+W6 DoD 绿" % (len(RESULTS) - fails, len(RESULTS))) if not fails
      else "FAILED (%d/%d) · 敏感词不过=返工文案" % (fails, len(RESULTS)))
sys.exit(1 if fails else 0)
