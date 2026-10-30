# B级接入总账 (B级96渠道全部接入调研渠道·终账)
生成: 2026-10-26 | 合并三波子台账: ① 集成台账.md (1025 登记波) ② btier_register_ledger.md (1026 免费注册波) ③ btier_freekey_ledger.md (1026 免费钥申领波)
权威源: MASTER_REGISTRY.json (620条) + btier_plan.json (B级分桶234) | 数字全实测 (脚本逐项复算, 断言通过): b_total=234 / lit_total=70 / user_actions=73 / paid_kept=25
口径说明: 用户令时点 B级=96 (集成台账 1025 22:10 记录); 同日 22:20 终局调和 MASTER_REGISTRY 全量重判四级 → **B级=234** (A=195/B=234/C=185/D=6 实测tier计数), 本总账按调和终态 234 计 (96→234 演进如实留痕)。

## 0. 终账四数 (全实测)
| 数 | 值 | 口径与实测依据 |
|---|---|---|
| **b_total** | **234** | MASTER_REGISTRY.json tier=B 实测计数 = btier_plan.json stats.total_B (双源一致) |
| **lit_total** | **70** | 免费钥波 7 引擎 + 免费注册波 63 条 (两波零重叠, 程序判重通过; 注册波域名去重62 — BASE双址1站) |
| **user_actions** | **73** | 免费钥波 44 钥源 + 免费注册波 29 卡点; 名称归一化与plan-idx双口径交集均=空 (去重后仍 44+29) |
| **paid_kept** | **25** | btier_plan bucket=paid_only 实数 (纯付费/订阅/机构订阅 — 留档不接入, 免费宪法在役零采购) |

## 1. B级234分桶账 (btier_plan.json, 依据 MASTER_REGISTRY tier=B 逐条 access 分型)
| 桶 | 条数 | 状态 |
|---|---|---|
| free_key 免费API钥可申领/免key开放API | 64 | ③波 attempted=18 网络动作, lit=7, 其余 44 钥源列用户动作 |
| dataset 开放数据集/文件直下/目录清单 | 21 | 未单列探针波 (A级 HTTP_ENGINES 134 已含数据集直下面; 本面待后续波) |
| free_register 免费账号注册/免登录网页免费面 | 124 | ②波 attempted=124 全量实测 (见下) |
| paid_only 纯付费/订阅/机构订阅 | 25 | 留档不接入 (paid_kept) |
| **合计** | **234** | 64+21+124+25 |

## 2. 三波子台账摘要
- **波① 登记波 (1025, 集成台账.md)**: SURVEY_ALIASES 终态 429 键 (A195+B234, 第二轮终局调和后); api_replica_bridge HTTP_ENGINES 134 + CLI 15; 腿批量建造 119 (编译门 119/119 绿); 登记≠接线 (named_channels 建渠走 T-015)。
- **波② 免费注册波 (1026, btier_register_ledger.md)**: free_register 124 条逐站纯HTTP探针 → attempted=124 = lit 63 + USER_ACTION 29 + BLOCKED_ANTIBOT 21 (浏览器腿候选) + FAIL_HTTP 6 + DEAD 5。
- **波③ 免费钥申领波 (1026, btier_freekey_ledger.md)**: free_key 64 桶 → 网络实测 18 渠道 (lit 7 + 停用疑/迁移疑/限流 11); 44 钥源列用户动作清单 (零硬闯零验证码突破); 新腿 7 件编译门 7/7 绿, HTTP_ENGINES +8。
- 横向: 铁律全程在役 — 免费宪法 (付费面永不采购) / 密钥永不进仓 / 台账只增不删 / 浏览器非必要不开。

## 3. 点亮清单 lit=70 (① 免费钥波 7 引擎 + ② 免费注册波 63 条, 逐条原表照录)
### 3a. 免费钥波 LIT=7 (纯HTTP冒烟通过+入池)
## ① 冒烟通过 = 7 渠道 (每渠道 1 查询, 纯HTTP零浏览器)

