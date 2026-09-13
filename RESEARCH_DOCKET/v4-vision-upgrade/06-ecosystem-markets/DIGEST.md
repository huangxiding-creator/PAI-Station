# Track 06 摘要：技能市场 / 插件生态 / 协议网络 / Agent 经济（2025-2026 新格局）

生成：2026-09-13。条目 33（`_all.json` 为准）。基线 427 名未重复；`anthropics/skills`、MCP Registry、A2A、Dify、ModelScope 五项按「复录+新进展」收录并注明增量。

**检索降级实录**：WebSearch/WebFetch/webReader 同池配额 09-13 耗尽（09-26 恢复）→ 实际通道为 gh CLI（全部星数经 gh api 复核）+ curl 直连/代理（官方文档 .md 端点、smithery.ai、glama、modelscope、marketplace.dify.ai、promptbase、apps.shopify、aws agentcore 等标题级实证）+ Chrome 抓取（Bing 结果被缓存查询污染，仅部分可用）。metaso API key 未注入。agnt.net、salesforce.com/agentexchange（403/404）、blog.replit.com/agent-store、n8n.io/creator-program 本网络不可达 → 未收录，未编造。支付协议组大量事实来自精选清单 tsubasakong/awesome-agent-payments-protocol（更新 2026-09-07，含 canonical 原链），仓库类均已独立复核星数。

## 条目摘要

### 分发协议与市场机制
1. **Claude Code Plugin Marketplace 协议（官方）** — 市场即 git 仓库：`.claude-plugin/marketplace.json` 目录清单，`/plugin marketplace add` 安装，5 种 source（github/url/git-subdir 稀疏克隆/npm/带凭证 zip）、版本化缓存、保留名防仿冒、跨市场依赖白名单。Anthropic 只发协议不建店。
2. **社区 Claude Code 市场层** — 协议发布数周内第三方市场涌现：everything-claude-code 2865★（黑客松冠军）、devsforge 73★、netresearch 56★（标榜跨 30+ agent 可移植）、skillsforge 40★，另有市场聚合器与 1942★ 中文分叉。供给端零运营自发生长。
3. **anthropics/skills 176,024★（复录+新进展）** — SKILL.md 格式成为事实标准、被 30+ agent 兼容；格式本身产生超越任何单一商店的网络效应。
4. **Smithery** — 「AI agent 的应用商店」：CLI 原语覆盖搜索→浏览器人工确认鉴权→安装→逐工具枚举（tool list github issues.），收录 100K+ 工具与技能，CLI 仓 arcadeai-labs/smithery-cli 834★；站点直接分发 OpenClaw 技能（含 metadata.openclaw 头）实现跨生态桥。
5. **MCP 官方 Registry（复录+新进展）** — registry.modelcontextprotocol.io，2025-09 预览、2025-10 API freeze；核心架构是 **metaregistry**：只存 server.json 元数据、指向 npm/PyPI/Docker，发布一次处处引用；官方文档明确预期 **subregistry**（策展增值层）被 ETL 消费。工作组成员来自 Stacklok/PulseMCP，背靠 Anthropic/GitHub/Microsoft。
6. **Glama MCP Registry** — 独立目录，实时标题显示 86,426 个 server。发现层规模化已远超人工策展能力。
7. **Docker MCP Registry** — Docker 官方（552★），复用容器镜像供应链分发 MCP 服务器。
8. **ToolHive** — 2162★，企业级 MCP 运行平台：签名/来源证明+OPA(Rego) 策略+容器沙箱；Stacklok 被 GitHub 收购、项目走向 CNCF。供应链安全范式从软件包移植到 agent 工具。
9. **mcpb（前 dxt）** — 2106★，官方 MCP Bundle 签名打包格式+桌面一键安装。zip 的正规升级路线：zip+manifest+签名+安装器四件套。
10. **MCPBench / LiveMCPBench** — 251★/104★，对 MCP 服务器与大规模工具集的独立评测基准。市场的质量评分层。
11. **Archestra** — 4267★，企业 MCP registry+gateway+orchestrator 一体（guardrails）。发现与治理单点合并。
12. **agents.md** — 24,329★，repo 根目录说明书开放格式（OpenAI 发起）。零基础设施的声明式发现。

