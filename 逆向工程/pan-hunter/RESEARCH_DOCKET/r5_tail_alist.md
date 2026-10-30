# R5 调研卷宗: 长尾盘 + alist 生态 (PAN-HUNTER)
- 日期: 2026-10-30 | 研究员: R5 | 范围: A) alist及分叉/免登驱动/端点摘录/搜索生态 B) 长尾盘逐盘+光鸭网盘专门核实
- 方法: gh api 实测星标/许可证/推送 + ghfast.top 镜像抓 raw 源码行号摘录 + WebSearch 官网核
- 评级: A=克隆即用(许可证友好+贴题) / B=借端点借模式 / C=参考弱 / D=不可用或不存在
- 免登色: 绿=游客列表+游客直链 / 黄=游客列表可但直链要登录(或部分场景) / 红=强登录 / 未核=标注

## A. alist 生态 (网盘协议百科全书)

### A1. 主仓与分叉格局
| 名称 | url | 星 | 许可证 | 活性 | 结论 |
|---|---|---|---|---|---|
| alist 主仓 | github.com/alist-org/alist | 50,379 | AGPL-3.0 | 2026-10-21 | 活跃; 2025-06 信任危机后仍是正仓 |
| OpenList | github.com/OpenListTeam/OpenList | 25,363 | AGPL-3.0 | 2026-10-30(当日) | 最活跃分叉日更; driver数超alist; 本卷宗主要蓝本 |
| OpenAList | github.com/AlliotTech/openalist | 253 | AGPL-3.0 | 2026-10-22 | 社区分叉(基于alist v3.45.0); 独有曲奇云盘驱动; 文档 alist.iots.vip |
| xiaoya-alist | github.com/xiaoyaDev/xiaoya-alist | 8,502 | GPL-3.0 | 2026-10-28 | 媒体库向(仅pattern) |
| alist-tvbox | github.com/power721/alist-tvbox | 3,165 | 无(未声明) | 2026-10-29 | TvBox代理+搜索(无许可证仅pattern) |

要点: alist/OpenList driver 代码一律 AGPL-3.0 -> 采纳方式=pattern only(端点/签名算法可读可仿写, 代码不得拷进闭源件); 例外见 MIT/Apache 第三方项目。

### A2. 免登/游客驱动路径结论(核心交付)
OpenList drivers/ 全目录实测含 100+ 驱动:
1. 纯游客分享挂载(绿): 123_share(shareKey+SharePwd, AccessToken非必填), lanzou/ilanzou(分享页解析, 见A3), url_tree, mediatrack
2. 游客列表+登录直链(黄): aliyundrive_share(get_share_token+file/list游客), doubao_share(cookie字段非required+ShareIds必填, 待实测), lenovonas_share, onedrive_sharelink, pikpak_share
3. 半登录(黄): 115_share(cookie或QRCodeToken二选一+share_code/receive_code)
4. 强账号(红, driver层): guangyapan(SMS两段登录+ClientID+X-Device-Sign), ctfile(rest.ctfile.com/v1账号API), weiyun(Cookies required), quark_open(refresh_token+AppID+SignKey, 附共享续期API api.oplist.org/quarkyun/renewapi), quark_uc
5. alist/OpenList 站点级 guest: 管理员给游客开路径权限, 但服务端仍持账号token(非盘侧免登)
6. 盘侧官方免登 != driver免登: 光鸭云盘 driver 账号型, 但盘官方支持"免登录下载"分享(官网核), 盘级=绿

### A3. driver 源码可借端点/签名(行号级; 蓝本=OpenListTeam/OpenList@main + ByLsPro/JxPan 未加密源码.js)

[蓝奏云 drivers/lanzou/util.go]
- L27 账号态 POST Base/doupload.php; L112 Referer: https://pc.woozooo.com
- L124-156 acw_sc__v2 挑战自动计算并回灌cookie(蓝奏反爬核心)
- L320-321 游客解析正则: var domain[12]='..(ajaxfile|ajaxm).php?file=(\d+)...' + var wp_sign='([^']*)'
- L326-342 游客直链: POST domain1 参数 action=downprocess, websignkey=ajaxdata[1], signs=ajaxdata[1], sign=wp_sign, websign=2, kd=kdns, ves=1 -> json 返回 dom+url

