# -*- coding: utf-8 -*-
"""终极提案·调研波1: 研究方法论框架与AI研究编排系统普查 — 编译器
数据源: _raw/gh_*.json + _raw/repo*.json (gh api 实测 2026-10-28) + HN Algolia 180天 + WebSearch
纪律: stars全为gh api实测, 零手填; 只登记不装不clone
"""
import json, collections

P = []  # (lane, name, repo, desc, access, fit, stars, note)

def add(lane, name, repo, desc, access, fit, stars, note=None):
    P.append(dict(lane=lane, name=name, repo=repo, desc=desc, access=access, fit=fit, stars=stars, **({"note": note} if note else {})))

L1 = "1-AI研究编排框架"
L2 = "2-多智能体研究角色分工"
L3 = "3-证据链与事实核查"
L4 = "4-知识图谱与推理引擎"
L5 = "5-竞争情报OSINT方法论"
L6 = "6-研究报告质量评估"

# ============ LANE 1: AI研究编排 (任务点名锚定件 + 新增) ============
# --- 任务点名锚定件(上轮渠道普查已登, 本轮以方法论角度复登, note=prev_survey) ---
add(L1, "gpt-researcher", "https://github.com/assafelovic/gpt-researcher",
    "编排事实锚: 计划agent+执行agent分工(广度查库→深度研读→综合), 产出带引用报告; 人类协同与子任务定制是方法论核心",
    "开源Apache-2.0自托管(Python, 多LLM)", "需改造", 30317, "prev_survey复登")
add(L1, "STORM", "https://github.com/stanford-oval/storm",
    "编排事实锚: 研究写作骨架=多视角问询(Perspectifier)→多agent对话(WRITER/EDITOR角色分离)→大纲→带引用全篇长文",
    "开源MIT自托管(Python)", "可直接采用", 31720, "prev_survey复登")
add(L1, "open-deep-research(LangChain)", "https://github.com/langchain-ai/open_deep_research",
    "编排事实锚: 子agent并行生成假设→后台supervisor压缩上下文循环; 已archived但压缩-精炼循环范式仍被广泛抄用",
    "开源MIT(官方已归档, 需改造)", "方法论参考", 12673, "prev_survey复登")
add(L1, "Agent Laboratory", "https://github.com/SamuelSchmidgall/AgentLaboratory",
    "编排事实锚: 文献综述→公式化→实验计划→执行→报告全流程human-in-loop工作站(博士级流水线蓝本)",
    "开源MIT自托管(Python)", "方法论参考", 5914, "prev_survey复登")
add(L1, "DeepResearcher(GAIR)", "https://github.com/GAIR-NLP/DeepResearcher",
    "编排事实锚: 在真实web环境端到端RL训练深研agent(浏览-推理-综合一体), RL训练范式证据",
    "开源Apache-2.0(研究代码)", "纯论文", 806, "prev_survey复登")

# --- 新增零重复 ---
add(L1, "AI-Scientist", "https://github.com/SakanaAI/AI-Scientist",
    "全自动科研闭环: idea→实验→写作→自动评审(内置LLM Reviewer三段评审), 评审agent可直接移植为研报critic",
    "开源自托管(Python, 需LLM key)", "需改造", 14810)
add(L1, "AI-Scientist-v2", "https://github.com/SakanaAI/AI-Scientist-v2",
    "agentic树搜索驱动的workshop级自动发现; 树搜索+自动审稿迭代双环是长报告自检的方法论来源",
    "开源研究代码(Python)", "纯论文", 7415)
add(L1, "CycleResearcher", "https://github.com/zhu-minjun/Researcher",
    "研究agent×自动评审agent互促强化学习(CycleReviewer); 产-评互促RL范式可借鉴为报告质量内环",
    "开源研究代码", "纯论文", 407)
add(L1, "AFlow", "https://github.com/FoundationAgents/AFlow",
    "MCTS自动搜索agentic workflow代码表示(ICLR2025 Oral); 研究流程本身可被自动优化而非手写",
    "开源MIT(Python)", "可直接采用", 626)
add(L1, "WeResearch", "https://github.com/search?q=WeResearch",
    "任务点名件: GitHub+全网双源实测无官方公开仓(仅同名0星站点壳仓), 代码未公开; 登记论文线索待追踪",
    "论文(代码未公开)", "纯论文", None, "官方repo未公开(1028双源实测)")
add(L1, "harness2(Google Research)", "https://github.com/google-research/harness2",
    "Google递归agent harness(Recursive Agent Harnessing, HN 81pt/19c); 递归编排与任务拆解骨架",
    "开源自托管", "可直接采用", 20542, "HN近180天发现")
add(L1, "Mole", "https://github.com/lajosdeme/mole",
    "终端深度研究agent: 强制预算+引用核实(verified quotes)+本地数据隐私边界(HN 100pt)",
    "开源自托管(终端CLI)", "可直接采用", 317, "HN近180天发现")
add(L1, "FAROS", "https://github.com/OpenNSWM-Lab/FAROS",
    "蓝图驱动的AutoResearch运行时: idea生成→实验→产物全链编排",
    "开源自托管", "方法论参考", 3036)
add(L1, "loopx", "https://github.com/loopx-project/loopx",
    "本地优先语义控制平面+research workbench: 长程目标→可验证结果(把研究目标当语义工单管理)",
    "开源本地优先", "方法论参考", 6452)
add(L1, "dr-claw", "https://github.com/OpenLAIR/dr-claw",
    "AI博士军团研究IDE(海量AI Doctor助手编队), 研究工作台交互范式",
    "开源自托管", "方法论参考", 1169)
add(L1, "luxas", "https://github.com/Muuuun/luxas",
    "自主研究同事: 一个问题→过夜编译成手稿; 长时程无人值守研究编排",
    "开源自托管", "方法论参考", 1169)
