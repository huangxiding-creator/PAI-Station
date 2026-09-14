# -*- coding: utf-8 -*-
"""Build _all.json for docket 10 (OSS ecosystem business cases). Data collected 2026-09-13.
First-hand sources: GitHub REST API (gh CLI), HN Algolia API, api.npmjs.org, wordpress.org,
clawhub.com, dify.ai/pricing, openrouter.ai/api. No fabricated numbers; unknown -> 0/unknown."""
import json, io

E = []  # entries

def add(name, cat, stars, model, fly, rev, lesson, url, rel):
    E.append({
        "name": name, "category": cat, "stars": stars,
        "model": model, "ecosystem_flywheel": fly,
        "revenue_evidence": rev, "lesson_for_pai": lesson,
        "evidence_url": url, "relevance": rel})

# ============ open-core (13) ============
add("GitLab", "open-core", 24537,
    "CE 开源 + EE 付费 + .com SaaS，全部远程公司 handbook 公开",
    "开发者自建 CE 入门 → 功能天花板倒逼升级 EE/云；贡献者可转雇员（handbook 公开招聘链路）",
    "2018 年收入 $10.5M（HN 18441768）；现为上市公司 NASDAQ:GTLB，最新财年收入亿美元级（本轮 SEC API 拉取 404，未一手复核）",
    "社区版功能天花板要清晰可感知但不羞辱；PAI 技能市场可做「个人免费、团队/商用收费」的天然分界",
    "https://github.com/gitlabhq/gitlabhq", 4)
add("Supabase", "open-core", 109092,
    "全栈开源 Postgres 平台，自托管免费 → Supabase 云托管付费",
    "每个功能都开源 → 开发者用爱发电传播 → 自托管烦恼转化为云订单；生态 24,032 个 topic:supabase 仓库",
    "$200M Series D，$2B 估值（2025-04，HN 43763225）",
    "「开源即获客、托管即变现」的标准剧本；PAI 本地优先但可留一个零配置云备份/同步付费位",
    "https://github.com/supabase/supabase", 5)
add("PostHog", "open-core", 39762,
    "产品分析+AI 可观测 one-stop，MIT 核心 + 企业功能付费",
    "开发者带 bugs/roadmap 公开运营，社区 issue 直接变产品需求；自部署免费换口碑",
    "早期公开写「为开源项目融资 $3M」（HN 23426662），后累计多轮融资，收入未公开",
    "公开 build in public 换取开发者信任，是低预算生态冷启动的最佳杠杆",
    "https://github.com/PostHog/posthog", 4)
add("Mattermost", "open-core", 39047,
    "自托管安全协作（Slack 替代），团队版开源 + 企业版付费",
    "合规/军政场景自托管刚需 → 按席位买企业功能（合规审计、SSO）",
    "$50M Series B（2019，HN 20382018）",
    "「自托管免费」可以本身就是卖点（数据主权）；PAI 的本地优先卖点同源",
    "https://github.com/mattermost/mattermost", 3)
add("Cal.com / cal.diy", "open-core", 48414,
    "排程基础设施 AGPL open-core；2026-04 宣布闭源，社区 6 天内分叉 cal.diy 续命",
    "飞轮反例：VC 驱动烧钱补贴开源 → 商业化不达预期 → 闭源 → 社区 fork（cal.diy 259pts）接管开源版",
    "2026-04-15 「Cal.com is going closed source」（391pts，HN 47780456）；社区版分叉 cal.diy（HN 47852155）",
    "AGPL+CLA 是双刃剑：闭源当天社区就能合法分叉；PAI 技能市场规则要一开始写死「谁拥有什么」，避免日后翻脸成本",
    "https://github.com/calcom/cal.diy", 5)
add("Typebot", "open-core", 10315,
    "独立开发者（baptisteArno）的聊天机器人搭建器：self-host 免费 + 云订阅",
    "一人公司用开源获取分发，云订阅变现，功能路线由社区 issue 驱动",
    "Show HN 2022（HN 30811499）；具体收入 unknown（独立开发者未公开）",
    "indie 开发者可持续样本：开源=全球分发渠道，不需要销售团队；PAI 技能作者可以复制此模式",
    "https://github.com/baptisteArno/typebot.io", 4)
add("Strapi", "open-core", 73135,
    "开源 headless CMS + Strapi Cloud",
    "自托管开发者 → 云/企业版；插件生态由社区贡献",
    "$4M 融资（2019，HN 21260968），后续多轮，收入 unknown",
    "CMS 红海里靠开源拿下分发；差异化场景比功能堆叠重要",
    "https://github.com/strapi/strapi", 3)
add("Odoo", "open-core", 54321,
    "开源 ERP：社区版 LGPL + 企业版 + 官方托管，One App Free 策略（一个应用永久免费）",
    "一个免费 app 引流 → 装第二个 app 开始付费 → 生态伙伴（实施商）网络放大",
    "HN 专文「Story of Odoo: Open-Sourced Competitor to Oracle, SAP」（HN 21865699）；收入量级 unknown（未一手复核）",
    "One App Free 是精妙的转化漏斗；PAI 可让「核心技能永久免费、生态技能收费」",
    "https://github.com/odoo/odoo", 3)
add("Metabase", "open-core", 49218,
    "开源 BI + Metabase Cloud/企业版",
    "自助 BI 病毒式内部传播（人人可看板）→ IT 买单",
    "$13M（2019，HN 19135547）",
    "工具型产品靠「用的人多、付钱的人少」金字塔也能成立",
    "https://github.com/metabase/metabase", 3)
add("Plausible Analytics", "open-core", 29048,
    "AGPL 隐私分析，主推托管 SaaS，全程公开收入与决策",
    "anti-Google Analytics 旗帜 → GDPR 时代口碑传播；公开数据本身就是营销内容",
    "$1.2M ARR 公开（2023-03，HN 35121435）",
    "小团队+公开数据+反巨头旗帜即可养活公司；PAI 的「个人数据主权」叙事同样有旗帜价值",
    "https://github.com/plausible/analytics", 4)
