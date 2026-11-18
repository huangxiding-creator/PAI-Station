# -*- coding: utf-8 -*-
"""kb_delivery_pdf — 知识库 SKU 网盘交付说明 PDF（一页）。

背景（1118 用户令：KB 内容只存百度网盘，不上传小程序）：
  小程序购买解锁后主交付=详情页网盘链接卡（引擎按解锁态下发）；
  full/<sku>.pdf 位放一页真实《交付说明》（含百度链接），兼容旧版客户端
  「打开 PDF 全文」入口——任何版本购买后都有真实可读内容，零假件。

用法: py tools/kb_delivery_pdf.py --sku KB-SUBCON-2026
"""
from __future__ import annotations

import argparse
import json
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from fpdf import FPDF  # noqa: E402

REPO = Path(__file__).resolve().parents[1]
CONTENT = REPO / "report_platform" / "content"
FONT = REPO / "data" / "state" / "qw_deploy_stage_1007" / "fonts" / "simhei.ttf"


def build(sku: str) -> Path:
    data = json.loads((CONTENT / "report.json").read_text(encoding="utf-8"))
    r = next(x for x in data["reports"] if x.get("sku") == sku)
    bs = r.get("baidu_share") or {}
    url = bs.get("url") or ""
    pwd = bs.get("code") or ""
    assert url, f"{sku} 无 baidu_share.url"

    pdf = FPDF(format="A4")
    pdf.add_page()
    pdf.add_font("hei", "", str(FONT))
    pdf.set_auto_page_break(False)

    def h(txt, size, y, align="L", bold_like=True):
        pdf.set_font("hei", "", size)
        pdf.set_xy(18, y)
        pdf.cell(174, 10, txt, new_x="LMARGIN", new_y="NEXT", align=align)

    h("知识库 · 网盘交付说明", 22, 24, "C")
    h(f"{r.get('title', '').strip('《》')}", 14, 44, "C")
    y = 68
    h("感谢选购。整库内容存放于百度网盘（小程序内不占手机存储），按下列信息取件：", 11, y)
    y += 14
    h("一、百度网盘链接（永久有效）：", 13, y); y += 10
    h(url, 12.5, y); y += 10
    h(f"提取码：{pwd if pwd else '无需提取码（链接直开）'}", 12.5, y); y += 16

    h("二、使用步骤：", 13, y); y += 10
    for step in (
        "1. 复制上方链接，在浏览器或百度网盘App打开；",
        "2. 建议「保存至我的网盘」长期使用（链接永久，也可随时重新打开）；",
        "3. 整库为 ZIP 打包，下载后解压即可按四大类目录检索使用；",
        "4. 免费蓝图（完整编目目录+精选样本）在小程序本商品页「免费试读」处随时可看。",
    ):
        h(step, 11, y); y += 8.5
    y += 6
    h("三、售后：链接失效或下载异常，请在小程序「我的」页联系客服，核实订单后即时补发。", 11, y); y += 12

    badges = {b.get("k"): b.get("v") for b in (r.get("badges") or [])}
    h(f"商品信息：{badges.get('文件数', '')}｜{badges.get('总容量', '')}｜质量评分 {r.get('subtitle', '')}", 10, y); y += 8
    h(f"出品：总包智库研究团队 · SKU {sku} · {r.get('listed_at', '')}", 10, y)

    out = CONTENT / "full" / f"{sku}.pdf"
    out.write_bytes(pdf.output())
    print(f"[ok] 交付说明PDF {out} ({out.stat().st_size}B) url={url[:44]}…")
    return out


if __name__ == "__main__":
    ap = argparse.ArgumentParser()
    ap.add_argument("--sku", required=True)
    raise SystemExit(build(ap.parse_args().sku) and 0)
