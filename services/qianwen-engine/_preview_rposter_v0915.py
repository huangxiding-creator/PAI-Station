# -*- coding: utf-8 -*-
"""_preview_rposter_v0915.py — v0.9.15 研报海报本地预览（真 report.json 数据，无码兜底）。

用法: python _preview_rposter_v0915.py [sku]  → 渲染 _preview_rposter_<sku>.png
"""
import json
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE))

from qianwen_engine import poster  # noqa: E402

DATA = Path(r"E:/AI-Station/report_platform/content/report.json")


def norm_badges(badges):
    import re
    PURE = re.compile(r"^[0-9]+(?:\.[0-9]+)?$")
    out = []
    for b in badges or []:
        if (isinstance(b, dict) and {"k", "v"} <= b.keys()
                and PURE.match(str(b.get("v") or ""))
                and not PURE.match(str(b.get("k") or ""))):
            out.append({"k": b["v"], "v": b["k"]})
        else:
            out.append(b)
    return out


def main() -> int:
    sku = sys.argv[1] if len(sys.argv) > 1 else "CNNC-EPC"
    reports = json.loads(DATA.read_text(encoding="utf-8"))["reports"]
    r = next(x for x in reports if x["sku"] == sku)
    d = {
        "sku": r["sku"], "title": r["title"], "subtitle": r.get("subtitle", ""),
        "words_wan": r.get("words_wan"), "badges": norm_badges(r.get("badges")),
        "chapters": r.get("chapters") or [], "cat_name": r.get("cat_name", ""),
    }
    png = poster.build_report(d, qr_png=None, catalog_count=len(reports))
    out = HERE / f"_preview_rposter_{sku}.png"
    out.write_bytes(png)
    print(f"OK {sku} -> {out.name} {len(png)}B h≈?")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