add(L1, "AutoScholarLoop", "https://github.com/damonwan1/AutoScholarLoop",
    "多agent自动研究环: idea发现→实验执行→证据落地论文写作→质量审计四段闭环",
    "开源自托管", "方法论参考", 534)
add(L1, "de-anthropocentric-research-engine", "https://github.com/yogsoth-ai/de-anthropocentric-research-engine",
    "给定研究方向自动跑: 文献综合→gap验证→假说形成→实验设计(非人类中心的严谨研究管线)",
    "开源自托管", "方法论参考", 505)
add(L1, "Polaris", "https://github.com/ZJU-REAL/Polaris",
    "面向自主科学发现的agent系统(ZJU), 发现导向编排",
    "开源研究代码", "纯论文", 264)
add(L1, "research-town", "https://github.com/ulab-uiuc/research-town",
    "人类研究社区模拟器(ICML2025): agent扮演作者/审稿人社区; 社区化评审方法论",
    "开源研究代码", "纯论文", 216)
add(L1, "UniversalDeepResearch", "https://github.com/NVlabs/UniversalDeepResearch",
    "NVIDIA通用深研论文(arXiv:2509.00244)官方代码",
    "开源研究代码", "纯论文", 470)
add(L1, "sgr-agent-core", "https://github.com/vamplabAI/sgr-agent-core",
    "Schema-Guided Reasoning(SGR): 用schema约束agent推理路径(可迁移到研究流程结构化)",
    "开源自托管", "方法论参考", 1127)
add(L1, "XScientist", "https://github.com/smileformylove/XScientist",
    "Git式证据史: 研究过程可检查/可复现/可回滚(inspectable evidence histories)",
    "开源自托管", "方法论参考", 126)
add(L1, "CoAutoResearch", "https://github.com/YihongT/CoAutoResearch",
    "自主调查+递归自改进+人机协同研究系统",
    "开源自托管", "方法论参考", 112)
add(L1, "PaperTeam", "https://github.com/JiahongXu88/PaperTeam",
    "证据落地科研agent: 引用核验+论文生产流水线",
    "开源自托管", "方法论参考", 95)
add(L1, "deepevolve", "https://github.com/liugangcode/deepevolve",
    "DeepResearch+代码进化双agent发现新算法; 深研×进化搜索组合范式",
    "开源自托管", "方法论参考", 144)
add(L1, "deepdive skill", "https://github.com/Socialpranker/deepdive",
    "12阶段研究管线skill: plan-review门+并行子agent搜索+claims台账(证据账本)",
    "Claude Code skill即装即用", "可直接采用", 368)
add(L1, "research-toolkit", "https://github.com/rrrrrredy/research-toolkit",
    "研究方法+工作流工具+独立评审三合一(Agent Skill/插件/本地MCP三形态)",
    "skill/MCP即装即用", "可直接采用", 310)
add(L1, "hoolulu/deep-research", "https://github.com/hoolulu/deep-research",
    "券商级深度研报生成skill: 一条命令约十分钟出专业级深研报告",
    "Claude Code skill即装即用", "可直接采用", 605)
add(L1, "SeanEllyJames/deep-research-skill", "https://github.com/SeanEllyJames/deep-research-skill",
    "会思考有判断的深度调研(反信息罗列式汇总)即插即用skill",
    "Agent skill即装即用", "可直接采用", 187)
add(L1, "folio", "https://github.com/helsome/folio",
    "本地优先AI投研工作台: 深度调研+证据化投资论点+组合风险分析(投研编排参考)",
    "开源本地优先", "方法论参考", 265)
add(L1, "report-helper", "https://github.com/Jiaranbb/report-helper",
    "长篇深度研究报告调研/写作助手: 一句话跑完完整报告输出高质量PDF",
    "开源自托管", "可直接采用", 60)
add(L1, "Open-Deep-Research-workflow-on-Dify", "https://github.com/AdamPlatin123/Open-Deep-Research-workflow-on-Dify",
    "Dify上的深研工作流DSL: 级联多源搜索→大纲→带引用长文(低代码可视化编排样本)",
    "开源Dify DSL即导入", "可直接采用", 320)
add(L1, "deepsearch-agents", "https://github.com/didilili/deepsearch-agents",
    "对话式多智能体深搜实战项目(LangGraph+RAGFlow+Tavily): 深研agent工程教材级样本",
    "开源自托管", "方法论参考", 300)
add(L1, "deep-research-mcp", "https://github.com/pminervini/deep-research-mcp",
    "统一MCP口聚合OpenAI/Gemini Deep Research/Tavily/自托管DR引擎(多DR引擎编排器)",
    "开源MCP即挂", "可直接采用", 116)
add(L1, "gptr-mcp", "https://github.com/assafelovic/gptr-mcp",
    "gpt-researcher官方MCP服务化(LLM应用经MCP协议执行深研)",
    "开源MCP即挂", "可直接采用", 376)
add(L1, "deepcloak", "https://github.com/Mrbaeksang/deepcloak",
    "本地优先研究工具: 显式抓取决策+来源证据+带引用报告(CLI+MCP双口)",
    "开源本地优先(Python)", "方法论参考", 60)
add(L1, "deepresearchagent(1612535983)", "https://github.com/1612535983/deepresearchagent",
    "可恢复可审计深研agent(LangGraph): 规划→搜索→证据管理→报告, 断点续跑",
    "开源自托管", "方法论参考", 52)
add(L1, "super-survey", "https://github.com/GoatGit/super-survey",
    "可复用多轮调研skill: 证据背书的产品/市场/技术/开源/投资式调研",
    "Agent skill即装即用", "可直接采用", 89)
