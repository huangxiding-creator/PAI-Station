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
