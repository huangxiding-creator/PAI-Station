# 技能深读提取报告：knowledge-work-plugins(16) + anthropics-skills(2) + openai-skills(1) + planning-with-files(1)

> 提取员：t1 组（knowwork）。基线=EPC100 工程研报工厂 + 调研方法论栈；空白 W1-W9 见任务书。
> 所有路径相对 `E:\AI-Station\_proposals\skill-fusion-r2\research\vendor\skillsweep\`。
> 诚实纪律：20 技能中 8 个（40%）给出明确负面或保留意见，见各节【质量】。

---

## 一、knowledge-work-plugins（Anthropic 知识工作插件，16 个）

仓架构：11+ 个职业域插件（sales/legal/data/…），每插件 = `plugin.json + .mcp.json + commands/ + skills/`，全文件制无代码。仓内明显存在**两代产品**（详见共性模式 P1）：
- "模板代"：大而全的输出模板 + 领域知识，无降级路径无门；
- "运行时代"（sales 系 + small-business 系）：技能头带 Rules 块（untrusted content/tiers 降级/Gate），链式编排带接缝契约，且共享 `small-business/shared/` 下的失效模式 doctrine 文档（12 份，是全仓工程含金量最高的部分）。

### 1. bio-research/skills/start
- **一句话定位**：bio-research 插件的 onboarding 向导——列连接的 MCP、列兄弟技能、问用户今天干什么。
- **核心机制**：Step1-5 线性走场（欢迎语→探测 MCP→技能清单→可选二进制 MCP→问需求），无门无状态。
- **数据契约**：无。技能清单是一张写死的 5 行表。
- **可移植做法**：唯一可借的是"会话开头用廉价读探测本会话有哪些工具可用"这一动作，可并进 conductor 的渠道账本健康检查开场（但本项目已有更完整的实现，增量≈0）。
- **质量**：**负面**。整份文件大量 `~~删除线~~` 占位符（PubMed/ChEMBL 等 connector 名被划掉），是脱敏/剥离后的残骸形态；对"技能=可执行契约"没有任何贡献，纯话术。无脚本无测试。**融合提案不建议收录。**

### 2. data/skills/data-visualization
- **一句话定位**：图表选型 + Python 代码模式 + 设计/无障碍原则的纯知识技能（`user-invocable: false`，被动供 Claude 查阅）。
- **核心机制**：无流程。三块知识：① 按"数据关系→图型"选型表（13 行，含 Sankey/Slope/Bullet/Small multiples）；② 反模式清单（禁饼图<6类、永禁 3D、双轴慎用、堆叠多条带中段难比较）；③ matplotlib/seaborn/plotly 成品代码（含 format_number 千分位/货币/百分比格式化函数、色盲安全调色板 `PALETTE_CATEGORICAL`）。
- **数据契约**：选型表本身即契约（What-You're-Showing → Best Chart → Alternatives）；无状态机。
- **可移植做法**：W3 出版级图表——把"反模式清单 + 选型表"接到 EPC100 后置链的图表生成腿作硬校验清单（饼图/3D/双轴直接拒出，标题必须写洞察句 "Revenue grew 23% YoY" 而非 "Revenue by Month"）。注意本机已有 dataviz skill（色板/表单规格），应做**合并而非并存**：本技能的反模式与无障碍 checklist 是 dataviz 未覆盖的增量。
- **质量**：真好（作为知识参考）。证据：`format_number` 直接可用；"Title states the insight" 条目具体到例句。缺陷：无脚本、无验证环节（图生成后无渲染回看）；与 create-viz 内容重复约 60%（见下条）。

### 3. data/skills/create-viz
- **一句话定位**：`/create-viz` 命令版图表生成器，把 data-visualization 知识套上 6 步流程（理解→取数→选型→生成→设计→保存）。
- **核心机制**：6 步工作流；数据三来源（仓库查询/粘贴上传/会话前情）；未指定图型时按同一张选型表推荐并解释。
- **数据契约**：输入 `<data source> [chart type]`；输出 PNG（dpi=150）+ 生成代码返给用户。代码块里写死"Always include"三项（粗体标题/轴标签/spines 移除）。
- **可移植做法**：W3——"6. Save and Present"里的"把生成代码一并交给用户、并建议变体"适合 EPC100 图表腿：产图同时落一份可重跑的 .py，方便宣传三件复用同图。
- **质量**：**保留意见（平庸）**。它是 data-visualization 的命令包装，选型表、调色板、spines 代码几乎逐行重复——同插件内冗余设计。融合时只收一份，收运行视角的 6 步 + 知识视角的反模式清单即可。无脚本无测试。

### 4. design/skills/research-synthesis
- **一句话定位**：把访谈/问卷/工单蒸馏成主题-证据-机会的用户研究综合器（轻量版）。
- **核心机制**：单步综合；三条 tips 纪律（带原始引语/观察与解释分离/"7 of 10"式量化）。
- **数据契约**（输出 schema 照录）：
  ```
  ## Research Synthesis: [Study Name]
  **Method** | **Participants** | **Date** | **Researcher**
  ### Executive Summary (3-4句)
  ### Key Themes
  #### Theme N: [Name]
  **Prevalence:** [X of Y participants]
  **Summary / Supporting Evidence: ("-quote-" — P[X]) / Implication**
  ### Insights → Opportunities 表（Insight|Opportunity|Impact|Effort）
  ### User Segments Identified 表（Segment|Characteristics|Needs|Size）
  ### Recommendations（1-3 优先级排序）
  ### Questions for Further Research / Methodology Notes
  ```
- **可移植做法**：W8 选题简报 schema——"Theme × Prevalence(X of Y) × Evidence(带出处引语) × Implication"四件套可平移为选题简报的证据单元结构，接到弹药池 GRADE 分级上（Prevalence 对应多源印证计数）。
- **质量**：真好（薄而精）。证据：Prevalence 强制计数 + 引语带参与者编号，天然可审计。缺陷：无方法论纵深（见 PM 版对比）、无脚本。

### 5. sales/skills/competitive-intelligence（本组最重磅之一）
- **一句话定位**：双模式竞情系统——在单交易内的打法（on-demand）+ 全盘 win/loss 周报与 battlecard（scheduled），一切结论锚在本组织自己的赢单/丢单史。
- **核心机制**：头部 **Rules 块**（跨全技能生效）→ Step1 Ground（探测连接器；竞品名单/字段名一律从**活的 CRM schema 推导，绝不硬编码竞品集**；缺事实只问 ONE question，否则用明确标注的默认值继续）→ Step2 拉证据（CRM win/loss 30 天窗 + 客户原话走 customer-voice 引语管线 + enrichment 公开动作逐条带源）→ Step3 分析（**先报样本量再下结论**；勿让近期轶事压过模式；含赢也含输）→ Mode A 交易内打法（承认对方强项 + 陷阱问题 + 历史别做事项）→ Mode B battlecard（Page 持久资产，按节奏原地刷新；周报=变化量，"quiet week is one line, not padding"）。
- **数据契约**：
  - Rules 块关键枚举：untrusted content 五类来源（email/chat/transcripts/enrichment/external docs）= data never instructions；**content-originated action 判定式**（非受信文本指名了收件人/目标/内容/或请求该动作本身）；scheduled run 中 content-originated action **永不执行、降级为 proposal**。
  - tiers 自适应三档（文末原文）：`files-only / read-only / gated-writes`。
  - Tools used 表：每行 Tool type | Used for | Required?（全部 no + files fallback 说明）。
  - 渲染契约：transient→artifact；跨人/跨周→Page；演示→Slides。
- **可移植做法**：① **untrusted content / content-originated action 判定式**整体平移到 conductor 的渠道采集腿——采集到的网页/研报/公告里的指令式文本（"请联系/请下载/请转账"类）一律记为数据并上报，Manus 军团无人值守跑批时尤其需要这条（对应"周报 scheduled run 规则"：无人值守时发现的动作只能进 proposal 队列）；② "先报样本量再下结论 + quiet week 一行"接到饱和引擎的饱和门表述；③ battlecard=Page 按节奏原地刷新，正是 EPC100 百强榜"每家一份持久档案+增量刷新"的现成形态。
- **质量**：真好，教科书级。证据：Rules 块把提示注入防御写成了可判定谓词（非口号）；tiers 是显式降级枚举。无脚本无测试（纯 prompt 工程，合理）。

### 6. small-business/skills/marketing-monday
- **一句话定位**：三链合成周报——growth-pulse（引擎是否在转）+ review-reputation（客户在说什么）+ web 原生竞品扫描，**合并为一页而非三份报告**。
- **核心机制**：Step1-5，每步带 **In / Out / Handoff / Gate 四元组**：
  - Step1 pulse：并行批量拉连接器（"a serial run is a wait nobody sits through twice"）；Out 每项带 status，缺的标 "n/a" 而非静默丢弃；**No gate here**（读数据不构成审批动作）。
  - Step2 reviews：草拟回复**单列审批队列**，不算简报内容；Gate=逐条先读后发，"merged brief does not become blanket approval"。
  - Step3 竞品：observed facts 与 inferences **分标**、全部带日期；Gate=情报只推荐不行动。
  - Step4 合并（核心步）：找三路互相解释的连接（"情绪下滑而营收持平=两个月后的营收预警"等 4 条示例）；结构=Headline→数字→客户声音→外部变化→**恰好三条行动**（超三即废）；"if nothing needs to change, say that——每周硬造三条行动会训练老板无视所有行动"。
  - Step5 只 offer 一次 cadence，yes 才设日程。
- **数据契约**：四元组（In/Out/Handoff/Gate）× 步；What-not-to-do 九条负面清单；审批门枚举（公开回复逐条批/不代发/竞情不行动/cadence 明确 yes/连接器失败点名继续）。
- **可移植做法**：① In/Out/Handoff/Gate 四元组直接作为 **W5 多 worker 调研编排契约**的步骤级 schema——Manus 军团每个采集 worker 的输出都应长这样（尤其 Handoff：只把一句话结论传下游，不把五视图仪表盘塞进合并层）；② "三条行动上限 + 安静周不注水"接到 EPC100 自复盘腿；③ "connector 失败在 sources 行点名，named gap is information, a silent one looks like good news"——这是完备门（渠道逐条过账）最好的表述范本。
- **质量**：真好。证据：每步 Handoff 都写了"传什么/不传什么"；负面清单九条全部反真实事故。依赖 `../../shared/` 与 `../growth-pulse/reference/` 的相对引用**全部实际存在**（已核验），文档与实体不脱节。

### 7. marketing/skills/competitive-brief
- **一句话定位**：竞品研究 + 定位/信息/内容差距分析的完整模板库（battlecard 工厂）。
- **核心机制**：Trigger→Inputs（竞品名必填/自家语境/焦点）→ 逐竞品五路检索（官网/新闻 6 个月/内容策略/评测站/招聘信号）→ 输出 7 段结构（Exec Summary→竞品画像→**信息对比矩阵**→内容差距→机会→威胁→建议 3-5 条）。
- **数据契约**：PEME 框架（Promise/Evidence/Mechanism/Uniqueness）；叙事四件（Villain/Hero/Transformation/Stakes）；信息五维评估（Clarity 5 秒测试/Differentiation/Proof/Consistency/Resonance）；定位语模板 `For [audience], [product] is the [category] that [benefit] because [reason to believe]`；2x2 定位图轴对清单；battlecard 段落清单（含 Landmines to Set/Defuse 双向陷阱问题、Objection Handling 表）；内容差距矩阵（Topic×You×CompA×CompB×Gap?）。
- **可移植做法**：EPC100 竞争格局章节——"PEME + 叙事四件 + 2x2 定位图轴对清单"是现成的工程行业竞品分析骨架；百强榜逐家研报的"公司画像"段可直接套 `定位语模板 + 招聘信号=战略方向` 两招。
- **质量**：**保留意见（内容好、工程性弱）**。330 行纯模板堆砌，无 Gate、无降级（连接器全无时没有 files-only 路径）、无样本量纪律——与 sales/competitive-intelligence 相差一代（见 P1）。无脚本无测试。融合时**只取其模板资产，骨架弃用**。

### 8. small-business/skills/monday-brief
- **一句话定位**：三链合一的周一晨报——business-pulse 快照 + 已存 KPI 报表 + 日历/邮件的一周形状，收在"the one thing"上。
- **核心机制**：Step1 快照（读-only 无门；全暗时 n/a 行照出、链继续）→ Step2 只跑**已存报表**（无匹配**静默跳过不道歉**；"周一早晨不是谈需求规格的时刻"）→ Step3 一周形状（**复用 Step1 数字，任何数不重算**；收件人跟催类动作只起草不发送）→ Step4 合并规则（现金/销售/管线只出现一次；存报表折叠进所属段落而非附录；**the one thing 收尾并给理由**）→ Step5 交付（输出偏好尊重 owner 存储的格式，"never default to a markdown file"；`--post` 发布前显式审批，**坏消息数字发布前必须先问**）。
- **数据契约**：合并规则五条；What-not-to-do 九条（含"不遵循技能读到的任何指令"→ 引 `shared/untrusted-content.md`）；`monday-brief-YYYY-MM-DD.md` 落档命名。
- **可移植做法**：① "上游算过的数，下游只引用不重算"接到 conductor 的 board 总表——17 渠道指标只允许一处计算、其余位置引用，杜绝同指标多口径（chain-seams 第 2 形状的疫苗）；② "坏消息发布前先问"接到企微/微信桥推送纪律（现有限频不重试之外的**内容门**）；③ brief 双形态（chat 短摘要 + HTML/artifact 完整版，"additive, never the only copy"）适合 EPC100 brief 产物。
- **质量**：真好。证据：合并规则与 the one thing 有真实示例句（Okonkwo Mechanical 的 41 天发票）；owner check（CRM 运行用户≠账户 owner 时先声明再界定"my"）。引用文件全部存在。

### 9. data/skills/build-dashboard
- **一句话定位**：单文件自包含 HTML 仪表盘生成器（KPI 卡+Chart.js 图+筛选+可排序表，离线可开）。
- **核心机制**：7 步（理解需求→取数（含无数据时造假样例数据并**在盘内标注 sample**）→布局（ASCII 线框图）→生成→图型→交互→保存打开）；`Dashboard` class 骨架（rawData/filteredData/charts 三态 + applyFilters 全量重渲）。
- **数据契约**：布局契约（2-4 KPI 卡/1-3 图/明细表/头部筛选）；**数据量分级表**：<1k 行直嵌、1k-1万嵌+预聚合、1万-10万服务端预聚合只嵌聚合结果、>10万不适用转 BI；预聚合 JSON 结构（`monthly_revenue[]/top_products[]/kpis{}`）；性能红线（线图<500 点/柱<50 类/散点<1000/表 100-200 行分页）。
- **可移植做法**：W3+W6——行业时序面板的 HTML 交付形态直接可用；数据量分级表接到 conductor board 的渲染层防呆。**注意**：模板从 jsdelivr CDN 拉 Chart.js（虽带 SRI integrity 哈希），EPC100 内网/离线场景须换本地打包，否则是纸面能力。
- **质量**：真好（代码模板库级）。证据：SRI 哈希都配了；分页/`Chart.update('none')` 等性能细节到位。缺陷：无验收门（生成后无"打开并确认渲染"的强制步——docx 技能的反例对照）；CDN 依赖如上。

### 10. operations/skills/process-doc
- **一句话定位**：把"活在人脑子里的流程"固化成 SOP（流程图+RACI+异常表）。
- **核心机制**：访谈式收集（"Start messy"）→ 输出模板。
- **数据契约**（输出 schema）：Purpose/Scope/**RACI 矩阵**（Step|Responsible|Accountable|Consulted|Informed）/Process Flow/Detailed Steps（每步 Who/When/How/Output 四件）/**Exceptions 表**（Scenario|What to Do）/Metrics 表（Metric|Target|How to Measure）/Owner+Last Updated+Review Cadence 头部。
- **可移植做法**：EPC100 自身工艺的元文档化——七步方法论的每一步用此模板固化（尤其 **Exceptions 表**："通常走 X，但 Y 时走 Z"恰是渠道出队闸/黑名单/积分制渠道这些分支规则的正确载体）；Owner+Review Cadence 头部适合 domain_blocklist 与渠道账本的登记簿。
- **质量**：平庸但有用。证据：三条 tips 中"**exceptions 是流程文档最值钱的部分**"是真洞察。无脚本无测试，轻量到一页。

### 11. product-management/skills/synthesize-research
- **一句话定位**：研究综合的完整方法论参考（主题分析/亲和图/三角验证/人设/机会量化全流程）。
- **核心机制**：5 步工作流（取数→逐源提取→主题与模式（**频率×影响四象限**：高高频高影响=最高优先/低频高影响=特定段重要/高频低影响=体验改进/低低=记下并降级）→综合输出→复查延伸）。
- **数据契约**：逐源提取六件（Key observations/Quotes/Behaviors/Pain points/Positive signals/Context）；**Finding 五件套**（Finding statement/Evidence 带源/Frequency/Impact/**Confidence level: High|Medium|Low**，5-8 条上限按频率×影响排序）；三角验证三型（methodological/source/temporal）；机会量化公式 Impact=(Users)×(Frequency)×(Severity)+Evidence strength+Strategic alignment+Feasibility；persona 反模式五条（人口学人设/太多人设/虚构人设/静态人设/无决策含义人设）；调查分析错误清单（均值无分布/忽略无应答偏差/小差异过解释/Likert 当区间数据/交叉表相关当因果）。
- **可移植做法**：① **Confidence level 三档 + "2 个访谈的发现是假设不是结论"**接到 Jev/LayaForge 判断层的证据分级输出侧（判断置信与证据量挂钩）；② 频率×影响四象限接到弹药池 ammo 的优先级排序（多源出现频次×行业影响）；③ "Sources disagree is signal, not error——如实报告分歧再深挖，不许挑一个"接到 ACH 假设对抗的证据冲突处置。
- **质量**：真好（内容密度全组前列）。缺陷：与 design/research-synthesis **同仓同质**（同一插件家族两个 synthesis，前者薄版后者厚版，无交叉引用）——又是冗余设计实证；500 行无分层 references，上下文成本高。

### 12. legal/skills/brief
- **一句话定位**：法律团队三模式简报器（每日/主题/事故）。
- **核心机制**：三模式分派（无参数时先问模式）→ 每模式各自的源扫描清单与输出格式；topic 模式明示"只综合已连源，不替代正式法律检索，需要现行效力/判例时指引用户去 Westlaw/Lexis"；incident 模式"**快而不全**：宁可快出，不等齐全"，立即标诉讼保全义务、GDPR 72 小时等硬时限。
- **数据契约**：daily 输出 7 段（Urgent→Contract Pipeline 三列计数→New Requests→Calendar→Team Activity→Deadlines→**Sources Not Available**）；incident 输出 10 段（Situation/Timeline/**Immediate Legal Considerations**/Relevant Agreements/Internal Response/Key Contacts/Recommended Immediate Actions 1-N/**Information Gaps**/**Sources Checked**）；每模式一个"Gaps 命名"段是强制项。
- **可移植做法**：W8——三模式（日常盘/主题深挖/突发事件）×"Gaps 与 Sources Checked 强制段"的骨架平移到选题简报：每份简报必须带"哪些渠道没查到/没覆盖"清单，与完备门对账。
- **质量**：真好（结构设计）。证据：Sources Not Available 升格为输出格式的一级段落（不是附注）；incident 的速度优先序写进 Important Notes。无脚本。

### 13. legal/skills/meeting-briefing
- **一句话定位**：会前简报准备器 + 会后行动项跟踪。
- **核心机制**：Step1-5（识别会议→按**会议类型×准备需求矩阵**（8 类会议）评估→跨源取语境→综合→**识别准备缺口**）；会后 action item 纪律与跟踪节奏（高优每日查/中超周查/低约月查/逾期升级）。
- **数据契约**：简报模板 15 段（Participants 表含 Key Interests/**Open Issues 表（Issue|Status|Owner|Priority H/M/L|Notes）**/Talking Points/Questions to Raise（每条带 why）/Decisions Needed（options+recommendation）/**Red Lines/Non-Negotiables**/Prior Meeting Follow-Up/**Preparation Gaps**）；行动项表（#|Action Item|Owner|Deadline|Priority|Status）+ 四类行动区分（legal 内部/业务侧/外部/待排会）。
- **可移植做法**："Decisions Needed（选项+建议）+ Red Lines"两段接到 EPC100 悬决事项上报企微的固定格式（现在 PAI-Station V3 的悬决待用户项正缺结构化呈现模板）；行动项"单一 owner+具体日期"纪律接到工单系统。
- **质量**：平庸偏好。证据：类型矩阵与 Red Lines 段实用；但整体是模板罗列，无降级路径，与 brief 相比工程性弱一档。无脚本。

### 14. legal/skills/signature-request
- **一句话定位**：合同签署前检查清单 + 电子签路由。
- **核心机制**：4 步（受件→**签署前 7 项检查**（终稿无 open redline/附件齐/主体名正确/日期/签署权/内部批准/律师已审）→配置签署顺序（串行/并行/先内部审批）→路由或降级为湿签说明）。
- **数据契约**：检查清单 7 项枚举；输出含 `Pre-Signature Check: [PASS / ISSUES FOUND]` 门。
- **可移植做法**：**PASS/ISSUES FOUND 二值门**的形态可借到 W6 交付物验收门（docx 排版完成后跑"样式检查单：PASS/ISSUES"）；其余法律域绑定强。
- **质量**：**保留意见**。对本战场可移植密度全场最低（一条门形态而已）；"最常见的签署错误是法律主体名写错"这类细节无跨域价值。无脚本。

### 15. marketing/skills/performance-report
- **一句话定位**：营销绩效报告生成器 + 五渠道指标字典。
- **核心机制**：报告类型分派（campaign/channel/content/overall/custom）→ 8 段输出（Exec Summary→指标仪表盘（Metric|This|Prior|Change|Target|**Status: on track/at risk/off track**）→趋势→What Worked→Needs Improvement→Insights→建议（每条 What/Why 挂具体洞察/Impact/Effort/Priority + **2x2 优先级矩阵**）→下期重点）；趋势分析 7 步；归因模型 6 型对照表；优化流程 7 步（Identify→Diagnose→Hypothesize→Prioritize→Test→Measure→Scale）。
- **数据契约**：指标字典五套（email 9 指标带 benchmark 区间如 open rate 15-30%/social 8/paid 10/SEO 9/content 8/pipeline 9，每条 Definition|Benchmark|What It Tells You）；预测注意（<12 数据点必须标低置信、预测一律给区间）；Status 三态枚举。
- **可移植做法**：① **Status 三态（on track/at risk/off track）+ 指标字典带 benchmark 区间**接到 conductor board 渠道健康列（现只有成败计数，无"该渠道正常水位该多少"参照）；② "预测<12 点标低置信、给区间不给点值"接到金标准/Jev 一致率周报的表述规范。
- **质量**：真好作为领域知识，**保留意见作为流程**：340 行大而全，无 Gate 无降级，属模板代（P1）；benchmark 数字是营销域数字，工程研报场景需重造。无脚本。

### 16. sales/skills/account-context
- **一句话定位**：单一客户的 360 度跨源合brief（CRM+邮件+文档+通话记录+内部群聊→一页现状简报）。
- **核心机制**：与 competitive-intelligence 同代的 Rules 头（逐字同一套 untrusted content/tiers）→ Step1 Ground（字段名从活 CRM schema 推导；缺事实 ONE question 规则）→ Step2-5 分源拉取（CRM 核心记录+近 10 opp/15 联系人/90 天 10 活动；邮件 90 天取 5 线程且**必须开全线程再概括"落在哪"，绝不从搜索预览概括**；transcripts 取最近 1 条带关键点；chat 60 天）→ Step6 综合（**以现状叙事开头而非数据堆**）→ **Owner check**（CRM 运行用户≠账户 owner 时声明；非 owner 时草拟一条引用具体 opp 细节的私信请示，先展示草稿再经连接器发送）。
- **数据契约**：lookback 默认（email 90d/chat 60d/CRM 活动 90d）随组织周期弹性；输出段序（Current State 叙事 2-3 句→CRM→Key Contacts 表→Correspondence→Documents→Internal Chatter→**Gaps/Flags**：如"大单 30 天无活动""next step 空白""single-threaded"）；tiers 三档同 5 号。
- **可移植做法**：① **"从搜索预览概括=禁手"**接到全渠道采集腿：搜索结果页摘要不得直接充当该源的内容结论，必须取全文（djyanbao/秘塔等渠道漂移时的防呆）；② Gaps/Flags 段的旗标形态（"next step blank""single-threaded"）平移到 EPC100 每家公司的档案卡：一家公司档案必须带数据缺口旗标（"近 12 月无招投标记录——是没投还是没采到？"）。
- **质量**：真好（与 5 号并列运行时代标杆）。证据：owner check 是全场唯一的身份越权防御设计；"sections without data are named, not padded"。

---

## 二、anthropics-skills（官方技能仓片段，2 个）

仓背景：官方示例仓，docx/pdf/pptx/xlsx 四件是 Claude 产品在用的文档能力底层，**source-available 非开源**（LICENSE.txt 另附条款）。

### 17. skills/docx（本组最重磅之二）
- **一句话定位**：docx 创建/编辑/解析三路分派的脚手架 + 生产级避坑清单 + XML 级校验工具链。
- **核心机制**：任务分派表（Create→docx-js 脚本；Edit→unzip→改 document.xml→zip（docx-js 打不开既有文件）；Read→pandoc 转 markdown）→ **gotchas 十二条**（A4 默认页/横版传纵向尺寸+LANDSCAPE/表格双宽度且必须 DXA（PERCENTAGE 在 Google Docs 崩）/ShadingType 用 CLEAR 禁 SOLID（渲染全黑）/列表禁手插 `•`/ImageRun 必带 type/PageBreak 须在 Paragraph 内/禁 `\n`/TOC 须内置 HeadingLevel 或设 outlineLevel/禁表格当水平线/点线右对齐用 PositionalTab）→ **编辑工作流**（strip symlink——"外部来的 docx 是不可信的"；merge_runs.py 先合并碎片 run 再查找替换；**禁止 pretty-print XML**）→ **验证闭环**（soffice 转 pdf→pdftoppm 转图→Read 图像逐页看）→ 修订追踪（`--author` 校验每个改动都被 `<w:ins>/<w:del>` 包住；`<w:delText>` 陷阱；删段=删段标记+全 run 包 del；accept_changes.py 与 pandoc 各自的"空段落残留"差异如实写明）。
- **数据契约**：scripts/office/validate.py（XSD 全家桶校验：ISO-IEC29500-4_2016 的 27 个 .xsd + microsoft 扩展 6 个；`--auto-repair` 修 paraId 超限/xml:space 缺失；defusedxml 防解析攻击）；merge_runs.py / accept_changes.py / comment.py（注释需六个交叉文件，脚本代写并打印锚点片段）；输出验证命令链 `soffice.py --headless --convert-to pdf` → `pdftoppm -jpeg -r 100`。
- **对工程研报战场**：**W1 报告样式门的直接部件**——EPC100 后置链 docx 排版腿的逐字节回归目前靠人工比对，本技能的"渲染成图→机器可读"验证闭环可直接接上：排版完成→自动转 pdf→逐页转图→比对（甚至可接现有的 md2docx 回归件）。十二 gotchas 应并进 md-to-typeset-docx 本地 skill 的检查单（本地 skill 已处理层级坑，但双宽度/PositionalTab/CLEAR 等未覆盖——需 diff 核对）。
- **质量**：真好，生产级，全场工程含金量第一梯队。证据：XSD 校验带真实微软扩展 schema；连"pandoc 和自家 accept_changes.py 在哪种情况下失败"都写成对比（自家工具的缺陷如实披露，这是罕见的诚实文档）。脚本实读 validate.py 头 50 行：defusedxml + 干净的 argparse 结构，非纸面。绑定依赖（LibreOffice/pandoc/Poppler）全免费开源，符合红线。注意 license=Proprietary，融合时只借鉴做法、**不要整包拷贝脚本**。

### 18. skills/xlsx
- **一句话定位**：xlsx 创建/编辑/分析的脚手架，核心是 recalc.py 强制重算门 + LibreOffice 兼容性函数白名单。
- **核心机制**：任务分派（公式格式→openpyxl/批量→pandas/速览→markitdown/读模型→**两次 load_workbook**（data_only=True 得缓存值丢公式；默认得公式串丢值——一次拿不全））→ **每个输出的硬性要求**（专业字体/零公式错误/公式绝不硬编码结果（写 `=SUM(B2:B9)` 不写 Python 算好的数）/逐字遵用户规格（自作主张的重设计=失败，再优雅也是）/每个假设与硬编码数在读者可见处标注+真源引用格式 `Source: Company 10-K, FY2024, Page 45, [SEC EDGAR URL]`/给他人填的表必须带图例+一行示例）→ **重算门**（openpyxl 写公式无缓存值，不重算则一切读回 None；recalc.py 输出 JSON `status: success|errors_found / total_formulas / total_errors / error_summary 最多 100 格`；**errors_found 也 exit 0——干净退出≠干净工作簿**；"绿色重算只证明公式可算，不证明算得对——先写 2-3 条核对取值再铺全表"）→ **函数存活白名单**（Excel-2007 时代函数免前缀；六个 2007 后函数须 `_xlfn.` 前缀；**永禁 XLOOKUP/XMATCH/SORT/FILTER/UNIQUE/SEQUENCE**——LibreOffice 算不了或溢出元数据丢失致静默截断且 total_errors=0；公式被降权小写=没解析的速判法）→ 外部链接工作簿陷阱（`[1]` 索引指向磁盘上不存在的文件；openpyxl 保存即剥缓存值；recalc.py 在此状态**拒绝运行**，--force 接受损失）。
- **数据契约**：recalc JSON schema 如上；金融模型规范全量（配色：蓝=硬输入/黑=公式/绿=跨表链接/红=跨文件链接/黄=关键假设；数字：货币 `#,##0`+单位进表头/零渲染 `-`/负数括号/百分比**存分数**/年份存文本；结构：假设各自成格被公式引用 `=B5*(1+$B$6)` 禁 `=B5*1.05`/投影期公式全行一致——"孤零零被改过的一格是最常见的静默错误"）。
- **对工程研报战场**：① W6 交付物验收门——recalc JSON 的 `status/total_errors/error_summary` 是现成的机器可读验收协议，若 EPC100 财务测算表进 xlsx 交付，此门直接用；② "Source: 10-K, Page 45, URL" 的引用格式接到研报数据表规范（弹药池 GRADE 分级的 A 级证据应落到这种可回查粒度）；③ 金融模型五色规范接到百强榜公司财务对比表模板。
- **质量**：真好，与 docx 同级。证据：把自家工具链的三个静默失败模式（exit 0 陷阱/溢出截断/外部链接剥离）全部写成显式规则；"你引入的错误与你继承的错误长得一模一样——要证明是继承的，去原始文件查那个格子"是可操作的归因纪律。同 Proprietary license 注意事项。

