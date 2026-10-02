# -*- coding: utf-8 -*-
"""决定性实验: 真点发送键 + 监听 api.manus.im — 判定点击无效的三种形态.
形态A 请求发出被拒(4xx/5xx)=服务端拒绝; 形态B 请求没发=前端拦截/遮挡/disabled;
形态C 成功创建=sid 到手(顺手成为军团今日第一单, prompt 是真实待派题).
"""
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
import manus_lib as lib

page = lib.make_page()
print(f"[probe] url = {page.url}")

box = page.ele("xpath://*[@contenteditable='true']", timeout=5)
if not box:
    print("[probe] composer 不在 — 页面非主界面, 中止")
    sys.exit(1)
resid = (box.text or "")[:60]
print(f"[probe] composer 残留: {resid!r}")

anc = box.parent().parent()
btns = anc.eles("tag:button")
send = btns[-1]
r = send.run_js("function(){var r=this.getBoundingClientRect();"
                "return JSON.stringify({x:r.x,y:r.y,w:r.width,h:r.height,"
                "dis:this.disabled,adis:this.getAttribute('aria-disabled'),"
                "cls:this.className.slice(0,120)});}")
print(f"[probe] 发送键态: {r}")

# 若按钮带 aria-disabled=true, 先看 React 是否感知了输入 (输入事件疑点)
box.click()
time.sleep(0.5)
r2 = send.run_js("function(){return JSON.stringify({dis:this.disabled,"
                 "adis:this.getAttribute('aria-disabled')});}")
print(f"[probe] 点击composer后发送键态: {r2}")

page.listen.start("api.manus.im")
print("[probe] === 步骤1: 元素 click() ===", flush=True)
try:
    send.click()
    print("[probe] click 无异常")
except Exception as e:
    print(f"[probe] click 异常 {type(e).__name__}: {str(e)[:60]}")

deadline = time.time() + 15
hit = []
while time.time() < deadline:
    m = __import__("re").search(r"/app/([A-Za-z0-9_-]{8,})", page.url or "")
    if m:
        print(f"[probe] ✓✓ URL 跳转 sid={m.group(1)} — 形态C 创建成功!")
        break
    try:
        pkt = page.listen.wait(timeout=1)
        if pkt and not pkt.is_failed:
            u = pkt.url.split("?")[0]
            if u not in hit:
                hit.append(u)
                print(f"[probe] api包: {pkt.response.status} {u}")
    except Exception:
        pass

if not hit and "/app/" not in (page.url or ""):
    print("[probe] === 步骤2: 坐标点击 (actions) ===", flush=True)
    import json as _j
    geo = _j.loads(send.run_js(
        "function(){var r=this.getBoundingClientRect();"
        "return JSON.stringify({x:r.x+r.width/2,y:r.y+r.height/2});}"))
    page.actions.click((geo["x"], geo["y"]))
    deadline = time.time() + 15
    while time.time() < deadline:
        m = __import__("re").search(r"/app/([A-Za-z0-9_-]{8,})", page.url or "")
        if m:
            print(f"[probe] ✓✓ 坐标点中! sid={m.group(1)}")
            break
        try:
            pkt = page.listen.wait(timeout=1)
            if pkt and not pkt.is_failed:
                u = pkt.url.split("?")[0]
                if u not in hit:
                    hit.append(u)
                    print(f"[probe] api包: {pkt.response.status} {u}")
        except Exception:
            pass

if not hit and "/app/" not in (page.url or ""):
    print("[probe] === 步骤3: Enter 兜底 ===", flush=True)
    page.actions.key_down("enter").key_up("enter")
    deadline = time.time() + 12
    while time.time() < deadline:
        m = __import__("re").search(r"/app/([A-Za-z0-9_-]{8,})", page.url or "")
        if m:
            print(f"[probe] ✓✓ Enter 中! sid={m.group(1)}")
            break
        try:
            pkt = page.listen.wait(timeout=1)
            if pkt and not pkt.is_failed:
                u = pkt.url.split("?")[0]
                if u not in hit:
                    hit.append(u)
                    print(f"[probe] api包: {pkt.response.status} {u}")
        except Exception:
            pass

page.listen.stop()
final = page.url or ""
print(f"[probe] 终态 url = {final}")
print(f"[probe] 判定: "
      + ("形态C 创建成功" if "/app/" in final and "from=web" not in final
         else ("形态A 服务端拒绝" if hit else "形态B 前端无反应")))
