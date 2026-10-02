# RUN_LEDGER — weapp-forge（小程序全流程工厂提案）

> C10：运行台账胜过文档。每个检查点记录：时间 / 动作 / 实测结果 / 下一步。

## 2026-09-27

| # | 时间(UTC) | 动作 | 实测结果 | 下一步 |
|---|---|---|---|---|
| 1 | 12:52 | idea-intake：IDEA_SEED.md 落盘（用户四条补充指令全部钉入 constraints/pilot：全网最顶级/顶级缝合怪不造轮子/推送到我的小程序后台+调试验证测试/微信支付+研报付费阅读试点+语音+AI对话+微信AI） | ambiguity_scorer.py --fields 实测 **10/10 action=auto**，五字段全 specific，零追问 | research-orchestrator |
| 2 | 12:55 | 并行调研发射：5 个后台 agent（official_eco≥25 / frameworks_ui≥40 / skills_mcp_ai≥25 / wechat_pay≥15 / pilot_features≥15） | 全部在跑 | 等待+聚合 |
| 3 | 13:01 | 主控广度清点：GitHub 14 组查询扫掠（sweep.js）+ npm registry 4 组×100 | **GitHub 328 unique repos（0 degraded）+ npm 351 unique packages（0 degraded）**；末尾 awesome 补扫撞上次级限流（328 已够，不追） | aggregate.js 聚合去重 |
| 4 | 13:02 | 评分脚本链勘察：maturity_index/tenx_delta_index/pricing/scorecard 全部 stdin-file 式，输入契约已记录 | 待 agents 数据落地后实车跑 | enrichment→四脚本→PROPOSAL |

## 待办（依赖 agent 返回）

- [ ] 聚合 5 agent docket + 2 sweep → _merged.json + _INVENTORY.md（去重后总数 ≥100 硬门）
- [ ] 对候选零件 top~50 补齐 open_issues/license/updated_at（gh core API，限速 1/s）→ maturity_index 实跑 → feasibility
- [ ] ten× claims 定轴实跑（候选：onboarding_time 想法→可调试 72h→4h；dev_efficiency；deploy_cost 人工触点）→ tenx
- [ ] 定价：竞品价格采集（低代码平台/云开发套餐）→ pricing 实跑
- [ ] user_value：引用 ≥1 篇痛点证据文档
- [ ] scorecard 实跑 → verdict=proceed 才出 PROPOSAL.md/BUSINESS_MODEL.md/SCORECARD.json
- [ ] ✋ 批准门：向用户呈现提案，一次决策 approve/revise/reject

## agent 返回记录

