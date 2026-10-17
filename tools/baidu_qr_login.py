# -*- coding: utf-8 -*-
"""baidu_qr_login.py — 百度网盘扫码登录取 BDUSS（scan-summon 协议配套）.

背景: BaiduPCS-Go 无扫码旗标, 只有 -bduss/-stoken 路; 102G 裁判文书磁力链
云端离线等 BDUSS. 本件纯 HTTP 走 passport 二维码流:
  --qr           生成二维码 PNG + sign/gid 状态落盘
  --poll <秒>    轮询 qristatus, 200 即取 bduss/stoken
凭据纪律: bduss/stoken 只落 data/secrets/baidu_bduss.ini, 绝不打印值(只报长度).
直连(ProxyHandler({})), 国内站不走代理 — 网络统一管理纪律「只探测不动网」.
"""
import argparse
import json
import re
import sys
import time
import uuid
import urllib.request
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

ROOT = Path(r"E:\AI-Station")
STATE = ROOT / "tools" / "baidu_qr_state.json"
QR_PNG = ROOT / "tools" / "baidu_qr.png"
SECRETS = ROOT / "data" / "secrets" / "baidu_bduss.ini"
UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
      "(KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36")

_opener = urllib.request.build_opener(urllib.request.ProxyHandler({}))


def http_jsonp(url, cb="bd__cbs__x"):
    u = url + ("&" if "?" in url else "?") + "callback=" + cb
    req = urllib.request.Request(u, headers={
        "User-Agent": UA, "Referer": "https://pan.baidu.com/"})
    with _opener.open(req, timeout=15) as r:
        txt = r.read().decode("utf-8", "replace")
    m = re.search(re.escape(cb) + r"\((.*)\)\s*$", txt, re.S)
    return json.loads(m.group(1) if m else txt)


def get_qr():
    tt = int(time.time() * 1000)
    gid = str(uuid.uuid4()).upper()
    d = http_jsonp(
        "https://passport.baidu.com/v2/api/getqrcode?lp=pc&qrloginfrom=pc"
        f"&apiver=v3&tt={tt}&gid={gid}&loginVersion=v4&_={tt}")
    sign = d["sign"]
    img = d.get("imgurl", "")
    if img.startswith("//"):
        img_url = "https:" + img
    elif not img.startswith("http"):
        img_url = "https://" + img          # 实测有无协议头两种形态
    else:
        img_url = img
    req = urllib.request.Request(img_url, headers={
        "User-Agent": UA, "Referer": "https://pan.baidu.com/"})
    with _opener.open(req, timeout=15) as r:
        QR_PNG.write_bytes(r.read())
    STATE.write_text(json.dumps(
        {"sign": sign, "gid": gid, "born": time.time()}), encoding="utf-8")
    print(json.dumps({"ok": True, "qr_png": str(QR_PNG),
                      "png_bytes": QR_PNG.stat().st_size}))


def poll(max_sec: int) -> int:
    st = json.loads(STATE.read_text(encoding="utf-8"))
    sign, gid = st["sign"], st["gid"]
    t0 = time.time()
    last = None
    while time.time() - t0 < max_sec:
        tt = int(time.time() * 1000)
        try:
            d = http_jsonp(
                "https://passport.baidu.com/v2/api/qristatus?sign=" + sign +
                "&lp=pc&qrloginfrom=pc&apiver=v3"
                f"&tt={tt}&gid={gid}&_={tt}")
        except Exception as e:  # noqa: BLE001
            print("poll err:", repr(e)[:100])
            time.sleep(3)
            continue
        s = d.get("status")
        if s != last:
            print(f"[{int(time.time() - t0)}s] status={s} errNo={d.get('errNo')}")
            last = s
        if s == 200:
            data = d.get("data") or {}
            bduss = d.get("bduss") or data.get("bduss") or ""
            stoken = d.get("stoken") or data.get("stoken") or ""
            if not bduss:
                print("status=200 但无 bduss 字段, keys=",
                      sorted(list(d.keys()) + list(data.keys())))
                return 3
            SECRETS.parent.mkdir(parents=True, exist_ok=True)
            with open(SECRETS, "w", encoding="utf-8") as f:
                f.write("[baidu]\n"
                        f"bduss = {bduss}\n"
                        f"stoken = {stoken}\n"
                        f"# via qr login {time.strftime('%F %T')}\n")
            print(f"BDUSS_SAVED len={len(bduss)} stoken_len={len(stoken)} "
                  f"file={SECRETS}")
            return 0
        if s == 430:
            print("二维码已过期(430)")
            return 2
        time.sleep(2.5)
    print("TIMEOUT")
    return 1


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--qr", action="store_true")
    ap.add_argument("--poll", type=int, metavar="SEC")
    a = ap.parse_args()
    if a.qr:
        get_qr()
    elif a.poll:
        raise SystemExit(poll(a.poll))
    else:
        ap.print_help()


if __name__ == "__main__":
    main()
