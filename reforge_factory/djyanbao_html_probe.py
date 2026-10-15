# -*- coding: utf-8 -*-
"""djyanbao_html_probe — 单卡 outerHTML 落盘 (改版适配 6)."""
from __future__ import annotations

import sys
import time
from pathlib import Path
from urllib.parse import quote

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from DrissionPage import ChromiumOptions, ChromiumPage   # noqa: E402

PROFILE = Path(__file__).resolve().parents[1] / "data" / "harvest" / "_djyanbao_profile"


def main() -> int:
    q = sys.argv[1] if len(sys.argv) > 1 else "电子招投标"
    co = ChromiumOptions()
    co.set_argument("--window-position=-32000,0")
    co.set_user_data_path(str(PROFILE))
    co.set_local_port(9533)
    page = ChromiumPage(co)
    page.get(f"https://www.djyanbao.com/search?q={quote(q)}", timeout=25)
    time.sleep(7)
    rows = page.eles(
        'xpath://div[contains(@class,"py-3") and contains(@class,"border-b")]')
    card = next(r for r in rows
                if "页" in (r.text or "") and "·" in (r.text or ""))
    html = card.html or ""
    Path("data/harvest/djyanbao_card.html").write_text(html, encoding="utf-8")
    print(f"[html] 卡片 HTML {len(html)} 字 → data/harvest/djyanbao_card.html")
    return 0


if __name__ == "__main__":
    sys.exit(main())
