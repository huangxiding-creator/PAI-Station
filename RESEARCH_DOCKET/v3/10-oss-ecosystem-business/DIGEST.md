# Docket 10 — 开源生态商业化案例库（OSS Ecosystem Business）

调研时点：2026-09-13 ｜ 代理：v3r10 ｜ 数据源：GitHub REST API（gh CLI 一手）、HN Algolia API（一手）、api.npmjs.org / wordpress.org / clawhub.com / dify.ai / openrouter.ai（官网一手 curl）
说明：WebSearch 配额于调研中耗尽（2026-09-26 重置），按预案降级为 gh CLI + HN Algolia + curl；所有 stars 为 2026-09-13 GitHub API 实测值；无法取证的数字一律标 unknown / 0，未编造。

## 总量

- `_all.json`：**93 条**（要求 ≥50），全部含 9 字段与一手证据 URL
- 覆盖矩阵完成度：open-core 13 / dual-license 10 / saas-oss 15 / marketplace 6 / plugin-ecosystem 14 / foundation 6 / token-economy 6 / cn-case 18 / other(负面) 5
- 未能实证项：`JiushuCity`（GitHub 搜索无有效结果，弃收）；GitLab 最新财年收入（SEC XBRL API 404）、Nabu Casa 定价（页面 JS 渲染）、Blender/Godot 基金会当前金额（同因）标 unknown

## Top 10 精选（按对 PAI-Station 的启示强度）

| # | 案例 | Stars | 为什么入选 |
|---|------|-------|-----------|
| 1 | **OpenClaw**（+ClawHub 9,415★） | 389,536 | 9.5 个月登顶全球 stars 榜的个人 agent 生态；技能注册表 ClawHub 实测有下载排行；同时经历网关战争（Anthropic/Google 封杀，HN 47633396/47115805）与头部技能恶意软件事件（HN 46898615）——PAI 的完整镜像与预演 |
| 2 | **anthropics/skills（Claude Skills）** | 176,017 | SKILL.md「文件夹即技能」成为 agent 能力打包事实标准（HN：「也许比 MCP 更大」，738pts）；PAI 技能格式的最大公约数候选，兼容它=接入百万作者心智 |
| 3 | **superpowers（obra）** | 285,849 | MIT 技能框架+方法论绑定传播，社区技能目录自生长；证明「方法论内容」比纯工具传播快一个量级 |
| 4 | **Home Assistant** | 90,402 | 本地优先+可选云订阅（Nabu Casa）的最成熟范本；1000+ 集成（GitHub API 计数达上限）由设备厂商为卖硬件而贡献——「厂商为卖东西而写插件」飞轮可直接移植为「作者为卖服务而写技能」 |
| 5 | **n8n** | 204,123 | fair-code+云订阅，2025-10 融资 $180M（HN 45525336）；用户 workflow 模板池=最便宜的自生长内容引擎 |
| 6 | **Civitai（Buzz 积分）** | 0（闭源站） | 非区块链积分经济最成功样本：上传/下载/早鸟奖励 Buzz，创作者凭下载量变现；PAI「下载赚积分」机制的防刷与衰减设计直接参考 |
| 7 | **OpenRouter** | 0 | 统一网关+预付 credits 记账+按量抽成，445 模型（API 实测）；2026-08 加入 Stripe（HN 49364559，964pts）——积分充值/提现/清算的工程模板 |
| 8 | **Dify** | 155,554 | 中国团队 open-core 全球化最成功样本；云定价一手实证（$590/$1590 年付档）；双语双社区冷启动打法 |
| 9 | **WordPress 插件经济** | 21,412 | wordpress.org 实测 72,000 免费插件+庞大付费插件年费经济；同时是治理反面教材（WP Engine vs Automattic 冲突，HN 41613628）：商标/服务器权限集中的生态风险 |
| 10 | **Cal.com → cal.diy** | 48,414 | 2026-04-15 宣布闭源（HN 47780456），社区 6 天内分叉 cal.diy 续命（HN 47852155）——AGPL+CLA 下社区合法接管的全过程直播；PAI 规则要第一天写死 |