### 交易与协议网络（agent 商务）
13. **UCP（Universal Commerce Protocol）** — Google+Shopify 发起（NRF 2026）：Universal Cart 已覆盖 Search/Gemini/YouTube/Gmail，Nike/Target/Walmart 等接入；Tech Council 10 员（2026-04 Amazon/Meta/Microsoft/Salesforce/Stripe 加入）；季度发布+领域分会（住宿/餐饮/支付）；Shopify 2026-06 开放 agent 档案**零审批自助注册**。
14. **ACP（OpenAI+Stripe）** — 1541★ Beta；RFC：agentic checkout、能力协商、payment handlers、折扣扩展；spec 演进至 2026-04-17 版（cart/feed/orders/authn）；NVIDIA 出零售参考实现。
15. **AP2（Google→FIDO Alliance）** — 捐 FIDO（60+ 组织）开放治理；v0.2 新增 Human-Not-Present 支付与 **Verifiable Intent**（用户授权防篡改日志，与 Mastercard 共研）；Gemini Spark 以 AP2 护栏（消费上限/白名单/显式批准/永久交易轨迹）跑常驻购物 agent。
16. **x402** — x402-foundation/x402 6607★（coinbase/x402 改为开发分支）；HTTP 402+paymentMiddleware 一行挂付费墙；v2 用 CAIP 标识；官方含「给 MCP 工具按调用收费」指南；Cloudflare Agents SDK 内建。
17. **MPP（Stripe）** — 2026-03 发布，向后兼容 x402，新增 session（流式/按用量）、周期付、稳定币/卡/银行多轨；Visa 出 MPP 卡规范+SDK。
18. **Visa TAP + Agent Directory** — 商家与 agent **互验**的双向注册表；2026-07-02 欧洲首笔 live agent 交易（30+ 发卡行）；2026-06 接入 ChatGPT agent 结账。
19. **Mastercard Agent Pay / AP4M** — 2026-06-10：agent 间高频低值支付网络（凭证→授权→交易→法币/稳定币结算）；agent 权限凭证记在公链（Polygon/Solana/Base）；Verifiable Intent 框架；30+ 伙伴（含 Cloudflare/Coinbase/Stripe/Ant International）；与 x402/MPP 互操作。
20. **支付宝 Agentic Commerce Trust Protocol + AI Pay** — 2026-01 上线，Qwen App 首发直连淘宝闪购；对话内选-订-付闭环；2026-02 **单周 1.2 亿笔**——全球最大规模实证。
21. **AMP（蚂蚁国际）** — 2026-04-28 开源：LLM/平台/商家 agent 接入 Alipay+ 44 亿钱包，绑定步骤较绑卡省约 50%，逐笔盗用退款保障。
22. **ERC-8183 + ERC-8004** — 链上 escrow 标准+身份/声誉注册表；结算时把履约反馈写回声誉——交易自动产生声誉。
23. **Virtuals Protocol ACP + OpenClaw 桥** — 链上 agent 雇佣市场（agent hires agent，escrow 结算、bonding curve 冷启动）；官方 openclaw-acp（167★，并入 acp-cli）直接桥接 OpenClaw 生态。市场从技能流通升维到产能流通。
24. **WebMCP（Chrome 149 origin trial）** — 网站把 JS 函数与带注解表单暴露为浏览器内 agent 工具；Booking/Expedia/Shopify/Etsy/Instacart/Target 早期试用。零安装技能路线。
25. **Web Bot Auth（IETF WG）** — 已特许工作组：web 自动流量的标准认证+bot 信息目录（HTTP 消息签名+目录草案 2026-06 版）；章程把 A2A 接口与终端用户认证划给 AP2/TAP 层。
26. **AGNTCY DIR** — Linux Foundation/Cisco 组件群：DIR agent 目录（importer/runtime/sdk）+OIDC 网关+安全宿主。运行时发现（市场即 DNS）路线。

