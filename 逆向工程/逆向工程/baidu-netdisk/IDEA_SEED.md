# IDEA_SEED — 百度网盘全功能 API/CLI 化（代号 BDPAN-FACTORY）

- 日期：2026-10-29
- 来源：用户明示指令（含账号 pyeye@126.com、方法论三件套 REA+Reverse-skill+PentAGI、super-skill 全流程不跳步、批准门后自主实施）

## 原始想法
逆向本机百度网盘客户端 → 文件上传/下载/删除/检索、文件夹新建/编辑/删除等常用功能 API/CLI 化，供 Claude Code 命令行调用。

## 意图澄清（ambiguity score = 3，自动通过 Hybrid Gate）
- 北极星（用户中途确认）：**全盘访问 + 自主可控 + 零遥测**
- 现状痛点（实测）：
  1. 官方 bdpan CLI（本机已装 AppData\Local\bdpan\bdpan.exe，未登录）沙箱锁死 `/apps/bdpan/`，全盘操作不可能
  2. bdpan 每次调用回传 `--session-input`（用户原始输入）到百度 = 遥测
  3. 闭源黑盒：无断点续传语义、无限速控制、无自主修复能力
- 隐含需求（从 workspace 上下文推断，提案将确认）：
  - 接入既有备份链（AI-Station-archive/<项目>/<日期>.tar.gz → 网盘）
  - 技能化：升级现有 baidu-drive skill 底座
  - 复用三件套方法论沉淀为可复用「客户端→API 工厂」资产

## 约束（宪法+铁律）
- 只用用户本人账号；只读优先；请求节流（账号风控红线：黑名单码 31119/31329 在案）
- 密钥永不进仓（secrets_vault 模式）
- 删除类操作（远端 rm）必须用户当次明示确认
- 24h 不间断、永动机让路规则、零浏览器优先（纯 HTTP）
- PentAGI 8443 当前无响应（docker 不可用）→ 提案含复活腿或降级方案

## 初步假想（待研究证据修正）
三通道架构：T1 官方开放平台 API（合法稳定）× T2 PCS/BDUSS 协议（BaiduPCS-Go 蓝本，全盘+秒传）× T3 客户端实测协议（8.2.5 抓包校准 UA/签名）→ 统一 CLI + skill v2。
