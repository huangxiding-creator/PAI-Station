# agent2

# 总包AI顾问（wx5cee1574ce45819b）虚拟支付全配方——可复制级挖掘报告

**商业模型（v0.8.0 用户令 1008 定稿）**：咨询全免费，仅「导出文件」按条收费 ¥0.1（`EXPORT_PRICE_FEN = 10`，E:\AI-Station\services\qianwen-engine\qianwen_engine\config.py:64）。旧 ¥1 整篇解锁（unlock_once 道具）已按用户令下线，端点 404 回归锚在 test_export_pay.py:436-441。

---

## 1. 「五步」具体是哪五步

权威出处：E:\AI-Station\WeAppForge\RUN_LEDGER.md:199（2026-10-07 23:2x「✅ 虚拟支付开通落地·服务端五步全收官（用户令『虚拟支付已经开通』）」）：

1. **offer_id=1450664233** —— 从小程序后台虚拟支付控制台「基本配置-基础配置」取得。
2. **道具 unlock_once「咨询解锁-单次」1 元** —— 用 wujie 微前端 raw CDP 注入配方创建（`Runtime.evaluate` 递归 iframe 找 file input → `DOM.requestNode` → `DOM.setFileInputFiles`；DrissionPage 的 `ele()` 对 wujie 文档全盲，这是核心坑）。
3. **AppKeys 沙箱+现网两把入 secret** —— 控制台「查看沙箱AppKey / 查看现网AppKey」按钮点开差分提取，直写 virtual_pay.secret。
4. **pay_sign 官方新规格** —— paySig=HMAC(appKey, uri&body) / signature=HMAC(session_key, body)，无 `VirtualPayment&` 前缀，官方向量锚定 **6 测全绿**（tests/test_pay_sign.py）。
5. **生产上线** —— 4 次部署，env=1 沙箱旗标**字节级实证** + 健康 6/6 + 配置零漂移（Cpu1/Mem2/Min1/Max2/Port8080/VPC subnet-ksblbg8p/AccessType MINIAPP,PUBLIC）。

同条目记录的**通道突破**：`tcb run service:config` 3.8.5 是结构性死路（options 未声明 envId + checkTcbrEnv 拒非 tcbr 环境，源码级实证）→ 正解 = `@cloudbase/manager-node` 直调。
同条目记录的**待办**（截至 1007 收官时）：客户端 0.8.0 解锁 UI 接 requestVirtualPayment 沙箱联调 → 道具发布 → env=1 切 0 现网。注：客户端代码 1008 已写好（见第 4 节），沙箱实弹联调/道具发布/env 切 0 未见完成记录。

## 2. offer/道具创建方式与配置细节

**创建方式 = 控制台 UI 自动化（非 API）**。实弹脚本 E:\AI-Station\WeAppForge\work\mp_cancel_logout\vpay_item_create.py：

- 入口 `https://mp.weixin.qq.com/wxamp/subApp/skit?token={token}&lang=zh_CN`（token 由 watch_category.py 的 `live_token` 从活会话 URL 提取，正则 `token=(\d{8,})`）
- 流程：点「基本配置」→「道具配置」→「添加道具」→ JS 填表（React 原生 setter + input/change 事件派发）：
  - 道具ID=`export_once`、名称=`导出解锁-单条`、价格=`0.1`、备注=`解锁单条导出`
  - 再点「普通道具」→「自定义」
- 图标上传走 CDP：`Runtime.evaluate` 递归 iframe 找 `input[type=file]` 拿 objectId → `DOM.requestNode` 换 nodeId → `DOM.setFileInputFiles` 注入 E:\AI-Station\WeAppForge\work\mp_cancel_logout\_goods_icon.png
- 点「提交审核」→ dump 全 iframe 文本确认列表出现 `export_once` → **自动写回 secret**：`export_product_id=export_once` 追加/替换进 E:\AI-Station\data\secrets\virtual_pay.secret（vpay_item_create.py:220-227）
- 全程 16 个 vpay_probe*.py 探针递进迭代（probe1 探入口 → probe7 揭 AppKey → probe16=建 unlock_once 1 元道具的成熟配方 → item_create 改编建 export_once）

