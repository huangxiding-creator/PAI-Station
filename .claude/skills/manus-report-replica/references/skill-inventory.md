# Manus 技能体系索引（40 官方 + 8 用户 · 全量原文已收割）

> 原文位置: `逆向工程/manus-reverse/live/skills/_pkg/<name>/…/SKILL.md`
> 收割链: SkillService/ListSkills → DownloadSkill → S3 签名直链 → zip 解包
> 内置核心技能（沙箱 /home/ubuntu/skills/）: deep-research(全文在案) +
> technical-writing + office 族（任务开场必读的"内部规范"）

## 报告链最相关技能

| 技能 | 用途 | 要点 |
|---|---|---|
| skill-creator | 技能创作元指南 | <500行/三级渐进披露/自由度三档/前置触发器写法 |
| youtube-video-research | 视频一手信源 | 主题分解4-6域×2-3视频=12-20信源;查询变体;CEO访谈优先 |
| financial-analysis | 公司财务研究 | SEC/市场数据/估值 |
| typst-pdf-maker | 出版级 PDF | 确定性规划器教义(manifest→plan→freeze→preflight) |
| excel-generator | 专业表格 | 表格生成规范 |
| comparison-article-writer | X vs Y 对比文 | 研究支撑对比框架 |
| listicle-blog-writer / alternative-blog-writer / seo 族 | 内容营销 | SEO 优化写作 |
| stock-analysis | 股票公司分析 | 金融数据 |
| similarweb-analytics / website-traffic-checker / backlink-analysis / keyword-research / content-gap-analysis | 网站情报 | 流量/外链/关键词/内容缺口 |
| 各软件 playbooks (16) | 工具操作 | Photoshop/Office/OBS/CapCut 等 |

## skill-creator 核心教义（对我们的 skill 创作直接适用）

1. **上下文窗口是公共品**：默认"模型已很聪明"，只加它不知道的；
   每段自问"这行字配得上它的 token 吗"
2. **渐进披露三级**: 元数据常驻(~100词) → 触发后载 body(<500行) → 按需载 references
3. **自由度三档**: 高=文本指引(开放任务) / 中=伪代码参数(有偏好模式) /
   低=精确脚本(脆弱关键操作) — "窄桥要护栏, 开阔地随意走"
4. **结构**: SKILL.md(必需, frontmatter name+description=唯一触发器) +
   scripts/(确定性, 不进上下文) + references/(按需文档) + templates/(输出资产)
5. 信息只活在一处（SKILL.md 或 references，不重复）
6. 祈使句写作；禁 README/CHANGELOG（技能给 AI 用不给人看）

## deep-research 八条军规（内置核心技能 · 全文在案）

见 search-engineering.md 末节（原文全录）。

## technical-writing（待回收）

deep-research 指定写终稿时 MUST 遵循的写作规范技能；heist 任务回收中，
拿到后补录本文件。
