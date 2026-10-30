# -*- coding: utf-8 -*-
"""归并筛选: sweep_*.json -> MASTER_REGISTRY.json + 筛选报告.md
①跨路去重(repo/域名) ②对照现役(manifest35+channels_v2 62+逆向工程复刻件)算差集
③四级分类 A/B/C/D ④适用面标签 ⑤双产物。数字全由本脚本实测计算。"""
import json, re
from pathlib import Path
from datetime import datetime, timezone

BASE = Path(r"E:/AI-Station/reforge_factory/channels_survey_2026")
STATION = Path(r"E:/AI-Station")

def norm_url(u):
    if not u: return None
    u = u.strip()
    if u.startswith("tool://"): return "tool:" + u[7:].strip("/").lower()
    m = re.match(r"^https?://([^/]+)(/[^\s]*)?", u)
    if not m: return None
    host = m.group(1).lower()
    path = (m.group(2) or "").strip("/")
    host_n = re.sub(r"^(www|api|export)\.", "", host)
    for fh, pre in (("github.com", "gh"), ("gitlab.com", "gl")):
        if host_n == fh and path:
            seg = [s for s in path.split("/") if s and not s.endswith(".git")]
            if len(seg) >= 2:
                return pre + ":" + seg[0].lower() + "/" + seg[1].lower()
    if host in ("git.lolcat.ca", "gitlab.metager.de") and path:
        seg = [s for s in path.split("/") if s]
        if len(seg) >= 2: return "git:" + host + "/" + seg[0].lower() + "/" + seg[1].lower()
    return "dom:" + host_n

GITHUB_FULL = re.compile(r"^github\.com/[A-Za-z0-9_.\-]+/[A-Za-z0-9_.\-]+$")

def is_placeholder_site(u):
    if not u or "(" in u: return True
    b = u.replace("https://", "").rstrip("/")
    if b.startswith("github.com/") and not GITHUB_FULL.match(b): return True
    return False

manifest = json.load(open(STATION/"ResearchFactory-Eng/channel_manifest.json", encoding="utf-8"))
named35 = manifest["named_channels"]
v2 = json.load(open(STATION/"ResearchFactory-Eng/EPC100/conductor/v2/channels_v2.json", encoding="utf-8"))
v2ch = v2["channels"]
replica_dirs = sorted([p.name for p in (STATION/"逆向工程").iterdir() if p.is_dir()])

raw_entries = []
def add(lane, source_tag, p):
    e = {"source_lanes": [lane], "source_tags": [source_tag]}
    for k in ("name","repo_or_site","desc","access","fit","evidence","stars_or_evidence",
              "cat","tier","managed","src","registry_id","one_liner","cn_reachable","cn_reach"):
        if k in p: e[k] = p[k]
    raw_entries.append(e)

import glob as _g
SWEEPS = []
for _f in sorted(_g.glob(str(BASE / "sweep_*.json"))):
    try:
        _d = json.load(open(_f, encoding="utf-8"))
        if isinstance(_d, dict) and _d.get("projects"):
            SWEEPS.append(_d)
            print("load", _f.split(chr(92))[-1].split("/")[-1], len(_d["projects"]))
    except Exception as _e:
        print("skip", _f, _e)
for _sw in SWEEPS:
    _ln = _sw.get('lane', 'unknown')
    for _p in _sw['projects']:
        add(_ln, _p.get('src', _ln), _p)

RAW_TOTAL = len(raw_entries)

SVC_KEY_OVR = {
    "网页搜索项目注册表(119项)": "svc:search_library",
    "ima 公开知识库 (公开订阅库生态发现+收割, EPC100 第21渠道)": "svc:ima_public",
    "秘塔知识库专题(工程行业大脑: 知识库内文件检索/元数据/原文件下载)": "svc:metaso_kb",
    "裁判文书卷宗线(BT全量卷+百度网盘102G离线)": "svc:wenshu_bt",
}
for e in raw_entries:
    mg = str(e.get("managed", ""))
    if e["source_lanes"] == ["localregistry"] and (mg.startswith("在役已纳管") or e["source_tags"] == ["localregistry:D_reverse_replica"]):
        e["existing_match"] = True
        e["existing_source"] = "渠道册在役" if mg.startswith("在役已纳管") else "逆向工程复刻件"
    if e["source_tags"] == ["localregistry:A_search_library_ce"]:
        if "已接线实采" in mg:
            e["existing_match"] = True
            e["existing_source"] = "search_library接线(webregistry实采)"
        else:
            e["registry_covered"] = True

