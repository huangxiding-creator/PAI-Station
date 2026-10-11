# F1 调研搜集质量档案 — 2026-10-11T08:11:31 ｜ **进度与质量实况 (字数门未过, 非验收放行件)**

> 字数门: T1≥3,000,000 ∧ T1+T2≥30,000,000 有效字符（弹药门 v3,
> tiers.json 判定, 只算新增+judge valid）
> 实绩: T1=14,144,206 ｜ T2=5,883,341
> ｜ T1+T2=20,027,547 ｜ **门态 FAIL ⏳**（距 T1+T2 门差 9,972,453 字待采）

## 1. 总量与分层账
- 存量语料盘点: 10,347,917 字（han+西文词口径,
  67 目录, A级 46 目录 · B级 19 目录 · C级 1 目录 · D级 1 目录）
- F1-BLUEBOOK 池（判定后真账）: 有效 36,557,312 字 /
  7273 件 ｜ 待审 0
- 分层: T1 14,144,206 (1822件) ｜
  T2 5,883,341 (1740件) ｜
  T3 734,403（封顶不计门）｜ T0 15,795,362（不计）
- 军团 F1 缺口树: 待派 51 / 已派 0 /
  已收 0 / 收割 0 字
- 池引擎账:
| engine | 字数 |
|---|---|
| cross:topics | 12,329,194 |
| stock:corpus | 10,159,246 |
| cross:wechat_rss | 2,998,057 |
| cross:stats | 1,814,544 |
| cross:bidding | 1,675,402 |
| cross:policy | 1,607,380 |
| cross:standards | 1,121,878 |
| cross:assoc | 604,437 |
| cross:zhsearchpro | 525,066 |
| cross:cnki | 495,810 |
| cross:zzlh | 422,518 |
| cross:patents | 300,200 |
| cross:hbba | 271,218 |
| cross:metaso | 235,647 |
| cross:cnea | 181,677 |
| cross:company_info | 173,038 |
| cross:nafmii | 166,998 |
| cross:nnsa | 154,179 |
| cross:video | 150,848 |
| cross:railway_market | 138,634 |
| cross:cninfo | 115,527 |
| cross:deep_crawl | 94,549 |
| cross:eia | 84,199 |
| cross:websearch_en | 68,822 |
| cross:sasac | 64,367 |
| cross:dangdang | 54,662 |
| cross:academic_en | 46,345 |
| cross:weread | 45,767 |
| cross:nea | 45,232 |
| cross:luban | 39,849 |
| cross:chinamoney | 32,479 |
| cross:mot | 32,268 |
| cross:mohurd | 29,157 |
| cross:ggzy | 24,913 |
| cross:wbproj | 22,412 |
| cross:damodaran | 21,687 |
| cross:ndrc_pifu | 20,800 |
| cross:mem_gov | 19,774 |
| cross:ndrc | 18,339 |
| cross:sogou_wechat | 16,235 |
| cross:financial | 15,159 |
| cross:sinopec_ec | 14,830 |
| cross:intl_news | 14,154 |
| cross:irm | 13,738 |
| cross:gbstandard | 12,273 |
| cross:edgar | 9,998 |
| cross:wb_sanctions | 9,851 |
| cross:arxiv | 8,975 |
| cross:earnings_call | 8,319 |
| cross:procuratorate | 8,144 |
| cross:ofac | 4,809 |
| cross:ebook | 3,831 |
| cross:awards | 3,701 |
| cross:tcec | 2,755 |
| cross:mofcom_hzs | 1,173 |
| cross:wiki_intl | 1,162 |
| cross:hacker_news | 767 |
| cross:jzsc | 319 |

