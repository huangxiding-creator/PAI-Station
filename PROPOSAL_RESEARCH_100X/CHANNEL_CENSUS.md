# 中国工程企业（EPC 工程总承包方向）尽调公开信息渠道普查（CHANNEL_CENSUS）

> 普查日期：2026-09-20 ｜ 普查员：渠道普查 agent ｜ 服务：双百倍提案 P1「渠道普查工程」
>
> **验证方法与诚实声明**：本次普查当日 WebSearch/webReader 检索配额耗尽（2026-09-26 重置），全部入口验证改用 **curl 直连实测**（状态码 + 页面标题，中国家庭宽带网络；国际站经本地代理 :7890），此法比搜索摘要更硬——状态码是目标服务器亲答。实测口径：`200/301/302=存活可达`；`403/412/521=存活但反爬（需浏览器态/Chrome MCP）`；`404/DNS失败=改版漂移或入口有误 → 标待验证`；`未实测 → 标待验证`。绝不编造 URL，不确定的一律标待验证。

---

## 一、总览数字

| 指标 | 数量 |
|------|-----|
| **渠道类总数** | **139** |
| 在位渠道类（已建 python 采集器） | 69（09-20 P1b 四批六站接入：ggzy/zzlh/samr_penalty/nafmii/railway_market/procuratorate，全部实弹落真文件；另 chinabidding_cn 注册缓施） |
| **新增缺口渠道类** | **70** |
| 其中：免费公开（免登录，含反爬需浏览器态） | 50 |
| 其中：免费需登录/强登录态 | 4 |
| 其中：付费 API/商业凭证 | 6 |
| 其中：待验证（入口漂移/分散/未实测） | 15 |
| 分类框架（尽调本体） | 15 大类 |
| 本日实测存活 URL | 66 个（≥20 要求达成，无编造） |

> **P1b 第一批接入实况（09-20 当日）**：SOP 四步全走——①探测锚点
> （ggzy 首页 17 公告锚点 SSR/zzlh 25 锚点 UTF-8/eco_penalty 栏目 JS 壳缓施/
> cebps·water_market·tzxm 缓施）②GovListChannel 子类双落地③五线接线
> （registry/DEFAULT_CHANNELS/CHANNEL_META/survey_runner/测试 expected set）
> ④守卫 11 测试+studio 11 测试全绿+实弹烟测（ggzy 落「NOx超低排放技改
> EPC总承包」公告/zzlh 落 4 份招标公告，EPC 关键词真命中）。

---

## 二、分类清单（15 大类，含在位与新增）

状态图例：`在位`=已有采集器 ｜ `★新建-免费`=免费公开待新建 ｜ `★新建-登录`=免费需登录 ｜ `★新建-付费`=付费API/凭证 ｜ `★待验证`=入口待确认。实测列为 2026-09-20 curl 状态码。

### 1. 工商主体与股权穿透（4：1 在位 + 3 新增）

| 渠道类 | 官方入口 | 覆盖维度 | 状态 | 实测 |
|--------|---------|---------|------|------|
| company_info | aiqicha.baidu.com（爱企查爬取） | 工商照面/股权/风险 | 在位 | 200 |
| gsxt | https://www.gsxt.gov.cn 国家企业信用信息公示系统 | 股东出资/变更/年报/经营异常/行政处罚（官方母库） | ★新建-免费（强反爬需浏览器态） | 521（存活，反爬盾） |
| tianyancha_api | https://open.tianyancha.com 天眼查开放平台 | 股权穿透图/司法风险/招投标/招聘聚合（提案缺口#4 点名） | ★新建-付费 | 302（开放平台存活） |
| qichacha_api | https://www.qcc.com 企查查 | 同上维度 + 资质/许可聚合 | ★新建-付费 | 200 |
| qixin | www.qixin.com 启信宝（未实测） | 同上维度 | ★待验证 | 未实测 |

