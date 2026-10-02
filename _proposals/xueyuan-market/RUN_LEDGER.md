# RUN_LEDGER — xueyuan-market（总包学园·研报商城）

## 2026-09-28 Idea Factory 全流程（用户令：Super-Skill 不跳环节，提案经批准后开发）

| # | 时间 | 动作 | 实测结果 | 下一步 |
|---|---|---|---|---|
| 1 | 白天 | idea-intake：评分器首跑 score=5 ask（persona/pain/constraints 弱）→ 以项目记忆默认值补齐重评；残留 ask 系中文关键词启发式误判（value_hypothesis 原文在档仍判 missing）→ 诚实记 ask→auto-resolved | IDEA_SEED.md 落盘（假设3项待批准门确认） | — |
| 2 | — | 密钥卫生：AppSecret 入 data/secrets/mp_secret_wxfdb55b184756e89e.secret；上传密钥 P1 已在位 | 凭证单点实弹 errcode=0 token 137字符（对比 biaoxun 抄错字符教训，零误差） | — |
| 3 | — | 资产盘点：EngOpp-Mining/reports 97项=**40 docx 成品**/358MB/0 PDF；zongbao 脚手架4页+catalog(1试点19章)在位 | 内容源确认「存量直接上架」（用户午间补充） | — |
| 4 | — | research-orchestrator 9渠道：GBK print 崩（收尾）但收割已落盘；UTF-8 重跑全绿 | 9渠道如实降级（唯1命中=汇率噪声丢弃；producthunt/googletrends degraded）；quality_passed=false → 6 gap 全部对应4深研 | — |
| 5 | — | 4路深研 agent 并行（pay/competitors/refund/viral） | 98条带URL信源全落盘（官方文档多篇1.0/0.95实读；degraded逐条诚实标注） | — |
| 6 | — | proposal-forge 脚本实跑：tenx（首跑 dev_efficiency 单位反向假劣→修为周产出版本数10x 重跑）/pricing(n=1 premium)/maturity(n=0 中性) | **TenX 2.681=480× tenx_qualified**；scorecard **0.875 proceed**；scorecard_input rationale 全链路可溯源 | 批准门 |
| 7 | — | PROPOSAL/BUSINESS_MODEL/SCORECARD/DIGEST/GAP 六件套落盘 | — | **等用户批准/修改/否决** |

## 关键证据坐标

- deep_pay：虚拟支付唯一合规通道/2026-04-01全终端强制/¥498道具直购/iOS12%+不可主动退/Android refund_order 180天
- deep_refund：消保法25条数字内容豁免/承诺即合同事前公示/点赞必得=附条件赠送/随机抽赠须公示概率/三道闸+25%熔断
- deep_competitors：¥1888/300页实锤锚/垂直无竞品/20%试读舒适带/三招可抄三招禁抄
- deep_viral：getUnlimited scene 32字符官方实读/服务端生成推荐/邀请解锁+组队双引擎安全区/K≈0.1-0.2基线

## 批准门待确认 8 项（PROPOSAL 第九节）

主体类型/¥498/20页/退款映射/点赞必得/内容源/8871端口/虚拟支付开通人工位

## 2026-09-28 批准门通过

| # | 动作 | 结果 |
|---|---|---|
| 8 | 用户答复「总包学园小程序主体是企业」 | 唯一阻塞确认项放行=批准；其余7项按提案默认；进 Phase 0 全自主 |

## 2026-09-28 Phase 1

| # | 动作 | 实测结果 | 下一步 |
|---|---|---|---|
| 9 | Phase 1 可行性+风险登记落盘（FEASIBILITY_REPORT.md 七节：复用盘点 8 在役件/新建 8 件无高难、三档营收全标注估算、P0 依赖图三线并行；RISK_REGISTER.md 14 条含 top3 展开，12 项指定风险全覆盖；复用证据实核 WFR #9-46/md2blocks 10 单测实数） | CC-FPS=0.80 GO | 进 Phase 2 |

## 2026-09-28 Phase 2+2b

