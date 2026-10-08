# GOAL_LEDGER — 旗舰付费研报平台运行账

> 目标（用户 1007 令）: 售卖研究报告, 每月 ¥100,000+ 净收入, 生产/宣传/变现全环自动。
> 本账只记「跑通过什么 + 判据 + 坑」, 数字零造假。详细战略态见记忆 flagship-paid-report-goal。

## F5d 在线支付 · 1008 收官态

**买家体验（顶配）**: 微信内打开 → 点「微信支付」→ OAuth 静默授权 → JSAPI 拉起收银台 →
付款 → 2.5s 轮询确认 → 自动跳转阅读页（订单号+ck 令牌门）。微信外 → Native 二维码 +
长按识别。全程零上传凭证、零人工核对。

| 件 | 判据 | 态 |
|---|---|---|
| pay.py 微信支付 v3 | 37/37 tests 绿 (含回调验签/AES-GCM 解密/幂等 mark_paid/退款) | ✅ |
| JSAPI 三段流 | wxlogin→wxback→pt 令牌(10min)→jsapi→WeixinJSBridge | ✅ 代码完 |
| ck 安全 | uuid4hex[:16], orders.ck_hash sha256, hmac.compare_digest 门 | ✅ |
| HTTPS 正式口 | LE 证书 report.yrecepc.cn (2027-01-06 到期), 443→172.18.0.1:8885, 续期 deploy-hook 自动 reload | ✅ 公网验 200/tls/301 |
| 激活开关 | secret.ini [wxpay] 五件套 + oauth_secret + certs/wx_platform_pub.pem; notify_base 由 work/_set_notify_base.py 落 | ⏳ 等用户商户资质 |
| 备用通道 | alt-pay 折叠条保转账登记旧路 (UI 微信独占, 1007 令) | ✅ |

**无商户号的正路**: 微信支付商户注册（企业/个体户资质）→ 无合规绕行。
个人码监听器 = 账号风险红线, 不做。UI 保持微信单通道, 支付宝休眠位保留。

## 部署经济学 · lite 模式 (1008 定型)

- 全量包 222.7MB / 24,754 片 = 小时级, 不可接受。
- content-diff 实证远端 196/198 字节一致 → **lite 包 = site/ + 4 py + 2 图 ≈ 1.0MB / 115 片 / 435s**。
- 复用 ecs_qw run() 通道: `printf '%s' '{chunk}' >> /tmp/rp_in/rp.b64` 12k 字/片。
- 执行: `work/_deploy_lite.py`；验证 = active + ready_code=200 + r50-snei.html payWxBtn≥1 + LITE-OK。

### 坑 (tar 双剥 · 最高危)
arcname 已带 `report_platform/` 前缀时, `--strip-components=1 -C /www/` = 双剥 → 文件落在
/www/server.py 而非 /www/report_platform/server.py, 服务跑旧码, journal 出现
BaseHTTPRequestHandler fallthrough `code 404, message Not Found`（= 路由缺席, 区别于 JSON 404）。
**正确解压目标 `-C /www/report_platform`**; 停机清理五个游尸 (/www/site /www/server.py
/www/pay.py /www/template.py /www/content)。
次坑: `grep -c` 空计数 exit 1 会杀 set -e → `|| true` 捕获后显式门控。

## v2 视觉审计闭环 (「世界顶级审美」令)

**方法**: 本地 playwright 截图 (work/shots_vN.py, m/d 双视口, 元素级+全页) → PIL 转 JPG
(≤8000px, q88) → **新文件名** (*_vN.jpg, 绕 CDN 路径缓存) → Read 出 CDN URL (~15min 有效)
→ analyze_image 中文审计提示词 (布局/层级/缺陷五问) → 低风险 CSS 修 → 重建 → 37 tests → 复截。

**两轮战果**:
- R1: 刊头副标题「不满意」腰斩 → 语义 `<br>`; 退款行可扫性; ap-note text-wrap:balance;
  wide 按钮阴影; alt-pay 对比度。
- R2: reader gate 输入框边框 .15→.30 + placeholder 显色; #gate .rule 收紧 16px;
  wide 阴影再进档 rgba(112,86,40,.62); alt-pay #5F543F + 大箭头。
- 审计确认无硬伤: 桌面 buy-box / index 刊头 / cta-end / 移动 buy-box。

## HTTPS 拓扑 (1008 live)