| 渠道 (engine) | 池 | 查询 | HTTP/通道 | 命中 | 入池 | 字数 | 台账行 |
|---|---|---|---|---|---|---|---|
| ecb_sdw (ECB SDW API) ★重点 | EPC-OVERSEAS | EXR/D.USD.EUR.SP00.A | 200 direct | 12 | 1件 | 3,429 | ✓ |
| courtlistener_recap (v4 API) ★重点 | EPC-OVERSEAS | construction contract dispute | 200 direct **匿名面**(count=1,526,866) | 8 | 1件 | 2,153 | ✓ |
| nasa_images (NASA Library API) ★重点NASA | EPC-OVERSEAS | construction site | 200 direct | 8 | 1件 | 7,431 | ✓ |
| open_canada (CKAN) | EPC-OVERSEAS | construction contract | 200 direct | 8 | 1件 | 7,507 | ✓ |
| compras_gov_br_pncp (巴西PNCP) | EPC-OVERSEAS | 20261001-20261020 | 200 direct (tamanhoPagina=10门槛: 3会400) | 8 | 1件 | 4,455 | ✓ |
| noaa_nws (api.weather.gov) ★重点NOAA | EPC-OVERSEAS | TX | 200 direct | 8 | 1件 | 2,444 | ✓ |
| hn_algolia_api (HN检索) ★重点HF线 | EPC-JIAGE | cost estimation software | 200 direct | 8 | 1件 | 5,774 | ✓ (首查 construction cost 8命中0字=URL去重非渠道故, 复查询实证入池) |

- hf_datasets (HuggingFace) 1025 波已冒烟入池在案 (本波不重复计数); NOAA 重点的 ncei 检索面实测 400 停用疑 → 本波以 NWS 官方面点亮 NOAA, 如实分流
- 配置: `reforge_factory/legs/api_replica_bridge.py` HTTP_ENGINES 新增 8 条 (.bak_1026_freekey_wave 先行; headers 参数在案: courtlistener=`Authorization: Token <key>`, core=`Authorization: Bearer <key>`, web_search_pro=`Authorization: Bearer <key>`+body model 字段); 薄腿 7 件新建 (ecb_sdw/nasa_images/core_api/open_canada/courtlistener_recap/compras_gov_br_pncp/noaa_nws), 编译门 7/7 绿
### 3b. 免费注册波 LIT=63 (免登录面冒烟200通过)
## A. 点亮 63 条 (LIT, 免登录面冒烟通过)

