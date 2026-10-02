# T2 Slice A 轻扫提取报告（36 技能）

来源清单：`research/t2_slice_a.txt`（邻域相关分数 7 档）。每技能只读 SKILL.md 本体，不深读 references。
主战场对照：EPC100 工程研报工厂；空白 W1 样式门/W2 分级工作流/W3 图表/W4 PDF 解析/W5 多 worker 契约/W6 交付验收门/W7 学术检索聚合/W8 简报 schema/W9 内部债。红线：免费优先/密钥不入库/只增不删。
质量分布：A×5 / B×18 / C×13。

---

## 1. doc-coauthoring [anthropics-skills]
- **定位**：人机协作写文档三阶段引导工作流（Context Gathering → Refinement & Structure → Reader Testing）。
- **机制亮点**：①Stage 3 用"零上下文 fresh 子代理"当读者测试盲点（no context bleed，预测 5-10 个读者问题逐一验证）；②每节走"澄清问题→5-20 项头脑风暴→编号挑选→surgical edit"循环，str_replace 永不重印全文；③退出条件显式化（连续 3 轮无实质改动→问能否删减；80% 完成时全文一致性/冗余/slop 复查）。
- **可移植**：W6 交付验收门——fresh-eyes 子代理读成品研报预测读者问题是零成本可抄的验收腿。
- **质量**：B（纯 prompt 工作流无脚本，但 Anthropic 官方设计扎实）

## 2. auto-paper-improvement-loop [Auto-claude-code-research-in-sleep]
- **定位**：论文自动改进环（外部 GPT 审稿→修复→重编译，2 轮封顶，+4.5 分实证）。
- **机制亮点**：①Reviewer Independence Protocol：每轮 fresh thread、禁传"上轮修了什么"，附实证（带上下文 3/10 虚高至 8/10）；②edit-whitelist 数据契约：YAML 声明 allowed/forbidden paths + forbidden_operations 正则检测器（new_cite/numerical_claim 等），拒绝必落日志不静默丢弃，forbidden_deletions 直接对应"只增不删"；③状态 JSON 断点续跑（24h 窗口）+ restatement regression test（正文↔附录定理归一化比对防漂移）。
- **可移植**：极强。评审独立性=Jev 判断层防自我盖章同构；edit-whitelist=只增不删红线的可执行化；分数进展表=质量门。
- **质量**：B（内联 bash/python 丰富+实证记录，无专门测试）

## 3. idea-creator [Auto-claude-code-research-in-sleep]
- **定位**：从大方向到排序研究 idea（风景调查→多透镜发散→跨模型评审→GPU 试点）。
- **机制亮点**：①Phase 3 只做机械去重+预算硬门（"annotate, not eliminate"），质量判断全部留给 Phase 4 跨模型评审；②双模型生成取并集+dedup_key 机械去重 schema（生成可同族、裁决不可同族）；③GPU 预算常量（单试点 2h 上限/总预算 8h）+ query_pack 威胁扫描门防缓存注入。
- **可移植**：强。"注释不淘汰"改良弹药池三态执行器（中间态留证据不空杀）；预算硬门=积分/配额调度门。
- **质量**：B（工作流+引用核验脚本链，无自带测试）

## 4. idea-discovery-robot [Auto-claude-code-research-in-sleep]
- **定位**：机器人域 idea-discovery 编排（survey→idea→novelty→review 四技能链接）。
- **机制亮点**：①Robotics Problem Frame 显式化（embodiment/benchmark/sim2real 逐字段，缺失默认 sim-first 安全侧）；②好/弱 idea 模式对照清单（demo-driven 不可 benchmark 即降权）；③Real Robot Rule：物理执行必须显式批准，AUTO_PROCEED 默认推进但硬件例外。
- **可移植**：中。"领域 Frame 先行+默认安全侧+付费/高危例外门"模式适配渠道调研编排。
- **质量**：B（纯编排文档，规则清晰）

