# -*- coding: utf-8 -*-
"""C 轴传感器 channel_matrix 渠道×主题命中矩阵 (T-007E / REQ-020 & REQ-029 前半 /
KB-COMPLETENESS-SPEC C 轴).

REQ-029 前半: 当渠道×主题命中矩阵检测到未命中渠道时 → miss_list + 新建队列判定;
建渠执行器(SOP 四步法)是 T-015 的活, 本件只做传感器, 不建渠不写队列。

在役渠道清单 (分母): `ResearchFactory-Eng/channel_manifest.json` 的 named_channels
(实测 28 个)。读不到时 fail-soft: 分母退化 = 池 by_engine 已见引擎清单(全命中,
近似口径, 输出标 fail_soft=true)。

命中账 (分子): `ammo_pool/<战役>/pool_state.json` 的 by_engine 引擎→字符账。
引擎→渠道映射 (内置映射表, 全部近似已注明):
  1. 直接命中: 引擎标签含渠道 id/别名/中文名 (最长别名优先, 防止 `ima` 误吞
     `ima_public` 这类包含式别名);
  2. 前缀基名: `cross:*` / `rss:*` 段取基名查 BASE_TO_CHANNEL 表 ——
     wechat_rss → 微信生态 ≈ 搜狗微信(sougo), rss → RSS 常年收割(rss_fleet 族,
     named 渠道无对应不点亮), academic_en/arxiv/patents → 学术/专利缺口(留给 T-015);
  3. 个别整标签/前缀近似: search:web ≈ WebSearch, stock:* ≈ 存量语料库 等, 注明近似。

green = miss_list 空 或 miss_list 全部已在新建队列
`ammo_pool/<战役>/completeness/C_axis_queue.json`(KB 口径 [{"name","sop_step"}],
也兼容纯字符串; 文件缺席 → 队列空, 有 miss 即红)。

双产物落盘 (真实池/清单只读, 只写评估产物):
  1. `ammo_pool/<战役>/completeness/C_axis.json` — 完备性账本 C 轴节
  2. `ammo_pool/<战役>/channel_matrix.json` — taskgraph T-007E verify 权威件(同载荷镜像)

CLI:
  py reforge_factory/completeness/channel_matrix.py <战役> [--ammo-root DIR]
      [--manifest PATH] [--dry-run]
"""
from __future__ import annotations

import argparse
import json
import sys
from datetime import datetime, timezone
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[2]
DEFAULT_AMMO_ROOT = REPO_ROOT / "ammo_pool"
DEFAULT_MANIFEST_PATH = REPO_ROOT / "ResearchFactory-Eng" / "channel_manifest.json"
QUEUE_RELPATH = Path("completeness") / "C_axis_queue.json"

SENSOR = "channel_matrix"
AXIS = "C"

#: 渠道别名表 (小写; 渠道 id 与清单 name 会自动并入, 此处只补引擎标签里的变体拼写)。
#: 「最长别名优先」规则处理包含式别名 (ima ⊂ ima_public)。
CHANNEL_ALIASES: dict[str, list[str]] = {
    "manus": ["manus"],
    "sougo": ["sougo", "sogou", "搜狗微信", "微信文章"],
    "metaso": ["metaso", "秘塔"],
    "djyanbao": ["djyanbao", "洞见研报"],
    "website": ["website", "官网"],
    # 1026 记账债修复 (五轴门修④): 视频文稿族含抖音/短视频搜索探针腿
    # (channel_invocations slug=douyin 的 aweme 探针行即本渠调用)。
    "video": ["video", "视频", "douyin", "抖音"],
    "ima": ["ima"],
    "ima_public": ["ima_public"],
    "ima_plaza": ["ima_plaza", "ima广场"],
    "samr": ["samr", "std.samr", "国标公开系统"],
    "weread": ["weread", "微信读书"],
    "lark": ["lark", "feishu", "飞书"],
    "wechat_local": ["wechat_local", "微信本地"],
    "wechat4": ["wechat4", "微信4"],
    "browser360": ["browser360", "360浏览器"],
    "localfiles": ["localfiles", "本地文件"],
    "websearch": ["websearch"],
    "court": ["court", "wenshu", "涉诉", "裁判文书"],
    "cnki": ["cnki", "知网", "wenchuanyun"],
    "corpus_stores": ["corpus_stores", "存量语料"],
    "govlist": ["govlist", "政府名录", "company_info"],
    "eoscar": ["eoscar", "e-oscar"],
    "cli_stack": ["cli_stack"],
    "pansou": ["pansou", "网盘聚合"],
    "chinatextbook": ["chinatextbook", "教材语料"],
    # 1024 记账债修复: zsp_web_full = 免key中文多引擎检索的网页全文腿
    # (zh_search_pro 同族, zsp 前缀), 原表漏映射。
    "zh_search_pro": ["zh_search_pro", "zhsearchpro", "免key中文",
                      "zsp", "zsp_web_full"],
    # 1024 记账债修复: 池内实采引擎标签 ebook / ebook216 (EPC-OVERSEAS 电子书
    # 两腿实采) 直接命中别名 — 原表只有 ebook_library/ebook_treasure, 裸标签
    # "ebook"/"ebook216" 漏映射 (与 BASE_TO_CHANNEL["ebook"] 同族口径)。
    "ebook_library": ["ebook_library", "电子书渠道", "ebook_treasure",
                      "ebook", "ebook216"],
    "search_library": ["search_library",
                       # 1026 记账债修复 (五轴门修④): webregistry:* 成员引擎
                       # (mwmbl/marginalia/yacy 等) 与调用台账 slug=webregistry
                       # 同属本渠 (原仅 PREFIX_TO_CHANNEL 前缀近似覆盖)。
                       "webregistry"],
    # 1026 记账债修复 (五轴门修④): 调用台账 slug=quark (quark_pan cli.py
    # whoami 探针行) 即本渠账号面调用。
    "quark_pan": ["quark_pan", "夸克网盘", "quark"],
    "anysearch": ["anysearch"],
    "openalex": ["openalex"],
    "semantic_scholar": ["semantic_scholar", "s2"],
    "arxiv": ["arxiv"],
    # 1024 当当专项令: 图书情报渠道直登记 (原仅 BASE_TO_CHANNEL cross:dangdang→ebook_library 近似)
    "dangdang": ["dangdang", "当当图书", "当当"],
    # 1024 metaso-kb 专项令: 秘塔知识库专题独立渠道 (工程行业大脑 25538 件文件面;
    # 匿名检索面已通, 下载面待 owner 凭据修正 — 复刻件 逆向工程/metaso-kb-reverse/)
    "metaso_kb": ["metaso_kb", "秘塔知识库专题", "工程行业大脑"],
    # 1025 渠道整合令: last30days 近30天多源社媒渠道 (reddit/hn/polymarket/
    # github 键less地板), 引擎标签 last30days/l30d 直落本渠
    "last30days": ["last30days", "l30d", "last30", "近30天社媒"],
}


