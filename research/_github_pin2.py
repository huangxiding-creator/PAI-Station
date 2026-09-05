# -*- coding: utf-8 -*-
"""Round-2 pins via search API (separate rate pool)."""
import json, os, time, urllib.parse, urllib.request
OUT = r"e:\AI-Station\RESEARCH_DOCKET\github"
UA = {"User-Agent": "PAI-Station-research", "Accept": "application/vnd.github+json"}
WANT = {
 "dify":"rag-kb","FastGPT":"rag-kb","MaxKB":"rag-kb","ragflow":"rag-kb",
 "khoj":"rag-local","anything-llm":"rag-local","open-webui":"rag-local",
 "PaddleOCR":"ocr","RapidOCR":"ocr","Umi-OCR":"ocr","OmniParser":"ocr",
 "voidtools Everything":"ops","pywebview":"gui","WinSW":"ops",
}
rows = json.load(open(os.path.join(OUT, "_all.json"), encoding="utf-8"))
seen = {r["repo"].lower() for r in rows}
added = 0
for q, tag in WANT.items():
    url = "https://api.github.com/search/repositories?q=" + urllib.parse.quote(q) + "&sort=stars&per_page=3"
    try:
        with urllib.request.urlopen(urllib.request.Request(url, headers=UA), timeout=25) as r:
            data = json.loads(r.read().decode("utf-8"))
    except Exception as e:
        print(f"[WARN] {q}: {e}", flush=True); time.sleep(12); continue
    for it in data.get("items", [])[:1]:
        if it["full_name"].lower() in seen: break
        rec = {"repo": it["full_name"], "stars": it.get("stargazers_count"), "lang": it.get("language"),
               "desc": (it.get("description") or "")[:180], "pushed": (it.get("pushed_at") or "")[:10],
               "license": (it.get("license") or {}).get("spdx_id"), "url": it.get("html_url"), "tags": [tag, "pinned"]}
        rows.append(rec); seen.add(rec["repo"].lower()); added += 1
        print(f"[PIN] {rec['repo']} ★{rec['stars']} {rec['pushed']}", flush=True); break
    time.sleep(7)
json.dump(rows, open(os.path.join(OUT, "_all.json"), "w", encoding="utf-8"), ensure_ascii=False, indent=1)
rows.sort(key=lambda x: -x["stars"])
with open(os.path.join(OUT, "_digest.md"), "w", encoding="utf-8") as f:
    f.write(f"# GitHub harvest: {len(rows)} unique repos\n\n| # | Repo | Stars | Lang | Pushed | Tags |\n|--:|---|--:|---|---|---|\n")
    for i, r in enumerate(rows, 1):
        f.write(f"| {i} | [{r['repo']}]({r['url']}) | {r['stars']} | {r['lang']} | {r['pushed']} | {','.join(r['tags'])} |\n")
print(f"[DONE] added={added} total={len(rows)}", flush=True)