def entry_key(e):
    if e.get("existing_match") and e["source_lanes"] == ["localregistry"]:
        nm = e["name"]
        if nm in SVC_KEY_OVR: return SVC_KEY_OVR[nm]
        site = e.get("repo_or_site", "")
        if not is_placeholder_site(site):
            k = norm_url(site)
            if k and not k.startswith("gh:"): return k
        return "svc:" + re.sub(r"\s+", "", nm)[:28]
    k = norm_url(e.get("repo_or_site", ""))
    return k if k else ("name:" + re.sub(r"\s+", "", e["name"])[:28])

by_key = {}
for e in raw_entries:
    k = entry_key(e)
    if k in by_key:
        m = by_key[k]
        m["source_lanes"] = sorted(set(m["source_lanes"] + e["source_lanes"]))
        m["source_tags"] = sorted(set(m["source_tags"] + e["source_tags"]))
        for f in ("existing_match", "registry_covered"):
            if e.get(f): m[f] = True
        if e.get("existing_source") and not m.get("existing_source"):
            m["existing_source"] = e["existing_source"]
        for f in ("evidence","stars_or_evidence","desc","fit","access","cat","src","one_liner"):
            if f in e and f not in m: m[f] = e[f]
        m["dup_merge_count"] = m.get("dup_merge_count", 1) + 1
    else:
        e["dedup_key"] = k
        by_key[k] = e
entries = list(by_key.values())
UNIQUE_TOTAL = len(entries)
DEDUP_MERGED = RAW_TOTAL - UNIQUE_TOTAL

EXIST_DOM = {
    "openalex.org": "openalex", "semanticscholar.org": "semantic_scholar", "arxiv.org": "arxiv",
    "manus.im": "manus", "metaso.cn": "metaso", "weixin.sogou.com": "sougo",
    "djyanbao.com": "djyanbao", "kns.cnki.net": "cnki", "ima.qq.com": "ima",
    "weread.qq.com": "weread", "feishu.cn": "lark", "pan.baidu.com": "baidu_netdisk",
    "ebiaozhun.com": "gbstandard", "giiisp.com": "giiisp", "pan.quark.cn": "quark_pan",
    "bid.powerchina.cn": "powerchina", "book.dangdang.com": "dangdang",
    "wenku.baidu.com": "kb_harvest", "book118.com": "kb_harvest", "doc88.com": "kb_harvest",
    "enr.com": "enr(逆向件)", "xique.com": "xique(逆向件)", "chinca.org": "chinca(逆向件)",
    "openstd.samr.gov.cn": "std-samr(逆向件/skill)", "api.bilibili.com": "video",
    "wxy88.top": "zbzk_wxy", "sec.gov": "edgar", "mee.gov.cn": "eia",
    "panjiva.com": "panjiva", "pages.stern.nyu.edu": "damodaran",
    "mvanhorn/last30days-skill": "last30days", "anysearch-ai/anysearch-skill": "anysearch",
    "tapxworld/chinatextbook": "chinatextbook", "fish2018/pansou": "pansou",
    "jbiaojerry/ebook-treasure-chest": "ebook", "yt-dlp/yt-dlp": "video",
    "careytian-ai/zh-search-pro": "zh_search_pro", "wenshu.court.gov.cn": "court",
    "searxng/searxng": "search_library(接线引擎)", "jina-ai/reader": "search_library(接线引擎)",
}
for e in entries:
    if e.get("existing_match"): continue
    k = e["dedup_key"]
    hit = None
    if k.startswith("dom:"): hit = EXIST_DOM.get(k[4:])
    elif k.startswith("gh:") or k.startswith("gl:"): hit = EXIST_DOM.get(k.split(":", 1)[1])
    if hit:
        e["existing_match"] = True
        e["existing_source"] = "现役渠道[" + hit + "]"
