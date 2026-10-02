# -*- coding: utf-8 -*-
"""EPC50 ima OLE2 二轮转换 (0925, bin2md 补刀).

一轮 (epc50_bin2md) 战果 83 md; 约 30 件 .doc/.ppt 为 2007 前 OLE2
老格式, mammoth/python-docx/python-pptx 全不认 (BadZipFile /
PackageNotFoundError / KeyError). 本机实测 Office 2007 COM 在役
(Word/PPT 12.0) → COM 归一化路线:

  *.doc.bin  → Word.SaveAs(wdFormatXMLDocument=12) → .docx → mammoth→md
  *.ppt(.pptx).bin → PPT.SaveAs(ppSaveAsOpenXMLPresentation=24) → pptx
                → python-pptx→md  (KeyError 件也借 COM 归一化重试)
  *.xls.bin  → Excel.SaveAs(xlCSV=6) → csv → 平铺 md (仅1件, 顺手)
  *.jpg.bin  → 跳过 (图片, OCR 另议)

纪律: Visible=False / DisplayAlerts=False / try-finally Quit;
中间件落 _ole2_tmp/; 只增不删; 幂等 (目标 .md 存在即跳).
"""
import sys
import time
from pathlib import Path

# stdout 包装只做一次: epc50_bin2md 导入时已包 (双 TextIOWrapper 会令
# 先包者被 GC 时关闭底层流 → "I/O operation on closed file" 实锤)
sys.path.insert(0, str(Path(__file__).parent))
from epc50_bin2md import IMA, docx_to_md, docx_to_md_fallback, ppt_to_md  # noqa: E402

TMP = IMA / "_ole2_tmp"
WD_DOCX = 12      # wdFormatXMLDocument
PP_PPTX = 24      # ppSaveAsOpenXMLPresentation
XL_CSV = 6        # xlCSV


def com_convert(kind: str, src: Path, dst: Path) -> None:
    """Word/PPT/Excel COM 归一化 (OLE2 → OOXML/csv)."""
    import pythoncom
    import win32com.client as w

    pythoncom.CoInitialize()
    if kind == "doc":
        app = w.DispatchEx("Word.Application")
        app.Visible = False
        app.DisplayAlerts = 0
        try:
            doc = app.Documents.Open(str(src), ReadOnly=True,
                                     AddToRecentFiles=False)
            doc.SaveAs2(str(dst), FileFormat=WD_DOCX)
            doc.Close(False)
        finally:
            app.Quit()
    elif kind == "ppt":
        app = w.DispatchEx("PowerPoint.Application")
        try:
            pres = app.Presentations.Open(str(src), ReadOnly=True,
                                          Untitled=False, WithWindow=False)
            pres.SaveAs(str(dst), PP_PPTX)
            pres.Close()
        finally:
            app.Quit()
    elif kind == "xls":
        app = w.DispatchEx("Excel.Application")
        app.DisplayAlerts = False
        try:
            wb = app.Workbooks.Open(str(src), ReadOnly=True)
            wb.SaveAs(str(dst), FileFormat=XL_CSV)
            wb.Close(False)
        finally:
            app.Quit()


def xls_md(csv_path: Path, title: str) -> str:
    """csv → 平铺 md (Excel COM 写的是 GBK csv)."""
    rows = csv_path.read_text(encoding="gbk", errors="replace").splitlines()
    body = "\n".join(ln for ln in rows if ln.strip())
    return f"# {title}\n\n```csv\n{body}\n```\n"


def main() -> int:
    TMP.mkdir(exist_ok=True)
    bins = sorted(IMA.glob("*.bin"))
    todo = []
    for p in bins:
        target = p.parent / (p.name[:-4] + ".md")
        if target.exists():
            continue
        stem = p.name[:-4].lower()
        if stem.endswith((".doc", ".docx")):
            todo.append((p, "doc"))
        elif stem.endswith((".ppt", ".pptx")):
            todo.append((p, "ppt"))
        elif stem.endswith((".xls", ".xlsx")):
            todo.append((p, "xls"))
        elif stem.endswith((".jpg", ".png")):
            print(f"[ole2] 跳图片件 {p.name[:40]}", flush=True)
        else:
            print(f"[ole2] 未知型 {p.name[:40]}", flush=True)
    print(f"[ole2] 待转 {len(todo)} 件 (doc/ppt/xls)", flush=True)
    ok = fail = 0
    for i, (p, kind) in enumerate(todo, 1):
        stem = p.name[:-4]
        target = p.parent / (stem + ".md")
        try:
            mid = TMP / (stem.replace("/", "_")[:60] +
                         {"doc": ".conv.docx", "ppt": ".conv.pptx",
                          "xls": ".conv.csv"}[kind])
            com_convert(kind, p, mid)
            if kind == "xls":
                body = xls_md(mid, stem)
            elif kind == "ppt":
                body = f"# {stem}\n\n{ppt_to_md(mid)}\n"
            else:
                try:
                    body = f"# {stem}\n\n{docx_to_md(mid)}\n"
                except Exception:
                    body = f"# {stem}\n\n{docx_to_md_fallback(mid)}\n"
            target.write_text(body, encoding="utf-8")
            ok += 1
            print(f"[{i}/{len(todo)}] ✓ {stem[:44]}", flush=True)
        except Exception as e:
            fail += 1
            print(f"[{i}/{len(todo)}] ✗ {stem[:44]} "
                  f"{type(e).__name__}: {str(e)[:50]}", flush=True)
        time.sleep(0.3)
    print(f"[ole2] 完: 成 {ok} | 败 {fail}", flush=True)
    return 0


if __name__ == "__main__":
    sys.exit(main())
