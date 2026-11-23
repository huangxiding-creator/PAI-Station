# -*- coding: utf-8 -*-
"""_session_cookie_profile — 只读分析某个公众号 profile 的会话 cookie 结构.
做法: 用该 profile 离屏起浏览器 → 打开公众平台首页(只读) → 通过 CDP 读 cookie 属性
→ 打开草稿箱列表(只读) → 再读一次, 看哪些 cookie 的过期时间被刷新 → 优雅关闭.
输出只有 cookie 名与属性(域名/过期时间/是否会话级/HttpOnly/Secure), 不输出 cookie 值.
绝不写入、删除或注入任何 cookie.
用法: py -X utf8 _session_cookie_profile.py acct07
"""
import json
import subprocess
import sys
import time
import urllib.request
from datetime import datetime
from pathlib import Path

import websocket

CHROME = r"C:\Program Files\Google\Chrome\Application\chrome.exe"
PROFILE_ROOT = r"F:\We-AIPO\autopub\data\browser_profiles"
PORT = {"acct05": 9391, "acct01": 9392, "acct07": 9393}

acct = sys.argv[1] if len(sys.argv) > 1 else "acct07"
port = PORT[acct]
proc = subprocess.Popen(
    [CHROME, f"--remote-debugging-port={port}", f"--user-data-dir={Path(PROFILE_ROOT) / acct}",
     "--window-position=-32000,-32000", "--window-size=1280,800",
     "--disable-blink-features=AutomationControlled", "--no-first-run",
     "--no-default-browser-check", "--disable-infobars", "about:blank"],
    stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
try:
    time.sleep(7)
    tabs = json.loads(urllib.request.urlopen(f"http://127.0.0.1:{port}/json", timeout=5).read().decode())
    page = next(t for t in tabs if t.get("type") == "page")
    ws = websocket.create_connection(page["webSocketDebuggerUrl"], timeout=20)
    mid = [0]

    def cdp(method, **params):
        mid[0] += 1
        ws.send(json.dumps({"id": mid[0], "method": method, "params": params}))
        while True:
            msg = json.loads(ws.recv())
            if msg.get("id") == mid[0]:
                if "error" in msg:
                    raise RuntimeError(msg["error"])
                return msg.get("result", {})

    def cookies_mp():
        res = cdp("Network.getAllCookies")
        return [c for c in res.get("cookies", []) if "weixin.qq.com" in c.get("domain", "")]

    def describe(label):
        cks = cookies_mp()
        print(f"\n=== {label}: mp/weixin 域 cookie {len(cks)} 个 ===")
        print(f"{'cookie名':<24}{'过期':<22}{'剩余':<12}{'会话级':<8}{'HttpOnly':<9}{'Secure'}")
        now = time.time()
        for c in sorted(cks, key=lambda c: c.get("expires", 0)):
            exp = c.get("expires", 0)
            if exp <= 0:
                exp_s, left, sess = "(会话级)", "-", "是"
            else:
                exp_s = datetime.fromtimestamp(exp).strftime("%Y-%m-%d %H:%M")
                left = f"{(exp - now) / 86400:.1f}天" if exp > now else "已过期"
                sess = "否"
            print(f"{c['name'][:23]:<24}{exp_s:<22}{left:<12}{sess:<8}{str(bool(c.get('httpOnly'))):<9}{bool(c.get('secure'))}")
        return {c["name"]: c.get("expires", 0) for c in cks}

    cdp("Network.enable")
    cur = cdp("Target.getTargetInfo") if False else None
    before = describe("打开首页前")

    # 只读导航: 首页
    setc = []
    ws.settimeout(2)
    ws.send(json.dumps({"id": 999, "method": "Page.navigate", "params": {"url": "https://mp.weixin.qq.com/"}}))
    t0 = time.time()
    while time.time() - t0 < 15:
        try:
            m = json.loads(ws.recv())
            if m.get("method") == "Network.responseReceivedExtraInfo":
                for k, v in (m.get("params", {}).get("headers") or {}).items():
                    if k.lower() == "set-cookie":
                        setc.append(v)
        except Exception:
            pass
    ws.settimeout(20)
    # 当前 URL
    mid[0] += 1
    ws.send(json.dumps({"id": mid[0], "method": "Runtime.evaluate", "params": {"expression": "location.href", "returnByValue": True}}))
    while True:
        m = json.loads(ws.recv())
        if m.get("id") == mid[0]:
            url = m.get("result", {}).get("result", {}).get("value", "")
            break
    import re
    tok = re.search(r"token=(\d+)", url or "")
    print("\n首页跳转:", "已进入后台(URL 带 token)" if tok else f"未进入后台 ({(url or '')[:60]})")
    after_home = describe("打开首页后")
    names_home = sorted({re.match(r"\s*([^=]+)=", v).group(1).strip() for v in setc if re.match(r"\s*([^=]+)=", v)})
    print("首页响应里被服务器重新下发的 cookie:", names_home or "无")

    # 只读导航: 草稿箱列表 (带 token)
    setc2 = []
    if tok:
        ws.settimeout(2)
        ws.send(json.dumps({"id": 1000, "method": "Page.navigate",
                            "params": {"url": f"https://mp.weixin.qq.com/cgi-bin/appmsg?t=media/appmsg_list&action=list_card&lang=zh_CN&token={tok.group(1)}"}}))
        t0 = time.time()
        while time.time() - t0 < 12:
            try:
                m = json.loads(ws.recv())
                if m.get("method") == "Network.responseReceivedExtraInfo":
                    for k, v in (m.get("params", {}).get("headers") or {}).items():
                        if k.lower() == "set-cookie":
                            setc2.append(v)
            except Exception:
                pass
        ws.settimeout(20)
        after_list = describe("打开草稿箱后")
        names_list = sorted({re.match(r"\s*([^=]+)=", v).group(1).strip() for v in setc2 if re.match(r"\s*([^=]+)=", v)})
        print("草稿箱响应里被服务器重新下发的 cookie:", names_list or "无")
        changed = [n for n in after_list if after_list[n] != before.get(n)]
        print("两次只读访问后过期时间发生变化的 cookie:", changed or "无")
    ws.close()
finally:
    try:
        ver = json.loads(urllib.request.urlopen(f"http://127.0.0.1:{port}/json/version", timeout=5).read().decode())
        w = websocket.create_connection(ver["webSocketDebuggerUrl"], timeout=5)
        w.send(json.dumps({"id": 1, "method": "Browser.close"}))
        time.sleep(1.5)
        w.close()
        print("\n已优雅关闭浏览器 (cookie 正常落盘)")
    except Exception as e:
        print("关闭浏览器时:", str(e)[:60])
    time.sleep(1)
    try:
        proc.terminate()
    except Exception:
        pass
