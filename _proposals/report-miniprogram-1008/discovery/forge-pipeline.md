# agent4

# WeAppForge 小程序工厂——构建/上传/发布流水线与密钥体系盘点

## 0. 总体形态（VISION/WIZARD）

`E:\AI-Station\WeAppForge\VISION.md`：2026-09-27 批准（Scorecard 0.849），愿景是「把'我想把 X 做成小程序'变成一句触发词」，七腿流水线（规格化→生成→构建→上传→调试→测试→发布）无人值守，北极星=onboarding_time ≤4h。`E:\AI-Station\WeAppForge\WIZARD.md`：仅 5 步需本人操作（注册小程序拿 AppID、生成上传密钥+IP 白名单、填 `data/secrets/weappforge.json`、DevTools 开服务端口、告知完成），之后 `node pipeline/forge.mjs` 一条命令构建→上传→出体验码。

## 1. 构建打包上传机制

**工具= miniprogram-ci（非微信开发者工具 CLI）**。`E:\AI-Station\WeAppForge\package.json`：miniprogram-ci ^2.1.31 + miniprogram-automator + miniprogram-simulate + api-typings；scripts：`build: node pipeline/build.mjs`、`upload: node --no-experimental-webstorage pipeline/upload.mjs`、`harness:xueyuan: node work/harness_xueyuan.cjs`。DevTools 2.02.2608070 虽装在 E:\WeChatDevTools，但 RUN_LEDGER #64 记录本机 IDE CLI 已损坏（exit 9），「包编译健康走 CI 上传全量构建背书即可，IDE 非必需」。

**两代交付器并存**：
- P0 首航版 `E:\AI-Station\WeAppForge\pipeline\forge.mjs`：L3（build.mjs：npm install→tsc 编译门真 emit .js→ci.packNpm）→L4（upload.mjs：ci.upload）→L5（preview.mjs 体验码），逐腿计时落盘 `data/reports/forge-*.json`。首航实测 31.8s（RUN_LEDGER #9）。
- 常用统一入口 `E:\AI-Station\WeAppForge\work\forge.mjs`：`list / lint / upload / preview / deliver` 五命令；deliver=lint（work/wxml_lint.mjs 闸门，WXML 禁方法调用绑定）→upload→preview 二维码→推企微（`E:/AI-Station/tools/send_wecom_file.py`）；多项目注册表读 `E:\AI-Station\WeAppForge\data\projects.json`。

**密钥引用（全部 private.<appid>.key 形态）**：
- 注册表 `data/projects.json` 三条目均指向 `E:/AI-Station/data/secrets/private.<appid>.key`，注释「appid与key文件名逐字符diff过的才准入」；`work/forge.mjs` 的 buildProject 用 `privateKey: key`（内容直注），`work/upload_qianwen.mjs` 用 `privateKeyPath`。
- 本地 packNpm 不用真钥：`pipeline/build.mjs` 用占位文件 `data/secrets/placeholder.key` + appid `touristappid`。
- 红线：VISION.md「密钥外置（data/secrets/ 红线区）：上传密钥/支付密钥/AI key 永不入 git、不入前端」。
- **例外**：总包说小程序 `E:\AI-Station\website\zongbaoshuo-miniprogram\tools\upload.js` 的钥在 `E:\AI-Station\微信小程序\private.wxd096fc6994ef6f48.key`（红线区外的原始下载目录）。

**IP 白名单处理**：WIZARD.md 第 2 步要求用户手工把本机公网 IP 加白；但 RUN_LEDGER 装机清单 #43 实证「IP 白名单未配也通过=未启用强校验」——上传链从未被白名单拦截。`work/audit_v073_results.json`（L129-132）另记录：若管理 API 遇 40164=控制台开了 IP 白名单，解法=把 ECS 47.120.43.20 加入或控制台直操。

**Node 兼容三连坑（已焊死）**：Node≥22/25 的 localStorage 探针炸 ci——`--no-experimental-webstorage` 焊进 scripts 与 spawn（RUN_LEDGER #8）；`work/upload_qianwen.mjs` 头部注释记「exit 0 假成功实锤」须带 `NODE_OPTIONS=--require .../localstorage-shim.cjs`；`work/forge.mjs`/`upload_xueyuan_trial.mjs` 用 `Object.defineProperty(globalThis,'localStorage',{get:()=>undefined})` 遮蔽。

