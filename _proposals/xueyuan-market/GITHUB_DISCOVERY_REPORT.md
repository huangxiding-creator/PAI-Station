# GITHUB DISCOVERY REPORT — 总包学园·研报商城（Phase 2 外部发现）

> 生成：2026-09-28，Super-Skill Phase 2。方法遵 V4.0 规则：**复用** Idea Factory research-orchestrator 已跑过的 github 渠道结果，不重搜；自有资产逐件实核打分（目录+关键文件抽查，非整读）。全部论断带来源文件名/台账行号。

## 一、外部 GitHub 渠道结果（复用 docket）

| 信源 | 实据 | 判读 |
|---|---|---|
| `RESEARCH_DOCKET/github/_all.json` | 文件全文 = `[]`（0 条结果） | 渠道跑了、没命中 |
| `RESEARCH_DOCKET/github/_all.md` | 文件全文仅一行：`# Channel: github (0 docs)` | 同上，如实落盘 |
| `RUN_LEDGER.md` 行 #4 | 「9渠道如实降级（唯1命中=汇率噪声丢弃）」 | github 在 9 渠道收割中零有效命中 |
| `PROPOSAL.md` 第五节 | 「median maturity 脚本层 n=0（GitHub 中文长尾不命中，如实降级）→ 中性 0.5；可行性证据形态替换为自有生产实证，记分卡取 0.85，双数字均公示」 | 降级后果已在记分卡层闭环，非悬空缺口 |

**结论**：GitHub 对「中文·工程总承包·研报商城」这一垂直长尾 **0 命中，如实降级**。这不是执行缺陷而是事实本身：GitHub 上不存在同域可 clone 的中文工程情报商城；外部开源对本项目的贡献收窄为**组件级**备选（见第三节），**系统级的巨人在自家产线**（见第二节）。

## 二、自有资产适配矩阵（本项目的「巨人」在自家产线）

