# -*- coding: utf-8 -*-
"""batch_up.py — 内容产线批处理上架（T-P0-02 + T-P0-03 接线；常驻增量出货通道）
母本 content_pipeline.py 零改动旁挂复用（split/junk/HTML 壳/Edge 渲染全 import）。
增量语义（RUN_LEDGER #16 常驻令）：无 --force 时已产出且校验通过的 slug 直接跳过，
新落盘 docx 自动纳管——同一条命令既是全量批处理也是日常增量上架。

用法（PYTHONIOENCODING=utf-8）:
  python batch_up.py --dry-run                 # 清单+去重决策表（写 manifest，不产文件）
  python batch_up.py --only js-shuiwang-2026   # 指定 slug（逗号分隔）
  python batch_up.py --limit 3                 # 只跑前 N 份未产出的（冒烟）
  python batch_up.py                           # 全量/增量（幂等续跑）
  python batch_up.py --force                   # 忽略缓存全部重跑（含 publishedAt 刷新）
  python batch_up.py --verify                  # 验收断言（catalog/占比/空壳/包内零命中/PDF）
产物：微信小程序/zongbao/content/reports/{slug}/chapters.json（付费章空壳）
      + content/catalog.json（price=49800 分，补 province/industry/ownerType/trialChapterCount）
      + E:/AI-Station/data/xueyuan/pdfs/{slug}/{read,print,trial}.pdf（read 110dpi/print 150dpi ≤10MB）
"""
from __future__ import annotations

import argparse
import json
import re
import sys
from datetime import date
from pathlib import Path

import mammoth

import content_pipeline as cp
import pdf_compress
from batch_meta import DEDUP_PAIRS, META, infer_meta
import chapters_full as cfu
import cards_extract as cex   # 波3a：商机卡抽取（裂变2.0 VIRAL_100X 引擎1 数据底座）

REPORTS_DIR = Path("E:/AI-Station/EngOpp-Mining/reports")
XY = Path("E:/AI-Station/data/xueyuan")
XY_PDF, XY_BUILD, TMP = XY / "pdfs", XY / "build", Path("E:/AI-Station/data/_tmp")
PRICE_FEN = 49800
TRIAL_BAND = (0.15, 0.25)   # 试读占比验收带（REQUIREMENTS FR-P0-01）
TRIAL_DEFAULT = 2           # 默认试读 2 章；占比不达 15% 时自适应加章（字段记实际值）

PLAIN = lambda s: len(re.sub(r"<[^>]+>", "", s))
STRONG_TITLE = re.compile(  # 单块文档兜底梯级：<p><strong>一、…</strong></p> 编号小节
    r"^<p><strong>("
    r"[一二三四五六七八九十]{1,3}、|[（(][一二三四五六七八九十]{1,3}[)）]"
    r"|\d{1,2}[.、](?!\d)|第[一二三四五六七八九十百\d]+[章节部分篇]"
    r")[^<]{0,60}</strong></p>$"
)
BLOCK = re.compile(r"(<p>.*?</p>|<table.*?</table>|<h[1-6].*?</h[1-6]>|<[ou]l.*?</[ou]l>)", re.S)


def split_ex(html: str) -> tuple[list, str]:
    """h1→h2+噪声过滤沿用母本（试点语义零漂移）；'全文'单块时切 <p><strong>编号段</strong></p>"""
    chs = cp.drop_junk_chapters(cp.split_chapters(html))
    if not (len(chs) == 1 and chs[0]["title"] == "全文"):
        return chs, "h1"
    tokens = [t for t in BLOCK.split(html) if t and t.strip()]
    chunks: list[dict] = []
    title, buf, preamble = None, [], []
    for tok in tokens:
        m = STRONG_TITLE.match(tok.strip())
        if m:
            if title is None:
                preamble, buf = buf, []  # 首个编号段之前的前导块封存
            else:
                chunks.append({"title": title, "html": "".join(buf)})
                buf = []
            title = re.sub(r"<[^>]+>", "", m.group(0)).strip()
            buf.append(tok)
        else:
            buf.append(tok)
    if title is not None:
        chunks.append({"title": title, "html": "".join(buf)})
    if chunks and preamble:
        chunks[0]["html"] = "".join(preamble) + chunks[0]["html"]  # 前导并入首章
    out: list[dict] = []  # 短小节并入前章：内容零丢失（不做丢弃式过滤）
    for c in chunks:
        if out and PLAIN(c["html"]) < 120:
            out[-1]["html"] += c["html"]
        else:
            out.append(c)
    chunks = out
    if len(chunks) < 2 or sum(PLAIN(c["html"]) for c in chunks) < PLAIN(html) * 0.5:
        return chs, "h1"  # 编号段切不开/覆盖率不足一半→回退母本单块语义
    for i, c in enumerate(chunks):
        c["id"] = f"ch{i + 1:02d}"
    return chunks, "strong"