| # | 动作 | 结论 | 下一步 |
|---|---|---|---|
| 10 | 外部发现+自有盘点+skills 发现落盘：GITHUB_DISCOVERY_REPORT.md（github 渠道 0 命中如实降级复用 docket `_all.json=[]`/`_all.md 0 docs`；自有 8 件适配矩阵逐件实核打分 80-100%——含路径勘误：qianwen-engine 实居 `E:\AI-Station\services\`；外部 4 方案 Painter/wxml-to-canvas/mp-html/云函数否决理由+翻案条件均带出处；C4 判定=自有栈 7 件全 ≥80% clone-and-adapt、新建 5 件均 from-scratch-with-base 无裸建）+ SKILLS_DISCOVERY_REPORT.md（npx skills find 5 查询全真跑 EXIT=0；评估后 0 安装=已覆盖/域错配/薄技能三因；4 项翻案条件记档） | 巨人=自家产线（P0 总体复用 ≈80%），三大新建=商城前端/FTS5 中文检索/批评评分+退款自动化 | 进 Phase 3 |

## 2026-09-28 Phase 3

| # | 动作 | 结论 | 下一步 |
|---|---|---|---|
| 11 | 知识库三件套落盘：KNOWLEDGE_BASE/ 7 文件（virtual_pay/refund_criticism/viral_poster/market_pricing/content_pipeline/engine_conventions/mp_review_compliance，各 100-136 行、浓缩源注明、试点 19 章实样核验）+ SCHEMAS.md（13 表 SQLite DDL 草稿按 P0/P1/P2 分组，criticisms 四层闸字段/归因三表首触唯一约束；catalog.json/chapters.json 文件契约）+ CONTEXT.md（41 条统一语言含禁用同义词） | 口径坑入库：试点 catalog price=990 分系遗留值，正式统一 49800 分（Phase 5 上架脚本参数化） | 进 Phase 4（已并行在跑） |

## 2026-09-28 Phase 4

| # | 动作 | 结论 | 下一步 |
|---|---|---|---|
| 12 | REQUIREMENTS.md 落盘（162 行）：JTBD 11 故事×3 persona；FR 28 条（P0×10/P1×12/P2×6）条条 GWT 可测+溯源；NFR 14 条；新能力透镜（纸笔残留 8 项判定/AI 锤子 8 位审计=真判断位仅批评评分+伴读/版权两问挂提审门）；P0 上线门 10 条硬判据；批准门状态=用户门 2026-09-28 前置满足基线冻结 | 两歧义收敛：预览三件套读法待 ARCHITECTURE 定稿；书券按「攒券换报告」避开道具固定价差价难题；组队未满员处置=规则公示后才上线 | 进 Phase 5 |

## 2026-09-28 Phase 5+5b

| # | 动作 | 结论 | 下一步 |
|---|---|---|---|
| 13 | ARCHITECTURE.md(238行,ADR×8)+API_DESIGN.md(294行,P0×13+P1×12+P2×5组端点,28FR/14NFR 双覆盖索引)落盘。生产代码实核三契约：pay_sign 双签名 separators 逐字节透传+outTradeNo 字符集；503=缺 offer_id/product_id 三行 secret 触发、session_key 失效走 401 重登非 503；mark_paid 幂等骨架。增补 favorites/read_log/teams 三组表（只增不改） | **A8：zongbao appid 即总包学园本体（projectname=zongbao-xueyuan）→ 前端原位改造不新开项目**；微信未公开字段（回调载荷/查单/refund_order 部分退款/组队拆分）全标 TBD 开通后实测 | 进 Phase 6 |

## 2026-09-28 提审前置·版权审计（与 Phase 6 并行）

| # | 动作 | 实测结果 | 下一步 |
|---|---|---|---|
| 14 | 40 份 docx 图表来源审计（COPYRIGHT_AUDIT.md）：40/40 正常打开零损坏；图片共 42 张全 PNG 集中在 6 份省级报告（各 7 张，34 份纯文本零图）；三重证据链（matplotlib tEXt 签名+dpi150 / MD5 与 charts_* 源图字节级同源 / 图注无截图转载水印关键词）+ OLE/外链/页眉脚图全零 | **自产 42/42=100%，高危 0，复核 0 → 前置条件 5 图表维度满足，零处置**。三遗留：①江苏×2/西藏×2 双版本同图（MD5 互同）→上架每省择一版 ②34 份纯文本文档的文字引用维度未审（图表审计范围外，文字引用抽检挂 Phase 8 内容批处理时做）③产线未来新素材须先过哈希登记闸否则自动落人工复核档 | 不阻塞；随 Phase 8 处理①② |

## 2026-09-28 Phase 6

| # | 动作 | 实测结果 | 下一步 |
|---|---|---|---|
| 15 | WBS.md(162行)+TASK_BACKLOG.md(53行)落盘：Epic-P0 29 任务×5 垂直切片（切片①=tracer bullet 试点报告端到端 T-P0-01~17，B/C 线按冻结契约 mock 并行，缝合验收=T-P0-17）+Epic-P1 15 任务×7 Story；每任务六要素（编号/产出/依赖双写/判据挂 FR/NFR 编号/规模）；关键路径 C线→铺量→上云→门禁→审核；A∥B∥C 三窗口并行映射；R-01/04/06/10 风险联防挂到具体任务 | P0=12S+16M+1L≈24 人日（估 20-28）agent 并行后日历 2-3 工作日；P1≈15.5 人日（估 13-19）。设计亮点：搜索两步走（切片① LIKE 最小腿先通链路→切片② 40 份规模上 FTS5 三层降级才可验）；书券 T-P1-14 提到 P1 首位（退款双轨/邀请/组队共依赖） | 进 Phase 7 |

## 2026-09-28 需求基线变更 #1（用户令）

| # | 变更 | 内容 | 影响 |
|---|---|---|---|
| 16 | 用户常驻令：新报告双通道分发（公众号宣传+**小程序直接上架在线售卖**） | 上架从一次性批量升格为**产线常驻出货通道**。设计承接：①content_pipeline 增量幂等=新 docx 落盘即纳管（无 --force 时仅处理新增，天然增量）②**服务端真源=新报告无需小程序发版即可售**（详情/付费正文/PDF 下载全走引擎 8871；试读章包内化随下次常规发版 forge 秒级）③远期=EPC100 收尾钩子/定时扫描自动衔接。新增验收：往 reports/ 放一份新 docx→跑增量命令→catalog+1、详情/试读/购买链路立即可用 | 挂 T-P0-02（批处理循环增量语义）+T-P0-23（上云内容同步）；不涉支付/退款/合规，NFR-09 无需重过 |

## 2026-09-28 Phase 7

| # | 动作 | 实测结果 | 下一步 |
|---|---|---|---|
| 17 | 引擎骨架落位 services/xueyuan-engine/（.venv 自包含；wechat.py 逐行照抄换名含 pay_sign 双签名；store.py 17 表 DDL 幂等；app.py 装配+9 业务域空 router+/health+/auth/login+XY_DEV_LOGIN 闸；config 全阈值配置项含 REPORT_PRICE_FEN=49800）+ zongbao 撬入 md2blocks（10/10） | **pytest 13/13 绿（0.98s）**；8872 起 /health 200+dev login token 验回+确杀无残留；真 secret 烟测 502=微信 40029（接线通的实证）；单文件≤280 行；零既有文件改动未 commit。差异 5 条如实记录（TTL 配置化/session_key 并列 users.login 无 quota/路由 404 形态留 Phase 8） | **端口事故闭环**：8870=qianwen 门实例被误杀→已复活（docs=200），xueyuan 影子位改 8872 入档；进 Phase 8 B/C 双线 |

## 2026-09-28 Phase 8 · A 线（内容批产线）

| # | 动作 | 实测结果 | 下一步 |
|---|---|---|---|
| 18 | batch_up.py(344行)+pdf_compress.py(134)+batch_meta.py(100) 旁挂母本零改动；幂等/--force/--only/--verify/增量语义（常驻令#16 落实）。**三实测发现**：①48.5MB 真凶=Edge PDF 结构树 42MB（非图片），摘除+GC→5.8MB/3s/1290 页文本完好；②40 份中 26 份无标题单块（strong 编号段）母本切章会成 1 章 0 付费章→梯级切章 100% 覆盖 9-18 章；③固定试读 2 章破 15-25% 带（江苏 0.6%）→自适应选章 | 试点重跑基准逐字节一致；PDF 49.07→5.44/5.47/1.57MB；catalog 990→49800 修正；3 省级冒烟全入带（浙江16.2%/甘肃15.6%/西藏15.4%）；--verify PASS；幂等复跑 built:0 skipped:4 | **全量 38 份批量已由主会话触发（后台）**。遗留四项：江苏附录巨章 9.1% WARN（章内截断未做）/ownerType 待补 15 份/6 份 <5K 字薄商品 ¥498 匹配风险留运营判/解释器锁定 Python311 全家桶 |

## 2026-09-28 Phase 8 · C 线（商城前端）

| # | 动作 | 实测结果 | 下一步 |
|---|---|---|---|
| 19 | zongbao 原位改造 16 文件：api.ts 统一客户端（401 静默重登恰一次/503 灰置/服务维护兜底）+mock-fixtures（API_DESIGN 形状+防泄漏字段缺席断言）+index 商城首页（包内秒开→刷新/搜索防抖两层/榜单/筛选 chips/分页）+detail 新增页（决策卡模糊结论/预览三件套/价格锚参照/发票/披露三件）+reader（md2blocks/🔒占位/末章决策卡/scene 容错）+me（已购收藏双源）+md2blocks.wxss 共享排版 | **node --test 43/43**（15 单测+4 页面走查+24 预存零回归）；L3 构建门 PASS（tsc+packNpm）；五页 wxml_lint 全过；全文件 ≤384 行；console.log 零。联调=翻 mockApi flag（默认 true）；PROD_BASE 域名 TBD 占位；支付灰置三层矩阵齐备 | 等 B 线落地→T-P0-17 缝合验收（翻 flag 联调试点端到端） |

## 2026-09-28 Phase 8 · B 线（引擎业务）

| # | 动作 | 实测结果 | 下一步 |
|---|---|---|---|
| 20 | 引擎切片①全量实装：sync_from_catalog 进库钩子（启动自动+admin/resync）/catalog+详情决策卡+三维关联/chapters 权益裁剪（付费章 html 字段缺席）/LIKE 两层搜索/pay_sign+回调幂等+XY_FAKE_PAY 生产禁启自检/水印流式下载/me+收藏/限流中间件 | **pytest 56/56 绿，覆盖 TOTAL 95%**（全模块 ≥82%）；8872 实弹全链：503 精确体→沙箱假值真签名（goodsPrice 49800）→假回调 first:true→重放 first:false 恒 200→已购 3037845 字→水印 24.5MB/1290 页 extract_text 还原 uid+订单尾号→再购 409→净收尾（杀进程/删临时 secret）。修 4 bug：fts 路由漏注册/ApiError.extra/store 双键兼容/空壳断言口径 | **转工单 5 条**：①chapters_full.json 批量产（已派 A 线复工，最高优先）②catalog tags 缺→hot_words 空（容错在）③试点 trial=17/19 数据决策留提审前评审④单章腿 P0-6 未实装⑤回调官方字段名待真凭证 |

## 2026-09-28 Phase 8 · 全量批量收官

| # | 动作 | 实测结果 | 下一步 |
|---|---|---|---|
| 21 | 全量批处理后台实跑（40→去重 2→38 份清单；built 34+skipped 4=38；江苏/西藏双版本去重留新时间戳版，章/字/图 MD5 三重一致）+--verify | **EXIT=0 全 PASS**：catalog 38 条=清单 38 条；空壳抽验 3 份（ezhou/gs/henan-huizong）包内付费指纹零命中；PDF 全部 ≤10MB 档。**WARN 5 份越带**：hubei-huizong 33.3%/hubei-shuili 27.5%（偏高）+yichang 14.9%/jingmen 14.7%/js-shuiwang 试点 9.1%（偏低，附录巨章）——章内截断未实装，提审前统一评审 | A 线已获绿灯跑 chapters_only 回填（38 份付费正文全集）；引擎下次启动 sync 自动吃 38 条 |

## 2026-09-28 Phase 8 · B 线工单#1 完结（chapters_full+tags）

| # | 动作 | 实测结果 | 下一步 |
|---|---|---|---|
| 22 | chapters_full.py(62行) 新增+batch_up.py 394 行挂两钩（构建路径复用章数据零重解析+backfill_one 不碰 Edge/PDF+--chapters-only 模式+一致性硬闸：章 id/标题序列不齐拒落盘）；catalog make_tags（推不出留空） | **回填 37+1=38/38 全落位（2.5 分钟）**；抽验 3 份章 id/标题逐一对齐+全章 html 非空；与 B 线站位件 19 章逐章 dict 相等（双产线互证）；tags 38/38（3-5 个/份）；--verify 收口 PASS；今后新报告构建路径自动携带 chapters_full+tags 零手工 | 缝合验收（T-P0-17）在跑；其后 FTS5 切片② |

## 2026-09-28 Phase 8 · T-P0-17 缝合验收

| # | 动作 | 实测结果 | 下一步 |
|---|---|---|---|
| 23 | 契约对拍（mock-fixtures 对齐引擎 10 项微调+tsc 零错+出厂门 19/19）+活体冒烟两轮 29 步（无 secret 11/11：503 精确体/防泄漏判据；临时 dev secret 17 PASS+1 GAP，secret 跑毕即删复核）+活体页面走查 27/27（wx.request 桩换真实 fetch 变体）；交付 STITCH_REPORT.md+两可复跑探针脚本 | **带条件 PASS**。A1 FAIL 级断链：P0-6 单章端点引擎未实装而 reader.ts:137 已购付费章独走它→已购读不了付费章（已派 B 线复工补端点，建议走引擎侧保防泄漏主闸）；A2 layer_used 恒 like（FTS5 切片②自愈）；数据态：试点 trial=17/19 与产品口径反差（A 线治理项挂提审前评审） | B 线补 P0-6→复跑探针→无条件 PASS→切片② FTS5 |

## 2026-09-28 Phase 8 · A1 断链闭链（切片①无条件 PASS）

| # | 动作 | 实测结果 | 下一步 |
|---|---|---|---|
| 24 | B 线复工补 P0-6 单章腿（chapters.py 97→133 行：判序 404→401→429 限流→403 html 缺席→200 全量；试读章免登录；read_log 落库；响应=契约超集双全 id/title/pages+chapter_id/is_trial）+3 新契约测试 | **pytest 59/59**（chapters 覆盖 98%）；缝合探针复跑：第一轮无 secret 11/11、第二轮 18/18（原 GAP 步 9 现绿：单章端点在役，支付链→解锁→单章 2.39M 字全过）；活体页面走查 27/27；净收尾（secret 0 残留/8872 清零/8870 未动） | **切片①收官=无条件 PASS**。开切片② FTS5（38 份规模三层降级+P95 压测） |

## 2026-09-28 Phase 8 · 切片④备料（部署）

| # | 动作 | 实测结果 | 下一步 |
|---|---|---|---|
| 25 | ecs_deploy_xueyuan.py（/opt/xueyuan/8871/独立 venv/FORBIDDEN 审计含 8869 误带自纠/--dry-run=plan 所查即所跑）+ecs_upload_xueyuan_data.py（core/pdfs 两相位断点台账）+nginx 模板+ECS 只读预检 | **上云路线定案（混合）**：OSS=403 UserDisable（用户控制台位）；实测资产仅 122MB（纠正 475MB 高估）：core 594 片/**49 分钟当天全功能**，pdfs 6,309 片≈8.6h 四晚分批或 OSS 开通即整切；ECS 预检：12G 磁盘/7.1G 内存/8871 空闲/Python3.12.3/ufw active；两脚本干跑 EXIT=0，零写入 | 部署日=FTS5 收官后：ufw→上传 core→systemd→探针→（用户）安全组 8871→pdfs 夜航；切片⑤合规文案已并行开写 |

## 2026-09-28 Phase 8 · 切片② FTS5 中文检索（T-P0-19）

| # | 动作 | 实测结果 | 下一步 |
|---|---|---|---|
| 26 | fts.py 重写 283 行（jieba lcut+HMM 预分词/lru_cache 缓存；reports_fts 虚表四列 title/summary/chapter_titles/keyword_toks 外部内容表 content='fts_docs'——契约样张 content='' 的可维护变体（增量重建须旧值回删）；三层降级 L1→L2（聚合报告级+超集字段 hit_chapters）→L3（keyword_toks=tags+省份/业主/行业元数据，EPC100 章节商机实体标注接入后追加）→LIKE 两子层兜底→none+fallback_hint；入库钩子 store.sync_from_catalog→rebuild_reports（局部导入防环；失败不阻塞进库，读路径不建表缺表自愈降级 LIKE）+基准脚本 tests/bench_search.py（store 层直调真库）+契约测试 14 条（拆词命中/逐层触发/layer_used 标记/表缺与空索引双形态 LIKE 兜底/tags 空容错/热词频次排序/off 回表过滤/增量重建回删） | **pytest 68/68**（59 基线+9 净增）；真库 38 份/532 章 100 采样：P50=3.1ms **P95=6.4ms**（<500ms NFR-01 PASS，78 倍余量）max=11.0ms，层分布 L1:23/L2:38/L3:10/none:29；三层实查：水网工程→L1(js-shuiwang-2026)、时间窗口→L2(4 报告带第十一章命中章列表)、政府→L3(23 报告 owner=政府水利部门)、究——→like(5 报告跨 token 边界)；store.py 恰 400 行（红线持平）；jieba 0.42.1 requirements 在位免装 | A2 自愈点闭案：缝合期 layer_used 恒 like 的阶段差消除，STITCH_REPORT A2 记录自然过期；hot_words=契约 Top N（config=8）随 /search 响应下发；待部署日随切片④上云（ECS 侧启动 sync 自动建索引） |

## 2026-09-28 Phase 8 · 切片⑤ T-P0-25（合规披露文案）

| # | 动作 | 实测结果 | 下一步 |
|---|---|---|---|
| 27 | AGREEMENT_COPY.md（163→165 行）落盘=用户协议/退款/点赞赠/组队/书券/发票/页脚七节文案真源，各节带「嵌入位置」标注 | 数字逐字对齐 KB（50-300 字/月≤2 次/50→50% 线性含 70 分→¥348.60 例/每日限 1 份/498 券=1 份/¥998 组队）；熔断黑名单只写「平台保留权」内部阈值零外泄；iOS 双轨如实（明写不可主动退）；「必得·附条件赠送」原语+与分享无关声明；禁用词 grep 零命中；**主会话裁定**：评分三维取冻结基线口径「真诚度/真实度/建设性」（任务提示的「内容」维由建设性语义覆盖，改用户侧命名须升版本）；邀请奖励补对接注（FR-P1-09 双组件，「解锁完整免费部分」P1 实现期回填本文件） | T-P0-26 前端嵌入（支付前弹层三件/页脚一行版/独立规则页）；其后 T-P0-27/28 QA 断言集→T-P0-29 提审包 |

## 2026-09-28 Phase 8 · 切片⑤ T-P0-26（前端披露嵌入）

| # | 动作 | 实测结果 | 下一步 |
|---|---|---|---|
| 28 | zongbao 嵌入三件：utils/agreement.ts（267 行=文案单一真源，七节结构化+PAY_SHEET+FOOTER_DISCLAIMER，升版本只改此文件）+pages/agreement 新页（七节全文折叠渲染/anchor=pay 锚定第二节/三要点卡）+pay-sheet 共享弹层模板（detail/reader 同源；503 灰置时规则照常可看）+页脚一行版绑定+me 页入口；pay.ts 顺手删 confirmPayDisclosure 死代码 | **node --test 48/48**（主会话亲测复跑；43 存量+5 新增）；tsc+packNpm L3 门 PASS；单文件最大 267 行；**文案逐字性=AGREEMENT_COPY 76 条正文行↔常量双向 diff 100% 覆盖**（主会话抽验 5 处关键句逐字命中：70 分→¥348.60/月≤2 次/不支持七天无理由退款/页脚/必得·附条件赠送） | T-P0-27/28 QA 断言集换装（harness）∥ T-P0-29 提审包材料，双开 |

## 2026-09-28 Phase 8 · 切片⑤ T-P0-29（提审包材料）+ 部署日提前

| # | 动作 | 实测结果 | 下一步 |
|---|---|---|---|
| 29 | REVIEW_PACK.md（185 行）六部分：信息表（类目=KB 首选「教育/知识付费」主报+「工具」备选；「商业资讯」不在 KB 开放清单证据中标待核）/应答卡 Q1-Q7（含审核员免登录体验路径）/必办 8 项（增值电信/ICP=KB 无记载如实标待核不编造）/**数据治理决策单①-⑤**/Day-0 十步走查（提审可先于虚拟支付开通 R-01）/P1 四道前置 | **制包三实测修正超在档记录**：①薄商品名单 6→**13 份**（scan_cache.json 全量复核 2,120-4,683 字）；②5 WARN 越带=章粒度结构问题（逐章累计复算五份均无整数章落入 15-25% 带，hubei-huizong 已 trial=1 最小值）→默认建议改「接受+联动处置」；③hubei-huizong-20260807 薄+越带双榜同源（3,990 字×33.3%），下架即双解。新发现⑤=AI 脚手架 tab（云开发 extend.AI 预览文案）随包提审的拒审观感风险，默认隐藏 | **等用户勾选决策单①-⑤**（①越带全接受 ②js-shuiwang 决策卡明示 ③下架最薄 6 份 ④ownerType 提审后补 ⑤隐藏 AI tab——⑤与 harness 在跑件同文件，待 harness 收官后执行）；部署链在跑（见 #30） |
| 30 | **部署日提前实跑**（主会话亲审两脚本+三方路径契约核清：chapters_full→/opt/xueyuan/data/xueyuan/content=SERVER_CONTENT_DIR/包内容→content_pkg=XY_CONTENT_DIR/db→DB_PATH；顺序=先数据后引擎，首启即带内容同步建 FTS=生产行为预演） | 后台链：ecs_upload --phase core（594 片≈49 分）→ecs_deploy（引擎+venv+systemd+ufw+本机探针）；安全组不开（上线日用户一键）；PDF 夜航另排 | 跑毕验收：探针 200+38 份进库实数+重启拉起实测→记 #31 |

## 2026-09-28 Phase 8 · T-P0-27/28（QA 发布门禁）+ 断链根因修复

| # | 动作 | 实测结果 | 下一步 |
|---|---|---|---|
| 31 | harness_xueyuan.cjs（30 断言=25 硬门 XY00-24+5 诚实 SKIP）+package.json harness:xueyuan 注册+QA_HARNESS_REPORT.md；第二轮坏值注入验证（临时副本 price 990→FAIL 退出码 1 输出精准定位）验后零污染 | **首轮 24 PASS/1 FAIL——FAIL=F1 真缺陷非误报**（app.ts 两处 console.log 随包上传，cloud=false 生产冷启动每次打印）；主会话三修：**F1**=app.ts 去 console.log（降级注释化）；**⑤**=AI tab 隐藏（app.json 去 pages/tabBar 项+packOptions.ignore 整目录排除出包，P2 回归）；**F4**=pdfs 树 24MB 水印测试残留清除（download.py wm/=按用户缓存可再生；**新观察：ECS 上 wm 缓存无淘汰策略，100 用户×38 报告×2 类型长期增长，P1 加淘汰或改流式**）。重建+复跑：**node --test 48/48，harness 25 PASS/0 FAIL/5 SKIP=ALL PASS** | F3（catalog 38 vs 门#1 目标 40）=去重所致（#21），门判据按「上架清单全量」口径执行如实备注；SKIP 五条理由在册（活体由 stitch_live_*.mjs 与真机覆盖） |
| 32 | **ECS 链首跑断链根因修复**：143/597 片处 DescribeInvocationResults 遭 TCP 重置（198.18.0.1=代理 fake-ip 段，系统代理不稳，单瞬断杀全链） | 修系统两招入两脚本：①run_aliyun 剥离 HTTP(S)_PROXY/ALL_PROXY 直连（aliyun 中国端点无需代理）②describe_inv 查询侧安全重试（纯读可任意重试 4 次 5/10/15/20s 退避；RunCommand 不重试——双执行会污染 printf>> 追加分片）；py_compile 过 | 补丁链已重启（task bf38qhq2f）；跑毕验收记 #33 |

## 2026-09-28 需求基线变更 #2（用户令：决策单全按默认）

| # | 变更 | 内容 | 影响 |
|---|---|---|---|
| 33 | 用户批准 REVIEW_PACK §四决策单①-⑤全默认：①5 WARN 越带全接受 ②js-shuiwang 决策卡明示付费范围 ③**提审前下架最薄 6 份**（38→32） ④ownerType 提审后补 ⑤AI tab 隐藏（已于 #31 执行） | **③落地=off sidecar 机制**：content/off.json 旁挂位（产线永不写）+catalog.apply_off_sidecar（幂等对齐全库 status：在列=off 列表/详情/关联/搜索全屏蔽，移出即复上架；损坏按空处理）+lifespan/admin_resync 双接线；6 份名单=hubei-shuiliting/zhumadian/luoyang/kaifeng/xuchang/sanmenxia-shuiliju-2026。**②落地=paywallNote 通用规则**：试读占比>50% 时决策卡自动出注记「前 X/N 章免费；付费解锁的是末 Y 章数据本体（商机项目清单明细）」——不硬编码 slug，任何高试读比报告通用 | 引擎 pytest **70/70**（+off 双测：下架/复上架/损坏容错）；前端 **49/49**（+paywallNote 测：17/19 触发/低比例不触发/离线兜底不触发）；harness 复跑 **ALL PASS**；生产翻 off 走 systemctl restart（admin/resync 为 dev 闸）；ECS 侧 off.json 随链毕补送（core 载荷始建于 off.json 之前） |

## 2026-09-28 需求基线变更 #4（用户令：情报裂变 2.0 全量采纳）

| # | 变更 | 内容 | 影响 |
|---|---|---|---|
| 37 | 用户令「基于我的想法设计创新玩法，比我的方案好 100 倍」+「目的=高品质研报快速病毒式裂变」→ 设计交付 VIRAL_100X.md（五引擎：商机卡主引擎/报告即媒介 PDF 个人码/周榜/一周商机故事/情报官质量门体系）→ 用户选「**全量采纳**」 | 核心洞察=付费章本身是裂变物（一条商机一张卡，分享语义从求人扫码变递情报人情）；K 模型 0.1-0.2→0.4-0.8（诚实估算+漏斗两周校准）；FR-P1-09 判据升级「2 裸扫码」→「N 有效带新（读完≥1 章试读）」，AGREEMENT_COPY v1.1 馆友双组件文案已兼容；红线自查全过（无分销/无强制分享/无现金/无新增随机抽赠） | **波 3 全量入 scope**：3a=A 线商机抽取钩子+38 份回填+E3 并卡模板+卡片详情页+H5 长尾页；3b=情报官判据切换+AC v1.2+榜单/故事管线；3c=PDF 个人码尾页+K 看板。在跑四路零停工全复用（E1 账本=情报官账本/E3 引擎=卡渲染底座）；公众号双通道常驻令闭环（宣传文=商机卡 H5 合集） |

| # | 变更 | 内容 | 影响 |
|---|---|---|---|
| 34 | 用户令二连：①「请你自行安全组放行 8871」（与 9-17 阿里云 CLI 全自主授权一致）②「p1、P2 全开发完」 | ①sg_xueyuan_8871.py 开闸工具（open/close/check 幂等+传播延迟轮询 ≤20s，实锤传播延迟坑）；规则已生效：sg-f8z293gtze06l969ebtg `TCP 8871/8871 0.0.0.0/0 xueyuan-engine Accept`（22 条 ingress 并存无冲突）；**公网探针待部署链落位（ufw+systemd 在链内）后即绿**。②P1（可传闭环 15 任务）+P2（AI 伴读/订阅消息/已购检索/转赠/会员 B 端）全量开发启动——设计基线已在位（FR/API/WBS 冻结），纯 Phase 8 执行；三波 agent 军：波1=引擎社交经济簇∥引擎批评退款簇∥前端 P1（对冻结契约+mock 并行），波2=海报+QR 池∥P2 引擎簇，波3=前端 P2+缝合 QA | 免费模型铁律全程约束（判断层/AI 伴读免费端点调研先行，付费 API 调用数=0）；P2 会员/B端=平台门（DAU≥1万+90天）只做 flag-off 脚手架+文档；AI tab 将以正确形态（引擎 KB 直连 FR-P2-01）回归 |

## 2026-09-28 Phase 11 · 生产上云收官（P0）

| # | 动作 | 实测结果 | 下一步 |
|---|---|---|---|
| 35 | **ECS 生产部署三跑收官**（数据相位首链毕：38 份 content_pkg+content+db 10.9MB；引擎相位两断两修：①云助手 RunCommand 默认 60s 超时杀 venv/pip（ExitCode=-1）→ 补 `--Timeout 600`，参数名二跑实锤为 **Timeout 非 TimeoutSeconds**；②重跑 b64 二次追加污染隐患 → cmd_mkdir 加 rm 幂等头）+ off.json 送达 | **全绿**：venv PIP_OK+IMPORT_OK（fastapi/uvicorn/curl_cffi/jieba/PIL/pypdf）/systemd active+enable/ufw 8871 双栈 ALLOW/**公网探针 health=200（87ms）**/off.json 送达重启后**公网 catalog total=32（=38−6 下架名单生产生效）**；ship_off_json.py 常驻运维件交付（本地改名单→一键送达+重启+验收，含 json 预校验防半写）；**引擎绿灯 ENGINE_EDITS_GREEN_LIGHT.txt 已放**（波1 两路引擎 agent 结束只读备料转写入） | 波1 三 agent 在跑（E1 社交经济/E2 批评退款/F1 前端）+版权文字抽检 agent；PDF 夜航四晚批待排；ECS 无 CJK 字体实锤（海报模块须自带 OFL 中文字体，走分片通道单独落位不进部署包） |
| 36 | **版权文字维度抽检收官**（RL #14 遗留②闭环，COPYRIGHT_AUDIT_TEXT.md 落盘）：34 份纯文本全扫三类高危信号（a 转载痕迹 280 处/b 新闻体整段 0/c 第三方机构数据未标注 0）+seed=42 抽 6 份约 1.98 万字通读 | a 类 280 处逐条回溯**全部为自有溯源标注**（269「来源：」=模板口径声明+商机条目采集站点标注；11 处 URL 全指 .gov.cn 公告溯源）；抽检软性照搬四指征零发现=模板+大模型自产文体；**总结论=34 份文字维度提审就绪，与图表维度（42/42 自产）合并支撑 40 份 docx 无第三方版权素材** | 附带两项非版权瑕疵：①14 份文档泄漏 ```markdown 围栏（A 线排版 bug→**转工单：产线批处理 md2docx 前须剥围栏**，存量 14 份提审不受阻）②西藏 1 处「咨询公司调研数据」模糊归因（下版修订）；不阻断提审 |

