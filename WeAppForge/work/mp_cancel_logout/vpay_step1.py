# -*- coding: utf-8 -*-
"""vpay_step1 — Step1 同意协议：勾选(回读checked) → 下一步 → dump Step2 商户资料表单。"""
import sys
import time

sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from vpay_common import click_shadow, log, pierce_dump, shot  # noqa: E402
from driver import attach_or_launch  # noqa: E402

JS_CHECKED = r"""
return (function(){
  function walk(root){
    try {
      var cbs = Array.from(root.querySelectorAll('input[type=checkbox]'));
      for (var i = 0; i < cbs.length; i++) {
        var r = cbs[i].getBoundingClientRect();
        if (cbs[i].className.indexOf('form__checkbox') >= 0 || r.width >= 0) {
          if (cbs[i].closest && cbs[i].closest('form,div') && (cbs[i].offsetParent !== null || r.width >= 0)) {
            return JSON.stringify({checked: cbs[i].checked, disabled: cbs[i].disabled});
          }
        }
      }
      var ks = Array.from(root.querySelectorAll('*'));
      for (var j = 0; j < ks.length; j++) { if (ks[j].shadowRoot) { var r2 = walk(ks[j].shadowRoot); if (r2) return r2; } }
    } catch (e) {}
    return null;
  }
  return walk(document) || '{}';
})();
"""


def main():
    page = attach_or_launch()
    tab = page.latest_tab
    log("s1", {"url": (tab.url or "")[:120]})

    # 1) 勾选协议 checkbox（点 label span）
    c = click_shadow(tab, "我已阅读并同意上述条款", mode=3)
    log("s1", {"click_check_label": c})
    time.sleep(2.5)
    try:
        st = tab.run_js(JS_CHECKED)
        log("s1", {"checkbox_state": st})
    except Exception as e:
        log("s1", {"checkbox_state_err": str(e)[:200]})

    # 2) 下一步
    c2 = click_shadow(tab, "下一步", mode=1)
    log("s1", {"click_next": c2})
    time.sleep(5)
    d = pierce_dump(tab)
    log("s1", {"step2_dump": d and d[:8000], "shot": shot(tab, "step2")})
    return 0


if __name__ == "__main__":
    sys.exit(main())