def pick_trial(sizes: list) -> int:
    """默认 2 章；按占比带 [15%,25%] 自适应（必须留 ≥1 付费章）；无解取最贴近带者"""
    total, n_ch = sum(sizes), len(sizes)
    if n_ch <= 1 or total == 0:
        return min(TRIAL_DEFAULT, n_ch)
    in_band = [n for n in range(1, n_ch)
               if TRIAL_BAND[0] <= sum(sizes[:n]) / total <= TRIAL_BAND[1]]
    if in_band:
        return min(in_band, key=lambda n: abs(n - TRIAL_DEFAULT))
    lo, hi = TRIAL_BAND
    return min(range(1, n_ch), key=lambda n: min(
        abs(lo - sum(sizes[:n]) / total), abs(sum(sizes[:n]) / total - hi)))


def _keywords(chapters: list, n_trial: int) -> list:
    """付费章抽 3 条 30 字指纹（避开试读文本），供 --verify 包内零命中断言"""
    trial_text = "".join(re.sub(r"<[^>]+>", "", c["html"]) for c in chapters[:n_trial])
    kws = []
    for c in chapters[n_trial:]:
        text = re.sub(r"<[^>]+>", "", c["html"])
        for start in (150, 800, 2000):
            k = re.sub(r"\s", "", text[start:start + 40])
            if len(k) >= 20 and k not in trial_text:
                kws.append(k)
                break
        if len(kws) >= 3:
            break
    return kws


def merge_catalog(entry: dict, *, force: bool = False) -> None:
    path = cp.CONTENT / "catalog.json"
    catalog = json.loads(path.read_text(encoding="utf-8")) if path.exists() else {"reports": []}
    reports = catalog["reports"]
    old = next((r for r in reports if r["id"] == entry["id"]), None)
    if old and not force:
        entry = {**entry, "publishedAt": old.get("publishedAt", entry["publishedAt"])}  # 常驻稳定：不刷新已上架日期
    catalog["reports"] = [entry if r["id"] == entry["id"] else r for r in reports]
    if old is None:
        catalog["reports"].append(entry)
    path.write_text(json.dumps(catalog, ensure_ascii=False, indent=2), encoding="utf-8")


def _valid_existing(slug: str) -> bool:
    ch_json = cp.CONTENT / "reports" / slug / "chapters.json"
    bmeta = XY_BUILD / f"{slug}.json"
    if not all(p.exists() for p in (ch_json, bmeta)) :
        return False
    if not all((XY_PDF / slug / n).exists() for n in ("read.pdf", "print.pdf", "trial.pdf")):
        return False
    try:
        chs = json.loads(ch_json.read_text(encoding="utf-8"))
        n = json.loads(bmeta.read_text(encoding="utf-8"))["trial_chapters"]
        return bool(chs) and all(c["html"] == "" for c in chs[n:])
    except Exception:
        return False


