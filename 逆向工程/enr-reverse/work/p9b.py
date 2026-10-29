# -*- coding: utf-8 -*-
import sys, io
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', errors='replace')
from rapidocr_onnxruntime import RapidOCR
ocr = RapidOCR()
res, _ = ocr("E:/AI-Station/逆向工程/enr-reverse/captures/p7_chinca2024_tbl1.png")
rows = {}
for box, txt, conf in (res or []):
    y = round((box[0][1]+box[2][1])/2)
    rows.setdefault(y//12, []).append((int(box[0][0]), y, txt, conf))
ys = sorted(rows)
print("groups:", len(ys))
for yk in ys[:14]:
    line = sorted(rows[yk])
    print(f"y~{line[0][1]:4d} " + " | ".join(f"{t}" for _,_,t,_ in line)[:150])
