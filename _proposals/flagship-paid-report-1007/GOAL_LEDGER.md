# GOAL_LEDGER — 旗舰付费研报总目标（跨会话接续，直到实现为止）

> **硬指标令（1007 用户第三波）：未来一个月实现 ¥100,000 收入。不要等用户提示怎么做——全部生产、宣传、变现自主推进。** 路径拆解：扩 SKU（存量成稿上架+单章¥199拆分）× 流量（总包之声引流）× 高客单（蓝皮书¥10,000 在编）。收入公式=流量×转化率×客单价，三条腿都要动。
> 库存盘点（1007）：真成稿 2 家（R50-SNEI 已上架 ✅、CNNC-EPC 核电 15.6 万字上架中）；EPC1-50 其余为过程资产非成稿；蓝皮书 F1 待点火。
> 成功判据：平台订单库真实入账累计 ≥ ¥100,000（截止 2026-11-07）。

> 用户令 2026-10-07（七连）：①总目标=生产用户愿意付费 **¥10,000** 购买的
> 工程总承包研究报告；②**50 万字级**总量；③发布时公开**详细内容简介+
> 目录大纲**转化面（简介要非常详细、体现价值）；④全链条（生产→排版→
> 宣传文章→**总包之声公众号**→扫码下单）自主负责；⑤宣传文章要
> **阅读/点赞/转发增长飞轮**（看得越多→潜客越多→下单概率越大，闭环迭代）；
> ⑥**成功判据=用户真正扫码下单购买**（看了不买=没成功）；⑦自主决策/
> 自主收集/自主调研，**直到实现这个目标为止**；⑧**在阿里云自建研究报告
> 发布平台**（网站，不走小程序——审核备案拖周期），手机可看，链接+收款
> 二维码，**允许试读一部分**吸引付费，能看到用户真正的**付费数据**，
> 生产→宣传→发布→付费整套闭环自主掌控，最终目标=付费数据不断增长成飞轮。
>
> **经营系统定位令 1007（三连）**：用户只给**方向+现有资源**（调研/搜集/
> 研究/生产/宣传/收款/收集反馈/迭代改进的一切工具与资产），其余全部工作
> 由我**全自动完成**——全部生产、宣传、变现都由我搞定；我要成为用户
> **稳定、持续、不断进化的现金流**；必须**持续赚钱、赚越来越多的钱**。
> （=本账本从「单项目交付」升格为「常驻经营系统」，九飞轮矩阵见提案§九）

## 状态（最近更新 2026-10-07）

