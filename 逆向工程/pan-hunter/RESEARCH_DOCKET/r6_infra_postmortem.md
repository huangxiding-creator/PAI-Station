# PAN-HUNTER R6 卷宗：通用基建与历史验尸（免登录网盘检索下载 CLI）

- 日期：2026-10-30 ｜ 研究员：R6 ｜ 方法：gh api repos 实测星数/许可证/最后推送 + 多引擎搜索交叉；尸体案卷只认可溯信源（政府站/主流媒体/一手 README）
- 实收 45 条（A=8 / B=21 / C=13 / D=9）；不确定处标「未核」
- 总判：检索层 clone-and-adapt pansou（MIT,15.1k★,fit 95）；下载执行层 aria2 RPC（GPL-2.0，独立进程经 JSON-RPC 驱动无传染,fit 95）；HTTP 层 curl_cffi（MIT,fit 92）；盘适配接口抄 OpenList driver 规范（AGPL→只抄协议不抄码）。自研面收窄到：源插件 + 免登录凭据零托管。

## 第一节 下载基建（25 条）

### 通用引擎
| # | 名称 | url | 活性 | 它解决什么 | verdict | fit |
|---|------|-----|------|-----------|---------|-----|
| 1 | aria2 | https://github.com/aria2/aria2 | 43322 / GPL-2.0 / 2026-06 | 多协议多连接下载引擎：RPC 模式、-x16 -s16 分段、断点续传、--checksum 校验、限速 | A | 95 |
| 2 | AriaNg | https://github.com/mayswind/AriaNg | 13265 / MIT / 2026-10 | aria2 静态 Web 控制台，队列/速度/错误可视，MIT 可改皮 | A | 85 |
| 3 | yt-dlp | https://github.com/yt-dlp/yt-dlp | 203767 / Unlicense / 2026-10-29 | extractor 插件架构黄金标准：每站点一个 extractor 类、独立测试；Unlicense 可任意取用 | A | 90 |
| 4 | Gopeed | https://github.com/GopeedLab/gopeed | 27254 / GPL-3.0 / 2026-10-30 | Go 下载引擎(CLI+GUI+库)，分块并发/断点/协议扩展；GPL 只借鉴库化设计 | B | 75 |
| 5 | AB Download Manager | https://github.com/amir1376/ab-download-manager | 18826 / Apache-2.0 / 2026-10-28 | 桌面多线程下载+浏览器接管；Apache 可复用分段调度代码 | B | 65 |
| 6 | File Centipede | https://github.com/filecxx/FileCentipede | 10944 / 无许可证 / 2026-10-26 | C++ 多协议+浏览器集成下载器；无许可证 pattern only | C | 40 |
| 7 | Motrix | https://github.com/agalwood/Motrix | 57571 / NOASSERTION / 2026-10 | aria2 封装 UX 样板；长期半停更史+许可存疑 | C | 50 |
| 8 | axel | https://github.com/axel-download-accelerator/axel | 3420 / GPL-2.0 / 2026-09 | 极简 CLI 分段下载，容器内 fallback | B | 55 |
| 9 | parfive | https://github.com/Cadair/parfive | 63 / MIT / 2026-10 | Python asyncio 下载库:并发+重试+进度，MIT 可直接 pip 进我们 CLI | A | 70 |
| 10 | gdown | https://github.com/wkentaro/gdown | 5475 / MIT / 2026-10-29 | 单盘特化客户端范式:配额舞步/confirm 令牌/断点,写法教材 | B | 60 |
| 11 | pyload | https://github.com/pyload/pyload | 3902 / NOASSERTION(自述AGPL,未核) / 2026-10-28 | 账户池+逐站插件包+下载器抽象三层框架先例(含captcha/队列) | B | 70 |
| 12 | JDownloader | https://jdownloader.org (SVN托管,GitHub无官方仓,未核) | — | 逐站点插件+premium账户池架构鼻祖 | B | 50 |
| 13 | FreeRapid | https://sourceforge.net/projects/freerapid | 基本停更 | SourceForge 时代逐 hosting 插件下载器,插件热插包分发教材 | C | 25 |
| 14 | XDM | https://github.com/subhra74/xdm | 8166 / GPL-3.0 / 2026-10 | 长期休眠后 metadata 有动,真实活性存疑,仅案例 | C | 35 |
| 15 | Persepolis | https://github.com/persepolisdm/persepolis | 7487 / GPL-3.0 / 2025-10 | aria2 GUI,价值有限 | C | 30 |
| 16 | uGet | https://github.com/ugetdm/uget | 151 / null / 2024-10 | GTK 下载器+aria2 插件位,主战场 sourceforge | C | 25 |

