# RESEARCH_DIGEST: 微信私域收入引擎 全网调研（直用验证版）

> 调研日期：2026-10-14 | 方法：三路侦察兵（A 微信机器人 / B 工作流+CRM / C 风控+内容桥+收款）
> + 11-agent 对抗验证工作流（10 条承重 claim 独立取证 + 批评官裁决）
> 全部 stars/license/push 为 api.github.com 当日实测；本地代码逐行核对并标 文件:行号。
> 结果：8 条 claim confirmed、1 条 refuted（meedu 商用授权被证伪）、1 条带重大方向修正
> （LangBot 限速器是入站侧）。上午 108 项目普查保留为背景层（本文末节）。

## 一、2026 微信机器人格局（A 路 + 验证）

**格局剧变三事实**：
1. chatgpt-on-wechat 已改名 **CowAgent**（47,387★ MIT，301 重定向实证），微信个人号通道
   换官方 **iLink Bot API**——仅单聊、24h 回复窗口、不进群（docs + 源码 channel/ 实证）。
2. **hook 路线终结**：WeChatFerry 已 archived（6,807★），锁死微信 3.9.12.51，4.x 无望。
3. 微信群场景现役技术只剩两条腿：**iPad 协议**（WeChatPadPro）与 **Windows UIA**（wxauto 系）。