## 2. 三个 appid 的发布链路与 robot 策略

注意：任务给的称谓与文件证据有出入——**wx5cee 实为「总包AI顾问」**（前身 biaoxun 总包标讯，0929 更名 zongbao-ai），**wxd096 注册表名「总包千问」但现役=总包说展示小程序**（projectname 仍是 zongbao-qianwen）。

| appid | 现役身份 | 项目真身 | 上传器 | robot 策略 |
|---|---|---|---|---|
| wxfdb55b184756e89e | 总包学园（研报商城） | `WeAppForge\projects\zongbao\`（九页全量：index/reader/me/detail/agreement/cards/search/subscribe/rank）+ 体验快照 `work\zongbao_trial\` | `work/upload_xueyuan_trial.mjs`（快照五页瘦身包，ignores 剔 cards/**、@vant、mp-html、*.ts） | 无 robot 参数（默认 robot 1），版本 argv 传入 |
| wxd096fc6994ef6f48 | 总包说科技展示小程序 v1.1.2 | `E:\AI-Station\website\zongbaoshuo-miniprogram\`（version 1.1.2） | `tools/upload.js`（version 读 package.json；--robot 可覆盖，默认 1；--preview 出 preview.png） | 默认 robot 1，命令行覆盖 |
| wx5cee1574ce45819b | 总包AI顾问 v0.8.0 | `WeAppForge\projects\zongbao-ai\`（package.json version 0.8.0，type commonjs 就近覆盖父级 ESM） | `work/upload_qianwen.mjs` | **robot 1..30 轮转**：`work/robot_cursor.txt`（当前=14）记游标，`(last % 30)+1` 取下一个；每次上传追加 `work/robot_registry.jsonl`（13 行，robot2-14，0.4.2→0.8.0 全版本史）；上传后自动跑 `work/trial_health_probe.py` 健康探针 |

**robot 轮转的根因（upload_qianwen.mjs 头部「0929 教训级铁律」注释）**：同一 robot 再上传会替换该机器人名下的开发版本记录；体验版钉着该记录时即被顶掉→钉位悬空→全部入口按线上老版页面表解析→扫码「页面不存在」。故轮转保钉位 + 上传后探针防静默劣化（BROKEN 时提示用户后台一步「选为体验版」）。

**版本号策略**：语义版本手工 bump + 三处联动（package.json / my 页脚 / bootsim 断言，RUN_LEDGER #72：0.7.1 三处版本标记联动）。出码腿走 `getwxacodeunlimit`：`work/qr_dev_zbs.py` 示范标准配方——`page 显式 + check_path:false + env_version develop/trial`（「永不 404」）；海报码 `POSTER_QR_ENV_VERSION` 在 `services/qianwen-engine/qianwen_engine/config.py`（当前 "trial"，发布日一行切 release）。

## 3. 引擎（8869）是什么

**代码真身=`E:\AI-Station\services\qianwen-engine\qianwen_engine\`**（FastAPI；app.py/config.py/store.py/wechat.py/zhipu.py/metaso_kb.py/poster.py/exporter.py/session.py）。ECS 上 `http://47.120.43.20:8869`，systemd `qianwen-engine.service`（Restart=always，RUN_LEDGER #33），真 DB=`/opt/qianwen/data/qianwen/db.sqlite`（#64：qianwen.db 是空壳诱饵）。本机双实例：生产 8869 + 带闸 8870（harness 专用，`global.__QW_BASE__` 覆盖口）。

