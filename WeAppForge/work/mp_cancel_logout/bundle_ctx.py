# -*- coding: utf-8 -*-
"""bundle_ctx.py — 扒 index bundle 中 wxaacctclose 前后文与 he.post 序列化方式。"""
import json
import sys

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch  # noqa: E402

JS = """
async function main() {
  var srcs = Array.prototype.slice.call(document.querySelectorAll('script[src]')).map(function (x) { return x.src; });
  var target = null;
  for (var i = 0; i < srcs.length; i++) { if (srcs[i].indexOf('index.') >= 0) { target = srcs[i]; break; } }
  if (!target) return JSON.stringify({err: 'no index bundle'});
  var txt = await (await fetch(target)).text();
  var idx = txt.indexOf('wxaacctclose');
  if (idx < 0) return JSON.stringify({err: 'no hit', len: txt.length});
  var out = {url: target.split('/').pop(), len: txt.length,
    before: txt.substr(Math.max(0, idx - 700), 700),
    after: txt.substr(idx, 900)};
  // 找 he 的定义：常见形如 xxx.post= function / Content-Type 设置
  var ct = txt.indexOf('x-www-form-urlencoded');
  out.formType = ct >= 0 ? txt.substr(Math.max(0, ct - 350), 500) : null;
  var ct2 = txt.indexOf('Content-Type');
  out.contentType = ct2 >= 0 ? txt.substr(Math.max(0, ct2 - 200), 400) : null;
  return JSON.stringify(out);
}
return main();
"""


def main():
    page = attach_or_launch()
    tab = page.latest_tab
    r = json.loads(tab.run_js(JS, timeout=60) or "{}")
    if "err" in r:
        print(json.dumps(r, ensure_ascii=True))
        return 1
    print("URL:", r.get("url"), "LEN:", r.get("len"))
    print("\n===== BEFORE (700) =====")
    print(r.get("before", ""))
    print("\n===== AFTER (900) =====")
    print(r.get("after", ""))
    print("\n===== formType =====")
    print((r.get("formType") or "none")[:600])
    print("\n===== contentType =====")
    print((r.get("contentType") or "none")[:500])
    return 0


if __name__ == "__main__":
    sys.exit(main())