#: ---- 1025 渠道普查纳管令(第二轮·终局调和): MASTER_REGISTRY.json
#: A+B级 429 条全量登记 (调和终态 by_tier_all A=195/B=234, tier_basis 逐条
#: 在案; 第一轮 238 条登记 22:16 被回滚, 本轮含其等价恢复+新判增量)。
#: .bak=completeness/channel_matrix.pre-survey1025.bak。
#: id=注册表条目slug(停用词/短名防护; 已建腿15条用腿引擎名覆盖, 见
#: channels_survey_2026/集成台账.md), 别名=slug/域名/gh全名(>=4字符+停用词
#: 过滤, 防短别名误吞引擎标签)。只增不删: 并入存量渠道键时extend不去除原别名。
#: 已知塌缩: 重建致17条原svc聚合条目并入dom:github.com键(单列id github_com,
#: 原判A整体恢复), 拆分留主会话裁定。
#: 登记≠接线: 新渠道进渠道册(named_channels)前不计入 C 轴分母, 建渠走 T-015 SOP。
SURVEY_ALIASES: dict[str, list[str]] = {
    "akshare": ["akshare 开源金融数据库", "github.com", "akfamily/akshare"],  # A级·项目数据·AKShare 开源金融数据库
    "aas_ee_open_websearch": ["aas-ee/open-websearch", "github.com"],  # A级·通用网研·Aas-ee/open-webSearch
    "aiddata": ["aiddata.org"],  # A级·项目数据/数据集·AidData
    "anysearch_skill": ["anysearch skill", "github.com", "anysearch-ai/anysearch-skill"],  # A级·新闻舆情·AnySearch Skill
    "data_bis_org": ["bis统计门户", "data.bis.org"],  # A级·项目数据·BIS统计门户
    "bls": ["bls public data api", "api.bls.gov"],  # A级·标准定额/项目数据·BLS Public Data API
    "bts_gov": ["bts(美国交通统计局)", "bts.gov"],  # A级·项目数据/数据集·BTS(美国交通统计局)
    "bing_news_rss": ["bing news rss"],  # A级·新闻舆情·Bing News RSS
    "book118_book118_com": ["book118文档库(book118.com)", "book118.com"],  # A级·数据集·Book118文档库(book118.com)
    "b_cc_api": ["b站cc字幕api", "api.bilibili.com"],  # A级·新闻舆情·B站CC字幕API
    "cnki_kns_cnki_net_paperdown": ["cnki 论文（官方线 kns.cnki.net, paperdown 管线）", "kns.cnki.net"],  # A级·学术专利·CNKI 论文（官方线 kns.cnki.net, PaperDown 管线）
    "common_crawl": ["common crawl", "commoncrawl.org"],  # A级·新闻舆情/数据集·Common Crawl
    "common_crawl_2": ["common crawl"],  # A级·数据集·Common Crawl
    "courtlistener_recap": ["courtlistener+recap(美国判例)", "courtlistener.com"],  # A级·通用网研·CourtListener+RECAP(美国判例)
    "crossref_api": ["crossref api"],  # A级·学术专利·Crossref API
    "crossref_rest_api": ["crossref rest api", "api.crossref.org"],  # A级·学术专利·Crossref REST API
    "doaj_api": ["doaj api", "doaj.org"],  # A级·学术专利·DOAJ API
    "dailyhotapi": ["github.com", "imsyy/dailyhotapi"],  # A级·新闻舆情·DailyHotApi
    "damodaran": ["damodaran 数据集目录(估值对标免费基准库)", "pages.stern.nyu.edu"],  # A级·数据集·Damodaran 数据集目录(估值对标免费基准库)
    "datacite": ["datacite api", "api.datacite.org"],  # A级·数据集·DataCite API
    "doc88_doc88_com": ["doc88文档库(doc88.com)", "doc88.com"],  # A级·数据集·Doc88文档库(doc88.com)
    "dryad": ["dryad api", "datadryad.org"],  # A级·数据集·Dryad API
    "duckduckgo_html_lite_instant_answer_api": ["duckduckgo(含html/lite与instant answer api)"],  # A级·通用网研·DuckDuckGo(含html/lite与Instant Answer API)
    "ecb_sdw": ["ecb数据门户(sdw)", "data.ecb.europa.eu"],  # A级·项目数据·ECB数据门户(SDW)
    "emsc_seismic_portal": ["emsc seismic portal", "seismicportal.eu"],  # A级·新闻舆情/数据集·EMSC Seismic Portal
    "enr_enr_com_top_250": ["enr 工程新闻记录(enr.com top 250)"],  # A级·新闻舆情/项目数据·ENR 工程新闻记录(ENR.com Top 250)
    "enr_com": ["enr工程新闻纪录", "enr.com"],  # A级·新闻舆情·ENR工程新闻纪录
    "europe_pmc_rest_api": ["europe pmc rest api", "ebi.ac.uk"],  # A级·学术专利·Europe PMC REST API
    "eurostat": ["eurostat api", "ec.europa.eu"],  # A级·标准定额/项目数据·Eurostat API
    "evilran_baidu_mcp_server": ["evilran/baidu-mcp-server", "github.com"],  # A级·新闻舆情·Evilran/baidu-mcp-server
    "fao_aquastat": ["fao aquastat", "fao.org"],  # A级·项目数据/数据集·FAO AQUASTAT
    "gadm": ["gadm.org"],  # A级·学术专利/数据集·GADM
    "gdacs": ["gdacs.org"],  # A级·新闻舆情/数据集·GDACS
    "gdelt_2_0_doc_api": ["gdelt 2.0 doc api", "api.gdeltproject.org"],  # A级·新闻舆情·GDELT 2.0 Doc API
    "gdelt_doc_2_0_api": ["gdelt doc 2.0 api"],  # A级·新闻舆情·GDELT DOC 2.0 API
    "global_dam_watch_grand": ["global dam watch/grand", "globaldamwatch.org"],  # A级·项目数据/数据集·Global Dam Watch/GRanD
    "google_news_rss": ["google news rss", "news.google.com"],  # A级·新闻舆情·Google News RSS
    "google_news_rss_2": ["google news rss"],  # A级·新闻舆情·Google News RSS
    "google_open_buildings": ["google open buildings", "sites.research.google"],  # A级·项目数据/数据集·Google Open Buildings
    "hdx_humanitarian_data_exchange": ["hdx(humanitarian data exchange)", "data.humdata.org"],  # A级·项目数据/数据集·HDX(Humanitarian Data Exchange)
    "hn_algolia_api": ["hn algolia api"],  # A级·新闻舆情·HN Algolia API
    "hf_datasets": ["huggingface datasets api", "huggingface.co"],  # A级·数据集·HuggingFace Datasets API
    "huggingface_hub_api": ["huggingface hub api"],  # A级·数据集·HuggingFace Hub API
    "imf_datamapper_sdmx": ["imf datamapper + sdmx", "imf.org"],  # A级·项目数据·IMF DataMapper + SDMX
    "inform_risk_index": ["inform risk index", "drmkc.jrc.ec.europa.eu"],  # A级·数据集·INFORM Risk Index
    "internet_archive": ["internet archive"],  # A级·学术专利/项目数据·Internet Archive
    "jina_reader_r_jina_ai_s_jina_ai": ["jina reader (r.jina.ai / s.jina.ai)", "github.com", "jina-ai/reader"],  # A级·通用网研·Jina Reader (r.jina.ai / s.jina.ai)
    "knockoutez_wigolo": ["knockoutez/wigolo", "github.com"],  # A级·通用网研·KnockOutEZ/wigolo
    "manus": ["manus.im"],  # A级·通用网研·Manus
    "marginalia_search": ["marginalia search"],  # A级·通用网研·Marginalia Search
    "marginalia_search_2": ["marginalia search", "github.com", "marginaliasearch/marginaliasearch"],  # A级·通用网研·Marginalia Search
    "microsoft_global_ml_building_footprints": ["microsoft global ml building footprints", "github.com", "microsoft/globalmlbuildingfootprints"],  # A级·项目数据/数据集·Microsoft Global ML Building Footprints
    "nist": ["nist technical series publications", "nist.gov"],  # A级·标准定额·NIST Technical Series Publications
    "noaa_ncei": ["noaa ncei", "ncei.noaa.gov"],  # A级·数据集·NOAA NCEI
    "oecd_data_explorer": ["oecd data explorer", "data-explorer.oecd.org"],  # A级·标准定额/工商招投标/项目数据/数据集·OECD Data Explorer
    "oecd_data_explorer_sdmx": ["oecd data explorer sdmx", "sdmx.oecd.org"],  # A级·学术专利/项目数据·OECD Data Explorer SDMX
    "ofac_sdn": ["ofac sdn 制裁名单(海外合规尽调底线证据)", "treasury.gov"],  # A级·数据集·OFAC SDN 制裁名单(海外合规尽调底线证据)
    "opec_momr": ["opec月报(momr)", "opec.org"],  # A级·通用网研·OPEC月报(MOMR)
    "opendi": ["open contracting data registry", "data.open-contracting.org"],  # A级·工商招投标/项目数据·Open Contracting Data Registry
    "open_ownership_register": ["open ownership register", "openownership.org"],  # A级·通用网研·Open Ownership Register
    "openaire_search_api": ["openaire search api", "api.openaire.eu"],  # A级·学术专利/项目数据·OpenAIRE Search API
    "openalex": [],  # A级·学术专利·OpenAlex
    "openalex_api": ["openalex api", "api.openalex.org"],  # A级·学术专利·OpenAlex API
    "openfema": ["fema.gov"],  # A级·项目数据/数据集·OpenFEMA
    "opensanctions": ["opensanctions.org"],  # A级·项目数据·OpenSanctions
    "openstreetmap": ["openstreetmap.org"],  # A级·标准定额/项目数据/数据集·OpenStreetMap
    "openstreetmap_overpass_api": ["openstreetmap overpass api", "overpass-api.de"],  # A级·数据集·OpenStreetMap Overpass API
    "openverse": ["github.com", "wordpress/openverse"],  # A级·数据集·Openverse
    "openverse_2": ["openverse"],  # A级·数据集·Openverse
    "our_world_in_data": ["our world in data", "ourworldindata.org"],  # A级·数据集·Our World in Data
    "ourairports": ["ourairports.com"],  # A级·项目数据/数据集·OurAirports
    "overture_maps_foundation": ["overture maps foundation", "overturemaps.org"],  # A级·项目数据/数据集·Overture Maps Foundation
    "panjiva": ["panjiva 海关提单(免费层供应链核实)", "panjiva.com"],  # A级·项目数据·Panjiva 海关提单(免费层供应链核实)
    "playwright_mcp": ["playwright mcp", "github.com", "microsoft/playwright-mcp"],  # A级·通用网研·Playwright MCP
    "prozorro": ["prozorro.gov.ua"],  # A级·工商招投标/项目数据·ProZorro
    "pubmed_central_pmc": ["pubmed central (pmc)", "ncbi.nlm.nih.gov"],  # A级·学术专利·PubMed Central (PMC)
    "reddit_json": ["reddit搜索json"],  # A级·新闻舆情·Reddit搜索JSON
    "reliefweb_api": ["reliefweb api", "reliefweb.int"],  # A级·新闻舆情/项目数据·ReliefWeb API
    "sec_edgar": ["sec edgar", "efts.sec.gov"],  # A级·通用网研·SEC EDGAR
    "sec_edgar_2": ["sec edgar 美股披露(国际对标一手源)", "sec.gov"],  # A级·项目数据·SEC EDGAR 美股披露(国际对标一手源)
    "storm_hosted": ["storm hosted", "storm.genie.stanford.edu"],  # A级·学术专利·STORM hosted
    "searxng": ["github.com", "searxng/searxng"],  # A级·新闻舆情·SearXNG
    "searxng_2": ["searxng"],  # A级·标准定额/学术专利/新闻舆情·SearXNG
    "secretiveshell_mcp_searxng": ["secretiveshell/mcp-searxng", "github.com"],  # A级·通用网研·SecretiveShell/MCP-searxng
    "semantic_scholar_api": ["semantic scholar api"],  # A级·学术专利·Semantic Scholar API
    "semantic_scholar_graph_api": ["semantic scholar graph api", "api.semanticscholar.org"],  # A级·学术专利·Semantic Scholar Graph API
    "stackexchange_api_stack_overflow": ["stackexchange api(含stack overflow)"],  # A级·标准定额·StackExchange API(含Stack Overflow)
    "ted_tenders_electronic_daily": ["ted (tenders electronic daily)", "ted.europa.eu"],  # A级·工商招投标/项目数据·TED (Tenders Electronic Daily)
    "un_data_portal": ["un data portal", "data.un.org"],  # A级·项目数据·UN Data Portal
    "unctad_ipm": ["unctad投资政策观察站(ipm)", "investmentpolicy.unctad.org"],  # A级·通用网研·UNCTAD投资政策观察站(IPM)
    "usaspending": ["usaspending api", "api.usaspending.gov"],  # A级·项目数据·USAspending API
    "usgs_earthquake_api": ["usgs earthquake api", "earthquake.usgs.gov"],  # A级·项目数据/数据集·USGS Earthquake API
    "usgs_nwis": ["usgs nwis", "waterdata.usgs.gov"],  # A级·新闻舆情/项目数据/数据集·USGS NWIS
    "unpaywall_api": ["unpaywall api", "api.unpaywall.org"],  # A级·学术专利·Unpaywall API
    "wayback_machine_api": ["wayback machine api", "web.archive.org"],  # A级·新闻舆情/工商招投标·Wayback Machine API
    "wayback_machine_cdx_api": ["wayback machine cdx api"],  # A级·项目数据·Wayback Machine CDX API
    "websearch_claude": ["websearch(claude 内建)"],  # A级·通用网研·WebSearch(Claude 内建)
    "wechatsogou": ["github.com", "chyroc/wechatsogou"],  # A级·新闻舆情·WechatSogou
    "wiby": [],  # A级·数据集·Wiby
    "wikidata": ["wikidata api", "wikidata.org"],  # A级·标准定额/数据集·Wikidata API
    "wikidata_sparql": ["wikidata sparql"],  # A级·项目数据·Wikidata SPARQL
    "wikipedia_api": ["wikipedia api(中英等多语言)"],  # A级·标准定额·Wikipedia API(中英等多语言)
    "world_bank_open_data": ["world bank open data", "data.worldbank.org"],  # A级·项目数据/数据集·World Bank Open Data
    "worldbank": ["world bank open data api", "api.worldbank.org"],  # A级·项目数据·World Bank Open Data API
    "world_bank_ppi_database": ["world bank ppi database", "ppi.worldbank.org"],  # A级·项目数据·World Bank PPI Database
    "world_bank_projects_operations": ["world bank projects & operations", "projects.worldbank.org"],  # A级·工商招投标/项目数据·World Bank Projects & Operations
    "worldbank_projects": ["world bank projects & operations api", "search.worldbank.org"],  # A级·工商招投标/项目数据·World Bank Projects & Operations API
    "yacy": ["github.com", "yacy/yacy_search_server"],  # A级·通用网研·YaCy
    "zenodo": ["zenodo api", "zenodo.org"],  # A级·数据集·Zenodo API
    "agent_search": ["agent-search", "github.com", "brcrusoe72/agent-search"],  # A级·通用网研·agent-search
    "aggregate_search_mcp": ["aggregate-search-mcp", "github.com", "wasd9191/aggregate-search-mcp"],  # A级·新闻舆情·aggregate-search-mcp
    "arxiv_api": ["arxiv api", "export.arxiv.org"],  # A级·学术专利·arXiv API
    "arxiv_py": ["arxiv.py", "github.com", "lukasschwab/arxiv.py"],  # A级·标准定额/学术专利·arxiv.py
    "baidu_serp_api": ["baidu-serp-api", "github.com", "ohblue/baidu-serp-api"],  # A级·新闻舆情·baidu-serp-api
    "cc_index_table": ["cc-index-table", "github.com", "commoncrawl/cc-index-table"],  # A级·数据集·cc-index-table
    "damonwonghv_youtube_search_api": ["damonwonghv/youtube-search-api", "github.com"],  # A级·新闻舆情·damonwonghv/youtube-search-api
    "data_europa_eu": ["data.europa.eu"],  # A级·工商招投标/数据集·data.europa.eu
    "data_gov_uk": ["data.gov.uk(英国)", "data.gov.uk"],  # A级·项目数据/数据集·data.gov.uk(英国)
    "ddgr": ["github.com", "jarun/ddgr"],  # A级·通用网研·ddgr
    "ddgs_duckduckgo_search": ["ddgs (duckduckgo_search 换代版)", "github.com", "deedy5/ddgs"],  # A级·通用网研·ddgs (duckduckgo_search 换代版)
    "efinance": ["efinance 轻量行情财报库", "github.com", "micro-sheep/efinance"],  # A级·项目数据·efinance 轻量行情财报库
    "firecrawl_firecrawl_mcp_server": ["firecrawl/firecrawl-mcp-server", "github.com"],  # A级·通用网研·firecrawl/firecrawl-mcp-server
    "free_search_mcp": ["free-search-mcp", "github.com", "sweetcornna/free-search-mcp"],  # A级·通用网研·free-search-mcp
    "googler": ["github.com", "jarun/googler"],  # A级·标准定额·googler
    "gosom_google_maps_scraper": ["gosom/google-maps-scraper", "github.com"],  # A级·项目数据·gosom/google-maps-scraper
    "hn_cli": ["hn-cli", "github.com", "heartleo/hn-cli"],  # A级·通用网研·hn-cli
    "howdoi": ["github.com", "gleitz/howdoi"],  # A级·通用网研·howdoi
    "ihor_sokoliuk_mcp_searxng": ["ihor-sokoliuk/mcp-searxng", "github.com"],  # A级·标准定额·ihor-sokoliuk/mcp-searxng
    "ima_openapi_skill_kb": ["ima 知识库 (官方 openapi skill, 个人订阅 kb 检索+原文下载)", "ima.qq.com"],  # A级·数据集·ima 知识库 (官方 OpenAPI skill, 个人订阅 KB 检索+原文下载)
    "kituin_picimagesearch": ["kituin/picimagesearch", "github.com"],  # A级·新闻舆情·kitUIN/PicImageSearch
    "last30days_skill": ["last30days-skill", "github.com", "mvanhorn/last30days-skill"],  # A级·新闻舆情·last30days-skill
    "modelcontextprotocol_servers_fetch": ["modelcontextprotocol/servers (官方参考服务器, 含 fetch)", "github.com", "modelcontextprotocol/servers"],  # A级·通用网研·modelcontextprotocol/servers (官方参考服务器, 含 fetch)
    "mrkrsl_web_search_mcp": ["mrkrsl/web-search-mcp", "github.com"],  # A级·通用网研·mrkrsl/web-search-mcp
    "mwmbl": ["github.com", "mwmbl/mwmbl"],  # A级·通用网研·mwmbl
    "nickclyde_duckduckgo_mcp_server": ["nickclyde/duckduckgo-mcp-server", "github.com"],  # A级·通用网研·nickclyde/duckduckgo-mcp-server
    "python_baidusearch_pypi_baidusearch": ["python-baidusearch (pypi baidusearch)", "github.com", "amazingcoderpro/python-baidusearch"],  # A级·新闻舆情·python-baidusearch (PyPI baidusearch)
    "re3data": ["re3data api", "re3data.org"],  # A级·数据集·re3data API
    "zquestz_s": ["github.com", "zquestz/s"],  # A级·通用网研·s
    "sckott_habanero": ["sckott/habanero", "github.com"],  # A级·学术专利·sckott/habanero
    "searx_space": ["searx-space", "github.com", "searxng/searx-space"],  # A级·数据集·searx-space
    "searx_space_2": ["searx.space 实例目录", "searx.space"],  # A级·数据集·searx.space 实例目录
    "searxng_cli": ["searxng-cli", "github.com", "suknna/searxng-cli"],  # A级·通用网研·searxng-cli
    "samtay_so": ["github.com", "samtay/so"],  # A级·通用网研·so
    "sogou_weixin_mcp_server": ["sogou-weixin-mcp-server", "github.com", "ptbsare/sogou-weixin-mcp-server"],  # A级·新闻舆情·sogou-weixin-mcp-server
    "surfraw": ["gitlab.com", "surfraw/surfraw"],  # A级·通用网研·surfraw
    "tarzi": ["github.com", "mirasoth/tarzi"],  # A级·通用网研·tarzi
    "wayback_machine_downloader": ["wayback-machine-downloader", "github.com", "hartator/wayback-machine-downloader"],  # A级·数据集·wayback-machine-downloader
    "wechat_article_search": ["wechat-article-search", "github.com", "zjp1997720/wechat-article-search"],  # A级·新闻舆情·wechat-article-search
    "wiki_tui": ["wiki-tui", "github.com", "builditluc/wiki-tui"],  # A级·通用网研·wiki-tui
    "xorsoft": ["xorsoft web search (search.xorsoft.dev)", "search.xorsoft.dev"],  # A级·通用网研·xorsoft web search (search.xorsoft.dev)
    "zh_search_pro": ["zh-search-pro(本仓技能资产)"],  # A级·标准定额/新闻舆情·zh-search-pro(本仓技能资产)
    "shfe_com_cn": ["上期所日行情与持仓", "shfe.com.cn"],  # A级·通用网研·上期所日行情与持仓
    "data_sh_gov_cn": ["上海公共数据开放平台", "data.sh.gov.cn"],  # A级·项目数据/数据集·上海公共数据开放平台
    "sse_com_cn": ["上海证券交易所", "sse.com.cn"],  # A级·项目数据·上海证券交易所
    "miga": ["世行miga政治风险出版物", "miga.org"],  # A级·通用网研·世行MIGA政治风险出版物
    "yield_chinabond_com_cn": ["中债·中国债券信息网公开面", "yield.chinabond.com.cn"],  # A级·通用网研·中债·中国债券信息网公开面
    "chinca": ["中国对外承包工程商会(chinca)", "chinca.org"],  # A级·项目数据·中国对外承包工程商会(CHINCA)
    "ccgp_gov_cn": ["中国政府采购网", "ccgp.gov.cn"],  # A级·工商招投标·中国政府采购网
    "wenshu_court_gov_cn": ["中国裁判文书网", "wenshu.court.gov.cn"],  # A级·通用网研·中国裁判文书网
    "ebook_treasure_chest_24_071_1000": ["中文电子书书单渠道 (ebook-treasure-chest 24,071本/1000类目)", "github.com", "jbiaojerry/ebook-treasure-chest"],  # A级·数据集·中文电子书书单渠道 (ebook-treasure-chest 24,071本/1000类目)
    "cffex_com_cn": ["中金所日统计", "cffex.com.cn"],  # A级·项目数据·中金所日统计
    "key_zh_search_pro": ["免key中文多引擎检索(zh-search-pro)", "github.com", "careytian-ai/zh-search-pro"],  # A级·通用网研·免key中文多引擎检索(zh-search-pro)
    "tapxworld_chinatextbook_43_5gb_2087": ["全套教材语料库 (tapxworld/chinatextbook 43.5gb/2087册)", "github.com", "tapxworld/chinatextbook"],  # A级·数据集·全套教材语料库 (TapXWorld/ChinaTextbook 43.5GB/2087册)
    "mofcom_gov_cn": ["商务部《对外投资合作国别(地区)指南》", "mofcom.gov.cn"],  # A级·通用网研·商务部《对外投资合作国别(地区)指南》
    "xique_com": ["喜鹊ai投标助手(千里马系标讯)", "xique.com"],  # A级·工商招投标/项目数据·喜鹊AI投标助手(千里马系标讯)
    "std_samr_gov_cn": ["国家标准全文公开系统(std.samr.gov.cn)", "openstd.samr.gov.cn"],  # A级·标准定额·国家标准全文公开系统(std.samr.gov.cn)
    "gb_gb_t_ebiaozhun": ["国标 gb/gb/t 情报渠道 (ebiaozhun 免登录链)", "ebiaozhun.com"],  # A级·标准定额·国标 GB/GB/T 情报渠道 (eBiaozhun 免登录链)
    "dce_com_cn": ["大商所日行情与持仓", "dce.com.cn"],  # A级·通用网研·大商所日行情与持仓
    "pan_quark_cn": ["夸克网盘账号面", "pan.quark.cn"],  # A级·数据集·夸克网盘账号面
    "04": ["存量语料库(04智库/网盘本地存量/自建库)"],  # A级·数据集·存量语料库(04智库/网盘本地存量/自建库)
    "94_85_orchestrator_py_manifest": ["工厂渠道注册表(94模块/85源渠道, orchestrator.py manifest驱动)", "github.com", "(auto_manus/epc49_registry_night.py)"],  # A级·标准定额/学术专利/工商招投标/项目数据·工厂渠道注册表(94模块/85源渠道, orchestrator.py manifest驱动)
    "cninfo_com_cn": ["cninfo.com.cn"],  # A级·通用网研·巨潮资讯网
    "02_70": ["开放网络泛搜线(战场落点 02 初次网络调研/70_开放网络)"],  # A级·新闻舆情·开放网络泛搜线(战场落点 02 初次网络调研/70_开放网络)
    "book_dangdang_com": ["当当图书(书目情报: 题录/简介/目录框架)", "book.dangdang.com"],  # A级·数据集·当当图书(书目情报: 题录/简介/目录框架)
    "pc_4_1_15": ["微信pc 4.1.15(本地库)", "weixin.qq.com"],  # A级·新闻舆情·微信PC 4.1.15(本地库)
    "weread_qq_com": ["weread.qq.com"],  # A级·数据集·微信读书
    "sogou_com": ["搜狗(含微信垂直)"],  # A级·新闻舆情·搜狗(含微信垂直)
    "weixin_sogou_com": ["weixin.sogou.com"],  # A级·新闻舆情·搜狗微信
    "pdf_wxy88_top_ccki_top_kns8": ["文献云知网镜像全文pdf (wxy88.top → ccki.top kns8 新面)", "wxy88.top"],  # A级·学术专利·文献云知网镜像全文PDF (wxy88.top → ccki.top KNS8 新面)
    "hq_sinajs_cn": ["新浪财经行情接口(非官方公开)", "hq.sinajs.cn"],  # A级·通用网研·新浪财经行情接口(非官方公开)
    "djyanbao_com": ["djyanbao.com"],  # A级·新闻舆情/数据集·洞见研报
    "szse_cn": ["深圳证券交易所", "szse.cn"],  # A级·项目数据·深圳证券交易所
    "github_com": ["深网官网爬虫线", "github.com"],  # A级·项目数据·深网官网爬虫线
    "eia_eia": ["生态环境部环评渠道(模块名 eia, 非美国eia)", "mee.gov.cn"],  # A级·项目数据·生态环境部环评渠道(模块名 eia, 非美国EIA)
    "76_bid_powerchina_cn": ["电建系招标舰队(76站, bid.powerchina.cn 无鉴权)", "bid.powerchina.cn"],  # A级·工商招投标/项目数据·电建系招标舰队(76站, bid.powerchina.cn 无鉴权)
    "baidu_com": [],  # A级·标准定额/新闻舆情/项目数据·百度
    "wenku_search": ["百度文库搜索(wenku-search)", "wenku.baidu.com"],  # A级·数据集·百度文库搜索(wenku-search)
    "bduss": ["百度网盘(bduss扫码+离线下载)", "pan.baidu.com"],  # A级·数据集·百度网盘(BDUSS扫码+离线下载)
    "metaso": ["秘塔学术搜索(metaso)", "metaso.cn"],  # A级·学术专利·秘塔学术搜索(metaso)
    "pansou": ["网盘聚合发现(pansou)", "github.com", "fish2018/pansou"],  # A级·数据集·网盘聚合发现(pansou)
    "qt_gtimg_cn": ["腾讯财经行情接口(非官方公开)", "qt.gtimg.cn"],  # A级·通用网研·腾讯财经行情接口(非官方公开)
    "yt_dlp_bili_yt": ["视频文稿(yt-dlp bili/yt)", "github.com", "yt-dlp/yt-dlp"],  # A级·新闻舆情·视频文稿(yt-dlp bili/yt)
    "czce_com_cn": ["郑商所日行情与持仓", "czce.com.cn"],  # A级·通用网研·郑商所日行情与持仓
    "giiisp_com_keyless": ["集思谱 giiisp.com 论文检索(keyless英文腿)", "giiisp.com"],  # A级·学术专利·集思谱 giiisp.com 论文检索(keyless英文腿)
    "lark_cli_wiki": ["飞书语料 (lark-cli 检索/导出 + 总包智库 wiki 存量, 云端战略文档中枢)", "feishu.cn"],  # A级·数据集·飞书语料 (lark-cli 检索/导出 + 总包智库 wiki 存量, 云端战略文档中枢)
    "360_360ai": ["360搜索(含360ai搜索)"],  # B级·新闻舆情·360搜索(含360AI搜索)
    "4get": [],  # B级·通用网研·4get
    "acled": ["acleddata.com"],  # B级·项目数据/数据集·ACLED
    "adb_projects_statistics": ["adb projects & statistics", "adb.org"],  # B级·项目数据·ADB Projects & Statistics
    "ansi_webstore": ["ansi webstore", "webstore.ansi.org"],  # B级·标准定额/工商招投标·ANSI Webstore
    "asme": ["asme.org"],  # B级·标准定额·ASME
    "astm_international": ["astm international", "astm.org"],  # B级·标准定额·ASTM International
    "anthropic_research_claude": ["anthropic research (claude)", "anthropic.com"],  # B级·通用网研·Anthropic Research (Claude)
    "autoglm_research": ["autoglm-research", "autoglm-research.zhipuai.cn"],  # B级·通用网研·AutoGLM-Research
    "base": ["base-search.net"],  # B级·学术专利·BASE
    "base_2": [],  # B级·学术专利·BASE
    "boamp": ["boamp.fr"],  # B级·工商招投标/项目数据·BOAMP
    "bsigroup_com": ["bsigroup.com"],  # B级·标准定额·BSI
    "bellingcat_online_investigation_toolkit": ["bellingcat online investigation toolkit", "bellingcat.gitbook.io"],  # B级·项目数据·Bellingcat Online Investigation Toolkit
    "bing": [],  # B级·标准定额/学术专利/新闻舆情·Bing
    "boardreader": [],  # B级·新闻舆情·Boardreader
    "bochaai_bocha_search_mcp": ["bochaai/bocha-search-mcp", "github.com"],  # B级·新闻舆情·BochaAI/bocha-search-mcp
    "brave_search_api": ["brave search(网页+api)"],  # B级·新闻舆情·Brave Search(网页+API)
    "cen_cenelec": ["cen-cenelec", "cencenelec.eu"],  # B级·标准定额·CEN-CENELEC
    "core_api": ["core api"],  # B级·学术专利·CORE API
    "core_api_v3": ["core api v3", "api.core.ac.uk"],  # B级·学术专利·CORE API v3
    "compras_gov_br_pncp": ["compras.gov.br/pncp(巴西)", "gov.br"],  # B级·工商招投标/项目数据·Compras.gov.br/PNCP(巴西)
    "consensus": ["consensus.app"],  # B级·学术专利·Consensus
    "copernicus_data_space_ecosystem": ["copernicus data space ecosystem", "dataspace.copernicus.eu"],  # B级·新闻舆情/项目数据/数据集·Copernicus Data Space Ecosystem
    "coze_space": ["coze space", "coze.cn"],  # B级·通用网研·Coze Space
    "din_de": ["din.de"],  # B级·标准定额·DIN
    "danubia_content_extraction_api": ["danubia content extraction api", "danubia.tech"],  # B级·通用网研·Danubia content extraction API
    "deepsearch_deepsearch_ing": ["deepsearch (deepsearch.ing)", "deepsearch.ing"],  # B级·通用网研·DeepSearch (deepsearch.ing)
    "developmentaid": ["developmentaid.org"],  # B级·工商招投标/项目数据·DevelopmentAid
    "dimensions": ["app.dimensions.ai"],  # B级·学术专利·Dimensions
    "ebrd": ["ebrd项目数据库", "ebrd.com"],  # B级·工商招投标/项目数据·EBRD项目数据库
    "eia_api_v2": ["eia api v2", "api.eia.gov"],  # B级·项目数据·EIA API v2
    "eic_fiec_org": ["eic欧洲国际承包商", "eic.fiec.org"],  # B级·通用网研·EIC欧洲国际承包商
    "entso_e_transparency_platform": ["entso-e transparency platform", "transparency.entsoe.eu"],  # B级·项目数据/数据集·ENTSO-E Transparency Platform
    "epo_espacenet_ops_api": ["epo espacenet + ops api", "ops.epo.org"],  # B级·学术专利·EPO Espacenet + OPS API
    "ecosia": [],  # B级·通用网研·Ecosia
    "elicit": ["elicit.com"],  # B级·学术专利·Elicit
    "espacenet_epo_ops": ["espacenet/epo ops", "worldwide.espacenet.com"],  # B级·学术专利/项目数据·Espacenet/EPO OPS
    "event_registry": ["event registry", "eventregistry.org"],  # B级·新闻舆情·Event Registry
    "exa": [],  # B级·通用网研·Exa
    "fidic": ["fidic国际咨询工程师联合会", "fidic.org"],  # B级·通用网研·FIDIC国际咨询工程师联合会
    "fiec": ["fiec欧洲建筑业联合会", "fiec.org"],  # B级·项目数据·FIEC欧洲建筑业联合会
    "fred_api": ["fred api", "api.stlouisfed.org"],  # B级·项目数据·FRED API
    "fetchrelay": ["fetchrelay.com"],  # B级·通用网研·FetchRelay
    "figshare_api": ["figshare api", "api.figshare.com"],  # B级·学术专利/数据集·Figshare API
    "flowith_oracle_mode": ["flowith oracle mode", "flowith.net"],  # B级·通用网研·Flowith Oracle Mode
    "futurehouse_platform": ["futurehouse platform", "futurehouse.org"],  # B级·学术专利·FutureHouse Platform
    "futuresearch": ["futuresearch.ai"],  # B级·通用网研·FutureSearch
    "gnews_api": ["gnews api", "gnews.io"],  # B级·新闻舆情·GNews API
    "gemini_deep_research": ["gemini deep research", "gemini.google"],  # B级·通用网研·Gemini Deep Research
    "genspark_super_agent": ["genspark super agent", "genspark.ai"],  # B级·通用网研·Genspark Super Agent
    "github_topic_search_engine": ["github topic: search-engine 聚合页", "github.com", "topics/search-engine?o=desc&s=stars"],  # B级·数据集·GitHub topic: search-engine 聚合页
    "global_energy_monitor": ["global energy monitor", "globalenergymonitor.org"],  # B级·项目数据·Global Energy Monitor
    "google": [],  # B级·通用网研·Google
    "google_dataset_search": ["google dataset search", "datasetsearch.research.google.com"],  # B级·数据集·Google Dataset Search
    "google_dataset_search_2": ["google dataset search"],  # B级·数据集·Google Dataset Search
    "google_patents_public_datasets_bigquery": ["google patents public datasets (bigquery)", "patents.google.com"],  # B级·学术专利/数据集·Google Patents Public Datasets (BigQuery)
    "google_programmable_search_engine_json_api": ["google programmable search engine json api"],  # B级·项目数据·Google Programmable Search Engine JSON API
    "google_scholar": ["google scholar"],  # B级·学术专利·Google Scholar
    "google_trends": ["google trends"],  # B级·新闻舆情·Google Trends
    "grok_deepsearch_agents": ["grok deepsearch / agents"],  # B级·新闻舆情·Grok DeepSearch / Agents
    "h2o_ai_deep_research": ["h2o.ai deep research", "h2o.ai"],  # B级·通用网研·H2O.ai Deep Research
    "iea_data_statistics": ["iea data & statistics", "iea.org"],  # B级·项目数据·IEA Data & Statistics
    "iec_ch": ["iec.ch"],  # B级·标准定额·IEC
    "ieee_xplore_api": ["ieee xplore api", "developer.ieee.org"],  # B级·学术专利·IEEE Xplore API
    "iso_online_browsing_platform": ["iso online browsing platform", "iso.org"],  # B级·标准定额·ISO Online Browsing Platform
    "jisc": ["jisc (日本产业标准调查会)", "jisc.go.jp"],  # B级·标准定额·JISC (日本产业标准调查会)
    "kaggle": [],  # B级·标准定额/数据集·Kaggle
    "kaggle_datasets": ["kaggle datasets", "kaggle.com"],  # B级·数据集·Kaggle Datasets
    "kagi": [],  # B级·通用网研·Kagi
    "kimi_researcher": ["kimi-researcher", "moonshotai.github.io"],  # B级·通用网研·Kimi-Researcher
    "lme_com": ["lme官网延迟行情", "lme.com"],  # B级·通用网研·LME官网延迟行情
    "lens_org_api": ["lens.org api", "api.lens.org"],  # B级·标准定额/学术专利·Lens.org API
    "librey": [],  # B级·通用网研·LibreY
    "mgx_dev": ["mgx.dev"],  # B级·通用网研·MGX
    "magi": [],  # B级·项目数据·Magi
    "media_cloud": ["media cloud"],  # B级·新闻舆情·Media Cloud
    "mediacloud": ["mediacloud.org"],  # B级·新闻舆情·MediaCloud
    "metager": [],  # B级·新闻舆情·MetaGer
    "microsoft_copilot_researcher": ["microsoft copilot researcher", "microsoft.com"],  # B级·通用网研·Microsoft Copilot Researcher
    "millionshort": [],  # B级·通用网研·MillionShort
    "mojeek": [],  # B级·标准定额·Mojeek
    "mwmbl_2": [],  # B级·通用网研·Mwmbl
    "nasa_firms": ["nasa firms", "firms.modaps.eosdis.nasa.gov"],  # B级·新闻舆情/数据集·NASA FIRMS
    "newsapi_org": ["newsapi.org"],  # B级·新闻舆情·NewsAPI.org
    "nopechallc_nopecha_extension": ["nopechallc/nopecha-extension", "github.com"],  # B级·通用网研·NopeCHALLC/nopecha-extension
    "not_human_search": ["not human search", "nothumansearch.ai"],  # B级·通用网研·Not Human Search
    "notebooklm": ["notebooklm.google"],  # B级·通用网研·NotebookLM
    "osint_framework": ["osint framework", "osintframework.com"],  # B级·通用网研·OSINT Framework
    "osint_stuff_tools_collection": ["osint stuff tools collection", "github.com", "cipher387/osint_stuff_tool_collection"],  # B级·通用网研·OSINT Stuff Tools Collection
    "open_canada": ["open canada", "open.canada.ca"],  # B级·工商招投标/项目数据/数据集·Open Canada
    "open_contracting_partnership": ["open contracting partnership", "open-contracting.org"],  # B级·标准定额/工商招投标/项目数据/数据集·Open Contracting Partnership
    "openai_deep_research": ["openai deep research", "openai.com"],  # B级·通用网研·OpenAI Deep Research
    "opencitations": ["opencitations.net"],  # B级·学术专利/数据集·OpenCitations
    "opencorporates": ["opencorporates.com"],  # B级·通用网研·OpenCorporates
    "openinframap": ["openinframap.org"],  # B级·项目数据·OpenInfraMap
    "patentsview_uspto": ["patentsview (uspto)", "search.patentsview.org"],  # B级·学术专利/项目数据·PatentsView (USPTO)
    "perplexity_deep_research": ["perplexity deep research", "perplexity.ai"],  # B级·通用网研·Perplexity Deep Research
    "perplexity_sonar_api": ["perplexity sonar api"],  # B级·学术专利/新闻舆情·Perplexity Sonar API
    "petal_search": ["petal search"],  # B级·新闻舆情·Petal Search
    "phind": [],  # B级·标准定额·Phind
    "presearch": [],  # B级·通用网研·Presearch
    "public_apis": ["public apis", "github.com", "public-apis/public-apis"],  # B级·新闻舆情/数据集·Public APIs
    "qwant": [],  # B级·通用网研·Qwant
    "qwen_deep_research": ["qwen deep research", "chat.qwen.ai"],  # B级·通用网研·Qwen Deep Research
    "rsshub": [],  # B级·新闻舆情·RSSHub
    "researchrabbit": ["researchrabbit.ai"],  # B级·学术专利·ResearchRabbit
    "richard_weiss_mcp_google_cse": ["richard-weiss/mcp-google-cse", "github.com"],  # B级·新闻舆情·Richard-Weiss/mcp-google-cse
    "sam_gov": ["sam.gov排除名单", "sam.gov"],  # B级·通用网研·SAM.gov排除名单
    "ssrn": ["ssrn(社科预印本平台)", "ssrn.com"],  # B级·学术专利·SSRN(社科预印本平台)
    "scispace": ["scispace.com"],  # B级·学术专利·SciSpace
    "scite_ai": ["scite.ai"],  # B级·学术专利·Scite.ai
    "scopus_api_elsevier_dev": ["scopus api (elsevier dev)", "dev.elsevier.com"],  # B级·学术专利·Scopus API (Elsevier Dev)
    "scrapingbee_google_search_api": ["scrapingbee/google-search-api", "github.com"],  # B级·通用网研·ScrapingBee/google-search-api
    "searchapi_io": ["searchapi.io"],  # B级·通用网研·SearchApi.io
    "searchhive": ["searchhive.dev"],  # B级·通用网研·SearchHive
    "serpapi": [],  # B级·学术专利/新闻舆情/项目数据·SerpAPI
    "serper_dev": ["serper.dev"],  # B级·通用网研·Serper.dev
    "springer_nature_api": ["springer nature api", "dev.springernature.com"],  # B级·学术专利·Springer Nature API
    "startpage": [],  # B级·通用网研·Startpage
    "stract": [],  # B级·通用网研·Stract
    "swisscows": [],  # B级·通用网研·Swisscows
    "tavily": [],  # B级·通用网研·Tavily
    "teclis": [],  # B级·通用网研·Teclis
    "trendradar_technologieradar": ["trendradar (technologieradar)", "technologieradar.tryresearchly.com"],  # B级·新闻舆情·Trendradar (technologieradar)
    "truestar": ["truestar.tech"],  # B级·通用网研·TrueStar
    "tushare_pro": ["tushare(pro免费积分面)", "github.com", "waditu/tushare"],  # B级·项目数据·Tushare(Pro免费积分面)
    "uk_companies_house_api": ["uk companies house api", "developer.company-information.service.gov.uk"],  # B级·项目数据·UK Companies House API
    "uk_contracts_finder": ["uk contracts finder", "gov.uk"],  # B级·工商招投标/项目数据·UK Contracts Finder
    "un_comtrade_api": ["un comtrade api", "comtradeapi.un.org"],  # B级·项目数据·UN Comtrade API
    "un_comtrade_api_2": ["un comtrade+ api", "comtradeplus.un.org"],  # B级·项目数据/数据集·UN Comtrade+ API
    "ungm": ["ungm联合国全球市场", "ungm.org"],  # B级·工商招投标·UNGM联合国全球市场
    "unido_statistics": ["unido statistics", "stat.unido.org"],  # B级·项目数据·UNIDO Statistics
    "us_census_bureau_api": ["us census bureau api", "api.census.gov"],  # B级·项目数据·US Census Bureau API
    "usgs_earthexplorer_landsat": ["usgs earthexplorer/landsat", "earthexplorer.usgs.gov"],  # B级·项目数据/数据集·USGS EarthExplorer/Landsat
    "wipo_patentscope": ["wipo patentscope", "patentscope.wipo.int"],  # B级·学术专利·WIPO PATENTSCOPE
    "web_of_science_api": ["web of science api", "clarivate.com"],  # B级·学术专利·Web of Science API
    "wolfram_alpha": ["wolfram alpha"],  # B级·标准定额·Wolfram Alpha
    "yandex": [],  # B级·通用网研·Yandex
    "yep": [],  # B级·通用网研·Yep
    "you_com_api": ["you.com api"],  # B级·通用网研·You.com API
    "you_com_research": ["you.com research", "you.com"],  # B级·通用网研·You.com Research
    "awesome_civil_engineering_quantumnovice": ["awesome-civil-engineering (quantumnovice)", "github.com", "quantumnovice/awesome-civil-engineering"],  # B级·数据集·awesome-civil-engineering (QuantumNovice)
    "awesome_civil_engineering_riponcm": ["awesome-civil-engineering (riponcm)", "github.com", "riponcm/awesome-civil-engineering"],  # B级·数据集·awesome-civil-engineering (riponcm)
    "awesome_digital_civil_engineering": ["awesome-digital-civil-engineering", "github.com", "ayberkrk/awesome-digital-civil-engineering"],  # B级·数据集·awesome-digital-civil-engineering
    "awesome_osint": ["awesome-osint", "github.com", "jivoi/awesome-osint"],  # B级·通用网研·awesome-osint
    "awesome_public_datasets": ["awesome-public-datasets", "github.com", "awesomedata/awesome-public-datasets"],  # B级·数据集·awesome-public-datasets
    "awesome_selfhosted_search_engines": ["awesome-selfhosted (search engines 分类)", "github.com", "awesome-selfhosted/awesome-selfhosted"],  # B级·数据集·awesome-selfhosted (search engines 分类)
    "awesome_spacecraft_engineering_datasets": ["awesome-spacecraft-engineering-datasets", "github.com", "patrickfleith/awesome-spacecraft-engineering-datasets"],  # B级·数据集·awesome-spacecraft-engineering-datasets
    "brave_brave_search_mcp_server": ["brave/brave-search-mcp-server", "github.com"],  # B级·新闻舆情·brave/brave-search-mcp-server
    "brave_brave_search_skills": ["brave/brave-search-skills", "github.com"],  # B级·通用网研·brave/brave-search-skills
    "brightdata_brightdata_mcp": ["brightdata/brightdata-mcp", "github.com"],  # B级·通用网研·brightdata/brightdata-mcp
    "bx_brave_search_cli": ["bx (brave-search-cli)", "github.com", "brave/brave-search-cli"],  # B级·新闻舆情·bx (brave-search-cli)
    "data_gov_us_ckan": ["data.gov (us ckan)", "data.gov"],  # B级·工商招投标/项目数据/数据集·data.gov (US CKAN)
    "data_gov_in": ["data.gov.in(印度)", "data.gov.in"],  # B级·项目数据/数据集·data.gov.in(印度)
    "edoardottt_awesome_hacker_search_engines": ["edoardottt/awesome-hacker-search-engines", "github.com"],  # B级·项目数据/数据集·edoardottt/awesome-hacker-search-engines
    "exa_labs_exa_mcp_server": ["exa-labs/exa-mcp-server", "github.com"],  # B级·新闻舆情·exa-labs/exa-mcp-server
    "exa_py": ["exa-py", "github.com", "exa-labs/exa-py"],  # B级·新闻舆情·exa-py
    "felladrin_awesome_ai_web_search": ["felladrin/awesome-ai-web-search", "github.com"],  # B级·项目数据/数据集·felladrin/awesome-ai-web-search
    "firecrawl_firesearch": ["firecrawl/firesearch", "github.com"],  # B级·通用网研·firecrawl/firesearch
    "google_api_python_client_custom_search_json_api": ["google-api-python-client (custom search json api)", "github.com", "googleapis/google-api-python-client"],  # B级·新闻舆情·google-api-python-client (Custom Search JSON API)
    "google_search_results_python_serpapi": ["google-search-results-python (serpapi 官方)", "github.com", "serpapi/google-search-results-python"],  # B级·新闻舆情·google-search-results-python (SerpApi 官方)
    "kagi_cli": ["kagi-cli", "github.com", "microck/kagi-cli"],  # B级·新闻舆情·kagi-cli
    "kagisearch_kagimcp": ["kagisearch/kagimcp", "github.com"],  # B级·新闻舆情·kagisearch/kagimcp
    "perplexityai_modelcontextprotocol": ["perplexityai/modelcontextprotocol", "github.com"],  # B级·新闻舆情·perplexityai/modelcontextprotocol
    "punkpeye_awesome_mcp_servers": ["punkpeye/awesome-mcp-servers", "github.com"],  # B级·数据集·punkpeye/awesome-mcp-servers
    "searx_space_3": ["searx.space"],  # B级·数据集·searx.space
    "serpapi_serpapi_mcp": ["serpapi/serpapi-mcp", "github.com"],  # B级·新闻舆情·serpapi/serpapi-mcp
    "tavily_ai_tavily_mcp": ["tavily-ai/tavily-mcp", "github.com"],  # B级·新闻舆情·tavily-ai/tavily-mcp
    "tavily_open_trailsearch": ["tavily-open (已更名 trailsearch)", "github.com", "jianjungki/tavily-open"],  # B级·新闻舆情·tavily-open (已更名 TrailSearch)
    "tavily_python": ["tavily-python", "github.com", "tavily-ai/tavily-python"],  # B级·新闻舆情·tavily-python
    "vladkens_twscrape": ["vladkens/twscrape", "github.com"],  # B级·新闻舆情·vladkens/twscrape
    "data_eastmoney_com": ["东方财富数据中心(免费网页面)", "data.eastmoney.com"],  # B级·项目数据·东方财富数据中心(免费网页面)
    "sinosure": ["中信保(sinosure)国别风险公开面", "sinosure.com.cn"],  # B级·通用网研·中信保(Sinosure)国别风险公开面
    "pbc_gov_cn": ["中国人民银行公开数据", "pbc.gov.cn"],  # B级·项目数据·中国人民银行公开数据
    "ecaci_org_cn": ["中国建筑业协会", "ecaci.org.cn"],  # B级·项目数据·中国建筑业协会
    "chinajsb_cn": ["中国建设报/中国建设新闻网", "chinajsb.cn"],  # B级·新闻舆情·中国建设报/中国建设新闻网
    "zxgk_court_gov_cn": ["中国执行信息公开网", "zxgk.court.gov.cn"],  # B级·通用网研·中国执行信息公开网
    "cebpubservice_com": ["中国招标投标公共服务平台", "cebpubservice.com"],  # B级·工商招投标·中国招标投标公共服务平台
    "gov_cn": ["中国政府公报(国务院+地方)", "gov.cn"],  # B级·学术专利·中国政府公报(国务院+地方)
    "ccement_com": ["ccement.com"],  # B级·新闻舆情·中国水泥网
    "chinamoney_com_cn": ["中国货币网(外汇交易中心)", "chinamoney.com.cn"],  # B级·通用网研·中国货币网(外汇交易中心)
    "cacem_com_cn": ["中施企协(中国施工企业管理协会)", "cacem.com.cn"],  # B级·通用网研·中施企协(中国施工企业管理协会)
    "aiib": ["亚投行(aiib)", "aiib.org"],  # B级·工商招投标·亚投行(AIIB)
    "rmfyalk": ["人民法院案例库(rmfyalk)", "rmfyalk.court.gov.cn"],  # B级·通用网研·人民法院案例库(rmfyalk)
    "qcc_com": ["qcc.com"],  # B级·工商招投标·企查查
    "creditchina_gov_cn": ["creditchina.gov.cn"],  # B级·通用网研·信用中国
    "ggzy_gov_cn": ["全国公共资源交易平台", "ggzy.gov.cn"],  # B级·工商招投标·全国公共资源交易平台
    "glxy_mot_gov_cn": ["全国公路建设市场信用信息管理系统", "glxy.mot.gov.cn"],  # B级·通用网研·全国公路建设市场信用信息管理系统
    "ucdrs_superlib_net": ["全国图书馆参考咨询联盟", "ucdrs.superlib.net"],  # B级·学术专利·全国图书馆参考咨询联盟
    "xypt_mwr_cn": ["全国水利建设市场监管平台", "xypt.mwr.cn"],  # B级·通用网研·全国水利建设市场监管平台
    "jianyu360_com": ["jianyu360.com"],  # B级·工商招投标·剑鱼标讯
    "bse_cn": ["北交所披露与市场数据", "bse.cn"],  # B级·项目数据·北交所披露与市场数据
    "pkulaw_com": ["北大法宝免费面", "pkulaw.com"],  # B级·数据集·北大法宝免费面
    "qianlima_com": ["千里马招标网", "qianlima.com"],  # B级·工商招投标·千里马招标网
    "qixin_com": ["qixin.com"],  # B级·通用网研·启信宝
    "fec_mofcom_gov_cn": ["商务部对外投资合作信息服务", "fec.mofcom.gov.cn"],  # B级·项目数据·商务部对外投资合作信息服务
    "jzsc_mohurd_gov_cn": ["四库一平台/全国建筑市场监管公共服务平台", "jzsc.mohurd.gov.cn"],  # B级·通用网研·四库一平台/全国建筑市场监管公共服务平台
    "gsxt_gov_cn": ["国家企业信用信息公示系统", "gsxt.gov.cn"],  # B级·通用网研·国家企业信用信息公示系统
    "data_gov_cn": ["国家公共数据资源平台", "data.gov.cn"],  # B级·项目数据/数据集·国家公共数据资源平台
    "ncpssd": ["国家哲学社会科学文献中心(ncpssd)", "ncpssd.cn"],  # B级·学术专利·国家哲学社会科学文献中心(NCPSSD)
    "flk_npc_gov_cn": ["国家法律法规数据库(flk)", "flk.npc.gov.cn"],  # B级·通用网研·国家法律法规数据库(flk)
    "ecp_sgcc_com_cn": ["国家电网电子商务平台", "ecp.sgcc.com.cn"],  # B级·工商招投标·国家电网电子商务平台
    "pss_system_cponline_cnipa_gov_cn": ["国家知识产权局专利检索系统", "pss-system.cponline.cnipa.gov.cn"],  # B级·学术专利·国家知识产权局专利检索系统
    "nstl": ["国家科技图书文献中心(nstl)", "nstl.gov.cn"],  # B级·学术专利·国家科技图书文献中心(NSTL)
    "data_stats_gov_cn": ["国家统计局国家数据", "data.stats.gov.cn"],  # B级·项目数据·国家统计局国家数据
    "nea_gov_cn": ["国家能源局电力业务资质", "nea.gov.cn"],  # B级·通用网研·国家能源局电力业务资质
    "cg_95306_cn": ["国铁采购平台", "cg.95306.cn"],  # B级·工商招投标·国铁采购平台
    "suaee_com": ["地方产权交易所公告(代表:上海联交所)", "suaee.com"],  # B级·新闻舆情·地方产权交易所公告(代表:上海联交所)
    "ai": ["天工ai搜索"],  # B级·新闻舆情·天工AI搜索
    "tianyancha_com": ["tianyancha.com"],  # B级·工商招投标·天眼查
    "so_toutiao_com": [],  # B级·新闻舆情·头条搜索
    "jzsbs_com": ["jzsbs.com"],  # B级·新闻舆情·建筑时报
    "jianshe99_com": ["jianshe99.com"],  # B级·工商招投标·建设通
    "ebnew_com": ["ebnew.com"],  # B级·工商招投标·必联网
    "mysteel_com": ["mysteel.com"],  # B级·新闻舆情·我的钢铁网
    "neeq_com_cn": ["新三板(股转系统)", "neeq.com.cn"],  # B级·通用网研·新三板(股转系统)
    "web_search_pro": ["智谱 web_search_pro"],  # B级·新闻舆情·智谱 web_search_pro
    "bidizhaobiao_com": ["bidizhaobiao.com"],  # B级·工商招投标·比地招标网
    "stats_customs_gov_cn": ["海关总署统计数据平台", "stats.customs.gov.cn"],  # B级·项目数据·海关总署统计数据平台
    "www1_hkexnews_hk": ["港交所披露易", "www1.hkexnews.hk"],  # B级·通用网研·港交所披露易
    "hkexnews": ["港交所披露易(hkexnews)", "hkexnews.hk"],  # B级·通用网研·港交所披露易(HKEXnews)
    "volcengine_com": ["火山方舟联网搜索(豆包)"],  # B级·新闻舆情·火山方舟联网搜索(豆包)
    "aiqicha_baidu_com": ["爱企查(百度)", "aiqicha.baidu.com"],  # B级·通用网研·爱企查(百度)
    "100njz_com": ["100njz.com"],  # B级·新闻舆情·百年建筑网
    "xueshu_baidu_com": [],  # B级·学术专利·百度学术
    "xueshu_baidu_com_2": ["百度学术(免费发现层)", "xueshu.baidu.com"],  # B级·学术专利·百度学术(免费发现层)
    "index_baidu_com": [],  # B级·新闻舆情·百度指数
    "news_baidu_com": [],  # B级·新闻舆情·百度新闻
    "ai_metaso": ["秘塔ai搜索(metaso)"],  # B级·学术专利/新闻舆情·秘塔AI搜索(metaso)
    "iresearch_cn": ["艾瑞咨询免费报告面", "iresearch.cn"],  # B级·通用网研·艾瑞咨询免费报告面
    "companies_house": ["英国companies house", "find-and-update.company-information.service.gov.uk"],  # B级·通用网研·英国Companies House
    "dnb_com": ["邓白氏d&b(纯付费-按令排除)", "dnb.com"],  # B级·通用网研·邓白氏D&B(纯付费-按令排除)
    "bidcenter_com_cn": ["bidcenter.com.cn"],  # B级·工商招投标·采招网
}
# 只增合并: 与存量渠道同名键(如 arxiv)并入, 不覆盖不删除
for _k in list(SURVEY_ALIASES):
    _cur = CHANNEL_ALIASES.setdefault(_k, [])
    _cur.extend(_a for _a in SURVEY_ALIASES[_k] if _a not in _cur)

