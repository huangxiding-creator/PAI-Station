# -*- coding: utf-8 -*-
"""api_replica_bridge — 逆向复刻件 API 优先接入层 (1024 用户令: 全渠道尽量避免浏览器自动化).

模式 (每处浏览器腿同构):
  ① API 优先: importlib 加载复刻件原文件 (绝不修改复刻件本身), 调其公开类/函数;
  ② 复刻件抛错 (墙/配额/网络/依赖缺) → 降级原浏览器路径, 日志如实打印 fallback 原因;
  ③ 原浏览器路径原样保留 (降级兜底铁律), 本件只加适配层;
  ④ 记账: API 路径成功 → channel_invocations.jsonl 追加一行 (tool 字段带
     api_replica: 前缀), 台账只增不改不删 (1022 宪法口径)。

1025 扩展: CLI_ENGINES 子进程引擎登记表 (last30days 接入令) — argparse 主入口型
引擎不走 importlib, engine_cmd() 出命令前缀, 台账/寻址与本层共用 (只增不改不删)。

台账寻址: 显式 ledger 参数 > env RF_API_INVOCATION_LEDGER (绝对路径) >
ammo_pool/<campaign>/channel_invocations.jsonl (campaign 参数) > 不落盘 (打印)。
"""
from __future__ import annotations

import importlib.util
import json
import os
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

REPO = Path(__file__).resolve().parents[2]          # E:\AI-Station
AMMO_ROOT = REPO / "ammo_pool"

#: 复刻件登记表 (8 件 — LEDGER 权威源; dangdang 1024 当当专项令入列;
#: metaso_kb 1024 metaso-kb 专项令入列: 检索面匿名已 5/5 贯通, 登录/下载面待凭据修正)
REPLICAS: dict[str, Path] = {
    "sogou":    REPO / "逆向工程" / "sogou-weixin-reverse" / "replica" / "sogou_weixin_api.py",
    "metaso":   REPO / "逆向工程" / "metaso-reverse" / "replica" / "metaso_api.py",
    "djyanbao": REPO / "逆向工程" / "djyanbao-reverse" / "replica" / "djyanbao_api.py",
    "wenku":    REPO / "逆向工程" / "wenku-search-reverse" / "replica" / "wenku_full_api.py",
    "cnki":     REPO / "逆向工程" / "cnki-reverse" / "replica" / "cnki_api.py",
    "chinca":   REPO / "逆向工程" / "chinca-reverse" / "replica" / "chinca_api.py",
    "dangdang": REPO / "逆向工程" / "dangdang-reverse" / "replica" / "dangdang_api.py",
    "metaso_kb": REPO / "逆向工程" / "metaso-kb-reverse" / "replica" / "metaso_kb_api.py",
}

#: CLI 引擎登记表 (1025 last30days 接入令): 子进程调用型采集引擎 —
#: 非 importlib 复刻件 (引擎自带 CLI argparse 主入口, 走 subprocess 而非路径导入)。
#: python=专用 venv (引擎硬门 py>=3.12, 根 .venv 是 3.11 不可用); 引擎纯标准库零依赖。
CLI_ENGINES: dict[str, dict[str, Path]] = {
    "last30days": {
        "script": REPO / "vendors" / "last30days-skill" / "skills" / "last30days"
                  / "scripts" / "last30days.py",
        "python":  REPO / "vendors" / "last30days-skill" / ".venv"
                  / "Scripts" / "python.exe",
    },
    "bls": {                                   # 1025 纳管令·BLS Public Data API
        "script": REPO / "reforge_factory" / "legs" / "bls_leg.py",
        "python":  Path("py"),
    },
    "datacite": {                                   # 1025 纳管令·DataCite API
        "script": REPO / "reforge_factory" / "legs" / "datacite_leg.py",
        "python":  Path("py"),
    },
    "ddgr": {                                   # 1025 纳管令·ddgr
        "script": REPO / "reforge_factory" / "legs" / "ddgr_leg.py",
        "python":  Path("py"),
    },
    "dryad": {                                   # 1025 纳管令·Dryad API
        "script": REPO / "reforge_factory" / "legs" / "dryad_leg.py",
        "python":  Path("py"),
    },
    "eurostat": {                                   # 1025 纳管令·Eurostat API
        "script": REPO / "reforge_factory" / "legs" / "eurostat_leg.py",
        "python":  Path("py"),
    },
    "hf_datasets": {                                   # 1025 纳管令·HuggingFace Datasets API
        "script": REPO / "reforge_factory" / "legs" / "hf_datasets_leg.py",
        "python":  Path("py"),
    },
    "nist": {                                   # 1025 纳管令·NIST Technical Series Publicat
        "script": REPO / "reforge_factory" / "legs" / "nist_leg.py",
        "python":  Path("py"),
    },
    "opendi": {                                   # 1025 纳管令·Open Contracting Data Registry
        "script": REPO / "reforge_factory" / "legs" / "opendi_leg.py",
        "python":  Path("py"),
    },
    "re3data": {                                   # 1025 纳管令·re3data API
        "script": REPO / "reforge_factory" / "legs" / "re3data_leg.py",
        "python":  Path("py"),
    },
    "usaspending": {                                   # 1025 纳管令·USAspending API
        "script": REPO / "reforge_factory" / "legs" / "usaspending_leg.py",
        "python":  Path("py"),
    },
    "wikidata": {                                   # 1025 纳管令·Wikidata API
        "script": REPO / "reforge_factory" / "legs" / "wikidata_leg.py",
        "python":  Path("py"),
    },
    "worldbank": {                                   # 1025 纳管令·World Bank Open Data API
        "script": REPO / "reforge_factory" / "legs" / "worldbank_leg.py",
        "python":  Path("py"),
    },
    "worldbank_projects": {                                   # 1025 纳管令·World Bank Projects & Operatio
        "script": REPO / "reforge_factory" / "legs" / "worldbank_projects_leg.py",
        "python":  Path("py"),
    },
    "xorsoft": {                                   # 1025 纳管令·xorsoft web search (search.xor
        "script": REPO / "reforge_factory" / "legs" / "xorsoft_leg.py",
        "python":  Path("py"),
    },
    "zenodo": {                                   # 1025 纳管令·Zenodo API
        "script": REPO / "reforge_factory" / "legs" / "zenodo_leg.py",
        "python":  Path("py"),
    },
}


