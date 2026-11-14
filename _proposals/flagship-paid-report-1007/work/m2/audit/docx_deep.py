# -*- coding: utf-8 -*-
"""docx_deep — 金标准深挖: 样式ID真身/章头实貌/页脚页码/段距规律."""
import re
import sys
import zipfile
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
USER = Path(r"E:\AI-Station\ResearchFactory-Eng\06 迭代优化\《EPC工程审计与决算实战研究报告》（总包创研院）20261114.docx")
z = zipfile.ZipFile(USER)
styles = z.read("word/styles.xml").decode("utf-8", "replace")
doc = z.read("word/document.xml").decode("utf-8", "replace")

# 1. 用到的样式ID → 定义
used = ["168", "5", "174", "30", "172", "173", "6", "16", "171", "27"]
for sid in used:
    m = re.search(r'<w:style [^>]*w:styleId="%s"[^>]*>(.*?)</w:style>' % sid, styles, re.S)
    if not m:
        continue
    s = m.group(1)
    name = re.search(r'<w:name w:val="([^"]+)"', s)
    font = re.search(r'w:eastAsia="([^"]+)"', s)
    sz = re.search(r'<w:sz w:val="(\d+)"', s)
    bold = "B" if 'w:b/>' in s or '<w:b ' in s else ""
    spacing = re.search(r'w:line="(\d+)"', s)
    before = re.search(r'w:before="(\d+)"', s)
    after = re.search(r'w:after="(\d+)"', s)
    ind = re.search(r'w:firstLine="(\d+)"', s)
    print(f"样式{sid}: {name.group(1) if name else '?':<20} "
          f"字体={font.group(1) if font else '-':<10} "
          f"字号={int(sz.group(1))/2 if sz else '-':>4}pt {bold} "
          f"行距={spacing.group(1) if spacing else '-'} "
          f"段前={before.group(1) if before else '-'} 段后={after.group(1) if after else '-'} "
          f"缩进={ind.group(1) if ind else '-'}")

# 2. 章标题实貌 (24pt的上下文)
print("\n=== 24pt run 上下文 ===")
for m in re.finditer(r'<w:sz w:val="48"/>', doc):
    ctx = doc[m.start()-800:m.start()+900]
    txt = "".join(re.findall(r"<w:t[^>]*>([^<]*)</w:t>", ctx))
    print(f"  …{txt[:60]}…")
    break

# 3. 页脚内容
for n in sorted(z.namelist()):
    if "footer" in n:
        f = z.read(n).decode("utf-8", "replace")
        txt = "".join(re.findall(r"<w:t[^>]*>([^<]*)</w:t>", f))
        print(f"\n{n}: {txt[:60]!r} | 页码域={'PAGE' in f}")

# 4. 正文段落段后距规律 (样式168的样段)
m = re.search(r'<w:p [^>]*>(?:(?!</w:p>).)*?w:val="168".*?</w:p>', doc, re.S)
if m:
    s = m.group(0)
    txt = "".join(re.findall(r"<w:t[^>]*>([^<]*)</w:t>", s))[:40]
    after = re.search(r'w:after="(\d+)"', s)
    line = re.search(r'w:line="(\d+)"', s)
    ind = re.search(r'w:firstLine="(\d+)"', s)
    print(f"\n正文样段: {txt!r} 段后={after.group(1) if after else '-'} 行距={line.group(1) if line else '-'} 缩进={ind.group(1) if ind else '-'}")
z.close()
