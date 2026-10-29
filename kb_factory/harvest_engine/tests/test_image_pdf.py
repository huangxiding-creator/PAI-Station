# -*- coding: utf-8 -*-
"""T10 单测：image_pdf 像素拼页——按图片实际像素定页拼 PDF（FR3.1 通用件，FR7.1 L3 复用）。

- fixture=tests 运行时参数化路径（tmp_path，公约§10：不落包内默认位）；PIL 手造
  792×1120 与 595×842 两尺寸各 2 页，混排列传入——页序=传入序即被逐页几何+颜色双锁。
- 断言口径：pypdfium2 读回页宽高（pt）与源图像素数严格相等（1px=1pt 版式），零近似。
- GIF89a 兼容：P 模式 + transparency 参数强制 89a 头（fixture 自证 6 字节头），几何不变。
- 禁 fitz/PyMuPDF（AGPL，NFR6 GPL 隔离）——本件读回一律 pypdfium2。
"""
import sys
from pathlib import Path

import pytest

_KB_DIR = Path(__file__).resolve().parents[2]  # kb_factory/
sys.path.insert(0, str(_KB_DIR))  # worktree 阶段 kb_factory 无 __init__.py：顶层导入 harvest_engine
if not (_KB_DIR / "channel_adapters" / "base.py").exists():
    # worker worktree：kb_factory 未入 git → channel_adapters 只读复用主仓真身（供 kb_factory. 前缀解析）
    for _anc in _KB_DIR.parents:
        if (_anc / "kb_factory" / "channel_adapters" / "base.py").exists():
            sys.path.insert(1, str(_anc))
            break

try:  # 合并后正名 kb_factory.harvest_engine.*；worktree 阶段回退顶层名
    from kb_factory.harvest_engine.pdf.image_pdf import build_image_pdf  # noqa: E402
except ImportError:
    from harvest_engine.pdf.image_pdf import build_image_pdf  # noqa: E402

from PIL import Image  # noqa: E402
import pypdfium2 as pdfium  # noqa: E402

# 任务卡 fixture 规格：两尺寸各 2 页；颜色逐页互异（锁页序=传入序）
_SPECS = [
    (792, 1120, (198, 40, 40)),   # p0 红
    (595, 842, (40, 150, 70)),    # p1 绿
    (792, 1120, (60, 90, 200)),   # p2 蓝
    (595, 842, (225, 200, 60)),   # p3 黄
]
_COLOR_TOL = 16  # 渲染回读容差（纯色块±16 内认定为同色）


def _make_png(tmp: Path, name: str, w: int, h: int, color: tuple) -> Path:
    p = tmp / name
    Image.new("RGB", (w, h), color).save(p, format="PNG")
    return p


def _make_gif89a(tmp: Path, name: str, w: int, h: int, color: tuple) -> Path:
    """P 模式 + transparency（未用索引）强制 GIF89a 头；fixture 自证头与像素。"""
    p = tmp / name
    Image.new("RGB", (w, h), color).quantize(colors=64).save(p, format="GIF", transparency=1)
    with open(p, "rb") as f:
        assert f.read(6) == b"GIF89a", "fixture 不是 GIF89a"
    with Image.open(p) as im:
        assert im.size == (w, h)
        assert im.convert("RGB").getpixel((w // 2, h // 2)) == color, "GIF89a 量化丢色，fixture 失真"
    return p


def _page_sizes(pdf_path: Path) -> list[tuple[float, float]]:
    doc = pdfium.PdfDocument(str(pdf_path))
    try:
        return [(page.get_width(), page.get_height()) for page in doc]
    finally:
        doc.close()


def test_fr3_1_page_geometry_equals_pixels(tmp_path):
    """FR3.1：每图一页，页几何==图实际像素（pypdfium2 读回逐页断言，零近似）。"""
    imgs = [_make_png(tmp_path, f"p{i}.png", w, h, c) for i, (w, h, c) in enumerate(_SPECS)]
    out = build_image_pdf(imgs, tmp_path / "geo.pdf")
    sizes = _page_sizes(out)
    assert len(sizes) == len(_SPECS)  # 页数实测==传入图数
    for i, ((w, h, _c), (pw, ph)) in enumerate(zip(_SPECS, sizes)):
        assert (pw, ph) == (float(w), float(h)), f"第{i}页几何 ({pw},{ph}) != 像素 ({w},{h})"


def test_fr3_1_page_order_equals_input_order(tmp_path):
    """FR3.1：页序=传入序——四色四页，pypdfium2 渲染中心像素对色（兼证末页非空，NFR-GATE④）。"""
    imgs = [_make_png(tmp_path, f"o{i}.png", w, h, c) for i, (w, h, c) in enumerate(_SPECS)]
    out = build_image_pdf(imgs, tmp_path / "order.pdf")
    doc = pdfium.PdfDocument(str(out))
    try:
        assert len(doc) == 4
        for i, ((w, h, color), page) in enumerate(zip(_SPECS, doc)):
            bmp = page.render(scale=32 / w)  # 统一渲染到 ~32px 宽，纯色块免缩放伪影
            got = bmp.to_pil().getpixel((bmp.width // 2, bmp.height // 2))[:3]
            assert all(abs(g - e) <= _COLOR_TOL for g, e in zip(got, color)), (
                f"第{i}页中心色 {got} != 传入第{i}图 {color}（页序错或页错色）")
    finally:
        doc.close()


def test_fr3_1_gif89a_input_geometry_unchanged(tmp_path):
    """FR3.1：GIF89a 输入兼容（转 PNG 嵌入），几何不变；PNG+GIF 混排同 PDF。"""
    gif = _make_gif89a(tmp_path, "g0.gif", 595, 842, (120, 60, 160))
    png = _make_png(tmp_path, "g1.png", 792, 1120, (30, 160, 170))
    out = build_image_pdf([gif, png], tmp_path / "gif.pdf")
    assert _page_sizes(out) == [(595.0, 842.0), (792.0, 1120.0)]  # 几何不变+页序不乱


def test_fr3_1_empty_input_rejected(tmp_path):
    """FR3.1：空图组是调用方 bug，须显式 ValueError 而非静默产 0 页 PDF。"""
    with pytest.raises(ValueError):
        build_image_pdf([], tmp_path / "never.pdf")
