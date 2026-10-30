# -*- coding: utf-8 -*-
"""s3_book_chain — S3 出书标准链（产线级一键：合并→docx→WPS复刻排版硬门→PDF→幂等质检→产物清单）。

固化来源（只增不删, 既有件零改动）: 第9份 EPC-OVERSEAS 实证链
  _proposals/flagship-paid-report-1007/work/m2/overseas/s3_out_chain.py（1025, out/ 341页全绿）
本件 = 该链的战役参数化通用版（--campaign/--chapters-dir/--title/--out-dir）。

环节与复用件（勿重造）:
  ① 合并   第9份 merge 逻辑原样移植: 章目基准 <chapters-dir>/chapters.json（no=1..N 连续）,
           章文 _ch{no:02d}_p1.md 首行须=「# 第N章 title」; 扉页(# 书名/出品：总包创研院研究团队/
           版本日期) + 章序拼 + 内部元数据删减（仅两类: 章尾 <!-- chars: N --> 尾注、
           「本章使用说明（按角色取用）」块2行）; 守门: 恰删1尾注+2行块、[来源:…]锚点守恒、
           标题行/表格行前后全等。无 chapters.json 时支持 --merged-md 已合并稿直通（只记账不删改）。
  ② docx   tools/report_to_docx.py（封面/点线目录/页码/中文字体基建）
  ③ 排版硬门 逆向工程/wps-ai-paiban/replica/aipaiban.py（WPS「AI排版」本地复刻, 零云端）,
           研报预设轨（同 m2/report_paiban.py）: --preset beauty --toc on --page-numbers on
           --h1-break on --table-style three_line; 排版失败=链中断（1022宪法令: 合并完成必须
           排版、全链自动无绕行——本return 3即该条款代码化）。
  ④ PDF    Word COM 后台转换（ExportAsFixedFormat 不弹窗, WINWORD PID 精准清卫生纪律）,
           pypdf 实测页数; PDF 永远只从「排版版 docx」出——结构上杜绝无排版 PDF。
  ⑤ 幂等质检 合并复跑 sha256 零漂移 + aipaiban --dry-run 复跑须判 incremental。
  ⑥ 产物清单 逐件 bytes/sha256 实测打印 + s3_run_manifest.json;
           台账 reforge_factory/s3_book_chain_ledger.jsonl 只增不改。

usage:
  py -X utf8 s3_book_chain.py --campaign <名> --chapters-dir <终稿目录> --title <书名> \
      [--out-dir <产物目录>] [--version-date 2026-10] [--merged-md <已合并md>] [--skip-20w-gate]
产物: <out-dir>/{REPORT_FULL.md, 书名.docx, 书名_排版版.docx(+.summary.md), 书名.pdf, s3_run_manifest.json}
退出码: 0=全链PASS | 1=合并/20万字门 | 2=docx门 | 3=排版硬门(无排版不出PDF) | 4=PDF门 | 9=总门
"""
from __future__ import annotations

import argparse
import hashlib
import json
import re
import subprocess
import sys
import time
from collections import Counter
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

RF = Path(__file__).resolve().parent                          # E:\AI-Station\reforge_factory
TO_DOCX = Path(r"E:\AI-Station\tools\report_to_docx.py")       # 封面/点线目录/页码/中文字体
AIPAIBAN = Path(r"E:\AI-Station\逆向工程\wps-ai-paiban\replica\aipaiban.py")  # WPS复刻排版
PY311 = r"C:\Users\91216\AppData\Local\Programs\Python\Python311\python.exe"   # 腿件解释器(同第9份)
LEDGER = RF / "s3_book_chain_ledger.jsonl"                     # 只增不改
PUBLISHER = "总包创研院研究团队"                                 # 出品方固定(AI表述禁令: 不提AI辅助)
CJK = re.compile(r"[\u4e00-\u9fff]")
CHARS_NOTE = re.compile(r"^\s*<!-- chars: \d+ -->\s*$")
ROLE_MARK = "> **本章使用说明（按角色取用）**"
# 研报预设轨（同 m2/report_paiban.py 的产线调用面, 零云端）
PAIBAN_FLAGS = ["--mode", "auto", "--preset", "beauty", "--toc", "on",
                "--page-numbers", "on", "--h1-break", "on", "--table-style", "three_line"]

