# -*- coding: utf-8 -*-
"""FR3.AC2 取样协议测试：book118 OCR 文字层+GT 三份（T33，REQ 硬一致性③修复）。

取样协议（FR3.AC2）：每份 fixture=标题+首页可见文本前 2 个≥4 字词（人工誊录一次入
tests/fixtures/book118_gt.json——誊录证据=首页图 render/ocr.ocr_image 行集辅助选词
（book118_gt_pages/_ocr_lines.json）+验收同链实测文字层（_chain_probe/_chain_layers.json）
双证人工确认，词真实可见）；验收=pypdfium2 抽 searchable PDF 文字层做精确匹配
（容错=0：字符级零容差，仅空白归一口径=匹配前移除全部空白字符），3/3 命中=该份过；
脚本对 3 份 GT 全过。

样本=已落档两件（6115103231005025 免费 3/7 + 5110103104004213 收费 62/124）+ T19
fixtures 留档推荐档（5123021331010032 全预览 22/22，_probe_t19_shtm_playwright.html
同目录链接）。三形态（免费/收费/全预览）各一。

- 离线用例（零网络）：①GT 文件协议形状；②OCR 钩子空文本行过滤（paddle 偶发空行，
  回注件拒空串——T34/docin 同坑，注入行集确定性验证）；③合成中文页（PIL+simhei
  真画字）真跑全链：像素拼 PDF→钩子→文字层抽取→3/3 精确命中；④harvest_preview_pdf
  挂参 ocr_layer=False 语义（像素 PDF 先行、无字数参照不落 manifest 不跑质检门=
  verify_pdf 如实 False）+后补文字层过门（编排层职责演示）。
- 实弹用例（@pytest.mark.live）=GT 三份主验收：fixtures 缓存首页图在位即零网络零
  浏览器；缺图则活链重拉（Playwright .shtm 首跳→openapi 页清单→首页图直下，与
  _probe_t33_step1.py 同链）。KB_HARVEST_SKIP_LIVE=1 时跳过并在输出明示（公约第 4 条）。
"""
import io
import json
import os
import re
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

try:  # 合并后正名 kb_factory.harvest_engine.*；worktree 阶段回退顶层名（同 T23 测试件）
    from kb_factory.channel_adapters.base import FileMeta
    from kb_factory.harvest_engine.adapters.book118 import (
        Book118Adapter, make_pdf_ocr_searchable, ocr_pages_lines)
except ImportError:
    from channel_adapters.base import FileMeta  # type: ignore
    from harvest_engine.adapters.book118 import (  # type: ignore
        Book118Adapter, make_pdf_ocr_searchable, ocr_pages_lines)

import pypdfium2 as pdfium  # noqa: E402
from PIL import Image, ImageDraw, ImageFont  # noqa: E402

_LIVE_SKIP = os.environ.get("KB_HARVEST_SKIP_LIVE") == "1"
_FIX_DIR = Path(__file__).resolve().parent / "fixtures"
GT_PATH = _FIX_DIR / "book118_gt.json"
PAGES_ROOT = _FIX_DIR / "book118_gt_pages"

_UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
       "(KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36")

#: 合成页 GT（誊录自 2026-10-22 验收同链实测 _probe_t33_step4.py 输出，人工确认；
#: 避开重采样行尾伪字「度/彣_」段）
SYNTH_TITLE = "某培训学院教学督导制度"
SYNTH_WORDS = ["教学督导委员会", "督导检查记录"]


# ---------------------------------------------------------------- 协议件（纯函数）

def _norm(text: str) -> str:
    """空白归一（容错=0 的抽取口径：只移除空白字符，字符级零容差）。"""
    return re.sub(r"\s+", "", text or "")


def _text_layer(pdf_path: Path) -> str:
    """pypdfium2 抽 PDF 文字层（全页 textpage 合并；FR3.AC2 验收唯一实测来源）。"""
    with pdfium.PdfDocument(str(pdf_path)) as doc:
        return "".join(p.get_textpage().get_text_range() for p in doc)


def _load_gt() -> dict:
    return json.loads(GT_PATH.read_text(encoding="utf-8"))


