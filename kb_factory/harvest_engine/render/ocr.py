# -*- coding: utf-8 -*-
"""OCR 文字层件（T13，支撑 FR3.2/FR7）：pypdfium2 抽帧 → paddleocr 识别 → 文字层回注可搜索 PDF。

统一语言（CONTEXT.md）：
- 文字层=图片型 PDF 补可搜索文本的二级管线件；BOOK118 纯图预览 PDF（792×1120 屏幕级）
  与 L3 渲染兜底共用（FR3.2/FR7.1）。
- 本件只做「抽帧/识别/回注」三步；L3 编排（Playwright 截图→拼PDF→调本件）属
  render/fallback（T28），book118 GT 取词协议属 adapters/book118（T33）。

二级管线（唯一权威序）：
  render_pages(pdf, dpi=150)  →  ocr_image(帧)  →  build_searchable_pdf(帧, 行, dpi)
  make_pdf_searchable() = 三步串联的入口。

回注原理（纯 pypdfium2，无 AGPL 件）：
- 每页 FPDFPage_New（宽高=像素×72/dpi）→ 先插文字对象（FPDFPageObj_CreateTextObj
  +FPDFText_SetText，simhei CID 子集嵌入）→ 后插整页图片对象（FPDFBitmap_CreateEx
  BGRA + FPDFImageObj_SetBitmap）：内容流序=先文字后图，图盖文字→视觉零扰动、文本可抽取。

实测口径（2026-10-22，py3.13 + paddleocr 3.7.0 + paddlepaddle 3.3.1 win-cpu）：
- paddleocr 包不自带推理框架：paddlepaddle 需另装（本机补装 3.3.1，win py3.13 有轮）。
- 模型首跑自动下载（PP-OCRv6_medium_det/rec，~/.paddlex/official_models，联网），此后离线。
- onednn 坑：win-cpu 需 enable_mkldnn=False，否则 NotImplementedError
  (ConvertPirAttribute2RuntimeAttribute, onednn_instruction.cc)。
- API 代际：3.x predict() → OCRResult（rec_texts/rec_scores/rec_boxes=x0,y0,x1,y1 像素）；
  2.x ocr() → [[ [quad,(text,score)], ... ]]。本机 3.7 走前者，后者为兼容兜底。
"""
import ctypes
import threading
from dataclasses import dataclass, field
from pathlib import Path

import numpy as np
import pypdfium2 as pdfium
import pypdfium2.raw as pdfium_c
from PIL import Image

__all__ = [
    "DEFAULT_DPI", "OcrLine", "SearchablePdfStats", "build_searchable_pdf",
    "get_engine", "make_pdf_searchable", "ocr_image", "render_pages", "reset_engine",
]

DEFAULT_DPI = 150  # 屏幕级预览图口径（BOOK118 792×1120；FR7 L3 同参）

# 回注嵌字体候选（FPDFText_LoadFont 实测 TTF 可嵌；ttc 有解析风险不入列）
CJK_FONT_CANDIDATES = (
    r"C:\Windows\Fonts\simhei.ttf",
    r"C:\Windows\Fonts\Deng.ttf",
)

_ENGINE = None
_ENGINE_LOCK = threading.Lock()


@dataclass
class OcrLine:
    """单识别行：像素盒（图像左上原点 x0,y0,x1,y1）+ 文本 + 置信分。"""

    text: str
    score: float
    box: tuple  # (x0, y0, x1, y1) 像素


@dataclass
class SearchablePdfStats:
    """二级管线产物实测统计（数字零造假：页数=帧数、行数=识别行数、字数=逐行累加）。"""

    pages: int = 0
    lines: int = 0
    chars: int = 0
    dpi: int = DEFAULT_DPI
    per_page: list = field(default_factory=list)  # 每页行数（int 列表）


def get_engine():
    """paddleocr 实例懒加载单例（线程锁双检；首建下载/加载模型，此后进程内复用）。"""
    global _ENGINE
    if _ENGINE is None:
        with _ENGINE_LOCK:
            if _ENGINE is None:
                from paddleocr import PaddleOCR  # 延迟导入：模块导入不拖引擎启动

                _ENGINE = PaddleOCR(
                    use_doc_orientation_classify=False,
                    use_doc_unwarping=False,
                    use_textline_orientation=False,
                    lang="ch",
                    enable_mkldnn=False,  # win-cpu onednn 指令坑绕行（见模块 docstring）
                )
    return _ENGINE


