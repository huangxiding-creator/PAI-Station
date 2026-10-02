# -*- coding: utf-8 -*-
"""fw-ui channel: gh search API sweeps to discover additional repos per category."""
import subprocess, json, time, os

OUT_DIR = r"E:\AI-Station\_proposals\weapp-forge\RESEARCH_DOCKET\frameworks_ui"

SEARCHES = {
    "framework": "search/repositories?q=miniprogram+framework&sort=stars&per_page=20",
    "framework_weapp": "search/repositories?q=weapp+framework&sort=stars&per_page=15",
    "okam": "search/repositories?q=okam+miniprogram&per_page=10",
    "ui_wechat": "search/repositories?q=wechat+ui+miniprogram&sort=stars&per_page=20",
    "thorui": "search/repositories?q=thorui&sort=stars&per_page=10",
    "wux": "search/repositories?q=wux-weapp&sort=stars&per_page=10",
    "tailwind": "search/repositories?q=weapp-tailwindcss&sort=stars&per_page=10",
    "vite": "search/repositories?q=weapp+vite&sort=stars&per_page=15",
    "unocss": "search/repositories?q=unocss+applet&sort=stars&per_page=10",
    "mp_ci": "search/repositories?q=miniprogram-ci&sort=stars&per_page=15",
    "action": "search/repositories?q=miniprogram+upload+action&sort=stars&per_page=10",
    "charts": "search/repositories?q=miniprogram+charts&sort=stars&per_page=15",
    "markdown": "search/repositories?q=miniprogram+markdown&sort=stars&per_page=15",
    "state": "search/repositories?q=miniprogram+state&sort=stars&per_page=15",
    "util": "search/repositories?q=miniprogram+util&sort=stars&per_page=15",
    "template": "search/repositories?q=miniprogram+template&sort=stars&per_page=30",
    "weapp_template": "search/repositories?q=weapp+template&sort=stars&per_page=20",
    "network": "search/repositories?q=miniprogram+network&sort=stars&per_page=10",
    "qrcode": "search/repositories?q=weapp-qrcode&sort=stars&per_page=10",
    "cookie": "search/repositories?q=weapp+cookie&sort=stars&per_page=10",
}

def gh_search(path):
    p = subprocess.run(["gh", "api", path, "--paginate",
                        "--jq", '.items[] | {full_name,html_url,description,stargazers_count,forks_count,language,pushed_at,archived}'],
                       capture_output=True, text=True, encoding="utf-8", errors="replace")
    items = []
    if p.returncode == 0:
        for line in p.stdout.splitlines():
            line = line.strip()
            if not line:
                continue
            try:
                items.append(json.loads(line))
            except Exception:
                pass
    else:
        return {"_error": (p.stderr or "").strip()[:200], "items": []}
    return {"items": items}

def main():
    all_out = {}
    for key, path in SEARCHES.items():
        r = gh_search(path)
        all_out[key] = r
        print(key, "->", len(r.get("items", [])), "items", ("ERR:" + r["_error"]) if "_error" in r else "")
        time.sleep(0.3)
    with open(os.path.join(OUT_DIR, "_raw_search.json"), "w", encoding="utf-8") as f:
        json.dump(all_out, f, ensure_ascii=False, indent=1)
    print("saved")

if __name__ == "__main__":
    main()
