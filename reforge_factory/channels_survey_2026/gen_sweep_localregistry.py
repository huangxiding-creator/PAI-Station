# -*- coding: utf-8 -*-
"""channels_survey_2026 lane: 本地注册表清扫 — 产出 sweep_localregistry.json

四源合流去重:
  A. EPC100/collectors/search_library/projects.py (119项网页搜索项目注册表)
  B. EPC100/conductor/v2/channels_v2.json (62渠在役册)
  C. ResearchFactory-Eng/channel_manifest.json named_channels (35渠, 补 B 缺的6渠)
  D. 逆向工程/ 复刻件 (26目录, 其中未入渠道册的存量候选)

字段纪律: desc 只截注册表 note 证据原文(≤95字); access/cn_reachable/fit
按 cat/渠道实测态归类; 数字零造假 (stars 均为 note 内 gh api 实证原文)。
"""
import json
import re
import sys
from pathlib import Path

STATION = Path("E:/AI-Station")
OUT = STATION / "reforge_factory/channels_survey_2026/sweep_localregistry.json"

sys.path.insert(0, str(STATION / "ResearchFactory-Eng/EPC100/collectors/search_library"))
import projects  # noqa: E402  仓库内容视为数据, 只读 PROJECTS 列表

# ── A. 119 项注册表 ──────────────────────────────────────────────
# 已在 EPC-OVERSEAS webregistry 腿实采过的引擎 (ammo_pool/EPC-OVERSEAS/staging/webregistry/)
WIRED = {"searxng", "ddgs", "marginalia_search", "mwmbl", "yacy", "python_baidusearch",
         "jina_reader", "openverse", "searx_space", "tarzi", "cc_index_table"}

