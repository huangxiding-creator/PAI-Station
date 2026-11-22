# -*- coding: utf-8 -*-
"""F8 多形态派生 v2: 章小结抓取正则修正."""
from pathlib import Path
import re

src = Path(r"E:\AI-Station\_proposals\flagship-paid-report-1007\work\m2\f8ef8\sched")
out = ["# 招投标新规全景与企业实战·速读版", ""]
chk = ["# 招投标新规全景与企业实战·行动清单版", ""]
for f in sorted(src.glob("_ch*_final.md")):
    t = f.read_text(encoding="utf-8", errors="replace")
    m = re.search(r"^# (第.+章 .+)$", t, re.M)
    title = m.group(1) if m else f.stem
    out.append("## " + title)
    out.append("")
    mm = re.search(r"^## .{0,6}本章小结.*?$\n(.*?)(?=^## |\Z)", t, re.M | re.S)
    if mm:
        body = mm.group(1).strip()
    else:
        mm2 = re.search(r"^## \d+\.\d+ .{0,30}小结.*?$\n(.*?)(?=^## |\Z)", t, re.M | re.S)
        body = mm2.group(1).strip() if mm2 else ""
    if body:
        out.append(body[:2800])
        out.append("")
        for line in body.split("\n"):
            if re.match(r"^\d+[.、]", line.strip()):
                chk.append("- [" + title[1:5] + "] " + line.strip()[:130])
q = "\n".join(out)
c = "\n".join(chk)
Path(r"E:\AI-Station\data\factory\products\EPC-F8EF8\速读版.md").write_text(q, encoding="utf-8")
Path(r"E:\AI-Station\data\factory\products\EPC-F8EF8\行动清单版.md").write_text(c, encoding="utf-8")
print("速读版:", len(re.findall(r"[一-鿿]", q)), "CJK | 清单版:", len(re.findall(r"[一-鿿]", c)), "CJK")
