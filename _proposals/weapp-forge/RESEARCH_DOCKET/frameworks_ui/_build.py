# -*- coding: utf-8 -*-
"""fw-ui builder: merge gh api raw data + catalog descriptions -> _all.json + _all.md"""
import json, os
from datetime import datetime, timezone

BASE = r"E:\AI-Station\_proposals\weapp-forge\RESEARCH_DOCKET\frameworks_ui"
import sys
sys.path.insert(0, BASE)
from _catalog import CATALOG, DEGRADED, NOT_FOUND_404

NOW = datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ")

def load(name):
    p = os.path.join(BASE, name)
    if not os.path.exists(p):
        return []
    return json.load(open(p, encoding="utf-8"))

def index():
    idx = {}
    # precise results first (full metadata incl license)
    for fname, key in [("_raw_repos.json", None), ("_raw_round2.json", "precise"),
                       ("_raw_round3.json", "precise"), ("_raw_round4.json", None)]:
        data = load(fname)
        if key:
            data = data.get(key, [])
        for it in data:
            if isinstance(it, dict) and "_error" not in it and it.get("full_name"):
                idx[it["full_name"].lower()] = it
    return idx

CAT_NAMES = {
    "framework": "跨端框架",
    "ui": "UI 组件库",
    "tooling": "工程化/样式工具链",
    "charts": "图表/可视化",
    "richtext": "富文本/Markdown 渲染",
    "state": "状态管理/数据",
    "util": "实用库",
    "template": "模板/脚手架",
    "official_ai": "官方新基建/AI",
}

