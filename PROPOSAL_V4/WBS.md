# WBS — Phase A 主权层 MVP（任务级·TDD 先行）

- 立项：2026-09-13（用户批准）；对应 VISION_V4 P0 / GAP G1+G4
- 验收（10× 判据，对齐 PROPOSAL_V4）：①三向导出导入实测回放
  ②遗忘权审计报告（双时态可验「已忘且何时忘」）③遗产模式干净房离线跑通。

## V3 资产盘点（Phase A 的地基，实测 2026-09-13）

| 资产 | 现状 | Phase A 动作 |
|------|------|-------------|
| 画像五层 | `profile/model.py` JSONL+双时间线（effective_from/to）已是双时态语义 | 只读渲染进 vault；forget 复用封口机制 |
| 记忆 | `memory/store.py` SQLite FTS5=文档索引（非主权资产） | 新建 markdown 记忆库（人机双读），索引层不动 |
| 技能 | `data/skills/<name>/SKILL.md`（frontmatter name/description，五层安全扫描） | 账本化（skills-ledger.jsonl）+导出适配 |
| 决策记忆 | `learn/whys.py` 空壳 | 全新建 DecisionLedger |
| 审计 | `data/audit.db` + `security/audit.py` | 遗忘/导出动作写审计 |
| 台账纪律 | 871 tests / ruff 0 / cleanroom 样板 | 全程沿用 |

## 新包 `src/paistation/sovereign/`（200-400 行/文件）

```
sovereign/
  format.py      # 规范核心：SOVEREIGN_SPEC_VERSION、vault 布局、MANIFEST 指纹、vault_validate
  vault.py       # MemoryVault（remember/search/render）+ DecisionLedger（decide/supersede/review）
  protocol.py    # 四命令：export_vault / import_vault / forget / audit_vault
  heritage.py    # heritage_bundle：全量导出+OFFLINE.md 离线功能清单+HEIRLOOM.md 继承指定
  adapters/
    claude_code.py   # → CLAUDE.md + memory/*.md
    openclaw.py      # → skills/（SKILL.md 兼容复制）+ AGENTS.md
    astrbot.py       # → persona_prompt.md + memories.md
```

vault 目录（`data/sovereign/`，git-friendly、单文件可 diff）：
```
MANIFEST.json            # 文件清单+sha256 指纹+spec 版本
memory.md                # 记忆库（append-only 时间线，人机双读）
decisions/DEC-*.md       # 决策记忆：决策/被否方案(为何否)/理由/复盘回填
profile.md               # 画像五层渲染视图（生成物）
skills-ledger.jsonl      # 技能账本
reputation.jsonl         # 声誉档案（A 期留 schema）
forgotten.jsonl          # 遗忘日志（何时/何物/谁授权）——只增不删
```

## 任务切片（tracer-bullet，每片红→绿→回归）

| # | 任务 | 测试 | 要点 |
|---|------|------|------|
| A1 | format.py+vault.py | test_sovereign_vault.py | 决策记忆含**被否方案**（obra 语义）；supersede 链；review 复盘回填；memory append-only；MANIFEST 指纹校验 |
| A2 | protocol.py 四命令 | test_sovereign_protocol.py | export 幂等；import roundtrip 无损+可从 Claude Code memory 目录导入；forget=封口+forgotten.jsonl+审计（物理不删，R 只增不删）；audit 报告：可证伪性/遗忘合规/指纹完整性 |
| A3 | heritage.py | test_sovereign_heritage.py | bundle 含 OFFLINE.md（本地可用 vs 云依赖分列）+HEIRLOOM.md；离线可读可复活 |
| A4 | adapters×3 | test_sovereign_adapters.py | 三向产物结构自检；Claude Code 产物可直接落 `.claude/`；OpenClaw 产物含 skills 结构；AstrBot 产物含 persona |
| A5 | CLI 集成 | test_sovereign_cli.py | `pai sovereign <export|import|audit|forget|heritage|decide|remember>`（对齐 organ 注册模式） |
| A6 | 验收回放 | 全量回归+ruff+cleanroom | 10× 三判据逐条打勾，RUN_LEDGER 记录 |

## 纪律

- 红测试先行→最小实现绿→全量回归（exit 0）→ ruff（项目范围 0）→ commit（带 Co-Authored-By）
- 网络零依赖（Phase A 全本地）；不弹窗（CREATE_NO_WINDOW 铁律）；密钥零接触
