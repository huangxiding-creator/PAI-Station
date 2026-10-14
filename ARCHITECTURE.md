# ARCHITECTURE — revenue-engine（双栈组装架构 v1，2026-10-14）

> 旧档已归档：revenue-engine/docs/archive/zongbao-ai-v0917-*.md。
> 需求基线：REQUIREMENTS.md v2.1（25 REQ）。组件证据：RESEARCH_DIGEST / GITHUB_DISCOVERY_REPORT。

## 1. 系统总图

```
                    ┌────────── 微信生态 ──────────┐
                    │  100 值守群   群成员私聊     │
                    └───┬──────────┬─────────┬───┘
            收：rion-cli│DB直读     │         │iLink官方(1v1)
                        │          │收+发    │
        ┌───────────────┘     A栈收发│iPad协议 │
        ▼                          ▼         ▼
  [SignalDetector]          [LangBot]     [CowAgent]
  [OpportunityEvaluator]     fixwin 入站    1v1承接
        │                    86400s/3        │
        │ Lead transformer          │全局日20插件(~50行)
        ▼                           ▼        ▼
  ┌──────────────── EspoCRM（线索中枢·MySQL）──────────────┐
  │  Lead 去重(归一化键) · 评分 · 状态流转 · 原生看板      │
  └───────┬───────────────────────────────────────────────┘
          │评分≥70                    │订单事件
          ▼                           ▼
  [企微群webhook告警]          [acg-faka 发卡/收款]←─ wechatpay V3(商户号门)
          │                           │归因胶水(回调→Lead)
          ▼                           ▼
      主理人(30min/天)         源消息→Lead→推荐→私聊→订单 全链回溯

  B栈（主号UIA·已实战）：proactive 每日9点推送 ← We-AIPO 产线JSON
        → auto_responder 队列(日3/全局20/冷却/熔断) → wxrpa Ctrl+Enter
  外部注入口：8440 FastAPI POST /enqueue（REQ-005）
  审计总线：全发送路径 → 发送日志盘（REQ-019，CowAgent 豁免限频不豁免审计）
```

## 2. 组件与职责

| 组件 | 实现件（锁定策略） | 职责 | 替换预案 |
|---|---|---|---|
| 采集-群 | rion-cli（既有） | 群消息→信号词命中 | wxrpa 读屏兜底 |
| 信号识别 | zbops SignalDetector（既有骨架） | 商机/求助/采购信号 | — |
| A 栈 | LangBot @docker（版本锁 release tag） | 值守问答+插件 | 存活门不过→整栈不部署 |
| 微信通道-A | WeChatPadPro @docker digest 锁 | iPad 协议 | B 栈单栈 |
| 合规腿 | CowAgent 官方 iLink | 1v1 承接 | 不可替（官方通道） |
| B 栈队列 | zbops auto_responder（既有） | 限频安全网+发送 | — |
| 发送-B | wxrpa（既有） | UIA Ctrl+Enter | wechatauto-replica(4.x)/wxautox(购买) |
| 主动服务 | zbops proactive（既有） | 每日推送+钩子 | — |
| CRM | EspoCRM @官方镜像 digest 锁 | 线索/评分/流转/看板 | CordysCRM |
| 告警 | 企微群 webhook | 高价值直达主理人 | — |
| 收款 | acg-faka + wechatpay V3 | 下单/发货/回调 | 个人码半自动 |
| 编排 | 军团 schtasks（既有） | 7×24 调度/自愈/让路 | — |

**自研胶水全集（≤300 行，REQ-024 P6 门）**：Lead transformer（≤200，含归因回调合并）/
全局日20插件（~50）/8440 入口（>30）。

## 3. 缝合契约（upstream DoD → downstream 入口条件）

| # | 契约 | 上游交付义务 | 下游入口条件 |
|---|---|---|---|
| C1 | 信号→Lead | SignalDetector 输出信号 JSON（wxid/昵称/群/原文/类型/时间，schema 见 API_DESIGN §2） | transformer 收到即 <60s 内 POST EspoCRM，失败重试 3 次落死信 |
| C2 | 产线→推送 | We-AIPO channels_publish_detail.json 含标题/链接/标签 | proactive 标签匹配命中才入队，md5 去重后经 B 栈队列 |
| C3 | EspoCRM→告警 | Lead 保存且评分字段就绪 | 评分≥70 触发 webhook，5 分钟内送达 |
| C4 | 订单→归因 | acg-faka 回调含商品 SKU+购买者标识+订单号 | transformer 将订单事件写回源 Lead（关联字段），前 10 单全量核对 |
| C5 | 8440 注入 | 外部服务持 API Key | enqueue 消息过安全网（日3/全局20/冷却），超限返回 429 |
| C6 | 风控互通 | 任一栈 report_risk_signal | 双栈同停（REQ-018/021 同口径），人工核查后恢复 |

## 4. ADR 索引（revenue-engine/docs/adr/）

| ADR | 决策 |
|---|---|
| [ADR-001](revenue-engine/docs/adr/ADR-001-dual-stack.md) | 双栈并行（vs 单栈 all-in）——互备 + 风险隔离 |
| [ADR-002](revenue-engine/docs/adr/ADR-002-membership.md) | 99 会员承接：acg-faka 商品位（meedu 出局：商用授权） |
| [ADR-003](revenue-engine/docs/adr/ADR-003-n8n-deferred.md) | n8n 后置（与 proactive 重叠+无中文界面），触发条件=多源 RSS 需求 |
| [ADR-004](revenue-engine/docs/adr/ADR-004-cowagent-exempt.md) | CowAgent 豁免限频（官方通道），强制入审计日志 |
| [ADR-005](revenue-engine/docs/adr/ADR-005-payment-paths.md) | 收款三态路径（商户号门驱动：V3 直连/个人码/暂缓） |
| [ADR-006](revenue-engine/docs/adr/ADR-006-group-assets.md) | 群资产归属：重要群主号/可控群主持有，小号仅成员 |

## 5. 部署拓扑

- **Windows 主机（既有）**：主号微信桌面端（B 栈 UIA，版本锁定）+ zbops + rion-cli + 军团 schtasks
- **docker（同机或旁路小主机）**：LangBot + WeChatPadPro(mysql8+redis6) + EspoCRM(+mysql)
- **磁盘**：发送审计日志独立目录，保留 ≥90 天；EspoCRM 数据每日 mysqldump 进军团备份轨
- **网络红线**：9222 WeAIPO 免打扰；WeChatPadPro/EspoCraft 端口仅本机回环暴露

## 6. 失效模式表

| 组件死亡 | 系统行为 | 恢复 |
|---|---|---|
| 小号被封（A 栈） | REQ-021 分级：风控异常→双栈同停 30min 内→人工核查恢复 B 栈 | 小号池轮换；A 栈停摆不影响 B 栈收入链 |
| 主号 UIA 失效（微信升级） | B 栈停；A 栈（若在役）接管值守 | 切 replica 备用腿/锁回旧版微信 |
| EspoCRM 挂 | 信号入死信队列；发送侧照常（限频不依赖 CRM） | docker 重启 + mysqldump 恢复 |
| acg-faka 支付插件失效 | 收款降级个人码半自动（ADR-005） | 插件修复或官方 SDK 直连 |
| LLM 供应商耗尽 | 工程大脑轮换下一家；轮换期静默不编造（REQ-011.AC2） | 自动 |
| 军团让路令 | 全线暂停（让路令暂停≠故障，REQ-022.AC1） | yield_pause_all --resume（用户令） |
