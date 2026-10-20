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

## 沙箱内置技能库（heist 全量回收 · 34 件 SKILL.md 原文在案）

位置: `逆向工程/manus-reverse/live/sandbox_skills/_x/<name>/SKILL.md`

**报告链相关**: office-documents(docx/xlsx 生产+核验教义, OfficeCLI+LibreOffice) ·
office · deep-research · data-analysis · slides · builtin-llm-models ·
manus-api · manus-config · manus-tasks · handoff · triggers ·
automation-and-scheduling · persistent-computing · imagegen ·
image-processing · read-special-images · music-prompter · tts-prompter ·
trip · game-asset-catalog · finance-pro-playbooks · tailscale-network ·
data-api · data-backup-restoration · gws-best-practices · skill-creator …

**任务开场必读三规范的真身** = office-documents / office / deep-research
（Live 事件流前三个 text_editor 读取即此三件）。

## technical-writing 状态（heist 实证 2026-10-21）

**不在沙箱默认技能目录**（清单实证 + 交付中多个 0B SKILL.md 二次确证）。
deep-research 引用路径 `/home/ubuntu/skills/technical-writing/SKILL.md` 属
按需注入——报告写作任务触发时由服务端挂载。
复刻启示：写作规范作为「按需挂载层」而非常驻——我们的等价物即本 skill 的
quality-checklist.md + 产线文风纪律。

## 沙箱基础设施实证（heist 副产）

- 沙箱供应商: **e2b**（sandbox_id 形如 imzi…-e2b-prod-aws-ap-southeast-1）
- 文件交付链: 沙箱文件 → sessionFile/<sid>/sandbox/<key> →
  FileService/SignUrl(module=PRE_SIGN_MODULE_SESSION_FILE) → S3 预签
  （upload 型口径; 稳定下载走会话页文件卡片）
- fileOperationPromotion 事件携带 filePath（交付即事件）
