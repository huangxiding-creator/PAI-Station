# -*- coding: utf-8 -*-
"""第 11 路：感知型意图识别调研卷宗生成器（2026-09-15）。

数据来源：
- GitHub REST API 两批实测（_recon/gh_survey_out.tsv + gh_survey2_out.tsv，09-15）
- metaso 学术检索 2 轮（scholar：GUI agent 综述 + 桌面活动任务识别学术脉络）
字段：name/category/stars/pushed_at/license/intent_route/lesson_for_pai/evidence_url/relevance
"""
import json
import os

R = []  # (name, category, stars, pushed_at, license, intent_route, lesson, url, relevance)


def add(*row):
    R.append(dict(zip(
        ("name", "category", "stars", "pushed_at", "license",
         "intent_route", "lesson_for_pai", "evidence_url", "relevance"), row)))


# ============ A. perceptual-context 感知型个人上下文（12） ============
add("screenpipe", "perceptual-context", 21576, "2026-09-14", "NOASSERTION",
    "连续录屏→本地 OCR/视觉结构化→向量化管道喂 agent（Open Computer History）",
    "原始动态信息流的工程标杆：捕获层与理解层彻底分离，插件式 pipe 消费事件流——PAI sense 层的同构放大版",
    "https://github.com/screenpipe/screenpipe", 5)
add("ActivityWatch", "perceptual-context", 18887, "2026-09-10", "MPL-2.0",
    "window/AFK 两类 bucket 聚合活动事件→应用/标题维度时间线",
    "bucket 模型=事件流分段的现成范式：焦点窗口变更+AFK 边界即可切出「活动段」，是意图识别的第一道工序",
    "https://github.com/ActivityWatch/activitywatch", 5)
add("Windrecorder", "perceptual-context", 3938, "2026-09-16", "GPL-2.0",
    "小体积连续录屏+OCR 索引→「屏幕记忆」检索",
    "中文原生、Windows 优先、隐私本地——与 PAI 同平台同语言生态的屏幕记忆参照；OCR 帧去重与索引策略可借鉴",
    "https://github.com/yuka-friends/Windrecorder", 4)
add("MIRIX", "perceptual-context", 3441, "2026-09-12", "Apache-2.0",
    "多 agent 个人助理 track on-screen activities：屏幕活动→六类记忆（core/episodic/semantic/procedural/resource/knowledge-vault）→问答",
    "「屏幕活动→结构化记忆分层」的完整映射表；六类记忆与 PAI profile 五层（M5）互为校对清单",
    "https://github.com/Mirix-AI/MIRIX", 5)
add("OpenRecall", "perceptual-context", 2939, "2025-09-24", "AGPL-3.0",
    "Windows Recall 开源替代：截屏+OCR+本地嵌入→活动时间线",
    "隐私优先叙事的产品化样本：默认全本地、明确数据边界——PAI 对外叙事直接参照",
    "https://github.com/openrecall/openrecall", 3)
add("OpenAdapt", "perceptual-context", 1725, "2026-09-14", "MIT",
    "GUI 任务演示录制→编译为程序→独立检查同意才报 VERIFIED",
    "「状态-动作对」数据化的工程样板：活动流不只用于理解，还可沉淀为可验证的复现程序（技能 forge 的取证标准）",
    "https://github.com/OpenAdaptAI/OpenAdapt", 4)
add("efficient-recorder", "perceptual-context", 234, "2026-02-03", "-",
    "Rewind.ai 隐私替代：活动捕获层", "捕获层轻量化参照", "https://github.com/janwilmake/efficient-recorder", 2)
add("ScreenMind", "perceptual-context", 213, "2026-09-10", "MIT",
    "截屏→Gemma 3 视觉分析→屏幕历史 search/chat",
    "小模型本机跑通「屏幕记忆+对话」的最小闭环证明；低配档（tiers）可复用此路线",
    "https://github.com/ayushh0110/ScreenMind", 3)
add("rewindos", "perceptual-context", 51, "2026-06-24", "AGPL-3.0",
    "Linux 版 Recall 替代：截屏+OCR+全文索引", "跨平台同构印证", "https://github.com/jaypopat/rewindos", 2)