| 资产 | 实据（本次实核） | 适配度 | 复用方式 | 改造量 |
|---|---|---|---|---|
| **projects/zongbao 四页脚手架** | `app.json` 四页（index/reader/ai/me）+tabBar3；`config/index.ts` featureFlags 三开关（virtualPay/cloud/voiceInput，开通即翻转零改码）+`trialChapterCount: 2` 内建试读闸；`utils/pay.ts` L28 virtualPay=false 优雅降级在位；`content/catalog.json`+`reports/js-shuiwang-2026/chapters.json` 试点内容在位（WFR #11） | **80%** | index(书架)→商城首页；reader→分章阅读器（试读章数已是配置项）；ai→AI伴读；me→我的权益 | **中**——首页/详情页是最大改造件（搜索/榜单/筛选/决策卡），但全在脚手架底盘上做 |
| **biaoxun md2blocks 排版** | `projects/biaoxun/utils/md2blocks.js` 199 行零依赖；`tests/md2blocks.test.mjs` 实数 **恰好 10 个 test()**（含 HTML 兜底：<br>/实体解码/图片降级 alt、中文软换行、截断容错）；WFR #37 单测 10/10 PASS、#38 排版革命实证 | **90%** | 阅读器/详情页块渲染直接搬；docx→mammoth 转出的章节 HTML 走其 HTML 兜底腿消化 | **低**——决策卡/试读结束页新增块模板即可 |
| **qianwen-engine 骨架** | 实际位置 `E:\AI-Station\services\qianwen-engine\`（注：WeAppForge\services\ 路径不存在；实据=`work/ecs_deploy_v025.py` L17 `ENGINE` 指向）。`app.py` 294 行：pay_sign L237（appsecret+session_key **双签名**腿）、offerId 缺→**503 降级** L249-251、unlock_paid L283；`store.py` mark_paid L282 **幂等**（重复回调恒 True）+pay_log 对账；`tests/test_pay_sign.py` 5 向量；ECS 8869 在役（WFR #32-34/#45 公网 401@78ms） | **85%** | xueyuan-engine 抄骨架：login/Bearer token/异步/幂等/pay_sign/503 全同构（AI_NATIVE_OPTIONS #7 同构度>80% 实核成立） | **中低**——换 appid/appsecret/新端口 8871；「购报告=道具直购」复用 pay_sign 一条腿；report 目录/权益模型新写；refund_order 腿新 |
| **content_pipeline** | `pipeline/content_pipeline.py` 162 行：mammoth→h1/h2 切章→`drop_junk_chapters` 噪声过滤→chapters.json（**付费章空壳防包内泄漏** L113-116）→Edge headless 双 PDF（CREATE_NO_WINDOW）→catalog 合并；WFR #12 首跑 19 实质章/试读 6816 字符/full.pdf 50MB（图片重，已记待压缩） | **80%** | 批处理 40 份 docx（单份 CLI 形态已就绪，--trial/--price 已是参数） | **中**——批处理循环+PDF 压缩腿+购者水印个性化三个增量 |
| **ECS 部署配方 + forge.mjs 上传链** | `work/ecs_deploy_v025.py`（tar→base64 分片→云助手→systemd→探针）+ WFR #32-34（双层墙 ufw+SG，12 分钟上云）；`pipeline/forge.mjs` 67 行 L3构建→L4上传→L5体验码逐腿计时；WFR #9 首航 31.8s **且首航 appid 就是总包学园 wxfdb55b184756e89e**；#22/#44/#46 biaoxun 六次 deliver 6.5-13.3s | **95%** | 8871 端口照抄 8869 作业；forge 切 secrets.projectPath 即用 | **极低**——端口/服务名/项目路径三处字面改 |
| harness 回归框架 | `work/harness.cjs` 26 断言含支付 D 场景（已解锁 409/幂等 200，WFR #41/#43） | **85%** | 换断言集复用框架 | 低 |
| 企微通道 | WFR #22/#40/#44 体验码/上新推送在役（errcode 0） | **90%** | 退款率日报/熔断告警/上新通知 | 极低 |
| EPC100 产线内容 | RUN_LEDGER #3：97 项=**40 docx 成品**/358MB；持续补货 | **100%** | 内容源直接上架 | 0 |

## 三、外部开源方案评估（曾考虑/已否决）

> 决策记录原始出处：`AI_NATIVE_OPTIONS.md` #2/#6；外部证据出处：`RESEARCH_DOCKET/deep_viral/_all.md` Q2（海报三路线）。「mp-html 在 docket 无直接信源」是本次实核发现，如实标注（见该行）。

| 方案 | 用途 | 否决理由（证据出处） | 什么条件下翻案 |
|---|---|---|---|
| **Painter**（酷家乐开源 JSON 驱动海报库） | 海报生成 | deep_viral Q2 §2.2（_all.md L97-100）：GitHub 仓库 fetch **degraded**（域名校验拦截，未实读 star/更新，cred 0.6 诚实标注）；51CTO 选型文：功能强但上手复杂（cred 0.6）。对照结论（L118）：研报海报=模板固定+码预生成+朋友圈长按识别 → 服务端 PIL 首选（AI_NATIVE_OPTIONS #2 决 A） | 端侧实时个性化（用户昵称/头像即时合成）成为核心诉求时——决策已预留「端侧补充位」（AI_NATIVE_OPTIONS #2 括注） |
| **wxml-to-canvas**（官方扩展组件） | 端侧海报 | deep_viral Q2 §2.2（L90-95）：官方文档实读 cred 1.0，但仅 3 标签+flex、布局能力★（对照表 L113）；研报海报需封面+大字数据+码的富排版，表达力不够 | 同上——轻量端侧补充场景，与 Painter 二选一 |
| **mp-html**（富文本渲染组件） | 阅读器 | **证据出处如实说明：docket 四路深研 grep mp-html = 0 直接命中**，该决策不靠外部信源而靠自有产线对比——md2blocks 已建成+10 单测+「顶级排版，卖相即转化」已真机实证（WFR #37/#38；AI_NATIVE_OPTIONS #6 决 B）。mp-html 本身曾在 hello 模板 packNpm 打包验证（WFR #5：2 包 617ms 0 警告）=技术路径未被封死，仅是落选 | docx 转出的富 HTML（嵌套表格/复杂图文混排）超出 md2blocks 块模型表达力时，作为兜底渲染器接入——依赖生态已验证可装 |
| **云函数方案**（云开发跑生成/签名） | 海报生成/支付签名腿 | deep_viral Q2 §2.3（L102-104）：冷启动+内存/时长限制+按调用计费在裂变峰值反超自备服务器；WFR #13 类型门实锤虚拟支付真协议要求 paySig+signature **服务端**签名——ECS 自备服务器已承担此腿并公网验证（#42/#45），8869 在役=零增量成本 | 基本不翻——除非整体放弃 ECS 自管形态迁云开发（与 AI_NATIVE_OPTIONS #2/#7 双决策交叉锁定，且与「ECS 0 增量成本」经济账冲突） |

## 四、C4 判定（站在巨人肩膀）

规则：**score≥80% → clone-and-adapt；<60% → from-scratch；两者之间 → 部分底座上新建**。

**A. 自有栈逐件判定（全部 ≥80%，全走 clone-and-adapt）**：

| 件 | 适配度 | 判定 |
|---|---|---|
| forge.mjs + ECS 部署配方 | 95% | clone-and-adapt |
| md2blocks | 90% | clone |
| 企微通道 | 90% | clone |
| harness 框架 | 85% | clone-and-adapt（换断言集） |
| qianwen-engine 骨架 | 85% | clone-and-adapt |
| zongbao 四页脚手架 | 80% | clone-and-adapt（压线达标：底盘/开关/降级全在，首页商城化为最大改造） |
| content_pipeline | 80% | clone-and-adapt（批处理+压缩+水印三增量） |

**B. 新建件判定（无一「无底座裸建」）**：

| 新建件 | 底座盘点 | 判定 |
|---|---|---|
| FTS5 全文检索层 | SQLite 已是引擎存储基座（store.py 同库同机）；中文预分词是从零的新知识（RISK_REGISTER R-10：默认 tokenizer 不适配 CJK，jieba 切词后建索引列；三层降级+LIKE 兜底已设计） | **from-scratch（逻辑层），底座=SQLite in-stack**（综合≈40%） |
| 海报生成器 | PIL 经验在产线（`work/gen_icons.py`、biaoxun tabBar PIL 图标×4，WFR #21）；scene 32 字符契约官方实读 1.0（deep_viral Q1）；模板系统+码池+归因三表从零 | **from-scratch with base**（≈35%） |
| 批评评分引擎 | criticize 端点**存证壳已在产**（app.py L191-199「P0 仅存证（仲裁 P1）」，like 端点同构可参照）；判断层/语义锚定/查重从零（架构=AI_NATIVE_OPTIONS #1；学术特征可抄 deep_refund 4.1/4.2） | **from-scratch with base**（≈30%） |
| 退款自动化 | pay_log 对账表+幂等解锁模式可反向套用（mark_paid 同构于退款回冲）；refund_order API 腿+iOS 书券双轨从零（deep_pay Q4；「部分退款」参数级语义官方未公开须开通后实测） | **from-scratch with base**（≈25%） |
| PDF 压缩腿（附） | 病因已知（full.pdf 50MB 图片重，WFR #12「已记」）；图片压缩脚本经验在册（FEASIBILITY 1.2 表引 zongbaoshuo tools/compress_images.py） | 独立小工具，路径明确（≈50%） |

与 FEASIBILITY_REPORT 1.2「P0 无一件高难度新建件」互洽：两件中高（批评评分/退款）都有端点壳/对账表垫底，属 P1。

## 五、结论

P0 总体复用率估计 **≈80%**（按件加权：部署95/排版90/引擎85/前端80/管线80，且首航 appid 就是总包学园本体）——外部 GitHub 同域 0 命中如实降级后，「巨人」确认在自家产线，外部组件仅 mp-html 作兜底保留。**最大的三块新建工作量**：① 商城首页+详情页前端（搜索/榜单/筛选/决策卡——脚手架内的最大改造件）；② FTS5 全文检索层（中文预分词是真正的新知识，含三层降级兜底）；③ 批评评分引擎+退款自动化（P1 两件中高：端点壳/对账表在产，但判断层与 refund_order 腿从零）。P0 关键路径上没有任何无底座裸建件。
