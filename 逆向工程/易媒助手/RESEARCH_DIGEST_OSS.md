# 易媒助手开源等价物调研纪要(一键多平台发布系统底座选型)

- 生成: 2026-10-19 | 方法: gh api GitHub REST + 各仓README一手实测, star数/许可证/推送时间全部实测, 无手填
- 逐项目明细: `逆向工程/易媒助手/RESEARCH_DOCKET/github/*.json` (一项目一文件) + 汇总 `_all.json`
- 背景铁律: 必须找可直接拿来用的开源项目, 尽量不自己开发。对标易媒助手(CEF内嵌+直连API双引擎+SQLite cookie隔离)

## 一、结论速览

**主底座 = DevilJie/social-auto-upload-web-ui(千帆云递)**, 辅以上游 dreammis/social-auto-upload 模块池,
B站协议走 biliup, 公众号图文走官方API(iamzifei skill蓝本), 长尾平台兜底用 pywinauto 驱动易媒助手本体。
搜狐号/网易号等长尾图文平台开源界空白, 需自研少量适配器。

## 二、排名表(全部实测 2026-10-19)

| # | 项目 | stars | 许可 | 最近推送 | 平台数 | 发布形态 | 技术栈 | 账号管理 | 签名算法 | 维护 | 适配分 | 采纳 |
|---|------|-------|------|----------|--------|----------|--------|----------|----------|------|--------|------|
| 1 | DevilJie/social-auto-upload-web-ui 千帆云递 QianFan Sync | 318 | MIT | 2026-10-19 | 19 | 基于social-auto-upload的web-ui优化重构(活跃UI继任者) | Python+Playwright+Web UI | 待核验 | 无 | 非常活跃(当天推送) | 92 | reuse-主底座 |
| 2 | dreammis/social-auto-upload | 15619 | MIT | 2026-09-02 | 11 | 视频全平台; 图文仅抖音/小红书/快手; 定时发布多数平台 | Playwright浏览器自动化 + Bilibili走biliup协议库; 自带sau CLI与AI skills | Playwright storage_state JSON + xhs的accounts.ini多账号配置 + SQLi | B站走biliup协议上传; 无X-Bogus/a_bogus类签名逆向 | 活跃(2026-09推送) | 90 | reuse-上游模块池 |
| 3 | biliup/biliup | 5517 | MIT | 2026-10-18 | 1 | 视频投稿(协议直连,非浏览器) | Rust(biliup-rs CLI)+Python包; B站投稿协议含登录(扫码/密码/cookie) | 多种登录方式,cookie持久化 | 内置B站投稿协议与认证(wbi签名等) | 非常活跃(2026-10-18推送) | 85 | reuse-B站协议适配器 |
| 4 | iamzifei/wechat-article-publisher-skill | 157 | MIT | 2026-08-12 | 1 | 图文(草稿箱,不自动群发) | 官方API直连:Python解析Markdown/HTML→结构化(title/content/images)→微信草稿API;图片自动传素材库;无浏览器自动化 | 微信公众号官方API凭证(AppSecret等) | 官方API无需签名逆向 | 活跃(2026-08) | 85 | reuse-公众号图文官方API蓝本 |
| 5 | hanliang97/MatrixMedia 矩媒 MatrixMedia | 992 | GPL-2.0 | 2026-10-17 | 8 | 视频(CLI 8平台全自动化)+publish-article子命令(图文,范围待查docs/cli.md) | Vue+Electron+Puppeteer; GUI+CLI(argv含cli无头)+HTTP API(POST 127.0.0.1:30088/publis | Electron session partition persist:<手机号><平台> 隔离,CLI与GUI共用; C | 未见协议签名逆向,走浏览器自动化 | 非常活跃(2026-10-17推送) | 65 | pattern-only(GPL-2.0传染) |
| 6 | pywinauto/pywinauto | 6218 | BSD-3-Clause | 2026-10-15 | 0 | 取决于被驱动软件 | Win32 API+UI Automation;配合inspect识别控件 | 由被驱动软件自管(易媒助手SQLite) | N/A(不走协议) | 活跃(2026-10-15) | 72 | reuse-驱动易媒助手兜底 |
| 7 | kebenxiaoming/matrix | 969 | Apache-2.0 | 2025-12-27 | 4 | 仅视频 | Python3+Playwright; Redis存登录态队列+MySQL存发布队列+supervisor守护; 小红书登录依赖本地xhs-api服务(app2 | cookie文件管理+MySQL/Redis账号队列,可多账号(user_queue_login按类型排队登录) | 内置小红书x-s/x-t签名服务(xhs-api目录,本地flask) | 半休眠(约10个月未推) | 60 | reuse(Apache,参考xhs签名服务) |
| 8 | NanmiCoder/MediaCrawler | 67192 | NOASSERTION(自定义非标准许可证,含非商用限制) | 2026-10-15 | 7 | N/A(采集不发布) | Playwright + CDP模式(连接用户已有Chrome,127.0.0.1:9222,复用已有登录态降风控;可关CDP回标准Playwright) | 登录态缓存:扫码/cookie登录后Playwright browser_data持久化;多账号在Pro闭源版才有(开源 | 核心思路:无需JS逆向,在保留登录态的浏览器上下文里用JS表达式现取签名参数(x | 非常活跃(2026-10-15) | 55 | pattern-only(非商用许可) |
| 9 | BACNext/BACNext | 200 | None | 2026-08-17 | 1 | N/A(API文档) | Markdown文档 | N/A | 无 | 社区接力,非官方 | 20 | pattern-only同源法律风险 |
| 10 | SocialSisterYi/bilibili-API-collect | 20163 | None | 2026-01-30 | 1 | N/A(纯API文档库,非发布工具) | Markdown文档 | N/A | 无 | 死亡(律师函后停更) | 15 | 不采用(法律风险情报) |
| 11 | cml227/Wanmeiyifa | 45 | None | 2023-11-28 | 0 | 万媒易发:AI驱动多平台多账号管理神器(README自述) | 未核实 | 未核实 | 无 | 死亡(2023-11停更近3年) | 15 | 不采用(无许可+停更) |

注: 平台数为"发布能力覆盖数"; 千帆云递19平台全表与各项目逐平台清单见对应 JSON。

## 三、每个项目我们拿什么

### 1. DevilJie/social-auto-upload-web-ui — 千帆云递 QianFan Sync
- https://github.com/DevilJie/social-auto-upload-web-ui
- 拿什么: 主底座整体clone-and-adapt: 19平台适配器impl/(Registry模式按平台分目录)+Flask任务队列+SQLite账号/素材库+定时排程+CloakBrowser反检测+MCP服务, 数据全本地

### 2. dreammis/social-auto-upload
- https://github.com/dreammis/social-auto-upload
- 拿什么: uploader/ 12平台Playwright模块(alipay/baijiahao/bilibili/douyin/hupu/ks/tencent/tk/weibo/xhs/xiaohongshu/youtube) + xhs accounts.ini多账号模式 + sau CLI + AI skills; 上游修复回流源

### 3. biliup/biliup
- https://github.com/biliup/biliup
- 拿什么: B站协议投稿组件(多P/多登录方式/边录边传), 替代浏览器自动化B站路线, MIT可闭源集成

### 4. iamzifei/wechat-article-publisher-skill
- https://github.com/iamzifei/wechat-article-publisher-skill
- 拿什么: 公众号图文官方API直连蓝本: MD/HTML->结构化->草稿箱API+素材库自动传图, 零风控零浏览器

### 5. hanliang97/MatrixMedia — 矩媒 MatrixMedia
- https://github.com/hanliang97/MatrixMedia
- 拿什么: 不抄代码(GPL), 抄三个机制: CLI(argv含cli)+HTTP API(30088)+MCP三通道编排; Electron persist:<手机号><平台> session按账号隔离; cli accounts登录态检测命令

### 6. pywinauto/pywinauto
- https://github.com/pywinauto/pywinauto
- 拿什么: UIA驱动易媒助手桌面端的兜底通道, 衔接已逆向的SQLite cookie资产, 覆盖开源空白的长尾平台

### 7. kebenxiaoming/matrix
- https://github.com/kebenxiaoming/matrix
- 拿什么: xhs-api本地flask签名服务(x-s/x-t)思路 + MySQL发布队列/Redis登录态队列/supervisor守护的多账号调度架构(Apache可抄)

### 8. NanmiCoder/MediaCrawler
- https://github.com/NanmiCoder/MediaCrawler
- 拿什么: 不抄代码(非商用许可), 抄两个模式: 浏览器上下文内JS表达式现取签名参数(免逆向); CDP连接真人Chrome复用登录态降风控

### 9. BACNext/BACNext
- https://github.com/BACNext/BACNext
- 拿什么: BAC律师函后的社区接力仓库, 仅作B站协议情报跟踪, 不依赖

### 10. SocialSisterYi/bilibili-API-collect
- https://github.com/SocialSisterYi/bilibili-API-collect
- 拿什么: 已死(2026-01-28律师函停更删文档)。价值=风险先例: 协议文档化路线会被平台武装维权

### 11. cml227/Wanmeiyifa
- https://github.com/cml227/Wanmeiyifa
- 拿什么: 不采用: 无许可证+2023-11停更

## 四、平台覆盖缺口(需自研)

- 搜狐号/网易号/企鹅号/一点资讯等长尾图文平台: 开源界空白, 需自研Playwright适配器
- 微博图文: 现成实现仅视频, 图文需自研
- 知乎/头条图文形态: 需对千帆云递实测确认后定
- 多账号矩阵调度: 现成项目均为单机单账号视角, 矩阵编排(账号池+队列+调度面板)需自研, 可参考kebenxiaoming的MySQL+Redis+supervisor队列模式与MatrixMedia的persist:<手机号><平台> session隔离

## 五、风险清单

- 法律: B站2026-01-28对bilibili-API-collect发律师函(指控系统性收集传播非公开API/调用逻辑/认证机制), 原仓停更删文档。协议直连+签名逆向路线已被平台武装维权, 优先官方API+浏览器自动化
- 仓库猝死: WeChatVideoUploader/uvan-x已404。平台投诉可瞬间杀死依赖仓库。选定底座后立即fork+本地镜像+离线vendor, 选择器资产自持
- 选择器易碎: 平台改版即失效(kebenxiaoming README自认需自行维护css选择器)。需选择器集中配置+截图AI校验+热修机制
- 许可证红线: MediaCrawler(非商用)/MatrixMedia(GPL-2.0)/bilibili-API-collect(无许可)不可抄码进入闭源产品线; 千帆云递与upstream与biliup均为MIT可放心
- 账号风控: 多账号同机同指纹易触发风控。对策=千帆云递CloakBrowser隐身/MatrixMedia按账号session partition/MediaCrawler CDP复用真人浏览器。注意MediaCrawler CDP默认9222端口与WeAIPO浏览器免打扰红线冲突, 复用必须改端口或独立profile

## 六、已核实死件/不存在项

- lecepin/WeChatVideoUploader: 404。原视频号Playwright上传明星项目已消失,作者仓库列表已无此项目(2026-10-19实测)。其能力以social-auto-upload的tencent_uploader模块存活
- uvan-x/media-platform-upload: 404,uvan-x账号已注销。活跃UI继任=DevilJie/social-auto-upload-web-ui
- ovtenkf: 用户不存在(404),任务清单中ovtenkf/other无法核实
- any-publish: GitHub无同名开源仓(gh search --match name实测)
- BearCarryBack(月伴/苏轼): GitHub无同名开源仓,疑为闭源商业工具(UNVERIFIED)

## 七、Working notes(过程证据链)

- 2026-10-19 gh api 实测: social-auto-upload 15619stars/MIT/pushed 2026-09-02; uploader/目录12模块; xhs_uploader含accounts.ini
- 2026-10-19 gh api 实测: lecepin/WeChatVideoUploader 404, lecepin全部仓库列表无此项目
- 2026-10-19 gh api 实测: uvan-x用户404(账号注销); DevilJie/social-auto-upload-web-ui 318stars/MIT/pushed当天, README载19平台表+三层架构+data目录cookies+SQLite
- 2026-10-19 gh api 实测: bilibili-API-collect 20163stars/archived/无LICENSE文件, README原文确认2026-01-28律师函停更删文档; BACNext/BACNext 200stars为社区接力
- 2026-10-19 gh api 实测: MediaCrawler 67192stars/许可证Other(NOASSERTION)/pushed 2026-10-15; README载CDP 9222模式+浏览器上下文取签名+Pro版多账号
- 2026-10-19 gh api 实测: biliup 5517stars/MIT/pushed 2026-10-18(Rust); biliup-rs 1073stars/MIT/archived(2025-11)
- 2026-10-19 gh api 实测: MatrixMedia 992stars/GPL-2.0/pushed 2026-10-17; kebenxiaoming/matrix 969stars/Apache-2.0/pushed 2025-12-27(README载xhs-api签名服务+MySQL/Redis)
- 2026-10-19 gh api 实测: iamzifei skill 157stars/MIT/pushed 2026-08-12(README载官方API草稿箱路线)
- 2026-10-19 gh api 实测: pywinauto 6218stars/BSD-3-Clause/pushed 2026-10-15; 万媒易发45stars/无许可/2023-11停更; ovtenkf用户404
- gh search实测: GitHub无 any-publish / BearCarryBack 同名开源仓; 中文关键词"搜狐号/网易号/图文一键分发"搜索无可用结果(长尾图文开源空白证据)

## 八、组合方案(落地形态)

1. clone 千帆云递为仓库基底(Flask后端+Vue前端+MCP), 保持MIT合规与上游同步能力
2. B站适配器替换为 biliup 协议路线(更快更稳); 公众号图文接入官方API草稿箱路线
3. 多账号矩阵: 按MatrixMedia的session partition思路改造千帆云递的cookie存储, 每账号每平台一个隔离上下文+账号池SQLite(对齐易媒助手SQLite cookie隔离设计)
4. 长尾平台(搜狐/网易等): 先用pywinauto驱动易媒助手兜底, 逐个替换为自研Playwright适配器
5. 立即fork+本地镜像全部依赖仓库, 防仓库猝死; 选择器集中到配置文件便于热修
