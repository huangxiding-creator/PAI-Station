# ADR-001: 双栈并行（iPad 小号 + UIA 主号）

日期：2026-10-14 | 状态：accepted

## 背景
发送腿技术路线二选一：iPad 协议（LangBot+WeChatPadPro）vs UIA（wxrpa/wxauto 系）。
批评官裁决：zbops 队列本质就是 UIA 路线，两者不是并列选项而是两条不同地基。

## 决策
双栈并行：A 栈（LangBot+WeChatPadPro，小号，存活门前置）负责值守问答扩展性；
B 栈（zbops 队列+wxrpa，主号，已实战）负责限频安全网+主动推送+收款链。

## 理由
1. 互备：任一栈死亡另一栈接管（失效模式表）
2. 风险隔离：协议风险只由小号承担（C-4）；主号永不经手 iPad 协议
3. B 栈零新增开发即可跑最小收入闭环（Phase 1 不依赖 A 栈）

## 放弃的选项
- 单栈 iPad all-in：WeChatPadPro 无 LICENSE+封号 4 案+存活零证据，单点不可承受
- 单栈 UIA：丢掉 LangBot 插件生态与群问答自动化直用件，值守回答全靠自研=违背铁律
