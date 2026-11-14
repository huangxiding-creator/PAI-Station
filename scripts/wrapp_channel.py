# -*- coding: utf-8 -*-
"""wrapp_channel — 微信读书检索+整书下载统一 CLI（生产版, 1102 APK 深逆向产物）

通道:
  搜索  weread.qq.com/api/store/search —— 公共目录, 免登录, 零账号风险
  下载  i.weread.qq.com/book/chapterdownload —— app 域整书一包(2请求/本),
        凭据=模拟器真 app 令牌(data/secrets/weread_app_token.json),
        头表=在线 dump 真值(appver 全版本号 + UA 与注册设备逐字一致, 服务器校验)

产物: data/weread/<书名>/book.json + <书名>.md（站内标准格式, 与 web 管线产物同构）

安全纪律（内建, 不可协商）:
  - 日预算默认 15 本（观察期; 单一台账 _recon/app_daily_count.json）
  - 书间 60-180s 人类抖动由批量件 wrapp_batch.py 管; 本 CLI 单本即时
  - 401=令牌过期 → 跑 `token` 子命令自动恢复（唤醒模拟器 app 滚新令牌重提取, ~30s）
  - soldout=1 已下架书自动识别跳过

用法:
  py -X utf8 scripts/wrapp_channel.py search <关键词> [--pages 3] [--title-contains X]
  py -X utf8 scripts/wrapp_channel.py info <bookId>
  py -X utf8 scripts/wrapp_channel.py download <bookId> [--out 目录]
  py -X utf8 scripts/wrapp_channel.py token            # 令牌自动恢复 SOP
  py -X utf8 scripts/wrapp_channel.py quota            # 查今日台账
"""
from __future__ import annotations

import argparse
import base64
import io
import json
import os
import re
import subprocess
import sys
import time
import zipfile
from html.parser import HTMLParser

import requests

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
REPO = Path = os.path
ROOT = r"E:\AI-Station"
SECRET = os.path.join(ROOT, "data", "secrets", "weread_app_token.json")
OUTROOT = os.path.join(ROOT, "data", "weread")
DAILY = os.path.join(OUTROOT, "_recon", "app_daily_count.json")
EV = os.path.join(ROOT, "逆向工程", "weread-apk-reverse", "evidence")
ADB = os.path.join(ROOT, "rea-tools", "platform-tools", "adb.exe")

try:
    from Crypto.Cipher import AES
except ImportError:  # pragma: no cover
    AES = None

# ---- 头表（1102 Frida spawn 在线 dump 真值；UA 与会话注册设备逐字一致是 200 的硬条件）----
# 1105迁移评估终局: MuMu15无root且weread allowBackup=false → 令牌农场永留雷电(emulator-5554)
APPVER = "10.2.2.10167650"
UA = ("WeRead/10.2.2 WRBrand/redmi Dalvik/2.1.0 "
      "(Linux; U; Android 9; 25102RKBEC Build/PQ3A.190705.09211140)")


def token() -> dict:
    return json.load(open(SECRET, encoding="utf-8"))


def headers():
    t = token()
    return {"Accept-Charset": "UTF-8", "Accept": "*/*",
            "accessToken": t["accessToken"], "vid": t["vid"],
            "appver": APPVER, "basever": APPVER, "baseapi": "28", "osver": "9",
            "channelId": "0", "User-Agent": UA, "Connection": "Keep-Alive"}


# ---------------- 搜索（公共目录, 免登录） ----------------
def _walk_books(o, out: list):
    if isinstance(o, dict):
        if isinstance(o.get("bookInfo"), dict):
            out.append(o["bookInfo"])
        for v in o.values():
            _walk_books(v, out)
    elif isinstance(o, list):
        for v in o:
            _walk_books(v, out)


def search(kw: str, pages: int = 3, title_contains: str = "") -> list[dict]:
    h = {"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/121.0.0.0",
         "Referer": "https://weread.qq.com/"}
    books: dict[str, dict] = {}
    for page in range(pages):
        r = requests.get("https://weread.qq.com/api/store/search",
                         params={"keyword": kw, "maxIdx": page * 50, "count": "50",
                                 "synckey": "0", "scene": "19"}, headers=h, timeout=30)
        found: list = []
        if r.status_code == 200:
            _walk_books(r.json(), found)
        new = 0
        for b in found:
            bid = b.get("bookId")
            if bid and bid not in books:
                books[bid] = {"bookId": bid, "title": b.get("title"),
                              "author": b.get("author")}
                new += 1
        if new == 0:
            break
        time.sleep(3)
    out = list(books.values())
    if title_contains:
        p = title_contains.lower()
        out = [b for b in out if p in (b.get("title") or "").lower()]
    return out


