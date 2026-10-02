# 评估学理框架调研

说明：为「企业 EPC 总承包业务深度研究报告」（10 万字中文）制定质量标准，本文件调研学术界与教育测量领域评估「分析性写作质量」的成熟框架，以及把质量变成可测指标的方法。共 29 条，覆盖 13 项必查清单，优先一手学术来源。

### 1. Paul-Elder 普遍理性标准（Universal Intellectual Standards）
- URL: https://www.criticalthinking.org/pages/universal-intellectual-standards/827
- 核心要点: 批判性思维基金会提出的 9 条普遍理性标准：清晰性、准确性、精确性、相关性、深度、广度、逻辑性、重要性、公正性。其中清晰性被称为「门槛标准」（gateway standard）——不清晰则其余标准无从检验。
- 对我们的适用: 直接可作为研报框架质量的一级审读清单，逐章追问「这章有多深、多广、是否相关、逻辑是否自洽」。

### 2. Toulmin 论证模型（The Uses of Argument, 1958）
- URL: https://en.wikipedia.org/wiki/Toulmin_model
- 核心要点: Stephen Toulmin 1958 年提出论证六要素：主张（claim）、资料（data）、担保（warrant）、支撑（backing）、限定词（qualifier）、反驳（rebuttal）。它把「一个好论证」拆成可逐项核验的组件，是现代论证评估的通用底座。
- 对我们的适用: 给 10 万字研报的每一个核心论断做「六要素完备性」检查——有没有证据、证据与结论之间的推理桥是否写明、是否交代了适用边界与反例。

### 3. Stab & Gurevych 论证结构自动识别（EMNLP 2014）
- URL: https://aclanthology.org/D14-1006/
- 核心要点: 在 persuasive essay 语料上标注主张、大前提、小前提并自动识别论证组件（F1 约 0.72-0.77），证明 Toulmin 式论证质量可以被计算化度量。该方向后来发展成 argument mining 领域。
- 对我们的适用: 说明「论证完备率」可以程序化：用 NLP 抽出报告中的主张-证据对，统计有多少主张缺证据、多少证据没接到主张上。

### 4. SOLO 分类法（Biggs）
- URL: https://www.johnbiggs.com.au/academic/solo-taxonomy/
- 核心要点: Biggs 的「可观察学习成果结构」五级：前结构→单点结构→多点结构→关联结构→拓展抽象。它评的不是对错而是思维结构的复杂度，广泛应用于开放性作答评分。
- 对我们的适用: 是「思想深度」的现成等级尺——一章内容只罗列事实=多点结构，能整合出因果图景=关联结构，能抽象出可迁移规律=拓展抽象；rubric 的深度档可直接借用这五级命名。

### 5. 修订版 Bloom 认知目标分类（Krathwohl 2002）
- URL: https://www.jstor.org/stable/1477405
- 核心要点: Anderson & Krathwohl 2001 修订版把 Bloom 六级改为记忆、理解、应用、分析、评价、创造，并叠加事实性/概念性/程序性/元认知四类知识，形成二维矩阵。
- 对我们的适用: 给章节抽样定级——顶级研报的主体应落在「分析-评价-创造」档；若大量篇幅停留在「理解/复述」（行业常识转述），即可判定思想浓度不达标。

### 6. CER 科学解释框架（McNeill & Krajcik）
- URL: https://www.researchgate.net/publication/248942276_Synergy_Between_Teacher_Practices_and_Curricular_Scaffolds_to_Support_Students_in_Using_Domain-Specific_and_Domain-General_Knowledge_in_Writing_Arguments_to_Explain_Phenomena
- 核心要点: 从 Toulmin 模型衍生的教学简化版：解释 = 主张（Claim）+ 证据（Evidence）+ 推理（Reasoning），高阶再加反驳（Rebuttal）。因其可操作性强，成为理科写作评分的标准拆法。
- 对我们的适用: 比 Toulmin 六要素更适合当一线审稿模板——对报告每个小节问三句话：主张是什么、证据是哪条、凭什么由证据推到主张。

### 7. e-rater 自动评分系统 V.2（Attali & Burstein 2006, ETS）
- URL: https://ejournals.bc.edu/index.php/jtla/article/view/1650
- 核心要点: ETS 的工业级作文自动评分器，V.2 用一组小而可解释的特征（语法、用法、机械、风格、组织、发展等 12 个特征）线性加权逼近人工分，在 TOEFL/GRE 中实役，与人工分相关约 0.9。
- 对我们的适用: 证明「写作质量」可分解为一组可计算特征再加权——我们的中文版可对应：句长分布、连接词密度、术语一致性、段落组织度，作为机评第一道筛。