### 盘专用框架
| # | 名称 | url | 活性 | 它解决什么 | verdict | fit |
|---|------|-----|------|-----------|---------|-----|
| 17 | BaiduPCS-Go(qjfoidnh) | https://github.com/qjfoidnh/BaiduPCS-Go | 5856 / Apache-2.0 / 2026-09 | 百度PCS协议+BDUSS登录+多线程+秒传/分享解析;与站内bdn.py互为对照蓝本;issue区=百度风控一手证据库(另有Angey40分叉440★) | A(蓝本) | 80 |
| 18 | iikira/BaiduPCS-Go原版 | https://github.com/iikira/BaiduPCS-Go | 404已消失(gh api实测2026-10-30) | 原作者2019弃坑/账号消散导致原仓蒸发——单人巴士因子铁证 | D | — |
| 19 | aliyunpan(tickstep) | https://github.com/tickstep/aliyunpan | 5131 / Apache-2.0 / 2026-09 | 阿里盘Go CLI全链:刷新令牌/上传下载/秒传/CLI交互框架 | B | 70 |
| 20 | aliyundrive-webdav | https://github.com/messense/aliyundrive-webdav | 9728 / MIT / archived 2026-02 | 阿里盘WebDAV;上游开放接口收紧后被作者归档——盘方政策杀死单盘工具活例 | D | 40 |
| 21 | bypy | https://github.com/houtianze/bypy | 8588 / MIT / 2025-04 | 百度PCS官方API十年长跑者:限速/分片/重试的克制写法 | B | 60 |
| 22 | quark-auto-save | https://github.com/Cp0204/quark-auto-save | 3085 / AGPL-3.0 / 2026-07 | 夸克签到/转存/整理/推送全链;AGPL只学不抄;issue#14明拒网赚=项目方风控自觉 | B | 70 |
| 23 | PikPakAPI | https://github.com/Quan666/PikPakAPI | 220 / 无许可证 / 2025-02 | PikPak离线盘API封装(GID/离线下载/分享);无许可证默认版权保留 | C | 40 |
| 24 | Kubespider | https://github.com/opennaslab/kubespider | 2194 / Apache-2.0 / 2026-04 | 资源订阅→解析→投递aria2的下载编排器,与PAN-HUNTER形态最像的开源件之一 | B | 75 |
| 25 | SyncPan | https://github.com/mqflive/syncpan-release | 31 / 闭源发行仓 / 2026-10 | 多盘同步追更商业件,release-only闭源分发形态参照 | C | 30 |

## 第二节 聚合框架先例（12 条）

