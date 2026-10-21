# -*- coding: utf-8 -*-
"""sched_pdf_convert — 工期报告 docx→PDF (Word COM 后台, 同 slsd 卫生纪律)."""
import subprocess
import sys
import time
from pathlib import Path

import win32com.client

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
NO_WIN = 0x08000000
SRC = (Path(__file__).resolve().parent / "sched"
       / "工程工期管理与延误索赔实战指南2026版.docx")


def pids():
    r = subprocess.run(
        ["tasklist", "/FI", "IMAGENAME eq WINWORD.EXE", "/FO", "CSV"],
        capture_output=True, text=True, encoding="gbk", errors="replace",
        creationflags=NO_WIN)
    return {ln.split('","')[1] for ln in r.stdout.splitlines()
            if '","' in ln and "WINWORD" in ln}


def main() -> int:
    pdf = SRC.with_suffix(".pdf")
    base = pids()
    word = win32com.client.DispatchEx("Word.Application")
    word.Visible = False
    word.DisplayAlerts = 0
    try:
        doc = word.Documents.Open(str(SRC), ReadOnly=True)
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
        print("WINWORD 清理", "完成" if not (pids() - base) else "有残留")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
