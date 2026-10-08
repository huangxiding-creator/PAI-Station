# -*- coding: utf-8 -*-
"""vpay_open_run — 主脚本：重取活token → 重进虚拟支付 → 点「开通」→ 回读下一面向导态。"""
import sys
import time

sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from vpay_common import click_shadow, ensure_tech, fresh_page, log, pierce_dump, shot  # noqa: E402


def main():
    page, tab, token = fresh_page()
    if not token:
        log("run", {"state": "NO_TOKEN", "url": (tab.url or "")[:120]})
        return 1
    if not ensure_tech(tab):
        log("run", {"state": "WRONG_ACCOUNT", "url": (tab.url or "")[:120]})
        return 1
    log("run", {"token": token, "identity_ok": True})

    # 进虚拟支付
    r = tab.run_js('return (function(){var a=document.querySelector(\'a[href*="subApp/skit"]\'); if(a){a.click(); return "clicked";} return "no-link";})();')
    log("run", {"goto_skit": r, "url": (tab.url or "")[:120]})

    # 轮询等 wujie 挂载（找「开通」按钮），最多 40s
    found = False
    for i in range(13):
        time.sleep(3)
        try:
            has = tab.run_js('return (function(){function own(e){return Array.prototype.filter.call(e.childNodes,function(n){return n.nodeType===3;}).map(function(n){return n.nodeValue.trim();}).join(\'\').trim();}function walk(r){try{var bs=Array.from(r.querySelectorAll(\'button\'));for(var i=0;i<bs.length;i++){var o=own(bs[i]);var rr=bs[i].getBoundingClientRect();if((o===\'开通\'||o===\'立即开通\')&&rr.width>0)return true;}var ks=Array.from(r.querySelectorAll(\'*\'));for(var j=0;j<ks.length;j++){if(ks[j].shadowRoot&&walk(ks[j].shadowRoot))return true;}}catch(e){}return false;}return walk(document);})();')
        except Exception:
            has = "err"
        log("run", {"poll": i, "open_btn": has})
        if has is True or has == "true":
            found = True
            break
    if not found:
        d = pierce_dump(tab)
        log("run", {"state": "OPEN_BTN_NOT_FOUND", "pierce": d and d[:4000], "shot": shot(tab, "nofound")})
        return 2

    # 回读当前可见交互元素
    d = pierce_dump(tab)
    log("run", {"pierce": d and d[:5000], "shot": shot(tab, "wizard")})

    # 点「开通」
    c = click_shadow(tab, "开通", mode=1)
    log("run", {"click_open": c})
    time.sleep(6)
    d2 = pierce_dump(tab)
    log("run", {"after_open": d2 and d2[:7000], "shot": shot(tab, "after_open")})
    return 0


if __name__ == "__main__":
    sys.exit(main())
