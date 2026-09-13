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
