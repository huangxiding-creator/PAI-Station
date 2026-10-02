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

### v0.5.1 页面不存在根治 + 智谱免费链（0929 深夜）

| # | 时间 | 动作 | 实测结果 | 下一步 |
|---|---|---|---|---|
| 51 | 23:1x | **根因诊断（教训级）**：无路径入口（后台体验码/最近使用/会话卡）按线上 1.0.7 老页面表解析默认页 home/home → 新包无此页 =「页面不存在」；0.2.7 时代 ask 居首仍翻车即此机制实证 | 包级根治：pages/home/home 兼容跳板页（落地即 reLaunch 咨询首页 + switchTab 兜底 + 蓝图闪屏）+ app.json 五页（home 殿后，入口仍 ask） | 提审发布=终局解（等用户令） |
| 52 | 23:1x | **智谱免费链**（用户令：key 在超级AI工作站）：qianwen_engine/zhipu.py（PAI zhipu_client 契约精简移植：429 冷却 120s 切模型/1113 余额耗尽摘链/1301 内容审核立即失败/直连 opener/多账号免费池）；app.py optimize 智谱主链+KB 回落；zhipu.secret 双 key 落 data/secrets（红线：不进 git 不全显） | tests 28/28 PASS（fixture 默认禁 zhipu 全离线+智谱成功/502退次/空退次三腿） | — |
| 53 | 23:2x | 备份（用户令「做好备份」）：文件系统 work/backups/zongbao-ai_v0.5.0_20260929_2328 + git 定向提交 2ca933a（65 文件：小程序全包+引擎全包+work 关键脚本） | BACKUP_OK 33 文件；BOOT-SIM 109/109（五页+home 四查+防线沿用） | — |
| 54 | 23:2x | 上传 0.5.1 robot5 + 出码 qr_trial_v051 + qr_dev_v051 + 桥推企微×2 + 桌面弹码×2 | UPLOAD_OK 71151B；TRIAL_HEALTH CHANNEL_OK；QR 双 OK | 用户后台重钉体验版 0.5.1（最后一次：home/home 在包，老表解析不再404） |
| 55 | 23:2x | ECS 增量部署智谱链（zhipu.py/config.py/app.py 分片上传+zhipu.secret chmod600）+ 重启 + 生产 smoke | 4 文件落位；service=active/local_probe=401；**optimize 真智谱改写 2.0s/143字/递进小问结构**，LEFT=9 计次正确 | — |
| 56 | 23:3x | 锅圈补种 5 问（pot_seed.py 幂等续种，预算 15 点） | **pot_items=20/20 全量**（seeded=5 skipped=15 failed=0，27/16/22/22s/问，预算 15/15 恰好用尽） | — |

### v0.6.0 100× 颠覆式弧线：免费追问·要点速览·相关问题·分享海报（0930）

