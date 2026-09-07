# 第 22 章 OpenClaw 三级借用与伴生网关

## 22.0 决策背景与本章使命

用户建议原文：

> "我建议本项目产品在 OpenClaw 的框架基础上开发，你的意见是？"

经源码级论证（第 18 章五竞品研读 + 附录 K ADR-16），结论为**借件不借架**：不以 OpenClaw（TS 100,478 行 / MIT）为基座 fork 开发，而以三级借用吸收其精华。用户确认"需要"展开预案与 PoC，并"同意你的建议"。本章将该决策落成四件交付：

1. **L2 通道协议参考实现详案**——从 OpenClaw feishu 扩展（8.2 万行，其 162 个扩展中唯一的中国 IM 通道）提取 7 个生命周期工程件，用 Python 重写进自有内核；
2. **L2 PoC 实录**——`poc/channel_adapter_skeleton.py` 已通过 7 项自测（22.5 节）；
3. **L3 伴生网关预案**——M6+ 可让 OpenClaw 作为伴生网关与本产品双运行时共存；
4. **通道子系统 fork 预案**——M0.5 复核点的触发条件、范围与维护策略（预计不触发）。

> **金句**：8 万行通道扩展的精华不在协议（协议在官方 SDK 里），而在**生命周期工程**——这 7 件全部可以用 Python 在自己的精简内核里重写（合计约 800 行）。借件不借架，借的是工程纪律，不是代码本体。

## 22.1 三级借用总纲

| 级别 | 借什么 | 具体内容 | 成本 | 可逆性 |
|---|---|---|---|---|
| **L1 借设计** | 边界纪律 | ①通道 transport-only（共享类型化动作属呈现层所有，通道适配器只编码）②插件不得 import 内核内部（只用 `plugin-sdk` 缝）③`AGENTS.md` 契约文化（每条规则写明保护的不变量）④doctor 自修复（配置体检 `--fix`） | 零（写进第 17 章通道即插件规约） | 天然可逆 |
| **L2 借组件（参考实现）** | 通道生命周期工程 7 件 | 22.2 节详案 + PoC 已验证 | ≈800 行 Python | 天然可逆 |
| **L3 逃生门** | 伴生网关 | M6+ OpenClaw 作为外部对话网关接入本产品本机 OpenAI 兼容 API（第 17 章） | 配置项 + 适配文档 | **可逆**（关掉即回内嵌通道） |

**基座 vs 伴生的本质区别**：基座（fork 其 10 万行做底）不可逆——信任长板（第 21 章）必须长在内核数据流上，一旦迁入别人的进程模型就永久让渡；伴生（外部网关经标准 API 接入）完全可逆——它只是我们 18 个上下文源之外的一个**对话入口**，随时可拆。

## 22.2 L2 详案：七个生命周期工程件移植表

源码引证全部来自 `research/competitors-src/openclaw-main/extensions/feishu/src/`（行号见 `RESEARCH_DOCKET/openclaw-channel-protocols.md`）：

| # | 工程件 | OpenClaw 源码 | Python 落点（M2 通道子系统） | 验收标准 |
|---|---|---|---|---|
| 1 | **指数退避重连** | `monitor.transport.ts:52-53,127-132`：`min(1000×2^(n-1), 30000)ms`，成功即清零 | `ChannelAdapter.run_loop` 统一治理 | 断网恢复测试：退避曲线 1s→2s→4s→…→30s 封顶，恢复后归零 |
| 2 | **终态错误分类** | `:55-57,160-166`：仅「重连耗尽」「自动重连关闭」两契约为终态（blocked），其余一律 recovering | `is_terminal_error()` | 注入两类终态错误→停止重试并标 blocked；ECONNRESET 等继续退避 |
| 3 | **状态三态发布** | `:257-273,304-312`：ready/recovering/blocked + `lastConnectedAt/lastEventAt/lastError` 喂健康监控 | `ChannelStatus`（不可变 dataclass）→ 第 6 章健康面板 | 通道健康仪表盘实时反映三态切换 |
| 4 | **Webhook 安全五件套** | `:358-517`：签名前置（sha256(timestamp+nonce+encryptKey+rawBody) 时序安全比较，**先于 JSON 解析**）/ challenge 应答 / 限流（account+path+ip 三维键）/ 体积+超时守卫 / 原型污染键黑名单 | `webhook_admission()` + `verify_feishu_style_signature()` | 企微自建应用回调服务器：伪造签名 401、超大载荷 413、`__proto__` 键被剥除 |
| 5 | **日志脱敏五正则** | `:134-158`：URL 凭据 / Bearer 头 / 裸 Bearer / 敏感键值 / 控制字符+500 字符截断 | `redact_error_for_log()` | 单测：五类泄密样本全部脱敏；**信任账本 incident 入账前强制过此过滤器**（第 21 章） |
| 6 | **durable 先落账后应答** | `feishu-ingress.ts` + `:50-51,498-507`：事件先入持久化队列再 ACK，应答头 `x-openclaw-delivery-accepted: durable` 如实反映 | `DurableLedgerStub` → SQLite 事务 | 崩溃恢复测试：ACK 过的事件必然已在库；challenge 不宣称 durable |
| 7 | **归一化事件契约** | `event-types.ts`（47 行）：三身份域（原生 ID/统一 ID/租户键）+ 会话拓扑（root/parent/thread）+ 提及列表 | `NormalizedEvent`（不可变） | 四通道（飞书/钉钉/企微/微信）出站事件同构，画像跨通道关联键可用 |

