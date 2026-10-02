# -*- coding: utf-8 -*-
"""下载域——双 PDF（read/print）流式下发+水印合成（NFR-03/06；链路②-7）。

水印=购者昵称+订单尾号+uid（与 orders 对账可溯源，泄漏源定位）：
对角浅灰重复平铺，文本落在页面内容流（pypdf extract_text 可还原→NFR-06 抽取判据）。
覆盖层 PDF 为内置 Helvetica 手绘内容流（零新依赖；昵称非 ASCII 字符降级为 uid，
CJK 全名水印待切片②评估嵌入字体）。PDF 未就绪→404 PDF_NOT_READY（A 线产物未到降级）。
下载产物=水印页+个人码尾页（pdftail.personalize，3c 裂变环；失败降级原水印版）。
"""
from __future__ import annotations

import math
import os
import tempfile
from io import BytesIO
from pathlib import Path

from fastapi import APIRouter, Request
from fastapi.responses import FileResponse
from pypdf import PdfReader, PdfWriter

from . import config, pdftail, store, wechat
from .catalog import get_report
from .errors import ApiError

router = APIRouter(prefix="/api/v1", tags=["download"])


def _ascii(text: str) -> str:
    """水印文本 ASCII 化（Helvetica/WinAnsi 约束；CJK 降级由 uid 兜底溯源）。"""
    return "".join(ch for ch in text if 32 <= ord(ch) < 127).strip()


def _overlay_pdf_bytes(text: str, w: float, h: float) -> bytes:
    """单页对角平铺水印覆盖层（45° 旋转 Tm 矩阵，浅灰 0.72）。"""
    esc = text.replace("\\", r"\\").replace("(", r"\(").replace(")", r"\)")
    c = s = math.sqrt(0.5)
    ops = ["q 0.72 0.72 0.72 rg", "BT /F1 11 Tf"]
    x_step, y_step = 190, 140
    row, y = 0, 24
    while y < h:
        x = -90 + (row % 2) * (x_step // 2)
        while x < w + 90:
            ops.append(f"{c:.4f} {s:.4f} {-s:.4f} {c:.4f} {x:.1f} {y:.1f} Tm ({esc}) Tj")
            x += x_step
        y += y_step
        row += 1
    ops += ["ET", "Q"]
    content = "\n".join(ops).encode("ascii")
    objs = [
        b"<< /Type /Catalog /Pages 2 0 R >>",
        b"<< /Type /Pages /Kids [3 0 R] /Count 1 >>",
        (f"<< /Type /Page /Parent 2 0 R /MediaBox [0 0 {w:.1f} {h:.1f}]"
         " /Resources << /Font << /F1 5 0 R >> >> /Contents 4 0 R >>").encode(),
        b"<< /Length " + str(len(content)).encode() + b" >>\nstream\n" + content + b"\nendstream",
        b"<< /Type /Font /Subtype /Type1 /BaseFont /Helvetica /Encoding /WinAnsiEncoding >>",
    ]
    out = bytearray(b"%PDF-1.4\n")
    offsets: list[int] = []
    for i, body in enumerate(objs, 1):
        offsets.append(len(out))
        out += f"{i} 0 obj\n".encode() + body + b"\nendobj\n"
    xref = len(out)
    out += f"xref\n0 {len(objs) + 1}\n".encode() + b"0000000000 65535 f \n"
    for off in offsets:
        out += f"{off:010d} 00000 n \n".encode()
    out += (f"trailer\n<< /Size {len(objs) + 1} /Root 1 0 R >>\n"
            f"startxref\n{xref}\n%%EOF").encode()
    return bytes(out)


def watermark_pdf(src: Path, dst: Path, text: str) -> None:
    """逐页叠水印（按页尺寸缓存覆盖层）；临时文件+原子替换防并发写坏。"""
    reader = PdfReader(str(src))
    writer = PdfWriter()
    cache: dict[tuple[float, float], object] = {}
    for page in reader.pages:
        size = (round(float(page.mediabox.width), 1), round(float(page.mediabox.height), 1))
        if size not in cache:
            cache[size] = PdfReader(BytesIO(_overlay_pdf_bytes(text, *size))).pages[0]
        page.merge_page(cache[size])  # 覆盖层后画=浮于正文之上
        writer.add_page(page)
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


def _order_tail(uid: str, rid: str) -> str:
    with store._db() as c:
        row = c.execute(
            "SELECT out_trade_no FROM orders WHERE user_id=? AND report_id=?"
            " AND status IN ('paid','delivered') ORDER BY id DESC LIMIT 1",
            (uid, rid)).fetchone()
    return (row["out_trade_no"] or "")[-6:] if row else ""


@router.get("/reports/{rid}/download")
def download(rid: str, request: Request, type: str = "read"):
    """水印版 PDF 下载（Bearer+权益；可重复下载幂等）。"""
    if type not in ("read", "print"):
        raise ApiError(400, "INVALID_PARAM", "type 仅支持 read|print")
    openid = wechat.bearer_openid(request)
    if not openid:
        raise ApiError(401, "UNAUTHORIZED", "未登录或凭证过期")
    user = store.get_or_create_user(openid)
    uid = user["id"]
    report = get_report(rid)
    if not report:
        raise ApiError(404, "REPORT_NOT_FOUND", "报告不存在或已下架")
    with store._db() as c:
        entitled = c.execute(
            "SELECT 1 FROM entitlements WHERE user_id=? AND report_id=? LIMIT 1",
            (uid, rid)).fetchone() is not None
    if not entitled:
        raise ApiError(403, "NOT_ENTITLED", "未解锁该报告，无法下载")
    src = config.PDF_DIR / rid / f"{type}.pdf"
    if not src.exists():  # A 线 PDF 产物未到位降级（T-P0-03 压缩腿并行）
        raise ApiError(404, "PDF_NOT_READY", "报告 PDF 尚未就绪，请稍后再试")
    tail = _order_tail(uid, rid)
    wm_text = _ascii(f"{user.get('nickname') or ''} {uid} {tail}") or uid
    dst = config.PDF_DIR / rid / "wm" / f"{uid}_{tail or 'none'}_{type}.pdf"
    if not dst.exists():
        watermark_pdf(src, dst, wm_text)
    serve = pdftail.personalize(dst, rid, uid, report)  # 个人码尾页（失败降级原样）
    return FileResponse(
        serve, media_type="application/pdf", filename=f"{rid}-{type}.pdf",
        content_disposition_type="inline",
    )