| # | 名称 | url | 活性 | 架构与它解决什么 | verdict | fit |
|---|------|-----|------|------------------|---------|-----|
| 26 | PanSou | https://github.com/fish2018/pansou | 15085 / MIT / 2026-10-12 | 高性能网盘搜索API:并发TG频道+异步插件源(工作池)、插件等级+时间新鲜度+关键词多维排序、分片内存+分片磁盘二级缓存、异步插件「尽快响应持续处理」;14类盘链接自动归类(baidu/aliyun/quark/tianyi/uc/mobile/115/pikpak/xunlei/123/magnet/ed2k等);自带插件开发指南+AI客户端Skill指南(Codex/Claude/Cursor可装);插件示例qqpd/gying/weibo/woniu | A(克隆母体) | 95 |
| 27 | CloudSaver | https://github.com/jiangrui1994/CloudSaver | 9413 / MIT / 2026-10-15 | 可自部署「搜索+链接解析+转存」一体(Vue3+Docker);README警告勿在陌生站填盘Cookie;暗坑:开源源码停在v0.2.5,新版只发Docker镜像且与源码不对应(open-core漂移) | A(钉v0.2.5源码版) | 88 |
| 28 | PanHub | https://github.com/joyce677/panhub (主仓wu529778790/panhub.shenzjd.com) | 438 / 无许可证 / 2026-04 | TG 80+频道+10+插件聚合:优先级调度、独立并发配置、指数退避重试、LRU+内存监控缓存、单源熔断、超时控制、60+测试>90%覆盖、SEARCH_PASSWORD密码门 | B | 60 |
| 29 | LinkSwift | https://github.com/hmjz100/LinkSwift | 36366 / AGPL-3.0 / 2026-10-27 | 油猴脚本:百度/阿里/移动/天翼/迅雷/夸克/UC/123等直链解析全家桶;AGPL只抄解析思路+抄其盘名录当收录目录 | B | 70 |
| 30 | lzpan_search | https://github.com/Xwudao/lzpan_search | 656 / MIT / 2025-09 | 轻量盘搜站聚合小件,源抽象极简可读 | B | 60 |
| 31 | PanIndex | https://github.com/px-org/PanIndex | 1399 / AGPL-3.0 / 2025-06缓更 | 网盘目录索引程序,盘搜「站」化形态参照 | C | 40 |
| 32 | BaiduyunSpider | https://github.com/k1995/BaiduyunSpider | 1180 / 无许可证 / 2019-09停 | 百度云资源爬虫尸体 | D | 20 |
| 33 | 直链解析小件组 | 189-down(84★) network-disk-parse(82★) DriveDirectLink(249★) 均github.com同名仓 | 低活/半停 | 逐盘直链算法参考(天翼/多盘通用解析) | B/C | 50 |
| 34 | TG闭源盘搜bot生态 | @yunpan_bot(阿里盘) @kejiqubot(夸克) 见github.com/TelegramTip/telegram-bots-collection | 闭源在役 | 频道爬取+会员制商业闭环形态;同名CloudSearch开源仓未找到(未核) | C | 40 |
| 35 | mcp-pansou-search | https://www.npmjs.com/package/mcp-pansou-search | 2025-10 | pansou的MCP化先例:检索能力直接进AI客户端生态——我们CLI加MCP头零成本 | C | 55 |
| 36 | OpenList | https://github.com/OpenListTeam/OpenList | 25363 / AGPL-3.0 / 2026-10-30当日仍推 | AList社区分叉,自述「防御信任攻击的长期治理分叉」;30+盘统一挂载,driver接口=盘适配层协议范本;AGPL传染→只抄接口协议独立实现 | B(架构) | 85 |
| 37 | AList | https://github.com/AlistGo/alist | 50379 / AGPL-3.0 / 2026-10-21 | 曾经的聚合之王;2025-06被作者悄悄出售→失联→社区恐慌供应链投毒→OpenList分叉(案卷见3.2#45) | D(信任死)+B(架构) | 50 |

## 第三节 awesome 清单与尸体案卷（12 条）

### 3.1 收录目录（gh search「awesome wangpan / awesome netdisk」均空——无权威 awesome-pan 仓）
| # | 名称 | url | 说明 | verdict |
|---|------|-----|------|---------|
| 38 | GitHub topic: wangpan | https://github.com/topics/wangpan | 最接近的持续更新收录页 | B |
| 39 | LinkSwift README 盘名录 | https://github.com/hmjz100/LinkSwift#readme | 百度/阿里/移动/天翼/迅雷/夸克/UC/123全名单——直接当我们源插件清单 | B |

### 3.2 尸体案卷（死因: L=法务 R=风控对抗 B=商业模式 A=上游政策/作者）
| # | 案 | 信源 | 死因 | 对我们的启示 |
|---|----|------|------|--------------|
| 40 | PanDownload(2020-04扬州警方抓捕作者蔡某萌,获利约30万,罪名=提供侵入/非法控制计算机信息系统程序工具) | jfdaily.com/wx/detail.do?id=237985 ｜ stcn.com/article/detail/127936 ｜ zh.wikipedia「PanDownload」 | L(刑事) | 突破盘方限速措施=刑事红线;多线程不算罪,绕过技术措施才算 |
| 41 | 速盘SpeedPan(已基本失效;2019被曝后台上传用户BDUSS) | cloud.tencent.com社区分析 ｜ cr173.com述「下着下着就断」 | R+信任崩坏 | 偷用户凭证=身败名裂第一;硬对抗百度限速终归失败 |
| 42 | 盘多多(2019一审判赔35000元) | 国家版权局 ncac.gov.cn/xxfb/yjdt/201909/t20190903_49616.html | L(民事/版权) | 判赔额不高但足以杀死小站长;索引分享链接也可能担帮助侵权 |
| 43 | 付费盘搜站长常某被抓(19.9~199元会员制) | zhuanlan.zhihu.com/p/2034642120947004647 | B+L | 向下载者直接收费=主观恶意放大器;变现必须离下载行为远一层 |
| 44 | 小雅AList全家桶(原版停更,知乎述「阿里凉了停更」;社区分叉monlor/docker-xiaoya续命) | github.com/monlor/docker-xiaoya ｜ zhihu 2024文 | A(上游盘政策) | 内容源押单一盘政策必死;「官方下架」说法未核 |
| 45 | AList卖身案(2025-06悄悄出售→失联→OpenList分叉复活) | 163.com《一夜之间,我的开源网盘被悄悄卖了》｜ global.v2ex.co ｜ linux.do | B(变现压顶)+信任链 | 凭据托管型聚合器的信任链是生死项;治理结构决定寿命 |
| 46 | aliyundrive-webdav归档(2026-02) | github.com/messense/aliyundrive-webdav archived实测 | A(上游API收紧) | 单盘适配=搭盘方政策便车,需多盘冗余 |
| 47 | iikira/BaiduPCS-Go原仓蒸发(gh api 404实测) | gh api 2026-10-30 | A(作者巴士因子) | 关键适配层org化/多维护者;fork在才有命续(qjfoidnh已证) |
| 48 | 2016个人网盘大关停潮(360/快盘等,涉黄侵权主因) | xinhuanet.com/zgjx/2016-10/22/c_135773438.htm | L(行业级) | 行业紧-松-紧周期律;设计按「随时收紧」留退路 |
| 49 | 百度版权维权常态化(2024德恒代理一二审再审全胜) | dehenglaw.com案讯 | L | 盘方主动狩猎聚合站;域名/品牌别带pan+破解字样 |
| 50 | 快点芭蕾 | 搜索引擎无此名(查询被内容过滤器拦截,未核/疑讹传) | — | 需求方提供的名字先验真,不写进产品文档 |

