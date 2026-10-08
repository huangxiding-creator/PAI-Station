# HANDOFF — 研究报告商城整合进总包AI顾问(wx5cee) · 移交另一会话实施

**移交时间**: 2026-10-08 夜 · **移交会话**: 743cb8f4（本会话只做了侦察+两次转向收口，未写任何商城代码）
**用户令链原文**: ①「把研究报告站点整合到总包AI顾问小程序中。不再整合到总包科技小程序中了」②「你暂停整合到总包科技就好，恢复总包科技原来的样子」③「研究报告商城改整合进总包AI顾问，由另外一个会话实施」

## 一、终局形态（用户已拍板，勿再问）

- **宿主小程序 = 总包AI顾问 wx5cee1574ce45819b**（虚拟支付/备案/认证全完成，虚拟支付已在役生产）
- **wxfdb（总包学园，已改名「总包科技」）线 = 弃置**。其虚拟支付开通推进到 Step2 表单页后收场：**零填写零提交零副作用**，1008 夜实测虚拟支付入口回到 `FRESH_NOT_OPENED` 原貌；9336 控制台 wxfdb 全部标签已关，只剩 wx5cee 会话单标签（原貌）。wxfdb 本地凭据留 report_platform/secret.ini [wxapp_wxfdb]（仅本地仓外文件，未用过）。

## 二、可直接复用的资产地图

### 1. 商品与内容（全在 E:/AI-Station/report_platform/）
- **目录源** `content/report.json`：dict{site_name, reports:[66]}，单 SKU 字段全：sku/title/subtitle/price/price_label/words_wan/badges/sample_file/sample_label/chapters[]/cat/cat_name/method_note/intro_lede/intro/audience
- **价格分布**：¥498×6 / ¥598×27 / ¥698×30 / ¥1999×2 / ¥10000×1（蓝皮书预售 BLUEBOOK-2027）
- **内容件** `content/full/`：130 文件（66 SKU × html+pdf），**264MB**
- 阿里云旧站已四层关死（数据全留 ECS /www/report_platform 含订单库；回滚配方在 memory flagship-paid-report-goal.md「1008 傍晚大转向」段）

### 2. 虚拟支付轨道（wx5cee，已在役生产，照抄即可）
- **权威配方 = `discovery/qianwen-vpay.md`**（29018 字节，全链可复制级）：offer_id=1450664233 / 道具创建 wujie CDP 配方 / AppKeys 差分揭取 / pay_sign 新规格（HMAC-SHA256(appKey, uri&body) + HMAC-SHA256(session_key, body)，无前缀，紧凑 JSON 逐字节透传，6 官方向量测试在 tests/test_pay_sign.py）
- **服务端四腿**（签名即落单/复用未付单/回调凭单+查单核验 fail-closed/幂等发货）：services/qianwen-engine/qianwen_engine/app.py:559-708 + wechat.py:47-105 + store.py —— 报告解锁腿≈export 腿改皮（kind=report, aid→sku）
- **客户端** WeAppForge/projects/zongbao-ai/utils/pay.js（paySupported iOS 门 + requestVirtualPayment 三件套透传）；**API 基址** utils/config.js:7 `BASE_URL = OVR || 'https://ai.epcschool.top'`（TCB 云托管自定义域名，request 合法域名已通）
- **部署/换密钥**：manager-node 直调（tcb CLI 3.8.5 死路勿再试）—— qw_tcb_prep.py → data/state/mn_client/update_envparams.js → 验证三板斧；envId cloudbase-d2gzke5r0b706b3a3 / ap-shanghai / 服务 qianwen-engine / SECRET_FILES_B64 注入
- **在役 secrets**（E:/AI-Station/data/secrets/virtual_pay.secret 六键，env=1 沙箱态）

### 3. 控制台自动化（9336 专属口，若需建道具/查发布态）
- 会话现状：wx5cee 会话活（token 不落盘，从 9336 控制台 URL 活提；profile E:\AI-Station\data\state\mp_qr_profile；掉线走 qr_send.py 扫码召唤，12h 限频）
- **同管切号配方（已实证）**：隐藏 `div[title="切换账号"]` JS 直点（Vue handler 不挑可见性）→ `.switch_account_dialog .account_item` 点目标号 → 整页刷新换 token
- **wujie 微前端工具**：`WeAppForge/work/mp_cancel_logout/vpay_common.py`（fresh_page 扫全 tab 按身份找会话 / pierce_dump / click_shadow 穿 shadow DOM 点按钮——控制台 Vue 页三坑见 weapp-launch-factory skill references/mp-console-automation.md）
- **建道具成熟配方**：`vpay_item_create.py`（改 PRODUCT_ID/名称/价格即可）

## 三、关键设计题（另一会话 Phase 4 前须裁决）

1. **道具分层**：现役 export_once ¥0.1。报告需 ¥498/598/698/1999/(10000)。两路线：A) 每 价一档道具×buyQuantity=1（干净，但 ¥10,000 单道具可能撞 vpay 价格上限——上限未实测，deep_pay 调研信源 cred 0.5-0.8）；B) 单道具小面额+buyQuantity=N（¥1999=1999×¥1）。建议先实测 A 的上限再定；蓝皮书 ¥10,000 若撞顶→拆定金+尾款或预售分期
2. **在役两坑（前置）**：export_once 道具 1007 建后停在「开发版本未发布」；生产 env=1 沙箱旗标未切 0。**报告道具建完必须连发布+切 0 一起收口**（否则买家付不了真钱）
3. **iOS 铁律**：paySupported()=platform!=='ios'——iOS 隐藏购买入口。¥498+ 高价报告在 iOS 无购买通道是商业硬伤，需产品层对策（iOS 展示「客服微信购买」兜底之类，用户裁决）
4. **阅读形态**：PDF（wx.downloadFile+openDocument，需 downloadFile 合法域名加 ai.epcschool.top——走 /wxa/modify_domain API 免控制台）+ 试读 native rich-text（chapters/sample 已结构化）；web-view 阅读器作 v2（业务域名要控制台配验证文件）
5. **内容上云**：264MB/130 件——建议 TCB 云存储+CDN（勿塞 docker 镜像拖慢构建）；或首期只上 试读+PDF
6. **验收判据**：沙箱单全链（签名→拉起→回调→解锁→读文）→ 道具发布 → env 切 0 → 真机真钱 ¥0.1 面额自购验资全回流

## 四、本会话已做的账（全部只读侦察+收口，零商城代码）

- discovery/ 七件（f5a-site/xueyuan-mp/qianwen-vpay/forge-pipeline/proposals/wxfdb-state/console-ops）
- 探针 14+ 个（vpay_open_probe*.py + vpay_common.py + vpay_step1.py + vpay_open_run.py，全在 WeAppForge/work/mp_cancel_logout/）
- wxfdb 侧：切号成功→vpay 三绿门全过→Step1 协议过→Step2 表单页**未填即弃**→入口复原 FRESH_NOT_OPENED 实证→标签全清
- memory flagship-paid-report-goal.md 已录终局形态；GOAL_LEDGER 见同批提交

## 五、纪律提醒（照旧）

WeAIPO 9222 免打扰｜9336 是控制台唯一合法口｜密钥永不进仓（secret.ini/virtual_pay.secret 均 gitignored）｜推送=github-push skill 场景A/B+场景C 百度备份｜数字零造假｜每次收口 GOAL_LEDGER 回填
