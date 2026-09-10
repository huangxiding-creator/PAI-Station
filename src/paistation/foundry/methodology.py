"""方法论卡库（M7.0 / PROPOSAL_M7 §3.3）：重构引擎的弹药库。

36 张机器可读卡（L1 章层 12 / L2 节层 12 / L3 内容层 12），来源：
- AIResearch 知识萃取方法资料库（30+ 券商行业研究框架 + 100 思维模型）结构蒸馏
- 09-09 转录指定的顶级智库清单（麦肯锡/明托/芒格/毛选/混沌/曾鸣/德鲁克…）
版权纪律：只蒸馏框架结构并标注来源，不搬运原文（版权三态=结构参考）。
纯标准库；CARDS 为不可变元组（宪法：只读映射）。
"""

# 字段：id / name / one_liner / level / structure / scenarios / source
CARDS: tuple[dict, ...] = (
    # ---------- L1 章层：整份方案的大骨架 ----------
    {"id": "ooda", "name": "OODA 循环", "level": "L1",
     "one_liner": "观察→判断→决策→行动的快速闭环",
     "structure": "Observe 观察 → Orient 判断 → Decide 决策 → Act 行动 → 回到观察",
     "scenarios": "诊断-机会-路线-落地-度量的方案总骨架；快速迭代场景",
     "source": "博伊德（军事战略）"},
    {"id": "pdca", "name": "PDCA 双环", "level": "L1",
     "one_liner": "计划-执行-检查-处理，外环学习内环执行",
     "structure": "Plan 计划 → Do 执行 → Check 检查 → Act 处理；单环改流程，双环改认知",
     "scenarios": "实施路线图与度量体系章节；持续改进机制设计",
     "source": "戴明（丰田生产方式）"},
    {"id": "mckinsey7", "name": "麦肯锡七步法", "level": "L1",
     "one_liner": "从陈述问题到一路到底的解题程序",
     "structure": "陈述问题 → 拆分问题 → 排优先级 → 制定计划 → 关键分析 → 归纳论证 → 讲故事",
     "scenarios": "行业诊断章；把大问题拆成可解小题",
     "source": "麦肯锡（AIResearch 框架库）"},
    {"id": "pyramid", "name": "金字塔原理", "level": "L1",
     "one_liner": "结论先行，以上统下，归类分组，逻辑递进",
     "structure": "中心论点 → 一级支撑（MECE 分组）→ 二级论据 → 数据底座",
     "scenarios": "全方案叙述结构；推荐序与价值陈述",
     "source": "芭芭拉·明托（麦肯锡）"},
    {"id": "scqa", "name": "SCQA 序列", "level": "L1",
     "one_liner": "情境-冲突-问题-答案的开场结构",
     "structure": "Situation 情境 → Complication 冲突 → Question 问题 → Answer 答案",
     "scenarios": "方案引言与每章开头；制造阅读钩子",
     "source": "芭芭拉·明托"},
    {"id": "mece", "name": "MECE 原则", "level": "L1",
     "one_liner": "相互独立、完全穷尽地切分问题",
     "structure": "选定维度 → 二分/矩阵/流程切分 → 校验不重不漏 → 形成问题树",
     "scenarios": "机会矩阵的行列设计；章节切分校验",
     "source": "麦肯锡"},
    {"id": "iceberg", "name": "系统思考冰山模型", "level": "L1",
     "one_liner": "事件之下找模式，模式之下找结构，结构之下找心智",
     "structure": "事件层 → 趋势模式层 → 结构层 → 心智模式层",
     "scenarios": "行业痛点根因章；组织转型阻力分析",
     "source": "彼得·圣吉《第五项修炼》"},
    {"id": "doublediamond", "name": "双钻设计模型", "level": "L1",
     "one_liner": "先发散找对问题，再收敛做对方案",
     "structure": "探索（发散）→ 定义（收敛）→ 发展（发散）→ 交付（收敛）",
     "scenarios": "需求诊断与方案设计两阶段章节",
     "source": "英国设计协会（设计思维）"},
    {"id": "lean-loop", "name": "精益创业循环", "level": "L1",
     "one_liner": "构建-度量-学习的最小可行验证",
     "structure": "想法 → Build 构建 MVP → Measure 度量 → Learn 学习 → 转型或坚持",
     "scenarios": "L1 试点（90 天）路线设计",
     "source": "埃里克·莱斯《精益创业》"},
    {"id": "second-curve", "name": "第二曲线", "level": "L1",
     "one_liner": "在第一曲线到达顶点前开启第二曲线",
     "structure": "第一曲线（现有业务）→ 失速点识别 → 第二曲线投入窗口 → 新增长引擎",
     "scenarios": "行业转型时机判断章；企业 AI 升级的战略叙事",
     "source": "查尔斯·汉迪 / 李善友（混沌学园）"},
    {"id": "combination", "name": "组合创新", "level": "L1",
     "one_liner": "创新不是无中生有，而是旧要素新组合",
     "structure": "要素拆解（技术/产品/市场/组织）→ 重新组合 → 跨界化学反应 → 验证",
     "scenarios": "AI×行业的可能性发散章；机会矩阵生成",
     "source": "熊彼特 / 李善友（混沌学园）"},
    {"id": "jtbd", "name": "JTBD 焦糖布丁", "level": "L1",
     "one_liner": "用户雇佣产品是为了完成进步任务",
     "structure": "情境 → 想要的进步 → 动机 → 痛点 → 现有替代方案 → 雇佣/解雇判断",
     "scenarios": "行业客户需求诊断章；AI 产品切入点选择",
     "source": "克莱顿·克里斯坦森"},

    # ---------- L2 节层：章内的子框架 ----------
    {"id": "five-forces", "name": "五力模型", "level": "L2",
     "one_liner": "五种竞争力量决定行业盈利结构",
     "structure": "现有竞争者 → 潜在进入者 → 替代品 → 供应商议价力 → 买方议价力",
     "scenarios": "行业竞争格局节；AI 改变哪种力量分析",
     "source": "迈克尔·波特（AIResearch 框架库）"},
    {"id": "swot", "name": "SWOT 分析", "level": "L2",
     "one_liner": "优势劣势机会威胁四象限定位",
     "structure": "S 优势 × W 劣势（内部）× O 机会 × T 威胁（外部）→ SO/WO/ST/WT 策略",
     "scenarios": "企业 AI 转型起点评估节",
     "source": "商学院经典（斯坦福研究院）"},
    {"id": "blue-ocean", "name": "蓝海四行动", "level": "L2",
     "one_liner": "剔除-减少-增加-创造重构价值曲线",
     "structure": "剔除行业惯例 → 减少过度投入 → 增加行业标准 → 创造新价值",
     "scenarios": "AI 重构业务流程节；差异化策略设计",
     "source": "钱·金 / 莫博涅《蓝海战略》"},
    {"id": "bm-canvas", "name": "商业模式画布", "level": "L2",
     "one_liner": "九块画布看清一门生意",
     "structure": "客户细分×价值主张×渠道×客户关系×收入×核心资源×关键活动×伙伴×成本",
     "scenarios": "AI 落地后的商业模式重塑节",
     "source": "奥斯特瓦德《商业模式新生代》"},
    {"id": "ice", "name": "ICE 评分法", "level": "L2",
     "one_liner": "影响力×信心×易行性三度打分排序",
     "structure": "Impact 影响力(1-10) × Confidence 信心(1-10) × Ease 易行性(1-10) → 总分排序",
     "scenarios": "AI 机会矩阵优先级排序节",
     "source": "肖恩·埃利斯（增长黑客）"},
    {"id": "eisenhower", "name": "艾森豪威尔矩阵", "level": "L2",
     "one_liner": "按紧急重要四象限分配资源",
     "structure": "重要紧急→立即做；重要不紧急→排计划；紧急不重要→委托；其余→删除",
     "scenarios": "实施路线图任务排期节",
     "source": "时间管理经典（艾森豪威尔）"},
    {"id": "fogg", "name": "Fogg 行为模型", "level": "L2",
     "one_liner": "行为=动机×能力×提示，三者齐备才发生",
     "structure": "B = MAP：动机 Motivation × 能力 Ability × 提示 Prompt → 缺一不可",
     "scenarios": "组织 AI 采纳推广节；员工用起来的条件设计",
     "source": "福格（斯坦福行为设计实验室）"},
    {"id": "value-chain", "name": "价值链分析", "level": "L2",
     "one_liner": "把企业拆成价值创造环节找优化点",
     "structure": "进料后勤→生产→发货→营销→服务（主链）+ 采购/研发/人力/基建（辅链）",
     "scenarios": "AI 机会矩阵的行设计（环节×能力）",
     "source": "迈克尔·波特"},
    {"id": "stp", "name": "STP 定位", "level": "L2",
     "one_liner": "细分-选择-定位三步锁定市场",
     "structure": "Segmentation 细分 → Targeting 选择 → Positioning 定位",
     "scenarios": "方案服务的客户群定位节",
     "source": "科特勒 / 特劳特"},
    {"id": "risk-matrix", "name": "风险矩阵", "level": "L2",
     "one_liner": "概率×影响双维给风险分级",
     "structure": "概率(低中高) × 影响(低中高) → 九宫格 → 红/黄/绿区应对策略",
     "scenarios": "AI 实施风险与规避节",
     "source": "PMBOK 项目管理"},
    {"id": "raci", "name": "RACI 责任矩阵", "level": "L2",
     "one_liner": "谁负责谁批准谁被咨询谁被告知",
     "structure": "任务 × 角色 → R 负责 / A 批准 / C 咨询 / I 知会",
     "scenarios": "落地组织保障节；AI 转型专班分工",
     "source": "PMBOK 项目管理"},
    {"id": "compounding", "name": "智能复利飞轮", "level": "L2",
     "one_liner": "数据→模型→场景→反馈，越转越智能",
     "structure": "场景积累数据 → 数据训练模型 → 模型优化场景 → 反馈再积累（60 分奇点后黑洞效应）",
     "scenarios": "AI 落地度量体系节；复利对账设计",
     "source": "曾鸣《智能商业》"},

    # ---------- L3 内容层：节内表达与抄作业组件 ----------
    {"id": "checklist", "name": "清单检查法", "level": "L3",
     "one_liner": "关键动作用清单兜住不遗漏",
     "structure": "识别关键动作 → 拆成可勾选项 → 执行时逐项核对 → 持续修订",
     "scenarios": "避坑清单/上线检查表组件",
     "source": "阿图·葛文德《清单革命》"},
    {"id": "wbs", "name": "WBS 工作分解", "level": "L3",
     "one_liner": "把大任务拆到可直接执行的最小单元",
     "structure": "总目标 → 一级交付物 → 二级工作包 → 三级活动（可指派/可估算）",
     "scenarios": "抄作业组件：任务分解表",
     "source": "PMBOK 项目管理（AIResearch 框架库）"},
    {"id": "decision-tree", "name": "决策树", "level": "L3",
     "one_liner": "分支条件可视化每步选择",
     "structure": "决策节点 → 分支条件（是/否）→ 叶节点行动 → 概率与价值标注",
     "scenarios": "方案中的分场景决策指引",
     "source": "决策科学经典"},
    {"id": "swimlane", "name": "泳道流程图", "level": "L3",
     "one_liner": "按角色泳道展开跨部门流程",
     "structure": "角色泳道 × 步骤时序 → 节点（活动/判断/交接）→ 瓶颈标注",
     "scenarios": "业务关系流程图组件（Mermaid 渲染）",
     "source": "BPMN 流程建模"},
    {"id": "contrast-matrix", "name": "对比矩阵", "level": "L3",
     "one_liner": "多方案多维并排一目了然",
     "structure": "行=候选方案 × 列=评价维度 → 单元格打分/标注 → 结论行",
     "scenarios": "工具选型/方案比选表格",
     "source": "结构化写作（AIResearch 框架库）"},
    {"id": "inversion", "name": "逆向思维", "level": "L3",
     "one_liner": "想成功先研究怎样必然失败",
     "structure": "目标 → 反转（怎样搞砸）→ 列失败清单 → 逐条规避",
     "scenarios": "避坑清单生成法；风险预案",
     "source": "查理·芒格《穷查理宝典》"},
    {"id": "5whys", "name": "5Whys 根因分析", "level": "L3",
     "one_liner": "连问五个为什么挖到根因",
     "structure": "现象 → 为什么①→②→③→④→⑤ → 根因 → 对策（问不下去了即到位）",
     "scenarios": "问题复盘节；失败案例解剖",
     "source": "丰田生产方式"},
    {"id": "negative-list", "name": "负面清单避坑法", "level": "L3",
     "one_liner": "把教训固化成禁止事项",
     "structure": "事故/教训收集 → 提炼禁止条款 → 分类（红线/慎行/待议）→ 定期复审",
     "scenarios": "避坑清单组件；经验地图的坑位标注",
     "source": "工程实践 / AIResearch 知识萃取"},
    {"id": "infographic", "name": "信息图浓缩表达", "level": "L3",
     "one_liner": "一图胜千言的结构化浓缩",
     "structure": "提炼核心关系 → 选择图式（漏斗/循环/层级/矩阵）→ 极简标注 → 一眼看懂",
     "scenarios": "信息图组件（Mermaid/表格渲染）",
     "source": "数据可视化实践"},
    {"id": "case-embed", "name": "案例嵌入式教学", "level": "L3",
     "one_liner": "抽象方法配具体小案例降认知门槛",
     "structure": "方法陈述 → 真实小案例（背景-动作-结果）→ 回扣方法要点",
     "scenarios": "小案例组件（一堂掺水手法）",
     "source": "一堂 / 哈佛案例教学法"},
    {"id": "biz-formula", "name": "业务公式化", "level": "L3",
     "one_liner": "把业务逻辑浓缩成可计算公式",
     "structure": "识别业务变量 → 找到运算关系 → 写成公式 → 标注杠杆点",
     "scenarios": "业务公式组件；度量体系指标推导",
     "source": "量化管理实践（德鲁克目标管理）"},
    {"id": "contradiction", "name": "矛盾分析法", "level": "L3",
     "one_liner": "抓主要矛盾，具体问题具体分析",
     "structure": "列出诸矛盾 → 找主要矛盾与主要方面 → 分析矛盾转化条件 → 集中力量解决",
     "scenarios": "多方利益冲突节；转型阻力排序",
     "source": "毛泽东《矛盾论》《实践论》（毛选）"},
)