add(L1, "Agon", "https://github.com/AutoResearch-Factory/Agon",
    "Claude Code自主科研插件: 多agent环从裸题直达运行实验",
    "Claude Code插件即装", "方法论参考", 54)
add(L1, "steer", "https://github.com/xieyulai/steer",
    "STEER: AI4R实验框架, 接驳既有研究工具的auto-research编排",
    "开源自托管", "方法论参考", 28)
add(L1, "newssurvey", "https://github.com/impredicative/newssurvey",
    "用指定新闻站+LLM写survey报告(信源限定式综述生成)",
    "开源自托管", "方法论参考", 31)
add(L1, "researcher-skill(ReAct)", "https://github.com/ViryaZheng/researcher-skill",
    "ReAct深搜skill: 搜深不搜宽, 每轮沿上一轮线索追进(线索链式深挖)",
    "Agent skill即装即用", "可直接采用", 26)
add(L1, "hermes-researcher-agent", "https://github.com/AlekseiUL/hermes-researcher-agent",
    "隐私安全研究员agent: web/GitHub/YouTube/Reddit/文档+source-lineage核查+反例寻找",
    "开源自托管", "方法论参考", 63)
add(L1, "shandu", "https://github.com/jolovicdev/shandu",
    "开源深研agent: LLM agents搜网+读页读PDF+来源可信度评分",
    "开源自托管", "方法论参考", 11)
add(L1, "caesar-agent", "https://github.com/jasonzliang/caesar-agent",
    "图驱动深度网探索+对抗性答案合成(graph-based exploration + adversarial synthesis)",
    "开源自托管", "方法论参考", 16)
add(L1, "lastsearch", "https://github.com/LastSearch-HQ/lastsearch",
    "可靠研究基建: 证据背书搜索+引用+置信分",
    "开源自托管", "方法论参考", 20)
add(L1, "openrouter-deep-research-mcp", "https://github.com/wheattoast11/openrouter-deep-research-mcp",
    "多agent研究MCP: 异步agent网/流式swarm编排研究",
    "开源MCP即挂", "方法论参考", 55)
add(L1, "LongCat-DeepResearch", "https://github.com/meituan-longcat/LongCat-DeepResearch",
    "美团开源深研harness: 多agent规划+独立分节研究+证据落地报告",
    "开源自托管", "方法论参考", 24)
add(L1, "qiqihezh/deepresearch-agent", "https://github.com/qiqihezh/deepresearch-agent",
    "生产级深研系统: 多agent编排+红蓝对抗降噪+语义级上下文压缩+跨agent共享记忆(165实验+显著性检验)",
    "开源自托管", "方法论参考", 171)
add(L1, "walsh", "https://github.com/ats4321/walsh",
    "多agent研究管线含可否决交易的风控经理(HN发现); 风控否决位可移植为研报质量门",
    "开源自托管", "方法论参考", 13, "HN近180天发现")
add(L1, "jeffy-skills", "https://github.com/jeffy-Peng/jeffy-skills",
    "证据背书深研skill: 时间线/力场图/机制框架产出可追溯决策就绪报告",
    "Agent skill即装即用", "可直接采用", 20)

# ============ LANE 2: 多智能体研究角色分工 ============
add(L2, "MetaGPT", "https://github.com/FoundationAgents/MetaGPT",
    "角色流水线范本(PM→架构师→工程师→QA): SOP编码进agent; 研究公司模拟=把角色换成选题官/研究员/撰写/审校",
    "开源MIT自托管(Python)", "需改造", 71038, "prev_survey复登(方法论角度)")
add(L2, "ChatDev", "https://github.com/OpenBMB/ChatDev",
    "chat-chain角色瀑布(CEO/CTO/程序员/测试员双人对话串): 瀑布式角色协作机制可直接套研报链",
    "开源Apache-2.0自托管", "需改造", 34598)
add(L2, "CAMEL", "https://github.com/camel-ai/camel",
    "inception role-playing机制: 双agent任务导向角色扮演+任务指定者/执行者分工",
    "开源Apache-2.0自托管", "方法论参考", 17983, "prev_survey复登(方法论角度)")
add(L2, "Swarm(OpenAI)", "https://github.com/openai/swarm",
    "轻量多agent编排教学件: agent与handoff原语(角色=agent, 交接=路由)的最小范式",
    "开源MIT(教育级, 已由agents-sdk接棒)", "方法论参考", 22079)
add(L2, "openai-agents-python", "https://github.com/openai/openai-agents-python",
    "Swarm继任生产框架: 多agent workflow+handoff+guardrails三原语",
    "开源MIT自托管(Python)", "可直接采用", 30338)
add(L2, "AgentScope", "https://github.com/agentscope-ai/agentscope",
    "看得见可理解可信任的多agent框架(消息可视化/监控/容错), 阿里出品",
    "开源Apache-2.0自托管", "可直接采用", 34448)
add(L2, "AgentVerse", "https://github.com/OpenBMB/AgentVerse",
    "动态编队范式: 招募→协作→评估→再招募循环; 任务求解时按需组合solver/reviewer角色",
    "开源Apache-2.0(原实验性)", "方法论参考", 5160)
add(L2, "CrewAI", "https://github.com/crewAIInc/crewAI",
    "角色扮演自主agent编队+hierarchical process(manager agent分派审查); researcher/writer角色内置",
    "开源MIT自托管(Python)", "需改造", 60184, "prev_survey复登(方法论角度)")
add(L2, "AutoGen", "https://github.com/microsoft/autogen",
    "GroupChat群聊协作: 多agent对话+critic代理(评审终结条件); 评审者角色注入范式",
    "开源自托管(Python)", "需改造", 61591, "prev_survey复登(方法论角度)")