### 8. 雅思写作四维评分标准（IELTS Writing Assessment Criteria）
- URL: https://ielts.org/cdn/Guides/ielts-writing-key-assessment-criteria.pdf
- 核心要点: 官方把写作拆成四个等权（各 25%）维度：任务回应（TR）、连贯衔接（CC）、词汇资源（LR）、语法多样性准确性（GRA），每个维度 0-9 分并有分档描述语（band descriptors）。
- 对我们的适用: 是「分析性量表 = 维度拆分 + 等权 + 分档描述语」的最佳公开范本；我们可类比设「问题回应度/论证连贯/证据质量/表达规范」四维并写中文分档锚点。

### 9. GRE 分析性写作评分等级描述（ETS 官方）
- URL: https://www.ets.org/gre/revised_general/prepare/analytical_writing/score_level_descriptions
- 核心要点: GRE 对 0-6 每个分数档给出整体性（holistic）官方描述，高档强调「洞察力、支撑充分、组织流畅、语言精确」，低档对应「缺乏洞察、支撑薄弱、组织混乱」；采用受训评分员 + e-rater 联评。
- 对我们的适用: 提供「整体分 + 分档描述语」的范本，其高分关键词「insightful」直接呼应我们的思想浓度要求，可借来定义 10 万字报告的总分档。

### 10. AAC&U VALUE 写作交流量规（Written Communication Rubric）
- URL: https://assessment.unc.edu/wp-content/uploads/sites/1284/2022/08/AACU_WC_ValueRubric.pdf
- 核心要点: 美国高校通用的成熟量规，把书面交流拆 5 维（语境与证据、来源与证据、主张与观点、组织论证、语法风格），每维 4 档（初学→熟练），并强制配 capstone 锚点样例。
- 对我们的适用: 免费公开、经过大规模院校使用验证，可作为我们 4 档制中文量规的直接结构模板，特别是「每档必须配真实样例」的做法。

### 11. 评分量规元分析（Jonsson & Svingby 2007）
- URL: https://doi.org/10.1016/j.edurev.2007.05.002
- 核心要点: 综述 75 项实证研究：分析性量规（analytic）比整体性量规信度高；配锚点样例（exemplars/anchors）与评分员培训显著提升评分者间信度；量规档数适中即可。
- 对我们的适用: 直接规定我们的评分工艺——用分析性量规、每档配 1-2 篇锚点段落、评分前做校准会，这是信度的三大杠杆。

### 12. 知识讲述 vs 知识转化（Bereiter & Scardamalia 1987）
- URL: https://psycnet.apa.org/record/1988-97103-011
- 核心要点: 写作心理学的经典区分：低质量写作是「知识讲述」（想到什么倒什么），高质量写作是「知识转化」（写作过程本身改造思想，为读者与目的重组知识）。
- 对我们的适用: 给「思想浓度」一个理论判据——审稿时识别哪些章节只是把搜集材料倒出来（转述多、综合少），哪些章节发生了知识转化（出现搜不到的整合性判断）。

### 13. MTLD 词汇多样性指标（McCarthy & Jarvis 2010）
- URL: https://doi.org/10.1093/applin/amp024
- 核心要点: 指出经典 TTR（类型/ token 比）强烈依赖文本长度不可比，提出 MTLD（因子前长度均值）与 MATTR（移动窗口 TTR）两种长度不敏感的词汇多样性度量。
- 对我们的适用: 提醒我们对 10 万字长文绝不能直接用朴素 TTR 衡量信息/词汇多样性，必须用分段 MTLD 或 MATTR，且只能当辅助客观指标。

### 14. 词汇多样性指标方法学比较（Fergadiotis 等 2013）
- URL: https://pmc.ncbi.nlm.nih.gov/articles/PMC3813439
- 核心要点: 系统比较 TTR、MTLD、MATTR、D 等指标在口头语料上的测量学性质，结论是各指标测量「词汇多样性」的侧面不同，应按目的选用并报告多项而非单一指标。
- 对我们的适用: 支撑我们把词汇/信息多样性做成指标组而非单一分数，并在标准中写明每个指标的口径与局限。

### 15. 信息熵（Shannon 1948）
- URL: https://people.math.harvard.edu/~ctm/home/text/others/shannon/entropy/entropy.pdf
- 核心要点: 香农定义了消息平均信息量的数学度量（比特），英文文本约每字符 1 比特，为「信息量」提供了严格可计算的底座，是后来一切信息密度度量的源头。
- 对我们的适用: 可对报告做字符级/词级熵与冗余度计算——熵过低提示车轱辘话与模板化表达，但须结合语义指标（熵不识别内容对错）。

