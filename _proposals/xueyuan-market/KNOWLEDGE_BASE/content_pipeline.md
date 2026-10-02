# 内容管线（content_pipeline）

> 浓缩自：PROPOSAL.md 4.2/十一、FEASIBILITY_REPORT.md 1.1/1.2、WeAppForge/pipeline/content_pipeline.py（源码实读）、WeAppForge/projects/zongbao/content/（zongbao 试点产物实读）
> 交叉引用：AI_NATIVE_OPTIONS.md #5/#6、RISK_REGISTER.md R-06（付费内容包内泄漏）
> 用途：批处理 40 份 docx 上架的数据契约与已实测事实。所有断言可溯源。

## 1. 管线全流程（一条命令 40 份批量进店）

```
docx → mammoth 转 HTML → 按 h1 切章 → 噪声章过滤 → 试读章/付费空壳拆分
     → 双 PDF（试读版/完整版，Edge headless）→ catalog.json/chapters.json 数据契约落盘
```

（源：PROPOSAL 十一 content_pipeline.py 复用行｜VISION 全自动上架管线）

命令行用法（源码实读）：

```
python content_pipeline.py <docx> <report_id> <title> [--trial N] [--price 990] [--summary ...] [--source 总包创研院]
```

- `--trial N`：试读章数，默认 2。
- `--price`：单位分？否——catalog 中 price 存 990（试点值，单位=分口径待与 SCHEMAS 统一，见第 7 节注）。
- 产出三件套：`projects/zongbao/content/reports/<id>/chapters.json` + `projects/zongbao/content/catalog.json` + `data/pdfs/<id>-trial.pdf`/`<id>-full.pdf`。

## 2. 切章与噪声过滤规则（源码实读）

- **按 h1 切章**：`split_chapters()` 用正则按 `<h1>` 分割；**h1 不足 2 章则退 h2**；正文前导内容（preamble）若非空，插入为首章「导语」；全部切不出时保守返回单章「全文」。章 id 编号 `ch01`..`chNN`。
- **噪声章过滤**：`drop_junk_chapters()` 剔除两类——①标题命中噪声正则（导语/目录/封面/前言/contents）；②正文（去标签后）< 400 字符的超短章。**试读从首个实质章起算**；全被滤掉时保守回退原文并重编号。
- **试读/付费空壳拆分**：包内章节文件中，前 `--trial` 章带 html 正文，其余付费章 `html=""`（空壳）——**防包内全文泄漏**（反编译小程序包拿不到付费正文）。

## 3. 防泄漏双设计（R-06 的结构性缓解）

1. **包内空壳**：付费章在 chapters.json 中只存标题不存正文（上节）。
2. **服务端按权益下发**：付费正文由引擎校验 entitlements 后下发——「内容交付=服务端按权益下发」已定选（AI_NATIVE_OPTIONS #5）。
- 下载 PDF 带购者昵称水印（防转传），转赠限 1 次。（源：PROPOSAL 4.2）
- 触发信号与兜底：反编译包体出现付费正文→泄漏源轮换水印指纹定位溯源；走微信官方侵权投诉通道下架转传载体。（源：R-06）

## 4. 双 PDF（Edge headless）

- 渲染方式：`msedge.exe --headless --print-to-pdf`（Edge 无头打印，openDocument 无页码范围的官方替代）；`creationflags=0x08000000`（CREATE_NO_WINDOW，Windows 不弹窗铁律）。（源码实读）
- 试读版=前 N 章正文；完整版=全文。HTML 壳自带样式（720px 版心/h1 蓝底线/表格边框）+右上角水印「总包学园 · 日期」。
- **待办：full.pdf 压缩**——图片重导致 full.pdf 约 50MB 级，云端交付前必压（难度低-中；图片压缩脚本经验已有：zongbaoshuo-miniprogram/tools/compress_images.py）。（源：FEASIBILITY 1.2 第一行）

## 5. catalog.json 数据契约（试点实样）

文件位置 `projects/zongbao/content/catalog.json`，合并更新（同 id 覆盖，新 id 追加）。字段：

| 字段 | 类型 | 说明 | 试点实值 |
|---|---|---|---|
| id | string | 报告短 ID | `js-shuiwang-2026` |
| title | string | 报告标题 | `江苏省水网工程商机研究` |
| summary | string | 摘要（缺省「{title}——总包创研院出品。」） | 同左 |
| price | int | 价格 | 990（试点值；正式=49800 分，PROPOSAL 假设2） |
| chapterCount | int | 实质章数 | 19 |
| source | string | 出品方 | `总包创研院` |
| publishedAt | string | 上架日期 ISO | `2026-09-27` |

示例一行（实样）：
`{"id":"js-shuiwang-2026","title":"江苏省水网工程商机研究","summary":"江苏省水网工程商机研究——总包创研院出品。","price":990,"chapterCount":19,"source":"总包创研院","publishedAt":"2026-09-27"}`

