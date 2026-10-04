# -*- coding: utf-8 -*-
"""gen_search_library.py — dedup_result.json → EPC100/collectors/search_library/projects.py

分类映射 (cat) + tier1 名单 (免费无键深验) + org-更名别名归一 + existing 本机资产注入。
幂等: 每次从 dedup_result.json 全量重生成 projects.py。
"""
import json
import re
import sys
from pathlib import Path
from urllib.parse import urlparse

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
HERE = Path(__file__).parent
OUT = Path(r"E:/AI-Station/ResearchFactory-Eng/EPC100/collectors/search_library/projects.py")

# org 更名/搬家 别名 → 规范址 (双键之外的同项目双址)
ALIASES = {
    "github.com/mendableai/firecrawl": "github.com/firecrawl/firecrawl",
    "github.com/itzcrazykns/perplexica": "github.com/itzcrazykns/vane",
}

# host[/owner/repo 或 /path] → (cat, tier, extra)
# cat: metasearch|ai_search|api_wrapper|zh_search|mcp_server|cli_tool|
#      crawler|awesome_list|key_required|existing
MAP = {
    # ---- 元搜索/自托管搜索引擎
    "github.com/searxng/searxng": ("metasearch", 1, {}),
    "github.com/benbusby/whoogle-search": ("metasearch", 0, {}),
    "github.com/searx/searx": ("metasearch", 0, {"note": "searxng 前身, 冻结态; 存档登记"}),
    "github.com/ahwxorg/librey": ("metasearch", 0, {}),
    "git.lolcat.ca/lolcat/4get": ("metasearch", 0, {}),
    "gitlab.metager.de/open-source/metager": ("metasearch", 0, {}),
    "github.com/yacy/yacy_search_server": ("metasearch", 0, {}),
    "github.com/mwmbl/mwmbl": ("metasearch", 1, {}),
    "github.com/marginaliasearch/marginaliasearch": ("metasearch", 1, {}),
    "github.com/stractorg/stract": ("metasearch", 0, {}),
    "github.com/codelibs/fess": ("metasearch", 0, {"note": "企业级全文检索服务器"}),
    "github.com/wordpress/openverse": ("metasearch", 1, {"ptype": "service", "alt": "https://api.openverse.org/v1/images/?q=bridge"}),
    "github.com/freecodecamp/devdocs": ("metasearch", 0, {"note": "开发者文档聚合检索"}),
    "github.com/asciimoo/hister": ("metasearch", 0, {}),
    "github.com/searxng/searx-space": ("metasearch", 1, {"ptype": "service", "alt": "https://searx.be/search?q=epc&format=json", "note": "实例目录; probe=公共实例JSON查询"}),
    "github.com/searxng/searxng-docker": ("metasearch", 0, {"note": "官方 docker 部署伴生件"}),
    # ---- AI 搜索/答案引擎
    "github.com/itzcrazykns/vane": ("ai_search", 0, {"note": "原 Perplexica, 已更名 Vane"}),
    "github.com/miurla/morphic": ("ai_search", 0, {}),
    "github.com/zaidmukaddam/scira": ("ai_search", 0, {"note": "原 MiniPerplx"}),
    "github.com/assafelovic/gpt-researcher": ("ai_search", 0, {}),
    "github.com/stanford-oval/storm": ("ai_search", 0, {}),
    "github.com/dzhng/deep-research": ("ai_search", 0, {}),
    "github.com/internlm/mindsearch": ("ai_search", 0, {"note": "中文 AI 搜索 (书生·浦语)"}),
    "github.com/modsetter/surfsense": ("ai_search", 0, {}),
    "github.com/khoj-ai/khoj": ("ai_search", 0, {"note": "个人知识+联网 AI 搜索"}),
    "github.com/open-webui/open-webui": ("ai_search", 0, {"note": "web 网关层(多引擎可插)"}),
    "github.com/developersdigest/llm-answer-engine": ("ai_search", 0, {}),
    "github.com/supermemoryai/opensearch-ai": ("ai_search", 0, {}),
    "github.com/jina-ai/node-deepresearch": ("ai_search", 0, {}),
    "github.com/leptonai/search_with_lepton": ("ai_search", 0, {}),
    "github.com/anysearch-ai/anysearch-skill": ("ai_search", 0, {"note": "skill 形态交付"}),
    # ---- 搜索 API 封装 (免费/无键)
    "github.com/deedy5/ddgs": ("api_wrapper", 1, {"pypi": "ddgs", "note": "duckduckgo_search 换代版; 免键"}),
    "github.com/gleitz/howdoi": ("cli_tool", 1, {"pypi": "howdoi"}),
    "github.com/googleapis/google-api-python-client": ("key_required", 0, {"note": "CSE 需 key (免费层100q/d)"}),
    # ---- key_required (付费/需key API 产品及其官方封装)
    "github.com/exa-labs/exa-py": ("key_required", 0, {}),
    "github.com/exa-labs/exa-mcp-server": ("key_required", 0, {}),
    "github.com/tavily-ai/tavily-python": ("key_required", 0, {}),
    "github.com/tavily-ai/tavily-mcp": ("key_required", 0, {}),
    "github.com/serpapi/google-search-results-python": ("key_required", 0, {}),
    "github.com/serpapi/serpapi-mcp": ("key_required", 0, {}),
    "github.com/brave/brave-search-mcp-server": ("key_required", 0, {"note": "Brave API 免费层1q/s 需key"}),
    "github.com/brave/brave-search-cli": ("key_required", 0, {}),
    "github.com/kagisearch/kagimcp": ("key_required", 0, {}),
    "github.com/microck/kagi-cli": ("key_required", 0, {}),
    "github.com/perplexityai/modelcontextprotocol": ("key_required", 0, {"note": "sonar API 需 key"}),
    "github.com/bochaai/bocha-search-mcp": ("key_required", 0, {"note": "中文搜索API 需 key"}),
    "github.com/richard-weiss/mcp-google-cse": ("key_required", 0, {}),
    "github.com/jianjungki/tavily-open": ("key_required", 0, {"note": "社区开源替代壳 (TrailSearch)"}),
    # ---- 中文搜索
    "github.com/chyroc/wechatsogou": ("zh_search", 0, {"note": "搜狗微信检索 (老牌, 冻结前登记)"}),
    "github.com/amazingcoderpro/python-baidusearch": ("zh_search", 0, {"pypi": "baidusearch"}),
    "github.com/zjp1997720/wechat-article-search": ("zh_search", 0, {}),
    "github.com/imsyy/dailyhotapi": ("zh_search", 0, {"note": "热榜聚合 API (微信/微博/百度头条等50+源)"}),
    "github.com/evilran/baidu-mcp-server": ("zh_search", 0, {}),
    "github.com/ptbsare/sogou-weixin-mcp-server": ("zh_search", 0, {"note": "搜狗微信 MCP (在役采集线同源面)"}),
    "github.com/wasd9191/aggregate-search-mcp": ("zh_search", 0, {}),
    "github.com/ohblue/baidu-serp-api": ("zh_search", 0, {}),
    "github.com/mirasoth/tarzi": ("zh_search", 0, {}),
    # ---- MCP 服务器 (免费无键)
    "github.com/modelcontextprotocol/servers": ("mcp_server", 0, {"note": "官方参考服务器集 (fetch 等)"}),
    "github.com/ihor-sokoliuk/mcp-searxng": ("mcp_server", 0, {}),
    "github.com/secretiveshell/mcp-searxng": ("mcp_server", 0, {}),
    "github.com/nickclyde/duckduckgo-mcp-server": ("mcp_server", 0, {"pypi": "duckduckgo-mcp-server"}),
    "github.com/aas-ee/open-websearch": ("mcp_server", 0, {"note": "多引擎聚合免键 MCP"}),
    "github.com/mrkrsl/web-search-mcp": ("mcp_server", 0, {}),
    "github.com/microsoft/playwright-mcp": ("mcp_server", 0, {"note": "浏览自动化 MCP (检索后腿)"}),
    "github.com/sweetcornna/free-search-mcp": ("mcp_server", 0, {}),
    "github.com/firecrawl/firecrawl-mcp-server": ("mcp_server", 0, {"note": "对接自托管 firecrawl 可免键"}),
    # ---- CLI 工具
    "github.com/jarun/ddgr": ("cli_tool", 1, {}),
    "github.com/zquestz/s": ("cli_tool", 0, {"note": "聚合打开器 (80+ 站点)"}),
    "github.com/samtay/so": ("cli_tool", 0, {"note": "终端聚合搜索 (haskell)"}),
    "github.com/jarun/googler": ("cli_tool", 0, {"note": "2023 起停更地标; 存档登记 (ddgr 继任在役)"}),
    "gitlab.com/surfraw/surfraw": ("cli_tool", 0, {"note": "古典地标; 存档登记"}),
    "github.com/heartleo/hn-cli": ("cli_tool", 0, {}),
    "github.com/suknna/searxng-cli": ("cli_tool", 0, {}),
    "github.com/builditluc/wiki-tui": ("cli_tool", 0, {}),
    # ---- 爬取/抽取 (检索前后腿)
    "github.com/unclecode/crawl4ai": ("crawler", 0, {"pypi": "crawl4ai"}),
    "github.com/firecrawl/firecrawl": ("crawler", 0, {"pypi": "firecrawl-py", "note": "org 更名 mendableai→firecrawl 已归一"}),
    "github.com/apify/crawlee": ("crawler", 0, {"pypi": "crawlee"}),
    "github.com/scrapy/scrapy": ("crawler", 0, {"pypi": "scrapy"}),
    "github.com/scrapy-plugins/scrapy-playwright": ("crawler", 0, {"pypi": "scrapy-playwright"}),
    "github.com/microsoft/playwright": ("crawler", 0, {}),
    "github.com/browserbase/stagehand": ("crawler", 0, {}),
    "github.com/browser-use/browser-use": ("crawler", 0, {"pypi": "browser-use"}),
    "github.com/skyvern-ai/skyvern": ("crawler", 0, {}),
    "github.com/scrapegraphai/scrapegraph-ai": ("crawler", 0, {"pypi": "scrapegraphai"}),
    "github.com/adbar/trafilatura": ("crawler", 1, {"pypi": "trafilatura"}),
    "github.com/docling-project/docling": ("crawler", 0, {"pypi": "docling"}),
    "github.com/microsoft/markitdown": ("crawler", 0, {"pypi": "markitdown"}),
    "github.com/mozilla/readability": ("crawler", 0, {"note": "Firefox 阅读模式同源抽取"}),
    "github.com/jina-ai/reader": ("crawler", 1, {"ptype": "service", "alt": "https://r.jina.ai/https://example.com", "note": "r.jina.ai 免费层无键"}),
    # ---- awesome 清单/目录
    "github.com/felladrin/awesome-ai-web-search": ("awesome_list", 0, {}),
    "github.com/edoardottt/awesome-hacker-search-engines": ("awesome_list", 0, {}),
    "github.com/punkpeye/awesome-mcp-servers": ("awesome_list", 0, {}),
    "github.com/awesome-selfhosted/awesome-selfhosted": ("awesome_list", 0, {"note": "search engines 分类段"}),
    "github.com/topics/search-engine": ("awesome_list", 0, {}),
    "searx.space": ("awesome_list", 0, {"ptype": "service"}),
    # ---- langchain 社区件 (watchlist 破例收: 统一搜索工具面事实标准)
    "github.com/langchain-ai/langchain-community": ("api_wrapper", 0, {"note": "统一 SearchTools 抽象层 (多引擎适配事实标准)"}),
    "github.com/brcrusoe72/agent-search": ("api_wrapper", 0, {}),
    # ---- 审计增补 (audit extra_suggestions)
    "github.com/felladrin/minisearch": ("metasearch", 0, {"note": "极简元搜索 (SearXNG 家族轻量支)"}),
    "github.com/onyx-dot-app/onyx": ("ai_search", 0, {"note": "原 Danswer; 企业级 AI 检索问答 (多连接器)"}),
    "github.com/gocolly/colly": ("crawler", 0, {"pypi": "colly", "note": "Go 爬取框架地标"}),
    "github.com/meilisearch/meilisearch": ("metasearch", 0, {"note": "自建索引引擎面 — 本地语料检索可用 (非网页元搜索)"}),
    "github.com/typesense/typesense": ("metasearch", 0, {"note": "自建索引引擎面 (非网页元搜索)"}),
    "github.com/opensearch-project/opensearch": ("metasearch", 0, {"note": "自建索引引擎面 (非网页元搜索)"}),
    "github.com/oracle/opengrok": ("metasearch", 0, {"note": "垂直: 源码检索服务器"}),
    "github.com/sourcegraph/zoekt": ("metasearch", 0, {"note": "垂直: 代码检索 (Sourcegraph 同源)"}),
    "github.com/flaresolverr/flaresolverr": ("crawler", 0, {"note": "Cloudflare 盾代理层 — 登记级, 不接默认腿"}),
    "github.com/dgtlmoon/changedetection.io": ("crawler", 0, {"note": "站点变更监测 (检索伴生面)"}),
    "github.com/commoncrawl/cc-index-table": ("api_wrapper", 0, {"note": "Common Crawl 索引 SQL 检索面 — 网页存档普查用"}),
    "github.com/hartator/wayback-machine-downloader": ("cli_tool", 0, {"note": "Wayback 存档整站回收 (历史稿源考古)"}),
    "github.com/future-house/paper-qa": ("ai_search", 0, {"pypi": "paper-qa", "note": "学术文献 RAG 问答"}),
    "github.com/lukasschwab/arxiv.py": ("api_wrapper", 0, {"pypi": "arxiv", "note": "arXiv 检索 API 封装 (学术腿)"}),
    "github.com/mikf/gallery-dl": ("cli_tool", 0, {"note": "媒体站检索下载 (相邻能力)"}),
}