---

## 三、openai-skills（1 个，仓已 deprecated）

仓背景：README 首行即声明 **deprecated**，迁往 openai/plugins 仓。本技能属 `.curated`。

### 19. skills/.curated/notion-research-documentation
- **一句话定位**：Notion 站内研究→四格式带引用文档的调研技能（Codex 形态）。
- **核心机制**：Quick start 5 步（notion-search 定源→fetch 摘要点→**格式选择**→按模板 notion-create-pages 建页→引用+后续 update）；Step0 是 MCP 未连接时的自修复（`codex mcp add/login` + 提示用户重启）。
- **数据契约**：① **格式选择决策树**：比较多个选项→Comparison(800-1200 字)；时效紧/简单→Quick Brief(200-400)；正式/大量文档→Comprehensive(1500+)；默认→Research Summary(500-1000)——**四格式×字数区间×适用场景**的分级输出契约；② 引用语义三级（inline `<mention-page>` 紧随句后/section 级/文末 Sources 分组（Primary/Supporting/Background））+ over-citing vs under-citing vs grouped 的平衡示例 + 过时信息标注格式；③ **evaluations/*.json**：`name/skills/query/expected_behavior[]/success_criteria[]` 双清单评测（罕见的技能自带评测）。
- **对工程研报战场**：W2 分级工作流——四格式决策树是现成的 light/medium/heavy 分级参照（W2 的形态可定义为：Quick Brief≈light、Summary≈medium、Comprehensive≈heavy，字数区间直接沿用并按工程研报尺度放大）；eval JSON 的 expected_behavior+success_criteria 双清单是给 EPC100 各技能写验收判据的模板。
- **质量**：中上，**三条保留**：① 绑死 Notion MCP（商业服务，且需 OAuth 登录），跨出 Notion 即无用——按"免费资源优先"红线只能借结构不能借链路；② **文档/评测脱节实证**：eval JSON 两处引用 `reference/formats.md`，而 reference/ 目录实际文件是 `format-selection-guide.md` 等（已改名未同步评测），是纸面漂移的实锤；③ 仓已 deprecated，上游不再维护。examples/ 四篇端到端样例（competitor-analysis/market-research/technical-investigation/trip-planning）是加分项。

---

## 四、planning-with-files（1 个）

仓背景：独立开源仓，v2.43.0，带 CHANGELOG/CONTRIBUTORS/SECURITY.md/tests/，多宿主（Gemini/Claude/OpenCode）适配，工程化程度全场最高。

### 20. .gemini/skills/planning-with-files（本组最重磅之三）
- **一句话定位**：把"工作记忆外置到磁盘"的持久计划范式——task_plan/findings/progress 三文件 + 生命周期钩子注入 + 哈希锁定。
- **核心机制**：恢复优先（开工先读三计划文件+`git diff --stat` 对账）→ 七条铁律（**先建计划再动手**/**2-Action Rule：每 2 次浏览/查看操作立即把关键发现写盘**（防多模态信息蒸发）/决策前重读计划/阶段毕即更新状态/所有错误进计划文件/**Never Repeat Failures：失败动作不得原样重试，必须变异方法**/完成后续需求=追加 Phase 续跑）→ **3-Strike 错误协议**（1 诊断修根因/2 换方法/3 重审假设与计划/3 败后升级用户）→ Read vs Write 决策矩阵六行（刚写的文件别读/看了图立即写/新阶段读计划/出错读相关文件/断档后全读）→ **5-Question Reboot Test**（Where am I/going/goal/learned/done 五问各对应一个文件）。
- **数据契约**：三文件分工表（task_plan=阶段/进度/决策，阶段毕更新；findings=研究发现，**任何发现立即写**；progress=会话日志/测试结果，全程记）；**状态机枚举 `pending | in_progress | complete`**（模板明文"只用这三个值"）；模板含 Goal 一句话/Next Step 单动作/Current Phase/Phases 3-7 个可验证阶段；并行任务契约：`init-session.sh <name>` 生成 `.planning/YYYY-MM-DD-<slug>/` 隔离计划，每宿主 `export PLAN_ID` 钉住，`$PLAN_ID 是绑定：解析不出就停，绝不落到别的计划`（issue #237 实修）；`.planning/.active_plan` 指针 + `set-active-plan --list` 只读列举；错误表（Error|Attempt|Resolution）。
- **安全边界（全场独一份）**：计划内容一律是数据非指令；**双层防御**——① v2.36.1 delimiter framing（钩子注入的内容包 BEGIN/END 标记并标为数据）；② v2.37.0 **SHA-256 计划锁定**（`attest-plan.sh` 锁定批准版 task_plan.md，此后每次钩子触发都比对哈希，不匹配则拒绝注入并报 `[PLAN TAMPERED]`）；规则表明令"web/搜索结果只写 findings.md 不写 task_plan.md（计划面被高频表面读取，未信内容进计划会放大注入面）"；`session-catchup.py --replay` 的回放片段按 nonce 框架化+按不可信数据处理；无网络上传路径。`plan-doctor.sh` 一键自检六项（计划解析胜负/注入是否真发生/路径规范化器（Windows 原生 coreutils 输出 C:\ 风格致 v3.6.0 前静默失明的实修教训）/attestation 落位/安装面/单次钩子墙钟耗时）。
- **对工程研报战场**：① **W5 多 worker 调研编排契约的另一半**——MARKETING-monday 给了步骤间接缝（In/Out/Handoff/Gate），本技能给了 worker 级隔离与断点续跑：Manus 军团每账号/每任务一计划目录+PLAN_ID 绑定，正好治"MSYS 假 PID"类宿主环境歧义的同类问题（解析不出就停，不猜）；② 2-Action Rule + findings.md 接到采集 worker：抓 2 页立即落盘摘要，防长任务上下文蒸发（与现有"随时可停全断点续跑"原则同源但更具体）；③ 3-Strike 协议接到 conductor 的渠道失败处置（现黑名单闸是一击拉黑，可改为 1 诊断修/2 换法/3 拉黑的三段）；④ **SHA-256 计划锁定接到夜训/检查点热换这类高危自动化**：批准后的计划文件上锁，任何静默改动触发即停——比"预备就位+自动触发"模式多一层防篡改；⑤ 5-Question Reboot Test 作为长跑任务的每日自检表。
- **质量**：真好，全场工程化之最。证据：attest-plan.sh 实读——五级解析链（$PLAN_ID→.active_plan→mtime 最新→cwd 是 .planning/<slug>→legacy 根目录）+ slug 合法性白名单校验，真 shell 工程；plan-doctor 自带"Windows 原生 coreutils 曾致静默失明"的版本史教训；SKILL.md description 本身就是一份安全声明（无网络上传/钩子只报状态不请求续跑/不执行 Markdown 里声明的命令——自我约束写实了）。小保留：`.gemini/` 路径绑 Gemini 宿主命名（内容宿主无关，接线时去路径化）；钩子注入机制在 Claude Code 侧需对应 SessionStart/Stop hook 重配。

