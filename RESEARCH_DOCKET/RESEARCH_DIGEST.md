# RESEARCH_DIGEST.md — PAI-Station 全网深度调研综合（2026-09-05）

> 数据底座：GitHub Search/Repos API 收割 **350 个去重仓库**（242 个近 3 个月活跃），+ 竞品站点/HN/Reddit/知乎/CSDN/官方文档 9 频道定性调研，+ 用户自有 22 个 GitHub 仓库与 39 个本地项目勘察。
> 明细：[github/_digest.md](github/_digest.md)（全量 star 表）、[china-im.md](china-im.md)、[competitor-site.md](competitor-site.md)、[pypi-npm.md](pypi-npm.md)、[hn-reddit.md](hn-reddit.md)

## 一、品类格局：2026 个人 AI 助手的四个世代
1. **聊天接入层**（2023-24）：ChatGPT 套壳、wechaty 机器人 —— 已死或平庸
2. **工作流平台**（2024-25）：Dify 154k★、FastGPT、MaxKB、RAGFlow —— 面向开发者搭应用，非个人终端用户
3. **个人 agent 框架**（2025-26 爆发）：
   - **OpenClaw 388,933★**：本地网关+24+IM+skills+调度，MIT；TS/Node，极客向，中国 IM 非一等公民，无本地感知
   - **nanobot 47,726★**（HKUDS）：超轻量 Python 自托管个人 agent，WebUI+MCP+多 agent
   - **openhuman 39,436★**：Mac/Win/Linux 本地优先个人 AI（Rust），local-first 记忆+编排+深度研究
   - **QwenPaw 34,919★**（阿里 agentscope-ai）：多聊天 App 接入的个人助手
   - **OS-Copilot 1,796★**：早期学术
4. **感知-执行闭环**（2026 前沿）：screenpipe（YC S26）、UFO²、Agent-S3、UI-TARS-desktop 38.9k★、browser-use 112k★ —— 单器官强，但无一整合成"懂你"的整机

## 二、器官移植缝合图（Stitching Map）—— 每个器官用全球最强件
| 器官 | 选型（★） | 角色 |
|------|-----------|------|
| 框架基线 | OpenClaw 388,933（架构参考）+ 自研 Python 桌面核心 | 网关/skills/调度思想移植，不直接依赖 TS 栈 |
| 频道-飞书 | lark-oapi 官方 SDK（WebSocket 长连接，免公网 IP） | 双向对话+卡片+主动推送 |
| 频道-钉钉 | dingtalk-stream 官方 SDK（Stream Mode） | 同上 |
| 频道-企微 | 自建应用 REST + aibot_subscribe WS + 群 Webhook | 交互主通道（合规、可传文件） |
| 频道-微信 | 纯视觉只读（mss 截图 + GLM-4V-Flash 视觉）+ 企微引导 | 零封号风险 |
| 浏览器 | DrissionPage 12,421（用户指定）；browser-use 112,355（agent 模式备选） | 自动化+逆向 API 化 |
| 文档→MD | MarkItDown 178,266（Office）+ MinerU 79,235（复杂 PDF）+ docling 66,026（表格公式） | 全盘知识抽取三引擎 |
| 语音 | SenseVoice 9,242（中文 CER 减半/169x 实时）+ FunASR 流式 + faster-whisper 25,247（多语） | 会议/环境音/语音指令 |
| OCR/屏幕理解 | PaddleOCR 88,913 + RapidOCR（CPU 轻量）+ Umi-OCR 47,107 + OmniParser 25,370（GUI 解析） | 屏幕语义化 |
| 截图留存 | mss/dxcam + 10 分钟滚动删除 | 隐私安全默认 |
| 记忆/上下文 | OpenViking 35,602（自进化上下文库：记忆+RAG+技能统一，需验许可证）或自建轻量三级记忆 | ⑤自学习支柱引擎 |
| 检索 | SQLite FTS5(BM25+jieba) + sqlite-vec/LanceDB | 绿色便携，零服务依赖 |
| 深度研究 | gpt-researcher 29,295 + STORM 31,226（换 Zhipu 免费模型） | ④能力支柱 |
| 爬虫 | crawl4ai 81,445 + scrapy 64,206 + firecrawl 176,721（自托管） | ③内网规则学习 |
| 编排 | LangGraph 41,083 / smolagents 29,163（按需薄用） | 多步任务 |
| 技能标准 | anthropics/skills 174,376（SKILL.md 开放标准）+ obra/superpowers 281,952 | ④技能生态直通全球市场 |
| 桌面壳 | pywebview 6,008 / Flet 16,649 + pystray 托盘 + WinSW 14,280（或 schtasks）开机自启 | PC 客户端形态 |
| 运维稳定 | 复用 We-AIPO：_AdaptivePacer 限流降级、tenacity 重试、retro_autopilot、preflight/health 体系 | 7×24 无人值守 |
| 模型 | GLM-4-Flash(128K/30并发) → GLM-4.7-Flash(200K) → GLM-Z1-Flash(推理) 链，全部免费 | 零成本承诺 |

## 三、直接竞品解剖（必须正面超越的 4+1）
| 维度 | OpenClaw | nanobot | openhuman | QwenPaw | **PAI-Station** |
|------|----------|---------|-----------|---------|-----------------|
| 形态 | 本地网关+WebUI | 轻量框架+WebUI | 桌面 App | 框架/云 | **Windows 绿色便携桌面客户端** |
| 中国 IM | 社区桥接非一等公民 | 部分 | 无 | 部分（阿里系） | **飞书/钉钉/企微官方长连接一等公民+微信纯视觉** |
| 本地全盘感知 | ✗ | ✗ | 弱 | ✗ | **全盘扫描+1:00 增量+屏幕滚动+环境音** |
| 中文职场技能蒸馏 | ✗ | ✗ | ✗ | ✗ | **初稿↔终稿 diff 蒸馏、公文/纪要/周报/软著技能** |
| 零成本模型 | ✗（默认付费 API） | ✗ | ✗ | ✗ | **智谱免费链承诺** |
| 主动服务 JTBD | 调度有、智能无 | ✗ | ✗ | ✗ | **JTBD 打分引擎决定何时打扰** |
| 商业模式 | 开源无变现 | 开源 | 开源 | 大厂生态 | **免费软件+Token 计量+技能市场+满意度退款** |
| 用户画像/企业画像 | ✗ | ✗ | ✗ | ✗ | **MBTI 多模型画像报告（Word+MD）** |

## 四、社区情绪与风险情报
- 记忆框架基准互相打架 → 自建轻量记忆，不站队外挂服务
- GUI Agent 仍不可靠 → 主路径原生 API/文件操作，GUI 仅兜底（用户"逆向成 API"理念正确）
- 微信 Hook 封号>80% → 纯视觉只读是唯一可承诺路线
- Windows Defender/权限 → 绿色便携 + INI 全参数 + 只读红线
- Skills 开放标准（2025-12）→ 直接兼容 = 生态冷启动捷径
