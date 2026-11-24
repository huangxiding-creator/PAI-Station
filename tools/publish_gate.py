# -*- coding: utf-8 -*-
"""publish_gate — S7.5 出厂门 (1124 用户令: 对抗核验固化为产线硬门).

四维对抗核验的确定性子集固化为上架前硬门 (模型维度仍走对抗核验 workflow):
  A 书体    12章审计重跑全PASS / 全书L1书名==SKU title(连环替换门) / CJK≥200k
            / chapters.json↔h1 逐字 / 跨章逐字重复段落(软门) / 正身=nb_draft在场(1124铁令)
  B 交付    PDF无目录占位符(「更新目录域」「Ctrl+A」) / 页数==SKU副题 / PDF尺寸合理
  C 在架    report.json条目唯一存在 / price/chapters/sample/poster齐 / 本地site含书名
  D 宣传    标题≤64B / digest=blockquote≤120B / {{QRCODE}}在位 / ≥2000字
            (数字对勘与事实混用=模型维度, 由对抗核验 workflow 承担, 本门不重复)

用法:
  py -X utf8 tools/publish_gate.py --campaign-dir work/m2/f176d --sku SYNERGY-2026 \
     [--promo-md promo/a.md --promo-md promo/b.md ...] [--skip-online] \
     [--allow-no-nb-draft]   # 1124前出版的战役特赦(F176D纯bank先于正身令)
退出码: 0=放行上架; 1=拦截(逐条列出)
"""
from __future__ import annotations

import argparse
import json
import re
import subprocess
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
REPO = Path(__file__).resolve().parents[1]
PDF_PLACEHOLDER_PAT = re.compile(r"更新目录域|Ctrl\s*\+\s*A|F9")


def cjk(t: str) -> int:
    return len(re.findall(r"[一-鿿]", t))


