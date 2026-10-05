---
name: muse-forget
description: Remove a personal fact, preference, relationship detail, topic, or prior event from persistent memory and stop existing copies, derived indexes, or background jobs from bringing it back; use for explicit requests such as "forget that", "don't remember this about me", or "remove that from your memory"; do not use when "forget it" merely means cancel the current task.
github_url: https://github.com/win4r/MuseAI-Skills
github_hash: 38bbb45a2c5a0f70de975f6387385770b9ad8aac
version: 0.1.0
created_at: 2026-10-05
entry_point: SKILL.md
upstream_path: opt/hatch/skills/forget/SKILL.md
source_article: https://mp.weixin.qq.com/s/0KXzHwrw826IQ7DYiZ8lQg
---

> **来源与适配说明**
> 本技能移植自微信文章《Meta Muse的68个Skills全貌曝光》所梳理的 MuseAI-Skills 仓库（GitHub win4r/MuseAI-Skills@38bbb45a2c5a0f70de975f6387385770b9ad8aac，非官方快照）中的 forget 技能。
> 原文完整位置：`E:/AI-Station/06 技能/library/MuseAI-Skills/opt/hatch/skills/forget/`（含 `SKILL.md` 与 `references/artifact-inventory.md`）。
> 本版是本地适配移植版：忠实保留上游章节结构与实质规则；仅对依赖 Muse 运行时的指令改为参考式表述并加【Muse 环境专用】标注与本地映射；未发明本机不存在的命令，未虚构功能。

## 本环境适配

上游依赖 Muse 运行时（hatch 工具调用、`/opt/hatch` 安装路径、连接器 OAuth、VM 机制）。逐条标注与本地映射：

1. **hatch 工具调用 `forget.plan` / `forget.confirm`**（技能安装于 `/opt/hatch/skills/forget/`，由 hatch 工具目录起子代理）——【Muse 环境专用】。本地映射：用 Claude Code 的 Agent/Workflow 工具两段式落地——先起一个普通 planner 子代理做只读盘点，经用户明确确认后再起 executor 子代理执行；本机不存在 `forget.*` 命令，不得直接调用。
2. **模型钉扎与机密 VM（muse-special / 私有 Avocado on a confidential VM）**——【Muse 环境专用】。本地映射：Claude Code 子代理运行在本会话模型与权限体系内，无独立 VM；"不在工具参数中重复敏感文本"的纪律照常适用。
3. **Muse 记忆文件系统（`~/MEMORY.md`、`~/memory/**`、`~/memory/shopping/PROFILE.md`、`~/workspace/memory/forget/pending.json`）**——【Muse 环境专用】。本地映射：本项目持久记忆为 Claude Code 自动记忆目录 `C:/Users/91216/.claude/projects/e--AI-Station/memory/`（MEMORY.md 及各专题 md）与项目内文件（如 `E:/AI-Station/SELF_PROFILE/`）；上游路径本机不存在，正文中相关指令按参考式处理。
4. **`memory_explain` / `memory_search` / claim spine / PostgreSQL 索引与向量**——【Muse 环境专用】。本地映射：无对应 API；检索与验证改用 Read/Grep 从新鲜状态重读记忆目录与相关文件。
5. **运行时回收（claims 回撤 + memory search 重建索引）**——【Muse 环境专用】。本地映射：无运行时回收器；等价纪律是人工逐一改写派生物（摘要、索引、快照、账本）后再复核。
6. **Muse 连接器 OAuth（邮件/日历/联系人/设备等外部源）**——【Muse 环境专用】。本地映射：本机外部渠道是各自独立的 CLI/skill（企微、飞书、QQ 邮箱等）；动它们属外部动作，须单独请示，不在本技能授权范围。
7. **Muse 运行时"确认即排除"控制与 48 小时跟进选择器**——【Muse 环境专用】。本地映射：无该选择器；本机最接近的"复活源"是 schtasks 定时任务、守护脚本与后台 agent，盘点时按上游清单第 5 节思路检查。
8. **`references/artifact-inventory.md`（九节清点清单）**——非 Muse 专属附件，vendored 原件可直接读：`E:/AI-Station/06 技能/library/MuseAI-Skills/opt/hatch/skills/forget/references/artifact-inventory.md`；本文仅保留其章节骨架摘要。

---

# Forget

[本地注：以下为移植正文，英文保持英文。未标注处均为上游原文；"Muse"字样在本机语境读作"本会话助手与本项目持久面"。]

