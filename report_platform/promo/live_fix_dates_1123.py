# -*- coding: utf-8 -*-
"""live_fix_dates_1123 — 前两讲日期纠错 (12/11,12/12 → 12/10,12/11).

链: API定位错件 → 撤销×2(kebab菜单) → 建正件×2 → API终验 → 重取L1/L2 QR.
"""
from __future__ import annotations

import datetime
import json
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

PROMO = Path(__file__).resolve().parent
MARK = "data-lpc-mark"

WRONG = [  # (月份-日, 主题关键词)
    ("12-11", "开局谋篇"),
    ("12-12", "设计牵头"),
]
RIGHT = [
    {"no": 1, "month": 12, "day": 10, "topic": "开局谋篇：EPC项目策划要点",
     "desc": "第1讲·熊俊波｜《EPC项目策划管理实务》：EPC项目策划的定位与作用、总体思路、关键内容与实战要点。系列首播。"},
    {"no": 2, "month": 12, "day": 11, "topic": "设计牵头的整体解决方案",
     "desc": "第2讲·熊俊波｜《设计院牵头EPC：模式、痛点与破解》：设计院牵头EPC的机遇与挑战、组织与流程、痛点与破解之道。"},
]


def log(m):
    print(f"[fix {time.strftime('%H:%M:%S')}] {m}", flush=True)


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


def api_notices(fr):
    r = fr.run_js("""
        return fetch('/micro/live/cgi-bin/mmfinderassistant-bin/live/current_live_notice',
            {method: 'POST', headers: {'Content-Type': 'application/json'},
             body: JSON.stringify({timestamp: String(Date.now()), scene: 7, reqScene: 7})})
        .then(function(r){ return r.text(); });
    """)
    d = json.loads(r)
    out = []
    for n in (d.get("data") or {}).get("noticeRecords") or []:
        ts = n.get("startTime") or 0
        out.append({
            "md": datetime.datetime.fromtimestamp(ts).strftime("%m-%d"),
            "intro": n.get("introduction") or "",
            "id": n.get("noticeId"),
        })
    return sorted(out, key=lambda x: x["md"])