| # | 时间 | 动作 | 实测结果 | 下一步 |
|---|---|---|---|---|
| 57 | 00:xx | **提案链收官（super-skill 最新版全步）**：五腿调研（github-render/web-ux/web-competitors/github-chat/idea-seed）→ RESEARCH_DOCKET×4 → DIGEST（市场空白实证：工程垂直AI问答小程序无竞品；F1-F5 决策表；10 技法排序；排除清单 towxml/Vant/lottie/AI警示标签/GPL）→ GAP_REPORT（G1-G12）→ PROPOSAL 定稿 → SCORECARD 0.818 proceed | 五腿全绿；核心判断=「贵的答案只买一次，便宜的解释无限次」两级产品架构（工程大脑付费 KB + 智库助手免费智谱接地） | W2/W3 登记（订阅消息/语义缓存/流式/深色） |
| 58 | 00:xx | **引擎 v0.6.0 四端点**：followups 表+posters 表+answers.tldr/related 列；POST /followup（2-200字·双限额 每答案10/全局20·北京0点重置·后台线程智谱接地·503 兜底无KB回落=免费铁律）；GET /followups（本人线程）；GET /digest（tldr3×60字+related3×40字·一次生成永久缓存）；GET /poster（Pillow 750×1334 蓝图纸风·真 wxacode.getUnlimited scene=s=p&a={aid} env_version=trial check_path=false·BLOB 缓存）；wechat.py access_token+wxacode 通道 | tests **38/38**（10 新测：流/校验/双限额/智谱错/POT答案/digest缓存/坏JSON重试/海报流/QR失败兜底/字体缺503）；坑两枚入库=**.format() 花括号坑**（prompt 内 JSON 必须 {{}} 转义）+ GBK ✓ 字符坑 | — |
| 59 | 00:xx | **客户端 F1-F5**：answer 页=要点速览卡(编号3条)/追问对话流(气泡+呼吸点+错误态+输入行+剩余次数)/相关问题chips(点按 qw_prefill 预填 ask)/生成海报(showShareImageMenu 双病毒环 entrancePath+印刷码·previewImage 兜底)/等待打勾 ✓；ask 页 onShow prefill 线；六小按钮排 | BOOT-SIM **126/126**（14 新查：WXML 零方法调用绑定/预填线/四端点/entrancePath 显式页/优雅降级全查） | — |
| 60 | 00:xx | ECS 增量部署 v0.6.0（5 文件分片 12K b64：store/config/app/wechat/poster.py 共 64KB）+ py_compile 全量 + 重启 + 生产 smoke 三腿 | service=active/probe=401；**smoke 全绿：digest 2.3s（tldr=3 质量佳「限额设计优化收益归承包人」）/followup 2.4s 129字接地结论先行/poster 2.3s 218987B 真码+POSTER-CACHED 秒回同 b64** | — |
| 61 | 00:1x | 上传 0.6.0 robot6 + 出码 qr_trial_v060 + qr_dev_v060 + 桥推双码 + 桌面弹码×2 | UPLOAD_OK 81907B；TRIAL_HEALTH CHANNEL_OK；QR 双 OK（98803B/99133B）；spool 双落位（坑：python subprocess 弹窗阻塞→拆 bash 直弹即通） | 用户后台重钉体验版 0.6.0；提审仍等用户令（POSTER_QR_ENV_VERSION 一行切 release） |

### 0930 体验版「页面不存在」复发→数据闭环→真机确认

| # | 时间 | 动作 | 实测结果 | 下一步 |
|---|---|---|---|---|
| 62 | 07:5x | **复发诊断（数据钉死非理论）**：check_path=true 探针逐页枚举线上 1.0.7 老表=**恰好 {home/home, my/my}**（ask/pot/index 全 41030）；robot 台账核实 5 版本 5 机器人零顶替。根因=用户钉位一直停在 0.4.2（该版**无** home 页，home 是 0.5.1 才加）+ 无路径入口按老表解析 home → 老包无此页 → 404。v0.5.1 时代的 home/home 根治从未被真机验证（当时直接跳 0.6.0），本次=该机制的首次实证闭环 | 机制与全部观测一致（0929 18:43 扫显式ask码成功=钉位包有ask；后来404=无路径入口解析home包里没有） | — |
| 63 | 07:5x | 用户重钉 0.6.0（含 home/my 双覆盖）+ **永不404码** qr_trial_v060b_home（page=home/home：新老包双环境都在表，任何解析必命中，落地 reLaunch 咨询首页）桥推+桌面弹码；雷达基线 users=3/answers=27/followups=1 后台守望 | **用户确认「可以正常看到了」——v0.6.0 体验版真机闭环** | 提审发布=整类问题终局解（等用户令） |
| 64 | 07:5x | 环境事实入库：引擎雷达真 DB=**/opt/qianwen/data/qianwen/db.sqlite**（qianwen.db 是空壳诱饵）；users 表无 last_seen 列（活性判据=计数对比非时间戳）；微信开发者工具本机 CLI 损坏（User Data .cli 握手文件 ENOENT，exit 9）——包编译健康走 CI 上传全量构建背书即可，IDE 非必需 | — | IDE 修复挂低优先 |