add(L2, "TradingAgents", "https://github.com/TauricResearch/TradingAgents",
    "证券研究多agent角色分工教科书: analyst团队→research团队(牛熊对抗辩论)→trader→risk manager(可否决); 辩论式证伪直接可用",
    "开源自托管(Python)", "需改造", 117312)
add(L2, "academic-research-skills", "https://github.com/Imbad0202/academic-research-skills",
    "research→write→review→revise→finalize五段技能链(研究-撰写-评审-修订角色序列skill化)",
    "Claude Code skills即装即用", "可直接采用", 54171)

# ============ LANE 3: 证据链与事实核查 ============
add(L3, "FacTool", "https://github.com/GAIR-NLP/factool",
    "GAIR事实检测: claim抽取→检索核查+代码执行核查双路→二值判定; 每句话可验证的工程蓝本",
    "开源Apache-2.0(Python)", "可直接采用", 935)
add(L3, "Factcheck-GPT", "https://github.com/yuxiaw/Factcheck-GPT",
    "任务分解式核查: check-worthy claim抽取→原子分解→检索→核验; 内含FactCheck-Bench(Factbench.jsonl)=任务点名件FactCheck-Bench实体",
    "开源(Python+数据集)", "可直接采用", 117, "FactCheck-Bench官方数据集宿主")
add(L3, "SAFE(long-form-factuality)", "https://github.com/google-deepmind/long-form-factuality",
    "Google DeepMind搜索增强事实评估器(任务点名件SAFE): 长文事实claim→多步搜索推理→支持/反驳判定; 附LongFact数据集",
    "开源Apache-2.0(Python)", "方法论参考", 698)
add(L3, "FActScore", "https://github.com/shmsw25/FActScore",
    "EMNLP2023原子化事实评分: 生成文本→原子事实分解→检索→逐条核验→百分比分数; 长报告逐句打分的事实基线",
    "开源(Python)", "方法论参考", 460)
add(L3, "RARR", "https://github.com/anthonywchen/RARR",
    "检索增强重归因与修订(ACL2023): 事后为LLM输出补出处+改错(post-hoc修正器); 修订式而非拒绝式纠错",
    "开源(Python)", "方法论参考", 53)
add(L3, "ClaimVerify", "https://github.com/google-research/claimverify",
    "任务点名件: 证据检索→文档选择→立场判定三段式主张验证pipeline+基准(ACL2022); 官方仓已404(本轮实测), 方法论由Factcheck-GPT/RefChecker承接",
    "论文+数据集(repo已下线404实测)", "方法论参考", None)
add(L3, "RefChecker", "https://github.com/amazon-science/RefChecker",
    "Amazon细粒度幻觉检测: claim-tripplet(主体-关系-客体)抽取→与参考证据图比对; 检测管线+基准数据集",
    "开源(Python)", "可直接采用", 434)
add(L3, "OpenFactCheck", "https://github.com/yuxiaw/OpenFactCheck",
    "事实性评测开源框架: 可复现FacTool/FActScore/ClaimVerify等五种方法+自定义核查pipeline可视化搭建",
    "开源(Python)", "可直接采用", 64)
add(L3, "FreshQA", "https://github.com/freshllms/freshqa",
    "世界知识新鲜度问答基准: 对抗性+隐性过时信息挑战(判别「该不该查」再答)",
    "开源(数据+评测代码)", "方法论参考", 404)
add(L3, "ALCE", "https://github.com/princeton-nlp/ALCE",
    "带引用文本生成评测(EMNLP2023): citation recall/precision双指标=机器化判断每句话有出处的标准答案",
    "开源MIT(Python)", "方法论参考", 528)
add(L3, "FELM", "https://github.com/hkust-nlp/felm",
    "NeurIPS2023事实性评测基准: 分域(世界知识/科学/数学/推荐)+分推理链的事实性细分",
    "开源(基准+代码)", "纯论文", 65)
add(L3, "FactCircuit", "https://github.com/superwesleyhys-ux/factcircuit",
    "可审计claim-evidence验证环: 不可变溯源+分阶段检查+有界核验",
    "开源自托管", "方法论参考", 882)
add(L3, "IncarnaMind", "https://github.com/IncarnaMind/IncarnaMind",
    "杂乱文件→核查报告的开源桌面应用(macOS/Win/Linux): 从素材到checked report的成品形态",
    "开源桌面应用", "可直接采用", 847)
add(L3, "Automated-Fact-Checking-Resources", "https://github.com/Cartus/Automated-Fact-Checking-Resources",
    "自动事实核对研究总库(TACL22/EMNLP23配套): 文献级方法论地图",
    "开源文献清单", "方法论参考", 578)
add(L3, "claude-skills-journalism", "https://github.com/jamditis/claude-skills-journalism",
    "新闻/媒体/学术Claude Code技能包: 核验/FOIA/数据新闻/学术写作; 记者级事实核查工作流skill化",
    "Claude Code skills即装即用", "可直接采用", 436)
add(L3, "LLM-for-misinformation-research", "https://github.com/ICTMCG/LLM-for-misinformation-research",
    "LLM错误信息研究论文集(多模态含): 错误信息识别方法论综述源",
    "开源论文清单", "方法论参考", 334)
add(L3, "bullshit-detector", "https://github.com/SerhiiKorniienko/bullshit-detector",
    "逐claim事实核查+0-10 BS评分的agent skills(对任一网页断言打分并给源)",
    "Agent skills即装即用", "可直接采用", 160)
add(L3, "FactReasoner", "https://github.com/IBM/FactReasoner",
    "IBM长文事实性assessor: 生成即评的推理式事实判定",
    "开源(Python)", "方法论参考", 44)