def reset_engine() -> None:
    """丢弃单例（测试/换语言参数用）；下次 get_engine 重建。"""
    global _ENGINE
    with _ENGINE_LOCK:
        _ENGINE = None


def _quad_to_bbox(quad) -> tuple:
    """四点框 → 轴对齐盒（2.x rec_polys 兜底路径）。"""
    xs = [float(p[0]) for p in quad]
    ys = [float(p[1]) for p in quad]
    return (min(xs), min(ys), max(xs), max(ys))


def _lines_from_result(result) -> list:
    """paddleocr 结果 → [OcrLine]；3.x（dict 键）优先，2.x（[quad,(text,score)]）兜底。"""
    lines: list[OcrLine] = []
    if result is None:
        return lines
    pages = result if isinstance(result, list) else [result]
    for page in pages:
        if page is None:
            continue
        if hasattr(page, "keys"):  # 3.x OCRResult（本机 3.7 实测）
            texts = list(page.get("rec_texts") or [])
            scores = list(page.get("rec_scores") or [])
            boxes = page.get("rec_boxes")
            if boxes is None:  # 部分版本只有 rec_polys
                polys = list(page.get("rec_polys") or [])
                boxes = [_quad_to_bbox(p) for p in polys]
            for i, text in enumerate(texts):
                score = float(scores[i]) if i < len(scores) else 0.0
                box = boxes[i] if i < len(boxes) else (0, 0, 0, 0)
                lines.append(OcrLine(text=text, score=score,
                                     box=(float(box[0]), float(box[1]),
                                          float(box[2]), float(box[3]))))
        else:  # 2.x：page = [ [quad,(text,score)], ... ]
            for item in page:
                quad, (text, score) = item[0], item[1]
                lines.append(OcrLine(text=text, score=float(score), box=_quad_to_bbox(quad)))
    return lines


def ocr_image(image: Image.Image) -> list:
    """单帧识别：PIL 图 → [OcrLine]（盒坐标=该图像像素系）。"""
    engine = get_engine()
    if hasattr(engine, "predict"):  # 3.x
        result = engine.predict(np.asarray(image.convert("RGB")))
    else:  # 2.x 兜底
        result = engine.ocr(np.asarray(image.convert("RGB")), cls=True)
    return _lines_from_result(result)


def render_pages(pdf_path, dpi: int = DEFAULT_DPI) -> list:
    """抽帧：pypdfium2 按 dpi 渲每页为 PIL 图（scale=dpi/72）。"""
    frames = []
    with pdfium.PdfDocument(str(pdf_path)) as doc:
        for page in doc:
            frames.append(page.render(scale=dpi / 72.0).to_pil())
    return frames


def _load_cjk_font_path() -> Path:
    for candidate in CJK_FONT_CANDIDATES:
        path = Path(candidate)
        if path.exists():
            return path
    raise RuntimeError(
        f"回注需 CID 字体，候选全缺失: {CJK_FONT_CANDIDATES}（部署机请装其一）")