### 0930 域名换轨 gcbrain.top + ICP 备案攻坚（提审最后一块砖）

| # | 时间 | 动作 | 实测结果 | 下一步 |
|---|---|---|---|---|
| 65 | 1x:xx | **域名换轨**：用户弃 epcschool.top（腾讯备案接入≠阿里云，80口被跨商墙 403 Non-compliance 实证）→ 阿里云新注册 **gcbrain.top**；ECS 换 vhost（api-epcschool.conf→api-gcbrain.conf 80段预置301+ACME路径）；LE 旧证书删除；config.js BASE_URL→https://api.gcbrain.top；epcschool 产物清理 | dig 223.5.5.5→47.120.43.20 ✓（域名实名通过）；node --check ✓；BOOT-SIM **158/158**；本机 Host 头探针：epcschool 仍 403 拦 / api.gcbrain 301 我方 nginx（未拦） | — |
| 66 | 1x:xx | **备案路径裁决**：公开库+DNS 实证 **dify.gcblog.net 解析 96.8.116.122（美国）非本 ECS** → gcblog.net 无备案快车道（海外托管不需备案）→ **gcbrain.top 正规 ICP 备案是唯一路径**；备案无 OpenAPI（aliyun beian 不存在）→ 用户令走 DrissionPage 浏览器自动化 + 交账密（入 data/secrets/aliyun_console.secret） | WebFetch beianx/chinaz 均拿不到库数据；timeline 评估：今日提交→国庆假期管局停审→节后初审+管局→**通过≈10月中下旬** | — |
| 67 | 1x:xx | **备案审核期关站**：api.gcbrain.conf 80段 301→**444 连接即断**（未开站合规态；ACME 路径保留），nginx -t+reload；变更登记 network_changelog.jsonl | ECS 本机探针 **local80=000** ✓（此前侦察确认 default.conf 是 Dify 兜底 vhost——必须保留 gcbrain 专属 server_name 块，否则命中 Dify 页面反成"已开站"） | 备案通过后 ecs_gcbrain_ignite.py 点火 443 并恢复 301 |
| 68 | 1x:xx | **DrissionPage 登录攻坚**：Chrome 独立 profile（data/state/aliyun_beian_profile）+调试口 9335（避 9222 微信devtools）；登录页侦察=账号 fm-login-id/密码 fm-login-password/图片验证码 fm-login-checkcode；**验证码视觉认码两次通过（DWV6）但服务器两次返回「密码错误」**——字段值 JS 校验 acct_ok=True/pwd_len=10/10 无误 → 判定阿里云防自动化拦截（密码正确也报密码错误） | 账号 pyeye@126.com 存在（无「账号不存在」）；两次拒绝未触发锁号 | **用户接管手输密码**（浏览器保持打开）+后台监视器 bo2v79dtk 盯 URL 离开登录页即自动侦察主体页 entityId=9452842 |
| 69 | 12:2x | **步3五连修+提交成功**：①网站语言中文简体（首验"选中"实为下拉浮层假象）②去误选综合门户chip③云产品实例选 i-f8za6qhv365cwhti5y35④验证码040273⑤名称三改定稿=用户令「黄细丁的工程笔记」——**教训级根因：备注文本灌进名称字段致硬卡提交**（`tag:textarea` 首匹配=隐藏JSON槽，备注真身=placeholder「请根据实际情况填写备注内容」；名称含长文标点必触发驳回风险error元素） | 修后「完成填写」→ **ADVANCED orderInfoList**（订单2032850488548步3收官；确认页内嵌"新增第二网站"空表单=正常形态） | 用户接管改名称+上传图片资料（浏览器保持打开+只读监视器 bu1y3zhxj） |
| 70 | 12:4x | **证书预签实证=边缘拦截**：certbot HTTP-01 预签 403 unauthorized（LE 视角）——**未备案域名在大陆 ECS 的 80 口被阿里云边缘层直接截胡403**（容器内 Host 探针 404=我们的 nginx 没轮到执行）；webroot 挂载已验对齐（certbot/www→/var/www/html） | 结论：证书只能备案通过后签（ecs_gcbrain_ignite.py 预判此形态成立）；DNS-01 预签记为 fallback 未启用 | 备案通过当天跑 ignite（自动 DNS 校验→证书→443→公网200） |
| 71 | 13:0x | **引擎 v0.7.0 上云**：tar 分片(37.5KB→4片)→py_compile→restart→**46/46 测试**（含修复 test_poster_env_cache_separation）+产线冒烟6腿：pot/list、**answer 免费直读 1350 字（付费墙拆除生效）**、quota 6/6、digest 1.6s、citation_ft 4.5s(v0.7.0 新·智谱接地)、poster 219KB trial 重建+缓存命中同图 | **根因修复：POSTER_QR_ENV_VERSION 本机+线上均误置 release**（正式版未发布前置 release=海报码开出旧 1.0.7）→ 双双回 trial，测试改方向无关断言 | 发布当日一行切 release+重启即生效（缓存按 env 隔离自动失效重生成） |
| 72 | 13:2x | **0.7.1 域名版上包（提审候选）**：发现 0.7.0(robot7 0930 01:38) 系域名换轨**前**所传（BASE_URL 仍 IP）→ bump 0.7.1+三处版本标记联动（package.json/my页脚/bootsim 断言）→ BOOT-SIM **158/158** → robot8 上传 89878B | UPLOAD_OK；TRIAL_HEALTH CHANNEL_OK（轮转机制钉位零损） | 提审链机器侧全就绪，唯等备案：点火→控制台加域名→提审0.7.1→发布→切 release |

