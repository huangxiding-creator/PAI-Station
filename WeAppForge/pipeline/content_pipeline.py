# -*- coding: utf-8 -*-
"""content_pipeline.py — 研报 docx → 小程序内容三件套
产出：
  微信小程序/zongbao/content/reports/<id>/chapters.json  （试读章带 html，付费章出空壳防包内泄漏）
  微信小程序/zongbao/content/catalog.json                （合并更新 chapterCount）
  data/pdfs/<id>-trial.pdf / <id>-full.pdf             （Edge headless 双 PDF，openDocument 无页码范围的官方替代）
用法:
  python content_pipeline.py <docx> <report_id> <title> [--trial N] [--price 990]
"""
import json
import re
import subprocess
import sys
import argparse
from datetime import date
from pathlib import Path

import mammoth

ROOT = Path(__file__).resolve().parent.parent
PROJECT = ROOT / "projects" / "zongbao"
CONTENT = PROJECT / "content"
PDF_DIR = ROOT / "data" / "pdfs"
EDGE = Path(r"C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe")

HTML_SHELL = """<!DOCTYPE html>
<html lang="zh-CN"><head><meta charset="utf-8">
<style>
body {{ font-family: "Microsoft YaHei", "PingFang SC", sans-serif; max-width: 720px;
  margin: 0 auto; padding: 32px 24px; color: #1f2329; line-height: 1.8; font-size: 15px; }}
h1 {{ font-size: 22px; border-bottom: 2px solid #1e5eff; padding-bottom: 8px; }}
h2 {{ font-size: 18px; margin-top: 28px; }}
table {{ border-collapse: collapse; width: 100%; font-size: 13px; }}
td, th {{ border: 1px solid #d0d4da; padding: 6px 8px; }}
img {{ max-width: 100%; }}
.watermark {{ position: fixed; top: 8px; right: 16px; color: #b8bec7; font-size: 12px; }}
</style></head><body><div class="watermark">{watermark}</div>{body}</body></html>"""


def split_chapters(html: str) -> list:
    """按 h1 切章；h1 不足 2 章则退 h2。返回 [{id,title,html}]"""
    for tag in ("h1", "h2"):
        parts = re.split(rf"(<{tag}[^>]*>.*?</{tag}>)", html, flags=re.S)
        chunks = []
        preamble = ""
        i = 0
        while i < len(parts):
            if re.match(rf"<{tag}", parts[i] or ""):
                m = re.search(r">([^<]+)</", parts[i])
                title = (m.group(1) if m else f"章节 {len(chunks) + 1}").strip()
                body = parts[i] + "".join(parts[i + 1 : i + 2])
                chunks.append({"title": title, "html": body})
                i += 2
            else:
                if parts[i].strip() and not chunks:
                    preamble = parts[i]
                i += 1
        if preamble.strip():
            chunks.insert(0, {"title": "导语", "html": preamble})
        if len(chunks) >= 2:
            for idx, c in enumerate(chunks):
                c["id"] = f"ch{idx + 1:02d}"
            return chunks
    return [{"id": "ch01", "title": "全文", "html": html}]


def render_pdf(html_path: Path, pdf_path: Path) -> None:
    pdf_path.parent.mkdir(parents=True, exist_ok=True)
    subprocess.run(
        [str(EDGE), "--headless", "--disable-gpu", f"--print-to-pdf={pdf_path}", str(html_path)],
        check=True, capture_output=True, timeout=180,
        creationflags=0x08000000,  # CREATE_NO_WINDOW（不弹窗铁律）
    )


JUNK_TITLE = re.compile(r"^\s*(导语|目\s*录|目\s*录|封面|前\s*言|contents)\s*$", re.I)


def drop_junk_chapters(chapters: list, min_body_chars: int = 400) -> list:
    """剔除封面/目录/超短噪声章，试读从首个实质章起算"""
    kept = [
        c for c in chapters
        if not JUNK_TITLE.match(c["title"]) and len(re.sub(r"<[^>]+>", "", c["html"])) >= min_body_chars
    ]
    if not kept:  # 全被滤掉时保守回退原文
        return chapters
    for idx, c in enumerate(kept):
        c["id"] = f"ch{idx + 1:02d}"
    return kept


def main() -> None:
    ap = argparse.ArgumentParser()
    ap.add_argument("docx")
    ap.add_argument("report_id")
    ap.add_argument("title")
    ap.add_argument("--trial", type=int, default=2)
    ap.add_argument("--price", type=int, default=990)
    ap.add_argument("--summary", default="")
    ap.add_argument("--source", default="总包创研院")
    args = ap.parse_args()

    docx = Path(args.docx)
    with open(docx, "rb") as fh:
        result = mammoth.convert_to_html(fh)
    full_html = result.value

    chapters = drop_junk_chapters(split_chapters(full_html))
    out_dir = CONTENT / "reports" / args.report_id
    out_dir.mkdir(parents=True, exist_ok=True)

    # 小程序包内章节：试读章带正文，付费章空壳（防包内全文泄漏）
    packed = [
        {**c, "html": c["html"] if idx < args.trial else ""}
        for idx, c in enumerate(chapters)
    ]
    (out_dir / "chapters.json").write_text(
        json.dumps(packed, ensure_ascii=False, indent=1), encoding="utf-8"
    )

    # 双 PDF（交付件）：试读版=前 N 章；完整版=全文
    stamps = {"watermark": f"总包学园 · {date.today().isoformat()}"}
    trial_body = "".join(c["html"] for c in chapters[: args.trial])
    full_body = "".join(c["html"] for c in chapters)
    tmp_dir = ROOT / "data" / "_tmp"
    tmp_dir.mkdir(parents=True, exist_ok=True)
    for name, body in (("trial", trial_body), ("full", full_body)):
        hp = tmp_dir / f"{args.report_id}-{name}.html"
        hp.write_text(HTML_SHELL.format(body=body, **stamps), encoding="utf-8")
        render_pdf(hp, PDF_DIR / f"{args.report_id}-{name}.pdf")

    # catalog 合并更新
    catalog_path = CONTENT / "catalog.json"
    catalog = json.loads(catalog_path.read_text(encoding="utf-8")) if catalog_path.exists() else {"reports": []}
    entry = {
        "id": args.report_id,
        "title": args.title,
        "summary": args.summary or f"{args.title}——总包创研院出品。",
        "price": args.price,
        "chapterCount": len(chapters),
        "source": args.source,
        "publishedAt": date.today().isoformat(),
    }
    catalog["reports"] = [entry if r["id"] == entry["id"] else r for r in catalog["reports"]]
    if not any(r["id"] == entry["id"] for r in catalog["reports"]):
        catalog["reports"].append(entry)
    catalog_path.write_text(json.dumps(catalog, ensure_ascii=False, indent=2), encoding="utf-8")

    print(json.dumps({
        "report_id": args.report_id,
        "chapters": len(chapters),
        "trial_chapters": args.trial,
        "packed_html_chars": sum(len(c["html"]) for c in packed),
        "trial_pdf": str((PDF_DIR / f"{args.report_id}-trial.pdf")),
        "full_pdf": str((PDF_DIR / f"{args.report_id}-full.pdf")),
        "full_pdf_kb": round((PDF_DIR / f"{args.report_id}-full.pdf").stat().st_size / 1024, 1),
    }, ensure_ascii=False, indent=2))


if __name__ == "__main__":
    sys.stdout.reconfigure(encoding="utf-8")
    main()
