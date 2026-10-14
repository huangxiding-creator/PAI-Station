# CONTEXT: revenue-engine 术语表与系统地图

## 一图

```
100工程群 ─┬─ rion-cli(DB直读) ── SignalDetector ── EspoCRM(Lead) ── 企微webhook告警 ── 主理人(30min/天)
           ├─ A栈 LangBot(小号iPad) ── 群问答(入站限频 86400/3) ── 全局日20插件(待写)
           └─ B栈 zbops队列(主号UIA) ─┬─ wxrpa 发送(日3/全局20/冷却/熔断)
                                    └─ proactive 每日9点推送 ← We-AIPO产线JSON
1v1承接: CowAgent(iLink官方) ── 深聊 → acg-faka下单(498研报/99会员) ← wechatpay V3(商户号前提)
归因: 消息→Lead→商机→订单→回款，EspoCRM 全链状态流转
```

## 术语表

| 术语 | 定义 |
|---|---|
| A 栈 | iPad 协议小号栈：LangBot + WeChatPadPro，群值守 AI 问答（存活门前置） |
| B 栈 | UIA 主号栈：zbops auto_responder 队列 + wxrpa 发送 + proactive 推送（已实战） |
| 主号 / 小号 | 统一用「主号」（C-4 约束其只跑 B 栈）；小号=协议风险承担者（A 栈专用） |
| 值守群 | 纳入运营的 100 工程群子集（=REQ-009 的「目标群」，两词同义，Phase 0-4 圈定清单） |
| B 栈队列 | auto_responder 队列（同义旧名：zbops 队列，统一用「B 栈队列」） |
| 合规腿 | CowAgent 官方 iLink 单聊 1v1 承接（零封号风险，24h 回复窗口） |
| 双栈 | A+B 并行互备架构；任一栈死另一栈接管 |
| 存活门 | Phase 0-1：2 小号×14 天 WeChatPadPro 存活实验（判据：零封号+在线率≥90%），门不过 A 栈不铺量 |
| 走单门 | Phase 0-2：acg-faka 微信支付插件实测一单 498 元全流程 |
| 商户号门 | Phase 0-3：企业商户号+营业执照确认（微信支付 V3 硬前提） |
| 协同策略门 | Phase 0-4：主/小号谁答谁推/去重互通/风控互通定稿 |
| 限频矩阵 | 见 KNOWLEDGE_BASE/safety-params.md（发送侧唯一权威表） |
| 归一化去重键 | 跨群识别同一微信用户的合并键设计件（wxid 优先/昵称+群/手机号） |
| Lead transformer | 采集信号→EspoCRM POST /Lead 的胶水（100-200 行，唯一大件） |
| 工程大脑 | 既有 LLM 多供应商轮换（智谱→硅基流动→Agnes 免费额度） |
| 弹药库 | F1-BLUEBOOK 1.08 亿字研报池（498 元 SKU 的货源） |
| 军团 | 在役 7×24 调度纪律（schtasks 网格+让路机制+审计台账） |
| WeAIPO | 自媒永动机（3 公众号+1 视频号日更）——让路令优先级最高 |

## 红线速查（本 run 全程有效）

1. 删除只认用户明示指令（1012 事故）
2. 密钥永不进仓；推送冻结（本地 commit 可，push 等令）
3. WeAIPO 9222 免打扰；9336/9337 端口专用
4. 数字零造假（一切字数/数据门以实测为准）
5. 三级许可证边界（宽松直改/闭源情报/付费购买；不克隆闭源代码）
6. 让路令状态：2026-10-14 14:20 全暂停生效中（恢复=yield_pause_all.py --resume，等用户令）