Treat forgetting as cleanup across Muse, not as editing one memory note.
Information may also live in conversation history, other notes, preferences,
goals, scheduled work, created items, search results, or active work that can
write it back.

Use everyday language with the user and do not expose internal machinery. Say
"memory," "reminders," "created items," "shared items," "logs," or "backups"
instead of file names, database tables, indexes, projections, telemetry
systems, tool names, agent types, or runtime machinery. Keep exact locators and
technical details inside the private work. Get technical only when the user
does or when they explicitly ask how the cleanup works.

## Make a plan

Call `forget.plan` once with `{}`. 【Muse 环境专用——本地映射：用 Agent/Workflow 工具一次性起一个普通 planner 子代理替代。】
It starts an ordinary untyped subagent with
the normal tool catalog that derives the subject from the current conversation,
so do not repeat sensitive text in tool arguments. Wait for its handoff instead
of polling or doing a parallel search. Muse pins this child to muse-special, or
to private Avocado on a confidential VM, independently of the active model
selection. 【Muse 环境专用——本地无 VM/模型钉扎，仅作参考。】

The planner reads
`E:/AI-Station/06 技能/library/MuseAI-Skills/opt/hatch/skills/forget/references/artifact-inventory.md`
(vendored 原件), stays read-only, and checks:

- original places and copies with the same meaning;
- memory, search results, conversation context, and summaries made from it;
- reminders, scheduled or active work, and outside sources that can recreate
  the information;
- shared or published copies and anything Muse cannot erase.

Vendored 清单九节骨架摘要（完整版见 vendored 原件 `references/artifact-inventory.md`，此处删减的只是各节的示例枚举，规则全保留）:

1. **Conversation and live execution** — current and prior events, compaction
   summaries, subagent histories, tool calls and outputs, restart checkpoints,
   transcript-derived previews, attachments, pending handoffs, and active
   RuntimeWork that may still hold or act on the information. The visible chat
   itself is not a cleanup target or a completion blocker.
2. **Source files and standing context** — `~/MEMORY.md` and dated logs under
   `~/memory/`, personalization, persona/identity/goal files, people and group
   pages, standing instruction files, workspace attachments. Recoverable
   trash, temp/editor-backup files, exports, and version-control history are
   not erased by removing the working copy.
3. **Memory retrieval and derived projections** — search-document and
   embedding indexes, the claim spine, compact projections, prompt-context
   caches, centrally published embeddings. Deleting text without reconciling
   derived retrieval surfaces leaves active copies.
4. **Self-improvement outputs** — finished and in-flight runs whose evidence
   window included the subject: memory claims and run state, relationships
   records, alignment/dream artifacts, goals bookkeeping, shopping-profile
   runs, studying plans, ideas and cards, skill improvements, follow-up
   attempts, publication outboxes. A staging artifact can reapply a removed
   projection.
5. **Goals, schedules, and future producers** — goals and tracking items, cron
   definitions and bodies, reminders, heartbeat instructions, hooks, workflow
   definitions and saved runs, pending outbox/notification payloads, admitted
   workers. Quiesce an in-flight writer before editing; disable or cancel an
   approved producer before cleaning its output.
6. **Artifacts and sharing** — file/web artifacts and their records, media,
   exports, shares, feed/podcast objects. Local removal does not revoke a
   shared URL or retract a message; external revocation is a distinct action
   needing separate approval.
7. **Connected and cached sources** — external accounts, browser sessions and
   caches, ingest records. The forget request does not by itself authorize
   changing the source service; an unchanged connected item that could be
   re-ingested needs a source-scoped exclusion or an explicit limitation.
8. **Operational and retained copies** — telemetry, journald, database WAL,
   snapshots, backups, service copies. State per class whether deleted,
   replaced, excluded from active use, or retained; never claim physical
   erasure of backups or telemetry without authoritative confirmation.
9. **Verification closure** — six criteria: (1) no approved authoritative
   source remains available; (2) exact and semantic retrieval no longer return
   a usable copy; (3) standing prompt context, new summaries, flushes, and
   checkpoints do not restate it; (4) no active, staged, queued, or scheduled
   producer can recreate it; (5) approved artifacts and shares have the
   requested disposition; (6) remaining external or retention-controlled
   copies are explicitly reported. A check that reintroduces the sensitive
   text into a normal chat, memory entry, todo, filename, or report is itself
   a failure.

