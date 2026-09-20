# PAI-Station 调研框架全景图（FRAMEWORK_MAP）

> 2026-09-20 三路实测侦察整合（工厂实读 / 渠道在位性 / 本地语料盘点）。全部路径可核、数字实测。
> 定位：本项目的调研能力=「渠道层 × 方法层 × 工具层 × 质量层 × 运行时层」五层咬合的工厂体系，服务一个目标：
> **比调研对象董事长更深刻理解他们公司，比员工更懂他们公司。**

---

## 一、总览：五层咬合的调研工厂

```
┌─ 质量层 ────────────────────────────────────────────────┐
│ M-Score(Beneish八变量+146词典) · AI盲评(五维/50) · 金标准  │
│ (引注5/千字门) · 事实核验六器 · CI门禁 · Jev E3 分离缝      │
├─ 方法层 ────────────────────────────────────────────────┤
│ 万维钢桌研(思维密集度/五本书梯度/强力研读) × 何晓斌田野      │
│ (5W1H/解剖麻雀/报告五步) · EPC五阶段 · 工厂八步流水线       │
├─ 渠道层 ────────────────────────────────────────────────┤
│ 工厂64适配器(9类) + 仓级20渠道(实测在位) + 4路金矿桥接      │
│ + 本地语料298G+ · 账号安全四件套治理                       │
├─ 工具层 ────────────────────────────────────────────────┤
│ research_studio ~130 py 管线 · Jev判断层(三原语/开关/熔断) │
│ · Chrome MCP · CLI群(opencli/dokobot/wecom/lark…)         │
├─ 运行时层 ──────────────────────────────────────────────┤
│ 7×24双车道常驻 · NB窗11-19错峰 · checkpoint 13阶段断点     │
│ · watchdog自愈 · 战报台账                                  │
└─────────────────────────────────────────────────────────┘
```

**产能实数（2026-09-20 快照）**：百强榜 100 家在制（0 完成/2 在制，09-18 启动，pre-NB 链 ~1 天/家）；
已交付样板：核电 14 章 122,011 字（191/281 引用验证过、十件套 10/10、盲评 20/50）、东方电气八件套 8/8、AI 投标调研 559 文件 1.15M 字。

---

## 二、调研渠道全景

### A. 工厂级 64 渠道适配器（`engineering-research.skill\scripts\channels\`）

| 类别 | 渠道（适配器） | 账号态/备注 |
|------|---------------|------------|
| 文献 | cnki / cnki_direct（知网双路）、shutong（数彤）、wenchuanyun（文传云）、arxiv、dangdang（当当） | 文献虫账号在位；DrissionPage+CDP 下 PDF |
| 研报 | djyanbao（洞见研报） | 密码登录+课题级 profile |
| 微信 | wechat_channel（公众号管理 API）、sogou（SouGouWeDown2 :3000） | 全采/关键词批量 |
| 搜索/新闻 | metaso / metaso_free（秘塔）、news / em_news / intl_news | api_key 在位 |
| 网站/视频 | website / deep_crawl（官网深爬）、video（B站 yt-dlp 3级fallback） | — |
| 资本市场 | **earnings_call（业绩会：巨潮破WAF主源+互动易副源）**、cninfo、chinamoney、shclearing、edgar、damodaran、**panjiva（海关提单）** | 财务/资本面主力 |
| 企业情报 | company_info（爱企查）、bidding（比地招标）、**ccgp（政采，C2 破墙：晚8h冷却+热身，医院 25,737 条实证）** | — |
| 政府/奖项 | mohurd / ndrc / nea / sasac / mofcom / mot / stats / creditchina / shixin / permit / **luban 鲁班奖** / awards / **jzsc 四库一平台** / standards / patents | — |
| 其他 | feishu（默认关）、rss、vip（12入口失效已退役） | — |

**渠道治理**：`channel_outcome.py` 连续 3 败熔断冷却 240 分钟；base sleep 0.5–2s；arxiv 3s 官方间隔；每课题落 `channel_cases.json`/`channel_health.json`/`collection_manifest_r{N}.json` 三账。

### B. 仓级 20 渠道（2026-09-20 在位性实测）