**secret 六键**（config.py:60-63 注释定义格式）：`offer_id=` / `product_id=` / `export_product_id=` / `env=`（0 正式 1 沙箱）/ `sandbox_appkey=` / `prod_appkey=`。实际值（测试 fixture 佐证，test_export_pay.py:66-73）：
```
offer_id=1450664233
product_id=unlock_once_legacy
export_product_id=export_once
env=1
sandbox_appkey=test-sandbox-appkey   # 生产为真实键（ qw_tcb_prep.py:75-78 断言 offer_id=1450664233 在文件里）
prod_appkey=test-prod-appkey
```

**两个道具的语义**：`unlock_once`=¥1 咨询解锁-单次（v0.2.5 时代，现已下线留档为 `product_id=unlock_once_legacy`）；`export_once`=¥0.1 导出解锁-单条（在役）。**mode=short_series_goods（道具直购）**，单位分，`buyQuantity`=条数（单条=1，批量=N）。

**注意区分两个 env 概念**：支付 `env`（0 现网/1 沙箱，进 signData 字段）与 `POSTER_QR_ENV_VERSION`（config.py:81，海报小程序码指向 trial/release 版本，默认 trial，正式发布当日一行切 release）是两个独立维度。

## 3. pay_sign 签名算法与密钥管理

核心实现 E:\AI-Station\services\qianwen-engine\qianwen_engine\wechat.py:47-69：

```python
def virtual_pay_sign(app_key, session_key, sign_data=None, *, uri="requestVirtualPayment", body=None):
    if body is None:
        body = json.dumps(sign_data or {}, separators=(",", ":"), ensure_ascii=False)
    pay_sig = hmac.new((app_key or "").encode(), (uri + "&" + body).encode(), hashlib.sha256).hexdigest()
    signature = hmac.new((session_key or "").encode(), body.encode(), hashlib.sha256).hexdigest()
    return body, pay_sig, signature
```

- **2026-10 官方《签名详解》AppKey 新规格**：pay_sig = HMAC-SHA256(**appKey**, uri + "&" + signData)——旧规格误用 appsecret；signature = HMAC-SHA256(**session_key**, signData)——旧规格多 `VirtualPayment&` 前缀，新规格无。沿革实证：RUN_LEDGER.md:111（v0.2.5 旧规格 paySig=appsecret 腿带 `requestVirtualPayment&`、signature 带 `VirtualPayment&` 前缀）→ 1007 换新规格。
- appKey 随 env 取两把：env=0 用 prod_appkey、env=1 用 sandbox_appkey（app.py:545）。
- **signData 为紧凑 JSON 字符串（separators=(",",":"), ensure_ascii=False），客户端必须原样透传该字符串**——签名与其逐字节绑定，不得重序列化。
- **6 测**（tests/test_pay_sign.py，54 行输出 "ALL PASS (6 vectors, 官方向量锚定)"）：0) 官方向量端到端（appkey="12345"、uri=/xpay/query_user_balance、body='{"openid": "xxx", "user_ip": "127.0.0.1", "env": 0}' → pay_sig=c37809f27c6d7fd1837ad2500a04512b66b34fd793a39a385fade56dca89a4b5、signature=089d9e8dc5d308977360c4b79ec600a93d736802802a807d634192328032f6c7）1) 紧凑序列化契约 2) 双签名独立复核 3) 密钥隔离（换 session_key 只动 signature；换 appKey 只动 pay_sig）4) 逐字节绑定 5) 中文不转义。
- **密钥存哪**：全部住 E:\AI-Station\data\secrets\（红线区不进 git）——virtual_pay.secret（六键）、zongbao_qianwen_mp.secret（appsecret）、qianwen_engine_hmac.key（引擎 token HMAC）。生产侧经 `SECRET_FILES_B64` 环境变量（JSON map 文件名→base64，entrypoint 启动落盘 SECRETS_DIR）注入（TCB_DEPLOY.md:141-143）。
- **session_key 管理**（审计 CRITICAL-1 根治）：login 走真 code2session 后 `store.save_session(openid, session_key)` 落 mp_session 表，仅服务端留存用于 HMAC 签名，绝不下发客户端（app.py:96-99；test_export_pay.py:108-119 锚定「session_key 绝不出现在任何 API 响应」）。缺 session_key 时签名腿 401 → 客户端静默重登刷新后重试。
- **换密钥唯一活口 = manager-node 直调**（TCB_DEPLOY.md §8a:109-143）：`python WeAppForge/work/mp_cancel_logout/qw_tcb_prep.py`（重建 staging + 拉 live EnvParams → 替换 virtual_pay.secret → roundtrip 断言 → 出 data/state/qianwen_tcb_envparams.json）→ `node data/state/mn_client/update_envparams.js`（凭证读 ~/.config/.cloudbase/auth.json 临时密钥，`cloudrun.deploy({serverName, targetPath: staging, deployInfo:{ReleaseType:'FULL'}, serverConfig:{EnvParams: JSON.stringify(全量env), OpenAccessTypes:['PUBLIC','MINIAPP']}})`）→ 验证三板斧（detail EnvParams 双解 b64 比对 / record list 等 normal+HasTraffic / https://ai.epcschool.top/api/health）。

