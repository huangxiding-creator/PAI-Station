# -*- coding: utf-8 -*-
"""_acct_alive_check — 只读探活: 手工起Chrome→看首页是否登录超时→关. 不注入任何cookie."""
import os, subprocess, sys, time
from DrissionPage import ChromiumPage, ChromiumOptions

CHROME = r"C:\Program Files\Google\Chrome\Application\chrome.exe"
PROFILE = r"F:\We-AIPO\autopub\data\browser_profiles"
PORTS = {"acct01": 9362, "acct05": 9361, "acct07": 9363}
accts = sys.argv[1:] or ["acct05", "acct01", "acct07"]
for acct in accts:
    port = PORTS[acct]
    proc = subprocess.Popen([CHROME, f"--remote-debugging-port={port}", f"--user-data-dir={os.path.join(PROFILE, acct)}",
                             "--window-position=-32000,-32000", "--disable-blink-features=AutomationControlled", "--no-first-run", "about:blank"],
                            stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    time.sleep(7)
    try:
        co = ChromiumOptions(); co.set_local_port(port)
        page = ChromiumPage(co)
        page.get("https://mp.weixin.qq.com/")
        time.sleep(6)
        src = page.html or ""
        url = page.url or ""
        # 以首页判活 (列表页不带token一律回登录超时, 不可作探活页 — 1122修)
        import re as _re
        dead = ("登录超时" in src) or ("请重新登录" in src)
        alive = (not dead) and (bool(_re.search(r"token=\d+", url)) or ("新的创作" in src))
        print(f"{acct}: alive={alive} url={url[:60]}", flush=True)
        try: page.quit()
        except Exception: pass
    except Exception as e:
        print(f"{acct}: ERR {str(e)[:60]}", flush=True)
    finally:
        try: proc.terminate()
        except Exception: pass
    time.sleep(3)