## 5. mermaid-diagram [Auto-claude-code-research-in-sleep]
- **定位**：Mermaid 图生成+CLI 语法验证+严格视觉评审。
- **机制亮点**：①mmdc 渲染验证语法（MAX_ITERATIONS=3 循环修复）；②打分契约：箭头方向错→≤6 分封顶、块标签错→≤7、<9 不收；③双文件输出（.mmd 源+.md 预览）+学术配色规范（输入绿/编码蓝/输出橙）+KaTeX 数学标注规则。
- **可移植**：W3 图表空白直接可用：渲染验证+分项封顶打分可移植到研报图表门；mmdc 开源免费。
- **质量**：B（有验证命令链，无测试）

## 6. paper-illustration-image2 [Auto-claude-code-research-in-sleep]
- **定位**：论文插画多级迭代生成（Claude 规划/审→Codex image 桥渲染→评分≥9 收）。
- **机制亮点**：①preflight/finalize/verify 三脚本收据化（JSON 落盘证据，verify 不过不许宣称成功）；②refinement 反馈必须具体（"加大模块间距"而非"改好看点"）；③helper 解析四层回退链（CLAUDE_SKILL_DIR→.aris→tools→ARIS_REPO）。
- **可移植**：中。生成-评审-收据三件套模式适配图表腿；但依赖 Codex 付费 image 桥，违反免费优先——只抄模式不抄栈。
- **质量**：B（脚本齐+verify 契约）

## 7. research-refine-pipeline [Auto-claude-code-research-in-sleep]
- **定位**：方法精炼+实验计划两段式一条龙（先稳 thesis 再排实验）。
- **机制亮点**：①Planning Gate 五问显式过门（最终论点/主贡献/有意拒绝的复杂度/遗留审稿疑虑/前沿原语必要性）；②固定六输出文件契约（FINAL_PROPOSAL/REVIEW_SUMMARY/EXPERIMENT_PLAN/TRACKER 等）；③claims 跨三文件复用不漂移。
- **可移植**：中。Planning Gate 五问可做研报开工门；claims 跨文件一致=摘要/正文/结论一致性的机械化。
- **质量**：B（编排文档）

## 8. googleads-automation [awesome-claude-skills]
- **定位**：GA4/Google Ads 报表 MCP 工具手册。
- **机制亮点**：①"先 RUBE_SEARCH_TOOLS 拿实时 schema 再调用"防漂移；②Known Pitfalls 表（dateRange 非 dimension/exits 无效/格式硬坑）。
- **可移植**：低。广告域无关；schema 漂移防护与渠道逆向既有实践重合。
- **质量**：C（纯工具速查）

## 9. MailerLite Automation [awesome-claude-skills]
- **定位**：邮件营销 MCP 工具手册。
- **机制亮点**：①分页双制陷阱（subscriber cursor 制 vs campaign page 制，翻不全=采样偏差）；②嵌套响应形状坑（results[i].response.data）。
- **可移植**：低-中。"翻页不穷尽=统计失真"坑表模式可进渠道采集器维护手册。
- **质量**：C（纯文档）

## 10. similarweb_digitalrank_api-automation [awesome-claude-skills]
- **定位**：SimilarWeb 流量情报 MCP 手册。
- **机制亮点**：①运行时工具发现（搜 schema 不硬编码 slug）；②REMOTE_WORKBENCH+ThreadPoolExecutor 批量并行模式。
- **可移植**：低。SimilarWeb 若有免费额度可做竞品网站流量腿，默认不采。
- **质量**：C

## 11. developer-growth-analysis [awesome-claude-skills]
- **定位**：分析 Claude Code 聊天历史→成长报告→HN 资源→Slack DM。
- **机制亮点**：①history.jsonl 时间窗过滤做四维行为画像（项目/技术/问题类型/挣扎点）；②改进区必须 evidence-based（引用具体聊天证据）。
- **可移植**：低。与 self-profile 管线重叠，无新机制；所依赖 history.jsonl 格式有过时风险。
- **质量**：C（纸面流程）