## 2026-09-28 Phase 11 · 体验版 0.3.0 上传收官（用户令「请发布为体验版」）

| # | 动作 | 实测结果 | 下一步 |
|---|---|---|---|
| 38 | **p1 总开关接线**（config/features.p1：live 树默认 true，me/detail/reader 五页入口全联动 wx:if，零死按钮）+ smoke 测试改判据（giftTabEnabled 随 flag：开可见/关重载后隐藏 makePageFresh 双态断言） | tsc EXIT 0 · node --test **66/66** · harness 修两处过期判据（XY06 v1.0→**v1.1** 链三段齐=协议 v1.1 镜像 ratified；XY13 豁免位扩 mock-fixtures-**p1**+该文件加 hex-appid 合规腿）→ **ALL PASS 25/0/5** | 快照 flip 工艺固化（一处 config 四翻：p1:false/apiEnv:prod/mockApi:false/PROD_BASE→http://47.120.43.20:8871/api/v1） |
| 39 | **体验版快照+上传**（work/zongbao_trial 四翻快照；upload_xueyuan_trial.mjs=upload+preview 双动作）· **两轮瘦身实锤**：①首轮 4194KB>2MB 被拒（errcode 80051）→ 剥 @vant 1183K+mp-html 48K（**全库零引用脚手架死重**）+content/cards 1254K（P1 已关）+全部 .ts 289K+tsconfig/lock → 2683KB 仍超；②chapters.json 实测已是紧凑 JSON（pretty-print 无水分，638367→637966 仅省 0.07%）→ **偏差 D-1**：快照内 3 份巨型研报（js-shuiwang 638K/gs-shuili 585K/zj-shuili 516K）不捆正文走服务端 | **UPLOAD_PASS**：v0.3.0「总包学园 P0 商城基线·32份在售·体验版」robot=1，编译包 **810293B=810KB**（2MB 限内余 1.2MB），15.2s；**PREVIEW_PASS**：work/xueyuan_trial_qr.png 落地（470×470，实为 JPEG 内容）；**活体三探针全 200**：catalog（total=32）/chapters（js-shuiwang html 带回）/report detail（anchor 1888 齐）——3 份服务端依赖报告实测可达 | **D-1 偏差+根治工单**：正式版/P1 上线前须**分包重构**（微信铁律=章节所在分包必须含 reader 页→单内容分包 ≤2MB 装 2596K 不下，cards 1254K 回归后更炸；方案=大小报告贪心双分包或渐进缓存 USER_DATA_PATH）；快照 D-1 影响面=3 份报告离线首开降级「章节加载失败」（在线 87ms 无感，扫码体验者必有网）；**用户一步**：MP 控制台「版本管理→开发版本→0.3.0→选为体验版」+体验者开「开发调试」（http+IP 请求非白名单域，qianwen 8869 同款先例）；vant/mp-html 死重清除待回 live 树（npm 构建链一并清） |

