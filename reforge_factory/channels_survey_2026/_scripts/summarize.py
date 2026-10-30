import json, glob, sys, os
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
base = sys.argv[1]
for f in sorted(glob.glob(os.path.join(base, "gh_*.json"))):
    print("###", os.path.basename(f))
    try:
        d = json.load(open(f, encoding="utf-8"))
    except Exception as e:
        print("  PARSE-ERR", e); continue
    print("  total_count:", d.get("total_count"))
    for it in d.get("items", []):
        desc = (it.get("description") or "").replace("\t", " ").replace("\n", " ")
        home = (it.get("homepage") or "").strip()
        lang = it.get("language") or ""
        print("\t".join([it["full_name"], str(it["stargazers_count"]), desc[:130], home, lang, it["pushed_at"][:10]]))
for f in sorted(glob.glob(os.path.join(base, "hn_*.json"))):
    print("###", os.path.basename(f))
    try:
        d = json.load(open(f, encoding="utf-8"))
    except Exception as e:
        print("  PARSE-ERR", e); continue
    print("  nbHits:", d.get("nbHits"), "hits:", len(d.get("hits", [])))
    for h in d.get("hits", []):
        title = (h.get("title") or "").replace("\t", " ").replace("\n", " ")
        print("\t".join([str(h.get("objectID")), str(h.get("points")), str(h.get("num_comments")), (h.get("created_at") or "")[:10], title[:110], h.get("url") or "(self)"]))
