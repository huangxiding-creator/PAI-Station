# V3 增量调研计划（research-orchestrator）

> 2026-09-13 ｜ 底座：V2 RESEARCH_DOCKET（350 仓库 + 器官缝合图）｜ 产出地：`RESEARCH_DOCKET/v3/`
> 硬纪律（用户明令）：**每个环节调研项目 ≥20 个**，真实 URL、不编造、站在巨人肩膀、为缝合服务。

## 九大调研环节

| # | 环节 | 目标问题 | 输出目录 |
|---|---|---|---|
| 1 | 国产办公 AI 对标 | 确证"5克巴迪"（音近匹配腾讯系产品）；腾讯 ima/飞书/钉钉/WPS 等能力矩阵（主动性/感知/记忆/执行/进化/价格）→ 找 100× 差量维度；海外对标（M365 Copilot/Gemini Workspace/Limitless） | `v3/01-benchmark-cn-office-ai/` |
| 2 | 无限上下文/记忆 | "硬盘即记忆"最佳架构：向量/关键词/图谱/混合检索；Letta/mem0/Zep/cognee/LightRAG/HippoRAG 等 vs V2 已录 OpenViking；Windows 本地索引（Everything/Windows Search） | `v3/02-infinite-context-memory/` |
| 3 | 语音/环境声感知 | 笔记本 CPU 24/7 常开监听可行性：流式 ASR（SenseVoice/FunASR/sherpa-onnx/whisper.cpp/RealtimeSTT）、唤醒词（openWakeWord）、VAD（silero）、说话人分离（3D-Speaker）、环境声事件（YAMNet/PANNs） | `v3/03-voice-ambient-sensing/` |
| 4 | 主动任务发现 | 环境音/会议/打字 → 待办发现的现成方案：screenpipe 后继、Rewind/Limitless、MSFT Recall 隐私教训、Otter action items、process/task mining、agent inbox 触发模式（cron/文件监视/webhook） | `v3/04-proactive-task-discovery/` |
| 5 | 24/7 Windows 常驻 | 托盘/服务/看护：pystray、NSSM、schtasks（已有实操）、WASAPI 环回采集（pyaudiowpatch）、防休眠、绿色便携（uv/embeddable python）、自动更新、崩溃自愈 | `v3/05-windows-resident-daemon/` |
| 6 | 用户建模 | "比用户更懂用户"：用户事实记忆、写作风格提取、Delphi 千人数字孪生、sleep-time 整合（Letta）、本地隐私画像、纵向记忆固化 | `v3/06-user-modeling/` |
| 7 | 自进化 skill | super-skill 自举对象：Voyager skill library、SkillWeaver、Anthropic Agent Skills、AWM/Reflexion、Darwin Gödel Machine、DSPy 提示进化、buglog 模式 | `v3/07-self-evolving-skills/` |
| 8 | 普适化安装器 | "一套方式装到任何人电脑"：Ollama/LM Studio/AnythingLLM 一键安装范式、uv standalone、winget/scoop 分发、无 GPU 最低硬件基线、配置向导、干净卸载 | `v3/08-universal-installer/` |
| 9 | 个人 Agent OS 增量 | V2 调研（09-11）后的最新格局：OpenClaw 生态、Claude Agent SDK/Code 2.x（subagents/workflows/skills/hooks）、Goose 桌面 daemon、A2A/AG-UI 协议、MCP registry、与我们的差异化 | `v3/09-personal-agent-os-delta/` |

## 每环节统一产出契约

- `_all.json`：数组，每项 `{name, url, type, stars_or_scale, license, maturity, relevance(1-5), what, value_to_v3, freshness}`
- `DIGEST.md`：≥20 项全景表 + **Top5 缝合推荐**（排序理由）+ 3 条对 V3 架构的硬启示 + 风险/坑清单
- 与 V2 底座去重：已知项目（OpenClaw/nanobot/openhuman/QwenPaw/screenpipe/UFO²/SenseVoice/OpenViking/browser-use/MarkItDown/MinerU/docling）只记**新进展**，不重录

## 纪律

1. ≥20 项/环节，查不到的标注"未核实"换下一项，绝不编造
2. 优先 2025-2026 新鲜度；每项必有真实 URL
3. 只落盘 `RESEARCH_DOCKET/v3/<环节>/`，不动项目其他目录，不 commit，不碰密钥
4. 九路并行后台代理执行；全部回收后由主线汇总 `v3/RESEARCH_DIGEST.md` + `v3/GAP_REPORT.md` → proposal-forge

## 下游

→ 汇总消化 → `PROPOSAL_V3/PROPOSAL.md` + `SCORECARD.json`（十倍代差指数 = 四能力逐项对比办公 AI 空白）→ ✋ 提案审批闸（唯一人工触点）→ 批准后 14-Phase 一周全自主开发