REG_OVERRIDES = {
    # id → (access, cn, fit)
    "perplexica__github_com": ("自托管开源(上游SearXNG+Ollama免key)", "GitHub直连可达(gh api实证)", "泛深度检索底座+新闻舆情(自托管Perplexity)"),
    "searxng__github_com": ("自托管免登录API(?format=json)", "GitHub直连可达(gh api实证)", "泛深度检索底座(70+引擎聚合);新闻舆情"),
    "gpt_researcher__github_com": ("自托管开源(LLM key自配)", "GitHub直连可达(gh api实证)", "调研编排引擎(深度报告产线);学术专利"),
    "storm_co_storm__github_com": ("自托管开源(LLM key自配)", "GitHub直连可达(gh api实证)", "调研编排引擎(维基式长文);学术专利"),
    "open_deep_research__github_com": ("自托管开源(LLM key自配)", "GitHub直连可达(gh api实证)", "调研编排引擎(breadth/depth迭代深挖)"),
    "deepresearch__github_com": ("自托管开源(Jina s.jina.ai可免key)", "GitHub直连可达(gh api实证)", "调研编排引擎(Search-Read-Reason循环)"),
    "paper_qa__github_com": ("自托管开源(LLM key自配)", "GitHub直连可达(gh api实证)", "学术专利(科学文献高精度RAG问答)"),
    "arxiv_py__github_com": ("免登录API封装(arXiv官方API)", "GitHub直连可达(gh api实证)", "学术专利(arXiv取数腿基础件)"),
    "cc_index_table__github_com": ("免登录API(Athena/SQL直查)", "GitHub直连可达(gh api实证)", "数据集(Common Crawl开放网页索引)"),
    "wayback_machine_downloader__github_com": ("免key CLI(gem)", "GitHub直连可达(gh api实证)", "数据集(Wayback存档整站回捞)"),
    "devdocs__github_com": ("免登录API(自托管)", "GitHub直连可达(gh api实证)", "数据集(100+官方文档站聚合检索)"),
    "openverse__github_com": ("免登录API(openverse.org)", "GitHub直连可达(gh api实证)", "数据集(开放媒体检索,图片/音频)"),
    "marginalia_search__github_com": ("免登录API(marginalia.com/public API)", "GitHub直连可达(gh api实证)", "泛深度检索(独立索引小语料站发现)"),
    "yacy__github_com": ("自托管免登录API(P2P)", "GitHub直连可达(gh api实证)", "泛深度检索底座(P2P分布式索引)"),
    "jina_reader__github_com": ("免登录API(r.jina.ai无key限额)", "GitHub直连可达(gh api实证)", "全文抽取底座(任意URL→LLM友好markdown)"),
    "markitdown__github_com": ("开源库(pip)", "GitHub直连可达(gh api实证)", "全文抽取底座(Office/PDF→Markdown归一)"),
    "docling__github_com": ("开源库(pip)", "GitHub直连可达(gh api实证)", "全文抽取底座(PDF布局解析,IBM)"),
    "trafilatura__github_com": ("开源库(pip)", "GitHub直连可达(gh api实证)", "全文抽取底座(网页主内容抽取)"),
    "meilisearch__github_com": ("自托管免登录API", "GitHub直连可达(gh api实证)", "数据集(本地语料秒搜底座)"),
    "typesense__github_com": ("自托管免登录API", "GitHub直连可达(gh api实证)", "数据集(本地语料检索底座)"),
    "opensearch__github_com": ("自托管免登录API", "GitHub直连可达(gh api实证)", "数据集(本地索引引擎底座)"),
    "flaresolverr__github_com": ("自托管服务(免key)", "GitHub直连可达(gh api实证)", "浏览器自动化底座(Cloudflare盾绕行)"),
    "changedetection_io__github_com": ("自托管服务(免key)", "GitHub直连可达(gh api实证)", "新闻舆情(站点变更盯哨/增量感知)"),
    "bochaai_bocha_search_mcp__github_com": ("需key(博查中文AI搜索API)", "中文原生(博查国内API)", "新闻舆情(中文网页/生态内容源)"),
    "evilran_baidu_mcp_server__github_com": ("免key MCP(百度直取内置限流)", "中文原生", "新闻舆情(百度网页SERP)"),
    "wechatsogou__github_com": ("免key库(pip,代码冻结2021)", "中文原生", "新闻舆情(搜狗微信文章,历史件)"),
    "python_baidusearch__github_com": ("免key库(零依赖)", "中文原生", "新闻舆情(百度SERP→JSON)"),
    "dailyhotapi__github_com": ("免登录API(自托管REST/RSS)", "中文原生", "新闻舆情(百度/知乎/微博热榜聚合)"),
    "wechat_article_search__github_com": ("免key CLI", "中文原生", "新闻舆情(公众号文章结构化)"),
    "sogou_weixin_mcp_server__github_com": ("免key MCP", "中文原生", "新闻舆情(搜狗微信→MCP)"),
    "aggregate_search_mcp__github_com": ("免key MCP(百度+必应+搜狗)", "中文原生", "新闻舆情(三引擎聚合+正文抓取)"),
    "tarzi__github_com": ("免key库(Rust,API-free多引擎)", "中文原生(含百度/搜狗引擎)", "泛深度检索底座(多引擎+缓存)"),
    "aas_ee_open_websearch__github_com": ("免key MCP(bing/baidu/sogou等)", "中文原生(含国内引擎)", "泛深度检索底座(中文引擎面独一档)"),
    "4get__git_lolcat_ca": ("自托管免登录API", "需代理7895(海外自托管)", "泛深度检索底座(代理元搜索)"),
    "metager__gitlab_metager_de": ("自托管免登录API", "需代理7895(海外自托管)", "泛深度检索底座(德国非营利元搜索)"),
    "searx_space__github_com": ("免登录API(instances.searx.space)", "需代理7895(海外站)", "数据集(SearXNG公共实例体检目录)"),
    "hister__github_com": ("自托管服务", "需代理7895(海外站hister.org)", "泛深度检索底座(searx作者回归作)"),
    "mwmbl__github_com": ("免登录API(mwmbl.org)", "需代理7895(海外站)", "泛深度检索底座(非营利自建索引)"),
    "stract__github_com": ("自托管服务", "需代理7895(海外站)", "泛深度检索底座(开源网页搜索引擎)"),
    "fess__github_com": ("自托管免登录API", "需代理7895(海外站,日系)", "数据集(企业站内搜索+爬虫)"),
}

CAT_DEFAULT_ACCESS = {
    "ai_search": "自托管开源(LLM key自配)",
    "metasearch": "自托管免登录API",
    "mcp_server": "免key MCP服务器",
    "key_required": "需key(API)",
    "zh_search": "免key(免登录直取)",
    "api_wrapper": "免登录API封装",
    "cli_tool": "免key CLI(pip/npm)",
    "crawler": "开源库/自托管",
    "awesome_list": "数据集(清单文档)",
}
CAT_DEFAULT_CN = {
    "ai_search": "GitHub直连可达(gh api实证)",
    "metasearch": "GitHub直连可达(gh api实证)",
    "mcp_server": "GitHub直连可达(gh api实证)",
    "key_required": "GitHub直连可达(仓库)/API需代理",
    "zh_search": "中文原生",
    "api_wrapper": "GitHub直连可达(gh api实证)",
    "cli_tool": "GitHub直连可达(gh api实证)",
    "crawler": "GitHub直连可达(gh api实证)",
    "awesome_list": "GitHub直连可达(gh api实证)",
}
CAT_DEFAULT_FIT = {
    "ai_search": "泛深度检索底座+新闻舆情(答案引擎)",
    "metasearch": "泛深度检索底座(多引擎聚合);新闻舆情",
    "mcp_server": "泛深度检索(MCP工具面,LLM管线直挂)",
    "key_required": "泛检索API;新闻舆情",
    "zh_search": "中文工程舆情;新闻舆情",
    "api_wrapper": "泛深度检索底座",
    "cli_tool": "泛深度检索底座(终端面)",
    "crawler": "全文抽取/浏览器自动化底座(渠道采集支撑)",
    "awesome_list": "数据集(检索渠道候选清单)",
}

