# -*- coding: utf-8 -*-
"""final_verify.py — 终审：全新导航后 DOM 深查注销状态（不只 innerText）。"""
import json
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch, shot  # noqa: E402

TOKEN = "91558662"
INDEX = f"https://mp.weixin.qq.com/wxamp/index/index?token={TOKEN}&lang=zh_CN"

JS = """
var h = document.documentElement.outerHTML;
var r = {};
var words = ['自主注销', '剩余冻结期', '取消注销', '账号冻结中', '帐号冻结中', '注销流程'];
for (var i = 0; i < words.length; i++) {
  var w = words[i];
  var idx = h.indexOf(w);
  r[w] = idx >= 0 ? h.substr(Math.max(0, idx - 60), 130).split('\\n').join(' ') : null;
}
var t = document.body.innerText || '';
r.innerText_clean = (t.indexOf('注销') < 0) && (t.indexOf('冻结') < 0) && (t.indexOf('暂停') < 0);
return JSON.stringify(r);
"""


def main():
    page = attach_or_launch()
    tab = page.latest_tab
    tab.get(INDEX)  # 全新导航：Vue 按服务端状态重渲染
    time.sleep(5)
    r = json.loads(tab.run_js(JS) or "{}")
    s = shot(tab, "final_verify")
    print(json.dumps({"url": (tab.url or "")[:120], "dom": r, "shot": s}, ensure_ascii=True))


if __name__ == "__main__":
    main()
