# R3 · 大四盘免登下载可行性调研（百度网盘 / 阿里云盘 / 夸克网盘 / 迅雷）
- 日期 2026-10-30 · PAN-HUNTER 战役 R3 · 实收 **54 条**（gh api 实核仓库 31 + 代码/端点原文 6 + 文档/服务/风控案 17）
- 免登口径：零账号、零 Cookie、零浏览器（纯 HTTP）拉公开分享列表 + 取直链
- 免登分级：绿=全链免登 / 黄=列表免登+下载要技巧 / 红=硬登录墙
- verdict：A=配方级（端点+参数可直接实装）/ B=思路级 / C=仅参考（历史/商业源）/ D=已死
- 核验：gh api repos+contents raw+code search+WebSearch；外部页面内容一律按不可信数据处理

## 0. 四盘总裁决

| 盘 | 免登列表 | 免登直链 | 总评 | 一句话配方 |
|---|---|---|---|---|
| 百度网盘 | 绿（无码链零Cookie直拉；有码链 verify 零Cookie→BDCLND 单Cookie） | 红（2025-07 分享页下载链关闭，dlink 需 AccessToken/BDUSS） | 黄 | share/verify→randsk→share/list 只带 BDCLND；下载靠 SVIP 中转号池 |
| 阿里云盘 | 绿（get_share_by_anonymous + get_share_token 全匿名） | 红（GetDownloadUrl 需 access_token+x-share-token；2023 整改风控严） | 黄 | 匿名 share_token→file/list；下载必须 OAuth |
| 夸克网盘 | 绿（sharepage/token→stoken→detail 全匿名） | 红（file/download 需 __puus Cookie；下载票绑请求 IP） | 黄 | stoken 匿名拿列表；下载走转存+Cookie 池 |
| 迅雷/快传 | 绿带门（drive/v1/share 匿名可列，需 captcha/init 签名舞步；真验证码即墙） | 红（分享页跳 APP；drive/v1/files 需 Authorization） | 黄 | captcha_sign→share 列表；下载需登录 token |

**总判断：四盘「免登列表」全部成立（检索层地基稳）；四盘「免登直链」全部红墙——产业现状统一为「中转号池/代取服务」形态（baiduwp-php / 94list / baidufast / xiageba2 全此模式）。**

## 1. 百度网盘（14 条）