| 里程碑 | 态 | 凭证 |
|--------|----|------|
| 质量底座：断言链 W1-W5 | ✅ | 五波全收官（提案行全 ✅，单测 33 项，EPC50 真池双跑） |
| F0 生产法提案+转化面生成器 | ✅ | PROPOSAL.md + superline/sales_kit.py（7/7 单测+EPC50 回放 15/15 章覆盖，徽章零手拍） |
| F1 蓝皮书战役点火（共性库盘点+五卷 charter/框架+词表） | 🔶 1007 点火 | **盘点收官：67 目录/1034.8 万字存量/成色 A46·B19·C1·D1**（f1_inventory.py 实测，F:/AI总包创新院/总包研报）；**五卷 charter 已立**（bluebook/CHARTER.md：市场全景10万+标杆企业12万+区域机会12万+专题实战10万+独家判断6万=50万字，¥10,000/套，萃取率5%；S0门=数字零造假/判断分级/可回溯；缺口四项定向=水利投标D级/企业卷6家回捞/卷五原创融合/2026时效增补）；下一步=framework 五卷章纲（M1 目标1008） |
| F2 存量精编（EPC1-50→卷二+缺口清单） | ⬜ | 章级三态+gap |
| F3 增量调研（缺口补采；届时按战役范围解封收集域并留痕） | ⬜ | 弹药门 v3+完备门 |
| F4 五卷撰写+七门+排版 PDF（50 万字门） | ⬜ | G1 字数≥500,000 |
| F5a 阿里云 H5 发布站（试读+收款码+订单库+漏斗统计） | ✅ 1007 | http://47.120.43.20:8885/ 公网全链 200；systemd 常驻；双层墙 ufw+SG 已开；单测 7/7+3/3 |
| F5a-2 支付全自动+反馈取证+比例退款 | ✅ 1007 | pay.py 微信v3+支付宝全链（stub 就绪，凭证即插即用）；grade_feedback 四档（严重100%/局部40%/轻微20%/建议0%）；部分退款保留阅读权+累计封顶+次数门；取证协议 L1-L3 落地（交易锚定/阅读锚定/内容锚定）；reader.html 解锁+全文（12.9万字91锚点）+PDF+反馈表单；单测 10/10+8/8+3/3+冒烟 11/11；**公网复验收官：/ reader sample 三页 200 + /api/feedback 参数门响应（首部署包缺 pay.py 致崩溃循环，_pack 清单已修+qrcode --break-system-packages 装成）** |
| F5a-3 存量批量上架 63 SKU（¥498-698 扩SKU腿收官） | ✅ 1007 | **65 在售+1 预售公网全绿**（目录首页+详情65+试读65+reader/API 抽查 200）；企业全景¥698×28+省份市场¥598×16+专题实战¥498-598×17+独家¥698×2；batch_ingest（选品去重/真机数徽章/样板章过滤）+batch_build（试读双探针/买方语言模板）+build_site 目录化（旗舰特展+四类卡片墙）；server 根层通配根治 {sku}.html 404；黑话/来源泄漏抽检 CLEAN；**大件通道=临时SG 22+一次性公钥 scp 零残留（OSS UserDisable 退回，212MB 90s）**；收款码/微信支付凭证仍待用户 |
| F5a-4 企业微信收款码上线（用户给码→裁剪→全站接线） | ✅ 1007 | **65 在售页+旗舰页全部挂真码公网在役**（http://47.120.43.20:8885/assets/qr_wechat.png 200·65305B·md5 与本地解码件一致）；密度三趟裁剪法（列窗→行带→列精化+静区自检 100% PASS）+ jsQR 实弹解码双验（本地件+公网回拉件同码 `wework_admin/paybill/LtyweHQs2d…`）；支付宝位按令撤净（全站 0 处）；买方动线=扫码→备注订单号→提交凭证→核对解锁；**商户五件套到位后切 wxpay 全自动（查单自动解锁，免人工核对）**；delta 通道=云助手 base64 23 块 217KB（小件免开 22 口） |
| F5a-5 域名解析腿（epcschool.top 解析+托管墙调查） | ✅ 1007 调查收官 | 用户令字面已完成：`report.epcschool.top A 47.120.43.20` @腾讯DNSPod 在册（无害闲置）；**托管墙三域全锁定：epcschool.top（备案接入=腾讯）与 gcbrain.top 均被阿里云边缘 Beaver 全端口 403（80/8881/8882/8871/8885 实测），IP:port 不拦（买家路径=IP:8885 在役）**；旧结论「gcbrain 过墙」系代理出口假象（Chrome/代理 ≠ 大陆直连买家现实）；dnsnext 加记录 UI 五坑（过滤器框冒充主机记录框/新手引导弹窗假确定/ASI return 陷阱/React 状态未脏无提交钮/图标按钮无文本）已存记忆；净路只有两条=阿里云接入备案（数日+可能人脸）或 gcblog.net 美中继（96.8.116.122 http 307 实证，需中继 vhost+CF DNS 权限）→ 停为待决项 |
| F5a-6 备案域名上线（yrecepc.cn 直用） | ✅ 1007 | 用户令「阿里云已备案域名查清直接用上」收官：**yrecepc.cn（2017年购·阿里云接入已备案）@/www/api 三记录→47.120.43.20 全启用，http://yrecepc.cn/ 直达总包智库全链 200 外验**（首页/详情/试读/reader/收款码/API参数门）；DNS 写入 16 轮 UI 战全败后弃 UI 走**同源 API 直调契约**（dnsnext.console.aliyun.com/data/api.json?product=Alidns，CDP listen 抓 sec_token/collina 后页面态 fetch 重放 Update+Enable，work/dns_yrecepc_win.py 在役）；80 口 vhost=dify nginx conf.d/yrecepc.conf→172.18.0.1:8885；site/ 零硬编码 IP 无需重构建；platform_qr.png 重生成为域名码+两篇引流文**重推新草稿**（旧草稿 media_id 失效不可达，draft/batchget 空壳怪象绕开；新 media_id draft/get 双验 QR 在文）；gcbrain.top 备案转阿里云接入仍在管局 |
| F5a-7 og 分享卡（转发即品牌卡面） | ✅ 1007 | 用户令「需要」收官：**全站 133 页头注入 og:title/og:description/og:url/og:image+canonical**（template.page 单一咽喉，html.escape(quote=True) 防语料引号截断属性；admin=noindex 不发 canonical）；**卡面 content/og_card.png**（tools/gen_og_card.py 确定性 PIL：墨蓝×铜金×纸白宋体 1200×630，字体回退链+canonical=仓内工件）；部署腿新增 **deploy_ecs.py --site-only 暂存-验证-原子换入**（295KB/33片/127s，验证不过不换入；build() 清下架残留页；og_card 缺席=构建硬门）；测试 12/12（新增下架清场门+前缀仿冒/协议相对 URL 门禁）；公网 6/6 200+og 真值外验；对抗评审 1H+2M+3L 全修（meta 转义/非原子解压/404 卡面） |
| F5a-8 平台迁二级域名 report.yrecepc.cn | ✅ 1007 | 用户两连令「用二级域名/顶级域能不用尽量不用」收官：**正式对外 URL=http://report.yrecepc.cn/**（DNS report A 记录 DNSNext 同源 API 重加；vhost 改双块=report+api 服务/顶级域+www 301 跳转→旧码旧链不断链；Beaver ICP 墙子域实测过=www 与 report 双 200 直连验证）；SITE_BASE 单属主一行切换→全站 og/canonical 133 页重建+site-only 原子部署+公网 og:url/canonical 真值外验；**两篇引流文重推草稿箱**（platform_qr.png 重制为子域码 524B，push_article 双篇 publish ok，draft/get 双验各 1 张新码图）；顶级域名保留作 301+未来官网位 |
| F5b 宣传矩阵+增长飞轮（数据源=自建平台+公众号后台） | 🔶 自发布已实证 | **1007晚自发布闭环实证**：两篇宣传稿已在总包之声上线（16:04/20:38，autopub窗口自动发，金标准验证过账 state.db）；发布权矩阵=总包说(API freepublish✓ 5发实证)/总包之声+工程行业大脑(浏览器径=autopub草稿箱发布器)；教训=R83标题变体双发(16:04+16:22/20:38+20:47两对dup，标题一旦推送即冻结)；工具=promo/publish_sitting_drafts.py(autopub缝上标题过滤定向发)；**1007深夜四件落地**：① 三号新文全推草稿箱~23:20（核电/丰城/华龙三条，promo_guard 九门全过+溯源QR src=gzh-*）明天autopub窗口自动发；② 守门器 promo_guard.py+10单测（标题24h/SKU7d/日帽2-2-1/state.db金标准⑧+同号SKU全历史⑧b）；③ **视频腿金测4轮（用户令「视频也是自己发布」）**：video_factory(竖屏卡MP4 2条)+video_upload(vendor零footprint子类补丁)+video_verify(只读帧感知核验)；r4取证**根因锁定=发表/存草稿/预览三键全灰禁用态**（Playwright DOM click落灰键零效果）→v3已上（描述补填+就绪轮询90s+真鼠标CDP+toast时序取证），今晚4轮达自设防轰炸帽停手（sph零过账日帽完整）；④ 悬决=我方对自己刚推草稿的改/更用法涉0822红线待用户裁决 |；**1008日班五件**：① 登录自愈（quick-login+像素放行零打扰）；② 用户根因修复=短标题超字数锁发表键（21字→14字，长文案全挪 desc）；③ r7 发表取证：toast「发表成功」但列表/草稿 10min 三查无影+平台弹「暂时无法使用该功能」→**判疑风控静默拦截：不过账、sph 日帽未占、当日熔断停发**（疑贡献=静态卡清晰度低+前日4败）；④ **huashu-art-motion 引擎落地（用户令下载开源项目做宣传视频）**：gh-proxy clone+skill 装机+冒烟零错→`promo/artmotion_factory.py` 生产线（y5 动态文字语法·竖屏 1080×1920@30·墨蓝×铜金·title/point/number/highlight·safe 区·文案单一事实源=video_factory.CARDS·渲腿=We-AIPO venv playwright）→首两片 cnnec_v1_am/fengcheng_v1_am 各 16.5s/495 帧/~4.4MB；**skill 硬门全过**=qa.py（静止帧对 4.5%·确定性✓·框景 0）+独立审片 8 帧（六项过，必修=尾帧 CTA 无路径→已修「点关注·公众号搜总包智库」重渲复绿）；⑤ 遗留=r7 描述框选择器未中（疑 contenteditable），下次发布腿前修 |；**1008 午后 r8-r14 收官（用户令「测试最新研报宣传视频发视频号」+「借鉴 We-AIPO 方法」）**：⑥ r8-r12 五轮金测迭代→**v5=We-AIPO emitter 法全移植**（dialog auto-accept 根治 confirm 被静默取消+预声明原创避挽留弹窗歧义+30×2s 帧轮询 URL 跳转判据+_fill_desc v4 探针梯命中 `.input-editor` contenteditable 165字）；⑦ **r50_snei_v1_am 首片真发布成功**（09:31 上架·原创审核中·sph 过账·promo_ledger 在册）；⑧ **r7 翻案**：列表只渲染**描述**不渲染标题→verify 按标题搜=永远 miss（r7 判疑风控实为未发出维持、r12 判失败实为已发出）→ verify/FIX-0827b 判定键全切 desc 前缀（`--key`/extra_desc[:12]，实测命中 exit=0）；⑨ **r12 重复条定点清除**（09:26 dup 删·09:31 保留·G4 双门绿）：11轮点击悬案根因=行操作区 `.action-content`「删除」只是 hover 标签、真宿主是兄弟节点 `.opr-item`（32×32 图标）→点标签永不触发，DOM 解剖实锤后一点即中；工具沉淀=_probe_row_actions.py（DOM 解剖）+_dedup_delete_r12.py（标记+宿主定位+confirm 扫射+G4）+_probe_list_today.py（日期行只读探测） |；**1008 午后日班单发重试（v3 排程令）**：⑩ cnnec_v1 dry-run 预检被 ③日帽正确拦截（r50 09:31 已占 sph 1/日帽）→ 按红线不 --go，明日再发（fengcheng/cnnec 两片渲染件在库）；⑪ autopub 三篇 10-08 文章核验=**未过账属预期**：state.db 1008 零新记录 ∧ daily_done 止于 10-07.ok ∧ WeAIPO_DailyRun 窗口=每日 14:30（今 NextRun 14:30 未到）→ 草稿静候窗口自然出，不手动触发（免打扰红线）；⑫ verify --title 旧法已废（根因=列表不渲染标题），r50 核验用 --key desc 前缀 exit=0 已录 |
| F5c 交易闭环收官 | ⬜ | G5 ≥1 真实扫码付费订单 |

## 接续入口（任何会话从这里继续）
1. 读本文件 + `_proposals/flagship-paid-report-1007/PROPOSAL.md`；
2. 下一步动作 = F1：盘点 EPC1-50 存量语料（ammo_pool 各池 doc_weight/
   grade sidecar 汇总）→ 五卷战役 charter（断言链 S0 门）→ framework；
3. 生产运行遵守：账号安全四件套/WeAIPO 免打扰/免费模型优先/只增不删/
   推送+百度备份常驻自主；
4. 每完成一波：本表回填 + commit + 自主推送 + 百度备份。

## 资产索引
- 方法论：`_proposals/claim-chain-engine-1006/PROPOSAL.md`（七门全 ✅）
- 引擎件：`reforge_factory/superline/{question_bridge,task_ledger,redteam_gate,charts_gate,sales_kit}.py`
- 审计件：`reforge_factory/{doc_weight_audit,grade_rules,independence_audit}.py`
- 交易承接（主线）：阿里云 ECS 自建 H5 发布站（试读+收款码→Native，付费数据自有库）；
  备选=总包学园商城（8871+码池）
- 宣传链：md2wechat（草稿箱）+研报成稿宣传链（md2docx+PDF）