# ---------------- 下载（app 域整书） ----------------
def remap_key_iv(vid: int):
    remap = bytes([0x2d, 0x50, 0x56, 0xd7, 0x72, 0x53, 0xbf, 0x22, 0xfb, 0x20])
    s = str(vid)
    vr = bytes(remap[int(c)] for c in s)
    buf = bytes(vr[i % len(vr)] for i in range(32))
    return buf[:16], buf[16:]


def zip_password(vid: int, encrypt_key_b64: str) -> str:
    data = base64.b64decode(encrypt_key_b64)
    key, iv = remap_key_iv(vid)
    dec = AES.new(key, AES.MODE_CBC, iv).decrypt(data[:16])
    return "".join(chr(b) for b in dec if 32 <= b <= 126)


def book_info(bid: str) -> tuple[int, dict]:
    r = requests.get("https://i.weread.qq.com/book/info",
                     params={"bookId": bid, "myzy": "1", "source": "reading",
                             "teenmode": "0"}, headers=headers(), timeout=30)
    j = r.json() if r.status_code == 200 else {}
    return r.status_code, j


def chapter_download(bid: str, version, fmt: str, chap_end: int):
    return requests.get("https://i.weread.qq.com/book/chapterdownload",
                        params={"bookId": bid, "chapters": "0-%d" % chap_end,
                                "pf": "wechat_wx-2001-android-100-weread",
                                "pfkey": "pfKey", "zoneId": "1",
                                "bookVersion": str(version), "bookType": fmt,
                                "quote": "", "release": "1", "stopAutoPayWhenBNE": "1",
                                "preload": "2", "preview": "0", "offline": "0",
                                "giftPayingCard": "0", "enVersion": "7.5.0",
                                "modernVersion": "7.5.0", "teenmode": "0"},
                        headers=headers(), timeout=120)


class _Txt(HTMLParser):
    _SKIP = ("script", "style", "head")

    def __init__(self):
        super().__init__(convert_charrefs=True)
        self.parts, self.imgs, self._skip = [], [], 0

    def handle_starttag(self, tag, attrs):
        if tag in self._SKIP:
            self._skip += 1
        if tag == "img":
            src = dict(attrs).get("src") or dict(attrs).get("data-src")
            if src:
                self.imgs.append(src)
        if tag in ("p", "div", "br", "li", "h1", "h2", "h3", "h4", "tr"):
            self.parts.append("\n")

    def handle_endtag(self, tag):
        if tag in self._SKIP and self._skip:
            self._skip -= 1

    def handle_data(self, data):
        if not self._skip:
            self.parts.append(data)


def html_to_text(html: str):
    p = _Txt()
    try:
        p.feed(html)
    except Exception:
        return re.sub(r"<[^>]+>", "", html), []
    text = re.sub(r"[ \t\xa0]+", " ", "".join(p.parts))
    return re.sub(r"\n{3,}", "\n\n", text).strip(), p.imgs


