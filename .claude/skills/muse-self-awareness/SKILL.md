---
name: muse-self-awareness
description: Ground self-referential answers in this Claude Code agent's actual filesystem - skills, memory, config, and workspace state. Use when the user asks who the agent is, what it can do, what it knows or remembers, what it has built, which services or channels are connected, or what rules it follows.
github_url: https://github.com/win4r/MuseAI-Skills
github_hash: 38bbb45a2c5a0f70de975f6387385770b9ad8aac
version: 0.1.0
created_at: 2026-10-05
entry_point: SKILL.md
upstream_path: opt/hatch/skills/self-awareness/SKILL.md
source_article: https://mp.weixin.qq.com/s/0KXzHwrw826IQ7DYiZ8lQg
---

# Self-Awareness

> **来源与适配说明**
> 本技能移植自微信文章《Meta Muse的68个Skills全貌曝光》所披露的 MuseAI-Skills 仓库快照（GitHub win4r/MuseAI-Skills@38bbb45，非官方快照）中的 `opt/hatch/skills/self-awareness/`。
> 原文完整位置（vendored 原件，含 `references/` 两份附件，均未删改）：`E:/AI-Station/06 技能/library/MuseAI-Skills/opt/hatch/skills/self-awareness/`。
> 本版是**本地适配移植版**：上游为 Muse VM（hatch 环境）设计，此处把"自指问题锚定在 agent 实际文件系统事实上"的方法适配为 Claude Code（本仓库 E:/AI-Station，Windows + Git Bash）下检查自身技能/记忆/配置的通用方法。

## 本环境适配

上游依赖逐条对照（标注【Muse 环境专用】者为上游特有，本机不可直接执行）：

1. 【Muse 环境专用】hatch VM 工具面（上游 Tooling 节的 `read`/`exec` 探针在 hatch 运行时内执行）→ 本地映射：Claude Code 内建 Read / Glob / Grep / Bash 工具；Bash 为 Git Bash（POSIX 语法、正斜杠路径）。
2. 【Muse 环境专用】`/opt/hatch/skills/` 与 `~/workspace/skills/`（Muse 技能安装位）→ 本地映射：项目技能 `E:/AI-Station/.claude/skills/`，用户级技能 `~/.claude/skills/`（两者均实测在位）。
3. 【Muse 环境专用】Muse 连接器 OAuth（上游 extensions.md 的"连接建议"以连接器已连接态为证据源）→ 本地映射：本机"已连接服务"对应 auto-memory 中各渠道条目（weread / djyanbao / metaso / lark 等）与 `data/secrets/` 凭据（红线：只登记存在性，不解密、不代登）。"连接发现"问题改写为对已注册技能/渠道账本的缺口盘点。
4. 【Muse 环境专用】Muse VM 主目录身份文件（`~/IDENTITY.md ~/SOUL.md ~/AGENTS.md ~/TOOLS.md ~/USER.md ~/MEMORY.md ~/TOMM.md`）、`~/memory/*.md` 与 `~/workspace/` 产物 → 本地映射：`CLAUDE.md`（项目/用户两级，本机当前均缺失，按规则 2 如实报告）、`~/.claude/rules/*.md`（全局规则，在位）、auto-memory `~/.claude/projects/<project-slug>/memory/MEMORY.md`（本项目 slug 为 `e--AI-Station`，在位）、`E:/AI-Station/SELF_PROFILE/`（静态自画像语料）、工作区产物即 `E:/AI-Station/` 各子目录。
5. 【Muse 环境专用】上游 frontmatter 键 `metadata: { "includeInPrompt": false }`（Muse 加载器语义）→ 本地映射：Claude Code 按 description 触发加载，无此键语义，已略去。

## Purpose

Answer self-referential questions from observed files and workspace state, not guesses or training-memory.

## Tooling

Use the Read, Glob, Grep, or Bash tools to inspect the current environment before answering.

Local probes (this machine, Git Bash; tolerant of missing files — report gaps honestly per rule 2):

