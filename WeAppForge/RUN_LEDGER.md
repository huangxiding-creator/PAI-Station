# RUN_LEDGER — WeAppForge（P0 地基 + P1 试点执行台账）

> C10 运行台账胜过文档。提案台账见 `_proposals/weapp-forge/RUN_LEDGER.md`（840 证据/评分/批准门）。

## 2026-09-27 P1 试点首夜（用户令：开工）

| # | 时间 | 动作 | 实测结果 | 下一步 |
|---|---|---|---|---|
| 10 | 22:40 | 内容源定位：EngOpp-Mining/reports 97 件成品，**总包创研院品牌研报**（江苏/新疆水网商机研究 docx + 各市水利局）——「总包学园」粮仓确认 | 江苏最新版 1788892913 选为试点首篇 | 更多篇目上架 |
| 11 | 22:45 | `projects/zongbao/` 全脚手架：四页（书架/阅读器/AI/我的）+ tabBar + 配置中心（featureFlags: virtualPay/cloud/voiceInput 三开关，开通即翻转零改码）+ 数据层三件（store/pay/ai 优雅降级） | 就位 | — |
| 12 | 22:50 | `pipeline/content_pipeline.py`：docx→(mammoth)→h1切章→**噪声章过滤**（封面/目录/短章剔除）→chapters.json（**试读章带正文/付费章空壳防包内泄漏**）+ 双 PDF（Edge headless，CREATE_NO_WINDOW） | 首跑选错试读章（封面+目录）→ 加 drop_junk_chapters 修复；**19 实质章，试读=第一章+第二章 6816 字符**；full.pdf 50MB（图片重，云端交付前须压缩——已记） | PDF 压缩腿 |
| 13 | 22:57 | forge v0.2.0：类型门两次拦截（InputEvent 类型名/虚拟支付真协议要求 **paySig+signature 服务端签名**——云函数签名腿的实锤情报）→ 修后三腿全绿 | **v0.2.0 上后台，总 27.3s**（L3 4.2s+L4 11.5s+L5 11.6s），体验码已刷新 | — |
| 14 | 23:05 | L6 首件：tests/zongbao-utils.test.mjs（node:test 零依赖；wx 全局桩） | **4/4 PASS**（目录装载/试读数/权益幂等/支付降级）；Windows 坑=require 不吃 file:// 字符串须原生路径 | simulate 组件级（明日） |

## P1 待用户人工位（一次性清单）

1. 后台验收 v0.2.0（版本管理→开发版本，扫码可开）
2. 虚拟支付开通（后台→功能→虚拟支付；主体档位确认）→ 我翻 virtualPay 开关+云函数签名腿（paySig/signature）
3. 云开发环境开通（免费额度够试点；环境 ID 给我）→ AI 对话+PDF 云存储+发货云函数
4. 同声传译插件申请（后台→设置→第三方设置→插件管理，wx069ba97219f66d99）→ 语音输入
5. 类目确认（当前类目是？个人/企业主体决定虚拟支付档位）

## 2026-09-27 P0 装机夜

