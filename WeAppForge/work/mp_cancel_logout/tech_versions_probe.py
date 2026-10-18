# -*- coding: utf-8 -*-
"""tech_versions_probe.py — 9336 总包科技：getcodepage(版本管理) 状态侦查。只读。"""
import json
import re
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch, shot  # noqa: E402

APPID = "wxfdb55b184756e89e"
GHID = "gh_5ebe2155780f"

page = attach_or_launch()
tab = None
for tid in page.tab_ids:
    t = page.get_tab(tid)
    u = t.url or ""
    if "mp.weixin.qq.com" in u and ("getcodepage" in u or "wxamp" in u):
        tab = t
        break
if not tab:
    print(json.dumps({"tab": False}))
    raise SystemExit(1)

m = re.search(r"token=(\d+)", tab.url or "")
token = m.group(1) if m else ""
tab.get(f"https://mp.weixin.qq.com/wxamp/wacodepage/getcodepage?token={token}&lang=zh_CN")
time.sleep(6)

html = tab.html or ""
guard = APPID in html or GHID in html
text = re.sub(r"<script[\s\S]*?</script>", " ", html)
text = re.sub(r"<style[\s\S]*?</style>", " ", text)
text = re.sub(r"<[^>]+>", "\n", text)
text = re.sub(r"[ \t\xa0]+", " ", text)
lines = [ln.strip() for ln in text.split("\n") if ln.strip()]

info = {"url": (tab.url or "")[:120], "appid_guard": guard,
        "n_120": html.count("1.2.0"), "n_112": html.count("1.1.2")}

# 版本区块上下文
for kw in ("线上版本", "审核版本", "审核中", "开发版本", "体验版"):
    idx = text.find(kw)
    if idx >= 0:
        seg = re.sub(r"\s+", " ", text[max(0, idx - 60): idx + 500]).strip()[:420]
        info[f"ctx_{kw}"] = seg
    else:
        info[f"ctx_{kw}"] = None

# 版本记录行
rows = re.findall(r"1\.\d\.\d", lines and "\n".join(lines) or "")
info["versions_seen"] = sorted(set(rows))

print(json.dumps(info, ensure_ascii=False, indent=1))
shot(tab, "tech_versions")