| 项目 | ★/License | 最近push | 群能力 | 直用判定 |
|---|---|---|---|---|
| [langbot-app/LangBot](https://github.com/langbot-app/LangBot) | 18,147 / Apache-2.0 | 2026-10-14 | ✅ wechatpad 群收发（chatroom.py + sources/wechatpad.py L471-694 实证） | ✅ 主干 |
| [WeChatPadPro/WeChatPadPro](https://github.com/WeChatPadPro/WeChatPadPro) | 2,642 / **无LICENSE** | 2026-08-20 | iPad 协议服务端（docker: mysql8+redis6+ADMIN_KEY，deploy/docker-compose.yml 实证） | ⚠️ 风险件（见法律节） |
| [zhayujie/CowAgent](https://github.com/zhayujie/CowAgent) | 47,387 / MIT | 2026-10-14 | ❌ 仅单聊 | ✅ 合规 1v1 承接腿 |
| [Tencent/openclaw-weixin](https://github.com/Tencent/openclaw-weixin) | 941 / NOASSERTION | 2026-10-13 | ❌ 仅单聊（官方 iLink 插件） | 参考（合规方向标） |
| [cluic/wxauto](https://github.com/cluic/wxauto) | 7,360 / Apache-2.0 | 2026-04-13 | UIA，锁微信 3.9.X；4.x 属商业版 wxautox | 🔧 库非机器人=回到自研 |
| [fanyuantaier/wechatauto-replica](https://github.com/fanyuantaier/wechatauto-replica) | 440 / Apache-2.0 | 2026-10-10 | UIA，**微信 4.x**，wxauto 兼容 API | 🔧 备用腿（单人维护风险） |
| WeChatFerry / wechatbot-webhook / kirara-ai / AstrBot | — | 归档/停更/无个微群通道 | ❌ | 仅参考 |

**LangBot 关键修正（对抗验证 corrected_fact）**：其内置 fixwin 限速器是**入站请求侧**
（位于 MessageProcessor 之前，超限丢弃用户消息不回复），配置 `safety.rate-limit`
（window-length/limitation/strategy，默认 60s/60 次，可配 86400s/3 次，ratelimit.py L27、
fixedwin.py L104-125 实证）——被动问答等价于「每群每窗口最多回 N 条」，但**不约束主动/
定时推送**；且分组键拼接 pipeline_uuid（fixedwin.py L54-64），同群配多条流水线配额会放大。

## 二、本地资产实证（B 路 + zbops-local-queue 核查）

| 资产 | 实证内容 | 位置 |
|---|---|---|
| zbops 发送队列 | MAX_PER_CHAT_DAILY=3 / MAX_GLOBAL_DAILY=20 / CHAT_COOLDOWN=30min / 营业 8-21 点 / 群间隔 60-180s / md5 前50字符去重 / report_risk_signal 熔断清队列 | radar/auto_responder.py L30-37, L87-116 |
| zbops 主动服务 | 每日 9-10 点循环 + rion-cli 热词 + 群画像标签匹配 + enqueue(priority=3)；内容源直读 We-AIPO 状态 JSON | radar/proactive.py L43, L108-179 |
| wxrpa 发送 | _send_via_wxrpa：UIA + Ctrl+V/Ctrl+Enter 进个人微信桌面客户端 | auto_responder.py L166-195 |
| 8440 缺口 | main.py 仅有 selftest/run/monitor/both 四子命令——callback 服务**只存在于文档串**，HTTP 入口要连服务一起补 | main.py L264-276 |

**架构认知修正（批评官裁决）**：zbops 不是「企微腿」而是「**主号 UIA 发送腿 + 企微入站回调**」。
真实架构 = **双栈并行**：A 栈 iPad 协议小号（LangBot）+ B 栈 UIA 主号（zbops 队列+wxrpa）。

## 三、编排 / CRM / 内容 / 收款（B、C 路 + 验证）

| 场景 | 选型 | ★/License | 验证结论 |
|---|---|---|---|
| 定时主动服务 | **zbops proactive（既有）**；n8n 降为可选 | n8n 207,303 / Sustainable Use | n8n 内部商用合法（LICENSE 原文 own internal business purposes）；但与 proactive.py 功能重叠且 master 无官方中文界面（i18n 仅 en 实测）——内容源以自有产线 JSON 为准时 n8n 可后置 |
| 线索 CRM | **EspoCRM** | 3,486 / AGPL-3.0 | zh_CN 随仓、X-Api-Key + POST /Lead、**创建时自动查重内置**（duplicate-check.md 原文）；AGPL 不分发无义务；备选 CordysCRM 2,784★（中文原生，去重未验证） |
| 告警 | 企微群 webhook | — | 纯 HTTP 零开发 |
| 内容 RSS | 自产 JSON 准源；wewe-rss 备源 | wewe-rss 9,646 / MIT | **已 archived**（末推 2026-03-20，只读）——用时需 fork 自维护 |
| 收款-官方 | **wechatpay-skills** | 364 / MIT | 微信支付官方 AI Agent 技能包，2026-10-13 仍活跃；官方 SDK 全家 Apache-2.0 |
| 收款-发卡 | **acg-faka** | 5,804 / MIT（kernel/Plugin.php 专有例外） | 自动发卡系统；**微信支付自动发货插件在闭源商店，无可公开验证**——上线前必须实测走一单 |
| 收款-会员 | ~~meedu~~ **出局** | Apache-2.0 + ADDITIONAL_TERMS | **refuted**：附加条款禁止未经商业授权商业运营——99 元会员直用即违约；改用 acg-faka 商品位或自建薄腿 |
| 公众号 SDK | wechatpy（冻结态）/ WxJava / easywechat | 33,155★ / Apache-2.0 | wechatpy 末版 2021，仅打补丁式使用 |

**供应链警示**：PyPI 包名 `pyweixin` 是无主占位空包（owner=n0rmrx，v0.1.0）——与
Hello-Mr-Crab/pywechat 主线说的 pyweixin **不是同一个**，pip 装到的是空包。docker 镜像
（WeChatPadPro/acg-faka 等）应固定 digest 拉取并预扫。

## 四、真空白胶水清单（全链路唯一要写的代码，批评官核定）

1. **采集→EspoCRM Lead transformer**（100-200 行，目前零行）：wxid/群昵称→Lead 字段映射、
   来源群、触发时机（商单词命中/iLink 单聊咨询）；含跨群身份归一化去重键设计
   （EspoCRM 查重是 CRM 内部字段，微信侧同一人换昵称/跨群的归一无现成件）。
2. **LangBot 发送侧全局日 20 插件**（~50 行，落点待实测）：插件体系存在（src/langbot/pkg/plugin/
   + .lbpkg 格式实证）但能否挂统一发送出口、重启计数是否清零、与 fixwin 如何避免双计未验证；
   必须做在流水线维度之上（pipeline_uuid 会放大配额）。
3. **zbops 8440 服务入口 + POST /enqueue**：比原估「30 行」大——callback 子命令不存在，
   要连 FastAPI 服务入口一起补，且队列/计数器进程归属需重设计。
4. **主/小号协同策略**（设计件非代码）：谁答谁推、同群内容去重（两栈各自 md5/插件去重不互通）、
   风控信号互通（report_risk_signal 现仅熔断自己）。

## 五、法律与账号风险表（批评官 + 验证合并）

| 风险 | 等级 | 证据/应对 |
|---|---|---|
| WeChatPadPro 无 LICENSE | 高 | GitHub license=null + 全目录无 LICENSE 文件——默认保留所有权利，越权使用/分发/修改无授权；封号 4 起一手报告（#18/#67/#126/#167，#67：被拉群都掉线封号）；**先做 1-2 小号×2 周存活实验再定群规模**；按三级边界只做事实级情报提取，不逆向复刻其代码 |
| iPad 协议封号 | 高 | LangBot 作者原话「有。建议用小号」（issue #1096）；小号+克制频率对冲；群资产归属小号=号焚群亡，需轮换成本预算 |
| UIA 违反微信用户协议 | 中低 | 长期低位风险；zbops 安全网（日3/冷却/熔断）已实战；识流参数佐证安全阈值 |
| 微信支付 V3 硬前提 | 高（收款腿） | 需企业商户号+营业执照；无则整条收款腿不通，个人码半自动收款备选未设计 |
| meedu 商用授权 | 已排除 | ADDITIONAL_TERMS.md 原文 |
| n8n fair-code | 低 | 内部商用合法，禁收费转售托管；.ee. 文件不在授权内 |
| EspoCRM AGPL | 低 | 不分发即无义务；CRM 若对外暴露页面/API 给客户需复查 |
| 合规审计缺失 | 中 | 发送日志留存、群内营销退订/静默、封号应急预案、群资产归属策略——均未立项（进 P4 需求） |

## 六、背景层：上午 108 项目普查（保留索引）

Wechaty 23,363 / kirara-ai 19,089（停更16月）/ LangBot 18,139 / wxauto 7,362 / vbot 4,611（网页协议已死）/
ChatGPT-On-CS 4,469（AGPL 电商客服）/ 国内 SCRM 18 家（识流/微伴/尘锋/探马…全部闭源 SaaS）/
国际 AI 销售 20 家（Drift/Intercom/Gong…无微信生态）/ Agent 编排 10 框架 / 工程行业 AI 8 家。
详见 git 历史（本文件上午版本）。

## 关键洞察（保留自上午版，仍成立）

1. 无人做「微信群监控+商机挖掘+内容分发+AI 答疑」全闭环——执行/分析/闭环三层断裂。
2. 工程垂直行业（规范/标准/造价/EPC 知识密度极高）的 AI 商业开发完全空白。
3. 内容→商机→收入全链路归因无人做到。
