# -*- coding: utf-8 -*-
"""s3_out_chain — EPC-OVERSEAS S3 出书链编排件（合并→docx→专业排版→PDF+幂等门）。

适配复用 SCHED 战役链（勿重造）:
  合并   ← build_docx.py 的 md 合并模式（章目基准 sched/chapters.json）
  docx   ← tools/report_to_docx.py（封面/点线目录/页码/中文字体基建）
  排版   ← work/m2/report_paiban.py（WPS AI 排版本地复刻 aipaiban, 零云端,
           研报预设: beauty/三线表/目录/页码/章分页 h1-break）
  PDF    ← report_paiban --pdf（Word COM 后台转换+进程自清卫生纪律）

元数据删减（主编报告 E 项, 仅此两类, 章文一字不改）:
  1) 章尾 <!-- chars: N --> 尾注注释
  2) 「本章使用说明（按角色取用）」块（引用块 2 行）
删前逐章断言: 恰删 1 条尾注+2 行说明块; 引注锚点/标题/表格行 前后全等。

usage: py -X utf8 s3_out_chain.py
产物: work/m2/overseas/out/{REPORT_FULL.md, 报告.docx, 报告_排版版.docx, 报告.pdf}
"""
from __future__ import annotations

import hashlib
import json
import re
import subprocess
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
PY311 = r"C:\Users\91216\AppData\Local\Programs\Python\Python311\python.exe"
OV = Path(__file__).resolve().parent
SCHED = OV / "sched"
OUT = OV / "out"
TITLE = "中资电力EPC出海：全球市场与准入实战指南"
TO_DOCX = Path(r"E:\AI-Station\tools\report_to_docx.py")
PAIBAN = OV.parent / "report_paiban.py"
CJK = re.compile(r"[\u4e00-\u9fff]")  # 战役口径同 _tmp_slop_audit.py
CHARS_NOTE = re.compile(r"^\s*<!-- chars: \d+ -->\s*$")
ROLE_MARK = "> **本章使用说明（按角色取用）**"


def strip_meta(text: str) -> tuple[str, dict]:
    """删两类元数据; 返回 (净文, 记账). 其余行一字不动."""
    lines = text.splitlines()
    keep, removed, note_n, role_n = [], [], 0, 0
    i = 0
    while i < len(lines):
        if CHARS_NOTE.match(lines[i]):
            note_n += 1
            removed.append(lines[i])
            i += 1
            continue
        if lines[i] == ROLE_MARK:
            role_n += 1
            removed.append(lines[i])
            i += 1
            while i < len(lines) and lines[i].startswith(">"):
                role_n += 1
                removed.append(lines[i])
                i += 1
            continue
        keep.append(lines[i])
        i += 1
    return ("\n".join(keep).rstrip() + "\n",
            {"clean": "\n".join(keep), "removed": "\n".join(removed),
             "note_lines": note_n, "role_lines": role_n})


def guards(name: str, orig: str, clean: str, removed_text: str, rec: dict) -> None:
    """删减守门: 恰删 1 尾注 + 2 行说明块; 锚点计数守恒(原=净+删, 删侧仅限块内);
    标题/表格行前后全等(块行皆 '>' 起头, 理论零变动)."""
    assert rec["note_lines"] == 1, f"{name} chars尾注数={rec['note_lines']} 应=1"
    assert rec["role_lines"] == 2, f"{name} 说明块行数={rec['role_lines']} 应=2"
    from collections import Counter
    a = Counter(re.findall(r"\[来源[：:][^\]]*\]", orig))
    b = Counter(re.findall(r"\[来源[：:][^\]]*\]", clean))
    d = Counter(re.findall(r"\[来源[：:][^\]]*\]", removed_text))
    assert a == b + d, f"{name} 锚点不守恒 {dict(a - b - d)}"
    for label, pre in (("标题行", "#"), ("表格行", "|")):
        a = [l for l in orig.splitlines() if l.startswith(pre)]
        b = [l for l in clean.splitlines() if l.startswith(pre)]
        assert a == b, f"{name} {label}变动 {len(a)}->{len(b)}"