def build_one(item: dict, *, force: bool, max_mb: float) -> dict:
    slug, docx = item["slug"], item["path"]
    if not force and _valid_existing(slug):  # 幂等跳过=增量上架机制
        bmeta = json.loads((XY_BUILD / f"{slug}.json").read_text(encoding="utf-8"))
        cat_path = cp.CONTENT / "catalog.json"
        try:
            ids = {r["id"] for r in json.loads(cat_path.read_text(encoding="utf-8"))["reports"]}
        except Exception:
            ids = set()
        if slug not in ids:
            merge_catalog(bmeta["catalog_entry"])  # 修复型补录（不动已有条目）
        return {"slug": slug, "status": "skipped-existing", **{k: bmeta[k] for k in ("chapter_count", "trial_chapters", "ratio_pct")}}

    with open(docx, "rb") as fh:
        html = mammoth.convert_to_html(fh).value
    chapters, splitter = split_ex(html)
    sizes = [PLAIN(c["html"]) for c in chapters]
    total = sum(sizes) or 1
    n = pick_trial(sizes)
    ratio = sum(sizes[:n]) / total
    out_dir = cp.CONTENT / "reports" / slug
    out_dir.mkdir(parents=True, exist_ok=True)
    (out_dir / "chapters.json").write_text(json.dumps(  # 付费章空壳（防包内泄漏）；键序对齐试点产物
        [{"title": c["title"], "html": c["html"] if i < n else "", "id": c["id"]} for i, c in enumerate(chapters)],
        ensure_ascii=False, indent=1), encoding="utf-8")
    cfu.write_full(slug, chapters)  # 付费正文全集（B 线契约：同章数据复用，不重切不重解析）
    cex.build_one(slug, chapters=chapters, province=item["province"], force=force)  # 商机卡自动携带（新报告零手工）

    stamps = {"watermark": f"总包学园 · {date.today().isoformat()}"}
    pdf_dir = XY_PDF / slug
    TMP.mkdir(parents=True, exist_ok=True)
    bodies = {"trial": "".join(c["html"] for c in chapters[:n]), "full": "".join(c["html"] for c in chapters)}
    for name in ("trial", "full"):
        hp = TMP / f"{slug}-{name}.html"
        hp.write_text(cp.HTML_SHELL.format(body=bodies[name], **stamps), encoding="utf-8")
    cp.render_pdf(TMP / f"{slug}-trial.html", pdf_dir / "trial.pdf")
    raw = TMP / f"{slug}-full-raw.pdf"
    cp.render_pdf(TMP / f"{slug}-full.html", raw)
    pdf_stats = pdf_compress.compress_pair(raw, pdf_dir, {"max_mb": max_mb})  # read 110dpi / print 150dpi
    pdf_stats["trial_mb"] = pdf_compress.destruct_light(pdf_dir / "trial.pdf")  # 试读版同样去结构树
    raw.unlink()

    blob = item["file"] + "".join(c["title"] for c in chapters[:3]) + chapters[0]["html"][:2000]
    industry = "水利工程" if re.search(r"水利|水务", blob) else ""
    tags = cfu.make_tags(item["title"], item["province"], industry, item["owner_type"])
    entry = {"id": slug, "title": item["title"],
             "summary": f"{item['title']}——总包创研院出品。", "price": PRICE_FEN,
             "chapterCount": len(chapters), "trialChapterCount": n,
             "province": item["province"], "industry": industry, "ownerType": item["owner_type"],
             "tags": tags, "source": "总包创研院", "publishedAt": date.today().isoformat()}
    merge_catalog(entry, force=force)
    bmeta = {"slug": slug, "file": item["file"], "splitter": splitter,
             "chapter_count": len(chapters), "trial_chapters": n, "trial_chars": sum(sizes[:n]),
             "full_chars": sum(sizes), "ratio_pct": round(ratio * 100, 1),
             "keywords": _keywords(chapters, n), "pdfs": pdf_stats, "catalog_entry": entry,
             "built_at": date.today().isoformat()}
    XY_BUILD.mkdir(parents=True, exist_ok=True)
    (XY_BUILD / f"{slug}.json").write_text(json.dumps(bmeta, ensure_ascii=False, indent=1), encoding="utf-8")
    return {"slug": slug, "status": "built", "splitter": splitter, "chapters": len(chapters),
            "n_trial": n, "ratio_pct": round(ratio * 100, 1),
            "read_mb": pdf_stats["read.pdf"]["mb"], "print_mb": pdf_stats["print.pdf"]["mb"],
            "src_mb": pdf_stats["src_mb"], "pages": pdf_stats["pages"]}


