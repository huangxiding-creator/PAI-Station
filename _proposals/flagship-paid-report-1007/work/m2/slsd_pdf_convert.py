# -*- coding: utf-8 -*-
"""slsd_pdf_convert — 水利水电EPC风险报告 docx→PDF（Word COM 后台, 不弹窗）.

沿 build_pdf.py 卫生纪律: DispatchEx 独立实例 / NO_WIN / 只清本进程新增 WINWORD。
输出: 同目录同名 .pdf；打印页数（badges 用, 数字零造假）。
"""
import subprocess
import sys
from pathlib import Path

import win32com.client

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
WD_PDF = 17
NO_WIN = 0x08000000
SRC = Path(r"e:\AI-Station\逆向工程\manus-reverse\live"
           r"\9DCD48BZUH8msRx6TPCfxC\deliver"
           r"\中国水利水电工程EPC总承包风险管理研究报告.docx")


def winword_pids():
    r = subprocess.run(["tasklist", "/FI", "IMAGENAME eq WINWORD.EXE",
                        "/FO", "CSV"], capture_output=True, text=True,
                       encoding="gbk", errors="replace",
                       creationflags=NO_WIN)
    return {ln.split('","')[1] for ln in r.stdout.splitlines()
            if '","' in ln and "WINWORD" in ln}


def main() -> int:
    pdf = SRC.with_suffix(".pdf")
    base = winword_pids()
    word = win32com.client.DispatchEx("Word.Application")
    word.Visible = False
    word.DisplayAlerts = 0
    try:
        doc = word.Documents.Open(str(SRC), ReadOnly=True)
        doc.ExportAsFixedFormat(str(pdf), WD_PDF)
        pages = doc.ComputeStatistics(2)      # wdStatisticPages
        doc.Close(False)
        print(f"[pdf] {pdf.name} 落盘 {pdf.stat().st_size:,}B · {pages} 页")
    finally:
        word.Quit()
        import time
        for _ in range(20):
            new = winword_pids() - base
            if not new:
                break
            subprocess.run(["taskkill", "/PID", *sum(([p] for p in new), [])],
                           capture_output=True, creationflags=NO_WIN)
            time.sleep(1)
        print("[pdf] WINWORD 残留清理完成" if not (winword_pids() - base)
              else "[pdf] ⚠️ 仍有残留, 已尽力")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