## 2026-09-28 Phase 8/11 · P1 四簇验收收官 + 引擎 P1 上生产

| # | 动作 | 实测结果 | 下一步 |
|---|---|---|---|
| 40 | **四 agent 验收（Judge=C12 金标准亲测）**：E1 社交经济簇三留裁全 RATIFIED（①组队座位案②差 1 分拆档 33266×2+33268 合计恒等+503 生产闸 ②新用户=last_seen 空且注册<24h 双条件从严代理 ③test_store 表计数改对 store.TABLES 真源集合等值断言保牙）· E2 批评退款簇（映射纯函数 clamp+锚点字节断言 70→34860；自动退≤50%档/iOS 书券/黑名单客诉全 manual；refund_order 未接线 RuntimeError 自拒；heuristic 默认零外呼付费 API=0）· E3 海报簇（17/17+OFL 字体+防泄漏结构锁）· w3a 商机卡（3104 卡防幻觉抽验我独立选样 5/5 HIT 对母本原文） | **全量 pytest 178 passed 亲复现**（125+53=178 账平；E1 曾目睹的 7 失败=E2 并发期自文件，已自愈） | **缝合缝一刀**：invite.py 自带宽松版 parse_scene（E1 先行期产物）与 poster.parse_scene 双实现漂移实锤（无字符集/32 上限校验、s= 查码不验 report_id）→ **invite 委托 poster 真源+lookup_code 注入**，30/30+178 全绿 |
| 41 | **引擎 P1 部署上生产**：ecs_deploy_xueyuan.py 幂等重跑（引擎相位=代码+venv+systemd+ufw，一次过 PIP_OK/IMPORT_OK/health=200）+ **新坑实锤**：`systemctl enable --now` 对已 active 服务**不重启**——盘上代码已换进程跑旧模块，P1 路由公网 404 → 手动 restart 后全 401 正闸 | 公网验证：health 200 · catalog 200 · criticize/poster/like 全 **401 UNAUTHORIZED**（鉴权门在位非 404）→ **P1 引擎生产在役**（gift/voucher/invite/team/criticize/refund/notify/poster 八域） | deploy 脚本 cmd_systemd 焊死（enable+显式 restart，E4 落地再部署免再踩）；**海报字体 16.9MB 送达在跑**（16KB 分片要 ~1400 片≈2h 弃；走 ECS 公网直拉 jsdelivr——首拉 6.3/7.9MB 截断实锤→续传 ×6 轮方案，sha256 对本地+PIL 装载验收，后台任务在跑） |
| 42 | **E4（P2 引擎簇）发射**：已购检索（付费章 snippet±40 字防泄漏锁）/转赠（每报告 1 次+条款待 v1.2 我属主）/订阅消息 scaffold（501 自拒+access_token 助手补位）/AI 伴读 scaffold（judge 同款双 provider：local 检索式应答默认+openai_compat 留缝，**qianwen 两腿积分制付费禁止接入**） | 文件属权=新四文件+app/store/config 追加；settle 簇全部只读；测试目标 ≥30 新增 | E4 交付后：验收→引擎再部署→F2 前端 P2 波；wave3 余量=卡详情页/H5 长尾页+情报官判据切换+PDF 个人码尾页 |