**异步流水线**（RUN_LEDGER #29 + app.py）：`POST /api/ask` 秒回 `{id,status:pending}`，KB 检索在后台线程跑；`GET /api/answer/{id}` 带 progress 事件流（提交/送达/检索轮次+字数，v0.7.0 加 SSE 流式 partial 打字机素材）；`_ask_lock = threading.Semaphore(1)` 串行闸（KB 网页会话一次一问）；失败自动退次。数据链：metaso 总包智库（KB_TOPIC_ID 8673582927558737920，cookie 网页积分线）+ 智谱免费链（zhipu.secret 多账号 glm-4-flash 池，optimize/追问/digest/citations 全接地绝不烧 KB）+ 微信 code2session + 虚拟支付双签名（paySig=HMAC(appKey)、signature=HMAC(session_key)，config.py 载明 offer_id=1450664233、导出 ¥0.1/条）。v0.8.0 起支持 CloudBase 云托管迁移（config.py：DB_KIND sqlite|mysql、PORT 环境变量缺省 8080）。

**harness 26 断言=`E:\AI-Station\WeAppForge\work\harness.cjs`**：逻辑回归 harness——wx 桩+Page 桩+真引擎（QW_DEV_LOGIN/QW_FAKE_ASK 双闸进程打 8870），三场景：A 全链（登录→配额→提问→答案→我的，19 断言）+ B 配额耗尽（402→引导弹窗，4 断言）+ C 空态（3 断言）= **26 断言**（尾部自报 `HARNESS ALL PASS (A19 + B4 + C3 = 26 assertions)`），后期加 D 虚拟支付场景（D1 已解锁 409 / D2 幂等解锁）。注意它是 0928 旧版，require 的是 `projects/biaoxun/...`（该目录现仅剩 screenshots/，已漂移失效）；现行验收主力是 BOOT-SIM（`work/bootsim_v3.py`，断言数 98→109→126→158→205→241→247 随版本增长）与 `work/harness_xueyuan.cjs`（学园）。

## 4. work/zongbao_trial 是什么

**总包学园（wxfdb）的体验版上传快照**。`work/upload_xueyuan_trial.mjs` 头注释：「快照 work/zongbao_trial：p1 关 / apiEnv prod / PROD_BASE http://47.120.43.20:8871/api/v1 / mockApi false 四翻已焊死」。自身 `project.config.json` appid=wxfdb55b184756e89e、projectname zongbao-xueyuan；`app.json` 五页（index/reader/me/detail/agreement，pages/ai 在 packOptions ignore）；`config/index.js` 四开关全 false（virtualPay/cloud/voiceInput/p1），DEV_BASE=8872、PROD_BASE=47.120.43.20:8871，支持 `globalThis.__XY_BASE__` 注入。含 content/（catalog.json+off.json+reports/）。

**与 projects/zongbao 的关系**：projects/zongbao 是 P1 试点真身全量开发目录（TS 源码+node_modules+miniprogram_npm+九页含 cards/search/subscribe/rank 的 p1 商机卡全功能）；zongbao_trial 是从真身抽出的**发布态瘦身快照**——p1 功能关闭、@vant/mp-html 等未引用 npm 包以 ignores 剔除（主包 2MB 限瘦身，upload_xueyuan_trial.mjs 注释），直传 wxfdb 后台，再由用户控制台「选为体验版」。上传用 privateKey 内容直注（KEY=readFileSync 红线区钥）。

## 5. ECS（47.120.43.20，实例 i-f8za6qhv365cwhti5y35，cn-heyuan）端口全景