## 4. 小程序端调用代码（wx.requestVirtualPayment 参数组装）

封装层 E:\AI-Station\WeAppForge\projects\zongbao-ai\utils\pay.js:35-62：

```js
wx.requestVirtualPayment({
  mode: sign.mode,               // 'short_series_goods'（服务端下发）
  signData: sign.sign_data,      // 服务端签名字符串原样透传（逐字节绑定签名，不重序列化）
  paySig: sign.pay_sig,
  signature: sign.signature,
  success: () => { /* 回调服务端核验标记 */ api.request('POST', '/api/answer/{id}/export_paid', { out_trade_no: sign.out_trade_no }) },
  fail: (errRes) => { /* cancel/errCode===1 静默，其余提示重试 */ }
})
```

sign 来自服务端签名腿（api.js:126-127）：`exportSign(id)` → POST /api/answer/{id}/export_sign；`exportAllSign()` → POST /api/answers/export_all_sign。签名腿 409=服务端判定已解锁（已付补标记）直接收口；503=未开通降级文案；401=自动静默重登重试（api.js:72-81 统一 401 拦截）。

**调用现场**：
- 单条：pages/answer/answer.js:225-265 `onExport` —— wx.showModal（「支付 0.1 元」确认键）→ `pay.payExport(id)` → 成功 setData exportPaid=true 进导出面板；核验腿抖断时 res.reconciling 不谎报完成（重取详情等查单补标记）。
- 批量：pages/my/my.js:137-190 `onExportAll` —— unpaid 计数以服务端权威 `export_unpaid_all` 为准（/api/history 下发，防客户端 20 条截断算错钱——审计 MEDIUM-5）→ 超 99 条拦（buyQuantity 上限）→ 「支付 N×0.1 元」一单付清。
- **iOS 铁律**：`paySupported() = _platform !== 'ios' && typeof wx.requestVirtualPayment === 'function'`（pay.js:19-21）；UI 门 answer.wxml:239 `wx:if="{{payOk || exportPaid}}"`（iOS 隐藏付费入口但已解锁内容仍可导出）、my.wxml:127 同理。
- 版本：package.json version 0.8.0。

## 5. 服务端校验/发货逻辑

四腿端点（app.py:559-708）+ 三道防线：

**签名腿**（export_sign / export_all_sign）：仅本人答案 → 支付环境三验（_export_pay_env:540-552——offer_id/export_product_id 在位、appKey 按 env 选、session_key 在）→ **签名即落单** pay_order（otn 主键，kind=single/batch，批量落 aid_list=签名时刻未解锁快照）→ 复用未付单同 otn（防二次扣款，审计 HIGH-3）→ 若微信侧已付未标记当场补标记+409 收口 → 组 sign_data 返回 `{mode, sign_data, pay_sig, signature, out_trade_no, price_fen}`。sign_data 八字段：offerId/buyQuantity/env/currencyType=CNY/productId/goodsPrice/outTradeNo/attach（attach=sha256(openid)前16位，防明文）+mode。