**SDK 委托模式**（最重要的元发现）：OpenClaw 的 `client.ts`（414 行）自己也不写飞书 WS 协议——完全委托官方 `@larksuiteoapi/node-sdk`，自有 WS 配置仅 `pingTimeout: 3` 一项。我们对等实现：飞书用官方 `lark-oapi`（自带 WSClient + EventDispatcher）、钉钉用官方 `dingtalk-stream`、企微按回调文档。**协议零自研、零 fork**——这是 L2 借用的正确姿势：借工程件，不借代码。

其余三个可直接抄思路的小件：多账户客户端缓存（凭据四元组变化才重建，`client.ts:233-370`）、代理感知 HTTP 实例（agent 激活时 `proxy:false` 防旁路，fail-fast 不静默，`client.ts:171-216`）、媒体上传 multipart 归一化（`client.ts:97-169`）。

## 22.3 L3 伴生网关预案（M6+，双运行时共存）

**部署形态**：

```
┌────────────────────────── 本机（无公网暴露） ──────────────────────────┐
│                                                                       │
│  飞书/钉钉/企微/Telegram… ──► OpenClaw（TS 伴生网关，用户自装）        │
│                                  │  OpenAI 兼容协议（本机回环）        │
│                                  ▼                                    │
│                        PAI-Station 本机 OpenAI 兼容 API（第 17 章）    │
│                                  ▼                                    │
│                        Python 精简内核：感知-记忆-蒸馏-信任流水线       │
│                        （全部数据不出 PAI-Station 进程边界）            │
└───────────────────────────────────────────────────────────────────────┘
```

**四条边界**：

| 边界 | 规则 |
|---|---|
| 消息路由 | IM 入站 → OpenClaw 网关 → OpenAI 兼容端点 → 内核生成 → 原路回流。OpenClaw 只是又一个「模型端点客户端」 |
| 数据边界 | OpenClaw 只见**对话文本**；文件感知/行为 diff/画像/信任账本/技能库全部留在 PAI-Station，伴生网关零触及 |
| 安全边界 | 仅本机回环监听；API key 单向（PAI-Station 签发给网关）；网关无任何 PAI-Station 内部状态访问权 |
| 启停边界 | `pai.ini [companion_gateway] enabled=off|auto|on`，`auto` = 检测到本机运行 OpenClaw 时提示一次性接入向导；`off` = 完全无感 |

**触发条件**（何时值得启用 L3）：①用户已重度使用 OpenClaw、不愿迁移对话入口；②某新通道 OpenClaw 先于我们支持（借它的通道广度，不动我们的内核深度）。两种场景都**不改变**产品主体——伴生网关是锦上添花的入口，不是依赖。

**可逆性证明**：关闭 `companion_gateway` 后，内嵌通道（M2 交付的飞书/钉钉/企微）继续承担全部通信；已产生的对话经网关期间照常入上下文库（它本来就走 OpenAI 兼容端点进内核）。无数据迁移、无功能损失。

## 22.4 通道子系统 fork 预案（M0.5 复核点，预计不触发）