def pdf_first_pages_text(pdf: Path, pages: int = 5) -> str:
    from pypdf import PdfReader
    r = PdfReader(str(pdf))
    return "\n".join((p.extract_text() or "") for p in r.pages[:pages])


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--campaign-dir", required=True)   # work/m2/<slug>
    ap.add_argument("--sku", required=True)
    ap.add_argument("--promo-md", action="append", default=[])
    ap.add_argument("--skip-online", action="store_true")
    ap.add_argument("--allow-no-nb-draft", action="store_true",
                    help="1124前出版战役特赦 (正身令之前纯bank出版)")
    ap.add_argument("--pre-shelf", action="store_true",
                    help="上架前过门模式: SKU条目/资产类检查降为WARN (sku_insert 自带安全门兜底)")
    ns = ap.parse_args()

    cd = REPO / ns.campaign_dir
    sched = cd / "sched"
    out = sched / "out"
    fails: list[str] = []
    warns: list[str] = []

    # ---------- A 书体 ----------
    # 逐章重跑审计脚本 (目录内 _audit_*.py, 如 _audit_f176d.py)
    audits = sorted(sched.glob("_audit_*.py"))
    chj_gate = sched / "chapters.json"
    n_ch = len(json.loads(chj_gate.read_text(encoding="utf-8"))) if chj_gate.is_file() else 12
    audit_py = audits[0] if audits else None
    if audit_py:
        nums = " ".join(f"{i:02d}" for i in range(1, n_ch + 1))
        rr = subprocess.run([sys.executable, "-X", "utf8", audit_py.name] + nums.split(),
                            capture_output=True, text=True, encoding="utf-8",
                            errors="replace", cwd=str(sched))
        audit_out = rr.stdout or ""
        n_fail = len(re.findall(r"\bFAIL", audit_out))
        if n_fail:
            fails.append(f"A1 章级审计 {n_fail} 项FAIL ({audit_py.name})")
        else:
            print(f"[A1] 12章审计重跑全PASS ({audit_py.name})")
    else:
        fails.append("A1 章级审计脚本缺席 (_audit_*.py)")

    book = out / "REPORT_FULL.md"
    if not book.is_file():
        fails.append("A2 REPORT_FULL.md 缺席")
        print("\n".join(fails))
        return 1
    book_text = book.read_text(encoding="utf-8")
    l1 = next((ln.lstrip("# ").strip() for ln in book_text.splitlines()
               if ln.startswith("# ")), "")
    cjk_total = cjk(book_text)
    if cjk_total < 200_000:
        fails.append(f"A3 全书 CJK {cjk_total:,} < 200,000")
    else:
        print(f"[A3] 全书 CJK {cjk_total:,}")

    # 连环替换门: 书名 == report.json SKU title
    rj = REPO / "report_platform" / "content" / "report.json"
    d = json.loads(rj.read_text(encoding="utf-8"))
    entry = next((x for x in d["reports"] if x.get("sku") == ns.sku), None)
    if not entry:
        (warns if ns.pre_shelf else fails).append(
            f"A4 report.json 无 {ns.sku} 条目" + (" (pre-shelf, sku_insert 兜底)" if ns.pre_shelf else " — 先头插再过门"))
    if entry:
        sku_title = (entry.get("title") or "").strip("《》")
        book_title = l1.strip("《》")
        if sku_title != book_title:
            fails.append(f"A4 书名连环替换: 书L1「{book_title[:24]}…」≠ SKU「{sku_title[:24]}…」")
        else:
            print(f"[A4] 书名==SKU title ✓ {l1[:40]}")
        if entry and chj_gate.is_file():
            want_n = len(json.loads(chj_gate.read_text(encoding="utf-8")))
            got_n = len(entry.get("chapters") or [])
            if got_n != want_n:
                fails.append(f"A5 SKU chapters={got_n} ≠ 章表{want_n}")

    # chapters.json ↔ h1 逐字
    chj = sched / "chapters.json"
    if chj.is_file():
        want = {f"第{x['no']}章 {x['title']}" for x in json.loads(chj.read_text(encoding="utf-8"))}
        got = set(re.findall(r"^# (第\d+章 .+)$", book_text, re.M))
        miss = want - got
        if miss:
            fails.append(f"A6 章题不符: {sorted(miss)[:2]}…")
        else:
            print("[A6] chapters.json ↔ 全书12章题逐字一致")

    # 跨章逐字重复段落 (软门: >8组 FAIL)
    finals = sorted(sched.glob("_ch*_final.md"))
    para_map: dict[str, list[str]] = {}
    for f in finals:
        for para in re.split(r"\n\s*\n", f.read_text(encoding="utf-8")):
            p = re.sub(r"\s", "", para)
            if len(p) >= 60 and not p.startswith("|"):
                para_map.setdefault(p, []).append(f.stem)
    dup_groups = {k: v for k, v in para_map.items() if len(set(v)) >= 2}
    if len(dup_groups) > 8:
        fails.append(f"A7 跨章逐字重复段落 {len(dup_groups)} 组 > 8 (收编须改写)")
    elif dup_groups:
        warns.append(f"A7 跨章逐字重复段落 {len(dup_groups)} 组 (同案复用, 软门容忍)")
    else:
        print("[A7] 跨章无逐字重复段落")

    # 正身: nb_draft 在场 (1124 铁令)
    missing_nb = [f.name for f in finals
                  if not (sched / f"_ch{f.stem[3:5]}_nb_draft.md").is_file()]
    if missing_nb and not ns.allow_no_nb_draft:
        fails.append(f"A8 正身缺NB初稿: {len(missing_nb)}章无 _chNN_nb_draft.md "
                     f"(1124铁令: NBLM初稿=正身)")
    elif missing_nb:
        warns.append(f"A8 特赦: {len(missing_nb)}章无nb_draft (1124前纯bank出版)")

    # ---------- B 交付 ----------
    pdf = out / "REPORT_FULL_排版版.pdf"
    if not pdf.is_file():
        fails.append("B1 排版版 PDF 缺席")
    else:
        txt = pdf_first_pages_text(pdf)
        hit = PDF_PLACEHOLDER_PAT.search(txt)
        if hit:
            fails.append(f"B2 PDF目录占位符未更新 (命中「{hit.group(0)}」— docx_paiban 需更新目录域)")
        else:
            print("[B2] PDF 目录已更新 (无占位符)")
        from pypdf import PdfReader
        n_pages = len(PdfReader(str(pdf)).pages)
        sub = entry.get("subtitle", "") if entry else ""
        m = re.search(r"(\d+)\s*页", sub)
        if m and int(m.group(1)) != n_pages:
            fails.append(f"B3 SKU副题页数 {m.group(1)} ≠ PDF实测 {n_pages} — 改账")
        elif m:
            print(f"[B3] 页数账实一致 {n_pages} 页")

    # ---------- C 在架 (本地) ----------
    if entry:
        for k, label in [("sample_file", "样章"), ("price", "价格")]:
            if not entry.get(k):
                fails.append(f"C1 SKU缺{label} ({k})")
        sample = REPO / "report_platform" / "content" / "sample" / str(entry.get("sample_file", "x"))
        if entry.get("sample_file") and not sample.is_file():
            fails.append(f"C2 样章文件缺席: {entry['sample_file']}")
        poster = REPO / "report_platform" / "promo" / "posters" / f"{ns.sku}.png"
        if not poster.is_file():
            fails.append(f"C3 海报缺席: {ns.sku}.png — 先 poster_fetch")
        else:
            print("[C3] 海报在位")
        site_idx = REPO / "report_platform" / "site" / "index.html"
        if site_idx.is_file() and l1.strip("《》")[:12] not in site_idx.read_text(encoding="utf-8"):
            fails.append("C4 site/index.html 未含书名 — 先 build_site")
        elif site_idx.is_file():
            print("[C4] site 目录含书名")

    # ---------- D 宣传 ----------
    for md_arg in ns.promo_md:
        p = Path(md_arg) if Path(md_arg).is_absolute() else REPO / md_arg
        if not p.is_file():
            fails.append(f"D1 宣传稿缺席: {md_arg}")
            continue
        t = p.read_text(encoding="utf-8")
        title_m = re.search(r"^#\s*(.+)$", t, re.M)
        title = title_m.group(1).strip() if title_m else ""
        tb = title.encode("utf-8")
        if len(tb) > 64:
            fails.append(f"D2 {p.name} 标题 {len(tb)}B > 64B (45003)")
        dq = ""
        for ln in t.splitlines()[:8]:
            s = ln.strip()
            if s.startswith(">"):
                dq = s.lstrip("> ").strip()
                break
        db = dq.encode("utf-8")
        if not dq:
            fails.append(f"D3 {p.name} 前8行无 blockquote digest")
        elif len(db) > 120:
            warns.append(f"D4 {p.name} digest {len(db)}B → push_article 发布时字节截断到120B "
                         f"(45004; 想要完整摘要请把 md blockquote 压进120B)")
        if "{{QRCODE}}" not in t:
            fails.append(f"D5 {p.name} 缺 {{QRCODE}} 占位")
        n_cjk = cjk(t)
        if n_cjk < 2000:
            fails.append(f"D6 {p.name} 正文 {n_cjk} < 2000字")
        if not fails or all(not x.startswith(f"D") for x in fails):
            print(f"[D] {p.name}: 标题{len(tb)}B digest{len(db)}B CJK{n_cjk} ✓")

    # ---------- 裁决 ----------
    print()
    for w in warns:
        print(f"[WARN] {w}")
    if fails:
        print(f"\n== 出厂门拦截: {len(fails)} 项 ==")
        for f in fails:
            print(f"  ✗ {f}")
        return 1
    print("\n== 出厂门放行 ✓ (S7.5 PASS — 可上架) ==")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
