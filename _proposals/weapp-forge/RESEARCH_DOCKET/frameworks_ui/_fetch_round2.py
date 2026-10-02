# -*- coding: utf-8 -*-
"""fw-ui round2: official org sweep + precise refetch + remaining searches (no paginate)."""
import subprocess, json, time, os, sys

OUT_DIR = r"E:\AI-Station\_proposals\weapp-forge\RESEARCH_DOCKET\frameworks_ui"
JQ = '{full_name,html_url,description,stargazers_count,forks_count,language,license:.license.spdx_id,updated_at,pushed_at,archived}'

PRECISE = [
    # discovered via search, need full metadata
    "ecomfe/okam", "dingyong0214/ThorUI", "dingyong0214/ThorUI-uniapp",
    "ant-design/ant-design-mini", "tinajs/tina", "ant-move/Antmove",
    "weidian-inc/hera", "MellowCo/unocss-preset-weapp", "ruochuan12/mini-ci",
    "echoings/actions.mini-program", "antvis/wx-f2", "ant-design/x-markdown-mini",
    "viarotel-org/vite-uniapp-template", "xlzy520/uniapp-tailwind-uview-starter",
    # guesses for 404s and remaining categories
    "yingye/weapp-qrcode", "charliegao/weapp-cookie", "wendao/flyio",
    "umicro/uview-ui", "vkun/uview-ui", "Tencent/weui", "Tencent/kbone-ui",
    "wechat-miniprogram/weui-wxss", "wechat-miniprogram/miniprogram-demo",
    "wechat-miniprogram/weapp-cli", "wechat-miniprogram/miniprogram-automator-sdk",
    "morjs/morjs", "element-morjs/morjs", "antfin/morjs",
    "qiun/wx-ucharts", "attemptw/ucharts", "karstank/wx-dva-mp",
]

SEARCHES = {
    "morjs": "search/repositories?q=morjs&per_page=10",
    "ucharts": "search/repositories?q=ucharts&sort=stars&per_page=10",
    "template": "search/repositories?q=miniprogram+template&sort=stars&per_page=20",
    "weapp_template": "search/repositories?q=weapp+template&sort=stars&per_page=15",
    "dva": "search/repositories?q=miniprogram+dva&sort=stars&per_page=10",
}

def run(args):
    return subprocess.run(args, capture_output=True, text=True, encoding="utf-8", errors="replace")

def main():
    # A. official org sweep
    p = run(["gh", "api", "orgs/wechat-miniprogram/repos?sort=pushed&per_page=100",
             "--jq", ".[] | select(.stargazers_count >= 50) | {full_name,html_url,description,stargazers_count,forks_count,language,pushed_at,archived}"])
    org_items = []
    if p.returncode == 0:
        for line in p.stdout.splitlines():
            line = line.strip()
            if line:
                try:
                    org_items.append(json.loads(line))
                except Exception:
                    pass
    else:
        print("ORG ERR:", p.stderr[:150])
    print("org items:", len(org_items))
    for it in org_items:
        print(f"  {it['full_name']:60s} {it['stargazers_count']:>6} {str(it.get('pushed_at',''))[:10]}")

    # B. precise
    precise_out = []
    for r in PRECISE:
        q = run(["gh", "api", f"repos/{r}", "--jq", JQ])
        if q.returncode == 0 and q.stdout.strip():
            precise_out.append(json.loads(q.stdout))
        else:
            precise_out.append({"full_name": r, "_error": (q.stderr or "").strip()[:100]})
        time.sleep(0.05)
    ok = [d for d in precise_out if "_error" not in d]
    print(f"precise OK {len(ok)} / {len(PRECISE)}")
    for d in precise_out:
        if "_error" in d:
            print("  ERR:", d["full_name"])

    # C. searches (spaced)
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
        time.sleep(2.5)

    json.dump({"org": org_items, "precise": precise_out, "search": search_out},
              open(os.path.join(OUT_DIR, "_raw_round2.json"), "w", encoding="utf-8"),
              ensure_ascii=False, indent=1)
    print("saved round2")

if __name__ == "__main__":
    main()