| idx | 渠道 | 实测面 | 证据 |
|-----|------|--------|------|
| 14 | DeepSearch (deepsearch.ing) | https://deepsearch.ing | free-face smoke 200/6690B via direct |
| 31 | IEA Data & Statistics | https://www.iea.org/data-and-statistics | free-face smoke 200/335690B via direct |
| 33 | JISC (日本产业标准调查会) | https://www.jisc.go.jp | free-face smoke 200/28625B via direct |
| 41 | Mojeek | https://mojeek.com | free-face smoke 200/6716B via direct |
| 69 | 中信保(Sinosure)国别风险公开面 | https://www.sinosure.com.cn | free-face smoke 200/30093B via direct |
| 70 | 中国水泥网 | https://www.ccement.com | free-face smoke 200/345970B via direct |
| 71 | 企查查 | https://www.qcc.com | free-face smoke 200/38871B via direct |
| 72 | 剑鱼标讯 | https://www.jianyu360.com | free-face smoke 200/357049B via direct |
| 73 | 千里马招标网 | https://www.qianlima.com | free-face smoke 200/333723B via direct |
| 76 | 建设通 | https://www.jianshe99.com | free-face smoke 200/279963B via direct |
| 77 | 必联网 | https://www.ebnew.com | free-face smoke 200/284028B via direct |
| 78 | 我的钢铁网 | https://www.mysteel.com | free-face smoke 200/400000B via direct |
| 80 | 比地招标网 | https://www.bidizhaobiao.com | free-face smoke 200/870B via direct |
| 82 | 爱企查(百度) | https://aiqicha.baidu.com | free-face smoke 200/13053B via direct |
| 83 | 百年建筑网 | https://www.100njz.com | free-face smoke 200/400000B via direct |
| 86 | 采招网 | https://www.bidcenter.com.cn | free-face smoke 200/59406B via direct |
| 87 | 360搜索(含360AI搜索) | https://so.com | free-face smoke 200/323174B via http://127.0.0.1:7890 |
| 88 | 4get | https://4get.ca | free-face smoke 200/1807B via direct |
| 90 | Anthropic Research (Claude) | https://www.anthropic.com/news/research | free-face smoke 200/400000B via direct |
| 99 | BASE | https://www.base-search.net | free-face smoke 200/7856B via http://127.0.0.1:7890 |
| 100 | BASE | https://base-search.net | free-face smoke 200/7856B via http://127.0.0.1:7890 |
| 101 | Bellingcat Online Investigation Toolkit | https://bellingcat.gitbook.io/toolkit | pass2: 200/400000B 真题名(gitbook) via direct |
| 102 | Bing | https://bing.com | free-face smoke 200/198522B via direct |
| 103 | BOAMP | https://www.boamp.fr | free-face smoke 200/80191B via direct |
| 104 | Boardreader | https://boardreader.com | free-face smoke 200/32930B via direct |
| 112 | EBRD项目数据库 | https://www.ebrd.com/work-with-us/procurement/projects-database.html | free-face smoke 200/268247B via direct |
| 121 | FIDIC国际咨询工程师联合会 | https://fidic.org | pass2: 200/101919B 真题名, challenge-platform仅脚本非拦截 via direct |
| 122 | FIEC欧洲建筑业联合会 | https://fiec.org | free-face smoke 200/216762B via direct |
| 130 | Google | https://google.com | free-face smoke 200/189020B via http://127.0.0.1:7890 |
| 134 | Google Scholar | https://scholar.google.com | free-face smoke 200/133818B via direct |
| 135 | Google Trends | https://trends.google.com | free-face smoke 200/400000B via direct |
| 143 | LibreY | https://github.com/Ahwxorg/LibreY | free-face smoke 200/319715B via direct |
| 149 | Mwmbl | https://mwmbl.org | free-face smoke 200/19682B via direct |
| 155 | OpenInfraMap | https://openinframap.org | free-face smoke 200/2217B via direct |
| 156 | OSINT Framework | https://osintframework.com | free-face smoke 200/8553B via direct |
| 165 | Qwant | https://www.qwant.com | free-face smoke 200/156982B via http://127.0.0.1:7890 |
| 168 | RSSHub | https://docs.rsshub.app | free-face smoke 200/16976B via http://127.0.0.1:7890 |
| 176 | Startpage | https://www.startpage.com | free-face smoke 200/22109B via http://127.0.0.1:7890 |
| 177 | Stract | https://stract.com | free-face smoke 200/45110B via direct |
| 178 | Swisscows | https://swisscows.com | free-face smoke 200/149990B via direct |
| 179 | Teclis | https://teclis.com | free-face smoke 200/15788B via direct |
| 181 | UK Contracts Finder | https://www.gov.uk/contracts-finder | free-face smoke 200/64855B via direct |
| 183 | UNGM联合国全球市场 | https://www.ungm.org/PublicTender | pass2: 根域 200/108370B 'Welcome to the UNGM' via direct (旧/PublicTender路径已404) |
| 188 | Yandex | https://yandex.com | free-face smoke 200/330748B via direct |
| 190 | 东方财富数据中心(免费网页面) | https://data.eastmoney.com | free-face smoke 200/373651B via direct |
| 191 | 中国人民银行公开数据 | http://www.pbc.gov.cn | free-face smoke 200/140923B via direct |
| 196 | 中国政府公报(国务院+地方) | https://www.gov.cn/gongbao | free-face smoke 200/898B via direct |
| 197 | 中国货币网(外汇交易中心) | https://www.chinamoney.com.cn | free-face smoke 200/13390B via direct |
| 202 | 全国公共资源交易平台 | https://www.ggzy.gov.cn | free-face smoke 200/67824B via direct |
| 208 | 商务部对外投资合作信息服务 | https://fec.mofcom.gov.cn | free-face smoke 200/53349B via direct |
| 209 | 四库一平台/全国建筑市场监管公共服务平台 | https://jzsc.mohurd.gov.cn | free-face smoke 200/5494B via direct |
| 214 | 国家电网电子商务平台 | https://ecp.sgcc.com.cn | free-face smoke 200/8996B via direct |
| 217 | 国家统计局国家数据 | https://data.stats.gov.cn | free-face smoke 200/3198B via direct |
| 218 | 国家能源局电力业务资质 | https://www.nea.gov.cn | free-face smoke 200/109170B via direct |
| 219 | 国铁采购平台 | https://cg.95306.cn | free-face smoke 200/182068B via direct |
| 220 | 地方产权交易所公告(代表:上海联交所) | https://www.suaee.com | free-face smoke 200/4061B via direct |
| 221 | 天工AI搜索 | https://www.tiangong.cn | free-face smoke 200/400000B via direct |
| 222 | 头条搜索 | https://so.toutiao.com | free-face smoke 200/4911B via direct |
| 223 | 建筑时报 | http://www.jzsbs.com | free-face smoke 200/29698B via direct |
| 226 | 港交所披露易 | https://www1.hkexnews.hk | free-face smoke 200/9168B via direct |
| 227 | 港交所披露易(HKEXnews) | https://www.hkexnews.hk/index_c.htm | free-face smoke 200/9184B via direct |
| 231 | 百度新闻 | https://news.baidu.com | free-face smoke 200/68455B via direct |
| 232 | 秘塔AI搜索(metaso) | https://metaso.cn | free-face smoke 200/149324B via direct |
## 4. 用户动作清单 (去重合计 73; 两波交集=空, 程序验证)
### 4a. 免费钥波 44 钥源 (blocked_user_action; 密钥落位 secrets/<渠道>.secret)
## ③ 用户动作清单 = 44 钥源 (blocked_user_action; 同源条目已合并, 零硬闯零验证码突破)