### 1001 v0.7.3 用户十一点令：周换装主题+计数+授勋动画+复制下线+锅圈百条（0929 域名 api.yrecepc.cn 在役）

| # | 时间 | 动作 | 实测结果 | 下一步 |
|---|---|---|---|---|
| 73 | 1x:xx | **引擎 v0.7.3**：导出撤奖（REWARD_ACTIONS=like/share/criticize 三动作，export 抛 ValueError）；answers 增 views/shares 列+原子 bump（GET answer 即 views+1；/share+/poster 即 shares+1）；隐私门收紧（get_answer_visible 非本人且非锅圈=404）；智谱 deep_answer 长文链+pot_seed_zhipu 播种机（幂等/质量门350字/无套话/结构标记/GAP 3s/pending 让路）；tests **47/47** | 全绿（含 export 不赠次+隐私门新测） | — |
| 74 | 1x:xx | **周换装主题系统**：gen_themes.py HSL 派生 7×52 token（navy 像素校准 Δ≤2/通道；paperInk 族四 token 补齐）→ utils/theme.js（getDay 周映射 周日石墨…周六熔炉；theme_pref 锁定；导航栏染色）→ page-meta page-style 六页注入+tab-bar 根内联；~130 处字面量→CSS 变量（3 agent 并行+2 python 批+answer/my 手转） | BOOT-SIM **205/205**；模拟器像素级复核：周四=暮山紫电 navy1 #1a0936/paper #f2edf8 与调色板逐位一致；my 页点熔炉信号→themeKey/存储/✓ 全切+**tab-bar 同步换装**（#31160e）；跟随星期恢复 violet | — |
| 75 | 1x:xx | **交互三件**：观看/转发 chips（answer a-meta+pot 列表 meta 行）；授勋动画 rw-*（径向幕+旋转虚线光环+渐变奖章+1+八向火花+heavy 震动+2.4s 自动收，onUnload 清定时器）；外观画廊（ap-grid 8 格实色样卡+跟随星期格） | 模拟器 DOM 全数在位；动画 pinned 像素复核=全屏幕+奖章盘+文字（v4 截图 ASCII 判读）；全 session **0 异常 0 警告** | — |
| 76 | 13:3x | **ECS 部署 v0.7.3**（ecs_deploy_v073.py：tar 46.6KB→5 片→py_compile→restart→health=200；backup_v072 留底）| 坑：**views/shares 迁移未随重启生效**——store.init() 懒触发（首 DB 请求才跑）且 health 不触 DB；直跑 `store.init()` 后 PRAGMA 确认双列落位 | 懒 init 改启动 eager 挂低优先（现行=每次请求路径首触即幂等补列，无实害） |
| 77 | 13:3x | **锅圈播种 100 条**：ECS nohup pot_seed_zhipu.py pot_questions_v2.json（80 题智谱免费链：600-900 字专家长文/EPC 热点=计价调价·变更索赔·结算审计·招投标合规·新能源争议） | 进度 20→26/100（约 2.2 分/条，预计傍晚收满 100） | 收满后抽查质量+锅圈前端复核 |
| 78 | 13:4x | **上包+出码**：0.7.3 robot10 上传 119443B（UPLOAD_OK/TRIAL_HEALTH CHANNEL_OK）；qr_trial_v073+qr_dev_v073 双码（page=home/home 永不404配方 check_path=false） | 桥仍死（0930 14:06 起 ret:-2 待用户扫码复活）→ 桌面弹码投递 | 用户真机验收→（0.7.1 审核单先撤）→提审 0.7.3→发布后 POSTER_QR_ENV_VERSION 切 release |

