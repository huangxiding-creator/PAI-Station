# -*- coding: utf-8 -*-
"""FR3.2 单测：OCR 文字层二级管线（pypdfium2 抽帧 150dpi → paddleocr 识别 → 回注可搜索 PDF）。

- 驱动体=PIL 本地样图（792×1120 屏幕级，BOOK118 预览图口径，SYNTHESIS §4-13）：
  draw 中文若干词（msyh.ttc）→ 组纯图 PDF → 二级管线回注 → pypdfium2 抽文本断言。
- 验收门：识别词命中 ≥80%（zero-mock：paddleocr 真模型本地推理，模型首跑自动下载已缓存）。
- 字体双源：画图用 msyh.ttc（PIL 可开 ttc）；PDF 回注嵌 simhei.ttf（FPDFText_LoadFont 实测 TTF）。
"""
import re
import sys
from pathlib import Path

_KB_DIR = Path(__file__).resolve().parents[2]  # kb_factory/
sys.path.insert(0, str(_KB_DIR))  # worktree 阶段 kb_factory 无 __init__.py：顶层导入 harvest_engine

import pypdfium2 as pdfium  # noqa: E402
from PIL import Image, ImageDraw, ImageFont  # noqa: E402

try:  # 合并后正名 kb_factory.harvest_engine.*；worktree 阶段回退顶层名
    from kb_factory.harvest_engine.render.ocr import (  # noqa: E402
        DEFAULT_DPI, build_searchable_pdf, get_engine, make_pdf_searchable,
        ocr_image, render_pages, reset_engine)
except ImportError:
    from harvest_engine.render.ocr import (  # noqa: E402
        DEFAULT_DPI, build_searchable_pdf, get_engine, make_pdf_searchable,
        ocr_image, render_pages, reset_engine)

MSYH = Path(r"C:\Windows\Fonts\msyh.ttc")   # 画样图（PIL 支持 ttc）
SIMHEI = Path(r"C:\Windows\Fonts\simhei.ttf")  # 回注嵌字体（FPDFText_LoadFont 实测 TTF）

_WORDS = ["水利枢纽工程", "溢洪道", "闸门启闭机", "施工导流", "混凝土重力坝", "质量检测评定"]


def _sample_image() -> Image.Image:
    """本地样图：792×1120 屏幕级白底 + 6 个中文词（黑体大字号，屏幕级可识别口径）。"""
    img = Image.new("RGB", (792, 1120), "white")
    draw = ImageDraw.Draw(img)
    font = ImageFont.truetype(str(MSYH), 54)
    for i, word in enumerate(_WORDS):
        draw.text((90, 110 + i * 165), word, fill="black", font=font)
    return img


def _norm(text: str) -> str:
    return re.sub(r"\s+", "", text)


def _page_text(pdf_path) -> str:
    with pdfium.PdfDocument(str(pdf_path)) as doc:
        return "".join(page.get_textpage().get_text_range() for page in doc)


def test_fr32_ac1_image_pdf_to_searchable_round_trip(tmp_path):
    """FR3.2 验收链：样图→纯图 PDF（回注前零文字）→二级管线（抽帧150dpi+识别+回注）→命中≥80%。"""
    img = _sample_image()
    plain_pdf = tmp_path / "plain.pdf"
    stats_plain = build_searchable_pdf([img], [[]], plain_pdf)  # 纯图 PDF：空文字层
    assert stats_plain.pages == 1 and stats_plain.lines == 0 and stats_plain.chars == 0
    assert _page_text(plain_pdf) == ""  # 回注前无可搜索文本（图片型 PDF 事实）

    out_pdf = tmp_path / "searchable.pdf"
    stats = make_pdf_searchable(plain_pdf, str(out_pdf), dpi=DEFAULT_DPI)
    assert stats.pages == 1 and stats.dpi == DEFAULT_DPI
    assert stats.lines >= 1 and stats.chars >= 1  # 实测统计（数字零造假）

    text = _norm(_page_text(out_pdf))
    hits = [w for w in _WORDS if w in text]
    assert len(hits) / len(_WORDS) >= 0.8, f"识别词命中不足80%: {len(hits)}/{len(_WORDS)} 命中={hits}"


def test_fr32_ac2_render_pages_dpi_contract(tmp_path):
    """抽帧契约：150dpi 渲 792×1120 页 → 回到 792×1120 像素（屏幕级口径不漂移）。

    pypdfium2 位图尺寸=ceil(页宽×scale)（380.16pt×150/72=792.0000001→793）：
    实测存在 ±1px 栅格化量化（右/下缘白填充），契约按 ±1px 收口，dpi 换算本体不漂移。
    """
    img = _sample_image()
    plain_pdf = tmp_path / "dpi.pdf"
    build_searchable_pdf([img], [[]], plain_pdf, dpi=DEFAULT_DPI)
    frames = render_pages(plain_pdf, dpi=DEFAULT_DPI)
    assert len(frames) == 1
    width, height = frames[0].size
    assert abs(width - 792) <= 1 and abs(height - 1120) <= 1, f"150dpi 抽帧漂移: {(width, height)}"


def test_fr32_ac3_ocr_lines_geometry_and_scores():
    """识别行契约：文本非空、分值∈[0,1]、像素盒在图像界内且 x0<x1/y0<y1。"""
    img = _sample_image()
    lines = ocr_image(img)
    assert lines, "样图至少识别出一行"
    for line in lines:
        assert line.text.strip()
        assert 0.0 <= line.score <= 1.0
        x0, y0, x1, y1 = line.box
        assert 0 <= x0 < x1 <= img.width and 0 <= y0 < y1 <= img.height, f"越界盒: {line.box}"
    joined = _norm("".join(line.text for line in lines))
    assert any(w in joined for w in _WORDS), f"样词全未命中: {joined[:80]}"


def test_fr32_ac4_engine_lazy_singleton():
    """OCR 实例懒加载单例：同进程同对象；reset 后才重建（避免重复初始化模型）。"""
    e1 = get_engine()
    e2 = get_engine()
    assert e1 is e2
    reset_engine()
    e3 = get_engine()
    assert e3 is not e1


def test_fr7_ac1_make_pdf_searchable_measured_stats(tmp_path):
    """FR7 支撑件口径：stats 为实测产出（页数=帧数、行数=识别行数、字数=逐行累加），不手填。"""
    img = _sample_image()
    lines = ocr_image(img)
    assert lines, "前置：识别出行"
    out_pdf = tmp_path / "stats.pdf"
    stats = build_searchable_pdf([img], [lines], out_pdf)
    assert stats.pages == 1
    assert stats.lines == len(lines)
    assert stats.chars == sum(len(line.text) for line in lines) > 0
    assert out_pdf.stat().st_size > 1000  # 实体文件非空


def test_fr32_ac5_multi_page_pipeline(tmp_path):
    """多页管线：两页样图 → 纯图 PDF → 二级管线逐页回注，逐页均可抽文本。"""
    imgs = [_sample_image(), _sample_image()]
    plain_pdf = tmp_path / "multi_plain.pdf"
    build_searchable_pdf(imgs, [[], []], plain_pdf)
    out_pdf = tmp_path / "multi.pdf"
    stats = make_pdf_searchable(plain_pdf, str(out_pdf))
    assert stats.pages == 2
    with pdfium.PdfDocument(str(out_pdf)) as doc:
        assert len(doc) == 2
        for page in doc:
            page_text = _norm(page.get_textpage().get_text_range())
            hits = [w for w in _WORDS if w in page_text]
            assert len(hits) / len(_WORDS) >= 0.8, f"某页命中不足: {hits}"
