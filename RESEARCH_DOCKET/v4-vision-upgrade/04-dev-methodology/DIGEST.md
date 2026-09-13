# Track 04：AI-native 开发方法论 — 调研摘要

- generated: 2026-09-13 · 条目数：30（repo 15 / product 5 / article 9 / paper 1）
- 检索降级说明：WebSearch 与 webReader MCP 配额耗尽（重置 2026-09-26），全程降级为 gh CLI + curl（代理 http://127.0.0.1:7890）+ HN Algolia API + Bing 辅助。所有 URL 均实证可达（200 或 gh 元数据），星数为当日 gh 实测。查不到的元数据（Antigravity 星数等）如实标 null。
- 基线排重：427 名基线已核对；Cognition 条目标注「复录+新进展」（基线录的是 Devin 公司，本条是独立方法论文本）；OpenAI Codex 与基线「OpenAI Agents SDK/AgentKit」为不同工件。

---

## 一、Spec 驱动 / 方法论框架（repo）

**1. GitHub Spec Kit**（github/spec-kit，136k★）
GitHub 官方 spec 驱动工具包，`/specify → /plan → /tasks → /implement` 四命令流水线，发布一周年时 ship 了 1.0.0。agent 无关设计（Claude Code/Gemini CLI/Copilot 通吃）。独有「项目宪法（constitution）」层：所有 spec 必须先过宪法检查，且 spec/plan/tasks 是可 diff 的序列化工件。

**2. OpenSpec**（Fission-AI/OpenSpec，68k★）
自称「最受爱戴的 spec 框架」，哲学是 fluid not rigid / iterative not waterfall / brownfield not just greenfield。已重构为 artifact 引导工作流，spec 变更集（change proposal + delta）进 CI 校验。对存量代码库（brownfield）的友好度是其最大差异点。

**3. GSD / GSD Core**（gsd-build/get-shit-done 64.5k★ → 活跃开发迁 open-gsd/gsd-core 9.4k★）
TÂCHES 出品的元提示+上下文工程+spec 驱动系统，设计目标是「让 agent 长时间自主而不失大图景」。核心机制是对抗 context rot：重活全部丢给 fresh-context 子代理，执行按并行波次进行、每个 executor 起手是干净 200k token，里程碑走五步 phase loop。支持 10+ agent 后端。

**4. BMAD-METHOD**（bmad-code-org，53k★）
「Breakthrough Method for Agile AI-Driven Development」：Clarify→Plan→Build&Verify→Learn&Adjust 交付环，PM/架构师/项目经理/工程师/QA 角色化且各带独立上下文。关键哲学是「process sizes itself to the work」——小变更直通、复杂工作才走深流程。

**5. Ruflo（原 claude-flow）**（ruvnet/ruflo，72.3k★）
自称「原版 agent harness」：swarm/hive-mind 共享记忆、自适应记忆与自学习智能、联邦、向量 RAG，配套 UI Beta 与 Live Agents 观测面板。把单 agent 循环升格为 agent 种群循环的最大规模尝试。

**6. Vibe Kanban**（BloopAI/vibe-kanban，28k★，官方公告 sunsetting）
看板式多 agent 编排器，kanban issue 规划 + workspace 执行，10+ agent 后端可切换（Claude Code/Codex/Gemini CLI/Copilot/Amp/Cursor/OpenCode…）。注意：官方 readme 已公告「Vibe Kanban is sunsetting」——独立编排层正在被 IDE 原生吸收，这本身就是 2026 年的结构性信号。

**7. Agent OS**（buildermethods/agent-os，5.4k★）
Brian Casel 的系统：向代码库注入产品/技术标准（standards 文档），所有 spec 先对齐标准再动笔。把「标准」而非「提示」做成方法论核心注入物。

## 二、自治软件工程 / 研究系（repo）

**8. OpenHands（原 OpenDevin）**（OpenHands/OpenHands，87.7k★，组织已从 All-Hands-AI 迁移）
开放版自主 SE 平台：Docker 沙箱隔离的动作空间（终端/浏览器/编辑）、Agent Skills 生态、Agent Server API 与浏览器端 TS 客户端。「沙箱即平台」——每步 agent 行动都在可丢弃环境里。

**9. MetaGPT**（FoundationAgents/MetaGPT，70.3k★，ICLR）
「Code = SOP(Team)」：把 PM/架构师/PM/工程师的人类 SOP 编码为 agent 角色流水线，强制结构化中间工件（PRD/系统设计/任务清单）交接。论文消融证明 SOP 化中间工件显著优于自由对话协作。

**10. SWE-agent**（SWE-agent/SWE-agent，20.3k★，NeurIPS 2024）
吃 GitHub issue 自动修 bug。学术贡献是 ACI（Agent-Computer Interface）概念：为 agent 专门设计的精简工具接口（自带防护、防误编辑崩溃栈）比直接复用人类工具显著更有效。

