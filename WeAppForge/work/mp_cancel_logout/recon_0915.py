# -*- coding: utf-8 -*-
"""recon_0915.py — wx5cee 0.9.15 提审前只读侦察（9336 常驻 Chrome 配方）。

dump：全部版本块（线上/审核中/开发版行）+ 0.9.15 开发版行「提交审核」按钮在位。
零点击零输入；退出码 0=页面解析成功。
"""
import json
import re
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")

from driver import attach_or_launch  # noqa: E402

APPID = "wx5cee1574ce45819b"

JS_BLOCKS = r"""
return (function(){
  var blocks = document.querySelectorAll('.code_version_log');
  var out = [];
  for (var i = 0; i < blocks.length; i++) {
    out.push((blocks[i].innerText || '').replace(/\s+/g, ' ').slice(0, 260));
  }
  return JSON.stringify({n: blocks.length, blocks: out,
    appid_ok: (document.body.innerText || '').indexOf('wx5cee') >= 0,
    loginish: (document.body.innerText || '').indexOf('扫码') >= 0 &&
              (document.body.innerText || '').indexOf('登录') >= 0});
})()
"""

JS_ROW_0915 = r"""
return (function(){
  function ownText(e){return Array.prototype.filter.call(e.childNodes,function(n){return n.nodeType===3;}).map(function(n){return n.nodeValue.trim();}).join(' ');}
  var els = document.querySelectorAll('*');
  for (var i=0;i<els.length;i++){
    if (ownText(els[i]) === '0.9.15'){
      var row = els[i];
      for (var d=0; d<8 && row; d++){
        var t = row.innerText || '';
        if (t.indexOf('提交审核') >= 0 || t.indexOf('选为体验版') >= 0){
          var btn = row.querySelector('button.weui-desktop-btn_primary, .weui-desktop-btn_primary');
          return JSON.stringify({depth:d, rowText:t.slice(0,200).replace(/\n/g,'|'),
            submitBtn: btn ? ((btn.innerText||'').trim() + '|' + btn.className.slice(0,50)) : null});
        }
        row = row.parentElement;
      }
      return JSON.stringify({err:'no-row-with-submit'});
    }
  }
  return JSON.stringify({err:'no-anchor-0.9.15'});
})();
"""


def main() -> int:
    page = attach_or_launch()
    tab = None
    for t in page.get_tabs():
        u = t.url or ""
        if "mp.weixin.qq.com" in u and "token=" in u:
            tab = t
            break
    if tab is None:
        print("NO_LOGGED_IN_TAB")
        return 1

    ct = None
    for t in page.get_tabs():
        if "getcodepage" in (t.url or ""):
            ct = t
            break
    if ct is None:
        token = re.search(r"token=(\d{8,})", tab.url or "").group(1)
        ct = page.new_tab(f"https://mp.weixin.qq.com/wxamp/wacodepage/getcodepage?token={token}&lang=zh_CN")
        time.sleep(6)

    ct.run_js("location.reload();")
    time.sleep(8)
    d = json.loads(ct.run_js(JS_BLOCKS) or "{}")
    print("appid_ok:", d.get("appid_ok"), "| loginish:", d.get("loginish"), "| blocks:", d.get("n"))
    for b in d.get("blocks", []):
        print("  BLOCK:", b[:230])
    print("row0915:", ct.run_js(JS_ROW_0915))
    ct.get_screenshot(r"E:\AI-Station\WeAppForge\filing\review_0915_recon.png")
    print("RECON_DONE")
    return 0


if __name__ == "__main__":
    sys.exit(main())
