---
name: muse-skill-creator
description: Use when creating, updating, or reviewing a skill — pin down the trigger-oriented description and frontmatter, split content across SKILL.md/references/assets/bin, and run the authoring review checklist before calling it done.
github_url: https://github.com/win4r/MuseAI-Skills
github_hash: 38bbb45a2c5a0f70de975f6387385770b9ad8aac
version: 0.1.0
created_at: 2026-10-05
entry_point: SKILL.md
upstream_path: opt/hatch/skills/skill-creator/SKILL.md
source_article: https://mp.weixin.qq.com/s/0KXzHwrw826IQ7DYiZ8lQg
---

> **来源与适配说明**
> - 来源：微信文章《Meta Muse的68个Skills全貌曝光》→ MuseAI-Skills 仓库（github.com/win4r/MuseAI-Skills）@ `38bbb45` 的非官方快照。
> - 原文完整位置：`E:/AI-Station/06 技能/library/MuseAI-Skills/opt/hatch/skills/skill-creator/`（含 `SKILL.md` 与 `references/authoring_guide.md`，下称 vendored 原件）。
> - 本版是本地适配移植版：忠实保留上游内容结构与实质（英文正文保持英文），仅把依赖 Muse 运行时、会误导本机执行的指令改为参考式表述并以【Muse 环境专用】标注。
> - 定位：与本项目 `github-to-skills` 工厂（把外部 GitHub 仓库移植成本地技能，管"搬得对"）互补——本技能管"写得好"：触发条件、目录拆分、交付前检查清单。

## 本环境适配

上游依赖 Muse VM / hatch 运行时，以下条目在本机不可直接执行，逐条给出本地映射：

- 【Muse 环境专用】`~/workspace/skills/<name>/`（Muse 工作区技能路径）→ 本地映射：项目技能 `E:/AI-Station/.claude/skills/<name>/`，用户级技能 `~/.claude/skills/<name>/`。
- 【Muse 环境专用】`/opt/hatch/skills/skill-creator/bin/scaffold-connector-skill --provider <provider>`（连接器技能脚手架）→ 本机无此二进制，且 vendored 快照本身也未收录 `bin/`（快照仅 `SKILL.md` + `references/`）。参考方式：按其思路手写 `Tooling`/`Auth` 章节（写清用哪个 helper、凭据注入到哪、允许哪些 host、失效怎么换）。
- 【Muse 环境专用】`credentials.request_api_access`（authd 连接器凭据申请工具，Muse 专属 API）→ 本机无 authd；凭据获取/存放走本项目既有纪律（`data/secrets/`、keyring 等，账号安全红线照旧），不走本节流程。
- 【Muse 环境专用】连接器 OAuth / authd 守护进程（Connector Credentials 一节的整体前提）→ 本机仅作方法论参考：凭据注入交给 helper 而非 prompt 文本；401/403 先查凭据是否真的随请求附带。
- 【Muse 环境专用】frontmatter 字段 `metadata: { "includeInPrompt": true }` → Claude Code 不识别该字段；本机使用 YAML `name`/`description` 等标准字段。
- 【Muse 环境专用】authoring guide 中 "Jarvis bundled skills" 与其 `bin/` helper 惯例 → 本机对应技能目录内 helper 脚本；"能进 helper 的协议/凭据/解析逻辑不留在 prompt 文本"这条规则照用。
- 【Muse 环境专用】`python3 -m py_compile ~/workspace/skills/<skill-name>/bin/*.py`（路径为 Muse 工作区）→ `py_compile` 是通用 Python 能力，本机等价：`python -m py_compile "E:/AI-Station/.claude/skills/<name>/bin/"*.py`（对应用户级路径同理）。

---

# Skill Creator（以下为移植正文）

## Purpose

Create or update a skill that is easy to trigger, concise to load, and backed by references or helper code only when they materially improve reliability.

## Workflow

1. Clarify the capability, likely trigger phrases, and the target skill path (upstream: `~/workspace/skills/<name>/`；本地：`E:/AI-Station/.claude/skills/<name>/`).
2. Choose a narrow scope. Prefer one clear job per skill. Split unrelated jobs into separate skills.
3. Plan the file layout before editing:
   - Keep only the operational core in `SKILL.md`.
   - Put bulky docs, examples, schemas, or tutorials in `references/`.
   - Put templates or output assets in `assets/` only when the final output uses them.
   - Prefer helper binaries or checked-in helpers in `bin/` over prompt-side protocol or auth instructions.
4. Draft or update frontmatter. Required: `name`, `description`.
5. Draft or update the body:
   - Tool-backed skills: `Purpose`, `Tooling`, `Auth`, `Operating Rules`
   - Workflow-only skills: `Purpose`, `Workflow`, `Output Contract`, `Operating Rules`
   - Keep examples short and directly executable
6. Trim aggressively. Remove long API docs, schema dumps, and setup essays from `SKILL.md`. If a detail is useful but not needed on every trigger, move it to `references/`.
7. Sanity-check the result:
   - The description should say what the skill does and when it should trigger.
   - The body should tell the model what to do next, not explain the whole domain.
   - Commands, paths, and auth flows must match real repo/runtime behavior.

