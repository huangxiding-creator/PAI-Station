# -*- coding: utf-8 -*-
"""djyanbao_card_probe — 单卡内容+交互线索 (改版适配件 2)."""
from __future__ import annotations

import sys
import time
from pathlib import Path
from urllib.parse import quote

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from DrissionPage import ChromiumOptions, ChromiumPage   # noqa: E402

PROFILE = Path(__file__).resolve().parents[1] / "data" / "harvest" / "_djyanbao_profile"

JS = r"""
var rows = document.querySelectorAll('div.py-3.border-b');
var out = ['ROWS=' + rows.length];
for (var i = 0; i < rows.length && i < 22; i++) {
    var t = (rows[i].innerText || '').replace(/\n+/g, ' ').slice(0, 66);
    out.push(i + ': ' + t);
}
return out.join('\n');
"""


def main() -> int:
    q = sys.argv[1] if len(sys.argv) > 1 else "工程总承包"
    co = ChromiumOptions()
    co.set_argument("--window-position=-32000,0")
    co.set_user_data_path(str(PROFILE))
    co.set_local_port(9533)
    page = ChromiumPage(co)
    page.get(f"https://www.djyanbao.com/search?q={quote(q)}", timeout=25)
    time.sleep(8)
    try:
        print(page.run_js(JS))
    except Exception as e:
        print(f"[probe] JS 失败: {e}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
