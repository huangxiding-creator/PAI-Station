# -*- coding: utf-8 -*-
"""fw-ui round3: final precise fetches + util search."""
import subprocess, json, time, os

OUT_DIR = r"E:\AI-Station\_proposals\weapp-forge\RESEARCH_DOCKET\frameworks_ui"
JQ = '{full_name,html_url,description,stargazers_count,forks_count,language,license:.license.spdx_id,updated_at,pushed_at,archived}'

PRECISE = [
    "eleme/morjs", "uviewui/uview-ui", "junbin-yang/uCharts-v3",
    "Tencent/tdesign-miniprogram-starter-retail", "finalvip/weapp_template",
    "lexmin0412/taro3-react-template", "lencx/create-mpl",
    "NewFuture/miniprogram-template",
    "icebreaker-template/native-weapp-tailwindcss-template",
    "weapp-cookie/weapp-cookie", "charliegao/weapp-cookie",
    "hocgin/action-wechat-miniprogram-upload",
]

SEARCHES = {
    "util": "search/repositories?q=miniprogram+utils&sort=stars&per_page=15",
    "cookie": "search/repositories?q=weapp-cookie&sort=stars&per_page=8",
}

def run(args):
    return subprocess.run(args, capture_output=True, text=True, encoding="utf-8", errors="replace")

def main():
    out = []
    for r in PRECISE:
        q = run(["gh", "api", f"repos/{r}", "--jq", JQ])
        if q.returncode == 0 and q.stdout.strip():
            out.append(json.loads(q.stdout))
        else:
            out.append({"full_name": r, "_error": (q.stderr or "").strip()[:100]})
        time.sleep(0.05)
    ok = [d for d in out if "_error" not in d]
    print(f"precise OK {len(ok)} / {len(PRECISE)}")
    for d in out:
        if "_error" in d:
            print("  ERR:", d["full_name"])
        else:
            print(f"  {d['full_name']:52s} {d['stargazers_count']:>6} {str(d.get('pushed_at',''))[:10]} {'ARCH' if d.get('archived') else ''}")

    search_out = {}
    for key, path in SEARCHES.items():
        s = run(["gh", "api", path, "--jq", ".items[] | {full_name,html_url,description,stargazers_count,forks_count,language,pushed_at,archived}"])
        items = []
        if s.returncode == 0:
            for line in s.stdout.splitlines():
                line = line.strip()
                if line:
                    try:
                        items.append(json.loads(line))
                    except Exception:
                        pass
        else:
            search_out[key] = {"_error": s.stderr[:120], "items": []}
            continue
        search_out[key] = {"items": items}
        print(key, "->", len(items))
        for it in items[:10]:
            print(f"  {it['full_name']:48s} {it['stargazers_count']:>6} {str(it.get('pushed_at',''))[:10]}")
        time.sleep(2.5)

    json.dump({"precise": out, "search": search_out},
              open(os.path.join(OUT_DIR, "_raw_round3.json"), "w", encoding="utf-8"),
              ensure_ascii=False, indent=1)
    print("saved round3")

if __name__ == "__main__":
    main()