**11. The AI Scientist**（SakanaAI/AI-Scientist，14.5k★）
全自动开放端科研：idea→实验代码→运行→论文→自动评审的端到端无人值守闭环，每论文成本个位数美元。既是「自进化代码库」的激进样本，也暴露论文级幻觉与评审偏见——人审节点当前不能全撤。

## 三、验证 / 评审基础设施（repo）

**12. promptfoo**（promptfoo/promptfoo，25k★）
声明式 prompt/agent/RAG 评测框架，CLI + CI/CD 集成，官方描述「Used by OpenAI and Anthropic」。把 agent 行为回归做成 CI 门禁的标杆。

**13. PR-Agent**（The-PR-Agent/pr-agent，13k★，Qodo 商业版的开源底座）
「原版开源 PR 评审员」：每条 PR 自动描述/提问/安全扫描/性能建议。评审从「阶段级事后复盘」推进到「每次提交的强制伴随物」。

**14. Qodo Cover**（qodo-ai/qodo-cover，5.6k★，2025-06-15 起停止维护）
CI 里迭代生成测试持续提升覆盖率的 agent 循环，「先测后码」的自动化对偶。项目已弃维护——prior art 信号：测试「长出来」只是形式，金标准的质量才是关键。

**15. Taskmaster**（blader/taskmaster，522★，小而锋利）
Claude Code Stop hook 完成度守卫：「progress is not completion」。机制四件套：evidence over narrative（禁总结式停机）、机器可查完成条件、确定性 done token（供 CI 解析）、同会话恢复 + 目标重锚定。

## 四、产品 / 平台

**16. Kiro（AWS）** — https://kiro.dev/（title 实测「Move beyond AI coding to agentic engineering」）
大厂 spec 驱动 IDE：requirements（EARS 格式）/design/tasks 三工件 + hooks + steering 目录常驻上下文。spec 驱动有大众商业市场的最强背书。

**17. Tessl** — https://www.tessl.io/（title 实测已改为「Agent Enablement Platform」）
从「spec 驱动开发平台」转型为组织级 agent 治理/度量平台。转型轨迹本身是最强信号：单一方法论工具站不住，要活成平台能力+治理层。

**18. Conductor** — https://www.conductor.build/（title 实测「Run a team of coding agents in the cloud」）
云端 coding agent 团队：每 agent 独立环境并行，人通过可视 timeline 逐段评审。人审对象从 diff 升级为过程时间线。

**19. OpenAI Codex** — https://openai.com/codex（200 实测）
官方编码 agent：云端沙箱容器并行任务，`codex exec` 面向无人值守/CI 原语，另有 code review agent。无人值守长任务被产品化为一等命令面。

**20. Google Antigravity** — https://antigravity.google.com/（Google 系域名经代理不可达，星数 null；经 Bing 结果与官方 codelabs 交叉验证）
agent-first IDE：任务管理器 + artifacts 面板（计划/浏览器/终端产物皆为一等监控对象），Agent Manager 统一调度。观测 agent 工件先于读 diff。

## 五、方法论文章 / 论文

**21. Don't Build Multi-Agents（Cognition）【复录+新进展】** — cognition.ai/blog/dont-build-multi-agents（200 实测）
Devin 母公司檄文：并行多 agent 是分布式系统陷阱。三原则：Share context（共享全轨迹而非单消息）、Actions carry implicit decisions、优先单线程线性 agent。对 PAI 三线复盘的直接警示：线间若只交接摘要，隐式决策会在合并时爆发。

**22. 12 Factor Agents（HumanLayer / Dex Horthy）** — humanlayer.dev/blog/12-factor-agents（200 实测）
agent 工程界的 12-factor 时刻：own your prompts / own your context window / own your control flow / stateless reducer / errors as context 等 12 条可打勾原则。方法论清单化、可机器自检的范本。

**23. Advanced Context Engineering for Coding Agents（HumanLayer）** — humanlayer.dev/blog/advanced-context-engineering（200 实测）
子代理架构、读写分离工具、验证回路、compaction、上下文回压（backpressure）与 forking。同站《A Brief History of Ralph》（brief-history-of-ralph）把 Ralph 循环的谱系也写成了工程史。

**24. Ralph Wiggum as a "software engineer"（Geoffrey Huntley）** — ghuntley.com/ralph/（200 实测）
PAI「Ralph 三线复盘」的源头原文：「Ralph 在最纯形式下就是一个 Bash 循环 `while :; do cat PROMPT.md | claude-code ; done`」，附 YC 黑客松实录「放进 while 循环一夜 shipped 6 个 repo」。原文明确：缺陷可辨识、可用不同 prompt 风格消解——prompt 是循环的控制参数。