add("Langfuse", "open-core", 34515,
    "LLM 应用可观测/评估，核心开源 + 云与企业功能",
    "LLM 开发者调试刚需 → trace 数据沉淀形成粘性",
    "融资情况 unknown（本轮未取证到数字）",
    "观测类功能天然粘性（数据在谁手里谁赢）；PAI 的运行日志/进化记录就是自己的护城河数据",
    "https://github.com/langfuse/langfuse", 4)
add("Appwrite", "open-core", 57353,
    "开源后端平台（Firebase 替代）+ Appwrite Cloud",
    "自托管入口 → 云转化；Hacktoberfest 等社区运营拉新",
    "融资 unknown（本轮未取证到数字）",
    "社区活动（贡献者积分/勋章）可持续拉动贡献，成本低",
    "https://github.com/appwrite/appwrite", 3)
add("Meilisearch", "open-core", 59273,
    "开源搜索引擎 + Meilisearch Cloud",
    "开发者体验（5 分钟接入）驱动口碑",
    "$5M 种子（2022，HN 30098857）",
    "极端易用性本身是冷启动飞轮；PAI 安装器同理（8 号 docket）",
    "https://github.com/meilisearch/meilisearch", 3)

# ============ dual-license / license-saga (10) ============
add("MySQL", "dual-license", 12422,
    "GPL/商业双许可鼻祖，Oracle 持有，云时代被反复验证",
    "数据库内核免费 → 企业级支持/云服务收费；分叉频出（MariaDB/Percona）反证生态黏性",
    "成熟案例（收入未在本轮取证，Oracle 不单独披露）",
    "双许可的前提是版权集中（CLA）；PAI 若要保留商业灵活性需早定 CLA 策略",
    "https://github.com/mysql/mysql-server", 2)
add("MongoDB", "dual-license", 28554,
    "2018 年首创 SSPL 防云厂商白嫖 + Atlas 云订阅",
    "文档数据库生态（驱动/工具/O'Reilly 教育）→ 云托管变现",
    "上市公司 NASDAQ:MDB（收入十亿美元级为公开常识，本轮未一手复核）",
    "「改协议防云」是开源商业化经典防御，但代价是社区善意；PAI 个体户属性暂时无此威胁",
    "https://github.com/mongodb/mongo", 3)
add("Redis", "dual-license", 76347,
    "2024-03 改 SSPL → Linux Foundation 当月接管 Valkey 分叉；2025 年 Redis 8 重新加入 AGPL 选项",
    "许可证地震 → 大厂（AWS/Google）贡献者集体迁移到 Valkey → Redis 被迫回摆 AGPL 挽回社区",
    "许可证事件全记录见 HN 39853463（LF 启动 Valkey）",
    "许可证反复横跳的代价是信任永久折价；PAI 选好开源协议后应写进宪法不折腾",
    "https://github.com/redis/redis", 3)
add("Valkey", "dual-license", 27186,
    "Redis 分叉，Linux Foundation 托管，AWS/Google 等注入全职工程师",
    "厂商痛恨单一厂商控盘 → 基金会中立托管 → 贡献者网络一夜建成",
    "Linux Foundation 官宣接管（2024-03-28，HN 39853463）；一年内 27k stars",
    "基金会化是「被逼出来的中立性」；PAI 技能市场若做大也可承诺规则由社区治理",
    "https://github.com/valkey-io/valkey", 3)
add("Elasticsearch", "dual-license", 77111,
    "2021 弃 Apache 换 SSPL（防 AWS）→ AWS 直接分叉 OpenSearch；2024-08 官方加回 AGPLv3",
    "两次换协议：第一次丢生态，第二次往回收——证明开源许可既是护城河也是枷锁",
    "2024-08 加回 AGPL 为官方公告事件（本轮 HN 未检到高热帖，标注 known-未链接）",
    "「回来」的路比「离开」贵十倍；协议决策要做不可逆假设",
    "https://github.com/elastic/elasticsearch", 3)
add("OpenSearch", "dual-license", 13704,
    "AWS 发起的 Elasticsearch 分叉，2024 年移交 Linux Foundation",
    "云巨头养的分叉 → 中立化后厂商共建 → 与 Elastic 竞争倒逼其回归开源",
    "仓库活跃度（13.7k stars/2.9k forks）为 GitHub API 一手数据",
    "巨头互斗的产物反而可能最中立；PAI 无需站队但可借鉴其多厂商共治委员会设计",
    "https://github.com/opensearch-project/OpenSearch", 3)
add("Sentry", "dual-license", 44770,
    "BSL → 2023 自创 FSL（Functional Source License）：源码开放、禁竞品商用、2 年后自动转 Apache",
    "错误监控 SaaS 为主业，源码开放换信任与自助部署",
    "「Sentry Relicense Again (FSL)」（HN 38306320）；收入 unknown",
    "FSL 是 open-core 之外第三条路（时限性开源）；PAI 技能可考虑「N 个月后自动转公有领域」条款",
    "https://github.com/getsentry/sentry", 4)
add("Terraform / HashiCorp", "dual-license", 49648,
    "2023-08 弃 MPL 改 BUSL → 社区分叉 OpenTofu；2025-02 IBM 完成收购",
    "厂商改协议 → 社区 72 小时内宣布分叉 → 客户（Oracle 等）公开切换；公司整体卖给 IBM",
    "IBM 完成收购（2025-02-27，HN 43199256，488pts）",
    "BUSL 事件证明：社区资产的主权在贡献者手里，不在公司手里；PAI 的技能生态同理",
    "https://github.com/hashicorp/terraform", 4)
add("OpenTofu", "dual-license", 30165,
    "Terraform 的 LF 托管分叉（MPL-2.0），registry + 社区治理",
    "政策宣言（open-letter）集结厂商 → 基金会托管 → 大客户背书迁移",
    "Oracle 弃 Terraform 改用 OpenTofu（2024-05-15，HN 40365198）",
    "分叉要有 registry+治理+大客户三件套才能活；技能市场被背叛时社区的「逃生舱」长这样",
    "https://github.com/opentofu/opentofu", 4)
