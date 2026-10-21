# SECURITY MANUAL 归档 — 6b 网络语境 / 9 生产开关（2026-10-22 用户令「剩余四件全部完成」授权代核）

## 6b 网络语境人工核（PASS）
取证（grep 全量，命令留痕于 DEVLOG 同日条目）：
- kb_factory 运行时出网点：**仅 `channel_adapters/wenku_meta.py` → wenku.baidu.com/gsula/sula/syncmrecall（检索元数据，零Cookie）**；其余 http 命中全部为测试/夹具/门自检代码（tests/、security_gate.py 白名单表）
- 小程序 kbfactory 面：零直连外部域——所有请求经 `utils/api.js` BASE_URL=ai.epcschool.top（自有引擎）
- PII 流向：email/need_text 仅进入订单 payload → 自有引擎 /api/kb/*；**检索词不含用户身份**（无 openid/邮箱拼接进 wenku 请求）
- 结论：无数据外泄面；用户数据只到自有后端

## 9 生产开关人工核（PASS）
- `KB_WENKU_FETCH`：源码默认不设=黄源 OFF（终审三态探针已证：fetch=1无secret→OFF / fetch=1有secret→ON / 不设→OFF）；生产不设 ✓
- `KB_WENKU_MIN_INTERVAL`：代码默认 3s（安全门下限=3）；**运维规程=生产 6s**（run_seeds.py 已用 6s 实证无恙；RELEASE.md §3 参数表为准）✓
- 密钥在仓外：data/secrets/（gitignored）+ 07 任务/自动建库Agent/_credentials/*.secret.ini（双保险）✓；发布面 git ls-files 零凭据（安全门项1 PASS）✓
- 生产人工核遗留：TCB 部署时确认不设 QW_DEV_LOGIN/QW_FAKE_ASK（TCB_DEPLOY.md §3 纪律，部署清单已含）

## 归档声明
两项 MANUAL 核验完成，证据如上；安全门 9 PASS / 0 FAIL / 2 MANUAL(已归档) —— 门机检输出不因此变更（MANUAL 态保持，以本文档为归档凭证）。
