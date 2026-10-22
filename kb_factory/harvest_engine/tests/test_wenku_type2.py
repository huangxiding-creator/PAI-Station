# -*- coding: utf-8 -*-
"""T31 单测：wenku 类型2 重组（纯图片 renderImageHtml）+ 注记#5 字数参照定义（OCR 文字层）。

被测物 = kb_factory.harvest_engine.adapters.wenku 的 T31 增量段（T18/T22/T26 已锁契约
只增不改；占位钉 T31 本任务兑现，T35 类型1 半的「T26/T31/T35」组字样保留）：
- 类型2 页几何缺省 **2400×1500**（§5.1/W:834 类型2 专属缺省；类型3 缺省 892×1262 不混用），
  pageInfo 在场优先（parseFloat 语义，实弹为字符串小数）；
- 图片腿（§5.2 数组消费+§9「可纯 httpx」）：htmlUrls 数组经 html_urls_to_pages（T22 真符号，
  pn= 索引去重）→ 页号升序逐页 GET（UA+Referer wenku+Cookie）→ judge_page_png 四步链
  （assets/magic_check 真符号：>200B/PNG 魔数/IHDR/占位图<2KB 丢弃）→ 幸存 data URI 内嵌；
- 重组 HTML（§7.3 renderImageHtml 逐字 CSS：body margin:0 / .page 宽高=pageInfo +
  page-break-after:always + overflow:hidden / img 100%×100% + display:block +
  object-fit:contain / @page size=pageInfo margin:0）→ html_to_pdf（printToPDF，
  页几何权威=@page）→ pypdfium2 实测逐页尺寸==pageInfo px→pt（FR2.AC2 验收口径）；
- **注记#5（SPEC_REVIEW 残留#5 落地）**：类型2 字数参照=OCR 文字层实测（产物=render/ocr
  二级管线回注的 searchable PDF；manifest ref_chars_source="type2"——quality_gate 五型
  词表之 type2，词义钉死「wenku 类型2=OCR 全文」，**不走 pageJson**）；manifest+质检门
  四门真跑（全量=expected_pages / 占位图丢弃致页缺=preview_limit 部分收割合法形态）；
- 类型判定记 ledger（recon_dispatch branch=type2 + recon_type2 + quality_gate）。

现场校准（2026-10-22 实弹探针，证据=fixtures/_t31_probe_type2.json：24 候选 8 探全 type3）：
- 今日站方检索面已全量 html_view 化，真类型2 寻件困难 → 实弹走任务卡明示的**合成口径**
  （live readerInfo + 真实 wenku CDN 图直链组 htmlUrls 数组，网络腿打真实图 URL，口径如实
  记录）；判型逻辑（Array.isArray(htmlUrls)&&length>0）与全链重组均为真件实测。

测试纪律（WORKER_CONVENTIONS）：
- 离线单测零网络：图片腿经 asset_fetch 注入点（网络腿，任务卡明示）；初始腿经 fetch_html
  注入点（T22 同缝）；OCR 子系统经 ocr_fn 注入点（T23/book118 同缝：render_pages+
  build_searchable_pdf 真件+确定性行集，paddle 引擎属 T13 边界）；打印腿=本地 Chromium
  加载本地 HTML（file:// 零网络）。
- 实弹用例（@pytest.mark.live）=真实网络 zero-mock；KB_HARVEST_SKIP_LIVE=1 时跳过
  （跳过时明示）。Playwright sync API 不可嵌套：打印腿在无外层 sync 上下文时执行。
"""
import io
import json
import os
import re
import sys
import time
from pathlib import Path

import pytest

_KB_DIR = Path(__file__).resolve().parents[2]  # kb_factory/
sys.path.insert(0, str(_KB_DIR))  # worktree 阶段 kb_factory 无 __init__.py：顶层导入 harvest_engine
if not (_KB_DIR / "channel_adapters" / "base.py").exists():
    for _anc in _KB_DIR.parents:  # worker worktree：channel_adapters 只读复用主仓真身
        if (_anc / "kb_factory" / "channel_adapters" / "base.py").exists():
            sys.path.insert(1, str(_anc))
            break

try:  # 合并后正名 kb_factory.harvest_engine.*；worktree 阶段回退顶层名
    from kb_factory.channel_adapters.base import FileMeta
    from kb_factory.harvest_engine.adapters.base import LadderResult
    from kb_factory.harvest_engine.adapters.wenku import (ReaderInfoLegResult,
                                                          Type2Page,
                                                          WenkuDownloadAdapter,
                                                          fetch_type2_images,
                                                          judge_doc_type,
                                                          render_image_html,
                                                          type2_page_dims)
    from kb_factory.harvest_engine.audit import HarvestAudit
    from kb_factory.harvest_engine.pdf.html_print_pdf import PX_PER_PT_CSS
    from kb_factory.harvest_engine.quality_gate import REF_CHARS_SOURCE_DESC
    from kb_factory.harvest_engine.render.ocr import (DEFAULT_DPI, OcrLine,
                                                      build_searchable_pdf,
                                                      render_pages)