```bash
# identity & operating rules
cat "E:/AI-Station/CLAUDE.md" ~/.claude/CLAUDE.md 2>/dev/null
cat ~/.claude/rules/*.md 2>/dev/null
# memory (auto-memory is per-project-slug)
cat ~/.claude/projects/e--AI-Station/memory/MEMORY.md 2>/dev/null
ls ~/.claude/projects/*/memory/ 2>/dev/null
# skills (project + user level)
ls "E:/AI-Station/.claude/skills/" ~/.claude/skills/ 2>/dev/null
# settings & permissions
cat ~/.claude/settings.json 2>/dev/null
# built artifacts & self profile
ls "E:/AI-Station/SELF_PROFILE/" 2>/dev/null
find "E:/AI-Station" -maxdepth 2 -type d 2>/dev/null | head -40
```

Upstream probes, kept verbatim for reference only — 【Muse 环境专用】these paths do not exist on this machine, do not run them as-is:

```bash
cat ~/IDENTITY.md ~/SOUL.md ~/AGENTS.md ~/TOOLS.md 2>/dev/null
cat ~/USER.md ~/MEMORY.md ~/TOMM.md 2>/dev/null
ls ~/memory/*.md 2>/dev/null
ls /opt/hatch/skills/ ~/workspace/skills/ 2>/dev/null
find ~/workspace/ -maxdepth 3 -type f \( -name "*.html" -o -name "*.md" -o -name "*.json" \) 2>/dev/null
```

Read the vendored original [references/question_types.md](../../../06%20技能/library/MuseAI-Skills/opt/hatch/skills/self-awareness/references/question_types.md) (`E:/AI-Station/06 技能/library/MuseAI-Skills/opt/hatch/skills/self-awareness/references/question_types.md`) when the user asks a specific self-awareness question and you need the exact traversal for that question type.

Read the vendored original [references/extensions.md](../../../06%20技能/library/MuseAI-Skills/opt/hatch/skills/self-awareness/references/extensions.md) (`E:/AI-Station/06 技能/library/MuseAI-Skills/opt/hatch/skills/self-awareness/references/extensions.md`) only when the user explicitly wants connection recommendations or an optional self-awareness dashboard.

## Question Types (condensed)

Condensed from the vendored `references/question_types.md`; full traversal lists see the vendored original. Shared framing: read the smallest relevant set of files first, organize around the user's life and current work, cite concrete file paths, call out uncertainty instead of guessing.

1. **Capabilities** ("what can you do?" / "what are you connected to?") — inspect rules files, auto-memory, both skills directories, built artifacts. Group by the user's domains or projects; distinguish active/connected capability from merely available capability.
2. **Connection discovery** ("what should I connect?") — inspect the same sources plus channel/memory entries evidencing connected state. Rank highest-impact gaps first; keep the list short unless the user wants everything.
3. **Identity** ("who are you?") — inspect identity-ish files (rules, SELF_PROFILE, memory). Answer in character but ground claims in files; mention where core traits come from.
4. **User knowledge** ("what do you know about me?") — inspect SELF_PROFILE and memory. Separate stable profile facts from recent observations; flag anything possibly outdated.
5. **Memory** ("what do you remember about X?") — inspect curated auto-memory (MEMORY.md index) first, then per-topic memory files. Distinguish curated memory from raw logs; be honest about gaps.
6. **Built items** ("what have you built?") — inspect workspace directories (e.g. `E:/AI-Station/` subprojects, skills authored) and memory for project history. For each item: what it does, and whether it looks current or stale.
7. **Rules** ("what are your rules?") — inspect `~/.claude/rules/*.md`, settings.json hooks/permissions, project CLAUDE.md if present. Separate platform rules from self-imposed style rules; keep it readable, not legalistic.

Optional extensions (from vendored `references/extensions.md`): connection recommendations compare connected capabilities with available skills and prioritize the top 3 gaps with why-it-matters and setup effort; an optional dashboard/inventory stays grounded in observed data with explicit active/available/unknown status. Never produce either unprompted.

## Operating Rules

1. Re-read the relevant files every time. Never answer from cached assumptions.
2. If a file or directory is missing, say that directly instead of filling the gap.
3. Organize capability answers around the user's life domains and active projects, not a flat tool list.
4. Separate observed facts from inference. Cite file paths when it helps the user trust the answer.
5. Be explicit about stale or partial evidence, especially for memory, connected services, or built items.
6. Stay within the scope of the question. Do not append skill ideas, connection advice, or dashboards unless the user asked for them.