add("silver-beetle（银甲虫）", "perceptual-context", 3, "2026-05-24", "-",
    "完全本地 Windows 个人上下文智能体：应用窗口+文件活动+剪贴板类型+屏幕理解+本地 LLM→日报/时间线/项目记忆/上下文接力",
    "与 PAI-Station 感知→意图→记忆链路几乎同构的独立实现（低星但同构度全场最高）：其信号选型（窗口/文件/剪贴板三源）与产出形态（时间线/项目记忆/接力）是直接可抄的骨架",
    "https://github.com/liurixxx/silver-beetle", 5)
add("kuangye", "perceptual-context", 3, "2026-07-30", "Apache-2.0",
    "通用视觉智能体底座：看懂屏幕→理解上下文→执行→从经验学习", "国产「屏幕理解+经验学习」叙事参照", "https://github.com/chenjicai2024/kuangye", 2)
add("Screen-Mate", "perceptual-context", 1, "2025-11-30", "-",
    "观察屏幕→理解上下文→主动建议", "主动式（proactive）最小样本：先理解后开口的交互次序印证 PAI 打扰预算设计", "https://github.com/Pranav0402/Screen-Mate-A-Context-Aware-Intelligent-Screen-Assistant", 2)

# ============ B. gui-grounding 屏幕理解/定位模型（10） ============
add("UI-TARS-desktop", "gui-grounding", 38979, "2026-09-11", "Apache-2.0",
    "端到端原生 GUI agent 模型栈：大规模截图预训练感知+统一动作空间+System-2 慢思考（任务分解/反思/里程碑识别）",
    "感知升级件的最高标杆：截图直接→结构化理解（免 UIA）；其 System-2 三件套（分解/反思/里程碑）同时是意图推理的提示工程模板",
    "https://github.com/bytedance/UI-TARS-desktop", 5)
add("OmniParser", "gui-grounding", 25389, "2026-07-20", "CC-BY-4.0",
    "纯视觉截图解析：检测+OCR→可交互元素结构化清单",
    "PAI 屏幕感知升级首选件：把 vision.py 的增量截图变成结构化 UI 状态（元素+文本+坐标），供 L1/L2 共用；与 UIA 双通道互补",
    "https://github.com/microsoft/OmniParser", 5)
add("ShowUI", "gui-grounding", 1898, "2026-04-24", "Apache-2.0",
    "CVPR'25 端到端 VLA：视觉-语言-动作统一训练，UI 引导的视觉_token_选择",
    "端到端路线代表；其「UI 引导 token 筛选」思路可降低屏幕理解算力成本", "https://github.com/showlab/ShowUI", 3)
add("ml-ferret（Ferret-UI）", "gui-grounding", 8663, "2026-09-11", "NOASSERTION",
    "Apple 屏幕理解 VLM：任意分辨率原生处理移动/桌面 UI 问答",
    "大厂屏幕理解基线；「屏幕问答」能力形态即 L2 慢通道的感知后端候选", "https://github.com/apple-aiml-research/ml-ferret", 3)
add("CogVLM", "gui-grounding", 6740, "2024-05-29", "Apache-2.0",
    "通用 VLM 底座（CogAgent 系列的视觉基座）", "国产 VLM 选型池一员", "https://github.com/zai-org/CogVLM", 2)
add("SeeClick", "gui-grounding", 494, "2025-07-13", "Apache-2.0",
    "南京大学 GUI grounding 预训练：截图→可点击元素定位（njucckevin/SeeClick）",
    "GUI 预训练学术线代表作；轻量 grounding 权重可用于低配档", "https://github.com/njucckevin/SeeClick", 3)
add("Aria-UI", "gui-grounding", 411, "2025-02-08", "-",
    "快速上下文感知 action grounding（GUI 指令→元素）",
    "「快速+上下文感知」定位路线：证明 grounding 可以做到近实时（L1 快通道的感知补充）", "https://github.com/AriaUI/Aria-UI", 3)