# 本机在册检索资产 → existing 段 (不发探针)
EXISTING_ENTRIES = [
    ("zh_search_pro", "zh-search-pro skill (第24渠道)", "skill://zh-search-pro",
     "免key中文六引擎: 必应中国/百度WAP/搜狗微信/360/知乎/头条+DDG(代理); 上游 openclaw/skills careytian-ai/zh-search-pro (3823★)"),
    ("cli_serp", "cli_serp SERP 直拿直解析", "module://cli_serp",
     "bing+baidu 解析器, curl_cffi impersonate, 引擎域 2.5s 节流; 9 渠道共用"),
    ("cli_fetcher", "cli_fetcher 双梯取数器", "module://cli_fetcher",
     "直连→系统代理双梯; cli_stack 基座"),
    ("opencli", "opencli 166站桥接", "tool://opencli",
     "playwright chromium 专用桥实例; 渠道CLI化工程主干 (09-21 装机)"),
    ("metaso", "metaso 渠道", "skill://metaso-search",
     "积分制付费资源 (09-24 令: 批量禁用, 只做必要性单查)"),
    ("pansou", "第22渠道 pansou", "service://127.0.0.1:8888",
     "上游 fish2018/pansou 已为在册渠道; 网盘聚合发现"),
    ("websearch_tool", "Claude WebSearch 工具", "tool://websearch",
     "会话层检索工具, 配额制"),
    ("sogou_wedown2", "搜狗微信采集 v2", "service://127.0.0.1:3000",
     "公众号文章面; headless 常驻零弹窗 (1003)"),
]