add(L3, "Awesome-Long-Form-Factuality", "https://github.com/ki-ljl/Awesome-Long-Form-Factuality",
    "长文事实性论文与资源策展清单",
    "开源论文清单", "方法论参考", 28)
add(L3, "OLAPH", "https://github.com/dmis-lab/OLAPH",
    "生物医学长文QA事实性提升(迭代自纠训练)",
    "开源研究代码", "纯论文", 37)
add(L3, "FaStfact", "https://github.com/Yingjia-Wan/FaStfact",
    "EMNLP2025更快更强长文事实性评测(成本敏感的事实核查)",
    "开源研究代码", "纯论文", 36)
add(L3, "FactAlign", "https://github.com/MiuLab/FactAlign",
    "EMNLP2024长文事实性对齐(训练侧)",
    "开源研究代码", "纯论文", 19)
add(L3, "Attributed-QA", "https://github.com/google-research-datasets/Attributed-QA",
    "Google归因问答基准: 引用归因能力直接评测集",
    "数据集(开源)", "纯论文", 55)
add(L3, "web-researcher-mcp", "https://github.com/zoharbabin/web-researcher-mcp",
    "搜网+读一手来源+逐条引用核验的MCP服务(Claude/Cursor/Codex通用)",
    "开源MCP即挂", "可直接采用", 72)
add(L3, "sage-research", "https://github.com/qinyu8028/sage-research",
    "多agent深研系统: 自主网搜/学搜+质量门检索+结构化报告(中文)",
    "开源自托管", "方法论参考", 25)
add(L3, "SignalDesk-deep-searching", "https://github.com/riveeji/SignalDesk-deep-searching",
    "AI/Agent技术选型深研系统: 问题澄清→多源搜证→引用回链→证据覆盖校验→报告导出",
    "开源自托管", "方法论参考", 22)
add(L3, "dsh-research-report", "https://github.com/PerryLink/dsh-research-report",
    "可验证研究报告引擎: 内容寻址证据台账(claim-快照绑定防证据漂移)",
    "开源自托管", "方法论参考", 213)
add(L3, "research-proof", "https://github.com/tonyblu331/research-proof",
    "压力测试研究主张: 可证伪证据计划+对抗检查+冻结验证器+证明台账",
    "开源自托管", "方法论参考", 52)
add(L3, "build-research-evidence", "https://github.com/cpt13-g/build-research-evidence",
    "claim驱动科研skill: 骨干实验优先+独立结果审计+Evidence Freeze(证据冻结)",
    "Agent skills即装即用", "方法论参考", 46)
add(L3, "citeweave", "https://github.com/ruoyuanwang/citeweave",
    "证据优先可审计书目度量agent: 元数据→科学图谱→可出版报告",
    "开源自托管", "方法论参考", 5)
add(L3, "automated-fact-checking(aic-factcheck)", "https://github.com/aic-factcheck/automated-fact-checking",
    "多语言自动事实核对pipeline与数据生成(几乎任意语言)",
    "开源(Python)", "方法论参考", 4)
add(L3, "PremiseCheck", "https://github.com/OpenLAIR/PremiseCheck",
    "对人类与AI审稿意见做前提事实核查(审稿意见也可被核查)",
    "开源研究代码", "方法论参考", 6)

# ============ LANE 4: 知识图谱与推理引擎 ============
add(L4, "GraphRAG(微软)", "https://github.com/microsoft/graphrag",
    "图RAG开创件: 实体抽取→社区层级聚类→局部/全局两查询模式(全局问题向量检索失效的解法)",
    "开源MIT自托管(Python)", "可直接采用", 36464)
add(L4, "LightRAG", "https://github.com/HKUDS/LightRAG",
    "EMNLP2025轻量图RAG: 双层检索(低层实体+高层主题)+增量更新, 落地成本远低于微软版",
    "开源MIT自托管(Python)", "可直接采用", 40369)
add(L4, "RAGFlow", "https://github.com/infiniflow/ragflow",
    "深文档理解RAG引擎: 版面解析+引用溯源(Chunk级出处)+Agent融合; 带引用研报的工程底座",
    "开源Apache-2.0自托管(Docker)", "可直接采用", 92971)
add(L4, "graphiti", "https://github.com/getzep/graphiti",
    "实时agent知识图谱: bi-temporal双时间轴(事件时间与摄取时间分离)+增量更新; 研究情报随时间演化的解法",
    "开源MIT自托管(Python)", "可直接采用", 32283)
add(L4, "graphify", "https://github.com/Graphify-Labs/graphify",
    "代码库+文档+SQL+PDF→可查询知识图谱(单一管线多源入图)",
    "开源自托管", "需改造", 136962)
add(L4, "HippoRAG", "https://github.com/OSU-NLP-Group/HippoRAG",
    "NeurIPS2024海马体启发RAG: PPG个性化PageRank多跳推理(单步检索做多跳问题)",
    "开源研究代码", "方法论参考", 4081)
add(L4, "nano-graphrag", "https://github.com/gusye1234/nano-graphrag",
    "极简可hack的GraphRAG实现(微软论文的最小复刻), 二次开发首选底座",
    "开源MIT(Python)", "可直接采用", 4006)
add(L4, "KAG", "https://github.com/OpenSPG/KAG",
    "逻辑形式引导的推理与检索框架(OpenSPG引擎+LLM): 受控推理而非纯向量相似",
    "开源Apache-2.0自托管", "可直接采用", 9130)
add(L4, "llm-graph-builder", "https://github.com/neo4j-labs/llm-graph-builder",
    "Neo4j官方: 非结构化数据LLM自动建图(PDF/网页→属性图)",
    "开源Apache-2.0(Neo4j栈)", "可直接采用", 5285)