for e in entries:
    if "notebooklm" in e["dedup_key"]:
        e["note"] = "本站NBLM runbook在役(26笔记本), 未入manifest/v2渠道册, 记为B级注册面"

D_KEYS = {"gh:mikf/gallery-dl", "dom:prices.eu.org"}
import re as _re
def need_key(acc):
    a = _re.sub(r"[免零无]key|[免零无] key|[免零无]Key", "", acc)
    return bool(_re.search(r"需.{0,6}key|key\s*\(|付费|账号|需申请", a, _re.I))
def tier_assign(e):
    key, name, acc = e["dedup_key"], e["name"], str(e.get("access", ""))
    cat = e.get("cat", "")
    if key in D_KEYS: return "D"
    if name == "DevDocs": return "D"
    if e.get("existing_match") and e["source_lanes"] == ["localregistry"]:
        if any(x in name for x in ("易媒助手", "WPS AI排版", "识流AI助手")): return "D"
        return "A"
    if "datasets" in e["source_lanes"] and "localregistry" not in e["source_lanes"]:
        ev = str(e.get("evidence", ""))
        neg = any(x in ev for x in ("404", "410", "403", "000", "412", "302", "303", "301", "429"))
        pos = ("200" in ev or "202" in ev or "官方" in ev)
        if acc.startswith("浏览器") and "API" not in acc: return "B"
        if ("免登录" in acc or "匿名" in acc) and "需" not in acc.replace("需登录", ""):
            return "A" if (pos or not neg) else "B"
        if "API" in acc and not need_key(acc) and "购买" not in acc and "订阅" not in acc and "合作" not in acc and pos:
            return "A"
        return "B"
    if e.get("registry_covered") or "localregistry:A_search_library_ce" in e["source_tags"]:
        if cat == "key_required" or cat == "awesome_list": return "B"
        if cat in ("mcp_server", "api_wrapper", "zh_search", "cli_tool"):
            return "B" if need_key(acc) else "A"
        return "C"
    if e.get("existing_match"): return "A"
    if "deepresearch" in e["source_lanes"]:
        if "闭源产品" in acc or "需申请" in acc or "MCP/API" in acc or "API需key" in acc or "账号" in acc: return "B"
        if key == "dom:storm.genie.stanford.edu": return "A"
        return "C"
    TOPIC_A = {"gh:damonwonghv/youtube-search-api", "gh:gosom/google-maps-scraper",
               "gh:knockoutez/wigolo", "gh:kituin/picimagesearch", "gh:sckott/habanero",
               "dom:search.xorsoft.dev"}
    if key in TOPIC_A: return "A"
    if "需key" in acc or "付费" in acc or "需X账号" in acc: return "B"
    site = str(e.get("repo_or_site", ""))
    if "github.com" not in site and site.startswith("http") and ("未实测" in acc or "服务" in acc or "网站" in acc):
        return "B"
    return "C"

TAG_MAP = [("标准定额", ("标准", "定额", "造价")), ("学术专利", ("学术", "文献", "论文", "专利", "综述")),
           ("新闻舆情", ("新闻", "舆情", "热度", "口碑", "社媒", "热榜", "监测")),
           ("工商招投标", ("招标", "投标", "标讯", "tender", "contracting", "采购")),
           ("项目数据", ("项目数据", "统计", "卫星", "地图", "名录", "财务", "金融")),
           ("数据集", ("数据集", "目录", "dataset"))]
def tags_assign(e):
    txt = " ".join(str(e.get(k, "")) for k in ("name", "fit", "desc", "one_liner"))
    tags = [t for t, kws in TAG_MAP if any(k in txt for k in kws)]
    return tags if tags else ["通用网研"]

for e in entries:
    e["tier"] = tier_assign(e)
    e["tags"] = tags_assign(e)

SAME_SRC = {"gh:sckott/habanero": "dom:api.crossref.org", "gh:lukasschwab/arxiv.py": "dom:arxiv.org",
            "gh:commoncrawl/cc-index-table": "dom:commoncrawl.org"}