| 在位（18） | 形态 | 一句话用途 |
|-----------|------|-----------|
| weread-download | skill | 整书提取（日限2本/冷却熔断铁律） |
| SouGouWeDown2 | API :3000 | 公众号批量（409 锁天然串行） |
| djyanbao | CLI | 研报索引 |
| metaso(+upload) | CLI+skill | AI 搜索+沉淀 |
| ima 知识库 | skill(node) | KB 金矿（总包998+水利449） |
| lark-cli + 23 lark-* | CLI | 飞书 23 域，530 万字/750 对象 |
| mcporter 腾讯文档 | CLI(mcp) | 四服务 444 工具 |
| dws 钉钉 | CLI | 12 skill 全域（**待登录**） |
| wechat-cli(huohuoer) | CLI | 微信本地 21/21 库（197会话/634条实证） |
| qqmail-cli | skill+CLI | 邮箱只读+分级 |
| rss-harvest | CLI+OPML | 905 源（首轮 17,759 篇 905成0败） |
| bdpan 百度网盘 | CLI | 102G 裁判文书 BT 分发待授权 |
| court.gov.cn 工艺 | 方法论文档 | 法规官方获取六步（**未脚本化**） |
| NotebookLM ×3 | skill | Gemini 笔记本引用式答案+成稿主引擎 |
| opencli + dokobot | CLI | 通用调研（**agent-reach/xyz-dl 两件失踪**） |
| Chrome MCP | MCP | 持久浏览器（C2 破墙热身/调研通道） |
| epc-deep-research | skill | 5 阶段采集引擎（50+主题） |
| wecom-cli | CLI | 通知推送 |
| yt-dlp | skill | 视频字幕 |

### C. 金矿语料资产（范围×100 的家底，实测）

| 资产 | 规模实测 | 状态 |
|------|---------|------|
| F:\工程知识库超市 | **298G / 40,595 文件**（水利九库+古代水利19+智慧水利309+勘察设计319+工作助手598+工程建设449+投融资29…） | 只读金矿 |
| E:\AI-Station\04 智库 | 6.2G / 11,878 文件（万维钢/混沌/微信读书/洞见研报/Jev 研报） | 已部分入 localfiles 索引 |
| IdeaDig | 7.3G / 23,111 文件 | — |
| RSS 本地库 | 905 源 / 17,759 篇首轮 | epc100_enrich A 路 |
| ima KB | 总包 998 + 水利 449 对象 | epc100_enrich C 路 |
| 飞书语料 | 750 对象 / 530 万字 | 战略文档中枢 |
| 微信本地 | 21 库全解锁 | epc100_enrich B 路 |
| localfiles 盘点 | 29 万级文件枚举 / 31.5G chunk 库（449 万块补嵌进行中） | D 路（T1-T4 分层） |
| RESEARCH_DOCKET v3 | 11M / 267 文件（九路调研） | super-skill 调研产物 |

---

## 三、调研方法

### A. 方法论双源（super-skill references/research-methodology.md，语料本体永不上公开仓）

- **万维钢桌研**：思维密集度选源（准备时间÷阅读时间）→ 五本书梯度爬阶（畅销→热门→专家→硬书→前沿）→ 强力研读（读两遍只读两遍，笔记写到取代原书）→ 交叉点前沿形成观点 → 费曼检验+专家审稿。模型件：37%搜集停 / 基廷斯 / 过度拟合 / 学术积木 / 专家五重境界 / 律师机制。
- **何晓斌田野**：六步程序 5W1H（每步有交付物）→ 定性解剖麻雀×定量望远镜混合设计 → 访谈关系六原则 → 报告五步（立意→定题→思路→架子→资料三原则「精准新」）。
- **铁律**：「你的问题你负责」——调研的终点不是知道了什么，而是能给出什么思想/结论。

### B. EPC 调研五阶段 + 工厂八步

- epc-deep-research skill 五阶段：情报理解 → 主题生成（10 维度 50-80 主题）→ 多通道并行采集（5-7 通道）→ 整理去重（标题相似+前200字哈希指纹）→ 覆盖度分析（4 因子 0-100 评分，<60 补采）。
- 工厂八步（`EPC100\PLAN.md`）：scaffold 选题 → enrich 金矿桥接 → survey 采集（63 渠道关键词矩阵）→ framework/gap 萃取（SCQA+MECE+7 维+覆盖矩阵补调）→ smart_packer 打包（≤280 文件）→ NB 成稿（14 章+质量飞轮收敛）→ postchain 排版（md2docx 印刷级）→ promotion 宣传（三档，publish=草稿箱）。

### C. 质量体系八件（「比董事长更懂」的验证器群）

| # | 器 | 机制 | 实测基线 |
|---|-----|------|---------|
| 1 | M-Score | Beneish 1999 八变量（阈值 -1.78）+ 146 条产业链词典句级锚点 + 诚实弃权 | 东电 182.4 污染→词典根治→弃权 |
| 2 | AI 盲评 | 确定性匿名化→五维（证据链/逻辑/信源/独立思考/可读性）×10 分 | **首基线 20/50**（核电） |
| 3 | 金标准引注密度 | 可发布门 5 引注/千字；Adani 22.0 参考线 | gate_pass |
| 4 | cite_check | n-gram 包含 0.30 / 数字 0.60+地板 0.15，三态（真实/悬空/幻觉） | 191/281 通过 |
| 5 | atom_verifier | 原子三层漏斗 + RARR 最小编辑修复 | — |
| 6 | consistency_auditor | 跨章实体冲突（注入矛盾 10/10 检出） | 10/10 |
| 7 | sensitivity_probe | 逐源删除判带翻转→单源依赖警报 | 抓 M-Score 污染 |
| 8 | source_lineage + CI 门禁 | bigram Jaccard≥0.55 转载簇；引用真实率≥90%/有效≥80%/均分≥7.0 | e2e 黄金基线 |

