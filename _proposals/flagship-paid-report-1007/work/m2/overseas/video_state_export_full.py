# -*- coding: utf-8 -*-
"""video_state_export_full — live 9222 channels tab 全量只读导出 (cookies+localStorage) 1025."""
import json, sys, urllib.request
from pathlib import Path
from websocket import create_connection

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
STATE = Path(r"E:\AI-Station\report_platform\promo\video_account_state.json")

def http_json(url):
    with urllib.request.urlopen(url, timeout=10) as r:
        return json.loads(r.read().decode("utf-8"))

def main():
    tabs = http_json("http://127.0.0.1:9222/json")
    tab = next((t for t in tabs if "channels.weixin.qq.com" in (t.get("url") or "")), None)
    if not tab:
        print("[exp] 无 channels tab"); return 1
    print("[exp] tab:", tab["url"][:70])
    wsoc = create_connection(tab["webSocketDebuggerUrl"], timeout=15, suppress_origin=True)
    # localStorage 只读快照
    wsoc.send(json.dumps({"id": 1, "method": "Runtime.evaluate", "params": {
        "expression": "JSON.stringify(Object.fromEntries(Object.entries(localStorage)))",
        "returnByValue": True}}))
    r1 = json.loads(wsoc.recv())
    ls_raw = (r1.get("result", {}).get("result", {}) or {}).get("value", "{}")
    wsoc.close()
    ls = json.loads(ls_raw)
    print(f"[exp] localStorage entries: {len(ls)} -> {sorted(ls.keys())[:8]}")
    # cookies (browser 级 ws)
    ver = http_json("http://127.0.0.1:9222/json/version")
    wsoc2 = create_connection(ver["webSocketDebuggerUrl"], timeout=15, suppress_origin=True)
    wsoc2.send(json.dumps({"id": 1, "method": "Storage.getCookies"}))
    r2 = json.loads(wsoc2.recv())
    wsoc2.close()
    cookies = [c for c in r2.get("result", {}).get("cookies", [])
               if "channels.weixin.qq.com" in (c.get("domain") or "")]
    def slim(c):
        out = {"name": c["name"], "value": c["value"], "domain": c["domain"], "path": c.get("path", "/")}
        if c.get("expires", -1) > 0: out["expires"] = c["expires"]
        if c.get("httpOnly") is not None: out["httpOnly"] = c["httpOnly"]
        if c.get("secure") is not None: out["secure"] = c["secure"]
        return out
    state = {
        "cookies": [slim(c) for c in cookies],
        "origins": [{"origin": "https://channels.weixin.qq.com",
                     "localStorage": [{"name": k, "value": v} for k, v in ls.items()]}],
    }
    STATE.write_text(json.dumps(state, ensure_ascii=False, indent=1), encoding="utf-8")
    print(f"[exp] 写入 {STATE.name}: {len(cookies)} cookies + {len(ls)} localStorage")
    return 0

if __name__ == "__main__":
    sys.exit(main())
