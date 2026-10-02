# -*- coding: utf-8 -*-
"""PDF 个人码尾页（3c）——水印版下载追加个人归因尾页，裂变环闭合。

水印（download 域）回答「泄漏源是谁」；本模块回答「传播出去的每一份
PDF 都在替购买者拉新」：末页=品牌头+报告题+个人专属小程序码+CTA。
扫码者经 invite 首触归因进入小程序，购买者计入有效带新（v1.2 §六）——
下载物从「被防盗的资产」升级为「可溯源的分享物料」。

码源与邀请海报同池同 scene：ensure_scene(rid, uid, 'poster')——一码两用
（海报分享与 PDF 转传共用码池图与归因计数，不为尾页单灌码）；码池未灌
时渲染可见占位（poster._draw_qr_placeholder 降级纪律，绝不冒充真码）。

渲染链：PIL 画 CJK 页（NotoSansSC）→ save(format='PDF') 单页 → pypdf
追加到水印产物后；磁盘缓存 *_p.pdf 幂等；任何失败降级=原水印版照发
（尾页是增益不是依赖，下载主链不得被尾页拖挂）。
"""
from __future__ import annotations

import logging
import os
import tempfile
from io import BytesIO
from pathlib import Path

from PIL import Image, ImageDraw
from pypdf import PdfReader, PdfWriter

from . import config
from .poster import (_FontKit, _draw_qr_placeholder, _ellipsize, _wrap,
                     ensure_scene, qr_pool_path)

logger = logging.getLogger("xueyuan.pdftail")

# 版式常量（对齐 poster.TEMPLATE 色系；改版式升本注释）
NAVY = (17, 58, 102)
NAVY_META = (201, 216, 236)
AMBER = (240, 169, 59)
INK = (42, 53, 66)
GRAY = (90, 107, 127)
BG = (246, 247, 249)
MARGIN = 96
QR_SIZE = 420
DISCLAIMER = "行业研究，非投资建议；决策自担。"   # 页脚免责一行版（AGREEMENT §八逐字）
TAIL_NOTE = "本文件含购买者专属溯源水印，仅供本人工作参考"
TAIL_SUB = "扫码进入总包学园 · 更多行业商机情报"
A4_ASPECT = 842 / 595


def render_tail_page(report: dict, qr_bytes: bytes | None,
                     aspect: float = A4_ASPECT) -> Image.Image:
    """个人尾页整页（宽 1240，高按源 PDF 首页纵横比；A4 默认）。"""
    w = 1240
    h = max(round(w * aspect), 1400)   # 极矮页兜底：内容仍须放得下
    img = Image.new("RGB", (w, h), BG)
    d = ImageDraw.Draw(img)
    kit = _FontKit()
    d.rectangle([0, 0, w, 300], fill=NAVY)   # 品牌头（navy 满宽条）
    d.text((MARGIN, 96), config.POSTER_BRAND, font=kit.bold(88), fill="white")
    d.text((MARGIN, 196), config.POSTER_BRAND_SUB, font=kit.regular(44), fill=NAVY_META)
    y = 380
    d.text((MARGIN, y), "行业研究报告 · 购买版", font=kit.bold(40), fill=AMBER)
    y += 88
    title = str(report.get("title") or report.get("id") or "")
    for ln in _ellipsize(_wrap(d, title, kit.bold(64), w - 2 * MARGIN), 3):
        d.text((MARGIN, y), ln, font=kit.bold(64), fill=INK)
        y += round(64 * 1.3)
    y += 36
    d.text((MARGIN, y), TAIL_NOTE, font=kit.regular(36), fill=GRAY)
    card = QR_SIZE + 2 * 36   # 码区（居中白卡）
    cx = (w - card) // 2
    cy = min(h - 560, y + 120)
    d.rounded_rectangle([cx, cy, cx + card, cy + card], radius=32, fill="white")
    if qr_bytes:
        with Image.open(BytesIO(qr_bytes)) as q:
            img.paste(q.convert("RGB").resize((QR_SIZE, QR_SIZE), Image.LANCZOS),
                      (cx + 36, cy + 36))
    else:
        _draw_qr_placeholder(d, cx + 36, cy + 36, QR_SIZE, kit)
    ty = cy + card + 56
    d.text((w // 2, ty), config.POSTER_CTA, font=kit.bold(48), fill=NAVY, anchor="ma")
    d.text((w // 2, ty + 76), TAIL_SUB, font=kit.regular(36), fill=GRAY, anchor="ma")
    d.text((w // 2, h - 72), DISCLAIMER, font=kit.regular(34), fill=GRAY, anchor="ma")
    return img


def _tail_pdf_bytes(img: Image.Image) -> bytes:
    """PIL 图 → 单页 PDF 字节（PIL 内建 PDF 写出，JPEG 编码，零新依赖）。"""
    out = BytesIO()
    img.convert("RGB").save(out, format="PDF")
    return out.getvalue()


def personalize(wm_pdf: Path, rid: str, uid: str, report: dict) -> Path:
    """水印版追加个人尾页（磁盘缓存 *_p.pdf 幂等）；任何失败降级返回原路径。

    scene 落库（poster_code）与码池读取都在 try 内：无 DB/无字体的最坏
    情况也只是「少一页增值内容」，下载主链不受影响。
    """
    dst = wm_pdf.with_name(wm_pdf.stem + "_p.pdf")
    if dst.exists():
        return dst
    try:
        reader = PdfReader(str(wm_pdf))
        aspect = (float(reader.pages[0].mediabox.height)
                  / float(reader.pages[0].mediabox.width)
                  ) if reader.pages else A4_ASPECT
        scene = ensure_scene(rid, uid, "poster")   # 与邀请海报同源同池
        qp = qr_pool_path(scene)
        qr_bytes = qp.read_bytes() if qp.exists() else None
        tail = PdfReader(BytesIO(_tail_pdf_bytes(
            render_tail_page(report, qr_bytes, aspect)))).pages[0]
        writer = PdfWriter()
        for page in reader.pages:
            writer.add_page(page)
        writer.add_page(tail)
        dst.parent.mkdir(parents=True, exist_ok=True)
        fd, tmp = tempfile.mkstemp(dir=dst.parent, suffix=".tmp")
        os.close(fd)
        try:
            with open(tmp, "wb") as fh:
                writer.write(fh)
            os.replace(tmp, dst)
        finally:
            if os.path.exists(tmp):
                os.unlink(tmp)
        logger.info("pdftail %s uid=%s scene=%s qr=%s", rid, uid, scene,
                    "hit" if qr_bytes else "placeholder")
        return dst
    except Exception:  # noqa: BLE001 —— 尾页=增益非依赖：降级不挡下载主链
        logger.warning("pdftail degrade rid=%s uid=%s", rid, uid, exc_info=True)
        return wm_pdf
