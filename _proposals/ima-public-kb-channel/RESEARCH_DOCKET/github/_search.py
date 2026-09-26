# -*- coding: utf-8 -*-
"""Read-only GitHub repo search sweep for Tencent ima KB export/backup tooling.
Output: _search_results.json (all hits, deduped) + console log."""
import sys, json, time, urllib.request, urllib.parse

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

OUT = r"E:\AI-Station\_proposals\ima-public-kb-channel\RESEARCH_DOCKET\github\_search_results.json"
PROXY = "http://127.0.0.1:7890"

QUERIES = [
    "ima 知识库",
    "ima.copilot",
    "ima.qq.com",
    "ima export",
    "ima backup",
    "ima 笔记",
    "ima knowledge base",
    "知识库导出",
    "tencent ima",
    "ima 知识库 导出",
    "ima downloader",
    "ima mcp",
    "腾讯 ima",
    "ima api tencent",
]

def fetch(url, use_proxy=False, timeout=25):
    req = urllib.request.Request(url, headers={
        "User-Agent": "research-recon/1.0",
        "Accept": "application/vnd.github+json",
    })
    handlers = [urllib.request.ProxyHandler({"http": PROXY, "https": PROXY})] if use_proxy else []
    opener = urllib.request.build_opener(*handlers)
    with opener.open(req, timeout=timeout) as r:
        return json.loads(r.read().decode("utf-8", errors="replace"))

results = {}   # full_name -> item
log = []
for q in QUERIES:
    url = "https://api.github.com/search/repositories?q=%s&sort=stars&order=desc&per_page=20" % urllib.parse.quote(q)
    data = None
    for attempt, use_proxy in ((0, False), (1, True)):
        try:
            data = fetch(url, use_proxy=use_proxy)
            break
        except Exception as e:
            log.append("[warn] q=%r attempt=%d proxy=%s err=%s" % (q, attempt, use_proxy, e))
            time.sleep(2)
    if data is None:
        log.append("[FAIL] q=%r" % q)
        time.sleep(7)
        continue
    total = data.get("total_count", 0)
    items = data.get("items", [])
    log.append("[ok] q=%r total=%d got=%d" % (q, total, len(items)))
    for it in items:
        fn = it["full_name"]
        if fn not in results:
            results[fn] = {
                "full_name": fn,
                "html_url": it.get("html_url"),
                "stars": it.get("stargazers_count"),
                "language": it.get("language"),
                "pushed_at": it.get("pushed_at"),
                "created_at": it.get("created_at"),
                "default_branch": it.get("default_branch", "main"),
                "description": it.get("description"),
                "topics": it.get("topics", []),
                "fork": it.get("fork"),
                "archived": it.get("archived"),
                "matched_queries": [q],
            }
        else:
            results[fn]["matched_queries"].append(q)
    time.sleep(7)  # respect 10 req/min unauthenticated search limit

with open(OUT, "w", encoding="utf-8") as f:
    json.dump({"log": log, "repos": sorted(results.values(), key=lambda x: -(x["stars"] or 0))}, f, ensure_ascii=False, indent=1)

print("\n".join(log))
print("TOTAL UNIQUE REPOS:", len(results))
