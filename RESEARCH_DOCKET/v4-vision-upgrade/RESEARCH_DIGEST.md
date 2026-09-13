# V4 调研总账（RESEARCH_DIGEST）

- 生成：2026-09-13 · 数据源：八路 `_all.json` 合并产物 `_merged_all.json`
- 纪律符合性：C14 全程——所有 URL 真实可溯源；WebSearch/webReader 周配额耗尽期间
  各路降级为 gh CLI / curl(代理) / HN Algolia / cn.bing(Chrome MCP)，降级实录见各 DIGEST。

## 一、数据总账

| 指标 | 数值 |
|------|------|
| 八路原始条目 | 240（31+40+28+30+26+33+29+23） |
| 跨路重复 | 1（elizaos：02+06 各录一次） |
| **基线（427 名）碰撞** | **0** |
| **净新增** | **239**（硬指标 ≥100，达成 2.4×） |
| 类型分布 | repo 111 / product 46 / paper 39 / company 27 / article 16 |
| 带实测星数的 repo | 124 |
| 复录+新进展（破例） | Cognition / anthropics/skills / MCP Registry / Dify / ModelScope / A2A / Bee |

**星数头部**（证明调研命中了 2025-2026 真实主战场）：
ECC 257k（agent harness OS）· anthropics/skills 176k（SKILL.md 事实标准）·
Dify 155k · spec-kit 136k（宪法层 spec 驱动）· OpenHands 87.7k · Ruflo 72.3k ·
MetaGPT 70.3k · OpenSpec 68k · GSD 64.5k · OpenManus 58.3k（框架天级平权）·
BMAD 53k · AstrBot 40.4k（中国 IM 侧挂）。

## 二、六大横切主题（62 条信号的收敛）

### T1 · 主权层是空位，引擎已过剩（01/03/07/08）
- agent-infrastructure-landscape 目录收录 **912 个记忆系统**——世界不缺第 913 个引擎；
  ai-memory / engrim / obsidian-second-brain 全在解「记忆怎么跟人走、跨 agent 走」。
- Second-Me 15.7k★ 验证「数字自我主权」叙事有社区买单，但只造了自我没造环境。
- Sovereign Reflections（2606.15728）给出学术敌人画像：平台的「数据殖民主义」。
- 尸检三律：HuggingChat/Dot 证明壳层必死、资产层留存；Moxie 证明需要「遗产模式」；
  23andMe 证明敏感数据变现公司的终局是贱卖+信任清零。
- **收敛**：V4 的产品不是引擎，是「主权的协议与持有层」——markdown 为源、
  可导入/导出/审计/遗忘，谁换 agent 都带着走。

### T2 · 增强用户取代替代用户，已有可计算的形状（07）
- MIT 脑电（认知债务）+ MSR×CMU 319 人（批判性思维迁移）+ 1182→439 人 12 个月纵向
  （陪伴致幸福感下降）——三重独立反面证据链。
- Enrichment Paradox（2603.24391）：委托越过临界阈值后能力衰减**不可逆**——
  共生还是退化第一次成为可计算相变问题。
- Cognitive Debt 形式理论（2606.15078）：认知债务=「未验证推理义务的存量」，可记账。
- Parasite（2508.11359）：多数使用模式下 AI 对人的信息收支是寄生——
  「信息贸易顺差」可以做北极星指标。
- **收敛**：第一个以「用户认知健康为 KPI」的常驻 agent 无人认领；
  V3 完全没有这个维度。

### T3 · 验证资产是护城河，机器判据是门票（04/07）
- Addy 70% 定律：前 70% 边际成本归零，价值全在后 30% 验证资产。
- promptfoo（行为级 eval 进 CI，OpenAI/Anthropic 在用）+ Qodo Cover 弃维护
  （测试「长出来」只是形式，金标准质量才是关键）+ Vibe Kanban 日落
  （纯编排壳被 IDE 原生吞掉）+ Tessl 转型（方法论要长成平台层）。
- Taskmaster（blader）：stop-hook 完成度守卫——evidence over narrative、
  确定性 done token、同会话恢复。**闸门只管入口，不管出口**是 V3 盲区。