候补：Supabase（$200M@$2B，HN 43763225）、Blender（基金会+Steam 付费分发+Development Fund 三引擎）、shadcn/ui（registry 分发协议）、MCP（28,608 个 topic:mcp-server 仓库）、cc-switch（网关战争催生的缝隙工具一年 132k stars）、DeepSeek（开源权重+低价 API 互补，545% 成本利润率披露）。

## 分组统计与结构洞察

| 类别 | 数量 | 代表 | 共性结论 |
|------|------|------|---------|
| open-core | 13 | GitLab、Supabase、Plausible、cal.diy | 「社区版免费换信任、托管/企业功能收费」仍是主流；但 cal.com 证明天花板设计失败会触发社区分叉 |
| dual-license / 许可证事件 | 10 | Redis→Valkey、Terraform→OpenTofu、Sentry FSL、IBM×HashiCorp | 2023-2026 密集爆发许可证战争；分叉要有 registry+治理+大客户三件套才能活（OpenTofu 一年 30k★）；IBM 2025-02 完成收购 HashiCorp（HN 43199256） |
| saas-oss | 15 | Ollama、Open WebUI、n8n、Home Assistant、Jan | 本地 AI 工具普遍 44k-181k★ 但**商业化大多 unknown**——分发≠变现是全组最大教训（Open WebUI 151k★ 改许可变现仍艰、Flowise 55k★ 已归档） |
| marketplace | 6 | npm（周下载 1360 亿，一手）、HF、Blender、Unity 资产店 | 注册表=生态咽喉；HF「上传即分发+排行榜」$235M 融资（HN 37248895）；Unity 个人 $3k/5 天（2011，HN 2500426）证明长尾市场能养活小作者 |
| plugin-ecosystem | 14 | OpenClaw/ClawHub、anthropics/skills、shadcn、ComfyUI、Obsidian、WP | 技能/插件生态正处爆发窗口：claude-skills topic 8,240 仓库、mcp-server 28,608 仓库、openclaw topic 9,119 仓库（均一手）；闭源核心+开放插件市场（Obsidian/Raycast）长期可行 |
| foundation | 6 | Linux、K8s、PyTorch→LF、vLLM | 中立托管解决单厂信任问题；K8s 的付费认证体系（CKA）是基金会稀有「卖证书」变现位 |
| token-economy | 6 | OpenRouter、Civitai、Steemit（反）、BAT（反） | 预付 credits+真实价值锚定（OpenRouter/Civitai）成功；无需求锚定的代币（Steemit 崩塌、BAT 温吞）全部失败 |
| cn-case | 18 | Dify、RAGFlow 90,587★、Cherry Studio、new-api、DeepSeek、cc-switch | 中国军团在本赛道全面前排：9 个 CN 项目 >20k★；飞致云矩阵（MaxKB/1Panel/JumpServer 互导流）与 DeepSeek「开源权重+卖消耗」是两条可复制路线 |
| other（负面教材） | 5 | Sourcegraph 三段式陨落、CentOS→Rocky、Atom→Pulsar、OpenOffice、Audacity 遥测 | 死因谱：透支社区信任（Sourcegraph）、母公司弃子（Atom）、治理僵局（OpenOffice）、无视本地优先隐私共识（Audacity）；CentOS 案同时证明「被背叛的生态=新机会」 |

## PAI-Station 生态飞轮设计输入（10 条收敛发现）