**回调腿**（export_paid / export_all_paid）：**绝不裸信客户端**（审计 CRITICAL-2）——凭服务端订单（otn 必须存在、openid 匹配、kind/aid 匹配，伪造/空/他人单→404）+ **微信查单核验** `xpay_query_order`（wechat.py:79-105：POST https://api.weixin.qq.com/xpay/query_order?access_token=…，body={openid,out_trade_no,offer_id,env}+pay_sig+signature，签名走 body=/uri=/xpay/query_order 直签入口，请求体字段序与签名字符串序逐字节一致）→ `_order_status_paid`（app.py:486-500）：SUCCESS/PAYED/PAID→放行；NOTPAY/CLOSED/PAYERROR/REFUND/USERPAYING→400；字段缺失/陌生枚举→None 对账中。**生产（env=0）fail-closed：查单失败/不明一律 503**；**沙箱（env=1）查单基础设施不可用时信任回调**（模拟支付无真实资金，且 env 由服务端配置决定，客户端无法自选环境伪造）——app.py:514-537。

**发货**（store.py:751-808）：`mark_export_paid(aid)`——answers.export_paid=1 + 首次落 pay_log 对账行（幂等，重复回调恒 True）；批量 `mark_export_paid_many(openid, aids, otn)`——只标记快照 ∩ 本人 ∩ ready ∩ 未解锁，快照外新完成咨询留给下一单（审计 MEDIUM-4）。订单状态机 mark_order_paid:847-855（仅 signed→paid 真转，重复回调不重复记账）。导出闸门：/api/answer/{aid}/export 与 /api/answers/export_all 先验 export_paid，未解锁 402。解锁语义：unlock_once/export_once 都是**单次购买解锁该条反复导出**，不是消耗品（buyQuantity 一次性买 N 条各解锁一次）。

**测试矩阵**（tests/test_export_pay.py，21 个测试覆盖 8 个盲区）：盲区#1 login 真路径落 session_key / #2 伪造 otn 零支付解锁死路 / #3 批量快照 / #5 otn 熵（同毫秒双单不同号，_make_otn 尾接毫秒 base36+4位随机熵，app.py:476-483）/ #6 权威计数 / #7 仅 pending 404 / #8 dev 登录无 session_key 签名腿 401。

## 6. 虚拟支付开通前置条件（主体/商户号）

- **主体 = 总包说（海南）教育科技有限公司（企业认证 0928 通过）**——E:\AI-Station\WeAppForge\filing\category_dossier\README_一次性备件清单.md:12。config.py:60 注释定性：「虚拟支付（wx.requestVirtualPayment 道具直购 · **企业主体合规通道**）」。WIZARD.md:9-10 建号时就要求主体选「企业」（视频号企业认证同套资质）、类目先「工具-效率」起步。
- **开通流程（6 步，官方文档转述，出自学园调研 E:\AI-Station\_proposals\xueyuan-market\RESEARCH_DOCKET\deep_pay\_all.md:31——同属微信虚拟支付官方流程，非总包实做留痕）**：MP 后台【支付与交易→虚拟支付】→ 读协议 → 提交商户资料**开通独立新商户号（虚拟支付专用，区别于普通微信支付商户号）** → 账户状态查询及资料审核 → 账户验证 → 扫码签约 → 进商户管理后台配置道具/查订单/资金管理。前提：非个人主体 + 类目在开放清单（工具/教育知识付费等）。
- **总包AI顾问的开通本身是用户在控制台手动完成的**（RUN_LEDGER.md:199 用户令「虚拟支付已经开通」后 agent 落地配置五步）；**工程内未见具体商户号数字记录**（合理：代码链路只需 offer_id+AppKey，商户号在商户平台侧）。

## 7. TCB（云开发/云托管）在链路中的角色

