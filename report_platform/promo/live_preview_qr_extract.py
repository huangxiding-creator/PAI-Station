# -*- coding: utf-8 -*-
"""live_preview_qr_extract — 逐讲提取预约二维码+推广链接 (1104 总包圈直播战役).

每张计划卡片「邀请他人推广」→ 弹窗: 200x200 QR(data URI) + 分享链接.
产出: live_qr/L{n}_qr.png + live_qr/links.json
"""
from __future__ import annotations

import base64
import json
import re
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

PROMO = Path(__file__).resolve().parent
OUT = PROMO / "live_qr"
OUT.mkdir(exist_ok=True)

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

TOPICS = [
    "抢抓六网机遇，再造增长曲线",
    "六网首重水网，聚力抢占先机",
    "把握管网红利 筑牢城市生命线",
    "建强物流网，畅通经济循环",
    "抢滩新型电网 谋局新三网协同",
]


def log(m: str) -> None:
    print(f"[qrx {time.strftime('%H:%M:%S')}] {m}", flush=True)


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
            log("✗ reserve frame 未达")
            return 1
        # 找全部可见邀请按钮 (每卡一个, 按出现序=日期序)
        n = fr.run_js("""
            return (function(){
                var els = document.querySelectorAll('button');
                var n = 0;
                for (var i=0;i<els.length;i++){
                    var e = els[i];
                    if ((e.innerText||'').trim()==='邀请他人推广'
                        && e.getBoundingClientRect().width>0) n++;
                }
                return n;
            })();
        """)
        log(f"邀请按钮数: {n}")
        links = {}
        for idx in range(5):
            # 点第 idx 个邀请按钮
            fr.run_js(f"""
                var el = (function(){{
                    var vis = [];
                    var els = document.querySelectorAll('button');
                    for (var i=0;i<els.length;i++){{
                        var e = els[i];
                        if ((e.innerText||'').trim()==='邀请他人推广'
                            && e.getBoundingClientRect().width>0) vis.push(e);
                    }}
                    return (vis.length > {idx}) ? vis[{idx}] : null;
                }})();
                if (el) el.setAttribute('{MARK}', '1');
            """)
            fr.run_js(CLICK_JS)
            time.sleep(4)
            # 抓弹窗: QR data URI + 链接文本
            data = fr.run_js("""
                return (function(){
                    var wrps = document.querySelectorAll('.weui-desktop-dialog__wrp');
                    var wrp = null;
                    for (var i=0;i<wrps.length;i++){
                        if (wrps[i].getBoundingClientRect().width>0){ wrp = wrps[i]; break; }
                    }
                    if (!wrp) return JSON.stringify({err:'NO_DIALOG'});
                    var qr = '';
                    var imgs = wrp.querySelectorAll('img');
                    for (var i=0;i<imgs.length;i++){
                        var r = imgs[i].getBoundingClientRect();
                        if (r.width>=150 && (imgs[i].src||'').indexOf('base64')>0){
                            qr = imgs[i].src; break;
                        }
                    }
                    var txt = (wrp.innerText||'').trim();
                    return JSON.stringify({qr: qr, text: txt.slice(0,400)});
                })();
            """)
            try:
                d = json.loads(data)
            except Exception:
                d = {"err": f"PARSE:{str(data)[:80]}"}
            qr_uri = d.get("qr", "")
            log(f"L{idx+1} 弹窗文本: {d.get('text','')[:80]!r}")
            if qr_uri.startswith("data:image"):
                b64 = qr_uri.split(",", 1)[1]
                png = base64.b64decode(b64)
                fp = OUT / f"L{idx+1}_qr.png"
                fp.write_bytes(png)
                log(f"  ✓ QR → {fp.name} ({len(png)}B)")
                links[f"L{idx+1}"] = {
                    "topic": TOPICS[idx],
                    "dialog_text": d.get("text", ""),
                }
            else:
                log(f"  ✗ QR 未取得: {str(d)[:100]}")
            # 关弹窗 (取消/关闭/ESC)
            fr.run_js(f"""
                var el = (function(){{
                    var els = document.querySelectorAll('button,[class*=close],[class*=Cancel]');
                    for (var i=0;i<els.length;i++){{
                        var e = els[i];
                        var t = (e.innerText||'').trim();
                        if ((t==='取消'||t==='关闭'||t.indexOf('close')>=0||t==='确定')
                            && e.getBoundingClientRect().width>0) return e;
                    }}
                    return null;
                }})();
                if (el) el.setAttribute('{MARK}', '1');
            """)
            fr.run_js(CLICK_JS)
            time.sleep(2)
        (OUT / "links.json").write_text(
            json.dumps(links, ensure_ascii=False, indent=1), encoding="utf-8")
        log(f"链接台账 → {OUT/'links.json'}")
        return 0
    finally:
        try:
            tab.close()
        except Exception:
            pass


if __name__ == "__main__":
    sys.exit(main())
