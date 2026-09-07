# OpenClaw 通道协议源码研读（L2 借用调研档案）

> 调研日期：2026-09-07 · 源码版本：openclaw-main 最新 main 分支（本地镜像 `research/competitors-src/openclaw-main/`，MIT）
> 目的：为 ADR-16「借件不借架」的 L2 级借用（通道协议参考实现）提取可移植协议要点，支撑第 22 章与 `poc/channel_adapter_skeleton.py`
> 方法：逐文件通读 feishu 扩展（OpenClaw 162 个扩展中**唯一的中国 IM 通道**），其余通道（telegram/discord/slack 等）协议形态同构，不再逐个展开

## 0. 总量事实（ADR-16 论据复核）

- feishu 扩展包共 **82,375 行 TS**（含测试），`src/` 生产代码 **34,857 行、23 个核心文件**——单个通道 ≈ 一个中型产品
- 162 个扩展中中国 IM 通道**仅 feishu 一个**；`tencent` 扩展是混元模型 provider 端点而非企微通道；无 dingtalk / wecom / wechat 通道扩展
- 结论不变且加强：OpenClaw 的通道资产对我们是「单点参考」而非「全家桶基座」

## 1. feishu 扩展文件地图（生产代码 Top-23）

| 文件 | 行数 | 职责（对本项目的借鉴价值） |
|---|---|---|
| channel.ts | 2067 | 通道契约主实现（边界纪律范本） |
| bot.ts | 1955 | 机器人行为编排 |
| reply-dispatcher.ts | 1706 | 回复分发（消息路由参考） |
| monitor.comment.ts | 1402 | 评论事件处理 |
| docx.ts | 1391 | 文档导出 |
| media.ts | 1097 | 媒体上传/下载 |
| outbound.ts | 990 | 出站消息构造 |
| doctor.ts | 941 | 配置体检（`openclaw doctor --fix` 自修复） |
| drive.ts / bitable.ts | 806/769 | 云文档/多维表格集成 |
| streaming-card.ts / presentation-card.ts / card-action.ts | 766/527/489 | 卡片流式渲染与交互 |
| send.ts | 684 | 发送层 |
| monitor.account.ts | 597 | **账户级监控编排：双模式选择**（见 §3） |
| setup-surface.ts | 579 | 安装向导 |
| **monitor.transport.ts** | **568** | **传输层精华：WS 重连 + Webhook 安全（见 §4/§5）** |
| feishu-ingress.ts | 501 | 持久化入口（durable ingress，见 §6） |
| monitor.message-handler.ts | 500 | 入站消息处理 |
| bot-content.ts | 497 | 出站内容构造 |
| comment-shared.ts | 431 | 评论共享逻辑 |
| **client.ts** | **414** | **官方 SDK 委托层（见 §2）** |
| config-schema.ts | 408 | 配置模式校验 |
| **event-types.ts** | **47** | **归一化事件模式（见 §7）** |

## 2. client.ts（414 行）：SDK 委托而非自研协议

**最关键的发现：OpenClaw 自己也不写飞书 WS 协议**——`client.ts` 完全委托官方 `@larksuiteoapi/node-sdk`：

```ts
// client.ts:20-22 —— OpenClun 对 WS 的全部自有配置只有一个 ping 超时
const FEISHU_WS_CONFIG = { pingTimeout: 3 } as const;

// client.ts:382-404 —— WS 客户端 = 官方 SDK + 四个生命周期回调
await new feishuClientSdk.WSClient({
  appId, appSecret, domain, httpInstance,
  ...callbacks,                       // onError/onReady/onReconnected/onReconnecting
  loggerLevel: info, wsConfig: FEISHU_WS_CONFIG,
});

// client.ts:409-414 —— 事件分发器 = encryptKey + verificationToken
new EventDispatcher({ encryptKey, verificationToken });
```

其余值得移植的工程件：