**25. Measuring AI Ability to Complete Long Tasks（METR）** — metr.org（200 实测，7 个月翻倍原文在案）
agent 可完成任务时长约每 7 个月翻倍。流程权重设计的量化依据：人审闸应做成随能力指数增长自动调松紧的旋钮。

**26. Effective context engineering for AI agents（Anthropic 工程博客）** — anthropic.com/engineering/...（200 实测）
模型厂一手机制解释：上下文工程高于提示工程；compaction、结构化笔记、just-in-time 检索、子代理分解。「系统提示即操作系统」。

**27. The 70% Problem（Addy Osmani）** — addyo.substack.com/p/the-70-problem-hard-truths-about（HN Algolia 收录验证；substack 直抓经代理 000）
AI 把启动速度拉到 70% 后进入质量平台期，最后 30%（正确性/安全/维护性）由工程纪律、评审与测试文化接管。对「871 tests」最有解释力的外部框架。

**28. Not all AI-assisted programming is vibe coding（Simon Willison）** — simonwillison.net/2025/Mar/19/vibe-coding/（200 实测）
对 Karpathy 术语的权威界定：全程不看 diff 就接受才叫 vibe coding。给「何时糙快、何时上方法论」提供了业界通用判据。

**29. From Memo to Movement: Shopify's Cultural Adoption of AI（First Round Review）** — firstround.com/ai/shopify/（200 实测，访谈工程 VP Farhan Thawar）
Lütke 备忘录之后 Shopify 内部怎么落地：人人可用贵模型、AI 必须展示工作过程（show its work）、新手心态。方法论的组织维度一手案例。

**30. The Rise of the AI Engineer（swyx / Latent Space）** — latent.space/p/ai-engineer（200 实测，og:title 在案）
定义「AI Engineer」新角色：不训练模型、以模型为原料做产品与流程。方法论的人群假设基础：角色定义先于流程定义。

---

## 对百倍升级的信号（≥5 条）

1. **宪法层 + 分级路由，替代单一提案闸**。spec-kit 的 constitution（spec 之前先有全局不变式，所有提案强制过宪法检查）+ BMAD 的「process sizes itself to work」（小改直通/大改深走）+ Willison 的 vibe/AI-assisted/engineering 三档判据，三者合成一个 PAI 没有的机制：**闸门是带权重的路由器而非固定关卡**。

2. **上下文是第一公民资源，复盘质量受 context rot 支配**。GSD 的 fresh-context 子代理波次（每 executor 干净 200k）、HumanLayer 的回压/forking、Anthropic 的 compaction+结构化笔记共同指认：PAI 的 Ralph 复盘没有任何上下文预算管理，长会话复盘必然衰减。v4 应给每条工作线设 token 预算表与超限策略。

3. **无人值守的终点必须是机器判据，不是总结词**。Taskmaster（blader）的 stop-hook 完成度守卫——evidence over narrative、确定性 done token、同会话恢复、目标重锚定——可直接移植为 PAI 长跑任务的终点协议。它补的正是提案闸的盲区：**闸门只管入口，不管出口**。

4. **验证资产的复利才是护城河，编排壳不是**。Addy 70% 定律（前 70% 边际成本归零，价值全在后 30% 验证资产）+ promptfoo（行为级 eval 进 CI，OpenAI/Anthropic 在用）+ Vibe Kanban 日落（纯编排被 IDE 原生吞掉）+ Tessl 转型（方法论要长成平台层）——四条同向：**百倍不在更快生成，而在金标准/evals/沙箱做成可复利、可治理的资产**。

5. **能力曲线应成为流程设计的输入**。METR 实证任务时程每 7 个月翻倍：所有静态流程一年后都会退化为纯摩擦。v4 的每个闸门都应设计成「随任务时程/风险自动调松紧的旋钮」（人审节点指数后退），而不是写死的仪式。

6. **多线并行的代价是隐式决策传染**。Cognition 三原则（共享全轨迹/动作携带隐式决策/优先单线程线性）警示 PAI 三线复盘：线间若只传摘要不传全轨迹，合并时会踩分布式系统的经典坑；Conductor 的 timeline 回放则给出了「审过程而非审结果」的人审界面升级方向。

7. **ACI 视角：工具要为 agent 重新设计**。SWE-agent（NeurIPS）证明给 agent 专门设计带防护的精简接口（失败即回滚、防误编辑）显著优于递人类工具；PAI 当前工具面是给人用的——v4 应有 agent 专用工具层。MetaGPT 同时证明中间工件 schema 化交接优于自然语言文档。

8. **组织接口是方法论的第二半**。Shopify 落地三件套（贵模型全员开放、AI 强制 show its work、按学习者设计采纳）说明：单人自治方法要放大百倍，必须带组织配套——「强制过程证据」与信号 3 的 done token 同构，可以在 v4 里统一实现。