def engine_cmd(name: str) -> list[str]:
    """CLI 引擎 → 子进程命令前缀 [python, script]。缺件 → 抛 RuntimeError。"""
    ent = CLI_ENGINES.get(name)
    if ent is None:
        raise RuntimeError(f"未知 CLI 引擎: {name!r} (合法={sorted(CLI_ENGINES)})")
    if not ent["script"].is_file():
        raise RuntimeError(f"CLI 引擎脚本缺失: {ent['script']}")
    py = ent["python"] if ent["python"].is_file() else "py"
    return [str(py), "-X", "utf8", str(ent["script"])]


#: 1025 渠道普查纳管令(第二轮·终局调和): A级 HTTP/CLI 直调引擎登记表 —
#: 调和终态 A=195 中免登录API/免key HTTP/数据集直下类 (MCP服务器/浏览器类/
#: 自托管类不在此表, 全量见 MASTER_REGISTRY, 第一轮88条本轮等价重建+增量)。
#: 登记=可寻址(引擎名→端点+访问面), 实调走 legs/<engine>_leg.py 轻量采集腿
#: (已建15腿, 见 channels_survey_2026/集成台账.md); 引擎名与 channel_matrix
#: SURVEY_ALIASES 渠道 id 同名 (入池 engine 标签直落渠道)。
HTTP_ENGINES: dict[str, dict[str, str]] = {
    "gdelt_doc": {"kind": "http_api", "url": "https://api.gdeltproject.org/api/v2/doc/doc",
              "access": "免登录API(频率限制, 腿内>=3s节流)", "tags": "新闻舆情", "name": "GDELT 2.0 DOC API (全球新闻监测, 1028 P0-3)"},
    "arxiv_api": {"kind": "http_api", "url": "https://export.arxiv.org/api",
              "access": "免登录API", "tags": "学术专利", "name": "arXiv API"},
    "damodaran": {"kind": "http_api", "url": "https://pages.stern.nyu.edu/~adamodar/New_Home_Page/datacurrent.html",
              "access": "免登录API(静态目录直链)", "tags": "数据集", "name": "Damodaran 数据集目录(估值对标免费基准库)"},
    "damonwonghv_youtube_search_api": {"kind": "python_lib", "url": "https://github.com/damonwonghv/youtube-search-api",
              "access": "python库·免登录", "tags": "新闻舆情", "name": "damonwonghv/youtube-search-api"},
    "enr_com": {"kind": "http_api", "url": "https://www.enr.com",
              "access": "免登录(经chinca.org镜像链, 复刻件在案); enr.com本体403不直接用", "tags": "新闻舆情", "name": "ENR工程新闻纪录"},
    "gosom_google_maps_scraper": {"kind": "http_api", "url": "https://github.com/gosom/google-maps-scraper",
              "access": "CLI(开源)·免key", "tags": "项目数据", "name": "gosom/google-maps-scraper"},
    "jina_reader_r_jina_ai_s_jina_ai": {"kind": "http_api", "url": "https://github.com/jina-ai/reader",
              "access": "免登录API(r.jina.ai无key限额)", "tags": "通用网研", "name": "Jina Reader (r.jina.ai / s.jina.ai)"},
    "kituin_picimagesearch": {"kind": "python_lib", "url": "https://github.com/kitUIN/PicImageSearch",
              "access": "python库(免登录聚合源)", "tags": "新闻舆情", "name": "kitUIN/PicImageSearch"},
    "last30days_skill": {"kind": "http_api", "url": "https://github.com/mvanhorn/last30days-skill",
              "access": "开源skill(免登录, 部分源需代理/出口)", "tags": "新闻舆情", "name": "last30days-skill"},
    "openalex_api": {"kind": "http_api", "url": "https://api.openalex.org",
              "access": "免登录API(匿名限额,mailto礼貌池提额)", "tags": "学术专利", "name": "OpenAlex API"},
    "sckott_habanero": {"kind": "python_lib", "url": "https://github.com/sckott/habanero",
              "access": "python库·免登录API(Crossref公共)", "tags": "学术专利", "name": "sckott/habanero"},
    "sec_edgar_2": {"kind": "http_api", "url": "https://www.sec.gov/edgar/",
              "access": "免登录API(官方JSON)", "tags": "项目数据", "name": "SEC EDGAR 美股披露(国际对标一手源)"},
    "semantic_scholar_graph_api": {"kind": "http_api", "url": "https://api.semanticscholar.org",
              "access": "免登录API(无key限速)", "tags": "学术专利", "name": "Semantic Scholar Graph API"},
    "xorsoft": {"kind": "http_api", "url": "https://search.xorsoft.dev/",
              "access": "免登录站点(未实测)", "tags": "通用网研", "name": "xorsoft web search (search.xorsoft.dev)"},
    "chinca": {"kind": "http_api", "url": "https://www.chinca.org",
              "access": "免登录网页(纯HTTP过闸件在案)", "tags": "项目数据", "name": "中国对外承包工程商会(CHINCA)"},
    "key_zh_search_pro": {"kind": "http_api", "url": "https://github.com/careytian-ai/zh-search-pro",
              "access": "免登录API(URL模板免key)", "tags": "通用网研", "name": "免key中文多引擎检索(zh-search-pro)"},
    "tapxworld_chinatextbook_43_5gb_2087": {"kind": "dataset", "url": "https://github.com/TapXWorld/ChinaTextbook",
              "access": "数据集(GitHub raw免登录,105KB/s)", "tags": "数据集", "name": "全套教材语料库 (TapXWorld/ChinaTextbook 43.5GB/2087册)"},
    "std_samr_gov_cn": {"kind": "http_api", "url": "https://openstd.samr.gov.cn",
              "access": "免登录API(全链复刻)", "tags": "标准定额", "name": "国家标准全文公开系统(std.samr.gov.cn)"},
    "gb_gb_t_ebiaozhun": {"kind": "http_api", "url": "https://www.ebiaozhun.com",
              "access": "免登录API(付费件如实报价)", "tags": "标准定额", "name": "国标 GB/GB/T 情报渠道 (eBiaozhun 免登录链)"},
    "book_dangdang_com": {"kind": "http_api", "url": "https://book.dangdang.com",
              "access": "免登录API(图书情报面)", "tags": "数据集", "name": "当当图书(书目情报: 题录/简介/目录框架)"},
    "weixin_sogou_com": {"kind": "http_api", "url": "https://weixin.sogou.com",
              "access": "免登录API(复刻件,永久链局限在案)", "tags": "新闻舆情", "name": "搜狗微信"},
    "eia_eia": {"kind": "http_api", "url": "https://www.mee.gov.cn",
              "access": "免登录API(GovListChannel基座)", "tags": "项目数据", "name": "生态环境部环评渠道(模块名 eia, 非美国EIA)"},
    "76_bid_powerchina_cn": {"kind": "http_api", "url": "https://bid.powerchina.cn",
              "access": "免登录API(76站爬线)", "tags": "工商招投标/项目数据", "name": "电建系招标舰队(76站, bid.powerchina.cn 无鉴权)"},
    "wenku_search": {"kind": "http_api", "url": "https://wenku.baidu.com",
              "access": "免登录API(复刻件)", "tags": "数据集", "name": "百度文库搜索(wenku-search)"},
    "pansou": {"kind": "http_api", "url": "https://github.com/fish2018/pansou",
              "access": "免登录API(本地服务)", "tags": "数据集", "name": "网盘聚合发现(pansou)"},
    "yt_dlp_bili_yt": {"kind": "http_api", "url": "https://github.com/yt-dlp/yt-dlp",
              "access": "免登录CLI(yt-dlp)", "tags": "新闻舆情", "name": "视频文稿(yt-dlp bili/yt)"},
    "giiisp_com_keyless": {"kind": "http_api", "url": "https://giiisp.com",
              "access": "免登录API(英文腿keyless;中文腿需token)", "tags": "学术专利", "name": "集思谱 giiisp.com 论文检索(keyless英文腿)"},
    "marginalia_search": {"kind": "http_api", "url": "tool://marginalia_search",
              "access": "免登录API(限速)/需key提额", "tags": "通用网研", "name": "Marginalia Search"},
    "opensanctions": {"kind": "dataset", "url": "https://www.opensanctions.org/",
              "access": "数据集(免登录下载)+API(部分需key)", "tags": "项目数据", "name": "OpenSanctions"},
    "agent_search": {"kind": "http_api", "url": "https://github.com/brcrusoe72/agent-search",
              "access": "免登录API封装", "tags": "通用网研", "name": "agent-search"},
    "aiddata": {"kind": "dataset", "url": "https://www.aiddata.org",
              "access": "数据集免登录下载", "tags": "项目数据/数据集", "name": "AidData"},
    "arxiv_py": {"kind": "http_api", "url": "https://github.com/lukasschwab/arxiv.py",
              "access": "免登录API封装(arXiv官方API)", "tags": "标准定额/学术专利", "name": "arxiv.py"},
    "baidu_serp_api": {"kind": "http_api", "url": "https://github.com/ohblue/baidu-serp-api",
              "access": "免key(免登录直取)", "tags": "新闻舆情", "name": "baidu-serp-api"},
    "bing_news_rss": {"kind": "http_api", "url": "tool://bing_news_rss",
              "access": "免登录API(RSS)", "tags": "新闻舆情", "name": "Bing News RSS"},
    "bls": {"kind": "http_api", "url": "https://api.bls.gov/publicAPI/v2/timeseries/data/",
              "access": "免登录API(注册key提额)", "tags": "标准定额/项目数据", "name": "BLS Public Data API"},
    "bts_gov": {"kind": "dataset", "url": "https://www.bts.gov/",
              "access": "免登录API(CKAN)+数据集", "tags": "项目数据/数据集", "name": "BTS(美国交通统计局)"},
    "cc_index_table": {"kind": "http_api", "url": "https://github.com/commoncrawl/cc-index-table",
              "access": "免登录API(Athena/SQL直查)", "tags": "数据集", "name": "cc-index-table"},
    "common_crawl_2": {"kind": "dataset", "url": "tool://common_crawl_2",
              "access": "数据集+免登录索引API", "tags": "数据集", "name": "Common Crawl"},
    "crossref_api": {"kind": "http_api", "url": "tool://crossref_api",
              "access": "免登录API", "tags": "学术专利", "name": "Crossref API"},
    "crossref_rest_api": {"kind": "http_api", "url": "https://api.crossref.org",
              "access": "免登录API(mailto礼貌池提额)", "tags": "学术专利", "name": "Crossref REST API"},
    "data_gov_uk": {"kind": "dataset", "url": "https://data.gov.uk/",
              "access": "免登录API(CKAN)+数据集", "tags": "项目数据/数据集", "name": "data.gov.uk(英国)"},
    "datacite": {"kind": "http_api", "url": "https://api.datacite.org",
              "access": "免登录API", "tags": "数据集", "name": "DataCite API"},
    "ddgr": {"kind": "http_api", "url": "https://github.com/jarun/ddgr",
              "access": "免key CLI(pip/npm)", "tags": "通用网研", "name": "ddgr"},
    "ddgs_duckduckgo_search": {"kind": "http_api", "url": "https://github.com/deedy5/ddgs",
              "access": "免登录API封装", "tags": "通用网研", "name": "ddgs (duckduckgo_search 换代版)"},
    "doaj_api": {"kind": "http_api", "url": "https://doaj.org/api",
              "access": "免登录API", "tags": "学术专利", "name": "DOAJ API"},
    "dryad": {"kind": "http_api", "url": "https://datadryad.org/api/v2",
              "access": "免登录API", "tags": "数据集", "name": "Dryad API"},
    "duckduckgo_html_lite_instant_answer_api": {"kind": "http_api", "url": "tool://duckduckgo_html_lite_instant_answer_api",
              "access": "免登录网页(html/lite端点可脚本化)；Instant Answer API免登录", "tags": "通用网研", "name": "DuckDuckGo(含html/lite与Instant Answer API)"},
    "emsc_seismic_portal": {"kind": "http_api", "url": "https://www.seismicportal.eu/",
              "access": "免登录API(FDSN)", "tags": "新闻舆情/数据集", "name": "EMSC Seismic Portal"},
    "europe_pmc_rest_api": {"kind": "http_api", "url": "https://www.ebi.ac.uk/europepmc/webservices/rest",
              "access": "免登录API", "tags": "学术专利", "name": "Europe PMC REST API"},
    "eurostat": {"kind": "http_api", "url": "https://ec.europa.eu/eurostat/api/dissemination/statistics/1.0/data/",
              "access": "免登录API", "tags": "标准定额/项目数据", "name": "Eurostat API"},
    "gadm": {"kind": "dataset", "url": "https://gadm.org/",
              "access": "数据集(免登录下载)", "tags": "学术专利/数据集", "name": "GADM"},
    "gdacs": {"kind": "http_api", "url": "https://www.gdacs.org/",
              "access": "免登录API/RSS", "tags": "新闻舆情/数据集", "name": "GDACS"},
    "gdelt_2_0_doc_api": {"kind": "http_api", "url": "https://api.gdeltproject.org",
              "access": "免登录API", "tags": "新闻舆情", "name": "GDELT 2.0 Doc API"},
    "gdelt_doc_2_0_api": {"kind": "http_api", "url": "tool://gdelt_doc_2_0_api",
              "access": "免登录API", "tags": "新闻舆情", "name": "GDELT DOC 2.0 API"},
    "global_dam_watch_grand": {"kind": "dataset", "url": "https://globaldamwatch.org/",
              "access": "数据集(免登录下载)", "tags": "项目数据/数据集", "name": "Global Dam Watch/GRanD"},
    "google_news_rss": {"kind": "http_api", "url": "https://news.google.com/rss",
              "access": "免登录API(RSS)", "tags": "新闻舆情", "name": "Google News RSS"},
    "google_news_rss_2": {"kind": "http_api", "url": "tool://google_news_rss_2",
              "access": "免登录API(RSS)", "tags": "新闻舆情", "name": "Google News RSS"},
    "google_open_buildings": {"kind": "dataset", "url": "https://sites.research.google/open-buildings/",
              "access": "数据集(GCS免登录下载)", "tags": "项目数据/数据集", "name": "Google Open Buildings"},
    "googler": {"kind": "http_api", "url": "https://github.com/jarun/googler",
              "access": "免key CLI(pip/npm)", "tags": "标准定额", "name": "googler"},
    "hdx_humanitarian_data_exchange": {"kind": "dataset", "url": "https://data.humdata.org/",
              "access": "免登录API+数据集", "tags": "项目数据/数据集", "name": "HDX(Humanitarian Data Exchange)"},
    "hn_algolia_api": {"kind": "http_api", "url": "tool://hn_algolia_api",
              "access": "免登录API", "tags": "新闻舆情", "name": "HN Algolia API"},
    "hn_cli": {"kind": "http_api", "url": "https://github.com/heartleo/hn-cli",
              "access": "免key CLI(pip/npm)", "tags": "通用网研", "name": "hn-cli"},
    "howdoi": {"kind": "http_api", "url": "https://github.com/gleitz/howdoi",
              "access": "免key CLI(pip/npm)", "tags": "通用网研", "name": "howdoi"},
    "hf_datasets": {"kind": "dataset", "url": "https://huggingface.co/api/datasets",
              "access": "免登录API(部分下载需登录)", "tags": "数据集", "name": "HuggingFace Datasets API"},
    "huggingface_hub_api": {"kind": "http_api", "url": "tool://huggingface_hub_api",
              "access": "免登录API(限速)", "tags": "数据集", "name": "HuggingFace Hub API"},
    "imf_datamapper_sdmx": {"kind": "http_api", "url": "https://www.imf.org/external/datamapper/api/v1/",
              "access": "免登录API(官方)", "tags": "项目数据", "name": "IMF DataMapper + SDMX"},
    "inform_risk_index": {"kind": "dataset", "url": "https://drmkc.jrc.ec.europa.eu/inform-index",
              "access": "数据集(免登录下载)", "tags": "数据集", "name": "INFORM Risk Index"},
    "internet_archive": {"kind": "http_api", "url": "tool://internet_archive",
              "access": "免登录网页/子库检索API", "tags": "学术专利/项目数据", "name": "Internet Archive"},
    "marginalia_search_2": {"kind": "http_api", "url": "https://github.com/MarginaliaSearch/MarginaliaSearch",
              "access": "免登录API(marginalia.com/public API)", "tags": "通用网研", "name": "Marginalia Search"},
    "mwmbl": {"kind": "http_api", "url": "https://github.com/mwmbl/mwmbl",
              "access": "免登录API(mwmbl.org)", "tags": "通用网研", "name": "mwmbl"},
    "nist": {"kind": "dataset", "url": "https://www.nist.gov",
              "access": "免登录PDF直下", "tags": "标准定额", "name": "NIST Technical Series Publications"},
    "noaa_ncei": {"kind": "dataset", "url": "https://www.ncei.noaa.gov/",
              "access": "免登录API+数据集", "tags": "数据集", "name": "NOAA NCEI"},
    "oecd_data_explorer": {"kind": "dataset", "url": "https://data-explorer.oecd.org/",
              "access": "免登录API(SDMX)+数据集", "tags": "标准定额/工商招投标/项目数据/数据集", "name": "OECD Data Explorer"},
    "oecd_data_explorer_sdmx": {"kind": "http_api", "url": "https://sdmx.oecd.org/public/rest/",
              "access": "免登录API(匿名限额)", "tags": "学术专利/项目数据", "name": "OECD Data Explorer SDMX"},
    "ofac_sdn": {"kind": "dataset", "url": "https://www.treasury.gov/ofac/downloads/sdn.csv",
              "access": "免登录API(数据集csv直下)", "tags": "数据集", "name": "OFAC SDN 制裁名单(海外合规尽调底线证据)"},
    "opec_momr": {"kind": "dataset", "url": "https://www.opec.org/",
              "access": "免费页面(PDF直下)", "tags": "通用网研", "name": "OPEC月报(MOMR)"},
    "opendi": {"kind": "dataset", "url": "https://data.open-contracting.org",
              "access": "数据集+免登录", "tags": "工商招投标/项目数据", "name": "Open Contracting Data Registry"},
    "open_ownership_register": {"kind": "dataset", "url": "https://www.openownership.org",
              "access": "免费数据集下载+免登录网页(免费); register API直连000待验", "tags": "通用网研", "name": "Open Ownership Register"},
    "openaire_search_api": {"kind": "http_api", "url": "https://api.openaire.eu/search",
              "access": "免登录API", "tags": "学术专利/项目数据", "name": "OpenAIRE Search API"},
    "openalex": {"kind": "http_api", "url": "tool://openalex",
              "access": "免登录API(可选mailto进礼貌池)", "tags": "学术专利", "name": "OpenAlex"},
    "openfema": {"kind": "http_api", "url": "https://www.fema.gov/openfema",
              "access": "免登录API", "tags": "项目数据/数据集", "name": "OpenFEMA"},
    "openstreetmap": {"kind": "dataset", "url": "https://www.openstreetmap.org",
              "access": "免登录API(Overpass)+数据集(全量dump)", "tags": "标准定额/项目数据/数据集", "name": "OpenStreetMap"},
    "openstreetmap_overpass_api": {"kind": "http_api", "url": "https://overpass-api.de",
              "access": "免登录API(多镜像)", "tags": "数据集", "name": "OpenStreetMap Overpass API"},
    "openverse": {"kind": "http_api", "url": "https://github.com/WordPress/openverse",
              "access": "免登录API(openverse.org)", "tags": "数据集", "name": "Openverse"},
    "openverse_2": {"kind": "http_api", "url": "tool://openverse_2",
              "access": "免登录API(限速;可选key提额)", "tags": "数据集", "name": "Openverse"},
    "our_world_in_data": {"kind": "dataset", "url": "https://ourworldindata.org",
              "access": "数据集+免登录CSV", "tags": "数据集", "name": "Our World in Data"},
    "ourairports": {"kind": "dataset", "url": "https://ourairports.com/data/",
              "access": "数据集(免登录CSV)", "tags": "项目数据/数据集", "name": "OurAirports"},
    "overture_maps_foundation": {"kind": "dataset", "url": "https://overturemaps.org/",
              "access": "数据集(S3/Azure免登录下载)", "tags": "项目数据/数据集", "name": "Overture Maps Foundation"},
    "prozorro": {"kind": "dataset", "url": "https://prozorro.gov.ua/",
              "access": "免登录API+数据集", "tags": "工商招投标/项目数据", "name": "ProZorro"},
    "python_baidusearch_pypi_baidusearch": {"kind": "http_api", "url": "https://github.com/amazingcoderpro/python-baidusearch",
              "access": "免key库(零依赖)", "tags": "新闻舆情", "name": "python-baidusearch (PyPI baidusearch)"},
    "re3data": {"kind": "http_api", "url": "https://www.re3data.org",
              "access": "免登录API", "tags": "数据集", "name": "re3data API"},
    "reddit_json": {"kind": "http_api", "url": "tool://reddit_json",
              "access": "免登录API(限流严;出口敏感)", "tags": "新闻舆情", "name": "Reddit搜索JSON"},
    "reliefweb_api": {"kind": "http_api", "url": "https://reliefweb.int/",
              "access": "免登录API", "tags": "新闻舆情/项目数据", "name": "ReliefWeb API"},
    "zquestz_s": {"kind": "http_api", "url": "https://github.com/zquestz/s",
              "access": "免key CLI(pip/npm)", "tags": "通用网研", "name": "s"},
    "searx_space": {"kind": "http_api", "url": "https://github.com/searxng/searx-space",
              "access": "免登录API(instances.searx.space)", "tags": "数据集", "name": "searx-space"},
    "searxng_cli": {"kind": "http_api", "url": "https://github.com/Suknna/searxng-cli",
              "access": "免key CLI(pip/npm)", "tags": "通用网研", "name": "searxng-cli"},
    "sec_edgar": {"kind": "http_api", "url": "https://efts.sec.gov/LATEST/search-index",
              "access": "免登录API(全文检索+submissions JSON, 需声明UA, 实测200)", "tags": "通用网研", "name": "SEC EDGAR"},
    "semantic_scholar_api": {"kind": "http_api", "url": "tool://semantic_scholar_api",
              "access": "免登录API(限速;免费key提额)", "tags": "学术专利", "name": "Semantic Scholar API"},
    "samtay_so": {"kind": "http_api", "url": "https://github.com/samtay/so",
              "access": "免key CLI(pip/npm)", "tags": "通用网研", "name": "so"},
    "stackexchange_api_stack_overflow": {"kind": "http_api", "url": "tool://stackexchange_api_stack_overflow",
              "access": "免登录API(有匿名配额;key免费提额)", "tags": "标准定额", "name": "StackExchange API(含Stack Overflow)"},
    "storm_hosted": {"kind": "http_api", "url": "https://storm.genie.stanford.edu/",
              "access": "免登录网页", "tags": "学术专利", "name": "STORM hosted"},
    "surfraw": {"kind": "http_api", "url": "https://gitlab.com/surfraw/Surfraw",
              "access": "免key CLI(pip/npm)", "tags": "通用网研", "name": "surfraw"},
    "tarzi": {"kind": "http_api", "url": "https://github.com/mirasoth/tarzi",
              "access": "免key库(Rust,API-free多引擎)", "tags": "通用网研", "name": "tarzi"},
    "unpaywall_api": {"kind": "http_api", "url": "https://api.unpaywall.org",
              "access": "免登录API(仅需email参数)", "tags": "学术专利", "name": "Unpaywall API"},
    "usaspending": {"kind": "http_api", "url": "https://api.usaspending.gov",
              "access": "免登录API", "tags": "项目数据", "name": "USAspending API"},
    "usgs_earthquake_api": {"kind": "http_api", "url": "https://earthquake.usgs.gov/fdsnws/event/1/",
              "access": "免登录API", "tags": "项目数据/数据集", "name": "USGS Earthquake API"},
    "usgs_nwis": {"kind": "http_api", "url": "https://waterdata.usgs.gov/nwis",
              "access": "免登录API", "tags": "新闻舆情/项目数据/数据集", "name": "USGS NWIS"},
    "wayback_machine_api": {"kind": "http_api", "url": "https://web.archive.org/",
              "access": "免登录API", "tags": "新闻舆情/工商招投标", "name": "Wayback Machine API"},
    "wayback_machine_cdx_api": {"kind": "http_api", "url": "tool://wayback_machine_cdx_api",
              "access": "免登录API", "tags": "项目数据", "name": "Wayback Machine CDX API"},
    "wayback_machine_downloader": {"kind": "http_api", "url": "https://github.com/hartator/wayback-machine-downloader",
              "access": "免key CLI(gem)", "tags": "数据集", "name": "wayback-machine-downloader"},
    "wechat_article_search": {"kind": "http_api", "url": "https://github.com/zjp1997720/wechat-article-search",
              "access": "免key CLI", "tags": "新闻舆情", "name": "wechat-article-search"},
    "wechatsogou": {"kind": "http_api", "url": "https://github.com/chyroc/WechatSogou",
              "access": "免key库(pip,代码冻结2021)", "tags": "新闻舆情", "name": "WechatSogou"},
    "wiby": {"kind": "http_api", "url": "tool://wiby",
              "access": "免登录API(wiby.me/json/)", "tags": "数据集", "name": "Wiby"},
    "wiki_tui": {"kind": "http_api", "url": "https://github.com/Builditluc/wiki-tui",
              "access": "免key CLI(pip/npm)", "tags": "通用网研", "name": "wiki-tui"},
    "wikidata": {"kind": "http_api", "url": "https://www.wikidata.org",
              "access": "免登录API+SPARQL", "tags": "标准定额/数据集", "name": "Wikidata API"},
    "wikidata_sparql": {"kind": "http_api", "url": "tool://wikidata_sparql",
              "access": "免登录API", "tags": "项目数据", "name": "Wikidata SPARQL"},
    "wikipedia_api": {"kind": "http_api", "url": "tool://wikipedia_api",
              "access": "免登录API", "tags": "标准定额", "name": "Wikipedia API(中英等多语言)"},
    "world_bank_open_data": {"kind": "http_api", "url": "https://data.worldbank.org/",
              "access": "免登录API", "tags": "项目数据/数据集", "name": "World Bank Open Data"},
    "worldbank": {"kind": "http_api", "url": "https://api.worldbank.org/v2",
              "access": "免登录API", "tags": "项目数据", "name": "World Bank Open Data API"},
    "world_bank_ppi_database": {"kind": "dataset", "url": "https://ppi.worldbank.org/",
              "access": "数据集(免登录下载)", "tags": "项目数据", "name": "World Bank PPI Database"},
    "world_bank_projects_operations": {"kind": "http_api", "url": "https://projects.worldbank.org/",
              "access": "免登录API", "tags": "工商招投标/项目数据", "name": "World Bank Projects & Operations"},
    "worldbank_projects": {"kind": "http_api", "url": "https://search.worldbank.org/api/v2/projects",
              "access": "免登录API", "tags": "工商招投标/项目数据", "name": "World Bank Projects & Operations API"},
    "zenodo": {"kind": "http_api", "url": "https://zenodo.org/api",
              "access": "免登录API", "tags": "数据集", "name": "Zenodo API"},
    "zh_search_pro": {"kind": "http_api", "url": "tool://zh_search_pro",
              "access": "本仓技能(免登录URL模板)", "tags": "标准定额/新闻舆情", "name": "zh-search-pro(本仓技能资产)"},
    "sse_com_cn": {"kind": "http_api", "url": "https://www.sse.com.cn",
              "access": "免登录API(query.sse.com.cn JSON+Referer头, 实测200)+网页", "tags": "项目数据", "name": "上海证券交易所"},
    "miga": {"kind": "dataset", "url": "https://www.miga.org/",
              "access": "免费页面(出版物直下)", "tags": "通用网研", "name": "世行MIGA政治风险出版物"},
    "ccgp_gov_cn": {"kind": "http_api", "url": "http://www.ccgp.gov.cn",
              "access": "免登录检索(search.ccgp.gov.cn POST端点实测200, 无key)", "tags": "工商招投标", "name": "中国政府采购网"},
    "mofcom_gov_cn": {"kind": "dataset", "url": "https://www.mofcom.gov.cn/",
              "access": "免费页面(PDF直下)", "tags": "通用网研", "name": "商务部《对外投资合作国别(地区)指南》"},
    "94_85_orchestrator_py_manifest": {"kind": "http_api", "url": "https://github.com/(Auto_Manus/epc49_registry_night.py)",
              "access": "免登录API(纯HTTP夜扫)", "tags": "标准定额/学术专利/工商招投标/项目数据", "name": "工厂渠道注册表(94模块/85源渠道, orchestrator.py manifest驱动)"},
    "cninfo_com_cn": {"kind": "http_api", "url": "http://www.cninfo.com.cn",
              "access": "免登录API(POST /new/hisAnnouncement/query 实测200)+免登", "tags": "通用网研", "name": "巨潮资讯网"},
    "02_70": {"kind": "http_api", "url": "tool://02_70",
              "access": "免登录API(多腿聚合)", "tags": "新闻舆情", "name": "开放网络泛搜线(战场落点 02 初次网络调研/70_开放网络)"},
    "sogou_com": {"kind": "http_api", "url": "tool://sogou_com",
              "access": "免登录网页(微信垂直已复刻API化)", "tags": "新闻舆情", "name": "搜狗(含微信垂直)"},
    "szse_cn": {"kind": "http_api", "url": "https://www.szse.cn",
              "access": "免登录API(/api/report/ShowReport实测200)+网页", "tags": "项目数据", "name": "深圳证券交易所"},
    "github_com": {"kind": "http_api", "url": "https://github.com/Auto-Manus",
              "access": "免登录API(自研爬虫)", "tags": "项目数据", "name": "深网官网爬虫线"},
    "baidu_com": {"kind": "http_api", "url": "tool://baidu_com",
              "access": "免登录网页(可HTTP复刻;无公开通用搜索API)", "tags": "标准定额/新闻舆情/项目数据", "name": "百度"},
    # 1026 B级免费钥申领波新增 (channels_survey_2026/btier_freekey_ledger.md 权威台账):
    # 免key面直点7件 + 密钥面1件(headers=运行时读 data/secrets/<渠道>.secret, 永不进仓)。
    "ecb_sdw": {"kind": "http_api", "url": "https://data-api.ecb.europa.eu/service/data",
              "access": "免key官方API(实测26-10-26 direct 200)", "tags": "项目数据", "name": "ECB数据门户 SDW API",
              "secret": "", "headers": "{}"},
    "courtlistener_recap": {"kind": "http_api", "url": "https://www.courtlistener.com/api/rest/v4",
              "access": "匿名面在役(实测200);注册即token提额=用户动作", "tags": "通用网研", "name": "CourtListener+RECAP v4 API",
              "secret": "data/secrets/courtlistener.secret", "headers": "Authorization: Token <key>"},
    "nasa_images": {"kind": "http_api", "url": "https://images-api.nasa.gov/search",
              "access": "免key官方API(实测26-10-26 direct 200)", "tags": "项目数据", "name": "NASA Image and Video Library API",
              "secret": "", "headers": "{}"},
    "core_api": {"kind": "http_api", "url": "https://api.core.ac.uk/v3/search/works",
              "access": "匿名面在役(限流);免费key申领=用户动作提额", "tags": "学术专利", "name": "CORE API v3",
              "secret": "data/secrets/core.secret", "headers": "Authorization: Bearer <key>"},
    "open_canada": {"kind": "http_api", "url": "https://open.canada.ca/data/en/api/3/action/package_search",
              "access": "免key开放数据API(实测26-10-26 direct 200)", "tags": "工商招投标/项目数据", "name": "Open Canada 开放数据 API",
              "secret": "", "headers": "{}"},
    "compras_gov_br_pncp": {"kind": "http_api", "url": "https://pncp.gov.br/api/consulta/v1/atas",
              "access": "免key开放API(实测200, tamanhoPagina=10门槛)", "tags": "工商招投标/项目数据", "name": "Compras.gov.br PNCP API (巴西)",
              "secret": "", "headers": "{}"},
    "noaa_nws": {"kind": "http_api", "url": "https://api.weather.gov/alerts/active",
              "access": "免key官方API(实测26-10-26 direct 200; ncei检索面400停用疑)", "tags": "项目数据/数据集", "name": "NOAA NWS API",
              "secret": "", "headers": "{}"},
    "web_search_pro": {"kind": "http_api", "url": "https://open.bigmodel.cn/api/paas/v4/tools",
              "access": "密钥面: zhipu.secret双账号(api_key=1113余额不足, api_key_2=200但search_result恒空, SDK+裸HTTP复测) → 待用户动作开通资源包", "tags": "新闻舆情", "name": "智谱 web_search_pro",
              "secret": "data/secrets/web_search_pro.secret (或复用 zhipu.secret)", "headers": "Authorization: Bearer <key>; body={model:web-search-pro}"},
    # 1026 B级免费钥申领波·第2轮 (btier_freekey_ledger.md ⑤节; 密钥运行时读secret文件, 永不进仓):
    "us_census_api": {"kind": "http_api", "url": "https://api.census.gov/data",
              "access": "密钥面(1026申领成功; key实测Invalid Key=配额延迟待复测)", "tags": "标准定额/项目数据", "name": "US Census Bureau Data API",
              "secret": "data/secrets/us_census.secret", "headers": "{}", "params": '{"key": "<key>"}'},
    "nasa_firms": {"kind": "http_api", "url": "https://firms.modaps.eosdis.nasa.gov/mapserver",
              "access": "MAP_KEY密钥面(1026申领+status实测5000交易/10分钟)", "tags": "项目数据", "name": "NASA FIRMS WMS/area API",
              "secret": "data/secrets/nasa_firms.secret", "headers": "{}", "params": '{"MAP_KEY": "<key>"}'},
    "gnews": {"kind": "http_api", "url": "https://gnews.io/api/v4",
              "access": "免费层key 100req/天(1026申领+冒烟200命中3篇)", "tags": "新闻舆情", "name": "GNews API",
              "secret": "data/secrets/gnews.secret", "headers": "{}", "params": '{"apikey": "<key>"}'},
    "tavily": {"kind": "http_api", "url": "https://api.tavily.com/search",
              "access": "免费层key 1000积分/月(1026申领+冒烟200命中3条)", "tags": "通用网研", "name": "Tavily Search API",
              "secret": "data/secrets/tavily.secret", "headers": "{}", "body": '{"api_key": "<key>", "query": "<q>"}'},
}