[123云盘 drivers/123_share/util.go]
- L23-28: https://yun.123pan.com/api + /share/get(列表) + /share/download/info(直链); origin/referer=yun.123pan.com
- L32-50: signPath(path,"web","3") 路径签名(生成k,v查询对, 每请求按路径重算)
- L102-103: body 携带 shareKey+SharePwd -> 纯游客

[阿里云盘 drivers/aliyundrive_share/util.go]
- L24 auth.alipan.com/v2/account/token; L59 POST api.alipan.com/v2/share_link/get_share_token
- L136 POST api.alipan.com/adrive/v3/file/list; 头 x-share-token + X-Canary: client=web,app=share,version=v2.3.1

[夸克/UC JxPan 未加密源码.js]
- 夸克: drive-pc.quark.cn/1/clouddrive/share/sharepage/token -> /share/sharepage/detail -> /file/download; cookie __puus 刷新(需登录cookie)
- UC: 同族API, 强制 UC_COOKIE(2小时过期)

[蓝奏优享 ilanzou]
- api.ilanzou.com/unproved/share/list + api.ilanzou.com/unproved/file/redirect ("unproved"=未实名命名空间, 游客可调)
- OpenList drivers/ilanzou/util.go: L39 ts+hash十六进制签名; L87 可设 X-Forwarded-For 换IP; 小件 jwwsjlm/ilanzou_encryptHex(encryptHex解码)

[光鸭云盘 guangyapan]
- drivers/guangyapan/driver.go L22-23: account.guangyapan.com + api.guangyapan.com; util.go 端点 /nd.bizuserres.s/v1/get_res_center_token, get_task_status, file/get_info_by_task_id; meta.go=SMS两段登录+ClientID+X-Device-Sign
- JxPan L758 GuangyaPanParser; L1117 POST api.guangyapan.com/nd.bizuserres.s/v1/get_share_access_token(share_id+code; JxPan包登录Bearer, 匿名是否可用=未核)
- 分享URL形态 guangyapan.com/s/<id>?code=<提取码>; 直链走OSS(aliyun-oss-sdk, EndPoint由get_res_center_token下发)

[城通 ctfile drivers/ctfile/util.go]
- L18 defaultBaseURL=rest.ctfile.com/v1; L228 /user/info/profile; L237/271 /<ns>/folder/list 与 /<ns>/file/list; L345 /<ns>/file/fetch_url; L414 /<ns>/file/upload -> 全账号型

[微云 weiyun/meta.go] L10 Cookies required:true -> driver层免登无门

