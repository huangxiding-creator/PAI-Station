# -*- coding: utf-8 -*-
"""PDF 个人码尾页单测（3c）：渲染形状/单页 PDF/追加页数/码池真码/降级不挡下载。

下载契约演进登记：带权益下载=N 内容页+1 个人尾页（test_download 全流同步改）。
"""
from __future__ import annotations

import sys
from io import BytesIO
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

from tests.conftest import PILOT  # noqa: E402
from tests.test_download import _buy, _make_pdf  # noqa: E402

from PIL import Image  # noqa: E402
from pypdf import PdfReader  # noqa: E402

from xueyuan_engine import config, pdftail, poster  # noqa: E402


def test_render_tail_page_shape():
    img = pdftail.render_tail_page({"title": "江苏水网工程商机研究"}, None)
    assert img.size == (1240, round(1240 * 842 / 595))  # A4 默认纵横比（595:842）
    wide = pdftail.render_tail_page({"title": "x"}, None, aspect=1.0)
    assert wide.size == (1240, 1400)  # 矮页触发高度兜底（内容排版下限）
    tall = pdftail.render_tail_page({"title": "y"}, None, aspect=1.6)
    assert tall.size[1] == round(1240 * 1.6)  # 高页按纵横比照算


def test_tail_pdf_single_page():
    raw = pdftail._tail_pdf_bytes(pdftail.render_tail_page({"title": "t"}, None))
    assert raw.startswith(b"%PDF-")
    assert len(PdfReader(BytesIO(raw)).pages) == 1


def test_personalize_appends_tail(tmp_path, engine):
    src = _make_pdf(tmp_path / "wm.pdf", pages=2)
    out = pdftail.personalize(src, "r-tail", "u1", {"title": "测试报告"})
    assert out != src and out.exists() and out.name.endswith("_p.pdf")
    assert len(PdfReader(str(out)).pages) == 3  # 2 水印页 + 1 尾页
    again = pdftail.personalize(src, "r-tail", "u1", {"title": "测试报告"})
    assert again == out  # 磁盘缓存幂等


def test_personalize_scene_shares_poster_pool(tmp_path, engine):
    """scene 与邀请海报同源：同 (rid,uid) 下载尾页与海报共用一条 poster_code。"""
    src = _make_pdf(tmp_path / "wm0.pdf", pages=1)
    pdftail.personalize(src, "r-share", "u9", {"title": "s"})
    scene = poster.ensure_scene("r-share", "u9", "poster")  # 幂等取回同 scene
    with poster.store._db() as c:
        rows = c.execute(
            "SELECT scene_code FROM poster_code WHERE report_id=? AND inviter_uid=?",
            ("r-share", "u9")).fetchall()
    assert any(r["scene_code"] == scene for r in rows)


def test_personalize_qr_pool_hit(tmp_path, engine):
    src = _make_pdf(tmp_path / "wm2.pdf", pages=1)
    scene = poster.ensure_scene("r-qr", "u2", "poster")
    qp = poster.qr_pool_path(scene)
    qp.parent.mkdir(parents=True, exist_ok=True)
    Image.new("RGB", (10, 10), "red").save(qp, format="PNG")  # 码池灌真码
    out = pdftail.personalize(src, "r-qr", "u2", {"title": "QR"})
    assert out.exists() and len(PdfReader(str(out)).pages) == 2


def test_personalize_degrades_on_error(tmp_path, monkeypatch):
    src = _make_pdf(tmp_path / "wm3.pdf", pages=2)

    def boom(*a, **k):  # noqa: ANN002, ANN003
        raise RuntimeError("render down")

    monkeypatch.setattr(pdftail, "render_tail_page", boom)
    assert pdftail.personalize(src, "r-x", "u3", {"title": "x"}) == src  # 原样照发


def test_download_appends_tail_full_flow(engine, client, buyer, monkeypatch, pay_on):
    _buy(client, buyer, monkeypatch, pay_on)
    _make_pdf(config.PDF_DIR / PILOT / "read.pdf")
    r = client.get(f"/api/v1/reports/{PILOT}/download", headers=buyer)
    assert r.status_code == 200 and r.content.startswith(b"%PDF-")
    reader = PdfReader(BytesIO(r.content))
    assert len(reader.pages) == 3  # 2 内容页 + 1 个人尾页
    text = "".join(p.extract_text() or "" for p in reader.pages)
    assert buyer["uid"] in text  # 水印仍在内容页（NFR-06 不回归）
    assert any((config.PDF_DIR / PILOT / "wm").glob("*_p.pdf"))  # 尾页缓存落盘
