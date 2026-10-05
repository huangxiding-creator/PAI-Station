# FUSION_PLAN — 融合实施排期（1005 Arc O 第二波收官件）

> 输入：BEST_PRACTICES 66 条 × GAP_REPORT 十缺口 × 审计 8 lane 修正。
> 编制纪律：每项标 FT-编号（fusion ticket）+ 对标源 + 接线位 + 验收判据；
> 审计修正以 ✏ 内联（修正后的形态为准，原主张不实施）。

## P0 — 本轮立即实施（小体量高价值）

### FT-1 untrusted 围栏+defang 工具函数 ✅ 已实施
- **内容**：`ResearchFactory-Eng/lib/untrusted.py`——`fence_untrusted(text)`
  包 `<untrusted_content>` 围栏+前置 SECURITY 声明+defang 字面闭合标签
  （下划线→连字符，裸标识符不动）；`is_fenced()` 供测试。
- **对标**：last30days#3 + anysearch#4（横幅随数据走）。
- **接线实况**：anysearch 渠道 extract 出口已接线（实弹验证：输出带围栏+横幅）；
  Jev 判断腿/写作链深接线与 FT-3 同批实施（同一批代码路径一遍过，不两遍改）。
- **验收**：单测 6 条（defang 防逃逸/裸标识符不动/往返一致）✓。

### FT-2 坏主机连坐清除进渠道公共层 ✅ 已实施
- **内容**：`EPC100/collectors/net_hygiene.py`——`bad_host_ladder()`
  六类网络错误（DNS/证书/拒绝/超时/重置/5xx×N）→hostname 拉黑+从候选池
  删除该主机全部条目；`is_bad_host()` 查询；账本落 `data/net_hygiene/`
  （TTL 6h 自动过期防误拉黑永久化）。
- **对标**：node-DeepResearch#4。
- **接线位**：渠道收割件 URL 池过滤入口（pansou/opencli/search_library 共用）。
- **验收**：单测——单页 DNS 失败→同 host 全清；TTL 过期后放行。

## P1 — 近期工单（登记进 conductor 工单簿，独立会话实施）

### FT-3 执行回执账本（RQS 第 22 门的地基）
- **内容**：渠道腿/Jev 腿完成协议加 receipt 字段——cmd 哈希+产出文件
  sha256+行数；RQS 新增回执门（与 own_calculations 并列）。
- ✏ **审计修正**（DeerFlow lane）：L1 形态是 cmd 哈希+产出文件 sha256，
  **非**消息流派生（我们是 Python 确定性执行，无 LangChain 消息流）。
- **对标**：DeerFlow#0 三层验证栈。
- **验收**：Jev 腿自报「confirmed」无对应回执→门标 UNVERIFIED。

### FT-4 辛迪加转载检测（饱和门独立性升级）
- **内容**：同文检测进 coverage——标题 8-gram 相似+首段 MinHash，跨 host
  命中→标 syndicate_group，同组只算 1 独立源。
- **对标**：hyperresearch#2（5 份通稿=1 票）。
- **验收**：构造 3 站转载组，饱和门独立源计数=1。

### FT-5 中文信源权威度数值分层
- **内容**：权威度分（部委/官方 9-10，行业协会/官媒 7-8，门户 5，自媒体 3，
  匿名论坛 1-2）进信源资产库字段；GRADE 与权威度正交（A 级官方文件也可能
  是低权威自媒体转载——两维都记）。
- **对标**：LDR#1 四级打分（中文生态无 OpenAlex，规则分层替代）。
- **验收**：弹药池 manifest 新增 authority 字段，抽 50 条人工核对≥90% 正确。

### FT-6 实体覆盖账本（检索穷举可证明）
- **内容**：EEI 展开时记实体类型×已搜组合矩阵；轮末程序化回填未搜组合；
  连续零结果→「减约束词」指令。
- **对标**：LDR#0（SimpleQA 96.51% 机制）。
- **验收**：模拟 5 实体课题，回填腿生成的组合零重复、覆盖矩阵无白格。

### FT-7 新鲜度分级表
- **内容**：30+ 行领域→max_age_days 映射表进 lint 规则或 rqs_v3；
  V3-VERF 升级——数字句带 days_ago>领域阈值→warn。
- **对标**：node-DeepResearch#2。
- **验收**：金融数据句用 13 个月前来源→命中；静态事实句不命中。

### FT-8 quote 逐字对撞门（引用完整性第二阶段）
- **内容**：正文引号 span 对源文快照做归一化对撞（标点/空白折叠后），
  失配→warn；撤稿源（blocklist 命中）→error。