def _synthetic_page(out_path: Path) -> Path:
    """合成中文页（792×1120 白底 simhei 真画字，同 book118 页几何；零网络）。"""
    im = Image.new("RGB", (792, 1120), (255, 255, 255))
    d = ImageDraw.Draw(im)
    f_head = ImageFont.truetype(r"C:\Windows\Fonts\simhei.ttf", 28)
    f_title = ImageFont.truetype(r"C:\Windows\Fonts\simhei.ttf", 44)
    f_body = ImageFont.truetype(r"C:\Windows\Fonts\simhei.ttf", 30)
    d.text((396, 120), SYNTH_TITLE, font=f_head, fill=(80, 80, 80), anchor="ma")
    d.text((396, 260), "教学督导工作实施细则", font=f_title, fill=(0, 0, 0), anchor="ma")
    d.text((90, 420), "教学督导委员会负责全院教学质量的检查与评估。", font=f_body, fill=(0, 0, 0))
    d.text((90, 470), "督导检查记录按学期归档并定期通报。", font=f_body, fill=(0, 0, 0))
    im.save(out_path, format="PNG")
    return out_path


def _cached_first_page(doc_id: str) -> Path | None:
    """fixtures 缓存首页图（book118_gt_pages/{doc}/0001.{gif|png}；在位即零网络）。"""
    doc_dir = PAGES_ROOT / doc_id
    if doc_dir.is_dir():
        found = sorted(doc_dir.glob("0001.*"))
        if found and found[0].stat().st_size > 0:
            return found[0]
    return None


# ---------------------------------------------------------------- FR3.AC2 离线

def test_fr3_ac2_gt_json_protocol_shape():
    """GT 台账协议形状：3 份 fixture；标题≥4 字；每份恰 2 个≥4 字纯汉字词（可见词，
    不含页码/水印伪字）；shtm 链接可回溯（缺图时 live 重拉的锚点）。"""
    gt = _load_gt()
    fixtures = gt["fixtures"]
    assert len(fixtures) >= 3, f"任务卡口径=3 份 GT，当前 {len(fixtures)}"
    seen: set[str] = set()
    for fx in fixtures:
        doc_id = fx["doc_id"]
        assert re.fullmatch(r"\d{16}", doc_id), doc_id
        assert doc_id not in seen
        seen.add(doc_id)
        assert fx["shtm_url"].startswith("https://max.book118.com/html/")
        assert len(fx["title"]) >= 4
        assert len(fx["words"]) == 2
        for word in fx["words"]:
            assert len(word) >= 4, f"{doc_id} 词不足 4 字: {word!r}"
            assert re.fullmatch(r"[\u4e00-\u9fff]+", word), \
                f"{doc_id} 词须纯汉字可见词: {word!r}"
        assert fx["first_page_image"].startswith("book118_gt_pages/")


def test_fr3_ac2_ocr_pages_lines_filters_empty_lines():
    """OCR 钩子空文本行过滤：paddle 偶发空文本行，回注件拒空串（T34/docin 同坑）；
    注入行集确定性验证（识别函数注入，零网络零引擎）。"""
    try:
        from kb_factory.harvest_engine.render.ocr import OcrLine
    except ImportError:
        from harvest_engine.render.ocr import OcrLine  # type: ignore
    rows = [OcrLine("", 0.9, (0, 0, 1, 1)),
            OcrLine("教学督导", 0.99, (2, 2, 80, 20)),
            OcrLine("", 0.4, (0, 0, 1, 1)),
            OcrLine("检查记录", 0.98, (2, 22, 80, 40))]
    got = ocr_pages_lines([object()], lambda frame: rows)   # 单帧注入
    assert [ln.text for ln in got[0]] == ["教学督导", "检查记录"]  # 空行全滤
    assert ocr_pages_lines([], lambda frame: rows) == []     # 空帧集=空页集