### 2. 司法诉讼与仲裁（6：1 在位 + 5 新增）

| 渠道类 | 官方入口 | 覆盖维度 | 状态 | 实测 |
|--------|---------|---------|------|------|
| shixin | zxgk.court.gov.cn/shixin 失信被执行人 | 失信名单 | 在位 | 200 |
| wenshu | https://wenshu.court.gov.cn 裁判文书网 | 判决/裁定全文（施工合同纠纷、工程质量诉讼） | ★新建-登录（注册+限流；另有本地 102G BT 裁判文书存量可先离线） | 200 |
| zxgk_exec | https://zxgk.court.gov.cn 中国执行信息公开网 | 被执行人/限制消费/终本案件（shixin 超集） | ★新建-免费 | 301→200 |
| court_notice | https://rmfygg.court.gov.cn 人民法院公告网（09-20 探测：查询表单形态，列表在接口后，缓施） | 开庭/破产/清算/拍卖公告 | ★缓施-免费 | 200 |
| tingshen | https://tingshen.court.gov.cn 中国庭审公开网（09-20 探测：171KB 但检索应用形态，0 详情锚点） | 庭审录像/争点 | ★缓施-免费 | 200 |
| procuratorate | https://www.12309.gov.cn 中国检察网（首页 57KB SSR 18 锚点直出，已接入；案件信息公开为查询表单待深探） | 法律监督动态/公益诉讼/专项监督（企业红旗司法前哨） | ✅在位 | 200 |
| arbitration | https://www.cietac.org 贸仲 + http://www.bjac.org.cn 北仲（09-20 探测：贸仲 140KB 仅论坛栏目锚点，个案仲裁信息不公开——普查预判证实） | 仲裁程序公告/规则（工程仲裁主战场） | ★缓施-免费（公开信息有限） | 200 / 200 |

### 3. 信用与行政处罚（9：2 在位 + 7 新增）

| 渠道类 | 官方入口 | 覆盖维度 | 状态 | 实测 |
|--------|---------|---------|------|------|
| creditchina | creditchina.gov.cn 信用中国 | 联合惩戒/行政许可/处罚聚合 | 在位 | 在位 |
| mem_gov | mem.gov.cn 应急管理部 | 事故通报/监管处罚 | 在位 | 200 |
| safety_credit_list | https://www.mem.gov.cn 安全生产严重失信名单（mem_gov 补强专采） | 安全生产黑名单 | ★新建-免费（部分在位） | 200 |
| customs_credit | http://credit.customs.gov.cn 海关企业信用信息公示 | 海关注册/信用等级/失信（国际工程贸易面） | ★新建-免费（反爬需浏览器态） | 412（存活，反爬） |
| tax_credit_violation | https://www.chinatax.gov.cn（09-20 探测：首页 126KB SSR 但重大税收违法栏目锚点未现于首页，栏目级 URL 待深探） | 重大税收违法案件/纳税信用等级 | ★待验证 | 200（首页） |
| wage_blacklist | http://www.mohrss.gov.cn 人社部 + 信用中国欠薪栏目（09-20 探测：首页 986B JS 壳，栏目级 URL 待深探） | 拖欠农民工工资失信联合惩戒名单（EPC 业主/总包高压线） | ★缓施-免费 | 200（壳） |
| eco_penalty | https://www.mee.gov.cn 生态环境部行政处罚公示 | 环保处罚决定（环评在位 eia，处罚是缺口侧） | ★新建-免费 | 200 |
| env_disclosure | 企业环境信息依法披露系统（入口待验证） | 环境信息披露年报 | ★待验证 | 未实测 |
| samr_penalty | https://www.samr.gov.cn 市场监管总局（首页SSR直出处罚决定书 /zw/xzcfjd/art/，已接入；栏目页JS壳；个案查询WAF墙后待浏览器路径） | 行政处罚/垄断/质量抽查 | ✅在位 | 200 |