#: cross:*/rss:* 基名 → 渠道 (None = 有基名语义但无 named 渠道对应, 不硬点亮)。
BASE_TO_CHANNEL: dict[str, tuple[str | None, str]] = {
    "wechat_rss": ("sougo", "微信生态公众号RSS≈搜狗微信内容面（近似）"),
    "sogou_wechat": ("sougo", "搜狗微信直采"),
    "rss": (None, "RSS 常年收割（rss_fleet 族，未列 named 渠道）"),
    "cnki": ("cnki", ""),
    "metaso": ("metaso", ""),
    "weread": ("weread", ""),
    "zhsearchpro": ("zh_search_pro", ""),
    "video": ("video", ""),
    "websearch_en": ("websearch", "英文 web 搜索≈WebSearch 面（近似）"),
    "ebook": ("ebook_library", "电子书渠道族（近似）"),
    # 1024 当当专项令: dangdang 已建独立渠道, cross:dangdang 标签直落本渠
    # (原近似映射 ebook_library 让位)
    "dangdang": ("dangdang", "当当图书独立渠道（1024建渠, 原ebook_library近似退役）"),
    # 1024 metaso-kb 专项令: 秘塔知识库专题独立渠道, cross:metaso_kb 标签直落本渠
    "metaso_kb": ("metaso_kb", "秘塔知识库专题独立渠道（1024建渠, 工程行业大脑文件面）"),
    # 1025 last30days 接入令: cross:last30days 引擎标签直落本渠
    # (引擎标签恒为裸 last30days 已直命中别名, 本条兜 cross: 变体)
    "last30days": ("last30days", "last30days 近30日社媒热度渠道（1025接入, vendors引擎+reforge腿）"),
    "academic_en": (None, "学术英文（OpenAlex/S2/arXiv 待建渠 T-015）"),
    "arxiv": (None, "arXiv（待建渠 T-015）"),
    "patents": (None, "专利（待建渠 T-015）"),
}

