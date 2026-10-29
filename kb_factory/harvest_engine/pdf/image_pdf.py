# -*- coding: utf-8 -*-
"""图像像素拼 PDF（FR3.1：按图像实际像素定页拼 PDF；FR7.1 L3 截图链同件复用）。

统一语言（CONTEXT.md）：像素拼页——每图一页，页几何=图实际像素，页序=传入序。
方案=img2pdf 零重编码嵌入：可直嵌格式（JPEG/PNG/TIFF/JP2）原文件字节透传，不做
二次有损压缩；GIF89a 等其余格式 PIL 转 RGB PNG（等价重排，几何不变）后嵌入。
版式=固定 72dpi（1px=1pt）：pypdfium2 读回页宽高（pt）与源图像素数严格相等，
零近似——NFR-GATE① 页数与几何断言即用此口径。
铁律（NFR6 GPL 隔离）：禁 fitz/PyMuPDF（AGPL）；本件零 fitz import。
"""
from __future__ import annotations

import io
from pathlib import Path
from typing import Sequence

import img2pdf
from PIL import Image

PX_TO_PT_DPI = 72  # 1px=1pt：读回页宽高==像素数（整数级相等口径）

# 固定 dpi 版式器：img2pdf 按此把像素换算成 PDF 点，72/72 ⇒ 数值上一一对应
_LAYOUT_ONE_PX_IS_ONE_PT = img2pdf.get_fixed_dpi_layout_fun((PX_TO_PT_DPI, PX_TO_PT_DPI))

# img2pdf 可零重编码直嵌的输入格式（PIL format 口径）
_DIRECT_EMBED_FORMATS = frozenset({"JPEG", "PNG", "TIFF", "JPEG2000"})


def _has_alpha(im: Image.Image) -> bool:
    """图是否带透明通道（img2pdf 拒收 alpha，须先铺白底压平）。"""
    return im.mode in ("RGBA", "LA") or (im.mode == "P" and "transparency" in im.info)


def _embeddable_image_bytes(path: Path) -> bytes:
    """返回可直接交给 img2pdf 的图字节。

    - 可直嵌格式且无 alpha：原文件字节透传（零重编码，NFR-GATE 同源等价（像素透传）口径）；
    - GIF89a/BMP/WebP/带 alpha 等：PIL 铺白底转 RGB PNG（等价重排，几何不变）。
    """
    with Image.open(path) as im:
        fmt = (im.format or "").upper()
        if fmt in _DIRECT_EMBED_FORMATS and not _has_alpha(im):
            return path.read_bytes()
        base = Image.new("RGB", im.size, (255, 255, 255))  # alpha 铺白底（GIF87a/89a 无 alpha 走同路等价重排）
        rgba = im.convert("RGBA")
        base.paste(rgba, mask=rgba.getchannel("A"))
        buf = io.BytesIO()
        base.save(buf, format="PNG")
        return buf.getvalue()


def build_image_pdf(image_paths: Sequence[Path | str], out_pdf: Path | str,
                    title: str | None = None) -> Path:
    """按传入序把图片拼成 PDF：每图一页，页几何=图实际像素（1px=1pt）。

    :param image_paths: 图片路径序列（页序=此序）；单路径 str/Path 自动包单元素列。
    :param out_pdf: 输出 PDF 路径（父目录自动建）。
    :param title: 可选 PDF 元数据标题。
    :return: 实际落盘的 PDF 路径（页数/几何由调用方 pypdfium2 实测，数字零造假）。
    :raises ValueError: 空图组（调用方 bug，显式拒绝而非产 0 页 PDF）。
    """
    if isinstance(image_paths, (str, Path)):
        image_paths = [image_paths]
    paths = [Path(p) for p in image_paths]
    if not paths:
        raise ValueError("image_paths 为空：至少传 1 张图（像素拼页不产 0 页 PDF）")

    payload = [_embeddable_image_bytes(p) for p in paths]
    out = Path(out_pdf)
    out.parent.mkdir(parents=True, exist_ok=True)
    out.write_bytes(img2pdf.convert(payload, layout_fun=_LAYOUT_ONE_PX_IS_ONE_PT, title=title))
    return out
