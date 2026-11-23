# -*- coding: utf-8 -*-
"""_test_save_minimal — 最小化投稿测试: 只填标题+一句话正文+保存, 确认链路通.
用 DrissionPage 原生 .input()/.type() 而非剪贴板/JS注入. 通过后再投正式稿.
"""
import os, re, sys, time, subprocess, json
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from DrissionPage import ChromiumPage, ChromiumOptions

CHROME = r"C:\Program Files\Google\Chrome\Application\chrome.exe"
PROFILE = r"F:\We-AIPO\autopub\data\browser_profiles"
acct, port = "acct05", 9398
name = "总包之声"

# 1 启动
proc = subprocess.Popen(
    [CHROME, f"--remote-debugging-port={port}",
     f"--user-data-dir={os.path.join(PROFILE, acct)}",
     "--window-size=1280,850", "--window-position=60,60",
     "--disable-blink-features=AutomationControlled", "--no-first-run",
     "--no-default-browser-check", "--disable-infobars", "https://mp.weixin.qq.com/"],
    stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
time.sleep(8)
co = ChromiumOptions(); co.set_local_port(port)
page = ChromiumPage(co)

# 2 确认登录态
src = page.html or ""
assert "登录超时" not in src and "请重新登录" not in src, "未登录!"
print("[1] 已登录", flush=True)

# 3 打开编辑器
m = re.search(r"token=(\d+)", page.url or "")
tok = m.group(1) if m else ""
page.get(f"https://mp.weixin.qq.com/cgi-bin/appmsg?t=media/appmsg_edit_v2&action=edit&isNew=1&type=77&token={tok}")
time.sleep(6)
print("[2] 编辑器URL:", (page.url or "")[:70], flush=True)

# 4 填标题: 用 click 聚焦 + actions.type 输入 (DrissionPage .input() 在公众号标题框不生效)
t_ele = page.ele("#title", timeout=15)
if not t_ele:
    page.get_screenshot(os.path.join(os.environ.get("TEMP", "/tmp"), "editor_debug.png"))
    body_txt = page.run_js("return (document.body && document.body.innerText || '').slice(0, 300);") or ""
    print(f"[3X] 标题框15s未找到 | URL: {(page.url or '')[:80]} | body: {body_txt[:160]}")
    sys.exit(1)
    print(f"[3] 标题已填: {tv[:30]}", flush=True)
else:
    print("[3X] 标题框未找到"); sys.exit(1)

# 5 正文: DrissionPage 原生输入
body = page.ele(".ProseMirror") or page.ele("[contenteditable=true]") or page.ele(".edui-body-container")
if not body:
    print("[4X] 正文编辑器未找到"); sys.exit(1)
body.click()
time.sleep(0.5)
page.actions.type("这是一篇测试稿的正文内容。用于验证投稿链路是否通畅。")
time.sleep(1)
blen = page.run_js("var ed=document.querySelector('.ProseMirror,[contenteditable=true]'); return ed?(ed.innerText||'').length:0;")
print(f"[4] 正文已输入 长度={blen}", flush=True)

# 6 保存: 用 JS 精确点击 (与 _jes2_save_diag.py 一致, 该方式曾成功)
save_r = page.run_js("""
return (function(){
  function vis(el){var e=el;while(e&&e!==document.body){var st=getComputedStyle(e);if(st.display==='none'||st.visibility==='hidden')return false;e=e.parentElement;}return !!(el.offsetParent||el.getBoundingClientRect().height>0);}
  var els=document.querySelectorAll('button, .weui-desktop-btn, [role=button], a');
  for (var i=0;i<els.length;i++){
    var t=(els[i].innerText||'').trim();
    if(t==='保存为草稿' && vis(els[i])){ els[i].click(); return 'clicked'; }
  }
  return 'notfound';
})()
""")
print(f"[5] JS点保存: {save_r}", flush=True)
time.sleep(10)  # 保存可能需要时间

# 7 验证
page.get(f"https://mp.weixin.qq.com/cgi-bin/appmsg?t=media/appmsg_list&action=list_card&lang=zh_CN&token={tok}")
time.sleep(5)
raw = page.run_js("""
return (function(){
  var xhr = new XMLHttpRequest();
  xhr.open('GET', '/cgi-bin/appmsg?action=list_ex&type=77&token=%s&lang=zh_CN&begin=0&count=10', false);
  xhr.withCredentials = true; xhr.send(); return xhr.responseText;
})()
""" % tok)
items = json.loads(raw or "{}").get("app_msg_list") or []
hit = any("链路验证" in (it.get("title") or "") for it in items)
print(f"[6] 测试稿落箱: {'PASS' if hit else 'FAIL'} | 箱内 {len(items)} 条", flush=True)
if not hit:
    for it in items[:5]:
        print(f"   - {(it.get('title') or '')[:50]}")

try: page.quit()
except Exception: pass
try: proc.terminate()
except Exception: pass
print("[done]", "PASS" if hit else "FAIL")