### 4. 招投标与公共资源交易（15：4 在位 + 11 新增）

| 渠道类 | 官方入口 | 覆盖维度 | 状态 | 实测 |
|--------|---------|---------|------|------|
| bidding | 比地招标（意图对齐搜索） | 招标公告聚合 | 在位 | 在位 |
| ccgp | ccgp.gov.cn 中国政府采购网 | 政采工程合同公告 | 在位 | 在位（C2 破墙） |
| sinopec | ec.sinopec.com 中石化物资采购 | 央企业主招标 | 在位 | 在位 |
| wbproj | 世界银行项目库 API | 国际项目 | 在位 | 在位 |
| cebps | http://www.cebpubservice.com 中国招标投标公共服务平台 | 全国招标公告/中标公示枢纽（**首页 JS 壳，公告面在 API 后，缓施**） | ★缓施-免费 | 200 |
| ggzy | https://www.ggzy.gov.cn 全国公共资源交易平台 | **30+省招标/中标/成交公告聚合总枢纽（首页 SSR 直出，已接入）** | ✅在位 | 200 |
| sgcc_ecp | https://ecp.sgcc.com.cn 国家电网电子商务平台（09-20 探测：首页 8.9KB SPA 壳，公告在 JS 后，缓施） | 电网工程招标/中标（输变电 EPC 主市场） | ★缓施-免费 | 200（壳） |
| csg_bidding | 南方电网阳光电子商务平台（bidding.csg.cn DNS 不解析，改版漂移） | 南网招标 | ★待验证 | DNS 失败 |
| zzlh | http://www.365trade.com.cn 中招联合招标采购网 | 央企采购聚合（UTF-8 SSR 直出，已接入） | ✅在位 | 200 |
| chinabidding_cn | https://www.chinabidding.com.cn 中国采购与招标网（列表 SSR 59 锚点可读；**详情页 405 WAF 浏览器态检测**——Referer/cookie/同主域三路全败，已注册默认关，破壁后再开） | 招标公告老牌门户 | ★缓施-免费 | 301→200 |
| telecom_bid | txzb.miit.gov.cn 通信工程招投标平台（DNS 不解析） | 通信工程招标 | ★待验证 | DNS 失败 |
| military_proc | 全军武器装备采购网/军队采购网（未实测） | 军队采购 | ★待验证 | 未实测 |
| soe_eproc | 央企电子采购平台族：中石油/国家电投/华能/大唐/中核/中广核/能建/电建（入口分散未实测，sinopec 已在位） | 央工业主招标公告 | ★待验证（一类多源） | 未实测 |
| qianlima | https://www.qianlima.com 千里马招标网 | 招标聚合/订阅推送 | ★新建-付费 | 200 |
| jianyu360 | https://www.jianyu360.com 剑鱼标讯 | 招标聚合 | ★新建-付费 | 301（存活） |

### 5. 资质许可与市场准入（12：2 在位 + 10 新增）