密钥一律存 `E:/AI-Station/data/secrets/<渠道名>.secret` (gitignored 已核), 每行一钥, 腿运行时读取:

| # | 渠道 (btier idx) | 用户动作 | URL | secret 落位 |
|---|---|---|---|---|
| 1 | ACLED (0) | 注册账号→申 API key (学术/非营利免费) | acleddata.com/register/ | acled.secret |
| 2 | BochaAI (4) | 注册赠免费额度 key | open.bochaai.com | bocha.secret |
| 3 | Brave Search (5/6/7/10 同源) | 注册→免费层2000次/月 key | api.search.brave.com/app/register | brave.secret |
| 4 | Copernicus (11) | 免费注册→API token | dataspace.copernicus.eu | copernicus.secret |
| 5 | CORE (12/108) | 注册免费 key (匿名限流提额) | core.ac.uk/services/api | core.secret |
| 6 | Dimensions (16) | 研究人员免费档注册 | app.dimensions.ai | dimensions.secret |
| 7 | ENTSO-E (18) | 注册→RESTful security token | transparency.entsoe.eu | entsoe.secret |
| 8 | Event Registry (19) | 免费层 key | eventregistry.org/register | eventregistry.secret |
| 9 | Exa (20/21/22 同源) | dashboard 注册免费额度 key | dashboard.exa.ai | exa.secret |
| 10 | Firecrawl (25) | 账号 key (免费500积分) | firecrawl.dev | firecrawl.secret |
| 11 | GNews (27) | 免费层100次/天 key | gnews.io/register | gnews.secret |
| 12 | Google CSE (28/29/49 同源) | GCP 控制台启用 Custom Search API key (100次/天) | console.cloud.google.com/apis/library/customsearch | google_cse.secret |
| 13 | IEEE Xplore (32) | developer.ieee.org 申请 key | developer.ieee.org | ieee.secret |
| 14 | Kaggle (34/35 同源) | 账号→settings 下载 kaggle.json | kaggle.com/settings | kaggle.secret (存 json 内 kaggle_key 一行) |
| 15 | Media Cloud (38/39 同源) | 免费研究 key 申请 | sources.mediacloud.org/#/register | mediacloud.secret |
| 16 | MetaGer (40) | 官方申请免费 key (非商业) | metager.de/keys | metager.secret |
| 17 | NASA FIRMS (42) | MAP_KEY 表单申领 (邮箱回执) | firms.modaps.eosdis.nasa.gov/api/map_key/ | nasa_firms.secret |
| 18 | NewsAPI.org (43) | 免费开发层 key (100req/天) | newsapi.org/register | newsapi.secret |
| 19 | NopeCHA (44) | 注册免费额度 key (验证码识别) | nopecha.com | nopecha.secret |
| 20 | OpenCorporates (46) | 研究/记者免费 key 申请 (API面; 网页面recaptcha闸在案) | opencorporates.com/api/accounts | opencorporates.secret |
| 21 | SearchApi.io (51) | 注册100次/月 key | searchapi.io | searchapi.secret |
| 22 | SerpAPI (30/53/54 同源) | 注册100次/月 key | serpapi.com/manage-api-key | serpapi.secret |
| 23 | Serper.dev (55) | 注册赠2500次 key | serper.dev | serper.secret |
| 24 | Tavily (56/57/58/59 同源) | 注册1000积分/月 key | app.tavily.com | tavily.secret |
| 25 | UK Companies House (62/84 同源) | 免费注册→API key | developer.company-information.service.gov.uk/get-started | companies_house.secret |
| 26 | UN Comtrade+ (63/182 同源) | 注册→订阅 key (免费层) | comtradeplus.un.org | comtrade.secret |
| 27 | WIPO PATENTSCOPE (65) | OPS 免费注册 key | developer.wipo.int | wipo_ops.secret |
| 28 | Wolfram Alpha (66) | 免费试用 AppID (2000次) | developer.wolframalpha.com | wolfram.secret |
| 29 | 智谱 web_search_pro (79) | 开通 web-search-pro 资源包的账户 (现有双账号 1113/空结果 实证在案②) | open.bigmodel.cn/usercenter/apikeys | web_search_pro.secret (或更新 zhipu.secret) |
| 30 | 火山方舟联网搜索 (81) | 方舟控制台 key (注册赠额度) | console.volcengine.com/ark | volcengine_ark.secret |
| 31 | data.gov.in 印度 (111) | 免费注册 API key | data.gov.in/help | data_gov_in.secret |
| 32 | EIA API v2 (115) | 注册 key (邮箱回执) | eia.gov/opendata/register.php | eia.secret |
| 33 | EPO OPS (118/119 同源) | 免费注册 OPS key | developers.epo.org | epo_ops.secret |
| 34 | FRED (124) | 免费 key 申请 (邮箱回执) | fred.stlouisfed.org/docs/api/api_key.html | fred.secret |
| 35 | Google Patents BQ (133) | GCP 项目+BigQuery 免费查询额度 | console.cloud.google.com/bigquery | google_patents_bq.secret |
| 36 | Lens.org (142) | 学术免费申请 key | lens.org | lens.secret |
| 37 | PatentsView (158) | 免费申请 key | search.patentsview.org/docs | patentsview.secret |
| 38 | SAM.gov (169) | login.gov 注册→Entity API 免费key (排除名单面406/400在案②) | sam.gov/api-docs | sam_gov.secret |
| 39 | Springer Nature (174) | 免费注册 key | dev.springernature.com | springer.secret |
| 40 | Tushare (180) | 注册免费积分 token (验证码类, 不硬闯) | tushare.pro/register | tushare.secret |
| 41 | US Census (185) | key signup 邮箱回执 (Missing Key 页实证②) | api.census.gov/data/key_signup.html | us_census.secret |
| 42 | USGS EarthExplorer (186) | ERS 注册→M2M API | ers.cr.usgs.gov | usgs_eros.secret |
| 43 | data.gov US (110) | api.data.gov 免费钥 (CKAN action 404 平台迁移疑在案②) | api.data.gov/signup | data_gov.secret |
| 44 | S2 Semantic Scholar (A级重点) | 免费 key 表单 (匿名429全出口在案②) | semanticscholar.org/product/api#api-key-form | s2.secret |

