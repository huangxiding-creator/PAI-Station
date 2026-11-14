# -*- coding: utf-8 -*-
import re
import sys
import zipfile
from collections import Counter
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
fp = Path(r"E:\AI-Station\_proposals\flagship-paid-report-1007\work\m2\audit\sched\out\REPORT_FULL_总包标准版.docx")
z = zipfile.ZipFile(fp)
doc = z.read("word/document.xml").decode("utf-8", "replace")
for m in re.finditer(r"<w:sectPr.*?</w:sectPr>", doc, re.S):
    s = m.group(0)
    mg = re.search(r'<w:pgMar w:top="(-?\d+)" w:right="(-?\d+)" w:bottom="(-?\d+)" w:left="(-?\d+)"', s)
    if mg:
        print(f"边距 上{int(mg.group(1))/20} 右{int(mg.group(2))/20} 下{int(mg.group(3))/20} 左{int(mg.group(4))/20}pt")
        break
fonts = Counter(re.findall(r'w:eastAsia="([^"]+)"', doc))
print(f"中文字体: {dict(fonts.most_common(4))}")
szs = Counter(re.findall(r'<w:sz w:val="(\d+)"', doc))
print(f"字号: {dict({f'{int(k)/2:g}pt': v for k, v in szs.most_common(6)})}")
hdr = [n for n in z.namelist() if "header" in n]
if hdr:
    h = z.read(sorted(hdr)[0]).decode("utf-8", "replace")
    print(f"页眉: {''.join(re.findall(r'<w:t[^>]*>([^<]*)</w:t>', h))[:30]!r}")
ftr = [n for n in z.namelist() if "footer" in n]
if ftr:
    f = z.read(sorted(ftr)[0]).decode("utf-8", "replace")
    print(f"页脚页码域: {'PAGE' in f}")
z.close()
