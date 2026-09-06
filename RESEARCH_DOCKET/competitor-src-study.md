# 竞品源码级研究笔记（2026-09-06，五仓 main 分支快照）

> 方法：codeload.github.com 下载五仓最新 main tarball 至 research/competitors-src/（已 gitignore，第三方 GPL/AGPL 源码不入本仓库）；本文只沉淀**对 PAI-Station 有设计输入的事实**，每条标注源码路径。网站级调研见 competitor-deep-dive.md，本文是其源码级增量。

## 1. OpenClaw（openclaw/openclaw@main，TypeScript 100,478 行，MIT）

- **160+ 扩展矩阵**（extensions/）：通道类（whatsapp/telegram/discord/slack/signal/imessage/msteams/line/matrix/zoom-meetings…）与模型端点类（openai/anthropic/deepseek/moonshot/qwen/**zai 智谱**/volcengine/qianfan/ollama/lmstudio/vllm…）同构——每个 provider/通道一个独立包，包边界由 tsconfig.package-boundary 强制；
- **中国端点已在**：feishu、tencent、xiaomi、zalo、volcengine、qianfan、alibaba、zai——但无微信、无企微 webhook 一等通道，且面向海外个人部署；
- **custodian-skills/（自维护技能）**：add-model-provider、cloud-image-bake、configure-channel、diagnose-gateway——**agent 自己维护自己的网关**，这是"运维自动化"的技能化表达；
- **SKILL.md 格式实证**（custodian-skills/configure-channel/SKILL.md）：YAML frontmatter（name/description）+ 正文分 **Gather→Mutate→Prove** 三段，"每次运行必须以可观察的 Prove 结果收尾"；密钥只以 **SecretRefs** 进配置，绝不落明文；
- **VISION.md**：安全与安全默认 > 稳定性 > 首启可靠性为当前优先级；"trusted gateway, untrusted execution, deterministic policy"三词架构纲领；个人/团队同一网关仅配置不同。

## 2. openhuman（tinyhumansai/openhuman@main，Rust+TS 93,098 行，GPL-3）

- **Obsidian Wiki 记忆**：全部记忆压缩为**评分 Markdown 树**存 SQLite 并镜像为 Obsidian vault，用户可直接打开编辑——README 原话"No vector-soup black box"；
- **Workflows**：agent **主动提案**自动化→用户在**画布上审批**→审批门控的持久运行（开源 tinyflows 引擎）；
- **agent harness**（tinyagents）：检查点化图执行；卡住的 agent 可被"steer"；中止的返回根因；每次运行可回放且带**逐调用真实成本**；
- **split brain 编排**：快速反射 agent 分诊入站流量 + 深度推理核心 + "subconscious"操舵（与我们的双系统/OODA 同源但更工程化）；
- **Privacy Mode**：一个开关→**Rust 核心层强制**推理不出机（比应用层承诺强）；
- **模型路由**：订阅是默认不是锁定——任意 workload 可指向自有 key 或本地 Ollama，三者混用；
- **17 通道含原生邮件**（IMAP IDLE+SMTP）；mascot 吉祥物有脸有记忆（情感化设计）；
- **互操作后端**：memory.backend="agentmemory" 可代理 rohitg00/agentmemory，与 Claude Code/Cursor/Codex/OpenCode 共享记忆存储；
- README 竞争性表述："Hermes learns by watching you work; OpenClaw waits for plugins to ferry context in"。

## 3. QwenPaw（agentscope-ai/QwenPaw@main，Python 176,114 行，Apache-2.0，v2.2.0 2026-09-03）

