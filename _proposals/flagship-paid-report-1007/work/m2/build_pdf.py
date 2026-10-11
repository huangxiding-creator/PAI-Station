# -*- coding: utf-8 -*-
"""build_pdf — 蓝皮书 dist/*.docx → 同名 PDF（Word COM 后台转换，不弹窗）。

Word 2007+ ExportAsFixedFormat(wdExportFormatPDF=17)。
usage: PYTHONIOENCODING=utf-8 python build_pdf.py [vol ...]   # 缺省全部 dist/*.docx
"""
import subprocess
import sys
from pathlib import Path

import win32com.client

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
DIST = Path(__file__).resolve().parents[2] / "bluebook" / "dist"
WD_PDF = 17
NO_WIN = 0x08000000


def winword_pids():
    """当前 WINWORD.EXE PID 集合（Word 2007 Export 后 Quit 常 RPC 崩，残留须精准清）。"""
    r = subprocess.run(["tasklist", "/FI", "IMAGENAME eq WINWORD.EXE", "/FO", "CSV"],
                       capture_output=True, text=True, creationflags=NO_WIN)
    return {ln.split('","')[1] for ln in r.stdout.splitlines() if '","' in ln and "WINWORD" in ln}


def convert_one(docx):
    """单卷转换：独立 Word 实例（2007 COM 转大件后必崩，跨卷复用=传染，逐卷新起）。"""
    pdf = docx.with_suffix(".pdf")
    base = winword_pids()  # 只许清理本卷启动后新增的，用户自己开的 Word 不碰
    word = win32com.client.DispatchEx("Word.Application")
    try:
        word.Visible = False
        word.DisplayAlerts = 0
        doc = word.Documents.Open(str(docx), ReadOnly=True)
        doc.ExportAsFixedFormat(str(pdf), WD_PDF)
        doc.Close(False)
        size = pdf.stat().st_size if pdf.exists() else 0
        ok = size > 10_000
        print(f"{docx.stem}: pdf={'✓ ' + format(size, ',') + 'B' if ok else '✗ 空件'}")
        return 0 if ok else 1
    except Exception as e:  # noqa: BLE001 — 单卷失败继续下一卷
        print(f"{docx.stem}: ✗ {e}")
        return 1
    finally:
        try:
            word.Quit()
        except Exception:  # noqa: BLE001 — RPC 崩溃=进程已死/垂死，交给下方精准清
            pass
        for pid in winword_pids() - base:
            subprocess.run(["taskkill", "/PID", pid, "/F"], capture_output=True,
                           creationflags=NO_WIN)


def main():
    only = set(sys.argv[1:]) or None
    docxs = sorted(DIST.glob("*.docx"))
    if only:
        docxs = [p for p in docxs if any(k in p.stem or k in p.name for k in only)]
    if not docxs:
        print("无待转件")
        return 1
    fails = sum(convert_one(p) for p in docxs)
    print("PDF " + ("PASS 全绿" if fails == 0 else f"FAIL ×{fails}"))
    return 1 if fails else 0


if __name__ == "__main__":
    sys.exit(main())
