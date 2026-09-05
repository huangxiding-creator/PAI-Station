# -*- coding: utf-8 -*-
"""GitHub Search API harvester: build the PAI-Station candidate pool (>=100 repos)."""
import json, time, urllib.parse, urllib.request, sys, os

OUT_DIR = r"e:\AI-Station\RESEARCH_DOCKET\github"
os.makedirs(OUT_DIR, exist_ok=True)

# (query, min_stars, note-tag)
QUERIES = [
    ("topic:personal-ai-assistant", 50, "personal-assistant"),
    ("personal AI workstation", 20, "workstation"),
    ("AI workstation laptop assistant", 10, "workstation"),
    ("personal AI agent desktop windows", 30, "desktop-agent"),
    ("topic:gui-agent", 100, "gui-agent"),
    ("computer use agent", 200, "computer-use"),
    ("topic:agent-memory", 100, "memory"),
    ("LLM agent long-term memory", 100, "memory"),
    ("rewind screen recording memory AI", 100, "screen-context"),
    ("topic:screen-capture ocr ai", 100, "screen-context"),
    ("meeting transcription whisper local", 100, "meeting"),
    ("topic:meeting-minutes", 50, "meeting"),
    ("chinese speech recognition funasr", 200, "stt-cn"),
    ("realtime speech to text local", 100, "stt-rt"),
    ("pdf to markdown", 300, "doc2md"),
    ("convert files to markdown LLM", 100, "doc2md"),
    ("wechat chat history export", 30, "wechat"),
    ("微信 聊天记录 导出", 30, "wechat"),
    ("topic:knowledge-base rag", 500, "rag-kb"),
    ("local knowledge base LLM private", 200, "rag-local"),
    ("topic:browser-automation agent", 200, "browser"),
    ("topic:personal-knowledge-management ai", 50, "pkm"),
    ("claude agent skills marketplace", 30, "skills"),
    ("self improving LLM agent reflexion", 50, "self-improve"),
    ("proactive assistant notification scheduling", 50, "proactive"),
    ("topic:assistant desktop windows python", 50, "desktop-app"),
]

UA = {"User-Agent": "PAI-Station-research", "Accept": "application/vnd.github+json"}
seen, rows = {}, []

for q, min_stars, tag in QUERIES:
    url = "https://api.github.com/search/repositories?q=" + urllib.parse.quote(q) + "&sort=stars&order=desc&per_page=30"
    try:
        req = urllib.request.Request(url, headers=UA)
        with urllib.request.urlopen(req, timeout=25) as r:
            data = json.loads(r.read().decode("utf-8"))
    except Exception as e:
        print(f"[WARN] query failed: {q} -> {e}", flush=True)
        time.sleep(10); continue
    added = 0
    for it in data.get("items", []):
        full = it["full_name"]
        if full in seen:
            seen[full]["tags"].append(tag); continue
        if (it.get("stargazers_count") or 0) < min_stars:
            continue
        rec = {
            "repo": full, "stars": it.get("stargazers_count"),
            "lang": it.get("language"), "desc": (it.get("description") or "")[:180],
            "pushed": (it.get("pushed_at") or "")[:10], "license": (it.get("license") or {}).get("spdx_id"),
            "url": it.get("html_url"), "tags": [tag],
        }
        seen[full] = rec; rows.append(rec); added += 1
    print(f"[OK] {q!r} tag={tag} kept={added} total={len(rows)}", flush=True)
    time.sleep(7)

with open(os.path.join(OUT_DIR, "_all.json"), "w", encoding="utf-8") as f:
    json.dump(rows, f, ensure_ascii=False, indent=1)

rows.sort(key=lambda x: -x["stars"])
with open(os.path.join(OUT_DIR, "_digest.md"), "w", encoding="utf-8") as f:
    f.write(f"# GitHub harvest: {len(rows)} unique repos\n\n| # | Repo | Stars | Lang | Pushed | Tags |\n|--:|---|--:|---|---|---|\n")
    for i, r in enumerate(rows, 1):
        f.write(f"| {i} | [{r['repo']}]({r['url']}) | {r['stars']} | {r['lang']} | {r['pushed']} | {','.join(r['tags'])} |\n")
print(f"[DONE] {len(rows)} unique repos -> _all.json / _digest.md", flush=True)