add("OS-Atlas", "gui-grounding", 455, "2025-04-20", "Apache-2.0",
    "foundation action model：跨平台统一动作空间预训练",
    "动作空间统一化的基础工作；对 PAI 的启示=动作原语标准化（click/type/scroll/...）先于技能复杂化", "https://github.com/OS-Copilot/OS-Atlas", 3)
add("UGround", "gui-grounding", 318, "2026-08-24", "MIT",
    "ICLR'25 Oral：统一视觉 grounding（截图对话→元素定位）",
    "顶会 oral 级方法论：视觉 grounding 作为通用能力底座的学术定调", "https://github.com/OSU-NLP-Group/UGround", 3)
add("dsh-grounding", "gui-grounding", 0, "2026-08-22", "MIT",
    "本地 OCR GUI grounding 插件（无 GPU 依赖）",
    "零星但证明「本地轻量 grounding」可行：低配档兜底路线的存在性证据", "https://github.com/Tinzlu/dsh-grounding", 2)

# ============ C. cua-framework 执行型 agent 框架（11） ============
add("pi", "cua-framework", 105116, "2026-09-14", "MIT",
    "agent toolkit：统一 LLM API+agent loop+TUI+coding agent CLI（earendil-works）",
    "当前 agent 工程的事实级底座之一；事件循环与会话结构设计可参照", "https://github.com/earendil-works/pi", 3)
add("browser-use", "cua-framework", 114628, "2026-09-13", "MIT",
    "浏览器 agent 事实标准：DOM+视觉双通道理解页面",
    "DOM+视觉双通道=结构化优先、视觉兜底的感知分层——与 PAI「UIA 优先、视觉兜底」同构", "https://github.com/browser-use/browser-use", 3)
add("open-interpreter", "cua-framework", 68321, "2026-09-14", "Apache-2.0",
    "本地代码执行 agent（openinterpreter）", "执行侧参照：意图→代码动作的安全边界设计", "https://github.com/openinterpreter/openinterpreter", 2)
add("skyvern", "cua-framework", 23002, "2026-09-15", "AGPL-3.0",
    "浏览器工作流自动化：视觉+DOM 混合定位", "工作流（workflow）粒度的任务抽象参照", "https://github.com/Skyvern-AI/skyvern", 2)
add("Agent-S（S3）", "cua-framework", 12294, "2026-09-05", "Apache-2.0",
    "bBoN 行为优选（行为叙事生成+最佳选择评判）+原生代码 agent，去除 manager-worker 层级",
    "bBoN=把「多方案并述再选优」做成机制；对 PAI 的迁移：L2 慢通道对模糊段生成多个意图假设并自评，而非单次贪心解码", "https://github.com/simular-ai/Agent-S", 4)
add("self-operating-computer", "cua-framework", 10296, "2025-09-19", "MIT",
    "多模态模型操作计算机框架", "早期教育性项目：模块划分（截图/推理/动作）至今仍是标准三段式", "https://github.com/OthersideAI/self-operating-computer", 2)
add("UFO³", "cua-framework", 9730, "2026-09-14", "MIT",
    "微软 Windows 原生 agent：AppAgent（选择应用）×ActionAgent（执行动作）双 agent + UIA 优先",
    "Windows 平台+UIA 结构化数据优先的同路人：其「双 agent 分工」对 PAI 的启示=「意图发现」与「动作执行」必须解耦成两个循环", "https://github.com/microsoft/UFO", 4)
add("MobileAgent", "cua-framework", 9199, "2026-07-07", "MIT",
    "X-PLUG 移动 GUI agent 家族：多 agent 协作+跨 app", "多应用任务链（跨 app 交接）参照", "https://github.com/X-PLUG/MobileAgent", 2)
add("AppAgent", "cua-framework", 6881, "2025-03-19", "MIT",
    "腾讯：探索期自学 app 操作文档→部署期依文档行动",
    "「先探索建文档，再依文档行动」=无监督知识沉淀两阶段法，PAI 意图层可对称使用（先观察建意图库，再依库快判）", "https://github.com/TencentQQGYLab/AppAgent", 4)
