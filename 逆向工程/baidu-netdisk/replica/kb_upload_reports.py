# -*- coding: utf-8 -*-
"""kb_upload_reports.py — 91 SKU 研报全量入库 64 库（P1.5 首批，100× 内容工程）。
来源 report_platform/content/full（97 件正式 PDF，335MB）→
64. 总包研究成果库/11 总包智库独家研报全量/（SKU_标题.pdf）
+ 00 研报总目录（SKU↔标题↔定价 双向检索）。
幂等：远端同名跳过（上传前 list 预检）。
"""
import sys, os, re, json, time, datetime

if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from bdncore import BdnApi, BdnSession, RoutedApi, BdnApiError
from bdncore.transfer import UploadEngine

api = RoutedApi(BdnApi(BdnSession()))
SRC = r"E:\AI-Station\report_platform\content\full"
DST = "/超级总包知识库（动态更新）/64. 总包研究成果库/11 总包智库独家研报全量"
RJ = r"E:\AI-Station\report_platform\content\report.json"

BAD = '\\/:*?"<>|'


def sanitize(s):
    return "".join("-" if c in BAD else c for c in s).strip()


def main():
    rep = json.load(open(RJ, encoding="utf-8"))["reports"]
    by_sku = {r["sku"]: r for r in rep}
    # 建目录（幂等）
    try:
        api.mkdir(DST)
        print(f"mkdir ok: {DST}")
    except BdnApiError as e:
        print(f"mkdir: {e}")
    time.sleep(0.5)

    # 已存在预检
    try:
        have = {x["name"] for x in (api.list_dir(DST).get("entries") or [])}
    except BdnApiError:
        have = set()

    pdfs = sorted(f for f in os.listdir(SRC) if f.lower().endswith(".pdf"))
    print(f"本地 {len(pdfs)} 件 · 远端已有 {len(have)} 件")
    eng = UploadEngine(api)
    ok = skip = fail = 0
    fails = []
    t0 = time.time()
    try:
        for i, fn in enumerate(pdfs, 1):
            sku = fn[:-4]
            r = by_sku.get(sku)
            title = sanitize((r.get("title") or "").strip("《》")) if r else ""
            out = f"{sku}_{title}.pdf" if title else fn
            if out in have:
                skip += 1
                continue
            local = os.path.join(SRC, fn)
            for attempt in (1, 2, 3):
                try:
                    eng.upload(local, f"{DST}/{out}", rtype=3)
                    ok += 1
                    break
                except BdnApiError as e:
                    if attempt == 3:
                        fail += 1
                        fails.append((fn, str(e)[:90]))
                        print(f"  ✗ [{i}] {fn} — {str(e)[:90]}")
                    else:
                        time.sleep(2 * attempt)
            if i % 10 == 0:
                print(f"[{i}/{len(pdfs)}] ok {ok} skip {skip} fail {fail} · {time.time()-t0:.0f}s", flush=True)
            time.sleep(0.4)
    finally:
        eng.close()

    # 总目录文件（SKU↔标题↔价格 双向检索）
    lines = ["# 总包智库独家研报全量目录（91 SKU）", "",
             f"> 生成 {datetime.date.today()} · 来源：总包智库研究团队 · 全部为正式出版版本",
             "", "| SKU | 报告名称 | 定价 | 说明 |", "|---|---|---|---|"]
    for r in rep:
        lines.append(f"| {r['sku']} | {r.get('title','')} | ¥{r.get('price')} | {(r.get('subtitle') or '')[:60]} |")
    lines += ["", "## 按名称检索", ""]
    for r in sorted(rep, key=lambda x: x.get("title", "")):
        lines.append(f"- {r.get('title','')} → {r['sku']}")
    cat_local = os.path.join(os.path.dirname(os.path.abspath(__file__)), "_kb_build", "64_sku_catalog.md")
    open(cat_local, "w", encoding="utf-8").write("\n".join(lines))
    try:
        eng.upload(cat_local, f"{DST}/00 研报总目录_91SKU.md", rtype=3)
        ok += 1
        print("目录文件已上传")
    except BdnApiError as e:
        fail += 1
        fails.append(("catalog", str(e)[:90]))
    print(f"\n完成: ok {ok} skip {skip} fail {fail} · {time.time()-t0:.0f}s")
    for f in fails:
        print("  FAIL:", f[0], f[1])


if __name__ == "__main__":
    main()