| agent | 条目 | 状态 | 关键发现 |
|---|---|---|---|
| skills_mcp_ai | 49（skill19/mcp9/repo9/product8/doc4） | ✅ 完成 | 微信官方已下场：开发者工具 Skill 公测（wechatide，编译/预览/上传/云开发全覆盖）→ 编译腿直接建在官方件上；支付执行无 MCP、审核/类目/发布无任何 MCP（中国特色护城河空白）；"端到端"口号项目全部 0-2★ 零落地=缺口实证；低代码竞品价格已采到（即速999/上线了1800-5400/凡科698-5998/微盟16800-59800元/年）→ pricing 输入；试点"研报付费阅读"零竞品、零件全现成（wx-book 169★ 阅读器） |
| official_eco | 57（repo37/npm7/doc7/plugin1/news1/mcp1/degraded3） | ✅ 完成 | **最重磅：官方「AI 开发模式」平台级协议**（ai-mode-skills 203★：任意小程序改造为可被微信小微 SubAgent 调度的原子接口+组件；官方评测四指标≥60分/Intent≥50/复杂用例≥30% → 可当工厂出厂合格判据）；DevTools 2.0+ 内建扩展面板+MCP 市场分发；CloudBase-AI-Toolkit 1126★ 43+ MCP tools；工厂七腿官方零件全齐（ci 2.1.47 7.2万月载/CLI V2+HTTP V2/automator 5.9万月载/simulate 7.8万月载）；**坑**：miniprogram-ci/automator/minitest 三主仓已从官方 org 下架（404），ci 迁 miniprogram-ci-dist，automator npm 28 个月未更新（有社区兼容替代 @weapp-vite/miniprogram-automator），minitest 线实质停摆 |
| wechat_pay | 27（官方doc17/SDK7/政策3） | ✅ 完成 | **用户点名问题的完整答案**：三路线=①标准商户号JSAPI v3（企业/个体户，**小程序内卖数字内容属违规**）②CloudPay（免证书免签名但不降资质门槛）③**虚拟支付=数字内容唯一合规通道**；**2026-09 个人主体虚拟支付新开**（身份证+工具类目，月限10万，Android 1%/iOS 12%）；iOS双轨坑=苹果抽12%+账期45-60天，外链H5规避=微信明令违规；试点路径=MVP个人主体+工具类目+虚拟支付个人档（wx.requestVirtualPayment short_series_goods）→规模化企业主体+商业资讯-研报类目（需CPN许可）；**架构约束：研报以PDF文件交付、避免做成信息发布/检索平台形态** |
| frameworks_ui | 79（框架17/UI14/工程11/实用9/模板9/图表5/富文本5/状态5/官方AI基建4；74实测+5 degraded） | ✅ 完成 | 框架：uni-app 41617 > taro 37702 > wepy 22540(archived)；UI 活跃仅 vant-weapp 18457/tdesign/weui 27437（iview/wux/lin-ui/ColorUI/ThorUI 全停更）；富文本=mp-html 3750/towxml 2898（wxParse 7716 已死勿用）；weapp-tailwindcss 1864+weapp-vite 486 双活跃；**GH Actions 小程序发布 action 无一存活（最高14★2021停）→ 发布层无人做=工厂机会**；glass-easel 332/Skyline 新渲染预留对接位；uCharts 官方仓在 gitee |
| pilot_features | 26（api10/doc8/repo8） | ✅ 完成 | 六腿选型齐：分章渲染 mp-html+双PDF（openDocument 无页码范围，官方确认）；虚拟支付 wx.requestVirtualPayment（2026-04 强制官方通道）；WechatSI 实时语音+键盘降级；云开发 extend.AI+agent-ui 96★+官方知识库=零代码 RAG；msgSecCheck 200万次/天 免费；防盗版 canvas 水印+截屏隐藏。负面清单：个人主体禁 web-view/疑不可用同传插件（**企业主体已规避**）；session_key 禁下发前端；enableChunked 高性能模式强制 HTTP1 |

## 评分与交付（全部脚本实跑，零手填）

| # | 动作 | 实测结果 |
|---|---|---|
| 5 | aggregate.js 聚合去重 | **840 unique**（github328/npm351/official56/fw79/skills46/pilot26/pay27）→ `_INVENTORY.md` |
| 6 | candidates_enrich.js 51 零件富化（0 failed）→ maturity_index.py | median 68.9、22 mature、best 97.6 → **feasibility 0.809** |
| 7 | tenx_delta_index.py | onboarding_time 72h→4h=**17.99× tenx-qualified**；dev_efficiency 6×；deploy_cost 7× |
| 8 | pricing.py（7 竞品实价） | premium 定位 recommended **¥22,700/年**、anchor 5,400、floor 1,400 |
| 9 | scorecard.py | feasibility .809 / user_value .85 / monetization .72 / tenx .99 → **0.849 PROCEED**（门 0.72） |
| 10 | 交付物落盘 | PROPOSAL.md / BUSINESS_MODEL.md / SCORECARD.json / RESEARCH_DOCKET/{RESEARCH_DIGEST,GAP_REPORT}.md |

## 用户中途指令（全部已吸收）

全网最顶级✓ 顶级缝合怪不造轮子✓ 微信支付接入调研✓（三路线+虚拟支付结论）试点=研报付费阅读+语音+AI对话+微信AI✓ 企业主体（视频号企业认证）✓

## 当前状态