def convert_zip(zf, pwd, enc, out_dir, book_id, meta):
    names = zf.namelist()
    info_name = next((n for n in names if n.endswith("info.txt")), None)
    if not info_name:
        raise RuntimeError("zip 无 info.txt")
    info = json.loads(zf.read(info_name, pwd=pwd if enc else None).decode("utf-8", "replace"))
    chapters = []
    for ch in info.get("chapters", []):
        e = {"chapterUid": ch.get("chapterUid"), "title": ch.get("title", ""),
             "level": ch.get("level", 1), "html": "", "text": "", "images": []}
        files = ch.get("files")
        if files:
            html = "\n".join(
                zf.read(f, pwd=pwd if enc else None).decode("utf-8", "replace")
                for f in files if f in names)
            e["html"] = html
            e["text"], e["images"] = html_to_text(html)
        else:
            try:
                e["text"] = zf.read("%s_%d_o" % (book_id, ch.get("chapterUid")),
                                    pwd=pwd if enc else None).decode("utf-8", "replace")
            except KeyError:
                e["skipped"] = True
        chapters.append(e)
    md = ["# %s\n" % meta.get("title", book_id), ""]
    for ch in chapters:
        md += ["## %s\n" % ch["title"], ch.get("text", ""), ""]
    os.makedirs(out_dir, exist_ok=True)
    book = {"bookId": book_id, "title": meta.get("title", ""), "author": meta.get("author", ""),
            "cover": meta.get("cover", ""), "intro": meta.get("intro", ""),
            "format": meta.get("format", "epub"), "totalWords": meta.get("totalWords", 0),
            "chapterCount": len(chapters), "maxFreeChapter": meta.get("maxFreeChapter", 0),
            "paid": meta.get("paid", 1),
            "partial": any(c.get("skipped") for c in chapters),
            "partialReasons": ["zip缺章"] if any(c.get("skipped") for c in chapters) else [],
            "fetchedAt": time.strftime("%Y-%m-%dT%H:%M:%S"), "source": "app-zip",
            "chapters": chapters}
    json.dump(book, open(os.path.join(out_dir, "book.json"), "w", encoding="utf-8"),
              ensure_ascii=False, indent=1)
    fn = re.sub(r'[\\/:*?"<>|]', "_", book["title"] or book_id)
    open(os.path.join(out_dir, fn + ".md"), "w", encoding="utf-8").write("\n".join(md))
    return book


def have_book(bid: str) -> str | None:
    base = OUTROOT
    if not os.path.isdir(base):
        return None
    for d in os.listdir(base):
        p = os.path.join(base, d, "book.json")
        if os.path.exists(p):
            try:
                if json.load(open(p, encoding="utf-8")).get("bookId") == bid:
                    return os.path.join(base, d)
            except Exception:
                pass
    return None


def daily_add(n=1):
    today = time.strftime("%Y-%m-%d")
    d = {}
    if os.path.exists(DAILY):
        try:
            d = json.load(open(DAILY, encoding="utf-8"))
        except Exception:
            pass
    d[today] = d.get(today, 0) + n
    os.makedirs(os.path.dirname(DAILY), exist_ok=True)
    json.dump(d, open(DAILY, "w", encoding="utf-8"), ensure_ascii=False, indent=1)
    return d[today]


def download(bid: str, out: str = "", budget: int = 15) -> int:
    if have_book(bid):
        print("[wrapp] 已在库:", have_book(bid), "— 幂等跳过")
        return 0
    st, j = book_info(bid)
    if st == 401:
        print("[wrapp] 401 令牌过期 → 先跑: py -X utf8 scripts/wrapp_channel.py token")
        return 2
    if st != 200 or not j.get("title"):
        print("[wrapp] info 失败 HTTP", st)
        return 1
    if j.get("soldout") or (not j.get("version") and not j.get("chapterSize")):
        print("[wrapp] 《%s》已下架(soldout=%s)，平台不再分发" % (j["title"], j.get("soldout")))
        return 4
    print("[wrapp] 《%s》%s章 %s字 %s" % (j["title"], j.get("chapterSize"),
                                          format(j.get("totalWords", 0), ","),
                                          j.get("format")))
    time.sleep(6)
    chap_end = int(j.get("chapterSize", 1)) + int(j.get("lastChapterIdx", 0)) - 1
    r2 = chapter_download(bid, j.get("version"), j.get("format", "epub"), chap_end)
    if r2.status_code == 401:
        print("[wrapp] 401 令牌过期 → 先跑 token 子命令")
        return 2
    if r2.status_code == 402:
        print("[wrapp] 402 无整本权限（账号读不了的正常边界）")
        return 4
    if r2.status_code != 200:
        print("[wrapp] download HTTP", r2.status_code, r2.text[:150])
        return 1
    t = token()
    zf = zipfile.ZipFile(io.BytesIO(r2.content))
    enc = any(zi.flag_bits & 0x1 for zi in zf.infolist())
    pwd = zip_password(int(t["vid"]), r2.headers.get("encryptKey", "")).encode() if enc else None
    out_dir = out or os.path.join(OUTROOT, re.sub(r'[\\/:*?"<>|]', "_", j["title"])[:60])
    book = convert_zip(zf, pwd, enc, out_dir, bid,
                       {"title": j["title"], "author": j.get("author", ""),
                        "format": j.get("format"), "totalWords": j.get("totalWords"),
                        "intro": j.get("intro", ""), "cover": j.get("cover", "")})
    os.makedirs(EV, exist_ok=True)
    open(os.path.join(EV, "wrapp_%s.zip" % bid), "wb").write(r2.content)
    n = daily_add(1)
    empty = sum(1 for c in book["chapters"] if not (c.get("text") or "").strip())
    print("[wrapp] ✓ %d章(空文%d) → %s | 今日台账 %d/%d" %
          (len(book["chapters"]), empty, out_dir, n, budget))
    return 0


