# -*- coding: utf-8 -*-
"""fomi_nblm_pack300 v2 - 300文件纪律的正确整理法 (1102用户令 v2):
  文本类(md/txt/docx≤1MB) → 分域合并包(每包≤25件, 抽文本快道);
  PDF → 不抽取, 按主题相关性选 TOP 直接作源上传(NBLM原生吃PDF);
  其余未入选件 → 每域一份『资料索引包』(题名+大小清单, 全量可溯源).
总文件数 ≤ 300 (既有14源 + v2产物).
用法: py -X utf8 fomi_nblm_pack300v2.py [--pdf-direct 60] [--packs 150]
"""
from __future__ import annotations

import json
import re
import sys
from pathlib import Path

sys.path.insert(0, r"E:\AI-Station\reforge_factory")
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.stderr.reconfigure(encoding="utf-8", errors="replace")
import ammo_pool                                        # noqa: E402

WS = Path(r"E:\AI-Station\07 任务\福米电站EPC管理策划\05 Super-Skill工作区")
FW = WS / "nblm_upload" / "00_战役总笔记本"
STAGING = WS / "bdn_staging"
POOL = Path(r"E:\AI-Station\ammo_pool\FOMI-EPC")
SRC = Path(r"E:\AI-Station\07 任务\福米电站EPC管理策划")

MAX_TOTAL = 300
PDF_DIRECT = 60          # 直接上传的 PDF 数上限
PACKS_MAX = 150          # 合并包数上限
PER_PACK = 25            # 每包件数上限
TEXT_LIMIT = 1_000_000   # 文本类抽取的文件大小上限(B)

THEMES: list = [
    ("福米项目原件", lambda e, p: "fomi_project" in e or ("07 任务" in p and "05 Super" not in p)),
    ("兰州专著一手档案", lambda e, p: "lanzhou_monograph" in e or "兰州水源地专著" in p),
    ("兰州档案doc转换", lambda e, p: "lanzhou_doc_conv" in e or "doc_converted" in p),
    ("总包创新院库", lambda e, p: "zbcx_institute" in e or "AI总包创新院" in p),
    ("凯乐塔几内亚前例", lambda e, p: "kaleta" in e.lower() or "凯乐塔" in p),
    ("国际项目管理库198", lambda e, p: "intl_pm198" in e or "国际项目管理库" in p),
    ("总包大脑知识库", lambda e, p: "bdn" in e or "总包大脑" in p or "brain" in p.lower()),
    ("调度采集语料", lambda e, p: True),
]

#: PDF 直接上传的主题优先序 (越前越优先)
PDF_THEME_PRIORITY = ["凯乐塔几内亚前例", "国际项目管理库198", "总包大脑知识库",
                      "兰州专著一手档案", "总包创新院库", "福米项目原件", "调度采集语料"]

REL_RE = re.compile(
    r"几内亚|福米|凯乐塔|苏阿皮蒂|Fomi|Niandan|EPC|总承包|项目管理|FIDIC|国际工程|"
    r"水利水电|大坝|水电站|策划|体系|制度|合同|采购|质量|安全|风险|进度|数字化|"
    r"黄河|兰州|莫莫克|IPMA|PMI|PMBOK|咨询|标杆|案例|流程|管理", re.I)


def clean(t: str) -> str:
    return (t or "").encode("utf-8", errors="ignore").decode("utf-8")


def read_text_fast(fp: Path) -> str:
    suf = fp.suffix.lower()
    try:
        if suf in (".md", ".txt", ".markdown"):
            return clean(fp.read_text(encoding="utf-8", errors="ignore"))
        if suf == ".docx":
            import zipfile
            with zipfile.ZipFile(str(fp)) as z:
                xml = z.read("word/document.xml").decode("utf-8", errors="ignore")
            return clean(re.sub(r"<[^>]+>", " ", xml))
    except Exception:
        return ""
    return ""