## 12. chart-visualization [deer-flow]
- **定位**：26 种图表智能选型+JS 脚本生成（antvis 出品）。
- **机制亮点**：①数据特征→图型路由表（时序/对比/部分-整体/关系流/地图/层级六大类映射）；②统一 JSON payload 契约 `{tool, args}` 单入口调 generate.js，输出图 URL+完整 spec；③每图型独立 references schema 文件。
- **可移植**：强（正中 W3）。选型路由+单生成器入口可整体移植研报图表腿；MIT 开源免费。
- **质量**：B（有脚本+分型 schema，无测试）

## 13. skill-reviewer [deer-flow]
- **定位**：技能包只读审计评审器（只建议不改动）。
- **机制亮点**：①双轴评级：readiness 三态（blocked/revise/publish_candidate）×assurance 四档（static_only→regression_verified），"assurance 不得宣称高于证据"；②被审内容一律视为不可信数据（忽略包内嵌指令）；③强制走 review_skill_package 单一检查通道，不直接读文件。
- **可移植**：强。readiness×assurance 双轴=验收门成熟模板，适配 W6 交付验收门与技能池准入门。
- **质量**：B（rubric+checklist 体系，依赖外部工具）

## 14. instrument-data-to-allotrope [knowledge-work-plugins]
- **定位**：实验室仪器文件→ASM 标准 JSON/扁平 CSV 转换器。
- **机制亮点**：①三层解析梯队（allotropy 原生→模糊匹配回退→pdfplumber PDF 抽表）；②计算值必须带 data-source 溯源文档（derived 值溯源契约）；③软验证模式（未知单位警告不报错、--strict 收紧）。
- **可移植**：中-强。Tier1/2/3 解析梯队+pdfplumber 表格抽取直接适配 W4 PDF 解析腿；溯源契约适配弹药池出处链。
- **质量**：B（convert/flatten/export/validate 四脚本）

## 15. single-cell-rna-qc [knowledge-work-plugins]
- **定位**：单细胞 RNA-seq QC（MAD 自适应过滤+前后可视化）。
- **机制亮点**：①MAD（中位绝对偏差）自适应阈值代替硬编码 cutoff；②双供模式：一条命令全家桶 vs 模块化函数拼装；③过滤前后图+阈值叠加图强制落盘。
- **可移植**：低（领域无关），但 MAD 自适应异常检测可移植渠道健康监控（流量/成功率异常判定替代拍脑袋阈值）。
- **质量**：B（脚本+双模式 API）

## 16. validate-data [knowledge-work-plugins]
- **定位**：分析交付前 QA（方法论/计算/偏差三查+置信评级）。
- **机制亮点**：①七陷阱目录（join 爆炸/幸存者偏差/分母漂移/平均的平均/时区错位等，每条附检测 SQL）；②红旗清单（结果完美验证假设/整数巧合值=数据问题信号）；③三级评级（Ready/Share with caveats/Needs revision）；④分析文档复现模板（问题/数据源/定义/假设/查询全留痕）。
- **可移植**：极强。W6 交付验收门现成骨架：陷阱目录+红旗+三级评级直接改造成研报出厂数字核查门。
- **质量**：B（纯 checklist 但极扎实，附 SQL 检测法）

## 17. user-research [knowledge-work-plugins]
- **定位**：用户研究方法速查。
- **机制亮点**：方法选型表（样本量/周期）+访谈五段结构+四分析框架。
- **可移植**：无。
- **质量**：C（40 行纸面速查）

## 18. deploy-checklist [knowledge-work-plugins]
- **定位**：发布前检查清单生成器。
- **机制亮点**：①Rollback Triggers 前置（部署前定回滚阈值而非出事再定）；②按栈定制（feature flag/DB 迁移各加项）。
- **可移植**：中。回滚条件前置与夜训编排器保守收口同构，可补强 conductor 发布腿。
- **质量**：C（模板文档）