- **对标**：hyperresearch#1。
- **前置**：存档快照腿（METHODOLOGY 三.2）先行——对撞需要锚定版本。
- **验收**：构造改写失真引文→命中；逐字引用→不命中。

### FT-9 外部技能入仓扫描门
- **内容**：github-to-skill / SuperSkillWeekly 激活前跑确定性扫描——
  frontmatter 结构/禁 eval|exec|os.system/出站域名白名单/curl|bash 检测；
  内容哈希增量缓存。
- **对标**：scientific#2/#3 + DeerFlow SkillScan。
- **验收**：构造带 curl|bash 的恶意 skill 样本→拦截；干净 skill→零误报。

### FT-10 子进程环境洗刷
- **内容**：`utils/run_scrubbed.py` 公共封装——subprocess 前洗刷
  *KEY*/*SECRET*/*TOKEN*/*PASS*，良性变量（PATH/HOME/LANG）保留。
- **对标**：DeerFlow env_policy。
- **验收**：测试子进程读不到注入的假 OPENAI_API_KEY。

## P2 — 背板（择机）

### FT-11 RRF 跨源融合候选池
- **内容**：fusion_station——渠道收割件→URL 规范化→加权 RRF（subquery_
  weight×source_weight/(60+rank)）→富集保全去重→provenance 链。
- **对标**：last30days#0。
- ✏ **审计修正**（last30days lane）：实体接地**禁用「不接地才进池」硬门**——
  EPC49 对标战役同行证据故意不说主实体名；降权 -25+第一方地板 25+互动地板
  35 的救援结构才可移植。

### FT-12 Type-A/Type-B 验收门分类法
- **内容**：军团任务验收协议二分类——机器可查项执行者自判，质量项强制
  路由不同模型家族（GLM↔Jev 家族互审）。
- **对标**：ARIS#0/#1（「同一分布抽五次是一个带误差棒的意见」）。
- **前置**：FT-3 回执账本（Type-A 判定需要机器可查事实）。

### FT-13 HeadPeekr 便宜探查闸
- **内容**：抓全文前只下到 </head>，title/description/keywords BM25 判相关
  ——省抓取配额。
- **对标**：crawl4ai#0。
- **接线位**：opencli/pansou 的 URL 池预筛。

### FT-14 llms.txt 快通道
- **内容**：站点发现梯 sitemap→llms.txt（三变体）→SPA，命中 llms.txt 单请求
  拿全量（实测 10x）。
- **对标**：Skill-Seekers#0/#1。
- **接线位**：ebook_library 剩余站扫荡/p1b 慢站。

### FT-15 仓库级结构契约守卫（自家技能库）
- **内容**：对 ~/.claude/skills 全库机器校验——目录名==name/本地链接解析/
  scripts ast.parse/禁 eval。
- **对标**：scientific#2。

### 其余 medium/low 项
82 条 high 之外的 84 medium+21 low 留存 sweep2_result.json，按需检索；
不逐条立项（防工单膨胀）。

## 审计修正台账（8 lane 汇总）

| lane | 判定 | 修正落点 |
|---|---|---|
| DeerFlow 回执账本 | 放行+补强 | FT-3 形态改写（cmd哈希+文件sha256） |
| DeerFlow 四轮法 | 全成立 | 已用作本次蒸馏范本（模板照抄进 github-discovery 升级件） |
| DeerFlow prompt 缓存 | **delta 不诚实** | 降级不立项（我方 Jev 腿已有近似分离），转观察 |
| last30days 池参数 | 细节修正 | _diversify_pool 实名/槽位参数如实记录 |
| last30days 实体接地 | **形态禁止** | FT-11 禁硬门改降权+地板 |
| last30days 查询构造 | 增量收窄 | FT 未单列——keyword_engine.py 已有中文侧，英文意图词剥离并入 FT-6 组合 |
| last30days 红队接线 | 对象修正 | 接线对象改为「红队腿未来 LLM 化时」，当前零LLM腿无可围栏面 |
| Agent-Reach glm | 成立 | glm_client.py resolution 如实入档 |

## 收官判据

- [x] ≥100 源扫荡（208 unique）
- [x] 20 源深蒸馏（187 优点+审计）
- [x] BEST_PRACTICES / GAP_REPORT / FUSION_PLAN 三件套
- [x] report-helper F1-F6 融合（先行交付）
- [x] P0 两件实施+测试
- [ ] P1 九件进工单簿
- [ ] 全案推送+备份