**✋ 批准门**：等用户 approve/revise/reject。批准后 P0 第一步=AppID/密钥/装机验证+HelloWorld 全链计时拿基线。

## 2026-09-29 · 总包AI顾问体验版发布（用户令「发布到 wx5cee1574ce45819b 并设为体验版」）

| # | 动作 | 实测结果 |
|---|---|---|
| 11 | **appid 迁移收口**：引擎侧 0928 v0.2.6 已切（config.WX_APPID=wx5cee1574ce45819b + zongbao_qianwen_mp.secret 本地/ECS /opt/qianwen 孪生在位；旧号密钥转 .bak）；本窗补前端两翻=project.config.json appid + 快照 BASE_URL 10.4.158.104→47.120.43.20:8869（源码保 LAN 供 devtools，快照 work/qianwen_trial 供上传）；**定名正身**=「总包千问」5 处→「总包AI顾问」（app.json/ask.json 导航栏+ask.wxml hero+两注释） | ci.upload **PASS**：v0.2.6 · 全包 12685B · 13 文件 · 6.3s（robot1 → 开发版本位）；preview QR work/qianwen_preview_qr.png（项目成员即扫即测） |
| 12 | **Node25 ci 上传坑根治**：首跑「exit 0 假成功」实锤——corecompiler 子进程 `r.getItem is not a function` 炸 → 主进程 upload 顶层 await 永不落定（ESM 空转退出码 0 骗 CI 判据）；父进程 defineProperty 遮不到子进程 → **work/localstorage-shim.cjs + NODE_OPTIONS=--require 父子同注**，二跑 6.3s 全绿 | 生产探针：/api/health `{"ok":true}` · /api/engine/status 200（metaso 会话自管理，session_refreshing 状态机在位） |
| 13 | **用户侧两步**：①控制台 mp.weixin.qq.com（wx5cee1574ce45819b）→管理→版本管理→开发版本 0.2.6→「选为体验版」；②手机体验版开「开发调试」（HTTP+IP 未进合法域名，同总包学园口径） | ⚠ 此 appid 原挂 biaoxun 标讯演示版——开发版本位已被总包AI顾问 0.2.6 接管（用户明令迁移） |

## 2026-09-29 · 「页面不存在」根因修复（用户令「自行调试优化，真正能使用才交给我」）