add("MariaDB", "dual-license", 8212,
    "MySQL 分叉 + BSL 部分模块 + 上市（2022 借壳 SPAC）→ 2023-24 退市/破产保护风波",
    "MySQL 时代社区信任变现 → 资本化失败 → 教训样本",
    "破产保护/退市为公开新闻事件（本轮未取证到链接，标 known-未链接）",
    "开源公司借壳上市不解决单位经济问题；商业化要看现金流不是故事",
    "https://github.com/MariaDB/server", 2)

# ============ saas-oss (15) ============
add("Vercel (Next.js)", "saas-oss", 142266,
    "MIT 框架 Next.js 免费 → 前端托管云付费，框架即获客机器",
    "框架市占率 → 部署惯性 → 云收入；生态 186,368 个 topic:nextjs 仓库",
    "$150M Series D（2021，HN 29317453）；后续估值报道 $3B+（未一手复核）",
    "「工具免费、燃料收费」：PAI 运行时永久免费，token/算力/同步可收费",
    "https://github.com/vercel/next.js", 4)
add("Docker (Moby)", "saas-oss", 72090,
    "引擎开源 → Docker Hub/桌面订阅 + 企业版收费",
    "容器标准 = 全行业依赖 → 分发渠道垄断（Hub 镜像）→ 订阅变现",
    "2020 起对大企业收费 + Hub 免费额度限制（政策事件，具体收入 unknown）",
    "掌握「分发格式标准」比掌握代码更值钱；PAI 的技能包格式就是潜在标准",
    "https://github.com/moby/moby", 3)
add("Ollama", "saas-oss", 180766,
    "本地 LLM 运行时 MIT 开源，一键跑模型；商业化路径未公开",
    "把「下载+运行+管理模型」做到一条命令 → 23,370 个 topic:ollama 项目寄生其上",
    "商业化 unknown（无公开融资/定价取证）；2026-03 增加 Apple MLX 支持保持技术领先（HN 47582482）",
    "本地 AI 的事实标准入口；PAI 应把 Ollama 当作模型层依赖而非竞争者；「本地优先也能长出十亿级分发」的直接证明",
    "https://github.com/ollama/ollama", 5)
add("Home Assistant", "saas-oss", 90402,
    "本地优先家庭自动化 Apache-2.0 + Nabu Casa 订阅云（远程访问/语音/AI）",
    "1000+ 集成（GitHub contents API 达到 1000 上限）由设备厂商为卖硬件而贡献；本地免费→便利云收费",
    "Nabu Casa 定价页为 JS 渲染本轮未取到数字（unknown）；40k+ forks 为生态规模一手数据",
    "PAI 最直接的对标结构：本地免费+可选云订阅；「厂商为卖硬件而写集成」的飞轮值得抄——技能作者为卖服务而写技能",
    "https://github.com/home-assistant/core", 5)
add("Grafana", "saas-oss", 76725,
    "AGPL 可视化平台 + Grafana Cloud/企业版",
    "插件/数据源生态 → 统一观测入口 → 云转化",
    "$50M Series B（2020，HN 24191748）；后续轮次与收入 unknown",
    "AGPL 也能做大 SaaS（自托管信任换企业订单）",
    "https://github.com/grafana/grafana", 4)
add("n8n", "saas-oss", 204123,
    "fair-code（源可用）工作流自动化 + 云/企业版；模板生态即内容池",
    "用户 workflow 模板公开分享 → 新用户开箱即用 → 付费节点/企业功能；AI 浪潮二次起飞",
    "$180M 融资（2025-10-09，HN 45525336）；估值 ~$2.5B 为当时媒体报道（未一手复核）",
    "fair-code 是 open-core 的激进变体；「用户作品模板池」是最便宜的自生长内容引擎——PAI 技能市场同理",
    "https://github.com/n8n-io/n8n", 5)
add("Langflow", "saas-oss", 154685,
    "MIT 可视化 AI agent 构建（DataStax 主导，随 DataStax 并入 IBM）",
    "低门槛拖拽 → 开发者/分析师皆可贡献组件",
    "归属变化（DataStax→IBM）为公开事件；具体金额 unknown",
    "低代码降低生态贡献门槛：非程序员也能上架技能，是市场供给端扩容关键",
    "https://github.com/langflow-ai/langflow", 4)
add("Jan", "saas-oss", 44445,
    "100% 离线运行的 ChatGPT 替代（本地优先）+ 模型 hub",
    "本地推理 + 远程模型商 API 接入（收 API 费用或分成）",
    "商业化 unknown（无公开数字取证）",
    "本地优先+模型市场二合一的桌面形态与 PAI 最像；其 hub 即「下载即用」体验样本",
    "https://github.com/janhq/jan", 4)
add("AnythingLLM", "saas-oss", 65966,
    "本地优先 all-in-one AI 应用（桌面+docker），MIT",
    "口号 Stop renting your intelligence → 数据主权叙事引流",
    "商业化 unknown",
    "「Stop renting X」叙事对个人工作站产品极其有效，可直接借用到 PAI 文案",
    "https://github.com/Mintplex-Labs/anything-llm", 4)
add("LocalAI", "saas-oss", 49086,
    "开源本地推理引擎（OpenAI 兼容 API），社区捐赠驱动",
    "Docker 一键替换 OpenAI endpoint → 极客自传播",
    "收入 unknown（捐赠驱动）",
    "API 兼容层策略：成为标准的替代品比成为新标准便宜",
    "https://github.com/mudler/LocalAI", 3)
add("GPT4All", "saas-oss", 77390,
    "Nomic 出品的本地 LLM 运行框架，MIT",
    "模型+文档+生态一体分发，教育市场换口碑",
    "收入 unknown（Nomic 后续被收购为公开报道，未一手复核）",
    "本地 LLM 教育者红利已过，时机窗口很重要",
    "https://github.com/nomic-ai/gpt4all", 3)