/root/dify/docker/nginx/conf.d/yrecepc.conf — 4 server 块; 80→301→443; LE 续期
deploy-hook 自动 `docker exec nginx-1 nginx -s reload`。双层墙: ufw 443 + 安全组 443。
服务: systemd report-platform @8885 (WorkingDirectory=/www/report_platform)。

## 待用户 (硬阻塞变现)
1. 微信支付商户号五件套 (mchid/appid/api_v3_key/serial_no/private_key_pem) + 公众号 AppSecret
2. (可选) 支付宝——UI 暂微信独占
3. 短剧/视频日更飞轮持续引流 (F5c 已上, 自动)

## 1008 傍晚 - 旧站关闭令（四层断，数据保留）

用户三连令：售卖阵地迁小程序（report-miniprogram-1008 战役）→ 旧站关停+端口关闭。

- [x] report-platform.service stop+disable（ECS /www/report_platform 全留，含 data/report_platform.db）
- [x] /root/dify/docker/nginx/conf.d/yrecepc.conf → yrecepc.conf.disabled-1008 + docker nginx -s reload
- [x] ufw 8885 v4/v6 双删；SG sgr-f8z6a8hm36rbz0g4gzt4 撤销（22→21 规则）
- [x] 外网验证：47.120.43.20:8885 与 report.yrecepc.cn 均断；8884/8889/8871/443 等他服未动
- 回滚四步：systemctl enable --now report-platform.service；mv vhost 改回+reload；ufw allow 8885/tcp；重开 SG 8885
- 关联弃置：微信支付直连商户申请单 2000002836618453 留档可续（用户令「先不管了」）；收款改虚拟支付轨道

## 1008 夜 - 整合目标二段转向（终局：总包AI顾问 wx5cee，另会话实施）

用户令链：①「把研究报告站点整合到总包AI顾问小程序中。不再整合到总包科技小程序中了」
②「你暂停整合到总包科技就好，恢复总包科技原来的样子」③「研究报告商城改整合进总包AI顾问，由另外一个会话实施」。

- [x] wxfdb（总包学园，1008 已更名「总包科技」）虚拟支付开通线**弃置于 Step2 表单页**：
      三绿门全过（已认证/企业/主体完备）+ Step1 协议通过，**零填写零提交零副作用**；
      复测入口态 = FRESH_NOT_OPENED 原貌；9336 控制台 wxfdb 4 标签全关，只剩 wx5cee 单会话（原状）
- [x] 控制台零扫码账号切换配方沉淀（隐藏 div[title="切换账号"] JS 直点 → switch_account_dialog
      → account_item）+ wujie 微前端穿 shadow DOM 工具 vpay_common.py（fresh_page/click_shadow/pierce_dump）
- [x] 移交文档落盘：`_proposals/report-miniprogram-1008/HANDOFF.md`（另一会话唯一入口：
      商品目录 content/report.json 66 SKU 价档 498×6/598×27/698×30/1999×2/10000×1、
      内容件 264MB/130、vpay 在役轨道 offer_id=1450664233、qianwen-engine 四腿、
      zongbao-ai BASE_URL=ai.epcschool.top、道具分层/iOS 门/发布+切0 三前置等关键设计题）
- [ ] （wx5cee 整合实施 = 另一会话，本会话到此移交为止）

## 2026-10-08 · wx5cee 整合实施收官（承接会话执行）

- [x] 引擎商城六腿 + 可售判定（64/66；TOPIC-06 超 20MB、BLUEBOOK 无 PDF 自动「整理中」）
- [x] 四档 vpay 道具 report_498/598/698/1999 现网建毕（¥1999 上限实测过；secret 四键入账）
- [x] downloadFile 合法域名 ai.epcschool.top 已在列（实查三组域名均有，零操作）
- [x] 生产部署 009：内容层 92.3MB 随镜像 + /api/reports 目录腿实弹 66/64 + 双闸门语义全对
- [x] 客户端 v0.9.0：五签 tab（研究倒数第二）+ 目录/详情/试读/购买/PDF 六腿 + iOS 闸
- [x] BOOT-SIM 341/341 + 引擎 85/85 + 上传 robot15 + 体验版钉位换 0.9.0
- [x] **提审 2026-10-08 19:22:08 审核中（普通队列）**——「所有工作全部完成再提审」用户令达成
- [ ] TOPIC-06 PDF 重生成 ≤20MB（工单；整理中直至重生）
- [ ] 过审后：发布（先清灰度横幅态）→ 六道具现网发布 → env=1→0 → 海报码 release → 收口链