| # | 时间 | 动作 | 实测结果 | 下一步 |
|---|---|---|---|---|
| 1 | 21:47 | DevTools 下载攻坚：servicewechat 302 无 Location（JS 挑战头轮换，curl 不可破）→ webReader 穿透页拿版本号 → **Chrome MCP 新标签页**拿按钮真 href | **Stable 2.02.2608070 直链**（devtools.wxqcloud.qq.com.cn/release/be1ec64.../wechat_devtools_2.02.2608070_win32_x64.exe），182MB sha1 90641f77 完整 | — |
| 2 | 21:50 | NSIS 静默安装（`/S /D=E:\WeChatDevTools`，不弹窗铁律） | 安装成功，**cli.bat 在位**，`cli -v` 吐 V2 命令树=活性 PASS | — |
| 3 | 21:52 | npm 工具链：首轮 2 版本号拍脑袋翻车（C14 教训）→ `npm view` 实查后重装 | **1164 包 38s**：miniprogram-ci 2.1.31 / simulate 1.6.2 / automator 0.12.1 / @weapp-vite/automator **1.2.22**（兜底件存在，研究结论修正：非 0.0.x）/ api-typings 5.2.3 | — |
| 4 | 21:55 | 修 2 坑：config ROOT 差一层；packNpm 是**位置参数** `ci.packNpm(project, opts)` 非 `{project:}`（README 实证） | — | — |
| 5 | 21:56 | **L3 构建腿实弹**：hello 模板→work/ →tsc 类型门→packNpm | **全绿**：tsc PASS；packNpm 617ms，2 包（@vant/weapp+mp-html），0 警告；miniprogram_npm/ 实证在位 | L4/L5 等密钥 |
| 6 | 22:00 | 全链仪表 `pipeline/forge.mjs`（L3→L4→L5 逐腿计时落盘 data/reports/）+ secrets 样例 + **WIZARD.md（用户 5 步向导）** | 就位 | 等用户走完向导 |
| 7 | 22:25 | 用户直接交凭证（跳过向导）：小程序「总包学园」AppID wxfdb55b184756e89e + 上传密钥（E:\AI-Station\微信小程序\ 目录，另有第二个小程序 wxd096fc… 旧密钥在册）；密钥 copy 入红线区 + weappforge.json 落位 | key 1679B 验证通过 | 跑首航 |
| 8 | 22:29-22:31 | 首航三连修：①Node25 localStorage 探针炸 → `--no-experimental-webstorage` 焊进 spawn+scripts ②ci 不做 TS 转译 → tsc 从 --noEmit 改真 emit ③packNpm 位置参数（前次已修） | 修一跑一，逐个实证 | 三火全绿 |
| 9 | 22:31 | **🚀 全链首航成功：L3 构建 5.8s + L4 上传 13.3s + L5 体验码 → 总 31.8s**，v0.0.1「WeAppForge 首航」已上「总包学园」后台，二维码 data/preview-qr.png (470×470) | **onboarding_time 机器段基线=31.8s**（4h 主张的仪表就位，人工触点=0） | P1 试点 |

## 装机清单状态

- [x] DevTools 2.02.2608070（Electron 底座）@ E:\WeChatDevTools，CLI V2 活
- [x] 工厂工具链 5 件（npm，全部真实版本验证）
- [x] hello 模板（原生 TS + @vant/weapp + mp-html）+ L3 构建 PASS
- [x] forge.mjs 全链计时仪表 + WIZARD.md
- [x] **AppID + 上传密钥已接入（用户直交，IP 白名单未配也通过=未启用强校验）**
- [x] **v0.0.1 已上用户后台 + 体验版二维码产出 —— P0 验收判据达成**
- [ ] automator/L5 真机自动回归腿（需 DevTools 服务端口开启+登录态，P1）
- [ ] simulate/L6 单测腿（hello 无自定义组件，P1 试点补）

## 关键配方（复用价值）

- DevTools 直链获取：servicewechat.com 下载端点有 JS 挑战（SKFrmwRespCookie 轮换，curl 不可破）→ 用 Chrome MCP 开**新标签页**导航官方下载页 → 捕获 HTML 里 grep `devtools.wxqcloud.qq.com.cn`（旧 dldir1 路径仅 1.x）
- 2.x 安装包 URL 形态：`https://devtools.wxqcloud.qq.com.cn/WechatWebDev/release/<hash>/wechat_devtools_<ver>_win32_x64.exe`
- NSIS 静默装：`exe /S /D=<盘符路径>`（/D 最后、无引号）；后台任务 cwd 会漂移，exe 用绝对路径
- vant 正名：`vant-weapp`=2019 旧包（止 0.5.29），1.x 线真名 `@vant/weapp`（1.11.7）
- miniprogram-ci packNpm 签名：位置参数；`new ci.Project` 构造器强制 privateKeyPath 非空（本地 packNpm 用占位文件即可）

## 2026-09-28 biaoxun v0.2.0 顶级版（用户令：自行测试优化+美观流畅）

