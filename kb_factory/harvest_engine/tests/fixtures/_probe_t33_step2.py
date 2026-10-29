# -*- coding: utf-8 -*-
"""T33 取样探针②：三份 GT 首页图 ocr_image 行集 dump（辅助选词+人工确认誊录用）。

FR3.AC2 取样协议：每份 fixture=标题+首页可见文本前 2 个≥4 字词。本探针只产证据
（识别行+置信分+像素盒），词的最终誊录由人工对照确认入 book118_gt.json。
"""
import json
import sys
from pathlib import Path

_FIX = Path(__file__).resolve().parent
sys.path.insert(0, str(_FIX.parents[3]))
sys.path.insert(1, str(_FIX.parents[2]))

from PIL import Image  # noqa: E402

from harvest_engine.render.ocr import ocr_image  # type: ignore

ROOT = _FIX / "book118_gt_pages"

out = {}
for doc_dir in sorted(p for p in ROOT.iterdir() if p.is_dir()):
    img_path = next(doc_dir.glob("0001.*"))
    with Image.open(img_path) as im:
        lines = ocr_image(im.convert("RGB"))
    rows = [{"i": i, "text": ln.text, "score": round(ln.score, 3),
             "box": [round(v) for v in ln.box]}
            for i, ln in enumerate(lines)]
    out[doc_dir.name] = rows
    print(f"===== {doc_dir.name} {img_path.name} lines={len(rows)} =====")
    for r in rows:
        print(r)

(ROOT / "_ocr_lines.json").write_text(json.dumps(out, ensure_ascii=False, indent=1),
                                       encoding="utf-8")
print("dumped ->", ROOT / "_ocr_lines.json")