### D. 实验方法（判断层科学化）

- Jev 三实验：E1 意图 Choice（p50 1.3s/$0.0001，conf 对错分离 0.92/0.70）；E2 任务 Noul（对抗集召回 1.00/误报 0.00 vs 规则基线 0.27/0.42）；E3 引文验证（**0.5 正切分离缝零跨界**：真阳 0.58-0.97 / 假阳全 ≤0.48；词面 90 分含 17 分假阳注水）。
- 金标准混合路由 86 题、needs_screen 四变体实测（具体问句 0.94 vs 抽象 0.17-0.27）。
- A/B 数字自洽验证（73+3=76 / 90=73+17）。

---

## 四、调研工具

| 层 | 工具群 |
|----|--------|
| 管线 | `scripts\research_studio\` ~130 py（survey/framework/pack/nb/flywheel/assemble/delivery/promotion/insight_engine_p6/blind_review/cite_check/atom_verifier…自带 tests） |
| 编排 | `EPC100\epc100_factory.py`（900 行主编排）/enrich/postchain/nb_preflight + `src\knowfactory\`（NB 知识工厂：orchestrator/auth/alchemy/upload） |
| 判断 | **Jev（paistation.judgment）**：三原语 noul/choice/score + 一键开关（env>ini>key）+ 熔断器（3 败/300s 冷却/半开试探）+ 六项合规轨迹审计 |
| 采集 | 64 适配器 + SouGouWeDown2 + DrissionPage + My-FireCrawl + PaperDown + Chrome MCP + yt-dlp |
| 成稿 | NotebookLM（14 章+质量飞轮：evidence_packer→chapter_evaluator→revision_engine）+ GLM 付费链（关键词矩阵/盲评） |
| 排版/宣传 | md-to-typeset-docx（印刷级 Word）→ promotion 三档（总包之声草稿箱） |
| 基础设施 | schtask 四 XML（AlwaysOn-Logon/Keepalive 30min/NightRun/NightStop）、run.pid 单实例、PAUSE 旗标、checkpoint 13 阶段、pipeline_watchdog、码热轮换、NB 隧道（金丝雀→美国 02 钉节点→HTTPS_PROXY 认领→三不抢还原）、Clash 开窗推送配方 |

---

## 五、运行时与产能

- **7×24 双车道常驻**：NB 车道（北京 11:00–19:00=美东错峰窗内 FIFO 推 nb_waiting 家）+ pre-NB 车道（全天候备料）；`_lane_pick` 线程锁原子占位不重复派活；NB 45min 起飞跑道闸、19:30 硬停、让路 We-AIPO 心跳。
- **断点续跑**：13 阶段 checkpoint；pending→running→nb_waiting→done|failed；attempts<3；到过门前复位不重跑调研。
- **台账**：state.json 百家账本（99 pending+1 running）/每日战报/outcome_ledger（+6/12/24 月回访设计）/nb_quota_ledger（120 事件/5h，1200/周）/corpus_ledger 每课题语料账。

---

## 六、已知缺口（诚实清单）

| # | 缺口 | 证据 |
|---|------|------|
| 1 | **通用调研 CLI 缺两件**：agent-reach / xyz-dl 失踪（memory 四件套记录过时） | PATH/npm -g/全库 grep 均无 |
| 2 | **法规渠道未工程化**：court.gov.cn 工艺停留在方法论文档，无脚本 | 06 迭代优化卷 |
| 3 | **钉钉无凭证**：dws 在位未登录，12 skill 闲置 | README |
| 4 | **结构化企业数据 API 缺位**：企查查/天眼查 openapi 未接（爱企查适配器是爬取非 API） | 渠道清单 |
| 5 | **产能瓶颈**：0/100 完成；pre-NB ~1 天/家 → 100 家≈百日；NB 窗是硬约束 | 战报 09-18 |
| 6 | **判断层未接调研链**：Jev 三实验实锤但仅接了 intent 路由/taskcards；E3 引文筛/大语料 Map-Reduce/预测校准未接线 | 悬决清单 |
| 7 | **盲评付费层靠 fallback**：GLM 余额不足时五维评分降级，20/50 基线是 fallback 分 | _blind_review.json paid=False |
| 8 | **金矿利用率低**：298G F 盘/F56 万块 chunk 补嵌进行中，语义路由未全域可用 | localfiles remaining 449 万 |

> 以上缺口即 100× 提案的靶子——见 PROPOSAL.md。
