# -*- coding: utf-8 -*-
"""wps_field_refresh — 用本机 WPS/Word COM 实机更新全部域并回存.

验证并固化: TOC 域真出带页码条目 / STYLEREF 章名解析 / PAGE 页码 / 总页数.
打开→更新(正文+各节页眉页脚)→重分页→读取证据→另存→关闭. 全程不可见.
"""
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

DOCX = r"E:/AI-Station/_proposals/flagship-paid-report-1007/work/m2/visa/sched/out/REPORT_FULL_出版级.docx"

import pywintypes  # noqa: F401
import win32com.client

PROGIDS = ["Kwps.Application", "KWPS.Application", "wps.Application", "Word.Application"]
app = None
used = None
for pid in PROGIDS:
    try:
        app = win32com.client.DispatchEx(pid)
        used = pid
        break
    except Exception:
        continue
if app is None:
    print("NO_COM_APP")
    sys.exit(2)
print("COM app:", used)

wdHeaderFooterPrimary = 1
wdHeaderFooterFirstPage = 2
wdHeaderFooterEvenPages = 3
wdStatisticPages = 2
wdSaveFormatDocx = 12 if used.startswith(("Word",)) else 12  # WPS同值

doc = None
try:
    app.Visible = False
    try:
        app.DisplayAlerts = 0
    except Exception:
        pass
    doc = app.Documents.Open(DOCX, ReadOnly=False)
    t0 = time.time()
    # 1) 更新正文书域(TOC)
    for story in range(1, 8):
        try:
            doc.StoryRanges(story).Fields.Update()
        except Exception:
            pass
    # 2) 更新各节页眉页脚域
    for i in range(1, doc.Sections.Count + 1):
        sec = doc.Sections(i)
        for hf in (sec.Headers(wdHeaderFooterPrimary), sec.Headers(wdHeaderFooterFirstPage),
                   sec.Headers(wdHeaderFooterEvenPages), sec.Footers(wdHeaderFooterPrimary),
                   sec.Footers(wdHeaderFooterFirstPage), sec.Footers(wdHeaderFooterEvenPages)):
            try:
                hf.Range.Fields.Update()
            except Exception:
                pass
    doc.Repaginate()
    pages = doc.ComputeStatistics(wdStatisticPages)
    toc_count = doc.TablesOfContents.Count
    toc_entries = 0
    toc_sample = []
    if toc_count:
        toc = doc.TablesOfContents(1)
        toc_entries = toc.Range.Paragraphs.Count
        for j in range(1, min(toc_entries, 6) + 1):
            line = toc.Range.Paragraphs(j).Range.Text.strip()
            if line:
                toc_sample.append(line[:52])
    hdr_odd = doc.Sections(1).Headers(wdHeaderFooterPrimary).Range.Text.strip()
    hdr_even = doc.Sections(1).Headers(wdHeaderFooterEvenPages).Range.Text.strip()
    hdr_first = doc.Sections(1).Headers(wdHeaderFooterFirstPage).Range.Text.strip()
    print("pages:", pages)
    print("toc_fields:", toc_count, "entries:", toc_entries)
    for s in toc_sample:
        print("  TOC>", s)
    print("hdr_odd :", repr(hdr_odd[:40]))
    print("hdr_even:", repr(hdr_even[:40]))
    print("hdr_first:", repr(hdr_first[:40]))
    err = [t for t in (hdr_odd, hdr_even) if ("错误" in t or "Error" in t or "未找到" in t)]
    print("field_errors:", err if err else "none")
    doc.Save()
    print("saved with refreshed field results")
finally:
    if doc is not None:
        doc.Close(SaveChanges=0)
    app.Quit()
print("elapsed %.1fs" % (time.time() - t0))