### 16. 思想密度（Idea Density）与 CPIDR 自动测量
- URL: https://link.springer.com/article/10.3758/s13428-010-0037-9
- 核心要点: 思想密度 = 每百词中的命题数（propositions/100 words），源自 Nun Study 修女自传研究（低思想密度预测晚年认知衰退）；CPIDR 软件可由词性标注自动计算，Pakhomov 用其分析 Iris Murdoch 作品。
- 对我们的适用: 这是「洞见密度」最接近的成熟学术度量——可给章节算命题密度/千字，作为思想浓度的客观代理指标之一（需人工抽样校验命题质量）。

### 17. Coh-Metrix 语篇多维分析工具（Graesser 等 2004）
- URL: https://doi.org/10.3758/BF03195564
- 核心要点: 汇聚指代衔接、LSA 潜在语义衔接、连接词类型、句法复杂度、情景模型等上百个语篇层指标，证明「连贯与组织」可以多侧面计算，而非只靠直觉。
- 对我们的适用: 我们的机评腿可对应实现其中文版子集：指代链完整性、连接词谱系（因果/转折/递进比例）、段落间语义相似度骤降点检测。

### 18. Flesch 阅读容易度公式（Flesch 1948）
- URL: https://doi.org/10.1037/h0057532
- 核心要点: 用平均句长与平均音节数两个变量线性组合预测文本可读性（美国中小学年级水平），是历史上影响最大的可读性公式。
- 对我们的适用: 借其「两个浅层变量即可预测阅读负担」的思路建中文版（平均句长+平均词长），但只用于筛查过长句、超标段落，不评内容质量。

### 19. 可读性原理与公式批判（DuBay 2004）
- URL: https://books.google.com/books/about/The_Principles_of_Readability.html?id=Aj0VvwEACAAJ
- 核心要点: 系统梳理 20 世纪可读性研究与几十个公式，同时收录大量批判：公式只捕捉句长词长两个表层变量，忽略内容、组织与读者先验知识，Word 版 Flesch-Kincaid 封顶 12 年级且有缺陷。
- 对我们的适用: 给我们划定边界——可读性指标只进「表达规范」维度的筛查位，绝不作为思想浓度的替代品写进总分。

### 20. AlphaReadabilityChinese 中文可读性工具
- URL: https://www.researchgate.net/publication/379452433
- 核心要点: 面向中文的可读性测量工具与开源库，整合多种中文可读性算法；经典中文公式（如台湾地区研究）常用平均笔画数/平均句长等变量，西方公式不能直接照搬。
- 对我们的适用: 中文可读性必须用本土化变量（平均句长、词长、标点密度），可引此工具做报告表达层自动体检。

### 21. Heuer《情报分析心理学》与竞争性假设分析（ACH）
- URL: https://www.cia.gov/resources/csi/static/Pyschology-of-Intelligence-Analysis.pdf
- 核心要点: CIA 资深分析家 Heuer 指出分析质量的最大敌人是认知偏误（锚定、证实偏向），提出 ACH 八步法：穷举假设、逐证据给每个假设打「一致性/诊断力」分，重点找能排除假设的证伪性证据，而非只找支持性证据。
- 对我们的适用: EPC 报告的核心判断（政策走势、竞争格局、风险概率）应按 ACH 建假设矩阵，报告质量标准可加入「关键判断是否做过证伪检验」这一硬指标。

### 22. Sherman Kent 估测性概率用语（Words of Estimative Probability, 1964）
- URL: https://www.cia.gov/readingroom/docs/CIA-RDP93T01132R000100020036-3.pdf
- 核心要点: Kent 给出情报界经典概率-用语对照表：几乎肯定（约 93%±6）、很可能（约 75%）、大概率/ Oddsline 对半（50%）等，主张概率判断必须用统一校准的语言，避免「可能」被读者各读各的。
- 对我们的适用: 报告中所有前瞻判断须挂接一张固定的中文概率用语表（每档附百分比区间），杜绝「或将」「不排除」滥用导致的不确定性失真。

### 23. ICD 203 情源分析与置信语言标准（ODNI）
- URL: https://archive.dni.gov/files/documents/ICD/ICD-203.pdf
- 核心要点: 美国情报界现行指令：每条分析产品必须带来源质量评估与置信水平（高/中/低），概率用语用 7 级可能性量表（almost no chance 到 almost certain），并把「可能性」与「置信度」分开表述。
- 对我们的适用: 直接抄结构——我们的每章关键论断须双标：来源可靠度 + 分析置信度，且两者独立分级；这是把「严谨性」变成可检项目的现成规范。

