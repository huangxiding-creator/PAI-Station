# -*- coding: utf-8 -*-
"""docx_paiban — 工厂级通用排版器: 任意 .docx → 出版级自动排版 (1022 用户令).

蓝本: 逆向工程/wps-ai-paiban/replica/aipaiban.py (WPS「AI排版」会员功能
本地复刻, 逆向工程/wps-ai-paiban/ 逆向报告.md 全档). 九轨道回归全过:
beauty 21/21 · official(GB/T 9704) · thesis(GB/T 7713) · contract/bid
(WPS真身实测版) · exam(A3) · 仿排对拍零误差 · 幂等复跑.

产线接入点:
  - 报告线 S3: report_paiban.py (研报预设包装) ← 已固化
  - 本件 = 通用入口: 任何产线/任何 docx, 全预设可选, 带幂等质检门

用法:
  py -X utf8 tools/docx_paiban.py <输入.docx> [-o 输出.docx]
      [--preset beauty|official|thesis|contract|bid|contract-public|bid-public|exam-arts|exam-science]
      [--theme official-black|steel-blue|personal-navy] [--pdf] [--no-qa]

默认: beauty 预设 + 目录 + 页码 + 章分页 + 三线表 + 排版后幂等质检门
(复跑 dry-run 须判 incremental; 判 full 重排=告警)。--pdf 附带 Word COM 转 PDF。
"""
from __future__ import annotations

import argparse
import subprocess
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
REPO = Path(__file__).resolve().parents[1]
AIPAIBAN = REPO / "逆向工程" / "wps-ai-paiban" / "replica" / "aipaiban.py"
LEDGER = REPO / "data" / "state" / "paiban_factory_ledger.jsonl"


def paiban(src: Path, out: Path, preset: str, theme: str,
           extra: list[str], qa: bool) -> tuple[bool, str]:
    cmd = [sys.executable, "-X", "utf8", str(AIPAIBAN), str(src),
           "-o", str(out), "--mode", "auto", "--preset", preset,
           "--theme", theme, *extra]
    r = subprocess.run(cmd, capture_output=True, text=True,
                       encoding="utf-8", errors="replace", timeout=1800)
    ok = r.returncode == 0 and out.exists() and out.stat().st_size > 10000
    summary = (r.stdout or "")[-2500:] + (f"\n[stderr]{r.stderr[-600:]}"
                                          if r.returncode else "")
    if not ok or not qa:
        return ok, summary
    v = subprocess.run(
        [sys.executable, "-X", "utf8", str(AIPAIBAN), str(out),
         "--dry-run", "--mode", "auto"],
        capture_output=True, text=True, encoding="utf-8",
        errors="replace", timeout=900)
    vt = (v.stdout or "") + (v.stderr or "")
    if "incremental" in vt or '"full"' not in vt:
        summary += "\n[质检✅] 幂等复跑=incremental(排版达标)"
    else:
        summary += "\n[质检⚠️] 复跑判 full 重排 — 建议复查"
    return ok, summary


def docx_to_pdf(docx: Path) -> Path | None:
    """Word COM 后台转 PDF (build_pdf.py 卫生纪律)."""
    import win32com.client
    NO_WIN = 0x08000000
    pdf = docx.with_suffix(".pdf")

    def pids():
        rr = subprocess.run(
            ["tasklist", "/FI", "IMAGENAME eq WINWORD.EXE", "/FO", "CSV"],
            capture_output=True, text=True, encoding="gbk", errors="replace",
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
        try:
            word.Quit()
        except Exception:  # noqa: BLE001 — 大件后 Quit 常崩, 自清兜底
            pass
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
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("docx")
    ap.add_argument("-o", "--out", default="")
    ap.add_argument("--preset", default="beauty",
                    choices=["beauty", "official", "thesis", "contract", "bid",
                             "contract-public", "bid-public", "exam-arts",
                             "exam-science"])
    ap.add_argument("--theme", default="official-black",
                    choices=["official-black", "steel-blue", "personal-navy"])
    ap.add_argument("--pdf", action="store_true")
    ap.add_argument("--no-toc", action="store_true")
    ap.add_argument("--no-page-numbers", action="store_true")
    ap.add_argument("--no-h1-break", action="store_true")
    ap.add_argument("--table-style", default="three_line",
                    choices=["three_line", "off"])
    ap.add_argument("--no-qa", action="store_true")
    ns = ap.parse_args()

    src = Path(ns.docx).resolve()
    if not src.is_file():
        print(f"[!] 无文件: {src}")
        return 1
    if not AIPAIBAN.is_file():
        print(f"[!] 复刻件缺失: {AIPAIBAN}")
        return 2
    out = (Path(ns.out).resolve() if ns.out
           else src.with_name(src.stem + f"_排版版_{ns.preset}.docx"))

    extra = []
    if ns.no_toc:
        extra += ["--toc", "off"]
    if ns.no_page_numbers:
        extra += ["--page-numbers", "off"]
    if ns.no_h1_break:
        extra += ["--h1-break", "off"]
    extra += ["--table-style", ns.table_style]

    ok, summary = paiban(src, out, ns.preset, ns.theme, extra, not ns.no_qa)
    if not ok:
        print("[!!] 排版失败\n" + summary[-800:])
        return 3
    print(f"[✅] {ns.preset} 预设排版完成 → {out.name} {out.stat().st_size:,}B")
    for ln in summary.splitlines():
        if ln.startswith("[质检"):
            print(" " + ln)

    LEDGER.parent.mkdir(parents=True, exist_ok=True)
    import json
    with LEDGER.open("a", encoding="utf-8") as fh:
        fh.write(json.dumps(
            {"ts": time.strftime("%F %T"), "src": src.name,
             "out": out.name, "preset": ns.preset, "theme": ns.theme,
             "bytes": out.stat().st_size}, ensure_ascii=False) + "\n")

    if ns.pdf:
        docx_to_pdf(out)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