| # | 时间 | 动作 | 实测结果 | 下一步 |
|---|---|---|---|---|
| 20 | 12:00 | 根因修复：`ask.wxml {{!question.trim()}}`（WXML 绑定禁方法调用=提问按钮死锁根因）→ canAsk 全部 JS 侧计算 | wxml_lint 闸门 PASS（首战即擒此缺陷类型） | 闸门常驻 |
| 21 | 12:05 | 客户端 12 文件重写：api.js 401 静默重登+quota 端点/ask 页配额卡+样例chips/answer 页骨架屏+重试+点赞/纠错/复制/分享+锁定态重设计(全文字数预告,无预览重复)/my 页配额常显+时间格式化+空态CTA/app.wxss 设计系统/tabBar PIL 图标×4 | harness 三场景 **26 断言全 PASS** | — |
| 22 | 12:11 | `forge deliver biaoxun 0.2.0` | 上传 6.2s PASS + 体验码二维码已推企微(errcode 0) | 用户扫码验收 |
| 23 | — | **四坑修复**：①引擎 ask() except 缩进错位（aid/return 被吞进 except 体→正常路径返回 None=200 null）②forge.mjs `'..'+projectPath` 缺分隔符→编译子进程 cwd 落空→spawn ENOENT ③WeAppForge package.json type:module 感染项目 .js→biaoxun 落 `{"type":"commonjs"}` 就近覆盖 ④QW_FAKE_ASK KbAnswer 缺 question/cid/url 必填 | 全修+py_compile+harness 复验 | — |

生产引擎 8869 在役（无测试闸；假 code 实测被微信 40029 拒=appid/appsecret 对联通）。改动未提交 git（等用户令，推必带百度备份）。

### v0.2.1 真机点击根因修复（用户报"点击提问，没有运行"）

| # | 时间 | 动作 | 实测结果 | 下一步 |
|---|---|---|---|---|
| 24 | 13:20 | 根因：ask 页 tabBar 页用 `position:fixed bottom:0` → **原生 tabBar 盖住按钮吃掉点击**；且网络失败提示=一闪而过 toast=用户眼中"没反应" | 改常规文档流+红卡常驻+失败弹窗化 | — |
| 25 | 13:25 | config.js 加 `global.__QW_BASE__` 覆盖口 → harness 指 8870 带闸实例（生产 8869 不停机） | harness 26 断言复验 PASS | 常驻双实例形态 |
| 26 | 13:28 | 新增 `work/binding_audit.cjs`（13 绑定全在+tab页禁fixed+图标存在）+ **真 KB 冒烟**（生产 metaso 链路首次实证） | 审计 PASS；KB 11.1s/898字/6引用 | — |
| 27 | 13:30 | `forge deliver biaoxun 0.2.1` | 上传 9.6s PASS+体验码已推企微；DevTools 已最小化启动等扫码（IDE登录+服务端口=两人工位） | 用户真机复验 |

### v0.2.2 全过程透明化 + 网络排查（用户报"检索中很久/提问网络问题"）

| # | 时间 | 动作 | 实测结果 | 下一步 |
|---|---|---|---|---|
| 28 | 14:00 | 根因排查：DB 无真实 openid 行=手机请求从未到达引擎；防火墙全开+入站默认 Block+本机读规则也要管理员（"无python规则"结论不可靠）；WLAN=有线网；UAC 放行被用户取消 | 待观测日志定论 | 用户重试时看 access log |
| 29 | 14:20 | **异步流水线**：POST /api/ask 秒回 {id,status:pending}，KB 后台线程跑；GET /api/answer 带 progress 事件流（提交/送达/检索轮次+字数）；失败自动退次(refund_one)；store 四态(pending/ready/error/退次)+老库 ALTER 平滑升级；metaso_kb on_event 钩子 | harness 26 断言全 PASS（异步收敛）；真 KB 实弹 15.9s/756字/6引用 | — |
| 30 | 14:35 | `forge deliver biaoxun 0.2.2`（客户端：秒跳答案页+进度时间线+秒表+生成中徽章+失败退次卡） | 上传 6.4s PASS+体验码推企微 | 用户扫码+网络放行 |
| 31 | — | 双实例形态：生产 8869(info 日志观测)+带闸 8870(harness 专用，global.__QW_BASE__ 覆盖口) | 互不干扰常驻 | — |

