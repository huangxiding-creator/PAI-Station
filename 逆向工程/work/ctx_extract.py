# -*- coding: utf-8 -*-
"""Extract context windows around keywords in the minified biz bundle."""
import io, re, sys

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8", errors="replace")
path = r"e:\AI-Station\逆向工程\extracted\app64\resources\biz\index.js"
src = open(path, "r", encoding="utf-8", errors="replace").read()
print("len:", len(src))

KEYWORDS = ["微信", "WeChat", "wechat", "OCR", "ocr", "accessib", "clipboard", "desktopCapturer",
            "Moments", "群聊", "群", "screen", "Screen", "capture", "识别", "截图", "wxid", "wx_"]

seen_spans = set()
def dump(kw, limit=6, width=220):
    print(f"\n########## {kw} ##########")
    count = 0
    for m in re.finditer(re.escape(kw), src):
        s = max(0, m.start() - width)
        e = min(len(src), m.end() + width)
        key = (s // 100, kw)
        if key in seen_spans:
            continue
        seen_spans.add(key)
        snippet = src[s:e].replace("\n", "\\n")
        print(f"--- @{m.start()} ---")
        print(snippet)
        count += 1
        if count >= limit:
            break

for kw in KEYWORDS:
    dump(kw)
