---
name: muse-wide-research
description: Trigger when a research or lookup task splits into many independent inputs (companies, people, topics, URLs) that must each return the same structured fields - fan out per-input workers under one manager and merge into a single normalized result set with coverage reporting.
github_url: https://github.com/win4r/MuseAI-Skills
github_hash: 38bbb45a2c5a0f70de975f6387385770b9ad8aac
version: 0.1.0
created_at: 2026-10-05
entry_point: SKILL.md
upstream_path: opt/hatch/skills/wide-research/SKILL.md
source_article: https://mp.weixin.qq.com/s/0KXzHwrw826IQ7DYiZ8lQg
---

# Wide Research（muse-wide-research）

> **来源与适配说明**
> - 来源：微信文章《Meta Muse的68个Skills全貌曝光》（https://mp.weixin.qq.com/s/0KXzHwrw826IQ7DYiZ8lQg）→ MuseAI-Skills 仓库 @ `38bbb45a2c5a0f70de975f6387385770b9ad8aac`（非官方快照，仓库地址 https://github.com/win4r/MuseAI-Skills）。
> - 原文完整位置：`E:/AI-Station/06 技能/library/MuseAI-Skills/opt/hatch/skills/wide-research/SKILL.md`（上游技能名 `wide_research`，共 45 行；该目录下无 references/ 等附属文件，SKILL.md 即全部内容，无删减）。
> - 本版是 Claude Code（E:/AI-Station）环境下的本地适配移植版：正文忠实保留上游英文内容与章节结构，仅对涉及 Muse 运行时的表述加注本地映射（以「本地注」标出），未增删任何上游规则。

## 本环境适配

上游为纯方法学技能，正文未直接调用任何外部命令或脚本；其隐式依托的 Muse 环境机制逐条列出如下，每条标注【Muse 环境专用】并给出本地映射或参考方式：

| 上游依赖 | 标注 | 本地映射 / 参考方式 |
|---|---|---|
| hatch_* CLI 工具族 | 【Muse 环境专用】 | 本技能上游正文未调用任何 hatch_* CLI，本地无需安装任何工具即可执行本方法学；如需考证 hatch CLI 形态，见 vendored 原件目录 `E:/AI-Station/06 技能/library/MuseAI-Skills/opt/hatch/`。 |
| /opt/hatch 安装路径 | 【Muse 环境专用】 | 上游技能部署于 Muse VM 的 `/opt/hatch/skills/wide-research/`；本地对应只读快照 `E:/AI-Station/06 技能/library/MuseAI-Skills/opt/hatch/skills/wide-research/`，运行本技能不依赖该路径（仅作原文参考）。 |
| Muse 连接器 OAuth | 【Muse 环境专用】 | 上游正文不涉及任何 Muse 连接器或 OAuth 授权；本地无对应物也不需要——研究输入由用户/会话直接提供，产出直接写回会话。 |
| Muse VM 沙箱机制 | 【Muse 环境专用】 | 上游运行在 Muse 虚机沙箱内；本地由 Claude Code 会话直接执行同等方法学，无 VM 层，注意遵守本机 Windows 不弹窗等运行纪律即可。 |
| manager/worker subagent 生成机制 | 【Muse 环境专用】 | manager subagent → Claude Code 的 Agent/Workflow 工具（并行 spawn 子代理）；worker → manager 内按输入逐条分派的子任务，本地即一次并行 Agent 调用矩阵或 Workflow 编排步骤。 |

## Purpose

Coordinate one manager subagent that fans out the same research task across many independent inputs and returns a single normalized result set.

> 本地注：在 Claude Code 中，"manager subagent" 由 Agent/Workflow 工具承担——主会话（或单一编排子代理）并行 spawn 多个 worker 子代理，每个 worker 处理一个输入。

## When to Use

- The task can be split into many independent subtasks (for example, one company/person/topic per input).
- Each subtask should return the same structured fields.
- The user asks for "wide research", "parallel research", or high-volume lookup/screening.

Do not use this workflow for single-item tasks or when subtasks depend on each other.

## Tooling

Use exactly one manager subagent for the overall operation.

Manager input contract:
- `operation_brief`: one concise sentence.
- `inputs`: one independent item per element.
- `output_schema`: required fields and allowed types.
- `worker_prompt_template`: per-input instructions.
- `completion_format`: exact JSON object shape for the manager's final response.

Manager output contract:
- `total`
- `success_count`
- `failure_count`
- `results`
- `failures`
- `notes`

> 本地注：以上两份契约原样适用于 Claude Code 的 Agent/Workflow 编排——把它们写进 spawn worker 时传入的提示词模板与最终汇总格式即可，无需任何专用脚本。

## Operating Rules

1. Deduplicate and normalize the input list before spawning the manager.
2. Keep the output schema minimal and explicit; avoid optional or free-form fields unless the user asked for them.
3. Use one manager coordinator for one user goal; do not fan out multiple sibling root-level subagents.
4. Instruct the manager to assign one worker per input and keep each worker scoped to its own item.
5. If completeness matters and some inputs fail, retry only the failed inputs, once, when feasible.
6. Reply to the user immediately that wide research has started; do not block on completion.
7. In the final user-facing output, always report coverage (`success_count/total`) and unresolved gaps.
