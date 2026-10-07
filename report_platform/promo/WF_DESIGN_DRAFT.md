# 「3公众号+1视频号 → report.yrecepc.cn」全账号引流接线设计 v1

总纲: **We-AIPO 一行不改**(0923免打扰红线), 平台侧(E:\AI-Station\report_platform\promo\)自建内容引擎, 走「API投草稿箱 → autopub 代发」旁路——该通道已被实证(10-07 20:38 总包之声文章+20:47伴随贴图双发, 侦察A)。三号差异化切片66份报告, 视频号走「素材自动生产+每日1条人工桥」, 度量靠平台埋点 extra 字段加 src 归因。

## 0. 今晚实测补证(设计者亲测, 区别于侦察转述)

- 三号 token 全通: `总包之声/总包说/工程行业大脑` get_access_token 全部 TOKEN_OK(2026-10-07 22:3x, 无40164)——**多号推送无IP白名单阻塞**
- `http://report.yrecepc.cn/` GET 200(38KB); https 未起(000); `yrecepc.cn` 301 → `http://report.yrecepc.cn/`——QR 走 http 链可用
- server.py:268-277 `/api/track` 吃 `{event, sku, extra≤120}` 落 sqlite events(ts,event,sku,extra); template.py:214-216 `t(e,x)` 前端 extra 默认空串——**src 归因只需前端一行改, 服务端零改**
- report.json 复核: 66份(ent28/prov16/topic17/excl2/flagship2/蓝皮书coming_soon), chapters 合计1018条
- push_article.py:38 `load_account()` 无参 + :54 `push_draft()` 未传 account_name——但 wechat_publisher.py:52/:120-122 两个函数**均已支持 account_name 参数**, 参数化≈10行
- ffmpeg/cv2/moviepy 均不在位, qrcode+PIL 在位(视频素材合成需 `pip install imageio-ffmpeg`, 免费)
- 广告营销三号txt+8张底部图在位(E:\CPOPC\We-AIPO\广告营销\)

## 1. 总架构图

```
                    E:\AI-Station\report_platform\content\
                    report.json(66份/1018章节) + sample/65 + full/65html
                              │  (只读, 平台自有)
                              ▼
        ┌──────────────────────────────────────────────┐
        │ 内容引擎 (新建, report_platform\promo\)        │
        │  promo_factory: 报告×体裁×账号 → promo/*.md    │
        │  promo_guard:  去重/冷却/日帽/digest校验       │
        │  promo_ledger.jsonl (自家台账)                 │
        └──────────────┬───────────────────────────────┘
                       │ push_article.py --account X --qr qr_X.png
                       │ (参数化后; 中式水墨渲染+{{QRCODE}}注入)
                       ▼  API /cgi-bin/draft/add (trust_env=False 直连)
        ═══════════ 微信草稿箱(三号并行, 共享资源) ═══════════
        总包之声(acct07)   总包说(acct01)   工程行业大脑(acct05)
              └─────────────┴────────────────┘
                            │  零改动, 顺路搭车
                            ▼  WeAIPO_DailyRun 14:30 → publish_relay →
        autopub 三号并行 Web编辑器「发表」(relay波 15:52/17:47/20:34, 侦察E)
        + 每篇自动伴随贴图 = 免费第二次曝光 (侦察A)
                            ▼
        视频号 总包说(海南)教育科技 42,640粉 (We-AIPO 管辖, 不碰)
          v1: 每日1条人工桥 (素材包自动产: 标题/文案/挂链文章/竖屏卡)
          v2: 自动发布 —— 悬置待用户令(共享Chrome 9222风险, 见open_questions)
                            ▼
        度量: QR带 ?src=gzh-xxx → template TRACK_JS 捕获 → events.extra
        → visit→scroll_90→read_sample→click_buy→order_created 分号漏斗
```

We-AIPO 侧动作合计 = **0行代码0配置改动**。读取(不改): wechat_accounts.json(凭证共用不复制, wechat_publisher.py:11-13约定)、published_topics.json(只读对照防撞题)、state.db/ad_ledger(只读度量)。

## 2. 三号差异化定位与报告切片

教训依据: 侦察E「同号10篇挤推荐窗自相蚕食」裁决③Q9——差异化不只是号与号, 更是**每号内容配方与人设绑定**, 商业密度按号分级。

| 号 | 角色 | 报告切片 | 主体裁 | 频率帽 | 商业密度 |
|---|---|---|---|---|---|
| **总包之声** acct07 | 货架号/旗舰橱窗 | flagship 2 + excl 2 深拆(×4篇=16) + topic精选 + 货架合集 + 蓝皮书预热 | 单报告深拆(r50模板)/问答体(cnnec 14问式)/货架盘点(shelf65式)/信任状方法论 | 1-2/日 | 最高: 文内QR+CTA+预告位 |
| **总包说** acct01 | 企业拆解号 | ent 28(×3: 定位/框架拆解/数据榜单)=84篇 + prov 16(×3: 进省底账/项目清单/竞争格局)=48篇 | 对比框架体(北斗七星/六维模型式)/数据榜单体(679张表原料)/「拆一家总包看N个体系」专栏 | 1/日 | 中: 轻CTA+报告名试读钩 |
| **工程行业大脑** acct05 | 避坑复盘号(零粉养号) | topic 17(×3: 复盘叙事/避坑清单/问答)=51篇 | 事故复盘叙事(topic-10丰城式: 73人遇难/1.02亿硬数字)/避坑清单 | ≤1/日, 起步3-4/周 | 最轻: 仅尾部广告块+文末QR, 正文不强推 |

