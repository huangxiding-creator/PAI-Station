# -*- coding: utf-8 -*-
"""fw-ui round4: fetch full metadata (incl license) for official-org repos we will include."""
import subprocess, json, time, os

OUT_DIR = r"E:\AI-Station\_proposals\weapp-forge\RESEARCH_DOCKET\frameworks_ui"
JQ = '{full_name,html_url,description,stargazers_count,forks_count,language,license:.license.spdx_id,updated_at,pushed_at,archived}'

PRECISE = [
    "wechat-miniprogram/glass-easel", "wechat-miniprogram/computed",
    "wechat-miniprogram/api-typings", "wechat-miniprogram/recycle-view",
    "wechat-miniprogram/sm-crypto", "wechat-miniprogram/lottie-miniprogram",
    "wechat-miniprogram/threejs-miniprogram", "wechat-miniprogram/mpflow",
    "wechat-miniprogram/miniprogram-cli", "wechat-miniprogram/ai-mode-skills",
    "wechat-miniprogram/ai-mode-demo", "wechat-miniprogram/awesome-skyline",
    "wechat-miniprogram/miniprogram-slim", "wechat-miniprogram/wxml-to-canvas",
    "wechat-miniprogram/kbone-ui", "wechat-miniprogram/miniprogram-compat",
    "wechat-miniprogram/miniprogram-api-promise", "wechat-miniprogram/mobx",
]

def main():
    out = []
    for r in PRECISE:
        p = subprocess.run(["gh", "api", f"repos/{r}", "--jq", JQ],
                           capture_output=True, text=True, encoding="utf-8", errors="replace")
        if p.returncode == 0 and p.stdout.strip():
            out.append(json.loads(p.stdout))
        else:
            out.append({"full_name": r, "_error": (p.stderr or "").strip()[:100]})
        time.sleep(0.05)
    ok = [d for d in out if "_error" not in d]
    print(f"OK {len(ok)} / {len(PRECISE)}")
    for d in out:
        if "_error" in d:
            print("ERR:", d["full_name"])
    json.dump(out, open(os.path.join(OUT_DIR, "_raw_round4.json"), "w", encoding="utf-8"),
              ensure_ascii=False, indent=1)
    print("saved round4")

if __name__ == "__main__":
    main()
