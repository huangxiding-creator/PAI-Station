# -*- coding: utf-8 -*-
"""fw-ui channel: batch fetch repo metadata via gh api (real stars/pushed_at)."""
import subprocess, json, time, os

OUT_DIR = r"E:\AI-Station\_proposals\weapp-forge\RESEARCH_DOCKET\frameworks_ui"
JQ = '{full_name,html_url,description,stargazers_count,forks_count,language,license:.license.spdx_id,updated_at,pushed_at,archived}'

REPOS = [
    # --- 跨端框架 ---
    "NervJS/taro", "dcloudio/uni-app", "wepyjs/wepy", "Tencent/wepy",
    "meituan-dianping/mpvue", "didi/mpx", "Tencent/kbone", "remaxjs/remax",
    "ant-inst/morjs", "alipay/morjs", "alibaba/rax", "didi/chameleon",
    "Tencent/omi", "yojs/okam", "Baidu/okam", "wechat-miniprogram/miniprogram-ts-template",
    # --- UI 组件库 (微信原生向) ---
    "youzan/vant-weapp", "Tencent/tdesign-miniprogram", "wechat-miniprogram/weui-miniprogram",
    "talkingdata/iview-weapp", "weilanwl/ColorUI", "TaleLin/lin-ui",
    "wux-weapp/wux", "skyvow/wux-weapp", "climblee/uv-ui", "jview666/jview-ui",
    # --- 工程化/样式 ---
    "weapp-tailwindcss/weapp-tailwindcss", "weapp-vite/weapp-vite",
    "unocss-applet/unocss-applet", "sonofmagic/weapp-tailwindcss",
    "skyvow/weapp-gulp", "wechat-miniprogram/miniprogram-ci",
    # --- 图表/可视化 ---
    "ecomfe/echarts-for-weixin", "qiun/ucharts", "xiaolin3303/wx-charts",
    # --- 富文本/Markdown ---
    "jin-yufeng/mp-html", "sbfkcel/towxml", "TooBug/wemark", "bgwdansen/wx-parse-remax",
    "icindy/wxParse",
    # --- 状态管理/数据 ---
    "Tencent/westore", "wechat-miniprogram/mobx-miniprogram-bindings",
    "wechat-miniprogram/mobx-miniprogram",
    # --- 实用库/测试 ---
    "wechat-miniprogram/miniprogram-simulate", "wechat-miniprogram/miniprogram-automator",
    "wangyupo/weapp-qrcode", "zhengjunxin/weapp-cookie",
]

def gh_repo(full):
    p = subprocess.run(
        ["gh", "api", f"repos/{full}", "--jq", JQ],
        capture_output=True, text=True, encoding="utf-8", errors="replace")
    if p.returncode == 0 and p.stdout.strip():
        try:
            return json.loads(p.stdout)
        except Exception:
            return {"full_name": full, "_error": "parse"}
    return {"full_name": full, "_error": (p.stderr or "").strip()[:160]}

def main():
    out = []
    for i, r in enumerate(REPOS):
        d = gh_repo(r)
        out.append(d)
        time.sleep(0.08)
    with open(os.path.join(OUT_DIR, "_raw_repos.json"), "w", encoding="utf-8") as f:
        json.dump(out, f, ensure_ascii=False, indent=1)
    ok = [d for d in out if "_error" not in d]
    bad = [d for d in out if "_error" in d]
    print(f"OK {len(ok)} / ERR {len(bad)}")
    for d in bad:
        print("ERR:", d["full_name"], "|", d["_error"])

if __name__ == "__main__":
    main()
