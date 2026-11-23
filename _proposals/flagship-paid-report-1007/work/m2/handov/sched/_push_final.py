# -*- coding: utf-8 -*-
"""_push_final — 最终版投稿: DrissionPage 原生输入, 不走剪贴板/execCommand/JS注入.
策略: 标题 click+type; 正文 click+逐段 type; 保存 click; 验证.
用法: py -X utf8 _push_final.py <acct> <md_path> <title> <img_path> <verify_key>
"""
import json, os, re, subprocess, sys, time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from DrissionPage import ChromiumPage, ChromiumOptions

CHROME = r"C:\Program Files\Google\Chrome\Application\chrome.exe"
PROFILE = r"F:\We-AIPO\autopub\data\browser_profiles"
KB = r"E:\AI-Station\电力KB收割"
PORTS = {"acct05": 9405, "acct01": 9406, "acct07": 9407}

acct = sys.argv[1]
md_path = sys.argv[2]
title = sys.argv[3]
img_path = sys.argv[4]
verify_key = sys.argv[5] if len(sys.argv) > 5 else title[:10]
port = PORTS[acct]

# 读 md → 纯文本段落列表
paras = []
md = open(md_path, encoding="utf-8").read()
for ln in md.splitlines():
    s = ln.strip()
    if s.startswith("# ") or s.startswith("!["):
        continue
    if s.startswith("## "):
        paras.append(s[3:])
    elif s.startswith("> "):
        paras.append(s[2:])
    elif s:
        import re as R
        t = R.sub(r"\*\*(.+?)\*\*", r"\1", s)
        paras.append(t)
print(f"[prep] 正文 {len(paras)} 段 {sum(len(p) for p in paras)} 字", flush=True)

# 清残留
subprocess.run(["powershell", "-NoProfile", "-Command",
                f"Get-CimInstance Win32_Process -Filter \"Name='chrome.exe'\" | "
                f"Where-Object {{$_.CommandLine -match '{acct}'}} | "
                "ForEach-Object { Stop-Process -Id $_.ProcessId -Force -ErrorAction SilentlyContinue }"],
               capture_output=True, timeout=30)
time.sleep(3)

# 起 Chrome
proc = subprocess.Popen(
    [CHROME, f"--remote-debugging-port={port}",
     f"--user-data-dir={os.path.join(PROFILE, acct)}",
     "--window-size=1280,850", "--window-position=60,60",
     "--disable-blink-features=AutomationControlled", "--no-first-run",
     "--no-default-browser-check", "--disable-infobars",
     "https://mp.weixin.qq.com/"],
    stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
time.sleep(8)

try:
    co = ChromiumOptions(); co.set_local_port(port)
    page = ChromiumPage(co)
    src = page.html or ""
    if "登录超时" in src or "请重新登录" in src:
        cred = json.load(open(os.path.join(KB, f"mp_cred_{acct}.json"), encoding="utf-8"))
        cookies = cred.get("cookies") or {}
        pairs = [{"name": k, "value": v} for k, v in cookies.items()] if isinstance(cookies, dict) else cookies
        page.set.cookies(pairs)
        time.sleep(1)
        page.get("https://mp.weixin.qq.com/")
        time.sleep(5)
    m = re.search(r"token=(\d+)", page.url or "") or re.search(r"token=(\d+)", page.html or "")
    tok = m.group(1) if m else ""
    if not tok:
        print(f"[{acct}] 未登录"); sys.exit(1)
    print(f"[{acct}] token={tok}", flush=True)

    # 打开编辑器
    page.get(f"https://mp.weixin.qq.com/cgi-bin/appmsg?t=media/appmsg_edit_v2&action=edit&isNew=1&type=77&token={tok}")
    time.sleep(8)
    # 等编辑器就绪
    for _ in range(20):
        r = page.run_js("return document.getElementById('title') ? 1 : 0;")
        if r == 1: break
        time.sleep(1.5)
    print(f"[{acct}] 编辑器就绪", flush=True)

    # 标题: click 聚焦 + actions.type
    t_ele = page.ele("#title", timeout=10)
    if t_ele:
        t_ele.click()
        time.sleep(0.3)
        page.actions.type(title)
        time.sleep(0.5)
        print(f"[{acct}] 标题已输入", flush=True)

    # 正文: 聚焦正文编辑器, 逐段 type
    body = page.ele(".ProseMirror") or page.ele("[contenteditable=true]") or page.ele(".edui-body-container")
    if body:
        body.click()
        time.sleep(0.5)
        for i, para in enumerate(paras):
            if i > 0:
                page.actions.key_down("Enter").key_up("Enter")
            page.actions.type(para)
            time.sleep(0.3)
        blen = page.run_js("var ed=document.querySelector('.ProseMirror,[contenteditable=true],.edui-body-container'); return ed?(ed.innerText||'').length:0;")
        print(f"[{acct}] 正文已输入 长度={blen}", flush=True)

    # 海报: DrissionPage 文件上传
    img_ele = page.ele("tag:input[type=file]", timeout=3)
    if img_ele:
        img_ele.input(img_path)
        time.sleep(5)
        print(f"[{acct}] 海报已上传", flush=True)
    else:
        print(f"[{acct}] 海报上传入口未找到(纯文文稿)", flush=True)

    # 保存
    save = page.ele("text:保存为草稿", timeout=5)
    if save:
        save.click()
        print(f"[{acct}] 已点保存", flush=True)
    else:
        print(f"[{acct}] 保存按钮未找到"); sys.exit(1)
    time.sleep(15)

    # 落箱验证
    page.get(f"https://mp.weixin.qq.com/cgi-bin/appmsg?t=media/appmsg_list&action=list_card&lang=zh_CN&token={tok}")
    time.sleep(5)
    raw = page.run_js("""
return (function(){
  var xhr = new XMLHttpRequest();
  xhr.open('GET', '/cgi-bin/appmsg?action=list_ex&type=77&token=%s&lang=zh_CN&begin=0&count=30', false);
  xhr.withCredentials = true; xhr.send(); return xhr.responseText;
})()
""" % tok)
    items = json.loads(raw or "{}").get("app_msg_list") or []
    hit = any(verify_key in (it.get("title") or "") for it in items)
    print(f"[{acct}] 落箱: {'PASS' if hit else 'FAIL'} | 箱内 {len(items)} 条", flush=True)

except Exception as e:
    print(f"[{acct}] 异常: {str(e)[:120]}", flush=True)
finally:
    try: page.quit()
    except Exception: pass
    try: proc.terminate()
    except Exception: pass
    time.sleep(2)