## Connector Credentials

> 【Muse 环境专用】本节前提是 Muse VM 的 authd 连接器机制，本机不可执行；保留正文以存其形，可迁移的诊断原则已就地标注。

Collecting a provider's credential is `credentials.request_api_access`, not a file you write. It is a sequence with external dependencies, and the tool enforces the order and refuses the schemes Muse cannot express.（本地参考：凭据不是手写的文件——获取与存放走本机 secrets 纪律。）

Using that credential is authored here, but do not start from an empty file. Once the connector is connected, scaffold it:

```
/opt/hatch/skills/skill-creator/bin/scaffold-connector-skill --provider <provider>
```

【Muse 环境专用】上式本机不可执行（见「本环境适配」）。参考其产出契约：脚手架生成的 `SKILL.md` 中，`Tooling` 与 `Auth` 两节直接写清 credential mechanics——which helper to import, where the value goes, which hosts are allowed, and how to replace a credential that stops working；本机手写这两节时照此清单核对。

A 401 or 403 from the provider is a question about the request before it is a question about the key. Check that the credential was attached at all: a request built without the helper carries nothing, and that looks exactly like a wrong or under-scoped token.（此条为通用诊断原则，本机直接适用。）

## Operating Rules

1. Preserve working commands and repo conventions; do not invent binaries, paths, or auth flows.
2. Prefer minimal frontmatter and on-demand loading. Only add metadata the skill actually needs.
3. Give auth its own section instead of burying it in operating rules.
4. Use existing setup/auth helpers when they exist. Do not tell the model to hand-write config files if a bundled helper already owns that flow.
5. Create `references/` only when it materially shortens `SKILL.md`; avoid duplicating the same guidance in both places.
6. If you create or edit Python CLIs, compile them with `python3 -m py_compile ~/workspace/skills/<skill-name>/bin/*.py` before reporting success.（本地路径换成 `E:/AI-Station/.claude/skills/<name>/` 下的对应 helper 目录。）

## Authoring Guide

（自 vendored 原件 `references/authoring_guide.md` 内联精简，未逐字收录——完整版见 vendored 原件：`E:/AI-Station/06 技能/library/MuseAI-Skills/opt/hatch/skills/skill-creator/references/authoring_guide.md`）

### Naming

- Directory name: `kebab-case`
- Frontmatter `name`: `snake_case`【Muse 惯例】Claude Code 本机惯例为 `name` 与目录同名 kebab-case（本技能即 `muse-skill-creator`）。
- Keep names short, concrete, and capability-based.
- Namespace by provider or domain when it improves trigger clarity, for example `google-calendar` or `outlook-calendar`.

### Resource Split

Choose the smallest structure that carries the skill reliably.

- Keep instructions in `SKILL.md` when they are short, stable, and required on every trigger.
- Use `references/` when the detail is useful but conditional: long examples, schemas, variant-specific notes, or extended workflows.
- Use `assets/` only for files that become part of the delivered output.
- Prefer `bin/` helpers for repeated protocol, credential, or parsing work. Do not leave those mechanics in prompt text if a helper can own them.（上游此句针对 Jarvis bundled skills，本机适用于任何技能内 helper。）

### Frontmatter Template

```yaml
---
name: "my_skill"
description: "One-line description of what the skill does and when to use it."
---
```

Notes:
- `name` and `description` are the core trigger surface.
- Bundled skills should usually not set `metadata.includeInPrompt`.【Muse 环境专用】该字段 Claude Code 不使用，本机模板即上面两行。

### Body Templates

Tool-backed skill:

```markdown
# Skill Title

## Purpose
One line.

## Tooling
Exact commands, key flags, and the response fields the model should parse.

## Auth
Where auth lives, what setup to do first, and what not to print.

## Operating Rules
Short numbered constraints the tool itself does not enforce.
```

Workflow-only skill:

```markdown
# Skill Title

## Purpose
One line.

## Workflow
Ordered steps for the agent.

## Output Contract
What the final result should contain.

## Operating Rules
Short numbered constraints.
```

### What to Move Out of `SKILL.md`

- Long API endpoint catalogs
- Full response schema dumps
- Repeated auth/token extraction snippets
- Lengthy tutorials or background essays
- Large blocks of variant-specific guidance that only apply sometimes

Move that material to `references/` and link it from the relevant section in `SKILL.md`.

### Review Checklist

- Does the description clearly state both capability and trigger context?
- Is the skill scoped to one coherent job?
- Does `SKILL.md` tell the model what to do next, instead of teaching the whole subject?
- Are commands and paths real for this repo/runtime?
- Are auth expectations explicit when needed?
- Did you remove `includeInPrompt` unless there is a strong reason to keep it?【Muse 环境专用】本机改问：是否只保留 Claude Code 实际使用的 frontmatter 字段？
- If the skill uses helpers, does the prompt rely on them instead of duplicating their work?
