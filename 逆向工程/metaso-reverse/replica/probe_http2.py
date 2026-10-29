# -*- coding: utf-8 -*-
"""metaso pure-HTTP probe round2: full browser-identical face.
tid=uuid4 (verified), _nb_* empty, meta-token from SSR home, warmup chain, then chat POST."""
import json, re, sys, time, uuid
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from curl_cffi import requests as cr

TID = str(uuid.uuid4())
S = cr.Session(impersonate="chrome")
# browser cookie face (tid verified == telemetry uuid; _nb empty verified via sha256)
S.cookies.set("tid", TID, domain=".metaso.cn", path="/")
S.cookies.set("_nb_ioWEgULi", "", domain=".metaso.cn", path="/")

UA = None
BASE_H = {"accept-language": "zh-CN,zh;q=0.9", "metaso-pc": "pc"}

def note_cookies(tag):
    print(f"  [{tag}] cookies now: {sorted(S.cookies.keys())}")

# 1) home -> meta-token + aliyungf_tc
r = S.get("https://metaso.cn/", timeout=25, headers={**BASE_H})
print(f"[1] home HTTP {r.status_code} len={len(r.text)}")
m = re.search(r'<meta id="meta-token" content="([^"]+)"', r.text)
TOKEN = m.group(1) if m else ""
print(f"  meta-token: {TOKEN[:40]}... len={len(TOKEN)}")
print("  set-cookie on home:", r.headers.get("set-cookie", "")[:200])
note_cookies("home")

# 2) warmup chain (order from REA capture)
time.sleep(2)
for u in ("https://metaso.cn/api/search-template",
          "https://metaso.cn/api/my-info",
          "https://metaso.cn/api/metaso-ai-config",
          "https://metaso.cn/api/meta-config/by-key?configKey=scholarScope"):
    try:
        r = S.get(u, timeout=20, headers={**BASE_H, "referer": "https://metaso.cn/",
                                          "accept": "application/json"})
        sc = r.headers.get("set-cookie", "")
        print(f"[2] {u.split('metaso.cn')[1][:50]} -> {r.status_code} len={len(r.text)} sc={sc[:120]}")
    except Exception as e:
        print(f"[2] {u} EXC {type(e).__name__}")
    time.sleep(1.5)
note_cookies("warmup")
if TOKEN:
    open("meta_token_last.txt", "w").write(TOKEN)

# 3) chat POST with token + full cookie face
def body(q, engine=""):
    mid = f"temp-{uuid.uuid4()}"
    msg = {"id": mid, "key": f"temp-{uuid.uuid4()}",
           "conversationId": f"temp-{uuid.uuid4()}",
           "role": "user", "content": q, "markdownContent": q,
           "engineType": engine, "filter": "all", "contentType": 0,
           "outputHtml": False, "mode": "detail", "model": "fast_thinking",
           "outputStyle": "正常"}
    return {"model": "fast_thinking", "stream": True, "messages": [msg],
            "engineType": engine, "mode": "detail", "filter": "all",
            "outputHtml": False, "outputStyle": "正常", "darkMode": False,
            "outputLanguage": "中文", "htmlNoDisplayEnable": True,
            "metaso-pc": "pc", "token": TOKEN}

H = {"accept": "text/event-stream", "content-type": "application/json",
     "metaso-pc": "pc", "origin": "https://metaso.cn", "referer": "https://metaso.cn/",
     "accept-language": "zh-CN,zh;q=0.9"}

time.sleep(3)
r = S.post("https://metaso.cn/api/search/chat", json=body("中资EPC出海"), headers=H, timeout=90, stream=True)
print(f"[3] chat POST HTTP {r.status_code} ct={r.headers.get('content-type','')[:40]}")
buf = []
t0 = time.time()
try:
    for line in r.iter_lines():
        buf.append(line if isinstance(line, str) else line.decode("utf-8", "replace"))
        if time.time() - t0 > 75:
            print("  (75s cutoff)"); break
        if sum(len(x) for x in buf) > 400000: break
except Exception as e:
    print("  stream exc:", type(e).__name__, str(e)[:100])
t = "\n".join(buf)
print(f"  stream_len={len(t)} events={t.count(chr(10)+'data:')+ (1 if t.startswith('data:') else 0)}")
open("chat_stream_round2.txt", "w", encoding="utf-8").write(t)
print("  head:", t[:500].replace("\n", "\\\\n"))
print("  tail:", t[-400:].replace("\n", "\\\\n"))