def backfill_one(item: dict, *, force: bool = False) -> dict:
    """已 built slug 补产 chapters_full.json + catalog tags（不重跑 Edge/PDF，只重解析 docx）"""
    slug = item["slug"]
    ch_json = cp.CONTENT / "reports" / slug / "chapters.json"
    bmeta_path = XY_BUILD / f"{slug}.json"
    full_json = cfu.XY_CONTENT / "reports" / slug / "chapters_full.json"
    if not (ch_json.exists() and bmeta_path.exists()):
        return {"slug": slug, "status": "not-built"}
    if full_json.exists() and not force:
        return {"slug": slug, "status": "skipped-existing"}
    packed = json.loads(ch_json.read_text(encoding="utf-8"))
    with open(item["path"], "rb") as fh:
        chapters, _ = split_ex(mammoth.convert_to_html(fh).value)
    if not cfu.packed_match(chapters, packed):
        return {"slug": slug, "status": "mismatch",
                "error": "补产切章与包内 chapters.json 不一致（docx 疑似变更），拒绝落盘"}
    dst = cfu.write_full(slug, chapters)
    bmeta = json.loads(bmeta_path.read_text(encoding="utf-8"))
    entry = bmeta["catalog_entry"]
    entry["tags"] = cfu.make_tags(item["title"], entry.get("province", ""),
                                  entry.get("industry", ""), item["owner_type"])
    merge_catalog(entry)  # 保 publishedAt（常驻稳定语义）
    bmeta["catalog_entry"] = entry
    bmeta_path.write_text(json.dumps(bmeta, ensure_ascii=False, indent=1), encoding="utf-8")
    return {"slug": slug, "status": "backfilled", "chapters": len(chapters),
            "full_mb": round(dst.stat().st_size / 1024 / 1024, 2)}

def worklist(reports_dir: Path) -> tuple[list, dict]:
    files = sorted(p.name for p in reports_dir.glob("*.docx") if not p.name.startswith("~$"))
    skipped = {}
    for keep, drop, reason in DEDUP_PAIRS:
        if keep in files and drop in files:
            skipped[drop] = {"keeper": keep, "reason": reason}
    seen = {}
    entries = []
    for f in files:
        if f in skipped:
            continue
        meta = META.get(f) or infer_meta(f)
        slug = meta["slug"] if meta["slug"] not in seen else f"{meta['slug']}-{len(seen[meta['slug']]) + 1}"
        seen.setdefault(meta["slug"], []).append(f)
        entries.append({"file": f, "path": reports_dir / f, **meta, "slug": slug})
    return entries, skipped


def cards_backfill_one(item: dict, *, force: bool = False) -> dict:
    """波3a：已 built slug 补产 content/cards/{slug}.json（母本=chapters_full.json，不重解析 docx）"""
    slug = item["slug"]
    mother = cex.XY_CONTENT / "reports" / slug / "chapters_full.json"
    if not (mother.exists() and (XY_BUILD / f"{slug}.json").exists()):
        return {"slug": slug, "status": "not-built"}
    return cex.build_one(slug, province=item["province"], force=force)


def run_cards_only(args, entries: list) -> int:
    """波3a --cards-only 模式：商机卡抽取/回填（幂等跳过已有，--force 重抽）"""
    pool = [e for e in entries if not args.only or e["slug"] in args.only]
    if args.limit:
        pool = pool[: args.limit]
    results = []
    for i, e in enumerate(pool, 1):
        print(f"[cards {i}/{len(pool)}] {e['slug']}", flush=True)
        try:
            r = cards_backfill_one(e, force=args.force)
        except Exception as exc:
            r = {"slug": e["slug"], "status": "failed", "error": str(exc)[:200]}
            print("  FAIL:", exc, flush=True)
        results.append(r)
        if r.get("cards") is not None:
            print(f"  → {r['status']} cards={r['cards']}", flush=True)
    tally: dict = {}
    for r in results:
        tally[r["status"]] = tally.get(r["status"], 0) + 1
    print(json.dumps(tally, ensure_ascii=False))
    bad = [r for r in results if r["status"] in ("failed", "mismatch", "no-mother", "not-built")]
    return 1 if bad else 0


