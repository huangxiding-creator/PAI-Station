# -*- coding: utf-8 -*-
"""tcb_probe2.py — mp 后台找「云开发/云托管」入口（mp 会话 SSO 进 CloudBase）。"""
import json
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch, shot  # noqa: E402
from watch_category import live_token  # noqa: E402

DUMP = """
function walk(doc, parts, depth) {
  if (!doc || depth > 3) return;
  try {
    var txt = (doc.body && doc.body.innerText) || '';
    if (txt && txt.length > 30) parts.push({d: depth, txt: txt.slice(0, 2000)});
  } catch (e) {}
  try {
    var frs = doc.querySelectorAll('iframe');
    for (var j = 0; j < frs.length; j++) walk(frs[j].contentDocument, parts, depth + 1);
  } catch (e) {}
}
var parts = [];
walk(document, parts, 0);
return JSON.stringify(parts);
"""


def main():
    page = attach_or_launch()
    tab = page.latest_tab
    token = live_token(tab)
    if not token:
        print(json.dumps({"login_wall": True}, ensure_ascii=False))
        return 1
    home = f"https://mp.weixin.qq.com/misc/cloudbasepage?token={token}&lang=zh_CN"
    tab.get(home)
    time.sleep(10)
    res = {"try1_url": tab.url, "try1_title": tab.title}
    res["try1_docs"] = json.loads(tab.run_js(DUMP) or "[]")
    res["shot1"] = shot(tab, "tcb_mp_entry_try1")
    print(json.dumps(res, ensure_ascii=False))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
