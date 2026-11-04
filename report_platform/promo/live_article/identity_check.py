# -*- coding: utf-8 -*-
"""identity_check — 亲验 mp profile 登录身份 (错号事故后强化流程)."""
from __future__ import annotations

import subprocess
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

CHROME = r"C:\Program Files\Google\Chrome\Application\chrome.exe"
PROF_ROOT = Path(r"F:\We-AIPO\autopub\data\browser_profiles")
PORTS = {"acct05": 19852, "acct07": 19853}


def main() -> int:
    profile = sys.argv[1]
    port = PORTS[profile]
    proc = subprocess.Popen([
        CHROME, f"--remote-debugging-port={port}",
        f"--user-data-dir={str(PROF_ROOT / profile)}",
        "--start-minimized", "--no-first-run", "--no-default-browser-check",
        "--new-window", "https://mp.weixin.qq.com/",
    ])
    time.sleep(9)
    try:
        from DrissionPage import Chromium
        b = Chromium(addr_or_opts=f"127.0.0.1:{port}")
        tab = b.get_tab(b.tab_ids[-1])
        time.sleep(4)
        url = tab.url or ""
        print(f"url: {url[:80]}")
        if "/cgi-bin/home" not in url and "token=" not in url:
            print("VERDICT: NOT_LOGGED_IN")
            return 2
        # 账号名探测 (多选择器梯)
        name = tab.run_js("""
            return (function(){
                var sels = ['.weui-desktop_account_name', '.account_box .nickname',
                            'a.title.ant-dropdown-link', '.weui-desktop_name',
                            '[class*=nickname]', '.mp-home-account .name'];
                for (var i=0;i<sels.length;i++){
                    var els = document.querySelectorAll(sels[i]);
                    for (var j=0;j<els.length;j++){
                        var t = (els[j].innerText||'').trim();
                        if (t && t.length>1 && t.length<20) return t;
                    }
                }
                // 兜底: 页面全文找已知号名
                var txt = document.body.innerText || '';
                ['总包之声','总包说','工程行业大脑'].forEach(function(n){
                    if (txt.indexOf(n)>=0 && !window.__hit) { window.__hit = n; }
                });
                return window.__hit || '';
            })();
        """)
        print(f"identity: {name!r}")
        print(f"VERDICT: {'OK' if name else 'UNKNOWN'}")
        return 0
    finally:
        try:
            b.quit()
        except Exception:
            proc.terminate()


if __name__ == "__main__":
    sys.exit(main())
