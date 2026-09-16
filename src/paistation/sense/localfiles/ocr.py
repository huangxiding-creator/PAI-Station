"""WinRT OCR 子系统：扫描件 PDF 收编（2026-09-17 落地）。

Windows 10+ 自带离线中文 OCR（zh-Hans-CN 语言包），经 winsdk 从
Python 直调——零模型下载、零外部服务，真机实测 0.5s/页，白龟湖
支付凭证扫描件核心数字（合同额/已付/尾款）全量识别。

管线：pymupdf 200dpi 栅格化 → InMemoryRandomAccessStream →
BitmapDecoder → OcrEngine.recognize_async。WinRT 逐词输出会在
汉字间插空格（"平 顶 山"），trigram 检索会因此查不到"平顶山"——
squeeze_ocr_spaces 必须在入库前归一。

页数上限：OCR 是真计算不是挂死，40 页×0.5s≈20s 预算内；超页
文件截断并在文内标注，保批吞吐不被百页卷宗拖垮。
"""
from __future__ import annotations

import asyncio
import re

OCR_VER = "winrt-ocr1"
OCR_DPI = 200
OCR_MAX_PAGES = 40

# CJK 相邻（含全角标点）间空格删除；全角标点周围空格归一
_CJK = r"　-鿿＀-￯"
_CJK_GAP = re.compile(f"(?<=([{_CJK}])) +(?=[{_CJK}])")
_EDGE_GAP = re.compile(r" ?([，。；：、！？）】」》]) ?")
# 数字间 WinRT 间隔号（小数点误识）：『244 · 378』『2020 · 12 · 29』
# → 小数点形态——否则检索『244.378』永远查不到（09-17 支付凭证实锤）
_NUM_DOT = re.compile(r"(?<=\d) ?[·°。・] ?(?=\d)")

_engine = None  # 进程级缓存：OcrEngine 单例


class OcrUnavailable(Exception):
    """OCR 引擎不在位（无语言包/winsdk 缺席）——上层回退原错误。"""


def squeeze_ocr_spaces(text: str) -> str:
    """WinRT 逐词空格归一：汉字间空格删除，标点贴边。

    实测样本：『平 顶 山 市 白 龟 湖 … 合 同 金 额 为 3691 ， 409』
    → 『平顶山市白龟湖…合同金额为 3691，409』。英文单词间空格保留。
    """
    out = _NUM_DOT.sub(".", text)
    out = _CJK_GAP.sub("", out)
    return _EDGE_GAP.sub(r"\1", out)


def has_ocr() -> bool:
    """引擎探测（进程缓存）：用户档案语言里有 OCR 识别器即真。"""
    try:
        return _get_engine() is not None
    except OcrUnavailable:
        return False


def _get_engine():
    global _engine
    if _engine is None:
        try:
            from winsdk.windows.media.ocr import OcrEngine
        except Exception as exc:  # winsdk 缺席
            raise OcrUnavailable(f"winsdk 不在位: {exc}") from exc
        _engine = OcrEngine.try_create_from_user_profile_languages()
        if _engine is None:
            raise OcrUnavailable("用户语言无 OCR 识别器（缺语言包）")
    return _engine


def ocr_pdf(path: str, dpi: int = OCR_DPI,
            max_pages: int = OCR_MAX_PAGES) -> str:
    """扫描件 PDF → 文本。页间 \\n\\n；超页截断并文内标注。"""
    try:
        return asyncio.run(_ocr_pdf_async(path, dpi, max_pages))
    except OcrUnavailable:
        raise
    except Exception as exc:  # 渲染/解码失败按提取失败口径上抛
        raise OcrUnavailable(f"OCR 管线故障: {exc}") from exc


async def _ocr_pdf_async(path: str, dpi: int, max_pages: int) -> str:
    import pymupdf
    import winsdk.windows.storage.streams as streams
    from winsdk.windows.graphics.imaging import BitmapDecoder

    engine = _get_engine()
    parts: list[str] = []
    with pymupdf.open(path) as pdf:
        pages = pdf.page_count
        for i in range(min(pages, max_pages)):
            png = pdf[i].get_pixmap(dpi=dpi).tobytes("png")
            st = streams.InMemoryRandomAccessStream()
            dw = streams.DataWriter(st.get_output_stream_at(0))
            dw.write_bytes(png)
            await dw.store_async()
            dec = await BitmapDecoder.create_async(st)
            bmp = await dec.get_software_bitmap_async()
            parts.append((await engine.recognize_async(bmp)).text)
        if pages > max_pages:
            parts.append(f"[OCR 截断：共 {pages} 页，收编前 {max_pages} 页]")
    return squeeze_ocr_spaces("\n\n".join(parts))
