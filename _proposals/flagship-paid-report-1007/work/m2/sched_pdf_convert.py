# -*- coding: utf-8 -*-
"""sched_pdf_convert — 工期报告 docx→专业排版→PDF (1021 用户令: 排版为上架前置门).

链: 报告.docx → report_paiban(WPS AI排版复刻: 三线表/目录/页码/章分页) → Word COM PDF。
本件 = 编排入口; 幂等: 已有同名_排版版.docx(>50KB)即跳过排版直接转PDF。
"""
import subprocess
import sys
import time
from pathlib import Path

import win32com.client

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
NO_WIN = 0x08000000
SRC = (Path(__file__).resolve().parent / "sched"
       / "工程工期管理与延误索赔实战指南2026版.docx")
PAIBAN = Path(__file__).resolve().parent / "report_paiban.py"


def ensure_typeset() -> Path:
    """排版版存在且>50KB 直接用; 否则跑 report_paiban 产排版版。"""
    ts = SRC.with_name(SRC.stem + "_排版版.docx")
    if ts.is_file() and ts.stat().st_size > 50000:
        print(f"[skip] 排版版已存在 {ts.stat().st_size:,}B")
        return ts
    r = subprocess.run(
        [sys.executable, "-X", "utf8", str(PAIBAN), str(SRC), "--pdf"],
        capture_output=True, text=True, encoding="utf-8",
        errors="replace", timeout=1200)
    print(r.stdout[-500:] if r.stdout else "", end="")
    if ts.is_file() and ts.stat().st_size > 50000:
        return ts
    raise SystemExit("[!!] 排版失败: " + (r.stderr or "")[-300:])


def pids():
    r = subprocess.run(
        ["tasklist", "/FI", "IMAGENAME eq WINWORD.EXE", "/FO", "CSV"],
        capture_output=True, text=True, encoding="gbk", errors="replace",
        creationflags=NO_WIN)
    return {ln.split('","')[1] for ln in r.stdout.splitlines()
            if '","' in ln and "WINWORD" in ln}


def main() -> int:
    src = ensure_typeset()
    pdf = src.with_suffix(".pdf")
    base = pids()
    word = win32com.client.DispatchEx("Word.Application")
    word.Visible = False
    word.DisplayAlerts = 0
    try:
        doc = word.Documents.Open(str(src), ReadOnly=True)
        doc.ExportAsFixedFormat(str(pdf), 17)
        pages = doc.ComputeStatistics(2)
        doc.Close(False)
        print(f"[pdf] {pdf.name} {pdf.stat().st_size:,}B {pages} 页")
    finally:
        try:
            word.Quit()
        except Exception:  # noqa: BLE001 — Word COM 大件后 Quit 常崩, 自清即可
            pass
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