add(L4, "neo4j-graphrag-python", "https://github.com/neo4j/neo4j-graphrag-python",
    "Neo4j官方GraphRAG Python SDK(生产化接法)",
    "开源(Python SDK)", "可直接采用", 1321)
add(L4, "RAPTOR", "https://github.com/parthsarthi03/raptor",
    "树状递归摘要检索: 文档聚类→摘要→再聚类(层级抽象记忆); 研报分层叙事的检索对应物",
    "开源MIT(Python)", "方法论参考", 1775)
add(L4, "autoflow", "https://github.com/pingcap/autoflow",
    "TiDB向量+GraphRAG对话式知识库工具(pingcap)",
    "开源自托管(Docker)", "可直接采用", 2978)
add(L4, "TrustGraph", "https://github.com/trustgraph-ai/trustgraph",
    "语义agent治理平台: 知识图谱+流程治理agent基建",
    "开源自托管", "方法论参考", 2842)
add(L4, "Awesome-GraphRAG", "https://github.com/DEEP-PolyU/Awesome-GraphRAG",
    "GraphRAG资源总库(综述/论文/基准/开源项目)",
    "开源论文清单", "方法论参考", 2680)
add(L4, "FalkorDB", "https://github.com/FalkorDB/FalkorDB",
    "GraphBLAS稀疏矩阵图数据库, 低延迟多跳查询(GraphRAG推理底座选型)",
    "开源图数据库", "需改造", 10494)
add(L4, "Memgraph", "https://github.com/memgraph/memgraph",
    "内存图数据库: 主打GraphRAG/AI记忆/实时图分析",
    "开源图数据库(BSL)", "需改造", 4632)
add(L4, "NebulaGraph", "https://github.com/vesoft-inc/nebula",
    "分布式图数据库(大规模图谱横向扩展)",
    "开源Apache-2.0", "需改造", 12454)
add(L4, "smartrag", "https://github.com/aymenfurter/smartrag",
    "GraphRAG驱动的多agent深度研究(图+多agent组合样本)",
    "开源自托管", "方法论参考", 87)
add(L4, "menu-rag", "https://github.com/nambo/menu-rag",
    "超越基础RAG的实时深度研究(菜单式检索编排)",
    "开源自托管", "方法论参考", 22)
add(L4, "post-graph-rag", "https://github.com/crajah/post-graph-rag",
    "Postgres原生高精度GraphRAG: 新事实替换旧事实(时间感知图谱, CFO换人问题)", "开源(Postgres扩展)", "方法论参考", 12, "HN近180天发现")

# ============ LANE 5: 竞争情报OSINT方法论 ============
add(L5, "OpenCTI", "https://github.com/OpenCTI-Platform/opencti",
    "开源网络威胁情报平台(任务点名件): STIX2知识图谱+调查关系图谱+时间线+报告产物; 顶级情报机构的结构化调查方法论本体",
    "开源自托管(Docker)", "需改造", 10211)
add(L5, "SpiderFoot", "https://github.com/smicallef/spiderfoot",
    "OSINT自动化(任务点名件): 200+模块自动采集→实体关联→调查导出; Maltego开源替代主力",
    "开源自托管(Python)", "方法论参考", 23906)
add(L5, "MISP", "https://github.com/MISP/MISP",
    "威胁情报共享平台: 事件→属性→标签→ sightings结构化+共享社区治理; 情报结构化共享范式",
    "开源自托管(AGPL)", "方法论参考", 6624)
add(L5, "IntelOwl", "https://github.com/intelowlproject/IntelOwl",
    "大规模TI编排: 100+分析器流水线对同一observable并行聚合",
    "开源自托管(Docker)", "方法论参考", 4769)
add(L5, "Yeti", "https://github.com/yeti-platform/yeti",
    "IOC协作调查平台: observable→indicator→sighting证据链组织",
    "开源自托管", "方法论参考", 2040)
add(L5, "bbot", "https://github.com/blacklanternsecurity/bbot",
    "递归互联网扫描: 目标→发现→新目标递归展开(OSINT树状调查法)",
    "开源自托管(Python)", "方法论参考", 10886)
add(L5, "worldmonitor", "https://github.com/koala73/worldmonitor",
    "实时全球情报仪表盘: AI新闻聚合+地缘监测+基础设施事件(情报台形态样本)",
    "开源自托管", "方法论参考", 89667)
add(L5, "sherlock", "https://github.com/sherlock-project/sherlock",
    "用户名跨站追踪(750+社交网络): 单一标识→全网画像的起点方法",
    "开源CLI", "方法论参考", 95039)
add(L5, "maigret", "https://github.com/soxoj/maigret",
    "人物卷宗: 6000+网站用户名聚合出完整dossier",
    "开源CLI", "方法论参考", 39394)
add(L5, "web-check", "https://github.com/lissy93/web-check",
    "网站全维OSINT分析一站式(37+检查项)",
    "开源自托管(Web)", "方法论参考", 35265)
add(L5, "social-analyzer", "https://github.com/qeeqbox/social-analyzer",
    "社媒画像API/CLI/Web(1000+站点检测)",
    "开源自托管", "方法论参考", 24396)
add(L5, "GHunt", "https://github.com/mxrch/GHunt",
    "Google账号情报框架(offensive OSINT)",
    "开源CLI", "方法论参考", 19753)
add(L5, "phoneinfoga", "https://github.com/sundowndev/phoneinfoga",
    "电话号码情报框架(号段/运营商/足迹)",
    "开源CLI(Go)", "方法论参考", 18301)
add(L5, "theHarvester", "https://github.com/laramies/theHarvester",
    "邮箱/子域名/人名/主机收割器(经典信息收集)",
    "开源CLI(Python)", "方法论参考", 18068)
