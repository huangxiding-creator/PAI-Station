# -*- coding: utf-8 -*-
"""EPC50 ima .bin → .md 批量转换 (0925 用户令: 按建议执行).

背景: ima 收获器 download() 对 URL/file_type 探测不出的件落 .bin,
实为 docx/ppt (123 件, 含 76 页作业指导书等高价值件). gate 只认
.md/.txt/.pdf → .bin 全部未入账 (10.48M 口径偏保守的主因之一).

转换规则 (按文件名 .bin 前的扩展名判型, 不按标题——存在标题含
「PPT」实为 docx 的件):
  *.ppt.bin / *.pptx.bin → python-pptx 逐页提取 (含表格单元格)
  *.doc.bin / *.docx.bin → mammoth→html→markdownify (保结构)
  失败兜底: 换另一库再试; 仍败如实记 failed (OLE2 老 .doc 无工具)
纪律: 只增不删 (原 .bin 保留); 幂等 (同名 .md 存在即跳过).
"""
import io
import sys
import time
import traceback
from pathlib import Path

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8",
                              errors="replace")

IMA = Path(r"E:/AI-Station/ResearchFactory-Eng/ResearchTopics/"
           "《中石化南京工程有限公司怎么干EPC总承包？》/04 网络调研搜集的资料"
           "/51_ima知识库")


def docx_to_md(path: Path) -> str:
    """mammoth → html → markdown (保标题/列表/表格结构)."""
    import mammoth
    import markdownify as md

    with path.open("rb") as f:
        html = mammoth.convert_to_html(f).value
    if not html.strip():
        raise ValueError("mammoth 空 html")
    body = md.markdownify(html, heading_style="ATX", strip=["img"])
    if not body.strip():
        raise ValueError("markdownify 空文")
    return body


def docx_to_md_fallback(path: Path) -> str:
    """python-docx 兜底: 段落+表格平铺 (丢格式保内容)."""
    import docx

    d = docx.Document(str(path))
    parts: list[str] = []
    for p in d.paragraphs:
        if p.text.strip():
            parts.append(p.text.strip())
    for t in d.tables:
        for row in t.rows:
            cells = [c.text.strip() for c in row.cells]
            if any(cells):
                parts.append(" | ".join(cells))
    if not parts:
        raise ValueError("python-docx 空文")
    return "\n\n".join(parts)


def ppt_to_md(path: Path) -> str:
    """python-pptx 逐页提取: 文本框+表格 (PPT 转图片页会空, 如实短)."""
    from pptx import Presentation

    prs = Presentation(str(path))
    parts: list[str] = []
    for i, slide in enumerate(prs.slides, 1):
        chunks: list[str] = []
        for shape in slide.shapes:
            if shape.has_text_frame:
                txt = shape.text_frame.text.strip()
                if txt:
                    chunks.append(txt)
            if getattr(shape, "has_table", False) and shape.has_table:
                for row in shape.table.rows:
                    cells = [c.text.strip() for c in row.cells]
                    if any(cells):
                        chunks.append(" | ".join(cells))
        if chunks:
            parts.append(f"## 幻灯片 {i}\n\n" + "\n\n".join(chunks))
    if not parts:
        raise ValueError("pptx 全空 (可能为图片型 PPT)")
    return "\n\n---\n\n".join(parts)


def convert_one(path: Path) -> tuple[str, str]:
    """→ (note, md_body). note: ok/copy/skip/failed:<原因>."""
    # 文件名形如 xxx.docx.docx.bin → 目标 xxx.docx.md (保留原扩展在名内)
    target = path.parent / (path.name[:-4] + ".md")
    if target.exists():
        return "skip", ""
    stem = path.name[:-4]                   # 去 .bin
    is_ppt = stem.lower().endswith((".ppt", ".pptx"))
    errors: list[str] = []
    for fn in ((ppt_to_md,) if is_ppt else (docx_to_md, docx_to_md_fallback)):
        try:
            body = fn(path)
            return "ok", f"# {stem}\n\n{body}\n"
        except Exception as e:
            errors.append(f"{fn.__name__}:{type(e).__name__}")
    return "failed:" + ";".join(errors), ""


def main() -> int:
    bins = sorted(IMA.glob("*.bin"))
    if not bins:
        print("[bin2md] 无 .bin 件", flush=True)
        return 0
    print(f"[bin2md] 待转 {len(bins)} 件", flush=True)
    ok = fail = skip = 0
    fail_list: list[str] = []
    chars = 0
    for i, p in enumerate(bins, 1):
        note, body = convert_one(p)
        if note == "ok":
            ok += 1
            chars += len("".join(body.split()))
            target = p.parent / (p.name[:-4] + ".md")
            target.write_text(body, encoding="utf-8")
            print(f"[{i}/{len(bins)}] ✓ {p.name[:44]}", flush=True)
        elif note == "skip":
            skip += 1
        else:
            fail += 1
            fail_list.append(f"{p.name[:44]} {note}")
            print(f"[{i}/{len(bins)}] ✗ {p.name[:44]} {note}", flush=True)
        time.sleep(0.05)
    print(f"[bin2md] 完: 成 {ok} (释放 {chars:,} 字) | 败 {fail} | 跳过 {skip}",
          flush=True)
    for f in fail_list:
        print(f"  ✗ {f}", flush=True)
    return 0


if __name__ == "__main__":
    sys.exit(main())