def slug(name: str, url: str) -> str:
    host = (urlparse(url if "//" in url else "https://" + url).hostname or "") \
        .replace(".", "_")
    s = re.sub(r"[^a-z0-9]+", "_",
               re.sub(r"\(.*?\)", "", name).lower()).strip("_")[:36]
    return f"{s or 'proj'}__{host[:24]}"


def host_key(url: str) -> str:
    u = url if "//" in url else "https://" + url
    p = urlparse(u)
    h = (p.hostname or "").lower()
    if h.startswith("www."):
        h = h[4:]
    path = p.path.strip("/").lower()
    return f"{h}/{path}" if path else h


def main():
    sys.path.insert(0, str(HERE))
    from dedup_gate import canon_url
    d = json.loads((HERE / "dedup_result.json").read_text(encoding="utf-8"))
    rows = []
    seen_id = set()
    for c in d["candidates"] + d.get("existing", []):
        url = canon_url(c["url"].rstrip("/"))
        hk = host_key(url)
        # MAP 匹配: 精确 host/path → host only
        hit = MAP.get(hk)
        if not hit:
            hit = MAP.get(hk.split("/")[0])
        if not hit:
            # 未映射 → 按 angle 给保守默认
            ang = c.get("angle", "")
            cat = {"metasearch": "metasearch", "ai-search": "ai_search",
                   "mcp-servers": "mcp_server", "cli-tools": "cli_tool",
                   "agent-crawl": "crawler", "search-api": "api_wrapper",
                   "zh-search": "zh_search", "awesome-lists": "awesome_list",
                   "audit-extra": "api_wrapper"}.get(ang, "api_wrapper")
            hit = (cat, 0, {})
        cat, tier, extra = hit
        pid = slug(c["name"], url)
        while pid in seen_id:
            pid += "x"
        seen_id.add(pid)
        row = {"id": pid, "name": c["name"], "url": url,
               "ptype": extra.get("ptype") or ("repo" if "github.com" in url else "site"),
               "cat": cat, "lang": c.get("lang", "?"),
               "src": "ws1005", "tier": tier,
               "quality": c.get("quality", "mid"),
               "angle": c.get("angle", ""),
               "note": " | ".join(x for x in [c.get("note", "")[:180],
                                              extra.get("note", "")]
                                  if x),
               "practices": (c.get("practices") or [])[:5]}
        if extra.get("pypi"):
            row["pypi"] = extra["pypi"]
        if extra.get("alt"):
            row["probe_q"] = extra["alt"]
        rows.append(row)

    # existing 段
    for pid, name, url, note in EXISTING_ENTRIES:
        rows.append({"id": pid, "name": name, "url": url, "ptype": "service",
                     "cat": "existing", "lang": "-","src": "ws1005",
                     "tier": 0, "quality": "-", "angle": "inhouse",
                     "note": note, "practices": []})

    # 检查未映射项 (审计完备性; 用别名归一后的键)
    unmapped = [c for c in d["candidates"]
                if host_key(canon_url(c["url"])) not in MAP
                and host_key(canon_url(c["url"])).split("/")[0] not in MAP]
    print(f"projects: {len(rows)} (candidates {len(d['candidates'])} "
          f"+ existing {len(EXISTING_ENTRIES)} - aliases归一)")
    print(f"unmapped→默认cat: {len(unmapped)}")
    for u in unmapped:
        print("  ?", u["name"], u["url"])

    lines = ["# -*- coding: utf-8 -*-",
             '"""search_library 注册表 — 网页搜索项目全量纳册 (1005 用户令 Arc L).',
             "",
             "扫荡: 8角度 workflow + 审计 (档案: AI-Station/_proposals/",
             "web-search-integration-1005/); 双键去重+org更名别名归一。",
             f"本文件由 gen_search_library.py 生成: {len(rows)} 项。",
             'cat 语义: metasearch/ai_search/api_wrapper/zh_search/mcp_server/',
             "cli_tool/crawler/awesome_list/key_required(只探文档面,免费优先)/",
             "existing(本机在册检索资产, 不发探针)。",
             '"""',
             ""]
    lines.append("PROJECTS = [")
    for r in rows:
        lines.append("    {")
        for k, v in r.items():
            if isinstance(v, str):
                v = v.replace("\\", "\\\\").replace('"', '\\"')
                lines.append(f'        "{k}": "{v}",')
            elif isinstance(v, list):
                if not v:
                    lines.append(f'        "{k}": [],')
                else:
                    lines.append(f'        "{k}": [')
                    for item in v:
                        item = item.replace("\\", "\\\\").replace('"', '\\"')
                        lines.append(f'            "{item}",')
                    lines.append("        ],")
            else:
                lines.append(f'        "{k}": {v},')
        lines.append("    },")
    lines.append("]")
    lines += ["", "",
              "def by_cat(cat):",
              "    return [p for p in PROJECTS if p[\"cat\"] == cat]",
              "",
              "",
              "def query(kw):",
              "    kw = kw.lower()",
              "    return [dict(p) for p in PROJECTS",
              "            if kw in (p[\"id\"] + p[\"name\"] + p[\"url\"]).lower()]",
              ""]
    OUT.write_text("\n".join(lines), encoding="utf-8")
    from collections import Counter
    print("cat 分布:", dict(Counter(r["cat"] for r in rows)))


if __name__ == "__main__":
    main()
