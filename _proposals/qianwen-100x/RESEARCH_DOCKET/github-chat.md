# GitHub 开源库调研：AI 聊天/问答交互（总包AI顾问）

- 调研日期：2026-09-29
- 调研渠道：WebSearch（免费）+ GitHub API（星数/许可证当日实测，限流前完成主样本）+ raw.githubusercontent.com 抓 README/源码（leon-fong 聊天页源码全文精读，经同码 fork MisterZhouZhou/ChatGPT-Miniprogram 入口）
- 分工边界：本文管**交互层**（传输/SSE/打字机/自动滚动/赠次闭环），渲染视觉层见同目录 `github-render.md`。其结论"保留自研 md2blocks（199 行 JS + 174 行 WXSS）、不换 towxml"在本文作为前提对齐——涉及渲染的技法一律按"借算法进 md2blocks、不整库引入"给出结论。

## 渠道结论

1. **微信小程序 AI 聊天的"流式三件套"在开源界已经成熟定型，三层全有 MIT/ISC 件可搬，零许可证风险：** 传输层 `wx.request enableChunked:true + onChunkReceived` 收 SSE（ecomfe/sse-kit ISC 现成封装）→ 渲染层流式 Markdown"稳定块缓存 + 不稳定尾部重解析"（ant-design/x-markdown-mini MIT）→ 表现层打字机 + path-setData + 自动滚动（leon-fong MIT）。这三件恰好是我们"答案页体验"相对头部 AI 产品的最大差距。
2. **交互升级主线不需要推翻现有架构：** 我们现在是"异步流水线 + 进度事件"（提问 → 阶段性进度 → 完整答案落库），开源最优体验是"正文逐字流出"。结合点 = **进度与正文分通道**：进度阶段仍走现有事件机制，引擎答案生成进入输出段时切 SSE 正文流（末段流式），用户从"干等进度条"变成"看着答案一段段长出来"。
3. **渲染层借算法不换库（与 render docket 对齐）：** x-markdown-mini 的核心价值不是库本身而是算法——"空行结尾的块已稳定即缓存、每轮只对不稳定尾部重新 lex"。该算法约 50-100 行可搬进自研 md2blocks，让现有块渲染器直接获得流式能力，不吃 2MB 主包墙（库本体 gzip 25KB 虽不大，但引入即带来第二套样式体系，与藏青/橙蓝品牌卡冲突，理由同 render docket 弃 towxml）。
4. **赠次/限额产品闭环有同构参照：** oldinaction/ChatGPT-MP（352★）的"聊天次数限制 + 分享得次数 + 每日免费次数"与我们"免费 6 次 + 四动作赠次（UNIQUE 每答案每动作一次）+ 北京 0 点清零"几乎同构，其到账提示/余额常显 UX 值得照抄**模式**——但它是 GPL-3.0 且开源版禁止商用，一行代码都不能进我们仓库。
5. **两条硬约束要记住：** ① 许可证地雷——无 LICENSE 文件的仓库（zxz054321、wemark、sbfkcel/towxml 的 GitHub 仓库本体）默认保留所有权利，代码一律不抄（towxml 以 npm 包 package.json 的 MIT 为准）；GPL-3.0（oldinaction）有传染性。② 基础库门槛——`enableChunked/onChunkReceived` 需基础库 ≥2.20.1（2021-09 发布），我们的用户画像（总包/工程从业者，机型偏保守）必须保留**非流式降级路径**：首包全量返回 + 前端打字机模拟（leon-fong show_text 模式正好就是纯前端降级方案）。

## 项目清单

### 总览