#: 个别整标签近似 (键为小写整标签)。
LABEL_TO_CHANNEL: dict[str, tuple[str, str]] = {
    "search:web": ("websearch", "网页搜索≈WebSearch 面（近似）"),
    "fulltext:web": ("website", "网页全文≈官网爬虫面（近似）"),
}

#: 前缀近似 (引擎标签第一段 → 渠道)。
PREFIX_TO_CHANNEL: dict[str, tuple[str, str]] = {
    "stock": ("corpus_stores", "存量池收割≈存量语料库（近似）"),
    # 1024 记账债修复: webregistry:* = 网页搜索项目注册表成员引擎
    # (marginalia_search/python_baidusearch/yacy/mwmbl/ddgs/searxng 六台),
    # 对应 named 渠道 search_library「网页搜索项目注册表」。
    "webregistry": ("search_library", "webregistry:* 注册表成员引擎≈网页搜索项目注册表渠道"),
}


def _norm(s: str) -> str:
    """队列/缺口匹配用的归一化: 去空白 + 小写 (id 与中文名皆可对上)."""
    return "".join(str(s).split()).lower()


def load_channels(manifest_path: Path) -> list[dict]:
    """读 named 渠道清单; 读不到返回 [] (fail-soft 由 scan 落地)."""
    try:
        data = json.loads(Path(manifest_path).read_text(encoding="utf-8"))
        chans = data.get("named_channels") or []
        return [c for c in chans if isinstance(c, dict) and c.get("id")]
    except Exception:
        return []