for e in entries:
    if e["dedup_key"] in SAME_SRC: e["same_source_as"] = SAME_SRC[e["dedup_key"]]

def cnt(pred): return sum(1 for e in entries if pred(e))
by_tier = {t: cnt(lambda e, t=t: e["tier"] == t) for t in ("A", "B", "C", "D")}
new_entries = [e for e in entries if not e.get("existing_match")]
NEW = len(new_entries)
new_by_tier = {t: sum(1 for e in new_entries if e["tier"] == t) for t in ("A", "B", "C", "D")}
reg_covered_new = sum(1 for e in new_entries if e.get("registry_covered"))
tag_stat = {}
for e in entries:
    for t in e["tags"]: tag_stat[t] = tag_stat.get(t, 0) + 1

now = datetime.now(timezone.utc).strftime("%Y-%m-%d %H:%M UTC")
def slim(e):
    out = {"name": e["name"], "entry": e.get("repo_or_site", ""), "tier": e["tier"],
           "tags": e["tags"], "dedup_key": e["dedup_key"], "source_lanes": e["source_lanes"]}
    for f in ("access", "evidence", "stars_or_evidence", "cat", "managed", "src", "desc",
              "one_liner", "fit", "existing_match", "existing_source", "registry_covered",
              "same_source_as", "note", "dup_merge_count"):
        if f in e: out[f] = e[f]
    return out

registry = {
    "_doc": "深度调研渠道普查主注册表(全量): 四路sweep归并去重+现役差集+四级分级+适用面标签; 数字全实测",
    "generated": now,
    "inputs": ["sweep_datasets.json(72)", "sweep_deepresearch.json(106)",
               "sweep_localregistry.json(180)", "sweep_topic_hn.json(112)"],
    "baseline_existing": {"channel_manifest_named": len(named35), "channels_v2": len(v2ch),
                          "replica_dirs": replica_dirs},
    "tier_defs": {"A": "免登录API/CLI可直采(搜索/数据/文献类)立即接入",
                  "B": "需key/账号/购买或数据集目录形态, 先注册登记",
                  "C": "研究代理框架/编排/引擎/爬取基建, 作方法论资产",
                  "D": "纯无关(娱乐/消费品/开发者文档/生产分发件)剔除"},
    "tag_vocab": ["标准定额", "项目数据", "学术专利", "新闻舆情", "工商招投标", "数据集",
                  "通用网研(扩展: 通用引擎/框架/基建适用面)"],
    "stats": {"raw_total": RAW_TOTAL, "unique_total": UNIQUE_TOTAL, "dedup_merged": DEDUP_MERGED,
              "existing_match": cnt(lambda e: e.get("existing_match")), "new_candidates": NEW,
              "new_registry_covered_search_library": reg_covered_new,
              "by_tier_all": by_tier, "by_tier_new_only": new_by_tier, "by_tag": tag_stat},
    "entries": sorted([slim(e) for e in entries],
                      key=lambda x: ({"A": 0, "B": 1, "C": 2, "D": 3}[x["tier"]], x["name"].lower())),
}
json.dump(registry, open(BASE/"MASTER_REGISTRY.json", "w", encoding="utf-8"), ensure_ascii=False, indent=1)

def row(e):
    st = "现役" if e.get("existing_match") else ("候选册在册" if e.get("registry_covered") else "新")
    ev = str(e.get("evidence") or e.get("stars_or_evidence") or "")
    return ("| " + e["name"] + " | " + str(e.get("repo_or_site", "")) + " | " +
            str(e.get("access", ""))[:56] + " | " + "/".join(e["tags"]) + " | " + st + " | " + ev[:56] + " |")

A_new = [e for e in entries if e["tier"] == "A" and not e.get("existing_match")]
A_old = [e for e in entries if e["tier"] == "A" and e.get("existing_match")]
B_e = [e for e in entries if e["tier"] == "B"]
C_e = [e for e in entries if e["tier"] == "C"]
D_e = [e for e in entries if e["tier"] == "D"]

