# -*- coding: utf-8 -*-
"""djyanbao_search_probe — 新版 /search?q= 页卡片结构探测 (改版适配件).

用法: py -3.11 reforge_factory/djyanbao_search_probe.py [查询词]
"""
from __future__ import annotations

import sys
import time
from pathlib import Path
from urllib.parse import quote

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from DrissionPage import ChromiumOptions, ChromiumPage   # noqa: E402

PROFILE = Path(__file__).resolve().parents[1] / "data" / "harvest" / "_djyanbao_profile"

JS = r"""
var out = [];
var body = document.body.innerText || '';
out.push('FAIL=' + (body.indexOf('研报加载失败') >= 0));
out.push('LOGIN=' + (body.indexOf('登录 / 注册') < 0 || body.indexOf('退出') >= 0));
var links = Array.from(document.querySelectorAll('a[href]')).filter(function(a){
    return a.offsetParent !== null && /report|detail|\/r\/|pdf/i.test(a.href);
});
out.push('LINKS=' + links.length);
links.slice(0, 6).forEach(function(a){
    out.push('  a: ' + a.href.slice(0, 76) + ' | ' +
             (a.innerText || '').replace(/\s+/g, ' ').slice(0, 40));
});
var big = Array.from(document.querySelectorAll('div,li,article')).filter(function(el){
    if (el.offsetParent === null || !el.className) return false;
    var r = el.getBoundingClientRect();
    return r.width > 260 && r.height > 60 && el.children.length >= 1;
});
var seen = {};
big.slice(0, 40).forEach(function(el){
    var c = String(el.className).slice(0, 56);
    if (!seen[c]) { seen[c] = 1; out.push('DIV ' + c + ' n=' + el.children.length); }
});
return out.slice(0, 40).join('\n');
"""


def main() -> int:
    q = sys.argv[1] if len(sys.argv) > 1 else "工程总承包"
    co = ChromiumOptions()
    co.set_argument("--window-position=-32000,0")
    co.set_user_data_path(str(PROFILE))
    co.set_local_port(9533)
    page = ChromiumPage(co)
    page.get(f"https://www.djyanbao.com/search?q={quote(q)}", timeout=25)
    time.sleep(7)                                   # 列表 API 异步渲染
    print(f"[probe] /search?q={q}")
    try:
        print(page.run_js(JS))
    except Exception as e:
        print(f"[probe] JS 失败: {e}")
        print("[probe] body 前 300:", (page.ele("tag:body").text or "")[:300])
    return 0


if __name__ == "__main__":
    sys.exit(main())