## 6. chapters.json 数据契约 + zongbao 试点 19 章结构实样

文件位置 `projects/zongbao/content/reports/<report_id>/chapters.json`，结构：`[{id, title, html}]`——试读章 html=正文，付费章 html=""（空壳）。

试点实样（js-shuiwang-2026，19 实质章，试读=前 2 章）：

| # | id | 标题 | html_len |
|---|---|---|---|
| 1 | ch01 | 第一章 研究概述与方法论 | 3117（试读） |
| 2 | ch02 | 第二章 执行摘要与核心发现 | 3699（试读） |
| 3 | ch03 | 第三章 江苏水利建设宏观战略背景 | 0（空壳） |
| 4 | ch04 | 第四章 政策环境与规划体系分析 | 0 |
| 5 | ch05 | 第五章 市场全景分析 | 0 |
| 6 | ch06 | 第六章 区域市场深度对比 | 0 |
| 7 | ch07 | 第七章 商机类别深度分析 | 0 |
| 8 | ch08 | 第八章 重大水利工程专题追踪 | 0 |
| 9 | ch09 | 第九章 投资规模与资金流向分析 | 0 |
| 10 | ch10 | 第十章 招标采购与竞争格局 | 0 |
| 11 | ch11 | 第十一章 时间窗口与行动节奏 | 0 |
| 12 | ch12 | 第十二章 技术趋势与产业创新 | 0 |
| 13 | ch13 | 第十三章 市场切入策略 | 0 |
| 14 | ch14 | 第十四章 风险评估与缓释建议 | 0 |
| 15 | ch15 | 第十五章 核心结论与行动指南 | 0 |
| 16 | ch16 | 附录A Top 100 商机清单 | 0 |
| 17 | ch17 | 附录B 区域统计汇总 | 0 |
| 18 | ch18 | 附录C 全量商机索引 | 0 |
| 19 | ch19 | 附录D 重点商机溯源清单 | 0 |

- 试读两章合计 3117+3699=**6816 字符**——与 FEASIBILITY 1.1 引述「试读=第一章+第二章 6816 字符」一致（WFR #12 首跑实测）。
- 章节标题模式：15 个正文章（第 1-15 章）+4 个附录（A-D）——**附录=高价值清单类内容（Top 100 商机/全量索引），天然放付费区尾部**。
- 该结构即 40 份 EPC100 docx 批处理的样板。

## 7. 与 SCHEMAS 的衔接（Phase 5 输入）

- catalog.json/chapters.json 是**文件契约**（小程序包内静态数据+引擎读取源）；SQLite 的 reports/chapters 表是**库契约**（引擎权益校验用）。两者字段对齐映射：catalog.reports[] → reports 行；chapters.json[] → chapters 行（html 列在库中只存试读章，付费正文另存服务端 content store，包内文件保持空壳）。
- 注意单位统一：catalog.price 试点存 990（分），正式口径 **price_fen=49800**；SCHEMAS.md 以「分」为唯一价格单位。
- 试读章数 trial 可按报告配置（config trialChapterCount=2，zongbao config/index.ts 实读）。

## 8. 排版与阅读器（交付体验）

- 阅读器=自研 **md2blocks** 块渲染（零依赖 MD 渲染器，单测 10/10 PASS）——选型已定：弃 mp-html，因排版卖相即转化（AI_NATIVE_OPTIONS #6）。
- docx→HTML 由 mammoth 完成（表格/列表/标题映射），管线已消化其输出结构（h1/h2/table/ul）。
- 详情页预览三件套（报告预览/目录/简介）+决策卡（已读 X 页/全文还有 Y 章 Z 页/未解锁 N 条核心结论模糊预览+目录树）复用同源章节数据。（源：PROPOSAL 4.1/4.2）

## 9. 关键量化（tenx 出处）

- deploy_cost 40×：content_pipeline 全自动批处理 **0.1 人时/份** vs 人工上架 4 人时。（源：PROPOSAL 二佐证轴｜tenx_claims）
- 内容源：EngOpp-Mining 40 份 docx 直接上架（358MB 存量），EPC100 产线持续补货；边际成本≈0。（源：PROPOSAL 假设6｜FEASIBILITY 2.1）
- 上架节奏=「一条命令 40 份批量进店」（docx→切章→试读空壳→双 PDF→catalog→海报模板）。（源：VISION 五件套2）

## 10. 已知坑与纪律

- Edge 路径硬编码 `C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe`——ECS 侧部署需换 Linux 渲染方案或本地预生成 PDF 后上传（部署时注意）。
- 试点 catalog price=990 是试点期遗留值，正式一律 49800 分——上架脚本参数化，不手改 JSON。
- 试读内容版权洁净：试读/正文不涉第三方版权图表，需授权或重绘（FEASIBILITY 前置5，阻塞提审）。
- 管线不弹窗（CREATE_NO_WINDOW）；批处理长任务按「长跑任务晚间执行」惯例安排。
