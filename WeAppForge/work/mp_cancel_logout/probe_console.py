# -*- coding: utf-8 -*-
"""probe_console.py — 附着 9336，盘点标签 + 在控制台 tab 上跑 _menu.js 状态探针。
用法: python probe_console.py [jsfile]
"""
import io
import json
import sys

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch, shot  # noqa: E402

JSFILE = sys.argv[1] if len(sys.argv) > 1 else "_menu.js"

page = attach_or_launch()

tabs = []
for tid in page.tab_ids:
    try:
        t = page.get_tab(tid)
        tabs.append({"url": (t.url or "")[:150], "title": (t.title or "")[:40]})
    except Exception as e:
        tabs.append({"err": str(e)[:80]})
print("TABS " + json.dumps(tabs, ensure_ascii=False))

# 钉定控制台主标签（wxamp 首页或 wacodepage）
tab = None
for tid in page.tab_ids:
    t = page.get_tab(tid)
    u = t.url or ""
    if "wacodepage" in u or "/wxamp/index/index" in u:
        tab = t
        if "wacodepage" in u:
            break

if not tab:
    print(json.dumps({"tab": False}, ensure_ascii=False))
    raise SystemExit(1)

js = io.open(JSFILE, encoding="utf-8").read()
print("PROBE " + tab.run_js("return (function(){" + js + "})()"))
shot(tab, "probe_console")