### 1002 v0.7.4 拒审根因→0.7.6 合规终版提审成功（AI标识/分享激励/隐私措辞三线收官）

| # | 时间 | 动作 | 实测结果 | 下一步 |
|---|---|---|---|---|
| 79 | 09:0x | **0.7.4 拒审根因**：《关于"人工智能生成合成内容需增加显著标识"公告》——AI生成内容缺显著标识。拒审详情页 audit_id=599847676 失败原因1 实锤 | 0.7.5 起补 12 处标识：ask首屏/answer页首+正文尾+追问尾/pot页首+列表尾/隐私弹窗/用户协议/home跳板 + 服务端 poster.py:211+231 海报图上双标识 | — |
| 80 | 09:3x | **双 agent 全面审查**（静态代码+合规两路并行）：CRITICAL 0；HIGH-1=诱导分享（运营规范3.2.1 分享+1次利益激励）；A1=剪贴板隐私声明（运行时实证：wx.getPrivacySetting 契约《总包AI顾问小程序隐私保护指引》live+setClipboardData 通过=已声明） | 两 agent 收敛同一结论，全部修复进 0.7.6 | — |
| 81 | 09:5x | **v0.7.6 合规终版**：分享激励下线（open-type=share 纯分享，赠次留有用/纠错/共享入锅圈三真实互动）；隐私协议措辞对齐静默登录（openid 凭证收集明示）；导出空 b64 防护；请求超时 300s→120s；文案清理 | BOOT-SIM **241/241**；编译 0错0警；robot 上传 124008B（09:57:33 总包君）；用户钉体验版 0.7.6 | — |
| 82 | 10:0x | **提审前三线终验**（用户令：功能+提审填写都确认才提交）：①API 面 root/pot/quota 401 fail-closed 在役；②模拟器六页巡检 ask/pot/zhiku/my/legal/answer 全 0 错误+额度链 login→token→quota 200（4/6）+答案页 14 blocks 渲染；③表单六项核对（版本描述 187/200 旧文案→重写 184/200 含 AI标识+分享激励下线说明；测试账号=无需登录✓；企业微信=否✓；隐私指引=采集用户隐私✓；订单path空✓；不加急✓） | 全绿 | — |
| 83 | 10:12 | **提审成功**：三步向导（须知勾选→安全测试继续提交→主表单）全过，页面回「已提交审核」；版本页终验=审核版本 0.7.6 · 审核中 · 2026-10-02 10:12:15 总包君 | 预计 1-7 天出结果 | 审核通过+发布后 POSTER_QR_ENV_VERSION trial→release（config.py:79 + ECS + CloudBase）|
