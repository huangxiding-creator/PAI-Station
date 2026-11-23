# -*- coding: utf-8 -*-
"""live_qr_token_api — 钩网+点邀请他人推广 → 捕 token API 的请求/响应."""
from __future__ import annotations

import json
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

PROMO = Path(__file__).resolve().parent

HOOK = """
(function(){
    window.__lpc2 = [];
    var of = window.fetch;
    window.fetch = function(){
        var u = (arguments[0]&&arguments[0].url)||String(arguments[0]);
        var body = null;
        try { body = JSON.stringify(arguments[1] && arguments[1].body) || null; } catch(e){}
        var p = of.apply(this, arguments);
        p.then(function(r){
            try {
                r.clone().text().then(function(t){
                    window.__lpc2.push({u: u, req: body, t: t.slice(0,3000)});
                });
            } catch(e){}
        });
        return p;
    };
    var oo = XMLHttpRequest.prototype.open;
    XMLHttpRequest.prototype.open = function(m, u){
        this.__u = u;
        return oo.apply(this, arguments);
    };
    var os = XMLHttpRequest.prototype.send;
    XMLHttpRequest.prototype.send = function(bd){
        var x = this;
        x.addEventListener('load', function(){
            try {
                window.__lpc2.push({u: x.__u, req: String(bd||'').slice(0,500), t: (x.responseText||'').slice(0,3000)});
            } catch(e){}
        });
        return os.apply(this, arguments);
    };
})();
"""

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


def main() -> int:
    from DrissionPage import Chromium
    b = Chromium(addr_or_opts="127.0.0.1:9222")
    tab = b.new_tab("about:blank")
    try:
        tab.run_cdp("Page.addScriptToEvaluateOnNewDocument", source=HOOK)
        tab.get("https://channels.weixin.qq.com/platform/live/reserve")
        time.sleep(13)
        fr = None
        for f in tab.get_frames():
            if "micro/live/reserve" in (f.url or ""):
                fr = f
                break
        if fr is None:
            print("no reserve frame")
            return 1
        base_len = len(json.loads(fr.run_js("return JSON.stringify(window.__lpc2||[]);") or "[]"))
        print(f"基线请求数: {base_len}")
        # 点 12/11 卡 (第3个邀请钮) 的邀请他人推广
        fr.run_js(f"""
            var el = (function(){{
                var vis = [];
                var els = document.querySelectorAll('button');
                for (var i=0;i<els.length;i++){{
                    var e = els[i];
                    if ((e.innerText||'').trim()==='邀请他人推广'
                        && e.getBoundingClientRect().width>0) vis.push(e);
                }}
                return (vis.length > 2) ? vis[2] : null;
            }})();
            if (el) el.setAttribute('{MARK}', '1');
        """)
        fr.run_js(CLICK_JS)
        time.sleep(5)
        caps = json.loads(fr.run_js("return JSON.stringify(window.__lpc2||[]);") or "[]")
        new = caps[base_len:]
        print(f"点击新增请求 {len(new)} 条:")
        out = PROMO / "live_article" / "invite_api_capture.json"
        out.write_text(json.dumps(new, ensure_ascii=False, indent=1), encoding="utf-8")
        for it in new:
            t = str(it.get("t", ""))[:150].replace("\n", " ")
            print(f"  {str(it['u'])[:110]}")
            print(f"    req={str(it.get('req'))[:120]}")
            print(f"    resp={t}")
        print(f"→ {out}")
        return 0
    finally:
        try:
            tab.close()
        except Exception:
            pass


if __name__ == "__main__":
    sys.exit(main())
