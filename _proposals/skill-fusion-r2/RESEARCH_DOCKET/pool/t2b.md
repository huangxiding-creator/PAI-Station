# T2 切片 B 轻扫提取报告（36 技能）

- 来源清单：`research/t2_slice_b.txt`（分数 6-7，邻域相关层）
- 方法：每技能只读 SKILL.md 本体 + Glob 目录清单判质量（未深读 references）
- 质量标签：A=有脚本有测试 / B=有脚本无测试或纯文档扎实 / C=平庸或纸面
- 统计：**A=2 / B=23 / C=11**。C 级集中在 composio 四件套、firecrawl 后两件、knowledge-work-plugins 半数——邻域分低不是没有原因的。
- 主战场参照：EPC100 工程研报工厂；空白 W1 样式门/W2 分级工作流/W3 图表/W4 PDF 解析/W5 多 worker 契约/W6 交付验收门/W7 学术检索聚合/W8 简报 schema/W9 内部债。

---

## 逐技能条目（按清单顺序）

### 1. flightaware [museai] — 航班查询与行程监控
- **定位**：FlightAware AeroAPI 渠道技能，查航班/机场/航司 + 预订行程的持续监控。
- **机制亮点**：(1) **cadence band 状态机**——按起飞前 48h/6h 分级 cron 频率（日→时→10-15min），每次运行先校正 cron 与当前频段一致再调源；(2) **事件指纹去重通知门**——材料性变更才生成 fingerprint，持久化先于发消息、同指纹绝不二次通知；延迟类指纹按 30/60/120 分钟档位判定、分钟值不入指纹（噪音抑制量化成指纹规则）；(3) **取消确证规则**——`cancelled:true` 单字段不算确认，须布尔与状态文本一致或独立来源佐证，冲突字段触发复查。
- **可移植**：fingerprint 去重 + cadence 分级调度直接可用于 conductor 监控腿（NB 锁/Manus 积分水位）；"高频 cron 体必须自包含（worker 无上下文也能重入）"是 W5 worker 契约的直接条款。
- **质量**：B（纯文档；附 eval/scenarios.yaml 评测场景，契约极扎实）

### 2. analyst-research [genli] — 三档投研研报工作流
- **定位**：投研/政策研报端到端工作流，light/medium/heavy 三档用户触发时选定。
- **机制亮点**：(1) **MODE_REGISTRY.md 单一真相源**——档参数全量化（页数 4-5/12-15/30-40、图表 0/6-10/25-35+、时预算 15min/1h/2-3h、硬停点 0/1/3、11 步 vs 8 步 vs 6 步）；(2) 分级加载顺序——每档只载必需 references，轻档显式跳过样式 spec 与图表模板；(3) 语言条件化 grep 红线（英文报告查未转义 `$`，中文报告查中文冒号比例）；(4) 项目脚手架落项目侧、skill 本体只读不污染。
- **可移植**：**直接对位 W2 分级工作流空白**——三档参数表 + 硬停点设计 + 档间升级路径（light→medium 前期工作可迁移）可整体搬给 EPC100 研报分档（快报/标准/深度）；语言条件化红线可进后置链排版门。
- **质量**：B（有 chart_template.py 无测试；中英双语文档体系）

### 3. pdf [awesome-claude-skills] — PDF 处理工具箱
- **定位**：PDF 全操作：提取文本/表格、建 PDF、合并/拆分、表单、OCR。
- **机制亮点**：(1) 任务→工具速查表（pypdf 基础操作/pdfplumber 文本表格/reportlab 生成/qpdf CLI）；(2) 表格提取→DataFrame→Excel 管线；(3) 表单场景分流到 forms.md + bounding box 校验脚本。
- **可移植**：**直接对位 W4 PDF 解析空白**——研报 PDF 弹药入库的表格腿（pdfplumber extract_tables→xlsx）可即拿即用。
- **质量**：A（scripts/ 10+ 脚本，含 check_bounding_boxes_test.py 测试）