except ImportError:
    from channel_adapters.base import FileMeta
    from harvest_engine.adapters.base import LadderResult
    from harvest_engine.adapters.wenku import (ReaderInfoLegResult, Type2Page,
                                               WenkuDownloadAdapter,
                                               fetch_type2_images, judge_doc_type,
                                               render_image_html, type2_page_dims)
    from harvest_engine.audit import HarvestAudit
    from harvest_engine.pdf.html_print_pdf import PX_PER_PT_CSS
    from harvest_engine.quality_gate import REF_CHARS_SOURCE_DESC
    from harvest_engine.render.ocr import (DEFAULT_DPI, OcrLine,
                                           build_searchable_pdf, render_pages)

import pypdfium2 as pdfium  # noqa: E402  （NFR6：pypdfium2 实测，禁 fitz）
from PIL import Image, ImageDraw  # noqa: E402

_LIVE_SKIP = os.environ.get("KB_HARVEST_SKIP_LIVE") == "1"
DOC_ID = "5f31c0de11a1b2c3d4e5f60718293a4b5c6d7e8f"  # 40 位 hex 合成 docId（形态=新式实测）
TYPE2_DEF_W, TYPE2_DEF_H = 2400.0, 1500.0            # §5.1/W:834 类型2 缺省
DEF_W_PT, DEF_H_PT = TYPE2_DEF_W / PX_PER_PT_CSS, TYPE2_DEF_H / PX_PER_PT_CSS  # 1800×1125pt
PAGE_W_STR, PAGE_H_STR = "600.5", "400.25"           # pageInfo 在场形态（字符串小数）
PAGE_W, PAGE_H = 600.5, 400.25
PW_PT, PH_PT = PAGE_W / PX_PER_PT_CSS, PAGE_H / PX_PER_PT_CSS
_TOL_PT = 0.6


# ---------------- fixture 工厂（实弹形态校准） ----------------

def _img_url(pn: int) -> str:
    """类型2 图片直链形态（含 pn= 页号，§3.2 去重键来源；wkbitmap=类型2 实测图床域）。"""
    return f"https://wkbitmap.bdimg.com/thumbnails/{DOC_ID}?pn={pn}&s=1&r=0.1"