def reg_entry(p):
    pid = p["id"]
    if p.get("cat") == "existing":
        return None  # 8项本地在册基础设施由渠道册面承接, 不重复登记
    ov = REG_OVERRIDES.get(pid)
    access, cn, fit = ov if ov else (
        CAT_DEFAULT_ACCESS.get(p.get("cat", ""), "开源项目"),
        CAT_DEFAULT_CN.get(p.get("cat", ""), "GitHub直连可达(gh api实证)"),
        CAT_DEFAULT_FIT.get(p.get("cat", ""), "泛深度检索底座"),
    )
    # 爬虫细分
    if p.get("cat") == "crawler":
        n = p["name"].lower()
        if any(k in n for k in ("playwright", "browser", "stagehand", "skyvern", "crawlee")):
            fit = "浏览器自动化底座(登录墙渠道采集)"
        elif any(k in n for k in ("markitdown", "docling", "trafilatura", "readability", "jina", "firecrawl", "scrapegraph")):
            fit = "全文抽取底座(研报资料归一)"
    note = p.get("note", "").replace("\n", " ")
    desc = note[:95] + ("…" if len(note) > 95 else "")
    m = re.search(r"([\d,.]+)\s*[kK]?★|([\d,.]+)\s*[kK]\s*stars|★\s*([\d,.]+[kK]?)", note)
    stars = m.group(0).strip() if m else ("registry in-file" if not note else "")
    return {
        "name": p["name"],
        "repo_or_site": p["url"],
        "desc": desc,
        "access": access,
        "cn_reachable": cn,
        "fit": fit,
        "stars_or_evidence": f"search_library注册表在册(1005 8角度扫描); {stars}" if pid not in WIRED
                             else f"search_library注册表在册+EPC-OVERSEAS webregistry腿已实采; {stars}",
        "source": "A.search_library注册表(119项)",
        "registry_id": pid,
        "cat": p.get("cat", ""),
        "tier": p.get("tier"),
        "managed": "已纳册(search_library渠道); " + ("引擎已接线实采" if pid in WIRED else "未接线=存量候选"),
    }