## 2026-09-28 需求基线变更 #5（v1.2 协议真源落定，主会话属主亲改）

| # | 变更 | 内容 | 影响 |
|---|---|---|---|
| 43 | AGREEMENT_COPY **v1.2**（情报裂变 2.0 #37 落法+P2 转赠前置）：①邀请解锁规则→「情报官体系与有效带新规则」（判据「邀 2 位新用户」→「1 位有效带新」质量门=完整阅读≥1 章试读或停留满 3 分钟；L1 观察员 1/L2 分析师 5/L3 情报官 20；L2=200 券+首读权、L3=1000 券+周榜署名+闭门会远期；旧口径已发不回退）②§五书券来源三种→四种（+情报官等级奖励）③**新增 §四转赠规则**（仅限本人付费购买/每报告终身 1 次/转出即失权益/与退款互斥/发票不随转；组队书券发票页脚顺移五六七八） | 红线自查过：等级奖励全虚拟无现金、一级归因无分销、L1≡原双组件不重复发；转赠源限 purchase 防书券套现链 | w3b-F（前端 v1.2 镜像+me 情报官卡+reader 停留上报）已发射，冻结契约=dwell POST+/me ladder 扩展字段；**引擎腿（invite 判据切换+ladder 表）排 E4 settle 后**（store/app 追加点并行冲突规避）；海报字体送达收官（sha256+PIL FONT_RENDER_OK，jsdelivr 截断→续传方案入库 work/ship_poster_fonts.py） |