| 渠道类 | 官方入口 | 覆盖维度 | 状态 | 实测 |
|--------|---------|---------|------|------|
| jzsc | jzsc.mohurd.gov.cn 四库一平台 | 建筑企业资质/人员/业绩 | 在位 | 在位 |
| permit | permit.mee.gov.cn 全国排污许可证平台 | 排污许可 | 在位 | 200 |
| water_market | http://xypt.mwr.cn 全国水利建设市场监管平台 | 水利市场主体信用/资质/不良行为（水利 EPC 权威库） | ★新建-免费 | 200（标题实测「水利建设市场监管平台」） |
| highway_credit | glxy.mot.gov.cn 全国公路建设市场信用信息管理系统（DNS 不解析，可能改版） | 公路设计/施工/监理信用评价 | ★待验证 | DNS 失败 |
| railway_market | http://www.nra.gov.cn 国家铁路局（首页 89KB SSR 61 锚点直出，已接入） | 铁路建设市场资质/失信名单/规章 | ✅在位 | 200 |
| aviation_market | http://www.caac.gov.cn 中国民航局（09-20 探测：888B JS 壳） | 民航专业工程建设市场 | ★缓施-免费 | 200（壳） |
| special_equipment | https://cnse.samr.gov.cn/info-pub/pub 全国特种设备公示信息查询（09-20 探测：68KB 查询表单态，0 详情锚点） | 特种设备生产/使用公示（压力容器/起重机械） | ★缓施-免费 | 200 |
| safety_permit | 安全生产许可证查询（住建部+省级入口分散） | 安许证状态（jzsc 部分覆盖） | ★待验证 | 未实测 |
| power_license | 国家能源局资质中心 承装（修、试）电力设施许可（入口待验证） | 电力设施许可 | ★待验证 | 未实测 |
| trademark | https://sbj.cnipa.gov.cn 中国商标网（09-20 探测：44KB SSR 16 锚点可采，但为工作动态/典型案例流，企业级商标查询在表单后——低优先缓施） | 商标注册（品牌/出海商标布局） | ★缓施-免费 | 200 |
| software_copyright | https://www.ccopyright.com.cn 中国版权保护中心（09-20 探测：查询表单态，0 详情锚点） | 软著登记（数字化能力证据） | ★缓施-免费 | 200 |
| hightech_cert | http://www.innocom.gov.cn 高新技术企业认定管理工作网 | 高企名录（税收优惠/技术实力） | ★新建-免费 | 200 |

### 6. 监管批复与项目要素（14：10 在位 + 4 新增）

| 渠道类 | 官方入口 | 覆盖维度 | 状态 | 实测 |
|--------|---------|---------|------|------|
| ndrc / ndrc_pifu | 发改委 + 批复库 | 项目批复 | 在位×2 | 在位 |
| nea / mofcom / mot / mohurd / nnsa / eia / policy / sasac | 能源局/商务部/交通部/住建部/核安全局/环评/政策/国资委 | 各监管口批复与政策 | 在位×8 | 在位 |
| tzxm | https://www.tzxm.gov.cn 全国投资项目在线审批监管平台 | 项目审批/核准/备案结果（**EPC 项目源头**） | ★新建-免费 | 200（标题 JS 渲染） |
| land_market | https://www.landchina.com 中国土地市场网（09-20 探测：4.9KB JS 壳） | 土地出让/成交公示（业主拿地=项目储备） | ★缓施-免费 | 200（壳） |
| planning_publicity | 规划公示（自然资源部+地方规划局，入口分散） | 控规/修规公示 | ★待验证 | 未实测 |
| carbon_market | https://www.cneeex.com 上海环交所/全国碳市场（09-20 探测：59KB 但锚点标题为「查看详细」无信息量，列表需解析相邻文本——缓施） | 碳配额履约（重资产能耗证据） | ★缓施-免费 | 200 |

### 7. 财务证券债券 ESG（17：9 在位 + 8 新增）

