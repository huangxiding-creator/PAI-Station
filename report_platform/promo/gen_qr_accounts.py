# -*- coding: utf-8 -*-
"""gen_qr_accounts — 分号归因二维码 (F5b): 每个宣传渠道一枚独立 src 码.

扫码进入 report.yrecepc.cn 携带 ?src=xxx → TRACK_JS 落 events.extra,
分号漏斗 (visit→scroll_90→click_buy→order_created) 可按渠道分桶.
site/platform_qr.png (无参码) 保留不动; 本脚本只新增分号码.

用法: python -X utf8 promo/gen_qr_accounts.py
"""
from __future__ import annotations

import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
ROOT = Path(__file__).resolve().parents[1]

BASE = "http://report.yrecepc.cn/"
# src 键 → (文件名, 渠道说明)
CHANNELS = {
    "gzh-zbzs": ("qr_zbzs.png", "公众号·总包之声"),
    "gzh-zbshuo": ("qr_zbshuo.png", "公众号·总包说"),
    "gzh-dt": ("qr_dt.png", "公众号·工程行业大脑"),
    "sph-manual": ("qr_sph.png", "视频号·人工桥"),
    "bb-preheat": ("qr_bb.png", "蓝皮书预热"),
}


def main() -> int:
    import qrcode
    out_dir = ROOT / "promo"
    for src, (fname, label) in CHANNELS.items():
        url = f"{BASE}?src={src}"
        img = qrcode.make(url, box_size=10, border=2)
        path = out_dir / fname
        img.save(path)
        print(f"[qr] {label:<14} {url}  -> {fname} ({path.stat().st_size}B)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