def test_fr3_ac2_offline_synthetic_page_exact_match(tmp_path):
    """合成中文页全链（零网络真链）：PIL+simhei 真画字→像素拼 PDF→OCR 文字层钩子
    （150dpi 重采样+空行过滤）→pypdfium2 抽文字层→标题+2 词 3/3 精确命中（容错=0，
    空白归一后逐字子串）。"""
    try:
        from kb_factory.harvest_engine.pdf.image_pdf import build_image_pdf
    except ImportError:
        from harvest_engine.pdf.image_pdf import build_image_pdf  # type: ignore
    img = _synthetic_page(tmp_path / "syn.png")
    image_pdf = build_image_pdf([img], tmp_path / "syn.pdf")
    searchable = tmp_path / "syn_ocr.pdf"
    stats = make_pdf_ocr_searchable(image_pdf, searchable)
    assert stats.pages == 1 and stats.lines >= 3 and stats.chars >= 20  # 实测非手填
    layer = _norm(_text_layer(searchable))
    misses = [t for t in (SYNTH_TITLE, *SYNTH_WORDS) if _norm(t) not in layer]
    assert misses == [], f"容错=0 精确匹配未命中: {misses}; layer={layer!r}"


def test_fr3_ac2_ocr_layer_disabled_then_reapply(tmp_path):
    """挂参 ocr_layer=False 语义：像素 PDF 先行（image_pdf 在/页数实测），文字层不跑
    （searchable_pdf/manifest/gate 全空、ref_chars=0），无字数参照即不落 manifest 不跑
    质检门（load_manifest 硬拒 ref_chars<1，零造假）→verify_pdf 如实 False；后补文字层
    （钩子）+手写 manifest 后质检门 4/4=编排层「像素先行+文字层后补」全语义。"""
    try:
        from kb_factory.harvest_engine import quality_gate
    except ImportError:
        from harvest_engine import quality_gate  # type: ignore
    img = _synthetic_page(tmp_path / "syn.png")
    buf = io.BytesIO()
    with Image.open(img) as im:
        im.save(buf, format="PNG")
    png_bytes = buf.getvalue()

    def transport(url: str):
        return 200, png_bytes

    meta = FileMeta(title="教学督导工作实施细则.docx", fmt="doc", extra={
        "book118_doc_id": "9901331010032999",
        "book118_page_urls": {1: "//view-cache.book118.com/view1/M04/1@k=.png"},
        "book118_pages_preview": 1, "book118_pages_actual": 1})
    adapter = Book118Adapter(sleep=lambda s: None)
    result = adapter.harvest_preview_pdf(meta, tmp_path / "work",
                                         image_transport=transport, ocr_layer=False)
    assert result.image_pdf.exists() and result.pages == 1          # 像素 PDF 先行
    assert result.searchable_pdf is None and result.manifest_path is None \
        and result.manifest is None                                 # 无参照不伪造
    assert result.ref_chars == 0 and result.gate_outcomes == []
    assert "book118_manifest" not in meta.extra
    assert adapter.verify_pdf(result) is False                      # 无门果=不过（如实）
    # 后补文字层（编排层职责）：钩子→manifest→质检门→收口
    searchable = tmp_path / "work" / "late_ocr.pdf"
    stats = make_pdf_ocr_searchable(result.image_pdf, searchable)
    assert stats.chars >= 20
    assert _norm(SYNTH_TITLE) in _norm(_text_layer(searchable))     # GT 同词仍 3/3 可命中
    manifest = {"pdf_path": str(searchable), "ref_chars": int(stats.chars),
                "ref_chars_source": "book118", "expected_pages": 1}
    mpath = tmp_path / "work" / "late_manifest.json"
    mpath.write_text(json.dumps(manifest, ensure_ascii=False, indent=1), encoding="utf-8")
    gate = quality_gate.run_gate(quality_gate.load_manifest(mpath))
    assert all(g.passed for g in gate), [g.detail for g in gate]    # 质检门 4/4


# ---------------------------------------------------------------- FR3.AC2 实弹（GT 主验收）