| # | 项目 | 地址 | 星数 | 许可证 | 交互形态一句话 | 结论 |
|---|---|---|---|---|---|---|
| 1 | ecomfe/sse-kit | github.com/ecomfe/sse-kit | 14 | ISC（npm） | 小程序 SSE 客户端封装（enableChunked） | **ADOPT**（传输层） |
| 2 | ant-design/x-markdown-mini | github.com/ant-design/x-markdown-mini | 28 | MIT | Ant Design 官方流式 Markdown 渲染 | **ADAPT**（借算法进 md2blocks） |
| 3 | zhouzxx/towxml-stream-typewriter | github.com/zhouzxx/towxml-stream-typewriter | 72 | MIT | towxml 流式打字机组件 | **ADAPT**（借打字机/滚动技法） |
| 4 | leon-fong/ChatGPT-miniprogram | github.com/leon-fong/ChatGPT-miniprogram | 378 | MIT | 打字机+towxml+Prompt 列表+取消请求 | **ADAPT**（交互技法直接可用） |
| 5 | oldinaction/ChatGPT-MP | github.com/oldinaction/ChatGPT-MP | 352 | **GPL-3.0+禁商用** | 全栈：流式打字+次数限制+分享得次数+历史 | **ADAPT（仅学模式，禁抄代码）** |
| 6 | gulihua10010/wxmini-chatgpt | github.com/gulihua10010/wxmini-chatgpt | 101 | Apache-2.0 | uni-app+WebSocket 连续对话，仿微信 UI | **SKIP**（架构不同轨） |
| 7 | zxz054321/chatgpt-miniprogram | github.com/zxz054321/chatgpt-miniprogram | 35 | **无 LICENSE** | TS+TDesign，WebSocket 流式，内容安全审查 | **SKIP 代码 / STUDY 合规点** |
| 8 | wangfengyuan/chatgpt-miniprogram | github.com/wangfengyuan/chatgpt-miniprogram | 22 | MIT | uniapp+Next.js 0 成本后端，次数限制 | **ADAPT**（架构思路） |
| 9 | Roy2017/fetch-event-source-miniprogram | github.com/Roy2017/fetch-event-source-miniprogram | 1 | MIT | @microsoft/fetch-event-source 小程序移植 | **ADAPT**（sse-kit 备选） |
| 10 | sbfkcel/towxml | github.com/sbfkcel/towxml | 2,898 | MIT（npm，GitHub 仓库无 LICENSE 文件） | 老牌 Markdown→WXML 渲染地基 | **基础设施**（render docket 已裁：不做主渲染） |
| 11 | TooBug/wemark | github.com/TooBug/wemark | 1,312 | 无 LICENSE | 腾讯系 Markdown 渲染（停更） | **SKIP** |
| 12 | zhayujie/chatgpt-on-wechat | github.com/zhayujie/chatgpt-on-wechat | 47,166 | MIT | 微信**个人号**机器人（非小程序） | **范围外**（列此防误引） |

