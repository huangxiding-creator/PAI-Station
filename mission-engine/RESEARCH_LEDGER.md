# 调研台账：128个外部仓库（2026-10-23实测，gh api/star实测+站内350仓语料+HN）
## A. 自主编排/多智能体框架（26）
OpenClaw 388933★MIT | AutoGPT 187714 | paperclip 106234 | dify 154502 | langchain 145688 | browser-use 112355 | OpenHands 86234 | ruflo 78524 | autogen 60811 | crewAI 60004 | openinterpreter 68243 | nanobot 47726 | openhuman 39436 | QwenPaw 34919 | UI-TARS-desktop 38858 | SuperAGI 17712 | agenticSeek 27531 | edict 17012 | hive 11119 | brigade 11354 | pentagi 32070 | dapr-agents 764 | swarmclaw 697 | MassGen 1143 | jarvis-registry 3693 | ownpilot 42
## B. Claude Code 编排/自主循环/调度（36）
superpowers 281952 | anthropics/skills 174376 | ARIS(Auto-claude-code-research-in-sleep) 17934 | ralph-claude-code 9711 | ralph-orchestrator 3185 | ralphy 2978 | deepclaude 2273 | continuous-claude 1387 | aeon 782 | super-board 462 | autoresearch-claude-code 346 | raptor-loop-hunt 271 | auto-company 198★MIT(同构愿景!) | awslabs/cli-agent-orchestrator 1462 | Claude-Code-Agent-Monitor 1106 | maestro-orchestrate 486 | codex-orchestrator 356 | codexmate 354 | octoally 102 | claudiator 27 | maniple 49 | claude-code-park 24 | openclaw-tmux-claude-ops 28 | loushang 1843 | planning-with-files 27595 | mnemosyne 101 | dely 87 | clu(24/7 daemon) 6 | cronagent 1 | busy 0 | SchedulerOracle 0 | nova-agent 0 | techtools-claude-code-cron-loop 1 | awesome-cli-coding-agents 1395 | pentest-agents 1026 | invisible_dots 32222
## C. 智谱额度/用量监控（12）
ccusage 19138★MIT | zcode-switch 410 | opencode-glm-quota 32 | zcode-proxy 22 | zhipu-codeing-plan-monitor 2 | zhipu-token-monitor 0 | glm-monitor 0 | GLMQuotaMonitor 1 | plan-watch 1 | LLMUsageBar 0 | pulse-win 0 | TokenMeter 1 —— 结论：全部只监控不重置，预测+治理+自动重置=空白
## D. 研究/爬取/文档/语音/记忆器官（38）
firecrawl 176721 | crawl4ai 81445 | scrapy 64206 | page-agent 28995 | OpenCLI 28991 | obscura 25294 | AIHawk 30312 | storm 31226 | gpt-researcher 29295 | markitdown 178266 | docling 66026 | MinerU 79235 | marker 39531 | PaddleOCR 88913 | Umi-OCR 47105 | OmniParser 25370 | faster-whisper 25247 | meetily 30373 | mem0 64734 | letta 24622 | graphiti 30604 | cognee 30486 | supermemory 29233 | OpenViking 35602 | MiroFish 71966 | dolt 24360 | khoj 37131 | ragflow 90081 | FastGPT 29580 | Langchain-Chatchat 38613 | anything-llm 65645 | open-webui 151007 | book-to-skill 28627 | GenAI_Agents 24670 | awesome-ai-agents 30582 | hermes-desktop 14448 | agenticSeek(dup A) | tauri 110821
## E. 微信/IM/CRM/收款（8）
CowAgent 47387★MIT | LangBot 18147★Apache-2.0 | WeChatPadPro 2642 | wechatauto-replica 440★Apache-2.0 | EspoCRM 3486★AGPL | CordysCRM 2784 | acg-faka 5804★MIT* | wechatpay-skills 364★MIT
## F. 补充编排/调度小件（8，来自gh search尾部）
gabrielkoerich/orch 19 | chipp-ai/dispatch 8 | genpark-role-playing 9 | akz4ol/cronagent 1 | SalvucciFacundo/agis 2 | BryanLimited/autopay-ai-cronos 0 | dinesh2648/claude_managed_agents 1 | bennyzen/zenclaw 7
## 站内在役前作（直接复用，非GitHub计数）
IdeaDig（URL→开发就绪方案五阶段）/ EngOpp-Mining v3（28.7min 112商机+审计教训）/ wxrpa W1（UIA 94节点）/ zbops / rion-cli / 微信情报库 / viaim-cli / topic_signals_to_radar.py / OPE传播M1 / 发布链 / KB-FACTORY / Manus军团 / 350仓语料(RESEARCH_DOCKET/github/_all.json) / zhipu-quota-guard(W0实测+已批)
## HN定性（Algolia实测）
"I Let Claude Code Autonomously Run Ads for a Month" / "Do AI Agents Make Money in 2026? Or Is It Just Mac Minis and Vibes?"
## 方法注记
gh api(authenticated) 六轮检索 + 站内350仓语料 + HN Algolia；WebSearch/WebFetch全灭（MCP月度4000额度100%用尽10-26重置+域名安全校验阻断），全部数字为当日实测，零手填