def merge(out_md: Path) -> dict:
    chapters = json.loads((SCHED / "chapters.json").read_text(encoding="utf-8"))
    assert [c["no"] for c in chapters] == list(range(1, 13)), "章目基准非 1..12"
    front = [f"# {TITLE}", "", "出品：总包创研院研究团队", "版本日期：2026-10", ""]
    parts, ledger = list(front), []
    for c in chapters:
        p = SCHED / f"_ch{c['no']:02d}_p1.md"
        orig = p.read_text(encoding="utf-8")
        first = orig.splitlines()[0]
        assert first == f"# 第{c['no']}章 {c['title']}", \
            f"{p.name} 章题与 chapters.json 不符: {first}"
        clean, rec = strip_meta(orig)
        guards(p.name, orig, rec["clean"], rec["removed"], rec)
        rec["cjk_before"] = len(CJK.findall(orig))
        rec["cjk_removed"] = rec["cjk_before"] - len(CJK.findall(rec["clean"]))
        ledger.append(rec)
        parts.append(rec["clean"].rstrip())
        parts.append("")  # 章间空行分隔（书页分页由排版链 h1-break 落实）
    out_md.parent.mkdir(parents=True, exist_ok=True)
    out_md.write_text("\n".join(parts).rstrip() + "\n", encoding="utf-8")
    text = out_md.read_text(encoding="utf-8")
    return {
        "sha256": hashlib.sha256(out_md.read_bytes()).hexdigest()[:16],
        "cjk_total": len(CJK.findall(text)),
        "chapters": ledger,
        "bytes": out_md.stat().st_size,
    }


def run(cmd: list[str], timeout: int) -> subprocess.CompletedProcess:
    return subprocess.run(cmd, capture_output=True, text=True, encoding="utf-8",
                          errors="replace", timeout=timeout, creationflags=0x08000000)


def winword_pids() -> set:
    """当前 WINWORD PID 集（只清理本链启动后新增的, 用户自开的 Word 不碰）."""
    r = subprocess.run(["tasklist", "/FI", "IMAGENAME eq WINWORD.EXE", "/FO", "CSV"],
                       capture_output=True, text=True, encoding="gbk",
                       errors="replace", creationflags=0x08000000)
    return {ln.split('","')[1] for ln in r.stdout.splitlines()
            if '","' in ln and "WINWORD" in ln}


def docx_to_pdf(docx: Path, pdf: Path) -> int:
    """Word COM 后台转 PDF（build_pdf.py 崩容错模式: Quit 崩不判失败, 精准清 PID）."""
    pages = 0
    base = winword_pids()
    word = None
    try:
        import win32com.client
        word = win32com.client.DispatchEx("Word.Application")
        word.Visible = False
        word.DisplayAlerts = 0
        doc = word.Documents.Open(str(docx), ReadOnly=True)
        doc.ExportAsFixedFormat(str(pdf), 17)
        pages = doc.ComputeStatistics(2)
        doc.Close(False)
    finally:
        try:
            if word is not None:
                word.Quit()
        except Exception:  # noqa: BLE001 — Word COM 大件后 Quit 常崩(RPC失败), 进程交给精准清
            print("    [hygiene] Word Quit 崩(已知病), 走 PID 精准清")
        for _ in range(20):
            new = winword_pids() - base
            if not new:
                break
            for pid in new:
                subprocess.run(["taskkill", "/PID", pid, "/F"], capture_output=True,
                               creationflags=0x08000000)
            time.sleep(1)
    return pages


