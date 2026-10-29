# -*- coding: utf-8 -*-
"""FR3.1 单测：book118 图床拉取+魔数识别+像素拼 PDF（T23，页清单→PDF 收割腿）。

- 离线用例=确定性注入（image_transport 注入点③ / ocr_fn=OCR 子系统边界注入；零网络零
  mock 框架）：图字节=PIL 手造 PNG/GIF89a（魔数自证），OCR 参照=T13 真件 render_pages+
  build_searchable_pdf 换确定性行集（paddle 引擎属 T13/T33 边界，文字层构建/字数统计全真），
  质检门=真 quality_gate 四门跑真 PDF（manifest 落盘经 load_manifest schema 校验）。
- 实弹用例（@pytest.mark.live）=真实网络：.shtm 首跳→openapi 页清单（T19 腿）→view-cache
  图直下（https 优先 http 兜底，trust_env=False）→魔数识别（.png 实为 GIF89a）→页号 int
  排序→pdf/image_pdf 像素拼 PDF→OCR 全文参照→质检门；KB_HARVEST_SKIP_LIVE=1 时跳过并在
  输出明示（公约第 4 条）。
- 页图全下这 1-2 份=真实交付物（任务卡口径：计 ledger 不计探针额度）。
- 免费档实测 preview=3<actual=7（T19 固定样本）→按 quality_gate「预览上限=部分收割合法
  形态」口径 manifest 用 preview_limit 过门①，FileMeta 形态标注「预览部分」（黄线 perm=yellow）。
"""
import io
import json
import os
import sys
from pathlib import Path

import pytest

_KB_DIR = Path(__file__).resolve().parents[2]  # kb_factory/
sys.path.insert(0, str(_KB_DIR))  # worktree 阶段 kb_factory 无 __init__.py：顶层导入 harvest_engine
if not (_KB_DIR / "channel_adapters" / "base.py").exists():
    # worker worktree：kb_factory 未入 git → channel_adapters 只读复用主仓真身
    for _anc in _KB_DIR.parents:
        if (_anc / "kb_factory" / "channel_adapters" / "base.py").exists():
            sys.path.insert(1, str(_anc))
            break

try:  # 合并后正名 kb_factory.harvest_engine.*；worktree 阶段回退顶层名（同 T19 测试件）
    from kb_factory.channel_adapters.base import FileMeta
    from kb_factory.harvest_engine.adapters.book118 import (  # noqa: E402
        PAGE_IMAGE_GAP_S, Book118Adapter, Book118ImageError, PageImageRecord,
        PreviewPdfResult, image_url_pair)
    from kb_factory.harvest_engine.audit import HarvestAudit
    from kb_factory.harvest_engine.store.ledger import Store
except ImportError:
    from channel_adapters.base import FileMeta  # type: ignore
    from harvest_engine.adapters.book118 import (  # type: ignore
        PAGE_IMAGE_GAP_S, Book118Adapter, Book118ImageError, PageImageRecord,
        PreviewPdfResult, image_url_pair)
    from harvest_engine.audit import HarvestAudit  # type: ignore
    from harvest_engine.store.ledger import Store  # type: ignore

import pypdfium2 as pdfium  # noqa: E402
from PIL import Image, ImageDraw  # noqa: E402

_LIVE_SKIP = os.environ.get("KB_HARVEST_SKIP_LIVE") == "1"

# ---- T19 固定实弹样本（任务卡口径：免费 3/7 主档 + 62 页收费档验 partial 标注）----
FREE_DOC_URL = "https://max.book118.com/html/2022/1214/6115103231005025.shtm"
FREE_DOC_ID, FREE_AID = "6115103231005025", 517914739
FREE_PREVIEW, FREE_ACTUAL = 3, 7
PAID_DOC_URL = "https://max.book118.com/html/2022/0414/5110103104004213.shtm"
PAID_DOC_ID = "5110103104004213"
PAID_PREVIEW, PAID_ACTUAL = 62, 124