def verify(slugs: list | None, max_mb: float) -> int:
    import pypdf
    manifest = json.loads((XY / "manifest.json").read_text(encoding="utf-8"))["list"]
    catalog = json.loads((cp.CONTENT / "catalog.json").read_text(encoding="utf-8"))["reports"]
    by_id = {r["id"]: r for r in catalog}
    fails = []
    print(f"[verify] 上架清单 {len(manifest)} 条 / catalog {len(catalog)} 条")
    for m in manifest:
        if slugs and m["slug"] not in slugs:
            continue
        e = by_id.get(m["slug"])
        if not e:
            fails.append(f"{m['slug']}: catalog 缺条目")
            continue
        if e["price"] != PRICE_FEN:
            fails.append(f"{m['slug']}: price={e['price']}≠{PRICE_FEN}")
        if "trialChapterCount" not in e:
            fails.append(f"{m['slug']}: 缺 trialChapterCount")
    extras = [r["id"] for r in catalog if r["id"] not in {m["slug"] for m in manifest}]
    if extras:
        fails.append(f"catalog 越位条目（不在清单）: {extras}")
    produced = [m["slug"] for m in manifest
                if (not slugs or m["slug"] in slugs) and (XY_BUILD / f"{m['slug']}.json").exists()]
    out_band, sample_hits = [], []
    for slug in produced:
        b = json.loads((XY_BUILD / f"{slug}.json").read_text(encoding="utf-8"))
        if not (TRIAL_BAND[0] * 100 <= b["ratio_pct"] <= TRIAL_BAND[1] * 100):
            out_band.append(f"{slug}: {b['ratio_pct']}%")
        chs = json.loads((cp.CONTENT / "reports" / slug / "chapters.json").read_text(encoding="utf-8"))
        if any(c["html"] != "" for c in chs[b["trial_chapters"]:]):
            fails.append(f"{slug}: 付费章 html 非空")
        for pdf in ("read.pdf", "print.pdf"):
            p = XY_PDF / slug / pdf
            if not p.exists():
                fails.append(f"{slug}: 缺 {pdf}")
                continue
            mb = round(p.stat().st_size / 1024 / 1024, 2)
            if mb > max_mb:
                fails.append(f"{slug}/{pdf}: {mb}MB>{max_mb}MB")
            pypdf.PdfReader(str(p))  # 独立解析器可打开断言
    if len(by_id) != len(manifest):
        print(f"  [warn] catalog 条数 {len(by_id)} ≠ 清单 {len(manifest)}（未全量产出前属预期，不判 FAIL）")
    for slug in sorted(produced)[:3]:  # 抽 3 份解包验证空壳：付费指纹在包内零命中
        b = json.loads((XY_BUILD / f"{slug}.json").read_text(encoding="utf-8"))
        text = (cp.CONTENT / "reports" / slug / "chapters.json").read_text(encoding="utf-8")
        hits = [k[:16] for k in b["keywords"] if k in text]
        if hits:
            fails.append(f"{slug}: 包内命中付费指纹 {hits}")
        else:
            sample_hits.append(slug)
    print(f"[verify] 已产出 {len(produced)} 份；占比越带 {len(out_band)} 份 {out_band[:6]}；"
          f"空壳抽验 {sample_hits} 全零命中")
    for f in fails:
        print("  FAIL:", f)
    print("[verify]", "PASS" if not fails else f"FAIL×{len(fails)}")
    return 1 if fails else 0