| 名称 | url | 活性 | 免登 | 关键端点/参数 | verdict |
|---|---|---|---|---|---|
| pansou checkBaidu | github.com/fish2018/pansou → service/check_service.go | 15085★ MIT 2026-10 活 | 列表绿 | POST pan.baidu.com/share/verify?surl=&pwd=（form: pwd/vcode/vcode_str，零Cookie→randsk）→ GET pan.baidu.com/share/list?web=1&page=1&num=20&order=time&desc=1&showempty=0&shorturl=&root=1&clienttype=0 仅带 Cookie: BDCLND=randsk；errno 谱：0=活，-9/-12=码错，-7/105/115/117/145=失效 | A |
| bdn PROTOCOL.md（本地资产） | E:\AI-Station\逆向工程\baidu-netdisk\PROTOCOL.md | 1029-30 实测 | 登录态对照 | G10 节：verify(8001=触发验证码)→share/list（shorturl 去前导1，web=5&channel=chunlei&app_id=250528）→transfer errno2 参数门 | A |
| LinkSwift 百度面 | github.com/hmjz100/LinkSwift | 36366★ AGPL 2026-10-27 活 | 直链红佐证 | 端点原文：pan.baidu.com/api/sharedownload?channel=chunlei&clienttype=0&web=1&app_id=250528；rest/2.0/xpan/share?method=list；share/tplconfig?fields=sign（分享页反爬sign）；openapi.baidu.com OAuth token。v1.1.1.6（2025-07-28）废弃百度分享页下载+BDUSS→AccessToken=免登直链死期锚点 | A |
| baiduwp-php | github.com/yuantuo666/baiduwp-php | 6336★ MIT 2024-04 停 | 红→中转模式 | README 自述：用 SVIP 账号 Cookie(BDUSS) 取链接发给访客=PD 后继标准形态 | B |
| 94list | github.com/codehub666/94list | 1785★ MIT 2024-08 停 | 红→中转模式 | SVIP 代理提取高速链接；README 风控警告：官方会限制/封号/封IP，商业用途后果更重 | B |
| HkList-laravel（原94list-laravel） | github.com/HkList/HkList-laravel | 2★ MIT 2025-02 archived | 同上 | Laravel 重构版 | C |
| gopeed-extension-baiduwp | github.com/monkeyWie/gopeed-extension-baiduwp | 2077★ 无证 2026-03 活 | 需登 | Gopeed 扩展，用户自带 Cookie/AccessToken 解析 | B |
| BaiduPCS-Go（qjfoidnh 后继） | github.com/qjfoidnh/BaiduPCS-Go | 5856★ 2026-09 活 | 需登 | iikira 原版（已 404）后继；dlink→PCS 302+UA netdisk 机制参照 | B |
| baidu-autosave | github.com/kokojacket/baidu-autosave | 322★ AGPL 2026-03 活 | 需登(转存) | Flask 自动转存；内置重命名频率限制提醒避 API 风控=节流情报 | B |
| baiduwp-bot | github.com/z-mio/baiduwp-bot | 101★ MIT archived | 同 baiduwp-php | TG bot 皮 | C |
| QiQUQ/baiduwp | github.com/QiQUQ/baiduwp | 14★ MIT 2020 停 | 历史遗产 | CF Workers 版 PD Web | C |
| TkzcM/baiduwp（原版 JS） | github.com/TkzcM/baiduwp | 404 已删 | D | baiduwp-php 上游，仓库已蒸发（删除原因未核） | D |
| tychxn/baidu-wangpan-parse | github.com/tychxn/baidu-wangpan-parse | 130★ MIT 2018 archived | 历史 | PD 时代解析件 | C |
| CSDN API 自动化实战 | blog.csdn.net/weixin_32520095/article/details/165717896 | 未核 | 黄 | shorturl 传参即回 shareid/uk+列表（与 pansou 配方互证） | C |
| 百度开放平台（官方） | pan.baidu.com/union | 官方在役 | 红（必须授权） | 官方 API 全家要 access_token，无匿名面 | D(对免登) |

小节结论：列表免登绿（pansou 在役零Cookie配方，含码链 verify 也免登，唯 8001 验证码软门）；直链红（生态退到 SVIP 中转号池）。

## 2. 阿里云盘/alipan（12 条）