| 渠道类 | 官方入口 | 覆盖维度 | 状态 | 实测 |
|--------|---------|---------|------|------|
| cninfo / chinamoney / shclearing / earnings_call / edgar / inquiry / irm / damodaran / panjiva | 巨潮/货币网/上清所/业绩会/SEC/问询函/互动易/估值/海关提单 | 财务资本面主力 | 在位×9 | 在位 |
| nafmii | https://www.nafmii.org.cn 交易商协会（首页 181KB SSR 58 锚点直出，已接入；回包 19s 级需 45s 超时） | 债务融资工具注册/披露（中票短融=EPC 巨头主流融资） | ✅在位 | 200 |
| chinabond | https://www.chinabond.com.cn 中国债券信息网（09-20 探测：383KB 但详情锚点 JS 装载，缓施） | 债券发行/兑付（违约预警） | ★缓施-免费 | 200 |
| sse | https://www.sse.com.cn 上交所（09-20 探测：62KB SSR 19 锚点为交易所新闻面；公司公告查询系统形态，披露主体已由 cninfo 在位覆盖——低增量缓施） | 上市披露（与巨潮互补的监管口径） | ★缓施-免费 | 200 |
| szse | https://www.szse.cn 深交所（09-20 探测：88KB 仅 3 新闻锚点，公告在查询系统——同 sse 低增量缓施） | 同上 | ★缓施-免费 | 200 |
| hkex | https://www.hkexnews.hk 披露易 | 港股披露（多数央企工程股两地上市） | ★新建-免费 | 302（存活） |
| esg_index | https://www.csindex.com.cn 中证指数 | ESG 评级/指数成分 | ★新建-免费 | 200 |
| customs_stats | http://stats.customs.gov.cn 海关统计数据平台 | 进出口贸易统计（国际 EPC 设备贸易） | ★新建-免费（反爬需浏览器态） | 412（存活，反爬） |
| financial_terminal | Wind 终端 / 东方财富 Choice（待验证） | 标准化财务数据库（多期对比/同业对标） | ★待验证（付费） | 未实测 |

### 8. 知识产权与科技成果（3：1 在位 + 2 新增）

| 渠道类 | 官方入口 | 覆盖维度 | 状态 | 实测 |
|--------|---------|---------|------|------|
| patents | 专利（专利检索/概览） | 专利 | 在位 | 在位 |
| sci_award | http://www.nosta.gov.cn 国家科学技术奖励工作办公室（09-20 探测：1.7KB 壳） | 国家科技奖名单（国家优质工程金奖/科技进步奖=技术背书） | ★缓施-免费 | 200（壳） |
| tech_registry | 国家科技成果登记（nast.org.cn 连接失败，入口漂移） | 成果登记库 | ★待验证 | 连接失败 |

### 9. 标准规范（3：2 在位 + 1 新增）

| 渠道类 | 官方入口 | 覆盖维度 | 状态 | 实测 |
|--------|---------|---------|------|------|
| standards / hbba | 国标 + 行业标准信息服务平台 | 国标/行标 | 在位×2 | 在位 |
| ttbz | https://www.ttbz.org.cn 全国团体标准信息平台 | 团体标准（中电联/勘协等主导的工程团标=技术话语权） | ★新建-免费 | 200 |

### 10. 行业数据与榜单（10：7 在位 + 3 新增）

| 渠道类 | 官方入口 | 覆盖维度 | 状态 | 实测 |
|--------|---------|---------|------|------|
| stats / tcec / cnea / pris / assoc / awards / luban | 统计局/中电联/核能协会/IAEA/三大工程协会/奖项/鲁班奖 | 行业统计与奖项 | 在位×7 | 在位 |
| enr | https://www.enr.com ENR | Top 250 国际承包商/Top 225 设计公司榜单（国际化能力标尺） | ★新建-免费（榜单页部分付费墙） | 200（经代理） |
| chinca | https://www.chinca.org 中国对外承包工程商会 | 对外承包营业额排名（ENR/CHINCA 双榜）/国别动态 | ★新建-免费 | 301→200 |
| industry_price | 我的钢铁 Mysteel / 兰格钢铁（入口待验证） | 钢材水泥价格（EPC 成本侧宏观） | ★待验证（付费） | 未实测 |

### 11. 新闻舆情与社媒（14：8 在位 + 6 新增）