# ── B. channels_v2.json 在役渠道册 (工程研报适用面; 排除纯基建/个人画像) ──
CH = {
 # id: (repo_or_site, desc, access, cn, fit)
 "anysearch": ("https://github.com/anysearch-ai/anysearch-skill", "AnySearch实时搜索: web+垂直17域+并行批量+网页抽取, 匿名免鉴权10/窗", "免登录API(匿名限额10/窗,日限200)", "大陆直连实证(中文EPC查询3/3高相关)", "泛深度检索;新闻舆情(实时清单+垂直域)"),
 "baidu_netdisk": ("https://pan.baidu.com", "百度网盘BDUSS+离线下载: 102G裁判文书离线卷/git备份, 复刻件tools/baidu_bd_offline.py", "浏览器+登录态(BDUSS三层持久化)", "中文原生", "数据集(裁判文书语料/网盘存量)"),
 "chinatextbook": ("https://github.com/TapXWorld/ChinaTextbook", "全套教材语料库43.5GB/2087册(Trees API全树3112条)", "数据集(GitHub raw免登录,105KB/s)", "GitHub直连可达(raw慢,gh-proxy梯)", "数据集(K12全科教材语料)"),
 "cnki": ("https://kns.cnki.net", "CNKI官方线kns.cnki.net+PaperDown管线, 滑块解题器护航, 实测无日篇数限额(累计1100+篇)", "免登录API+滑块护航(浏览器回退)", "大陆直连", "学术专利(论文全文T1主腿)"),
 "court": ("https://wenshu.court.gov.cn", "涉诉检索: wenshu直采受限→metaso/websearch兜底必要性单查", "需key(metaso积分单查纪律)", "中文原生", "法律涉诉(工程纠纷线索)"),
 "damodaran": ("https://pages.stern.nyu.edu/~adamodar/New_Home_Page/datacurrent.html", "Damodaran数据集目录: 255个xls直链(行业均值/国家风险溢价年更)", "免登录API(静态目录直链)", "需代理7895(NYU海外站)", "数据集(估值对标免费基准)"),
 "deepweb": ("https://github.com/Auto-Manus", "深网官网爬虫线: official:deepweb引擎126,577字已入池(官网扩量腿)", "免登录API(自研爬虫)", "大陆直连", "项目数据(企业官网一手)"),
 "djyanbao": ("https://www.djyanbao.com", "洞见研报: 券商研报PDF/行业深度, VIP下载19/19实证可下", "浏览器(DrissionPage+VIP登录态)", "中文原生", "新闻舆情+数据集(券商研报T2)"),
 "ebook": ("https://github.com/jbiaojerry/ebook-treasure-chest", "中文电子书书单24071本/1000类目(ctfile直链已死,清单模式)", "数据集(本地索引+书单manifest)", "中文原生", "数据集(中文书目情报)"),
 "ebook_library": ("https://github.com/(111文章站+105ArcK扫荡站)", "电子书渠道族216站纳册: verified32+live123/blocked36(殆知阁正牌daizhigev20)", "免登录API(探活+tier1取数)", "混合(域封10站,wikisource等墙态如实记)", "数据集(公版书/古籍/标准全文公开面)"),
 "edgar": ("https://www.sec.gov/edgar/", "SEC EDGAR: company_tickers.json(10412家)→submissions CIK两步流, 0905实证全通", "免登录API(官方JSON)", "需代理7895(sec.gov海外)", "项目数据(美股披露,国际工程对标Jacobs/AECOM/Fluor)"),
 "eia": ("https://www.mee.gov.cn", "生态环境部环评渠道ywgz/hjyxpj(88KB/70条shtml SSR, 直连200)", "免登录API(GovListChannel基座)", "大陆直连(requests直连)", "项目数据(建设项目环评受理/审批公示)"),
 "engopp": ("https://github.com/(EngOpp-Mining)", "EngOpp-Mining商机挖掘浏览器桥接腿(夜班在役)", "浏览器(桥接)", "中文原生", "项目数据(工程商机)"),
 "factory_registry": ("https://github.com/(Auto_Manus/epc49_registry_night.py)", "工厂渠道注册表94模块/85源: 招投标/政策/年报/专利/标准/信用/工商/住建能源发改垂直, 18线夜扫", "免登录API(纯HTTP夜扫)", "大陆直连(海外线edgar/ofac/panjiva需代理)", "项目数据T1(招投标公告/中标公示/专利/标准/年报)+标准定额造价(standards线)"),
 "gbstandard": ("https://www.ebiaozhun.com", "国标GB/GB-T情报: eBiaozhun三步链search→pid→paystatus免登录, 0币件直下PDF", "免登录API(付费件如实报价)", "大陆直连", "标准定额造价(标准号情报+0币全文)"),
 "giiisp": ("https://giiisp.com", "集思谱论文检索: keyless英文arXiv/OA腿live(HTTP200真命中), 中文腿待token", "免登录API(英文腿keyless;中文腿需token)", "大陆直连", "学术专利(英文论文/OA全文线索)"),
 "govlist": ("https://github.com/(GovListChannel基座)", "政府名录线GovListChannel 9站: ggzy公共资源交易总枢纽/智招联合/市监处罚/交易商协会/铁路局/检察网", "免登录API(基座trust_env=False直连)", "大陆直连(chinabidding_cn详情405 WAF缓施)", "项目数据(公共资源交易/招投标公告T2)"),
 "ima": ("https://ima.qq.com", "ima知识库官方OpenAPI: 个人订阅KB检索+原文下载(总包知识库998电建词表39命中)", "需key(client_id+api_key用户凭证)", "大陆直连(ima.qq.com)", "数据集(知识库PDF原文,辅助面)"),
 "ima_public": ("https://ima.qq.com/wiki/", "ima公开知识库生态: 政策规范标准库25745条/招标采购4249/法律全集150329条, 222件/860.7万字已入池", "需key(同凭证族)+分享页SSR腿免登录", "大陆直连", "数据集(政策规范/招标/法律全文T2)"),
 "lark": ("https://www.feishu.cn", "飞书语料: lark-cli检索/导出+总包智库wiki存量(136583节点, kb:lark_zhiku_file 78312件/16.54亿字)", "需key(lark-cli device-flow授权)", "大陆直连", "数据集(智库成品/研报/战略文档,云端中枢)"),
 "last30days": ("https://github.com/mvanhorn/last30days-skill", "last30days近30天情报聚合: reddit/HN/polymarket/github/grounding keyless源", "免登录API(纯stdlib引擎,需代理)", "需代理7895(github/HN源直连超时;reddit 403数据中心墙)", "新闻舆情(近30日英文社媒热度)"),
 "localfiles": ("https://github.com/(PAIStation)", "本地文件库: MFT/USN增量索引296835文件, 提取缓存+夜间嵌入(22:00-06:00)", "本地CLI(无登录面)", "本地", "数据集(本地全类型文档盘点)"),
 "manus": ("https://manus.im", "Manus军团271账号池: research_plan/survey_plan/collect三用途, 97把JWT API直调100%有效", "需key(JWT令牌,API直调)", "需代理7895(必走代理,美国02出口)", "泛深度调研放大器(规划+collect)"),
 "media_group": ("https://github.com/(opencli路由)", "媒体情报组12线: 36kr过账791字judge=valid, weibo/zhihu登录墙, toutiao热榜public", "免登录API(36kr线)+浏览器(cookie线)", "中文原生", "新闻舆情T3(快讯/社媒)"),
 "metaso": ("https://metaso.cn", "秘塔学术搜索: curl_cffi impersonate=chrome过TLS指纹WAF, 必要性单查制", "需key(Bearer积分线)", "大陆直连", "学术检索+泛调研兜底"),
 "nb_library": ("https://github.com/(NB_MD_library_v2)", "NB MD资料库v2: 68卷/5328篇/5960万当量, stock:nb_library 3007.9万字全池第3引擎", "数据集(本地在盘)", "本地", "数据集(共性资料语料,报告初稿底料)"),
 "ofac": ("https://www.treasury.gov/ofac/downloads/sdn.csv", "OFAC SDN制裁名单全量CSV: 302→S3预签名,206 Range生效", "免登录API(数据集csv直下)", "需代理7895(treasury.gov)", "数据集(海外合规尽调底线证据)"),
 "opencli_bridge": ("https://github.com/(opencli)", "opencli活站桥接166站: 578COOKIE/342PUBLIC/175UI/25LOCAL/7INTERCEPT", "浏览器(playwright专用桥实例)", "混合(cookie站需登录态)", "泛深度检索底座+新闻舆情(多站路由)"),
 "panjiva": ("https://panjiva.com", "Panjiva海运提单: 海外供应链一手实证", "需key(商业库)", "需代理7895", "项目数据(供应链/海外工程物流)"),
 "pansou": ("https://github.com/fish2018/pansou", "网盘聚合发现服务(本地8888): 上游fish2018/pansou", "免登录API(本地服务)", "大陆直连", "数据集(网盘资源聚合发现)"),
 "policy_law": ("https://github.com/(idle7_statute)", "政策法规官方全文腿61_政策法规: 法规全量+idle7_statute", "免登录API", "大陆直连", "标准定额造价(法规全文)+项目数据(政策)"),
 "powerchina": ("https://bid.powerchina.cn", "电建系招标群76站(bid.powerchina.cn主入口): 中标/招标一手", "免登录API(76站爬线)", "大陆直连", "项目数据T1(电建系招投标)"),
 "quark_pan": ("https://pan.quark.cn", "夸克网盘账号线: 扫码授权+转存+目录+直链+签到", "浏览器+登录态", "中文原生", "数据集(网盘语料转运)"),
 "registry": ("https://github.com/(registry:*9线)", "registry聚合: bidding/cninfo/company_info/jzsc/nea/patents/sasac/standards/tcec 9引擎线", "免登录API", "大陆直连", "项目数据(招投标/年报/专利/标准)+学术专利(patents线)"),
 "rion": ("https://github.com/(rion-wechat-cli)", "rion微信情报hub: 本地微信聊天只读检索", "本地CLI(登录态)", "中文原生", "新闻舆情(私域信号/选题源)"),
 "rss_fleet": ("https://github.com/(We-AIPO OPML)", "RSS源常年收割905源微信公众号RSS", "免登录API(RSS拉取)", "大陆直连(部分源需代理)", "新闻舆情(公众号时效层)"),
 "search_library": ("https://github.com/searxng/searxng (+5引擎)", "网页搜索项目注册表119项: searxng/ddgs/yacy/mwmbl/marginalia/python_baidusearch六台引擎webregistry已实采", "免登录API(六台引擎)", "混合(国内引擎直连/海外需代理)", "泛深度检索底座(本清扫路A源)"),
 "sibling": ("https://github.com/(电建系8院)", "电建系兄弟院官网群8院(56_兄弟院): 设计院动态一手", "免登录API(官网爬线)", "大陆直连", "项目数据(设计院动态/项目案例)"),
 "sougo": ("https://weixin.sogou.com", "搜狗微信: SNUID门票+11段碎片拼接四段纯HTTP链, 复刻件replica/sogou_weixin_api.py全绿", "免登录API(复刻件,永久链局限在案)", "大陆直连", "新闻舆情(公众号文章面T1)"),
 "video": ("https://github.com/yt-dlp/yt-dlp", "视频文稿腿: yt-dlp bili/yt字幕转语料", "免登录CLI(yt-dlp)", "混合(bili直连/yt需代理)", "新闻舆情(视频文稿语料)"),
 "websearch": ("tool://websearch", "Claude内置WebSearch(配额制, 10-26重置)", "内置工具(配额)", "内置", "泛深度检索(英文面)"),
 "website": ("https://github.com/(官网爬虫)", "官网爬虫: 研究对象企业官网一手材料(official:deepweb承接)", "免登录API(爬虫)", "大陆直连(海外站需代理)", "项目数据(企业官网一手T1)"),
 "wechat_local": ("https://github.com/(wechat-cli)", "微信本地情报: wechat-cli 21命令只读检索本地微信库", "本地CLI(登录态)", "中文原生", "新闻舆情(私域一手)+选题源"),
 "wenchuanyun": ("https://wxy88.top", "文传云知网镜像全文PDF(wxy88.top↔ccki.top KNS8镜像)", "免登录API(镜像站)+浏览器", "大陆直连", "学术专利(知网全文镜像腿)"),
 "wenshu": ("https://wenshu.court.gov.cn", "裁判文书: BT全量卷+百度网盘102G离线卷(275先行件在盘)", "数据集(BT卷+网盘离线)", "中文原生", "法律涉诉(判决书语料)"),
 "weread": ("https://weread.qq.com", "微信读书: 整书提取book.json+md+docx(日限2本/节流5.5-12s)", "浏览器+登录态", "中文原生", "数据集(专业书籍整书语料)"),
 "zh_search_pro": ("https://github.com/careytian-ai/zh-search-pro", "免key中文六引擎: 必应中国/百度WAP/搜狗微信/360/知乎/头条+DDG(代理)", "免登录API(URL模板免key)", "中文原生", "泛深度检索(中文面主力)"),
 "70_开放网络": ("(战场目录70_开放网络聚合)", "开放网络泛搜落点线: 多生产腿命中件统一落此(0930实证12件13294字)", "免登录API(多腿聚合)", "大陆直连", "新闻舆情(开放网络兜底/线索层)"),
 "chinaca_eia": ("", "", "", "", ""),  # placeholder guard
}
SKIP = {"pool_ingest", "eoscar", "cli_stack", "dingtalk", "qqmail", "wecom", "tencent_docs",
        "wechat4", "browser360", "stock_campaign", "wechat_export_local", "wechat_official",
        "zbzk_wxy", "ima_plaza", "kb_harvest"}  # kb_harvest 由 D 面单列; 其余=基建/个人画像/removed

