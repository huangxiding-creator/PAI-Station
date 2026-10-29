# -*- coding: utf-8 -*-
"""CDP raw capture: detail page XHR + localStorage export (authorized: user's own VIP session)."""
import json, sys, time, urllib.request
import websocket

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
PORT = "9341"
PAGE_URL = "https://www.djyanbao.com/report/4522142"
OUT = r"E:/AI-Station/逆向工程/djyanbao-reverse/captures/cdp_detail_events.json"

targets = json.load(urllib.request.urlopen(f"http://127.0.0.1:{PORT}/json/list"))
page = next(t for t in targets if t["type"] == "page" and "djyanbao" in t.get("url", ""))
ws_url = page["webSocketDebuggerUrl"]
print("target:", page["url"][:80])
ws = websocket.create_connection(ws_url, timeout=20, suppress_origin=True)
mid = 0
def cmd(method, params=None):
    global mid
    mid += 1
    ws.send(json.dumps({"id": mid, "method": method, "params": params or {}}))
    while True:
        m = json.loads(ws.recv())
        if m.get("id") == mid:
            return m.get("result", {})

cmd("Network.enable")
cmd("Runtime.enable")
cmd("Page.enable")

events = []
extra_headers = {}   # requestId -> headers from ExtraInfo
bodies = {}

# reload
mid += 1
ws.send(json.dumps({"id": mid, "method": "Page.reload"}))

deadline = time.time() + 14
ws.settimeout(3)
while time.time() < deadline:
    try:
        m = json.loads(ws.recv())
    except websocket.WebSocketTimeoutException:
        continue
    except Exception:
        break
    if "method" not in m:
        continue
    ev, p = m["method"], m.get("params", {})
    if ev in ("Network.requestWillBeSent", "Network.responseReceived",
              "Network.requestWillBeSentExtraInfo", "Network.requestServedFromCache"):
        events.append({"ev": ev, "p": p})
    elif ev == "Network.loadingFinished":
        rid = p.get("requestId")
        try:
            r = cmd("Network.getResponseBody", {"requestId": rid})
            if r.get("body"):
                bodies[rid] = {"body": r["body"][:200000], "base64": r.get("base64", False)}
        except Exception:
            pass

# localStorage export (user's own profile session -> state file for replica)
ls = cmd("Runtime.evaluate", {"expression": "JSON.stringify(localStorage)", "returnByValue": True})
print("localStorage keys:", list(json.loads(ls["result"]["value"]).keys()) if ls.get("result", {}).get("value") else "ERR")

out = {"events": events, "bodies": bodies, "localStorage_raw_len": len(ls.get("result", {}).get("value") or "")}
# save localStorage separately with token
ls_val = ls.get("result", {}).get("value") or "{}"
open(r"E:/AI-Station/逆向工程/djyanbao-reverse/captures/profile_localstorage.json", "w", encoding="utf-8").write(ls_val)
json.dump(out, open(OUT, "w", encoding="utf-8"), ensure_ascii=False, indent=1)
print("events:", len(events), "bodies:", len(bodies))
ws.close()
