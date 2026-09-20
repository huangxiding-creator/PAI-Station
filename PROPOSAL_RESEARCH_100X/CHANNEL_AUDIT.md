# 渠道深度审计报告 (2026-09-20)

> 用户指令: 「将本项目现有所有调研渠道再深度核实一遍, 配上相应的顶级的爬取技术
> 和工具。每个渠道都要紧紧围绕我们的调研目的实现真正高效、高质量爬取到比当前
> 数量多100倍的有效资料」。
> 本文 = A 线交付物: 以**产量健康度** (而非可达性) 为口径的全渠道核实。
> 数据源: ResearchTopics 6 主题全部 collection_manifest_r*.json (25+ 轮实测)
> + channel_health.json。不重跑已落盘数据 (免费模型优先铁律)。

## 一、总盘

- registry 69 渠道 (P1b 后), 台账实测出现 61 个, 总有效文件 ~3,600+
- **产量分布极度头重脚轻**: cnki_direct 一家 2,364 (65%), wechat_rss 365,
  company_info 201; 其余 59 渠道合计 <700
- **16 渠道多轮运行 0 产出** (wenchuanyun 5轮/cninfo 6轮/ccgp 5轮/
  sogou_wechat 6轮/hacker_news 6轮/edgar 6轮/earnings_call 5轮/
  jzsc 4轮/inquiry 4轮/permit 4轮/mofcom_hzs 4轮/shixin 4轮/
  shclearing 4轮/jobui 4轮/panjiva 4轮/metaso_free 4轮)

## 二、根因诊断 (本轮审计最大发现)

### 病灶 1: 语义路由错配 → 0命中 → 熔断锁死【已根治 15e3f6f】

主体查询型渠道 (查企业名/证券代码的渠道) 被喂课题短语:

| 渠道 | 收到的词 | 应收 | 结果 |
|---|---|---|---|
| cninfo | 「电力工程 EPC 项目管理」 | 东方电气股份有限公司 | 84关键词0命中→熔断 |
| jzsc | 「工程建设 EPC 项目管理」 | 华昕设计集团有限公司 | 60关键词0行→熔断 |
| inquiry | 课题短语 | 沪市简称/代码 | 非沪市0匹配→熔断 |
| earnings_call | 课题短语 | 上市公司简称 | 公告0条→熔断 |

铁证: 关键词集里**本来就有** `_institution`(目标全名)+`_competitors`(竞对
全名), 但渠道回退链 `or search_angle` 把短语喂进了主体检索。失败判
diagnosed_failure → 熔断冷却数小时 → 下轮直接 skipped(unavailable) →
**越跑越死, 渠道永久休眠**。

**根治 (commit 15e3f6f)**:
1. `base.subject_terms()`: 企业全名集提取 (_institution+_competitors+画像兜底)
2. 12 主体渠道路由改写: 简称键优先+必补全名, 永不回退短语
3. `not_applicable` 结局: API 正常应答但主体查无 = 诚实不适用, 不计熔断
   连败不进重试; 网络故障仍走 diagnosed_failure (不伪装)

**实弹复活验证**: jzsc×华昕 0→1 真文件 (四库在册记录);
cninfo×东方电气 0→5 真文件 (2026半年报/募资监管公告 PDF)。
守卫: tests/unit/test_subject_routing.py 28 绿; 全量回归 1166 绿。

### 病灶 2: sogou_wechat Node 工具链死亡 → 单轮空耗 65 分钟

「Node工具链与发现层均零产出」, r0 一轮 duration 3920s (65分钟) 后零产出。
处置方向 (B 线): 切换 SouGouWeDown2 本地 :3000 API (memory 实证在位)。

### 病灶 3: 零产出可预期渠道的「诚实归类」缺位

非上市主体查上市渠道 (青海院/华昕查 cninfo/inquiry/earnings_call/irm) 在
语义路由修复后将以 not_applicable 如实呈现, 不再伪装成故障。其余:
- shixin (验证码墙), shclearing (验证码墙), creditchina (WAF 412),
  customs_credit (412; 09-20 晚 curl_cffi 探针 chrome 伪装仍 412,
  server=SingleWindow → 应用层检测非指纹墙, 唯一候选浏览器态): 缓施组
