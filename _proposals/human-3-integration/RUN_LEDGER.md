# RUN_LEDGER — Human-3.0 深度融合安装 (2026-10-04)

用户令: 「请把这个项目与本项目深度融合在一起：帮我安装 https://github.com/chengjialu8888/Human」

## 上游考证
| 项 | 结果 |
|---|---|
| 提供的 URL `chengjialu8888/Human` | **404**（API 实证）→ 列用户 21 仓定位实仓 `Human-3.0`（star 23, 更新 2026-10-02）|
| 网络通路 | 直连+7890 双死（代理节点级故障，按「只探测不动网」未动配置）；**gh-proxy.com 镜像 200 = 唯一通路**（ghfast.top/ghproxy.net 403, gitclone.com 502）|
| 克隆 | `--depth 50` → `E:\AI-Station\Human\`（vendor 缓存层，已入 .gitignore）|
| 本质 | Dan Koe HUMAN 3.0 四象限发展评估与教练框架，skill 形态（SKILL.md 主行为 + references/ 4 件知识层 + 跨会话记忆 + 飞书导出）|

## 安装（已验证）
- 位置: `C:\Users\91216\.claude\skills\human-3-development-assessor\`（用户级，与 self-profile 同级）
- **验证: 系统技能列表已出现 `human-3-development-assessor`，frontmatter 原样识别** ✅

## 三根深度接线（融合面）
1. **记忆层重定向**: `~/.codex/...`（上游 Codex 形态）→ `E:\AI-Station\SELF_PROFILE\human3\memory\`（画像中枢第三层，PII 隔离已在 gitignore）
2. **冷启动预填**: 首评前（经同意）预读 KWP-7 personality_analysis + dossier + 近期信号流融合 → 缩短基线访谈 + 提供非自陈行为证据（正是 HUMAN 3.0「戳穿假性转化」需要的弹药）
3. **飞书导出真通道**: 上游话术级「ask Feishu export」→ 接站内 `.agents/skills/lark-doc/lark-drive`（不可用时按上游降级规则）

交叉印证表（Mind↔D1 / 2.0→3.0↔D7 / Glitch↔D6 / Vocation↔D2 / Body↔D4）沉淀在 skill 内 `STATION_INTEGRATION.md`。

## 对上游的改动面（升级可 diff 重放）
- `SKILL.md` Overview 段: agent-agnostic 句 → 本安装形态说明 + 融合指针（+7 行）
- `references/session-memory.md`: 记忆路径段重写（+3 行）
- 新增 `STATION_INTEGRATION.md`（融合契约+KWP-7 对照+重取配方）
- 其余逐字节保留（输出契约 14 段/访谈协议/agents/openai.yaml）

## 文件清单
- 安装副本: skill 目录 8 件（SKILL.md + STATION_INTEGRATION.md + references/×4 + agents/×1 + memory/.gitkeep）
- 本台账 + `upstream_repo_probe_20261004.json`（404 考证证据，自仓库根移入）
- `E:\AI-Station\Human\`（.gitignore vendor 层，不入库）

## 用法
任意会话说「帮我做一次 HUMAN 3.0 发展评估」或「/human-3-development-assessor」即触发；中文访谈自动跟随用户语言。
