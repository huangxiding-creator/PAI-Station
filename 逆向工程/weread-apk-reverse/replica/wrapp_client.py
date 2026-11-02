# -*- coding: utf-8 -*-
"""wrapp_client.py — 微信读书 app 域客户端（真 app 凭证版）

凭证：data/secrets/weread_app_token.json（从模拟器真 app 的 WRAccount 库提取，gitignored）
头表：10.2.2.10167650 地面真值（WRRequestInterceptor/LoginStateInterceptor 逆向实证）
协议：/book/info → /book/chapterdownload?chapters=0-N（整书ZIP）→ encryptKey→vid remap→zip密码
用法：
  python wrapp_client.py info <bookId>
  python wrapp_client.py download <bookId> [--out DIR]
"""
import base64
import io
import json
import os
import sys
import time
import zipfile

import requests

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
from wrapp_zip import zip_password, convert  # noqa: E402

TOKEN = json.load(open(r"E:\AI-Station\data\secrets\weread_app_token.json", encoding="utf-8"))
BASE = "https://i.weread.qq.com"
EV = os.path.join(HERE, "..", "evidence")


def headers():
    # 1102 Frida spawn 竞速 dump 的在线真值：appver=全版本号，UA=会话注册设备（服务器校验一致性）
    return {
        "Accept-Charset": "UTF-8",
        "Accept": "*/*",
        "accessToken": TOKEN["accessToken"],
        "vid": TOKEN["vid"],
        "appver": "10.2.2.10167650",
        "basever": "10.2.2.10167650",
        "baseapi": "28",
        "osver": "9",
        "channelId": "0",
        "User-Agent": ("WeRead/10.2.2 WRBrand/redmi Dalvik/2.1.0 "
                       "(Linux; U; Android 9; 25102RKBEC Build/PQ3A.190705.09211140)"),
        "Connection": "Keep-Alive",
    }


def book_info(sess, book_id):
    r = sess.get(BASE + "/book/info",
                 params={"bookId": book_id, "myzy": "1", "source": "reading", "teenmode": "0"},
                 timeout=30)
    return r


def chapter_download(sess, book_id, version, fmt, chap_end):
    return sess.get(BASE + "/book/chapterdownload",
                    params={"bookId": book_id,
                            "chapters": "0-%d" % chap_end,
                            "pf": "wechat_wx-2001-android-100-weread",
                            "pfkey": "pfKey",
                            "zoneId": "1",
                            "bookVersion": str(version),
                            "bookType": fmt,
                            "quote": "",
                            "release": "1",
                            "stopAutoPayWhenBNE": "1",
                            "preload": "2",
                            "preview": "0",
                            "offline": "0",
                            "giftPayingCard": "0",
                            "enVersion": "7.5.0",
                            "modernVersion": "7.5.0",
                            "teenmode": "0"},
                    timeout=120)


def main():
    cmd = sys.argv[1]
    bid = sys.argv[2]
    sess = requests.Session()
    sess.headers.update(headers())
    if cmd == "info":
        r = book_info(sess, bid)
        j = r.json() if r.status_code == 200 else {}
        keep = {k: j.get(k) for k in ("title", "author", "format", "version", "chapterSize",
                                       "lastChapterIdx", "paid", "maxFreeChapter", "totalWords")}
        print("HTTP", r.status_code, json.dumps(keep, ensure_ascii=False))
        json.dump(j, open(os.path.join(EV, "wrapp_info_%s.json" % bid), "w", encoding="utf-8"),
                  ensure_ascii=False)
        return 0 if r.status_code == 200 else 1
    if cmd == "download":
        r = book_info(sess, bid)
        j = r.json() if r.status_code == 200 else {}
        if r.status_code != 200 or not j.get("title"):
            print("info failed:", r.status_code, r.text[:200])
            return 1
        chap_end = int(j.get("chapterSize", 1)) + int(j.get("lastChapterIdx", 0)) - 1
        print("book:", j["title"], "| chapters 0-%d" % chap_end, "| fmt", j.get("format"))
        time.sleep(6)
        r2 = chapter_download(sess, bid, j.get("version"), j.get("format", "epub"), chap_end)
        print("chapterdownload -> HTTP", r2.status_code, "| %dB" % len(r2.content))
        if r2.status_code != 200:
            print("body:", r2.content[:300].decode("utf-8", "replace"))
            open(os.path.join(EV, "wrapp_dl_%s_%d.bin" % (bid, r2.status_code)), "wb").write(r2.content)
            return 1
        ek = r2.headers.get("encryptKey", "")
        zp = os.path.join(EV, "wrapp_%s.zip" % bid)
        open(zp, "wb").write(r2.content)
        print("zip saved:", zp, "| encryptKey:", ek[:10] + "…")
        try:
            pwd = zip_password(int(TOKEN["vid"]), ek)
            zf = zipfile.ZipFile(io.BytesIO(r2.content))
            enc = any(zi.flag_bits & 0x1 for zi in zf.infolist())
            names = zf.namelist()
            print("entries:", len(names), names[:6], "| encrypted:", enc)
            out = sys.argv[sys.argv.index("--out") + 1] if "--out" in sys.argv else None
            if out:
                convert(zf, pwd.encode() if enc else None, enc, out,
                        book_id=bid, meta={"title": j.get("title"), "author": j.get("author"),
                                            "format": j.get("format"),
                                            "totalWords": j.get("totalWords"),
                                            "intro": j.get("intro", "")})
            else:
                zi = next(z for z in zf.infolist() if not z.is_dir())
                data = zf.read(zi, pwd=pwd.encode()) if enc else zf.read(zi)
                print("sample %r: %dB head=%r" % (zi.filename, len(data), data[:80]))
            return 0
        except Exception as e:
            print("zip handling:", type(e).__name__, e)
            return 3
    print(__doc__)
    return 2


if __name__ == "__main__":
    sys.exit(main())
