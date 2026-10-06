# 输入件 3：Manus 复刻双 clone 深读融合方案（OpenManus commit 3309bf4 + LangManus commit a69eabf）

> 四路源码深读（agent loop/planning flow/工具层/提示词/爬取层）→ 49+ 模式总表 + 直接抄/改造接/不抄三清单 + 对七阶段的结构性增补。全部结论出自本地源码实地核对。

# Manus 复刻融合方案——「报告名→顶级研报」超级生产线框架

> 对象：`E:\AI-Station\_clones\OpenManus\`（commit 3309bf4）与 `E:\AI-Station\_clones\LangManus\`（commit a69eabf）。
> 我方在役资产：Channel Grid v2 五层调度（61 渠道注册 / tier_router 六闸 / conductor 7min tick / 完备门四态 / 探活周腿）、弹药门 v3（T1≥300万 ∧ T1+T2≥3000万 / T3 封顶 / 辛迪加 ≤40%∧≥3源）、证据饱和引擎（字数门∧饱和门双门 + ACH 对抗）、RQS 21 质量门、七阶段管线（S0 意图解析 / S1 初步框架 / S2 定向调研 / S3 最终框架 / S4 边写边收集 / S5 质量门 / S6 交付复利）。
> 本文全部结论出自四路源码深读，文件路径与行号均已实地核对。

---

## 0. 融合总纲（先看这一页）

**一句话定位**：OpenManus 是"会思考但失忆的单体"（LLM-in-the-loop，无持久化无质量判定）；LangManus 是"干净的多角色最小骨架"（supervisor 循环 + 共享黑板，但搜索/持久化/沙箱/限额四块全空）。我们的 conductor/tier_router 是"不想但记得所有事的流水线"（registry-in-the-loop，磁盘状态+闸门+对账）。

**融合公式**：

```
超级生产线 = 我们的产线硬层（不动）
           + 两 clone 的 agent 标准件层（新增）
硬层：Channel Grid v2 五层调度 + 弹药门v3 + 饱和引擎 + RQS 21门 + 七阶段管线
件层：六大契约（工具契约 / 双槽提示词 / 浏览器JSON行为契约 / 计划编排契约 /
      结构化路由契约 / 黑板回注契约）