- **生产部署位 = 腾讯云 CloudBase 云托管**（从 Aliyun ECS systemd+SQLite 迁来）：envId=cloudbase-d2gzke5r0b706b3a3、region=ap-shanghai、服务名 qianwen-engine、容器 python:3.11-slim + fonts-noto-cjk（Dockerfile 就在 E:\AI-Station\services\qianwen-engine\ 根，云托管自动构建）。DB=CloudBase MySQL（DB_KIND=mysql 环境变量切换，引擎代码零分叉，sqlite/mysql 双 DDL 同源在 store.py _SCHEMA）。**单副本运行**（进度流+KB 串行闸是进程内态）。健康检查 /api/health。
- **密钥通道 = SECRET_FILES_B64 环境变量**（JSON map 文件名→b64，entrypoint 启动落盘 SECRETS_DIR）；EnvParams 是 JSON 字符串。
- **manager-node 直调**：因 tcb CLI 3.8.5 `run service:config` 结构性死路（①options 未声明 envId 旗标恒 undefined 必抛；②即使补丁注入 envId，checkTcbrEnv 再拒非 tcbr 环境；③`--envParams` 值按 split('=') 无 maxsplit 截断），正解 = `@cloudbase/manager-node` 5.9.0（E:\AI-Station\data\state\mn_client\update_envparams.js）走 `UpdateCloudRunServer + DiffConfigItems 稀疏更新`——只动传入键，EnvParams 走 JSON 字符串通道无 '=' 截断。坑：`deploy()` 更新分支不展开旧配置，**OpenAccessTypes 不传会被默认值 ['OA','PUBLIC','MINIAPP'] 漂移，必须显式钉死**。
- 自定义域名 ai.epcschool.top（TCB_DEPLOY.md §7 写 api.epcschool.top 为规划名；ledger #199 验证实录用 ai.epcschool.top/api/health）。
- 部署/查询在役 CLI 通道（TCB_DEPLOY.md §8）：`tcb cloudrun deploy/detail/record/logs`，VPC vpc-hv6ji25g / subnet-ksblbg8p。
- 数据迁移：scripts/migrate_sqlite_to_mysql.py（一次性，TABLES 含 pay_log/pay_order 全部 12 表，防呆目标非空拒跑，--fresh 清空重灌）。

## 8. 沙箱 vs 生产切换

- **支付环境**：secret 文件 `env=` 键（0=现网 1=沙箱）→ 读入后（app.py:544 `env_val = int(vp.get("env","0") or 0)`）直通 sign_data.env 字段与查单 env 字段；appKey 随之选 prod_appkey/sandbox_appkey（app.py:545）。行为差异：沙箱查单不可用信任回调；生产 fail-closed 503（app.py:525-537）。
- **当前生产态 = env=1 沙箱旗标**（ledger #199「env=1 沙箱旗标字节级实证」；qw_tcb_prep.py 不改 env 键只换 secret 内容）。
- **切生产动作**：改 E:\AI-Station\data\secrets\virtual_pay.secret 的 `env=1` → `env=0` → `python WeAppForge/work/mp_cancel_logout/qw_tcb_prep.py` → `node data/state/mn_client/update_envparams.js` → 验证三板斧。前置=道具在后台发布（unlock_once/export_once 提交审核后须审核通过发布）。
- **POSTER_QR_ENV_VERSION**（config.py:81）是独立开关：海报小程序码 env_version 指向 trial（体验版）/release（正式版），默认 "trial"，正式发布当日一行切 release，缓存键含 env 版本自动重生成海报码（app.py:871-880）。

## 可复制配方摘要（给借鉴方）

1. 主体企业认证 + 类目过审 → 用户在 MP 后台手动开通虚拟支付（独立新商户号）。
2. 控制台自动化三件套（DrissionPage attach + CDP，公共腿 watch_category.live_token + driver.attach_or_launch）：取 offer_id（基本配置-基础配置）→ 揭两把 AppKey（查看沙箱/现网 AppKey 点击差分，vpay_probe7.py）→ 建道具（wujie iframe 递归 + DOM.setFileInputFiles 传图标，vpay_item_create.py）——全部自动写回 virtual_pay.secret 六键。
3. 服务端四件：login 留存 session_key（mp_session 表）→ 双签名（AppKey 新规格，官方向量锚定）→ 签名即落单（pay_order 表+复用未付单）→ 回调凭单+查单核验（/xpay/query_order 同规格直签）才发货（export_paid 标记+pay_log 对账）。fail-closed 原则贯穿。
4. 小程序端 pay.js 封装：服务端出签名三件套，客户端只透传+拉起+回调，iOS 隐藏付费入口。
5. 部署与密钥换装：manager-node 通道（SECRET_FILES_B64），沙箱 env=1 先行实证再切 0。