add(L5, "voidaccess", "https://github.com/KatrielMoses/voidaccess",
    "自托管暗网OSINT平台: 查询→图谱13步自动化(HN 188pt)",
    "开源自托管", "方法论参考", 945, "HN近180天发现")
add(L5, "ogi", "https://github.com/khashashin/ogi",
    "开源链接分析与OSINT框架(Maltego开源直替): 实体-关系调查图",
    "开源自托管", "需改造", 335)
add(L5, "awesome-hacker-search-engines", "https://github.com/edoardottt/awesome-hacker-search-engines",
    "黑客搜索引擎大全(按调查目标分类): 竞争对手情报检索地图",
    "开源清单", "方法论参考", 11428)
add(L5, "awesome-osint", "https://github.com/jivoi/awesome-osint",
    "OSINT资源总库(经典): 全品类调查方法入口",
    "开源清单", "方法论参考", 30507)
add(L5, "Awesome-OSINT-List", "https://github.com/Astrosp/Awesome-OSINT-List",
    "OSINT工具分类库(红队/侦察/企业情报分册)",
    "开源清单", "方法论参考", 4602)
add(L5, "Anthropic-Cybersecurity-Skills", "https://github.com/mukul975/Anthropic-Cybersecurity-Skills",
    "817条结构化网络安全技能, 映射MITRE ATT&CK/NIST CSF等六框架(结构化方法论skill化样本)",
    "Agent skills即装即用", "可直接采用", 35128)
add(L5, "querytool", "https://github.com/osintshifu/querytool",
    "本地优先独立OSINT查询工具: 源过滤+定向开搜(调查者的搜索调度台)",
    "开源自托管", "可直接采用", 326)
add(L5, "awesome-osint-repos", "https://github.com/osintshifu/awesome-osint-repos",
    "OSINT工具/技能/插件/MCP/agentic集成持续目录",
    "开源清单", "方法论参考", 90)
add(L5, "OSINT-for-countries", "https://github.com/paulpogoda/OSINT-for-countries-V2.0-MOVED",
    "分国OSINT资源(面向事实核查员与数字画像师结构化)",
    "开源清单", "方法论参考", 167)
add(L5, "deepdarkCTI", "https://github.com/fastfire/deepdarkCTI",
    "深暗网TI信源集(情报源扩展)",
    "开源清单", "方法论参考", 7433)
add(L5, "dnstwist", "https://github.com/elceef/dnstwist",
    "域名置换引擎: 检测仿冒/typo抢注/品牌侵权(竞争情报的品牌监测方法)",
    "开源CLI(Python)", "方法论参考", 5767)
add(L5, "user-scanner", "https://github.com/kaifcodec/user-scanner",
    "邮箱+用户名OSINT二合一套件, 原生MCP支持(agent化OSINT)",
    "开源MCP即挂", "可直接采用", 5494)

# ============ LANE 6: 研究报告质量评估 ============
add(L6, "DeepEval", "https://github.com/confident-ai/deepeval",
    "LLM评测框架(任务点名件): G-Eval等40+指标含忠实度/幻觉/引用, pytest式用例; 报告质量门机器化首选",
    "开源Apache-2.0(Python)", "可直接采用", 19145)
add(L6, "RAGAS", "https://github.com/vibrantlabsai/ragas",
    "RAG质量评测(任务点名件): 忠实度/答案相关/上下文精确召回等无参考评测指标族(原explodinggradients)",
    "开源Apache-2.0(Python)", "可直接采用", 16165)
add(L6, "promptfoo", "https://github.com/promptfoo/promptfoo",
    "prompt/agent/RAG评测+红队: 矩阵对比/断言/回归; 产线质量门工程件",
    "开源MIT(跨语言CLI)", "可直接采用", 26515)
add(L6, "langfuse", "https://github.com/langfuse/langfuse",
    "开源agent评测与可观测: trace-评分-数据集闭环(报告生产过程的留痕评审)",
    "开源自托管(TS)", "可直接采用", 36615)
add(L6, "opik", "https://github.com/comet-ml/opik",
    "LLM/RAG/agentic评测监控: 幻觉检测+在线评测",
    "开源Apache-2.0自托管", "可直接采用", 22975)
add(L6, "phoenix", "https://github.com/Arize-ai/phoenix",
    "AI可观测与评估: 实验追踪+LLM trace评估",
    "开源Apache-2.0(ELv2)", "可直接采用", 12033)
add(L6, "giskard", "https://github.com/Giskard-AI/giskard-oss",
    "LLM agent开源评测测试库: 自动扫描质量/安全缺陷+CI集成",
    "开源Apache-2.0(Python)", "可直接采用", 5931)
add(L6, "TruLens", "https://github.com/truera/trulens",
    "RAG triad评估: 上下文相关/接地性/答案相关三角(接地性=无证据支持即报错的工程化)",
    "开源MIT(Python)", "方法论参考", 3615)
add(L6, "OpenAI evals", "https://github.com/openai/evals",
    "OpenAI评测框架+开源基准注册表(评测即代码的鼻祖件)",
    "开源MIT(Python)", "方法论参考", 19663)
add(L6, "HELM", "https://github.com/stanford-crfm/helm",
    "斯坦福全景语言模型评测方法论(透明/多指标/场景矩阵的评估设计范式)",
    "开源Apache-2.0(Python)", "方法论参考", 2960)
add(L6, "lm-evaluation-harness", "https://github.com/EleutherAI/lm-evaluation-harness",
    "标准评测harness(数百任务统一口, 基准工程范式)",
    "开源MIT(Python)", "方法论参考", 14332)
add(L6, "iFixAi", "https://github.com/ifixai-ai/iFixAi",
    "AI agent独立审计(人审或agent自审): 回答「这agent到底行不行」的审计框架",
    "开源自托管", "方法论参考", 35945)
