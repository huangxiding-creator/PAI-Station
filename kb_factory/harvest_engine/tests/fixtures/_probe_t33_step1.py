# -*- coding: utf-8 -*-
"""T33 取样探针①：三份 GT 样本首页图拉取落档（tests/fixtures/book118_gt_pages/）。

样本=已落档两件（6115103231005025 免费/5110103104004213 62页收费）+T19 fixtures 活跃档
（5134312044001323，test_book118_preview.py 台账样本）。链=Playwright .shtm 首跳（SafeLine）
→fetch_ladder 页清单→首页 URL 图直下（httpx trust_env=False，魔数真身扩展名）。
产出：{doc}/0001.{gif|png}+每份 print 实测（页图字节/尺寸/清单页数）。
"""
import sys
from pathlib import Path

_FIX = Path(__file__).resolve().parent
sys.path.insert(0, str(_FIX.parents[3]))     # 仓库根（kb_factory.* namespace 正名链）
sys.path.insert(1, str(_FIX.parents[2]))     # kb_factory/（worktree 阶段顶层名回退链）

import httpx  # noqa: E402
from PIL import Image  # noqa: E402

from channel_adapters.base import FileMeta  # type: ignore
from harvest_engine.adapters.book118 import Book118Adapter, image_url_pair  # type: ignore
from harvest_engine.assets.magic_check import sniff_format  # type: ignore

DOCS = [
    ("6115103231005025", "https://max.book118.com/html/2022/1214/6115103231005025.shtm",
     "某培训学院教学督导制度.docx"),
    ("5110103104004213", "https://max.book118.com/html/2022/0414/5110103104004213.shtm",
     "煤炭设备项目投标报告（煤炭参考）.docx"),
    ("5123021331010032", "https://max.book118.com/html/2022/1214/5123021331010032.shtm",
     ""),  # T19 fixtures 留档推荐档（_probe_t19_shtm_playwright.html 同目录链接；标题取样时实测誊录）
]
OUT_ROOT = _FIX / "book118_gt_pages"

UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
      "(KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36")


def pull_first_page(browser, doc_id: str, url: str, title: str, http: httpx.Client) -> dict:
    adapter = Book118Adapter(browser=browser)
    meta = FileMeta(title=title, fmt="doc", source_url=url, extra={})
    ladder = adapter.fetch_ladder(adapter.plan(meta))
    facts = {"doc": doc_id, "ladder_ok": ladder.ok, "ladder_detail": ladder.detail[:160]}
    if not ladder.ok:
        return facts
    urls = meta.extra["book118_page_urls"]
    page1 = urls.get(1) or urls.get("1")
    if not page1:
        facts["err"] = f"页清单无第1页: keys={sorted(urls)[:5]}"
        return facts
    https_u, http_u = image_url_pair(page1)
    body, status, scheme = b"", 0, ""
    for target, sch in ((https_u, "https"), (http_u, "http")):
        r = http.get(target)
        status, body, scheme = r.status_code, r.content, sch
        if status == 200 and body:
            break
    if status != 200 or not body:
        facts["err"] = f"首页图直下失败 status={status} bytes={len(body)}"
        return facts
    fmt = sniff_format(body)
    facts.update(scheme=scheme, magic=fmt, byte_len=len(body))
    if fmt not in ("gif", "png"):
        facts["err"] = f"魔数词表外: {fmt!r}"
        return facts
    out_dir = OUT_ROOT / doc_id
    out_dir.mkdir(parents=True, exist_ok=True)
    path = out_dir / f"0001.{fmt}"
    path.write_bytes(body)
    with Image.open(path) as im:
        facts["size"] = im.size
    facts["path"] = str(path)
    facts["pages_preview"] = meta.extra.get("book118_pages_preview")
    facts["pages_actual"] = meta.extra.get("book118_pages_actual")
    facts["shtm_title"] = meta.title
    return facts


def main() -> None:
    from playwright.sync_api import sync_playwright
    out = []
    with sync_playwright() as pw:
        browser = pw.chromium.launch(headless=True, args=["--proxy-server=direct://"])
        try:
            with httpx.Client(timeout=30.0, trust_env=False,
                              headers={"User-Agent": UA}) as http:
                for doc_id, url, title in DOCS:
                    try:
                        facts = pull_first_page(browser, doc_id, url, title, http)
                    except Exception as exc:  # 如实记账（探针不吞形态）
                        facts = {"doc": doc_id, "err": f"{type(exc).__name__}: {exc}"}
                    out.append(facts)
                    print(facts, flush=True)
        finally:
            browser.close()
    (OUT_ROOT / "_pull_facts.json").write_text(
        __import__("json").dumps(out, ensure_ascii=False, indent=1), encoding="utf-8")


if __name__ == "__main__":
    main()