## 2. 渠道完备门过账（注册表逐条, 静默缺席不许收官）
| 渠道 | F1 专属贡献(字) | 态/计划 |
|---|---|---|
| opencli 166站桥接 | 0 | 存量编译内含其历史贡献; 跨战役复用已过账（见下方池engine cross: 行）; F1 专属新采待开火 |
| RSS 905源收割 | 0 | 存量编译内含其历史贡献; 跨战役复用已过账（见下方池engine cross: 行）; F1 专属新采待开火 |
| 搜狗微信采集 | 0 | 存量编译内含其历史贡献; 跨战役复用已过账（见下方池engine cross: 行）; F1 专属新采待开火 |
| 秘塔AI搜索 | 0 | 存量编译内含其历史贡献; 跨战役复用已过账（见下方池engine cross: 行）; F1 专属新采待开火 |
| 洞见研报 | 0 | 存量编译内含其历史贡献; 跨战役复用已过账（见下方池engine cross: 行）; F1 专属新采待开火 |
| 专利渠道 | 0 | 存量编译内含其历史贡献; 跨战役复用已过账（见下方池engine cross: 行）; F1 专属新采待开火 |
| 招投标五线 | 0 | 存量编译内含其历史贡献; 跨战役复用已过账（见下方池engine cross: 行）; F1 专属新采待开火 |
| CNKI论文 | 0 | 存量编译内含其历史贡献; 跨战役复用已过账（见下方池engine cross: 行）; F1 专属新采待开火 |
| 微信读书 | 0 | 存量编译内含其历史贡献; 跨战役复用已过账（见下方池engine cross: 行）; F1 专属新采待开火 |
| ima知识库 | 0 | 存量编译内含其历史贡献; 跨战役复用已过账（见下方池engine cross: 行）; F1 专属新采待开火 |
| 飞书文档中枢 | 0 | 存量编译内含其历史贡献; 跨战役复用已过账（见下方池engine cross: 行）; F1 专属新采待开火 |
| 通用网页搜索 | 0 | 存量编译内含其历史贡献; 跨战役复用已过账（见下方池engine cross: 行）; F1 专属新采待开火 |
| 官网定向爬取 | 0 | 存量编译内含其历史贡献; 跨战役复用已过账（见下方池engine cross: 行）; F1 专属新采待开火 |
| 本地文件扫描 | 0 | 存量编译内含其历史贡献; 跨战役复用已过账（见下方池engine cross: 行）; F1 专属新采待开火 |
| 视频字幕 | 0 | 存量编译内含其历史贡献; 跨战役复用已过账（见下方池engine cross: 行）; F1 专属新采待开火 |
| QQ邮箱 | 0 | 存量编译内含其历史贡献; 跨战役复用已过账（见下方池engine cross: 行）; F1 专属新采待开火 |
| [池engine] cross:topics | 12,329,194 | 跨战役收割件复用入账 (ResearchTopics 研究树, 同尺 judge+tiers) |
| [池engine] stock:corpus | 10,159,246 | 存量语料建池入账 (多渠道历史编译) |
| [池engine] cross:wechat_rss | 2,998,057 | 跨战役收割件复用入账 (ResearchTopics 研究树, 同尺 judge+tiers) |
| [池engine] cross:stats | 1,814,544 | 跨战役收割件复用入账 (ResearchTopics 研究树, 同尺 judge+tiers) |
| [池engine] cross:bidding | 1,675,402 | 跨战役收割件复用入账 (ResearchTopics 研究树, 同尺 judge+tiers) |
| [池engine] cross:policy | 1,607,380 | 跨战役收割件复用入账 (ResearchTopics 研究树, 同尺 judge+tiers) |
| [池engine] cross:standards | 1,121,878 | 跨战役收割件复用入账 (ResearchTopics 研究树, 同尺 judge+tiers) |
| [池engine] cross:assoc | 604,437 | 跨战役收割件复用入账 (ResearchTopics 研究树, 同尺 judge+tiers) |
| [池engine] cross:zhsearchpro | 525,066 | 跨战役收割件复用入账 (ResearchTopics 研究树, 同尺 judge+tiers) |
| [池engine] cross:cnki | 495,810 | 跨战役收割件复用入账 (ResearchTopics 研究树, 同尺 judge+tiers) |
| [池engine] cross:zzlh | 422,518 | 跨战役收割件复用入账 (ResearchTopics 研究树, 同尺 judge+tiers) |
| [池engine] cross:patents | 300,200 | 跨战役收割件复用入账 (ResearchTopics 研究树, 同尺 judge+tiers) |
| [池engine] cross:hbba | 271,218 | 跨战役收割件复用入账 (ResearchTopics 研究树, 同尺 judge+tiers) |
| [池engine] cross:metaso | 235,647 | 跨战役收割件复用入账 (ResearchTopics 研究树, 同尺 judge+tiers) |
| [池engine] cross:cnea | 181,677 | 跨战役收割件复用入账 (ResearchTopics 研究树, 同尺 judge+tiers) |
| [池engine] cross:company_info | 173,038 | 跨战役收割件复用入账 (ResearchTopics 研究树, 同尺 judge+tiers) |
| [池engine] cross:nafmii | 166,998 | 跨战役收割件复用入账 (ResearchTopics 研究树, 同尺 judge+tiers) |
| [池engine] cross:nnsa | 154,179 | 跨战役收割件复用入账 (ResearchTopics 研究树, 同尺 judge+tiers) |
| [池engine] cross:video | 150,848 | 跨战役收割件复用入账 (ResearchTopics 研究树, 同尺 judge+tiers) |
| [池engine] cross:railway_market | 138,634 | 跨战役收割件复用入账 (ResearchTopics 研究树, 同尺 judge+tiers) |
| [池engine] cross:cninfo | 115,527 | 跨战役收割件复用入账 (ResearchTopics 研究树, 同尺 judge+tiers) |
| [池engine] cross:deep_crawl | 94,549 | 跨战役收割件复用入账 (ResearchTopics 研究树, 同尺 judge+tiers) |
| [池engine] cross:eia | 84,199 | 跨战役收割件复用入账 (ResearchTopics 研究树, 同尺 judge+tiers) |
| [池engine] cross:websearch_en | 68,822 | 跨战役收割件复用入账 (ResearchTopics 研究树, 同尺 judge+tiers) |
| [池engine] cross:sasac | 64,367 | 跨战役收割件复用入账 (ResearchTopics 研究树, 同尺 judge+tiers) |
| [池engine] cross:dangdang | 54,662 | 跨战役收割件复用入账 (ResearchTopics 研究树, 同尺 judge+tiers) |
| [池engine] cross:academic_en | 46,345 | 跨战役收割件复用入账 (ResearchTopics 研究树, 同尺 judge+tiers) |
| [池engine] cross:weread | 45,767 | 跨战役收割件复用入账 (ResearchTopics 研究树, 同尺 judge+tiers) |
| [池engine] cross:nea | 45,232 | 跨战役收割件复用入账 (ResearchTopics 研究树, 同尺 judge+tiers) |
| [池engine] cross:luban | 39,849 | 跨战役收割件复用入账 (ResearchTopics 研究树, 同尺 judge+tiers) |
| [池engine] cross:chinamoney | 32,479 | 跨战役收割件复用入账 (ResearchTopics 研究树, 同尺 judge+tiers) |
| [池engine] cross:mot | 32,268 | 跨战役收割件复用入账 (ResearchTopics 研究树, 同尺 judge+tiers) |
| [池engine] cross:mohurd | 29,157 | 跨战役收割件复用入账 (ResearchTopics 研究树, 同尺 judge+tiers) |
| [池engine] cross:ggzy | 24,913 | 跨战役收割件复用入账 (ResearchTopics 研究树, 同尺 judge+tiers) |
| [池engine] cross:wbproj | 22,412 | 跨战役收割件复用入账 (ResearchTopics 研究树, 同尺 judge+tiers) |
| [池engine] cross:damodaran | 21,687 | 跨战役收割件复用入账 (ResearchTopics 研究树, 同尺 judge+tiers) |
| [池engine] cross:ndrc_pifu | 20,800 | 跨战役收割件复用入账 (ResearchTopics 研究树, 同尺 judge+tiers) |
| [池engine] cross:mem_gov | 19,774 | 跨战役收割件复用入账 (ResearchTopics 研究树, 同尺 judge+tiers) |
| [池engine] cross:ndrc | 18,339 | 跨战役收割件复用入账 (ResearchTopics 研究树, 同尺 judge+tiers) |
| [池engine] cross:sogou_wechat | 16,235 | 跨战役收割件复用入账 (ResearchTopics 研究树, 同尺 judge+tiers) |
| [池engine] cross:financial | 15,159 | 跨战役收割件复用入账 (ResearchTopics 研究树, 同尺 judge+tiers) |
| [池engine] cross:sinopec_ec | 14,830 | 跨战役收割件复用入账 (ResearchTopics 研究树, 同尺 judge+tiers) |
| [池engine] cross:intl_news | 14,154 | 跨战役收割件复用入账 (ResearchTopics 研究树, 同尺 judge+tiers) |
| [池engine] cross:irm | 13,738 | 跨战役收割件复用入账 (ResearchTopics 研究树, 同尺 judge+tiers) |
| [池engine] cross:gbstandard | 12,273 | 跨战役收割件复用入账 (ResearchTopics 研究树, 同尺 judge+tiers) |
| [池engine] cross:edgar | 9,998 | 跨战役收割件复用入账 (ResearchTopics 研究树, 同尺 judge+tiers) |
| [池engine] cross:wb_sanctions | 9,851 | 跨战役收割件复用入账 (ResearchTopics 研究树, 同尺 judge+tiers) |
| [池engine] cross:arxiv | 8,975 | 跨战役收割件复用入账 (ResearchTopics 研究树, 同尺 judge+tiers) |
| [池engine] cross:earnings_call | 8,319 | 跨战役收割件复用入账 (ResearchTopics 研究树, 同尺 judge+tiers) |
| [池engine] cross:procuratorate | 8,144 | 跨战役收割件复用入账 (ResearchTopics 研究树, 同尺 judge+tiers) |
| [池engine] cross:ofac | 4,809 | 跨战役收割件复用入账 (ResearchTopics 研究树, 同尺 judge+tiers) |
| [池engine] cross:ebook | 3,831 | 跨战役收割件复用入账 (ResearchTopics 研究树, 同尺 judge+tiers) |
| [池engine] cross:awards | 3,701 | 跨战役收割件复用入账 (ResearchTopics 研究树, 同尺 judge+tiers) |
| [池engine] cross:tcec | 2,755 | 跨战役收割件复用入账 (ResearchTopics 研究树, 同尺 judge+tiers) |
| [池engine] cross:mofcom_hzs | 1,173 | 跨战役收割件复用入账 (ResearchTopics 研究树, 同尺 judge+tiers) |
| [池engine] cross:wiki_intl | 1,162 | 跨战役收割件复用入账 (ResearchTopics 研究树, 同尺 judge+tiers) |
| [池engine] cross:hacker_news | 767 | 跨战役收割件复用入账 (ResearchTopics 研究树, 同尺 judge+tiers) |
| [池engine] cross:jzsc | 319 | 跨战役收割件复用入账 (ResearchTopics 研究树, 同尺 judge+tiers) |