## Key Facts
- 虚拟支付五步收官权威记录：①offer_id=1450664233 ②道具 unlock_once 1元（wujie raw CDP 注入配方）③AppKeys 沙箱+现网入 secret ④pay_sign 官方新规格官方向量锚定 6 测全绿 ⑤生产上线 env=1 沙箱旗标字节级实证+健康6/6+配置零漂移；待办=沙箱联调→道具发布→env 切 0 (E:\AI-Station\WeAppForge\RUN_LEDGER.md 199)
- 双签名算法：pay_sig=HMAC-SHA256(appKey, uri+'&'+body)；signature=HMAC-SHA256(session_key, body)；旧规格误用 appsecret 且多 'VirtualPayment&' 前缀；signData 紧凑 JSON ensure_ascii=False 客户端原样透传；官方向量 appkey=12345 uri=/xpay/query_user_balance (E:\AI-Station\services\qianwen-engine\qianwen_engine\wechat.py 47-69)
- 6 测=tests/test_pay_sign.py 六组断言（官方向量端到端/紧凑序列化/双签名复核/密钥隔离/逐字节绑定/中文不转义），输出 ALL PASS (6 vectors, 官方向量锚定) (E:\AI-Station\services\qianwen-engine\tests\test_pay_sign.py 23-54)
- secret 六键格式：offer_id= / product_id= / export_product_id= / env=(0正式 1沙箱) / sandbox_appkey= / prod_appkey=；文件=data/secrets/virtual_pay.secret；EXPORT_PRICE_FEN=10（¥0.1/条）；EXPORT_BATCH_MAX=99 (E:\AI-Station\services\qianwen-engine\qianwen_engine\config.py 60-65)
- login 落 session_key 进 mp_session 表（仅服务端用于 HMAC 签名绝不下发）——审计 CRITICAL-1：不落盘=签名腿恒 401 死锁 (E:\AI-Station\services\qianwen-engine\qianwen_engine\app.py 96-99)
- 四腿端点：export_sign(559)/export_paid(610)/export_all_sign(634)/export_all_paid(690)；签名即落单 pay_order；复用未付单同 otn 防二次扣款；已付未标记当场补标记 409 收口 (E:\AI-Station\services\qianwen-engine\qianwen_engine\app.py 559-708)
- 回调核验 fail-closed：生产(env=0)查单失败/状态不明一律 503 对账中；沙箱(env=1)查单不可用信任回调（模拟支付无真实资金，env 服务端定客户端无法伪造） (E:\AI-Station\services\qianwen-engine\qianwen_engine\app.py 514-537)
- 微信侧查单：POST /xpay/query_order，body={openid,out_trade_no,offer_id,env}+pay_sig+signature，签名规格同 requestVirtualPayment（body=/uri=/xpay/query_order 直签入口），请求体字段序与签名字符串序必须逐字节一致 (E:\AI-Station\services\qianwen-engine\qianwen_engine\wechat.py 79-105)
- 订单状态机：SUCCESS/PAYED/PAID→放行；NOTPAY/NOT_PAY/CLOSED/PAYERROR/REFUND/USERPAYING→400；陌生/缺失→None 对账中 (E:\AI-Station\services\qianwen-engine\qianwen_engine\app.py 486-500)
- pay_order 表 DDL（sqlite/mysql 双形态同源）：out_trade_no 主键/kind/aid/aid_list 快照/buy_quantity/total_fen/status signed→paid/pay_log 对账流水 (E:\AI-Station\services\qianwen-engine\qianwen_engine\store.py 377-420)
- 发货：mark_export_paid 幂等解锁单条+首次落 pay_log；mark_export_paid_many 快照制只解锁签名时刻 aid_list ∩ 未解锁（MEDIUM-4） (E:\AI-Station\services\qianwen-engine\qianwen_engine\store.py 751-808)
- 小程序端调用：wx.requestVirtualPayment({mode, signData: 服务端字符串原样透传, paySig, signature})；成功后回调 /export_paid；409 已解锁收口；iOS 铁律 paySupported()=platform!=='ios' 且基础库支持 (E:\AI-Station\WeAppForge\projects\zongbao-ai\utils\pay.js 19-62)
- 单条支付现场：wx.showModal 确认「支付 0.1 元」→ pay.payExport(id) → reconciling 态不谎报完成；批量现场 my.js onExportAll 用服务端权威 export_unpaid_all 计价、超 99 条拦截 (E:\AI-Station\WeAppForge\projects\zongbao-ai\pages\answer\answer.js 225-265)
- iOS UI 门：answer.wxml:239 wx:if="{{payOk || exportPaid}}"（iOS 隐藏付费入口已解锁可导出）；my.wxml:127 wx:if="{{payOk || exportUnpaidAll === 0}}" (E:\AI-Station\WeAppForge\projects\zongbao-ai\pages\answer\answer.wxml 239)
- 道具创建=控制台 UI 自动化非 API：mp.weixin.qq.com/wxamp/subApp/skit →基本配置→道具配置→添加道具→填 export_once/0.1 元→普通道具→自定义→CDP DOM.setFileInputFiles 传图标→提交审核→确认后自动写 secret export_product_id= 行 (E:\AI-Station\WeAppForge\work\mp_cancel_logout\vpay_item_create.py 2-6,177-229)
- AppKey 揭取工艺：控制台「查看沙箱AppKey/查看现网AppKey」点击前后差分收集（input 值+own-text 双通道，16-128位字符白名单过滤），直写 secret 并 put offer_id=1450664233 (E:\AI-Station\WeAppForge\work\mp_cancel_logout\vpay_probe7.py 100-133)
- TCB 部署：tcb run service:config 3.8.5 结构性死路；正解=manager-node 直调 UpdateCloudRunServer+DiffConfigItems 稀疏更新，EnvParams JSON 字符串通道无 '=' 截断，OpenAccessTypes 必显式钉死防 OA 漂移；密钥真通道=SECRET_FILES_B64（JSON map 文件名→b64，entrypoint 落盘） (E:\AI-Station\services\qianwen-engine\TCB_DEPLOY.md 109-143)
- 换密钥流程：qw_tcb_prep.py 重建 staging+拉 live EnvParams→替换 virtual_pay.secret→roundtrip 断言（断言 offer_id=1450664233 在文件）→node update_envparams.js（auth.json 临时密钥+cloudrun.deploy）→验证三板斧 (E:\AI-Station\WeAppForge\work\mp_cancel_logout\qw_tcb_prep.py 52-79)
- manager-node 调用形参：cloudrun.deploy({serverName:'qianwen-engine', targetPath:staging, deployInfo:{ReleaseType:'FULL'}, serverConfig:{EnvParams:JSON.stringify(envp), OpenAccessTypes:['PUBLIC','MINIAPP'], InstallDependency:true}})，envId=cloudbase-d2gzke5r0b706b3a3 region=ap-shanghai (E:\AI-Station\data\state\mn_client\update_envparams.js 12-54)
- 生产环境=CloudBase 云托管（envId cloudbase-d2gzke5r0b706b3a3，服务 qianwen-engine，python:3.11-slim+fonts-noto-cjk，DB_KIND=mysql CloudBase MySQL 内网，单副本，健康 /api/health，Dockerfile 在 services/qianwen-engine/ 根） (E:\AI-Station\services\qianwen-engine\TCB_DEPLOY.md 16-31,145-150)
- 沙箱/生产切换：secret env= 键 0/1 直通 sign_data.env 与查单 env，appKey 随 env 选 sandbox/prod；当前生产 env=1 沙箱实证态；切 0 前置=道具后台发布 (E:\AI-Station\services\qianwen-engine\qianwen_engine\app.py 540-552)
- POSTER_QR_ENV_VERSION='trial'（config.py:81）是海报小程序码指向版本独立开关，正式发布当日一行切 release，与支付 env 无关 (E:\AI-Station\services\qianwen-engine\qianwen_engine\config.py 81)
- 主体=总包说（海南）教育科技有限公司（企业认证 0928 通过）；config.py:60 定性「企业主体合规通道」 (E:\AI-Station\WeAppForge\filing\category_dossier\README_一次性备件清单.md 12)
- 开通流程6步（官方流程转述，学园调研同源记载）：MP后台【支付与交易→虚拟支付】→读协议→提交商户资料开独立新商户号（虚拟支付专用区别于普通微信支付商户号）→账户状态查询审核→账户验证→扫码签约→商户后台配道具 (E:\AI-Station\_proposals\xueyuan-market\RESEARCH_DOCKET\deep_pay\_all.md 31)
- v0.2.5 旧规格沿革实证（0929 时代）：pay_sig=appsecret 腿带 'requestVirtualPayment&'、signature 带 'VirtualPayment&' 前缀；1007 换 AppKey 新规格 (E:\AI-Station\WeAppForge\RUN_LEDGER.md 107-114)
- 旧 ¥1 解锁端点已下线回归锚：pay_sign/unlock_paid/share 均 404；现役道具 export_once ¥0.1（unlock_once 留档为 product_id=unlock_once_legacy） (E:\AI-Station\services\qianwen-engine\tests\test_export_pay.py 64-74,436-441)
- outTradeNo 生成：合法字符 [0-9A-Za-z_-|*@] 8-32 位不以下划线开头，锚点截 24 位+毫秒 base36 六位+4 位随机熵防同毫秒碰撞；批量锚点用 openid 哈希非明文（otn 进用户账单详情可见） (E:\AI-Station\services\qianwen-engine\qianwen_engine\app.py 476-483)
- 迁移脚本：migrate_sqlite_to_mysql.py 一次性搬 12 表（含 pay_log/pay_order），复用引擎运行时自举 DDL 不漂移，目标非空拒跑防重复灌数 (E:\AI-Station\services\qianwen-engine\scripts\migrate_sqlite_to_mysql.py 22-32)
- 对抗审计测试矩阵 21 测 8 盲区全锚定：login真路径/伪造otn死路/批量快照/otn熵/权威计数/pending 404/dev登录401/生产fail-closed+沙箱信任 (E:\AI-Station\services\qianwen-engine\tests\test_export_pay.py 1-15)
- WX_APPID=wx5cee1574ce45819b（总包千问引擎配置直书） (E:\AI-Station\services\qianwen-engine\qianwen_engine\config.py 58)

