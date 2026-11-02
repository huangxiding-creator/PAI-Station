# -*- coding: utf-8 -*-
"""wrapp_probe.py — 微信读书 app 域协议探针（只读，2 请求封顶）

地面真值来源：微信读书.apk 10.2.2.10167650 静态逆向
  - LoginStateInterceptor: 登录态= accessToken + vid 两头（无签名无设备指纹）
  - WRRequestInterceptor$Companion: basever=versionName.versionCode, baseapi=SDK_INT,
    channelId=ChannelConfig, UA="WeRead/<ver> WRBrand/<brand> Dalvik/2.1.0 (...)"
  - HuanMeng233/weread_downloader: /book/info + /book/chapterdownload?chapters=0-N 整书ZIP
  - encryptKey 响应头 -> AES-CBC(vid派生) -> zip 密码

安全纪律：只读探测；凭据不打印；输出落 evidence/；单靶小书(3300229637, 13章)。
"""
import base64
import hashlib
import io
import json
import os
import sys
import time
import zipfile

import requests

ROOT = os.path.dirname(os.path.abspath(__file__))
AUTH = r"E:\AI-Station\data\weread\_auth\weread_auth.json"
EV = os.path.join(ROOT, "..", "evidence")
os.makedirs(EV, exist_ok=True)

BOOK_ID = "3300229637"  # AI时代的新职业图谱（13章，此前已全本提取=账号有阅读权）

BASE = "https://i.weread.qq.com"
HDRS = {
    "appver": "10.2.2",
    "basever": "10.2.2.10167650",
    "baseapi": "34",          # Android 14 / SDK 34（真值=Build.VERSION.SDK_INT）
    "osver": "14",
    "channelId": "12",        # ChannelConfig.getChannelId()（渠道位）
    "User-Agent": ("WeRead/10.2.2 WRBrand/xiaomi Dalvik/2.1.0 "
                   "(Linux; U; Android 14; 2304FPN6DC Build/UKQ1.230804.001)"),
    "Connection": "Keep-Alive",
}


def load_auth():
    d = json.load(open(AUTH, encoding="utf-8"))
    cookie = d.get("cookie", "")
    skey = ""
    for kv in cookie.split(";"):
        k, _, v = kv.strip().partition("=")
        if k == "wr_skey":
            skey = v
    return skey, d.get("vid", "")


def remap_key_iv(vid: int):
    """vid 数位 -> remap 表派生 32B：key=前16B, iv=后16B（HuanMeng 逆向，待 APK 复核）"""
    remap = bytes([0x2d, 0x50, 0x56, 0xd7, 0x72, 0x53, 0xbf, 0x22, 0xfb, 0x20])
    s = str(vid)
    vr = bytes(remap[int(c)] for c in s)
    buf = bytes(vr[i % len(vr)] for i in range(32))
    return buf[:16], buf[16:]


def zip_password(vid: int, encrypt_key_b64: str) -> str:
    from Crypto.Cipher import AES  # pycryptodome
    key, iv = remap_key_iv(vid)
    data = base64.b64decode(encrypt_key_b64)
    dec = AES.new(key, AES.MODE_CBC, iv).decrypt(data[:16])
    return "".join(chr(b) for b in dec if 32 <= b <= 126)