def main() -> int:
    if "--pdf-direct" in sys.argv:
        global PDF_DIRECT
        PDF_DIRECT = int(sys.argv[sys.argv.index("--pdf-direct") + 1])
    items = []                       # (engine, path)
    mp = POOL / "manifest.jsonl"
    if mp.is_file():
        for ln in mp.read_text(encoding="utf-8").splitlines():
            ln = ln.strip()
            if not ln:
                continue
            try:
                o = ammo_pool._jload(ln)
            except Exception:
                continue
            if ammo_pool.RAW_MARK in o:
                continue
            items.append((o.get("engine", ""), o.get("source_path", "")))
    seen = {p for _, p in items}
    for f in STAGING.rglob("*"):
        if f.is_file() and f.suffix.lower() in (
                ".md", ".txt", ".pdf", ".docx", ".markdown") and str(f) not in seen:
            items.append(("bdn:staging", str(f)))
    exist = {f.name for f in FW.iterdir() if f.is_file()}
    base_count = len(exist)
    print(f"[v2] 候选 {len(items)} | 总本既有 {base_count} 文件, 预算 {MAX_TOTAL - base_count}")

    # ---- 分域 ----
    by_theme: dict = {}
    for eng, path in items:
        fp = Path(path)
        if not fp.is_file():
            continue
        th = "调度采集语料"
        for name, fn in THEMES[:-1]:
            try:
                if fn(eng, path):
                    th = name
                    break
            except Exception:
                pass
        by_theme.setdefault(th, []).append(fp)
    for th in by_theme:
        print(f"[v2] {th}: {len(by_theme[th])} 件")

    budget = MAX_TOTAL - base_count
    used = 0

    # ---- ① PDF 直接作源 (TOP by 相关性+大小) ----
    pdf_picked = []
    for th in PDF_THEME_PRIORITY:
        if len(pdf_picked) >= PDF_DIRECT or used >= budget - 40:
            break
        pdfs = [f for f in by_theme.get(th, []) if f.suffix.lower() == ".pdf"
                and 200_000 < f.stat().st_size <= 60_000_000]
        pdfs.sort(key=lambda f: -(100 if REL_RE.search(f.name) else 0)
                  * f.stat().st_size)
        for f in pdfs:
            if len(pdf_picked) >= PDF_DIRECT or used >= budget - 40:
                break
            name = f"q{len(pdf_picked) + 1:03d}_" + re.sub(
                r'[\\/:*?"<>|\s#]+', "_", th[:6] + "_" + f.stem)[:52] + ".pdf"
            if name in exist or len(name.encode("utf-8")) > 180:
                name = f"q{len(pdf_picked) + 1:03d}_pdf.pdf"
            dst = FW / name
            if not dst.exists():
                dst.write_bytes(f.read_bytes())
            pdf_picked.append((name, f))
            exist.add(name)
            used += 1
    print(f"[v2] PDF直传源 {len(pdf_picked)} 件")

    # ---- ② 文本类合并包 (每域可多包) ----
    pack_n = 0
    idx_lines = []
    for th, files in sorted(by_theme.items(),
                            key=lambda x: -len(x[1])):
        texts = [f for f in files if f.suffix.lower() in (
            ".md", ".txt", ".markdown", ".docx")
            and f.stat().st_size <= TEXT_LIMIT]
        big_texts = [f for f in files if f.suffix.lower() in (
            ".md", ".txt", ".docx") and f.stat().st_size > TEXT_LIMIT]
        others = [f for f in files if f not in texts and f not in big_texts]
        texts.sort(key=lambda f: -(100 if REL_RE.search(f.name) else 0))
        for i in range(0, min(len(texts), PER_PACK * 4), PER_PACK):
            if pack_n >= PACKS_MAX or used >= budget - 5:
                break
            chunk = texts[i:i + PER_PACK]
            body = [f"# 【{th}】合并包{pack_n + 1} (源{len(chunk)}件)\n",
                    "\n## 来源清单\n" + "\n".join(
                        f"- {f.name} ({f.stat().st_size:,}B)" for f in chunk)
                    + "\n\n---\n"]
            for f in chunk:
                t = read_text_fast(f)
                if t.strip():
                    body.append(f"\n\n◆源: {f.name}\n\n{t[:60000]}")
            name = f"r{pack_n + 1:03d}_{re.sub('[\\\\/:*?\"<>|\\s#]+', '_', th)[:12]}.md"
            fp_out = FW / name
            if not fp_out.exists():
                fp_out.write_text(clean("".join(body)), encoding="utf-8")
            exist.add(name)
            pack_n += 1
            used += 1
            print(f"[v2] {name} 源{len(chunk)} {fp_out.stat().st_size:,}B")
        # 索引包: 该域全部件名(含未入包的)
        if used < budget and (others or big_texts):
            idx = [f"# 【{th}】资料索引 (全量清单, 共{len(files)}件)",
                   f"> 其中合并包已收文本类{min(len(texts), PER_PACK*4)}件; "
                   f"以下为全量清单(未入选件之题名可溯源):", ""]
            for f in files:
                idx.append(f"- {f.name} ({f.stat().st_size:,}B)")
            name = f"x{re.sub('[\\\\/:*?\"<>|\\s#]+', '_', th)[:12]}_索引.md"
            fp_out = FW / name
            if not fp_out.exists():
                fp_out.write_text("\n".join(idx), encoding="utf-8")
            exist.add(name)
            used += 1

    total = len(list(FW.glob("*")))
    (WS / "nblm_upload" / "上传清单_300包v2.md").write_text(
        "# v2 上传清单\n\n> 总本文件数 %d / 上限300\n" % total
        + "\n".join("- " + f.name for f in sorted(FW.glob("q*")) )
        + "\n\n## 合并包与索引\n" + "\n".join("- " + f.name for f in sorted(FW.glob("r*")) + sorted(FW.glob("x*"))),
        encoding="utf-8")
    print(f"[v2] DONE 总本文件数 {total} (≤300: {'OK' if total <= 300 else '超限!'})")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