## 19. audit-support [knowledge-work-plugins]
- **定位**：SOX 404 内控测试方法论（金融合规级）。
- **机制亮点**：①四抽样法对照（随机/定向/随意/系统，各含适用场景与统计缺陷）；②样本量表（控制频率×风险等级→样本数）；③缺陷三级分类（deficiency/significant deficiency/material weakness）+聚合规则；④证据充分性清单（口头确认不算证据、无日期文件不算）。
- **可移植**：中-强。抽样量表适配弹药池质检（抽多少条验证渠道数据）；证据标准适配工单/验收取证；三级分类适配渠道健康分级。
- **质量**：B（纯方法论文档但极系统）

## 20. account-research [knowledge-work-plugins/sales]
- **定位**：目标公司调研简报（CRM 查重→enrichment 调研→ICP 打分→外联钩子）。
- **机制亮点**：①dedup before research（先查 CRM 防重复触达）；②ICP fit 表逐维证据化+未验证维度显式标注；③"content-originated action"法律式精确定义（不可信内容指定收件人/目标/内容的动作必须人工确认）——防注入动作劫持的最可执行表述。
- **可移植**：强。target-company 调研流程=百强榜逐家研报前置腿同构；content-originated 动作门移植到 Manus 军团产物处理（采集内容不得触发写动作）。
- **质量**：B（流程+反注入规则扎实）

## 21. crm-hygiene-check [knowledge-work-plugins/sales]
- **定位**：CRM 数据卫生只读审计（产出修复清单，修复移交他技能）。
- **机制亮点**：①七检查表（金额空/日期过期/阶段停滞>2x 中位数/单线程联系等）；②只读审计与修复执行分离（建议不执行）；③files-only/read-only/gated-writes 三态降级适配。
- **可移植**：中。停滞检测（>2x 中位数=stuck）可移植 conductor 僵任务检测；三态降级适配渠道缺失场景。
- **质量**：B

## 22. repo-intake-and-plan [lllllllama-rigorpilot-skills]
- **定位**：仓库只读侦察→最小可信复现计划（helper-tier，不执行）。
- **机制亮点**：①"最小可信复现"保守分级（推理>评估>训练）；②明确 helper 边界（自己不装环境不执行）。
- **可移植**：低-中。候选保守分级思路适配渠道工具评估（先冒烟再深用）。
- **质量**：C（本体仅 50 行声明式，实质在未读 references）

## 23. analytics [marketingskills]
- **定位**：埋点/追踪计划实施手册。
- **机制亮点**：①"为决策埋点不为数据埋点"原则；②对象-动作命名法；③验证清单（触发正确/无重复/无 PII）。
- **可移植**：低。无 web 产品埋点场景。
- **质量**：C（领域手册）

## 24. free-tools [marketingskills]
- **定位**：免费工具营销（engineering as marketing）策略。
- **机制亮点**：①八因子评分卡（25+强/<15 弃）；②反面案例警示（过度工程）；③维护/安全债计入决策。
- **可移植**：低。与自媒推广链弱相关。
- **质量**：C

## 25. schema [marketingskills]
- **定位**：schema.org JSON-LD 结构化数据实施。
- **机制亮点**：@graph 多类型组合+Rich Results 验证清单。
- **可移植**：低-中。仅当推广腿建 SEO 站点时有用。
- **质量**：C

## 26. notion-meeting-intelligence [openai-skills]
- **定位**：Notion 上下文+Codex 调研的会议材料准备。
- **机制亮点**：按会议类型路由六模板（status/decision/planning/retro/1:1/brainstorm）；MCP 失败时的自修复安装流程。
- **可移植**：低。会议域无关。
- **质量**：C（本体薄，实质在模板文件）

