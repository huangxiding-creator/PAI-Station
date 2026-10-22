# -*- coding: utf-8 -*-
"""T11 单测：html_print_pdf——本地 HTML 无头打印 PDF（FR2.2 wenku 重组链共用件，FR5.1 CSDN 选器流复用）。

- 口径：@page 600px×800px 两页 → pypdfium2 读回页宽高==450pt×600pt（px→pt 96dpi：600×72/96=450）。
- 断言面：页数实测==2 / 页几何逐页严格相等 / 页序=传入序（红蓝两页中心像素对色，
  兼证 print_background=True——关背景则对色必败）；margin 全0 隐含在精确两页+几何内。
- 字体钩子：build_font_face_css 纯函数产出 ascent-override:80% / descent-override:20%（纵向修正），
  e2e 注入后版不炸（几何仍==@page）。
- CSDN print-CSS 注入=extra_css 可选参数：@media print 隐藏块使页数 3→2（注入真实生效）。
- Playwright sync API 串行（无并行标记）；fixture 全本地 file://，零网络零 mock 框架。
"""
import sys
from pathlib import Path

_KB_DIR = Path(__file__).resolve().parents[2]  # kb_factory/
sys.path.insert(0, str(_KB_DIR))  # worktree 阶段 kb_factory 无 __init__.py：顶层导入 harvest_engine
if not (_KB_DIR / "channel_adapters" / "base.py").exists():
    # worker worktree：kb_factory 未入 git → channel_adapters 只读复用主仓真身（供 kb_factory. 前缀解析）
    for _anc in _KB_DIR.parents:
        if (_anc / "kb_factory" / "channel_adapters" / "base.py").exists():
            sys.path.insert(1, str(_anc))
            break

try:  # 合并后正名 kb_factory.harvest_engine.*；worktree 阶段回退顶层名
    from kb_factory.harvest_engine.pdf.html_print_pdf import (  # noqa: E402
        build_font_face_css, html_to_pdf)
except ImportError:
    from harvest_engine.pdf.html_print_pdf import (  # noqa: E402
        build_font_face_css, html_to_pdf)

import pypdfium2 as pdfium  # noqa: E402

_COLOR_TOL = 16          # 渲染回读容差（纯色块±16 内认定为同色）
_AT_PAGE_PT = (450.0, 600.0)  # 600px×800px @ 96dpi → 450pt×600pt

_PAGE_CSS = ("@page{size:600px 800px;margin:0;}"
             "html,body{margin:0;padding:0;}"
             ".pg{width:600px;height:800px;}"
             ".p0{background:rgb(198,40,40);break-after:page;}"
             ".p1{background:rgb(60,90,200);}"
             ".print-hide{width:600px;height:800px;background:rgb(40,150,70);}")


def _write_html(tmp: Path, name: str, extra_body: str = "", extra_style: str = "") -> Path:
    p = tmp / name
    p.write_text(
        f"<!doctype html><html><head><meta charset='utf-8'>"
        f"<style>{_PAGE_CSS}{extra_style}</style></head>"
        f"<body><div class='pg p0'></div><div class='pg p1'></div>{extra_body}</body></html>",
        encoding="utf-8")
    return p


def _page_sizes(pdf_path: Path) -> list[tuple[float, float]]:
    doc = pdfium.PdfDocument(str(pdf_path))
    try:
        return [(pg.get_width(), pg.get_height()) for pg in doc]
    finally:
        doc.close()


def test_fr2_2_page_geometry_equals_at_page_600px_800px(tmp_path):
    """FR2.2：@page 600px×800px → 两页，pypdfium2 读回逐页==450pt×600pt（96dpi 口径）。"""
    html = _write_html(tmp_path, "geo.html")
    out = html_to_pdf(html, tmp_path / "geo.pdf")
    sizes = _page_sizes(out)
    assert len(sizes) == 2, f"页数实测={len(sizes)}，margin 未清零或分页漂移"
    for i, sz in enumerate(sizes):
        assert sz == _AT_PAGE_PT, f"第{i}页几何 {sz} != @page 600px×800px→{_AT_PAGE_PT}"


def test_fr2_2_page_order_and_print_background(tmp_path):
    """FR2.2：页序=DOM 序（红→蓝），中心像素对色兼证 print_background=True。"""
    html = _write_html(tmp_path, "order.html")
    out = html_to_pdf(html, tmp_path / "order.pdf")
    doc = pdfium.PdfDocument(str(out))
    try:
        assert len(doc) == 2
        for i, color in enumerate([(198, 40, 40), (60, 90, 200)]):
            bmp = doc[i].render(scale=32 / 450)  # 统一渲染到 ~32px 宽
            got = bmp.to_pil().getpixel((bmp.width // 2, bmp.height // 2))[:3]
            assert all(abs(g - e) <= _COLOR_TOL for g, e in zip(got, color)), (
                f"第{i}页中心色 {got} != {color}（页序错或 print_background 未开）")
    finally:
        doc.close()


def test_fr2_2_font_face_override_hook(tmp_path):
    """FR2.2：字体钩子——ascent-override:80%/descent-override:20% 纵向修正；注入后几何不炸。"""
    css = build_font_face_css()  # 默认钩子（Microsoft YaHei 本地源）
    assert "ascent-override:80%" in css and "descent-override:20%" in css, (
        "纵向修正比例非 80%/20%：钩子口径漂移")
    assert "@font-face" in css and "src:local(" in css, "非 @font-face 本地源规则"
    # e2e：正文用钩子字体族 + 注入钩子 → 版仍两页、几何仍==@page
    html = _write_html(tmp_path, "font.html",
                       extra_style="body{font-family:'HarvestPrint'}",
                       extra_body="")
    html.write_text(html.read_text(encoding="utf-8").replace(
        "<div class='pg p0'></div>", "<div class='pg p0'>字重排样张</div>"), encoding="utf-8")
    out = html_to_pdf(html, tmp_path / "font.pdf", font_face_css=css)
    sizes = _page_sizes(out)
    assert len(sizes) == 2 and sizes[0] == _AT_PAGE_PT and sizes[1] == _AT_PAGE_PT


def test_fr5_1_extra_css_print_injection(tmp_path):
    """FR5.1：CSDN print-CSS 可选注入——@media print 隐藏第三块，页数 3→2（注入真实生效）。"""
    html = _write_html(tmp_path, "csdn.html",
                       extra_body="<div class='print-hide'></div>")
    hide_css = "@media print{.print-hide{display:none!important}}"
    # 未注入：隐藏块占满第三页
    bare = html_to_pdf(html, tmp_path / "bare.pdf", extra_css="")
    assert len(_page_sizes(bare)) == 3, "对照组应 3 页（隐藏块未被藏）"
    # 注入后：隐藏块退场，页数回落 2，几何不变
    out = html_to_pdf(html, tmp_path / "csdn.pdf", extra_css=hide_css)
    sizes = _page_sizes(out)
    assert len(sizes) == 2 and sizes[0] == _AT_PAGE_PT, "print-CSS 注入未生效或几何被扰"


def test_fr2_2_empty_font_hook_and_bad_input(tmp_path):
    """FR2.2：缺输入 HTML 显式报错（调用方 bug 不静默产空 PDF）。"""
    try:
        html_to_pdf(tmp_path / "nope.html", tmp_path / "never.pdf")
        raised = False
    except FileNotFoundError:
        raised = True
    assert raised, "缺源 HTML 应 FileNotFoundError 而非静默"