# ---------------- ① 合并（第9份 s3_out_chain 逻辑原样移植, 战役参数化） ----------------

def strip_meta(text: str) -> tuple[str, dict]:
    """删两类内部元数据; 返回 (净文, 记账). 其余行一字不动."""
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
    """删减守门: 恰删1尾注+2行说明块; 来源锚点守恒(原=净+删); 标题/表格行前后全等."""
    assert rec["note_lines"] == 1, f"{name} chars尾注数={rec['note_lines']} 应=1"
    assert rec["role_lines"] == 2, f"{name} 说明块行数={rec['role_lines']} 应=2"
    a = Counter(re.findall(r"\[来源[：:][^\]]*\]", orig))
    b = Counter(re.findall(r"\[来源[：:][^\]]*\]", clean))
    d = Counter(re.findall(r"\[来源[：:][^\]]*\]", removed_text))
    assert a == b + d, f"{name} 锚点不守恒 {dict(a - b - d)}"
    for label, pre in (("标题行", "#"), ("表格行", "|")):
        a2 = [l for l in orig.splitlines() if l.startswith(pre)]
        b2 = [l for l in clean.splitlines() if l.startswith(pre)]
        assert a2 == b2, f"{name} {label}变动 {len(a2)}->{len(b2)}"

def md_stat(p: Path) -> dict:
    return {"sha256": hashlib.sha256(p.read_bytes()).hexdigest()[:16],
            "cjk_total": len(CJK.findall(p.read_text(encoding="utf-8"))),
            "bytes": p.stat().st_size}

def merge_chapters(chapters_dir: Path, title: str, version_date: str, out_md: Path) -> dict:
    """章目录 + chapters.json → REPORT_FULL.md（扉页/章序拼/元数据删减+守门）."""
    chapters = json.loads((chapters_dir / "chapters.json").read_text(encoding="utf-8"))
    nos = [c["no"] for c in chapters]
    assert nos == list(range(1, len(nos) + 1)), f"章目基准非 1..{len(nos)} 连续: {nos}"
    parts = [f"# {title}", "", f"出品：{PUBLISHER}", f"版本日期：{version_date}", ""]
    ledger = []
    for c in chapters:
        p = chapters_dir / f"_ch{c['no']:02d}_p1.md"
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
        parts.append("")  # 章间空行分隔（书页分页由排版轨 h1-break 落实）
    out_md.parent.mkdir(parents=True, exist_ok=True)
    out_md.write_text("\n".join(parts).rstrip() + "\n", encoding="utf-8")
    return {**md_stat(out_md), "chapters": ledger, "mode": "chapters"}

def merge_passthrough(src_md: Path, out_md: Path) -> dict:
    """已合并稿直通模式: 逐字节复制入产物目录(不删不改), 只记账."""
    out_md.parent.mkdir(parents=True, exist_ok=True)
    out_md.write_bytes(src_md.read_bytes())
    return {**md_stat(out_md), "chapters": [], "mode": "passthrough"}

# ---------------- 腿件执行基建（第9份同款卫生纪律） ----------------

def run(cmd: list, timeout: int) -> subprocess.CompletedProcess:
    return subprocess.run(cmd, capture_output=True, text=True, encoding="utf-8",
                          errors="replace", timeout=timeout, creationflags=0x08000000)

def winword_pids() -> set:
    """当前 WINWORD PID 集（只清理本链启动后新增的, 用户自开的 Word 不碰）."""
    r = subprocess.run(["tasklist", "/FI", "IMAGENAME eq WINWORD.EXE", "/FO", "CSV"],
                       capture_output=True, text=True, encoding="gbk", errors="replace",
                       creationflags=0x08000000)
    return {ln.split('","')[1] for ln in r.stdout.splitlines()
            if '","' in ln and "WINWORD" in ln}

def docx_to_pdf(docx: Path, pdf: Path) -> int:
    """④ Word COM 后台转 PDF（Quit 崩不判失败, PID 精准清; 同第9份 build_pdf 崩容错模式）."""
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

# ---------------- 主链 ----------------

