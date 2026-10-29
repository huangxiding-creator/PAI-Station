# -*- coding: utf-8 -*-
"""P12: rank 覆盖度分析"""
import sys, io, json, re
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', errors='replace')
data = json.load(open("E:/AI-Station/逆向工程/enr-reverse/work/p11_ocr_lines_2026.json", encoding="utf-8"))
names = {"639244645774959654768356": "img1_CN名单", "639244724895586916296966": "img2_intlA",
         "639244727675116509911985": "img3_intlB", "639244727795429034281045": "img4_intlC"}
for im, rows in data:
    ranks = []
    for r in rows:
        # 找行首 1-3 位的纯数字 token (rank 2026)
        for x, t, conf in r:
            tt = t.strip().replace(" ", "")
            if re.fullmatch(r"\d{1,3}", tt) and 1 <= int(tt) <= 250:
                ranks.append((int(tt), x, t))
                break
    vals = [v for v, _, _ in ranks]
    print(f"\n== {names.get(im, im)}: rows={len(rows)} rank候选={len(vals)}")
    if vals:
        print("   range:", min(vals), "-", max(vals))
        # 缺口
        sv = sorted(set(vals))
        gaps = [(a, b) for a, b in zip(sv, sv[1:]) if b - a > 1]
        print("   内部缺口:", gaps[:10] if gaps else "无")
        print("   前12:", sv[:12])
        print("   后8:", sv[-8:])
