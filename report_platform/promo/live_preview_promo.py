# -*- coding: utf-8 -*-
"""live_preview_promo — 邀请他人推广: 主文档+全帧弹层扫描 v3."""
from __future__ import annotations

import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

MARK = "data-lpc-mark"
CLICK_JS = f"""
var el = document.querySelector('[{MARK}]');
if (el) {{
    ['pointerdown','mousedown','pointerup','mouseup','click'].forEach(function(ev){{
        el.dispatchEvent(new MouseEvent(ev, {{bubbles:true, cancelable:true, view:window}}));
    }});
}}
el && el.removeAttribute('{MARK}');
"""

SCAN_JS = """
            return (function(){
                var out = [];
                var sels = ['.weui-desktop-dialog__wrp', '[class*=dialog]', '[class*=modal]',
                            '[class*=popup]', '[class*=poster]', '[class*=qrcode]',
                            '[class*=share]', '[class*=promote]', '[class*=invite]'];
                var seen = [];
                for (var s=0;s<sels.length;s++){
                    var els;
                    try { els = document.querySelectorAll(sels[s]); } catch(e) { continue; }
                    for (var i=0;i<els.length;i++){
                        var e = els[i];
                        var r = e.getBoundingClientRect();
                        if (r.width<100 || r.height<80) continue;
                        var t = (e.innerText||'').trim().slice(0,420);
                        if (!t || seen.indexOf(t)>=0) continue;
                        seen.push(t);
                        out.push('== ' + sels[s] + ' [' + Math.round(r.width) + 'x' + Math.round(r.height) + ']\\n' + t);
                    }
                }
                // 大图/画布
                var imgs = [];
                var iels = document.querySelectorAll('img, canvas');
                for (var i=0;i<iels.length && imgs.length<12;i++){
                    var e = iels[i];
                    var r = e.getBoundingClientRect();
                    if (r.width<60) continue;
                    var src = e.tagName==='IMG' ? (e.src||'').slice(0,120) : 'CANVAS';
                    imgs.push('   ' + e.tagName + ' [' + Math.round(r.width) + 'x' + Math.round(r.height) + '] ' + src);
                }
                if (imgs.length) out.push('== IMAGES\\n' + imgs.join('\\n'));
                return out.join('\\n') || 'NOTHING';
            })();
"""


def main() -> int:
    from DrissionPage import Chromium
    b = Chromium(addr_or_opts="127.0.0.1:9222")
    tab = b.new_tab("https://channels.weixin.qq.com/platform/live/reserve")
    try:
        time.sleep(9)
        fr = None
        for f in tab.get_frames():
            if "micro/live/reserve" in (f.url or ""):
                fr = f
                break
        if fr is None:
            print("no reserve frame; tab=", tab.url[:80])
            return 1
        # 点第一个卡片的邀请按钮 (BUTTON 优先)
        fr.run_js(f"""
            var el = (function(){{
                var els = document.querySelectorAll('button');
                for (var i=0;i<els.length;i++){{
                    var e = els[i];
                    if ((e.innerText||'').trim()==='邀请他人推广' && e.getBoundingClientRect().width>0) return e;
                }}
                return null;
            }})();
            if (el) el.setAttribute('{MARK}', '1');
        """)
        fr.run_js(CLICK_JS)
        time.sleep(6)
        print("══ 主文档扫描:")
        print(tab.run_js(SCAN_JS)[:2000])
        for i, f in enumerate(tab.get_frames()):
            u = f.url or ""
            print(f"══ frame[{i}] {u[:80]}:")
            try:
                print(str(f.run_js(SCAN_JS))[:1600])
            except Exception as exc:
                print("  ERR:", type(exc).__name__)
        return 0
    finally:
        try:
            tab.close()
        except Exception:
            pass


if __name__ == "__main__":
    sys.exit(main())
