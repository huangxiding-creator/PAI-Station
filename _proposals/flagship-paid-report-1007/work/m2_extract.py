# -*- coding: utf-8 -*-
"""m2_extract — 蓝皮书 M2 源抽取器: docx/html -> 带段级锚点的纯文本 + 标题索引.
用法: python m2_extract.py <src.docx|src.html> <out_prefix>
产出: <out_prefix>.txt  ([P000123] 段锚)  + <out_prefix>.headings.md (标题索引)
"""
import io
import re
import sys

sys.stdout.reconfigure(encoding="utf-8", errors="replace")


def extract_docx(path):
    from docx import Document  # python-docx
    doc = Document(path)
    lines = []
    for i, p in enumerate(doc.paragraphs):
        t = p.text.strip()
        if t:
            lines.append((i, p.style.name if p.style else "", t))
    # 表格文本也抽(段锚 T0001-*)
    for ti, tbl in enumerate(doc.tables):
        for ri, row in enumerate(tbl.rows):
            cells = [c.text.strip().replace("\n", " ") for c in row.cells]
            if any(cells):
                lines.append((f"T{ti:03d}r{ri:02d}", "TABLE", " | ".join(cells)))
    return lines


HEADING_RE = re.compile(
    r"^((第[一二三四五六七八九十百0-9]+[章节部分篇])|(\d+(\.\d+){0,3}\s+\S)|([一二三四五六七八九十]+、\S)|"
    r"(摘要|目录|前言|附录|结论|引言|导读))")


def main():
    src, prefix = sys.argv[1], sys.argv[2]
    if src.lower().endswith(".docx"):
        lines = extract_docx(src)
    else:
        from html.parser import HTMLParser

        class Txt(HTMLParser):
            def __init__(self):
                super().__init__()
                self.buf, self.skip = [], 0

            def handle_starttag(self, tag, attrs):
                if tag in ("script", "style"):
                    self.skip += 1

            def handle_endtag(self, tag):
                if tag in ("script", "style") and self.skip:
                    self.skip -= 1

        # html 正文抽取走简单正则剥壳
        html = io.open(src, encoding="utf-8", errors="replace").read()
        html = re.sub(r"(?is)<(script|style)[^>]*>.*?</\1>", "", html)
        text = re.sub(r"(?s)<[^>]+>", "\n", html)
        text = re.sub(r"\n{2,}", "\n", text)
        lines = [(i, "HTML", t.strip()) for i, t in enumerate(text.split("\n")) if t.strip()]
    with io.open(prefix + ".txt", "w", encoding="utf-8") as f:
        for a, st, t in lines:
            a = a if isinstance(a, str) else f"P{a:06d}"
            f.write(f"[{a}] {t}\n")
    with io.open(prefix + ".headings.md", "w", encoding="utf-8") as f:
        for a, st, t in lines:
            if st.startswith("Heading") or (len(t) < 60 and HEADING_RE.match(t)):
                a = a if isinstance(a, str) else f"P{a:06d}"
                f.write(f"[{a}] ({st}) {t}\n")
    n = sum(len(t) for _, _, t in lines)
    print(f"OK paras={len(lines)} chars={n} -> {prefix}.txt/.headings.md")


if __name__ == "__main__":
    main()