add("Zed", "saas-oss", 90162,
    "高性能多人编辑器开源，编辑器免费 + 协作服务变现",
    "Rust 性能口碑 + 开源社区 + 实时协作网络效应",
    "收入 unknown",
    "本地能力免费+网络能力收费的界面清晰；PAI 的「单机技能免费、市场/同步收费」同构",
    "https://github.com/zed-industries/zed", 3)
add("Open WebUI", "saas-oss", 151806,
    "本地 AI 界面事实标准；2025-05 从 BSD-3 改为自定义许可+CLA 引发争议，另有企业版",
    "Ollama/本地模型默认前端 → 15 万 stars 巨量分发 → 商业化尝试",
    "改许可事件（HN 43901575，73pts）；收入 unknown",
    "151k stars 的项目商业化仍然困难——分发≠变现；且改许可遭社区反弹：PAI 协议要前置锁定",
    "https://github.com/open-webui/open-webui", 5)
add("LibreChat", "saas-oss", 43078,
    "MIT 多模型聊天 UI，2025-11 被 ClickHouse 收购",
    "插件/端点生态活跃，维护者一人起步",
    "ClickHouse 收购公告（HN 45877770，118pts）",
    "indie 开源项目的退出路径：被数据库公司买下当入口；技能市场作者同样可以有 exit 预期",
    "https://github.com/danny-avila/LibreChat", 4)
add("Flowise", "saas-oss", 55456,
    "可视化 LLM 编排，55k stars 但仓库已于 2026 年归档（GitHub API archived=true）",
    "反热样本：低代码编排赛道起落极快，热度≠护城河",
    "归档状态为 GitHub API 一手数据（2026-09-13）",
    "同类竞品一年内可归档；PAI 要靠数据沉淀（用户模型/技能资产）而非界面形态建立留存",
    "https://github.com/FlowiseAI/Flowise", 3)

# ============ marketplace (6) ============
add("npm registry", "marketplace", 10111,
    "JS 包注册表：发布免费 → 私有包/Teams/企业付费，2020 年被 GitHub 收购",
    "136,032,572,712 次周下载（api.npmjs.org 2026-09-13 一手）——全网最大软件分发飞轮",
    "周下载 1360 亿（一手）；收购金额 unknown",
    "注册表=生态咽喉：谁掌握技能包的分发与命名空间，谁就有定价权；PAI 技能注册表是核心资产",
    "https://api.npmjs.org/downloads/point/last-week", 5)
add("GitHub Marketplace + Sponsors", "marketplace", 0,
    "Apps/Actions 市场（分成机制）+ Sponsors 赞助（0% 抽成）",
    "仓库→Actions→付费 App 的转化链；赞助让 top 维护者可全职",
    "个人维护者 $100k/yr 公开帖（HN 23613719，1469pts）",
    "0 抽成赞助换生态繁荣、交易市场抽成变现——两个池子分开管；PAI 积分市场可复制此双轨",
    "https://github.com/sponsors", 5)
add("Hugging Face", "marketplace", 165222,
    "模型/数据集/Spaces hub 免费 + PRO 订阅/Inference API/企业版",
    "上传即分发+排行榜+论文互链，模型作者趋之若鹜；生态自供给内容",
    "$235M 融资含 Salesforce/Nvidia（2023-08，HN 37248895）；$4.5B 估值为同期报道",
    "「内容上传者自己就是分发渠道」的 marketplace 模板；PAI 技能市场的作者主页+排行榜+一键部署应整体抄",
    "https://github.com/huggingface/transformers", 5)
add("Unity Asset Store", "marketplace", 0,
    "游戏资产市场，创作者 70/30 分成起步（大额递减）",
    "开发者买资产省工时 → 创作者被动收入 → 资产质量内卷",
    "个人案例：$3,000/5 天（2011 spline 工具，HN 2500426）；现代总盘子 unknown",
    "细分垂类市场足以养活大量小微创作者；技能市场的长尾收入预期管理可参考（中位数很低、头部可观）",
    "https://hn.algolia.com/?query=Unity%20Asset%20Store", 4)
add("Chrome Web Store", "marketplace", 0,
    "扩展商店：$5 开发者注册费 + 商店内购/订阅分成",
    "浏览器垄断地位 → 扩展生态自供给 → 开发者跟随用户",
    "规模 unknown（本轮未取证到数字）",
    "「入口产品自带商店」最成熟的形态；PAI 作为桌面 agent，其技能商店天然继承此结构",
    "https://chromewebstore.google.com", 3)
add("Blender", "marketplace", 20284,
    "非营利基金会 + Development Fund 企业会员 + Steam 付费构建 + Blender Studio 订阅",
    "捐赠+会员+付费渠道三引擎；贡献者全职化靠 fund 覆盖",
    "Steam 版上线（HN 6215219）；2020 年度报告公开（HN 27078224）；当前基金具体金额 unknown（页面 JS 渲染）",
    "开源软件在 Steam 卖拷贝（便利付费）被验证；PAI 可上微软商店卖「省心版」+官方免费版并存",
    "https://fund.blender.org/", 5)

# ============ plugin-ecosystem (14) ============
add("OBS Studio", "plugin-ecosystem", 76126,
    "GPL 录播软件，插件生态 + 捐赠/赞助维持",
    "主播刚需 + 插件自由 → 社区接盘式开发（原作者退出后社区接管）",
    "收入 unknown（捐赠驱动）",
    "社区接盘机制（项目可传承）值得设计：技能作者弃坑后技能如何被社区接管",
    "https://github.com/obsproject/obs-studio", 4)
add("VS Code + Extension Marketplace", "plugin-ecosystem", 192097,
    "MIT 核心 + 闭源官方构建；扩展市场（14,616 个 topic:vscode-extension 仓库）",
    "扩展生态反哺编辑器普及 → Azure/远程服务变现",
    "生态规模为 GitHub topic 一手计数；市场收入 unknown",
    "开源核心+官方构建闭源（Logo/遥测）是可借鉴的混合形态；扩展市场=编辑器护城河",
    "https://github.com/microsoft/vscode", 5)