| 名称 | url | 活性 | 免登 | 关键端点/参数 | verdict |
|---|---|---|---|---|---|
| go-aliyundrive SDK | github.com/chyroc/go-aliyundrive | 在役 | 列表绿 | POST https://api.aliyundrive.com/adrive/v3/share_link/get_share_by_anonymous，body share_id | A |
| pansou checkAliyun | github.com/fish2018/pansou | 15085★ 活 | 列表绿 | 同上 + 头 origin/referer=https://www.alipan.com | A |
| boxplayer share.ts | github.com/gaozhangmin/boxplayer → src/aliapi/share.ts | 7468★ GPL-3.0 2026-10-30 活 | 列表绿/下载红 | 链路：get_share_by_anonymous → v2/share_link/get_share_token → 分享文件 list（share_token 即可，无需用户token）→ 转存 ApiSaveShareFilesBatch 才要用户 token | A |
| OpenList aliyundrive_share 驱动 | github.com/OpenListTeam/OpenList → drivers/aliyundrive_share | 25363★ AGPL 2026-10-30 活 | 需登(挂载) | refresh_token required:true；调 api.alipan.com/v2/share_link/get_share_token + /adrive/v3/file/list | B |
| aliyundrive-webdav 原版 | github.com/messense/aliyundrive-webdav | 9728★ MIT archived 2026-02 | 需登 | refresh_token→webdav | C |
| aliyundrive-webdav fork | github.com/eritpchy/aliyundrive-webdav | 1062★ 无证 archived | 需登 | 续命 fork | C |
| wxy1343/aliyunpan | github.com/wxy1343/aliyunpan | 472★ GPL-3.0 2023-02 停 | 需登 | Python 客户端；停更与 2023 整改同期（律师函传闻未核不采信） | C |
| liupan1890/aliyunpan（小白羊） | github.com/liupan1890/aliyunpan | 11809★ 无证 2022-10 停 | 需登 | Electron 客户端，整改潮后停更 | C |
| mingcheng/aliyunpan | github.com/mingcheng/aliyunpan | 0★ MIT 2026-10-21 活 | 需登 | Rust 分享 API（src/api/share.rs） | B |
| 阿里 PDS GetDownloadUrl 官方文档 | help.aliyun.com（PDS API 2022-03-01 GetDownloadUrl） | 官方 | 下载红 | share 场景要 share_id + x-share-token 头，且需 OAuth access_token | A(官方口径) |
| alist issue #3879 | github.com/AlistGo/alist/issues/3879 | 2023-03 | 风控证据 | 开放平台整改 refresh_token 获取失败潮 | 风控 |
| alist discussion #5510 | github.com/AlistGo/alist/discussions/5510 | 2023 | 风控证据 | 第三方 token 批量失效 | 风控 |

小节结论：列表免登绿（anonymous+share_token 全匿名，boxplayer 在役代码可抄）；直链红（openapi 强制 OAuth，2023 整改后第三方 token 高危）。

## 3. 夸克网盘（11 条）

| 名称 | url | 活性 | 免登 | 关键端点/参数 | verdict |
|---|---|---|---|---|---|
| pansou checkQuark | github.com/fish2018/pansou | 15085★ MIT 活 | 列表绿 | POST https://drive-h.quark.cn/1/clouddrive/share/sharepage/token（body pwd_id/passcode）→stoken；GET https://drive-pc.quark.cn/1/clouddrive/share/sharepage/detail?pwd_id=&stoken=&ver=2&pr=ucpro（零Cookie） | A |
| quark-auto-save | github.com/Cp0204/quark-auto-save | 3085★ AGPL 2026-07 活 | 列表绿/下载需登 | quark_auto_save.py:499/:513 同款 token+detail；:652 GET {BASE_URL}/1/clouddrive/file/download（BASE_URL=drive-pc.quark.cn，需 __puus Cookie）；wiki 有 API 接口页可外控 | A |
| QuarkPanTool | github.com/ihmily/QuarkPanTool | 1473★ Apache-2.0 2025-12 活 | 需登 | playwright 网页登录→批量转存/分享/下载 | B |
| quark-tracker | github.com/Fanxiaoyao66/quark-tracker | 2★ AGPL 2026-10 活 | 转存链 | 分享→转存→aria2c 全速→TMDB 改名（quark-auto-save 姊妹件） | B |
| quark-public-share-downloader | github.com/kunhai-88/quark-public-share-downloader | 0★ 2026-09 | 声称免登 | Codex skill：预检/下载/续传/校验；README 明示不绕登录墙/频控/平台限制 | B(待验) |
| quark-save | github.com/henggedaren/quark-save | 42★ Apache-2.0 2024-04 | 需登 | PHP 转存件（sharepage 端点同族） | C |
| TVSpider quark_api.js | github.com/jadehh/TVSpider | 697★ GPL-3.0 2024-09 停 | 需登 | 影视聚合内夸克 API 封装 | C |
| 2beetle/tgbot | github.com/2beetle/tgbot → utils/quark.py | 47★ 2026-05 活 | 需登 | TG bot 转存+取链 | C |
| larryistthere/quark-share-downloader | github.com/larryistthere/quark-share-downloader | 0★ MIT 2026-07 | 未核 | 下载器雏形 | C |
| LinkSwift 夸克面 | github.com/hmjz100/LinkSwift | 36366★ 活 | 列表绿/下载绑Cookie | drive-pc.quark.cn/1/clouddrive/file/download?pr=ucpro&fr=pc&sys=win32&ve=6.9.7.761；drive-social-api.quark.cn/1/clouddrive/chat/conv/file/acquire_dl_token；v1.1.4(2026-09)「优化夸克 Cookie 传递」=下载绑 Cookie 实锤；2025-12-26 适配夸克分享页 | A |
| 夸克免登专篇 gist | gist.github.com/myheart111/a04e291831b9b906f5b6ba2b0f1b72b8 | 2026-10-24 | 红佐证 | 免费号约0.06MB/s、注册+86 only、直链绑 IP、分享页推 APP；错误码族：提取码错误/分享已失效/违规 | C(商业源) |

