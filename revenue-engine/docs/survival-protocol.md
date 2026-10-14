# 存活门实验规程（T-041，2026-10-14 定稿）

## 人工步骤（主理人）

1. **小号准备**：2 个实名小号，注册地/常用地 = 本机所在地（协议情报档案 §4：登录地
   不一致本身是风控因子；无法固定出口则配 Socks5）
2. **扫码登录**：WeChatPadPro 起栈后，每号走 GenAuthKey→GetLoginQrCodeNew→手机扫码
   →确认「iPad 在线」；token 记入 `revenue-engine/reports/survival/accounts.json`
   （格式 `[{"name":"小号A","token":"..."},{"name":"小号B","token":"..."}]`）
3. **进群（只进测试群！）**：issue #67 实证被动被拉群都掉线封号——**实验期两小号
   禁止进任何重要群**；建/借 10 个测试群，逐号加入，每群一条记入 `groups.jsonl`：
   `{"ts":"...","group":"测试群名","note":"小号A加入"}`
4. **日常**：零维护。手机端如弹「环境异常」类提示 → 立即记 events 手账并告警

## 系统步骤（自动）

- 军团腿每 30 分钟跑 `py -I revenue-engine/probes/survival_watch.py`（注册脚本
  `revenue-engine/deploy/register_survival_watch.ps1`）→ events-YYYYMMDD.jsonl
- 报告随时可出：`py -I revenue-engine/probes/survival_watch.py report`
  → survival_report.md（VERDICT: PASS/FAIL/PENDING + 在线率 + 进群台账）

## 判据（REQ-001.AC1，2026-10-14 分级修订：实有小号=1）

| 判 | 条件 |
|---|---|
| 预铺量 PASS | D14 满 14 天 且 在役小号零封号征兆 且 在线率 ≥90%（probe_error 不计分母）→ 仅允许 10 群试运行 |
| 全量 PASS | 第 2 小号到位补双号 14 天证据 → 铺量至值守群全集 |
| FAIL | 任一号封号征兆 → A 栈不铺量，C 族需求转 B 栈单栈（ADR-001 降级路径） |
| PENDING | 未满 14 天时钟继续 |

## 前置依赖

- **容器运行时**（当前缺失！）：LangBot+WeChatPadPro 均 docker compose 部署——
  运行时方案待用户拍板（见主会话选项）
- 带宽窗口：WeChatPadPro/mysql/redis 镜像一次性拉取（让路令期间需窗口）