def _alias_table(channels: list[dict]) -> dict[str, list[str]]:
    """渠道 id + 清单 name + 内置别名 → 每渠道别名集 (全小写去重)."""
    table: dict[str, list[str]] = {}
    for c in channels:
        cid = str(c["id"])
        names = {cid.lower()}
        if c.get("name"):
            names.add(str(c["name"]).lower())
        names.update(a.lower() for a in CHANNEL_ALIASES.get(cid, []))
        # 长别名在前, 便于「最长优先」抑制包含式别名
        table[cid] = sorted(names, key=len, reverse=True)
    return table


def resolve_engine(label: str, table: dict[str, list[str]] | None = None) -> dict:
    """单引擎标签 → {channels, notes, bases}. 近似/族级语义都在 notes 注明."""
    if table is None:
        table = _alias_table(
            [{"id": k, "name": ""} for k in CHANNEL_ALIASES]
            + [{"id": i, "name": n} for i, n in (
                ("sougo", "搜狗微信"), ("metaso", "秘塔学术"), ("weread", "微信读书"),
                ("lark", "飞书语料"), ("cnki", "CNKI 论文"), ("manus", "Manus 军团"),
                ("website", "官网爬虫"), ("video", "视频文稿"), ("websearch", "WebSearch"),
                ("court", "涉诉检索"), ("corpus_stores", "存量语料库"),
                ("ebook_library", "电子书渠道族"), ("ima", "ima 知识库"),
                ("ima_public", "ima 公开知识库"),
            )]
        )
    low = str(label).lower()
    notes: list[str] = []
    bases: list[str] = []

    # 1) 直接命中 (含渠道 id/别名/中文名)
    matched: dict[str, set[str]] = {}
    for cid, aliases in table.items():
        hits = {a for a in aliases if a in low}
        if hits:
            matched[cid] = hits
    # 「最长别名优先」: 渠道 X 的全部命中别名都是别的渠道更长别名的子串 → X 让位
    def _shadowed(cid: str, alias: str) -> bool:
        for c2, aliases2 in matched.items():
            if c2 != cid and any(alias in a2 for a2 in aliases2):
                return True
        return False

    for cid in list(matched):
        if all(_shadowed(cid, a) for a in matched[cid]):
            del matched[cid]
    channels = set(matched)

    # 2) cross:*/rss:* 前缀基名
    for marker in ("cross:", "rss:"):
        if marker in low:
            base = low.split(marker, 1)[1].split(":", 1)[0]
            if base:
                bases.append(base)
                cid, note = BASE_TO_CHANNEL.get(base, (None, ""))
                if cid:
                    channels.add(cid)
                if note:
                    notes.append(note)
                elif not cid and marker == "rss:":
                    notes.append("RSS 常年收割（rss_fleet 族，未列 named 渠道）")

    # 3) 整标签 / 前缀近似
    whole = LABEL_TO_CHANNEL.get(low)
    if whole:
        channels.add(whole[0])
        if whole[1]:
            notes.append(whole[1])
    head = low.split(":", 1)[0]
    pref = PREFIX_TO_CHANNEL.get(head)
    if pref:
        channels.add(pref[0])
        if pref[1]:
            notes.append(pref[1])

    # 只留在渠道清单内的命中 (别名表可能含清单外残留)
    channels &= set(table)
    return {"channels": sorted(channels), "notes": notes, "bases": sorted(set(bases))}


