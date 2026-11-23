# -*- coding: utf-8 -*-
"""_qr_relogin — 单号「先退出再弹码」: profile 登着异号时, 先在其浏览器内点「退出登录」
(官方流程, 仅注销本 profile 会话) → 回登录页出二维码 → 纯观察等扫 → 核对昵称.
用法: py -X utf8 _qr_relogin.py acct05 总包之声 [超时秒=600]
纪律: 二维码弹出后绝不刷新; 成功后昵称不符则报警不存快照.
"""
import os
import re
import subprocess
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from DrissionPage import ChromiumPage, ChromiumOptions  # noqa: E402

CHROME = r"C:\Program Files\Google\Chrome\Application\chrome.exe"
PROFILE = r"F:\We-AIPO\autopub\data\browser_profiles"
PORTS = {"acct05": 9351, "acct01": 9352, "acct07": 9353}

acct = sys.argv[1]
expect = sys.argv[2]
TIMEOUT = int(sys.argv[3]) if len(sys.argv) > 3 else 600
port = PORTS[acct]

subprocess.run(["powershell", "-NoProfile", "-Command",
                f"Get-CimInstance Win32_Process -Filter \"Name='chrome.exe'\" | "
                f"Where-Object {{$_.CommandLine -match '{acct}'}} | "
                "ForEach-Object { Stop-Process -Id $_.ProcessId -Force -ErrorAction SilentlyContinue }"],
               capture_output=True, timeout=30)
time.sleep(2)
proc = subprocess.Popen(
    [CHROME, f"--remote-debugging-port={port}",
     f"--user-data-dir={os.path.join(PROFILE, acct)}",
     "--window-size=1100,850", "--window-position=80,80",
     "--disable-blink-features=AutomationControlled", "--no-first-run",
     "--no-default-browser-check", "--disable-infobars",
     "https://mp.weixin.qq.com/"],
    stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
print(f"[launch] {acct} 窗口已弹 (pid={proc.pid})", flush=True)
time.sleep(8)
co = ChromiumOptions()
co.set_local_port(port)
page = ChromiumPage(co)


def nickname() -> str:
    src = page.html or ""
    m = re.search(r'"nickname"\s*:\s*"([^"]+)"', src)
    return m.group(1) if m else ""


try:
    src = page.html or ""
    logged = bool(re.search(r"token=\d+", page.url or "")) or ("新的创作" in src)
    cur = nickname()
    print(f"[state] 已登录={logged} 当前昵称={cur or '-'}", flush=True)
    if logged and cur != expect:
        print(f"[logout] 登着异号「{cur}」→ 点退出登录", flush=True)
        r = page.run_js("""
return (function(){
  function vis(el){var e=el;while(e&&e!==document.body){var st=getComputedStyle(e);if(st.display==='none'||st.visibility==='hidden')return false;e=e.parentElement;}return !!(el.offsetParent||el.getBoundingClientRect().height>0);}
  var bs=document.querySelectorAll('button, a, [role=button], .weui-desktop-btn, span, div');
  for (var i=0;i<bs.length;i++){
    var t=(bs[i].innerText||'').replace(/\\s+/g,'').trim();
    if(t==='退出登录' && vis(bs[i]) && bs[i].innerText.length<12){ bs[i].click(); return 'clicked'; }
  }
  return 'notfound';
})()
""")
        print(f"[logout] {r}", flush=True)
        time.sleep(3)
        # 确认弹窗 (仅当确实点了退出登录才找确认钮, 防误点页面其他「确定」)
        for _ in range(5 if r == "clicked" else 0):
            c = page.run_js("""
return (function(){
  function vis(el){var e=el;while(e&&e!==document.body){var st=getComputedStyle(e);if(st.display==='none'||st.visibility==='hidden')return false;e=e.parentElement;}return !!(el.offsetParent||el.getBoundingClientRect().height>0);}
  var bs=document.querySelectorAll('button, .weui-desktop-btn, [role=button], a');
  var wants=['退出','确定','确认'];
  for (var w=0;w<wants.length;w++){
    for (var i=0;i<bs.length;i++){
      var t=(bs[i].innerText||'').replace(/\\s+/g,'').trim();
      if(t===wants[w] && vis(bs[i])){ bs[i].click(); return 'ok:'+wants[w]; }
    }
  }
  return '';
})()
""")
            if not c:
                break
            print(f"[logout-confirm] {c}", flush=True)
            time.sleep(2)
        time.sleep(5)
        src = page.html or ""
        if re.search(r"token=\d+", page.url or "") or "新的创作" in src:
            # 退出未生效: 兜底清本 profile 的 mp.weixin.qq.com 域 cookie (CDP 精准删;
            # 仅本地丢弃会话不通知服务器注销 → 不会踢掉其他 profile 的同号登录)
            print("[logout] 按钮退出未生效 → CDP 清本profile的mp.weixin.qq.com cookie后重载出码", flush=True)
            try:
                cks = page.run_cdp("Network.getCookies", urls=["https://mp.weixin.qq.com/"])
                n = 0
                for c in (cks.get("cookies") or []):
                    page.run_cdp("Network.deleteCookies", name=c.get("name", ""), domain=c.get("domain", ""))
                    n += 1
                print(f"[logout] 已清 {n} 个cookie", flush=True)
            except Exception as e:
                print(f"[logout] CDP清cookie异常: {str(e)[:80]}", flush=True)
            page.get("https://mp.weixin.qq.com/")
            time.sleep(6)
    print(f"[qr] 二维码已出 — 请用管理员微信扫码, **手机端选择「{expect}」登录**; 此后不刷新", flush=True)
    t0 = time.time()
    last = 0
    while time.time() - t0 < TIMEOUT:
        try:
            src = page.html or ""
            if re.search(r"token=\d+", page.url or "") or "新的创作" in src:
                cur = nickname()
                if cur == expect:
                    print(f"[ok] 登录成功, 昵称核对一致: {cur} ({int(time.time()-t0)}s)", flush=True)
                    time.sleep(4)
                    raise SystemExit(0)
                elif cur:
                    print(f"[warn] 登录的是「{cur}」≠ 期望「{expect}」— 请退出重扫并选择正确账号", flush=True)
                    time.sleep(15)
        except SystemExit:
            raise
        except Exception:
            pass
        now = time.time() - t0
        if now - last >= 20:
            print(f"[wait] 已等 {int(now)}s — 码不动, 请扫", flush=True)
            last = now
        time.sleep(4)
    print("[timeout] 未检测到登录, 窗口保留", flush=True)
    raise SystemExit(1)
finally:
    try:
        page.quit()
    except Exception:
        pass