- chinabidding_cn (09-20 晚 B 线破壁全解, 渠道工程已落地):
  WAF 二代双关 — TLS 指纹关 curl_cffi 过 (405→200) 但 200 是
  JS 质询页; 质询 cookie 离体即失效 (绑环境指纹) → 离线解算/
  cookie 搬运两捷径诚实放弃; 唯一通路=单浏览器会话连续导航
  (质询只触发一次, 2s/页, 实弹 3/3+2 真文件落盘)。
  **新事实: 正文实体在免费注册墙后** (可见面=标题+地区+预告,
  「立即注册查看」占位主导) → 价值密度不足, 默认关+工程保留,
  守卫测试 6 项锁语义 (子串计分/零命中不兜底/容器漂移诚实空)
- wenchuanyun 5轮0: 已根治 (09-20) — 三层路由断供 (GLM 22 渠道
  策略矩阵缺键 + engine 分支表五渠道 + topic_engine 不列期望渠道),
  学术家族保底+提示词补位, 守卫 6 测试; 渠道本身满血 (117 PDF/59s)
- mofcom_hzs 5轮0: 已根治 (09-20) — 站迁 https, http 形态 000
  连接死, 一行随迁复活实弹 5 真文件/16s
- wechat_accounts 5轮0: 根因实锤 — API key 认证无效
  (base_resp.ret=-1 认证信息无效), 须用户重新扫码 (凭证类决策)
- hacker_news/edgar 6轮0: 英文渠道对国内课题命中率天然低;
  edgar 语义路由后对有美股对标的目标会恢复
- mofcom_hzs 4轮0: http-only 站, 需核实当前回包形态
- metaso_free 4轮0: 游客配额日预算 12 次, 429 退避机制在位, 属预算性零产出

## 三、健康渠道产能基线 (每轮均产)

| 渠道 | 轮均文件 | 判定 |
|---|---|---|
| cnki_direct | 788 | 主力, 知网 PDF 直连 |
| wechat_rss | 122 | 主力, 公众号 RSS 流 |
| company_info | 33.5 | 健康 (语义路由后预期↑, 全名直查爱企查) |
| policy / shutong / standards | 21-29 | 健康 |
| cnki | 8 | 摘要通道, 摘要提取后转 cnki_direct 落 PDF |
| 其余政府列表渠道 | 1-11 | 健康 (SSR 列表, 逐轮稳定) |

## 四、×100 路线图口径 (度量=J1 信源筛后有效文件)

三路叠加的当前进度:
1. **渠道铺满**: 在位 69/缺口 70 → 本轮 P1b 继续接入 (浏览器态组+OFAC
   批量下载器+世行重定位)
2. **单渠道产能**: 语义路由根治 12 渠道休眠 (每主题每轮可复活 ~10 渠道
   ×1-8 文件); 慢站 timeout 修复 (nafmii 先例)
3. **时间流**: RSS 每日两轮 (PAIStation-rss-harvest 905 源) 持续滚动

诚实条款: ×100 是全链路叠加目标, 实测不足时如实呈报瓶颈。当前最大
瓶颈已从「渠道不够」转移到「主体渠道休眠」(已修) 与「JS 壳/WAF 墙态组」
(B 线攻坚)。

## 五、行动项

| # | 项 | 状态 |
|---|---|---|
| A1 | 语义路由+not_applicable | ✅ 15e3f6f, 1166 绿 |
| A2 | sogou_wechat 切 SouGouWeDown2 | B 线 |
| A3 | wenchuanyun/wechat_accounts/mofcom_hzs 诊断 | B 线 |
| A4 | 浏览器态破壁组 (creditchina/chinabidding_cn/JS壳组) | B 线 |
| A5 | OFAC sdn.csv 批量下载器+世行重定位 | C 线 |
| A6 | P2 persona 提问器+企查查 API | D 线 |
