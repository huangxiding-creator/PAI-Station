# -*- coding: utf-8 -*-
"""pdf_compress.py — PDF 压缩腿（T-P0-03 / NFR-03 单份 ≤10MB=配置项）

实测画像（试点 js-shuiwang full.pdf 48.5MB / 1290 页 / 仅 7 图 0.32MB / 流内容共 5.3MB）：
体积大头是 Edge headless 输出的 PDF 标签结构树（/StructTreeRoot，34.5 万个间接对象，
对象开销 ≈42MB；字体仅 5 个共享 xref，图片仅 0.32MB）。三板斧（实测 48.5→5.8MB / 3s）：
  1) 摘除 StructTreeRoot/MarkInfo → 孤儿化结构对象（代价：丢无障碍标签树，交付件可接受）
  2) save(garbage=3, deflate=True) 回收坍缩（4 档在 34 万对象上病态慢，见 CONFIG 注记）
  3) subset_fonts() 字体重子集 + 图片按显示尺寸实测 DPI 重采样（PIL LANCZOS）+ JPEG 降档
     ——阅读版 read.pdf 110dpi / 打印版 print.pdf 150dpi（ARCHITECTURE §六）
超 max_mb 自动用 fallback 档（更低 dpi/quality）对中间件重压；页数不变+可打开为硬断言。
"""
from __future__ import annotations

import io
from pathlib import Path

import pymupdf
from PIL import Image

CONFIG = {
    "read_dpi": 110,        # 阅读版（100-120 带宽取中）
    "print_dpi": 150,       # 打印版
    "jpeg_quality": 80,
    "fb_dpi": 85,           # 超限降档
    "fb_quality": 65,
    "max_mb": 10.0,         # NFR-03 阈值（配置项）
    "garbage": 3,           # 回收档位：3=紧凑去孤儿；4 在千页级大件上病态慢（实测>10min 无产出）
}


def _plain_mb(path: Path) -> float:
    return round(path.stat().st_size / 1024 / 1024, 2)


def _resample_images(doc: pymupdf.Document, dpi: int, quality: int) -> int:
    """页内图片按显示框换算真实 DPI，超目标才重采样为 JPEG 流替换（幂等无害）"""
    replaced = 0
    for page in doc:
        for img in page.get_images(full=True):
            xref = img[0]
            try:
                rects = page.get_image_rects(xref)
                pix = pymupdf.Pixmap(doc, xref)
                if pix.width < 8 or not rects:
                    continue
                w_pt = max(r.width for r in rects)
                dpi_now = pix.width / max(w_pt, 1.0) * 72.0
                if dpi_now <= dpi:
                    continue
                scale = dpi / dpi_now
                pil = Image.open(io.BytesIO(pix.tobytes("png"))).convert("RGB")
                pil = pil.resize(
                    (max(8, round(pix.width * scale)), max(8, round(pix.height * scale))),
                    Image.LANCZOS,
                )
                buf = io.BytesIO()
                pil.save(buf, "JPEG", quality=quality, optimize=True)
                page.replace_image(xref, stream=buf.getvalue())
                replaced += 1
            except Exception:
                continue  # 单图失败不炸整份
    return replaced


def _save_pass(doc: pymupdf.Document, dst: Path, pages_expected: int, garbage: int = 3) -> None:
    doc.save(dst, garbage=garbage, deflate=True)
    doc.close()
    chk = pymupdf.open(dst)  # 压完可打开 + 页数一致（硬断言）
    if chk.page_count != pages_expected:
        raise AssertionError(f"{dst.name} 页数变化 {pages_expected}->{chk.page_count}")
    chk.close()


def _one_variant(
    base: Path, dst: Path, pages: int, dpi: int, quality: int, max_mb: float, garbage: int = 3
) -> dict:
    """base=已做字体子集的中间件；产出单个变体，超限自动降档对 base 重压"""
    for attempt, (d, q) in enumerate(((dpi, quality), (CONFIG["fb_dpi"], CONFIG["fb_quality"]))):
        doc = pymupdf.open(base)
        n_resampled = _resample_images(doc, d, q)
        _save_pass(doc, dst, pages, garbage)
        if _plain_mb(dst) <= max_mb or attempt == 1:
            return {
                "pdf": dst.name, "mb": _plain_mb(dst), "dpi": d, "quality": q,
                "images_resampled": n_resampled, "fallback": attempt == 1,
            }
    raise AssertionError("unreachable")


def destruct_light(src: Path, dst: Path | None = None) -> float:
    """轻量压缩（仅去结构树+回收，不动图片字体）——试读版等小件用，实测 3.44→1.57MB/147 页"""
    dst = dst or src
    doc = pymupdf.open(src)
    pages = doc.page_count
    cat = doc.pdf_catalog()
    doc.xref_set_key(cat, "StructTreeRoot", "null")
    doc.xref_set_key(cat, "MarkInfo", "null")
    tmp = dst.with_suffix(".tmp.pdf")
    doc.save(tmp, garbage=3, deflate=True)
    doc.close()
    chk = pymupdf.open(tmp)
    assert chk.page_count == pages, f"{dst.name} 页数变化"
    chk.close()
    tmp.replace(dst)
    return _plain_mb(dst)


def compress_pair(src: Path, out_dir: Path, cfg: dict | None = None) -> dict:
    """Edge 原始 full pdf → out_dir/read.pdf + print.pdf（共享一次中间件）
    实测大头=Edge 标签结构树（试点件 34.5 万对象占 ~42MB，流内容仅 5.3MB）：
    摘除 StructTreeRoot/MarkInfo 后 garbage 回收 3 秒坍缩到 5.8MB（页数/文本不变）。
    """
    c = {**CONFIG, **(cfg or {})}
    out_dir.mkdir(parents=True, exist_ok=True)
    src_mb = _plain_mb(src)
    doc = pymupdf.open(src)
    pages = doc.page_count
    cat = doc.pdf_catalog()
    doc.xref_set_key(cat, "StructTreeRoot", "null")
    doc.xref_set_key(cat, "MarkInfo", "null")
    try:
        doc.subset_fonts()
    except Exception as exc:  # 字体子集失败不阻断（去结构树+回收仍做）
        print(f"  [warn] subset_fonts: {exc}")
    base = out_dir / "_subset_base.pdf"
    doc.save(base, garbage=c["garbage"], deflate=True)
    doc.close()
    stats = {"src_mb": src_mb, "pages": pages, "base_mb": _plain_mb(base)}
    for name, dpi in (("read.pdf", c["read_dpi"]), ("print.pdf", c["print_dpi"])):
        stats[name] = _one_variant(base, out_dir / name, pages, dpi, c["jpeg_quality"], c["max_mb"], c["garbage"])
    base.unlink()  # 中间件即弃（read/print 已各自落盘）
    return stats