```

两 clone 给的恰是我们缺的"推理级调度标准件"；我们有的恰是它们完全没有的"并行、校验、落盘、限额"四块产线硬需求。**融合方向是单向的：它们的标准件装进我们的骨架，绝不反向看齐**——它们的无持久化、无质量判定、单源搜索、无沙箱四块，正是我们的护城河所在。

---

## 1. 两项目全部可借鉴模式总表

### 1.1 按阶段挂载主表（S0-S6）

| # | 模式 | 出处（文件:行） | 挂阶段 | 融合档位 |
|---|------|----------------|--------|----------|
| 1 | 门卫节点：寒暄/有害请求前置过滤，不浪费规划算力 | LangManus `src/graph/nodes.py:150-164` + `src/prompts/coordinator.md` | **S0** | 只抄思想 |
| 2 | 立题先复述用户需求（第一步=用自己的话重述任务） | LangManus `src/prompts/planner.md` Execution Rules | **S0** | 只抄思想 |
| 3 | 六栏范围对齐卡（调研对象/报告类型/动机/关注点…） | 我方已有 F2（`reforge_factory/METHODOLOGY.md` 关卡一） | S0 | 已在役（对照锚） |
| 4 | 规划前先搜：`search_before_planning` 把搜索结果注入规划 prompt | LangManus `src/graph/nodes.py:115-120` | **S1** | 改造接 |
| 5 | 深思考开关：`deep_thinking_mode` 一行 if 切 basic↔reasoning 档 | LangManus `src/graph/types.py:26` + `nodes.py` | **S1** | 改造接 |
| 6 | 计划 JSON 契约：Step{agent_name,title,description,note}，裸 JSON 无围栏 | LangManus `src/prompts/planner.md:31-48` | **S1** | 直接抄 |
| 7 | 计划粒度纪律：收官角色只能用一次且必须最后一步、同 agent 连续步骤合并、计算类显式派单 | LangManus `src/prompts/planner.md` Notes | **S1** | 只抄思想 |
| 8 | LLM+PlanningTool 交计划（模型只能通过调工具交计划，参数即结构化计划） | OpenManus `app/flow/planning.py:136-211` | **S1** | 改造接 |
| 9 | 多执行者清单喂规划 LLM（name+description 进规划 prompt，要求步骤带 `[agent_name]` 标签） | OpenManus `app/flow/planning.py:145-160` | **S1/S3** | 改造接 |
| 10 | 兜底三步默认计划（模型没交计划→"分析/执行/验证"三步兜底） | OpenManus `app/flow/planning.py:204-211` | **S1** | 只抄思想 |
| 11 | 反过度规划条款："Avoid excessive detail or sub-steps"、"Know when to conclude" | OpenManus `app/prompt/planning.py` | **S1** | 直接抄 |
| 12 | 三问决策树 NEXT_STEP（计划够不够？能否立即执行下一步？完成了吗？） | OpenManus `app/prompt/planning.py` NEXT_STEP_PROMPT | **S1/S3** | 直接抄 |
| 13 | 步骤类型标签路由：正则 `\[([A-Z_]+)\]` 抠标签→executor 精确匹配 | OpenManus `app/flow/planning.py:243-247,77-92` | **S3** | 改造接 |
| 14 | step_prompt 结构 = 当前完整计划文本（✓/→/! 进度标记）+ "你只做第 N 步" | OpenManus `app/flow/planning.py:284-292`（`_get_plan_text`） | **S3/S4** | 直接抄 |
| 15 | 计划状态机独立于执行者（4 态 not_started/in_progress/completed/blocked，flow 独占写权） | OpenManus `app/tool/planning.py:20-42` | **S3** | 改造接 |
| 16 | 计划进度可视化文本（`[✓]/[→]/[!]/[ ]` + 百分比） | OpenManus `app/tool/planning.py:322-363` | **S3** | 只抄思想 |
| 17 | 结构化路由枚举：`Router.next: Literal[*OPTIONS]` + `with_structured_output`，杜绝路由幻觉 | LangManus `src/graph/types.py:11-14` + `nodes.py:85-104` | **S3** | 直接抄 |
| 18 | RESPONSE_FORMAT 统一回注信封：`Response from {name}:\n<response>…</response>\n*Please execute the next step.*` | LangManus `src/graph/nodes.py:19` | **S3/S4** | 直接抄 |
| 19 | 共享黑板：全部角色产出统一包 HumanMessage(name=…) 回注同一滚动消息史，下游零适配 | LangManus `src/graph/nodes.py:22-82` | **S3/S4** | 只抄思想 |
| 20 | 角色能力边界写进提示词而非代码（researcher 不做数学不碰文件、browser 慢且贵慎用） | LangManus `src/prompts/researcher.md` / `supervisor.md` | **S3** | 只抄思想 |
| 21 | 多引擎梯次降级：引擎注册表 dict → config 首选+fallback 链+其余 → 单引擎 3 次指数退避 → 全败睡 60s 整轮重试≤3 | OpenManus `app/tool/web_search.py:193-198,360-385,252-281` | **S2** | 改造接 |
| 22 | 搜索结果归一模型 `SearchItem(title,url,description)` | OpenManus `app/tool/search/base.py:6-17`（已实地核对） | **S2** | 直接抄 |
| 23 | fetch_content 轻读：BeautifulSoup 剥 script/style/header/footer/nav、空白折叠、10KB 封顶 | OpenManus `app/tool/web_search.py:106-153` | **S2** | 直接抄 |
| 24 | crawl4ai 渲染配方：domcontentloaded / process_iframes=True / remove_overlay_elements=True / excluded_tags / word_count_threshold | OpenManus `app/tool/crawl4ai.py:110-129` | **S2** | 改造接（必修 bug，见 §3.6） |
| 25 | JS 渲染→markdown→多模态切块：图片正则切 text/image_url 交替块 + urljoin 补相对图址 | LangManus `src/crawler/article.py:21-34` | **S2/S4** | 直接抄 |
| 26 | 三段式抽取管线：Jina 取 HTML → readability 抽正文 → Article 组装 | LangManus `src/crawler/{jina_client,readability_extractor,article}.py` | **S2** | 只抄思想 |
| 27 | 缺证优雅降级：可选凭证缺失→warning+降速继续，不抛异常 | LangManus `src/crawler/jina_client.py:15-20` | **S2** | 只抄思想 |
| 28 | 浏览器 JSON 行为契约：`current_state{evaluation_previous_goal, memory, next_goal} + action[]` | OpenManus `app/prompt/browser.py:21-35`（71 行 9 节） | **S2/S4** | 直接抄 |
| 29 | memory 字段强制计数："Count here ALWAYS how many… 0 out of 10 websites analyzed"防提前收工 | OpenManus `app/prompt/browser.py` 第 2 节 | **S4** | 直接抄（原文照抄） |
| 30 | 强制复盘上一步：`evaluation_previous_goal` 先自评 Success/Failed/Unknown+原因 | OpenManus `app/prompt/browser.py` 第 2 节 | **S4/S5** | 直接抄 |
| 31 | 诚实收尾条款：done 必须带全部已收集信息（"Do not just say you are done"）、未完成 success 必须置 false | OpenManus `app/prompt/browser.py` 第 4 节 | **S4/S5** | 直接抄（原文照抄） |
| 32 | live state 进 prompt：占位符五件套（URL/标题/标签数/视口余量/截图）每步由 BrowserContextHelper 实测填充 | OpenManus `app/agent/browser.py:43-75` | **S4** | 只抄思想 |
| 33 | 双槽提示词：SYSTEM_PROMPT（静态合同，一次）+ NEXT_STEP_PROMPT（每步 think() 前注入） | OpenManus `app/prompt/manus.py` + `app/agent/toolcall.py:41-43` | **S4** | 直接抄 |
| 34 | 截图走独立通道：base64_image 字段/带图 user message，不塞文本 | OpenManus `app/tool/base.py:38-75` + `toolcall.py` | **S4** | 只抄思想 |
| 35 | reporter 四段式报告模板：Executive summary / Key findings / Detailed analysis / Conclusions and recommendations | LangManus `src/prompts/reporter.md` Guidelines | **S4** | 直接抄 |
| 36 | 反幻觉写作纪律（Data Integrity 节，已实地核对原文）：只用显式提供的信息、缺数据写 "Information not provided"、Never create fictional examples、事实与分析分离、标注来源 | LangManus `src/prompts/reporter.md:41-57` | **S4/S5** | 直接抄（整节搬） |
| 37 | Terminate 自主收口：special_tool_names 命中即置 FINISHED，模型自己拉闸 | OpenManus `app/tool/terminate.py` + `app/agent/toolcall.py:218-235` | **S4** | 改造接（对接弹药门） |
| 38 | stuck 检测：连续同文重复 ≥duplicate_threshold(2) 判卡死 → 换策略提示前置拼进 next_step_prompt | OpenManus `app/agent/base.py:163-186` | **S4/S5** | 直接抄 |
| 39 | 写完报告≠终点：reporter 干完回 supervisor，再一跳 FINISH 才收口（内置验收再收口） | LangManus `src/graph/nodes.py:167-185` | **S5** | 改造接 |
| 40 | 验收无质量判定的反面教材：`executor.run()` 返回即 `_mark_step_completed()`，零校验 | OpenManus `app/flow/planning.py:296-299`（反面） | S5 | 不抄（警示锚） |
| 41 | 总结三级降级：flow LLM 总结 → 失败降级 primary agent 总结 → 再失败固定文案 | OpenManus `app/flow/planning.py:406-442`（`_finalize_plan`） | **S6** | 只抄思想 |
| 42 | SSE 事件协议 12 类：workflow/agent/llm/message/tool_call 五层 + reasoning_content 独立 delta 通道 + tool_call_result 带全文 | LangManus `docs/event-stream-protocol/` + `src/service/workflow_service.py` | **S6** | 改造接 |
| 43 | 流式暗号过滤：攒 chunk 判断 handoff 前导并吞掉，内部协议词不漏给用户 | LangManus `src/service/workflow_service.py:25-27,140-166` | S6 | 只抄思想 |
| 44 | 客户端断连即停：`req.is_disconnected()` | LangManus `src/api/app.py:117-119` | S6 | 只抄思想 |

### 1.2 横切层（跨阶段基础设施）模式表

| # | 模式 | 出处 | 融合档位 |
|---|------|------|----------|
| 45 | 工具极简契约：name/description/parameters 三字段 + `to_param()` 输出 OpenAI function-calling 格式，别无第二套描述通道 | OpenManus `app/tool/base.py:78-137` | 直接抄 |
| 46 | ToolResult 四字段（output/error/base64_image/system）+ `__bool__`/`__add__`/error 优先 | OpenManus `app/tool/base.py:38-75` | 直接抄 |
| 47 | ToolCollection：tool_map 派发 + 同名去重告警 + 批量产 schema | OpenManus `app/tool/tool_collection.py` | 直接抄 |
| 48 | description 写行为契约与失败语义（"primary 失败自动 fallback"、"只有 print 输出可见"） | OpenManus `app/tool/web_search.py:160-163` / `python_execute.py:13` | 直接抄 |
| 49 | 观察值固定格式 `` Observed output of cmd `{name}` executed: `` + max_observe 截断 | OpenManus `app/agent/toolcall.py:200-204` | 直接抄 |
| 50 | token 预算计入工具描述：`count_tokens(str(tool))` 累加进 input 并过限流闸，超限优雅收尾 | OpenManus `app/llm.py:693-705` | 改造接 |
| 51 | 记忆滑窗：Memory max_messages=100 超出截尾 | OpenManus `app/schema.py:159-168` | 直接抄 |
| 52 | AgentState 四态（IDLE/RUNNING/FINISHED/ERROR）+ state_context 异常即 ERROR | OpenManus `app/schema.py:32` / `base.py:58` | 只抄思想 |
| 53 | 角色→LLM 档位一张表 + 实例缓存 | LangManus `src/config/agents.py` + `src/agents/llm.py:64-96` | 改造接 |
| 54 | logged 工具工厂：`create_logged_tool` 把任意 BaseTool 包成带 IO 日志版本（LoggedToolMixin 覆写 `_run`），零侵入 | LangManus `src/tools/decorators.py:41-78` | 直接抄 |
| 55 | MCP 外部工具归一化：远端 inputSchema→同名工具契约，名字清洗 `[^a-zA-Z0-9_-]`、64 字符上限 | OpenManus `app/tool/mcp.py:118-173` | 改造接 |
| 56 | 服务器说明书注入：MCP server 的 initialize().instructions 作为一条 system 消息进 memory | OpenManus `app/agent/manus.py:159-171` | 只抄思想 |
| 57 | 工具清单漂移刷新：对比 inputSchema，增删都写 system message 告知 agent | OpenManus `app/agent/mcp.py:102-147` | 只抄思想 |
| 58 | 会话死亡检测：`sessions`/`tool_map` 空 → FINISHED | OpenManus `app/agent/mcp.py:149-164` | 只抄思想 |
| 59 | retry 白名单：tenacity 重试排除 TokenLimitExceeded（限流重试、超限不重试）；TokenLimitExceeded 从 `RetryError.__cause__` 拆出 | OpenManus `app/llm.py:354/481/637` | 只抄思想 |
| 60 | 差异化步数预算：各 agent 自定 max_steps/max_observe（Manus 20/10000，DataAnalysis 20/15000…） | OpenManus `app/agent/*.py` | 只抄思想 |
| 61 | 全局超时闸：`asyncio.wait_for(flow.execute(), 3600)` | OpenManus `run_flow.py` | 只抄思想 |
| 62 | agent_id/tool_call_id 规范化命名（`{workflow_id}_{name}_{step}`） | LangManus `src/service/workflow_service.py` | 只抄思想 |
| 63 | 单工具多动作的参数自描述（action→必选参数映射写进 parameters） | OpenManus `app/tool/sandbox/sb_browser_tool.py:111-126` | 只抄思想（键名须换合规写法） |

---

## 2. 「直接抄」清单（文件级，能不改就用）

原则：零依赖纯模式、纯文本契约、纯数据结构——复制进我方代码库即可服役，不绑定对方运行时。

| 序 | 抄什么 | 源文件 | 落点（我方） | 说明 |
|----|--------|--------|--------------|------|
| D1 | **Data Integrity 反幻觉纪律整节** | `LangManus/src/prompts/reporter.md:41-57` | S4 写作腿成稿提示词 + reforge_factory prompts | 五条纪律逐条照搬：只用显式提供信息 / 缺数据写 "Information not provided" / Never create fictional examples / 不臆测缺失信息 / 事实分析分离+标注来源。这是 RQS 门在提示词层的先手防线 |
| D2 | **浏览器 JSON 三件套契约 + 计数 + 诚实收尾** | `OpenManus/app/prompt/browser.py`（71 行全文） | DrissionPage/Chrome-MCP 腿系统提示词（阿里云控制台/CNKI 滑块/备案向导） | `evaluation_previous_goal`（强制复盘）+ `memory`（"0 out of 10" 式计数）+ `next_goal`；"done 必须带全部发现、未完成 success=false" 两条原文照抄 |
| D3 | **双槽提示词结构 + NEXT_STEP 每步注入** | `OpenManus/app/prompt/manus.py` + `app/agent/toolcall.py:41-43` | reforge_factory 判断层/写作腿的 agent 化 | 新建 `reforge_factory/prompts/{judge,writer}_prompts.py`：SYSTEM 放 RQS 门与产物合同（一次），NEXT_STEP 放"本步查什么、查完用什么收口"（每步） |
| D4 | **Terminate + special_tool_names 收口机制** | `OpenManus/app/tool/terminate.py` + `toolcall.py:218-235` | S4 agent 腿 | 模型自己拉闸收工，比外层硬计时更贴"弹药门达标即转产"语义。整体仅数十行，签名级照搬 |
| D5 | **stuck 检测三件套** | `OpenManus/app/agent/base.py:163-186` + `app/schema.py:159-168` | 常驻腿 agent 化 | `is_stuck()` 同文重复计数 + 换策略提示前置注入 + Memory 滑窗 100 条，三件成本极低 |
| D6 | **Router Literal 结构化路由** | `LangManus/src/graph/types.py:11-14` | S3 调度决策出口 | `next: Literal[*OPTIONS]` + `with_structured_output`，把"下一棒"收敛成枚举，杜绝路由幻觉 |
| D7 | **RESPONSE_FORMAT 统一回注信封** | `LangManus/src/graph/nodes.py:19` | S3/S4 各腿产出协议 | `Response from {name}:\n<response>…</response>\n*Please execute the next step.*` 一行常量，全产线统一信封 |
| D8 | **SearchItem 归一模型** | `OpenManus/app/tool/search/base.py:6-17`（已核对） | 渠道工具层 | title/url/description 三字段 pydantic，全部搜索腿的统一出口类型 |
| D9 | **工具契约三件** | `OpenManus/app/tool/base.py` + `tool_collection.py` | 渠道工具化 | BaseTool 三字段+to_param / ToolResult 四字段 / ToolCollection 派发+同名去重，构成"渠道→agent 工具"的注册契约 |
| D10 | **观察值固定格式 + max_observe 截断** | `OpenManus/app/agent/toolcall.py:200-204` | 全部 agent 腿工具回灌 | 长研报流水线防上下文污染的便宜招 |
| D11 | **planning NEXT_STEP 三问决策树 + 反过度规划条款** | `OpenManus/app/prompt/planning.py` | S1/S3 规划腿提示词 | "计划够不够？能否立即执行下一步？完成了吗？"三问 + "Avoid excessive detail / Know when to conclude"两句 |
| D12 | **计划 JSON 契约（Step 四字段）** | `LangManus/src/prompts/planner.md:31-48` | S1 计划产物 schema | agent_name/title/description/note，裸 JSON 无围栏——比自由文本计划强一个数量级的可校验性 |
| D13 | **reporter 四段式模板** | `LangManus/src/prompts/reporter.md` Guidelines | S4 成稿默认骨架 | Executive summary / Key findings / Detailed analysis / Conclusions——与我方研报结构兼容，作默认段式 |
| D14 | **create_logged_tool 工厂** | `LangManus/src/tools/decorators.py:41-78` | 渠道工具层横切件 | 把任意 BaseTool 包成带 IO 日志版本，零侵入；61 渠道逐个包成 LangChain tool 后自动获得 `_run` 级入参出参日志 |
| D15 | **Article.to_message() 多模态切块** | `LangManus/src/crawler/article.py:21-34`（70 行模式） | MEDIA-1 article 全文入池的图片腿 | markdown 按图片正则切 text/image_url 交替块 + urljoin 补相对址——带图文章直接喂 VL 做图证核对 |
| D16 | **fetch_content 轻读配方** | `OpenManus/app/tool/web_search.py:106-153` | S2 搜索腿附带正文 | 剥 script/style/header/footer/nav + 空白折叠 + 10KB 封顶，纯函数可直接搬 |
| D17 | **step_prompt 计划全景回灌结构** | `OpenManus/app/flow/planning.py:284-292` | LayaForge/写作腿单步模板 | `CURRENT PLAN STATUS:\n{全景}\n\nYOUR CURRENT TASK: You are now working on step {i}:`——防跑偏的核心廉价手段 |

---

## 3. 「改造接」清单（需适配我方调度体系，逐条说明改法）

### 3.1 WebSearch 多引擎梯次降级 → 免费搜索渠道同步容错层
- **源**：`OpenManus/app/tool/web_search.py`（引擎注册表 193-198 / engine_order 360-385 / 全败睡 60s 重试≤3 252-281）。
- **改法**：把引擎注册表换成我方免费检索渠道（zh-search-pro 的搜狗/必应/百度 WAP + anysearch），出口统一成 D8 的 SearchItem。注意粒度分工：tier_router 六闸管**渠道级**准入（跨 tick），这层管**单次查询内**的同步降级（同 tick 内秒级切换），互补不重叠。全败睡 60s 须改短（我方 7min tick 下睡 60s 占不起），建议降为 5-10s 且只重试 1 轮、失败转 DEFER 走下轮。

### 3.2 PlanningFlow 的 `[LEG]` 标签路由 → conductor 之上的推理级调度
- **源**：`OpenManus/app/flow/planning.py:145-176`（executor 清单喂规划 LLM）+ 243-247（正则抽 type）。
- **改法**：把采集腿/核验腿/写作腿/排版腿/推送链注册成带 `description` 的 executor 字典（挂 Channel Grid v2 之上），规划产物=带 `[COLLECT]/[VERIFY]/[WRITE]/[TYPESET]/[PUBLISH]` 标签的步骤清单，进同一张选腿表。**三处必须改**：①标签校验——模型写错标签不得静默落到第一个 executor（OpenManus 的无校验是反面），未识别标签硬拒并回炉重写；②保留我方 `_mk_cmd` 式占位符/串接命令双侧硬拒；③PlanningTool 存储从类属性 dict（`app/tool/planning.py:69`，跨实例会串）改实例属性 + 落盘 JSON（我方多线程产线必改）。分工：conductor 管进程级（7min tick），此层管单份研报内推理级。

### 3.3 Terminate 自主收口 ↔ 弹药门 v3 对接
- **源**：`OpenManus/app/tool/terminate.py` + `toolcall.py:218-235`。
- **改法**：Terminate 的触发提示词里写明我方弹药门语义（"T1≥300万且 T1+T2≥3000万即达标，达标后调 terminate(status=success) 收工"），使 agent 侧自主收口与 tier_router 的 `gate_ok→转产` 判定同源同阈值，防两层判定漂移。terminate 后必须留痕入 manifest（我方完备门要对账）。

### 3.4 SSE 事件协议 + 翻译层 → 研究工厂进度透明面板
- **源**：`LangManus/docs/event-stream-protocol/`（12 类事件五层分类学）+ `src/service/workflow_service.py`（astream_events→SSE 翻译、id 规范）。
- **改法**：事件分类学照搬（workflow/agent/llm/message/tool_call + tool_call_result 带全文 + reasoning_content 独立 delta 通道），但事件源换成我方 disk 态（manifest/conductor_jobs/账本三方），翻译层从 astream_events 换成对 board 总表的增量 diff。落点：EPC100 board 已有三方总表，加一个 SSE 端点即可——与我方"进度透明化"既有方向（WeAppForge 已做过）同构。

### 3.5 browser JSON 契约 → UI 自动化腿提示词骨架
- **源**：`OpenManus/app/prompt/browser.py` 9 节结构 + `app/agent/browser.py:43-75` 占位符填充。
- **改法**：JSON 契约与计数条款照搬（见 D2），但 action 空间换成我方 DrissionPage 七坑合规的动作集（run_js 须 return、viewport_midpoint 视口外抛异常等约束写进 Response Rules 节）；占位符填充器换成每步从 DrissionPage 实测取 URL/标题/tab 数。落点：阿里云控制台、CNKI 滑块、备案向导三条既有 UI 腿。

### 3.6 crawl4ai 渲染配方 → JS 站默认参数表（必修 bug）
- **源**：`OpenManus/app/tool/crawl4ai.py:110-129` 配方。
- **改法**：参数表照搬为 JS 站默认（domcontentloaded/process_iframes/remove_overlay_elements/excluded_tags/word_count_threshold）。**必修**：源码 227-232 行注释说预览 300 字符、实际从未切片（`content_preview = result["markdown"]` 后直接加省略号），多 URL 会 token 爆炸——改 `[:300]`。同时按我方铁律改流：**全文落盘、只回摘要+字数给模型**（分析用已落盘数据不重跑）。

### 3.7 AGENT_LLM_MAP → 免费模型优先的角色路由表
- **源**：`LangManus/src/config/agents.py` + `src/agents/llm.py:64-96`。
- **改法**：表结构照搬（角色→档位 + 实例缓存），内容换我方语义：角色→免费档优先 / Jev 兜底，且标注"Jev 只占免费做不到的原语位"（免费模型优先铁律）。规划/对抗验证类角色才允许升 reasoning 档（对应其 deep_thinking_mode 思想）。

### 3.8 token 预算计入工具描述 → Jev/长上下文腿预算闸
- **源**：`OpenManus/app/llm.py:693-705`。
- **改法**：ask 前把 `str(tool)` 的 token 算进 input，超限不硬报错而是优雅收尾（置 FINISHED + 留痕）——对接我方 Noul 双阈值/confidence 三段路由的预算侧。

### 3.9 stuck 检测的产线等价物 → 入池侧零新增预警
- **源**：`OpenManus/app/agent/base.py:170-186`。
- **改法**：agent 内照搬（D5）；另加产线级等价物：manifest 入池侧检测"同渠道同词表连续 N 轮零有效新增 → 打 warn + 提示换词表/换渠道"（我方有同 cmd 幂等去重，缺同产出空转检测）。

### 3.10 MCP instructions 注入 → 渠道账本模型侧可见化
- **源**：`OpenManus/app/agent/manus.py:159-171`。
- **改法**：渠道 CLI 的 README/用法要点在 agent 会话开头以一条 system 消息注入（渠道账本→模型可见）；配 3.11 的漂移刷新，渠道清单变化时告知 agent。

### 3.11 工具清单漂移刷新 → 渠道上下线告知
- **源**：`OpenManus/app/agent/mcp.py:102-147`（对比 inputSchema，增删写 system message）。
- **改法**：渠道注册表（61 渠道）的 tier_fit/限流态快照每会话 diff，增删腿都写一条 system 消息进上下文，agent 不再对已下线渠道发起调用。

### 3.12 coordinator 门卫 → S0 立项分流
- **源**：`LangManus/src/graph/nodes.py:150-164` + `src/prompts/coordinator.md`。
- **改法**：路由判据从"字符串包含 handoff_to_planner"升级为 D6 的结构化枚举（bare 字符串包含判断太脆，是它的偷懒处）；门卫职责换成我方语义：报告名可产性判级（语料水位/弹药存量/渠道覆盖预查）→ 交棒 S1 或 退回并说明缺口。恶意/无意义请求过滤保留。

### 3.13 search_before_planning + deep_thinking_mode → S1 双开关
- **源**：`LangManus/src/graph/nodes.py:115-120` + `src/graph/types.py:26-27`。
- **改法**：①规划前先搜：S1 立框架前用免费检索渠道对报告名搜一把，结果以 `# Relative Search Results` 段注入规划 prompt（顺带修掉其 `tititle` 拼写错误）；②深思考开关：默认免费档，疑难战役（RQS 诊断为难题级）才切 reasoning 档——两开关一行 if，成本低收益高。

### 3.14 reporter 后 FINISH 二跳 → S5 验收收口
- **源**：`LangManus/src/graph/nodes.py:167-185`。
- **改法**：保留"写完≠终点"的结构（写作腿产出后必须过一跳验收才收口），但验收者从 LLM 自由判断换成 RQS 21 门机检 + Jev 判断层（我方已有强件），LLM 只做门间裁决。

### 3.15 MCP 归一化清洗 → 外部工具名规范
- **源**：`OpenManus/app/tool/mcp.py:157-173`（`[^a-zA-Z0-9_-]→_`、64 字符上限）。
- **改法**：用于把我方渠道名/工具名（含中文、冒号等）清洗成模型侧稳定标识，中文名保留在 description。

---

## 4. 「不抄」清单与理由（我方已有更强件）

| 序 | 不抄什么 | 出处 | 理由（我方更强件） |
|----|----------|------|---------------------|
| N1 | LangManus tavily 单源搜索 | `src/tools/search.py` | 我方 61 渠道 grid + tier_router 六闸 + 辛迪加分账碾压；接线方向是**替换**其为 grid 后端工具（3.1），而非复用 |
| N2 | 两项目的无持久化设计（OpenManus plans/memory 进程内；LangManus 无 checkpointer，grep 实证零命中） | `OpenManus/app/tool/planning.py:69`；LangManus `builder.py:26` compile 不带 checkpointer | 我方 O_EXCL 锁 + tmp+os.replace 原子写 + 断点续跑 + adopt 收编是硬需求且在役；LangGraph 断点若用须自补 SqliteSaver，它们没给参考 |
| N3 | OpenManus "run() 返回即 mark completed" 无质量判定 | `app/flow/planning.py:296-299` | 我方完备门四态对账（manifest × conductor × 账本三方合并）+ RQS 21 门；它的 BLOCKED 枚举定义了却全代码路径走不到——我方 blocked/DEFER 三态是真用的，保持 |
| N4 | python_execute / python_repl / bash_tool 三件无沙箱执行器 | `OpenManus/app/tool/python_execute.py`；`LangManus/src/tools/{python_repl,bash_tool}.py`（shell=True 无超时无白名单） | 产线代码执行沿用我方子进程隔离范式（WinRT OCR pytest 死锁教训同源：进程内累积态死锁）；OpenManus 的 multiprocessing 方案在 Windows spawn 语义下每次冷启动 |
| N5 | ask_human 的 input() 阻塞问人 | `OpenManus/app/tool/ask_human.py` | 无人值守产线会挂死；人介入走企微/微信桥既有通道（扫码召唤协议） |
| N6 | LangManus planner 解析失败静默死亡（warning 后 `goto=__end__`） | `src/graph/nodes.py:136-139` | 违反我方"杜绝跑旧代码/假绿红线"纪律；计划解析失败必须重试/回炉/降级兜底（OpenManus 的三步兜底计划反而是可抄的对冲） |
| N7 | LangManus supervisor 无限循环（无轮数上限/无预算闸/计划纯软约束 full_plan 无消费者） | `src/graph/nodes.py:85-104`；全仓 grep 实证 | 我方 max_steps+ROUTER_MAX_INFLIGHT+daily_limit+六闸是产线命门；计划必须是硬契约（状态机落盘+对账），不能只靠提示词纪律维持 |
| N8 | OpenManus PlanningTool 类属性 dict 存储 | `app/tool/planning.py:69` | 跨实例共享，多线程产线必串（若抄 3.2 已含必改项） |
| N9 | crawl4ai 的 300 字符预览实现 | `app/tool/crawl4ai.py:227-232` | 实锤 bug（见 3.6），照抄即 token 爆炸 |
| N10 | SandboxBrowserTool 的 `"dependencies"` 非标 schema 键 | `app/tool/sandbox/sb_browser_tool.py:111-126` | 不在 JSON Schema 规范内，直传 API 有被拒风险；想法（action→必选参数自描述）抄，键名换合规写法（anyOf/if-then 或 description 约定） |
| N11 | LangManus write_file_tool / file_manager.md 悬空死代码 | `src/agents/agents.py` 未引用（grep 实证） | 上游"测试全绿≠接线真活"的自我案例，与我方 Arc O 铁律互证——引以为戒，不引以为件 |
| N12 | OpenManus FlowFactory 单实现注册表 | `app/flow/flow_factory.py`（FlowType 只有 PLANNING 一值） | 骨架空壳，无增量；我方 conductor 注册表已是多渠道多形态真身 |
| N13 | 两项目的 LLM-in-the-loop 决策模式整体 | OpenManus think() 每轮 ask_tool | 我方调度零 LLM 全确定性是长处（7min tick 下可审计可复盘）；融合只取"推理级单报告内"用 LLM 调度（3.2），进程级调度保持零 LLM |
| N14 | LangManus 前后端一体形态（reload=True 开发态、无 worker/队列） | `server.py` / `src/api/app.py` | 我方 schtasks+磁盘态常驻体系成熟；其 SSE 契约抄（3.4），部署形态不抄 |
| N15 | OpenManus Browser Use CLI MCP 自动挂载 | `app/agent/manus.py:18-38,83-99` | 我方浏览器腿已有多套在役形态（DrissionPage/Chrome MCP/9333 串行铁律），再引一套 stdio MCP 增运维面；其"外部工具归一化"机制抄（3.15），载体不抄 |

---

## 5. 七阶段管线结构性增补建议

### 5.1 总架构（融合后）

```
┌─────────────────────── 产线硬层（在役，不动）───────────────────────┐
│ Channel Grid v2 五层调度 · 弹药门v3 · 饱和引擎 · RQS 21门 · 断点/原子写 │
└──────────────────────────────┬───────────────────────────────────┘
                               │ 渠道工具化（D8/D9/D14：SearchItem+ToolCollection+logged 工厂）
┌──────────────────────────────▼───────────────────────────────────┐
│                  agent 标准件层（新增，两 clone 融合）                │
│  S0 门卫(3.12) → S1 规划器(3.13+D11+D12) → S3 调度器(D6+D7+3.2)      │
│  → S2/S4 工人腿(D2/D3 双槽提示词 + D37/D4 terminate + D5 stuck)     │
│  → S5 验收收口(3.14 RQS机检+FINISH二跳) → S6 交付(3.4 SSE + 41 总结降级)│
└──────────────────────────────────────────────────────────────────┘
```

### 5.2 逐阶段增补

**S0 意图解析 —— 加「门卫」**
- 现状：意图解析在，但无"是否值得立项"的前置分流。
- 增补：coordinator 式门卫节点（3.12）：报告名 → 可产性判级（语料水位/弹药存量/渠道覆盖三预查）→ 交棒 S1 或退回附缺口说明。路由判据用结构化枚举不用字符串包含。垃圾/不可产请求在此过滤，不浪费 S1 规划算力。

**S1 初步框架 —— PlanningFlow 思想的三点改造**
1. **计划契约标准化**（D12）：初框架产出从自由文本大纲升级为 Step JSON（agent_name/title/description/note），第一步必须复述报告名意图（LangManus 纪律）；收官步（成稿/交付）只能出现一次且必须最后。
2. **规划前先搜 + 深思考双开关**（3.13）：立框架前免费渠道先搜一把注入 `# Relative Search Results`；默认免费档、难题级战役才切 reasoning 档。
3. **兜底计划**（OpenManus 204-211 思想）：规划失败/解析失败不静默死（N6 反面），降级三步默认计划（盘点家底→定向采集→成稿验证）继续走，同时打 warn 留痕。
4. 执行者清单喂规划器（3.2）：各腿带 description 注册，计划步骤带 `[COLLECT]/[VERIFY]/[WRITE]/[TYPESET]/[PUBLISH]` 标签——标签错误硬拒回炉，不静默落默认腿。

**S2 定向调研 —— 渠道工具化 + 同步降级层**
- 61 渠道用 D8/D9/D14 包装成 agent 可调工具（grid_search_t1 / grid_search_free / grid_fetch_url…），自动获得 IO 日志；渠道账本以 system 消息注入（3.10），渠道漂移刷新（3.11）。
- 查询内同步降级层（3.1）补 tier_router 渠道级闸之外的秒级 fallback。
- 带图文章走 D15 多模态切块喂 VL 图证核对（MEDIA-1 延伸）。

**S3 最终框架 —— 计划状态机落盘 + 结构化路由**
- 计划状态机独立于执行者（OpenManus 第 2 可吸收点的我方版）：4 态（not_started/in_progress/completed/blocked）落盘 JSON，flow 层独占写权；blocked 是真态（对账用），不学它定义了走不到。
- 调度决策出口 = D6 Router Literal 枚举；产出统一 D7 信封回注黑板。
- step_prompt = 计划全景（✓/→/! 进度）+ "只做第 N 步"（D17）——S3 定稿与 S4 每步共用此模板。

**S4 边写边收集 —— 双槽提示词 + 计数收口**
- 判断层/写作腿全面换双槽结构（D3）：SYSTEM= RQS 门与产物合同；NEXT_STEP= 本步任务卡，每步注入。
- 写作腿提示词焊死三条款（D1/D2/D13）：Data Integrity 整节 + memory 字段计数（"N out of M 章引用已核"）+ 诚实收尾（没写完不许说写完）。
- **Terminate 对接弹药门**（3.3）：agent 侧"证据够了收工"与 tier_router `gate_ok→转产`同源同阈值——这是 PlanningFlow 思想对 S4 最关键的改造：收工判定从外层硬计时变成"达标即收"的模型侧对应物，但判定源仍是我方 tier_report 数字（不信模型自评）。

**S5 质量门 —— FINISH 二跳验收 + 双重复盘**
- 结构上保留"写完≠终点"（3.14）：写作腿产出后必须再过一跳验收才收口；验收者=RQS 21 门机检 + Jev 判断层（LLM 只做门间裁决）——比 LangManus 的"再一次 LLM 自由判断"硬。
- 每步复盘制度化：`evaluation_previous_goal` 式自评（D30）进入 S4 每步与 S5 每门：上一门过没过、为什么、下一门查什么。
- 产线级 stuck 预警（3.9）：同渠道同词表连续 N 轮零有效新增 → warn + 换词表建议。

**S6 交付复利 —— 总结三级降级 + 进度透明 + gotchas**
- 交付总结三级降级（模式 41 思想）：主链总结 → 降级备用腿 → 固定模板，任何一级失败不阻塞交付。
- SSE 事件协议面板（3.4）：12 类事件分类学对齐 board 三方总表增量 diff，tool_call_result 带全文利审计——进度透明化的现成契约，省一轮自研设计。
- gotchas 复利（F6 已在役）持续登记本方案实施中的坑（如 crawl4ai 预览 bug、PlanningTool 类属性坑、write_file_tool 悬空教训三条直接入册）。

### 5.3 必须焊死的融合纪律（防两 clone 的病传染过来）
1. **持久化铁线**：任何新 agent 件的状态一律落盘（plans/黑板摘要/终止留痕），进程内 dict 一律视为缓存。
2. **判定与采集解耦**：agent 自主性（think/terminate/stuck）只作用于推理级；产线级判定（转产/完备/质量门）永远走我方确定性机检。
3. **标签/枚举校验**：一切模型产出的路由标签、JSON 计划，解析失败或值域外 → 硬拒回炉或降级兜底，绝不静默落默认、绝不静默 `__end__`。
4. **预算闸不可绕**：max_steps/轮数/token 预算（3.8 计入工具描述）在 agent 件层再设一道，与 conductor 闸表双层互备。

---

## 6. 实施排期建议与验收判据

**P0（先抄即得，零风险）**：D1-D17 直接抄清单全部落地——提示词契约五件（D1/D2/D3/D11/D12/D13）进 reforge_factory prompts；工具契约四件（D8/D9/D10/D14）建渠道工具层；D15 进 MEDIA-1 图证腿；D17 进 LayaForge 单步模板。
**P1（改造接线）**：3.1 同步降级层 → 3.2/3.3 `[LEG]` 路由+Terminate 对接弹药门 → 3.13 S1 双开关 → 3.14 S5 二跳验收 → 3.9 产线 stuck 预警。
**P2（结构性）**：3.4 SSE 进度面板 → 3.5 UI 腿提示词骨架迁移 → 3.10/3.11 渠道账本模型侧可见化 → S0 门卫（3.12）。

**验收判据（可证伪）**：
- P0 后：写作腿成稿提示词含 Data Integrity 五条 + 计数 + 诚实收尾三条款（逐条 grep 可验）；全部渠道工具出口为 SearchItem/ToolResult 统一类型。
- P1 后：一份试产研报全程计划 JSON 落盘可对账（步骤态与 manifest/完备门三方一致）；Terminate 收工案例的弹药余量与 tier_report gate_ok 判定同阈值吻合；标签写错被硬拒回炉的日志至少一条（证明校验真活，非悬空——write_file_tool 教训）。
- P2 后：SSE 面板事件与 board 总表增量零漂移（抽样对账）；门卫退回的不可产请求附缺口说明。

**一句话收束**：OpenManus 给了四个契约（工具注册 / 双槽提示词 / 浏览器 JSON 行为 / 计划编排），LangManus 给了调度骨架（门卫-计划-中枢 / 结构化路由 / 黑板信封 / 事件协议）；我们的五层调度、弹药门、饱和引擎、RQS 21 门是它们的搜索/持久化/校验/限额四块空白的价值证明。**把它们的标准件装进我们的骨架，就得到整条超级生产线。**