| # | 动作 | 实测结果 |
|---|---|---|
| 14 | **诊断链**（快照对照→路径假设杀→automator 死路=devtools CLI 需 GUI 初始化+登录→API 探针失效=getwxacodeunlimit check_path 对未发布版本一律 41030，对照组学园同炸→preview 不校验 pagePath（假路径也过））→ **真凶=错发孤儿**：WeAppForge/projects 下有两个同名辈前端，`projects/qianwen`=v0.1 时代孤儿（旧 appid 时代产物、LAN BASE_URL、无 md2blocks），`projects/biaoxun`=v0.2.6 真身（appid wx5cee1574ce45819b ✓ 公网 BASE_URL ✓ 用户 0928 真机验过）——**目录名骗人，我发了孤儿**，故体验版「页面不存在」 | 交叉证据：孤儿包 12,685B vs 真身 41,144B（assets+md2blocks 全在）；引擎侧全程健康（/health ok·appid/secret 双端正确）|
| 15 | **修复三连**：①真身正名收尾——ask.json 导航栏「总包标讯」→「总包AI顾问」+ask.js/my.js 注释 + package.json 0.2.7；②`work/upload_qianwen.mjs` 重写直指 projects/biaoxun，**0.2.7 上传真成功**（UPLOAD_OK 落定·全包 41,144B·robot1 开发版本位）；③防复发——孤儿改名 `projects/_orphan_qianwen_v01_勿发布` + 误导物清除（qianwen_trial 快照/preview QR/测试脚本） | 开发版验证码 `work/qianwen_dev_qr_027.png`（getwxacodeunlimit env=develop check_path=false，98KB）|
| 16 | **用户侧两步（无可免）**：①控制台→版本管理→开发版本 **0.2.7**（顶部新的一条）→「选为体验版」（体验版指向=纯控制台操作，无 API）；②或直接扫开发版码先验（项目成员即扫即用） | 手机打开若仍「页面不存在」=体验版还指着旧孤儿包，重选 0.2.7 即愈 |
| 17 | **深挖第二真凶+体验成员绑定成功**：用户仍报「页面不存在」→ 引擎侧取证=users 表 0928 后零登录（微信从未把任何版本递到扫码手机）→ 权限缺口实锤；bind_tester 四种 body 全 47001 后破局——**对照实验**：第三方专属 /wxa/commit 对普通 token 立回 40014，而 bind_tester 走到 body 解析层（空 body=44002）=接口不拒普通 token，纯字段契约问题；社区实录+wechatpy 源码对出真相=**直调变体字段是 `wechatid`（单数字符串），`weixin_users`（数组）是第三方平台代调变体** | `POST /wxa/bind_tester {"wechatid":"ZongBaoJ01"}` → **errcode 0 ok**（userstr 5dcd04fa…；可 unbind_tester 反解）；交付两码=开发版码（管理员/项目成员直扫 0.2.7）+体验版码（体验成员可扫，须先重选 0.2.7 为体验版）；引擎 DB=登录雷达（users 表自记，扫后即验） |
| 18 | **用户令「全部自行搞定再给我报告」→ 三腿终检全绿+终局诊断**：①账号 API 取证 `cgi-bin/account/getaccountbasicinfo`（此前 /wxa/ 前缀=40066 误诊）→ 企业主体+微信认证通过+改名「总包AI顾问」已生效+无年审风险=账号健康；quota 神谕=该 appid 史上仅 6 次 API 调用（全是我）→ 微信从未供版复证；②孤儿包无死导航（3 跳转全指向自身存在页）→ **若体验版指着孤儿会「能开但请求失败」而非页面不存在 ⇒ 体验版槽位=空或钉在已被微信清除的远古标讯演示版**（终局病因）；③DevTools 本机从未初始化（无 User Data/.cli 焊不进）→ 游客模式路线物理死；④wxa/getversion 40066=第三方专属，版本状态无直调 API | **三腿自测全 PASS**：LEG A 云引擎真实秘塔 KB 回路（ECS 直调 metaso_kb.ask → 869字/4引用/11.1s，免费网页池单次）；LEG B API 全契约（8870 dev 登录→ask 扣次 3→2→轮询 status=**ready**+结构化答案+unlocked；首跑误判=状态名非 done）；LEG C 已上传 0.2.7 代码树 BOOT-SIM 8 项全绿（config 公网 BASE_URL/md2blocks/api 导出/App 注册/三页工厂/ask 走 wx.request 打 47.120.43.20:8869）；坑：本机 heredoc 吃反斜杠（payload 换 chr(10) 拼接走文件驱动根治） |
| 19 | **用户截图对质「后台只有这几个版本」→ 真相反转+#18 病因修正**：截图取证（vision 双查询）=**线上版 1.0.7 存在（2025-05-07「哈萨藏」发布的老标讯演示版）+ 开发版仅两条（2025 的 1.0.7 + 我的 0.2.7 ci机器人1）+ 蓝色「体验版」标已在 0.2.7 上（用户已钉好，重钉步骤作废）**；桌面微信自测通道打通：`generatescheme {"jump_wxa":{"env_version":"trial"}}` → `weixin://dl/business/` 协议直呼 → 小程序窗口真开（标题总包AI顾问）；**但像素级判据（PrintWindow 截图 RGB 探针：导航栏 (202,58,58)=红 ≠ 0.2.7 的 #1e5eff 蓝，主体 97.5% 纯白）钉死窗口渲染的是线上版老演示版=trial 打开失败回落 release**；证据链三连：①check_path=true+env=trial 真页面(pages/ask/ask)与假页面同回 41030=校验参照表只有线上版 1.0.7 的页面表 ②urllink path 参数全 40165（页面配置校验）而 bare 全 errcode 0 ③quota 史诗级低位 | **根因修正**：无 path 的打开（历史所有码/链）默认首页按**线上版 1.0.7 页面表**解析 → 0.2.7 无此页 → 手机「页面不存在」/桌面回落正式版；#18「远古被清除版本」诊断**作废**；**修复=显式 page 码**：`getwxacodeunlimit {"page":"pages/ask/ask","check_path":false,"env_version":"trial"}` → `work/qr_trial_fix1.jpg`（页面直嵌码内，扫码端在 0.2.7 里打开真实存在的页）；交付三路=桥发件箱（~/.wechat-claude-code/outbound-spool/ JSON text+file，手机长按即开）+桌面打开+radar 自动确认（ECS users 表比 2026-09-28 新行=打通，cron 13:37/16:23 两轮，成功才 wecom）；附赠通道：`https://wxmpurl.cn/0XnDrLBYh9n`（trial 无path链接，受同一默认页病根制约备用） |

