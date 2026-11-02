# -*- coding: utf-8 -*-
"""wrapp_zip.py — 微信读书整书ZIP → 站内标准 book.json/md 转换件

输入：chapterdownload 协议返回（或 app 缓存）的整书 ZIP + vid
     （zip 密码 = encryptKey 经 AES-CBC(vid remap 派生) 解出；部分包也可能无密码）
输出：data/weread/<书名slug>/book.json + <书名>.md（与 web 管线产物同构，
     下游 weread_book_products.py / 查重 / 验收 全兼容）

zip 内部结构（HuanMeng 逆向 + 站内 KNOWLEDGE.md §3）：
  info.txt  书籍章节元数据 JSON（chapters[].chapterUid/chapterIdx/title/level/files/wordCount）
  epub: 各章 HTML 文件（chapters[].files 指名）+ Styles/
  txt :  章文件名 = {bookId}_{chapterUid}_o
"""
import argparse
import base64
import io
import json
import os
import re
import sys
import time
import zipfile
from html.parser import HTMLParser


def remap_key_iv(vid: int):
    remap = bytes([0x2d, 0x50, 0x56, 0xd7, 0x72, 0x53, 0xbf, 0x22, 0xfb, 0x20])
    s = str(vid)
    vr = bytes(remap[int(c)] for c in s)
    buf = bytes(vr[i % len(vr)] for i in range(32))
    return buf[:16], buf[16:]


def zip_password(vid: int, encrypt_key_b64: str) -> str:
    from Crypto.Cipher import AES
    key, iv = remap_key_iv(vid)
    data = base64.b64decode(encrypt_key_b64)
    dec = AES.new(key, AES.MODE_CBC, iv).decrypt(data[:16])
    return "".join(chr(b) for b in dec if 32 <= b <= 126)


class _Txt(HTMLParser):
    _SKIP = ("script", "style", "head")

    def __init__(self):
        super().__init__(convert_charrefs=True)
        self.parts = []
        self.imgs = []
        self._skip = 0

    def handle_starttag(self, tag, attrs):
        if tag in self._SKIP:
            self._skip += 1
        if tag == "img":
            d = dict(attrs)
            src = d.get("src") or d.get("data-src")
            if src:
                self.imgs.append(src)
        if tag in ("p", "div", "br", "li", "h1", "h2", "h3", "h4", "tr"):
            self.parts.append("\n")

    def handle_endtag(self, tag):
        if tag in self._SKIP and self._skip:
            self._skip -= 1

    def handle_getdata(self, data):  # placeholder guard (see handle_data)
        pass

    def handle_data(self, data):
        if not self._skip:
            self.parts.append(data)


def html_to_text_md(html: str):
    p = _Txt()
    try:
        p.feed(html)
    except Exception:
        return re.sub(r"<[^>]+>", "", html), []
    text = "".join(p.parts)
    text = re.sub(r"[ \t\xa0]+", " ", text)
    text = re.sub(r"\n{3,}", "\n\n", text).strip()
    return text, p.imgs


def open_zip(path, vid=None, encrypt_key=None):
    raw = open(path, "rb").read()
    pwd = None
    if vid and encrypt_key:
        try:
            pwd = zip_password(int(vid), encrypt_key).encode()
        except Exception as e:
            print("[zip] derive pwd failed:", e)
    zf = zipfile.ZipFile(io.BytesIO(raw))
    enc = any(zi.flag_bits & 0x1 for zi in zf.infolist())
    if enc and pwd is None:
        raise SystemExit("[zip] entries encrypted but no password derivable (need vid+encryptKey)")
    return zf, pwd, enc


def convert(zf, pwd, enc, out_dir, book_id=None, meta=None):
    names = zf.namelist()
    info_name = next((n for n in names if n.endswith("info.txt")), None)
    if not info_name:
        raise SystemExit("[zip] info.txt not found; entries=%d e.g. %s" % (len(names), names[:5]))
    info = json.loads(zf.read(info_name, pwd=pwd if enc else None).decode("utf-8", "replace"))
    book_id = book_id or info.get("bookId", "")
    chapters_meta = info.get("chapters", [])
    is_txt = bool(re.search(r"_%d+_o$" % 0, names[0] or "")) or not any(
        n.endswith((".html", ".xhtml", ".htm")) for n in names)

    chapters = []
    for ch in chapters_meta:
        uid, title = ch.get("chapterUid"), ch.get("title", "")
        entry = {"chapterUid": uid, "title": title, "level": ch.get("level", 1),
                 "html": "", "text": "", "images": []}
        files = ch.get("files")
        if files:  # epub：章内多文件按序拼
            html_parts = []
            for f in files:
                try:
                    b = zf.read(f, pwd=pwd if enc else None).decode("utf-8", "replace")
                    html_parts.append(b)
                except KeyError:
                    pass
            html = "\n".join(html_parts)
            entry["html"] = html
            entry["text"], entry["images"] = html_to_text_md(html)
        else:  # txt：文件名约定
            fname = "%s_%d_o" % (book_id, uid)
            try:
                b = zf.read(fname, pwd=pwd if enc else None)
                entry["text"] = b.decode("utf-8", "replace")
            except KeyError:
                entry["skipped"] = True
        chapters.append(entry)

    md = ["# %s\n" % (meta or {}).get("title", info.get("title", book_id)), ""]
    for ch in chapters:
        md.append("## %s\n" % ch["title"])
        md.append(ch.get("text", ""))
        md.append("")

    os.makedirs(out_dir, exist_ok=True)
    book = {
        "bookId": book_id,
        "title": (meta or {}).get("title", info.get("title", book_id)),
        "author": (meta or {}).get("author", ""),
        "cover": (meta or {}).get("cover", ""),
        "intro": (meta or {}).get("intro", ""),
        "format": (meta or {}).get("format", "txt" if is_txt else "epub"),
        "totalWords": (meta or {}).get("totalWords", sum(c.get("wordCount", 0) for c in chapters_meta)),
        "chapterCount": len(chapters),
        "maxFreeChapter": (meta or {}).get("maxFreeChapter", 0),
        "paid": (meta or {}).get("paid", 1),
        "partial": any(c.get("skipped") for c in chapters),
        "partialReasons": ["zip缺章"] if any(c.get("skipped") for c in chapters) else [],
        "fetchedAt": time.strftime("%Y-%m-%dT%H:%M:%S"),
        "source": "app-zip",
        "chapters": chapters,
    }
    with open(os.path.join(out_dir, "book.json"), "w", encoding="utf-8") as fh:
        json.dump(book, fh, ensure_ascii=False, indent=1)
    with open(os.path.join(out_dir, "%s.md" % re.sub(r'[\\/:*?"<>|]', "_", book["title"])),
              "w", encoding="utf-8") as fh:
        fh.write("\n".join(md))
    empty = sum(1 for c in chapters if not (c.get("text") or "").strip())
    print("[convert] %s: %d章(空文%d/缺%d) → %s" %
          (book["title"], len(chapters), empty,
           sum(1 for c in chapters if c.get("skipped")), out_dir))
    return book


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("zip_path")
    ap.add_argument("--vid")
    ap.add_argument("--encrypt-key", dest="encrypt_key")
    ap.add_argument("--out", required=True)
    ap.add_argument("--meta-json", dest="meta_json", help="web/book/info 元数据补全（可选）")
    a = ap.parse_args()
    meta = json.loads(a.meta_json) if a.meta_json else {}
    zf, pwd, enc = open_zip(a.zip_path, a.vid, a.encrypt_key)
    convert(zf, pwd, enc, a.out, meta=meta)


if __name__ == "__main__":
    sys.exit(main())