### v0.2.3 上云（用户令"上云"——根治手机网络不可达）

| # | 时间 | 动作 | 实测结果 | 下一步 |
|---|---|---|---|---|
| 32 | 14:43 | ECS 部署（通道=云助手 RunCommand，SSH 22 不对公网）：qw_engine.tgz 分片 b64 上传(4片×16000)→解包 /opt/qianwen/services/qianwen-engine/→3 密钥落 data/secrets/→venv+fastapi/uvicorn/curl_cffi(阿里云镜像) | 解包/密钥/依赖全 OK；**坑=Ubuntu24 缺 python3-venv 须先 apt 装** | — |
| 33 | 14:46 | systemd 常驻 qianwen-engine.service（Restart=always，开机自启）| active+enabled，本机探针 401 | — |
| 34 | 14:48 | **双层防火墙放行**：ECS ufw（发现第二层墙！active+deny incoming）allow 8869 + 阿里云 SG AuthorizeSecurityGroup 8869/0.0.0.0/0 | 公网探针 **401 / 106ms**（PC 外网实测） | — |
| 35 | 14:50 | 云端双冒烟：①假 code 登录→微信 40029（appid/secret 云端链路通）②**真实 KB 单问**（metaso 会话跨 IP 验证=上云最后未知数）| ①40029 如预期 ②**1044字/4引用/16.3s 全通**——cookie 不绑家宽 IP | — |
| 36 | 14:55 | 客户端 BASE_URL→http://47.120.43.20:8869 + v0.2.3 deliver（harness 26 断言+绑定审计+lint 闸全绿后） | 上传 PASS+体验码推企微；**坑=forge 须从 WeAppForge 根目录跑（work/ 下跑致 work/work/ 双层路径 ENOENT）** | 用户手机任意网络复验 |

云端形态：`http://47.120.43.20:8869`（systemd 常驻，日志 `journalctl -u qianwen-engine`）。本地 8869 暂留作回退（用户验收后可停）。HTTPS 域名+合法域名仍为 P1（正式发布版强制）。

### v0.2.4 排版革命 + 改名总包千问（用户报"回答页裸 Markdown 符号/不美观"→"顶级排版"）

| # | 时间 | 动作 | 实测结果 | 下一步 |
|---|---|---|---|---|
| 37 | 15:1x | `utils/md2blocks.js` 零依赖 Markdown 渲染器：标题/加粗/斜体/行内代码/链接/引用/无序有序列表/表格/代码块/分隔线；`<br>`→硬分段、实体解码、中文软换行拼段、预览截断容错（围栏不闭合/表格缺行不炸） | 单测 10/10 PASS（tests/md2blocks.test.mjs） | — |
| 38 | 15:2x | 答案页重写：块级 WXML 模板（inl template 行内段复用）+ 顶级排版 WXSS（h2 品牌竖条/暗色代码块/圆角表格/序号徽章列表/依据来源编号chip）+ 字数/依据数 meta chips + 问题卡「问」徽章 | **坑：rows[i][j] 是 segs 数组，取值须 [0].v（测试索引层级错位两轮排查）** | — |
| 39 | 15:3x | 改名总包千问：app.json/hero/我的页/分享标题/导航栏全改；api.js 网络错误文案去 WiFi 旧话术 | harness A13 升级为 blocks 断言+A13c「无裸 Markdown 符号」 | 后台名称改版=用户人工位 |
| 40 | 15:34 | `forge deliver biaoxun 0.2.4` | 上传 7.8s PASS+体验码推企微 | 用户真机复验排版 |
| 41 | — | 假答案升级为真实 Markdown 形态（h2/列表/表格/引用），8870 带闸实例重启 | harness 26 断言全 PASS | — |

### v0.2.5 虚拟支付接线（用户令「请接1元解锁虚拟支付」）

