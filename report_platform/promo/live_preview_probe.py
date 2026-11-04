# -*- coding: utf-8 -*-
"""live_preview_probe — 全文检索 11月17日/L2 主题是否在任何区."""
from __future__ import annotations

import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

LIVE_URL = "https://channels.weixin.qq.com/platform/live/home"


def main() -> int:
    from DrissionPage import Chromium
    b = Chromium(addr_or_opts="127.0.0.1:9222")
    tab = b.new_tab(LIVE_URL)
    try:
        time.sleep(7)
        tab.run_js("""
            var links = document.querySelectorAll('a.finder-ui-desktop-menu__link');
            var target = null;
            for (var i=0;i<links.length;i++){
                var e = links[i];
                if ((e.innerText||'').trim().indexOf('直播预告')>=0) { target = e; if (e.getBoundingClientRect().width>0) break; }
            }
            if (target) ['pointerdown','mousedown','pointerup','mouseup','click'].forEach(function(ev){
                target.dispatchEvent(new MouseEvent(ev, {bubbles:true, cancelable:true, view:window}));
            });
        """)
        time.sleep(7)
        for f in tab.get_frames():
            if "micro/live/reserve" in (f.url or ""):
                fr = f
                break
        txt = fr.run_js("return (document.body.innerText||'');")
        for kw in ("11月17日", "六网首重水网", "11月12日", "抢抓六网机遇"):
            idx = txt.find(kw)
            print(f"'{kw}' → {'FOUND @'+str(idx) if idx>=0 else 'not found'}")
        # 当前计划区完整原文
        seg = txt.split("当前计划", 1)[1].split("历史预告", 1)[0]
        print("\n当前计划区原文:\n", seg)
        return 0
    finally:
        try:
            tab.close()
        except Exception:
            pass


if __name__ == "__main__":
    sys.exit(main())
