# B级免费钥申领波台账 (btier_freekey_ledger.md)

- **令**: B级96渠道全部接入调研渠道·免费钥申领波 (1026; 免费宪法在役: 只走免费钥/免费注册/开放数据, 付费面永不采购)
- **范围**: btier_plan.json `free_key` 桶 64 条 (同源合并后 42 个独立钥源) + 重点渠道 S2/CourtListener/OpenCorporates/ECB/NOAA/NASA/HF
- **网络面**: 直连优先→代理兜底 (7890/7891/7893 在听; **7895 已停** — 探针全轮次如实); 密钥永不进仓 (`data/` gitignore 第34行已核), 全文永不打印 (探针只记状态/长度/结构头)
- **本波数字**: attempted=18 渠道实测网络动作 | **lit=7 真点亮(冒烟通过+入池)** | blocked_user_action=44 钥源待用户注册/邮箱验证/控制台 (零硬闯, 如实列清单)
- 台账只增不删 (本件新建即增)

---

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

## ② 网络实测记录 (attempted=18 渠道, 含未点亮)

| 渠道 | 实测 | 判定 |
|---|---|---|
| ecb_sdw / courtlistener_recap / nasa_images / open_canada / compras_gov_br_pncp / noaa_nws / hn_algolia_api | 见① | LIT |
| noaa_ncei | /access/services/search/v1/data 三种参数形态 (searchTerm+pageSize / itemsPerPage / dataFormats=ISO-19115) 全 400 "Invalid search options" | 检索面停用疑, 如实; NOAA 由 noaa_nws 点亮 |
| nasa_firms | WMS GetCapabilities 404; 免key WMS 路径不在 | MAP_KEY 申领 (表单邮箱回执) → 用户动作 |
| core_api | 探针 direct 200 一次 (totalHits=3,039,301); 冒烟 429×2 (匿名限流窗口) | 渠道活, 正式免费 key (core.ac.uk/services/api 注册, 邮箱验证) → 用户动作提额 |
| data_gov_us_ckan | catalog.data.gov/api/3/action/package_search 四变体全 404 {"detail":{},"message":"Not Found"} | CKAN action 面平台迁移疑 (如实); api.data.gov 免费钥 (api.data.gov/signup 邮箱表单) → 用户动作 |
| opencorporates | 网页面 200 但=Google recaptcha challengepage (base href google.com/recaptcha) | 免key网页面被验证码闸; 研究/记者免费 key 申请 (opencorporates.com/api/accounts) → 用户动作 |
| us_census_bureau_api | 200 但 HTML "Missing Key" | key signup (api.census.gov/data/key_signup.html 邮箱回执) → 用户动作 |
| sam_gov | /sgs/v1/search 406→加 Accept:hal+json→400 "bad request" | 排除名单检索面收紧; Entity API 免费key (sam.gov/api-docs, login.gov 注册) → 用户动作 |
| not_human_search | /api/search 404 | 免费面形态待核 (registry 原判"未实测待核"维持) |
| semantic_scholar_api (S2) | direct/7890/7891/7893 全 429 "apply for a key for higher rate limits" | 匿名限流; 免费 key 表单 (semanticscholar.org/product/api#api-key-form, 页面实测200) → 用户动作 |
| courtlistener_register | /register/next/ 404 (注册页在 /register/) | 匿名面已点亮; token 提额=可选用户动作 |
| web_search_pro (智谱) | 双账号实测: api_key=HTTP429 code1113 "余额不足或无可用资源包"; api_key_2=200 但 search_result 恒空 (裸HTTP tools端点 `{model:web-search-pro}` + 官方SDK client.tools.web_search 两形态复测一致, usage completion_tokens=3000) | 免费面在现有双账号不可用 (新户免费额度类) → 用户动作: 开通 web-search-pro 资源包的账户或新户免费token账户; 腿已建 headers 形态在案 |

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

## ④ 产物清单 (只增)

- 新腿 7: `reforge_factory/legs/{ecb_sdw,nasa_images,core_api,open_canada,courtlistener_recap,compras_gov_br_pncp,noaa_nws}_leg.py` (编译门 7/7 绿)
- 桥表: `reforge_factory/legs/api_replica_bridge.py` HTTP_ENGINES +8 条 (备份 `api_replica_bridge.py.bak_1026_freekey_wave`)
- 探针: `channels_survey_2026/_freekey_probe_1026.py` + `_freekey_probe2_1026.py` (可复跑)
- 台账行: `ammo_pool/EPC-OVERSEAS/channel_invocations.jsonl` +6 行, `ammo_pool/EPC-JIAGE/channel_invocations.jsonl` +3 行 (hn×2, s2/core 429如实行); staging 留痕同口径
- 本台账: `channels_survey_2026/btier_freekey_ledger.md`

---

## ⑤ 免费钥申领波·第2轮 (1026 申领执行轮; 用户授权代填表单, 人机验证码/二次验证才请用户)

- **邮箱**: 51817@qq.com (qqmail-cli 只读轮询收件; 验证链接浏览器点掉)
- **浏览器**: DrissionPage@9341 最小化独立 profile (`_bigassets_local/dp_freekey_profile`) + 代理7890 (reCAPTCHA可达性), 严禁 9333/9222/9336/9337 ✓; 用完即清 (page.quit 实测 profile 进程 0 残留, 其余 chrome 属别会话未动)
- **付费禁令在役** (1026用户重申令): 一切信用卡/付款/付费计划面跳过列残留, 零付费才申

### 优先15源执行账 (attempted=15/15, 零硬闯零验证码突破)

| # | 渠道 | 结果 | 冒烟 | 残留/备注 |
|---|---|---|---|---|
| 3 | NASA FIRMS | **LIT**: MAP_KEY 申领成功(`/api/map_key_setup/` JSON POST→邮件回执) | ✓ mapkey_status 200 (5000 txn/10min) | nasa_firms.secret 落位 |
| 13 | GNews | **LIT**: 注册+邮箱验证+key | ✓ 200 命中3篇/total 113,894 | gnews.secret (免费层100req/天) |
| 6 | Tavily | **LIT**: Auth0注册+邮箱验证+key (dashboard `/api/keys` 流量截获, UI掩码件不可读) | ✓ 200 命中3条 | tavily.secret (免费1000积分/月) |
| 10 | US Census | key 落位 (邮件回执40hex) | ✗ 连续 Invalid Key=配额延迟 (双端点复测) | us_census.secret 待激活复测 |
| 1 | S2 Semantic Scholar | 表单提交成功 (HubSpot 全字段+5确认框, "Thank you! Your submission has been received!") | 待邮件 (官方backlog审) | key到件后落 s2.secret |
| 8 | EIA | 表单提交成功 (tos1=ToS全文textarea逐字提交, 响应"sent to your email") | 待邮件 (30min+未到) | 到件落 eia.secret |
| 15 | MetaGer | **付费化**: keys页现=一次性€5代币制 ("一次性付款"), 邮件免费key通道已撤 | - | 付费禁令跳过; 若坚持免费=放弃此源 |
| 2 | OpenCorporates | 墙: 全站对自动化客户端404 (`/api/accounts` 404, 浏览器+HTTP双证) | - | 用户动作 (真浏览器人工申请) |
| 4 | Brave | 墙: 注册表单滑块captcha未完成 (api-dashboard.search.brave.com/register) | - | 用户动作 (截图 shots_freekey_1026/brave_dash_after.png; pwd 已存) |
| 5 | Exa | 墙: 注册仅Google/Apple/Microsoft OAuth, 邮箱面=login-only ("account does not exist") | - | 用户动作 (OAuth需用户账号; 无绑卡要求但无邮箱注册路径) |
| 7 | SerpAPI | 墙: reCAPTCHA v2 可见挑战 (截图在案) | - | 用户动作 (pwd 已存) |
| 9 | FRED | 双重墙: api_key页强制 fredaccount 登录; Register=data-on-verify验证闸; 站点仅代理浏览器可达 (直连+3代理全超时) | - | 用户动作 (订阅误触发1封Welcome邮件, 无key) |
| 11 | UK Companies House | 墙: GOV.UK One Login 需安全码通道 (英国手机号/authenticator app) = 二次验证 | - | 用户动作 (铁律: 二次验证请用户) |
| 12 | Kaggle | 半墙: 邮箱注册表单可达已填, Next 客户端不前进; 新账号预期电话验证 | - | 用户动作 (pwd 已存) |
| 14 | NewsAPI | 墙: 完整表单两次提交均 "Your request was unsuccessful" = 反bot拒绝 (reCAPTCHA v3) | - | 用户动作 (pwd 已存) |

### 本轮数字 (零造假)
- **lit=3** (FIRMS/GNews/Tavily: key落位+冒烟命中) + **pending=3** (Census key待激活 / S2待审回执 / EIA待回执邮件) + **wall=8** (用户动作残留) + **paid-skip=1** (MetaGer付费化)
- secrets 新增 9 文件: 4 钥面 (us_census/nasa_firms/gnews/tavily) + 5 pwd面 (newsapi/serpapi/brave/exa/kaggle, 账号已建或半建)
- 桥表接线: `api_replica_bridge.py` HTTP_ENGINES +4 条 (us_census_api/nasa_firms/gnews/tavily, params/body 模板注明), ast 语法门绿
- 产物: 本节 + `shots_freekey_1026/` 截图16件 (墙证据) + `_freekey_form_recon*.py`/`_freekey_mail_harvest_1026.py`/`_freekey_dp_common_1026.py`/`_freekey_apply_eia_s2_1026.py` (可复跑) + `_s2_hsform_def_1026.json`
- 用户动作清单(8+1): OpenCorporates/Brave/Exa/SerpAPI/FRED/UK Companies House/Kaggle/NewsAPI 人工过闸; MetaGer 如需则付费(默认放弃)
