# DIRECTORY.md · AI-Station 全站地图（1015 整理战役建立）

> 一页看懂什么在哪、为什么。维护纪律：顶层新增目录须在此登记一行。

## 产线核心（在役，勿动）

| 目录 | 一句话 | 体量级 |
|---|---|---|
| reforge_factory/ | 研究生产线引擎（gates.json 权威源/五轴完备性/决策账本/审计四件） | ~百MB |
| _proposals/flagship-paid-report-1007/ | 旗舰付费研报产线（章程 v2 八段制/GOAL_LEDGER ¥100k 冲刺） | GB 级 |
| ammo_pool/ | 弹药池（各战役语料分层账，BID26/TRAIN 在池） | GB 级 |
| ResearchFactory-Eng/ResearchTopics/ | 82 个 EPC 战役工作区（语料已硬链去重：87GB 冗余回收，路径不变内容透明） | 22GB 实体 |
| report_platform/（+ECS 云端） | 自建发布平台（漏斗/订单/周报北极星/定价实验） | ~百MB |
| tools/ + services/ + Auto_Manus(代码) | 常驻工具与 31 个 PAIStation 计划任务 | ~GB |
| .claude/ | 技能/记忆/会话（worktrees 为他会在役工树） | ~GB |

## 数据与语料（在役资产）

| 目录 | 一句话 | 体量 |
|---|---|---|
| data/local_index/ | 本地文件索引金矿（index.db 45GB，D 路 GLOB 依赖） | 49GB |
| EngOpp-Mining/data/ | 工程机会挖掘库（engopp.db 30.6GB） | 31GB |
| 乐奇AI眼镜/ | 水利安全助手产品知识库（在役，10-12 仍活动） | 19GB |
| IdeaDig/ + ZBZK/ + EngMarketFit/ | 选题/中标智库/市场匹配数据与语料 | ~19GB |
| 04 智库/（含混沌学园；data/hundun 是其 junction，禁穿链删） | 智库语料实体 | 6GB |
| corpus/ | **新**：中央语料指纹账（sha_index 4076；采集查重接线位） | MB 级 |
| 微信生态（WeChat-AI/公众号RSS/Downloads） | 微信语料与导出 | ~GB |

## 归档与清理（本战役产物）

| 位置 | 内容 |
|---|---|
| _proposals/workspace-hygiene-1015/ | 本战役全部工件：普查/清单/台账（删除账 run_progress/硬链账/批报告/验证门报告） |
| work/cloud_staging/（战役内） | E 批云归档压缩件（上传百度后删原件，回执制） |
| corpus/_lossy_backup/ | D 批重压前原件备份（验收后接线） |
| logs/（规划） | W4 散日志归口 |

## 已清理（1015 战役，全清单在 _proposals/workspace-hygiene-1015/work/）

断点残骸 17.75GB ｜ 战役浏览器 profile 2.4GB ｜ 缓存/临时/旧日志 ~1.5GB ｜ 跨战役重复 PDF 硬链回收 87GB（内容原位可读）｜ git gc（进行中）｜ E 批待云后删 38GB

**净效果：E 盘余量 84.9GB → 208GB+**
