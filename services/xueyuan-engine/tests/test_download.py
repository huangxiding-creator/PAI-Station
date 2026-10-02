# -*- coding: utf-8 -*-
"""下载水印单测（T-P0-09）：fixture 小 PDF 自造/权益 403/PDF_NOT_READY/水印还原。"""
from __future__ import annotations

import sys
from io import BytesIO
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

from tests.conftest import PILOT  # noqa: E402

from pypdf import PdfReader, PdfWriter  # noqa: E402

from xueyuan_engine import config  # noqa: E402
from xueyuan_engine.download import watermark_pdf  # noqa: E402


def _make_pdf(path: Path, pages: int = 2) -> Path:
    w = PdfWriter()
    for _ in range(pages):
        w.add_blank_page(width=595, height=842)
    path.parent.mkdir(parents=True, exist_ok=True)
    with open(path, "wb") as fh:
        w.write(fh)
    return path


def _buy(client, buyer, monkeypatch, pay_on):  # noqa: ANN001
    monkeypatch.setenv("XY_FAKE_PAY", "1")
    monkeypatch.setenv("XY_PORT", "8872")
    out = client.post("/api/v1/pay/sign", json={"report_id": PILOT},
                      headers=buyer).json()["out_trade_no"]
    client.post("/api/v1/pay/callback", json={"outTradeNo": out})
    return out


def test_download_rejected_without_entitlement(engine, client, buyer):
    r = client.get(f"/api/v1/reports/{PILOT}/download", headers=buyer)
    assert r.status_code == 403 and r.json()["code"] == "NOT_ENTITLED"
    assert client.get(f"/api/v1/reports/{PILOT}/download").status_code == 401


def test_download_pdf_not_ready(engine, client, buyer, monkeypatch, pay_on):
    _buy(client, buyer, monkeypatch, pay_on)  # 已购但 PDF 产物未就位
    r = client.get(f"/api/v1/reports/{PILOT}/download", headers=buyer)
    assert r.status_code == 404 and r.json()["code"] == "PDF_NOT_READY"
    assert client.get(f"/api/v1/reports/{PILOT}/download",
                      params={"type": "wow"}, headers=buyer).status_code == 400


def test_download_watermarked_pdf_full_flow(engine, client, buyer, monkeypatch, pay_on):
    out = _buy(client, buyer, monkeypatch, pay_on)
    _make_pdf(config.PDF_DIR / PILOT / "read.pdf")
    _make_pdf(config.PDF_DIR / PILOT / "print.pdf")
    r = client.get(f"/api/v1/reports/{PILOT}/download", headers=buyer)
    assert r.status_code == 200 and r.headers["content-type"] == "application/pdf"
    raw = r.content
    assert raw.startswith(b"%PDF-")
    reader = PdfReader(BytesIO(raw))
    assert len(reader.pages) == 3  # 2 内容页 + 1 个人码尾页（3c 契约演进，test_pdftail 详测）
    text = "".join(p.extract_text() or "" for p in reader.pages)
    assert buyer["uid"] in text and out[-6:] in text  # 水纹还原 uid+订单尾号（NFR-06）
    # 水印文件落盘缓存（幂等重下载走缓存）
    wm_dir = config.PDF_DIR / PILOT / "wm"
    assert any(wm_dir.iterdir())
    r2 = client.get(f"/api/v1/reports/{PILOT}/download",
                    params={"type": "print"}, headers=buyer)
    assert r2.status_code == 200 and r2.content.startswith(b"%PDF-")


def test_watermark_pdf_function_direct(tmp_path):
    """水印合成函数直测：页数保持+文本可抽取+缓存目标原子落盘。"""
    src = _make_pdf(tmp_path / "src.pdf", pages=3)
    dst = tmp_path / "wm" / "out.pdf"
    watermark_pdf(src, dst, "reader-u1a2b3c4d5 901234")
    assert dst.exists()
    reader = PdfReader(str(dst))
    assert len(reader.pages) == 3
    joined = "".join(p.extract_text() or "" for p in reader.pages)
    assert "reader-u1a2b3c4d5" in joined and "901234" in joined
