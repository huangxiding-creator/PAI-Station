# -*- coding: utf-8 -*-
"""_check_drafts_all — 只读检查 acct05/01/07 草稿箱中的目标稿."""
import json, re, sys, time, os, subprocess
from DrissionPage import ChromiumPage, ChromiumOptions

CHROME = r"C:\Program Files\Google\Chrome\Application\chrome.exe"
PROFILE = r"F:\We-AIPO\autopub\data\browser_profiles"
PORTS = {"acct05": 9395, "acct01": 9396, "acct07": 9397}
KEYS = {"acct05": "建工司法解释二", "acct01": "程序争议", "acct07": "危大工程"}
ALSO = {"acct05": "EPC工程税务", "acct01": "含」字", "acct07": "先开票后付款"}

for acct, port in PORTS.items():
    proc = subprocess.Popen(
        [CHROME, f"--remote-debugging-port={port}",
         f"--user-data-dir={os.path.join(PROFILE, acct)}",
         "--window-position=-32000,-32000", "--disable-blink-features=AutomationControlled",
         "--no-first-run", "--no-default-browser-check", "about:blank"],
        stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    time.sleep(7)
    try:
        co = ChromiumOptions(); co.set_local_port(port)
        page = ChromiumPage(co)
        page.get("https://mp.weixin.qq.com/")
        time.sleep(6)
        src = page.html or ""
        m = re.search(r"token=(\d+)", page.url or "")
        tok = m.group(1) if m else ""
        if not tok:
            m2 = re.search(r"token=(\d+)", src)
            tok = m2.group(1) if m2 else ""
        if not tok:
            print(f"{acct}: 未登录"); proc.terminate(); time.sleep(2); continue
        page.get(f"https://mp.weixin.qq.com/cgi-bin/appmsg?t=media/appmsg_list&action=list_card&lang=zh_CN&token={tok}")
        time.sleep(4)
        raw = page.run_js("""
return (function(){
  var xhr = new XMLHttpRequest();
  xhr.open('GET', '/cgi-bin/appmsg?action=list_ex&type=77&token=%s&lang=zh_CN&begin=0&count=30', false);
  xhr.withCredentials = true; xhr.send(); return xhr.responseText;
})()
""" % tok)
        d = json.loads(raw or "{}")
        items = d.get("app_msg_list") or []
        print(f"--- {acct} 草稿箱 {len(items)} 条 ---")
        for it in items:
            t = (it.get("title") or "")[:56]
            if any(k in t for k in ("司法解释二", "程序争议", "含」字", "危大工程", "EPC工程税务", "建工司法解释")):
                print(f"  ★ {t}")
        # 检查我们关心的稿件
        for label, key in [("JES2之声", "建工司法解释二"), ("TAX发布", "EPC工程税务"),
                           ("JES2主题", "程序争议"), ("TAX主题", "含」字"), ("TAX痛点", "先开票后付款")]:
            hit = any(key in (it.get("title") or "") for it in items)
            print(f"  {label}: {'在箱' if hit else '不在'}")
        try: page.quit()
        except Exception: pass
    except Exception as e:
        print(f"{acct}: ERR {str(e)[:80]}")
    finally:
        try: proc.terminate()
        except Exception: pass
    time.sleep(2)
