# R4 运营商系+小四盘免登可行性（天翼/移动/沃盘/115/123/UC）

> PAN-HUNTER 战役 R4 研究卷宗 | 2026-10-30 | 实收 46 条
> 方法: gh api 星数/许可证/末push核验 + 源码端点提取 + 假码活性探测(curl 实测 2026-10-30) + WebSearch 生态面
> 图例: 绿=免登列表+直链均通 | 黄=半通(仅列表或需会话) | 红=无公开免登路 | A配方(可直接复用)/B思路/C参考/D死

## 0. 六盘总裁决

| 盘 | 分享链接形态 | 免登列表 | 免登直链 | 判色 | 一句话 |
|---|---|---|---|---|---|
| UC网盘 | drive.uc.cn/s/{pwd_id} fast.uc.cn/s/ | 通(实测) | 通(实测+MIT件) | 绿 | pc-api.uc.cn 三步免登, 阿里系门没关 |
| 115 | 115.com/s/{code}?password= anxia.com/s/ | 通(实测) | 通(skip_login_downurl) | 绿 | webapi 有官方"跳过登录下载"端点; 开放平台8月停服 |
| 123云盘 | 123pan.com/s/{key} 域名20+轮换 | 通(实测) | 通(download_info+签名, 可选token) | 绿 | api.123278.com 免登列表+encode123签名直链 |
| 移动云盘139 | yun.139.com 分享经AES密文 | 通(YunX源码注释实锤空cookie列目录) | 需登录(dlFromOutLinkV3要authorization) | 黄(列表绿) | AES密钥公开, 提取码明文回吐 |
| 天翼云盘189 | cloud.189.cn/t/{code} | 需Session(实测InvalidSessionKey) | 历史可行(greasyfork件), 现役全账号化 | 黄 | 免登富矿假设在此盘不成立 |
| 沃盘联通 | pan.wo.cn/s/{code} | SPA无公开API | 无 | 红 | 开源全是账号客户端, 分享API空白, 生态最小 |

富矿裁决: UC > 115 > 123 >> 139 > 天翼 >> 沃盘。
"运营商盘防护松=免登富矿"假设部分证伪: 最松的是 UC(阿里系但PC API敞开)与115(官方保留skip_login端点); 运营商盘中仅139列表松; 天翼有Session墙; 沃盘连路都没有。

## 1. 天翼云盘 (cloud.189.cn)