### 渠道与对照
27. **ModelScope MCP 广场（复录+新进展）** — 魔搭上线 MCP 广场（标题实证）：中国云渠道型托管目录，同 org 维护 MCPBench。
28. **Dify Marketplace（复录+新进展）** — Dify 155,558★；官方插件仓 632★+marketplace.dify.ai 在线市场；插件在 daemon 沙箱内运行——平台信任由沙箱背书。
29. **elizaOS** — 19,327★「开源 agentic 操作系统」；agent OS+插件体系最成功的开源对位。
30. **PromptBase** — 「#1 提示词市场」2026 仍存活；但天花板低：内容不可验证/不可组合/无运行时。
31. **Shopify App Store** — 成熟 B2B 插件经济：billing 内建代收分成+认证；2026-06 起 UCP agent 自助注册零审批。钱轮与供给侧开放的双重范本。
32. **Amazon Bedrock AgentCore** — AWS agent 运行时（记忆/身份/编排/治理），云渠道绑定分发。
33. **A2A v1.0（复录+新进展）** — 签名 agent card、多租户、LF 治理、6 语言 SDK、a2a-x402 支付扩展。能力声明走向可密码学校验。

## 对百倍升级的信号（8 条）

1. **分发协议化，杀死 zip**：Claude Code 市场协议（git 托管 marketplace.json+5 种 source+版本缓存+依赖白名单）与 MCP metaregistry（发布一次、处处引用、subregistry 分层策展）共同指向——PAI-Station 的「zip+meta.yaml 交换」应重构为「git-native 市场协议 + 元注册表」，发布=push、更新=pull、安装=add；市场不做仓库做 canonical 元数据+策展层。
2. **升格闸门从人工改为机器可验证四层**：签名+来源证明（ToolHive/mcpb）→ 沙箱运行时（Dify daemon/Archestra guardrails）→ 自动化评测（MCPBench）→ 策略引擎（OPA）。「用户用出好技能→人工升格入库」应改为「技能自带 eval 结果+签名+运行策略，带证明升格」，排名消费交易衍生数据（付费调用次数、履约记录，ERC-8183 式结算写回声誉）而非下载量/好评。
3. **钱轮是飞轮的缺环**：x402 让「给 MCP 工具按调用收费」成为一行中间件；MPP 把计费粒度推进到 session 流式；Shopify 证明 billing 内建是插件经济规模化的前提。技能市场应从第一天铺好计量+结算轨道（哪怕免费），好技能直接赚钱→收入即质量信号→驱动升格排序。
4. **信任结构化而非评分化**：Visa Agent Directory（商家↔agent 双向验证，不进目录就没交易）、A2A v1.0 签名 agent card、AP2 Verifiable Intent（授权行为防篡改日志）、Mastercard 把 agent 权限凭证放公链。技能市场需要同构物：作者签名身份（锚定 IETF Web Bot Auth 类标准）、技能 signed card、高风险动作的授权日志——「已验证」必须机检。
5. **冷启动=协议开放+锚点供给+零审批**：Anthropic 只发协议→社区市场数周涌现（含中文分叉）；UCP 靠十巨头理事会+锚点商家+Shopify 零审批自助注册扩张供给。双层飞轮的「升格入库」闸门应后置到消费端（安装/付费/评测数据淘汰），发布端做到零摩擦。
6. **市场 API 优先、购买者是 agent**：Smithery 把发现/鉴权/安装/逐工具枚举做成 CLI 原语；AGNTCY DIR 做运行时发现（任务时查目录→动态实例化→用完释放）。为「agent 自主逛店」设计：目录 API、能力协商（ACP 式 manifest 是可协商接口而非死元数据）、按需即取而非预装囤积。
7. **分发面在多元化，安装包只是其一**：agents.md（repo 声明式）、WebMCP（网页即工具、零安装、Chrome 149 origin trial）、云渠道（AgentCore/魔搭广场）、OS 心智（elizaOS）。技能应做成多形态（本地包/远端声明式工具/劳务服务），Virtuals 更指出终局可能是 agent 产能的劳务市场（agent 雇 agent、escrow 结算）。
8. **规模窗口正在关闭**：Alipay AI Pay 单周 1.2 亿笔（2026-02）、anthropics/skills 176k★、Glama 收录 86k servers、UCP 已进 Google 购物全家桶——agent 经济基础设施的占位速度以月计；PAI-Station 若做生态，差异化只剩「个人工作站场景的垂直深耕+本地信任」，通用协议应全部接入而非自造。