add("shadcn/ui", "plugin-ecosystem", 123663,
    "MIT 复制粘贴组件库 + registry 分发协议（npx 拉取而非 npm install）",
    "代码进用户仓库（所有权转移）→ 用户自行魔改再分享 → registry 生态（第三方主题/组件站涌现）",
    "无直接变现（作者受雇 Vercel）；生态规模一手：123k stars",
    "registry 协议（CLI 拉取+本地所有权）是技能分发最适合的形态：技能装进用户目录而非黑盒运行时——与 PAI 技能自进化理念完全一致",
    "https://github.com/shadcn-ui/ui", 5)
add("ComfyUI", "plugin-ecosystem", 132805,
    "节点式扩散模型 GUI（GPL-3.0）+ 官方 registry（registry.comfy.org）+ 桌面版",
    "custom node 生态（2,916 个 topic:comfyui 仓库）+ 工作流可分享文件格式",
    "商业化 unknown；生态规模一手：topic 计数",
    "「工作流文件」本身成为社交货币（截图/教程传播）——PAI 的技能包也应可炫耀、可转发",
    "https://github.com/Comfy-Org/ComfyUI", 5)
add("Raycast Store", "plugin-ecosystem", 7741,
    "闭源启动器 + 开源扩展仓库（extensions monorepo ≥1000 个，GitHub API 1000 上限；topic:raycast-extension 448）",
    "扩展 API+Store 审核制；用户群（开发者）与作者群高度重叠",
    "收入 unknown；扩展规模一手：monorepo 目录计数",
    "「审核制 monorepo 市场」质量可控但供给受限；PAI 可双轨：认证技能（审核）+野生技能（社区评分）",
    "https://github.com/raycast/extensions", 5)
add("WordPress 插件经济", "plugin-ecosystem", 21412,
    "开源核心（GPL）+ 72,000 免费插件（wordpress.org 一手）+ 巨大付费插件经济（WooCommerce/Elementor 等）",
    "插件作者服务小生态收年费 → 生态养活托管商/主题商/代理商多层经济",
    "wordpress.org/plugins 页面「72,000 free plugins」（2026-09-13 一手）；WP Engine 与 Automattic 冲突案（HN 41613628/42383680）",
    "二十年最长寿插件经济：年费订阅+freemium 是插件变现主流；治理冲突（WP Engine 案）警示商标/服务器权限集中风险",
    "https://wordpress.org/plugins/", 5)
add("Obsidian 插件生态", "plugin-ecosystem", 21510,
    "闭源笔记应用 + 完全开放插件 API（3,798 个 topic:obsidian-plugin 仓库）",
    "插件自由度极致 → 知识管理极客聚集 → Sync/Publish 官方云服务收费",
    "生态规模一手：topic 计数 + releases 仓库 21.5k stars；收入 unknown",
    "闭源应用+开放插件市场完全可行且长期共存；PAI 核心闭源与否可以解耦于技能市场开放性",
    "https://github.com/obsidianmd/obsidian-releases", 5)
add("MCP (Model Context Protocol) servers", "plugin-ecosystem", 90284,
    "Anthropic 开源协议 → agent-工具连接的行业标准",
    "28,608 个 topic:mcp-server 仓库（一手计数）；任意工具接任意模型的自供给生态",
    "无直接变现（协议层免费）；生态规模一手",
    "协议免费、实现收费：PAI 若定义「技能包格式」并让它外溢为行业标准，分发价值大于直接销售",
    "https://github.com/modelcontextprotocol/servers", 5)
add("Claude Skills (anthropics/skills)", "plugin-ecosystem", 176017,
    "SKILL.md 能力打包格式（Anthropic 官方仓库，2025-10 发布）",
    "「Claude Skills 也许比 MCP 更大」（HN 45619537，738pts）；指令+脚本+资源进一个文件夹即技能",
    "无直接变现；176k stars 为 GitHub 一手（2026-09-13）",
    "PAI 技能格式的最大公约数候选：与 SKILL.md 兼容=接入百万级作者心智；「文件夹即技能」的极简规范值得对齐",
    "https://github.com/anthropics/skills", 5)
add("OpenClaw", "plugin-ecosystem", 389536,
    "开源个人 agent 运行时（2025-11 起，原名 Clawdbot/Moltbot），MIT 系许可证",
    "个人 WhatsApp/Telegram 接管式助手爆红 → 技能/插件生态 → 网关战争（Anthropic/Google 限制其用户，HN 47633396/47115805/47963204）",
    "无融资取证（unknown）；389,536 stars 为 GitHub 一手（2026-09-13，9.5 个月达成）",
    "PAI 最直接的镜子：个人 agent+技能生态+被上游模型厂打压的生存博弈——必须多网关/本地模型冗余（详见 cc-switch 条）",
    "https://github.com/openclaw/openclaw", 5)
add("ClawHub", "plugin-ecosystem", 9415,
    "OpenClaw 官方技能+插件注册表（MIT，2026-01 上线）",
    "创作者上架技能、按下载计数排名（clawhub.com 实测：ClawCall 1.2k 下载居榜首）；生态 9119 个 topic:openclaw 仓库、974 个含 clawhub 仓库（一手）",
    "下载计数为 clawhub.com 页面一手（2026-09-13）；头部技能曾爆恶意软件事件（HN 46898615，334pts）",
    "技能市场的安全审查必须前置（签名+沙箱+举报流）；下载量排行是最直接的供需信号，PAI 市场第一天就要有",
    "https://github.com/openclaw/clawhub", 5)
add("superpowers (obra)", "plugin-ecosystem", 285849,
    "MIT agentic skills 框架+开发方法论（Jesse Vincent），社区技能生态爆炸",
    "技能=可组合开发方法论 → 用户贡献技能目录 → 框架与技能互相引流",
    "无变现取证；285,849 stars 为 GitHub 一手",
    "「方法论+技能包」绑定传播比纯工具传播快一个量级；PAI 的 skill evolution 应输出方法论内容",
    "https://github.com/obra/superpowers", 5)