链路形态: 短链 cloud.189.cn/t/{code} (实测假码302跳404页); H5端 m.cloud.189.cn; open API 族 cloud.189.cn/api/open/**.action
免登现状: 实测 GET cloud.189.cn/api/open/share/getShareInfo?shareId=&shareCode= 返回 InvalidSessionKey (cookieUserSession is null) — 列表就要 SESSION(SSK)。2020年代 greasyfork 有免登天翼油猴件(v0.8, 未核现状); 现役活件(LinkSwift/OpenList/PanIndex/CloudSaver)天翼全是账号系。nfd 旧版曾支持天翼后撤除。下载动作 api/open/file/getFileDownloadUrl.action (LinkSwift config/tianyi.json 原档)。

| 名称 | url | 活性 | 免登 | 关键端点 | verdict |
|---|---|---|---|---|---|
| 189-down | github.com/libsgh/189-down | 84★/无License/2023-02停 | 前端免登, 后端私服 | api.noki.top/pan/cloud189/shareToDown(需账密池) | C思路(无证勿抄码) |
| alimalls/189 | github.com/alimalls/189 | 9★/2024停 | 同上fork | 同上 | D |
| 免登天翼油猴件 | greasyfork.org/en/scripts/401709 | 2020年代 | 历史免登 | 未核(站点网络不通) | C未核 |
| LinkSwift | github.com/hmjz100/LinkSwift | 36370★/AGPL/2026-10超活 | 否(浏览器登录态) | getFileDownloadUrl.action + ssoH5 | B思路 |
| PanIndex | github.com/libsgh/PanIndex | 1399★/AGPL/2025-06 | 否(账号) | open.e.189.cn oauth2全登录流+family api | B思路(最全189 API图) |
| OpenList 189三驱动 | github.com/OpenListTeam/OpenList | 25363★/AGPL/当日活 | 否(账号) | 189/189pc/189_tv | B思路 |
| CloudSaver | github.com/jiangrui1994/CloudSaver | 9413★/MIT/2026-10活 | 转存型(账号) | 天翼转存 | C(检索/转存源) |
| Cloud189签到SDK | github.com/ming938428016/Cloud189 | 小/旧 | 否 | 登录签到 | C |

生态: 中等偏温 — CloudSaver/urldb 含天翼转存; 动漫剧集软件站有存量; 不敌夸克UC。
作战: 突破点=匿名SESSION(m.cloud.189.cn H5首访下发SSK后携入open api), 不成则账号池(PanIndex配方)。

## 2. 移动云盘/和彩云 (yun.139.com)

链路形态: API基址 share-kd-njs.yun.139.com/yun-share/richlifeApp/devapp/IOutLink/*; 个人云 personal-kd-njs.yun.139.com/hcy/*(渠道头10000034/mcloud 7.17.9写死, YunX注证明文JSON无Cookie)。分享参数AES加密, 密钥 PVGDwmcvfs1uV3d1 公开(YunX C139Constants.kt 原文)。
免登现状: 实测假payload打 getOutLinkInfoV6 返回 resultCode 01000101(端点活无登录墙)。YunX源码注释实锤: 139列表端点空cookie也能列目录, 下载/转存仍需登录; getOutLinkGeneral 明文回吐提取码passwd; dlFromOutLinkV3 直链要 account+authorization。

| 名称 | url | 活性 | 免登 | 关键端点 | verdict |
|---|---|---|---|---|---|
| YunX | github.com/CYQawa/YunX | 5949★/AGPL/2026-10-24超活 | 列表免登/直链登录 | getOutLinkInfoV6 / dlFromOutLinkV3 / getOutLinkGeneral + AES KEY | A思路(AGPL只取端点事实勿抄码) |
| YunGet | github.com/jiayuxuan123/YunGet | 305★/AGPL/2026-10-29活 | 同上 | 同YunX二代 | B |
| nfd EC移动云空间 | github.com/qaiu/netdisk-fast-download | 3425★/MIT/2026-10活 | 免登 | ecpan.cn/web/#/yunpanProxy (注意是ecpan非139) | B(同名陷阱) |
| OpenList drivers/139 | github.com/OpenListTeam/OpenList | 活 | 否(账号) | personal-kd-njs族 | C |
| 青龙签到系 | github.com/Le0nByte/QL_TimingScript | 活 | 否 | 签到领容量 | D(与分享无关) |

生态: 小 — 无主流聚合检索源收录139; 移动全家桶用户基数大, 资源以微信转存链散布。
作战: 列表免登配方端点+密钥+提取码回吐齐备(半天量); 直链先做断链检测收录, dlFromOutLinkV3 游客化待实测(大概率9188/需authorization)。

## 3. 沃盘/联通云盘 (pan.wo.cn)

链路形态: 分享页 pan.wo.cn/s/{code} (实测假码也200 SPA壳, 内容JS渲染); 官网宣传不限速。
免登现状: 红 — 未发现公开分享API; 开源生态全是账号客户端; OpenList wopan 驱动仅 RefreshToken/AccessToken(账号), 无分享挂载。

| 名称 | url | 活性 | 免登 | 关键端点 | verdict |
|---|---|---|---|---|---|
| wopan-sdk-go | github.com/OpenListTeam/wopan-sdk-go | 1★/Apache-2.0/2025-07 | 否(账号) | OpenList官方SDK, 账号api全图 | B思路 |
| OpenList drivers/wopan | github.com/OpenListTeam/OpenList | 活 | 否(账号) | refresh_token+family_id | C |
| wopan-open | github.com/crmmc/wopan-open | 5★/MIT/2026-10活 | 否(账号) | 三端账号客户端 | C |
| wopan-cf-worker | github.com/qhappyc/wopan-cf-worker | 6★/无证/2026-09 | 否(账号) | CF Workers文件服务移植 | C(无证) |
| didili/wopan | gitee.com/didili/wopan | 未核 | 未核 | gitee api合集(PanIndex#325引) | C未核 |
| pan.wo.cn 分享页 | pan.wo.cn/s/{code} | 官方 | 页面可看 | 无公开JSON api | 待自研抓包 |

生态: 最小 — 无检索源收录, 分享文化弱。
作战: 六盘最低优先; 若做需自抓H5/APP分享接口(联通投入小前端api可能裸奔——纯假设未核)。

## 4. 115网盘 (115.com)

链路形态: 115.com/s/{share_code}?password={code} / anxia.com/s/; webapi.115.com 与 CDN 域 115cdn.com。
免登现状: 绿(实测) — 假码打 webapi.115.com/share/snap?share_code=&receive_code=&cid= 返回 state:false errno:990002 参数错误(端点活无登录墙); MIT 件 P115Tool 走 115cdn.com/webapi/share/snap(列表) + share/skip_login_downurl(POST官方保留的免登直链端点, 名字即语义)。注意: 官方开放平台 open.115.com 已于2026-08暂停服务(新浪/凤凰/搜狐2026-08-09报道) — OAuth路线死, webapi免登路线反成活路。风险: 游客文件数/大小限额与风控(锁UA/验证码)未实测。

| 名称 | url | 活性 | 免登 | 关键端点 | verdict |
|---|---|---|---|---|---|
| nfd P115Tool | github.com/qaiu/netdisk-fast-download | 3425★/MIT/2026-10活 | 是 | 115cdn.com/webapi/share/snap + share/skip_login_downurl | A配方 |
| p115client | github.com/ChenyangGao/p115client | 73★/MIT/2026-09活 | 否(cookie) | 115全家桶python(分享/转存/秒传) | A(账号侧补全) |
| 115driver | github.com/SheltonZhu/115driver | 213★/NOASSERTION/2026-09活 | 否(cookie) | webapi.115.com Go封装(OpenList依赖) | B |
| TgtoDrive | github.com/walkingddd/TgtoDrive | 2223★/MIT/2026-10活 | 转存型 | 115/123/光鸭转存+302 | B |
| fake115uploader | github.com/orzogc/fake115uploader | 384★/GPL-3/2026-09活 | 否 | 模拟客户端(签名加密参考) | C |
| 115drive-webdav | github.com/gaoyb7/115drive-webdav | 633★/2025-04 | 否 | webdav桥 | C |
| 115-plus-desktop | github.com/lvzhenbo/115-plus-desktop | 381★/MIT/2026-10活 | 否 | 基于开放平台(已停服) | C(受停服打击) |
| P115-Share | github.com/ListeningLTG/P115-Share | 16★/2026-10活 | cookie | 分享助手 | C |
| p115-Docker | github.com/DDSRem-Dev/p115-Docker | 5★/MIT/2026-06 | cookie | 工具集成镜像 | C |
| OpenList 115三驱动 | github.com/OpenListTeam/OpenList | 活 | 115_share需cookie; 115_open停服 | webapi.115.com/share/snap,downurl | B |
| open.115.com | open.115.com | 2026-08停服 | OAuth曾通 | doc.oplist.org | D(现况) |
| iScript | github.com/PeterDing/iScript | 5131★/MIT/2022停 | 否 | 115老api | D(老) |

生态: 大 — 影视圈主力盘; panhub/CloudSaver/urldb 均收录; 存量厚。
作战: 克隆 nfd P115Tool(MIT); 补游客限额与UA风控实测即可上岗。

## 5. 123云盘 (123pan.com)

链路形态: 123pan.com/s/{shareKey}(可带密码); 分享域名20+个轮换(123865/123957/123panpay…, nfd Ye2Tool正则原文即字典); api域 api.123278.com(同轮换); 验证域 yun.123pan.com(OpenList issue实证)。
免登现状: 绿(实测) — 假码打 api.123278.com/b/api/share/get?shareKey=&SharePwd=&ParentFileId=&Page= 返回 code:400 ShareKey格式异常(端点活无登录墙); 直链 b/api/file/download_info + batch_download_share_info 免登可走, 部分分享需token(auths可选注入); 直链带 encode123 签名(六段 timeLong|a|url|way|version|y)。免费层直链流量额度/游客限速未实测。官方开放平台 open.123pan.com(PyPI pan123封装), 直链为付费特性。

| 名称 | url | 活性 | 免登 | 关键端点 | verdict |
|---|---|---|---|---|---|
| nfd Ye2Tool | github.com/qaiu/netdisk-fast-download | 3425★/MIT/2026-10活 | 是 | api.123278.com/b/api/share/get + file/download_info + encode123 | A配方 |
| OpenList 123_share | github.com/OpenListTeam/OpenList | 活 | 挂载免登(ShareKey+Pwd, token可选) | 同api族; 另有123/123_link/123_open | A配方(Go) |
| 123pan_unlock | github.com/QingJ01/123pan_unlock | 1051★/Apache-2.0/2025-11 | 登录免费号解锁 | 前端拦截改请求 | B |
| 123pan第三方客户端 | github.com/123panNextGen/123pan | 572★/GPL-3/2026-10活 | 否(账号) | 多方式解除部分流量限制 | B(限速对抗参考) |
| 123panYouthMember | github.com/hmjz100/123panYouthMember | 1096★/AGPL/2025-12 | 登录 | 会员模拟 | C |
| pan123 (PyPI) | pypi.org/project/pan123 | 活 | 开放平台OAuth | open.123pan.com官方api封装 | B(官方路) |
| open.123pan.com | open.123pan.com | 官方活 | OAuth+付费直链 | 官方文档 | C(变现通道非免登) |
| 123解锁修复版油猴 | greasyfork.org/cs/scripts/598793 | 活 | 登录免费号提分享直链 | 载荷重写(细节未核) | B未核 |

生态: 中大 — 软件游戏学习资源主力; CloudSaver/urldb/panhub收录; 免登录看列表+会员直链心智普遍。
作战: A配方双源(MIT nfd + OpenList只取事实); 轮换域名表字典化。

## 6. UC网盘 (drive.uc.cn)

链路形态: drive.uc.cn/s/{pwd_id}?public=1 与 fast.uc.cn/s/{pwd_id}; API前缀 pc-api.uc.cn/1/clouddrive/(与夸克同族, pr=UCBrowser)。
免登现状: 绿(实测) — 假码 POST share/sharepage/token?entry=ft&fr=pc&pr=UCBrowser 返回 status:404 code:41006 分享不存在(端点活无登录墙)。三步: 1 share/sharepage/token 取stoken; 2 transfer_share/detail?pwd_id&passcode&stoken 列目录(支持文件夹); 3 file/download 直链; 需管 __puus cookie(55min刷新走member接口)。限速未实测(夸克系游客直链常有并发/时效限制)。

| 名称 | url | 活性 | 免登 | 关键端点 | verdict |
|---|---|---|---|---|---|
| nfd UcTool | github.com/qaiu/netdisk-fast-download | 3425★/MIT/2026-10活 | 是 | pc-api.uc.cn/1/clouddrive/三步+__puus管理 | A配方 |
| xinyue-search | github.com/675061370/xinyue-search | 616★/MIT/2025-12 | 转存账号 | UC检索转存索引 | B(检索源思路) |
| urldb | github.com/ctwj/urldb | 491★/GPL-3/2026-10活 | 转存型 | UC/天翼/123/115/夸克自动化转存 | B |
| cloud-auto-save-x | github.com/OzoO0/cloud-auto-save-x | 230★/AGPL/2026-09活 | 转存型 | UC/115/123/天翼/移动云盘追剧 | B |
| OpenList quark_uc(+tv) | github.com/OpenListTeam/OpenList | 活 | 否(账号) | 同api族+cookie | C |
| LinkSwift/YunX/YunGet 的UC | 见各节 | 超活 | cookie增强 | 同族 | B |

生态: 大 — 与夸克并列短剧影视分享主力; xinyue-search/urldb收录; 检索覆盖价值高。
作战: A配方直接克隆(MIT), __puus刷新照抄; 夸克经验可平移。

## 7. 跨盘通用件与检索源

| 名称 | url | 活性 | 用途 | verdict |
|---|---|---|---|---|
| LinkSwift | github.com/hmjz100/LinkSwift | 36370★/AGPL超活 | 八盘直链油猴(天翼/移动/UC/123) | B思路 |
| netdisk-fast-download | github.com/qaiu/netdisk-fast-download | 3425★/MIT | 聚合解析服务, 本战役第一补给库(UC/115/123/夸克等40+盘, Maven cn.qaiu:parser) | A |
| mediary-scout | github.com/fancydirty/mediary-scout | 1620★/0BSD/2026-10活 | AI影视追更多盘媒体库 | C |
| SmartStrm | github.com/Cp0204/SmartStrm | 783★/2026-10活 | STRM/302直链 | C |
| tampermonkey Self-use | github.com/tampermonkeyStorage/Self-use | 501★/2026-10活 | 多盘搜索播放脚本 | C |
| panhub | github.com/wu529778790/panhub.shenzjd.com | 1785★/2026-10活 | 聚合搜索(夸克/阿里/百度/115/迅雷) | C(检索源) |
| CloudSaver | github.com/jiangrui1994/CloudSaver | 9413★/MIT/2026-10活 | 搜索+转存(115/夸克/天翼/123) | C(检索源) |

检索源覆盖: 夸克/UC/115 > 123 > 天翼 > 139 > 沃盘(零收录)。

## 8. R4 作战总纲

1. 第一波克隆A配方: nfd(MIT)三件套 UcTool/P115Tool/Ye2Tool + OpenList 123_share(Go) — 覆盖UC/115/123三绿盘, 端点实测活。
2. 第二波自研: 139列表(端点+AES密钥+提取码回吐全公开, 半天量) → 再攻 dlFromOutLinkV3 游客化; 天翼匿名SSK(H5首访) → 不成则账号池(PanIndex配方)。
3. 放弃/低优先: 沃盘(红), 115开放平台(2026-08停服)。
4. 风险位: 123轮换域名字典化(nfd正则即字典); 115游客限额未实测; UC __puus 55min需守护; 直链UA/Referer强绑定(nfd源码有现成头组)。

## Working notes (核验流水)

- libsgh/189-down 84★无证2023停, 后端私服需账密 — C/D
- qaiu/netdisk-fast-download MIT 3425★ 2026-10-13活, Maven cn.qaiu:parser 10.2.5, PanDomainTemplate盘码表+UcTool/P115Tool/Ye2Tool端点全档 — A
- hmjz100/LinkSwift AGPL 36370★ 2026-10-27超活, config/tianyi.json 账号端点原档 — B
- CYQawa/YunX AGPL 5949★ 2026-10-24活, C139/Pan115/Pan123 Api+Constants 全档; C139ResolveRepository注释实锤139列表空cookie可列 — A思路
- jiayuxuan123/YunGet AGPL 305★ 2026-10-29活 — B; ctwj/urldb GPL 491★ 2026-10-29活 — B
- OzoO0/cloud-auto-save-x AGPL 230★ 2026-09活 — B; xinyue-search MIT 616★ 2025-12 — B
- 实测2026-10-30假码: 115 share/snap errno990002(活无墙); UC sharepage/token 41006(活无墙); 123 api.123278.com share/get格式异常(活无墙); 189 getShareInfo InvalidSessionKey(要Session); 139 getOutLinkInfoV6 01000101(活); 沃盘假码200SPA壳
- 139 AES密钥 PVGDwmcvfs1uV3d1 (YunX C139Constants.kt); getOutLinkGeneral回吐提取码
- 115开放平台 open.115.com 2026-08停服(新浪/凤凰/搜狐2026-08-09)
- OpenList驱动盘点: 189/189pc/189_tv/139/wopan/115/115_open/115_share/123/123_link/123_open/123_share/quark_uc — 六盘全有账号驱动, 仅115/123有分享挂载
- greasyfork 401709(天翼免登2020)/598793(123解锁) 站点网络不通未核 — C未核
- CloudSaver jiangrui1994 9413★MIT 2026-10-15活; panhub 1785★(检索源); wopan-sdk-go Apache-2.0 1★; SheltonZhu/115driver 213★NOASSERTION 2026-09活; ChenyangGao/p115client MIT 73★ 2026-09活
