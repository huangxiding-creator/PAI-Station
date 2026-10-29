# -*- coding: utf-8 -*-
"""video_state_export_9222 — 从 WeAIPO 9222 live channels 浏览器只读导出视频号登录态 (1025).
CDP Network.getAllCookies 只读拉取 → 过滤 channels.weixin.qq.com → storage_state 格式。
不导航不开新页不碰任何 tab (免打扰红线)。旧态先备份只增, 再写 STATE。
"""
import json, shutil, sys, urllib.request
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
STATE = Path(r"E:\AI-Station\report_platform\promo\video_account_state.json")
BAK = STATE.with_name("video_account_state.bak-1022.json")

def http_json(url):
    with urllib.request.urlopen(url, timeout=10) as r:
        return json.loads(r.read().decode("utf-8"))

def main():
    ver = http_json("http://127.0.0.1:9222/json/version")
    ws = ver.get("webSocketDebuggerUrl", "")
    print("[exp] browser:", ver.get("Browser", "?")[:40])
    from websocket import create_connection  # pip websocket-client (WeAIPO venv 有)
    wsoc = create_connection(ws, timeout=15, suppress_origin=True)
    wsoc.send(json.dumps({"id": 1, "method": "Storage.getCookies"}))
    resp = json.loads(wsoc.recv())
    wsoc.close()
    cookies = resp.get("result", {}).get("cookies", [])
    keep = [c for c in cookies if "channels.weixin.qq.com" in (c.get("domain") or "")]
    print(f"[exp] cookies total={len(cookies)} channels={len(keep)}")
    if not keep or not any(c["name"] in ("sessionid", "wxuin") for c in keep):
        print("[exp] FAIL: live 浏览器无 channels 会话 cookie")
        return 1
    # storage_state 兼容格式: cookies 仅保留 playwright 认的字段
    def slim(c):
        out = {"name": c["name"], "value": c["value"], "domain": c["domain"],
               "path": c.get("path", "/")}
        if c.get("expires", -1) > 0:
            out["expires"] = c["expires"]
        if c.get("httpOnly") is not None:
            out["httpOnly"] = c["httpOnly"]
        if c.get("secure") is not None:
            out["secure"] = c["secure"]
        return out
    state = {"cookies": [slim(c) for c in keep], "origins": []}
    if not BAK.exists():
        shutil.copy2(STATE, BAK)
        print(f"[exp] 旧态备份 → {BAK.name}")
    STATE.write_text(json.dumps(state, ensure_ascii=False, indent=1), encoding="utf-8")
    print(f"[exp] 新态写入 → {STATE} ({len(keep)} cookies)")
    return 0

if __name__ == "__main__":
    sys.exit(main())