add("Cline", "plugin-ecosystem", 67901,
    "Apache-2.0 VS Code agent，免费开源，靠 BYOK/API 路由分成与付费模型位变现",
    "开源 agent 免费换用户 → 用户自带 API key 消耗 → 供应商返佣",
    "收入 unknown；67,901 stars 一手",
    "BYOK+供应商返佣是 agent 产品零摩擦变现模板；PAI 的 token 网关可直接复用此收入线",
    "https://github.com/cline/cline", 4)
add("Continue", "plugin-ecosystem", 35883,
    "开源 Copilot 替代（VS Code/JetBrains）+ hub/企业版",
    "开源获取企业信任 → 企业版（SSO/审计）收费",
    "Show HN（HN 36882146）；收入 unknown",
    "开发者工具开源版做信任、企业版做收入；PAI 的商用版同理",
    "https://github.com/continuedev/continue", 4)

# ============ foundation (6) ============
add("Linux kernel", "foundation", 248444,
    "GPL + 无数厂商付费贡献（开发者工资）",
    "一切计算的地基；贡献=雇佣关系，基金会管商标与治理",
    "生态规模一手：248k stars / 64.5k forks",
    "终极样本：当生态大到一定程度，「治理权」本身即资产",
    "https://github.com/torvalds/linux", 2)
add("Kubernetes", "foundation", 127382,
    "CNCF 毕业项目：核心免费 → 认证培训（CKA/CKAD）+ 各家托管服务变现",
    "厂商共建标准 → 培训/咨询/托管衍生经济（KCSP 合作伙伴网络）",
    "生态规模一手：127k stars",
    "认证体系（付费考试+证书）是基金会生态的成熟变现位；PAI 技能可发「认证技能作者」资质",
    "https://github.com/kubernetes/kubernetes", 2)
add("Apache Spark", "foundation", 43985,
    "ASF 孵化 → Databricks/Cloudera 等商业公司寄生其上",
    "基金会提供品牌+治理，商业公司提供全职工程师",
    "生态规模一手：44k stars",
    "「基金会养标准、公司养实现」的分工使 Spark 商业繁荣但核心永续",
    "https://github.com/apache/spark", 2)
add("PyTorch", "foundation", 102960,
    "Meta 捐给 Linux Foundation（PyTorch Foundation，2022）",
    "中立化打消厂商顾虑 → 全行业（含竞对云厂）共建",
    "生态规模一手：103k stars",
    "捐赠=放权换生态：单厂控制会限制采用；PAI 技能格式规范未来可捐赠中立化",
    "https://github.com/pytorch/pytorch", 3)
add("Node.js / OpenJS", "foundation", 121605,
    "OpenJS 基金会托管，npm 生态寄生",
    "核心维护由多家公司资助（贡献者雇佣制）",
    "生态规模一手：121k stars",
    "运行时的治理稳定比功能迭代更决定长尾生态存亡",
    "https://github.com/nodejs/node", 2)
add("vLLM", "foundation", 91599,
    "伯克利 Sky Computing Lab 开源 → LF AI & Data 托管 + 企业共建",
    "推理性能标杆 → 各家 AI 厂商贡献算子/后端 → 事实标准",
    "生态规模一手：91.6k stars",
    "学术出身+基金会托管+厂商共建是 AI 基建项目的标准成长路径",
    "https://github.com/vllm-project/vllm", 3)

# ============ token-economy (6) ============
add("OpenRouter", "token-economy", 0,
    "统一 LLM API 网关：预付 credits（token）+ 按量抽成；445 个模型（openrouter.ai/api 一手）",
    "一个 key 用所有模型+比价 → 开发者聚集 → 模型厂排队接入",
    "2026-08 加入 Stripe（HN 49364559，964pts）；「So you want to use OpenRouter?」（HN 49621546，744pts）",
    "credits 预付制是 token 经济最稳的记账单位（非区块链）；PAI 市场积分可直接对标：充值 credits、按调用/下载扣减、作者提现",
    "https://openrouter.ai/api/v1/models", 5)
add("Civitai", "token-economy", 0,
    "AI 模型分享社区：Buzz 积分（上传/下载/每日签到发放+法币购买），创作者凭下载量赚 Buzz 可变现",
    "创作者为赚 Buzz 上传模型 → 模型丰富吸引用户 → 用户购买 Buzz 加速获取（早鸟奖励设计）",
    "a16z 投资报道（HN 38265196）；具体 GMV unknown",
    "非区块链积分经济的最成功样本：产出=积分=消费闭环；PAI 技能下载赚积分的机制可直接参考其防刷设计（每日上限/早鸟衰减）",
    "https://civitai.com", 5)
add("Open Collective", "token-economy", 2277,
    "开源项目财务托管：透明账本+代付发票，平台抽成",
    "集体资金公开可审计 → 捐赠者信任 → 项目可持续",
    "抽成比例 unknown；2,277 stars 一手",
    "透明账本是捐赠型经济信任基础；PAI 技能作者收入若公开排行榜需配套隐私选项",
    "https://github.com/opencollective/opencollective", 3)
add("Brave / BAT", "token-economy", 23622,
    "注意力代币：看广告赚 BAT 补贴用户/创作者",
    "代币激励换用户量 → 广告主投放闭环",
    "创作者实际收入口碑一般（HN 25457508 讨论）；代币价格波动传导至激励价值",
    "代币价值锚定广告收入波动大，创作者收入不可预期——PAI 积分应锚定算力/token 等稳定价值物",
    "https://github.com/brave/brave-browser", 2)
add("Gitcoin", "token-economy", 1824,
    "二次方融资（matching pool）资助开源公共品，后转型 Allo 协议",
    "巨鲸+散户配捐的数学机制让小额捐赠放大",
    " Grants 系列累计配捐额 unknown；1824 stars（gitcoinco/web）",
    "配捐池（平台出一部分）比纯抽成更能催生长尾供给；PAI 可设「新技能冷启动配捐池」",
    "https://github.com/gitcoinco/web", 2)