| 渠道类 | 官方入口 | 覆盖维度 | 状态 | 实测 |
|--------|---------|---------|------|------|
| news / em_news / intl_news / wechat / sogou / video / rss / hacker_news | 百度新闻/东财/国际新闻/公众号/搜狗微信/B站/RSS/HN | 新闻舆情面 | 在位×8 | 在位 |
| xueqiu | https://xueqiu.com 雪球 | 机构/散户风险线索（暴雷前哨） | ★新建-登录（基础浏览免费） | 200 |
| guba | https://guba.eastmoney.com 股吧 | 散户舆情（欠薪/停工小道消息富矿） | ★新建-免费 | 200 |
| zhihu | https://www.zhihu.com 知乎 | 深度问答（员工/业主爆料） | ★新建-登录（搜索需登录态） | 302（存活） |
| weibo | https://weibo.com 微博 | 热点舆情（搜索降级可用） | ★新建-免费 | 302（存活） |
| douyin | https://www.douyin.com 抖音 | 短视频舆情（工地实拍/讨薪视频） | ★新建-登录（强反爬） | 200 |
| sph_video | 微信视频号（无公开 web 检索入口） | 短视频舆情 | ★待验证 | 未实测 |

### 12. 招聘用人（5：1 在位 + 4 新增）

| 渠道类 | 官方入口 | 覆盖维度 | 状态 | 实测 |
|--------|---------|---------|------|------|
| jobui | 职友集 | JD 聚合目录 | 在位 | 在位 |
| job51 | https://www.51job.com 前程无忧 | 招聘规模/岗位结构 | ★新建-免费（反爬） | 200 |
| boss_zhipin | https://www.zhipin.com BOSS直聘 | 同上（在招职位数=业务扩张先行指标） | ★新建-登录 | 302（存活） |
| zhaopin | https://www.zhaopin.com 智联招聘 | 同上 | ★新建-免费（反爬） | 200 |
| liepin | https://www.liepin.com 猎聘 | 高端岗位（总工/项目经理缺口=在 build 什么能力） | ★新建-免费 | 200 |

### 13. 学术研究与文献（9：全部在位，本轮无新增）

cnki / cnki_direct / shutong（书童图书馆）/ wenchuanyun（文献云 wxy88.top）/ arxiv / academic_en（Semantic Scholar+OpenAlex）/ dangdang / djyanbao（洞见研报）/ vip（维普，已退役）——文献层 64 类中最厚的部分，无缺口。

### 14. 国际合规与制裁（5：全新增）

| 渠道类 | 官方入口 | 覆盖维度 | 状态 | 实测 |
|--------|---------|---------|------|------|
| wb_sanctions | 世行除名企业页（09-20 探测：worldbank.org/projects 版/bancomundial 版/搜索 API 三 URL 全 404，**页面已漂移**，需页内检索重定位） | 世行制裁名单（含大量中资工程企业，海外投标一票否决项） | ★待验证 | 404×3 |
| ofac_sdn | https://sanctionssearch.ofac.treas.gov OFAC SDN 搜索 | 美国制裁名单（美元结算风险） | ★新建-免费 | 200（经代理） |
| adb_sanctions | https://www.adb.org/who-we-are/integrity 亚开行廉政（制裁列表子页漂移待验证） | 亚开行制裁 | ★待验证（主站存活） | 200（经代理） |
| fcpa_enforcement | SEC/DOJ FCPA 执法（子页 404 漂移；www.justice.gov 存活） | FCPA 反腐执法（海外工程代理风险） | ★待验证 | justice.gov 200 / 子页 404 |
| eu_sanctions | https://www.sanctionsmap.eu EU 制裁地图 | 欧盟制裁 | ★新建-免费 | 200（经代理） |

### 15. 项目库与会展会议（4：全新增）

| 渠道类 | 官方入口 | 覆盖维度 | 状态 | 实测 |
|--------|---------|---------|------|------|
| cpppc | https://www.cpppc.org 财政部 PPP 中心（全国 PPP 综合信息平台） | PPP 项目库（EPC+O 投资类项目池） | ★新建-免费（反爬需浏览器态） | 403（存活，反爬） |
| expo | https://www.cantonfair.org.cn 广交会 + https://www.ciie.org 进博会 | 参展商名录/新品（海外业务触角） | ★新建-免费 | 200 / 200 |
| rural_projects | 乡村振兴项目库（全国统一公开入口未找到，多为省级） | 乡村振兴项目 | ★待验证 | 未实测 |
| gov_meeting | https://www.gov.cn 中国政府网（国务院常务会议/政策吹风） | 会议纪要与重大工程定调（gov_list/policy 部分在位） | ★新建-免费（部分在位） | 200 |