chans = json.loads((STATION / "ResearchFactory-Eng/EPC100/conductor/v2/channels_v2.json").read_text(encoding="utf-8"))["channels"]
ch_entries = []
for cid, meta in chans.items():
    if cid in SKIP or cid not in CH or not CH[cid][0]:
        continue
    site, desc, access, cn, fit = CH[cid]
    disp = meta.get("name", cid)
    ch_entries.append({
        "name": f"{disp}",
        "repo_or_site": site,
        "desc": desc,
        "access": access,
        "cn_reachable": cn,
        "fit": fit,
        "stars_or_evidence": f"channels_v2.json在册62渠之一; status={meta.get('status','')}; disposition={meta.get('disposition','')}",
        "source": "B.channels_v2.json(在役渠道册)",
        "registry_id": cid,
        "managed": "在役已纳管(工厂渠道体系)",
    })

# ── C. manifest-only 渠道 (B 缺的) ──
MANIFEST_ONLY = {
 "kb_harvest": ("https://github.com/(KB-HARVEST引擎)", "KB-HARVEST收割引擎: 1022三下载器全破译(Fish端点表+伤心paris_2030+BOS直链)", "免登录API(复刻件)", "大陆直连", "数据集(文库/文档站整库收割)"),
 "openalex": ("https://api.openalex.org", "OpenAlex学术API: 免key, 2.5亿+学术作品元数据", "免登录API", "大陆直连(api.openalex.org)", "学术专利(英文学术T1)"),
 "semantic_scholar": ("https://api.semanticscholar.org", "Semantic Scholar学术API(S2): 免key, 引文图+摘要", "免登录API", "大陆直连", "学术专利(引文网络)"),
 "arxiv": ("https://arxiv.org/api", "arXiv学术API: 免key官方API", "免登录API", "大陆直连(export.arxiv.org)", "学术专利(预印本全文)"),
 "dangdang": ("https://book.dangdang.com", "当当图书情报: 登录/详情/目录页(toc/intro md已在EPC-OVERSEAS实采)", "免登录API(图书情报面)", "大陆直连", "数据集(图书书目/目录情报)"),
 "metaso_kb": ("https://metaso.cn", "秘塔知识库专题(工程行业大脑25538件文件面): 匿名检索已通,下载面待owner凭据", "免登录API(检索)+需key(下载)", "大陆直连", "数据集(工程行业知识库专题T2)"),
}
man = json.loads((STATION / "ResearchFactory-Eng/channel_manifest.json").read_text(encoding="utf-8"))["named_channels"]
man_ids = {c["id"] for c in man}
for cid, (site, desc, access, cn, fit) in MANIFEST_ONLY.items():
    if cid not in man_ids:
        continue
    nm = next(c.get("name", cid) for c in man if c["id"] == cid)
    ch_entries.append({
        "name": nm, "repo_or_site": site, "desc": desc, "access": access,
        "cn_reachable": cn, "fit": fit,
        "stars_or_evidence": f"channel_manifest.json named_channels(35渠)在册",
        "source": "C.channel_manifest.json(named 35渠)", "registry_id": cid,
        "managed": "在役已纳管(工厂渠道体系)",
    })