## 3. 分层成色
- T1 主稿构成（按引擎分账, 不一概而论）: stock:corpus 67 件 = 我方
  编译研究报告（credibility=research → GRADE B 权威二手, 原始一手源
  在其引用链内）; cross:* 收割件 = 各渠道一手/二手资料, 按渠道
  cred 定级（gov=policy/standards 类, paper=cnki/academic 类,
  research=djyanbao 类, 其余 web）, 成稿引用照断言链 S0 门回溯
- 存量成色: A级 46 目录 · B级 19 目录 · C级 1 目录 · D级 1 目录（A=单稿≥8万字可精编）
- 抽样锚点回查: 3-1 湖南打样章已过 m2_gate2 数字锚点门
  （165 去重锚点 / own_calc×5 / 源内分歧显式披露）— 方法链在位,
  全量章级回查随 M2 量产逐章执行
- 同题归并纪律: 存量建池 86 候选 docx → 71 主稿（副本/排版/中间
  成果 15 件留档不入池, 防版本虚账）; cross:* 腿内容头去重同防双计

## 4. 缺口四面覆盖（f1_gap_tree_v2 实况）
| 面 | 树进度 | 已收割 |
|---|---|---|
| 2026年十七省EPC市场最新动态 | 待派 17 / 已派 0 / 已收 0 | 已收割 0 字 |
| 2026年国家政策与EPC行业大盘 | 待派 8 / 已派 0 / 已收 0 | 已收割 0 字 |
| 水利EPC项目投标专题（D级缺口补采） | 待派 10 / 已派 0 / 已收 0 | 已收割 0 字 |
| 企业卷六家缺口回捞补充 | 待派 6 / 已派 0 / 已收 0 | 已收割 0 字 |
| 卷五独家判断证据采集（2026-2029预判） | 待派 10 / 已派 0 / 已收 0 | 已收割 0 字 |

