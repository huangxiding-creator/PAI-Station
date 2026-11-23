# -*- coding: utf-8 -*-
"""live_qr_fetch_1123 v2 — type:1 重放 → https链接 + 平台原产QR图直存."""
from __future__ import annotations

import base64
import datetime
import json
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

PROMO = Path(__file__).resolve().parent
OUT = PROMO / "live_qr_1123"
OUT.mkdir(exist_ok=True)

SESSION_BY_MD = {
    "12-11": ("L1", "第1讲·开局谋篇"),
    "12-12": ("L2", "第2讲·设计牵头"),
    "12-17": ("L3", "第3讲·费用清单"),
    "12-18": ("L4", "第4讲·优化设计"),
    "12-24": ("L5", "第5讲·分包合同"),
    "12-25": ("L6", "第6讲·计价依据"),
    "12-30": ("L7", "第7讲·结算支付"),
    "12-31": ("L8", "第8讲·知识体系"),
}


def main() -> int:
    caps = json.loads((PROMO / "live_article" / "api_capture_1123.json")
                      .read_text(encoding="utf-8"))
    notices = []
    for it in caps:
        if "current_live_notice" in it["u"]:
            d = json.loads(it["t"])
            notices = (d.get("data") or {}).get("noticeRecords") or []
            break
    ids = {}
    for n in notices:
        ts = n.get("startTime") or 0
        md = datetime.datetime.fromtimestamp(ts).strftime("%m-%d")
        if md in SESSION_BY_MD:
            ids[md] = n["noticeId"]

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
            print("no reserve frame")
            return 1
        ledger = {}
        for md, (ln, label) in SESSION_BY_MD.items():
            nid = ids.get(md)
            if not nid:
                continue
            body = {"noticeId": nid, "type": 1, "scene": 7, "reqScene": 7}
            r = fr.run_js(f"""
                return fetch('/micro/live/cgi-bin/mmfinderassistant-bin/live/live_notice_qrcode',
                    {{method: 'POST',
                     headers: {{'Content-Type': 'application/json'}},
                     body: JSON.stringify({json.dumps(body)})}})
                .then(function(r){{ return r.text(); }});
            """)
            try:
                d = json.loads(r)
                data = d.get("data") or {}
                url = data.get("qrcodeUrl") or ""
                qr_b64 = data.get("qrcode") or ""
                err = d.get("errCode")
            except Exception:
                url = qr_b64 = ""
                err = "PARSE"
            ok = url.startswith("https")
            img = ""
            if qr_b64:
                try:
                    png = base64.b64decode(qr_b64)
                    fp = OUT / f"{ln}_qr.jpg"
                    fp.write_bytes(png)
                    img = f"{fp.name}({len(png)}B)"
                except Exception:
                    img = "DECODE_FAIL"
            print(f"{md} {label}: err={err} https={'Y' if ok else 'N'} "
                  f"url={url[:60]} img={img}")
            if ok:
                ledger[ln] = {"date": md, "label": label, "url": url,
                              "img": img}
            time.sleep(1.2)
        fp = OUT / "qr_links.json"
        fp.write_text(json.dumps(ledger, ensure_ascii=False, indent=1),
                      encoding="utf-8")
        print(f"✓ {len(ledger)}/8 → {fp}")
        return 0 if len(ledger) == 8 else 1
    finally:
        try:
            tab.close()
        except Exception:
            pass


if __name__ == "__main__":
    sys.exit(main())