def group(lst, keyfn):
    g = {}
    for x in lst: g.setdefault(keyfn(x), []).append(x)
    return g

ACAD = ("CORE","Springer","IEEE","Scopus","Dimensions","Web of Science","Patents","Lens","Espacenet","WIPO","Comtrade","BASE","OpenCitations","Kaggle","UNIDO","IEA","ADB","Figshare","FRED","EIA","Census","Scite","Elicit","Consensus","SciSpace","ResearchRabbit","NotebookLM","FutureHouse","Not Human","SearchHive")
SEARCHKEY = ("Tavily","Exa","Brave","Kagi","SerpApi","Bocha","Google","Bright","firesearch","fire search")
def bg_key(e):
    if e.get("existing_match"): return "现役注册面"
    if any(k in e["name"] for k in ACAD): return "学术/数据API需key或账号"
    if "标准定额" in e["tags"]: return "标准机构购买/浏览器面"
    if any(k in e["name"] for k in SEARCHKEY) or need_key(str(e.get("access", ""))): return "搜索API需key"
    if "awesome" in e["name"].lower() or e.get("cat") == "awesome_list" or "目录" in str(e.get("fit", "")): return "数据集/目录形态"
    return "闭源DR产品/托管服务(未实测)"

ENG = ("LangGraph","AutoGen","CrewAI","MetaGPT","n8n","Dify","AutoGPT","Agno","Mastra","Semantic Kernel","smolagents","Letta","pydantic","Qwen-Agent","CAMEL","OWL","Praison","XAgent","AutoAgent","LlamaIndex","OpenManus","AgentGPT","Open WebUI","Agent Laboratory","Khoj","DocsGPT","Onyx")
CRAWL = ("crawl","Crawl","Scrap","scrap","Spider","spider","Playwright","browser","Browser","Skyvern","Flare","readability","Colly","ferret","patchright","curl","nopecha","proxy","atana","Photon","obscura","Scrapling","EasySpider","maxun","Maxun","newspaper","crawlab","webmagic","anakin","Anakin","moli","pinchtab","webclaw","PyScrappy","FetchRelay","MarkItDown","Docling","trafilatura","Crawlee","Stagehand","Stealth","stealth","changedetection")
ENGSRV = ("Search","search","Searx","searx","Whoogle","YaCy","4get","LibreY","MetaGer","mwmbl","Stract","Fess","Meili","Typesense","OpenSearch","Zoekt","Marginalia","DevDocs","Openverse")
def cg_key(e):
    fit = str(e.get("fit", "")) + e["name"]
    if any(k in fit for k in ("调研","研报","报告","综述","预测","知识库","访谈")): return "DR框架/研究代理"
    if any(k in e["name"] for k in ENG): return "编排/agent底座"
    if e.get("cat") == "metasearch" or any(k in e["name"] for k in ENGSRV): return "自托管搜索引擎/索引件"
    if any(k in e["name"] for k in CRAWL) or e.get("cat") == "crawler": return "爬取/浏览器/抽取基建"
    return "其他工具件"

