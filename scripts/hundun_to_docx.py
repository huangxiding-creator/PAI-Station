"""混沌学园 markdown → DOCX（metaso 专题库上传格式）。"""
import glob
import os
import re
import sys

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

from docx import Document
from docx.oxml.ns import qn
from docx.shared import Pt

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SRC = os.path.join(ROOT, "data", "hundun")


def add_para(doc, text, size=11, bold=False):
    p = doc.add_paragraph()
    run = p.add_run(text)
    run.font.size = Pt(size)
    run.font.bold = bold
    run.font.name = "Calibri"
    run._element.rPr.rFonts.set(qn("w:eastAsia"), "微软雅黑")
    return p


def convert(md_path: str) -> str:
    doc = Document()
    lines = open(md_path, encoding="utf-8").read().splitlines()
    for line in lines:
        s = line.strip()
        if not s:
            continue
        if s.startswith("# "):
            add_para(doc, s[2:], size=18, bold=True)
        elif s.startswith("## "):
            add_para(doc, s[3:], size=14, bold=True)
        elif s.startswith("- "):
            add_para(doc, "• " + s[2:])
        else:
            add_para(doc, s)
    out = os.path.splitext(md_path)[0] + ".docx"
    doc.save(out)
    return out


def main():
    for md in sorted(glob.glob(os.path.join(SRC, "*.md"))):
        out = convert(md)
        print(f"[docx] {os.path.basename(md)} -> {os.path.basename(out)} "
              f"({os.path.getsize(out) // 1024}KB)")


if __name__ == "__main__":
    main()