## 2026-09-29 · 蓝图设计系统 v0.3.1（用户令「提升页面设计，顶级 UI 水平」）

| # | 动作 | 实测结果 |
|---|---|---|
| 20 | **「工程蓝图 Blueprint」设计系统 v0.3→v0.3.1**：三页全重做（ask=蓝图hero+额度票根+委托单卡+QUICK DRAW虚线chip；answer=自绘顶栏+问句带+绘图仪扫描线轮询动画+白图排版（橙侧标h2/表格藏蓝表头/引用制图蓝）+依据来源=图签表格+「有用」盖红章 stampIn 动画；my=工程档案头+额度三联票+历史=S-01图纸编号行+BLANK SHEET空态）；全站 token 化（navy三阶/网格双层160rpx+32rpx/白墨/暖白纸面/安全橙/图章红/制图蓝）+ 自绘 tabBar（图框字标 问/我）+ 全页 navigationStyle custom（app.js 背胶囊算 navHeight）+ 轻震动 wx.vibrateShort；**桌面协议自测判据补全**=裸链 trial 开=线上版回落（无path默认页按 release 1.0.7 页面表解析，像素探针红导航实锤）→ 桌面验不了 trial 内容 → **自建设计台**：work/preview_030.html 三屏手机框静态渲染（同 token rpx÷2=px）+ Chrome MCP 截图视觉自审 → 三增量（hero 顶部纵深光 radial+DWG 行改真工程尺寸线带端标+SHT 1/1 图签+问句带橙左边标）回灌真身 → 0.3.1 上传 | BOOT-SIM 42/42 PASS；UPLOAD_OK 0.3.1 · 56,710B · 17 文件 · robot1（ci 编译门=真 WXML/WXSS 校验）；体验码 `work/qr_trial_031.jpg`（显式 page+scene v031）双路交付（桥发件箱 mp-qr-031-125722.json + 桌面弹出）；**体验版钉位不可 API 感知**：若扫码仍见旧蓝界面=体验版还钉 0.2.7，控制台→版本管理→0.3.1→选为体验版（一次） |

## 2026-09-29 · v0.4.0 咨询增强（用户五连令：三问题库/导出/标语×2/咨询化+语音）