小节结论：列表免登绿（token→stoken→detail 零Cookie）；直链红（download 需 Cookie+绑 IP；生态=Cookie 池转存）。

## 4. 迅雷网盘/迅雷快传（7 条）

| 名称 | url | 活性 | 免登 | 关键端点/参数 | verdict |
|---|---|---|---|---|---|
| pansou checkXunlei | github.com/fish2018/pansou | 15085★ 活 | 列表绿带门 | GET https://api-pan.xunlei.com/drive/v1/share?share_id=&pass_code=&limit=100&pass_code_token=&page_token=&thumbnail_size=SIZE_SMALL；头 x-client-id: ZUBzD9J_XPXfn7f7、x-device-id: 5505bd0cab8c9469b98e5891d9fb3e0d、x-captcha-token；captcha_token 来自 POST https://xluser-ssl.xunlei.com/v1/shield/captcha/init（action:"get:/drive/v1/share" + captcha_sign + package_name: com.xunlei.browser + client_version 1.10.0.2633 + redirect_uri xlaccsdk01://xunlei.com/callback）；响应含 url 字段=真验证码墙，弃 | A |
| urldb xunlei_pan.go | github.com/ctwj/urldb → common/xunlei_pan.go | 491★ GPL-3.0 2026-10-29 活 | 需登 | xluser-ssl.xunlei.com/v1/auth/token（refresh_token grant）+同款 captcha 头族 | A(登录态端点) |
| YunX | github.com/CYQawa/YunX | 5949★ AGPL 2026-10-24 活 | 需登 | Kotlin 迅雷云盘客户端（XunleiApi.kt） | B |
| xiageba2 | github.com/liumingye/xiageba2 | 14★ 2026-10-28 活 | 需登(转存站) | 多盘搜索+转存+重分享模式（server/api/source/geturl.ts） | B(模式) |
| nas-xunlei-helper | github.com/moonlightMing/nas-xunlei-helper | 0★ MIT 2026-10 活 | 需登 | 浏览器扩展推送 thunder:// 到 NAS 迅雷 | C |
| 迅雷快传（遗产） | baike.baidu.com/迅雷快传 | 2011 产物 | D | 已并入迅雷云盘 pan.xunlei.com/s/；f.xunlei.com 无官方停服公告但属死遗产（关闭日未核） | D |
| 无账号指南 gist（迅雷段） | gist.github.com/myheart111/c7240ff6bc6ec0265e93ad20869a03a7 | 2026-10-24 | 红佐证 | 迅雷分享页浏览器不下载只跳 APP；全速=APP 内 SVIP 专属 | C(商业源) |

小节结论：列表免登绿但带 captcha-sign 门槛（pansou 固定 client_id+device_id+签名舞步在役，真验证码触发即熔断）；直链红（分享页无 web 下载，drive API 要 token）。