---

## 跨技能共性模式（模式级发现，≥3 条）

**P1. 同仓两代产品：模板代 vs 运行时代（最重要的一条甄别结论）。**
knowledge-work-plugins 内部清晰分两代：模板代（competitive-brief/performance-report/synthesize-research/process-doc/meeting-briefing）= 大模板+领域知识，无门、无降级、无安全边界；运行时代（sales/competitive-intelligence、sales/account-context、small-business 全链）= Rules 头（untrusted content 谓词化）+ tiers 三档降级（`files-only/read-only/gated-writes`）+ Gate 审批门 + 命名缺口 + 样本量纪律 + What-not-to-do 负面清单。**融合提案必须按代际甄别取材：运行时代取骨架（安全/降级/门），模板代只取资产（矩阵/字典/模板段）**，否则会把无防护的 prompt 拌进 7×24 无人值守管线。

**P2. 链式编排的接缝契约：In/Out/Handoff/Gate 四元组 + 数字单算原则。**
small-business 链（marketing-monday/monday-brief）把每个链步写成四元组，且两条铁律贯穿：①上游算过的数下游只引用不重算（"one set of cash numbers, from one place"）；②Handoff 只传结论级产物（"不把五视图仪表盘带进合并简报"）。配套的 `shared/chain-seams.md` 把跨技能事故沉淀成 doctrine：**"总数可作 context 传下游，但绝不能成为下游更窄口径技能的分母"**（QuickBooks 全司营收 vs Shopify 线上营收，广告回报率 4.7x 被算成 194x 的实锤案例）。这是 W5 编排契约最现成的规格书，也是 conductor board 同指标多口径问题的疫苗。

