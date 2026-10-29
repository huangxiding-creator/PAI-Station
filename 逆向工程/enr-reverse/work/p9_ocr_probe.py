# -*- coding: utf-8 -*-
import sys, io
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', errors='replace')
from rapidocr_onnxruntime import RapidOCR
ocr = RapidOCR()
res, _ = ocr("E:/AI-Station/逆向工程/enr-reverse/captures/p7_chinca2024_tbl3.png")
print("boxes:", len(res) if res else 0)
for box, txt, conf in (res or [])[:40]:
    y = int(box[0][1]); x = int(box[0][0])
    print(f"  y={y:5d} x={x:5d} {conf:.2f} {txt[:70]}")