def _load_queue(path: Path) -> list[dict]:
    """读新建队列: [{"name","sop_step"}] 兼容纯字符串; 缺席/坏文件 → []."""
    try:
        data = json.loads(Path(path).read_text(encoding="utf-8"))
    except Exception:
        return []
    if not isinstance(data, list):
        return []
    out = []
    for it in data:
        if isinstance(it, str):
            out.append({"name": it})
        elif isinstance(it, dict) and it.get("name"):
            out.append({"name": str(it["name"]), "sop_step": it.get("sop_step")})
    return out


def scan(campaign: str, *, pool_root: Path | str | None = None,
         manifest_path: Path | str | None = None,
         queue_path: Path | str | None = None) -> dict:
    """扫描一战役 C 轴: 只读 pool_state/清单/队列, 返回账本节 dict (不落盘)."""
    root = Path(pool_root) if pool_root else DEFAULT_AMMO_ROOT
    manifest = Path(manifest_path) if manifest_path else DEFAULT_MANIFEST_PATH
    pool_state_path = root / campaign / "pool_state.json"
    if not pool_state_path.exists():
        raise FileNotFoundError(f"pool_state 不存在: {pool_state_path}")

    state = json.loads(pool_state_path.read_text(encoding="utf-8"))
    by_engine = state.get("by_engine") or {}

    channels = load_channels(manifest)
    fail_soft = not channels
    if fail_soft:  # 清单读不到 → 退化用池已见引擎清单 (全命中, 近似)
        channels = [{"id": k, "name": k} for k in sorted(by_engine)]

    table = _alias_table(channels)
    hit_chars: dict[str, int] = {}
    hit_engines: dict[str, list[str]] = {}
    engine_map: dict[str, dict] = {}
    zero_engines: list[str] = []
    for label, chars in by_engine.items():
        try:
            n = int(chars)
        except (TypeError, ValueError):
            n = 1 if chars else 0
        if n <= 0:
            zero_engines.append(str(label))
            continue
        res = resolve_engine(label, table)
        engine_map[str(label)] = res
        for cid in res["channels"]:
            hit_chars[cid] = hit_chars.get(cid, 0) + n
            hit_engines.setdefault(cid, []).append(str(label))

    hit_channels = [
        {"id": c["id"], "name": c.get("name", c["id"]),
         "chars": hit_chars[c["id"]], "engines": sorted(hit_engines[c["id"]])}
        for c in channels if c["id"] in hit_chars
    ]
    miss_detail = [{"id": c["id"], "name": c.get("name", c["id"])}
                   for c in channels if c["id"] not in hit_chars]
    miss_list = [m["name"] for m in miss_detail]
    total = len(channels)
    hitn = len(hit_channels)

    qpath = Path(queue_path) if queue_path else root / campaign / QUEUE_RELPATH
    queue = _load_queue(qpath)
    queue_keys = {_norm(q["name"]) for q in queue}
    # 队列里写渠道 id 也能对上 (miss 名/id 双口径匹配)
    miss_in_queue = [m["name"] for m in miss_detail
                     if _norm(m["name"]) in queue_keys or _norm(m["id"]) in queue_keys]
    # 1022 宪法终极形态: 每报告×全渠道×零豁免 — 豁免制废止 (channel_waivers
    # 废档), 绿判据改为「调用台账」: ammo_pool/<战役>/channel_invocations.jsonl
    # 记录每次真实调用 {channel, ts, tool, queries, yield, note} — 调用是义务,
    # 收获另计 (yield=0 也算调用). green = 名册全渠道均有调用记录.
    invocations: list[dict] = []
    ipath = root / campaign / "channel_invocations.jsonl"
    if ipath.is_file():
        try:
            invocations = [json.loads(x) for x in
                           ipath.read_text(encoding="utf-8").splitlines()
                           if x.strip()]
        except (json.JSONDecodeError, OSError):
            invocations = []
    # 1026 记账债修复 (五轴门修④): 调用台账按渠道族对账 — slug 名行
    # (douyin/quark/webregistry/arxiv_py/semantic_scholar_graph_api 等注册表
    # slug) 经 resolve_engine 别名/前缀表归渠, 与命中账用同一张映射表
    # (原精确等值匹配漏记已发生调用; 零造假: 只认表内真实映射, 未映射
    # slug 仍不算调用)。
    invoked_ids: set[str] = set()
    for iv in invocations:
        if isinstance(iv, dict) and iv.get("channel"):
            ch = str(iv["channel"])
            invoked_ids.add(_norm(ch))
            for cid in resolve_engine(ch, table)["channels"]:
                invoked_ids.add(cid)
    miss_not_invoked = [m["name"] for m in miss_detail
                        if _norm(m["name"]) not in invoked_ids
                        and _norm(m["id"]) not in invoked_ids]
    green = (not miss_not_invoked)

    approx_notes = sorted({
        n for res in engine_map.values() for n in res["notes"]
    })
    unmapped_engines = sorted(
        l for l, res in engine_map.items() if not res["channels"]
    )

    return {
        "axis": AXIS,
        "sensor": SENSOR,
        "campaign": campaign,
        "channels_hit": hitn,
        "channels_total": total,
        "hit_ratio": round(hitn / total, 4) if total else 0.0,
        "hit_channels": hit_channels,
        "miss_list": miss_list,
        "miss_detail": miss_detail,
        "new_channel_queue": queue,
        "miss_in_queue": miss_in_queue,
        "channel_invocations": len(invocations),
        "invoked_channels": sorted(invoked_ids),
        "miss_not_invoked": miss_not_invoked,        # 1022宪法: 唯一红因=未调用
        "invocations_path": str(ipath),
        "green": green,
        "green_rule": "1022宪法: 全渠道调用即绿(收获另计, 零豁免)",
        "engine_map": engine_map,
        "unmapped_engines": unmapped_engines,
        "zero_char_engines": zero_engines,
        "approx_notes": approx_notes,
        "manifest": str(manifest),
        "fail_soft": fail_soft,
        "fail_soft_note": ("渠道清单不可读, 分母退化=池 by_engine 已见引擎清单(近似)"
                           if fail_soft else ""),
        "generated_at": datetime.now().astimezone().isoformat(timespec="seconds"),
    }


