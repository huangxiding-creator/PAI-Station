# PROPOSAL — ima 公开知识库渠道 (ima-kb-public channel)

一句话: 把「网络公开分享的 ima 知识库」变成工程研报的正式资源库——可搜索、可下载、
可过账, 接入 conductor 渠道体系。

## 为什么赢 (调研实证, 非推测)
1. **信息差**: 社区做了下载器/MCP/同步器 35 个项目, 但无人把「公开 KB 生态」做成
   采集渠道; onclaw-dev 仓点名官方公开检索弱——而我们实测 search_knowledge_base
   能搜到公开订阅库矩阵 (工程知识库超市: 国家法律全集 150,329 条/水利 7,155 条/
   总承包电子书库/建筑规范库…), 工程域直接命中。
2. **双腿已双实测** (判据级): 下载腿=官方 OpenAPI 三腿全通 (搜库→库内搜/浏览→签名
   直链 res-skb.ima.qq.com+鉴权头); 发现腿=分享页 SSR `ima.qq.com/wiki/?shareId=`
   匿名 200 直出库名/订阅数/内容数/逐条清单 (3/4 实测过) + 搜狗微信
   `ima.qq.com/wiki shareId` 链接发现器 10/10 命中 + 官方知识库广场在役
   (20+行业/4亿+文件)。前人踩坑工艺 (jump_url 4h/直连关代理/wechatarticle=HTML/
   COS 403 勿用/链接删除即 400) 全有记录。
3. **弹药级库已点名**: 科创板 IPO 问询库 1 万内容 (招股书 1036+律师意见 2841+
   会计师回复 2869, 2019-2025 全量——研报工厂直接弹药); 压力容器标准库 3000+ 文件
   (~2000 份 ASME 级标准 PDF); 大坝安全管理库 (水利水电对口); 安全生产资料库。
4. **零新依赖**: 凭证已在位 (IMA_OPENAPI_CLIENTID/APIKEY), 官方端点, 免费零 key 增量。

## 方案 (两阶段)

### P0 渠道最小闭环 (采集器 + 接线)
`EPC100/collectors/ima_public/`:
| 件 | 内容 | 抄自 |
|---|---|---|
| client.py | OpenAPI 四端点封装 (search_knowledge_base/search_knowledge/get_knowledge_list/get_media_info), 复用 ~/.config/ima 凭证, 直连关代理 (y869 注记) | ima-skill 官方 + y869177843 |
| discover.py | 双路发现: ①主题→同义词扇出 (EPC→总承包/工程总承包/交钥匙/…)→search_knowledge_base→库目录卡 (kb_id/name/creator/content_count/member_count); ②分享链接路: 搜狗微信 `ima.qq.com/wiki shareId` + SSR 分享页解析 (免登录直出订阅数/内容数/逐条清单) | onclaw 点名缺陷→我们的差量; web_eco 链接发现器实测 10/10 |
| harvest.py | 选库→游标分页枚举条目→media_type 分派 (md/pdf 直接下, wechatarticle_ 存 HTML, chrome:// 链接存 .link.txt)→get_media_info 签名 URL+头下载→落 ResearchTopics/<topic>/05 粗加工/ima_<库名>/; 增量=已存跳过; 断点=state json (每文件记 media_id+状态) | delphuy/ima-downloader + y869/ima_sync |
| throttle.py | 账号安全四件套: 节流 (默认 sleep 3s/req)+冷却+日限额 (默认 300 文件/日)+熔断 (连续 5 失败停) | 既有账号安全纪律 |
| ledger 接线 | 渠道账本六态过账 (OK/EMPTY/BLOCKED/RATE_LIMITED/ERROR/NOT_RUN) + 完备门登记「ima_public」渠道 + board 可见 | skill-fusion J 包同构 |
| conductor 出队 | ima_public 任务类型: {topic, queries[], kb_filter, max_files} | 既有 conductor |

### P1 share_id 收割 + 死链防御 (增强)
- share_link.py: 分享链接→share_id 双层取数——SSR 元数据层 (免登录, 库卡+条目清单)
  + 正文层 (官方 API 登录态或社区逆向 knowledge_share_get 免登录端点, 二选一实测后定)
- 死链检测+快照: 链接删除即 400 (实测), 目录卡快照只增不删, 400 时标记 DEAD 留档
- 持续更新库跟踪: 「每日AI资讯」型库做增量轮询 (低频, 服从日限额)

## 验收判据 (实测后进下一段)
① discover('水利') 命中≥3 库且含 content_count>500 者
② harvest 一库下载≥20 文件入语料池, 中断重跑=断点续传 (已存跳过实证)
③ 渠道账本出现 ima_public 行, 六态无空洞
④ 日限额熔断实车触发一次 (设小限额验证)
⑤ EPC 主题词扇出检索出≥2 工程相关库并试收割≥10 文件进弹药池

## 红线对齐
- 只采「公开分享/订阅」面, 不碰他人私密库; 只读不写
- 我们的 API key 只发 ima.qq.com (skill 纪律); 密钥不回显不入 git
- 账号安全四件套默认收紧, 放宽须批; 长跑晚间执行
- 高风险域名清单照走; 只增不删

## 规模与排期
P0 一个工作段 (采集器+接线+判据①-④); P1 半段 (share_id+发现+判据⑤)。
依赖: 无新装件; conductor/渠道账本既有接口。

## Out of scope
- 不做公开库的全文 RAG/问答 (那是 ima 产品自己的事, 我们只收割语料)
- 不做 web-token cgi 通道 (OpenAPI 已够; 留作 OpenAPI 配额撞墙时的备案)
- 不自动订阅/入库他人库 (只下载公开内容)