## 5. 已知瑕疵与披露
1. **口径差**: 存量盘点 1,034.8 万 = han+西文词口径; 存量建池 71 主稿
   10,159,246 = 去空白全字符口径且剔版本副本 — 两者差异为口径定义,
   非丢失（cross:* 与军团增量腿与盘点口径无关, 全走池账）。
2. 存量为**我方自产二手编译品**（B 级）, 非一手官方源; 蓝皮书引用
   数字仍须按断言链 S0 门回溯一手出处（湖南章已示范）。
3. PDF 未入池（与盘点口径对齐防 docx+pdf 双计）, 留档可查。
4. T1/T2 分层为**标题级下界**（1005 定调词表 tiers.json）: 标题无
   EPC 族词≠内容不相关, T0 件在成稿阶段照常可引用, 只不上门账。
5. 树问 chars 为收割 raw 口径, 池门账只认 judge valid — 两账并行
   不互换。
6. 渠道完备门: 16 注册渠道中 F1 专属贡献当前仅存量编译+军团两腿,
   其余渠道 F1 专属补采**尚未开火**（首窗后按完备门逐条过账）。
7. **跨战役复用披露**（1011）: 池内 engine=cross:* 行为 ResearchTopics
   研究树（EPC49/50 历史战役工作区）收割件的跨战役复用 — 同一把尺
   （F1 词表 judge + tiers 标题分层）, 内容头去重; 排除法院裁判文书
   卷宗、用户私有资料、>2MB 合并巨件三类; PAIStation-F1CrossIngest
   计划任务 30min 增量重跑（幂等）。跨战役素材与 F1 专属新采在
   池内按 engine 可区分, 不冒充新采。