| 件 | 源码位置 | 要点 |
|---|---|---|
| 多账户客户端缓存 | client.ts:233-239, 344-370 | `Map<accountId, client>`，仅当 (appId, appSecret, domain, httpTimeoutMs) 四元组变化才重建 |
| 代理感知 HTTP 实例 | client.ts:171-216, 253-316 | 共享双协议 agent 跨 REST/bootstrap/WS 连接池化；agent 激活时 `proxy:false` 防 axios 走环境代理旁路；托管代理激活但 agent 创建失败 → 立即抛错（fail-fast 不静默） |
| User-Agent 注入 | client.ts:50-71 | 经 axios 拦截器改写 UA（`openclaw-feishu-builtin/<ver>/<platform>`），保留 SDK 其余拦截器栈 |
| 默认超时注入 | client.ts:247-316 | 所有请求注入默认超时防无限挂起 |
| 媒体上传归一化 | client.ts:97-169 | `/open-apis/im/v1/files`、`/im/v1/images` 的 multipart Buffer→Blob 归一化 |
| 域名双轨 | client.ts:241-245 | `feishu`（国内）/ `lark`（国际）→ SDK Domain 枚举 |

**对我们的直接结论**：飞书通道用官方 Python SDK `lark-oapi`（同样自带 WSClient + EventDispatcher）即可对等实现，**零协议自研、零 fork 需求**——L2 借用的正确姿势是借 client.ts 的工程件（缓存/代理/超时/UA），不是借它的代码。

## 3. monitor.account.ts（597 行）：双传输模式选择

```
monitor.account.ts:571-590
  connectionMode === "webhook"
    ? monitorWebhook({account, eventDispatcher, invokeWebhookEvent, statusSink})   // 本地 HTTP 服务器
    : monitorWebSocket({account, eventDispatcher, setSocketTerminator, statusSink}) // 官方 WS 长连接
```

- 模式由账户配置决定；两种模式共享同一 EventDispatcher 注册（`registerEventHandlers`）
- 线程绑定管理器（threadBindingManager）独立于传输层启停——传输可换、会话绑定不丢
- 对我们：第 17 章「通道即插件」的传输层应为**可插拔双模式**（IM 服务商长连接优先、webhook 兜底），与会话绑定解耦

## 4. monitorWebSocket（monitor.transport.ts:223-356）：重连与终态分类

```
while (!aborted) {
  wsClient = await createFeishuWSClient(account, {
    onError,                       // 终态错误 → resolve(terminalError)；可恢复错误 → 仅记日志
    onReady / onReconnected,       // → statusSink(channelReadyPatch)   通道恢复
    onReconnecting,                // → statusSink(recovering)
  });
  await wsClient.start({eventDispatcher});
  attempt = 0;                     // 成功即清零
  cycleEnd = await race(abortSignal, terminalError);
  // 终态错误 → statusSink(channelBlockedPatch) + 指数退避后重建客户端
}
```

| 协议参数 | 值 | 源码 |
|---|---|---|
| 重连初始延迟 | 1,000ms | `FEISHU_WS_RECONNECT_INITIAL_DELAY_MS`（:52） |
| 退避算法 | `min(1000 × 2^(attempt-1), 30000)` | `getFeishuWsReconnectDelayMs`（:127-132） |
| 退避上限 | 30,000ms | `FEISHU_WS_RECONNECT_MAX_DELAY_MS`（:53） |
| 成功后 | attempt 归零 | :288 |
| 终态错误① | `/^WebSocket reconnect exhausted after \d+ attempts?/` | :55（SDK 内部重连耗尽） |
| 终态错误② | `"WebSocket connect failed and autoReconnect is disabled"` | :56-57 |
| 终态 vs 可恢复 | 终态 → lifecycle `blocked`；否则 `recovering` 继续退避重试 | `isFeishuWsTerminalError`（:160-166）+ :334-341 |
| 客户端重建 | 每轮循环 new WSClient（注释：WSClient 不缓存，每次新连接） | client.ts:379-381 |

**状态发布协议**（statusSink，喂给网关健康监控）：

| 事件 | 发布内容 |
|---|---|
| onReady / onReconnected | `channelReadyPatch({lastConnectedAt, lastEventAt})` |
| onReconnecting | `{connected:false, lifecycle:"recovering", lastEventAt}` |
| 终态断开 | `channelBlockedPatch(脱敏错误, {connected:false})` |
| Webhook 2xx 响应 | `{lastEventAt, lastTransportActivityAt}`（非 2xx **故意不算**活性） |

## 5. monitorWebhook（monitor.transport.ts:358-568）：入站安全五件套