### 4. auto-review-loop-minimax [ARIS] — MiniMax 外审循环
- **定位**：review→fix→re-review 自主循环（MAX_ROUNDS=4），MiniMax 后端。
- **机制亮点**：(1) **停止条件双门**——score≥6 AND verdict∈{ready,almost} 同时成立，且显式记录"早期措辞用 or、AND 形式为权威"的规格自我修正；(2) **REVIEW_STATE.json 断点契约**——status(completed/in_progress) + 24h staleness 判 fresh/resume，compaction 后可续；(3) 顶部**"禁止 /loop、/schedule 包装"反模式警告**——verdict 类技能被定时器重入 = 零新信号全 token 成本；要调度的是判决前的等待，不是判决本身；(4) 评审原文 verbatim 存档纪律。
- **可移植**：状态契约 + 停止双门可进 Jev 判断层循环腿；"verdict-bearing 禁止定时器重入"应写进 conductor 出队闸。
- **质量**：B（纯文档无脚本，状态机契约扎实）

### 5. experiment-audit [ARIS] — 实验诚实度审计
- **定位**：跨模型审计实验完整性：假 ground truth / 自归一化 / 幻影结果 / 范围不足。
- **机制亮点**：(1) **执行者只收路径、外审读码判案**——executor 不参与诚实度判决（评审独立性）；(2) **A-F 六查清单**（GT 来源/归一化分母/结果文件存在性与数字对账/死代码/范围用语/评估类型分类），每查输出 PASS|WARN|FAIL + file:line 证据；(3) EXPERIMENT_AUDIT.json 机器可读 + **file-as-switch**（无文件=技能从未运行=零影响）；(4) 永不阻断只打标——claims 带 [INTEGRITY: WARN] 标签流转给下游 result-to-claim/paper-write 消费。
- **可移植**：**直接对位 W6 交付验收门**——研报数字与证据文件对账（claimed number vs file content）可用 A-F 清单改造；advisory-never-blocks + 标签流转模式适配后置链成稿门。
- **质量**：B（纯文档，审计契约完整；源于社区实报的 #57/#131 造假案）

### 6. meta-optimize [ARIS] — 技能外环优化
- **定位**：分析 ARIS 使用日志（events.jsonl）→ 提议 SKILL.md/参数/收敛规则优化，只提议不落地。
- **机制亮点**：(1) **生产者/落地者结构性分离**——本技能无 Write/Edit 工具，落地须人 invoke /meta-apply（自赦免防线）；(2) **bottleneck_log.jsonl append-only 台账**——每周期命名当前瓶颈，下期报告"上期瓶颈是否被落地补丁解决、现移向何处"（瓶颈接力而非孤立快照）；(3) **harness diet**——模型升级 = 脚手架删除候选（但特权边界/验收门/输出契约/安全检查五类永不删），"模型变新"本身只是重读触发器不是删除证据；(4) 触发率评测用混淆矩阵（查询落到兄弟技能=描述重叠，修法是消歧不是加推销词）。
- **可移植**：日志驱动 + 瓶颈命名 + append-only 台账可增强 SuperSkill 周度自升级；触发率混淆矩阵对 skill 描述调优直接可抄。罕见坦诚：明写"Bash 绕过写未防护、integrity verifier 未建"。
- **质量**：B（纯文档，事件 schema 全文档化）

### 7. paper-slides [ARIS] — 论文→会议幻灯片
- **定位**：编译论文→beamer PDF + 可编辑 PPTX + 逐秒讲稿 + Q&A 预演。
- **机制亮点**：(1) talk_type→slide 数→内容深度三级映射（poster 5-8 / spotlight 8-12 / oral 15-22 / invited 25-40）+ 逐 slide 秒级时间预算表；(2) SLIDES_STATE.json phase 级断点；(3) style-ref 参考风格 opt-in 且**永不传给评审者**（保评审独立）；(4) 排版硬规则量化（≤6 行/行 ≤8 词/图 ≥60% 面积/字号下限 28/20/14pt）。
- **可移植**：讲稿时间轴 + Q&A 预演结构可用于研报的路演/汇报衍生品；排版量化门可并进 W1 样式门。
- **质量**：B（纯文档，LaTeX 模板在 templates/）

