# -*- coding: utf-8 -*-
"""poster_fetch — 报告宣传海报拉取器 (2026-10-27 用户令: 二维码位→报告海报).

引擎端点 GET {BASE}/api/report/<SKU>/poster 返回 JSON {b64: <PNG base64>}
→ 解码落盘 promo/posters/<SKU>.png → 实测打印 尺寸/字节 (数字零造假: 全部实测).

用法:
  python -X utf8 promo/poster_fetch.py --sku OVERSEAS-2026
  python -X utf8 promo/poster_fetch.py --sku SCHED-2026 --out promo/posters

产物: promo/posters/<SKU>.png (发布链 S5 用: 宣传文 {{QRCODE}} 位嵌海报,
详见同目录 promo_poster_rule.md)。
"""
from __future__ import annotations

import argparse
import base64
import io
import json
import sys
from pathlib import Path

import requests

BASE_URL = "https://ai.epcschool.top"
TIMEOUT = 60  # 海报引擎为 Pillow 合成, 给足余量
HERE = Path(__file__).resolve().parent
DEFAULT_OUT = HERE / "posters"


def fetch_poster(sku: str, out_dir: Path, base_url: str = BASE_URL,
                 overwrite: bool = False) -> dict:
    """拉取单 SKU 海报, 落盘并返回实测账. 异常时抛出, 不造数."""
    url = f"{base_url.rstrip('/')}/api/report/{sku}/poster"
    resp = requests.get(url, timeout=TIMEOUT)
    if resp.status_code != 200:
        raise RuntimeError(f"HTTP {resp.status_code} @ {url}")
    try:
        payload = resp.json()
    except ValueError as e:
        raise RuntimeError(f"响应非 JSON: {resp.text[:200]!r}") from e
    b64 = payload.get("b64", "")
    if not b64:
        raise RuntimeError(f"JSON 无 b64 字段, keys={list(payload)[:8]}")
    if "," in b64[:64] and b64.strip().startswith("data:"):
        b64 = b64.split(",", 1)[1]  # 容忍 data:image/png;base64, 前缀
    png = base64.b64decode(b64)
    if not png.startswith(b"\x89PNG"):
        raise RuntimeError(f"解码后非 PNG (前8字节 {png[:8].hex()})")

    out_dir.mkdir(parents=True, exist_ok=True)
    out = out_dir / f"{sku}.png"
    if out.exists() and not overwrite:
        # 幂等重跑: 已有同 SKU 产物则覆盖前留 .bak (只增不删纪律)
        out.rename(out.with_suffix(".png.bak"))
    out.write_bytes(png)

    # 实测尺寸: 以 PIL 读回文件为准, 不信引擎自述
    from PIL import Image
    with Image.open(out) as im:
        w, h = im.size
        mode = im.mode
    return {
        "sku": sku, "url": url, "http": resp.status_code,
        "b64_chars": len(b64), "bytes": out.stat().st_size,
        "size": f"{w}x{h}", "mode": mode, "path": str(out),
    }


def main() -> int:
    ap = argparse.ArgumentParser(description="拉取报告宣传海报 PNG")
    ap.add_argument("--sku", required=True, help="报告 SKU, 如 OVERSEAS-2026")
    ap.add_argument("--out", default=str(DEFAULT_OUT),
                    help="落盘目录 (默认 promo/posters/)")
    ap.add_argument("--base", default=BASE_URL, help="引擎基址")
    ap.add_argument("--overwrite", action="store_true",
                    help="覆盖已有产物不留 .bak")
    ns = ap.parse_args()
    try:
        info = fetch_poster(ns.sku, Path(ns.out), ns.base, ns.overwrite)
    except Exception as e:
        print(f"[poster] FAIL {ns.sku}: {e}")
        return 1
    print("[poster] OK sku={sku} http={http} size={size} mode={mode} "
          "bytes={bytes} b64_chars={b64_chars}".format(**info))
    print("[poster] saved ->", info["path"])
    # 落一份机器可读台账 (追加, 只增不删)
    ledger = DEFAULT_OUT / "poster_fetch_ledger.jsonl"
    with ledger.open("a", encoding="utf-8") as f:
        import datetime
        f.write(json.dumps({"ts": datetime.datetime.now().isoformat(
            timespec="seconds"), **info}, ensure_ascii=False) + "\n")
    return 0


if __name__ == "__main__":
    sys.exit(main())
