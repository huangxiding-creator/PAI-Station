# -*- coding: utf-8 -*-
"""微信支付商户注册向导 CDP 直驱器 (1008).

背景: superpowers MCP 焊死在 9222, 而 9222 被 WeAIPO 视频号发布腿认作
生产口占用 (1008 实锤: pythonw 4 连接 actively 驱动). 本驱动独立附着
冷门口 9327 的 Edge, 零依赖 MCP.

用法 (子命令):
  tabs                 列标签页
  open <url>           新开标签页到 url
  eval <js_file>       在活动页执行 JS, 打印结果
  shot <out.png>       活动页截图
  click <selector>     点元素
  text <selector>      抽元素文本 (默认 body)
"""
import json
import sys
import time
import urllib.request

import websocket

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

BASE = "http://127.0.0.1:9327"
_ws = {"conn": None, "id": 0}


def _tabs():
    with urllib.request.urlopen(BASE + "/json", timeout=5) as r:
        return json.load(r)


def _page_tab():
    for t in _tabs():
        if t.get("type") == "page":
            return t
    raise SystemExit("no page tab")


def _ws_conn():
    if _ws["conn"] is None:
        t = _page_tab()
        # Edge/Chrome 拒带 Origin 头的 WS 握手(403), suppress_origin 根治
        _ws["conn"] = websocket.create_connection(
            t["webSocketDebuggerUrl"], timeout=20, suppress_origin=True)
    return _ws["conn"]


def cmd(method, params=None, timeout=20):
    _ws["id"] += 1
    mid = _ws["id"]
    _ws_conn().send(json.dumps({"id": mid, "method": method,
                                "params": params or {}}))
    deadline = time.time() + timeout
    while time.time() < deadline:
        _ws_conn().settimeout(max(0.5, deadline - time.time()))
        raw = _ws_conn().recv()
        msg = json.loads(raw)
        if msg.get("id") == mid:
            if "error" in msg:
                return {"__error": msg["error"]}
            return msg.get("result", {})
    return {"__error": "timeout"}


def eval_js(js, await_promise=False):
    r = cmd("Runtime.evaluate", {
        "expression": js, "returnByValue": True,
        "awaitPromise": await_promise}, timeout=30)
    if r.get("__error"):
        return json.dumps(r, ensure_ascii=False)
    res = r.get("result", {})
    if res.get("subtype") == "error" or "exceptionDetails" in r:
        return "EVAL_ERROR: " + json.dumps(
            r.get("exceptionDetails", res), ensure_ascii=False)[:500]
    return res.get("value")


def main():
    if len(sys.argv) < 2:
        print(__doc__)
        return
    op = sys.argv[1]
    if op == "tabs":
        for t in _tabs():
            print(t.get("type"), "|", t.get("title", "")[:40], "|",
                  t.get("url", "")[:80])
    elif op == "open":
        url = sys.argv[2]
        req = urllib.request.Request(
            BASE + "/json/new?" + urllib.parse.quote(url, safe=":/?&=%"),
            method="PUT")
        with urllib.request.urlopen(req, timeout=10) as r:
            print(json.dumps(json.load(r), ensure_ascii=False)[:200])
    elif op == "eval":
        js = open(sys.argv[2], encoding="utf-8").read()
        out = eval_js(js)
        print(out if isinstance(out, str) else json.dumps(
            out, ensure_ascii=False))
    elif op == "shot":
        r = cmd("Page.captureScreenshot", {"format": "png"}, timeout=30)
        import base64
        with open(sys.argv[2], "wb") as f:
            f.write(base64.b64decode(r.get("data", "")))
        print("saved " + sys.argv[2])
    elif op == "click":
        sel = sys.argv[2]
        js = ("(function(){const e=document.querySelector("
              + json.dumps(sel) + ");if(!e)return 'NO_EL';e.click();"
              "return 'CLICKED';})()")
        print(eval_js(js))
    elif op == "text":
        sel = sys.argv[2] if len(sys.argv) > 2 else "body"
        js = ("(function(){const e=document.querySelector("
              + json.dumps(sel) + ");return e?e.innerText.slice(0,4000):"
              "'NO_EL';})()")
        print(eval_js(js))


if __name__ == "__main__":
    import urllib.parse  # noqa: E402  (open 用)
    main()