def main() -> int:
    t0 = time.time()
    md = OUT / "REPORT_FULL.md"
    m1 = merge(md)
    tmp = OUT / "_REPORT_FULL_rerun.md"
    m2 = merge(tmp)
    drift = m1["sha256"] != m2["sha256"]
    tmp.unlink()  # 自产的幂等对照件, 用毕即清（非用户资产）
    cjk_removed = sum(c["cjk_removed"] for c in m1["chapters"])
    print(f"[1] 合并 {md} {m1['bytes']:,}B sha256:{m1['sha256']} "
          f"CJK={m1['cjk_total']:,}(删元数据 {cjk_removed} 字) "
          f"幂等复跑={'零漂移PASS' if not drift else '漂移FAIL'}")
    print(f"    逐章删减: " + " ".join(
        f"ch{c_i + 1}:{c['note_lines']}+{c['role_lines']}(-{c['cjk_removed']})"
        for c_i, c in enumerate(m1["chapters"])))
    gate200k = m1["cjk_total"] >= 200_000
    print(f"    ≥20万字门: {'PASS' if gate200k else 'FAIL'}")
    if drift or not gate200k:
        return 1

    docx = OUT / f"{TITLE}.docx"
    r = run([PY311, "-X", "utf8", str(TO_DOCX), str(md), str(docx)], 600)
    ok_docx = r.returncode == 0 and docx.exists() and docx.stat().st_size > 50_000
    print(f"[2] docx {'PASS' if ok_docx else 'FAIL'} {docx.name} "
          f"{docx.stat().st_size if docx.exists() else 0:,}B")
    if not ok_docx:
        print((r.stdout or "")[-400:], (r.stderr or "")[-400:])
        return 2

    ts_docx = OUT / f"{TITLE}_排版版.docx"
    r = run([PY311, "-X", "utf8", str(PAIBAN), str(docx),
             "--out", str(ts_docx)], 3600)
    ok_ts = r.returncode == 0 and ts_docx.exists() and ts_docx.stat().st_size > 50_000
    print(f"[3] 排版 {'PASS' if ok_ts else 'FAIL'} {ts_docx.stat().st_size if ts_docx.exists() else 0:,}B")
    print("    " + "\n    ".join((r.stdout or "").splitlines()[-6:]))
    if not ok_ts:
        print((r.stderr or "")[-800:])
        return 3

    # 排版幂等质检: aipaiban dry-run 复跑应判 incremental（零改动达标）
    AIPAIBAN = Path(r"E:\AI-Station\逆向工程\wps-ai-paiban\replica\aipaiban.py")
    v = run([PY311, "-X", "utf8", str(AIPAIBAN), str(ts_docx),
             "--dry-run", "--mode", "auto"], 1800)
    vt = (v.stdout or "") + (v.stderr or "")
    inc = "incremental" in vt
    print(f"    排版幂等复跑: {'incremental PASS' if inc else '非incremental⚠ ' + vt[-300:]}")

    pdf = OUT / f"{TITLE}.pdf"
    pages = docx_to_pdf(ts_docx, pdf)
    ok_pdf = pdf.exists() and pdf.stat().st_size > 100_000
    vpages = 0
    if ok_pdf:
        from pypdf import PdfReader
        vpages = len(PdfReader(str(pdf)).pages)
    print(f"[4] PDF {'PASS' if ok_pdf else 'FAIL'} {pdf.name} "
          f"{pdf.stat().st_size if pdf.exists() else 0:,}B "
          f"Word统计{pages}页/pypdf实测{vpages}页")
    print(f"[5] 幂等门: 合并复跑零漂移={'PASS' if not drift else 'FAIL'}; "
          f"排版复跑={'incremental PASS' if inc else '未达标'}")
    print(f"S3 全链 {'PASS' if ok_pdf and not drift and gate200k else 'FAIL'} "
          f"耗时 {time.time() - t0:.0f}s")
    return 0 if ok_pdf and not drift and gate200k else 9


if __name__ == "__main__":
    raise SystemExit(main())
