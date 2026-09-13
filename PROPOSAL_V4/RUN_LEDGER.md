# RUN_LEDGER — V4 运行台账（C10：台账胜过文档，只增不删）

## 2026-09-13

- ✅ 调研收官：八路 240→239 净新增；四收敛文档（commit 11c7814，已推送）
- ✅ ✋ 审批闸通过：用户「批准」——A→B→C→D→E 顺序动工
- ✅ V3 资产盘点（Phase A 地基实测）：
  - 画像五层=JSONL 双时间线（`profile/model.py`，effective_to 封口语义可直接复用为遗忘机制）
  - 记忆=SQLite FTS5 文档索引（`memory/store.py`）——是索引不是主权资产，vault 另建
  - 技能=`data/skills/<name>/SKILL.md`（frontmatter 与 Anthropic skills 近同构，适配成本低）
  - 决策记忆=`learn/whys.py` 空壳（确证差量 G1，Phase A 全新建）
  - `data/` 实存：audit.db / memory.db / skills/ / soul/ / foundry/ …（profile/ 未建=生产无画像条目，export 需容忍空）
- 📥 用户产品洞察入账（P2 变强三路径）：①经验沉淀（隐性经验显性化为主权资产）
  ②专家交付（任务级专家技能赋能，普通工作者出专家级成果）③前后对比
  （原成果 vs 赋能后成果的对照证据=采纳证据链）。已写入 VISION_V4 P2。
- 🚧 A1 动工：test_sovereign_vault.py 红测试 → format.py + vault.py
- ✅ A1-A5 TDD 全绿：vault16/protocol11/heritage4/adapters7/cli5=43 例；全量回归 **930 passed**；ruff 项目范围 0
- ✅ A6 收口：commit **76fe08d** 已推送（ls-remote 真判据 76fe08dc…==HEAD；网络走 push_net_heal 开窗→schannel→--restore）
- ✅ CLI 三线收尾（用户指令）：aliyun v3.5.0 / feishu-cli 0.2.0+lark-cli 0.1.0 / workbench v1.0.1（~/bin + wb 别名；用户级 PATH 原为空→已设）；
  **Workbench 连接实测打通**：`wb list`（实例「AI测试」i-f8za6qhv365cwhti5y35 Running）+ `wb exec`（Ubuntu 24.04.2 LTS kernel 6.8）零密码免公网 IP 直达；凭据落 ~/.workbench/config.json（0600，不进 repo）
- ⏭ 企微 CLI：官方/社区无包 → 自建（channels/wecom.py 封装）
- ⏭ Phase A 验收三判据：①三向导出导入实测回放（tests 已覆盖）②遗忘权审计报告（CLI audit 已通）③遗产模式干净房离线跑通（待做）
- ✅ **Phase A 验收三判据全部达成**（commit 28c2e83 已推送，ls-remote 真判据过）：
  - ③干净房抓到真缺陷——import_vault 不建 MANIFEST（测试盲区）；修复=导入后重算 build_manifest+roundtrip 补断言
  - scripts/heritage_cleanroom.py：全新 venv 离线装 wheel→CLI 造资产→heritage 产包→继承人 import 复活→HERITAGE-CLEANROOM-OK；全量 930 passed，ruff 0
- 🏁 **Phase A 收官**：主权层 MVP 完整落地（记忆/决策/画像/遗忘/审计/遗产/三向适配器/CLI 七动作）
- 🚧 Phase B WBS 细化完成（心跳轮）：B1 出口闸 done-token / B2 记忆自检三套统一入口 / B3 任务级进化代谢 / B4 金标准增长管线（origin+质量闸）/ B5 上下文预算+fresh-context（后置）/ B6 验收回放；地基盘点=金标准 40 条在 tests/fixtures、evolve/ 骨架、画像双时间线、audit_vault 遗忘合规
- 🏁 **Phase B 收官（B1-B6 全绿）**：
  - B1 出口闸：gate/exit.py ExitToken+validate（done=测试全绿+ruff+evidence 存在+status）+ CLI `--sovereign exit`（退出码=裁决）
  - B2 自检三套：gate/selfcheck.py（冲突不变量/vault 纯读结构回归+画像结构/坟回流）；重构 protocol.forget_violations 公共函数；夹具健康态补 MANIFEST
  - B3 任务级进化：evolve/task_mutation.py（propose 幂等→A/B→KEEP/DISCARD 末事件行语义，append-only）
  - B4 金标准管线：gate/golden_growth.py（origin 溯源+bigram/unigram max Jaccard≥0.70 拒稀释；拒收不入库）
  - B5 上下文预算：evolve/budget.py（无预算=无授权；超支→fresh-context 复盘候选→复盘闭环）
  - B6 验收：全量 **977 passed**（938+39），ruff 0；四判据达成（任务级进化闭环测试/管线可用/冲突回归绿/done-token 收口）
- 🏁 **Phase C 收官（C1-C6 全绿，control 包 24 测例）**：
  - C1 registry：动作法定清单（不在册=不可执行）；path 四级 read/write/spend/irreversible
  - C2 policy：风控式信任（read 放行/write 白名单/spend 限额累计/irreversible 恒 confirm/unknown 恒 deny）
  - C3 gateway：judge→执行→失败回滚→execution.jsonl 回放；无 handler=dry-run；**第三方复用判据达成**（子进程裸 import 网关 GATEWAY-REUSE-OK）
  - C4 meter：token/秒/元三维账本（append-only+聚合）
  - C5 approval：HMAC-SHA256 签名授权日志（密钥外部注入；篡改/换钥必验假）
  - C6 knob：METR 旋钮（无干预 4h 间隔翻倍，12h 封顶，单调）
  - 全量 **1001 passed**（977+24），ruff 0（首跑 1 例偶败未复现，两连绿）
- 🏁 **Phase D 收官（D1-D4 全绿，market 包+sidecar 25 测例）**：
  - D1 x402：HTTP 402 微结算语义（invoice 解析→支付处理器注入→带证明重放）；**免费期也全程计量**（402 即刻入账 meter）
  - D2 市场协议：publish=签名 skill card（HMAC+内容指纹）/install=验签+依赖白名单+版本缓存 skills-cache
  - D3 跨标准适配器：Anthropic 一键导入（导入即 eval：空壳拒收）/OpenClaw 导入补 version/→MCP manifest/→AGENTS.md
  - D4 IM 侧挂：/run /status /help→Gateway 执行→回执（待确认明确标注）；AstrBot 同协议可挂
  - 全量 **1026 passed**（1001+25），ruff 0；真钱微付费闭环留待用户配置支付处理器（协议+计量已就绪）