### A4. alist周边·搜索/聚合/直链项目
| 名称 | url | 星 | 许可证 | 活性 | 免登 | 可借 | verdict |
|---|---|---|---|---|---|---|---|
| netdisk-fast-download | github.com/qaiu/netdisk-fast-download | 3,425 | MIT | 2026-10 | 绿(分享直链云解析) | Java/vert.x; 支持蓝奏/优享/移动云/小飞机/亿方云/123/永硕E盘/Cloudreve+加密分享+文件夹; 公益API lz.qaiu.top/parser?url=<分享>&pwd=<码>; parser插件化+自定义解析器指南 | A(全场最贴题) |
| pansou | github.com/fish2018/pansou | 15,085 | MIT | 2026-10 | 绿 | 高性能网盘搜索API(TG频道+插件, 多频道并发+排序+盘型分类, docker一键) | A |
| CloudSaver | github.com/jiangrui1994/CloudSaver | 9,413 | MIT | 2026-10 | 黄(搜索免登/转存要号) | Vue3+Express 网盘资源搜索+转存 | A(搜索侧) |
| JxPan | github.com/ByLsPro/JxPan | 167 | Apache-2.0 | 2026-10 | 黄(多数parser带号) | 未加密源码.js=10盘直链百科(光鸭/阿里/夸克/UC/小飞机/优享/蓝奏/移动云/豆包/189) | A(源码可改) |
| quark-auto-save | github.com/Cp0204/quark-auto-save | 3,085 | AGPL-3.0 | 2026-07 | 黄 | 夸克签到/转存/分享订阅全链 | B(pattern) |
| LinkSwift | github.com/hmjz100/LinkSwift | 36,366 | AGPL-3.0 | 2026-10-27 | 黄(油猴网页态) | 八大网盘直链(百度/阿里/移动/天翼/迅雷/夸克/UC/123) | B(pattern) |
| SaveAny-Bot | github.com/krau/SaveAny-Bot | 2,585 | AGPL-3.0 | 2026-10 | 黄 | TG转存bot多盘后端 | B |
| PanIndex | github.com/libsgh/PanIndex | 1,399 | AGPL-3.0 | 2025-06 | 黄 | 网盘目录索引(蓝奏/天翼等) | B |
| SmartStrm | github.com/Cp0204/SmartStrm | 783 | 无 | 2026-10-29 | 黄 | STRM 302直链+Emby联动 | B |
| go-pansearch-release | github.com/Xwudao/go-pansearch-release | 92 | MIT | 2025-12 | 绿 | Go+React搜索引擎 | B |
| PanSearch | github.com/SmallZombie/PanSearch | 6 | Apache-2.0 | 2024-11 | 绿 | 聚合多搜索站统一接口 | B |
| yz_pansearch_api | github.com/fre123-com/yz_pansearch_api | 38 | 无 | 2025-11 | 绿 | 夸克/百度/迅雷/阿里搜索插件API | B(pattern) |
| pansou-web | github.com/fish2018/pansou-web | 364 | 无 | 2026-10 | 绿 | pansou前端 | B |
| nfd-vercel | github.com/nfd-parser/nfd-vercel | 2 | 无 | 2025-07 | 绿 | nfd的node/koa vercel版(lanzou/ilanzou/cow) | B |