_mod_cache: dict[str, object] = {}


def load(name: str):
    """按名加载复刻件模块 (路径导入, 零修改; 缓存复用)。缺件/依赖缺 → 抛 RuntimeError。"""
    if name in _mod_cache:
        return _mod_cache[name]
    path = REPLICAS.get(name)
    if path is None:
        raise RuntimeError(f"未知复刻件: {name!r} (合法={sorted(REPLICAS)})")
    if not path.is_file():
        raise RuntimeError(f"复刻件缺失: {path}")
    # metaso_api.py import 期 curl_cffi 缺失会 sys.exit → 预检 (SystemExit 不入 except Exception)
    if name == "metaso":
        try:
            import curl_cffi  # noqa: F401
        except ImportError as e:
            raise RuntimeError(f"复刻件依赖缺: curl_cffi ({e})")
    spec = importlib.util.spec_from_file_location(f"api_replica_{name}", path)
    if spec is None or spec.loader is None:
        raise RuntimeError(f"复刻件加载失败: {path}")
    mod = importlib.util.module_from_spec(spec)
    sys.modules[spec.name] = mod                     # dataclass 需 sys.modules 可寻址
    try:
        spec.loader.exec_module(mod)
    except SystemExit as e:                          # 复刻件 import 期自检失败如实抛
        sys.modules.pop(spec.name, None)
        raise RuntimeError(f"复刻件 import 期退出: {e}")
    except BaseException:
        sys.modules.pop(spec.name, None)
        raise
    _mod_cache[name] = mod
    return mod