## 第四节 反爬生存术（9 条）

| # | 名称 | url | 活性 | 它解决什么/证据 | verdict | fit |
|---|------|-----|------|----------------|---------|-----|
| 51 | curl_cffi | https://github.com/lexiforest/curl_cffi | 6795 / MIT / 2026-10-27 | TLS/HTTP2指纹模拟(chrome/safari impersonate),搜索源HTTP层标准答案 | A | 92 |
| 52 | cloudscraper | https://github.com/VeNoMouS/cloudscraper | 6808 / MIT / 2025-06 | CF JS挑战纯HTTP解法;合规边界:只用于公开页面被动通过,不做主动规避实现 | B | 65 |
| 53 | FlareSolverr | https://github.com/FlareSolverr/FlareSolverr | 16074 / MIT / 2026-10-24 | 无头浏览器代理过CF;重资源,边界内仅记录在案 | B | 55 |
| 54 | fake-useragent | https://github.com/fake-useragent/fake-useragent | 4048 / Apache-2.0 / archived 2026-03 | UA池数据源已归档→改用curl_cffi内建impersonate或自维护短列表 | C | 45 |
| 55 | undetected-chromedriver | https://github.com/ultrafunkamsterdam/undetected-chromedriver | 12890 / GPL-3.0 / 2025-07 | 浏览器侧反检测路线备查;站内默认DrissionPage(铁律) | C | 40 |
| 56 | 百度风控证据链 | CSDN gitblog_00158(限速恢复) ｜ cnblogs 2020(baidu_shurufa应用目录绕黑名单史) | — | 第三方客户端触发限速黑名单/账号异常;恢复=停用24-48h冷却+官方客户端正常使用;历史绕法皆短命 | C(证据) | — |
| 57 | BDUSS/STOKEN生命周期 | 腾讯云/知乎实测文 | — | Cookie数月有效,改密/异地登录即失效→凭据新鲜度与降级设计依据 | C | — |
| 58 | 夸克风控阈值 | quark-auto-save issue#14等 | 未核 | 无公开阈值案例;项目方拒网赚功能为间接信号;站内bdn经验=并发≤4+零浏览器 | C | — |
| 59 | 搜狗门票制(内部实证) | 站内 replica/sogou_weixin_api.py(1024全绿) | 在役 | 搜索源防封真相:门票(SNUID)+碎片拼接+频控,非硬对抗;同思路推及盘搜源 | C(内部) | — |

频控三律(合成结论): ①并发≤4/源+全局随机间隔2-5s ②指数退避+单源熔断(一源死不停机,panhub已验证) ③指纹走curl_cffi impersonate,UA与TLS同源一致(裸UA轮换反而露馅)

## 防死三原则（一句话版）