- **Agent OS — Workspace 三支柱**：Resources（资源透明落磁盘可查）/ **Governance（allow/deny/ask/sandbox 四态）** / Sandbox（macOS/Linux/Windows 三平台）；
- **governance/ 模块实证**：audit.py（SQLite AuditLog：record/query/purge+旧 schema 迁移）、detectors.py、policy.py、resource_governor.py、tool_adapter.py、tool_registry.py——治理是独立子系统而非散落校验；
- **skill_scanner**：rules/signatures/ 签名规则库+analyzers+data——技能上架前的机器审是规则驱动可扩展的；
- **Drivers**：MCP/A2A/ACP 协议中立连接层，加密凭据+**每调用策略门**；
- **Scroll Context**：每一轮对话持久化；被逐出的轮次建索引可按需召回——"nothing summarized away"；
- **ReMe v0.4**：自进化个人知识库，会话与资源持续变成**可读、可编辑、可搜索、可链接的 Markdown 记忆**；
- **运行时子代理**+ACP 跨系统编排；**WeChat 已进 README 通道列表**（钉钉/飞书/微信/Discord/Telegram/iMessage/QQ）——对手在进化，第 6.5 节情报需季度刷新；
- v2.2.0 新增：自托管多用户 Hub、QwenPaw Mail、统一模型路由、统一市场、Creator 1.1、PawApp 小程序平台、**用户可编辑 Agent Modes**、Oh-My-Paw 插件。

## 4. OpenViking（volcengine/OpenViking@main，Rust+Python，AGPLv3-core，v0.3.22）

- **ragfs**（crates/ragfs）：记忆=虚拟文件系统，agent 用 ls/tree/find 浏览自己的上下文——确定性操作替代黑盒向量查询；
- **目录级分层**：每个目录带 .abstract（L0 ~100 tokens）/ .overview（L1 ~2k tokens），相关性判断先于全文读取；
- **检索轨迹可观测**：每次检索留下可观看可调试的轨迹（retrieval trajectory）；
- **新基准数据**：LoCoMo——OpenClaw 24.20%→82.08%、**Hermes 33.38%→82.86%、Claude Code 57.21%→80.32%**；tau2-bench Retail 70.94→77.81、Airline 54.38→66.25；
- agent-plugins/：skills/ + servers/（MCP）——记忆中间件自己也长出了技能与工具插件面。

## 5. nanobot（HKUDS/nanobot@main，Python，MIT，4.6MB 轻量）

- **WebUI 优先引导**：全新安装可在**未配模型时先开浏览器界面**，设置在浏览器里完成而非改 JSON——首启体验设计值得抄；
- **共享本地网关**：127.0.0.1:8765 默认仅回环；后台守护模式让通道与自动化在 TUI/WebUI 退出后继续跑；
- **内置 OpenAI 兼容 API**：nanobot 本身就是可被调用的端点（api/ 目录）；
- **临时会话**：temporary chats 不进历史不进记忆——隐私粒度控制；
- **optional_features.py**：基于 importlib metadata 的可选特性发现/启用——功能开关的优雅实现（依赖装了功能才亮）；
- 目录含 cron/、pairing/、llm_usage/、bus/（事件总线）、security/。

## 6. 对 PAI-Station 的十项设计输入（进入第 17/18 章）

1. 扩展包边界强制（OpenClaw tsconfig package-boundary）→ 我们的通道/感知插件隔离规范；
2. SKILL.md 的 Gather/Mutate/**Prove** 三段纪律 → SKILL 规范 v2（附录 A 升级）；
3. SecretRefs（密钥引用不落明文）→ 16.6.3 DPAPI 保险箱的配置层配套；
4. custodian-skills 自维护技能 → "分身自体检/自修配置"种子技能（附录 M 增补）；
5. Obsidian Wiki 式记忆导出（Markdown vault 可编辑）→ 17.6 记忆自由的导出格式升级；
6. Workflows 提案-画布-审批门 → 主动服务的"提案模式"（调度强度 3 档的交互形态）；
7. allow/deny/ask/sandbox 四态治理 + 独立 governance 子系统 → 17.5 自主性自由的四态化；
8. Scroll Context 逐轮持久+逐出索引 → 会话记忆层设计补充（不丢失只沉降）；
9. WebUI 优先首启 + 临时会话 + OpenAI 兼容 API + optional_features → 17.9/17.11 界面与扩展自由的实现参照；
10. 检索轨迹可观测（OpenViking）→ 记忆浏览器增加"为什么想起这条"溯源展示。
