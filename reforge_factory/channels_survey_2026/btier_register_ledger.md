# B级渠道接入·免费注册波子台账 (free_register 124条, 1026)

- 用户令: B级渠道全部接入调研渠道 | 本波=免费注册波 (免费宪法在役: 只走免费钥/免费注册/开放数据集, 付费面永不采购)
- 权威源: `btier_plan.json` bucket=free_register 全 124 条 (idx 14-233, 唯一名 123: BASE/HKEX披露易/百度学术 各2条)
- 方法: 纯HTTP零浏览器 (浏览器非必要不开铁律); 直连优先→代理兜底 7895/7890/7891/7893; UA=Chrome124; 探针件 `_scripts/btier_register_probe.py`(pass2件`btier_register_probe2.py`)
- 原始实测: `_raw/btier_register_probe.jsonl` (124行逐站实测) + `_raw/btier_register_probe2_retries.jsonl` (变体重试)
- 密钥纪律: 凭据只内存读用不打印; 本波动用 `secrets/baidu_bduss.ini`(百度指数/爱企查带凭据冒烟) 与既有 metaso 账号态; 未采购任何付费面; 未新建任何付费单
- 铁律遵守: 验证码/人机/短信/邮箱点击/扫码/OAuth 类一律不硬闯, 全部落用户动作清单; 台账只增未删任何文件

## 结论 (全实测, 零造假)

- attempted = **124** (free_register 124 条逐站真实探针)
- lit = **63** (免登录面冒烟通过=真点亮; 唯一站点口径 63/123)
- blocked_user_action = **29** (注册/登录卡点→用户动作清单, 见下)
- BLOCKED_ANTIBOT = 21 (反爬/风控拒答→浏览器腿候选, 非用户动作)
- FAIL_HTTP = 6 (SPA壳4+405/500各1, 纯HTTP不可判→浏览器腿/接口另探)
- DEAD = 5 (当日全路由不通/DNS失败, 复测再判)

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

## C. 反爬拦截 21 条 (BLOCKED_ANTIBOT, 浏览器腿候选, 非用户动作)

| idx | 渠道 | 实测 | 裁定 |
|-----|------|------|------|
| 74 | 启信宝 | https://www.qixin.com | 451 风控拒答(直连) - 浏览器腿候选 |
| 75 | 天眼查 | https://www.tianyancha.com | 419 页面过期式反爬(直连) - 浏览器腿候选 |
| 89 | ADB Projects & Statistics | https://www.adb.org/projects | antibot 403 via http://127.0.0.1:7893 |
| 113 | Ecosia | https://ecosia.org | antibot 403 via http://127.0.0.1:7893 |
| 139 | ISO Online Browsing Platform | https://www.iso.org/obp/ui | antibot 403 via http://127.0.0.1:7893 |
| 144 | LME官网延迟行情 | https://www.lme.com | antibot 403 via http://127.0.0.1:7893 |
| 148 | MillionShort | https://millionshort.com | antibot 403 via http://127.0.0.1:7893 |
| 161 | Phind | https://phind.com | antibot 403 via http://127.0.0.1:7893 |
| 162 | Presearch | https://presearch.com | antibot 403 via http://127.0.0.1:7893 |
| 184 | UNIDO Statistics | https://stat.unido.org | antibot 403 via http://127.0.0.1:7893 |
| 189 | Yep | https://yep.com | antibot 403 via http://127.0.0.1:7893 |
| 193 | 中国建设报/中国建设新闻网 | http://www.chinajsb.cn | http直连403 Forbidden - 浏览器腿候选 |
| 194 | 中国执行信息公开网 | https://zxgk.court.gov.cn | antibot 403 via http://127.0.0.1:7893 |
| 198 | 中施企协(中国施工企业管理协会) | http://www.cacem.com.cn | TCP通但服务端断连无响应(直连) - 浏览器腿候选 |
| 201 | 信用中国 | https://www.creditchina.gov.cn | 412 反爬(直连; 注册表已知'反爬412浏览器腿') - 浏览器腿候选 |
| 207 | 北大法宝免费面 | https://www.pkulaw.com | 567 非标拒答(直连) - 浏览器腿候选 |
| 210 | 国家企业信用信息公示系统 | https://gsxt.gov.cn | 403'请求异常'(代理)/直连SSL断 - 滑块验证码闸门, 浏览器腿候选 |
| 215 | 国家知识产权局专利检索系统 | https://pss-system.cponline.cnipa.gov.cn | 412 反爬(直连) - 浏览器腿候选 |
| 225 | 海关总署统计数据平台 | http://stats.customs.gov.cn | 412 反爬(直连) - 浏览器腿候选 |
| 228 | 百度学术 | https://xueshu.baidu.com | antibot 403 via http://127.0.0.1:7893 |
| 229 | 百度学术(免费发现层) | https://xueshu.baidu.com | antibot 403 via http://127.0.0.1:7893 |