| 端口 | 服务 | 证据 |
|---|---|---|
| 8869 | qianwen-engine（总包AI顾问后端，systemd） | RUN_LEDGER #33/#34；`work/ecs_open8869.py`（ufw 放行+假 code 冒烟） |
| 8870 | 本地带闸测试实例（harness 专用，不公网） | harness.cjs `__QW_BASE__`；RUN_LEDGER #31 |
| 8871 | xueyuan-engine（总包学园商城 B 线，/opt/xueyuan） | `work/ecs_deploy_xueyuan.py`（「端口: 8871…红线：只写 /opt/xueyuan，绝不碰 /opt/qianwen 与 8864/8869/8870」）+ zongbao_trial PROD_BASE |
| 8872 | 学园 DEV_BASE（本地/开发） | `work/zongbao_trial/config/index.js` |
| 8884 | ZongBaoShuo-web（总包说官网，301→8889） | sg.json（Description "ZongBaoShuo-web"）+ `work/nginx_xueyuan.conf.template` 头注释四站惯例 |
| 8885 | F5a 旗舰付费研报站（试读+收款码+订单库，即 report.yrecepc.cn 买家路径） | `_proposals/flagship-paid-report-1007/GOAL_LEDGER.md` F5a 行「http://47.120.43.20:8885/ 公网全链 200；systemd 常驻；双层墙 ufw+SG 已开」 |
| 8889 | 总包说官网主口（与 8884 同 root /www/ZongBaoShuo） | `_deploy_v111.py` 头注释「双口 8884/8889 同 root」 |
| 8881/8882/8883 | WeAIPO-promo-site / PAI-Station / wechatbrief | sg.json + nginx_xueyuan.conf.template 注释 |
| 8886/8887/8888 | SG 有放行规则（0916 建）但用途未见文件注明 | `work/sg.json` |
| 80 | dify 容器 nginx（双 nginx 形态宿主层） | sg.json「dify」规则 |
| 8864 | laya-server（默认口） | `services/laya-server/server.py`（LAYA_PORT 缺省 8864） |

**部署通道=阿里云云助手 RunCommand（SSH 22 不对公网，仅内网 100.104.0.0/16）**。部署脚本家族在 `WeAppForge/work/`：ecs_deploy.py（v025 引擎全量）、ecs_deploy_v060/v070/v073.py（引擎增量）、ecs_deploy_xueyuan.py（学园）、ecs_deploy_zhipu.py、ecs_https_stage2.py、ecs_gcbrain_ignite.py（备案后 443 点火）、_deploy_v111.py（官网）等。通用配方（ecs_deploy_v073.py）：tar 打包→base64 分片（15000 字/片）→云助手追加→解包 /opt/qianwen/...→py_compile→systemctl restart→health 探针；坑=云助手回包状态字段是 InvocationStatus 非 Status（RUN_LEDGER #45）。双层墙纪律：云助手只做 ufw 层，阿里云 SG 放行=用户控制台位（ecs_deploy_xueyuan.py L181 注释）。

## 6. _deploy_v111.py

**位置=`E:\AI-Station\website\zongbaoshuo\_deploy_v111.py`**。头注释：「总包说官网 index.html 上 ECS 的通用部署器（读当前文件，幂等可重跑）。gzip→b64 分片(15000/片)→云助手落位→远端 md5 校验→备份旧件→原子替换。双口 8884/8889 同 root /www/ZongBaoShuo，一文件双生效（8884=301→8889）」。SRC=website/zongbaoshuo/index.html，DEST=/www/ZongBaoShuo/index.html，实例 i-f8za6qhv365cwhti5y35。同目录还有 `_nginx_zongbaoshuo.conf`（vhost 配置）与 `_reorder_v10.py`/`_qa_v7.py` 等官网维护件——**注意它部署的是官网 H5，不是小程序包**；小程序侧上传走 `website/zongbaoshuo-miniprogram/tools/upload.js`（§2）。

## 7. 附：work/mp_cancel_logout 实况

目录名源自 1004「取消小程序自主注销」战役（`driver.py`：专属 Chrome 端口 9336+profile `E:\AI-Station\data\state\mp_qr_profile`，状态机 QR_WAIT/LOGGED_IN/ACT_n/RESTORED/NEED_USER/ERROR，红线「绝不动控制台其他任何按钮」；act2-act13.py=注销链 13 步动作）。现已演化为**总包AI顾问 mp.weixin 后台自动化驾驶舱**：`vpay_probe1-16.py`（1007 虚拟支付逆向：wujie 微前端 raw CDP 注入配方）、`vpay_item_create/recon*.py`（1008 道具创建/对账）、`tcb_probe1-4.py`+`qw_tcb_prep.py`+`qw_tcb_envupdate.py`（CloudBase 云托管 @cloudbase/manager-node 直调，TCB_DEPLOY.md §8a 配方）、`watch_category*.py`（类目盯哨，schtasks QianwenCatWatch 每 3h）、`submit_audit_api.py`+`submit_v080.py`（提审三步向导：nav/step1/step1b/step2/form/fill/commit，铁律=自有文本节点找真按钮/checkbox 不连点/每步回读 DOM）。状态文件 `state.json`。