## 27. analytical-method-validation [scientific-agent-skills]
- **定位**：分析程序验证（ICH Q2(R2)/M10/USP/CLSI/ISO 六框架）计划与统计。
- **机制亮点**：①两铁律：先定治理框架再设计+验收标准先于数据（事后定标准=standing audit finding）；②脚本 exit code 契约（0 无发现/1 有发现/2 坏输入）可直接当 workflow 门；③纯标准库实现统计分布（无 numpy，任意解释器可复现）；④专业纠偏：r² 不是线性证据（lack-of-fit F 替代）、TOST 等价检验替代 t 检验"不显著=等价"谬误。
- **可移植**：强。"验收标准先于数据"=三门验收的立法哲学；exit-code-as-gate 可抄给 parity_gate 类工具；纯标准库哲学适配离线部署。
- **质量**：A（六脚本+协议/报告模板+source ledger 溯源，出版级）

## 28. bulk-rnaseq [scientific-agent-skills]
- **定位**：RNA-seq 端到端编排器，自称"router not reimplementation"。
- **机制亮点**：①只拥有唯一空白段（quant→counts 桥接脚本），其余全部 handoff 给专有技能；②双路径按环境选（nf-core 工业级 vs 手动教学级）， converge 到同一数据契约；③九陷阱清单每条带错误后果（strandedness 错→静默丢一半 reads）；④版本钉死纪律（pipeline -r/tool 版本/genome release）。
- **可移植**：中。"编排器只拥有空白段"架构原则适配 conductor 扩展；陷阱清单格式适配渠道 runbook。
- **质量**：A（桥接脚本+samplesheet 验证+四 reference+方法学引用）

## 29. dhdna-profiler [scientific-agent-skills]
- **定位**：文本认知指纹提取（12 维度+6 张力对）。
- **机制亮点**：①12 维评分须引文本证据+HIGH/MEDIUM/LOW 置信分级；②张力对（analytical↔intuitive 等）比绝对分更显风格；③同意与范围纪律（第三方画像必须标注推测性、明确拒供招聘/晋升/临床决策；自画像前先征询）。
- **可移植**：中。文风维度框架可为研报"模仿特定分析师文风"（W1 样式门）提供评分骨架；伦理边界声明是采集类技能范本。
- **质量**：B（评分框架+输出模板，无脚本，主观性强）

## 30. ginkgo-cloud-lab [scientific-agent-skills]
- **定位**：Ginkgo 云实验室协议目录与下单手册。
- **机制亮点**：协议目录三列定价透明（价格/周转/认证状态）+EstiMate 自然语言定制询价。
- **可移植**：无（生物湿实验域）。
- **质量**：C（目录文档）

## 31. hypogenic [scientific-agent-skills]
- **定位**：HypoGeniC 假设生成包的安全使用规划与审计。
- **机制亮点**：①"本地审查先行，never auto model call"（任何外呼 LLM/上传前强制确认门）；②五脚本全本地确定性：validate_config/plan_run 成本上界（无定价即 unready）/audit_dataset 跨 split 重复审计/inspect_outputs 脱敏检查/evaluate_local 无模型评估；③跨 split 精确重复=audit fail 硬门（pinned 数据集实测 3 组泄漏被抓）；④供应商隐私门（数据出域保留政策核对）。
- **可移植**：强。跨 split 泄漏审计直接适配 laya 扩标数据集质检（train/test 泄漏=扩标最大隐患）；成本上界规划器=付费 API 预算门（红线机械化）。
- **质量**：A（五脚本+严格 JSON 输出+nonzero on unsafe+日期化信源台账）

## 32. scanpy [scientific-agent-skills]
- **定位**：单细胞分析 scanpy 工具箱（14 脚本全家桶）。
- **机制亮点**：①".h5ad-in/.h5ad-out 可链式 CLI 脚本"覆盖全流程，明令"跑脚本优先于写代码"；②一键端到端（run_pipeline）与分步链两模式并存+JSON config 参数复现；③共享 _common.py 层统一加载/存图。
- **可移植**：中。领域无关但"文件进文件出链式脚本+一键/分步双模式+共享工具层"是管线脚手架最佳实践，适配 EPC100 工具腿设计。
- **质量**：A（脚本工具箱+模板资产+API/绘图/interop 四 reference）