## 5. 跨盘通用件与风险情报（10 条）

| 名称 | url | 活性 | 定位 | verdict |
|---|---|---|---|---|
| LinkSwift（油小猴系续作） | github.com/hmjz100/LinkSwift | 36366★ AGPL 2026-10-27 活 | 九盘直链油猴=端点地图（AGPL→只借端点情报不抄码） | A(端点)/pattern |
| linkswift-enhanced | github.com/dx-y/linkswift-enhanced | 82★ AGPL 2026-10-28 活 | 增强版（自动转存/批量/下载历史） | pattern |
| LinkSwift Chrome 移植 | github.com/ollpou/LinkSwift_- | 6★ AGPL 2026-10-17 活 | MV3 原生化 | pattern |
| 油小猴原版助手 | github.com/syhyz1990/baiduyun（youxiaohou.com / baiduyun.wiki） | 4697★ AGPL 2024-07 停 | LinkSwift 上游 | C(历史) |
| OpenList | github.com/OpenListTeam/OpenList | 25363★ AGPL 2026-10-30 活 | 驱动面普查：无任何免登分享驱动（baidu_netdisk/quark_open/quark_uc/thunder_browser/thunderx/aliyundrive_share 全要自家凭证）——负面结论亦是情报 | A |
| alist | github.com/AlistGo/alist（PR #6645 阿里 cdn 直链） | 50379★ AGPL 活 | 聚合器参照 | A(参考) |
| JxPan | github.com/ByLsPro/JxPan | 167★ Apache-2.0 2026-10-01 活 | CF Workers 多盘直链解析（JSON/302） | B |
| pansou 母体 | github.com/fish2018/pansou | 15085★ MIT 活 | 网盘资源聚合搜索+多盘免登存活校验=检索层可整体借（MIT 可复用） | A+reuse |
| cloud-drive-downloader skill | github.com/lisong2003-lgtm/cloud-drive-downloader | 0★ 2026-10-28 活 | Agent Skill 多盘下载（凭证保护设计） | C |
| 无账号下载指南+两 gist+baidufast | github.com/myheart111/-baidu-pan-download-guide；gist c7240ff6 / a04e2918；baidufast.com | 2026-10 在役 | 2026 死活地图+付费代取（150MB 内免费）=免登下载已产业化证据；自营利益相关打折采信 | C |

（另：知乎 2026 不限速攻略 zhuanlan.zhihu.com/p/2010073510807103477、Greasyfork「Teng 网盘直链助手免验证码」2025-09 更新——均未核，C 级旁证，不计入实收。）

## 6. 风控红线与节流拟人（护栏）

1. 刑事红线：PanDownload 作者 2020-04-15 被捕，罪名=提供侵入/非法控制计算机信息系统程序工具罪（扬州宝应警方；报案由=用户数据泄露；百度表态积极配合警方）。=> PAN-HUNTER 只做公开分享的检索/列表/取链/下载通道，不做限速破解、不碰无授权私有数据（与 IDEA_SEED 红线一致）。
2. 百度软门：share/verify 空 vcode 可通行，8001=验证码触发（本地 bdn 实测）→熔断退避；errno 105/115/117/145=失效不重试；转存/重命名高频是风控信号（baidu-autosave 专设限频提醒）。
3. 阿里 token 潮：2023-03 开放平台整改批量杀 refresh_token（alist #3879/#5510）→号池 OAuth 按耗材设计；匿名列表端点独立节流防连坐。
4. 夸克 IP 绑定：下载票绑请求 IP+Cookie→取链与下载同出口同 Cookie；免费号 0.06MB/s 实测口径。
5. 迅雷 captcha：share 列表先过 shield/captcha/init 签名；响应带 url 字段=真验证码→放弃该链（pansou 同款处置）。
6. 通用节流（抄 pansou 工程设计）：单飞合并(inflight)、状态化 TTL 缓存（活链长缓存/死链不重打）、固定桌面 UA+origin/referer 头族、每盘独立并发帽≤4、错误码熔断表。

