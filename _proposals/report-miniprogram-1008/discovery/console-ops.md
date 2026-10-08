# agent1

# mp.weixin.qq.com 控制台操作史考古（为 wxfdb 自行开通虚拟支付找复用通道）

## 一、控制台操作史：以前给 wxfdb/wx5cee 做过什么、用什么通道、登录态怎么维持

### 通道架构（1004 建立，至今在役）——「专属 Chrome + 9336 + DrissionPage」

核心件 `E:\AI-Station\WeAppForge\work\mp_cancel_logout\driver.py`：
```python
PORT = 9336
PROFILE = r"E:\AI-Station\data\state\mp_qr_profile"
MP_ROOT = "https://mp.weixin.qq.com/"
# opts.set_local_port(PORT); opts.set_user_data_path(PROFILE)
# 默认即 headful：二维码须显示到桌面
```
建此通道的根因（driver.py 头注）：MCP 共管浏览器（9222）被调研腿争抢（hide/show+重启毁标签页），二维码页无法存活 → 用专属 profile + 端口 9336 的独立 Chrome，attach-or-launch 可反复重入。

登录方式 = 管理员微信扫码：落在 mp.weixin.qq.com 根页二维码，`qr_fresh()` 判新鲜（页面无「已失效」/「点击刷新」遮罩，过期则重载换新码）。

登录态维持 = 两层：
1. **profile 持久化**：cookie 落在 `E:\AI-Station\data\state\mp_qr_profile`，Chrome 进程不死即活会话；
2. **live token 提取**（`watch_category.py` 的 `live_token(tab)`）：从活标签 URL 正则 `token=(\d{8,})` 提取，提不到则回控制台首页刷新一次再从 URL/页面源提，仍无=如实报 login_wall（token 硬编码会话重登即陈旧，1006 已根治为活提）。1007 起部分腿进化为零登录 API 版（`watch_category_api.py`：appsecret 换 access_token 走 api.weixin.qq.com，免扫码）。

### wx5cee1574ce45819b（总包AI顾问/biaoxun→zongbao-ai）——控制台自动化主战场

| 日期 | 操作 | 脚本/证据 |
|---|---|---|
| 1004 | **取消注销全链**（账号被自主注销，红横幅「小程序暂停服务」→查看详情→取消注销，状态机 QR_WAIT→ACT_1..13→RESTORED，act2-act13.py 逐步脚本+behavior_verify） | driver.py、act2..13.py、state.json 终态 `ACT13_requery status=0`；截图落 `E:\AI-Station\WeAppForge\filing\cancel_logout_*.png` |
| 1006-1008 | **类目盯哨**（深度合成>AI问答 绿灯判定）：浏览器版→API 版（零登录）→OS 级 schtasks `QianwenCatWatch` 每 3h（1008 根治会话级 cron 随会话死亡） | watch_category.py / watch_category_api.py / watch_category_task.py |
| 1007 夜 | **虚拟支付道具创建**：vpay_probe1→16 十六轮试错，probe16 定型「裸 CDP 喂文件」配方，实弹建 `unlock_once`（咨询解锁-单次 ¥1），页面回「道具已创建成功」 | vpay_probe16.py、`_p16.log`（row_seen=true, secret_written=true）、vpay_item_create.py（1008 又建 export_once ¥0.1） |
| 1008 | **v0.8.0 提审三步向导**（版本管理→提交审核→须知 checkbox→下一步→继续提交→主表单）+ **API 重提审**（submit_audit_api.py，API 优先控制台兜底） | submit_v080.py、submit_audit_api.py（内 assert appid=="wx5cee1574ce45819b"） |
| 1007-1008 | **云托管环境变量更新**（virtual_pay.secret 注入 SECRET_FILES_B64） | qw_tcb_prep.py、TCB_DEPLOY.md §8a |

**重要事实**：wx5cee 的虚拟支付「开通 6 步」（协议/商户资料/打款验证/扫码签约）是**用户 1007 人工完成的**（用户令「已开通」，offer_id=1450664233），agent 接手的是开通后的道具配置+服务端签名。学园 wxfdb 走同流程可整链复用。

### wxfdb55b184756e89e（总包学园）——控制台操作以用户手点为主

