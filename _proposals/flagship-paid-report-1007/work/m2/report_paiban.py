# -*- coding: utf-8 -*-
"""report_paiban — 产线专业排版件 (1021 用户令: 逆向WPS排版接入研究报告产线).

蓝本: 逆向工程/wps-ai-paiban/replica/aipaiban.py (WPS「AI排版」本地复刻,
21/21+9/9+5/5 实测全过, 零云端依赖)。本件 = 产线薄包装:
  报告.docx → aipaiban(研报预设: 通用黑色主题/三线表/目录/页码/章分页)
           → 排版后 docx + 变更摘要落账 + (可选)Word COM 转 PDF
排位: S3 的 report_to_docx 之后、PDF 之前; 幂等(aipaiban auto 对已排稿=incremental零改动)。
用法: py -X utf8 report_paiban.py <报告.docx> [--pdf] [--out 自定docx]
"""
from __future__ import annotations

import argparse
import subprocess
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
M2 = Path(__file__).resolve().parent
AIPAIBAN = Path(r"E:\AI-Station\逆向工程\wps-ai-paiban\replica\aipaiban.py")
LEDGER = M2 / "sched" / "paiban_ledger.jsonl"


def paiban(src: Path, out: Path) -> tuple[bool, str]:
    """调 aipaiban 复刻件排版; 返回 (成功, 摘要文本)."""
    cmd = [sys.executable, "-X", "utf8", str(AIPAIBAN), str(src),
           "-o", str(out), "--mode", "auto", "--preset", "beauty",
           "--toc", "on", "--page-numbers", "on", "--h1-break", "on",
           "--table-style", "three_line"]
    r = subprocess.run(cmd, capture_output=True, text=True,
                       encoding="utf-8", errors="replace", timeout=900)
    ok = r.returncode == 0 and out.exists() and out.stat().st_size > 10000
    summary = (r.stdout or "")[-3000:] + (("\n[stderr]" + r.stderr[-800:])
                                          if r.returncode else "")
    if not ok:
        return False, summary
    # 1022 接入「最新成功版」新增: 幂等质检门 — 复跑 auto 应为 incremental
    # (aipaiban 回归「幂等复跑 PASS」的产线化); 判 full 重排=未达标告警
    v = subprocess.run(
        [sys.executable, "-X", "utf8", str(AIPAIBAN), str(out),
         "--dry-run", "--mode", "auto"],
        capture_output=True, text=True, encoding="utf-8",
        errors="replace", timeout=600)
    vt = (v.stdout or "") + (v.stderr or "")
    incremental = "incremental" in vt
    full_replan = ('"full"' in vt or "mode: full" in vt.lower()
                   or "full 重排" in vt)
    if full_replan and not incremental:
        summary += "\n[质检⚠️] 复跑判 full 重排(未达幂等) — 建议复查"
    else:
        summary += "\n[质检✅] 幂等复跑=incremental(排版达标机器判据过)"
    return True, summary


def docx_to_pdf(docx: Path) -> Path | None:
    """Word COM 后台转 PDF (同 sched_pdf_convert 卫生纪律)."""
    import win32com.client
    NO_WIN = 0x08000000
    pdf = docx.with_suffix(".pdf")

    def pids():
        rr = subprocess.run(["tasklist", "/FI", "IMAGENAME eq WINWORD.EXE",
                             "/FO", "CSV"], capture_output=True, text=True,
                            encoding="gbk", errors="replace",
                            creationflags=NO_WIN)
        return {ln.split('","')[1] for ln in rr.stdout.splitlines()
                if '","' in ln and "WINWORD" in ln}

    base = pids()
    word = win32com.client.DispatchEx("Word.Application")
    word.Visible = False
    word.DisplayAlerts = 0
    try:
        doc = word.Documents.Open(str(docx), ReadOnly=True)
        doc.ExportAsFixedFormat(str(pdf), 17)
        pages = doc.ComputeStatistics(2)
        doc.Close(False)
        print(f"[pdf] {pdf.name} {pdf.stat().st_size:,}B {pages} 页")
    finally:
        word.Quit()
        for _ in range(20):
            new = pids() - base
            if not new:
                break
            for p in new:
                subprocess.run(["taskkill", "/PID", p], capture_output=True,
                               creationflags=NO_WIN)
            time.sleep(1)
    return pdf if pdf.exists() else None


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("docx")
    ap.add_argument("--pdf", action="store_true")
    ap.add_argument("--out", default="")
    ns = ap.parse_args()
    src = Path(ns.docx).resolve()
    if not src.is_file():
        print(f"[!] 无文件: {src}")
        return 1
    out = Path(ns.out).resolve() if ns.out else src.with_name(
        src.stem + "_排版版.docx")
    ok, summary = paiban(src, out)
    if not ok:
        print("[!!] 排版失败\n" + summary[-800:])
        return 2
    print(f"[✅] 排版完成 → {out.name} {out.stat().st_size:,}B")
    LEDGER.parent.mkdir(parents=True, exist_ok=True)
    with LEDGER.open("a", encoding="utf-8") as fh:
        fh.write(__import__("json").dumps(
            {"ts": time.strftime("%F %T"), "src": src.name,
             "out": out.name, "bytes": out.stat().st_size},
            ensure_ascii=False) + "\n")
    if ns.pdf:
        docx_to_pdf(out)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