> 星数/许可证均为 2026-09-29 GitHub API 实测。补充说明：render docket 记有"towxml-stream-typer 仅 5 星"，与本文的 zhouzxx/**towxml-stream-typewriter**（72★/9 fork，2025-04 创建）是两个仓库，后者已成气候，本文按实测数据采用。长尾小样本另记：Json031/Wechat-MiniProgram-ChatGPT（14★，Apache-2.0，云开发）、feixiangcode/chatgpt-wx-miniprogram（14★，无证，API2D）、MisterZhouZhou/ChatGPT-Miniprogram（2★，MIT，leon-fong 同码 fork，本文源码精读入口）。

### 1. ecomfe/sse-kit —— 小程序 SSE 客户端（ADOPT，传输层首选）

- **地址/星数**：https://github.com/ecomfe/sse-kit ，14★（百度 EFE 官方组织出品，质量有背书，星少但出身硬）
- **交互形态**：把 `wx.request({enableChunked:true})` + `onChunkReceived` 的 ArrayBuffer 流封装成标准 SSE 事件流，自动处理 UTF-8 解码、`\r\n` 边界与 chunk 切割缓冲（这是手写 SSE 最易翻车的三处）。
- **可复用技法**：npm 包 `sse-kit`，TS 编写，`import SSEProcessor from 'sse-kit/lib/bundle.weapp.esm'`；Async Iterator 消费（`for await (const event of sse.events())`）；生命周期钩子 onConnect/onComplete/onError/onHeadersReceived；`getCurrentEventId()` 断点续传；`preprocessDataCallback` 可插 base64 解码；v2.0 支持 SSE `event/data/id` 三字段（我们的"进度事件/正文块"正好可用 event 字段分通道）。
- **许可证**：ISC（npm package.json；仓库无 LICENSE 文件，以 npm 为准）
- **结论**：**ADOPT**。传输层即插即用，省掉手写解析；建议锁版本引入并写 50 行适配层（进度事件路由 → 进度条；正文事件路由 → 答案块）。若嫌它星少，备选 Roy2017（见 #9）。

### 2. ant-design/x-markdown-mini —— 流式 Markdown 渲染（ADAPT：算法进 md2blocks）

- **地址/星数**：https://github.com/ant-design/x-markdown-mini ，28★（Ant Design X 官方，2025-2026 新生代）
- **交互形态**：专为流式设计的轻量跨端 Markdown 渲染：**空行结尾的块视为稳定即缓存、后续 chunk 到达只对不稳定尾部重新 lex**，避免每个 chunk 全量重渲（长答案必卡死的根因）。支持 `semantic`（语义分块）与 `enableAnimation`（平滑生长动画）。
- **可复用技法**：核心 API 形态——
  ```ts
  renderNodes({ content: 累积全文, platform: 'wechat',
    streaming: { hasNextChunk: true, semantic: true, enableAnimation: true },
    onPatch: (nodes) => this.setData({ nodes }) });
  ```
  块缓存/尾部重 lex 算法（搬进 md2blocks 的正是这个）；ESM ~103KB/gzip 25KB；LaTeX/KaTeX（~487KB）与代码高亮（~184KB）按需插件；组件形态 `<markdown content streaming onRenderComplete>`。
- **许可证**：MIT
- **结论**：**ADAPT**。与 render docket 结论对齐——不整库引入（避免第二套样式体系进主包），但"稳定块缓存 + 尾部重解析"算法搬进自研 md2blocks（约 50-100 行），我们现有块数组渲染架构恰好天然适配（块数组 → 已稳定块冻结、末块重解析追加）。

### 3. zhouzxx/towxml-stream-typewriter —— 流式打字机组件（ADAPT：技法与示例实践）

- **地址/星数**：https://github.com/zhouzxx/towxml-stream-typewriter ，72★/9 fork（2025-04 创建）
- **交互形态**：基于 towxml 的流式打字机渲染：每次流式推送 `setMdText(id, text)` 全量喂入，组件内部**局部渲染连续文本 + 稳定节点复用**实现打字机；流结束 `setStreamFinish(id)`；立即停止 `stopImmediatelyCb(id)`。性能实证：5 万字 4 分 30 秒打完，20 万字多轮对话劣化 ≤2 秒——正是 EPC 长答案（几千字含条款/表格）场景。
- **可复用技法**：props `id`（必填唯一）/`speed`（默认 6ms/字）/`openTyper`/`theme`；事件 `finish`/`historyMessageFinish`（历史消息重放打字）；配套示例仓库 towxml-stream-typewriter-weChat-example 的**最佳实践清单**（加载历史消息、滚动到底部、终止打印、**停留页面（用户上滑）终止自动滚动 + 一键滚动到底部**）。
- **许可证**：MIT
- **结论**：**ADAPT**。库本体绑定 towxml（render docket 已裁不做主渲染），不直接引入；但"打字速度与网络解耦""终止打印""用户上滑即停自动滚"三组交互规则与实现思路直接搬。

### 4. leon-fong/ChatGPT-miniprogram —— 聊天页交互技法宝库（ADAPT）

- **地址/星数**：https://github.com/leon-fong/ChatGPT-miniprogram ，378★（小程序 ChatGPT 复刻类星数第一；注意默认分支名是 `mian`——作者 typo）
- **交互形态**：打字机逐字输出、回复等待动画、**取消当前对话请求**、清空屏幕、Prompt 列表（本地 `api/prompts.js` 可自定义）、AI 内容保存/复制、towxml 渲染 Markdown、系统角色注入。
- **可复用技法**（聊天页源码全文精读，三项直接可用）：
  ```js
  // ① 打字机 + path-setData：只更新该条消息，不重渲整个 messageList
  show_text(key, content_key, finished_key, value) {
    if (key >= value.length) { this.setData({ loading: false, [finished_key]: true }); return; }
    currentContent += value[key];
    this.setData({ [content_key]: currentContent }, () => {
      this.handleScollTop().then(() =>
        setTimeout(() => this.show_text(key + 1, ...), 50));  // 50ms/字
    });
  }
  // 调用：show_text(0, `messageList[${index}].content`, `messageList[${index}].finished`, 字符数组)
  // ② 自动滚动：createSelectorQuery 量内容高与视口高之差
  // ③ handleKeyboardHeightChange：screenHeight / safeArea.bottom / statusBarHeight+22 键盘弹起安全区计算
  ```
  文件级：`pages/chat/index.js`、`components/{custom-loading, message-item, prompt-item}`、`api/prompts.js`、`requestTask.abort()` 取消链路。
- **许可证**：MIT
- **结论**：**ADAPT**。打字机/path-setData/滚动/键盘四件技法照搬；UI 皮（ChatGPT 官网复刻风）弃。

### 5. oldinaction/ChatGPT-MP —— 赠次/限额产品闭环同构参照（ADAPT 模式，禁抄代码）

- **地址/星数**：https://github.com/oldinaction/ChatGPT-MP ，352★
- **交互形态**：全栈（JDK8+SpringBoot+Vue2+Uniapp+MySQL，基于 Grt1228/chatgpt-java）：打字效果+流式输出、**聊天次数限制、分享得次数、每日免费次数**、聊天历史、连接状态显示、会员/次数包/看广告得次数、敏感词检测、300 种提示词、H5/WEB 适配。前端在 `aezo-chat-gpt-m/`（uniapp，具体文件路径未能进一步定位，README 功能清单完整）。
- **可复用技法**：**产品模式而非代码**——"次数余额常显 + 分享得次数即时到账提示 + 每日免费 0 点清零"与我们"免费 6 次 + 四动作赠次 + 北京 0 点清零"几乎同构；其"连接状态显示"（对接中/已断开）对我们异步流水线的进度事件呈现是直接参照；"看广告得次数"是四动作之外未来可评估的第五动作。
- **许可证**：**GPL-3.0，且开源版禁止商用**
- **结论**：**ADAPT（仅模式）**。GPL 传染 + 禁商用双重红线：交互流程图可以画进我们的设计文档，一行代码不进仓库。

### 6. gulihua10010/wxmini-chatgpt —— WebSocket 连续对话（SKIP）

- **地址/星数**：https://github.com/gulihua10010/wxmini-chatgpt ，101★
- **交互形态**：uni-app + `wx.connectSocket` WebSocket 流式、上下文连续对话、仿微信聊天 UI；v2.0 已闭源（积分制/markdown 代码高亮行号/支付）。
- **可复用技法**：多轮上下文管理思路；仿微信气泡式 UI（与我们"专业智库答案卡"定位不符）。
- **许可证**：Apache-2.0（v1 开源部分）
- **结论**：**SKIP**。WebSocket 长连接与我们"HTTP + 异步流水线 + 进度事件"架构不同轨，为流式改长连接成本 > enableChunked 方案；UI 风格错位。多轮上下文列入远期再回头看。

### 7. zxz054321/chatgpt-miniprogram —— 无证仓库，但有一个合规提醒（SKIP 代码 / STUDY 合规）

- **地址/星数**：https://github.com/zxz054321/chatgpt-miniprogram ，35★
- **交互形态**：TypeScript+Less+TDesign 官网风格复刻；WebSocket 流式（`miniprogram/lib/websocket.ts` + 配套 chatgpt-websocket-server）；**微信内容安全审查接口**（云开发 security 能力）；点击复制、转发/朋友圈分享。
- **可复用技法**：唯一值得记的点是**内容安全审查**——我们自托管 qianwen-engine，答案不经云开发，提审前需自查是否需要敏感词/内容安全侧（用户输入侧尤其），这是它点破而我们链路上暂缺的一环。
- **许可证**：**无 LICENSE 文件（默认保留所有权利）**
- **结论**：**SKIP 代码**；内容安全合规点单独记入工单。

### 8. wangfengyuan/chatgpt-miniprogram —— 0 成本后端 + 次数限制（ADAPT 思路）

- **地址/星数**：https://github.com/wangfengyuan/chatgpt-miniprogram ，22★（注意默认分支 master，main 上 README 404）
- **交互形态**：uniapp+Vite+UnoCSS+Pinia+uview-plus 前端；Next.js+prisma+mongodb 后端部署 Vercel，宣称 0 成本；简洁聊天界面、可复制可分享、次数限制（无流式）。
- **可复用技法**："0 成本自托管后端 + 前端次数限制闸"的极简架构证明（与我们自托管引擎 + 免费次数模式同向）；其 Vercel 免费层部署可作为备用灾备思路。
- **许可证**：MIT
- **结论**：**ADAPT**（架构思路）。uniapp 栈与我们原生小程序不同轨，代码不直接搬。

### 9. Roy2017/fetch-event-source-miniprogram —— SSE 客户端备选（ADAPT）

- **地址/星数**：https://github.com/Roy2017/fetch-event-source-miniprogram ，1★（npm @chenroy/fetch-event-source-miniprogram）
- **交互形态**：@microsoft/fetch-event-source 的小程序移植：`fetchEventSource(url, {method, headers, onopen, onmessage, onerror, onclose, openWhenHidden:true})`。
- **可复用技法**：`parse.ts` 标准 SSE 逐行字节块解析器（极小可审计）；注意移植差异——onopen 收到的 response 是 wx.request 的 header 对象，须写 `response.header['content-type']?.startsWith('text/event-stream')`；`openWhenHidden` 语义（页面切后台不断流）是我们多阶段长任务需要的。
- **许可证**：MIT
- **结论**：**ADAPT**。sse-kit 的备胎：若需要 fetch-event-source 的自动重试/后台保活语义就换它；两库都极小，可先各写 20 行 demo 对比。

### 10-12. 基础设施与范围外（速记）

- **sbfkcel/towxml**（2,898★）：GitHub 仓库本体**无 LICENSE 文件**，npm 包 package.json 标 MIT——以 npm 版为准；render docket 已裁"不做主渲染"，本 docket 只在 #3 打字机技法中作其衍生品地基出现。**SKIP 主渲染**（维持前裁）。
- **TooBug/wemark**（1,312★，无 LICENSE，2023 停更）：Markdown 渲染老库，不支持流式，被 x-markdown-mini/towxml 全面取代。**SKIP**。
- **zhayujie/chatgpt-on-wechat**（47,166★，MIT）：是微信**个人号/公众号机器人**（itchat/企业微信协议），不是小程序，架构完全不适用；列此防止被星数误导误引。**范围外**。
- 生态补充：DCloud 官方 uni-ai-x（HBuilderX 4.75+ 开源 AI 聊天插件，支持 POST 流式接收）与 uni-ai-chat 模板走 uniapp/uniCloud 栈，与我们原生小程序 + 自托管引擎不同轨，不作候选，仅记生态水位。

## 可直接采纳技法（按对"总包AI顾问"的影响力排序）

1. **【最高｜体验代差修复】SSE 正文流式通道：进度与正文分通道。** 现状是"进度事件跑完 → 答案一次性出现"，头部产品的体验是"答案逐段长出来"。接线：qianwen-engine 输出段支持 `text/event-stream`（SSE `event` 字段区分 `progress` / `content` / `done`，sse-kit v2.0 原生支持 event 字段）；小程序端 `wx.request({enableChunked:true})` + sse-kit（ISC）收流。进度阶段继续喂现有进度条组件，content 事件喂答案块。**基础库 ≥2.20.1 门槛**，低版本走技法 3 降级。
2. **【最高｜长答案不卡死】稳定块缓存 + 不稳定尾部重解析，搬进自研 md2blocks（~50-100 行）。** x-markdown-mini 的核心算法：块以空行结尾即"稳定"进缓存永不重解析，每个 chunk 只重 lex 尾部不稳定块。我们的块数组架构（render docket 前提）天然适配：已稳定块冻结、末块重解析追加。EPC 答案动辄数千字含条款表格，没有这个算法的流式 = 每 chunk 全量重渲 = 必卡。
3. **【高｜降级与回放二合一】leon-fong show_text 打字机 + path-setData。** 50ms/字递归追加，`messageList[${index}].content` 形式的 setData 路径只更新该条消息不重渲列表。两个用途：① 低基础库/弱网降级（首包全量返回 + 前端打字机模拟）；② **历史答案重放**（towxml `historyMessageFinish` 同思路）——用户翻看旧答案时给 1-2 秒的"生长感"强化"AI 现场作答"心智。
4. **【高｜滚动手感】自动滚动四规则（towxml-stream-typewriter 示例实践）。** 流式期间自动滚动到底；**用户上滑离开底部 → 立即停自动滚**（否则用户回翻条款时被强行拽底，工程用户高频回翻场景必炸）；停滚后出"回到底部"悬浮按钮；一键回底。实现：`wx.createSelectorQuery()` 量内容高与视口高之差（leon-fong handleScollTop 现成）。
5. **【中｜键盘适配】handleKeyboardHeightChange 安全区公式。** `screenHeight / safeArea.bottom / statusBarHeight+22` 三值计算输入框弹起位置，直接复用 leon-fong 实现。中老年用户占比高的画像下，键盘遮挡输入框是高频差评点。
6. **【中｜赠次闭环 UX】照 ChatGPT-MP 模式强化四动作到账感。** 次数余额常显于提问入口旁；分享/评价等动作完成后**即时 toast 到账**（而非下次进入才见）；0 点清零前给"今日还剩 N 次"提示；UNIQUE 每答案每动作一次的去重规则用"该答案已领过"文案明示，替代沉默失败。GPL 仓库只学流程不抄码。
7. **【中｜可中断性】三处断点齐备。** 网络层 `requestTask.abort()`（leon-fong 取消当前对话）；SSE 层 `sse.close()`（sse-kit）；表现层 `stopImmediatelyCb`（towxml）→ 对应我们"立即停止打字、直接显示已到内容"。异步流水线还差第四处：**任务取消后端信号**（引擎侧中断生成，省算力）——开源样本没有，我们自己补。
8. **【低｜提问体验】Prompt 列表本地配置化（api/prompts.js 模式）。** 把"AI 优化提问三小问"的递进话术与锅圈页 15 问热点池从代码抽到本地配置文件，运营侧可改不用发版；系统角色注入模板同文件管理。
9. **【低｜合规】内容安全侧自查（zxz054321 点破的缺口）。** 我们自托管引擎不走云开发，用户输入侧（提问文本）与输出侧（引擎答案）的敏感词/内容安全目前依赖引擎自觉，提审前需评估是否补 wx 云开发 security.msgSecCheck 或等价自托管敏感词侧（oldinaction 亦有敏感词检测可参照模式）。记工单，不阻塞交互升级。
10. **【低｜远期】多轮上下文连续对话（gulihua10010 模式）。** 我们当前"单问单答 + 打破砂锅追问"对工程问答已够用；真正的多轮（指代消解、上下文继承）等打破砂锅数据验证需求后再上，届时 gulihua10010 的上下文管理可作参照（Apache-2.0，可细读）。

> 落地次序建议：技法 1+2+4 一组构成"流式答案页"最小闭环（一次改版）；3+5 是同次改版的顺手件；6 单独排一次小迭代（纯 UX 不动架构）；7 随流式改版带上前三处断点；8/9/10 记工单不排期。
