# -*- coding: utf-8 -*-
"""HTML 重组转 PDF（FR2.2：wenku 三型重组 HTML → printToPDF 产 PDF；FR5.1 CSDN 选器流共用）。

统一语言（CONTEXT.md）：无头打印——Playwright 无头加载本地 HTML，按 @page 定尺寸落 PDF。
- 打印参数（FR2.2 口径）：print_background=True + prefer_css_page_size=True + margin 全 0
  ——页几何权威=CSS @page（px→pt 按 96dpi：600px→450pt），非 page.pdf 的 width/height。
- 字体钩子：@font-face 注入 ascent-override:80% / descent-override:20%（纵向修正：
  收紧上下伸部，使重组页行盒与原版页纵向对齐——wenku 重组排版基准）。
- 落 PDF 前置等待：document.fonts.ready（add_style_tag 后字体规则须先被解析）
  + 固定 1000ms 缓冲（本地 src local() 解析不触发 fonts 事件）。
- CSDN print-CSS 注入=extra_css 可选参数（选器隐藏/重排流由此注入）。
- Playwright sync API（编排层单线程串行调用，与全厂 9336/9337 口令不涉——本件自起自灭浏览器）。
- 铁律（NFR6 GPL 隔离）：禁 fitz/PyMuPDF（AGPL）；读回核验一律 pypdfium2（调用方事）。
"""
from __future__ import annotations

from pathlib import Path

from playwright.sync_api import sync_playwright

PX_PER_PT_CSS = 96 / 72  # CSS px → PDF pt（96dpi 口径：600px=450pt）

FONTS_SETTLE_MS = 1000  # document.fonts.ready 之后的固定缓冲（ms）

# 纵向修正基准比例（FR2.2 wenku 重组口径；改此值须同步改测试口径断言）
_ASCENT_OVERRIDE = "80%"
_DESCENT_OVERRIDE = "20%"


def build_font_face_css(font_family: str = "HarvestPrint",
                        src_local: str = "Microsoft YaHei") -> str:
    """字体注入钩子（纯函数）：产出 @font-face 规则串。

    ascent-override:80% + descent-override:20% —— 纵向修正，压缩行盒上下伸部，
    使重组 HTML 分页节奏对齐原版（正文 font-family 用同名族即生效）。
    """
    return (f"@font-face{{font-family:'{font_family}';src:local('{src_local}');"
            f"ascent-override:{_ASCENT_OVERRIDE};descent-override:{_DESCENT_OVERRIDE};}}")


def html_to_pdf(html_path: Path | str, out_pdf: Path | str, *,
                font_face_css: str | None = None,
                extra_css: str | None = None,
                fonts_settle_ms: int = FONTS_SETTLE_MS) -> Path:
    """本地 HTML 无头打印成 PDF（页几何权威=CSS @page）。

    :param html_path: 源 HTML 路径（file:// 加载；缺文件 FileNotFoundError 显式拒）。
    :param out_pdf: 输出 PDF 路径（父目录自动建）。
    :param font_face_css: 字体钩子 CSS（传 build_font_face_css() 产物；None=不注入）。
    :param extra_css: 额外打印 CSS（CSDN print-CSS 选器流等；None/空=不注入）。
    :param fonts_settle_ms: document.fonts.ready 后的固定缓冲（默认 1000ms）。
    :return: 实际落盘的 PDF 路径（页数/几何由调用方 pypdfium2 实测，数字零造假）。
    """
    src = Path(html_path)
    if not src.is_file():
        raise FileNotFoundError(f"源 HTML 不存在: {src}")
    out = Path(out_pdf)
    out.parent.mkdir(parents=True, exist_ok=True)

    with sync_playwright() as pw:
        browser = pw.chromium.launch(headless=True)
        try:
            page = browser.new_page()
            page.goto(src.resolve().as_uri(), wait_until="networkidle")
            for css in (font_face_css, extra_css):
                if css:
                    page.add_style_tag(content=css)
            if fonts_settle_ms >= 0:
                # 等字体规则解析（add_style_tag 后 fonts 集合可能仍异步）+ 固定缓冲
                page.evaluate("() => document.fonts.ready.then(() => true)")
                page.wait_for_timeout(fonts_settle_ms)
            page.pdf(path=str(out), print_background=True, prefer_css_page_size=True,
                     margin={"top": "0", "right": "0", "bottom": "0", "left": "0"})
        finally:
            browser.close()
    return out