def main():
    idx = index()
    print("indexed repos:", len(idx))

    docs = []
    missing = []
    for full, (cat, content) in CATALOG.items():
        meta = idx.get(full.lower())
        if not meta:
            missing.append(full)
            continue
        doc = {
            "channel": "frameworks_ui",
            "doc_type": "repo",
            "category": cat,
            "title": meta["full_name"],
            "url": meta.get("html_url", f"https://github.com/{meta['full_name']}"),
            "content": content,
            "signals": {
                "stars": meta.get("stargazers_count"),
                "forks": meta.get("forks_count"),
                "language": meta.get("language"),
                "license": meta.get("license"),
                "pushed_at": meta.get("pushed_at"),
                "archived": bool(meta.get("archived")),
                "notes": f"gh api repos/{meta['full_name']} 实测；类目={CAT_NAMES[cat]}",
            },
            "retrieved_at": NOW,
            "credibility": 0.9,
        }
        docs.append(doc)

    if missing:
        print("!! MISSING from raw data (must fix):")
        for m in missing:
            print("   ", m)
        raise SystemExit(1)

    for title, (cat, url, content, note) in DEGRADED.items():
        docs.append({
            "channel": "frameworks_ui",
            "doc_type": "degraded",
            "category": cat,
            "title": title,
            "url": url,
            "content": content,
            "signals": {
                "stars": None, "forks": None, "language": None, "license": None,
                "pushed_at": None, "archived": None,
                "notes": note + f"；类目={CAT_NAMES[cat]}",
            },
            "retrieved_at": NOW,
            "credibility": 0.5,
        })

    docs.sort(key=lambda d: (list(CAT_NAMES).index(d["category"]) if d["category"] in CAT_NAMES else 99,
                             -(d["signals"]["stars"] or 0)))

    out = {"channel": "frameworks_ui", "generated_at": NOW, "docs": docs}
    with open(os.path.join(BASE, "_all.json"), "w", encoding="utf-8") as f:
        json.dump(out, f, ensure_ascii=False, indent=1)
    print("docs:", len(docs), "-> _all.json")

    # ---------- markdown ----------
    md = []
    md.append("# 微信小程序框架/UI/工程化开源生态清点（fw-ui 渠道）")
    md.append("")
    md.append(f"- 生成时间：{NOW}  ")
    md.append(f"- 条目总数：**{len(docs)}**（repo 实测 {len(docs)-len(DEGRADED)} 条 + degraded {len(DEGRADED)} 条）  ")
    md.append("- 数据来源：`gh api repos/{owner}/{repo}` 全量实测（stars/forks/pushed_at/archived 均为 GitHub API 原值，抓取日 2026-09-27）")
    md.append("")
    cur = None
    for d in docs:
        if d["category"] != cur:
            cur = d["category"]
            md.append(f"## {CAT_NAMES[cur]}（{sum(1 for x in docs if x['category']==cur)}）")
            md.append("")
            md.append("| repo | stars | forks | 语言 | license | 最后 push | 状态 | 定位（对工厂价值） |")
            md.append("|---|---:|---:|---|---|---|---|---|")
        s = d["signals"]
        stars = f"{s['stars']:,}" if s["stars"] is not None else "-"
        forks = f"{s['forks']:,}" if s["forks"] is not None else "-"
        lang = s["language"] or "-"
        lic = s["license"] or "-"
        pushed = (s["pushed_at"] or "-")[:10]
        if s["archived"] is True:
            status = "**ARCHIVED**"
        elif s["archived"] is False:
            pushed_year = (s["pushed_at"] or "1970")[:4]
            if pushed_year >= "2026":
                status = "活跃"
            elif pushed_year >= "2025":
                status = "缓维护"
            else:
                status = f"停更({pushed[:7]})"
        else:
            status = "degraded"
        first_sentence = d["content"].split("。")[0]
        md.append(f"| [{d['title']}]({d['url']}) | {stars} | {forks} | {lang} | {lic} | {pushed} | {status} | {first_sentence} |")
        if d["doc_type"] == "degraded":
            pass
    md.append("")

    md.append("## 工厂零件推荐位（每类第一名及理由）")
    md.append("")
    md.append("| 类目 | 推荐件 | 实测 stars | 理由 |")
    md.append("|---|---|---:|---|")
    picks = [
        ("跨端框架", "dcloudio/uni-app（React 栈备选 NervJS/taro）", "41617 / 37702",
         "两强都活跃；uni-app 生态+人才池最大、taro 是 React/TS 正统。工厂走 Vue 选 uni-app，走 React 选 taro，二选一不要混。"),
        ("UI 组件库", "youzan/vant-weapp", "18457",
         "MIT 商业级、组件全、文档好，微信原生向第一；官方系备选 tdesign-miniprogram（1771，2026-09 高频发版，长期主义）。"),
        ("工程化/样式", "sonofmagic/weapp-tailwindcss", "1864",
         "抓取当天仍在发版，tailwind v3/v4 全端支持；配合作者同生态 weapp-vite（486）构成原生小程序现代工程底座。"),
        ("图表/可视化", "ecomfe/echarts-for-weixin", "7512",
         "ECharts 全功能官方适配，研报图表（K线/地图/大数据量）一步到位；适配层 2024 后未推但稳定。"),
        ("富文本/Markdown", "jin-yufeng/mp-html", "3750",
         "富文本渲染事实标准（多端+编辑+插件），研报阅读试点 HTML 基座；Markdown 直渲染补 sbfkcel/towxml（2898）。"),
        ("状态管理", "wechat-miniprogram/mobx-miniprogram-bindings", "249",
         "官方维护、2026-09 活跃；轻量场景直接用官方 computed（696）。westore（4282）stars 更高但节奏一般。"),
        ("实用库", "charleslo1/weapp-cookie + wechat-miniprogram/miniprogram-simulate", "848 / 536",
         "cookie 库是唯一 2026 仍活跃的高星 util（对接 Web 会话刚需）；simulate 是官方组件单测件（2026-06 活跃）。sm-crypto（481）已封存式归档，可用但须自担维护。"),
        ("模板/脚手架", "wechat-miniprogram/miniprogram-demo", "7243",
         "官方组件/API 示例全集=代码生成 few-shot 语料库；行业起手式参考 tdesign-starter-retail（860，活跃）。"),
        ("发布流水线", "miniprogram-ci（npm，官方）", "-",
         "上传/预览唯一正门，npm-only 无 GitHub 仓；GH Actions 现成 action 全停更（echoings 2021/hocgin 2022），自写 20 行脚本最稳。"),
    ]
    for cat, pick, stars, why in picks:
        md.append(f"| {cat} | {pick} | {stars} | {why} |")
    md.append("")

    md.append("## 坑清单（archived / 停更 / 404）")
    md.append("")
    archived = [d["title"] for d in docs if d["signals"]["archived"] is True]
    stale = [d["title"] for d in docs if d["signals"]["archived"] is False and (d["signals"]["pushed_at"] or "1970")[:4] < "2025"]
    md.append("**已归档（archived=true，禁入新项目）**：")
    md.append("")
    for t in archived:
        md.append(f"- {t}")
    md.append("")
    md.append(f"**停更（最后 push 早于 2025 年，共 {len(stale)} 个）**：")
    md.append("")
    for t in stale:
        md.append(f"- {t}")
    md.append("")
    md.append("**实测 404（跳过，真身已记录）**：")
    md.append("")
    for t in NOT_FOUND_404:
        md.append(f"- {t}")
    md.append("")
    md.append("**关键生态事实**：")
    md.append("")
    md.append("- UI 库半壁江山已停更（iview/wux/lin-ui/ColorUI/ThorUI 均 2023-2024 停），活跃的只剩 vant-weapp、tdesign、weui 系——工厂选型必须落在活跃件上。")
    md.append("- 富文本老方案 wxParse（7716 stars）2020 年即死，历史 stars 与可用性严重背离，选型只看 mp-html/towxml。")
    md.append("- GitHub Actions 小程序发布 action 无一存活（最高 14 stars 且 2021 停），发布环节必须自研薄脚本包 miniprogram-ci。")
    md.append("- 官方大量关键件（miniprogram-ci/miniprogram-automator）npm-only 无 GitHub 仓，CLI 包装层是社区唯一开源样例（ruochuan12/mini-ci，已停）。")
    md.append("- 微信 2026 新推 AI 模式（ai-mode-skills/ai-mode-demo）与 glass-easel/Skyline 底座演进，是官方 AI 编程与新一代渲染两大方向信号，工厂设计时应预留对接位。")

    with open(os.path.join(BASE, "_all.md"), "w", encoding="utf-8") as f:
        f.write("\n".join(md) + "\n")
    print("->_all.md written,", len(md), "lines")

if __name__ == "__main__":
    main()