# ---------------- 令牌自动恢复 SOP ----------------
def token_refresh() -> int:
    dev = "emulator-5554"  # 1105终局: 令牌农场=雷电(MuMu15无root不可迁)
    subprocess.run([ADB, "-s", dev, "shell",
                    "monkey -p com.tencent.weread -c android.intent.category.LAUNCHER 1"],
                   capture_output=True, timeout=60)
    print("[wrapp] 模拟器 app 已唤醒（自动滚新令牌），等 25s …")
    time.sleep(25)
    for f, dst in [("WRAccount", "WRA.db"), ("WRAccount-wal", "WRA.db-wal"),
                   ("WRAccount-shm", "WRA.db-shm")]:
        subprocess.run([ADB, "-s", dev, "shell",
                        "su -c 'cp /data/data/com.tencent.weread/databases/%s /sdcard/%s; "
                        "chmod 666 /sdcard/%s'" % (f, dst, dst)], capture_output=True, timeout=60)
    import sqlite3
    import tempfile
    tmp = tempfile.mkdtemp()
    for dst in ["WRA.db", "WRA.db-wal", "WRA.db-shm"]:
        subprocess.run([ADB, "-s", dev, "pull", "/sdcard/" + dst,
                        os.path.join(tmp, dst)], capture_output=True, timeout=60)
    db = sqlite3.connect(os.path.join(tmp, "WRA.db"))
    row = db.execute("SELECT vid, accessToken, refreshToken FROM Account LIMIT 1").fetchone()
    if not row or not row[1]:
        print("[wrapp] 提取失败（模拟器未开/app未登录?）")
        return 1
    os.makedirs(os.path.dirname(SECRET), exist_ok=True)
    json.dump({"vid": str(row[0]), "accessToken": row[1], "refreshToken": row[2]},
              open(SECRET, "w", encoding="utf-8"), ensure_ascii=False, indent=1)
    print("[wrapp] ✓ 令牌已滚新(%s***) 并落 secrets" % row[1][:4])
    st, _ = book_info("853810")  # 免费公版书做只读探针
    print("[wrapp] 自检 book/info:", "OK" if st == 200 else st)
    return 0 if st == 200 else 1


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__,
                                 formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("cmd", choices=["search", "info", "download", "token", "quota"])
    ap.add_argument("arg", nargs="?", default="")
    ap.add_argument("--pages", type=int, default=3)
    ap.add_argument("--title-contains", dest="tc", default="")
    ap.add_argument("--out", default="")
    ns = ap.parse_args()
    if ns.cmd == "search":
        for b in search(ns.arg, ns.pages, ns.tc):
            have = "HAVE" if have_book(b["bookId"]) else "new "
            print(have, b["bookId"], "|", (b["title"] or "")[:44], "|", (b["author"] or "")[:12])
        return 0
    if ns.cmd == "info":
        st, j = book_info(ns.arg)
        print("HTTP", st, json.dumps({k: j.get(k) for k in (
            "title", "author", "format", "chapterSize", "version", "paid",
            "soldout", "totalWords")}, ensure_ascii=False))
        return 0 if st == 200 else 1
    if ns.cmd == "download":
        return download(ns.arg, ns.out)
    if ns.cmd == "token":
        return token_refresh()
    if ns.cmd == "quota":
        d = json.load(open(DAILY, encoding="utf-8")) if os.path.exists(DAILY) else {}
        today = time.strftime("%Y-%m-%d")
        print("今日 %d/15 本（台账 %s）" % (d.get(today, 0), DAILY))
    return 0


if __name__ == "__main__":
    sys.exit(main())