# ---------------------------------------------------------------- 离线 fixture 件
def _png_bytes(w: int, h: int) -> bytes:
    """白底+左上墨块 PNG（魔数自证；ink 带内形态=白页少量油墨，供质检门③真跑）。"""
    im = Image.new("RGB", (w, h), (255, 255, 255))
    ImageDraw.Draw(im).rectangle([2, 2, max(4, w // 3), max(4, h // 8)], fill=(10, 10, 10))
    buf = io.BytesIO()
    im.save(buf, format="PNG")
    data = buf.getvalue()
    assert data.startswith(b"\x89PNG\r\n\x1a\n")
    return data


def _gif89a_bytes(w: int, h: int) -> bytes:
    """GIF89a（P 模式+transparency 未用索引强制 89a 头；.png URL 实为 GIF 的离线同型）。"""
    im = Image.new("RGB", (w, h), (255, 255, 255))
    ImageDraw.Draw(im).rectangle([2, 2, max(4, w // 3), max(4, h // 8)], fill=(10, 10, 10))
    buf = io.BytesIO()
    im.quantize(colors=64).save(buf, format="GIF", transparency=2)  # 索引2=未用→头89a且无可见透明
    data = buf.getvalue()
    assert data.startswith(b"GIF89a"), "fixture 不是 GIF89a"
    return data


class ImageServer:
    """离线 view-cache 仿真（注入点③确定性响应；记录每次绝对 URL 供兜底/编码断言）。

    https_reject={页}：https 协议回 404（非 5xx→不重试直切 http 兜底）；
    error_pages={页}：网络层异常注入（ConnectionError 形态，两协议各耗尽重试）。
    """

    def __init__(self, blobs: dict):
        self.blobs = blobs
        self.calls: list[str] = []
        self.https_reject: set = set()
        self.error_pages: set = set()

    def __call__(self, url: str):
        self.calls.append(url)
        name = url.rsplit("/", 1)[-1]
        page = int(name.split("@", 1)[0].split(".", 1)[0])
        if page in self.error_pages:
            raise ConnectionError(f"simulated transport failure: page={page}")
        if page in self.https_reject and url.startswith("https://"):
            return 404, b""
        return 200, self.blobs[page]


class SleepRecorder:
    """时间注入点记录器（零真实等待）。"""

    def __init__(self):
        self.calls: list[float] = []

    def __call__(self, seconds: float) -> None:
        self.calls.append(round(float(seconds), 6))


def _offline_ocr_ref(image_pdf: Path, out_pdf: Path) -> int:
    """离线 OCR 参照（ocr_fn 注入实现）：T13 真件 render_pages+build_searchable_pdf，
    行集换确定性两条（paddle 引擎属 T13/T33 边界）；返回值=stats.chars 实测（勿手填）。"""
    try:
        from kb_factory.harvest_engine.render.ocr import (
            OcrLine, build_searchable_pdf, render_pages)
    except ImportError:
        from harvest_engine.render.ocr import (  # type: ignore
            OcrLine, build_searchable_pdf, render_pages)
    frames = render_pages(image_pdf, dpi=150)
    lines = [[OcrLine("离线参照行甲", 0.99, (2, 2, 90, 18)),
              OcrLine("离线参照行乙", 0.98, (2, 22, 90, 38))]] * len(frames)
    return int(build_searchable_pdf(frames, lines, out_pdf, dpi=150).chars)


def _page_sizes(pdf_path: Path) -> list:
    with pdfium.PdfDocument(str(pdf_path)) as doc:
        return [(round(p.get_width()), round(p.get_height())) for p in doc]


# ---------------------------------------------------------------- FR3.1 纯函数层

def test_fr3_1_image_url_pair_scheme_priority_no_recode():
    """协议相对 //→https 首试+http 兜底；绝对 URL 换协议头；@/= 原样透传勿二次编码
    （BOOK118_SPEC §3 fastdfs 文件名两形态实测）。"""
    rel = "//view-cache.book118.com/view1/M04/35/16/view_1_xxx@yyy=.png?v=20231026"
    https_u, http_u = image_url_pair(rel)
    assert https_u == "https:" + rel
    assert http_u == "http:" + rel
    assert "%40" not in https_u and "%3D" not in https_u and "%40" not in http_u
    a_https, a_http = image_url_pair("http://view-cache.book118.com/view2/M01/a@b=.png")
    assert a_https == "https://view-cache.book118.com/view2/M01/a@b=.png"
    assert a_http == "http://view-cache.book118.com/view2/M01/a@b=.png"
    b_https, b_http = image_url_pair("https://view-cache.book118.com/view3/M06/c.png")
    assert b_https.startswith("https://") and b_http.startswith("http://")
    assert image_url_pair("") == ("https://", "http://")   # 防御形态不炸


# ---------------------------------------------------------------- FR3.1 图直下离线

def test_fr3_1_download_page_images_int_sort_magic_fallback(tmp_path):
    """图直下腿：页号 int 排序（"10"<"2" 字典序坑防御）+魔数识别落盘（.png URL 实为
    GIF89a→存 .gif）+https 404 直切 http 兜底+URL 原样（@/= 未编码）+成功页除名失败页台账。"""
    blobs = {1: _png_bytes(120, 160), 2: _gif89a_bytes(120, 160), 10: _gif89a_bytes(120, 160)}
    server = ImageServer(blobs)
    server.https_reject = {2}
    page_urls = {10: "//view-cache.book118.com/view1/M04/10@k=.png",
                 2: "//view-cache.book118.com/view1/M04/2@k=.png",
                 1: "//view-cache.book118.com/view1/M04/1@k=.png"}
    audit = HarvestAudit(str(tmp_path / "harvest_audit.jsonl"))
    store = Store(str(tmp_path / "store"))
    rec = SleepRecorder()
    adapter = Book118Adapter(audit=audit, store=store, sleep=rec)
    records = adapter.download_page_images(page_urls, tmp_path / "pages", doc_id="611",
                                           image_transport=server)
    assert isinstance(records[0], PageImageRecord)
    assert [r.page for r in records] == [1, 2, 10]                    # int 数值序
    assert records[0].fmt == "png" and records[1].fmt == "gif" and records[2].fmt == "gif"
    assert all(r.status == 200 and r.byte_len == len(blobs[r.page]) for r in records)
    # https→http 兜底实证：page2 首呼 https(404) 末呼 http(200)，他页单呼 https
    p2 = [u for u in server.calls if "/2@" in u]
    assert p2[0].startswith("https://") and p2[-1].startswith("http://") and len(p2) == 2
    assert sum(1 for u in server.calls if "/1@" in u) == 1
    # 落盘名=魔数真身扩展名；字节等值
    assert records[1].path.name == "0002.gif" and records[1].path.read_bytes() == blobs[2]
    assert records[0].path.name == "0001.png"
    # URL 原样透传（勿二次编码）
    assert all("%40" not in u and "%3D" not in u for u in server.calls)
    # 成功页全除名（失败页台账空）
    assert store.iter_failed(site="book118", doc="611") == []
    # 页间礼貌间隔在位（n-1 次）
    assert rec.calls.count(PAGE_IMAGE_GAP_S) == 2
    # 审计：每页一行 page_image + 汇总一行 page_images
    lines = (tmp_path / "harvest_audit.jsonl").read_text(encoding="utf-8").splitlines()
    per_page = [ln for ln in lines if '"event": "page_image"' in ln or '"event":"page_image"' in ln]
    assert len(per_page) == 3
    assert any('"event": "page_images"' in ln or '"event":"page_images"' in ln for ln in lines)


def test_fr3_1_download_page_images_unknown_magic_and_transport_error(tmp_path):
    """失败页双形态：200+未知魔数（不赌 .png 扩展名）与网络层异常（双协议重试耗尽）
    →Book118ImageError(page_image_failed)+失败页台账如实记（resume 口径）。"""
    blobs = {1: b"\x00\x01not-an-image-at-all", 2: _gif89a_bytes(120, 160)}
    server = ImageServer(blobs)
    server.error_pages = {2}
    store = Store(str(tmp_path / "store"))
    adapter = Book118Adapter(store=store, sleep=SleepRecorder())
    page_urls = {1: "//view-cache.book118.com/view1/M04/1@k=.png",
                 2: "//view-cache.book118.com/view1/M04/2@k=.png"}
    with pytest.raises(Book118ImageError) as ei:
        adapter.download_page_images(page_urls, tmp_path / "pages", doc_id="611",
                                     image_transport=server)
    assert ei.value.kind == "page_image_failed"
    assert "unknown_magic" in str(ei.value) and "page=2" in str(ei.value)
    assert sorted(store.iter_failed(site="book118", doc="611")) == [1, 2]
    # 网络异常页双协议各 IMAGE_RETRY_PER_SCHEME 次（https 2 + http 2 = 4 呼）
    p2 = [u for u in server.calls if "/2@" in u]
    assert len(p2) == 4 and p2[0].startswith("https://") and p2[-1].startswith("http://")


def test_fr3_1_download_page_images_empty_list(tmp_path):
    """空页清单显式 no_page_list（不产 0 页产物，不静默）。"""
    adapter = Book118Adapter(sleep=SleepRecorder())
    with pytest.raises(Book118ImageError) as ei:
        adapter.download_page_images({}, tmp_path / "pages", doc_id="x")
    assert ei.value.kind == "no_page_list"


# ---------------------------------------------------------------- FR3.1 收割腿全链离线

def test_fr3_1_harvest_preview_pdf_offline_partial_and_full(tmp_path):
    """离线全链：页清单→图直下→魔数→像素拼 PDF（几何=像素，1px=1pt）→partial 黄线
    「预览部分」标注+manifest preview_limit / 全预览 expected_pages 两口径→真质检门 4/4。"""
    blobs = {1: _gif89a_bytes(120, 160), 2: _png_bytes(120, 160)}
    server = ImageServer(blobs)
    urls = {1: "//view-cache.book118.com/view1/M04/1@k=.png",
            2: "//view-cache.book118.com/view1/M04/2@k=.png"}
    audit = HarvestAudit(str(tmp_path / "harvest_audit.jsonl"))
    adapter = Book118Adapter(audit=audit, sleep=SleepRecorder())
    # 形态A：preview=2<actual=7 收费/部分预览 → 黄线+预览部分+preview_limit
    meta = FileMeta(title="离线部分预览样本.docx", fmt="doc", extra={
        "book118_doc_id": "9001", "book118_page_urls": dict(urls),
        "book118_pages_preview": 2, "book118_pages_actual": 7,
        "book118_partial_preview": True})
    result = adapter.harvest_preview_pdf(meta, tmp_path / "workA",
                                         image_transport=server, ocr_fn=_offline_ocr_ref)
    assert isinstance(result, PreviewPdfResult)
    assert result.pages == 2 and result.partial is True
    assert [r.page for r in result.page_records] == [1, 2]
    assert meta.perm == "yellow" and meta.extra["book118_form"] == "预览部分"   # 黄线+形态标注
    assert result.image_pdf.exists() and result.searchable_pdf.exists()
    assert _page_sizes(result.image_pdf) == [(120, 160), (120, 160)]           # 像素拼页几何
    manifest = json.loads(result.manifest_path.read_text(encoding="utf-8"))
    assert manifest["preview_limit"] == 2 and "expected_pages" not in manifest
    assert manifest["ref_chars_source"] == "book118"
    assert manifest["ref_chars"] == result.ref_chars and result.ref_chars >= 1  # OCR 实测非手填
    assert [g.name for g in result.gate_outcomes] == ["pages", "chars", "watermark", "integrity"]
    assert all(g.passed for g in result.gate_outcomes)                          # 质检门 4/4
    assert adapter.verify_pdf(result) is True
    # 形态B：preview==actual 全预览 → expected_pages 口径+不标预览部分（perm 保持 green）
    meta2 = FileMeta(title="离线全预览样本.docx", fmt="doc", extra={
        "book118_doc_id": "9002", "book118_page_urls": dict(urls),
        "book118_pages_preview": 2, "book118_pages_actual": 2})
    result2 = adapter.harvest_preview_pdf(meta2, tmp_path / "workB",
                                          image_transport=server, ocr_fn=_offline_ocr_ref)
    assert result2.pages == 2 and result2.partial is False
    assert meta2.perm == "green" and "book118_form" not in meta2.extra
    manifest2 = json.loads(result2.manifest_path.read_text(encoding="utf-8"))
    assert manifest2["expected_pages"] == 2 and "preview_limit" not in manifest2
    assert adapter.verify_pdf(result2) is True
    # 台账：pdf_build/quality_gate 事件在账（收割计 ledger）
    lines = (tmp_path / "harvest_audit.jsonl").read_text(encoding="utf-8").splitlines()
    assert any('"event": "pdf_build"' in ln or '"event":"pdf_build"' in ln for ln in lines)
    assert any('"event": "quality_gate"' in ln or '"event":"quality_gate"' in ln for ln in lines)


def test_fr3_1_p0_4_preview_cap_hard_truncation_before_disk(tmp_path):
    """T41 P0-4 法律面硬约束：「仅保存预览部分、不做全量重构」代码级化——页清单 3 页>
    book118_pages_preview=2 → 落盘前截断：第 3 页**不下载不落盘**（超限页零网络零字节）；
    preview_cap 审计行在账；产物/manifest/门全按 2 页预览口径。"""
    blobs = {1: _gif89a_bytes(120, 160), 2: _png_bytes(120, 160), 3: _png_bytes(120, 160)}
    server = ImageServer(blobs)
    urls = {1: "//view-cache.book118.com/view1/M04/1@k=.png",
            2: "//view-cache.book118.com/view1/M04/2@k=.png",
            3: "//view-cache.book118.com/view1/M04/3@k=.png"}
    audit = HarvestAudit(str(tmp_path / "p04_audit.jsonl"))
    adapter = Book118Adapter(audit=audit, sleep=SleepRecorder())
    meta = FileMeta(title="超限清单样本.docx", fmt="doc", extra={
        "book118_doc_id": "9004", "book118_page_urls": dict(urls),
        "book118_pages_preview": 2, "book118_pages_actual": 7,
        "book118_partial_preview": True})
    result = adapter.harvest_preview_pdf(meta, tmp_path / "work",
                                         image_transport=server, ocr_fn=_offline_ocr_ref)
    assert [r.page for r in result.page_records] == [1, 2]          # 只落盘前 2 页
    assert result.pages == 2 and result.partial is True
    assert not [u for u in server.calls if "/3@" in u]              # 第 3 页零发腿（落盘前截断）
    assert not list((tmp_path / "work" / "pages").glob("0003.*"))   # 零字节零文件
    manifest = json.loads(result.manifest_path.read_text(encoding="utf-8"))
    assert manifest["preview_limit"] == 2
    lines = (tmp_path / "p04_audit.jsonl").read_text(encoding="utf-8").splitlines()
    cap_rows = [ln for ln in lines if '"event": "preview_cap"' in ln
                or '"event":"preview_cap"' in ln]
    assert len(cap_rows) == 1 and "法律面硬约束" in cap_rows[0] and "3" in cap_rows[0]
    assert adapter.verify_pdf(result) is True


def test_fr3_1_harvest_preview_pdf_requires_page_list(tmp_path):
    """meta.extra 无 book118_page_urls → no_page_list 硬错（编排层先跑 T19 fetch_ladder）。"""
    adapter = Book118Adapter(sleep=SleepRecorder())
    meta = FileMeta(title="空", fmt="doc", extra={"book118_doc_id": "1"})
    with pytest.raises(Book118ImageError) as ei:
        adapter.harvest_preview_pdf(meta, tmp_path / "work")
    assert ei.value.kind == "no_page_list"


def test_fr3_1_verify_pdf_rejects_gate_fail(tmp_path):
    """verify_pdf 收口：门③越带（全油墨图）→False（不产 0 字/遮盖形态的假过门）。"""
    black = Image.new("RGB", (120, 160), (0, 0, 0))
    buf = io.BytesIO()
    black.save(buf, format="PNG")
    server = ImageServer({1: buf.getvalue()})
    meta = FileMeta(title="全黑页样本.docx", fmt="doc", extra={
        "book118_doc_id": "9003", "book118_page_urls": {1: "//view-cache.book118.com/x/1@k=.png"},
        "book118_pages_preview": 1, "book118_pages_actual": 1})
    adapter = Book118Adapter(sleep=SleepRecorder())
    result = adapter.harvest_preview_pdf(meta, tmp_path / "work",
                                         image_transport=server, ocr_fn=_offline_ocr_ref)
    assert result.pages == 1
    wm = [g for g in result.gate_outcomes if g.name == "watermark"][0]
    assert wm.passed is False                                     # ink=1.0 越上带（遮盖形态）
    assert adapter.verify_pdf(result) is False


# ---------------------------------------------------------------- FR3.1 实弹（真实网络，zero-mock）

@pytest.fixture(scope="module")
def chromium():
    """module 级唯一浏览器（同 T19 测试件口径：fixture 管 launch/close，直连代理坑 args）。"""
    from playwright.sync_api import sync_playwright
    with sync_playwright() as pw:
        browser = pw.chromium.launch(headless=True, args=["--proxy-server=direct://"])
        yield browser
        browser.close()


@pytest.mark.live
def test_fr3_1_live_free_doc_images_pdf_quality_gate(chromium, tmp_path):
    """实弹免费档 T23 全链（FR3.1 验收主证据，任务卡口径）：fetch_ladder 页清单→view-cache
    图直下（https 优先 http 兜底，trust_env=False）→魔数识别（.png 实为 GIF89a）→像素拼
    PDF→OCR 全文参照→质检门 4/4。免费档实测 preview=3<actual=7→preview_limit 口径过门①+
    黄线「预览部分」标注（quality_gate 部分收割合法形态；页数==actual 口径须 preview==actual
    档，本样本如实走 preview_limit）。"""
    if _LIVE_SKIP:
        print("[live-skip] KB_HARVEST_SKIP_LIVE=1：实弹免费档图链用例跳过（CI 场景明示）")
        pytest.skip("[live-skip] KB_HARVEST_SKIP_LIVE=1 实弹免费档图链跳过")
    store = Store(str(tmp_path))
    audit = HarvestAudit(str(tmp_path / "harvest_audit.jsonl"))
    adapter = Book118Adapter(browser=chromium, store=store, audit=audit)
    meta = FileMeta(title="某培训学院教学督导制度.docx", fmt="doc",
                    source_url=FREE_DOC_URL, extra={})
    ladder = adapter.fetch_ladder(adapter.plan(meta))
    assert ladder.ok, ladder.detail
    result = adapter.harvest_preview_pdf(meta, tmp_path / "work")
    records = result.page_records
    print(f"[live] 免费档页图魔数真身: {[(r.page, r.fmt, r.byte_len, r.scheme_used) for r in records]}")
    print(f"[live] 产物: image_pdf={result.image_pdf} searchable_pdf={result.searchable_pdf} "
          f"manifest={result.manifest_path} ref_chars={result.ref_chars}")
    assert [r.page for r in records] == list(range(1, FREE_PREVIEW + 1))    # int 排序全页
    assert all(r.fmt in ("gif", "png") for r in records)                    # 魔数词表内
    assert any(r.url.rsplit("/", 1)[-1].split("?")[0].endswith(".png") and r.fmt == "gif"
               for r in records), "SPEC §3 实锤形态（.png URL 实为 GIF89a）未复现"
    assert all(r.byte_len > 1000 for r in records)
    assert all(r.scheme_used in ("https", "http") for r in records)
    assert result.pages == FREE_PREVIEW                                     # 实测页数==页清单
    assert result.partial is True
    assert meta.perm == "yellow" and meta.extra["book118_form"] == "预览部分"
    manifest = json.loads(result.manifest_path.read_text(encoding="utf-8"))
    assert manifest["preview_limit"] == FREE_PREVIEW
    assert manifest["ref_chars_source"] == "book118"
    assert manifest["ref_chars"] == result.ref_chars and result.ref_chars >= 50   # OCR 实测非手填
    assert adapter.verify_pdf(result) is True                                # 质检门 4/4
    assert _page_sizes(result.image_pdf) and all(
        size == _page_sizes(result.image_pdf)[0] for size in _page_sizes(result.image_pdf))
    # 台账（收割计 ledger 不计探针额度）：page_images/pdf_build/quality_gate 事件在账
    lines = (tmp_path / "harvest_audit.jsonl").read_text(encoding="utf-8").splitlines()
    for ev in ("page_image", "pdf_build", "quality_gate"):
        assert any(f'"{ev}"' in ln for ln in lines), ev


@pytest.mark.live
def test_fr3_1_live_paid_doc_62_pages_partial_annotation(chromium, tmp_path):
    """实弹收费档（preview=62/actual=124，任务卡验 partial 标注）：62 页图全下（真实交付
    物，计 ledger 不计探针额度）→像素拼 PDF 62 页→黄线「预览部分」+manifest preview_limit=62
    →OCR 参照+质检门。"""
    if _LIVE_SKIP:
        print("[live-skip] KB_HARVEST_SKIP_LIVE=1：实弹收费档 62 页用例跳过（CI 场景明示）")
        pytest.skip("[live-skip] KB_HARVEST_SKIP_LIVE=1 实弹收费档跳过")
    audit = HarvestAudit(str(tmp_path / "harvest_audit.jsonl"))
    adapter = Book118Adapter(browser=chromium, audit=audit)
    meta = FileMeta(title="煤炭设备项目投标报告（煤炭参考）.docx", fmt="doc",
                    source_url=PAID_DOC_URL, extra={})
    ladder = adapter.fetch_ladder(adapter.plan(meta))
    assert ladder.ok, ladder.detail
    result = adapter.harvest_preview_pdf(meta, tmp_path / "work")
    records = result.page_records
    fmts = {r.fmt for r in records}
    print(f"[live] 收费档 62 页魔数真身集合: {sorted(fmts)}; "
          f"schemes={sorted({r.scheme_used for r in records})}")
    print(f"[live] 产物: image_pdf={result.image_pdf} manifest={result.manifest_path} "
          f"ref_chars={result.ref_chars} gate="
          + "/".join(f"{g.name}:{'P' if g.passed else 'F'}" for g in result.gate_outcomes))
    assert [r.page for r in records] == list(range(1, PAID_PREVIEW + 1))     # 62 页 int 排序全下
    assert fmts <= {"gif", "png"} and all(r.byte_len > 1000 for r in records)
    assert result.pages == PAID_PREVIEW                                     # 像素拼 PDF==62
    assert result.partial is True                                           # 62<124 收费形态
    assert meta.perm == "yellow" and meta.extra["book118_form"] == "预览部分"
    manifest = json.loads(result.manifest_path.read_text(encoding="utf-8"))
    assert manifest["preview_limit"] == PAID_PREVIEW and "expected_pages" not in manifest
    assert manifest["ref_chars_source"] == "book118" and manifest["ref_chars"] >= 500
    assert adapter.verify_pdf(result) is True
