import sys, pymupdf
src, dst = sys.argv[1], sys.argv[2]
doc = pymupdf.open(src)
parts = []
for i, page in enumerate(doc):
    parts.append(f"\n===== 第{i+1}页/共{len(doc)}页 =====\n" + page.get_text())
text = "".join(parts)
open(dst, "w", encoding="utf-8").write(text)
print(f"pages={len(doc)} chars={len(text)}")
