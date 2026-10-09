# -*- coding: utf-8 -*-
"""任务③ 渲染腿：占位符替换 → 科技深蓝渲染（无丢段补丁测真实体积）→ 全门检查。
纪律：RX1 盲丢段对本篇=禁区（5000字精写+数字锚点全钉死），先测全量真实 HTML 体积再裁决。
"""
import json
import logging
import re
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
PROMO = Path(r"E:\AI-Station\WeAppForge\work\promo_article_1009")
WEAIPO = Path(r"E:\CPOPC\We-AIPO")

sys.path.insert(0, str(WEAIPO))

md_src = (PROMO / "article.md").read_text(encoding="utf-8")
urls = json.loads((PROMO / "url_map.json").read_text(encoding="utf-8"))

final_md = md_src
for key, url in urls.items():
    final_md = final_md.replace("{{" + key + "}}", url)
assert "{{" not in final_md, "placeholder left!"
(PROMO / "article_final.md").write_text(final_md, encoding="utf-8")
print(f"article_final.md: {len(final_md)} chars, placeholders all filled")

import src.plugins.process.md_renderer as mr  # noqa: E402

# 无丢段补丁：RX1 默认评估 3.2x 会误伤本篇；改恒等，用真实渲染体积说话
mr.md_prebudget_slim = lambda md, budget=999999: (md, 0)

logging.basicConfig(level=logging.WARNING)
html_full = mr.render_md_to_wechat_html(final_md, "科技深蓝")
# 剥空段落 p（图后空白残留，零可见内容，纯预算空气）
html_full = re.sub(r"<p[^>]*>\s*(?:<br\s*/?>\s*)*</p>", "", html_full)
(PROMO / "article_full.html").write_text(html_full, encoding="utf-8")
print(f"FULL render (no-drop, empty-p stripped): {len(html_full)} chars")

# ── 自然渲染对照（看 RX1 会丢几段——只观察不采用）──
import importlib  # noqa: E402

mr_natural = importlib.reload(mr)
html_nat = mr_natural.render_md_to_wechat_html(final_md, "科技深蓝")
print(f"NATURAL render: {len(html_nat)} chars")

# ── 门检查（对 FULL 版）──
SENSITIVE = [
    "python", "Python", "GLM", "DeepSeek", "秘塔", "NotebookLM", "RSS", "OPML",
    "DrissionPage", "Chrome", "CDP", "Clash", "webhook", "SDK", "爬虫", "逆向",
    "ffmpeg", "whisper", "源码", "代码", "顶级", "病毒", "裂变", "保证", "法务",
    "诉讼", "10年沉淀",
]
ANCHORS = ["9,855", "847", "906", "620", "49", "517", "2013", "v0.9.12",
           "每天 6 次", "上不封顶", "依据来源", "纠错", "锅圈", "AI 生成"]

h = html_full
gates = {
    "len(html)>len(md)": len(html_full) > len(final_md),
    "html<20000": len(h) < 20000,
    "h2>=3": h.count("<h2") >= 3,
    "imgs==6": h.count("<img") == 6,
    "no class/id attrs": not re.search(r'<\w+[^>]*\s(class|id)=', h),
    "no div": "<div" not in h,
    "no {{ left": "{{" not in h,
    "sensitive=0": not [w for w in SENSITIVE if w in h],
    "anchors all present": all(a in h for a in ANCHORS),
    "section root": h.lstrip().startswith("<section"),
}
bad = [k for k, v in gates.items() if not v]
for k, v in gates.items():
    print(f"  {'PASS' if v else 'FAIL'}  {k}")
sens_hits = [w for w in SENSITIVE if w in h]
if sens_hits:
    print(f"  sensitive hits: {sens_hits}")
missing = [a for a in ANCHORS if a not in h]
if missing:
    print(f"  anchors missing: {missing}")

print("\n== RENDER GATES " + ("ALL PASS ==" if not bad else f"FAIL x{len(bad)} =="))
sys.exit(1 if bad else 0)