def write(result: dict, campaign: str, *, pool_root: Path | str | None = None) -> dict:
    """双产物落盘: completeness/C_axis.json (账本节) + 战役根 channel_matrix.json
    (taskgraph verify 镜像). 只增不删, 目录缺席则建."""
    root = Path(pool_root) if pool_root else DEFAULT_AMMO_ROOT
    cdir = root / campaign / "completeness"
    cdir.mkdir(parents=True, exist_ok=True)
    c_axis = cdir / "C_axis.json"
    mirror = root / campaign / "channel_matrix.json"
    text = json.dumps(result, ensure_ascii=False, indent=1)
    c_axis.write_text(text, encoding="utf-8", newline="\n")
    mirror.write_text(text, encoding="utf-8", newline="\n")
    return {"c_axis": str(c_axis), "mirror": str(mirror)}


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(
        description="C 轴传感器: 渠道×主题命中矩阵与缺口清单 (只读扫描)")
    ap.add_argument("campaign", help="战役名, 如 EPC-BID26")
    ap.add_argument("--ammo-root", default=None, help="ammo_pool 根 (默认仓库默认)")
    ap.add_argument("--manifest", default=None, help="channel_manifest.json 路径覆盖")
    ap.add_argument("--queue", default=None, help="C_axis_queue.json 路径覆盖")
    ap.add_argument("--dry-run", action="store_true", help="只打印不落盘")
    args = ap.parse_args(argv)

    try:
        result = scan(args.campaign, pool_root=args.ammo_root,
                      manifest_path=args.manifest, queue_path=args.queue)
    except FileNotFoundError as e:
        print(f"[C轴] FAIL {e}", file=sys.stderr)
        return 2

    summary = {
        "campaign": result["campaign"],
        "channels_hit": result["channels_hit"],
        "channels_total": result["channels_total"],
        "hit_ratio": result["hit_ratio"],
        "green": result["green"],
        "miss_list": result["miss_list"],
        "miss_not_invoked": result["miss_not_invoked"],
        "channel_invocations": result["channel_invocations"],
        "fail_soft": result["fail_soft"],
    }
    print("[C轴] " + json.dumps(summary, ensure_ascii=False))
    print("[C轴] 缺口清单(前10): " + "、".join(result["miss_list"][:10]))

    if args.dry_run:
        print("[C轴] dry-run: 未落盘")
        return 0
    out = write(result, args.campaign, pool_root=args.ammo_root)
    print(f"[C轴] 落盘 {out['c_axis']} + 镜像 {out['mirror']}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
