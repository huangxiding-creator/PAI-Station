# -*- coding: utf-8 -*-
"""P11: ENR 榜图 OCR 全量行抽取 (2026版4图) + 三道验证门"""
import sys, io, json, re, time
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', errors='replace')
from rapidocr_onnxruntime import RapidOCR
ocr = RapidOCR()

IMG_PREFIX = "E:/AI-Station/逆向工程/enr-reverse/captures/p10_2026_"
IMGS = ["639244645774959654768356", "639244724895586916296966",
        "639244727675116509911985", "639244727795429034281045"]

def ocr_rows(path):
    res, _ = ocr(path)
    W = None
    boxes = []
    for box, txt, conf in (res or []):
        x = (box[0][0] + box[2][0]) / 2
        y = (box[0][1] + box[2][1]) / 2
        boxes.append([x, y, txt, float(conf)])
    # 行簇: y 相差 <=12 归一行
    boxes.sort(key=lambda b: b[1])
    lines = []
    for b in boxes:
        if lines and abs(b[1] - lines[-1]["y"]) <= 12:
            lines[-1]["items"].append(b); lines[-1]["y"] = (lines[-1]["y"] + b[1]) / 2
        else:
            lines.append({"y": b[1], "items": [b]})
    rows = []
    for ln in sorted(lines, key=lambda l: l["y"]):
        its = sorted(ln["items"], key=lambda b: b[0])
        rows.append([(round(b[0]), b[2], b[3]) for b in its])
    return rows

def is_num(t):
    return bool(re.fullmatch(r"[\d,]+(?:\.\d+)?", t.replace(" ", "")))

all_rows = []
for im in IMGS:
    t0 = time.time()
    rows = ocr_rows(IMG_PREFIX + im)
    print(f"\n== {im}: {len(rows)} 行簇, {round(time.time()-t0,1)}s ==")
    for r in rows[:6]:
        print("   ", " | ".join(t[:34] for _, t, _ in r)[:170])
    all_rows.append((im, rows))
json.dump([(im, rows) for im, rows in all_rows],
          open("E:/AI-Station/逆向工程/enr-reverse/work/p11_ocr_lines_2026.json", "w", encoding="utf-8"),
          ensure_ascii=False)
print("\nSAVED p11_ocr_lines_2026.json")