add("OS-Copilot", "cua-framework", 1794, "2024-09-09", "MIT",
    "自我改进的 OS 常驻对话 agent", "常驻式 OS agent 早期形态；自改进叙事的先行者", "https://github.com/OS-Copilot/OS-Copilot", 2)
add("AppAgentX", "cua-framework", 672, "2025-04-15", "-",
    "自进化 GUI agent：执行经验→抽象为可复用技能（Westlake-AGI-Lab）",
    "「经验→技能」升格机制的 agent 版：与 PAI skill forge（M6）同构，提供意图层→技能层的升格参照", "https://github.com/Westlake-AGI-Lab/AppAgentX", 4)

# ============ D. intent-nlu 对话/语音意图识别（11） ============
add("rasa", "intent-nlu", 21324, "2026-07-24", "Apache-2.0",
    "工业级 NLU：意图分类+实体抽取+对话管理（.story 规则+ML 双引擎）",
    "意图识别的工业基线：意图-实体（槽位）数据结构与评估集惯例直接沿用；PAI 语音 utterance→意图可套用其标注体系", "https://github.com/RasaHQ/rasa", 4)
add("moonshine", "intent-nlu", 11071, "2026-08-31", "NOASSERTION",
    "极低延迟语音识别+意图识别+TTS 一体",
    "「语音→意图」端到端低延迟路线：PAI 语音链路（M1）的延迟预算参照", "https://github.com/moonshine-ai/moonshine", 3)
add("DeepPavlov", "intent-nlu", 6988, "2025-08-06", "Apache-2.0",
    "端到端对话系统工具箱（意图/槽位/NER）", "NLU 组件库备选", "https://github.com/deeppavlov/DeepPavlov", 2)
add("voice2json", "intent-nlu", 1105, "2024-03-07", "MIT",
    "命令行语音→意图（Hermes 协议意图模板）",
    "「意图模板文件+本地语音」的极简可组合范式：意图 schema 即配置文件", "https://github.com/synesthesiam/voice2json", 3)
add("IntelliQ", "intent-nlu", 683, "2025-07-17", "Apache-2.0",
    "LLM 意图识别+参数抽取+词槽技术→多轮问答 NL2API",
    "中文场景「意图→槽位→函数调用」完整实现样例；NL2API 与 PAI 任务卡→执行（M4）的映射同构", "https://github.com/answerlink/IntelliQ", 4)
add("TEXTOIR", "intent-nlu", 254, "2026-05-18", "MIT",
    "清华 thuiar 开放意图识别工具包（ACL'21）：已知意图分类+开放意图发现+新意图归纳三模块",
    "「开放意图识别」正是 PAI 需求的学术命名：不能预设意图全集，须能发现新意图并归纳成类——工具包可直接用作 L1 候选算法", "https://github.com/thuiar/TEXTOIR", 5)
add("MIntRec", "intent-nlu", 141, "2025-05-02", "MIT",
    "清华多模态意图识别数据集（ACM MM'22）：文本+语音+视频三模态意图标注",
    "多模态意图 ground truth 的标注规范参照：PAI 金标准集（意图版）的字段设计蓝本", "https://github.com/thuiar/MIntRec", 3)
add("xvfeng-Vehicle-AI-Assistant", "intent-nlu", 17, "2025-08-10", "Apache-2.0",
    "车载助手：微调小型语义模型+商用大模型双层意图识别+无关语义拒识，400+技能",
    "「双层意图识别+无关拒识」方法论实证：L1 小模型粗筛→L2 大模型细判→置信不足输出『无关』——PAI 拒识门的直接模板，且证明小模型层可微调到手", "https://github.com/JasonGuoStomachache/xvfeng-Vehicle-AI-Assistant", 5)
add("finance-intelligent-agent", "intent-nlu", 20, "2026-09-04", "MIT",
    "LangGraph 财富管理客服：意图识别+槽位填充+函数调用+混合 RAG",
    "LangGraph 状态机编排意图流的工程样板：节点即意图处理阶段，与 PAI 服务化编排对齐", "https://github.com/look378/finance-intelligent-agent", 3)