add("Steemit", "token-economy", 1947,
    "内容即挖矿的代币经济（2016 爆红后崩塌）",
    "发帖/点赞得币 → 通胀超发+大户勾结（ witnesses 治理失灵）→ 生态死亡",
    "仓库近乎停滞（1.9k stars，一手）；崩塌过程为行业公案",
    "代币经济反面教材：无真实需求锚定的积分会催生女巫攻击与内部人套利；PAI 积分发放必须绑定真实使用（运行成功/好评）而非行为本身",
    "https://github.com/steemit/steem", 2)

# ============ cn-case (18) ============
add("Dify", "cn-case", 155554,
    "开源 LLM 应用/agent 平台（LangGenius）+ Dify 云订阅",
    "开源换全球开发者 → 云版年付档位 $590/$1590（dify.ai/pricing 页面一手 grep）→ 企业版另议",
    "云定价一手：$590/$1590（2026-09-13）；融资额 unknown（本轮未取证到）",
    "中国团队做全球 open-core 最成功样本：中文社区+英文社区双轮；PAI 应同款双语冷启动",
    "https://github.com/langgenius/dify", 5)
add("FastGPT", "cn-case", 29636,
    "Sealos 系（labring）知识库/agent 平台，开源+商业云托管",
    "知识库场景刚需 → Sealos 云一键部署 → 商业版订阅",
    "Show HN 2023（HN 35719482，128pts）；收入 unknown",
    "「开源+自家云平台托管」组合拳（Sealos 承载）是国内云原生系标准打法",
    "https://github.com/labring/FastGPT", 5)
add("one-api", "cn-case", 36867,
    "MIT 许可的 LLM API 网关/分发系统（songquanpeng 个人项目）",
    "自用工具开源 → 中小团队渠道需求 → 海量 fork 生态（6.8k forks）",
    "无公司化变现（个人维护+赞助）；stars/forks 一手",
    "个人维护的网关类项目自然长成渠道生意——PAI 的 token 网关模块若开源可换取装机量",
    "https://github.com/songquanpeng/one-api", 5)
add("new-api", "cn-case", 47974,
    "one-api 社区分叉（QuantumNous），AGPL + 商业授权+赞助",
    "分叉更活跃（47.9k>36.9k stars）证明社区选择机制；插件化+分发功能增强",
    "无公开收入；stars 超越原版为 GitHub 一手（2026-09-13）",
    "分叉超越原版在中国开源圈反复发生：API 兼容+增量功能即可截流；PAI 保持向后兼容压力同源",
    "https://github.com/QuantumNous/new-api", 5)
add("Cherry Studio", "cn-case", 51734,
    "AGPL 桌面 AI 工作台（多模型/多服务商/知识库/agent）",
    "全平台桌面客户端+服务商聚合，GPL 生态位换取口碑装机",
    "商业化 unknown；51.7k stars 一手",
    "与 PAI 定位最接近的中国竞品：桌面+多网关+知识库；差异化须落在「自进化技能+市场」上",
    "https://github.com/CherryHQ/cherry-studio", 5)
add("LobeHub (LobeChat)", "cn-case", 82437,
    "MIT agent 生态（原 lobe-chat 插件市场）+ LobeHub 商业化门户",
    "插件/agent 市场+多模型接入 → 个人→团队云服务转化",
    "商业化收入 unknown；82.4k stars、插件市场生态一手",
    "中国开源做「agent 商店」UI 范本；其从 chat 改名 agent 中台的转身值得跟踪",
    "https://github.com/lobehub/lobehub", 5)
add("RAGFlow", "cn-case", 90587,
    "InfiniFlow 出品 RAG 引擎（Apache-2.0）+ 企业服务",
    "深度文档解析刚需 → 开源换企业线索 → 商业版/云服务",
    "HN 2024 报道（HN 39896923，230pts）；90.6k stars 一手",
    "企业级 RAG 需求被开源验证；PAI 个人知识库场景是其轻量版",
    "https://github.com/infiniflow/ragflow", 5)
add("MaxKB", "cn-case", 22774,
    "飞致云（FIT2CLOUD）开源矩阵成员：GPL-3.0 + 企业版",
    "公司化开源矩阵（1Panel/JumpServer/DataEase 互相导流）",
    "收入 unknown；矩阵协同为一手观察（同 org 多万星仓库）",
    "「一家公司养一排开源产品互相导流」的中国式打法；PAI 技能矩阵可故意设计互补簇",
    "https://github.com/1Panel-dev/MaxKB", 4)
add("1Panel", "cn-case", 36884,
    "飞致云 Linux 服务器管理面板（GPL-3.0）+ 专业版付费",
    "运维小白刚需 → 社区版口碑 → 专业版订阅",
    "收入 unknown；36.9k stars 一手",
    "GPL+专业版功能墙在国内可行；PAI 商业技能许可可参考其功能切分粒度",
    "https://github.com/1Panel-dev/1Panel", 4)
add("JumpServer", "cn-case", 31523,
    "飞致云堡垒机（GPL-3.0）+ 企业版，开源安全品类第一",
    "安全合规刚需 → 开源版获信任 → 企业功能付费",
    "收入 unknown；31.5k stars 一手",
    "安全品类天然适合 open-core（付费的是合规与审计）",
    "https://github.com/jumpserver/jumpserver", 3)
add("TiDB (PingCAP)", "cn-case", 40521,
    "分布式数据库 open-core + TiDB Cloud 托管",
    "国际会议论文+开源换信任 → Cloud 订阅；国内基础软件出海标杆",
    "融资多轮（公开报道）；收入 unknown；40.5k stars 一手",
    "基础软件「论文+开源+云」三段式；PAI 无论文位但「benchmark+开源+市场」结构同构",
    "https://github.com/pingcap/tidb", 3)
add("TDengine", "cn-case", 25109,
    "涛思数据时序数据库：AGPL+商业双许可+云",
    "物联网场景开源 → 商业许可/云订阅",
    "收入 unknown；25.1k stars 一手",
    "创始人公开分享开源商业化方法论（国内最早系统化输出者）",
    "https://github.com/taosdata/TDengine", 3)