def _add_text_layer(doc_raw, page_raw, font, line: OcrLine,
                    pt_per_px: float, page_h_pt: float) -> bool:
    """插单行文字对象（在图之前插入 → 被图盖住，仅作可搜索层）。"""
    x0, y0, x1, y1 = line.box
    size_px = max(y1 - y0, 1.0)
    obj = pdfium_c.FPDFPageObj_CreateTextObj(doc_raw, font, size_px * pt_per_px)
    if not obj:
        return False
    utf16 = line.text.encode("utf-16-le")
    chars = (ctypes.c_ushort * (len(utf16) // 2)).from_buffer_copy(utf16)
    if not pdfium_c.FPDFText_SetText(obj, chars):
        return False
    matrix = pdfium_c.FS_MATRIX(1, 0, 0, 1,
                                x0 * pt_per_px, page_h_pt - y1 * pt_per_px)  # 左上原点→PDF左下原点
    if not pdfium_c.FPDFPageObj_TransformF(obj, ctypes.byref(matrix)):
        return False
    return bool(pdfium_c.FPDFPage_InsertObject(page_raw, obj))


def _add_image_page(doc_raw, page_raw, image: Image.Image, pt_per_px: float) -> bool:
    """插整页图片对象（BGRA 外缓冲；在文字之后插入 → 盖住文字层）。"""
    width, height = image.size
    rgba = np.asarray(image.convert("RGBA"))
    bgra = np.ascontiguousarray(rgba[..., [2, 1, 0, 3]]).tobytes()  # RGBA→BGRA（通道 [2,1,0,3]）
    buf = ctypes.create_string_buffer(bgra, len(bgra))
    bitmap = pdfium_c.FPDFBitmap_CreateEx(
        width, height, pdfium_c.FPDFBitmap_BGRA,
        ctypes.cast(buf, ctypes.c_void_p), width * 4)
    if not bitmap:
        return False
    image_obj = pdfium_c.FPDFPageObj_NewImageObj(doc_raw)
    if not image_obj:
        return False
    pages_arr = ctypes.cast(
        (ctypes.c_void_p * 1)(ctypes.cast(page_raw, ctypes.c_void_p).value),
        pdfium_c.FPDFImageObj_SetBitmap.argtypes[0])
    if not pdfium_c.FPDFImageObj_SetBitmap(pages_arr, 1, image_obj, bitmap):
        return False
    w_pt, h_pt = width * pt_per_px, height * pt_per_px
    if not pdfium_c.FPDFImageObj_SetMatrix(image_obj, w_pt, 0, 0, h_pt, 0, 0):
        return False
    return bool(pdfium_c.FPDFPage_InsertObject(page_raw, image_obj))


def build_searchable_pdf(images, pages_lines, out_path, dpi: int = DEFAULT_DPI) -> SearchablePdfStats:
    """帧×行 → 可搜索 PDF（每页=文字层在下+整页图在上；视觉零扰动、pypdfium2 可抽文本）。

    pages_lines 与 images 等长；某页传 [] 即纯图页（回注前口径）。
    """
    if len(images) != len(pages_lines):
        raise ValueError(f"帧数({len(images)})与页行数({len(pages_lines)})不一致")
    pt_per_px = 72.0 / dpi
    font_path = _load_cjk_font_path()
    font_bytes = font_path.read_bytes()
    font_buf = ctypes.create_string_buffer(font_bytes, len(font_bytes))  # 持活至 save
    stats = SearchablePdfStats(pages=len(images), dpi=dpi)
    doc = pdfium.PdfDocument.new()
    try:
        doc_raw = doc.raw
        font = pdfium_c.FPDFText_LoadFont(
            doc_raw, ctypes.cast(font_buf, ctypes.POINTER(ctypes.c_ubyte)),
            len(font_bytes), 2, 1)  # type=2(TrueType) cid=1（中文必需）
        if not font:
            raise RuntimeError(f"CID 字体装载失败: {font_path}")
        for image, lines in zip(images, pages_lines):
            page_h_pt = image.height * pt_per_px
            page = doc.new_page(image.width * pt_per_px, page_h_pt)
            page_raw = page.raw
            for line in lines:  # 先文字（在下）
                if not _add_text_layer(doc_raw, page_raw, font, line, pt_per_px, page_h_pt):
                    raise RuntimeError(f"文字行回注失败: {line.text!r}")
            if not _add_image_page(doc_raw, page_raw, image, pt_per_px):  # 后图（在上）
                raise RuntimeError(f"整页图注入失败: {image.size}")
            if not pdfium_c.FPDFPage_GenerateContent(page_raw):
                raise RuntimeError(f"页内容生成失败: {image.size}")
            stats.per_page.append(len(lines))
            stats.lines += len(lines)
            stats.chars += sum(len(line.text) for line in lines)  # 实测累加
        doc.save(str(out_path))
    finally:
        doc.close()
    return stats


def make_pdf_searchable(src_pdf, dst_pdf, dpi: int = DEFAULT_DPI) -> SearchablePdfStats:
    """二级管线入口：抽帧(dpi) → 逐页识别 → 回注可搜索 PDF → 实测统计。"""
    frames = render_pages(src_pdf, dpi=dpi)
    pages_lines = [ocr_image(frame) for frame in frames]
    return build_searchable_pdf(frames, pages_lines, dst_pdf, dpi=dpi)