| 项 | 预案 |
|---|---|
| 触发条件 | M0.5 复核点满足其一：①某通道 L2 Python 重写工作量 > 集成其 TS 子系统的改造成本；②某通道协议仅 OpenClaw 有成熟实现且官方 SDK 缺位 |
| 范围 | 仅 `extensions/<channel>/src/` 传输子集（connect/recv/send/重连），以**独立 sidecar 进程**运行（进程边界隔离，同第 4 章 OpenViking sidecar 思路——MIT 无许可证传染，边界是为架构清晰而非合规） |
| 集成方式 | sidecar 暴露本地回环 HTTP（归一化事件 JSON进出），内核侧仍是 22.2 的 `ChannelAdapter` 契约——fork 不侵入内核 |
| 维护策略 | vendor 快照入 `research/competitors-src/` + 上游季度刷新对账（复用第 18 章竞品季度刷新机制）；改动以 patch 文件记录，禁直接改 vendor 源 |
| 默认结论 | **预计不触发**：PoC 已证明 7 件全部可 Python 重写（22.5），且飞书/钉钉/企微官方 SDK 均在——本预案是保险，不是计划 |

## 22.5 L2 PoC 实录（已完成）

| 交付物 | 内容 | 状态 |
|---|---|---|
| `RESEARCH_DOCKET/openclaw-channel-protocols.md` | 协议调研档案：文件地图（23 核心文件行数）、9 节协议要点、每条带源码路径行号、L2 借用结论表 | ✅ 已落盘 |
| `poc/channel_adapter_skeleton.py` | ≈350 行：`ChannelAdapter` 六接口抽象基类（connect/auth_refresh/recv/send/close/health + `run_loop` 统一重连治理）+ 7 件移植实现 + 7 项自测 | ✅ 全过 |

自测结果（`python poc/channel_adapter_skeleton.py`）：

```
[ok] redact: 五类泄密样本全部脱敏（URL 凭据/Bearer/token/password）
[ok] backoff: [1000, 2000, 4000, 8000, 16000, 30000, 30000] 曲线精确匹配源码公式
[ok] terminal-classification: 2 终态 + 1 可恢复正确分类
[ok] guards: 405/415/413/401 守卫次序正确（签名先于 JSON 解析）
[ok] signature: sha256+nonce 时序安全比较通过；__proto__/headers 键被剥除
[ok] durable: accepted 加头 / ack-only 不加头语义正确
[ok] status-sink: ready/recovering/blocked 三态发布次序正确
```

**成本核验**：7 件移植合计约 350 行 Python（含注释与自测）——对比 OpenClaw feishu 扩展 82,375 行，**借件成本 ≈ 借架成本的 0.4%**，且换来的内核纯净度（信任长板不旁落）无法用行数衡量。这是「容易的事借巨人的肩，最难的事也是在巨人的肩基础上再自己扛」在通道域的实例：退避公式、守卫次序、脱敏正则全是巨人现成的肩；把它们织进自己的内核数据流（信任账本入账前过滤、健康面板三态、durable 落账）才是自己扛的部分。

## 22.6 工单（进 TASK_BACKLOG）

| 工单 | 里程碑 | 内容 | 验收 |
|---|---|---|---|
| **T11** | M0 | 通道适配器基类按 PoC 骨架落地生产版（asyncio 化 + `channels.ini` 多账户 + 凭据四元组缓存失效）；7 项自测纳入 CI | 基类单测 + INI 加载测试绿 |
| **T12** | M2 | 三通道实现：飞书（`lark-oapi` WSClient 委托 + webhook 兜底双模式）、企微（回调服务器含安全五件套）、钉钉（`dingtalk-stream`）；全部出站 `NormalizedEvent` | 每通道收发冒烟 + 断网恢复退避曲线日志 |
| **T13** | M6 | 伴生网关模式：本机 OpenAI 兼容 API 对外部网关的签发/吊销 + `[companion_gateway]` 配置 + 接入向导 | OpenClaw 真实接入冒烟：IM→网关→内核→回流全链路 |

## 22.7 小结

本章把「在 OpenClaw 框架上开发」的建议落成了**更优解**：L1 借它的边界纪律（零成本）、L2 借它的通道生命周期工程（约 800 行 Python，PoC 已验证 7 件全过）、L3 留伴生网关逃生门（可逆）、fork 通道子系统作 M0.5 保险（预计不触发）。OpenClaw 的 8 万行通道资产被压缩成一份带行号的协议档案 + 一个 350 行的骨架，其工程纪律全部为我所用，其基座负担（10 万行 rebase 债、TS/Python 跨进程、信任长板旁落）一分不背。ADR-16 至此从「决策」变为「决策 + 详案 + PoC + 工单」四件套闭环。