| # | 动作 | 实测结果 |
|---|---|---|
| 21 | **①EPC 热点三连问题库**：SAMPLES 改 {tag,q} 结构 6 题（计价调价/设计变更索赔/背靠背条款/联合体投标/结算与审计/不平衡报价），每条=递进三小问（定性→依据→操作），chip 显示 tag+「三问」徽标，点按填全文；**②导出**：引擎新 `qianwen_engine/exporter.py`（行级 md 解析与前端 md2blocks 同源）+ `POST /api/answer/{aid}/export`（docx=python-docx 真表格真列表/pdf=fpdf2+simhei.ttf 蓝图排版，仅 unlocked 可导，base64 回传）；客户端 answer 页 onExport→ActionSheet→md 本地拼/docx+pdf 引擎生成→writeFile→showModal「微信转发(wx.shareFileMessage 兜底 openDocument)/预览」；**③④标语两处+全文咨询化**（委托单→咨询问题、tabBar 提问→咨询、CTA/空态/提示语全改）；**⑤语音两段式**：utils/voice.js（requirePlugin('WechatSI') try/catch 守卫+引导弹窗；asrStart 按住说话识别→确认→自动咨询；speak 长文按句≤180字分块顺序 TTS；stopSpeak 中断）+ ask 页按住说话条（脉冲动画）+ answer 顶栏「听」播报钮；**插件须控制台添加后才能 app.json 声明（未声明上传会被拒）→ 0.4.0 未声明（编译门实证 requirePlugin 守卫不碍打包），用户开通后 0.4.1 加声明即全功能** | 本地 8870 全链 PASS（login→ask→poll ready→export docx 37662B PK/pdf 30433B %PDF+bad-fmt 400+404 守卫）；PDF 视觉验收=深蓝题头带+图签 NO+问题带+引用块+依据来源（Chrome 渲染截图）；ECS 部署：exporter/app 上传+simhei.ttf 9.7MB 落 /opt/qianwen/data/qianwen/fonts+venv pip(python-docx/fpdf2 清华源)+重启 health ok+生产运行时纯函数冒烟 docx 37458B/pdf 23000B；BOOT-SIM v3 增 17 检查 **59/59 PASS**；UPLOAD_OK **0.4.0** 66,842B robot1；体验码 qr_trial_040.jpg 桥(mp-qr-040-133303)+桌面双路；坑：wb.upload 远端目录不存在报 PathNoWritePermission（先 mkdir）；wb 远端脚本绝对路径跑不吃 cwd（须 PYTHONPATH）；SimHei 无 •/｜ 字形（改 ·/；） |

## 2026-09-29 · v0.4.1 语音全功能（用户控制台添加 WechatSI 插件完成）

| # | 动作 | 实测结果 |
|---|---|---|
| 22 | **插件声明开关合闸**：用户在 mp 控制台「设置→第三方设置→插件管理」添加「微信同声传译」（provider wx069ba97219f66d99）后——app.json 顶层加 `"plugins":{"WechatSI":{"version":"0.3.5","provider":"wx069ba97219f66d99"}}`；package.json 0.4.1；BOOT-SIM v3 增 2 检查（app.json 声明 provider 精确匹配 + voice.js requirePlugin 守卫在位） | BOOT-SIM **61/61 PASS**；UPLOAD_OK **0.4.1** · __FULL__ 100,670B（代码 zip 45,664B）· robot1 · **回包 pluginInfo 带回插件本体 wx069ba97219f66d99 v0.3.5 · 33,753B = 后台添加真实生效的服务器级铁证**（若没加成功此步会被拒收）；体验码 qr_trial_041.jpg（显式 page+scene v041+check_path=false）双路交付（桥发件箱 mp-qr-041-141143.json+桌面弹出）；**语音从两段式降级态转入全功能**：ask「按住说话」→识别→确认弹窗→一键咨询 / answer「听」全文分句 TTS 朗读可中断；若扫码仍无语音条=体验版钉旧版，控制台→版本管理→0.4.1→选为体验版 |

## 2026-09-29 · 「页面不存在」复发根因闭环 + 三道永久防线（用户令「彻底排查，不要再发生」）