## B. 长尾盘逐盘
| 盘 | 域名 | 活性 | 免登 | 可借端点/文件(代表项目) | verdict |
|---|---|---|---|---|---|
| 蓝奏云 | lanzou*.com | 活跃 | 绿(分享页游客+直链可解) | A3蓝奏段; zaxtyson/LanZouCloud-API(810星MIT), chenhb23/lanzouyun-disk(1884星MIT), rachpt/lanzou-gui(1329星MIT), hanximeng/LanzouAPI(335星MIT), 5ime/Lanzou_API(181星无许可), Yu2002s/SplitLanzou(482星Apache) | A(富矿) |
| 蓝奏优享 | www.ilanzou.com | 活跃 | 绿(unproved API) | api.ilanzou.com/unproved/share/list+/file/redirect; ilanzou_encryptHex; JxPan IlanzouParser(L7658) | A |
| 光鸭云盘 | www.guangyapan.com | 活跃 | 绿(官方分享可开免登录下载; 注册2TB/不限速/离线下载) | OpenList drivers/guangyapan + JxPan L758/L1117(见A3) | A |
| 123云盘 | 123pan.com | 活跃 | 绿(分享挂载免登) | yun.123pan.com/api share/get+share/download/info+signPath; 123pan_unlock(1051星Apache), 123panNextGen(572星GPL日更), 123Pan-Unlimited-Share(185星GPL), 123panYouthMember(1096星AGPL) | A(接口) |
| 小飞机盘 | feijipan.com | 活跃 | 绿 | JxPan FeijipanParser(L6485); nfd支持 | A |
| 亿方云 | ecpan.cn | 活跃 | 绿(nfd README实测示例) | nfd /parser?url=<ecpan分享>&pwd=<码> + 短链 /ec/<data>@<pwd> | B |
| 文叔叔 | wenshushu.cn | 活跃 | 绿(产品即免登收发, 收件码制) | Aruelius/wenshushu(124星无许可->pattern); Yuriz132/wenshushu-transfer-skill(MIT) | B |
| 奶牛快传 | cowtransfer.com | 活跃 | 绿(取件码制免登) | Mikubill/cowtransfer-uploader(447星MIT Go), imacks/cowtransfer(MIT py库), kitUIN/CowtransferAPI(MIT) | A(三件全MIT) |
| 阿里云盘 | alipan.com | 活跃 | 黄(游客列表/直链要token) | A3阿里段; aliyundrive_share | B |
| 夸克网盘 | pan.quark.cn | 活跃 | 黄(token+detail游客可, 下载需转存/__puus) | JxPan夸克段; quark-auto-save(AGPL) | B |
| UC网盘 | drive.uc.cn | 活跃 | 黄偏红(强UC_COOKIE 2h过期) | JxPan UCParser | C |
| 城通网盘 | ctfile.com | 活跃 | 黄(游客可解一次性直连; 限速风控重) | qinlili23333/ctfileGet(1723星无许可->pattern), ctfile.Workers(MPL-2.0), ericwang2006/ctfile-cli(47星MIT), hihaar/CTFileParser(GPL), hxz393/CtfileUrlDecoder(GPL) | B |
| 曲奇云盘 | quqi.com | 2024-10原版停服转Pro | 黄未核(OpenAList驱动=cookie账号型; Pro新接口未核) | AlliotTech/openalist曲奇驱动+alist.iots.vip; sleechengn/webdav-quqi(1星MIT) | C(盘半死) |
| 微云 | weiyun.com | 活跃 | 红(driver强cookie; 公网无免登直链方法[WebSearch未获]) | loo2k/WeiyunHelper(41星MIT aria2导出), Macuyiko/weiyun-api(28星MIT 2015老逆向) | C |
| 移动云盘 | yun.139.com | 活跃 | 黄 | JxPan MobileCloudParser(L10626); nfd专业版189.qaiu.top | B |
| 天翼云盘 | cloud.189.cn | 活跃 | 黄 | JxPan README支持; LinkSwift | B |
| 超能邮箱盘 | 无 | 无 | 红: 无此产品 | WebSearch无"超能邮箱盘/超能网盘"独立盘; 仅"超能搜"安卓搜索APP(waptw.com/soft/12462.html) -> 判名称混淆(疑=超能搜APP或口误) | D |
| 净垚网盘 | 无 | 无 | 红: 不存在 | WebSearch"净垚 网盘"仅上海公司名(环保/企管/认证), 无任何网盘产品 | D |

### 光鸭网盘专项核实(任务点名)
结论: 真实存在。域名 www.guangyapan.com(官网WebSearch直达), 全名「光鸭云盘」; GitHub双源交叉证实(ByLsPro/JxPan 明文列"光鸭云盘(guangyapan.com)"; OpenList 官方 drivers/guangyapan 驱动)。API双域名 account/api.guangyapan.com, 业务路径 /nd.bizuserres.s/v1/*; 分享形态 /s/<id>?code=<码>; 官网明示分享可开"免登录下载"(盘级=绿); 官方OpenList驱动走SMS两段登录(Bearer+refresh_token+ClientID+X-Device-Sign), JxPan解析器再包登录cookie(get_share_access_token 匿名态是否可用=未核, 建议实测)。

## 实收统计
- 条目实收: 54 条(A1仓5 + A2驱动级11 + A4项目14 + B盘18 + 专项)
- 核实: gh api 仓级30+ / ghfast raw 行号摘录9文件 / WebSearch 6次 / 官网直达1
- verdict A 级: netdisk-fast-download(MIT), pansou(MIT), CloudSaver搜索侧(MIT), JxPan(Apache), 奶牛三MIT库, 蓝奏MIT系, 蓝奏优享/光鸭/123/小飞机接口绿
- 未核清单: doubao_share游客态, 光鸭share token匿名可用性, 曲奇Pro新接口, 微云深层接口

## Working notes (34条滚动过程记录已全部并入上文对应段; 关键链路: alist->OpenList drivers全目录->guangyapan/ilanzou/123_share/lanzou行号摘录->JxPan未加密源码10 Parser->nfd/pansou/CloudSaver三MIT主件->WebSearch六连核光鸭/超能/净垚/曲奇/微云)