# ── D. 逆向工程/ 复刻件 (未入渠道册的存量候选为主) ──
REX = [
 ("ENR 工程新闻记录(ENR.com Top 250)", "enr.com", "ENR国际工程榜: Cloudflare挑战纯HTTP不可过(如实), 替代源路线收官, 复刻件replica/enr_api.py", "浏览器(Cloudflare挑战)+替代源免登录API", "需代理7895(enr.com)", "项目数据(国际承包商250强排名,国际对标T1)", "逆向工程/enr-reverse/ 逆向报告+enr_api.py; 未入渠道册=存量候选"),
 ("喜鹊AI投标助手(千里马系标讯)", "https://www.xique.com", "喜鹊标书逆向: Tauri2.9.5+星火+Dify, Web版483模块明文已镜像, Ghidra工程在盘", "浏览器(客户端逆向,本地部署)", "中文原生", "项目数据(全国标讯/标书AI,千里马系数据蓝本)", "逆向工程/xique-reverse/ 15md+ghidra-proj; 未入渠道册=存量候选"),
 ("中国对外承包工程商会(chinca.org)", "https://www.chinca.org", "chinca加速乐/Aliyun WAF JS挑战纯HTTP复刻: chinca_api.py+solver.js 5/5会话贯通; 对外承包工程/劳务合作统计已实采入池", "免登录API(复刻件破WAF)", "大陆直连(加速乐已破)", "项目数据(对外承包工程统计T1, EPC-OVERSEAS已用)", "逆向工程/chinca-reverse/replica/; EPC-OVERSEAS staging/chinca实采; 未入渠道册"),
 ("国家标准全文公开系统(std.samr.gov.cn)", "https://openstd.samr.gov.cn", "国标清单/关键词批量PDF全链免登录: 检索API+Cache-Alive闸门+拼图重组, skill=std-samr-gb", "免登录API(全链复刻)", "大陆直连", "标准定额造价(国标全文T1, 与gbstandard互补)", "skill std-samr-gb在役; 逆向工程/std-samr/; 未入channels_v2册"),
 ("B站CC字幕API", "https://api.bilibili.com", "B站CC字幕渠道: bili_subtitle_api.py+扫码登录, SESSDATA只存data/secrets永不进仓", "需key(SESSDATA登录态)", "大陆直连", "新闻舆情(视频字幕语料,与video腿互补)", "逆向工程/bilibili-cc-reverse/replica/bili_subtitle_api.py; 未入渠道册"),
 ("Book118文档库(book118.com)", "https://book118.com", "Book118文档站复刻件: captures/replica/work三件套, kb_harvest覆盖面", "浏览器+复刻件", "大陆直连", "数据集(行业文档/模板下载)", "逆向工程/book118-reverse/; kb_harvest引擎覆盖"),
 ("Doc88文档库(doc88.com)", "https://www.doc88.com", "Doc88文档站复刻件: captures/replica/work三件套", "浏览器+复刻件", "大陆直连", "数据集(行业文档下载)", "逆向工程/doc88-reverse/; kb_harvest引擎覆盖"),
 ("百度文库搜索(wenku-search)", "https://wenku.baidu.com", "百度文库搜索逆向: KB-FACTORY Electron客户端app.asar已破, 复刻件贯通", "免登录API(复刻件)", "大陆直连", "数据集(文库文档面, 1024七渠道战役破译)", "逆向工程/wenku-search-reverse/; kb_harvest覆盖; 1024全渠道API化战役在案"),
 ("IMA批量下载助手(imima)", "https://ima.qq.com", "IMA批量下载助手逆向: 协议全解+replica/ima_replica.py整库下载实测可用", "需key(登录态)", "大陆直连", "数据集(ima知识库整库收割,ima渠道增强件)", "逆向工程/IMA下载助手/; ima-kb-harvest skill在役"),
 ("古德白Goodable(开源TS)", "https://github.com/goodable", "古德白逆向素材全量归档15md+10安装包+17仓库; Goodable开源TS源码在github/goodable", "数据集(源码镜像)", "GitHub直连可达", "泛深度检索底座(竞品研报工具复刻蓝本)", "逆向工程/古德白/ 15md+10安装包+17仓库"),
 ("易媒助手(多平台分发客户端)", "https://www.yimeizhushou.com", "易媒助手逆向: OPE传播引擎蓝本(易媒+千帆云底座), M1已落地", "浏览器(客户端)", "中文原生", "新闻舆情(发布链分发,非调研信源)", "逆向工程/易媒助手/; ope-engine在役"),
 ("识流AI助手(thiflow)", "https://shiliu.ai", "识流AI助手逆向结论: 纯RPA截图+YOLO+豆包视觉+拟人输入, 无朋友圈功能", "浏览器(RPA)", "中文原生", "非调研信源(方法论参考)", "逆向工程/extracted(thiflow结论md)"),
 ("WPS AI排版(AES模板)", "https://ai.wps.cn", "WPS AI排版逆向终局全清: AES密钥破城12/12模板解密+分发器四层链, 复刻件九轨道全绿(PentAGI@8443)", "需key(登录态+密钥破译)", "大陆直连", "非调研信源(报告排版产线件)", "逆向工程/wps-ai-paiban/; PentAGI上线8443"),
 ("微信PC 4.1.15(本地库)", "https://weixin.qq.com", "微信PC客户端4.1.15本地库逆向: wechat_local渠道支撑件", "本地CLI(登录态)", "中文原生", "新闻舆情(私域情报)", "逆向工程/wechat-pc-4.1.15/; wechat_local渠道覆盖"),
]
rex_entries = [{
    "name": n, "repo_or_site": s, "desc": d, "access": a, "cn_reachable": cn,
    "fit": f, "stars_or_evidence": ev,
    "source": "D.逆向工程/复刻件", "registry_id": "", "managed": m,
} for (n, s, d, a, cn, f, m, ev) in [(x[0], x[1], x[2], x[3], x[4], x[5], x[6], x[6]) for x in REX]]