It returns a concise plan covering what it found, what should change, how it
will verify the cleanup, and known limits. Keep the handoff discreet; refer to
"that information" instead of copying it into a new memory, todo, filename, or
report. Use conversations privately to find downstream copies and future
activity, but do not present the continued visibility or retention of the chat
itself as a cleanup limit.

## Ask, then execute

Show the user the plan's scope, irreversible actions, and important limits,
translated into the everyday categories above, then ask one direct confirmation
question. Silence, ambiguity, partial approval, or a changed scope is not
confirmation.

After a later clear approval, call `forget.confirm` with `{}`. 【Muse 环境专用——本地映射：确认后另起一个新的 executor 子代理，从继承的会话上下文读最新计划与确认。】
It starts a fresh
ordinary untyped subagent with the same model policy and reads the latest plan
and confirmation from the inherited conversation. There is no planning-agent
id to preserve or pass.

The executor must stop without mutation if it cannot identify one clear recent
plan and its approval. Otherwise it revalidates current state, stops approved
work before removing its outputs, uses the tools that own each item, preserves
unrelated content, refreshes anything derived from what changed, and verifies
from fresh state. For shopping preferences, check `~/memory/shopping/PROFILE.md`
directly, edit or remove matching entries, and verify no staged, queued,
running, or scheduled shopping-profile run can restore them. 【Muse 环境专用——本地无购物画像文件；规则的一般形式仍适用：直接编辑持久画像文件，并证明没有排队/在跑/定时的写入者能把它写回。】
If the
situation has materially changed or there is no safe way to clean up one
place, make a revised plan instead of broadening the cleanup.

Do not send approved cleanup targets to recoverable trash. For an exact local
file that should disappear entirely, use `rm -- <exact-path>` through the
shell（本机即 Bash 工具）; never use `rm -r` or another recursive shell deletion. Revalidate
the path immediately before removal, never use a glob or a broad target, and
edit mixed-content files instead of deleting them. Clean up directories through
the product action that owns them; if there is no safe owning action, make a
revised plan. If an owning product action archives a definition in trash as
part of its cleanup, permanently remove an exact matching standalone-file
tombstone. The plan must describe permanent removal as irreversible before the
user approves it.

Before finishing, the executor stages what it removed from memory so the
runtime can retract the matching memory claims and everything derived from
them: it writes `~/workspace/memory/forget/pending.json` as
`{"claims":[...],"citations":[...]}`, listing the claim ids it saw in
`memory_explain` or `memory_search` metadata and the exact `MEMORY.md#L<line>`
or `memory/<date>.md#L<line>` locators it removed or rewrote. Ids and locators
only, never the forgotten text; the file is written even when both lists are
empty. 【Muse 环境专用——本地无 claims 运行时与该暂存文件；等价纪律：在私有计划里记录"改了哪些文件哪些行"（仅定位符，不含被遗忘文本）。】

After the executor finishes successfully, Muse retracts the staged claims and
refreshes memory search, and waits for both before relaying the result. 【Muse 环境专用——本地映射：executor 自己用 Read/Grep 从新鲜状态复核全部受影响位置，作为"回收+重建索引"的人工等价。】
If the refresh fails, report
the cleanup as incomplete instead of claiming the information is no longer
searchable. Perform the cleanup directly in this executor rather than
delegating it to another subagent. If delegated work is still settling when the
executor finishes, Muse reports the cleanup as incomplete so later changes
cannot outrun the refresh. The executor should still verify the other affected
places; it does not need to refresh memory search a second time.

If either tool fails, do not fall back to unplanned manual deletion or claim
success. 【Muse 环境专用"tool"——本地读作两段式子代理流程任一环节失败。】
Explain the failure and
make a new plan if the user still wants to continue.

## Report honestly

Tell the user which categories were cleaned up, which reminders or other future
activity were stopped, and what remains. Do not repeat the forgotten
information.

Say "forgotten" only when fresh verification finds no active memory, derived
copy, or future activity that can bring the information back. Outside services,
shared or published items, logs, backups, or other retained copies may remain;
name the everyday category and whether Muse can keep it out of active use.

Do not tell the user that their original messages may remain visible in the
chat, and do not frame that as something Muse failed to erase. Visible
conversation text is not a cleanup target or a completion blocker. Inspect it
privately only to find and clean up memory, derived material, or future activity
that used it.

The request does not authorize deleting outside email, calendar data, device
records, shared publications, or another person's copy. Those actions need
their own user approval.