1. 法务隔离：只做「免登录公开分享链接的索引+用户自有通道下载」，不碰限速破解/账号池/向下载收费——PanDownload(刑事)、常某(收费即恶意)、盘多多(民事)三案分水岭全在这里；变现挂在工具/知识库/整编交付，不挂在下载行为。
2. 双解耦架构：源插件化(抄pansou插件制+yt-dlp extractor纪律) x 下载器抽象(抄OpenList driver协议+aria2 RPC执行)，任何单源/单盘/单作者死亡都可热插拔——阿里政策杀小雅与webdav、百度杀速盘、作者消失杀iikira，全是解耦不足死的。
3. 凭据零托管：免登录态检索(门票+指纹卫生+频控三律)，永不代收用户盘Cookie——速盘偷BDUSS臭史与AList卖身恐慌两次证明：谁托管凭据谁背信任死刑；必须登录态的功能一律用户本地自供密钥。

## 与站内资产的合流位
- 检索层：pansou克隆改造，源插件换七渠道复刻件(sogou/metaso/djyanbao/wenku/cnki/chinca+TG频道腿)
- 下载执行：aria2 RPC伴生+parfive兜底小文件；百度盘腿走bdn.py(8.2.5逆向111端点在役)
- kb-harvest的DownloadAdapter四段(0x仓骨架)恰为「下载器抽象」落点
- 纪律对齐：全链零浏览器(DrissionPage仅认证腿)、并发≤4、让路令/高峰令自动生效

## Working notes（检查点原账，数据均gh api 2026-10-30实测）
aria2 43322/GPL-2.0/2026-06 ｜ AriaNg 13265/MIT ｜ pyload 3902/NOASSERTION/2026-10-28 ｜ yt-dlp 203767/Unlicense ｜ axel 3420/GPL-2.0 ｜ Motrix 57571/NOASSERTION ｜ xdm 8166/GPL-3.0 ｜ persepolis 7487/GPL-3.0/2025-10 ｜ uget 151/null/2024-10 ｜ parfive 63/MIT ｜ gdown 5475/MIT ｜ curl_cffi 6795/MIT ｜ cloudscraper 6808/MIT/2025-06 ｜ FlareSolverr 16074/MIT(勘误:非GPL)/2026-10-24 ｜ fake-useragent 4048/archived ｜ aliyunpan 5131/Apache-2.0 ｜ aliyundrive-webdav 9728/MIT/archived 2026-02 ｜ BaiduPCS-Go qjfoidnh 5856/Apache-2.0 ｜ bypy 8588/MIT ｜ quark-auto-save 3085/AGPL-3.0+issue#14拒网赚 ｜ OpenList 25363/AGPL-3.0/当日仍推 ｜ alist 50379/AGPL-3.0 ｜ Gopeed 27254/GPL-3.0/当日仍推 ｜ undetected-chromedriver 12890/GPL-3.0 ｜ LinkSwift 36366/AGPL-3.0 ｜ pansou 15085/MIT ｜ panhub 438/无许可证 ｜ CloudSaver 9413/MIT+源码滞v0.2.5 ｜ ab-download-manager 18826/Apache-2.0 ｜ kubespider 2194/Apache-2.0 ｜ PikPakAPI Quan666 220/无许可证 ｜ PanIndex 1399/AGPL/2025-06缓 ｜ lzpan_search 656/MIT ｜ BaiduyunSpider 1180/无许可/2019停 ｜ FileCentipede 10944/无许可证/2026-10-26 ｜ iikira原仓404实测 ｜ 189-down 84/network-disk-parse 82/DriveDirectLink 249 ｜ SyncPan mqflive 31★闭源
- 尸体信源: jfdaily 237985 ｜ stcn 127936 ｜ zh.wikipedia PanDownload ｜ ncac.gov.cn t20190903_49616盘多多判赔3.5万 ｜ zhihu p/2034642120947004647常某收费被抓 ｜ cloud.tencent速盘BDUSS+cr173失效 ｜ 163.com/V2EX/linux.do AList卖身 ｜ xinhuanet c_135773438 ｜ dehenglaw百度胜诉
- 风控信源: CSDN gitblog_00158冷却24-48h ｜ cnblogs 2020 baidu_shurufa史 ｜ BDUSS数月有效/改密异地失效 ｜ 夸克阈值未核 ｜ 搜狗SNUID门票=站内实证
- README一手核验(gh api readme): pansou=工作池/异步插件/二级缓存/14盘型/AI客户端Skill指南; CloudSaver=v0.2.5开源滞后暗坑+勿填Cookie警告; panhub=熔断/指数退避/LRU/密码门/60+测试; OpenList=自述防御信任攻击分叉
- 未核清单: JDownloader官方仓与许可 ｜ CloudSearch bot开源源码 ｜ 小雅官方下架动因 ｜ 快点芭蕾(疑讹传)