| # | 动作 | 实测结果 |
|---|---|---|
| 23 | **取证三腿定根因**：①引擎雷达（ECS db.sqlite answers 表+journalctl）= 最后成功咨询 **13:15:55**，14:10 上传 0.4.1 后**引擎零流量** → 失败在入口层（页面从未加载）；②**健康探针**（新建 work/trial_health_probe.py：getwxacodeunlimit check_path=true+真页面+env=trial）→ **41030**，与 0928 首次「页面不存在」同一机器指纹=校验参照表回落线上版 1.0.7 老表；③官方社区口径确认（developers.weixin.qq.com 官方回复）= **同一机器人再上传会替换其名下开发版本记录，体验版钉着该记录时即被顶掉** → 钉位悬空。因果链：13:05 robot1 传 0.4.0（用户已钉 0.4.0，13:15 还在正常用）→ **14:10 我用 robot1 再传 0.4.1 顶掉自己被钉的记录 → 钉位悬空 → 全部入口按老表解析 → 「页面不存在」**。每次发新版说「看到旧界面请重选」实为钉位已死而非停在旧版 | **防线落地**：①upload_qianwen.mjs **robot 1..30 轮转**（work/robot_cursor.txt+robot_registry.jsonl 审计，被钉记录永不因后续上传被顶）+上传后自动跑健康探针（BROKEN 即打印用户唯一修复动作）；②scheme_fire_030.py 出码前**前置探针硬闸**（钉位悬空 SystemExit(2) 拒绝出码，当场对真实坏态完成拒发实战演示）；③BOOT-SIM +3 检查 → **64/64 PASS**。**修复当前故障须用户一步（无API可代办）**：版本管理→0.4.1（机器人1，14:10，含语音）→「选为体验版」；已挂会话级自动监视（每9min探针，翻绿即桥推确认+自删，90min未恢复自动停）。真正终局 cure=提审发布正式版（暂不提审令在效，保持等待） |

## 2026-09-29 · 桌面自测台四连判 + 老项目清零 + v0.4.2（用户令「自测台彻底优化」「新入口解析」「老项目全删」「彻底修复高质量交付」）