| # | 动作 | 实测结果 | 下一步 |
|---|---|---|---|
| 44 | **E4（P2 簇）验收 PASS**：237 passed 亲复现（178+59）· owned_search 付费章 snippet ±40 字硬锁+权益闸 · transfer 每报告 1 次 UNIQUE+转出即删权益 · subscribe 501 自拒+access_token 内存缓存不落盘 · ai_chat local 检索式应答零外呼（qianwen 两腿禁止接入实锤）· XY_FAKE_NOTIFY 新假闸双腿（启动 RuntimeError+端口自拒） | **两处 v1.2 冲突实锤**（E4 诚实自报②③）：①受赠方权益无 source 闸=transfer 链可无限接力 ②无在途退款拦——引擎按 REQUIREMENTS 写就先于 v1.2 协议 | **w3b-E 已发射**（引擎两件套：情报官判据切换 L1/L2/L3+转赠对齐 NOT_TRANSFERABLE/REFUND_IN_FLIGHT；与前端 w3b-F 零文件交集并行）；w3a-2-F（卡详情页前端）排 w3b-F 完成后串行（api.ts 同文件冲突规避） |

| # | 动作 | 实测结果 | 下一步 |
|---|---|---|---|
| 45 | **w3b-F（前端 v1.2 镜像）验收 PASS**：金标准亲验=tsc 0 错+全量 5 套件 **75/75**（66+9 新增）+**4/4 独立锚点抽验**（转赠退款互斥句/L2 权益句/旧口径衔接句/无现金对价句——均我自选，非 agent 报告锚点，md↔ts 逐字零漂移）；agreement.ts v1.2 330 行、p1-view 情报官卡+dwellReportSeconds、me 三件套 L1/L2/L3 徽章、reader onShow 锚定 onHide/onUnload 上报 | harness XY13 豁免扩 `-cards`（mock-fixtures-cards.ts 预留，hex-appid 合规腿同步加） | **w3a-2-F 已发射**（商机卡前端：pages/cards/detail+api 三函数 cardDetail/cardResolve/cardsByReport+mock fixtures+≥8 测试；冻结契约=公开单卡/by-report 两态前 3 锁尾/resolve 恒 200 降级；卡页不挂 p1=落地页语义）；w3b-E 引擎在跑，两 agent 文件零交集并行 |