## 7. 给 PAN-HUNTER 的处方
- L0/L1 检索+列表层：四盘全部纯 HTTP 免登可行（配方在手；pansou MIT 架构可借）。
- L2 下载层四盘全红：产业解=号池中转（94list/baiduwp-php 模式）或付费代取（baidufast 模式）——与免登北极星冲突，需用户裁决口径（建议默认：全量元数据索引+小文件通道，直链层做可选插件）。
- 优先序建议：夸克（资源最活跃/脚本生态最新）>百度（存量最大）>阿里（匿名面最干净）>迅雷（门槛最高产出最低）。

## Working notes（原始核验流水）
## Working notes (checkpoint, 按核验顺序)
1. 本地 bdn PROTOCOL.md (E:\AI-Station\逆向工程\baidu-netdisk\PROTOCOL.md) G10 share 节：百度旧代 share/verify→share/list→share/transfer 链 2026-10-29 实测存活，但 bdn 实测形态全带 BDUSS+STOKEN+randsk Cookie。share/list 参数 shorturl&root=1&web=5&channel=chunlei&app_id=250528。免登与否未实测 → 关键待验点。
2. gh api 实核：tychxn/baidu-wangpan-parse 130★ MIT 2018 死档(archived)；Cp0204/quark-auto-save 3085★ AGPL 2026-07 活；ihmily/QuarkPanTool 1473★ Apache-2.0 2025-12 活；AlistGo/alist 50379★ AGPL 2026-10-21 活；OpenListTeam/OpenList 25363★ AGPL 2026-10-30 活；eritpchy/aliyundrive-webdav 1062★ 无证 2024-07 档；messense/aliyundrive-webdav 9728★ MIT 2026-02 档(archived)；ByLsPro/JxPan 167★ Apache-2.0 2026-10-01 活。
3. gh api 实核二批：yuantuo666/baiduwp-php 6336★ MIT 2024-04；monkeyWie/gopeed-extension-baiduwp 2077★ 无证 2026-03 活；hmjz100/LinkSwift 36366★ AGPL 2026-10-27 活(八盘直链油猴)；dx-y/linkswift-enhanced 82★ AGPL 2026-10-28 活；z-mio/baiduwp-bot 101★ MIT；Fanxiaoyao66/quark-tracker 2★ AGPL 2026-10 活(夸克分享→转存→aria2)。
4. gist c7240ff6（2026-10-24 更新，作者自营 baidufast.com 付费代取服务，陈述打折采信）：PanDownload 2020 死、复刻版全是死/马；百度/夸克 userscript 直链已闭合，夸克下载票绑定请求 IP；123pan 免登 2025-11-26 移除；夸克注册 +86 only、免费号 ~0.06MB/s；迅雷分享页浏览器不下载只跳转 APP；阿里云盘该服务商尚不支持（更难）。C 级商业源，格局陈述与他源一致。
5. gist a04e2918（夸克专篇，同作者）：夸克分享页推 APP 无下载钮；错码/失效/违规错误码族在案（提取码错误/分享已失效/违规）。C 级。
6. 本地 pan-hunter/IDEA_SEED.md：免登=只打公开分享面，节流+拟人，绿黄红分级如实。
7. fish2018/pansou 15085★ MIT 活(2026-10-12)：service/check_service.go = 四盘+115/天翼/123/移动免登存活校验活配方（gh api 原文已读）。百度: POST share/verify?surl=&pwd=（form pwd/vcode/vcode_str，零Cookie）→randsk→GET share/list?web=1&shorturl=&root=1&clienttype=0 仅带 Cookie:BDCLND=randsk → errno0+list=免登列表成立；errno谱 -9/-12码错/-7,105,115,117,145失效。
8. 迅雷免登列表配方（pansou原文）：GET https://api-pan.xunlei.com/drive/v1/share?share_id=&pass_code=&limit=100&pass_code_token=&page_token=&thumbnail_size=SIZE_SMALL，头 x-client-id:ZUBzD9J_XPXfn7f7 x-device-id:5505bd0c... x-captcha-token；captcha_token 来自 POST https://xluser-ssl.xunlei.com/v1/shield/captcha/init（action:"get:/drive/v1/share"+captcha_sign+package com.xunlei.browser），若回 url 字段=真验证码墙。
9. 夸克免登列表配方（pansou原文）：POST https://drive-h.quark.cn/1/clouddrive/share/sharepage/token {pwd_id,...}→stoken；GET https://drive-pc.quark.cn/1/clouddrive/share/sharepage/detail?pwd_id=&stoken=&ver=2&pr=ucpro。零Cookie。
10. 阿里免登列表配方（pansou原文+chyroc/go-aliyundrive）：POST https://api.aliyundrive.com/adrive/v3/share_link/get_share_by_anonymous?share_id= 头 origin/referer=alipan.com。零Cookie零token。
11. OpenList 驱动面（gh api drivers 目录实核）：无任何免登分享驱动。aliyundrive_share 要 refresh_token(required)+share_id，调 api.alipan.com/v2/share_link/get_share_token+/adrive/v3/file/list；baidu_netdisk/quark_open/quark_uc/thunder_browser/thunderx 全自家凭证。=> 官方聚合器路线=登录态。
12. LinkSwift(hmjz100,36366★,AGPL,2026-10-27活)端点原文：百度 pan.baidu.com/api/sharedownload?channel=chunlei&clienttype=0&web=1&app_id=250528 + rest/2.0/xpan/share?method=list + share/tplconfig?fields=sign + openapi.baidu.com OAuth token；夸克 drive-pc.quark.cn/1/clouddrive/file/download?pr=ucpro&fr=pc&sys=win32&ve=6.9.7.761 + drive-social-api...acquire_dl_token；迅雷 api-pan.xunlei.com/drive/v1/files/ + xluser-ssl.xunlei.com/v1/shield/captcha/init。更新日志关键史：2025-07-28 v1.1.1.6「废弃百度BDUSS Cookie相关代码转向AccessToken」「废弃百度网盘分享页面下载相关代码」=百度分享页免登直链死期锚点；2025-12-26 适配夸克UC分享页；2026-09-09 优化夸克Cookie传递。
13. baiduwp-php(yuantuo666,6336★,MIT,2024-04停)：本质=SVIP账号代取直链发给访客（PanDownload后继形态）；关联 94list(codehub666,1785★,MIT,2024-08停)/HkList-laravel。
14. 风控红线已录：PanDownload 作者2020-04-15被捕（罪名=提供侵入/非法控制计算机信息系统程序工具罪，secrss/stcn在案）；阿里2023-03开放平台整改→alist refresh_token失效潮(GH issues #3879/#5510)；gist证词=百度封userscript直链/夸克下载票绑IP/123pan免登2025-11-26移除。
15. 迅雷快传：2011年产物已并入迅雷云盘，f.xunlei.com 无官方停服公告但属遗产（未核精确日期）。
16. 批量活性实核：pansou 15085★/boxplayer 7468★(2026-10-30活)/liupan1890-aliyunpan 11809★(2022停,无证)/syhyz1990-baiduyun 4697★AGPL(油小猴原版,2024-07停)/qjfoidnh-BaiduPCS-Go 5856★(2026-09活)/ctwj-urldb 491★(2026-10-29活)/jadehh-TVSpider 697★(2024-09停)/wxy1343-aliyunpan 472★GPL(2023-02停)/henggedaren-quark-save 42★/2beetle-tgbot 47★(2026-05活)/z-mio-baiduwp-bot 101★arch。