L = []
L.append("# 深度调研渠道普查 · 归并筛选报告 (channels_survey_2026)")
L.append("")
L.append("生成: " + now + " ｜ 产出件: MASTER_REGISTRY.json(全量) + 本报告 ｜ 建表脚本: _scripts/build_master_registry.py")
L.append("")
L.append("## 1. 输入与口径(全实测)")
L.append("")
L.append("- 四路sweep全量读入: sweep_datasets.json 72件 + sweep_deepresearch.json 106件 + sweep_localregistry.json 180件 + sweep_topic_hn.json 112件 = **原始 " + str(RAW_TOTAL) + " 条**")
L.append("- 跨路去重键: github/gitlab仓库(owner/repo小写) + 域名(去scheme/www/api前缀) + 渠道册聚合条目svc:命名空间; **去重合并 " + str(DEDUP_MERGED) + " 条 → 唯一条目 " + str(UNIQUE_TOTAL) + " 条**")
L.append("- 现役基线: channel_manifest named_channels " + str(len(named35)) + " 渠 + EPC100 conductor channels_v2 " + str(len(v2ch)) + " 渠 + 逆向工程复刻件目录 " + str(len(replica_dirs)) + " 个(其中14条存量候选入账) → 差集(非现役) = **新候选 " + str(NEW) + " 条**")
L.append("- 新候选中 " + str(reg_covered_new) + " 条已在search_library候选册在册未接线(webregistry已实采11台引擎单列现役)")
L.append("- 分级: A=免登录API/CLI可直采立即接入 ｜ B=需key/账号/购买或数据集目录形态先注册登记 ｜ C=研究代理框架/编排/引擎/爬取基建作方法论资产 ｜ D=纯无关剔除")
L.append("- 适用面标签: 标准定额/项目数据/学术专利/新闻舆情/工商招投标/数据集 + 扩展标签「通用网研」(六canonical标签均不适用时的通用引擎/框架/基建)")
L.append("- 探针负证(403/404/000等)非通道死亡判定(sweep_datasets method在案); 未实测托管服务如实标注")
L.append("")
L.append("## 2. 总量统计")
L.append("")
L.append("| 口径 | A立即接入 | B注册登记 | C方法论资产 | D不适用 | 合计 |")
L.append("|---|---|---|---|---|---|")
L.append("| 全量唯一条目 | " + str(by_tier["A"]) + " | " + str(by_tier["B"]) + " | " + str(by_tier["C"]) + " | " + str(by_tier["D"]) + " | " + str(UNIQUE_TOTAL) + " |")
L.append("| 新候选(差集) | " + str(new_by_tier["A"]) + " | " + str(new_by_tier["B"]) + " | " + str(new_by_tier["C"]) + " | " + str(new_by_tier["D"]) + " | " + str(NEW) + " |")
L.append("")
L.append("- 现役命中(existing_match): " + str(cnt(lambda e: e.get("existing_match"))) + " 条(本轮普查顺带确认在役渠道/复刻资产存活)")
L.append("- 适用面标签分布(多标签): " + " ｜ ".join(k + "=" + str(v) for k, v in sorted(tag_stat.items(), key=lambda x: -x[1])))
L.append("")
L.append("## 3. A级全列(" + str(len(A_new)) + "条新候选 + " + str(len(A_old)) + "条现役确认)")
L.append("")
L.append("### 3.1 A级·新候选(立即接入)")
L.append("")
L.append("| 名称 | 入口 | 访问形态 | 适用面 | 状态 | 证据 |")
L.append("|---|---|---|---|---|---|")
for e in sorted(A_new, key=lambda x: ("/".join(x["tags"]), x["name"].lower())): L.append(row(e))
L.append("")
L.append("### 3.2 A级·现役确认(差集扣除, 不重复接入)")
L.append("")
L.append("| 名称 | 入口 | 访问形态 | 适用面 | 状态 | 证据 |")
L.append("|---|---|---|---|---|---|")
for e in sorted(A_old, key=lambda x: x["name"]): L.append(row(e))
L.append("")
L.append("## 4. B级摘要(" + str(len(B_e)) + "条)")
L.append("")
for g, lst in sorted(group(B_e, bg_key).items(), key=lambda x: -len(x[1])):
    names = sorted(set(x["name"] for x in lst))
    L.append("### " + g + " · " + str(len(lst)) + "条")
    L.append("- " + " ｜ ".join(names[:40]) + (" …" if len(names) > 40 else ""))
    L.append("")
L.append("## 5. C级摘要(" + str(len(C_e)) + "条, 方法论资产)")
L.append("")
for g, lst in sorted(group(C_e, cg_key).items(), key=lambda x: -len(x[1])):
    names = sorted(set(x["name"] for x in lst))
    L.append("### " + g + " · " + str(len(lst)) + "条")
    L.append("- " + " ｜ ".join(names[:45]) + (" …" if len(names) > 45 else ""))
    L.append("")