def cancel_by_intro(fr, keyword: str) -> bool:
    # 1) 滚动让目标卡可见
    for _ in range(6):
        hit = fr.run_js(f"""
            return (function(){{
                var cards = document.querySelectorAll('.card-wrap');
                for (var i=0;i<cards.length;i++){{
                    if ((cards[i].textContent||'').indexOf('{keyword}')>=0) return 'Y';
                }}
                return 'N';
            }})();
        """)
        if hit == "Y":
            break
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
        time.sleep(0.8)
    # 2) kebab
    r = fr.run_js(f"""
        var el = (function(){{
            var cards = document.querySelectorAll('.card-wrap');
            for (var i=0;i<cards.length;i++){{
                if ((cards[i].textContent||'').indexOf('{keyword}')>=0){{
                    return cards[i].querySelector('.weui-desktop-popover__target');
                }}
            }}
            return null;
        }})();
        if (el) el.setAttribute('{MARK}', '1');
        return el ? 'OK' : 'NO_CARD';
    """)
    if r != "OK":
        log(f"✗ [{keyword}] 卡不可见")
        return False
    click_marked(fr)
    time.sleep(1.5)
    # 3) 撤销预告
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
        return el ? 'OK' : 'NO_OP';
    """)
    if r2 != "OK":
        log(f"✗ [{keyword}] 撤销项不可见")
        return False
    click_marked(fr)
    time.sleep(2.5)
    # 4) 确认弹窗主按钮
    r3 = fr.run_js(f"""
        var el = (function(){{
            var ds = document.querySelectorAll('.weui-desktop-dialog__wrp');
            for (var i=0;i<ds.length;i++){{
                if (ds[i].getBoundingClientRect().width<100) continue;
                var bs = ds[i].querySelectorAll('button, .weui-desktop-btn');
                for (var j=bs.length-1;j>=0;j--){{
                    var e = bs[j];
                    if ((e.innerText||'').trim() && e.getBoundingClientRect().width>0) return e;
                }}
            }}
            return null;
        }})();
        if (el) el.setAttribute('{MARK}', '1');
        return el ? ('OK:' + (el.innerText||'').trim()) : 'NO_BTN';
    """)
    if not str(r3).startswith("OK"):
        log(f"⚠ [{keyword}] 无确认弹窗 (可能已撤)")
        return True
    click_marked(fr)
    time.sleep(4)
    return True


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
        if fr is None:
            log("✗ reserve 未达 (9222状态?)")
            return 1
        log("══ 阶段1: 撤销两件错日期预告")
        for md, kw in WRONG:
            ok = cancel_by_intro(fr, kw)
            log(f"撤销 {md}[{kw}]: 点击链={ok}")
            time.sleep(2)
        # API 核验撤销
        time.sleep(4)
        notices = api_notices(fr)
        gone = all(not (n["md"] == md and kw in n["intro"]) for n in notices
                   for md, kw in WRONG)
        log(f"API核验两错件已消失: {gone} (现存{len(notices)}条: "
            f"{[n['md'] for n in notices]})")
        if not gone:
            log("✗ 撤销未生效 — 停止 (防错上加错)")
            return 2

        log("══ 阶段2: 建两件正确日期预告")
        sys.path.insert(0, str(PROMO))
        from live_preview_create import LiveCreator, LIVE_URL
        # 同tab复用: 直接用现有frame
        c = LiveCreator(tab)
        c.fr = fr                     # 复用已导航的frame
        for s in RIGHT:
            log(f"建 第{s['no']}讲 {s['topic']} 12月{s['day']}日")
            if not c.open_create_dialog():
                log("✗ 对话框未开"); return 3
            if not c.set_datetime(s["day"], 19, 30, month=s["month"]):
                log("✗ 时间设置失败"); c.cancel_dialog(); return 3
            if not c.fill_topic_desc(s["topic"], s["desc"]):
                log("✗ 表单失败"); c.cancel_dialog(); return 3
            if not c.submit():
                log("✗ 提交失败"); return 3
            time.sleep(3)

        log("══ 阶段3: API终验")
        time.sleep(4)
        notices = api_notices(fr)
        for n in notices:
            log(f"  {n['md']} {n['intro'][:20]}")
        want = ["12-10", "12-11", "12-17", "12-18", "12-24", "12-25",
                "12-30", "12-31"]
        got = [n["md"] for n in notices if n["md"].startswith("12-")]
        ok = sorted(got) == want
        log(f"12月八讲日期终验: {ok} ({got})")

        log("══ 阶段4: 重取L1/L2 QR")
        ids = {n["md"]: n["id"] for n in notices}
        ledger_path = PROMO / "live_qr_1123" / "qr_links.json"
        ledger = json.loads(ledger_path.read_text(encoding="utf-8"))
        for md, ln, label in (("12-10", "L1", "第1讲·开局谋篇"),
                              ("12-11", "L2", "第2讲·设计牵头")):
            nid = ids.get(md)
            if not nid:
                log(f"✗ {md} noticeId 缺"); continue
            body = {"noticeId": nid, "type": 1, "scene": 7, "reqScene": 7}
            r = fr.run_js(f"""
                return fetch('/micro/live/cgi-bin/mmfinderassistant-bin/live/live_notice_qrcode',
                    {{method: 'POST',
                     headers: {{'Content-Type': 'application/json'}},
                     body: JSON.stringify({json.dumps(body)})}})
                .then(function(r){{ return r.text(); }});
            """)
            d = json.loads(r)
            data = d.get("data") or {}
            url = data.get("qrcodeUrl") or ""
            import base64
            qr_b64 = data.get("qrcode") or ""
            if url.startswith("https") and qr_b64:
                png = base64.b64decode(qr_b64)
                fp = PROMO / "live_qr_1123" / f"{ln}_qr.jpg"
                fp.write_bytes(png)
                ledger[ln] = {"date": md, "label": label, "url": url,
                              "img": fp.name}
                log(f"✓ {ln} {md} QR重取 {len(png)}B")
            else:
                log(f"✗ {ln} QR失败: err={d.get('errCode')}")
            time.sleep(1.2)
        ledger_path.write_text(json.dumps(ledger, ensure_ascii=False, indent=1),
                               encoding="utf-8")
        log(f"QR台账已更新 → {ledger_path}")
        return 0 if ok else 4
    finally:
        try:
            tab.close()
        except Exception:
            pass


if __name__ == "__main__":
    sys.exit(main())
