# -*- coding: utf-8 -*-
"""finish_review_0912.py — 提审收尾：点成功弹窗「确定」→ getcodepage 终验 0.9.12 行「审核中」+ 截图存档。"""
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")

from driver import attach_or_launch  # noqa: E402


def main() -> None:
    page = attach_or_launch()
    gc = None
    codepage = None
    for t in page.get_tabs():
        u = t.url or ""
        if "get_class" in u and gc is None:
            gc = t
        if "getcodepage" in u and codepage is None:
            codepage = t
    print("tabs: get_class=", bool(gc), "getcodepage=", bool(codepage))

    # 1) get_class 成功弹窗点「确定」
    if gc is not None:
        r = gc.run_js(r"""
return (function(){
  var els = document.querySelectorAll('button, a, span');
  for (var i=0;i<els.length;i++){
    var el = els[i];
    var txt = (el.innerText||'').trim();
    if (txt === '确定' && el.offsetParent !== null){
      var real = el.closest('button')||el.closest('a')||el;
      real.click(); return 'ok-clicked:' + real.tagName;
    }
  }
  return 'no-confirm';
})();
""")
        print("confirm:", r)
        time.sleep(3)

    # 2) getcodepage 刷新 → 终验 0.9.12 行审核中
    if codepage is None:
        print("NO_CODEPAGE_TAB")
        sys.exit(1)
    codepage.run_js("location.reload();")
    time.sleep(8)
    v = codepage.run_js(r"""
return (function(){
  var body = document.body.innerText || '';
  var out = {has_0912: body.indexOf('0.9.12')>=0, has_reviewing: body.indexOf('审核中')>=0};
  var els = document.querySelectorAll('*');
  for (var i=0;i<els.length;i++){
    var el = els[i]; var own=false;
    for (var k=0;k<el.childNodes.length;k++){
      var n = el.childNodes[k];
      if (n.nodeType===3 && n.textContent.trim()==='0.9.12'){own=true;break;}
    }
    if (own){
      var node = el;
      for (var d=0; d<8 && node; d++){
        node = node.parentElement;
        if (!node) break;
        var t2 = node.innerText||'';
        if (t2.length>20 && t2.length<600 && t2.indexOf('0.9.12')>=0){
          out.row = t2.replace(/\n/g,'|').slice(0,220);
          return JSON.stringify(out);
        }
      }
    }
  }
  return JSON.stringify(out);
})();
""")
    print("version_row:", v)
    codepage.get_screenshot(r"E:\AI-Station\WeAppForge\filing\review_0912_submitted.png")
    print("DONE")


if __name__ == "__main__":
    main()
