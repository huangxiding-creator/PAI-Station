# -*- coding: utf-8 -*-
"""probe3: does engineType=scholar switch to academic sources? (1 POST, polite)"""
import json, re, sys, time, uuid
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from curl_cffi import requests as cr

S = cr.Session(impersonate="chrome")
S.cookies.set("tid", str(uuid.uuid4()), domain=".metaso.cn", path="/")
S.cookies.set("_nb_ioWEgULi", "", domain=".metaso.cn", path="/")
r = S.get("https://metaso.cn/", timeout=25)
TOKEN = re.search(r'<meta id="meta-token" content="([^"]+)"', r.text).group(1)
time.sleep(2)
S.get("https://metaso.cn/api/search-template", timeout=20, headers={"referer": "https://metaso.cn/"})
time.sleep(2)

def body(q, engine):
    msg = {"id": f"temp-{uuid.uuid4()}", "key": f"temp-{uuid.uuid4()}",
           "conversationId": f"temp-{uuid.uuid4()}", "role": "user",
           "content": q, "markdownContent": q, "engineType": engine,
           "filter": "all", "contentType": 0, "outputHtml": False,
           "mode": "detail", "model": "fast_thinking", "outputStyle": "正常"}
    return {"model": "fast_thinking", "stream": True, "messages": [msg],
            "engineType": engine, "mode": "detail", "filter": "all", "outputHtml": False,
            "outputStyle": "正常", "darkMode": False, "outputLanguage": "中文",
            "htmlNoDisplayEnable": True, "metaso-pc": "pc", "token": TOKEN}

H = {"accept": "text/event-stream", "content-type": "application/json",
     "metaso-pc": "pc", "origin": "https://metaso.cn", "referer": "https://metaso.cn/"}

r = S.post("https://metaso.cn/api/search/chat", json=body("国际工程EPC风险管控", "scholar"),
           headers=H, timeout=120, stream=True)
buf, t0 = [], time.time()
for line in r.iter_lines():
    buf.append(line if isinstance(line, str) else line.decode("utf-8", "replace"))
    if time.time() - t0 > 110 or sum(map(len, buf)) > 500000: break
t = "\n".join(buf)
open("chat_stream_scholar.txt", "w", encoding="utf-8").write(t)
print(f"HTTP {r.status_code} stream_len={len(t)}")
content, cites, actions = "", [], []
for p in [e[5:] for e in t.split("\n") if e.startswith("data:")]:
    if p == "[DONE]": continue
    try: j = json.loads(p)
    except Exception: continue
    d = j.get("choices", [{}])[0].get("delta", {})
    content += d.get("content") or ""
    if d.get("action"): actions.append(d["action"])
    cites += d.get("citations", [])
print("actions:", actions[:12])
print("answer len:", len(content))
print("citations:", len(cites))
seen = set()
for c in cites:
    if c.get("link") in seen: continue
    seen.add(c.get("link"))
    print("-", (c.get("orig_title") or c.get("title") or "")[:55], "|",
          (c.get("link") or "")[:70], "|", (c.get("authors") or [""])[0] if isinstance(c.get("authors"), list) else c.get("authors"),
          "|", c.get("institution"), "|", c.get("article_type"))
print("answer head:", content[:200])
