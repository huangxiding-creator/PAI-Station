# -*- coding: utf-8 -*-
"""GitHub 全网调研：搜索微信/AI/群运营/商机挖掘相关项目。"""
import json, sys, time
import urllib.request

sys.stdout = open(sys.stdout.fileno(), mode='w', encoding='utf-8', errors='replace')

QUERIES = [
    ("wechat bot", "wechat+bot"),
    ("wechat automation", "wechat+automation"),
    ("wechat ai assistant", "wechat+ai+assistant"),
    ("wechat rpa", "wechat+rpa"),
    ("wechat enterprise api", "wechat+work+api+wecom"),
    ("community management ai", "community+management+ai+chat"),
    ("group chat intelligence", "group+chat+intelligence+mining"),
    ("sales intelligence chat", "sales+intelligence+chat+monitoring"),
    ("lead mining chat", "lead+mining+chat+bot"),
    ("conversational ai b2b", "conversational+ai+b2b"),
    ("content recommendation engine", "content+recommendation+engine+wechat"),
    ("engineering industry ai", "engineering+industry+ai+assistant"),
    ("construction tech ai", "construction+technology+ai"),
    ("private domain traffic", "private+domain+traffic+wechat"),
    ("social selling automation", "social+selling+automation"),
    ("chatbot customer service", "chatbot+customer+service+enterprise"),
    ("knowledge base chatbot", "knowledge+base+chatbot+rag"),
    ("article summarization ai", "article+summarization+ai"),
    ("market intelligence monitor", "market+intelligence+monitoring"),
    ("revenue attribution ai", "revenue+attribution+marketing"),
]

all_projects = []
seen = set()

for label, q in QUERIES:
    url = f"https://api.github.com/search/repositories?q={q}&sort=stars&per_page=8"
    try:
        req = urllib.request.Request(url, headers={"User-Agent": "zbops-research"})
        resp = urllib.request.urlopen(req, timeout=15)
        d = json.loads(resp.read().decode("utf-8"))
        items = d.get("items", [])
        print(f"\n### {label} (total={d.get('total_count', 0)})")
        for r in items:
            name = r["full_name"]
            if name in seen:
                continue
            seen.add(name)
            desc = (r.get("description") or "")[:100]
            stars = r["stargazers_count"]
            lang = r.get("language") or "?"
            print(f"  {name} | ⭐{stars} | {lang} | {desc}")
            all_projects.append({"name": name, "stars": stars, "lang": lang,
                                "desc": desc, "category": label})
    except Exception as e:
        print(f"  ERROR: {e}")
    time.sleep(1)  # rate limit

print(f"\n\n=== TOTAL UNIQUE PROJECTS: {len(all_projects)} ===")

# Save to JSON for later use
with open(r"e:\AI-Station\RESEARCH_PROJECTS.json", "w", encoding="utf-8") as f:
    json.dump(all_projects, f, ensure_ascii=False, indent=2)
print("Saved to RESEARCH_PROJECTS.json")