## 33. statistical-power [scientific-agent-skills]
- **定位**：样本量/统计功效计算（闭式+仿真两轨）。
- **机制亮点**：①效应量三级依据（SESOI 最小可行动效应>缩水试点估计>惯例，禁止编数）；②"敏感性分析是交付物，单点 n 不是"（power curve 必交）；③post-hoc power=循环论证，明令禁止；④仿真功效法覆盖一切无公式设计（含 Monte Carlo CI）。
- **可移植**：中-强。调研饱和判定与样本量论证同构："最小可行动效应"→"值得写进研报的最小证据强度"，"源数量-置信度曲线"可补强饱和引擎元门（当前只有字数门+饱和门双门）。
- **质量**：A（两脚本+报告模板+文献锚）

## 34. anti-reversing-techniques [wshobson-agents]
- **定位**：反逆向/反调试技术百科（授权使用声明置顶）。
- **机制亮点**：①授权三验前置（权限/范围/法律合规）；②平台差异排查表（x86 RDTSC vs ARM PMCCNTR）。
- **可移植**：无（二进制安全域）。授权前置声明模式可借鉴但红线体系已有。
- **质量**：C（本体薄，导航到 references）

## 35. review-agent-setup [wshobson-agents]
- **定位**：AI agent 评审动作的人工审批门（Cedar 策略+Ed25519 签名收据链）。
- **机制亮点**：①审批窗口机制：flag 文件开窗→动作执行→立即关窗，窗外无条件拒绝；②每次尝试（无论允许/拒绝）都产 Ed25519 签名收据，整链离线可验证（npx verify 退出码 0/1/2）；③REVIEW_APPROVAL_FLAG 指向不存在文件=永久全拒绝 dry-run 模式。
- **可移植**：中-强。"开窗-执行-关窗+全程签名收据"适配高危操作（删除/对外发布/付费调用）审计腿；常开 dry-run 适配影子双轨。
- **质量**：B（机制完整，依赖外部 plugin 基础设施）

## 36. competitive-landscape [wshobson-agents]
- **定位**：竞争格局分析框架合集（Porter 五力/蓝海/定位图/定价/GTM）。
- **机制亮点**：①五力评分卡（1-5 强度+影响+关键因子，出总结论）；②四动作框架（消除/减少/提升/创造）+策略画布；③竞品画像模板（概览/产品/GTM/优劣势/推断动向）+定价矩阵+监控节奏（周/月/季/年分级）。
- **可移植**：强。EPC100 研报本行即竞争分析：五力评分卡/定位图/竞品监控节奏可直接做研报固定章节骨架（W8 简报 schema 的章节模板来源）。
- **质量**：B（纯方法论无脚本，但框架完整可即用）

---

## 跨技能共性模式（5 条）

1. **生成与裁决分离（防自我盖章）**：auto-paper 的 Reviewer Independence（fresh thread+实证虚高证据）、skill-reviewer 的"assurance 不得高于证据"、idea-creator 的"生成可同族、裁决不可同族"——三个仓库独立收敛到同一原则，与 Jev 判断层哲学同构，应固化为全厂门禁原则：任何评分/验收腿不得看见执行腿的修复摘要。
2. **约束先声明、执行后可审计**：analytical-method-validation"验收标准先于数据否则 standing finding"、edit-whitelist 路径+操作双维禁令带拒绝日志、hypogenic 外呼前确认门——高质量技能共同脊梁，直接支撑 W6+只增不删红线的机械化（约束写成数据契约而非 prompt 叮嘱）。
3. **质量判断降维为进程返回值/落盘收据**：AMV 的 exit code 0/1/2 可当 workflow 门、paper-illustration 的 preflight/verify JSON 收据、review-agent 的 Ed25519 收据链、hypogenic 严格 JSON+nonzero on unsafe——把"好不好"变成"进程退出码+JSON 证据文件"，是管线可编排性的关键手法，parity_gate 可直接吸收。
4. **只读审计与修复执行分离**：skill-reviewer（只建议不改）、crm-hygiene-check（修复移交 update-opportunity）、repo-intake（只侦察不执行）——审计腿无副作用、执行腿单独授权，适配渠道健康巡检与 conductor 出队闸设计。
5. **统计诚实性纪律三件套**：MailerLite 翻页穷尽（不穷尽=采样偏差）、audit-support 抽样量表（多少样本支撑结论）、statistical-power 敏感性分析（区间而非单点）——共同指向"结论须声明其统计地基"，可注入研报数据章节模板。