### 8. paper-write [ARIS] — LaTeX 论文起草
- **定位**：大纲→逐节 LaTeX 论文，8 步工作流（起草→理论一致性→文献→五遍审计→外审→逆大纲）。
- **机制亮点**：(1) **DBLP→CrossRef→[VERIFY] 三级引用链**（零安装零认证真 BibTeX）+ 内嵌 bib 清洗校验脚本（dead entries / year/venue/author 对账）；(2) **DATA_NEEDED HTML 注释标记**——证据缺口以 `grep -r DATA_NEEDED` 可检索的注释显式暴露，绝不编数字填坑（对位 GAP_REPORT 的 slot id）；(3) 五遍写作审计：去冗词/主动语态/句构/**术语一致 Banana 规则**（"香蕉"不许换同义词叫）/数字与引用完整性（摘要 N vs 表 1 对账）；(4) CONFIDENT PROSE 12 条声明-证据校准契约（过度对冲与虚假权衡都是缺陷）。
- **可移植**：**对位 W6+W1**：数字一致性 pass（正文数字 vs 证据文件对账）与证据缺口显式标记可整体搬进后置链；DBLP 链对位 W7 学术检索聚合的引文核验腿。
- **质量**：B（IEEE/ICLR/NeurIPS 模板资产齐；无测试）

### 9. research-refine [ARIS] — 方案打磨
- **定位**：模糊方向→问题锚定的可实施方法方案（5 轮外审循环）。
- **机制亮点**：(1) **Problem Anchor 不可变锚**——每轮 verbatim 复制 + drift 检查（评审建议若改变所解问题本身 = drift，须顶回或谨慎采纳）；(2) 7 维加权评分（方法特异性 25%/贡献质量 25%/问题保真 15%…）+ Simplicity Check 反膨胀（哪些评审建议是多余复杂度应拒绝）；(3) REFINE_STATE.json 五相状态机 + threadId 同线程续审；(4) 复杂度软上限：核心实验 ≤3、主声明 ≤2、新可训组件 ≤2。
- **可移植**：问题锚 + 漂移顶回 + 三软上限可直接用于研报大纲评审腿——防评审循环把研报范围越改越大；pushback-with-evidence 纪律对 Jev 判断层同构。
- **质量**：B（纯文档无脚本）

### 10. google-search-console-automation [awesome/composio] — GSC via Rube MCP
- **定位**：Google Search Console 六操作（站点列表/分析查询/URL 检查/站点地图）API 说明。
- **机制亮点**：参数级坑位表（sc-domain 前缀 vs URL 前缀、25k 行/请求上限、2-3 天数据延迟）；RUBE_SEARCH_TOOLS 先查 schema 再调用防漂移。
- **可移植**：无可移植（SEO 域外；先查 schema 再调用原则轻微可鉴）。
- **质量**：C（纯 API 说明书，无脚本无测试，模板复制感明显）

### 11. PhantomBuster Automation [awesome/composio] — 云采集账号管理
- **定位**：PhantomBuster agents/容器/配额/用量 API via Composio。
- **机制亮点**：组织配额资源检查 + 用量 CSV 导出；hCaptcha 求解参数契约。
- **可移植**：轻微——配额检查+用量导出模式对付费渠道账本有形式参考，但绑死 Composio 生态。
- **质量**：C（模板化 API 文档）

### 12. survey_monkey-automation [awesome/composio] — 问卷 via Rube MCP
- **定位**：SurveyMonkey 问卷/回收/收集器操作。
- **机制亮点**：搜索-连接-执行三步通用模式 + 分页/限流坑位。
- **可移植**：无可移植。
- **质量**：C（比 GSC 更薄，工具 slug 全靠运行时发现）

### 13. webscraping-ai-automation [awesome/composio] — 通用采集 via Rube MCP
- **定位**：WebscrapingAI 采集操作的最薄封装。
- **机制亮点**：session 复用与 memory 参数规范。
- **可移植**：无可移植（采集能力远劣于本项目自有渠道栈）。
- **质量**：C（本切片最薄，几乎全模板）

### 14. smoke-test [deer-flow] — 部署端到端冒烟
- **定位**：DeerFlow 拉码→部署（本地/Docker 双模式）→健康检查→报告全流程冒烟。
- **机制亮点**：(1) 双模式自动降级——Docker 拉镜像慢自动切本地；(2) 7 脚本分工（check_env/deploy/health/frontend_check 各自独立、幂等可重跑）；(3) **报告模板强制**——禁止自由发挥总结，必须用 templates/ 双模板之一；(4) **已知无害警告白名单**（飞书 SSL 错误等不阻塞通过，防误报）。
- **可移植**：无害警告白名单 + 模板化报告 + 幂等脚本分工，可直接用于 conductor 冒烟腿与 WeChatBriefDaily 等常驻管线的健康检查设计。
- **质量**：B（7 个 shell 脚本，无测试）

### 15. data-analysis [deer-flow] — DuckDB 数据分析
- **定位**：Excel/CSV 上传→DuckDB SQL 分析（inspect/query/summary 三动作）。
- **机制亮点**：(1) 单脚本三动作 CLI 契约（--action inspect|query|summary + --output-file，"不要读脚本只调用"）；(2) **SHA256(全部输入文件内容) 缓存键**——内容变即新库、路径无关，重复查询近零开销；(3) 多文件同查询上下文（跨文件 join）+ sheet→表名清洗规则。
- **可移植**：内容哈希缓存键可移植到弹药池语料索引（增量判定）；契约式脚本封装（agent 不读实现只按契约调用）值得 EPC100 工具脚本效仿。
- **质量**：B（1 个脚本无测试）

### 16. firecrawl-competitive-intel [firecrawl-workflows] — 竞品情报
- **定位**：竞品定价/功能/更新日志的持续性监控工作流。
- **机制亮点**：(1) **Rerun Inputs 块**——每次产出末尾附自身重跑参数（workflow+competitors+focus+cadence），为跨期 diff 留钩子；(2) 固定 JSON Shape（generatedAt/pricing/recentChanges/sources）；(3) 质量门：gated 内容记 contact-sales 不猜、保留 sources 供未来 diff。
- **可移植**：Rerun Inputs 自描述模式可直接进渠道账本/研报产出物——每份产出带自己的重跑参数；竞品定价/功能提取对 EPC100 研报竞品章节腿有直接复用价值。
- **质量**：B（纯文档短小但机制独到）

### 17. firecrawl-dashboard-reporting [firecrawl-workflows] — 仪表盘取数
- **定位**：认证仪表盘的可见指标提取报告。
- **机制亮点**：浏览器交互取数流程（设日期/点标签/展开表格）；"提取真实数字非图表标签"质量门；登录过期请用户重 auth 不绕过。
- **可移植**：轻微——认证站取数守则与账号安全纪律同向（不绕访问控制）。
- **质量**：C（与 16 同构模板，机制薄一层）

### 18. firecrawl-seo-audit [firecrawl-workflows] — SEO 审计
- **定位**：网站 SEO 审计（结构/页面/关键词/竞品 SERP 对比→优先级建议）。
- **机制亮点**：四线并行拆分（站点结构/页面 SEO/关键词 SERP/技术问题）；"建议须具体到页面+技术发现与策略猜测分离"质量门。
- **可移植**：无可移植（SEO 域外）。
- **质量**：C（同构模板）

### 19. analyze [knowledge-work-plugins/data] — 数据问答
- **定位**：自然语言数据问题→SQL→验证→呈现，三级复杂度路由。
- **机制亮点**：三级复杂度（快答/全分析/正式报告）各自输出形态；**呈现前五项验证清单**（行数合理性/null/量级/趋势连续性/聚合勾稽——子表加总=总计）。
- **可移植**：五项数据验证清单可进 W6 数字门——研报引用外部数据前的 sanity check 表。
- **质量**：C（纯清单方法论，平庸无独物）

### 20. explore-data [knowledge-work-plugins/data] — 数据集画像
- **定位**：新表/新文件的形状、质量、模式全面画像。
- **机制亮点**：(1) 列七分类法（Identifier/Dimension/Metric/Temporal/Text/Boolean/Structural）；(2) **完整性四级色阶**（>99% 绿/95-99 黄/80-95 橙/<80 红）+ 可疑值清单（占位值 N/A/999999/test、舍入偏差、未来日期、基数意外）；(3) 分布六形态 + 时序六模式判读 + 模式发现（外键候选/层级/冗余列）。
- **可移植**：新渠道语料首入库的画像协议可直接搬（列分类 + 质量分级 + 占位值检测）；完整性色阶可用于渠道健康账本。
- **质量**：B（纯文档但纵深扎实、清单即拿即用）

### 21. design-system [knowledge-work-plugins/design] — 设计系统管理
- **定位**：设计系统审计/文档/扩展三模式。
- **机制亮点**：audit 模式的 token 覆盖率 × 硬编码值计数表（多少实例硬编码 hex/任意间距）。
- **可移植**：轻微——"token 覆盖率 + 硬编码计数"审计思想可转为 W1 样式门（研报模板硬编码样式检测）。
- **质量**：C（域外，模板化）

### 22. comp-analysis [knowledge-work-plugins/hr] — 薪酬分析
- **定位**：薪酬基准/带宽落位/股权建模。
- **机制亮点**：P25/50/75/90 百分位带输出契约。
- **可移植**：百分位带格式对渠道产能/积分消耗报表有轻微形式参考；整体域外。
- **质量**：C

### 23. performance-review [knowledge-work-plugins/hr] — 绩效评审
- **定位**：自评/经理评/校准三模板。
- **机制亮点**：校准模式的评级分布表（对标公司目标比例）。
- **可移植**：无可移植。
- **质量**：C（纯模板）

### 24. content-creation [knowledge-work-plugins/marketing] — 营销内容创作
- **定位**：六渠道（博客/社交/邮件/落地页/新闻稿/案例）内容模板 + SEO + 公式库。
- **机制亮点**：(1) 标题 7 公式 + 开头钩子 6 公式（惊讶统计/反共识/场景/数据背书）可操作化；(2) 平台量化参数表（LinkedIn 1300 字符甜点、标题 <60 字符、meta <160）；(3) 每渠道结构模板带字数预算。
- **可移植**：钩子/标题公式库对 WeAIPO 自媒内容与研报宣传链（promotion 三档）有直接借用价值；平台字符参数表可进宣传渠道契约。
- **质量**：B（纯文档但公式密度高、可直接执行）

### 25. draft-content [knowledge-work-plugins/marketing] — 内容起草
- **定位**：按内容类型起草的执行版（content-creation 的下游）。
- **机制亮点**：品牌语音配置自动应用门（未配置时询问一次）。
- **可移植**：轻微——brand voice 配置文件模式对研报"风格 spec"固化有参考。
- **质量**：C（比 24 薄一层，执行清单）

### 26. contact-research [knowledge-work-plugins/common-room] — 联系人研究
- **定位**：Common Room 联系人画像查询（邮件/社交柄/名字+公司三级查找）。
- **机制亮点**：(1) 输入类型→查找方法分派表；(2) **数据稀疏时显式降级输出**——不猜 persona、不生成开场白，明确标注"数据受限"；只输出有数据的节、空节省略；(3) 活动信号以 `Contact Initiated`（60 天）为主信号，30 天无活动要标记。
- **可移植**："数据稀疏→显式受限输出而非猜测"与 ARIS DATA_NEEDED 同族，是研报证据不足章节的处理纪律；人物/公司调研腿（EPC100 高管背景）可参考其信号分级。
- **质量**：B（契约清晰 + references 指南）

### 27. report-pack [knowledge-work-plugins/small-business] — 定期报告包
- **定位**：定义一次、按节奏自动交付的 recurring 报告（report-builder + business-pulse 两技能链式拼装）。
- **机制亮点**：(1) **确认门分级**——新包一次确认、已存档定义零确认重跑（"再让用户描述上月定义过的报告 = 让命令显得坏掉"）；(2) **缺源不断送**——连接器挂了标 n/a 照常发货（"静默的周一 = 插件坏了"）；(3) cadence 只 offer 一次、拒绝后永不再问；调度态零交互（"要用户回答问题的定时报告不再是定时的"）；(4) 包+脉搏合并为单一交付物（两条消息=两件事读，一条=一份简报）。
- **可移植**：**直接对位 W8 简报 schema**——"已定义任务零交互重跑 / 缺腿不断送且缺口点名 / 单一交付物拼装"三条铁律可整体移植到 EPC100 周报与 conductor 调度腿。
- **质量**：B（纯文档，运行时契约设计一流）

### 28. lead-magnets [marketingskills] — 引流磁铁
- **定位**：lead magnet 的规划/门控/分发/度量策略。
- **机制亮点**：(1) 类型 × 阶段 × 投入矩阵（11 类型带制作工时）；(2) 门控梯度表（全门/半门/不门 + 每多一个字段降 5-10% 转化）；(3) 转化基准表（暖流量 20-40% / 冷流量 5-15%）。
- **可移植**：矩阵+基准数字的组织法对研报分发/获客策略有轻参考；整体域外。
- **质量**：B（references×2 + **evals/evals.json**——评测纪律）

### 29. marketing-council [marketingskills] — 营销议会
- **定位**：12 位传奇营销家（Godin/Ogilvy/Schwartz/Sharp…）模拟董事会多视角评审。
- **机制亮点**：(1) **强制异见者机制**——每次 3-5 席中必坐一位与问题倾向相冲突的顾问（"全同意的议会是镜子不是董事会"）；问题类型→适配顾问 + 天然异见者对照表；(2) **分歧地图**——不是罗列意见，而是 2-4 个真冲突 + 各自底层权衡（"Sharp vs Godin 在此实为 reach vs resonance"）+ 什么证据能裁决；(3) 拟真纪律：不虚构引语、在世人物加护、模拟声明置顶、档案与研究冲突时信研究。
- **可移植**：**强制异见者 + 分歧地图与 Jev 判断层/ACH 假设对抗直接同构**——红队腿可借"每议题必坐反方 + 冲突须可证据裁决"设计；12 份顾问档案的 dossier 结构（镜头/框架/签名问题/盲区）可做研报多视角评审的角色卡模板。
- **质量**：B（12 份顾问档案资产 + evals）

### 30. marketing-plan [marketingskills] — 年度营销计划
- **定位**：fCMO 级 13 节 AARRR 结构年度计划（8000-12000 字交付物）。
- **机制亮点**：(1) **progress.md 状态机**（fresh→INIT→REVIEW→FINALIZE→finalized）+ finalized 永不静默覆盖（升版 v{N+1}/重开/新起须问）；(2) 逐节交互审阅可断点续跑，sections/01.md 零填充分节文件；(3) 17 节现状评分 rubric + 139 点子库交叉引用 + **"不做什么和为什么"显式化**（Skip 带理由）；(4) 市场质量门（问题大小 × 频率四象限）作战略闸；开放决策显式化（"CAC 未知 = 最高影响开放项"不许糊弄）。
- **可移植**：状态机 + 零填充分节文件 + finalized 保护可直接用于 RESEARCH_FACTORY 阶段产物管理（W5 多 worker 契约：一 worker 一文件防合并冲突）；四象限选题闸对研报选题腿有参考。
- **质量**：B（15 份 references + evals，体系完整）

### 31. nature-shared [nature-skills] — Nature 写作共享引用包
- **定位**：Nature 系五个写作技能的内部共享依赖包（core/ + journal-formats/），非独立工作流。
- **机制亮点**：(1) 纯依赖包定位门——"不独立调用、只按需加载指定文件、不预载全包"；(2) 按刊分流且限额不互串（nature.md vs nature-machine-intelligence.md 各自文章类型/字数/投稿文件/数据代码义务）；(3) 语料推导的风格规则统一标注"非官方期刊政策"的诚实纪律。
- **可移植**：**共享引用包 + 按需单文件加载**架构对 EPC100 大体量方法论文档（METHODOLOGY.md 拆分、conductor/conductor 共享契约）是直接参考；每文件注明适用门防跨场景污染。
- **质量**：A（check_consistency.py + **tests/test_check_consistency.py**——纯写作技能里罕见的带测试）

### 32. documenting-legacy-codebases [riekelt-technical-writer] — 遗留代码库文档
- **定位**：从代码重建可信文档树的战役式方法（"代码是唯一可靠证人，其余皆证词"）。
- **机制亮点**：(1) **证据五级层级**（HEAD 代码 > 覆盖该路径的测试 > 运行时证据(带日期) > 提交史 > 名字/注释/旧文档/人记）——证词须验证后才入文；(2) **覆盖台账**（coverage.md）——每表面分母计数 + 背后命令 + 日期，中断后"重做零、漏做零"；(3) **死活三态判定**——alive=接线证明、dead=缺席证据具名（"无命令无控制器无自身测试外引用"）、dormant=接线但禁用；不能跑的代码禁现在时（时态规则）；(4) **refactor 测试**——"一次重命名就会证伪的句子 = 散文形式的实现细节，删"；多 agent 分层（枚举=小模型/抽取=中小/判断=中，读得多 ≠ 推理重）。
- **可移植**：**直接对位 W9 内部债**——EPC100/AI-Station 体系文档重建（conductor/EPC100 双仓数千 commit 的运行时知识固化）可用"调查先行 + 覆盖台账 + 证据层级"；模型分层分配对 conductor 双车道 worker 选型有参考。
- **质量**：B（纯文档但方法论纵深顶级）

### 33. technical-writing [riekelt-technical-writer] — 技术写作房规
- **定位**：仓库技术文档的统一规范（真值规则 + 文体 + 禁用构造 + 文档类型路由表）。
- **机制亮点**：(1) **文档五分类 × 编辑规则矩阵**——normative 被代码违反不许放水只记 violation；descriptive 精确随码；historical 永不重写；reference 穷举每一键；runbook 每步须真跑过；(2) 规则优先级六层（真值安全 > 类型技能例外 > 硬规则 > 目录惯例 > 风格偏好）；(3) 起草前四元组检查点（Kind/Audience/Purpose/Non-goals）；(4) 硬规则：一事一家（one fact one home）/不可追溯不陈述/过期文档加横幅不删/作者明说不改语气则风格 pass 停但真值仍绑。
- **可移植**：五分类编辑规则对 RUN_LEDGER/MEMORY 等长期活文档的编辑纪律直接适用；**"一事一家 + 索引与源冲突时源赢、索引是 bug"** 对弹药池/金矿索引设计是铁律级参考。
- **质量**：B（纯文档 + style/truth 两份 references，规范严密）

### 34. writing-issues [riekelt-technical-writer] — 工单写作
- **定位**：tracker 工单（epic/story/task/bug/spike）与验收标准写作规范。
- **机制亮点**：(1) **"离开你也能活"四问**——什么结果（世界的状态非步骤）/什么定 Done/证据在哪/谁拥有开放项（"仍需调查"无名字 = 违禁模糊归属）；(2) **验收条款可独立测试性标准**——"妥善处理错误"不算，"上传失败显示重试横幅并记 WARN"算；(3) 五类型一词一义 + spike 的 Done = 决策已记录（非"看过了"）；(4) bug 标题带症状不带诊断（"提醒时刻重复提醒"非"调度器竞态"，除非已证实）。
- **可移植**：**直接对位"已知空白转工单铁律"**——四问骨架 + 可测试验收条款示范正是工单质量门；bug 报告症状优先规则可进本项目 issue 模板。
- **质量**：B（纯文档，骨架即拿即用）

### 35. experimental-design [scientific-agent-skills] — 实验设计
- **定位**：数据采集前的设计决策：随机化/区组/DOE 矩阵（Fisher 三原则）。
- **机制亮点**：(1) 从问题出发的设计决策树（比较→CRB/交叉/整群；筛选→分数因子/PB；优化→响应面；仿真→拉丁超立方）；(2) 两个种子化脚本——randomization.py（简单/区组/分层区组/整群四种）+ doe_designs.py（七种设计矩阵，真实单位 + 默认随机化运行序防漂移混杂）；(3) **八大毁研究错误**（伪复制居首："3 鼠 100 细胞 = n3 非 n300"，重复测量≠独立重复）；(4) 与 statistical-power/analysis 技能分阶段交接。
- **可移植**：伪复制警告 + 种子化随机化纪律对双轨影子/AB 对比类验证的实验设计有直接参考（laya 影子一致率评估的样本独立性）；决策树组织法可效仿。
- **质量**：B（2 个可复现脚本，无测试文件）

### 36. geomaster [scientific-agent-skills] — 地理空间全域
- **定位**：遥感/GIS/空间 ML/30+ 科学域大百科（70+ 主题、500+ 例、8 语言）。
- **机制亮点**：(1) 16 份 references 分层索引（坐标系/核心库/遥感/ML/域应用/排错/数据源）；(2) 安装矩阵分 conda-forge 与 uv 两源并标注坑（rsgislib 仅 conda）；(3) 性能清单（空间索引 10-100x/分块读/Dask/Arrow）。
- **可移植**：无可移植（地理域外）。但巨域技能的"references 分层索引 + 安装源矩阵"组织法对大技能封装有参考价值。
- **质量**：B（知识库型，无脚本本体无测试，作为参考库扎实）

---

## 跨技能共性模式（≥3）

1. **断点状态 JSON + 24h staleness 门**（跨 4 仓独立收敛）：ARIS 全家（REVIEW_STATE/SLIDES_STATE/REFINE_STATE）与 marketing-plan（progress.md 状态机）都用同一契约：`phase + status + timestamp`；completed → 重启；in_progress 且 >24h → 陈旧重开；in_progress 且 <24h → 续跑。这是长任务免重跑的通用最小契约，与 EPC100 断点续跑同构，可直接标准化进 W5 worker 契约。

2. **"判决类步骤禁止定时器重入"**：ARIS 三个技能顶部反复出现同一反模式警告——verdict-bearing 步骤（审计/评审/优化）被 cron 重入 = 零新信号全 token 成本，且"循环接受自己的输出决定何时停 = 自我赦免"。正解：调度"判决前的外部等待"，判决本身只跑一次。对 conductor 出队闸是直接警示（哪些任务该 adopt、哪些该一次性）。

3. **执行者/判决者分离**（评审独立性，跨 4 仓）：experiment-audit（executor 只收路径、跨模型 reviewer 判案）、meta-optimize（producer 提议、/meta-apply 人闸落地）、paper-write/paper-slides（style-ref 参考永不给评审者看）、research-refine（anchor check 顶回 drift）。共同点：产生工件的一方不得出具放行判决。

4. **证据缺口显式标记而非编造**（跨 4 仓独立演化）：paper-write 的 DATA_NEEDED grep 可检索注释、contact-research 的稀疏数据降级输出（不猜 persona）、experiment-audit 的 [INTEGRITY: WARN] 标签流转、firecrawl 的 "gated 内容记 contact-sales 不猜"。四种形态一个原则——缺口可见化、绝不填充。研报后置链应统一采纳其中一种形态。

5. **append-only 台账 / 历史不可变**：meta-optimize 的 bottleneck_log.jsonl（瓶颈接力）、technical-writing 的 historical 永不重写（修正=新日期条目）、writing-issues 的 append-not-rewrite（范围变更=带日期追加注记）。与本项目"只增不删"红线同族。

6. **产出物自描述重跑参数**：firecrawl 的 Rerun Inputs 块、flightaware 的自包含 cron 体、data-analysis 的内容哈希缓存键——产出/任务自带重入所需的一切，不依赖会话上下文。

## 意外发现清单（清单外独特机制）

- **marketingskills 全套带 evals/evals.json**——连营销技能都有评测文件，而本切片多数代码技能反而没有测试；技能仓级评测纪律值得 skills-lock 生态效仿。
- **flightaware 延迟分档指纹**：30/60/120 分钟档位才构成新通知事件、精确分钟值不入指纹——把"噪音抑制"量化成了指纹规则，监控类渠道通知（企微推送防轰炸）可直接抄。
- **marketing-council 强制异见者 + 分歧地图**：比一般 multi-persona 技能深一层——产出不是意见集合而是"冲突 + 底层权衡 + 什么证据能裁决"；与 Jev/ACH 假设对抗直接同构。
- **report-pack"缺源不断送"**：连接器挂了标 n/a 照常交付 vs 静默跳过——运营型常驻管线的可用性设计，直接适用于每日/周管线。
- **meta-optimize 的 harness diet**：模型升级 = 脚手架删除候选，但五类（权限边界/验收门/输出契约等）永不删——把技能维护与模型代际挂钩的先行实践。
- **data-analysis 的 SHA256(内容) 缓存键**：以文件内容而非路径/时间为键，内容变即新库。
- **nature-shared 是纯文档技能里唯一带测试的**（check_consistency.py + test），证明"写作规范也能上一致性检查脚本"。
- **meta-optimize 坦白防御边界**：明写"故意绕过的 Bash 写未被防护、integrity verifier 未建"——纸面防御的诚实披露，罕见且值得学。

## 主战场空白对位速查

| 空白 | 命中技能 |
|---|---|
| W1 样式门 | paper-slides（排版量化门）、analyst-research（语言条件化红线）、design-system（token 覆盖率审计思想） |
| W2 分级工作流 | **analyst-research（三档注册表，头号命中）**、marketing-plan（13 节交互续跑） |
| W3 图表 | analyst-research（chart_template 契约存在但未深读）——本切片弱命中 |
| W4 PDF 解析 | **pdf（A 级，头号命中）** |
| W5 多 worker 契约 | marketing-plan（一 worker 一文件 + finalized 保护）、documenting-legacy-codebases（模型分层）、flightaware（自包含任务体） |
| W6 交付验收门 | **experiment-audit（A-F 对账清单，头号命中）**、paper-write（数字一致性 pass）、analyze（五项验证） |
| W7 学术检索聚合 | paper-write（DBLP→CrossRef→[VERIFY] 引用链） |
| W8 简报 schema | **report-pack（零交互重跑/缺源不断送/单一交付物）** |
| W9 内部债 | **documenting-legacy-codebases（覆盖台账 + 证据五级）、technical-writing（五分类编辑规则）** |