add("Lincan-Travel-Assistant-Agent", "intent-nlu", 15, "2026-08-20", "-",
    "Plan-and-Execute 旅行助手：6 大类意图识别（90%+）+两层记忆（Redis 短期+长期）",
    "「意图分类准确率 90%+」的可达成性参照+两层记忆与 L1/L2 双速通道同构", "https://github.com/LC-di-yan/Lincan-Travel-Assistant-Agent", 3)
add("llm_intend", "intent-nlu", 11, "2024-08-14", "Apache-2.0",
    "大模型意图识别最小实现", "LLM 直判意图的 baseline 形态", "https://github.com/yanyg123/llm_intend", 2)

# ============ E. memory-selfevolve 记忆/自进化基建（4） ============
add("mem0", "memory-selfevolve", 65290, "2026-09-14", "Apache-2.0",
    "agent 记忆层：抽取→整合→检索，对话/事件双源",
    "记忆基建事实标准：其「抽取-冲突消解-固化」三步与 PAI NightConsolidator（M5）互为印证", "https://github.com/mem0ai/mem0", 3)
add("graphiti", "memory-selfevolve", 30872, "2026-09-11", "Apache-2.0",
    "实时时序知识图谱（Zep 内核）：实体/事实/社区三层的 bi-temporal 模型",
    "意图上下文的时序底座首选：bi-temporal（有效时间≠录入时间）正是 PAI profile 双时间线（effective_to 封口）的同款设计，图谱化升级位", "https://github.com/getzep/graphiti", 5)
add("letta", "memory-selfevolve", 24737, "2026-09-10", "Apache-2.0",
    "有状态 agent 平台（MemGPT 系）：核心记忆/召回记忆分层+自编辑记忆",
    "「agent 自编辑记忆」机制参照：意图确认后由 agent 自己更新记忆块（PAI 夜间提案的人工闸版本已实现，其自动化程度更高）", "https://github.com/letta-ai/letta", 3)
add("MemOS", "memory-selfevolve", 11320, "2026-09-09", "Apache-2.0",
    "自进化记忆 OS：超持久+混合检索+跨任务技能沉淀",
    "「记忆即操作系统」叙事：跨任务技能沉淀与 PAI skill forge+effects（M6）对齐", "https://github.com/MemTensor/MemOS", 3)

# ============ F. process-mining 任务/流程挖掘（2） ============
add("pm4py", "process-mining", 1027, "2026-09-01", "AGPL-3.0",
    "流程挖掘标准库：事件日志→流程模型（发现/一致性/增强）",
    "活动段序列→工作流模型的现成算法箱：PAI 可用其对意图序列做 workflow 发现（自动过程挖掘），AGPL 需隔离调用", "https://github.com/process-intelligence-solutions/pm4py", 4)
add("openrpa", "process-mining", 3062, "2026-04-15", "MPL-2.0",
    "企业级开源 RPA（录制回放）", "录制回放的边界样本：无理解纯复刻的天花板（反面定位 PAI 的理解型路线）", "https://github.com/open-rpa/openrpa", 2)

# ============ G. benchmark 基准（2） ============
add("OSWorld", "benchmark", 3142, "2026-09-14", "Apache-2.0",
    "真实计算机环境多模态 agent 基准（NeurIPS'24）",
    "「真实环境任务完成度」评估范式：PAI 意图层验收可借其 config→observation→action→eval 结构", "https://github.com/xlang-ai/OSWorld", 3)
add("android_world", "benchmark", 900, "2026-09-09", "Apache-2.0",
    "Android 自主 agent 基准环境", "跨平台基准参照", "https://github.com/google-research/android_world", 2)

# ============ H. awesome 索引（5） ============
add("acu", "awesome-index", 1758, "2025-09-26", "-",
    "computer use 资源总目（trycua）", "追踪新项目的哨点", "https://github.com/trycua/acu", 2)