---

## 三、缺口优先级（75 个新增，按接入难度排序）

### 第一梯队：免费公开·免登录（50 个）——零成本即插即用，P1b 首批

**核心合规组（尽调红旗直接来源，优先做）**
1. zxgk_exec 执行信息公开（被执行人/限高/终本）
2. court_notice 法院公告网（破产/清算/拍卖）
3. tingshen 庭审公开网
4. procuratorate 检察网 12309（单位行贿/犯罪）
5. samr_penalty 市场监管总局处罚
6. eco_penalty 生态环境部处罚
7. wage_blacklist 欠薪失信名单（人社部+信用中国）
8. tax_credit_violation 税收违法/纳税信用
9. safety_credit_list 安全生产严重失信名单

**招投标业绩组（EPC 订单与对手盘核心，优先做）**
10. ggzy 全国公共资源交易平台（总枢纽，✅已接入 09-20）
11. cebps 中国招标投标公共服务平台（JS 壳缓施）
12. zzlh 中招联合（央企聚合，✅已接入 09-20）
13. sgcc_ecp 国网电商平台
14. chinabidding_cn 中国采购与招标网
15. arbitration 贸仲/北仲

**行业资质组（对口主管部门权威库，优先做）**
16. water_market 水利建设市场监管平台
17. railway_market 国家铁路局
18. aviation_market 民航局
19. special_equipment 特种设备公示
20. trademark 商标网 ｜ 21. software_copyright 软著 ｜ 22. hightech_cert 高企名录

**项目与要素组**
23. tzxm 投资项目在线审批平台 ｜ 24. land_market 土地市场网 ｜ 25. carbon_market 全国碳市场
26. cpppc PPP 项目库（反爬需浏览器态） ｜ 27. gov_meeting 政府网 ｜ 28. expo 广交会/进博会

**财务证券组**
29. nafmii ｜ 30. chinabond ｜ 31. sse ｜ 32. szse ｜ 33. hkex ｜ 34. esg_index ｜ 35. customs_stats（反爬需浏览器态）｜ 36. sci_award ｜ 37. ttbz ｜ 38. enr ｜ 39. chinca

**舆情招聘组**
40. guba 股吧 ｜ 41. weibo 微博 ｜ 42. job51 ｜ 43. zhaopin ｜ 44. liepin
**反爬但免费（需 Chrome MCP 浏览器态，技术上是免登录族）**
45. gsxt 工商公示（股权穿透母库） ｜ 46. customs_credit 海关信用 ｜ 47. xueqiu 雪球（基础浏览）
**国际免费组**
48. wb_sanctions 世行制裁 ｜ 49. ofac_sdn OFAC ｜ 50. eu_sanctions EU 制裁地图

### 第二梯队：免费需登录/强登录态（4 个）

51. wenshu 裁判文书网（注册+限流；建议先接本地 102G BT 存量离线索引，再补增量）
52. douyin 抖音 ｜ 53. zhihu 知乎（搜索态） ｜ 54. boss_zhipin BOSS直聘

### 第三梯队：付费 API/商业凭证（6 个）——需预算或商务授权

55. tianyancha_api 天眼查开放平台（提案缺口#4 点名，股权穿透+风险聚合一站式，首选）
56. qichacha_api 企查查 ｜ 57. qianlima 千里马 ｜ 58. jianyu360 剑鱼标讯 ｜ 59. industry_price 我的钢铁/兰格 ｜ 60. financial_terminal Wind/Choice（financial_terminal 若无预算可后置）

### 待验证组（15 个）——先补入口侦查再定梯队

