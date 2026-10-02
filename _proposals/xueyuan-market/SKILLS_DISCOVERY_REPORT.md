# SKILLS DISCOVERY REPORT — 总包学园·研报商城（Phase 2b）

> 生成：2026-09-28。方法：`npx -y skills find <query>` ×5，各 90s 超时、`-y` 防交互挂起；全部命令 **EXIT=0 真实返回**（无降级、无编造）。评估纪律：相关性<80% 不装；已在本机的同域技能不算新命中。

## 一、搜索词 × 结果 × 评估

| # | 查询词 | 返回 | 命中概览（头部） | 评估 | 处置 |
|---|---|---|---|---|---|
| 1 | `wechat miniprogram` | 20 条 | gourdbaby/wechat-miniprogram-skill（1.3K installs）、微信官方 skyline 系列（skyline-components/overview/worklet/route…986-918）、tencentcloudbase AI 系列 | **已覆盖**：本机全局技能清单实证在位——`wechat-miniprogram-skill@`、`wechat-miniprogram-builder@`、`skyline-components@`、`skyline-overview@`、`wechat-devtools@`、`weapp-devtools-e2e-best-practices@`（C:\Users\91216\.claude\skills\ 目录实查）；tencentcloudbase 系列=云开发路线，本项目走 ECS 自管（GITHUB_DISCOVERY 第三节云函数否决同因） | **不装**（重复+路线不符） |
| 2 | `wechat pay` | 20 条 | 微信支付官方 wechatpay-apiv3/wechatpay-skills 系列（payment-integration 1.4K / product-coupon 1.2K / basic-payment 898 / 医保/分/扣） | **域错配**：官方系列教的是**商户 JSAPI/H5 支付**——本项目数字内容必须走小程序**虚拟支付** wx.requestVirtualPayment（2026-04-01 起全终端强制，JSAPI/H5 收数字内容款=违规，PROPOSAL 4.2/deep_pay）；且 pay_sign 双签名腿已在产五向量验证（WFR #42） | **不装**（<80% 且方向性相反） |
| 3 | `poster image generation` | 20 条 | AI 生图技能（nano-banana-2 13.5K、superdesign 9.9K、qianwen-image-generation 4.9K、gpt-image…） | **域错配**：海报=服务端 PIL 模板**确定性生成**（AI_NATIVE_OPTIONS #2 决 A：千机一面/模板改不发版/码预生成避限频）；AI 生图=非确定性输出+多为付费 API（与免费模型优先铁律冲突） | **不装** |
| 4 | `sqlite fts5` | 20 条（真相关 2-3 条） | rodydavis/how-to-do-full-text-search-with-sqlite（74）、hoangsoft90/sqlite-fts5-queries（11）、martinholovsky/SQLite Database Expert（3K，通用） | **内容级核验**（skills.sh 页面实读）：rodydavis=单篇博客转技能的入门级（fts5 虚表/MATCH 基础），**无中文分词/预分词内容**——而本项目真正难点恰是中文（RISK_REGISTER R-10：jieba 预分词+三层降级）；martinholovsky=通用 SQLite 专家非 FTS5/CJK 专精；hoangsoft90 11 installs 未过可信门槛且按名仅覆盖查询语法 | **不装**（最强候选核验后 <80%） |
| 5 | `pdf compression` | 20 条（真相关 ≈4 条） | compdfkit/compdf-compress-pdf（18，商用 SDK 向）、franklinbaldo/pdf-compression（13）、minicoohei/pdf-compressor（4）、hst368/pdf-toolkit（1） | **薄技能**：全部 <20 installs；compdfkit 绑商用 SDK；本项目场景明确=full.pdf 50MB 图片重（WFR #12），解法=图片重采样压缩，经验已在册（FEASIBILITY 1.2 引 zongbaoshuo tools/compress_images.py），不值得引外部技能 | **不装** |

## 二、安装清单

**0 件。** 五个查询全部真实返回但无一条同时满足「相关性≥80% 且非重复且非商用绑定」——三因分布：已覆盖（#1）/域错配（#2/#3）/薄技能或内容不达（#4/#5）。与任务预期一致，如实记录。

## 三、手动复核项（翻案条件记档）

1. **skyline 官方系列**：本机已有 skyline-components/skyline-overview；若 P0 前端改用 Skyline 渲染引擎再评估补 skyline-worklet/skyline-route——当前决策=webview 渲染，不动。
2. **FTS5 中文检索落地时**：直接按 R-10 方案走 jieba 预分词建索引列+三层检索降级，不依赖外部 skill；若实施中撞到 FTS5 MATCH 语法级疑难，再回看 rodydavis 技能作语法参考（装它只为查语法不值全局位）。
3. **PDF 压缩腿落地时**：用 ghostscript/PyMuPDF 图片重采样直接实现（管线内 20 行级工具），不装 skill。
4. **wechatpay-apiv3 官方系列**：仅当启用商户侧微信支付（如风险 Plan B「纸质精装版电商 SKU」普通商户号收款）时再装 wechatpay-payment-integration——届时它是 ≥80% 的正域命中。
