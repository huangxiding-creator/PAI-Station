# -*- coding: utf-8 -*-
"""资产内联器 — slides/*.html 的 media/ 引用 → .src/inlined/*.html 的 data: URI。
sliders 源保持干净可编辑; 装配器只认 inlined 目录（契约: 最终文档零外链）。
"""
import base64
import json
import re
import shutil
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
SRC = Path(__file__).resolve().parent
SLIDES = SRC / "slides"
INLINED = SRC / "inlined"
MEDIA = SRC / "media"

MIME = {".jpg": "image/jpeg", ".jpeg": "image/jpeg", ".png": "image/png", ".webp": "image/webp"}


def datauri(p: Path) -> str:
    mime = MIME.get(p.suffix.lower(), "application/octet-stream")
    return "data:" + mime + ";base64," + base64.b64encode(p.read_bytes()).decode("ascii")


if INLINED.exists():
    shutil.rmtree(INLINED)
INLINED.mkdir()
shutil.copy(SLIDES / "deck.css", INLINED / "deck.css")

manifest = json.loads((SLIDES / "deck.json").read_text(encoding="utf-8"))
for s in manifest["slides"]:
    sid = s["id"]
    t = (SLIDES / f"{sid}.html").read_text(encoding="utf-8")

    def sub_src(m):
        p = MEDIA / m.group(1)
        if not p.exists():
            sys.exit(f"missing media: {p}")
        return 'src="' + datauri(p) + '"'

    def sub_url(m):
        p = MEDIA / m.group(1)
        if not p.exists():
            sys.exit(f"missing media: {p}")
        return 'url("' + datauri(p) + '")'

    t = re.sub(r'src="media/([^"]+)"', sub_src, t)
    t = re.sub(r'url\("media/([^"]+)"\)', sub_url, t)
    (INLINED / f"{sid}.html").write_text(t, encoding="utf-8")
    print(f"inlined {sid}")
shutil.copy(SLIDES / "deck.json", INLINED / "deck.json")
print("inline done ->", INLINED)