| # | 时间 | 动作 | 实测结果 | 下一步 |
|---|---|---|---|---|
| 42 | 15:4x | 引擎：login 留存 session_key（mp_session 表，仅服务端）；`POST /api/answer/{id}/pay_sign`（offerId 缺→503 优雅降级；session_key 缺→401 触发客户端静默重登；outTradeNo 字符合法化）；`unlock_paid` 幂等解锁+pay_log 对账表；wechat.virtual_pay_sign 双签名（pay_sig=appsecret 腿 `requestVirtualPayment&`，signature=session_key 腿 `VirtualPayment&`） | 签名单测 5 向量 PASS（键隔离/逐字节绑定/中文不转义） | 真机 -15005/-15006 若现按官方签名详解校前缀（一处改） |
| 43 | 15:5x | 客户端：onUnlock 真流程（paySign→wx.requestVirtualPayment→unlockPaid→重载）；503→诚实降级弹窗；-15007→静默重登重试；取消静默；老微信版本兜底 | harness 新 D 场景：D1 已解锁=409 / D2 幂等解锁=200，26 断言全 PASS。**坑：harness 里 api.js require 在 `global.__QW_BASE__` 之前→config 提前求值打到生产 ECS（40029 假象），require 顺序修正后全绿** | — |
| 44 | 15:5x | `forge deliver biaoxun 0.2.5` | 上传 6.5s PASS+体验码推企微 | — |
| 45 | 16:0x | ECS 重部署引擎 v0.2.5（tar 45.6KB→4 片云助手）；virtual_pay.secret 占位就位 | service=active / health=200 / pay_sign 公网 401@78ms。**坑：云助手回包状态字段=InvocationStatus（等 Status 必超时）** | 用户开通虚拟支付→填 offer_id/product_id→重启即生效 |

### v0.2.6 改名总包AI顾问（用户令）

| # | 时间 | 动作 | 实测结果 | 下一步 |
|---|---|---|---|---|
| 46 | 16:2x | 名称总包千问→**总包AI顾问**：app.json/hero/我的页/分享标题 9 处全换（副标语去千问千答、头像字千→问） | harness 26 断言+绑定审计全 PASS；上传 6.6s PASS+体验码推企微 | 后台「设置→基本设置→名称」同步改成总包AI顾问（用户人工位） |

### v0.5.0 用户九点令收官（0929）

| # | 时间 | 动作 | 实测结果 | 下一步 |
|---|---|---|---|---|
| 47 | 21-22时 | 引擎九点令：6次/天+四动作赠次(UNIQUE per answer·action,上不封顶)+北京0点清零+AI优化(/api/question/optimize 10次/天)+锅圈(pot_items/POT_OPENID/100字预览)+批量导出(/api/answers/export_all)+分享赠次(/api/answer/{aid}/share) | tests 27/27 PASS；ECS部署+服务重启+产线冒烟全绿 | — |
| 48 | 22-23时 | 锅圈种子：知乎/公众号20问EPC热点→工程大脑逐问作答(pot_seed.py 幂等+any_pending让路+20s间隔,预算45点≈15问) | pot_items=15/15；/api/pot/list 实测 COUNT15/preview100字/全文2562字 | 5问明日幂等补齐(预算恢复后重跑pot_seed) |
| 49 | 23时 | 前端九点令：语音全撤(voice.js删+插件声明撤)/示范性问题/AI优化提问(采用·保留原问)/免费规则文案/打破砂锅+批量导出/总包AI智库/五枚精美小按钮(pill)/分享标题=总包AI顾问-免费咨询/锅圈页(四件套+三页签tabBar) | BOOT-SIM 98/98 PASS(九点令全量+防线沿用) | — |
| 50 | 23:0x | 上传 0.5.0 robot4 + 出码 qr_dev_050 + 桥推企微+桌面弹码 | UPLOAD_OK 69462B；TRIAL_HEALTH CHANNEL_OK；QR_OK 95KB | 体验版钉位仍0.4.2：要在体验版看新版本须后台重钉0.5.0(用户控制台一步)；正式提审仍等用户令 |