**P3. 诚实报告三件套：命名缺口 / 安静周不注水 / 观察与推断分标。**
运行时代技能共同强制：缺的源点名（"Sources Not Available"/"named gap is information; a silent one looks like good news"）；没变化就说没变化（"A brief that manufactures three actions every week trains the owner to ignore all of them"/"quiet week is one line"）；observed facts 与 inferences 分标且全带日期。这组表述纪律可直接升级完备门（渠道逐条过账）与饱和引擎（饱和门）的输出侧——现有设计管"查没查"，这套管"怎么如实说查的结果"。

**P4. absent-is-not-zero：把数据洞与业务事实的混淆写成判定规则。**
`shared/absent-is-not-zero.md` 用九个真实事故（账龄表截断致应收少报 1.1 万美元/P&L 汇总漏费用致毛利率 100%/未来时间戳致"最热线索"/`available:0` 实为 3071 美元在途）归纳出规则："报任何数前先问：业务正常时长什么样、数据坏了时长什么样，分不清就直说分不清"。这与 EPC100"统计热路径禁扫"修复的锁风暴、remaining 节流是同一类问题（洞被读成好消息），建议作为采集渠道与 board 指标的通用判定律收编。

**P5. 验证闭环物理化：产物必须变回机器可读的形态再判。**
anthropics docx/xlsx 的共同脊梁：docx 排版完→soffice 转 pdf→逐页转 jpg→Read 图像（视觉回归）；xlsx 公式完→LibreOffice 真重算→JSON（`status/total_errors/error_summary`）且拆穿"干净退出≠干净工作簿"；并附带"绿色重算只证可算不证算对，先手核 2-3 条再铺开"。这是 W6 交付物验收门可直接落地的两件参照协议（图像比对门 + 重算 JSON 门）。