_BY_ID = {c["id"]: c for c in CARDS}


def card_count() -> int:
    """卡库总数（测试与验收用）。"""
    return len(CARDS)


def cards_by_level(level: str) -> list[dict]:
    """按层取卡（L1 章层 / L2 节层 / L3 内容层）。"""
    return [c for c in CARDS if c["level"] == level]


def get_card(card_id: str) -> dict | None:
    """按 id 取卡；不存在返回 None。"""
    return _BY_ID.get(card_id)


def find_cards(query: str, level: str = "") -> list[dict]:
    """关键词检索（name/one_liner/structure/scenarios 四字段任一命中）。"""
    if not query.strip():
        return []
    q = query.strip().lower()
    hits = []
    for c in CARDS:
        if level and c["level"] != level:
            continue
        haystack = " ".join((c["name"], c["one_liner"], c["structure"],
                             c["scenarios"])).lower()
        if q in haystack:
            hits.append(c)
    return hits


def validate_cards() -> list[str]:
    """卡库自检：返回问题清单（空=合格），构造期不可变故为纯函数。"""
    problems = []
    seen_ids, seen_names = set(), set()
    for c in CARDS:
        if c["id"] in seen_ids:
            problems.append(f"id 重复: {c['id']}")
        if c["name"] in seen_names:
            problems.append(f"名称重复: {c['name']}")
        seen_ids.add(c["id"])
        seen_names.add(c["name"])
        for field in ("id", "name", "one_liner", "level", "structure", "scenarios", "source"):
            if not str(c.get(field, "")).strip():
                problems.append(f"{c['id']} 字段缺失: {field}")
    return problems


def suggest_cards(query: str, level: str, k: int = 6) -> list[dict]:
    """按章节标题关键词推荐卡：2 字滑窗计分排序；无命中回退前 k 张（弹药不断供）。

    level 为层级串（"L1"/"L2"/"L3"/"L2L3"，包含即生效）。
    """
    levels = {lv for lv in ("L1", "L2", "L3") if lv in level}
    pool = [c for c in CARDS if c["level"] in levels] or list(CARDS)
    windows = [query[i:i + 2] for i in range(max(len(query) - 1, 0))]

    def _hits(card: dict) -> int:
        hay = " ".join((card["name"], card["one_liner"], card["structure"],
                        card["scenarios"]))
        return sum(1 for w in windows if w and w in hay)

    scored = sorted(pool, key=_hits, reverse=True)
    matched = [c for c in scored if _hits(c) > 0]
    return (matched or scored)[:k]
