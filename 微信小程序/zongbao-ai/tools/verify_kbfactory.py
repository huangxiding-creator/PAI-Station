# -*- coding: utf-8 -*-
"""W4+W6 自检门（DoD）——知识库蓝图页挂载与支付/导出/整库下单校验。

检查项：
  1. app.json 可解析；pages 含 pages/kbfactory/kbfactory 且在尾部；原 10 页顺序不变（回归锚）
  2. 页面四件套存在（wxml/wxss/js/json）
  3. wxml 未闭合标签粗检（标签配对计数，自闭合不计开）
  4. js 语法：有 node 走 node --check；无 node 退化为括号配对粗查
  5. 样本 JSON 可解析、≤200KB、含 tree/ratio/stats/quote 四键
  6. 敏感词自检：新页面/服务层/订单海报模块/样本全文 + zhiku 新增块，不得出现 渠道名/技术词
  7. W6 接线：付费按钮 iOS 分支（js 守卫+wxml 门控）· 邮箱校验 · 订单 payload 四键+摘要五键
     · 海报函数被导出按钮调用+相册拒绝预览降级 · 合规三句/履约中状态页文案
  8. W6 冒烟：node 在位时并入 DoD（支付成功/取消/409 三分支 + payload 组装 + 本地订单箱）
用法：py -3 tools/verify_kbfactory.py （于 zongbao-ai 根目录）
"""
import json
import re
import shutil
import subprocess
import sys
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
check("两份样本存在", len(samples) == 2, " ".join(rel(s) for s in samples))
for sp in samples:
    size = sp.stat().st_size
    check(f"样本 ≤200KB {rel(sp)}", size <= 200 * 1024, f"{size / 1024:.0f}KB")
    data = json.loads(sp.read_text(encoding="utf-8"))
    keys_ok = all(k in data for k in ("tree", "ratio", "stats", "quote"))
    check(f"样本含 tree/ratio/stats/quote {rel(sp)}", keys_ok)
    st, q = data["stats"], data["quote"]
    print(f"       ↳ {rel(sp)}: files={st['files']} gb={st['gb']} quote.total=¥{q['total']} "
          f"l1={st['l1_count']} l2={st['l2_count']}")

# ── 6. 敏感词自检 ──
for f in [ROOT / PAGE / x for x in quad] + [ROOT / "utils/kbfactory_service.js",
                                            ROOT / "utils/kbfactory_pay.js",
                                            ROOT / "utils/kbfactory_poster.js"] + samples:
    scan_banned(f"敏感词 {rel(f)}", f.read_text(encoding="utf-8"))
zw = (ROOT / "pages/zhiku/zhiku.wxml").read_text(encoding="utf-8")
m = re.search(r"<!-- ══ KB-FACTORY[\s\S]*?六库图纸目录", zw)
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

# ── 收口 ──
fails = RESULTS.count(False)
print(("ALL PASS (%d/%d checks) · W4+W6 DoD 绿" % (len(RESULTS) - fails, len(RESULTS))) if not fails
      else "FAILED (%d/%d) · 敏感词不过=返工文案" % (fails, len(RESULTS)))
sys.exit(1 if fails else 0)