- 0928 RUN_LEDGER #39：上传 v0.3.0 后「用户一步」= MP 控制台「版本管理→开发版本→0.3.0→**选为体验版**」；
- 0929 RUN_LEDGER #49：「**用户已选体验版（控制台步①完成）**」→ agent 趁窗灌 256 张体验版码池；剩手机半步=体验版开「开发调试」（http+IP 非白名单域须调试开关跳过校验）；
- 虚拟支付**尚未开通**：`_proposals\xueyuan-market\WIZARD_VIRTUAL_PAY.md` 是写给用户的点击向导（道具=研报单篇解锁 xy_report_unlock ¥498），文末注明「总包AI顾问（biaoxun, wx5cee1574ce45819b）也等同一个开通」。

## 二、开通虚拟支付要点哪些地方（可还原程度：官方 6 步全量 + 道具配置自动化配方全量）

**官方 6 步**（`_proposals\xueyuan-market\KNOWLEDGE_BASE\virtual_pay.md` §2 + WIZARD_VIRTUAL_PAY.md，源自官方文档深研 cred 0.95）：
1. mp.weixin.qq.com 管理员扫码登录 → 左侧菜单 **【功能（或「支付与交易」）→ 虚拟支付】**；若提示「类目不支持」→ 先到「设置→服务类目」调整到开放清单（教育/知识付费/工具）
2. 阅读并同意《虚拟支付服务协议》
3. 提交商户资料（营业执照、对公账户三要素）→ 系统开**虚拟支付专用独立新商户号**（与普通商户号两回事）
4. 账户状态查询与资料审核
5. 账户验证（打款验证或信息核验）
6. 扫码签约（管理员微信扫码签协议）

**开通后的道具配置（agent 已全自动化的部分，可直接复用给 wxfdb）**——`vpay_item_create.py`/`vpay_probe16.py` 实证路径：
- 直达 URL：`https://mp.weixin.qq.com/wxamp/subApp/skit?token={token}&lang=zh_CN`
- 页面结构（_p16.log 实录）：左栏「虚拟支付：接入指引/交易订单/资金管理/基本配置/广告金管理」；内 tab「基础配置/代币配置/**道具配置**/微信支付账号信息/广告金审批配置」
- 点「基本配置」→「道具配置」→「**添加道具**」→ 填 4 字段（placeholder 锚定：请填写道具ID/道具名称/道具价格/备注仅自己使用，用原生 setter+派发 input/change 喂 Vue）→「普通道具」→「自定义」→ CDP `DOM.setFileInputFiles` 喂道具图标 →「提交审核」→ 处理「我知道了」弹窗
- 道具先落「开发版本」（沙箱可测），测试无误后点「发布」上现网；offer_id 在「基本配置」页可见（RESEARCH_DOCKET/vpay_refund：offerId=虚拟支付商户号，MP后台-虚拟支付-基本配置）→ 拿到后写 `data/secrets/virtual_pay.secret`（offer_id=/product_id=/sandbox_appkey= 键值）
- 操作铁律全册在 `E:\AI-Station\.claude\skills\weapp-launch-factory\references\mp-console-automation.md`：翻译扩展 span 包裹须按自有文本节点找真按钮、checkbox 与按钮绝不连点（Vue digest）、每步 click 后回读 DOM、「选为体验版」须按版本号文本锚定 `.code_version_log` 块（祖先遍历曾误点 0.4.2 弹危险对话框）

## 三、现有浏览器实例/端口（netstat 实查 2026-10-08）

| 端口 | 状态 | 属主 | 用途 |
|---|---|---|---|
| **9336** | **LISTENING（PID 21860 chrome.exe，活）** | mp 控制台专属浏览器 | wx5cee 全部控制台操作落此，可直接 attach_or_launch 复用 |
| 9222 | LISTENING（PID 17064 chrome.exe） | superpowers MCP 共管口 | **WeAIPO 视频号发布腿生产占用**（wxpay_edge_cdp.py 注释实锤：被 pythonw 4 连接 actively 驱动），勿扰动 |
| 9327 | 未监听 | `E:\AI-Station\tools\wxpay_edge_cdp.py` 的 Edge 驱动口 | 微信支付商户注册向导 CDP 直驱器（websocket 直连 http://127.0.0.1:9327），当前未跑，用前须先拉起冷门口 Edge |
| 19825/19826 | 未监听 | 搜狗 bb-browser | 未在跑 |

## 四、扫码召唤协议的记录位置

