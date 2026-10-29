# -*- coding: utf-8 -*-
"""metaso pure-HTTP probe round1: is /api/search/chat replayable without token?
Polite: <=4 requests, >=4s gaps. Anonymous face only (scope.md)."""
import json, sys, time, uuid
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from curl_cffi import requests as cr

S = cr.Session(impersonate="chrome")

def body(q, token):
    mid = f"temp-{uuid.uuid4()}"
    m = {
        "id": mid, "key": f"temp-{uuid.uuid4()}",
        "conversationId": f"temp-{uuid.uuid4()}",
        "role": "user", "content": q, "markdownContent": q,
        "engineType": "", "filter": "all", "contentType": 0,
        "outputHtml": False, "mode": "detail", "model": "fast_thinking",
        "outputStyle": "正常",
    }
    b = {"model": "fast_thinking", "stream": True, "messages": [m],
         "engineType": "", "mode": "detail", "filter": "all", "outputHtml": False,
         "outputStyle": "正常", "darkMode": False, "outputLanguage": "中文",
         "htmlNoDisplayEnable": True, "metaso-pc": "pc"}
    if token is not None:
        b["token"] = token
    return b

H = {"accept": "text/event-stream", "content-type": "application/json",
     "metaso-pc": "pc", "origin": "https://metaso.cn", "referer": "https://metaso.cn/",
     "accept-language": "zh-CN,zh;q=0.9"}

def show(tag, r):
    ct = r.headers.get("content-type", "")
    t = r.text or ""
    print(f"--- {tag}: HTTP {r.status_code} ct={ct[:50]} len={len(t)}")
    print("   ", t[:600].replace("\n", "\\\\n")[:700])

# 1) warmup: home page -> cookies
r = S.get("https://metaso.cn/", timeout=25)
print(f"[1] home HTTP {r.status_code} len={len(r.text)} cookies={list(S.cookies.keys())}")
time.sleep(4)

# 2) POST chat without token field at all
r = S.post("https://metaso.cn/api/search/chat", json=body("中资EPC出海", None),
           headers=H, timeout=60, stream=True)
chunks = []
try:
    for line in r.iter_lines():
        chunks.append(line)
        if sum(len(c) for c in chunks) > 200000:
            break
except Exception as e:
    print("stream exc:", type(e).__name__)
t = "\n".join(c.decode("utf-8", "replace") if isinstance(c, bytes) else str(c) for c in chunks)
print(f"[2] no-token: HTTP {r.status_code} ct={r.headers.get('content-type','')[:50]} stream_len={len(t)}")
print("    head:", t[:800].replace("\n", "\\\\n"))
time.sleep(5)

# 3) POST chat with empty token
r = S.post("https://metaso.cn/api/search/chat", json=body("海外电力投资", ""),
           headers=H, timeout=60, stream=True)
chunks = []
try:
    for line in r.iter_lines():
        chunks.append(line)
        if sum(len(c) for c in chunks) > 200000:
            break
except Exception as e:
    print("stream exc:", type(e).__name__)
t = "\n".join(c.decode("utf-8", "replace") if isinstance(c, bytes) else str(c) for c in chunks)
print(f"[3] empty-token: HTTP {r.status_code} ct={r.headers.get('content-type','')[:50]} stream_len={len(t)}")
print("    head:", t[:800].replace("\n", "\\\\n"))