def _png_bytes(w: int, h: int) -> bytes:
    """白底+左上墨块 PNG（魔数自证；ink 带内形态=白页少量油墨，供质检门③真跑）。"""
    im = Image.new("RGB", (w, h), (255, 255, 255))
    ImageDraw.Draw(im).rectangle([2, 2, max(4, w // 3), max(4, h // 8)], fill=(10, 10, 10))
    buf = io.BytesIO()
    im.save(buf, format="PNG")
    return buf.getvalue()


def _placeholder_png(width: int, height: int) -> bytes:
    """占位图（魔数+IHDR 宽高+填充凑字节<2048B；§6.6 第④步丢弃形态）。"""
    return (b"\x89PNG\r\n\x1a\n" + (13).to_bytes(4, "big") + b"IHDR"
            + width.to_bytes(4, "big") + height.to_bytes(4, "big")
            + b"\x08\x05\x00\x00\x00" + b"\x00\x00\x00\x00" + b"\x7f" * 300)


def _gif89a_bytes(w: int, h: int) -> bytes:
    """GIF89a（魔数伪装形态：.png URL 实为 GIF 的实锤同型，R16）。"""
    im = Image.new("RGB", (w, h), (255, 255, 255))
    ImageDraw.Draw(im).rectangle([2, 2, max(4, w // 3), max(4, h // 8)], fill=(10, 10, 10))
    buf = io.BytesIO()
    im.quantize(colors=64).save(buf, format="GIF", transparency=2)
    data = buf.getvalue()
    assert data.startswith(b"GIF89a")
    return data


def _type2_reader_info(urls, page=None, show=None, page_info=None) -> dict:
    n = page if page is not None else len(urls)
    ri = {"showPage": show if show is not None else n, "page": n, "tplKey": "normal",
          "htmlUrls": list(urls)}
    if page_info is not None:
        ri["pageInfo"] = page_info
    return ri


def _ndview_html(page_data: dict) -> str:
    return ("<html><head><meta charset='utf-8'></head><body><script>\n"
            "var pageData = " + json.dumps(page_data, ensure_ascii=False) + ";\n"
            "</script></body></html>")


def _asset_fetch_spy(calls, blobs: dict, *, status_by_pn=None):
    """图片腿网络注入点（任务卡明示）：按 URL 记录 (url,binary,headers) 并按 pn= 应答。"""
    def fetch(url, headers, timeout, *, binary=False):
        calls.append({"url": url, "binary": binary, "headers": dict(headers)})
        m = re.search(r"[?&]pn=(\d+)", url)
        pn = int(m.group(1)) if m else -1
        status = (status_by_pn or {}).get(pn, 200)
        if status != 200:
            return status, b""
        data = blobs.get(pn)
        return (200, data) if data is not None else (404, b"")
    return fetch


def _offline_ocr_ref(image_pdf, out_pdf) -> int:
    """离线 OCR 参照（ocr_fn 注入实现）：T13 真件 render_pages+build_searchable_pdf，
    行集换确定性两条（paddle 引擎属 T13 边界）；返回值=stats.chars 实测（勿手填）。"""
    frames = render_pages(image_pdf, dpi=DEFAULT_DPI)
    lines = [[OcrLine("离线参照行甲", 0.99, (2, 2, 90, 18)),
              OcrLine("离线参照行乙", 0.98, (2, 22, 90, 38))]] * len(frames)
    return int(build_searchable_pdf(frames, lines, out_pdf, dpi=DEFAULT_DPI).chars)


_OFFLINE_OCR_CHARS_PER_PAGE = 2 * len("离线参照行甲")  # 每页两行×每行 6 字=12 字（len 实测口径）


def _meta(doc_id=DOC_ID, title="类型2样例-百度文库", pages=1) -> FileMeta:
    return FileMeta(title=title, fmt="doc", pages=pages, perm="green",
                    source_url=f"https://wenku.baidu.com/view/{doc_id}.html",
                    extra={"doc_id": doc_id})


def _audit_lines(path) -> list:
    p = Path(path)
    if not p.exists():
        return []
    return [json.loads(line) for line in p.read_text(encoding="utf-8").splitlines() if line]


def _page_sizes(pdf_path) -> list:
    doc = pdfium.PdfDocument(str(pdf_path))
    try:
        return [(pg.get_width(), pg.get_height()) for pg in doc]
    finally:
        doc.close()


# ---------------- 纯函数：类型2 页几何（§5.1 类型2 专属缺省） ----------------

def test_fr2_ac2_type2_page_dims_default_and_pageinfo():
    """§5.1/W:834：类型2 缺省 2400×1500（非类型3 的 892×1262）；pageInfo 在场优先
    （parseFloat 字符串小数）；坏值回落缺省（数字零造假：不猜）。"""
    assert type2_page_dims({}) == (TYPE2_DEF_W, TYPE2_DEF_H)
    assert type2_page_dims({"pageInfo": {"pageWidth": PAGE_W_STR, "pageHeight": PAGE_H_STR}}) \
        == (PAGE_W, PAGE_H)
    assert type2_page_dims({"pageInfo": {"pageWidth": "", "pageHeight": "x"}}) \
        == (TYPE2_DEF_W, TYPE2_DEF_H)
    assert type2_page_dims(None) == (TYPE2_DEF_W, TYPE2_DEF_H)


# ---------------- 图片腿：魔数四步链 + pn 索引 + 节流 ----------------

def test_fr2_ac2_fetch_type2_images_magic_chain_pn_index_headers():
    """图片腿（§5.2 数组消费+§6.6 四步链+§9 头）：pn= 索引页号升序（无 pn= 项如实不计）；
    合法 PNG 幸存 data URI 内嵌+IHDR 实测宽高；GIF 伪装/404/占位图(<2KB 全幅) 丢弃；
    腿头=UA+Referer wenku（§6.6 png 腿原作口径）+Cookie 在场携带；计数全实测。"""
    urls = ["https://x.bdimg.com/no-pn-here",                       # 无 pn=：不占页号（T22 契约）
            _img_url(10), _img_url(2), _img_url(3), _img_url(4), _img_url(5)]
    blobs = {10: _png_bytes(120, 80),                               # 页10 合法 PNG（幸存）
             2: _gif89a_bytes(120, 80),                             # GIF 伪装 → not_png_magic 弃
             3: _placeholder_png(2200, 1400),                       # 占位图（<2KB 全幅）→ 弃
             4: _png_bytes(100, 60)}                                # 小图幸存
    calls: list = []
    leg = _asset_fetch_spy(calls, blobs, status_by_pn={5: 403})     # 页5 403 → 弃
    assets = fetch_type2_images(_type2_reader_info(urls), asset_fetch=leg, cookie="BDUSS=x",
                                min_interval=0)
    assert [p.p for p in assets.pages] == [4, 10]                   # 页号升序+只收幸存页
    assert assets.pages[0].data_uri.startswith("data:image/png;base64,")
    assert (assets.pages[0].w, assets.pages[0].h) == (100, 60)      # IHDR 实测
    assert assets.pages[0].url == _img_url(4)                       # 原直链留档
    assert assets.stats == {"requests": 5, "img_kept": 2, "img_drop": 3}
    got_pns = [int(re.search(r"[?&]pn=(\d+)", c["url"]).group(1)) for c in calls]
    assert got_pns == [2, 3, 4, 5, 10]                              # 升序逐页（无 pn= 项不发腿）
    for c in calls:
        assert c["binary"] is True
        assert c["headers"]["Referer"] == "https://wenku.baidu.com/"
        assert c["headers"]["User-Agent"] and c["headers"]["Cookie"] == "BDUSS=x"


def test_fr2_ac2_fetch_type2_images_min_interval_paced():
    """腿间节流（§9 速率自律）：min_interval>0 时逐腿 sleep（首腿不睡；注入点计数）。"""
    slept: list = []
    urls = [_img_url(1), _img_url(2), _img_url(3)]
    fetch_type2_images(_type2_reader_info(urls),
                       asset_fetch=_asset_fetch_spy([], {i: _png_bytes(90, 60)
                                                         for i in (1, 2, 3)}),
                       min_interval=0.25, sleep=slept.append)
    assert slept == [0.25, 0.25]                                    # 3 腿：后两腿各 0.25s


# ---------------- 重组 HTML（§7.3 renderImageHtml 逐字 CSS） ----------------

def test_fr2_ac2_render_image_html_spec_css_and_pageinfo_priority():
    """§7.3 逐字 CSS：body margin:0 / .page 宽高=pageInfo（缺省 2400×1500）+
    page-break-after:always+overflow:hidden / last-child auto / img 100%×100%+display:block+
    object-fit:contain / @page size=W×H margin:0；每页 ``<div class="page"><img src="…"/></div>``；
    title 转义；data URI 内嵌（任务卡：逐页下载后重组，打印零网络）。"""
    pages = [Type2Page(p=1, url=_img_url(1), data_uri="data:image/png;base64,QUJD", w=100, h=60),
             Type2Page(p=2, url=_img_url(2), data_uri="data:image/png;base64,RERT", w=100, h=60)]
    html = render_image_html('标题<b>&"\'</b>', {}, pages)          # pageInfo 缺席 → 2400×1500
    assert ("body{margin:0}"
            ".page{page-break-after:always;width:2400px;height:1500px;overflow:hidden}"
            ".page:last-child{page-break-after:auto}"
            "img{width:100%;height:100%;display:block;object-fit:contain}"
            "@page{size:2400px 1500px;margin:0}") in html           # §7.3 原文逐字（:g 数值形态）
    assert html.count('<div class="page"><img src="data:image/png;base64,') == 2
    assert "<title>标题&lt;b&gt;&amp;&quot;&#39;&lt;/b&gt;</title>" in html
    html2 = render_image_html("t", {"pageInfo": {"pageWidth": PAGE_W_STR,
                                                 "pageHeight": PAGE_H_STR}}, pages[:1])
    assert f"width:{PAGE_W:g}px;height:{PAGE_H:g}px;overflow:hidden" in html2  # pageInfo 优先
    assert f"@page{{size:{PAGE_W:g}px {PAGE_H:g}px;margin:0}}" in html2
    assert render_image_html("t", {}, []).endswith("<body></body></html>")     # 零页防御


# ---------------- 段3 全链：分派接线 + printToPDF + 注记#5 ----------------

def test_fr2_ac2_fetch_ladder_type2_default_geometry_full_chain(tmp_path):
    """FR2.AC2 主验收（离线全链，pageInfo 缺席=2400×1500 缺省径）：ndview 初始腿（注入）→
    图片腿（注入，2/2 幸存）→ renderImageHtml → printToPDF → pypdfium2 实测页数==幸存页数、
    逐页尺寸==2400×1500px→1800×1125pt（±0.6pt）；注记#5：chars=ocr_fn 实测（不走 pageJson）
    → manifest ref_chars_source=type2+expected_pages=page → 质检门四门真跑全过；
    ledger 四事件（init/dispatch=type2/recon_type2/quality_gate）；临时 HTML 用毕即删。"""
    ri = _type2_reader_info([_img_url(1), _img_url(2)], page=2, show=2)   # 全免费缺省几何
    fetch_html = lambda url, headers, timeout: (200, _ndview_html({  # noqa: E731
        "title": "类型2样例-百度文库", "readerInfo": ri}))
    calls: list = []
    leg = _asset_fetch_spy(calls, {1: _png_bytes(120, 80), 2: _png_bytes(120, 80)})
    audit_path = tmp_path / "audit.jsonl"
    adapter = WenkuDownloadAdapter(audit=HarvestAudit(path=str(audit_path)))
    result = adapter.fetch_ladder(adapter.plan(_meta(pages=2)), fetch_html=fetch_html,
                                  asset_fetch=leg, out_dir=tmp_path / "out",
                                  asset_min_interval=0, ocr_fn=_offline_ocr_ref)
    assert isinstance(result, LadderResult) and result.ok is True
    assert result.ladder_used == "L1" and result.coverage == "2/2"
    assert result.artifact_path and Path(result.artifact_path).is_file()
    assert result.pages == 2
    expected_chars = 2 * _OFFLINE_OCR_CHARS_PER_PAGE
    assert result.chars == expected_chars                            # 注记#5：OCR 字数（实测）
    for w, h in _page_sizes(result.artifact_path):
        assert abs(w - DEF_W_PT) <= _TOL_PT and abs(h - DEF_H_PT) <= _TOL_PT, (
            f"PDF 页尺寸 {w}x{h}pt != pageInfo 缺省 {DEF_W_PT:g}x{DEF_H_PT:g}pt")
    stem = "类型2样例"
    manifest = json.loads((tmp_path / "out" / f"{stem}_manifest.json").read_text(encoding="utf-8"))
    assert manifest["ref_chars_source"] == "type2"                   # 五型词表之 type2（=OCR 全文）
    assert manifest["ref_chars"] == expected_chars
    assert manifest["expected_pages"] == 2 and "preview_limit" not in manifest
    assert Path(manifest["pdf_path"]).resolve() == Path(result.artifact_path).resolve()
    lines = _audit_lines(audit_path)
    assert [l["event"] for l in lines] == ["readerinfo_init", "recon_dispatch",
                                           "recon_type2", "quality_gate"]
    assert lines[1]["status"] == "type2" and "branch=type2" in lines[1]["detail"]
    assert lines[2]["status"] == "ok" and f"chars={expected_chars}(ocr)" in lines[2]["detail"]
    assert lines[3]["status"] == "ok" and lines[3]["count"] == 4     # 四门全过
    assert not list((tmp_path / "out").glob("_render_type2_*.html"))  # 临时件即删（W:683 同型）


def test_fr2_ac2_fetch_ladder_type2_pageinfo_and_partial_preview_limit(tmp_path):
    """pageInfo 在场优先径 + 占位图丢弃致页缺 → 幸存 1<page 2 = 部分收割合法形态：
    manifest 走 preview_limit（quality_gate 门①命中口径）；产物几何==pageInfo 600.5×400.25px
    →450.375×300.1875pt；wall_status/coverage 从采集腿透传。"""
    ri = _type2_reader_info([_img_url(1), _img_url(2)], page=2, show=2,
                            page_info={"pageWidth": PAGE_W_STR, "pageHeight": PAGE_H_STR})
    fetch_html = lambda url, headers, timeout: (  # noqa: E731
        200, _ndview_html({"title": "类型2样例-百度文库", "readerInfo": ri}))
    leg = _asset_fetch_spy([], {1: _png_bytes(120, 80),
                                2: _placeholder_png(550, 360)})     # 页2 占位图 → 丢弃
    audit_path = tmp_path / "audit.jsonl"
    adapter = WenkuDownloadAdapter(audit=HarvestAudit(path=str(audit_path)))
    result = adapter.fetch_ladder(adapter.plan(_meta(pages=2)), fetch_html=fetch_html,
                                  asset_fetch=leg, out_dir=tmp_path / "out",
                                  asset_min_interval=0, ocr_fn=_offline_ocr_ref)
    assert result.ok is True and result.pages == 1 and result.coverage == "2/2"
    for w, h in _page_sizes(result.artifact_path):
        assert abs(w - PW_PT) <= _TOL_PT and abs(h - PH_PT) <= _TOL_PT
    manifest = json.loads((tmp_path / "out" / "类型2样例_manifest.json").read_text(encoding="utf-8"))
    assert manifest["preview_limit"] == 1 and "expected_pages" not in manifest
    assert manifest["ref_chars"] == _OFFLINE_OCR_CHARS_PER_PAGE      # 1 页×12 字（实测）


def test_fr2_ac2_ref_chars_source_ocr_not_pagejson(tmp_path):
    """注记#5（SPEC_REVIEW 残留#5）直证：类型2 字数参照=OCR 文字层实测——manifest
    ref_chars_source="type2" 且 quality_gate 词义表钉死「OCR」；ref_chars==result.chars
    ==ocr_fn 实测返回；readerInfo 无 json 桶（类型2 无 pageJson 可走，参照唯一来源=OCR）。"""
    ri = _type2_reader_info([_img_url(1)], page=1, show=1,
                            page_info={"pageWidth": PAGE_W_STR, "pageHeight": PAGE_H_STR})
    fetch_html = lambda url, headers, timeout: (  # noqa: E731
        200, _ndview_html({"title": "类型2样例-百度文库", "readerInfo": ri}))
    ocr_seen: list = []

    def ocr_spy(image_pdf, out_pdf) -> int:
        ocr_seen.append(Path(image_pdf).name)
        return _offline_ocr_ref(image_pdf, out_pdf)

    adapter = WenkuDownloadAdapter()
    result = adapter.fetch_ladder(adapter.plan(_meta(pages=1)), fetch_html=fetch_html,
                                  asset_fetch=_asset_fetch_spy([], {1: _png_bytes(120, 80)}),
                                  out_dir=tmp_path, asset_min_interval=0, ocr_fn=ocr_spy)
    assert result.ok is True and ocr_seen == ["类型2样例.pdf"]       # 参照腿吃打印件（真链序）
    assert "OCR" in REF_CHARS_SOURCE_DESC["type2"]                   # 词表词义钉死（防漂移）
    assert "json" not in (ri["htmlUrls"] if isinstance(ri["htmlUrls"], dict) else {})
    manifest = json.loads((tmp_path / "类型2样例_manifest.json").read_text(encoding="utf-8"))
    assert manifest["ref_chars"] == result.chars == _OFFLINE_OCR_CHARS_PER_PAGE


def test_fr2_ac2_fetch_ladder_type2_zero_pages_honest_fail(tmp_path):
    """全部页判弃（404/GIF/占位）→ 零可用页如实 ok=False（不产空 PDF 不虚报页数）；
    coverage/wall 语义从采集腿透传（部分收割如实，§5.3）。"""
    ri = _type2_reader_info([_img_url(1), _img_url(2)], page=2, show=2)
    fetch_html = lambda url, headers, timeout: (  # noqa: E731
        200, _ndview_html({"title": "x", "readerInfo": ri}))
    leg = _asset_fetch_spy([], {1: _gif89a_bytes(90, 60)}, status_by_pn={2: 404})
    audit_path = tmp_path / "audit.jsonl"
    adapter = WenkuDownloadAdapter(audit=HarvestAudit(path=str(audit_path)))
    result = adapter.fetch_ladder(adapter.plan(_meta(pages=2)), fetch_html=fetch_html,
                                  asset_fetch=leg, out_dir=tmp_path / "out",
                                  asset_min_interval=0, ocr_fn=_offline_ocr_ref)
    assert result.ok is False and result.pages == 0 and result.artifact_path is None
    assert result.coverage == "2/2" and "零可用页" in result.detail
    lines = _audit_lines(audit_path)
    assert lines[-1]["event"] == "recon_type2" and lines[-1]["status"] == "fail"
    assert not list((tmp_path / "out").glob("*.pdf"))                # 不产空件


def test_fr2_ac2_type1_implemented_t35_verify_placeholder_pinned():
    """T35 兑现 supersede（2026-10-22）：类型1 dispatch 已实装（editor/XML 降级）——
    注入 params error 桶（端点实测形态）=XML 降级零桶如实失败（不产空件，零网络注入）；
    「T26/T31/T35」组字样仅存 verify 段4 占位（质检门对接归后继，钉死防漂移）。"""
    ri = {"htmlUrls": [], "rtcsRangeInfo": [{"page": 1, "range": "r0"}]}
    bundle = ReaderInfoLegResult(doc_id=DOC_ID, title_raw="t", title_clean="t", page=1,
                                 show_page=1, page_data={}, reader_info=ri, fill_needed=False,
                                 fill=None, stop_kind="not_needed", tri_cap_seen=False,
                                 html_urls_pages={}, wall_status=None, coverage="1/1", detail="")
    result = WenkuDownloadAdapter().dispatch_reconstruction(
        bundle, asset_fetch=lambda u, h, t, *, binary=False: (
            200, 'rtcs({"status":{"code":200002,"error":"params error"}})'))
    assert result.ok is False and "零可用桶" in result.detail       # T35 实装：占位钉兑现
    with pytest.raises(NotImplementedError, match=r"T26/T31/T35") as ei:
        WenkuDownloadAdapter().verify(result)                        # verify 半仍钉（占位组字样）
    assert "T35" in str(ei.value)


# ---------------- 实弹（真实网络 zero-mock；KB_HARVEST_SKIP_LIVE=1 跳过） ----------------

_LIVE_REASON = "KB_HARVEST_SKIP_LIVE=1：实弹用例跳过（真实网络未跑，公约第 4 条）"
_LIVE_AUDIT = Path(__file__).resolve().parent / "fixtures" / "_t31_live_audit.jsonl"
_LIVE_QUERIES = ("手抄报", "PPT模板", "试卷", "项目管理制度")  # 类型2 倾向词+T26 校准词（探针校准）
_LIVE_MAX_PROBE = 8      # 任务卡口径：每件 1 请求，≤8 件
_SYNTH_DOC_ID = "752032e54293daef5ef7ba0d4a7302768e996ff0"  # 合成口径基件（T26 落档 1/1 全免费件）
# 合成图源：ndview 页静态资产图直链（edu-wenku.bdimg.com=wenku 自有 CDN）；continueRead
# 横幅实测为 wenku 界面截图（OCR 实测 517/445 字），优先取用保证门②参照可立。
_CDN_IMG_RE = re.compile(r"https://edu-wenku\.bdimg\.com/v1/wkSmallApp/continueRead/[A-Za-z0-9/._-]+?\.png")
_CDN_IMG_FALLBACK_RE = re.compile(r"https://edu-wenku\.bdimg\.com/v1/pc/[A-Za-z0-9/._-]+?\.png")


def _probe_type2_docs():
    """实弹发现腿（任务卡口径）：syncmrecall 多取几件 → 逐一 ndview 挖 readerInfo 判型
    （每件 1 请求，≤8 件；类型2=Array.isArray(htmlUrls)&&length>0），找到即收（优先全免费
    免 signer）。今日探针校准（_t31_probe_type2.json 两轮 18 件全 type3）：真类型2 大概率
    寻不得 → 由调用方走任务卡明示的合成口径。"""
    from kb_factory.channel_adapters.wenku_meta import WenkuMetaAdapter
    from kb_factory.harvest_engine.adapters.wenku import fetch_page_data
    candidates, seen = [], set()
    for query in _LIVE_QUERIES:
        try:
            metas = WenkuMetaAdapter().metadata(query, 12)
        except Exception:
            continue  # syncmrecall 软封前科（DEVLOG 1014）：换词续试
        for m in metas:
            did = m.extra.get("doc_id")
            if did and did not in seen:
                seen.add(did)
                candidates.append({"doc_id": did, "title": m.title, "pages": m.pages})
    if not candidates:
        candidates = [{"doc_id": _SYNTH_DOC_ID, "title": "合成基件(落档)", "pages": 1}]
    candidates.sort(key=lambda c: (c["pages"] or 999))
    full, partial = [], []
    for cand in candidates[:_LIVE_MAX_PROBE]:
        try:
            page_data = fetch_page_data(cand["doc_id"])
        except Exception:
            continue
        ri = page_data["readerInfo"]
        if judge_doc_type(ri) != "type2":
            time.sleep(1.0)
            continue
        entry = {"meta": _meta(doc_id=cand["doc_id"], title=str(page_data.get("title") or "")),
                 "page_data": page_data}
        n_page = ri.get("page") or ri.get("originalPage") or ri.get("freePage") or 0
        n_show = ri.get("showPage") or 0
        (full if n_show >= n_page > 0 else partial).append(entry)
        if full:
            break
        time.sleep(1.0)
    return full, partial


def _synth_type2_bundle(adapter: WenkuDownloadAdapter):
    """合成口径（任务卡明示，如实记录）：live 取真 readerInfo（collect_reader_info 真腿）→
    htmlUrls 换成数组样本：URL=同域 ndview 页静态资产图直链（edu-wenku.bdimg.com，真实
    wenku CDN 图，网络腿真下载真判件），逐项附 ``&pn=N``（§3.2 页号键）。真类型2 今日
    寻件困难（站方检索面全量 html_view 化，判型探针两轮 18/18 type3）。"""
    from kb_factory.harvest_engine.adapters.wenku import (NDVIEW_URL_TMPL,
                                                          _httpx_fetch_html,
                                                          _view_headers)
    bundle = adapter.collect_reader_info(_SYNTH_DOC_ID)
    status, html = _httpx_fetch_html(NDVIEW_URL_TMPL.format(doc_id=_SYNTH_DOC_ID),
                                     _view_headers(None, ""), 20)
    imgs = _CDN_IMG_RE.findall(html or "") or _CDN_IMG_FALLBACK_RE.findall(html or "")
    uniq = list(dict.fromkeys(imgs))                  # 去重保序
    assert status == 200 and uniq, "合成口径失败：ndview 页无静态资产图直链"
    n = max(1, min(bundle.page or 1, len(uniq), 2))   # 小件口径：≤2 页（OCR 实测提速）
    bundle.reader_info["htmlUrls"] = [
        f"{uniq[i]}{'&' if '?' in uniq[i] else '?'}pn={i + 1}"   # 无 query 装配 ?pn=（404 坑实证）
        for i in range(n)]
    bundle.reader_info["page"] = bundle.reader_info.get("page") or n
    return bundle, n


@pytest.mark.live
@pytest.mark.skipif(_LIVE_SKIP, reason=_LIVE_REASON)
def test_fr2_ac2_live_type2_full_chain(tmp_path):
    """FR2.AC2 实弹主验收（任务卡口径）：优先真类型2 件全链（判型探针 ≤8 件入 ledger
    recon_dispatch branch=type2）→ 逐页图片直链下载（judge_page_png 四步链真判）→
    renderImageHtml → printToPDF → pypdfium2 实测页尺寸==pageInfo px→pt；注记#5：OCR
    文字层实测 ref_chars（manifest ref_chars_source=type2）→ 质检门四门。真类型2 寻件
    困难时走任务卡明示的合成口径（真 readerInfo+真 wenku CDN 图直链，口径如实打印+落账）。"""
    full, partial = _probe_type2_docs()
    adapter = WenkuDownloadAdapter(audit=HarvestAudit(path=str(_LIVE_AUDIT)))
    synthetic = not full and not partial
    before = len(_audit_lines(_LIVE_AUDIT))
    if full or partial:
        entry = (full or partial)[0]
        if full:
            result = adapter.fetch_ladder(adapter.plan(entry["meta"]), out_dir=tmp_path)
        else:  # 两段式：signer 补页（Chromium）→ 收口后重组（打印腿独立开浏览器避免嵌套）
            from kb_factory.harvest_engine.browser.kit import BrowserKit
            from kb_factory.harvest_engine.signer.page_signer import PageSigner
            from playwright.sync_api import sync_playwright
            with sync_playwright() as pw:
                browser = pw.chromium.launch(
                    headless=True,
                    args=[] if os.environ.get("KB_HARVEST_KEEP_PROXY") == "1"
                    else ["--no-proxy-server"])
                try:
                    kit = BrowserKit(browser)
                    signer = PageSigner(kit)
                    assert signer.ready, "ACS 签名窗未就绪（T17 件在位为前提）"
                    adapter.collect_reader_info(entry["meta"].extra["doc_id"], signer=signer)
                finally:
                    signer.close()
                    kit.close_all()
                    browser.close()
            result = adapter.dispatch_reconstruction(adapter.last_reader_info, out_dir=tmp_path)
        mode = "real-type2"
    else:
        bundle, n_pages = _synth_type2_bundle(adapter)
        result = adapter.dispatch_reconstruction(bundle, out_dir=tmp_path)
        mode = f"synthetic(real readerInfo + wenku CDN 图直链 ×{n_pages})"
    bundle = adapter.last_reader_info
    assert result.ok is True, f"实弹重组未过门: {result.detail}"
    assert result.artifact_path and Path(result.artifact_path).is_file()
    exp_w, exp_h = type2_page_dims(bundle.reader_info)
    sizes = _page_sizes(result.artifact_path)
    assert len(sizes) == result.pages >= 1
    for w, h in sizes:
        assert abs(w - exp_w / PX_PER_PT_CSS) <= _TOL_PT, f"页宽 {w}pt != pageInfo {exp_w}px"
        assert abs(h - exp_h / PX_PER_PT_CSS) <= _TOL_PT, f"页高 {h}pt != pageInfo {exp_h}px"
    lines = _audit_lines(_LIVE_AUDIT)[before:]
    dispatch = [l for l in lines if l["event"] == "recon_dispatch"]
    assert dispatch and dispatch[0]["status"] == "type2"
    assert f"tplKey={bundle.reader_info.get('tplKey')}" in dispatch[0]["detail"]
    recon = [l for l in lines if l["event"] == "recon_type2"]
    assert recon and recon[0]["status"] == "ok" and recon[0]["count"] == result.pages
    assert result.chars >= 1                                    # OCR 文字层实测（数字零造假）
    manifest_path = next(tmp_path.glob("*_manifest.json"))      # 产物同目录唯一 manifest
    manifest = json.loads(manifest_path.read_text(encoding="utf-8"))
    assert manifest["ref_chars_source"] == "type2"
    assert manifest["ref_chars"] == result.chars
    gate = [l for l in lines if l["event"] == "quality_gate"]
    assert gate and gate[-1]["count"] == 4 and gate[-1]["status"] == "ok"  # 四门全过
    print(f"\n[live] mode={mode} doc={bundle.doc_id} page={bundle.page} "
          f"showPage={bundle.show_page} pages={result.pages} chars={result.chars} "
          f"geo={sizes[0][0]:.1f}x{sizes[0][1]:.1f}pt tplKey={bundle.reader_info.get('tplKey')} "
          f"title={bundle.title_clean[:24]}")