L.append("## 6. D级剔除(" + str(len(D_e)) + "条)")
L.append("")
D_REASON = {"gallery-dl": "图片站媒体下载器(娱乐向)",
            "Prices.eu.org": "消费品比价站(sweep自标弱相关备查, 非工程面)",
            "DevDocs": "开发者文档聚合(非行业情报源)",
            "易媒助手(多平台分发客户端)": "生产分发件在役(ope-engine), 非调研渠道, 仅登记",
            "WPS AI排版(AES模板)": "排版生产件在役(PentAGI 8443), 非调研渠道, 仅登记",
            "识流AI助手(thiflow)": "逆向结论=纯RPA截图助手, 无研报情报面"}
for e in D_e:
    L.append("- " + e["name"] + " — " + D_REASON.get(e["name"], "与工程研报无关"))
L.append("")
L.append("## 7. 现役35渠道差集结论 + 接入建议")
L.append("")
L.append("- 差集: " + str(UNIQUE_TOTAL) + " 唯一条目中 " + str(cnt(lambda e: e.get("existing_match"))) + " 条命中现役(manifest35/v2-62/复刻件), **净新增候选 " + str(NEW) + " 条**(A " + str(new_by_tier["A"]) + " / B " + str(new_by_tier["B"]) + " / C " + str(new_by_tier["C"]) + ")")
L.append("- A级立即接入优先序: ①工程研报直接对口的匿名数据/文献API(OpenAIRE/Unpaywall/EuropePMC/DOAJ/Crossref/Zenodo/Dryad等) ②招投标/政府与宏观数据面(TED/OCD/USAspending/Eurostat/WB/OECD/UN Data/BLS/GDELT) ③免key中文/热榜/视频搜索件(DailyHotApi/baidu-serp-api/WechatSogou系/youtube-search-api) ④免key MCP/CLI包装器族(duckduckgo-mcp/open-webSearch/free-search-mcp/ddgr/howdoi/habanero)")
L.append("- B级注册登记建议: 学术API key族(CORE/Springer/IEEE/PatentsView/Lens/Espacenet OPS/Comtrade/FRED/EIA/Census)与闭源DR产品(OpenAI/Gemini/Perplexity DR等)按需开户; 标准机构(ISO/ASTM/BSI/DIN/ASME/CEN/IEC)购买面留采购决策; 未实测托管服务(Trendradar/TrueStar/FutureSearch/Danubia/FetchRelay/deepsearch.ing/xorsoft)接线前先探针")
L.append("- C级方法论资产: DR框架(Tongyi DeepResearch/WebThinker/MiroThinker/DeepAnalyze等)+编排底座吸收进产线方法论, 不占渠道名额")
L.append("- 已在册未接线11台引擎(cc_index_table/ddgs/jina_reader/marginalia/mwmbl/openverse/python_baidusearch/searx_space/searxng/tarzi/yacy, webregistry实采)=最短路径接线池")
L.append("")
L.append("## 8. 口径注记")
L.append("")
L.append("- same_source关联: habanero↔Crossref API ｜ arxiv.py↔arXiv API ｜ cc-index-table↔Common Crawl(工具件与源站键不同, 如实分列)")
L.append("- 渠道册聚合条目(开放网络泛搜线/RSS舰队/opencli舰队等)以svc:命名空间去重, 不与web资源误并; ima/ima_public、metaso/metaso_kb、court/wenshu卷宗同域多渠分列")
L.append("- GitHub topic聚合页/awesome清单作目录形态计B级(需人工纳册消化); 图库/验证码等基建件计C级备查")
open(BASE/"筛选报告.md", "w", encoding="utf-8").write("\n".join(L))

print("RAW", RAW_TOTAL, "| UNIQUE", UNIQUE_TOTAL, "| MERGED", DEDUP_MERGED)
print("by_tier_all", by_tier)
print("NEW", NEW, "| new_by_tier", new_by_tier, "| reg_covered_new", reg_covered_new)
print("existing_match", cnt(lambda e: e.get("existing_match")))
print("tags", dict(sorted(tag_stat.items(), key=lambda x: -x[1])))
print("A_new", len(A_new), "| A_old", len(A_old), "| B", len(B_e), "| C", len(C_e), "| D", len(D_e))
print("D:", [e["name"] for e in D_e])