add("Awesome-GUI-Agent", "awesome-index", 1217, "2025-08-17", "-",
    "showlab GUI agent 论文资源清单", "论文雷达", "https://github.com/showlab/Awesome-GUI-Agent", 2)
add("GUI-Agents-Paper-List", "awesome-index", 902, "2026-09-14", "-",
    "OSU-NLP 论文清单（持续更新）", "论文雷达", "https://github.com/OSU-NLP-Group/GUI-Agents-Paper-List", 2)
add("awesome-computer-use", "awesome-index", 583, "2026-04-15", "-",
    "ranpox 计算机使用资源", "工程雷达", "https://github.com/ranpox/awesome-computer-use", 2)
add("Awesome-Gui-Agents", "awesome-index", 70, "2025-08-26", "MIT",
    "浏览器/计算机 GUI agent 清单", "工程雷达", "https://github.com/supernalintelligence/Awesome-Gui-Agents", 2)

# ============ I. academic 学术论文/系统（14，evidence=metaso scholar 检索 09-15） ============
add("TaskTracer（2005）", "academic", None, "2005", "-",
    "Dragunov et al.：任务=持续存在且与固定资源组绑定的假设；采集 Office/浏览器可见事件流识别任务",
    "领域奠基：『任务-资源关联』假设 20 年未倒——PAI 的 fs_watcher 信号价值由此定调（文件活动是最强任务指纹）",
    "metaso scholar: TaskTracer: a desktop environment to support multi-tasking knowledge workers (IUI 2005)", 5)
add("SWISH（2006）", "academic", None, "2006", "-",
    "Nuria Oliver et al.：Windows 事件流→窗口标题+切换历史→语义归一化→聚类，类簇即任务",
    "『标题语义+切换历史』至今是 L1 快通道的最优特征组合（零成本、跨应用、语言鲁棒）",
    "metaso scholar: SWISH: semantic analysis of window titles and switching history (IUI 2006)", 5)
add("TaskPredictor（2007）", "academic", None, "2007", "-",
    "Shen & Dietterich：焦点窗口特征→判别式分类器输出任务概率；多窗预测融合（投票/似然比检验/Viterbi）",
    "『单窗分类+序列融合』两段式：Viterbi（任务转移代价模型）抑制窗口级抖动——PAI L1 输出的平滑器蓝本",
    "metaso scholar: Real-Time Detection of Task Switches of Desktop Users (IUI 2007)", 5)
add("TaskPredictor2 / Shen 学位论文（2009）", "academic", None, "2009", "-",
    "在线学习任务切换预测；三层活动模型（功能操作/工作流/任务）+资源信息流图两阶段挖掘→逻辑 HMM",
    "『功能操作→工作流→任务』三层抽象=PAI 事件→活动段→意图 的直接学术对应；在线学习=标注样本随用随更新的飞轮原型",
    "metaso scholar: Activity recognition in desktop environments (Shen, OHSU 2009)", 5)
add("Brdiczka 无监督任务恢复", "academic", None, "-", "-",
    "PARC：纯交互行为（打开/关闭/切换/粘贴）聚类资源→恢复任务模型，不读文档内容",
    "隐私最优路线证明：只凭行为不读内容也能聚类出任务——PAI 隐私档（只采元数据）的理论底气",
    "metaso scholar: 转引自 结合用户交互行为和资源内容的资源推荐（2014）", 4)
add("SummAct（2025）", "academic", None, "2025", "-",
    "Zhang et al.：LLM+上下文学习总结交互行为→切分子目标→加权 UI 元素→推导高层意图，较基线 +21.9%",
    "感知型意图识别的最新 SOTA 形态=『行为摘要』而非『逐步分类』：与 PAI L2 慢通道（段摘要→LLM 意图）设计完全一致，且证明 ICL 路线无需微调即可领先",
    "metaso scholar: SummAct: Uncovering User Intentions Through Interactive Behaviour Summarisation (2025)", 5)