- `E:\AI-Station\WeAppForge\work\mp_cancel_logout\watch_category.py:37`：「no-token: 会话未登录或页面异常, 须扫码召唤 (勿自动重发企微, 12h 一条)」——限频纪律写死在报文里
- `E:\AI-Station\WeAppForge\work\mp_cancel_logout\vpay_probe.py:31`：「no-token, 须扫码召唤」
- `E:\AI-Station\WeAppForge\work\mp_cancel_logout\qr_send.py`（协议实现件）：强制重开 mp 根页拿新码（旧码过期=重发必败）→ 截 `img[src*=scanloginqrcode]` → base64+md5 → 企微 webhook 图片直发 → 用户手机长按识别即完成登录（登录落在 9336 专属浏览器）
- 用户级记忆档 `C:\Users\91216\.claude\projects\e--AI-Station\memory\scan-summon-protocol.md`（用户 1004 令：确实需扫码时发企微叫用户做 30 秒动作，先穷尽自绕再升级）
- 旁证引用：`_proposals\report-methodology-1006\SUPER_PIPELINE_FRAMEWORK_V1.md:733`（notify/ask 二分时引「企微推送纪律+扫码召唤协议」）

## 五、给 wxfdb 开通虚拟支付的复用建议（基于以上事实）

1. 先决条件：虚拟支付 6 步中的 1-6 步（协议/资质/打款/签约）含商户资料人工提交与打款验证，**无法纯自动化**（对公账户打款验证是外部流程）；但开通动作本身的页面导航可复用 9336 通道代点（同 wx5cee 先例：用户给令「已开通」后 agent 接管一切）。
2. 通道复用：9336 专属浏览器现活着（PID 21860），但**当前登录的是哪个号须实查**（live_token+页面头像/账号名）；若须切到 wxfdb，须退出换码（qr_send.py 发企微叫用户扫，12h 限频）。
3. 道具配置段 100% 可自动化：vpay_item_create.py 改 PRODUCT_ID/名称/价格即可（1008 刚为 export_once 复用过一次，配方新鲜）。
4. 服务端腿复用：qianwen-engine 的 pay_sign 双签名 + TCB_DEPLOY.md §8a manager-node 环境变量通道 + virtual_pay.secret 三键（offer_id/product_id/sandbox_appkey）全链在役。

## Key Facts
- mp 控制台专属浏览器=独立 Chrome 端口 9336 + profile E:\AI-Station\data\state\mp_qr_profile，DrissionPage attach-or-launch，headful 二维码显示到桌面 (E:/AI-Station/WeAppForge/work/mp_cancel_logout/driver.py 27-53)
- 登录态维持=live_token() 从活会话 URL 正则 token=(\d{8,}) 提取，提不到回首页刷新再提，仍无=报 login_wall 须扫码召唤（勿自动重发企微 12h 一条） (E:/AI-Station/WeAppForge/work/mp_cancel_logout/watch_category.py 17-41)
- netstat 实查：9336 LISTENING PID 21860 chrome.exe（mp 控制台专属浏览器活着）；9222 LISTENING PID 17064（WeAIPO 生产口）；9327/19825/19826 未监听 (netstat -ano | grep -E ":9327|:9336|:9222|:19825|:19826" 2026-10-08 实查)
- 虚拟支付道具配置自动化配方：直达 /wxamp/subApp/skit?token=... → 基本配置 → 道具配置 → 添加道具 → 四字段 placeholder 填值 → 普通道具/自定义 → CDP setFileInputFiles 喂图标 → 提交审核；成功后回写 data/secrets/virtual_pay.secret (E:/AI-Station/WeAppForge/work/mp_cancel_logout/vpay_item_create.py 177-230)
- 1007 实弹成功证据：unlock_once 咨询解锁-单次 ¥1 创建成功，页面回「道具已创建成功」，row_seen=true secret_written=true；页面结构含 线上版本/开发版本(沙箱)/批量发布/批量添加道具/添加道具 (E:/AI-Station/WeAppForge/work/mp_cancel_logout/_p16.log 3-10)
- 开通虚拟支付官方 6 步全量还原：功能/支付与交易→虚拟支付→同意协议→提交商户资料(独立新商户号)→审核→账户验证→扫码签约；前置=管理员微信+营业执照+对公账户三要素+小程序简称 (E:/AI-Station/_proposals/xueyuan-market/KNOWLEDGE_BASE/virtual_pay.md 15-31)
- wxfdb55b184756e89e=总包学园（虚拟支付未开通，WIZARD 向导在册）；wx5cee1574ce45819b=总包AI顾问 biaoxun（已开通 offer_id=1450664233） (E:/AI-Station/_proposals/xueyuan-market/WIZARD_VIRTUAL_PAY.md 1, 56)
- 0929 wxfdb 体验版操作=用户手点控制台「版本管理→开发版本→0.3.0→选为体验版」（#39/#49），agent 侧只做上传与码池；选为体验版按钮定位须按版本号文本锚定 .code_version_log 块防误点 (E:/AI-Station/_proposals/xueyuan-market/RUN_LEDGER.md 194, 227-231)
- 扫码召唤实现件=qr_send.py：强制重开 mp 根页拿新码→截 scanloginqrcode 图→base64+md5→企微 webhook 图片直发→用户手机长按识别，登录落在 9336 专属浏览器 (E:/AI-Station/WeAppForge/work/mp_cancel_logout/qr_send.py 32-65)
- 控制台 Vue 动态页操作铁律全册（翻译扩展 span 包裹/checkbox 不连点/每步回读 DOM/审核状态 API 死路 errcode 86000）沉淀在 skill 参考件 (E:/AI-Station/.claude/skills/weapp-launch-factory/references/mp-console-automation.md 1-194)
- 9327=微信支付商户注册向导 Edge CDP 直驱器（websocket 直连，零依赖 MCP），因 9222 被 WeAIPO 生产占用而设冷门口，当前未跑 (E:/AI-Station/tools/wxpay_edge_cdp.py 1-25)
- 类目盯哨 OS 级腿=schtasks QianwenCatWatch 每 3h 跑 watch_category_api.py（API 版零登录免扫码：appsecret 换 access_token 查 /wxa/get_category），GREEN 才企微通知且只发翻转一次 (E:/AI-Station/WeAppForge/work/mp_cancel_logout/watch_category_task.py 1-33)
- 改云托管环境变量唯一活口=manager-node 直调（tcb run service:config 3.8.5 结构性死路勿再试）；virtual_pay.secret 经 SECRET_FILES_B64 JSON map 注入，qw_tcb_prep.py 全链在役 (E:/AI-Station/services/qianwen-engine/TCB_DEPLOY.md 109-143)
- submit_audit_api.py 内 assert appid==wx5cee1574ce45819b，submit_audit API 优先控制台兜底；审核状态查询 get_latest_auditstatus 仅第三方平台可调（自管理回 86000） (E:/AI-Station/WeAppForge/work/mp_cancel_logout/submit_audit_api.py 1-60)