add(L6, "garak", "https://github.com/NVIDIA/garak",
    "NVIDIA的LLM漏洞扫描器(红队式质量探针)",
    "开源Apache-2.0(Python)", "方法论参考", 9729)
add(L6, "mlflow", "https://github.com/mlflow/mlflow",
    "AI工程平台含LLM评估(实验-评估-注册生产闭环)",
    "开源Apache-2.0", "方法论参考", 28563)
add(L6, "deepscholar", "https://github.com/guestrin-lab/deepscholar",
    "构建并benchmark深研系统(学术向); 评测驱动的深研构建方法论",
    "开源研究代码", "方法论参考", 247)
add(L6, "LiveResearchBench", "https://github.com/SalesforceAIResearch/LiveResearchBench",
    "Salesforce开放式深研活体基准+评测框架(动态任务防污染)",
    "开源(Python)", "方法论参考", 121)
add(L6, "ResearchClawBench", "https://github.com/InternScience/ResearchClawBench",
    "自动化研究评测: 从再发现到新发现分级评测AI agent",
    "开源研究代码", "方法论参考", 276)
add(L6, "BrowseComp-Plus", "https://github.com/texttron/BrowseComp-Plus",
    "更公平透明的深研agent评测基准(ACL2026 Main, 反作弊设计)",
    "开源(基准+代码)", "方法论参考", 385, "HN近180天发现")
add(L6, "ReportBench", "https://github.com/ByteDance-BandAI/ReportBench",
    "字节学术综述任务深研agent综合基准",
    "开源研究代码", "方法论参考", 56)
add(L6, "livedrbench", "https://github.com/microsoft/livedrbench",
    "微软活体深研基准(挑战性客观任务)",
    "开源研究代码", "纯论文", 22)
add(L6, "SGI-Bench", "https://github.com/InternScience/SGI-Bench",
    "科学家对齐工作流探针(用工作流测科学通识智能)",
    "开源研究代码", "纯论文", 172)
add(L6, "agent-review-studio", "https://github.com/chasedndt/agent-review-studio",
    "本地优先证据评审/评估/精炼工作台(agent产物的人工评审台)",
    "开源自托管", "方法论参考", 1, "HN近180天发现")
add(L6, "Deterministic-Judge(论文)", "https://arxiv.org/abs/2606.22737",
    "有状态agent评测中LLM评审的确定性替代(arXiv 2606.22737, HN发现): 评审去随机化",
    "论文", "纯论文", None, "HN近180天发现")

# ================= 编译 =================
lanes_meta = {
    L1: "聚焦「怎么组织研究」: 计划-执行-综合-自检的编排架构(深研agent/自动科研/工作流引擎)",
    L2: "多agent系统的角色分工机制: researcher/writer/critic如何分配/交接/对抗",
    L3: "每句话有出处: claim抽取-分解-检索-判定-修订的证据链工程",
    L4: "比向量检索更深的关联推理: 图RAG/知识图谱/时序图谱/多跳推理",
    L5: "顶级情报机构的结构化调查方法: 威胁情报平台/OSINT自动化/链接分析",
    L6: "机器化判断「报告达到世界顶级」: RAG评测/LLM评审/活体基准/审计",
}

out = {
    "_doc": "世界顶级调研能力终极提案·调研波1: 研究方法论框架与AI研究编排系统普查(GitHub+HN180天+WebSearch); 聚焦怎么调研而非数据从哪来; 只登记不装不clone",
    "wave": "ultimate_proposal/survey_methodology",
    "generated": "2026-10-28",
    "method": "gh api search/repositories(topic:deep-research×3页/topic:research-agent×2页/topic:auto-research/graphrag/osint/threat-intelligence/fact-checking/llm-evaluation + 具名repo直查60+件) + HN Algolia近180天10查询 + WebSearch缺口补查; stars全部为gh api实测(2026-10-28), 零手填",
    "dedup_baseline": "上轮620项渠道普查(channels_survey_2026, 1025)已登记80个GitHub研究agent仓(_raw/prev_survey_repos.txt); 本轮除8件任务点名锚定件(note=prev_survey复登, 以方法论角度复登)外全部新增零重复",
    "fit_legend": {
        "可直接采用": "开源/即装即用, 直接接入研报产线",
        "需改造": "能力对口但需剥离场景(如软件公司模拟改研究公司)",
        "方法论参考": "读方法不抄代码(流程/指标/角色设计借鉴)",
        "纯论文": "论文+研究代码, 只取思想",
    },
    "stats": {},
    "lanes": [],
}

by_lane = collections.OrderedDict((k, []) for k in lanes_meta)
for item in P:
    by_lane[item["lane"]].append(item)

fit_cnt = collections.Counter(i["fit"] for i in P)
for lane, items in by_lane.items():
    items.sort(key=lambda x: -(x["stars"] if x["stars"] else 0))
    out["lanes"].append({"lane": lane, "focus": lanes_meta[lane], "count": len(items), "projects": items})

out["stats"] = {
    "total_items": len(P),
    "by_lane": {k: len(v) for k, v in by_lane.items()},
    "by_fit": dict(fit_cnt),
    "prev_survey复登锚定件": sum(1 for i in P if "prev_survey" in (i.get("note") or "")),
    "新增零重复件": sum(1 for i in P if "prev_survey" not in (i.get("note") or "")),
}

path = "E:/AI-Station/reforge_factory/ultimate_proposal/survey_methodology.json"
with open(path, "w", encoding="utf-8") as f:
    json.dump(out, f, ensure_ascii=False, indent=1)
print(json.dumps(out["stats"], ensure_ascii=False, indent=1))
print("written:", path)