def main() -> None:
    ap = argparse.ArgumentParser()
    ap.add_argument("--dry-run", action="store_true")
    ap.add_argument("--only", default="")
    ap.add_argument("--limit", type=int, default=0)
    ap.add_argument("--force", action="store_true")
    ap.add_argument("--verify", action="store_true")
    ap.add_argument("--chapters-only", action="store_true",
                    help="只补产 chapters_full.json+tags（限已 built slug，不碰 PDF）")
    ap.add_argument("--cards-only", action="store_true",
                    help="只补产 content/cards/{slug}.json 商机卡（波3a，母本 chapters_full）")
    ap.add_argument("--max-mb", type=float, default=pdf_compress.CONFIG["max_mb"])
    ap.add_argument("--reports-dir", default=str(REPORTS_DIR))
    args = ap.parse_args()
    entries, skipped = worklist(Path(args.reports_dir))
    manifest = [{"slug": e["slug"], "file": e["file"], "title": e["title"],
                 "province": e["province"], "owner_type": e["owner_type"],
                 "auto_slug": e.get("auto", False)} for e in entries]
    XY.mkdir(parents=True, exist_ok=True)
    (XY / "manifest.json").write_text(json.dumps(
        {"generated": date.today().isoformat(), "dedup_skipped": skipped, "list": manifest},
        ensure_ascii=False, indent=1), encoding="utf-8")
    print(f"[list] docx {len(entries) + len(skipped)} 份 → 去重跳过 {len(skipped)} 份 → 上架清单 {len(entries)} 份")
    for drop, info in skipped.items():
        print(f"  [dedup] {drop} → 保留 {info['keeper']}（{info['reason']}）")

    if args.verify:
        sys.exit(verify([s for s in args.only.split(",") if s] or None, args.max_mb))
    if args.chapters_only:  # 补产模式：对象=已 built（须绕开下方"剔已产出"增量过滤器）
        pool = [e for e in entries if not args.only or e["slug"] in args.only]
        if args.limit:
            pool = pool[: args.limit]
        results = []
        for i, e in enumerate(pool, 1):
            print(f"[cf {i}/{len(pool)}] {e['slug']}", flush=True)
            try:
                results.append(backfill_one(e, force=args.force))
            except Exception as exc:
                results.append({"slug": e["slug"], "status": "failed", "error": str(exc)[:200]})
                print("  FAIL:", exc, flush=True)
        bad = [r for r in results if r["status"] in ("failed", "mismatch")]
        tally = {}
        for r in results:
            tally[r["status"]] = tally.get(r["status"], 0) + 1
        print(json.dumps(tally, ensure_ascii=False))
        sys.exit(1 if bad else 0)
    if args.cards_only:  # 波3a：商机卡模式（母本旁挂，不碰 PDF/章数据）
        sys.exit(run_cards_only(args, entries))
    todo = entries
    if args.only:
        want = {s for s in args.only.split(",") if s}
        todo = [e for e in entries if e["slug"] in want]
        missing = want - {e["slug"] for e in todo}
        if missing:
            sys.exit(f"[error] 未知 slug: {missing}（可用: {[e['slug'] for e in entries]}）")
    if not args.force:  # 增量语义：先剔已产出（=已上架跳过，日常增量只处理新 docx）
        requested = len(todo)
        todo = [e for e in todo if not _valid_existing(e["slug"])]
        skipped_count = requested - len(todo)
    else:
        skipped_count = 0
    if args.limit:
        todo = todo[: args.limit]
    if args.dry_run:
        for e in todo:
            print(f"  [todo] {e['slug']:32s} {e['file']}")
        print(f"[dry-run] 待产出 {len(todo)} 份（--force 可全量重跑）")
        return
    results = []
    for i, e in enumerate(todo, 1):
        print(f"[{i}/{len(todo)}] {e['slug']} ← {e['file']}", flush=True)
        try:
            results.append(build_one(e, force=args.force, max_mb=args.max_mb))
        except Exception as exc:
            results.append({"slug": e["slug"], "status": "failed", "error": str(exc)[:200]})
            print("  FAIL:", exc, flush=True)
    ok = [r for r in results if r["status"] in ("built", "skipped-existing")]
    print(json.dumps({"built": len([r for r in results if r['status'] == 'built']),
                      "skipped": skipped_count + len([r for r in results if r['status'] == 'skipped-existing']),
                      "failed": len(results) - len(ok)}, ensure_ascii=False))
    sys.exit(0 if len(ok) == len(results) else 1)


if __name__ == "__main__":
    sys.stdout.reconfigure(encoding="utf-8")
    main()