| # | 动作 | 实测结果 | 下一步 |
|---|---|---|---|
| 46 | **w3b-E（情报官引擎+转赠 v1.2 对齐）验收 PASS**：金标准亲复现 **264 passed/0 fail**（基线 237+27 新）；代码亲读——transfer 双闸 `any(source='purchase')` 杀链式转赠+`_refund_in_flight` 批评/退款两域非终态镜像拦+转出同事务订单推 `transferred` 断批评退款已购闸；dwell clamp[1,600]+每关系 600s 封顶+无归因恒 200；L1/L2/L3 flags CAS 闩锁只升不降+旧口径托底；chapters GET Bearer 读腿 try 降级纯副作用；/me+relations 双表面同 `ladder_payload` | 诚实遗留收编：chapters 7 行钩子越清单=最小侵入裁定合规；读腿只挂 GET 列表端点（reader 实链走 GET，缝合 QA 再核）；app.py「23 表」注释陈旧不追 | **w3a-2-E 发射**（卡引擎三契约+卡 QR scene `c=&i=` 并 poster/invite 归因+H5 长尾页+卡模板并入 E3）；随后引擎再部署+content/cards 送达+缝合 QA；3c PDF 个人码尾页=主会话并行（pdftail.py 新模块零冲突） |

| # | 动作 | 实测结果 | 下一步 |
|---|---|---|---|
| 47 | **w3a-2-F（卡前端）验收 PASS** + **3c PDF 个人码尾页主会话落地** + **卡数据送达件备妥**：①金标准=tsc 0+全量 **88/88**（75+13 卡测试，`env -C` 绕 cd 剥离坑）+detail.ts 亲读（card_id 不透明透传/瘦卡跳行/免责单一真源/switchTab 正确/零 console.log）；②pdftail.py 新模块（PIL 画 CJK 尾页→PIL 内建 PDF→pypdf 追加；scene 与邀请海报同池一码两用；失败降级原水印版）+download.py 接线+7 新测全绿（下载契约演进=N 内容页+1 尾页，test_download 同步）；③work/ship_cards_content.py（tar.gz→16K 分片→content_pkg/cards/→sha256 marker 幂等+restart+探针） | 真数据四纠偏已实锤给两侧：card_id=`<rid>-cNNN` 不透明/amount_raw 文本串/stage `-` 占位归一在引擎边界/source_chapter 引擎富化 | **在跑=w3a-2-E（卡引擎+H5+卡海报）+F2（前端 P2 四件套：伴读面板/转赠/已购检索/订阅）**；harness XY13 豁免扩 `-p2`；两 agent settle 后=引擎全量合流→ECS 再部署+卡数据送达+缝合 QA |
| 48 | **「继续继续，全部完成」收官**：w3 全量+3c 全量+生产三连部署。①缝合=w3a-2-E/w3b-E/w3a-2-F/F2 四波 agent 全判 PASS（金标准亲复现）后引擎合流部署→**生产探针全绿**（cards 两态 js-shuiwang 133 卡锁 3/单卡 stage 归一+第 8 章富化/resolve c= 直拼+s= 未分配空/H5 200+404/dwell·relations·chat 三 401——chat 400 系探针 GBK 体假阳）；②卡短码根治=card_code 表+ensure_card_code（3104/3104 直拼超 32 的通道）+qr_pool --card 模式；③E4 flake 根治=conftest teardown join xy-score-* 评分 daemon（sqlite 假归因两现后拔根）；④harness XY06 基线 v1.1→v1.2（checker 陈旧非门弱化）；⑤ship_cards_content 判据修正（health={"ok":true} 无 status 键假阴性）+38 文件卡数据送达；⑥**3c 榜单/故事/K 看板主会话落地**：leaderboard.py（rank_week ISO 周快照冻结/省级热度=卡数+2×近7日扫码双码表归省/最大单库内口径诚实标注/新入榜业主=最新 published_at 真时间轴/故事=金额 TOP12 周序号轮换零模型/公式四键随包透明）+rankings/export markdown 出稿+K 看板四级漏斗 X-Operator-Token 闸（key 双落位 secrets 纪律）+rank 前端页（故事 hero+热度条形+两榜点穿）+me 入口 | **生产实锤热修一处**：故事段 stage 占位 '-' 直拼「项目处于-阶段」→引擎边界归一补 leaderboard 域+回归测试+重部署+DELETE rank_week 重算（快照冻结会钉住坏文案——预上线清窗安全）；**基线=引擎 319×2/前端 115+tsc0/harness 25-0-5**；生产终态=湖北 1353 卡居首/3104 全库/漏斗四级可拉（paid=3 真单） | 剩=分包重构 D-1（正式版前）+Day-0 QR 池 release 重灌（--card 模式已备）+用户两步（选体验版+开调试）+虚拟支付 offer_id；PDF 夜航四晚批在队列 |

