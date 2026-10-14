# GITHUB_DISCOVERY_REPORT: 直用清单（2026-10-14 重铸版）

> 结论反转声明：上午版「不 clone 整个项目，只复用思路+片段」作废。
> 本版 = **clone 下来就能跑的直用清单**，全部经 11-agent 对抗验证（stars/license/push
> 为 api.github.com 当日实测，关键能力附文件:行号证据）。

## 一、选定直用件（本引擎实际 clone/部署的仓库）

| # | 仓库 | ★ / License | 角色 | 部署方式 |
|---|---|---|---|---|
| 1 | [langbot-app/LangBot](https://github.com/langbot-app/LangBot) | 18,147 / Apache-2.0 | A 栈主干：群值守 AI 问答+插件生态 | Docker compose（仓库自带）；入站限频配置 86400s/3 |
| 2 | [WeChatPadPro/WeChatPadPro](https://github.com/WeChatPadPro/WeChatPadPro) | 2,642 / **无LICENSE** | A 栈微信通道（iPad 协议） | deploy/docker-compose.yml（mysql8+redis6+ADMIN_KEY）；**存活门前置，可弃组件** |
| 3 | [zhayujie/CowAgent](https://github.com/zhayujie/CowAgent) | 47,387 / MIT | 合规 1v1 承接腿（官方 iLink 单聊） | 一行脚本/Docker/桌面端；扫码即用 |
| 4 | [espocrm/espocrm](https://github.com/espocrm/espocrm) + [espocrm-docker](https://github.com/espocrm/espocrm-docker) | 3,486 / AGPL-3.0 | 线索中枢 CRM（自动查重/中文/REST） | 官方 docker 镜像；X-Api-Key + POST /Lead |
| 5 | [lizhipay/acg-faka](https://github.com/lizhipay/acg-faka) | 5,804 / MIT* | 收款发卡（498 研报自动发货） | *kernel/Plugin.php 专有例外；支付插件实测走单=硬门 |
| 6 | [wechatpay-apiv3/wechatpay-skills](https://github.com/wechatpay-apiv3/wechatpay-skills) | 364 / MIT | 微信支付官方 AI 技能包（收款腿） | Claude 技能安装；配套官方 SDK 全家 Apache-2.0 |
| 7 | [fanyuantaier/wechatauto-replica](https://github.com/fanyuantaier/wechatauto-replica) | 440 / Apache-2.0 | B 栈微信 4.x 备用腿（wxauto 兼容 API） | pip（PyPI 1.2.6.1，2026-10-10） |

**既有本地资产（零新开发直接复用）**：wxrpa（UIA 发送，实战验证）、rion-cli（群消息读取）、
zbops（auto_responder 限频队列 + proactive 每日推送 + 企微回调）、工程大脑（多供应商 LLM）、
军团调度（7×24 纪律）。

## 二、观察名单（备用，暂不部署）

| 仓库 | ★ / License | 用途 | 启用条件 |
|---|---|---|---|
| [1Panel-dev/CordysCRM](https://github.com/1Panel-dev/CordysCRM) | 2,784 / GPLv3+附加 | 中文原生 CRM 备选 | EspoCRM 去重/中文不达预期时 |
| [rachelos/we-mp-rss](https://github.com/rachelos/we-mp-rss) | 4,909 / 未标准化 | 公众号 RSS 备源 | 多源 RSS 需求出现时（license 需先确认） |
| [cooderl/wewe-rss](https://github.com/cooderl/wewe-rss) | 9,646 / MIT | 全文 RSS | **已 archived**——用时必须 fork 自维护 |
| [n8n-io/n8n](https://github.com/n8n-io/n8n) | 207,303 / Sustainable Use | 可视化编排 | 多源内容聚合需求出现时（无官方中文界面） |
| [binarywang/weixin-java-tools](https://github.com/binarywang/weixin-java-tools) | 33,155 / Apache-2.0 | 公众号 Java SDK | 公众号侧自动分发需求出现时 |
| [Hello-Mr-Crab/pywechat](https://github.com/Hello-Mr-Crab/pywechat) | 2,016 / LGPL-2.1 | 微信 4.1 UIA | replica 断更时（注意 PyPI `pyweixin` 是占位空包，须从源码装） |

## 三、排除清单（附原因，防回头重查）

| 仓库 | 排除原因 |
|---|---|
| lich0821/WeChatFerry | 已 archived，锁微信 3.9.12.51，hook 路线终结 |
| danni-cool/wechatbot-webhook | archived 近两年，通道不可考 |
| lss233/kirara-ai | 停更约 16 个月，无个微群通道，AGPL |
| AstrBotDevs/AstrBot | 无个微（hook/UIA/pad）适配器，AGPL+EULA 附加 |
| Hanson/vbot | 开源部分=已死网页协议，导流收费 API |
| Qsnh/meedu | **ADDITIONAL_TERMS 禁未授权商业运营**（refuted） |
| WuKongOpenSource/Wukong-AICRM | 非商业协议，商用需书面授权 |
| assimon/dujiaoka | archived；替代位=acg-faka |
| monicahq/monica / suitecrm / chatwoot | 域不符（个人关系 CRM/太重/客服收件箱） |
| wechatpy/wechatpy | 冻结态（末版 2021），仅打补丁式使用 |
| ttttmr/WeChat2RSS / wcfLink | 无 license，仅 pattern 参考 |

## 四、Documented Miss（自研胶水的合法性依据）

全 GitHub 实查（中英关键词：wechat anti-ban/微信风控/限频/拟人化/发卡/CRM 微信对接）：
1. **发送侧频控+拟人节奏组合件**不存在（LangBot fixwin 是入站侧；zbops 队列是自有件）
   → 自研 LangBot 全局日 20 插件 ~50 行
2. **微信信号→CRM Lead 桥**不存在（全球无 OSS CRM 原生接微信生态）
   → 自研 transformer 100-200 行
3. **跨群身份归一化去重键**无现成 → P4 设计件
4. zbops 8440 callback 服务入口不存在于代码 → 自补（main.py L264-276 实证）

## 五、供应链纪律

- docker 镜像固定 digest 拉取（WeChatPadPro/acg-faka）；pip 锁版本
- PyPI 陷阱：`pyweixin`（owner=n0rmrx，v0.1.0）是占位空包≠pywechat 主线
- WeChatPadPro v875+ 走付费赞助群分发——存活门实验用免费版即可，不预付