```
请求 → 路由精确匹配 → 方法白名单(POST)+JSON Content-Type → 限流(account+path+ip)
     → 请求体限制+读取超时守卫 → 签名验证(先于 JSON 解析!) → challenge 应答
     → 原型污染过滤 → EventDispatcher.invoke → 200 + durable 头
```

| 防护 | 实现 | 源码 |
|---|---|---|
| ① 签名前置 | `sha256(timestamp + nonce + encryptKey + rawBody)`，头 `x-lark-request-timestamp/-nonce/-signature`，`safeEqualSecret` 时序安全比较；**验签失败 401，先于任何 JSON 解析** | :94-119, 463-473 |
| ② 验证挑战 | `Lark.generateChallenge(payload, {encryptKey})` URL-verification 应答 | :481-489 |
| ③ 限流 | 限流键 = accountId + path + clientIp 三维 | :418-434（`buildFeishuWebhookRateLimitKey`） |
| ④ 请求体守卫 | 最大字节数 + 读取超时双限制，超限即断 | :437-460（`FEISHU_WEBHOOK_MAX_BODY_BYTES/BODY_TIMEOUT_MS`） |
| ⑤ 原型污染 | 载荷键黑名单 `{__proto__, prototype, constructor, headers}`；envelope 用 `Object.create({headers})` 承载可信头 | :63-83 |

路由细节：精确路径匹配（含 `?` 的显式路由保留原样契约；拒绝带 `#` 的 URL）:389-397。

## 6. feishu-ingress：durable 持久化入口

- 事件先入持久化队列再 ACK：durable 模式下响应头加 `x-openclaw-delivery-accepted: durable`（:50-51, 498-507）
- challenge 与非持久事件类型 ACK 时**不**宣称 durable 接受（防「假账」——与 We-AIPO 宪法「产物账不信报表」同构）
- 对我们：第 21 章信任账本的事件入账必须遵循同一纪律——**先落账、后应答、应答头如实反映接受语义**

## 7. event-types.ts（47 行）：归一化事件模式

```ts
FeishuMessageEvent = {
  sender: { sender_id: {open_id|user_id|union_id}, sender_type, tenant_key },
  message: { message_id, chat_id, chat_type: "p2p"|"group"|"topic_group"|"private",
             message_type, content, root_id/parent_id/thread_id, mentions[] }
}
FeishuBotAddedEvent = { chat_id, operator_id, external }
```

对我们的启示：通道适配器的归一化输出应包含**三身份域**（平台原生 ID / 统一 ID / 租户键）+ **会话拓扑**（根/父/线程三层回复链）+ **提及列表**——这是第 17 章通道即插件的统一事件契约蓝本。

## 8. 日志脱敏（formatFeishuWsErrorForLog，:134-158）——直接移植到信任账本

五类正则脱敏后才是可入日志/账本的错误文本：

1. URL 内嵌凭据 `://user:pass@` → `://[redacted]@`
2. `Authorization: Bearer xxx` → `[redacted]`
3. 裸 `Bearer xxx`
4. `token/secret/password/app_secret/tenant_access_token...=value` 键值对
5. 控制字符 → 空格；UTF-16 安全截断至 500 字符

## 9. L2 借用结论（进第 22 章）

| 借用件 | 去处 |
|---|---|
| 指数退避 + 终态分类 + 状态三态发布 | `poc/channel_adapter_skeleton.py` → M2 通道子系统通用传输层 |
| Webhook 安全五件套 | 企微自建应用回调 + 飞书 webhook 兜底模式 |
| 日志脱敏五正则 | 信任账本 incident 记录入账前过滤器（第 21 章） |
| 多账户缓存四元组失效 | channels.ini 多账户热更新 |
| durable 先落账后应答 | 通道事件 → trust_ledger/intents 入账纪律 |
| 归一化事件契约（三身份域+会话拓扑+提及） | 第 17 章通道即插件统一事件模式 |
| SDK 委托模式（pingTimeout 唯一自有配置） | 飞书用官方 lark-oapi WSClient 对等实现，零 fork |

**一句话总结**：OpenClaw feishu 通道 8 万行的价值不在协议（协议在官方 SDK 里），而在**生命周期工程**——重连退避、终态分类、健康发布、入站五重防护、日志脱敏、durable 纪律。这 7 件全部可以（也应该）用 Python 在我们自己的精简内核里重写（合计 ≈800 行），这正是「借件不借架」的 L2 本义。
