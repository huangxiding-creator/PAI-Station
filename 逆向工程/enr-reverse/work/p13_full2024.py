# -*- coding: utf-8 -*-
"""P13: 2024版完整250表 OCR 全量 + 2025图侦察"""
import sys, io, json, re, time
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', errors='replace')
from rapidocr_onnxruntime import RapidOCR
ocr = RapidOCR()

def ocr_rows(path):
    res, _ = ocr(path)
    boxes = []
    for box, txt, conf in (res or []):
        boxes.append([(box[0][0]+box[2][0])/2, (box[0][1]+box[2][1])/2, txt, float(conf)])
    boxes.sort(key=lambda b: b[1])
    lines = []
    for b in boxes:
        if lines and abs(b[1]-lines[-1]["y"]) <= 12:
            lines[-1]["items"].append(b); lines[-1]["y"] = (lines[-1]["y"]+b[1])/2
        else:
            lines.append({"y": b[1], "items": [b]})
    return [[(round(b[0]), b[2], round(b[3],2)) for b in sorted(l["items"], key=lambda x:x[0])] for l in sorted(lines, key=lambda l: l["y"])]

out = {}
for i in range(1, 6):
    p = f"E:/AI-Station/逆向工程/enr-reverse/captures/p7_chinca2024_tbl{i}.png"
    t0 = time.time()
    rows = ocr_rows(p)
    out[f"tbl{i}"] = rows
    ranks = []
    for r in rows:
        for x, t, c in r:
            tt = t.strip()
            if re.fullmatch(r"\d{1,3}", tt) and 1 <= int(tt) <= 250:
                ranks.append(int(tt)); break
    sv = sorted(set(ranks))
    print(f"tbl{i}: rows={len(rows)} ranks={len(sv)} range={sv[0] if sv else '-'}-{sv[-1] if sv else '-'} {round(time.time()-t0,1)}s")
json.dump(out, open("E:/AI-Station/逆向工程/enr-reverse/work/p13_ocr_lines_2024.json","w",encoding="utf-8"), ensure_ascii=False)

# 2025 图侦察
p = "E:/AI-Station/逆向工程/enr-reverse/captures/p10_2025_638914717477429679575412"
head = open(p, "rb").read(8)
print("\n2025 img magic:", head[:4].hex(), "PNG" if head[:4]==b"\x89PNG" else ("JPEG" if head[:3]==b"\xff\xd8\xff" else "?"))
rows = ocr_rows(p)
print("2025 rows:", len(rows))
for r in rows[:8]:
    print("   ", " | ".join(t[:30] for _, t, _ in r)[:160])
json.dump({"2025img": rows}, open("E:/AI-Station/逆向工程/enr-reverse/work/p13_ocr_lines_2025.json","w",encoding="utf-8"), ensure_ascii=False)