**P6. 计划外置状态机 + 哈希锁定：长跑任务的可审计骨架。**
planning-with-files 的三文件（plan/findings/progress）+ 三值状态机（pending/in_progress/complete）+ PLAN_ID 绑定隔离 + SHA-256 计划锁定 + delimiter framing 防注入，构成"断点续跑、并行不串线、计划防篡改"的完整最小集。EPC100 的任务卡（taskcards）已有相近物，缺的是哈希锁定与"解析不出就停绝不猜"的绑定语义。

**P7. 冗余成对设计是普遍病（反面模式）。**
同仓出现三对半冗余：data-visualization vs create-viz（60% 逐行重复）、design/research-synthesis vs product-management/synthesize-research（薄厚两版互不引用）、sales/competitive-intelligence vs marketing/competitive-brief（两代同题）、notion 评测引用 vs 实际文件名（改名未同步）。提示融合提案在做技能归并时**同题必合并、评测与文档同改**，避免把别人的冗余病继承过来。

---

## W1-W9 空白覆盖情况（一行表）

| 空白 | 覆盖 | 本组最佳来源 |
|---|---|---|
| W1 报告样式门 | **强** | docx 十二 gotchas + 渲染成图验证闭环 + shared/artifact-style.md（house style 输出偏好契约） |
| W2 分级工作流 | **强** | notion 四格式决策树（字数区间×场景）+ tiers 三档（files-only/read-only/gated-writes） |
| W3 出版级图表 | **中强** | data-visualization 反模式清单 + build-dashboard 全代码模板（注意 CDN 需本地化、与本地 dataviz skill 合并） |
| W4 PDF/文献结构化解析 | **弱** | 仅 docx 侧（unzip/pandoc/merge_runs）可类比；本组无 PDF 技能，需他组补 |
| W5 多 worker 编排契约 | **强** | chain-seams + In/Out/Handoff/Gate 四元组 + planning-with-files PLAN_ID 隔离/哈希锁定（两者互补成完整契约） |
| W6 交付物可用性验收门 | **强** | xlsx recalc JSON 门 + docx 视觉回归门 + signature-request 的 PASS/ISSUES 二值门形态 + notion eval 双清单 |
| W7 学术检索聚合 | **零** | 本组无（bio-research/start 的 MCP 名单被划线剥除，不可用） |
| W8 选题简报 schema | **中** | legal/brief 三模式骨架 + research-synthesis 四件套（Theme×Prevalence×Evidence×Implication）+ Sources Checked 强制段；无专门"选题"schema，需自组装 |
| W9 三新件（校准/快照/红队） | **强参照** | absent-is-not-zero（≈校准的反面清单）+ chain-seams（≈快照口径统一）+ competitive-intelligence 周报 baseline roll-forward（≈校准账本）；三者合起来正是三新件的现货蓝本 |

---

## 收录优先级速览（供融合提案直接引用）

1. **必收（骨架级）**：competitive-intelligence、account-context（Rules 头/tiers/Gate 全套）；marketing-monday、monday-brief（接缝契约+诚实报告）；planning-with-files（状态机+锁定）；docx、xlsx（验证闭环，只借做法防 license）。
2. **收资产（模板/字典级）**：competitive-brief（PEME/定位图/battlecard 段）、performance-report（指标字典+Status 三态+benchmark 区间）、synthesize-research（Confidence 三档+四象限+三角验证）、build-dashboard（代码模板，CDN 本地化）、data-visualization（反模式清单，与本地 dataviz 合并）、legal/brief（三模式+Gaps 强制段）、process-doc（Exceptions 表）、research-synthesis（四件套）。
3. **选择性收**：meeting-briefing（Decisions Needed/Red Lines 段）、notion-research-documentation（四格式决策树+eval JSON 形态；弃 Notion 链路，注意已 deprecated 与文档评测漂移）。
4. **不收**：bio-research/start（脱敏残骸，零机制）；signature-request（域绑定强，仅一条门形态可借）。
