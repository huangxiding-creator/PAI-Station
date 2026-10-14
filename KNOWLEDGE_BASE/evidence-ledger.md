# 证据台账（对抗验证 2026-10-14，回查用）

> 10 条承重 claim + 批评官裁决的原始出处索引。工作流 run: wf_3c5548f5-b54（11 agents）。

## Claim 判定总表

| claim | 判定 | 关键出处 |
|---|---|---|
| langbot-ratelimit | confirmed（修正：入站侧） | ratelimit.py L27/L54-65；fixedwin.py L54-125；safety.yaml L41-75；默认 60s/60 |
| langbot-wechatpad-group | confirmed | sources/wechatpad.py L471-525/L610-694；chatroom.py L4-12；langbot.app docs |
| wechatpadpro-license-risk | confirmed | api license=null；pushed 2026-08-20；封号 issues #18/#67/#126/#167 |
| cowagent-ilink-solo | confirmed | /repositories/522158088 重定向→CowAgent 47,387★；docs：单聊+24h 窗口 |
| espocrm-directuse | confirmed | i18n/zh_CN 目录；api.md X-Api-Key；duplicate-check.md 原文 |
| n8n-internal-use | confirmed | docker/get-n8n-compose.yml；LICENSE L32-33 internal business purposes；i18n 仅 en |
| wewe-rss-mit | confirmed（**archived**） | MIT；末推 2026-03-20，只读 |
| payment-stack | **refuted（部分）** | wechatpay-skills ✅；acg-faka MIT ✅ 但支付插件不可验证；**meedu ADDITIONAL_TERMS 禁未授权商用** |
| replica-wechat4 | confirmed | Apache-2.0；pushed 2026-10-10；PyPI 1.2.6.1 |
| zbops-local-queue | confirmed | auto_responder.py L30-37/L82/L87-116/L166-195；proactive.py L43/L93-100/L108-179；main.py L264-276 |

## 批评官裁决摘要

- 架构修正：zbops=主号 UIA 发送腿+企微入站回调；实为双栈（iPad 小号+UIA 主号）
- 三薄弱点：①发送腿地基（无LICENSE+封号+存活零证据）②收款腿（商户号/插件/meedu 三险）
  ③两处胶水被低估（8440 入口、Lead transformer 均零行）
- 裁决记录：频控非空白（B 栈已有）；n8n 降可选；wewe-rss 备源；CRM 边界=归一化去重键

## 过程产物

- 侦察兵 A/B/C 三报告（会话内，要点已并入 RESEARCH_DIGEST）
- 验证工作流 journal：.super-skill 同会话 workflows/wf_3c5548f5-b54/journal.jsonl
- 注入防护记录：docs.wxauto.org 页尾有针对 AI 的引导文本（已忽略）；其余抓取无注入
