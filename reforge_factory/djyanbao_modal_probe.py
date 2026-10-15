# -*- coding: utf-8 -*-
"""djyanbao_modal_probe — 卡片点击弹层探测 (改版适配 4)."""
from __future__ import annotations

import sys
import time
from pathlib import Path
from urllib.parse import quote

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from DrissionPage import ChromiumOptions, ChromiumPage   # noqa: E402

PROFILE = Path(__file__).resolve().parents[1] / "data" / "harvest" / "_djyanbao_profile"

JS_MODAL = r"""
var out = [];
var sels = ['.ant-modal', '[class*=modal]', '[class*=drawer]', '[role=dialog]',
            '[class*=Dialog]', '[class*=popup]', '[class*=Popup]'];
var found = {};
sels.forEach(function(s){
    document.querySelectorAll(s).forEach(function(el){
        if (el.offsetParent !== null) {
            var key = s + '|' + String(el.className).slice(0, 40);
            if (!found[key]) {
                found[key] = 1;
                out.push('MODAL ' + s + ' class=' + String(el.className).slice(0, 50));
                out.push('  text: ' + (el.innerText || '').replace(/\n+/g, ' ').slice(0, 220));
            }
        }
    });
});
if (!out.length) out.push('NO MODAL VISIBLE');
return out.join('\n');
"""


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
    card.click()
    time.sleep(4)
    print("[modal] 点卡后:")
    print(page.run_js(JS_MODAL))
    # 也试点卡内标题文本节点本身 (最深文本 span)
    try:
        title_el = card.ele(
            'xpath:.//span[contains(@class,"font-medium")]|.//h3|.//h2|'
            './/div[contains(@class,"font-bold")]', timeout=3)
        if title_el:
            title_el.click()
            time.sleep(4)
            print("[modal] 点标题文本后:")
            print(page.run_js(JS_MODAL))
    except Exception as e:
        print(f"[modal] 标题定位失败: {str(e)[:60]}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