def main():
    skey, vid = load_auth()
    if not skey or not vid:
        print("[probe] auth incomplete: skey_present=%s vid_present=%s" % (bool(skey), bool(vid)))
        return 2
    h = dict(HDRS)
    h["accessToken"] = skey
    h["vid"] = vid
    sess = requests.Session()
    sess.headers.update(h)

    # ---- 请求1：book/info（纯元数据，等价开书详情页）----
    t0 = time.time()
    r1 = sess.get(BASE + "/book/info",
                  params={"bookId": BOOK_ID, "myzy": "1", "source": "reading", "teenmode": "0"},
                  timeout=30)
    dt1 = time.time() - t0
    print("[probe] book/info -> HTTP %d (%.2fs)" % (r1.status_code, dt1))
    info = {}
    try:
        info = r1.json()
    except Exception:
        pass
    keep = {k: info.get(k) for k in ("title", "author", "format", "version",
                                     "chapterSize", "lastChapterIdx", "paid",
                                     "maxFreeChapter", "totalWords", "bookId")}
    print("[probe] info:", json.dumps(keep, ensure_ascii=False))
    open(os.path.join(EV, "probe_book_info_%s.json" % BOOK_ID), "wb").write(r1.content)
    if r1.status_code != 200 or not info.get("title"):
        print("[probe] book/info FAILED — auth/params problem, stop here.")
        return 1

    # ---- 请求2：chapterdownload chapters=0-1（最小整包，验权限+加密链）----
    time.sleep(8)  # 请求间隔，探针克制
    chap_end = min(int(info.get("chapterSize", 1)) + int(info.get("lastChapterIdx", 0)) - 1, 1)
    t0 = time.time()
    r2 = sess.get(BASE + "/book/chapterdownload",
                  params={"bookId": BOOK_ID,
                          "chapters": "0-%d" % chap_end,
                          "pf": "wechat_wx-2001-android-100-weread",
                          "pfkey": "pfKey",
                          "zoneId": "1",
                          "bookVersion": str(info.get("version", "")),
                          "bookType": info.get("format", "epub"),
                          "quote": "",
                          "release": "1",
                          "stopAutoPayWhenBNE": "1",
                          "preload": "2",
                          "preview": "0",
                          "offline": "0",
                          "giftPayingCard": "0",
                          "enVersion": "7.5.0",      # 服务端兼容参数，暂按巨人件
                          "modernVersion": "7.5.0",
                          "teenmode": "0"},
                  timeout=60)
    dt2 = time.time() - t0
    print("[probe] chapterdownload -> HTTP %d (%.2fs, %dB)" % (r2.status_code, dt2, len(r2.content)))
    if r2.status_code in (401, 402):
        print("[probe] body:", r2.content[:300].decode("utf-8", "replace"))
        open(os.path.join(EV, "probe_chapterdl_%s_%d.bin" % (BOOK_ID, r2.status_code)), "wb").write(r2.content)
        print("[probe] %d => %s" % (r2.status_code, "登录失效" if r2.status_code == 401 else "无整本下载权限"))
        return 1
    if r2.status_code != 200:
        open(os.path.join(EV, "probe_chapterdl_%s_%d.bin" % (BOOK_ID, r2.status_code)), "wb").write(r2.content)
        print("[probe] unexpected status", r2.status_code)
        return 1

    ek = r2.headers.get("encryptKey", "")
    print("[probe] encryptKey present:", bool(ek))
    raw = r2.content
    open(os.path.join(EV, "probe_chapterdl_%s.zip" % BOOK_ID), "wb").write(raw)
    print("[probe] zip sha256:", hashlib.sha256(raw).hexdigest()[:16], "…")

    # ---- 解密验证 ----
    try:
        pwd = zip_password(int(vid), ek)
        print("[probe] zip pwd derived, len=%d" % len(pwd))
        zf = zipfile.ZipFile(io.BytesIO(raw))
        names = zf.namelist()
        print("[probe] zip entries:", len(names), names[:8])
        got_enc = any(zinfo.flag_bits & 0x1 for zinfo in zf.infolist())
        print("[probe] entries encrypted flag:", got_enc)
        # 读一个明文/解密条目抽样验证
        zinfo = next(z for z in zf.infolist() if not z.is_dir())
        data = zf.read(zinfo, pwd=pwd.encode() if got_enc else None)
        print("[probe] sample entry %r: %dB, head=%r" % (zinfo.filename, len(data), data[:60]))
        return 0
    except Exception as e:
        print("[probe] decrypt/verify error:", type(e).__name__, e)
        return 3


if __name__ == "__main__":
    sys.exit(main())
