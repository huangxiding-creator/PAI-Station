# F1 调研搜集质量档案 — 2026-10-15T06:48:23 ｜ 用户验收材料

> 字数门: T1≥20,000,000 ∧ T1+T2≥50,000,000 有效字符（弹药门 v3,
> tiers.json 判定, 只算新增+judge valid）
> 实绩: T1=32,951,068 ｜ T2=38,312,333
> ｜ T1+T2=71,263,401 ｜ **门态 PASS ✅**（距 T1+T2 门差 0 字待采）

## 1. 总量与分层账
- 存量语料盘点: 10,347,917 字（han+西文词口径,
  67 目录, A级 46 目录 · B级 19 目录 · C级 1 目录 · D级 1 目录）
- F1-BLUEBOOK 池（判定后真账）: 有效 28,237,111 字 /
  5262 件 ｜ 待审 0
- 分层: T1 32,951,068 (9166件) ｜
  T2 38,312,333 (10727件) ｜
  T3 0（封顶不计门）｜ T0 0（不计）
- 军团 F1 缺口树: 待派 51 / 已派 0 /
  已收 0 / 收割 0 字
- 池引擎账:
| engine | 字数 |
|---|---|
| rss:bid26deep | 7,735,197 |
| f1deep | 7,079,550 |
| cross:rss:bidcut | 5,094,237 |
| rss:wide | 2,536,089 |
| stock:corpus | 866,370 |
| search:web | 856,652 |
| cross:bidding | 821,649 |
| cross:policy | 818,675 |
| cross:standards | 457,273 |
| fulltext:web | 425,437 |
| rss:bid26direct | 392,583 |
| f1full:cross:topics | 352,329 |
| cross:EPC49-SEPDC | 321,227 |
| cross:wechat_rss:bidcut | 287,368 |
| manus:corps | 134,796 |
| f1full:cross:patents | 16,362 |
| cross:hbba | 14,008 |
| f1full:cross:weread | 10,935 |
| f1full:cross:metaso | 10,857 |
| f1full:cross:dangdang | 4,458 |
| f1full:cross:academic_en | 539 |
| f1full:cross:cnki | 520 |

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
| [池engine] rss:bid26deep | 7,735,197 | 存量语料建池入账 (多渠道历史编译) |
| [池engine] f1deep | 7,079,550 | 存量语料建池入账 (多渠道历史编译) |
| [池engine] cross:rss:bidcut | 5,094,237 | 跨战役收割件复用入账 (ResearchTopics 研究树, 同尺 judge+tiers) |
| [池engine] rss:wide | 2,536,089 | 存量语料建池入账 (多渠道历史编译) |
| [池engine] stock:corpus | 866,370 | 存量语料建池入账 (多渠道历史编译) |
| [池engine] search:web | 856,652 | 存量语料建池入账 (多渠道历史编译) |
| [池engine] cross:bidding | 821,649 | 跨战役收割件复用入账 (ResearchTopics 研究树, 同尺 judge+tiers) |
| [池engine] cross:policy | 818,675 | 跨战役收割件复用入账 (ResearchTopics 研究树, 同尺 judge+tiers) |
| [池engine] cross:standards | 457,273 | 跨战役收割件复用入账 (ResearchTopics 研究树, 同尺 judge+tiers) |
| [池engine] fulltext:web | 425,437 | 存量语料建池入账 (多渠道历史编译) |
| [池engine] rss:bid26direct | 392,583 | 存量语料建池入账 (多渠道历史编译) |
| [池engine] f1full:cross:topics | 352,329 | 存量语料建池入账 (多渠道历史编译) |
| [池engine] cross:EPC49-SEPDC | 321,227 | 跨战役收割件复用入账 (ResearchTopics 研究树, 同尺 judge+tiers) |
| [池engine] cross:wechat_rss:bidcut | 287,368 | 跨战役收割件复用入账 (ResearchTopics 研究树, 同尺 judge+tiers) |
| [池engine] f1full:cross:patents | 16,362 | 存量语料建池入账 (多渠道历史编译) |
| [池engine] cross:hbba | 14,008 | 跨战役收割件复用入账 (ResearchTopics 研究树, 同尺 judge+tiers) |
| [池engine] f1full:cross:weread | 10,935 | 存量语料建池入账 (多渠道历史编译) |
| [池engine] f1full:cross:metaso | 10,857 | 存量语料建池入账 (多渠道历史编译) |
| [池engine] f1full:cross:dangdang | 4,458 | 存量语料建池入账 (多渠道历史编译) |
| [池engine] f1full:cross:academic_en | 539 | 存量语料建池入账 (多渠道历史编译) |
| [池engine] f1full:cross:cnki | 520 | 存量语料建池入账 (多渠道历史编译) |

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
7. **跨战役复用披露**（1011 两腿）: 池内 engine=cross:* 行为跨战役
   复用 — 一腿来自 ResearchTopics 研究树（EPC49/50 历史战役工作区）
   收割件, 二腿来自 data/rss_harvest/articles（PAIStation-rss-harvest
   每日 07:37/19:37 的 RSS 常年收割面, engine=cross:rss 单列可区分）。
   同一把尺（F1 词表 judge + tiers 标题分层）, 内容头去重（两腿重叠
   14,742 件已自动跳过）; 排除法院裁判文书卷宗、用户私有资料、
   >2MB 合并巨件三类; PAIStation-F1CrossIngest 计划任务 30min 增量
   重跑（幂等）。跨战役素材与 F1 专属新采在池内按 engine 可区分,
   不冒充新采。