61. csg_bidding 南网电商（DNS 失败） ｜ 62. telecom_bid 通信招标平台（DNS 失败） ｜ 63. highway_credit 公路信用系统（DNS 失败） ｜ 64. military_proc 军队采购 ｜ 65. soe_eproc 央企采购平台族 ｜ 66. safety_permit 安全生产许可证 ｜ 67. power_license 承装修试许可 ｜ 68. planning_publicity 规划公示 ｜ 69. env_disclosure 环境信息披露系统 ｜ 70. tech_registry 科技成果登记 ｜ 71. sph_video 视频号 ｜ 72. rural_projects 乡村振兴项目库 ｜ 73. adb_sanctions 亚开行制裁列表子页 ｜ 74. fcpa_enforcement SEC/DOJ FCPA 子页 ｜ 75. qixin 启信宝

> 三个 DNS 失败站（csg/txzb/glxy）大概率是改版换域名，用 Chrome MCP 开标签页走 Bing 检索即可定位新址（cn-statute-official-fetch 记忆中有同款打法）。

---

## 四、在位 64 类归类表（尽调本体框架）

| 尽调本体分类 | 在位渠道类（采集器名） | 数量 |
|-------------|----------------------|-----|
| 工商主体 | company_info（爱企查爬取） | 1 |
| 司法诉讼 | shixin（失信被执行人） | 1 |
| 信用处罚 | creditchina, mem_gov（应急部事故/处罚） | 2 |
| 招投标 | bidding（比地）, ccgp（政采）, sinopec（中石化采购）, wbproj（世行项目库） | 4 |
| 资质许可 | jzsc（四库一平台）, permit（排污许可） | 2 |
| 监管批复 | ndrc, ndrc_pifu, nea, mofcom, mot, mohurd, nnsa, eia（生态环境部环评）, policy, sasac | 10 |
| 财务证券 | cninfo, chinamoney, shclearing, earnings_call, edgar, inquiry（问询函）, irm（互动易）, damodaran, panjiva（海关提单） | 9 |
| 知识产权 | patents | 1 |
| 标准规范 | standards（国标）, hbba（行业标准信息服务平台） | 2 |
| 行业数据榜单 | stats, tcec（中电联）, cnea（核能协会）, pris（IAEA）, assoc（三大工程协会）, awards, luban（鲁班奖） | 7 |
| 新闻舆情 | news（百度新闻）, em_news, intl_news, wechat, sogou, video（B站）, rss, hacker_news | 8 |
| 招聘用人 | jobui（职友集） | 1 |
| 学术研究 | cnki, cnki_direct, shutong（书童图书馆）, wenchuanyun（文献云）, arxiv, academic_en, dangdang, djyanbao, vip（维普·退役） | 9 |
| 工具聚合 | deep_crawl, website, gov_list, metaso, metaso_free, feishu, wiki_intl | 7 |
| **合计** | | **64** |

> 注：eia 在位采集器实测是「生态环境部环评」而非美国 EIA；hbba 是「行业标准信息服务平台」而非河北渠道——两条命名易误读，已实读适配器 docstring 纠正。文献层（学术研究 9 类）是 64 类中最厚部分，本轮无新增缺口。

---

## 五、待验证清单与后续动作

1. **DNS 失败三站**（南网/通信招标/公路信用）：Chrome MCP + Bing 检索定位新域名（复用 cn-statute-official-fetch 工艺）。
2. **国际子页漂移两处**（ADB 制裁列表、SEC/DOJ FCPA 页）：主站均存活，子页 404，检索定位新路径。
3. **分散入口四处**（安全生产许可证/承装修试许可/规划公示/环境信息披露）：确认是否值得做统一聚合器，或并入 gov_list 基座。
4. **乡村振兴项目库**：未找到全国统一公开入口，建议降级为省级试点（待用户裁决是否保留该类）。
5. **WebSearch 配额 2026-09-26 重置后**：对待验证组 15 类补一轮检索验证，更新本表实测列。