## 2026-09-29 体验版启用日 · 生产码池首灌 + 短码复用根治（部署 #4）

| # | 动作 | 实测结果 | 下一步 |
|---|---|---|---|
| 49 | **用户已选体验版（控制台步①完成）**→趁窗把裂变第三腿（海报扫码）生产化：①码池首灌=32 报告×8 用户 **256 张体验版码**（env_version=trial，qr_pool --all-users --live ECS 原位灌；首次跑废 256 调=qrs/ 目录不存在落盘炸→qr_pool 写前 mkdir 自愈+重灌）；②**引擎级 bug 实锤根治**：poster._alloc_short_code 无 (report,inviter) 复用查——docstring 称幂等实现漏查，每次请求新掷随机短码→**码池永不命中（海报永占位框）+poster_code 无界膨胀**；照 cards.ensure_card_code 同款修（复用查先行+跨渠道复用——短码是归因键一人一报告一枚）+回归测试；③孤儿清账=480→256 行与 256 文件 **1:1**（首轮无文件 224 行 DELETE）；④deploy #4（tools/ 焊进部署包+零交叉审计白名单同步） | **320 passed**（319+短码复用回归 1；notify 日报测试=夹具硬编码 2026-09-28 跨日永久红，时钟陷阱变体二修=store.now() 注入）；生产实证=idempotent=True+178KB 真码在盘+posters 缓存 0 旧图+health 200 | 手机侧半步待用户=体验版开「开发调试」（HTTP+IP 未进合法域名，调试开关跳过校验）；**新测试者进来的运营节律=重跑码池灌命令（幂等，只为新 uid 补码）**；Day-0 发布后 --env-version release 全量重灌在册 |
