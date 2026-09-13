# Track 05 DIGEST — 开源商业化标杆 + AI 新商业模式（agent 支付/结果经济/数据资产）

- 生成：2026-09-13 | 条目：26（company 18 / repo 4 / article 4）| 基线 427 名已避开（仅 Cognition 一条为「复录+新进展」，新进展为 2026-09-08 融资）
- 检索降级实录：WebSearch 与 web_reader 主力配额耗尽（2026-09-26 重置）→ 降级为：本地代理 curl 直读官网（fetch.py）+ gh API（repo 元数据/README）+ HN Algolia API（真实提交 URL+日期+热度）+ Bing（仅部分有效，中国区结果不可用已弃）。所有 URL 经状态码核验（200/3xx）；Reuters/Bloomberg/NYT/substack/BI 直连被反爬挡（000），URL 来自 HN 提交记录，已在 _all.json 的 source_note 逐条标注。工具脚本存于 `_tools/`。

## A. Agent 支付与新清算层

1. **x402（x402 Foundation）** — HTTP 402 原生支付协议：未付费请求回 402，agent 用稳定币即时付款重试；零协议费、无账号无 API key。x402.org 实时面板（2026-09-13 直读）：近 30 天 75.41M 笔交易、$24.24M 交易额、22K 卖家。已从 Coinbase 移交中立基金会（Cloudflare 等参与），repo 6607★。
2. **UCP（Universal Commerce Protocol）** — Google+Shopify 牵头、Amazon/Meta/Microsoft/Salesforce/Stripe/Booking/Hilton 等共建的 agentic commerce 统一协议。repo 2025-12-31 创建即 9 个月 3370★；2026-05 Google I/O 的 Universal Cart 已在 Search/Gemini/YouTube/Gmail 上线（Nike/Walmart/Target 等商户）；Shopify 2026-06 开放自助 agent 注册。支付层对接 AP2/x402。
3. **ACP（Agentic Commerce Protocol）** — OpenAI+Stripe 维护的购买协议（1541★），规范从 2025-09-29 迭代到 2026-04-17（购物车/feed/订单/认证/MCP）；OpenAI「Buy it in ChatGPT」Instant Checkout 为首个大规模部署。
4. **x402 Bazaar 全量分析** — 对 Coinbase x402 登记簿 14,865 个挂单的可复现分析：仅 3.5% 显示真实需求。机器付费市场的第一份冷启动体检报告。
5. **Cloudflare Pay Per Crawl** — 用 HTTP 402+x-402 给 AI 爬虫按次收费（HN 569 分）；2026-06 beehiiv 等平台已落地「AI Crawl Control」三态开关（放行/封锁/收费）。内容方从「被白嫖」转向「按次收租」。

## B. 按结果定价（结果经济）

6. **Intercom Fin** — 在售页面三档全部「From $0.99 per Fin outcome」+座位费（2026-09 官网直读），另附百万美元保障。按结果计费已进入主流 SaaS 价目表并与订阅共存。
7. **Sierra** — Bret Taylor 的企业 agent 平台，首页第一卖点「Pay for a job well done」；官方博客系统论证 outcome-based 定价。卖「做成的事」而非 token，自担模型成本换溢价。
8. **Salesforce Agentforce（反面）** — Flex Credits/按对话计费打包进套餐，但采用不及预期（Reuters 2025-02），2025-12 转向确定性自动化并裁员 4000。结果不可控时按次计费=收入口碑双杀。
9. **Service as a Software（uxtigers）** — AI 卖的结果替代的是人力服务预算（万亿级），软件只是载体；按结果计费是自然对齐，定价天花板对标人工成本而非软件价格。
10. **Getlago（反方）** — 计量/归因/反作弊成本过高，赢家是 hybrid（订阅保底+用量+少量结果指标）。resolution 只在结果可验证的窄场景成立。
11. **Klarna AI 客服** — 官方新闻稿：首月处理 2/3 对话、等效 700 名全职人工。结果经济最早的可量化公开案例：省下的人工=可分配的价值池。

## C. AI 原生收入速度与上游挤压

12. **Lovable** — $100M ARR 用了约 8 个月（2025-07 官方博客），$200M 在 2025-11（TechCrunch）。credits+订阅混合、以可运行产物为交付单位。
13. **Cognition/Devin（复录+新进展）** — 2026-09-08 融 $2B+ @ $48B 估值；官方博客披露 run-rate 4 个月 $492M→近 $900M；客户含 NVIDIA/GE/Citi/奔驰；2025-07 已吞并 Windsurf。
14. **Anthropic** — 2026-08 年化收入破 $65B、筹备 IPO（Bloomberg/Reuters）。模型上游亲自下场吃应用层——下游技能市场必须选上游不愿做的长尾。
15. **OpenAI Instant Checkout + ChatGPT 广告** — ACP 即时购买（2025-09）+ 2026 年广告测试（NYT 报道品牌战役）：对话入口=新商店+新媒体，佣金+注意力双引擎首次合体。
16. **GitHub Copilot Premium Requests** — 「无限用」→订阅内配额+高阶模型按 premium requests 计量（2025-06 强制执行）。混合计价的巨头迁移剧本。