add("Milvus / Zilliz", "cn-case", 46078,
    "LF AI & Data 孵化的向量数据库 + Zilliz 云",
    "华人团队+基金会托管+云变现的国际路线",
    "收入 unknown；46.1k stars 一手",
    "向量 DB 赛道证明：中立托管（基金会）反而利于中国团队全球商业化",
    "https://github.com/milvus-io/milvus", 3)
add("DeepSeek", "cn-case", 104434,
    "MIT 开源权重模型 + 极低价 API 商业化",
    "开源权重=全球开发者免费分发/蒸馏 → 品牌与信任 → API 付费变现；V3/R1 发布即登顶（HN 42768072，1843pts）",
    "2025-02 官方披露 API 理论成本利润率 545%（api-docs.deepseek.com 公告，广为引用；本轮未直接打开原帖）",
    "「开源权重+闭源服务」互补而非互斥：免费的部分是获客，卖的是消耗；PAI 技能同理——技能免费、算力收费",
    "https://github.com/deepseek-ai/DeepSeek-V3", 5)
add("Qwen (阿里)", "cn-case", 27611,
    "Apache-2.0 全家族开源模型 + ModelScope/API 商业化",
    "全尺寸全模态开源矩阵 → 衍生生态（微调/部署工具）自供给 → 云 API 收入",
    "衍生模型数量居全球前列（公开常识）；收入 unknown；Qwen3 27.6k stars 一手",
    "开源矩阵密度本身就是市场占位策略；PAI 技能官方模板矩阵应同样密",
    "https://github.com/QwenLM/Qwen3", 4)
add("ModelScope (魔搭)", "cn-case", 9128,
    "阿里系模型社区（中国版 Hugging Face）+免费算力",
    "大厂背书+免费推理额度换开发者",
    "运营数据 unknown；9.1k stars 一手",
    "大厂补贴型社区：冷启动快但长期依赖母体输血；PAI 社区需自造血设计",
    "https://github.com/modelscope/modelscope", 4)
add("Coze Studio (字节)", "cn-case", 21581,
    "字节 agent 平台 2025-07 开源（Apache-2.0）+云版商业闭环",
    "闭源 SaaS 用户量大后反向开源抢开发者生态",
    "收入 unknown；21.6k stars（2025-07 至 2026-09 一手）",
    "「SaaS 成熟后开源」的逆向路径：用开源防守后来者；PAI 直接开源是进攻位",
    "https://github.com/coze-dev/coze-studio", 4)
add("cc-switch (独立开发者)", "cn-case", 132544,
    "个人开发的 Claude Code/Codex/OpenClaw 多供应商切换器（MIT 桌面应用）",
    "网关战争（模型厂限制第三方 agent）催生切换刚需 → 132k stars（2025-08 至 2026-09 一手）",
    "无变现取证（unknown）；增速一手",
    "痛点缝隙工具一年 13 万星：PAI 的多网关冗余设计是刚需级卖点；也说明依赖单一上游的风险有多真实",
    "https://github.com/farion1231/cc-switch", 4)

# ============ other / negative (5) ============
add("Sourcegraph（陨落弧线）", "other", 10296,
    "2018 高调开源 → 2023-07 转闭源 → 2024-08 仓库下架（public-snapshot 归档）",
    "反例：Cody AI 转型期把开源当获客成本，社区信任透支后 repo 转归档快照",
    "三段式证据：HN 18117755（594pts 开源）→ HN 36584656（444pts 不再开源）→ HN 41296481（424pts went dark）；snapshot archived=true 一手",
    "开源不是获客手段而是承诺；把社区当漏斗的项目会被社区记账",
    "https://github.com/sourcegraph/sourcegraph-public-snapshot", 4)
add("CentOS → Rocky/Alma", "other", 0,
    "2020 IBM/RedHat 停止 CentOS Stable → 社区 8 个月内推出 Rocky/Alma 替代",
    "反例+重生：单方面 EOL → 创始人回归重建（Greg Kurtzer）→ 企业级替代品涌现",
    "Rocky Linux 公告（HN 25445725，833pts，2020-12）",
    "平台级承诺（LTS/兼容）必须有治理背书，否则用户会自己造逃生舱——那也是机会（做别人生态的避险层）",
    "https://rockylinux.org", 3)
add("Atom → Pulsar", "other", 60744,
    "GitHub 的开源编辑器 2022 sunset，社区分叉 Pulsar 接管",
    "反例：母公司战略转移即弃子；社区接盘但动能大减",
    "Sunsetting Atom（HN 31668426，1320pts）；atom 仓库 archived=true 一手",
    "单一公司热情驱动的生态脆弱；PAI 要让技能生态价值独立于主程序存续（格式开放+可导出）",
    "https://github.com/atom/atom", 3)
add("Apache OpenOffice", "other", 1241,
    "Apache 基金会托管但实质僵死（2016 年公开信自曝仅剩志愿者）",
    "反例：基金会托管≠生态健康；治理僵局导致贡献者 2010 年大规模出走造 LibreOffice",
    "33 名开发者出走（HN 1857317，101pts，2010）；1.2k stars 一手",
    "把品牌交给基金会却不给资源=安乐死；治理要配预算和 roadmap",
    "https://github.com/apache/openoffice", 2)
add("Audacity 遥测风波", "other", 18410,
    "2021 Muse Group 收购后加遥测，社区信任崩塌、分叉四起",
    "反例：商业化动作无视社区共识 → PR/分叉海啸，至今未完全修复",
    "Basic Telemetry for Audacity（HN 27068400，134pts）+ 后续争议（HN 27082878）",
    "本地优先产品的用户对数据外流零容忍；PAI 任何遥测必须 opt-in+可视化（6 号 docket 用户模型同理）",
    "https://github.com/audacity/audacity", 3)

with io.open(r"E:\AI-Station\RESEARCH_DOCKET\v3\10-oss-ecosystem-business\_all.json", "w", encoding="utf-8") as f:
    json.dump(E, f, ensure_ascii=False, indent=2)

cats = {}
for e in E:
    cats[e["category"]] = cats.get(e["category"], 0) + 1
print("total:", len(E))
print("by category:", json.dumps(cats, ensure_ascii=False))
