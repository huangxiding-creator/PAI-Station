#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""waytoagi 语料 md → docx 批量转换（pandoc 引擎）+ 归置到 04 智库。

- 引擎：pypandoc(pandoc 3.9)，gfm 输入（支持管道表格/任务列表/删除线）
- 中文字体：生成 reference.docx（正文宋体/代码 Consolas，东亚字体 w:eastAsia 正确设置）
- 断点续跑：目标 docx 已存在则跳过
- 布局：04 智库/通往AGI之路/<L1章节>/<同名>.md + .docx；doc-map 缺章节的入 _未分类/
- 并行：ProcessPoolExecutor(默认 6)

用法：python md2docx_batch.py [--limit N] [--workers N] [--md-only]
  --md-only  只归置 md（不转 docx）——2026-09-12 起用户政策：补齐文档仅 md，
             秘塔也仅传 md；存量 3398 篇的 docx 保留不动
"""
import argparse
import json
import os
import re
import sys
import traceback
from concurrent.futures import ProcessPoolExecutor, as_completed

SKILL = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
STATE = os.path.join(SKILL, "state")
WIKI_DIR = r"E:\AI-Station\ResearchFactory-Eng\feishu-Down\wiki-output\waytoagi"
KB_DIR = r"E:\AI-Station\04 智库\通往AGI之路"

FM_RE = re.compile(r"\A---\s*\n.*?\n---\s*\n", re.S)


def make_reference_docx(path):
    """pandoc 参照文档：正文宋体小四、标题黑体、东亚字体正确。"""
    from docx import Document
    from docx.shared import Pt
    from docx.oxml.ns import qn

    doc = Document()
    styles = doc.styles

    def set_font(style, ascii_font, ea_font, size=None, bold=None):
        f = style.font
        f.name = ascii_font
        if size:
            f.size = Pt(size)
        if bold is not None:
            f.bold = bold
        rpr = style.element.get_or_add_rPr()
        rf = rpr.find(qn("w:rFonts"))
        if rf is None:
            rf = rpr.makeelement(qn("w:rFonts"), {})
            rpr.append(rf)
        rf.set(qn("w:eastAsia"), ea_font)

    set_font(styles["Normal"], "Times New Roman", "宋体", 12)
    sizes = {"Heading 1": 18, "Heading 2": 15, "Heading 3": 13,
             "Heading 4": 12, "Heading 5": 12, "Heading 6": 12}
    for name, size in sizes.items():
        if name in [s.name for s in styles]:
            set_font(styles[name], "Arial", "黑体", size, bold=True)
    for name in ("Source Code", "Verbatim Char"):
        try:
            set_font(styles[name], "Consolas", "宋体", 10.5)
        except KeyError:
            pass
    doc.save(path)


def convert_one(job):
    """job = (md_path, out_md, out_docx, ref_docx, md_only)。返回 (out_md, ok, err)。"""
    md_path, out_md, out_docx, ref_docx, md_only = job
    try:
        raw = open(md_path, encoding="utf-8", errors="replace").read()
        if not raw.strip():
            return out_md, False, "empty"
        os.makedirs(os.path.dirname(out_md), exist_ok=True)
        if not os.path.exists(out_md):
            with open(out_md, "w", encoding="utf-8", newline="") as f:
                f.write(raw)
        if md_only:
            return out_md, True, ""
        import pypandoc
        body = FM_RE.sub("", raw) if raw.startswith("---") else raw
        if not body.strip():
            return out_md, False, "empty"
        pypandoc.convert_text(
            body, "docx", format="gfm",
            outputfile=out_docx,
            extra_args=["--standalone", "--wrap=none", f"--reference-doc={ref_docx}",
                        f"--resource-path={os.path.dirname(md_path)}"],
        )
        return out_md, True, ""
    except Exception as e:
        return out_md, False, f"{type(e).__name__}: {e}"


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--limit", type=int, default=0)
    ap.add_argument("--workers", type=int, default=6)
    ap.add_argument("--md-only", action="store_true", help="只归置 md，不转 docx")
    args = ap.parse_args()

    doc_map_path = os.path.join(STATE, "doc-map.json")
    if not os.path.exists(doc_map_path):
        print("❌ state/doc-map.json 不存在，先跑 finalize_tree.py")
        return 1
    rows = json.load(open(doc_map_path, encoding="utf-8"))

    ref = os.path.join(STATE, "reference.docx")
    if not os.path.exists(ref):
        make_reference_docx(ref)

    def safe_dir(name):
        return re.sub(r'[\\/:*?"<>|\r\n\t]', "_", name).strip().strip(".")[:60] or "未命名"

    jobs, skip = [], 0
    for r in rows:
        md = os.path.join(WIKI_DIR, r["md"])
        if not os.path.exists(md):
            continue
        chapter = safe_dir(r.get("chapter") or "_未分类")
        base = os.path.splitext(r["md"])[0]
        out_docx = os.path.join(KB_DIR, chapter, base + ".docx")
        out_md = os.path.join(KB_DIR, chapter, r["md"])
        done_marker = out_md if args.md_only else out_docx
        if os.path.exists(done_marker):
            skip += 1
            continue
        jobs.append((md, out_md, out_docx, ref, args.md_only))
    if args.limit:
        jobs = jobs[: args.limit]
    mode = "纯md归置" if args.md_only else "md→docx 转换"
    print(f"待处理 {len(jobs)}（已存在跳过 {skip}），{mode}，workers={args.workers}")

    ok = fail = 0
    errors = []
    with ProcessPoolExecutor(max_workers=args.workers) as ex:
        futs = {ex.submit(convert_one, j): j for j in jobs}
        for i, fut in enumerate(as_completed(futs), 1):
            out, good, err = fut.result()
            if good:
                ok += 1
            else:
                fail += 1
                errors.append((os.path.basename(out), err))
            if i % 200 == 0:
                print(f"  进度 {i}/{len(jobs)} ok={ok} fail={fail}")
    print(f"✅ 转换完成：ok={ok} fail={fail}")
    if errors:
        with open(os.path.join(STATE, "convert-errors.log"), "w", encoding="utf-8") as f:
            for name, err in errors:
                f.write(f"{name}\t{err}\n")
        print(f"  失败清单: state/convert-errors.log")
        for name, err in errors[:10]:
            print(f"    ✗ {name[:50]}: {err[:80]}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