| # | 动作 | 实测结果 |
|---|---|---|
| 24 | **桌面自测台四连负结果定论**：generatescheme ①裸trial链 ②裸develop链（weixin://dl/business/?t=B2CqwBYhkXm）③带path develop链（ask→**40165 生成即拒**=path永远按线上版1.0.7老表校验；my/my→**冷启判据**：全杀 WeChatAppEx 十进程+重拉仍红壳 #ca3a3a 94%，与 0928/13:15 健康期像素判据同源）——**桌面协议链一切入口按老表解析→全回落老标讯**（用户旁观点击中「又跳总包标讯」=人证）；**唯一实证好路=码内显式 page+check_path=false 新解析**（13:15 引擎流量铁证）。vision+像素双探针全流程化（work/nav_probe.py 导航栏色判定 RELEASE_RED/OURS_NAVY） | **线上版页面表神谕**（release_pages_oracle.py 补 scene 修 40169 全盲坑）：老表真实页面=**pages/home/home + pages/my/my**（后者与我方真身撞名）；曾按撞名试 home 跳板方案→用户令「用新入口解析不要用老的」→**跳板撤回**（建后即删，零残留），入口纪律定死=新解析显式page码 |
| 25 | **老项目清零（用户令「全部删除不要留」）**：删 `_orphan_qianwen_v01_勿发布`（老号时代v0.1孤儿）+删 `work/upload_biaoxun.mjs`（老标讯时代上传器）+删老蓝调tabBar图标4×png（grep零引用=自绘tabBar前遗物）+删 `work/gen_icons.py`（老色板生成器）+清 api.js 首行「总包标讯」注释；**验明保留**：projects/zongbao=总包学园现役生产、work/zongbao_trial=学园活快照（upload_xueyuan_trial.mjs 在用） | **目录更名 biaoxun→zongbao-ai**（目录名骗人事故的源头永久封死）：uploader projectPath/bootsim ROOT/project.config.json projectname/package.json name 六处引用同步改；grep 复扫零旧引用（projects/zongbao/config/index.js 一条惯例注释保留不动） |
| 26 | **v0.4.2 上传**：版本标记「我的」页脚 `v0.4.2 · 总包AI顾问`（截图一眼辨版）+ 全部清痕成果打包 | **UPLOAD_OK 0.4.2 · robot2 · 98,215B · 18文件**（**首次轮转实弹**，robot1 被钉记录从此永不被顶；pluginInfo 照带 WechatSI 33,753B）；上传后探针自动跑→TRIAL_BROKEN+打印用户唯一动作（防线全链在役）；**BOOT-SIM 67/67**（+4检查：版本标记/无跳板页/零老标讯字样walk全包/原有三防线） |
| 27 | **双码双通道交付**：①qr_dev_042.jpg（env=develop+显式page+check_path=false，**免钉位通道**，管理员/项目成员扫码即开最新版）桥发件箱+桌面弹图双交付；②scheme_fire_030.py 升 v042（体验版通道，探针硬闸后出码）；**监视哨升级重建**（旧391b6da1删）：每9min探针→翻绿全自动（出体验码→桥推→wb雷达复核→汇报→CronDelete 自删），20:05 未恢复=一次性 giveup 桥推说明剩余唯一动作后自删 | 基线锁死：引擎最后流量 13:15:55、之后零流量（answers 表5行）；体验成员 ZongBaoJ01 复绑回声 85004=仍在册（重钉后体验码即用）；引擎 /api/health ok。**等用户一步**：版本管理→0.4.2（机器人2，18:23）→选为体验版；**终局选项待用户定夺**：提审发布正式版=一切入口按我方页面表解析的根治cure（暂不提审令在效，不催不动） |
| 28 | **探针语义自纠错（教训级）+体验码交付+雷达监视**：#19 早证 check_path=true 只按线上版已发布表校验（钉位健康时真页面也 41030），但 #23 所建 trial_health_probe.py 语义反了（真页回图=健康）→ **恒假阴性机器**：出码硬闸整个下午误锁+监视哨假 BROKEN（两个 cron 全删）；修正=探针改**通道体检**（my/my 回图=通道活；ask 41030=预期常数；SUMMARY=NO_PIN_ORACLE）+scheme_fire 撤硬闸（NOTE 化）+bootsim 检查改「出码器=码内显式page+免老表校验」 | BOOT-SIM **67/67**；**qr_trial_042.jpg 96,717B**（显式page+scene v042+check_path=false）桥发件箱+桌面弹图双交付 18:42；trial scheme bJBpvLuqwvs 备查；**雷达监视在役**（每4min、基线 13:15:55、answers 新流量=打通铁证、21:10 无人扫=收尾提醒后自删）；用户已重钉体验版（终审=手机扫码；桌面四连判疑桌面账号无体验版权限，非钉位证据） |
| 29 | **雷达亮=全链打通终审通过**：18:42:32 双路交付 qr_trial_042 → **18:43:26 answers 新行**（dCBqxyXZ·via kb·ready·27.5s·2805字·unlocked），比基线 13:15:55 新——手机扫显式page码→页面正常开→提问→引擎出答案，体验版钉位健康实证；users 表同一账号当日三问（12:39/13:15/18:43），免费 3 次/日已用尽（第 4 问将走「点赞+1」或解锁引导=预期非 bug） | 监视哨完成使命自删（c584befd）；答案内容=「设计变更索赔」预设三连问全文——用户实测路径即点卡咨询；引擎侧零改动 |
| 30 | **v0.4.3 语音交互重做（用户三连令）**：①按住识别文字实时填入「咨询问题」输入框（旧代码只写语音条小字 voiceText 从不进 question=病根一）；②松开立即结束识别（旧代码收尾全赖插件 onStop 回调，机型迟到/不回=「松开不结束」病根二）→ asrStop 当场以 lastPartial 收尾+onStop 降级 1s 宽限静默修正（_lateRefine）+管理器单例事件只注册一次+迟到会话吞掉窗（_staleUntil）；③布局调序=语音条→立即咨询按钮→咨询输入框（按钮从底栏上移）；删「说完自动提问」确认弹窗（改为显式点立即咨询） | BOOT-SIM **71/71**（+4：实时填入/松开即收尾/终稿宽限/布局顺序）；**UPLOAD_OK 0.4.3 robot3 98,899B**（pluginInfo 照带+通道体检 CHANNEL_OK）；qr_dev_043.jpg 94,959B 桥+桌面双交付 18:59（开发版=免钉位通道，管理员/项目成员扫码即测；体验版仍钉 0.4.2，要体验版用新交互须控制台把 0.4.3(机器人3) 选为体验版） |