## 意外发现清单（深读组可能遗漏的独特机制）

1. **numerical_claim 检测器**（auto-paper edit-whitelist）：对新增行跑正则 `\b\d+(\.\d+)?%?\b`，新增数字若在被删行中不存在即拒绝——可直接改造成研报成稿门：修订轮新增的数字必须溯源到弹药池条目，否则拒绝（防幻觉数字混入定稿）。
2. **restatement regression test**（auto-paper Step 4.5）：正文↔附录定理归一化（剥 label/ref/宏/空白后）逐条比对，六类漂移签名（conditional_loss/quantifier_loss/variable_rename 等）——摘要/正文/结论多处复述同一事实的自动一致性比对，EPC100 研报摘要与正文数字漂移检测直接可用。
3. **评审虚高的一手实证**（auto-paper）：codex-reply 带修复摘要评分 3/10→8/10 虚高、fresh thread 恢复真实 3/10——判断层设计罕见的量化实验证据，支持双轨影子/独立评审位的工程决策。
4. **跨 split 重复审计硬门**（hypogenic audit_dataset）：train/test 精确或身份重复即 fail，pinned 数据集实测抓出 3 组泄漏——laya v2/v3 扩标数据集质检的现成思路（防止同类研报句子同时进 train 与 held-out）。
5. **MAD 自适应阈值**（single-cell-rna-qc）：中位绝对偏差代替固定 cutoff——渠道健康监控（成功率/流量异常判定）的统计学替代方案，自动适应不同渠道基线。
6. **content-originated action 法律式定义**（account-research）：精确枚举"不可信文本指定收件人/目标/内容/请求动作本身"四判据——比"注意提示注入"口号可执行得多，适配 Manus 军团产物→写动作的隔离判据。
7. **审批窗口+签名收据链**（review-agent-setup）：开窗-执行-关窗三拍+每拍落 Ed25519 收据+整链离线验证——高危动作（删数据/对外发布/付费调用）的完整审计模式，窗口机制比常开权限的面板小得多。
8. **辅助检查失败的降级语义**（auto-paper Step 5.5）：kill-argument 对抗检查返回 BLOCKED/ERROR 时只记日志继续主管线、不阻塞——"辅助腿失败≠主管线失败"的显式降级规则，适配 conductor 旁路检查腿设计。
9. **"编排器只拥有空白段"**（bulk-rnaseq）：自 declared router，唯一自写的是上游下游都无人提供的桥接脚本——conductor 未来扩展时的职责切分原则，防止编排器膨胀成巨石。

## 诚实备注

- 13 个 C 级技能中 8 个为纯领域手册（营销/广告/生物目录/安全百科），对主战场无增量；入选价值主要靠 deer-flow 2 个、knowledge-work-plugins 数据/设计/销售线 8 个、scientific-agent-skills 7 个（其中 A 级 5 个全部出自 K-Dense scientific-agent-skills，该库整体工程纪律显著高于其余仓）。
- 本报告只读 SKILL.md 本体；C 级判定中 repo-intake-and-plan、notion-meeting-intelligence、anti-reversing-techniques 三者的实质内容在 references/ 中，若深读可能上调。
- 可移植性判断以"机制模式"为准而非直接安装：paper-illustration-image2 的付费桥、similarweb 的商用 API 均与免费优先红线冲突，只取模式不取栈。