def main() -> int:
    ap = argparse.ArgumentParser(
        description="S3 出书标准链: ①合并 ②docx ③WPS复刻排版硬门 ④PDF ⑤幂等质检 ⑥产物清单")
    ap.add_argument("--campaign", required=True, help="战役名(记账用)")
    ap.add_argument("--chapters-dir", default="", help="终稿章目录(含 chapters.json + _chNN_p1.md)")
    ap.add_argument("--merged-md", default="", help="已合并稿直通(替代 --chapters-dir, 须配 --out-dir)")
    ap.add_argument("--title", required=True, help="书名")
    ap.add_argument("--out-dir", default="", help="产物目录(缺省=<chapters-dir>/out)")
    ap.add_argument("--version-date", default=time.strftime("%Y-%m"), help="扉页版本日期(缺省当月)")
    ap.add_argument("--leg-python", default=PY311, help="腿件解释器(report_to_docx/aipaiban)")
    ap.add_argument("--skip-20w-gate", action="store_true", help="冒烟/短件明示跳过≥20万字门")
    ns = ap.parse_args()
    if not ns.chapters_dir and not ns.merged_md:
        ap.error("需 --chapters-dir 或 --merged-md 之一")
    if ns.merged_md and not ns.chapters_dir and not ns.out_dir:
        ap.error("--merged-md 直通模式必须显式 --out-dir（防误写正式产物目录）")
    t0 = time.time()
    leg = ns.leg_python if Path(ns.leg_python).exists() else sys.executable
    cdir = Path(ns.chapters_dir).resolve() if ns.chapters_dir else None
    out_dir = Path(ns.out_dir).resolve() if ns.out_dir else (cdir / "out")
    out_dir.mkdir(parents=True, exist_ok=True)
    print(f"== S3 出书链 campaign={ns.campaign} title={ns.title}")
    print(f"   chapters={'<直通merged-md>' if cdir is None else cdir}")
    print(f"   out={out_dir}")
    print(f"   legs: to_docx={TO_DOCX} | aipaiban={AIPAIBAN} | leg_py={leg}")

    # ① 合并（+20万字门+合并幂等零漂移）
    md = out_dir / "REPORT_FULL.md"
    if ns.merged_md and not ns.chapters_dir:
        m1 = merge_passthrough(Path(ns.merged_md).resolve(), md)
    else:
        m1 = merge_chapters(cdir, ns.title, ns.version_date, md)
    rerun = out_dir / "_REPORT_FULL_rerun.md"
    if m1["mode"] == "passthrough":
        m2 = merge_passthrough(md, rerun)
    else:
        m2 = merge_chapters(cdir, ns.title, ns.version_date, rerun)
    drift = m1["sha256"] != m2["sha256"]
    cjk_removed = sum(c["cjk_removed"] for c in m1["chapters"])
    print(f"[1] 合并[{m1['mode']}] {md.name} {m1['bytes']:,}B sha256:{m1['sha256']} "
          f"CJK={m1['cjk_total']:,}(删元数据 {cjk_removed} 字) "
          f"幂等复跑={'零漂移PASS' if not drift else '漂移FAIL'}")
    if m1["chapters"]:
        print("    逐章删减: " + " ".join(
            f"ch{i + 1}:{c['note_lines']}+{c['role_lines']}(-{c['cjk_removed']})"
            for i, c in enumerate(m1["chapters"])))
    gate200k = m1["cjk_total"] >= 200_000
    gate_ok = gate200k or ns.skip_20w_gate
    print(f"    ≥20万字门: {'PASS' if gate200k else ('SKIP(明示)' if ns.skip_20w_gate else 'FAIL')}")
    if drift or not gate_ok:
        return 1

    # ② docx
    docx = out_dir / f"{ns.title}.docx"
    r = run([leg, "-X", "utf8", str(TO_DOCX), str(md), str(docx)], 600)
    ok_docx = r.returncode == 0 and docx.exists() and docx.stat().st_size > 50_000
    print(f"[2] docx {'PASS' if ok_docx else 'FAIL'} {docx.name} "
          f"{docx.stat().st_size if docx.exists() else 0:,}B")
    if not ok_docx:
        print((r.stdout or "")[-400:], (r.stderr or "")[-400:])
        return 2

    # ③ aipaiban 排版硬门（1022宪法令「合并完成必须排版·无绕行」代码化:
    #    失败即 return 3 链中断, 永不走到 PDF 段）
    ts_docx = out_dir / f"{ns.title}_排版版.docx"
    r = run([leg, "-X", "utf8", str(AIPAIBAN), str(docx), "-o", str(ts_docx), *PAIBAN_FLAGS], 3600)
    ok_ts = r.returncode == 0 and ts_docx.exists() and ts_docx.stat().st_size > 50_000
    print(f"[3] 排版硬门 {'PASS' if ok_ts else 'FAIL'} {ts_docx.name} "
          f"{ts_docx.stat().st_size if ts_docx.exists() else 0:,}B")
    print("    " + "\n    ".join((r.stdout or "").splitlines()[-6:]))
    if not ok_ts:
        print("    [宪法无绕行] 排版失败=链中断, 禁止无排版出PDF")
        print((r.stderr or "")[-800:])
        return 3

    # ④ PDF（只从排版版 docx 出——结构上杜绝无排版PDF）
    pdf = out_dir / f"{ns.title}.pdf"
    wpages = docx_to_pdf(ts_docx, pdf)
    ok_pdf = pdf.exists() and pdf.stat().st_size > 100_000
    vpages = 0
    if ok_pdf:
        from pypdf import PdfReader
        vpages = len(PdfReader(str(pdf)).pages)
        print(f"[4] PDF {'PASS' if ok_pdf else 'FAIL'} {pdf.name} "
              f"{pdf.stat().st_size:,}B Word统计{wpages}页/pypdf实测{vpages}页")
    else:
        print(f"[4] PDF FAIL {pdf.name} {pdf.stat().st_size if pdf.exists() else 0:,}B")
        return 4

    # ⑤ 幂等质检（合并零漂移已过; 排版 dry-run 复跑须判 incremental）
    v = run([leg, "-X", "utf8", str(AIPAIBAN), str(ts_docx), "--dry-run", "--mode", "auto"], 1800)
    vt = (v.stdout or "") + (v.stderr or "")
    inc = "incremental" in vt
    print(f"[5] 幂等质检: 合并复跑={'零漂移PASS' if not drift else 'FAIL'}; "
          f"排版dry-run复跑={'incremental PASS' if inc else '未达标⚠ ' + vt[-300:]}")

    # ⑥ 产物清单（全实测 sha256/bytes/页数 — 数字零造假）
    arts = []
    for p in [md, docx, ts_docx, out_dir / f"{ns.title}_排版版.summary.md", pdf]:
        if p.exists():
            arts.append({"file": p.name, "bytes": p.stat().st_size,
                         "sha256_16": hashlib.sha256(p.read_bytes()).hexdigest()[:16]})
    print("[6] 产物清单:")
    for a in arts:
        print(f"    {a['bytes']:>12,}B  sha256:{a['sha256_16']}  {a['file']}")
    ok_all = ok_docx and ok_ts and ok_pdf and not drift and gate_ok
    manifest = {"ts": time.strftime("%F %T"), "campaign": ns.campaign, "title": ns.title,
                "version_date": ns.version_date, "verdict": "PASS" if ok_all else "FAIL",
                "merge": {k: m1[k] for k in ("sha256", "cjk_total", "bytes", "mode")},
                "idempotence": {"merge_zero_drift": not drift, "paiban_incremental": inc},
                "pages": {"word": wpages, "pypdf": vpages},
                "artifacts": arts, "elapsed_s": round(time.time() - t0, 1),
                "paiban_track": " ".join(PAIBAN_FLAGS)}
    (out_dir / "s3_run_manifest.json").write_text(
        json.dumps(manifest, ensure_ascii=False, indent=1), encoding="utf-8")
    with LEDGER.open("a", encoding="utf-8") as fh:
        fh.write(json.dumps({"ts": manifest["ts"], "campaign": ns.campaign, "title": ns.title,
                             "verdict": manifest["verdict"], "md_sha256": m1["sha256"],
                             "cjk": m1["cjk_total"], "pdf_pages": vpages,
                             "pdf_bytes": pdf.stat().st_size,
                             "paiban_incremental": inc, "zero_drift": not drift,
                             "out_dir": str(out_dir)}, ensure_ascii=False) + "\n")
    print(f"S3 全链 {'PASS' if ok_all else 'FAIL'} 耗时 {time.time() - t0:.0f}s")
    return 0 if ok_all else 9

if __name__ == "__main__":
    raise SystemExit(main())