### 24. 口头概率用语的校准实证（Wintle 等 2019）
- URL: https://pmc.ncbi.nlm.nih.gov/articles/PMC6469752
- 核心要点: 用 1700 名受试者实验测出每个概率短语（very likely、unlikely 等）对应的数值区间，并比较专家与公众、英语母语与否的解读差异；证明未校准的概率语言会造成系统性误读。
- 对我们的适用: 中文概率词同样需本地校准——可在评审团中做小规模调查，确定「大概率/有望/恐将」等词的读者感知区间，再写进我们的用语规范。

### 25. PRISMA 2020 系统综述报告规范
- URL: https://www.bmj.com/content/372/bmj.n71
- 核心要点: 27 项条目的报告清单 + 筛选流程图：检索式、数据库、去重、筛选人数、纳入排除标准、每步数量全部公开可复核，是「证据链透明」的行业金标准。
- 对我们的适用: 报告的调研过程章节应按 PRISMA 精神披露：信源清单、检索时间窗、筛选判据、排除原因，让 10 万字报告的证据底盘可审计。

### 26. GRADE 证据质量与推荐强度分级
- URL: https://doi.org/10.1136/bmj.39489.470347.AD
- 核心要点: 把证据体质量分高/中/低/极低四级（升降级因素：偏倚风险、不一致、间接性、不精确、发表偏倚），推荐强度分强/弱并明示依据；医学循证体系的通用货币。
- 对我们的适用: 可移植为研报证据分级器：EPC 数据来源按「官方统计/行业协会/公司披露/媒体转述/估算」五档定级，每张关键图表标注证据档位。

### 27. 金字塔原理（Barbara Minto, The Pyramid Principle）
- URL: https://modelthinkers.com/mental-model/minto-pyramid-scqa
- 核心要点: 麦肯锡写作标准：结论先行（answer first），顶层一个统辖思想（governing thought），下层按 MECE 展开；序言用 SCQA（情境-冲突-问题-答案）。最新版 2020 年。
- 对我们的适用: 作为框架质量的硬检查——每章首段是否给出该章答案、小节是否互斥完备（MECE 测试），目录即金字塔的反投影。

### 28. 「每页一个洞见」——实务界的洞见密度话语
- URL: https://www.linkedin.com/posts/heinrichrusche_career-slidewriting-slides-activity-7333161265487331328-UKgW
- 核心要点: 系统检索证实「insight density / insights per page」没有标准化学术定义，只存在于书评用语与咨询实务规范中（「一页一个洞见、一图一个观点」、每页过 So-What 测试、行动式标题）；最接近的学术度量是第 16 条的思想密度（命题/百词）。
- 对我们的适用: 我们的「洞见密度」须自定义口径——建议操作化为「每千字可摘录的增量判断数（他处搜不到的分析结论）」，并用人工锚点样例校准。

### 29. Krippendorff's α 与编码者间信度（Hayes & Krippendorff 2007）
- URL: https://doi.org/10.1080/19312450709336664
- 核心要点: 内容分析的标准信度系数，α≥0.80 可信、0.667-0.80 勉强可接受；适用于多评分员、多档、含缺失的一般情形，优于只算百分比一致或 Cohen's κ。
- 对我们的适用: 我们的终审必须多人独立打分并报 Krippendorff's α，α<0.80 的维度回炉重定锚点，杜绝单人打分的随意性。

## 综合判断

1. 框架质量用两把尺：Paul-Elder 九条理性标准（第1条）做逐章审读清单，Minto 金字塔+MECE（第27条）做结构硬检查；SOLO 五级（第4条）为「深度」定档命名，Bloom 修订版（第5条）抽样判认知层级。
2. 正文质量用四把尺组合：论证腿=Toulmin/CER 六要素或三要素完备率（第2、3、6条）；证据腿=GRADE 式证据分级+PRISMA 式过程披露（第25、26条）；校准腿=ICD 203/Kent 概率与置信双标（第21-24条）；表达腿=IELTS/GRE/VALUE 式分档量规（第8-10条）。
3. 客观机评只当辅助代理：e-rater 思路的特征加权（第7条）+ 中文可读性筛查（第18-20条）+ MTLD/熵/Coh-Metrix 指标组（第13-17条），各指标须写明口径与局限，不得单独定分。
4. 洞见密度无现成学术标准（第28条），建议操作化＝「每千字增量判断数（他源检索不到的结论）」× 命题密度（CPIDR 思路，第16条），人工抽样校验。
5. rubric 设计工艺定案：分析性量规、四维等权或加权、每维 4 档、每档配 1-2 个真实锚点段落（第8、10、11条）；评分员先校准后独立打分，报 Krippendorff's α≥0.80（第29条），不达标维度重训。
6. 一句话：框架质量靠 Paul-Elder+金字塔，正文质量靠「论证完备×证据分级×概率校准×表达量规」四腿，机评指标组只做体检不做判决，判决权在锚点校准后的人审团。