1. **技能格式 = 战略资产，对外兼容 SKILL.md。** anthropics/skills 176k★、ClawHub 9.4k★、superpowers 285k★、claude-skills topic 8,240 仓库——技能格式层已有事实标准。PAI 技能包应「文件夹即技能」且可双向兼容导入导出（做别人生态的避险层，参考 CentOS→Rocky 机会逻辑）。分发格式开放度 > 代码开放度（Docker/Moby 教训：掌握格式标准比掌握实现值钱）。
2. **市场第一天就要有：下载计数、排行榜、作者主页。** ClawHub 实测以下载数排 Trending；HF 的上传即分发+排行榜是 $4.5B 估值的地基。供需信号透明是创作者供给的第一驱动，比分成比例更重要。
3. **积分必须锚定真实价值物（token/算力），发放绑定真实使用。** 成功组（OpenRouter credits、Civitai Buzz）都是预付+消耗闭环、可变现；失败组（Steemit、BAT）锚定投机物、按行为发放→女巫攻击+内部人套利。PAI：技能下载赚积分，但积分主要用途是「消耗算力运行更多技能」，且配 Civitai 式早鸟衰减+每日上限防刷。
4. **安全审查前置是市场生死线。** ClawHub 头部技能恶意软件事件（HN 46898615，334pts）证明技能市场必然成为攻击面。设计：技能签名+沙箱权限声明（技能申请的 capability 白名单）+举报下架流+「认证作者」标识——对应 Raycast 的审核制 monorepo 与野生生态的双轨制。
5. **本地永久免费、网络能力收费（HA/Zed 界面）。** Home Assistant（本地控制 free + Nabu Casa 远程/AI 订阅）与 Zed（编辑器 free + 协作收费）验证了与 PAI 完全同构的切分。PAI：单机技能运行永久免费；技能市场云目录、跨设备同步、共享运行时（算力代跑）收费。
6. **多网关冗余是生存刚需，不是可选项。** OpenClaw 用户被 Anthropic/Google 相继限制（HN 47633396/47115805，均 >800pts）；缝隙工具 cc-switch 因此一年 132k★。PAI 必须原生支持多供应商+本地模型热切换，并把「不被任何上游卡脖子」写进卖点。
7. **许可证与作者权益条款第一天宪法化，永不横跳。** Redis（SSPL→Valkey 分叉→回摆 AGPL）、Elastic（两换协议）、Cal.com（闭源当天被 fork）、Open WebUI（BSD 改自定义+CLA 遭反弹）四案同结论：协议翻脸的代价是社区信任永久折价，且 AGPL 下社区当晚就能合法分叉。技能市场需另写：作者版权、弃坑技能的社区接管机制（OBS 式传承）、PAI 倒闭/转向时的生态逃生舱（格式开放+可导出）。
8. **分发≠变现，收入要三层结构。** saas-oss 组 15 个项目 stars 全部 44k+，但商业化 mostly unknown；Open WebUI 151k★ 仍在挣扎。收敛的可行结构：市场抽成（Civitai/Unity 式）+ 订阅（云同步/认证，Nabu Casa 式）+ 算力/token 差价（Cline/OpenRouter 式 BYOK 返佣）三层叠放，不押注单层。
9. **中国市场的两条已验证路线。** (a) 飞致云矩阵：一家公司养一排互补开源品互导流（MaxKB/1Panel/JumpServer 各 22k-37k★）；(b) DeepSeek/Dify：开源换全球信任+卖消耗/云订阅（Dify 云年付 $590/$1590 一手实证）。PAI 技能市场应双语上架，官方技能矩阵按互补簇设计（采集→清洗→上架→结算成套）。
10. **给作者 exit 预期，生态才有重投入。** LibreChat 一人项目被 ClickHouse 收购（HN 45877770）；GitHub Sponsors 个人 $100k/yr（HN 23613719）。技能作者的时间投入需要「被动收入+声誉资产+被收购/被雇佣」三重预期管理——PAI 市场的认证体系与收入公开榜（Opt-in）即服务于此。

## 方法论与局限

- stars/许可证/归档状态：`gh api repos/{owner}/{repo}`（2026-09-13 批量 100+ 仓库，2 个 404 为改名：cal.com→cal.diy、lobe-chat→lobehub、ComfyUI→Comfy-Org、typebot→baptisteArno/typebot.io，已跟踪重定向）
- 生态规模：GitHub topic 搜索 total_count（mcp-server 28,608 / nextjs 186,368 / ollama 23,370 / claude-skills 8,240 等）+ 目录 contents API 计数（HA 集成、Raycast extensions 均触及 1000 条 API 上限，记为 ≥1000）
- 商业事件：HN Algolia 检索 5 轮 60+ 查询，仅采信标题与分值可直接佐证的事实；媒体报道转述（n8n $2.5B 估值、HF $4.5B 估值、DeepSeek 545%）均标注「未一手复核」
- 一手官网取证：npm 周下载 136,032,572,712、WP 72,000 免费插件、OpenRouter 445 模型、ClawHub 下载计数、Dify 定价档位
- 未取到：GitLab 最新财年收入（SEC 404）、Blender/Godot 基金会当前金额与 Nabu Casa 定价（JS 渲染），Ollama/Jan/Cherry Studio 等多数本地 AI 工具的商业化数字（公开信息缺失，如实标 unknown）
