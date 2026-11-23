# -*- coding: utf-8 -*-
"""live_junk_cancel_1123 v3 — kebab→撤销预告→确认 全链 (文件版防转义)."""
from __future__ import annotations

import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

MARK = "data-lpc-mark"


def click_marked(fr):
    fr.run_js(f"""
        var el = document.querySelector('[{MARK}]');
        if (el) {{
            ['pointerdown','mousedown','pointerup','mouseup','click'].forEach(function(ev){{
                el.dispatchEvent(new MouseEvent(ev, {{bubbles:true, cancelable:true, view:window}}));
            }});
        }}
        el && el.removeAttribute('{MARK}');
    """)


def main() -> int:
    from DrissionPage import Chromium
    b = Chromium(addr_or_opts="127.0.0.1:9222")
    tab = b.new_tab("https://channels.weixin.qq.com/platform/live/reserve")
    try:
        time.sleep(11)
        fr = None
        for f in tab.get_frames():
            if "micro/live/reserve" in (f.url or ""):
                fr = f
                break
        # 0) 滚动列表把 12/13 卡带进可视区 (虚拟列表须渲染)
        for _ in range(6):
            fr.run_js("""
                (function(){
                    var cs = document.querySelectorAll('*');
                    for (var i=0;i<cs.length;i++){
                        var e = cs[i];
                        if (e.scrollHeight > e.clientHeight + 200 &&
                            (getComputedStyle(e).overflowY == 'auto' ||
                             getComputedStyle(e).overflowY == 'scroll')){
                            e.scrollTop = e.scrollTop + e.clientHeight * 0.7;
                        }
                    }
                })();
            """)
            time.sleep(0.7)
            hit = fr.run_js("""
                return (function(){
                    var cards = document.querySelectorAll('.card-wrap');
                    for (var i=0;i<cards.length;i++){
                        if ((cards[i].textContent||'').indexOf('实验占位请撤销')>=0) return 'Y';
                    }
                    return 'N';
                })();
            """)
            if hit == "Y":
                print("卡片已滚入可视区")
                break
        # 1) kebab (popover target)
        r = fr.run_js(f"""
            var el = (function(){{
                var cards = document.querySelectorAll('.card-wrap');
                for (var i=0;i<cards.length;i++){{
                    if ((cards[i].textContent||'').indexOf('实验占位请撤销')>=0){{
                        return cards[i].querySelector('.weui-desktop-popover__target');
                    }}
                }}
                return null;
            }})();
            if (el) el.setAttribute('{MARK}', '1');
            return el ? 'MARKED' : 'NO_EL';
        """)
        print("kebab:", r)
        click_marked(fr)
        time.sleep(2)
        # 2) popover 状态
        pop = fr.run_js("""
            return (function(){
                var ps = document.querySelectorAll('[class*=popper], .weui-desktop-popover__wrp');
                for (var i=0;i<ps.length;i++){
                    var st = getComputedStyle(ps[i]).display;
                    if (st !== 'none'){
                        return 'OPEN: ' + (ps[i].innerText||'').slice(0,100).replace(/\\n/g,'|');
                    }
                }
                return 'ALL_CLOSED';
            })();
        """)
        print("popover:", str(pop)[:150])
        # 3) 撤销预告项
        r2 = fr.run_js(f"""
            var el = (function(){{
                var ops = document.querySelectorAll('.operation-group');
                for (var i=0;i<ops.length;i++){{
                    var e = ops[i];
                    if ((e.textContent||'').indexOf('撤销预告')>=0
                        && e.getBoundingClientRect().width>0) return e;
                }}
                return null;
            }})();
            if (el) el.setAttribute('{MARK}', '1');
            return el ? 'MARKED' : 'NO_EL';
        """)
        print("撤销项:", r2)
        click_marked(fr)
        time.sleep(3)
        # 4) 可见确认弹窗 dump
        dlg = fr.run_js("""
            return (function(){
                var ds = document.querySelectorAll('.weui-desktop-dialog__wrp');
                for (var i=0;i<ds.length;i++){
                    var r = ds[i].getBoundingClientRect();
                    if (r.width>100){
                        return 'DLG: ' + (ds[i].innerText||'').slice(0,200);
                    }
                }
                return 'NO_DLG';
            })();
        """)
        print("确认弹窗:", str(dlg)[:250])
        # 5) 确认钮 (弹窗内主按钮)
        r3 = fr.run_js(f"""
            var el = (function(){{
                var ds = document.querySelectorAll('.weui-desktop-dialog__wrp');
                for (var i=0;i<ds.length;i++){{
                    if (ds[i].getBoundingClientRect().width<100) continue;
                    var bs = ds[i].querySelectorAll('button, .weui-desktop-btn');
                    for (var j=bs.length-1;j>=0;j--){{
                        var e = bs[j];
                        var t = (e.innerText||'').trim();
                        if (t && e.getBoundingClientRect().width>0) return e;
                    }}
                }}
                return null;
            }})();
            if (el) el.setAttribute('{MARK}', '1');
            return el ? ('BTN:' + (el.innerText||'').trim()) : 'NO_BTN';
        """)
        print("确认钮:", r3)
        if "BTN:" in str(r3):
            click_marked(fr)
            time.sleep(5)
        # 6) 终验
        left = fr.run_js(
            "return (document.body.textContent||'')"
            ".indexOf('实验占位请撤销')>=0;")
        print("实验卡仍在:", left)
        return 0 if not left else 1
    finally:
        try:
            tab.close()
        except Exception:
            pass


if __name__ == "__main__":
    sys.exit(main())