## Risks
- 9222 口是 WeAIPO 视频号发布腿生产占用（pythonw actively 驱动），任何控制台自动化绝不可借用该口——须继续走 9336 专属口
- 9336 会话的登录态是会话级 token：管理员重登后一切硬编码 token 即陈旧；所有脚本必须走 live_token() 活提，报 login_wall 时按扫码召唤协议企微叫人（12h 限频不重试）
- 虚拟支付 6 步中的商户资料提交/打款验证/扫码签约含不可自动化的人工位（对公打款是银行外部流程），照抄 wx5cee 模式=用户点完开通、agent 接管道具与服务端，勿试图全自动闯资质页
- 控制台是 Vue 动态页：翻译扩展 span 包裹、checkbox 连点白点、隐藏弹窗预渲染三坑已在 mp-console-automation.md 立铁律，绕过会误点危险按钮（选为体验版曾误点 0.4.2 弹危险切换框）
- curl_cffi 对 api.weixin.qq.com TLS 必断（SSL_ERROR_SYSCALL），API 腿一律用普通 requests；get_latest_auditstatus 对自管理小程序回 86000 是死路勿再写监视器
- 道具价格单位分/元与 iOS 双端分价规则部分为二手信源（cred 0.5-0.8），开通后须后台实测确认

## Open Questions
- 9336 专属浏览器当前登录的是 wx5cee 还是已切到其他号？须实查活标签 URL/账号名才能定（本次只读侦察未驱动浏览器）
- wxfdb 虚拟支付 6 步开通由谁执行：用户自己按 WIZARD_VIRTUAL_PAY.md 点（0928 设计初衷），还是授权 agent 用 9336 通道代点？涉及商户资质提交与打款验证，建议先向用户确认授权边界
- export_once 道具（1008 建）当前「未发布」停在开发版本沙箱——发布现网一步是否已走、由谁走，未在本次范围内核实
- vpay 控制台页是否存在「接入指引」页可查开通状态（wxfdb 可先探此页判类目/主体是否达标，避免白走 6 步）——vpay_probe 系列未覆盖该 tab，须实弹探一次