## 8. 附：work/ 目录其余要点

- 密钥/登记类：`sg.json`（ECS 安全组全量快照）、`secret_sizes.txt`、`s_inject_key.sh`/`s_rm_key.sh`（ECS 侧密钥注入/摘除）、`inst.json`。
- 引擎侧迭代证据：`upload_qianwen_run2.log`、`trial_health_probe.py`、`release_pages_oracle.py`、`qr_trial_fire.py`/`qr_dev_fire.py`（出码腿）。
- 备件包：`WeAppForge/filing/category_dossier/`（AI 算法协议生效截图+备案公示+OCR+提审备注定稿，README_一次性备件清单.md）；filing/ 根下另有 cancel_logout_act*.png 全程取证。
- 备份：`work/backups/`（如 zongbao-ai_v0.5.0_20260929_2328，RUN_LEDGER #53）。

## Key Facts
- 构建上传全部走 miniprogram-ci ^2.1.31（Node>=20），package.json scripts: build= pipeline/build.mjs, upload= --no-experimental-webstorage pipeline/upload.mjs, harness:xueyuan= work/harness_xueyuan.cjs (E:\AI-Station\WeAppForge\package.json 10-17, 22)
- 常用交付器 work/forge.mjs：lint(wxml_lint闸门)→upload→preview→deliver(推企微 tools/send_wecom_file.py)，多项目注册表 data/projects.json，WXML 闸门不过=拒传 (E:\AI-Station\WeAppForge\work\forge.mjs 1-8, 65-66)
- 三项目注册表：biaoxun wx5cee1574ce45819b / qianwen wxd096fc6994ef6f48 / zongbao wxfdb55b184756e89e，密钥均指 data/secrets/private.<appid>.key，注释「appid与key文件名逐字符diff过的才准入」 (E:\AI-Station\WeAppForge\data\projects.json )
- IP 白名单实证：装机清单记录「IP 白名单未配也通过=未启用强校验」，上传链从未被拦 (E:\AI-Station\WeAppForge\RUN_LEDGER.md 43)
- wx5cee(总包AI顾问)上传器 robot 1..30 轮转：cursor 文件记游标、registry.jsonl 台账、上传后自动 trial_health_probe；轮转根因=同 robot 再传顶掉被钉体验版记录致「页面不存在」 (E:\AI-Station\WeAppForge\work\upload_qianwen.mjs 5-8, 16-23)
- robot_registry.jsonl 现有 13 行（robot2-14），最新 2026-10-08T09:34 v0.8.0「导出付费：单条/批量¥0.1虚拟支付」；robot_cursor.txt=14 (E:\AI-Station\WeAppForge\work\robot_registry.jsonl )
- 总包说小程序项目在 website/zongbaoshuo-miniprogram（appid wxd096fc6994ef6f48, version 1.1.2），上传器 tools/upload.js robot 默认 1 可 --robot 覆盖，密钥在 E:\AI-Station\微信小程序\ 目录（红线区外） (E:\AI-Station\website\zongbaoshuo-miniprogram\tools\upload.js 20-27)
- 引擎 8869=services/qianwen-engine（FastAPI），ECS systemd qianwen-engine.service 常驻，真 DB=/opt/qianwen/data/qianwen/db.sqlite；异步流水线=POST /api/ask 秒回 id+pending、KB 后台线程、Semaphore(1) 串行闸、progress 事件流 (E:\AI-Station\services\qianwen-engine\qianwen_engine\app.py 53-60)
- harness 26 断言=work/harness.cjs 三场景 A19+B4+C3=26（wx桩+Page桩+真引擎8870带闸实例），自报 'HARNESS ALL PASS (A19 + B4 + C3 = 26 assertions)' (E:\AI-Station\WeAppForge\work\harness.cjs 1-6, 尾部console.log)
- work/zongbao_trial=总包学园体验版上传快照（appid wxfdb，五页瘦身包，四翻焊死：p1关/apiEnv prod/PROD_BASE 47.120.43.20:8871/mockApi false），projects/zongbao 是九页全量真身 (E:\AI-Station\WeAppForge\work\upload_xueyuan_trial.mjs 1-2)
- ECS 端口：8869 总包AI顾问引擎 / 8871 学园引擎（红线只写 /opt/xueyuan，8864/8869/8870 互不碰）/ 8884+8889 总包说官网双口同 root / 8885 F5a 旗舰研报站 / 8881-8883 WeAIPO/PAIStation/wechatbrief；部署全走云助手 RunCommand（SSH 不对公网） (E:\AI-Station\WeAppForge\work\ecs_deploy_xueyuan.py 1-10)
- _deploy_v111.py 位于 website/zongbaoshuo/：官网 index.html 上 ECS 通用部署器（gzip→b64分片15000/片→云助手→md5校验→备份→原子替换，双口 8884/8889 同 root /www/ZongBaoShuo） (E:\AI-Station\website\zongbaoshuo\_deploy_v111.py 1-7)
- F5a 收款码站证据：http://47.120.43.20:8885/ 公网全链 200、systemd 常驻、双层墙 ufw+SG 已开（report.yrecepc.cn 买家路径） (E:\AI-Station\_proposals\flagship-paid-report-1007\GOAL_LEDGER.md 34)
- 总包AI顾问真身 projects/zongbao-ai version 0.8.0；版本策略=手工 bump+三处联动（package.json/my页脚/bootsim断言）；海报码 POSTER_QR_ENV_VERSION='trial' 发布日切 release (E:\AI-Station\WeAppForge\projects\zongbao-ai\package.json 1-4)
- Node 25 坑连环修：--no-experimental-webstorage 焊进 forge.mjs；upload_qianwen.mjs 须 NODE_OPTIONS --require localstorage-shim.cjs（exit 0 假成功实锤）；preview/upload 腿同款遮蔽 (E:\AI-Station\WeAppForge\work\upload_qianwen.mjs 2-4)