- CourtListener token (courtlistener.secret, `Authorization: Token` 头已配) 为**可选提额**项: 匿名面已点亮, 不计入 blocked
- 邮箱验证/验证码/控制台登录类一律列清单不硬闯 (铁律); 注册邮箱由用户定夺 (不代用户注册外部账户)
### 4b. 免费注册波 29 卡点 (注册/登录类, 零硬闯)
## B. 用户动作清单 29 条 (USER_ACTION, 注册/登录卡点不硬闯)

| idx | 渠道 | 注册/登录面 | 卡点与所需动作 |
|-----|------|-------------|----------------|
| 15 | DevelopmentAid | https://www.developmentaid.org/users/register | 免费层注册表单(邮箱) + 邮箱验证; 纯HTTP 403拒 - 需人工注册或提供账号 |
| 60 | Trendradar (technologieradar) | https://technologieradar.tryresearchly.com | 站点503不稳, 注册面未实测 - 复测后定 |
| 61 | TrueStar | https://truestar.tech | 网页服务未实测, 登录/注册面待人工核 |
| 64 | vladkens/twscrape | https://github.com/vladkens/twscrape | 开源自部署件, 需X账号cookie(非注册站) - 需用户提供X账号cookie或弃用 |
| 91 | AutoGLM-Research | https://autoglm-research.zhipuai.cn | 智谱账号手机号登录(zhipu.secret=API key 非web登录态) - 浏览器登录态收割(tencent-captcha-click技能)或人工登录 |
| 107 | Consensus | https://consensus.app | Google OAuth/邮箱注册 - 人工注册 |
| 109 | Coze Space | https://www.coze.cn | 扣子账号: 手机号/微信扫码登录 - 人工登录 |
| 117 | Elicit | https://elicit.com | Google OAuth注册 - 人工注册 |
| 123 | Flowith Oracle Mode | https://flowith.net | 邮箱/Google注册+邮箱验证 - 人工注册 |
| 125 | FutureHouse Platform | https://www.futurehouse.org | 申请制表单(FutureHouse Platform) - 人工申请 |
| 126 | Gemini Deep Research | https://gemini.google/overview/deep-research | Google账号(生态已有NBLM工厂auth美国02出口可复用) - 本波纯HTTP不点亮, 浏览器腿复用auth |
| 127 | Genspark Super Agent | https://www.genspark.ai | 邮箱/Google注册 - 人工注册 |
| 136 | Grok DeepSearch / Agents | https://grok.com | X/xAI账号登录 - 人工登录 |
| 137 | H2O.ai Deep Research | https://h2o.ai | 云产品账号注册/开源自托管二选一 - 人工注册或走开源件 |
| 141 | Kimi-Researcher | https://www.kimi.com | kimi账号手机号/微信登录 - 人工登录 |
| 146 | MGX | https://mgx.dev | 邮箱/Google注册 - 人工注册 |
| 151 | NotebookLM | https://notebooklm.google | 谷歌账号 - 生态已有NBLM工厂auth(1020实测26本在册)在役, 本波不重复注册, 纯HTTP不点亮 |
| 159 | Perplexity Deep Research | https://www.perplexity.ai | 账号注册(邮箱/Google) - 人工注册 |
| 166 | Qwen Deep Research | https://chat.qwen.ai | Qwen账号手机号登录 - 人工登录 |
| 167 | ResearchRabbit | https://www.researchrabbit.ai | Google OAuth/邮箱注册 - 人工注册 |
| 170 | SciSpace | https://scispace.com | Google/邮箱注册 - 人工注册 |
| 171 | Scite.ai | https://scite.ai | 邮箱注册+人机验证(实测captcha标记) - 人工注册 |
| 175 | SSRN(社科预印本平台) | https://www.ssrn.com/index.cfm | 邮箱注册(Elsevier, 人机+邮箱验证; 纯HTTP 403) - 人工注册 |
| 200 | 人民法院案例库(rmfyalk) | https://rmfyalk.court.gov.cn | 手机号注册+短信验证码 - 人工注册(或短信码代收) |
| 204 | 全国图书馆参考咨询联盟 | http://www.ucdrs.superlib.net | 免费注册文献传递(表单+验证码) - 人工注册 |
| 212 | 国家哲学社会科学文献中心(NCPSSD) | https://www.ncpssd.cn | 免费注册(手机/邮箱+验证码) - 人工注册 |
| 216 | 国家科技图书文献中心(NSTL) | https://www.nstl.gov.cn | 免费注册(表单) - 人工注册 |
| 230 | 百度指数 | https://index.baidu.com | 已有百度BDUSS登录态 - 浏览器腿验证即可点亮(无需新注册) |
| 233 | 艾瑞咨询免费报告面 | https://www.iresearch.cn | 微信扫码/邮箱注册(实测扫码/微信登录标记) - 人工注册 |
## 5. channel_matrix SURVEY_ALIASES 补同步 (只增, 本终账动作)
- 实测盘点: 234 B级渠道 id 已全量在 SURVEY_ALIASES (第二轮登记在案); 两处缺口 → 本账补齐:
  1. **+2 新键**: nasa_images / noaa_nws (免费钥波点亮引擎, 注册表无独立条目, 按「引擎id=渠道id」惯例新建, 入池 engine 标签直落渠道)
  2. **+19 域名别名**: 免费注册波点亮站点中域名别名缺失的 19 键 (mojeek.com/so.com/4get.ca/bing.com/boardreader.com/google.com/scholar.google.com/trends.google.com/mwmbl.org/qwant.com/docs.rsshub.app/startpage.com/stract.com/swisscows.com/teclis.com/yandex.com/tiangong.cn/so.toutiao.com/news.baidu.com; 碰撞检查零冲突后只增追加)
- 终态: SURVEY_ALIASES 429→**431** 键; CHANNEL_ALIASES 合并 461→**463** 键; .bak 先行 = completeness/channel_matrix.py.bak-1026-btotal-final
- 验证: py_compile 绿; resolve_engine 冒烟 12/12 (nasa_images/noaa_nws/19域名直命中, dangdang/metaso/ecb_sdw/hn_algolia_api 旧链路不回归)

## 6. 复算留痕
- 校验件: channels_survey_2026/_final_merge_check3.py + _alias_patch_dryrun.py + _alias_patch_apply.py + _resolve_smoke.py + _gen_bledger_final.py (本件, 幂等可重跑)
- 断言: B=234 双源一致; 桶 64/21/124/25; lit 63+7; UA 29+44 交集空; paid_only=25