add("UI-TARS 模型（2025-01）", "academic", None, "2025-01", "-",
    "字节跳动原生 GUI agent 模型：增强感知（截图预训练）+统一动作空间+System-2 慢思考（任务分解/反思/里程碑识别）",
    "感知与推理的分层定式：『里程碑识别』对 PAI 的独特价值=长任务的进度感知（当前段处于任务哪一里程碑）",
    "metaso scholar: UI-TARS: Pioneering Automated GUI Interaction with Native Agents (2025-01)", 4)
add("GUI-Actor（2025）", "academic", None, "2025", "-",
    "无坐标自由视觉 grounding（coordinate-free）",
    "『元素引用而非坐标』的 grounding 哲学：PAI 屏幕状态应存『元素身份』而非像素坐标（抗分辨率/布局漂移）",
    "metaso scholar: GUI-Actor: Coordinate-Free Visual Grounding for GUI Agents (2025)", 3)
add("SE-GA（ICML'26）", "academic", None, "2026", "-",
    "天津大学+上交：分层记忆结构+迭代自我改进，解决『记不住/学不会』",
    "分层记忆自进化的学术定调：与 MIRIX 六类记忆、PAI profile 五层三方互证『分层是记忆的必要条件』",
    "metaso scholar: SE-GA: Memory-Augmented Self-Evolution (ICML 2026)", 3)
add("AWM（Agent Workflow Memory）", "academic", None, "-", "-",
    "向量检索已有轨迹中的抽象子路径（workflow）注入 prompt 增强决策",
    "『抽象工作流』作为记忆单元：PAI 意图序列→抽象工作流（如：调研→建卷宗→写台账）可检索复用，比存原始轨迹省一个量级上下文",
    "metaso scholar: Agent Workflow Memory（转引 GUI-Actor 优化方向）", 4)
add("UItron（2025-08）", "academic", None, "2025-08", "-",
    "多级推理格式：简单任务直接输出动作；复杂任务先 think；最难任务强制『观察屏幕变化』再分析",
    "复杂度自适应推理深度的具体分级法——PAI L2 的路由表（直判/think/观察证据再判）直接照抄此三档",
    "metaso scholar: UItron: Foundational GUI Agent with Advanced Perception and Planning (2025-08)", 5)
add("LongPerceptualThoughts（2025）", "academic", None, "2025", "-",
    "把 System-2 推理蒸馏进 System-1 感知（UofT+Purdue）",
    "降本路线图：L2 的慢推理结论蒸馏回 L1 快通道（今日 LLM 判过的意图类型，明日小模型直判）",
    "metaso scholar: LongPerceptual Thoughts: Distilling System-2 Reasoning for System-1 Perception (2025)", 4)
add("Agent S3 / bBoN（2025-10）", "academic", None, "2025-10", "-",
    "行为叙事生成+最佳选择评判（bBoN）；去除 manager-worker 层级改原生代码 agent",
    "『多假设自评』与『扁平化编排』两个工程判断：PAI 意图层无编排层级、直接函数管线；模糊段多意图假设并评",
    "metaso scholar: Agent S3: Computer-Use Agent with Behavior Best-of-N (2025-10)", 3)
add("OpenCUA / AgentNet（2025-26）", "academic", None, "-", "-",
    "港大：操作演示→带反思长链思维的『状态-动作对』数据基建+开源标注流水线+OpenCUA-32B",
    "数据飞轮的完整模板：用户演示（PAI=用户纠正）→结构化样本→模型进化；PAI 晨报确认的每次修正都应落 (segment, gold_intent) 对",
    "metaso scholar: OpenCUA: Building an Open Framework for Computer-Use Agents (HKU)", 4)

out = os.path.join(os.path.dirname(os.path.abspath(__file__)), "_all.json")
with open(out, "w", encoding="utf-8") as f:
    json.dump(R, f, ensure_ascii=False, indent=1)

cats = {}
for r in R:
    cats[r["category"]] = cats.get(r["category"], 0) + 1
print(f"OK {len(R)} items -> {out}")
print("categories:", cats)
assert all(len(r) == 9 for r in R), "schema 9 字段违规"
assert all(isinstance(r["relevance"], int) and 1 <= r["relevance"] <= 5 for r in R), "relevance 越界"