def resolve_ledger(ledger: str | Path | None = None,
                   campaign: str | None = None) -> Path | None:
    """台账路径解析: 显式 > env > campaign 池 > None(不落盘)。"""
    if ledger:
        return Path(ledger)
    env = os.environ.get("RF_API_INVOCATION_LEDGER", "").strip()
    if env:
        return Path(env)
    if campaign:
        return AMMO_ROOT / campaign / "channel_invocations.jsonl"
    return None


def append_invocation(channel: str, tool: str, queries: str,
                      yld: str, note: str = "",
                      *, campaign: str | None = None,
                      ledger: str | Path | None = None) -> bool:
    """API 路径成功 → 台账追加一行 {channel,ts,tool,queries,yield,note} (只增)。

    tool 由调用方给 (本层不越权编造), 惯例前缀 ``api_replica:``。"""
    row = {"channel": channel, "ts": time.strftime("%Y-%m-%d %H:%M:%S"),
           "tool": tool, "queries": queries, "yield": yld,
           "note": note or "api_replica 路径 (1024 API优先令)"}
    lp = resolve_ledger(ledger, campaign)
    if lp is None:
        print(f"[api_replica] 台账未寻址(无 campaign/env), 仅打印: {json.dumps(row, ensure_ascii=False)}")
        return False
    try:
        lp.parent.mkdir(parents=True, exist_ok=True)
        with lp.open("a", encoding="utf-8") as fh:
            fh.write(json.dumps(row, ensure_ascii=False) + "\n")
        return True
    except OSError as e:
        print(f"[api_replica] 台账写失败({lp}): {type(e).__name__}: {e}")
        return False
