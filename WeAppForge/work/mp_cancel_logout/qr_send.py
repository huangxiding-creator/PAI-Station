# -*- coding: utf-8 -*-
"""qr_send.py — 截专属浏览器当前登录二维码，企微 webhook 图片直发。

用法: python qr_send.py   （从任意 cwd，内部用绝对路径）
手机企微收图后长按识别二维码即可完成登录（登录落在 9336 专属浏览器）。
"""
import base64
import configparser
import hashlib
import json
import sys
import time
import urllib.request
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
HERE = Path(__file__).parent
sys.path.insert(0, str(HERE))

from DrissionPage import ChromiumPage  # noqa: E402
from driver import attach_or_launch, qr_fresh  # noqa: E402

SECRET = Path(r"E:\AI-Station\config\wecom.secret.ini")


def webhook():
    parser = configparser.ConfigParser()
    parser.read(str(SECRET), encoding="utf-8")
    return parser.get("wecom", "webhook")


def main(force_fresh=True):
    page = attach_or_launch()
    tab = page.latest_tab
    if force_fresh:
        tab.get("https://mp.weixin.qq.com/")  # 强制重开：必得新会话新码（旧码过期=重发必败）
        time.sleep(2)
    fresh = qr_fresh(tab)
    out = {"fresh": fresh, "url": (tab.url or "")[:80]}

    img = tab.ele('tag:img@[src*=scanloginqrcode]', timeout=5)
    shot = HERE / "qr_latest.png"
    ok = False
    if img:
        try:
            r = img.get_screenshot(path=str(HERE), name="qr_latest")
            ok = (HERE / "qr_latest.png").exists()
        except Exception:
            ok = False
    if not ok:
        tab.get_screenshot(path=str(shot))  # 兜底：整窗截图
    data = (HERE / "qr_latest.png").read_bytes()
    out["bytes"] = len(data)

    payload = json.dumps({
        "msgtype": "image",
        "image": {"base64": base64.b64encode(data).decode("ascii"),
                  "md5": hashlib.md5(data).hexdigest()},
    }).encode("ascii")
    req = urllib.request.Request(webhook(), data=payload,
                                 headers={"Content-Type": "application/json"})
    with urllib.request.urlopen(req, timeout=15) as resp:
        out["wecom"] = json.loads(resp.read().decode("utf-8"))
    print(json.dumps(out, ensure_ascii=True))
    return 0 if out["wecom"].get("errcode") == 0 else 1


if __name__ == "__main__":
    sys.exit(main())