- 记忆正确性三硬标尺：MemoryAgentBench 四能力（冲突消解！）+ StructMemEval
  结构测试 + Temvera 删除/双时态审计。
- **收敛**：进化敢全自动的前提是验证资产复利；谁定义「done」谁拥有定价权。

### T4 · 一切协议化：分发/信任/结算的原语已铺好（05/06）
- 分发：Claude Code 市场协议（git 托管 marketplace.json，社区市场数周自发生长）+
  MCP metaregistry（发布一次处处引用、subregistry 策展）——zip 死刑。
- 结算：x402 近 30 天 **75.41M 笔**真实交易、零协议费；UCP 进 Google 购物全家桶；
  支付宝 AI Pay 单周 **1.2 亿笔**；MPP/Visa TAP/Mastercard AP4M 全部互操作对接。
  机器可付、可买、可卖的商业底座第一版已铺完。
- 信任：A2A v1.0 签名 agent card、AP2 Verifiable Intent（授权防篡改日志）、
  ToolHive 签名+沙箱+OPA 策略、ERC-8183 结算写回声誉。
- **收敛**：全部接入、一个都不自造；差异化只剩「个人场景垂直深耕+本地信任」。

### T5 · 定价单位决定定价权，数据要「卖加工品锁原料」（05）
- Intercom 把 $0.99/resolution 写进在售价目表；Sierra 首页「Pay for a job well done」；
  uxtigers：结果对标的是**人力服务预算（万亿级）**不是软件价格。
- 反面：Agentforce 按次计费采用不及预期+裁员 4000；Getlago：计量/归因/反作弊成本
  高，赢家是 hybrid——**结果计费的前提是结果可机器验证**（回扣 T3）。
- 数据：Vana（BYOD 进 Linux Foundation）/ Surge（数据货架化）为正；
  23andMe 贱卖 / Mercor 4TB 泄露为反。本地优先从工程选择升级为**商业模式选择**。
- open-core 2.0：ClickHouse 卖托管、Neon 被 Databricks 收购、Ghost 章程级「不可收购」、
  Bitwarden $10/年个人层可行。
- **收敛**：定价单位=「替你完成的小时数」；原料（用户数据）锁本地，卖加工品（技能/结果）。

### T6 · 中国生态位：巨头收敛让出「跨生态主权工作台」，窗口 2-3 年（08）
- 通义并入夸克（收敛为超级框）+ 华为/荣耀/vivo OS 级 agent——单一巨头框内已饱和；
  空出的是**跨生态、跨厂商、用户主权的本地重型工作台**。
- OpenManus 6 万星：框架能力天级平权，护城河只能在框架外（数据/技能/记忆资产）。
- AstrBot 4 万星：中国个人 AI 最大实际载体是 **IM 侧挂**而非独立 App。
- Rokid×支付宝「看一眼支付」：高危动作的本土信任范式=**风控**（限额/白名单/
  异常检测/可回滚），不是权限弹窗。
- 零一万物收缩：底层模型会继续死人——**模型无关是生死线**。
- 尸检三律：不做专机+订阅（Humane $230M→$116M 变砖）；动作可审计可回放
  （Rabbit 被拆穿即信任破产）；壳层必死资产层留存（HuggingChat/Dot）。

## 三、对 V3 的四句话判词（GAP_REPORT 的引子）

1. **愿景**：V3 是「更好的工具」（对标 WorkBuddy）；世界顶级在争「主权层+认知健康+网络节点」——三个维度 V3 均为空白。
2. **方法论**：V3 有提案闸（入口、固定、人审）无出口闸；进化是周级仪式非任务级代谢；上下文无预算；金标准 40 条未资产化为定价权。
3. **商业**：V3 设想「市场抽成」；世界顶级在做「结算轨道+可验证结果定价+治理章程」——抽成层正被 x402 类零费协议降维。
4. **生态**：V3 是 zip+meta.yaml 孤岛标准+人工升格；世界已走向 git-native 协议+机器可验证四层闸门+交易衍生声誉。

—— 逐条差量见 `GAP_REPORT.md`；愿景重构见 `VISION_V4.md`；实现路线见 `PROPOSAL_V4.md`。