## D. 纯HTTP不可判 6 条 (FAIL_HTTP)

| idx | 渠道 | 实测 | 裁定 |
|-----|------|------|------|
| 195 | 中国招标投标公共服务平台 | http://www.cebpubservice.com | GET 405拒(http/https/bulletin子站均405) - 浏览器腿候选 |
| 199 | 亚投行(AIIB) | https://www.aiib.org/en/projects/index.html | SPA壳 200/71B 纯HTTP无内容(Angular壳) - 浏览器腿/接口另探 |
| 205 | 全国水利建设市场监管平台 | http://xypt.mwr.cn | 500 服务端错误(直连,http同) - 复测/浏览器腿 |
| 206 | 北交所披露与市场数据 | https://www.bse.cn | SPA壳 200/345B 纯HTTP无内容 - 浏览器腿/接口另探 |
| 213 | 国家法律法规数据库(flk) | https://flk.npc.gov.cn | SPA壳 200/552B 纯HTTP无内容(Vue壳, 题名实) - 浏览器腿/接口另探 |
| 224 | 新三板(股转系统) | https://www.neeq.com.cn | SPA壳 200/345B 纯HTTP无内容 - 浏览器腿/接口另探 |

## E. 当日不可达 5 条 (DEAD, 复测再判)

| idx | 渠道 | 实测 | 裁定 |
|-----|------|------|------|
| 116 | EIC欧洲国际承包商 | https://eic.fiec.org | 全路由不通(直连SSL EOF+代理502/超时) |
| 145 | Magi | https://magi.com | 全路由不通(http 502 / https握手超时) |
| 160 | Petal Search | https://petalsearch.com | 全路由不通(SSL EOF+502) |
| 192 | 中国建筑业协会 | http://www.ecaci.org.cn | DNS解析失败(getaddrinfo) 当日不可达 |
| 203 | 全国公路建设市场信用信息管理系统 | https://glxy.mot.gov.cn | DNS解析失败(getaddrinfo) 当日不可达 |

## F. 特殊凭据账 (掩码)

- `baidu_bduss.ini`: BDUSS(193位, GM***qW)+STOKEN(65位) — 用于百度指数/爱企查带凭据探针; 爱企查免登录面200点亮; 百度指数页面200但功能面需浏览器腿验证(见用户动作#230)
- metaso: 既有账号(158***89)+api_key(mk-***E4)+kb会话 — 本波免登录面200点亮, 深度功能已有态在库
- zhipu.secret: api_key×2(4a***e0/c5***2k) 为API密钥, 非AutoGLM-Research web登录态(两回事, 勿混)
- 本波零新增密钥零新增账号(纯HTTP探针不落新secret); 全部卡点转用户动作清单

## G. 后续建议

1. BLOCKED_ANTIBOT 21条 + FAIL_HTTP 6条 → 下一波浏览器腿批量过闸(DrissionPage@--start-minimized独立口, 逐站冒烟后点亮)
2. USER_ACTION 29条中, 可批量化优先: SSRN/NCPSSD/NSTL/艾瑞/ucdrs(邮箱注册类, 若用户提供邮箱验证点击); rmfyalk/Coze/Kimi/Qwen/AutoGLM(手机短信类, 需用户在场)
3. Gemini/NotebookLM 生态已有谷歌工厂auth, 直接走浏览器腿复用, 勿重复注册
4. DEAD 5条次工作日复测一次再定弃留(数字零造假: 当日不通如实记)

