# -*- coding: utf-8 -*-
"""FOMI .doc 批转 docx — pywin32 具名参数道 (PS COM 批量null坑的根治件).
只读原件, 产物写 doc_converted/; 断点续转 (已存在=跳过); Word 失败换 WPS 兜底.
用法: py -X utf8 convert_docs_fomi.py [limit]
"""
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.stderr.reconfigure(encoding="utf-8", errors="replace")
import win32com.client                        # noqa: E402
import pythoncom                              # noqa: E402

SRC = Path(r"D:\兰州水源地专著")
DST = Path(r"E:\AI-Station\07 任务\福米电站EPC管理策划\05 Super-Skill工作区\doc_converted")
DST.mkdir(parents=True, exist_ok=True)


def rel_name(p: Path) -> str:
    rel = str(p)[len(str(SRC)) + 1:]
    bad = '\\/:*?"<>|'
    return "".join("_" if c in bad else c for c in rel) + ".docx"


def convert_batch(limit=0):
    pythoncom.CoInitialize()
    files = [f for f in SRC.rglob("*.doc")
             if f.suffix.lower() == ".doc"]
    if limit:
        files = files[:limit]
    print("[doc2docx] 目标 %d 件" % len(files))
    word = wps = None
    ok = fail = skip = 0
    try:
        word = win32com.client.DispatchEx("Word.Application")
        word.Visible = False
        word.DisplayAlerts = 0
    except Exception as e:
        print("[doc2docx] Word 起不来:", repr(e)[:120])
    for i, f in enumerate(files, 1):
        target = DST / rel_name(f)
        if target.exists():
            skip += 1
            continue
        done = False
        for app_name, app in (("word", word), ):
            if app is None or done:
                continue
            try:
                doc = app.Documents.Open(
                    FileName=str(f), ConfirmConversions=False,
                    ReadOnly=True, AddToRecentFiles=False,
                    OpenAndRepair=True, Visible=False)
                if doc is None:
                    raise RuntimeError("open-null")
                doc.SaveAs2(str(target), 16)
                doc.Close(False)
                done = True
            except Exception:
                try:
                    app.Documents.Close(False)
                except Exception:
                    pass
        if not done and wps is None:
            try:
                wps = win32com.client.DispatchEx("KWps.Application")
                wps.Visible = False
            except Exception:
                wps = False
        if not done and wps:
            try:
                doc = wps.Documents.Open(str(f), False, True)
                doc.SaveAs2(str(target), 16)
                doc.Close(False)
                done = True
            except Exception:
                pass
        ok, fail = (ok + 1, fail) if done else (ok, fail + 1)
        if i % 100 == 0:
            print("[doc2docx] %d/%d ok=%d fail=%d skip=%d"
                  % (i, len(files), ok, fail, skip), flush=True)
    for app in (word, wps):
        if app:
            try:
                app.Quit()
            except Exception:
                pass
    print("[doc2docx] DONE ok=%d fail=%d skip=%d" % (ok, fail, skip))


if __name__ == "__main__":
    convert_batch(int(sys.argv[1]) if len(sys.argv) > 1 else 0)