## Risks
- 总包说（wxd096）上传密钥存于 E:\AI-Station\微信小程序\ 而非 data/secrets/ 红线区，与其余两个 appid 的密钥纪律不一致
- data/projects.json 注册表已漂移：qianwen 条目 projectPath=projects/qianwen（目录不存在）；biaoxun 条目名称「总包标讯」与实际身份（总包AI顾问）不符，work/forge.mjs 对这些条目执行会失败/误导
- work/harness.cjs 仍 require projects/biaoxun/...（该目录只剩 screenshots/），0928 版 harness 已实际失效；现行验收依赖 bootsim_v3.py，两者断言口径不同（26 vs 98-247）
- RUN_LEDGER.md 台账停在 1007（虚拟支付五步收官），1008 的 0.8.0 上传/提审动态只在 robot_registry.jsonl 与 mp_cancel_logout 脚本里，单看台账会漏最新态
- upload_xueyuan_trial.mjs 把 privateKey 内容读进内存直注（KEY=readFileSync），与 privateKeyPath 形态并存；泄露面等价但审计 grep 更难发现

## Open Questions
- wx5cee 小程序 0.8.0 提审当前状态？（robot_registry 止于 10-08 09:34 上传，submit_v080.py 1008 实况适配；提审结果与类目绿灯态需查 schtasks QianwenCatWatch 产出或企微通知，本盘点未及）
- ECS 上 8886/8887/8888 三个端口实际在跑什么？（SG 规则 2026-09-16 建但未见任何部署脚本/配置文件提及用途，需登 ECS 或问用户）
- 总包说（wxd096）密钥是否应迁入 data/secrets/ 红线区统一管理？（现留在微信小程序原始下载目录，与其余两 appid 纪律不一致）
- CloudBase 云托管（PORT 8080/env=1）与 ECS 8869 双形态的切换时间表？（config.py 已双轨就绪，RUN_LEDGER #199 记待用户裁决客户端 0.8.0 UI+env 切 0）
- work/harness.cjs 是否需要修路径指向 projects/zongbao-ai？（26 断言验收口径在台账中被反复引用，现文件已 require 失效）