## D. 数据资产（正面/反面/协议化）

17. **Scale AI** — 2025-06 Meta 约 $14.3B 换 49%（公开广泛报道）；BI 2025-12 长文披露投资后减薪/挖角/转向。数据人力工厂有天花板且客户即竞争者。
18. **Mercor** — 专家数据/RL 任务市场（估值 $10B 级报道未独立核实）；2026-03 LiteLLM 供应链攻击致 4TB 语音/40K 专家数据泄露（HN 600 分复盘）。数据平台=高价值靶标。
19. **Surge AI** — 盈利、不靠风投，把前沿数据与 RL 环境做成 off-the-shelf 货架商品+专家网络。数据生意从项目制→目录化的样本（财务数字标 null）。
20. **Vana** — 个人数据主权：Data DAO+集体授权换回报；2026-08 在 LF Decentralized Trust 设 PDP-Connect 个人数据授权规范实验室；Vana Cup 3 周 43 应用/18,000 人自带数据。BYOD 有真实需求。
21. **23andMe→Regeneron（反面）** — 破产后 $256M 连同千万人 DNA 数据出售（Reuters 2025-05，附伦理承诺）。敏感数据变现公司的终局：资产贱卖+信任清零。

## E. 开源商业化新范式（2025-2026）

22. **ClickHouse** — $350M C 轮（2025-05）+扩展 C 轮（2025-10）。新一代 open-core：核心全开放，卖托管（运维复杂度=护城河），叙事挂「AI 时代分析」。
23. **Neon→Databricks** — 开源 serverless Postgres 被收购（2025-05 官方 FAQ），2026-08 再吸收 Electric SQL 成 team Neon。OSS 流量→平台收购的新退出通道。
24. **Ghost** — 非营利基金会+章程规定永不可被收购、100% 收入再投入；Ghost(Pro) 托管养免费核心，10 年自给自足。「不可收购」本身是信任护城河。
25. **Bitwarden** — 免费核心+$10/年个人层+企业版（2022 融 $100M）；2026-05 社区 715 分长文批评方向漂移。个人隐私工具超低价大规模可行；社区信任是复利也是负资产。
26. **（横切）x402/UCP/ACP 三层合流** — 微支付原语（x402）+商务统一协议（UCP）+购买流程标准（ACP）在 2026 年完成互操作对接：机器可付、机器可买、机器可卖的商业底座已铺完第一版。

## 对百倍升级的信号（≥5）

1. **清算层正在变成协议原语，抽成层的下一代是「记账+钱包」**：x402 近 30 天 75.41M 笔真实交易、零协议费；UCP 两个月 3370★ 且 Google 把 Universal Cart 直接铺进 Search/Gemini/YouTube/Gmail。PAI-Station 不该只做「市场抽 30%」，应内建个人侧 x402/ACP 客户端——用户的技能互相调用、技能向外购数据/算力时按次微结算，工作站自己变成一个小型清算所（a16z：小额高频机器商务是无人认领的增量）。
2. **定价单位决定定价权**：Intercom 把「resolution」写进价目表（$0.99/次在售）、Sierra 拿它当首页标语、uxtigers 给出「对标人工成本而非软件价格」的万亿 TAM——但 Getlago 与 Agentforce 反面证明：结果计费的前提是「结果可机器验证」。百倍机会不在改价格表，而在做**验收协议/可验证结果层**：谁定义「任务完成」的度量，谁就拥有市场的定价权。个人工作站的天然单位是「替你完成的小时数」（Klarna 700 人等价、Cognition $492M→$900M 已验证速度）。
3. **数据资产化的正确姿势是「卖加工品，锁原料」**：正面（Vana 进 Linux Foundation 标准化 BYOD、Surge 把数据货架化）与反面（23andMe $256M 贱卖、Mercor 4TB 泄露）对照表明——用户数据留在本地、对外售卖的是技能/结果等加工品，才是既能变现又不炸信任的路线；本地优先从工程选择升级为商业模式选择。
4. **open-core 2.0 = 核心全开源+托管付费+治理章程**：ClickHouse（核心全开放、卖托管）、Neon（OSS 流量→平台收购退出）、Ghost（宪法级不可收购=信任护城河）、Bitwarden（$10/年个人层可行，但信任损耗 715 分长文示警）。PAI-Station 的订阅层应卖「不用自己运维的常驻同步/备份/多端」，并用治理结构锁定「永不卖用户」——这是隐私型个人产品最强的获客杠杆。
5. **上游挤压决定生态位**：Anthropic $65B run-rate 亲自做应用层、OpenAI 佣金+广告双引擎——技能市场必须选上游不愿做的长尾（本地化/隐私/跨端/中文生态）并把多模型路由当对冲；Agentforce 翻车同样警示：没有可验证结果的按次计费会双杀。
6. **需求侧先于供给侧**：x402 Bazaar 14,865 挂单仅 3.5% 有真实需求——「可收费」≠「有人付」。先造每日任务流（需求），再挂价格牌（供给）；市场护城河是「结算+验收+复购」闭环，不是货架。