## Risks
- 工程内未找到具体商户号数字记录——商户号在商户平台侧，代码链路只需 offer_id+AppKey，借鉴时不要在代码里找商户号
- deep_pay/_all.md 的开通6步/费率/价格上限是学园项目的调研文档（转述官方文档+行业信源），非总包AI顾问实做留痕，引用时须注明信源等级
- export_once 道具于 1007 傍晚「提交审核」，后台是否已审核通过/发布未见工程内实证记录；RUN_LEDGER #199 待办「道具发布」在收官时未完成——env 切 0 前必须先发布道具
- 沙箱端到端实弹（真机拉起支付面板验 signData 线格式）在 #199 收官时仍是待办；客户端 0.8.0 代码已写好但未见真机支付成功记录（本次只读侦察未发现后续 ledger 条目）
- 虚拟支付 secret 真实键值未读取（只读侦察遵守密钥红线，仅从测试 fixture 与 qw_tcb_prep 断言确认 offer_id=1450664233 存在）；sandbox_appkey/prod_appkey 实值无法从工程侧佐证
- 单副本约束：进度流与 KB 串行闸是进程内态，多副本前须先外置（MySQL/Redis），扩容时支付链 pay_order 依赖 DB 不受影响但 _PROGRESS 会丢
- 签名规格时效性：wechat.py 标注「2026-10 官方《签名详解》AppKey 新规格」，若微信后续再改规格，官方向量锚定测试（test_pay_sign.py §0）会第一时间红——这是设计优点不是风险，但借鉴方须知其锚定基准

## Open Questions
- 沙箱端到端实弹联调（真机拉起 wx.requestVirtualPayment 面板）是否已做？RUN_LEDGER #199 待办列「沙箱联调验 signData 线格式+mode=short_series_goods 实证」，未见完成记录——借鉴方首跑应先补这一步
- unlock_once 与 export_once 两道具在 MP 后台的审核/发布状态（提交审核≠已发布）；env 切 0 前必须确认道具已发布
- 虚拟支付扣款资金的实际结算账户/商户号数字（工程内无记录，须登录商户平台查看；deep_pay 调研称道具直购 T+3）
- 为什么生产停留 env=1 沙箱旗标——是等道具发布+真机联调的用户裁决（RUN_LEDGER #199 待办原文），还是已另有推进（本次只读侦察未见后续 ledger 条目）
- 批量导出 402 文案「¥{total_yuan:g}」的金额以 EXPORT_PRICE_FEN 计算，若未来调价需同步 config.py 与后台道具价格两处