def _pull_first_page_live(doc_id: str, shtm_url: str) -> Path:
    """缺缓存图时的活链重拉（.shtm 首跳→页清单→首页图直下；_probe_t33_step1.py 同链），
    拉到即落 fixtures 缓存（下次零网络）。"""
    import httpx
    try:
        from kb_factory.harvest_engine.adapters.book118 import image_url_pair
        from kb_factory.harvest_engine.assets.magic_check import sniff_format
    except ImportError:
        from harvest_engine.adapters.book118 import image_url_pair  # type: ignore
        from harvest_engine.assets.magic_check import sniff_format  # type: ignore
    from playwright.sync_api import sync_playwright

    with sync_playwright() as pw:
        browser = pw.chromium.launch(headless=True, args=["--proxy-server=direct://"])
        try:
            adapter = Book118Adapter(browser=browser)
            meta = FileMeta(title=doc_id, fmt="doc", source_url=shtm_url, extra={})
            ladder = adapter.fetch_ladder(adapter.plan(meta))
            assert ladder.ok, f"页清单腿失败: {ladder.detail}"
            urls = meta.extra["book118_page_urls"]
            page1 = urls.get(1) or urls.get("1")
            assert page1, f"页清单无第 1 页: keys={sorted(urls)[:5]}"
            https_u, http_u = image_url_pair(page1)
            body = b""
            with httpx.Client(timeout=30.0, trust_env=False,
                              headers={"User-Agent": _UA}) as http:
                for target in (https_u, http_u):
                    r = http.get(target)
                    if r.status_code == 200 and r.content:
                        body = r.content
                        break
            assert body, f"首页图直下失败: {doc_id}"
            fmt = sniff_format(body)
            assert fmt in ("gif", "png"), f"魔数词表外: {fmt!r}"
            out_dir = PAGES_ROOT / doc_id
            out_dir.mkdir(parents=True, exist_ok=True)
            path = out_dir / f"0001.{fmt}"
            path.write_bytes(body)
            return path
        finally:
            browser.close()


@pytest.mark.live
def test_fr3_ac2_live_gt_three_fixtures(tmp_path):
    """FR3.AC2 主验收：三份 GT（免费/收费/全预览三形态）逐份——首页图（缓存优先，
    缺则活链重拉）→像素拼 PDF→OCR 文字层钩子→pypdfium2 抽文字层→标题+2 词精确匹配
    （容错=0），3/3 命中=该份过；三份全过。"""
    if _LIVE_SKIP:
        print("[live-skip] KB_HARVEST_SKIP_LIVE=1：GT 三份实弹用例跳过（CI 场景明示）")
        pytest.skip("[live-skip] KB_HARVEST_SKIP_LIVE=1 GT 三份跳过")
    try:
        from kb_factory.harvest_engine.pdf.image_pdf import build_image_pdf
    except ImportError:
        from kb_factory.harvest_engine.pdf.image_pdf import build_image_pdf  # type: ignore
    gt = _load_gt()
    passed = 0
    for fx in gt["fixtures"]:
        doc_id = fx["doc_id"]
        img = _cached_first_page(doc_id)
        if img is None:
            img = _pull_first_page_live(doc_id, fx["shtm_url"])
            print(f"[live] {doc_id}: 缓存图缺，活链重拉 -> {img.name}")
        work = tmp_path / doc_id
        work.mkdir(parents=True, exist_ok=True)
        image_pdf = build_image_pdf([img], work / "page1.pdf")
        searchable = work / "page1_ocr.pdf"
        stats = make_pdf_ocr_searchable(image_pdf, searchable)
        layer = _norm(_text_layer(searchable))
        terms = [fx["title"], *fx["words"]]
        hits = [t for t in terms if _norm(t) in layer]
        misses = [t for t in terms if _norm(t) not in layer]
        print(f"[live] {doc_id} [{fx['form']}] chars={stats.chars} lines={stats.lines} "
              f"hits={len(hits)}/3" + (f" misses={misses}" if misses else ""))
        assert len(hits) == 3, \
            f"{doc_id} 容错=0 精确匹配 {len(hits)}/3，未命中={misses}；" \
            f"norm_layer 首末={layer[:60]!r}..{layer[-60:]!r}"
        passed += 1
    assert passed == len(gt["fixtures"]) == 3   # 脚本对 3 份 GT 全过