分号理由(全部侦察实证): 总包之声是 push_article 唯一实证闭环号且广告txt已7条产品链最商业化(侦察A/C); 总包说广告定位=资料/专家/直播, 专业号形象配企业拆解; 工程行业大脑 engagement中位0+养号间隔240-420s(config.ini:20), 体裁与其「实战教训」人设(筛选铁律: 只要价值百万实战经验)天然重合, 商业加载最轻。

切料红线: ent/prov 的 sample 第1章是法律声明样板文(ent-05.md:36-42), **摘录一律走 content/full/*.html 正文**(3847个h2节, 侦察D); topic/flagship 的 sample 可直接摘(topic-10.md:46-54, cnnec_preview.md:17-30)。

## 3. 内容引擎(report_platform\promo\ 新建)

- **模板五体裁**(侦察D实证骨架): 反问/痛点标题 → 权威blockquote(底账数字: 867份底稿/923引注/1600+资料) → 痛点bullets → 编号粗体框架干货免费给 → 适合谁 → CTA(试读免费+分档退款40%/20%) → {{QRCODE}} → 括号收尾
- **digest修复**: 模板第2行必写摘要句(push_article.py:53 取md第2行, 现有两篇实锤 digest==title 回退)
- **promo_guard.py 守门**(补上被绕过的 We-AIPO 内容闸, 侦察A risk): ①标题hash 24h跨号去重(C8等效) ②同报告跨号7天冷却 ③每号日帽 2/2/1 ④digest第2行非空 ⑤正文≥2000字(对齐3000→2000过审先例, We-AIPO config.ini:126-128) ⑥渲染HTML≤18000字符(20000硬上限+广告预留400, 侦察C) ⑦对照 We-AIPO published_topics.json 只读查重
- **promo_ledger.jsonl**: date/title-hash/sku/account/media_id/src, 归因回溯用
- **配额账**: draft/add 自限20/号/日(draft_quota.py:5-6), We-AIPO 常态占3-14 → promo≤2/号 留足余量
- **Phase 2 杠杆(第一周漏斗验证后)**: 广告营销\{号}.txt 各追加一个 `===` 分隔块(report.yrecepc.cn+试读免费)——append 属消费侧约定动作, 删旧块须请示(侦察C令0905); 追加后核对 ad_ledger 四态确认真注入非VT14静默skip。这是比单发软文更大的面: 三号每一篇日常文都带平台链(侦察A)

## 4. 视频号腿

现状: 全自动发布链在役(channels_publisher.py, 10/05 10/10全success, 侦察B)但属 We-AIPO 管辖, 不可挂载。素材源头(brain_replies)对我们闭门——自家号防回环(config.ini:30 总包之声/总包说跳过)意味着我们的公众号文不会回流成视频素材。

**v1 人工桥(默认, 本周起)**: 每日1条, 用户手机发表约2分钟
- promo/video_brief.py 每日 09:37 产出素材包: ①标题套爆款配方(views_flywheel 实证: 具体金额×1.43/大案要案×1.36/避坑止损×1.30, 侦察B) ②30字描述 ③**挂「扩展链接」= 当日公众号promo文**(视频曝光→文章→QR→平台, 零新基建闭环) ④PIL 产3张竖屏金句卡 + `pip install imageio-ffmpeg` 合成15s竖屏MP4(免费, 不占 NB 20/日配额——We-AIPO 已用19/20池尽; 不用 H3 付费API)
- v1 发布动作全人工 → 与 We-AIPO 的 Chrome 9222/防封闸零冲突

**v2 自动发布(悬置待令)**: 复用 vendor tencent_uploader(独立可移植, 侦察B) + account.json 登录态, 错窗(如21:30后)+自家锁文件。风险: 无法共享 We-AIPO 进程内 RL1-7 发布互斥锁, 若时窗重叠=双发布器抢同一 Chrome——0927用户三次确认的封号红线(每波≤5/同飞≤5/120s)语境下, **必须用户明示才做**。

不碰: NB 配额(19-20/日用满)、H3(付费API, 违免费优先铁律, 须用户令)、We-AIPO 已发视频(「生成即发布禁止后加工」只约束其产出; 我们自产新视频不属后加工)。

## 5. 调度与防撞

- **投喂窗**: 每日 13:30-14:00(赶 14:30 WeAIPO_DailyRun → 15:52 relay 波, 今日波次15:52/17:47/20:34, 侦察E); 晚补 20:00 前赶末波; 过点无害(草稿7天窗, config.ini:14)
- **零锁竞争**: API 投草稿不持 run.lock 不开浏览器, 任意时刻可投(push_article 无锁协调在役为实证, 侦察E)
- **发表权统一归 autopub**: 平台侧只投草稿永不 API 发表——48001(总包之声/工程行业大脑无群发API权)+双发洞(freepublish 不删箱条目, 不落 bridge 账本会被7天窗重发, 侦察E两实锤)
- **同日催发(可选)**: `python -X utf8 autopub/run.py --mode run --force --trigger manual`(官方幂等旁路, content_hash 只发新增; 撞锁 exit 2=等待重试, 勿删 run.lock)——仅调用不改引擎
- **节奏全继承**: 进箱后 autopub 按号节奏发(大脑240-420s/其余5-10s/单号100熔断), 我们零干预; 每篇promo自动产伴随贴图=第2次发表动作, 计入熔断但量级无害
- **商业配比**: promo ≤ 该号滑动7日日均的20%, 硬帽 2/2/1, 首两周 ≤1/号/日
- **绝对禁做清单**: 不改 WeAIPO 调度/配置/守护/fleet操作; 不并行跑两套浏览器管线(run.py:160串行红线); 群发永不自动化(草稿箱后留给用户, wechat_publisher.py:15); 投错草稿不可程序化撤回(safety.py 永不删除/编辑)→ **入箱前人审**; 广告营销目录 append-only

## 6. 度量闭环

**平台侧(主漏斗)**: template.py TRACK_JS 一行改——`var src=new URLSearchParams(location.search).get('src')||document.referrer||''`, 每次 t() 把 src 塞进 extra(服务端 extra≤120 已收纳, 零服务端改)。分号QR: ?src=gzh-zbzs / gzh-zbshuo / gzh-dt / sph-manual / bb-preheat。漏斗 = visit→scroll_25..90→read_sample→click_buy→order_created(FUNNEL_EVENTS, server.py:98)按 extra 分桶; /api/stats 现为全局漏斗, 周内加 GROUP BY extra 小改(admin.html 数据台)。QR 重生成指向 `http://report.yrecepc.cn/?src=xxx`(https 起来后再换码, 不阻塞)。

**公众号侧(只读回收)**: autopub state.db publish_records(按号发表成功+伴随贴图) / We-AIPO ad_ledger 广告注入四态(Phase 2追加块后验真注入) / artifact_ledger media_id↔题名回溯。**阅读数/粉丝数不可API回收**(未认证订阅号, 侦察未提供通道)→ 人工 MP 后台周抄(open_questions)。

**视频侧**: engagement_ledger.jsonl(CO2: 播放/赞/藏/转/评, 只读)看账号大盘; 人工桥视频后台手抄进周报。

**周复盘环**: 体裁×src×cat 转化热力 → 下周内容配方调整(哪类报告切片带货最强), 蓝皮书预热节奏据漏斗校准。

## 7. 内容日历与弹药续航

- **主矩阵**: ent28×3 + prov16×3 + topic17×3 + (excl2+flagship2)×4 = **199篇**(切片见§2)
- **合集/货架文**: 跨报告主题合集约20-30篇(16省投资盘子/央企EPC四强/新能源EPC四题)
- **蓝皮书预热**: 8-12篇, 总包之声 1/周, T-8周起(锚=上线日, open_questions)——体裁: 研究底账盘点(1034.8万字存量/五卷charter, F1点火成果)/卷册剧透/方法论信任状/早鸟价预告; 无 sample 只走 r50_article.md:65 式预告位, 每篇配 ?src=bb-preheat 独立归因
- **续航账**: 主矩阵199篇 ÷ 日均~3篇(之声1-2+说1+大脑0.5均值) ≈ **10周**; 加合集+预热 ≈ 13周; 深切扩展(full html 3847个h2节, 保守1000-1600段, 侦察D)→ **4-6个月**; 此后研究工厂持续产新报告续供, 不存在断粮点
- **排期原则**: 旗舰/独家最贵货(¥1999)排在漏斗成熟后(第3-4周)推; 蓝皮书预热与旗舰深拆交替避免同号同周撞题材

## 8. 账号安全红线清单(全数继承, 一条不放宽)

1. 节奏: 240-420s(大脑)/5-10s(其余)/100篇熔断——只投草稿天然继承, 永不绕过
2. 视频若v2: 每波≤5/同飞≤5/间隔≥120s(0927用户三次确认)
3. promo正文≥2000字/digest必填/标题64B截断(clip_title防45003)
4. draft/add: ensure_ascii=False+UTF-8字节体+显式Content-Type+3重试; trust_env=False 绝不过代理
5. 草稿入箱=7天窗内必发且不可撤回 → 人审后投
6. 账号安全红线: 见封禁信号立即止损上报; IP漂移→40164→加白后再推(今晚三号全白, 状态会漂)
7. 免打扰: WeAIPO 永不暂停/干扰; 本方案对其只读+共用凭证文件