# ── 合流去重 (name+site 归一小写) ──
seen, final = set(), []
for e in [*(reg_entry(p) for p in projects.PROJECTS), *ch_entries, *rex_entries]:
    if e is None:
        continue
    key = (e["name"].strip().lower()[:28], e["repo_or_site"].rstrip("/").lower())
    if key in seen:
        continue
    seen.add(key)
    final.append(e)

out = {
    "lane": "sweep_localregistry",
    "generated_at": "2026-10-25",
    "doc": "本地注册表清扫路: A.search_library注册表119项(111外部+8在册内部由渠道册承接) + B.channels_v2.json 62渠(45工程适用入账) + C.channel_manifest named 35渠(补6渠) + D.逆向工程/26目录复刻件(14条存量候选); 去重键=name[:28]+site",
    "count": len(final),
    "sources": {
        "A_注册表": {"path": "E:/AI-Station/ResearchFactory-Eng/EPC100/collectors/search_library/projects.py", "total": 119, "外部分类项": "111 (8项existing=本地在册基础设施, 由B/C渠道册面承接, 不重复登记)"},
        "B_在役渠道册": {"path": "E:/AI-Station/ResearchFactory-Eng/EPC100/conductor/v2/channels_v2.json", "total": 62, "入账": "45 (排除17: 纯基建/个人画像/removed)"},
        "C_named_manifest": {"path": "E:/AI-Station/ResearchFactory-Eng/channel_manifest.json", "total": 35, "新增入账": "6 (kb_harvest/openalex/semantic_scholar/arxiv/dangdang/metaso_kb)"},
        "D_逆向工程": {"path": "E:/AI-Station/逆向工程/", "total_dirs": 26, "入账": 14, "全量": "IMA下载助手,bilibili-cc,book118,chinca,cnki,dangdang,djyanbao,doc88,enr,manus,manus桌面端,metaso-kb,metaso,new-targets,sogou-weixin,std-samr,wechat-pc-4.1.15,wenku-search,work,wps-ai-paiban,xique,古德白,文库下载器,易媒助手,识流AI,逆向标的 (其中cnki/dangdang/djyanbao/metaso/metaso-kb/sogou/cnki类已由B面渠道册入账, D面只登记复刻件独有的存量候选)"},
    },
    "notes_extra": [
        "已实采引擎实证(未纳管→建议优先接线): ammo_pool/EPC-OVERSEAS/staging/webregistry/ 下11台引擎目录=cc_index_table/ddgs/jina_reader/marginalia_search/mwmbl/openverse/python_baidusearch/searx_space/searxng/tarzi/yacy",
        "未入任何渠道册的高价值存量候选Top5: ENR Top250(国际工程对标T1)/喜鹊标书-千里马系标讯/chinca对外承包统计/std-samr国标全文/B站CC字幕语料",
        "WebSearch MCP额度死(10-26重置)与reddit 403数据中心墙为如实限制记录",
    ],
    "projects": final,
}
OUT.write_text(json.dumps(out, ensure_ascii=False, indent=1), encoding="utf-8", newline="\n")
print("WROTE", OUT, "count=", len(final))
