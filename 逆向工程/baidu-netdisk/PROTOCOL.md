# PROTOCOL.md · 百度网盘协议规格书（证据分级）

> 战役：BDPAN-FACTORY W1「协议规格书」· 日期：2026-10-29 · 状态：W1 产物（用户已全案批准）
> 证据源四件：`analysis/CAPTURE_INVENTORY.md`（8.2.5 抓包 87 端点/1152 流量）· `analysis/BLUEPRINT_MAP.md`（BaiduPCS-Go 行号级）· `analysis/STATIC_NETBASE.md`（bdpan.exe/各 DLL 字符串面）· `RESEARCH_DOCKET/official_openapi.md`（官方开放平台 17 页）
> 活性普查：`analysis/W1_LIVENESS.md`（2026-10-29 当日 9 发只读实测，零 rand/rand2，零风控码）
> 账号口径：pyeyeye / uk=587408217 / SVIP8（vip_type=21）/ 企业管理员（总包智（海南）教育，cid=1000064637342）

## 0. 证据分级与统计

| 级 | 定义 | 行数 |
|---|---|---|
| **A** | 8.2.5 实测流量：抓包（2026-10-29 窗口 18:38-19:05）+ V1/V3 冒烟 + W1 普查（当日 9 发） | **50** |
| **B** | 蓝本源码：BaiduPCS-Go `1b91318`（行号见 BLUEPRINT_MAP）+ bdp(docs) 实测 | **31** |
| **C** | bdpan.exe / 客户端 DLL 字符串面（STATIC_NETBASE） | **10** |
| **D** | 官方开放平台文档（pan.baidu.com/union/doc，2026-10-29 抓取） | **20** |
| 合计 | 统一端点总表 | **111** |

W1 出口门核对：8.2.5 实测端点 A 级 50 条（≥50 ✓）= 抓包 41 形态 + V1/V3 冒烟 2 形态（loginStatus、xpan-list；与抓包重叠者计一次）+ W1 普查 7 形态（quota-GET、xpan-search、multifile-404、xpan-share-record、share-record、recycle-list、filediff-复测）。蓝本端点 100% 已带活性标记（B 级行活性列均注明「未实测/蓝本在役/已下线」三态之一）。

## 1. 统一端点总表（按 16 命令需求分组）

组口径 = PROPOSAL §五 16 命令面（tree 并入 ls、mirror/doctor 各成组、平台辅助与底座两组为非命令支撑面）。活性列：`0 (W1 2026-10-29)`=当日实测 errno=0；`抓包在役`=8.2.5 客户端窗口内出现且应答；`未实测`=无直测证据；已死者标注死因。

### G1 whoami（身份/登录态）

| 端点 | 家族 | 方法 | 用途 | 认证 | 关键参数 | 证据级 | 活性(errno+日期) | rand必要性 | 备注 |
|---|---|---|---|---|---|---|---|---|---|
| pan.baidu.com/api/loginStatus | api | GET | 登录态+画像；**响应明文发放 bdstoken/uk/username/vip_level** | Cookie(BDUSS) | clienttype=8&app_id=250528&web=1 | A | 0 (冒烟 2026-10-29) | 实证不需要 | doctor 复验第一针 |
| pan.baidu.com/api/user/getinfo | api | POST | 用户信息 | Cookie(BDUSS) | 通用模板+rand/rand2（客户端带） | A | 抓包在役 2026-10-29 | 客户端带/复刻待验 | — |
| pan.baidu.com/api/user/getinfo | api | GET | UK 收割（蓝本形态） | Cookie(BDUSS) | need_selfinfo=1 | B | 未实测 | 蓝本不带 rand | prepare.go:99-115 |
| pan.baidu.com/rest/2.0/xpan/nas?method=uinfo | xpan | GET | 官方用户信息 | access_token | vip_version=v2 | D | 未实测 | 无 rand 概念 | errno 42905 可重试 |
| pan.baidu.com/api/gettemplatevariable | api | GET | bdstoken 收割（web 面） | Cookie(BDUSS) | fields=["bdstoken"] | B | 未实测 | 蓝本不带 | prepare.go:220-229 |
| openapi.baidu.com/oauth/2.0/authorize | oauth | GET | OAuth 授权（码/简化/扫码三流） | 浏览器会话 | response_type&client_id&scope=basic,netdisk&qrcode=1 | D | 未实测 | 无 | 简化模式公开 client_id=QHOuRXiepJBMjtk0esLhrPoNlQyYd0mF |
| openapi.baidu.com/oauth/2.0/device/code | oauth | GET | 设备码流（bdpan OOB） | client_id | response_type=device_code&scope | D | 未实测 | 无 | device_code 300s；轮询≥5s |
| openapi.baidu.com/oauth/2.0/token | oauth | GET | 换/刷 token | code 或 refresh_token+client_secret | grant_type | D+C | bdpan 在用(未实测) | 无 | access 30d / refresh 10y 一次性禁循环刷 |
| pan.baidu.com/disk/home | api | GET | sign1/sign3/timestamp 抓取页（web 下载签名原料） | Cookie(BDUSS) | — | B | 未实测 | 无 rand | panhome/parse.go:13-66；跳 passport=cookie 失效 |

### G2 quota

| 端点 | 家族 | 方法 | 用途 | 认证 | 关键参数 | 证据级 | 活性 | rand必要性 | 备注 |
|---|---|---|---|---|---|---|---|---|---|
| pan.baidu.com/api/quota | api | GET | 配额（官方形态） | Cookie(BDUSS) | checkfree=1&checkexpire=1 | A | **0 (W1 2026-10-29)** | **实证不需要** | free≈3.31TB 回显 |
| pan.baidu.com/api/quota | api | POST | 配额（8.2.5 客户端形态） | Cookie(BDUSS) | 通用模板 | A | 抓包在役 2026-10-29 | 客户端带/GET 形态已证不需要 | 同端点双方法双形态皆活 |
| pcs.baidu.com/rest/2.0/pcs/quota?method=info | pcs遗产 | GET | 配额（旧） | Cookie(BDUSS) | method=info&app_id | B | 未实测（8.2.5 零出现） | 蓝本不带 | 漂移账 #1 |

### G3 ls / tree

| 端点 | 家族 | 方法 | 用途 | 认证 | 关键参数 | 证据级 | 活性 | rand必要性 | 备注 |
|---|---|---|---|---|---|---|---|---|---|
| pan.baidu.com/api/list | api | POST | 目录列表（全盘主力） | Cookie(BDUSS) | dir=&page=&num=1000&order&desc | A | 0 (冒烟 2026-10-29 dir=/ 17 项) | 实证不需要 | web 版翻页（#511 修）；1000 条/页 |
| pan.baidu.com/rest/2.0/xpan/file?method=list | xpan | GET | 文件列表 | Cookie(BDUSS) 或 access_token | dir&order&start&limit≤1000&web=1&folder=1 | A | 0 (V3 冒烟 2026-10-29) | 实证不需要 | 官方口径 limit≤1000 |
| pan.baidu.com/rest/2.0/xpan/file?method=listall | xpan | GET | 递归列表（tree 底座） | access_token（Cookie 形态待验） | dir&web | D+C | 未实测 | 无 rand 概念 | 2026-06-03 新政点名端点（沙箱限权仅 T1） |
| pcs.baidu.com/rest/2.0/pcs/file?method=list | pcs遗产 | GET | 列表（旧） | Cookie(BDUSS) | path&by&order | B | 未实测 | 蓝本不带 | 已被 web /api/list 替代（#511） |
| pan.baidu.com/recent/list | api | POST | 最近使用 | Cookie(BDUSS) | 通用模板 | A | 抓包在役 2026-10-29 | 客户端带/待验 | 辅助面 |

### G4 search

| 端点 | 家族 | 方法 | 用途 | 认证 | 关键参数 | 证据级 | 活性 | rand必要性 | 备注 |
|---|---|---|---|---|---|---|---|---|---|
| pan.baidu.com/rest/2.0/xpan/file?method=search | xpan | GET | 关键词搜索（全盘） | Cookie(BDUSS) | key≤30UTF8 字符&dir&recursion=1&num=500 固定 | A | **0 (W1 2026-10-29)** | **实证不需要** | 翻页靠 has_more 无 page |
| pcs.baidu.com/rest/2.0/pcs/file?method=search | pcs遗产 | POST | 搜索（旧） | Cookie(BDUSS) | path&wd&re | B | **死亡（W6 2026-10-30 探针：HTTP 200 但回 pcs 族 error_code/error_msg 形态，零搜索结果——退役再证）** | 蓝本不带 | prepare.go:232-249；E1 提速对比=xpan 唯一通道维持（replica/tests/_diag_archive/w6_qa_gate/e1_search_probe.json） |
| 语义搜索（MCP file_semantics_search） | xpan | GET | 自然语言搜索 | access_token | query | D | 未实测 | 无 | 仅官方 MCP 通道 |

### G5 meta

| 端点 | 家族 | 方法 | 用途 | 认证 | 关键参数 | 证据级 | 活性 | rand必要性 | 备注 |
|---|---|---|---|---|---|---|---|---|---|
| pan.baidu.com/rest/2.0/xpan/file?method=meta | xpan | GET | 单文件详情 | Cookie 或 access_token | path(URL 编码)&dlink=1 | D | 未实测 | 无 | dlink 约 8h |
| pan.baidu.com/rest/2.0/xpan/file?method=filemetas | xpan | POST | 路径批量详情 | 同上 | target=JSON 路径数组&dlink&blocks | D | 未实测 | 无 | — |
| pan.baidu.com/rest/2.0/xpan/multimedia?method=filemetas | xpan | GET | fsids 批量详情（现行） | 同上 | fsids=JSON≤100&thumb&dlink&needmedia | D | 未实测 | 无 | 返回 block_list/media_info |
| pan.baidu.com/rest/2.0/xpan/multifile?method=metas | xpan(legacy) | GET | fsids 元信息（旧 web 形态） | Cookie(BDUSS) | fsids&dlink=0 | A | **404 已死 (W1 2026-10-29)** | —（端点死） | 漂移账 #4；现行=multimedia 形态 |
| pan.baidu.com/api/filemetas?dlink=1 | api | GET | fsids 元信息+下载直链 | Cookie(BDUSS+STOKEN) | fsids=JSON&dlink=1&clienttype=8 | A | **0 (W4 2026-10-29)** | 实证不需要 | dlink 明文回（d.pcs 域带 sign&expires=8h）；md5=混淆体；block_list=null；下载引擎 dlink 入口 |
| pcs.baidu.com/rest/2.0/pcs/file?method=meta | pcs遗产 | POST | 元信息（旧） | Cookie(BDUSS) | multipart param=fsids | B | 未实测 | 蓝本不带 | prepare.go:141-158 |

### G6 mkdir

| 端点 | 家族 | 方法 | 用途 | 认证 | 关键参数 | 证据级 | 活性 | rand必要性 | 备注 |
|---|---|---|---|---|---|---|---|---|---|
| pan.baidu.com/api/create | api | POST | 建目录（isdir=1；web 客户端同款） | Cookie(BDUSS+STOKEN) | path&isdir=1&rtype=0&clienttype=8&app_id=250528&web=1 | A | **0 (W4 2026-10-29)** | 实证不需要 | errno=0 带 fs_id；**-8=已存在（幂等信号）**；bdstoken 不需要；W4 主通道 |
| pan.baidu.com/rest/2.0/xpan/file?method=create | xpan | POST | 建目录（isdir=1 免预传） | Cookie 或 access_token | path&isdir=1&rtype | D | **9019 need verify (W4 2026-10-29)** | 无 | xpan 写面风控验证墙，本账号死路（漂移账 #13） |
| pcs.baidu.com/rest/2.0/pcs/file?method=mkdir | pcs遗产 | POST | 建目录（旧） | Cookie(BDUSS) | path | B | **假成功 (W4 2026-10-29)** | 蓝本不带 | errno=0 但目录不落盘（prepare.go:272-281）；勿用 |

### G7 rename / mv / cp / rm

| 端点 | 家族 | 方法 | 用途 | 认证 | 关键参数 | 证据级 | 活性 | rand必要性 | 备注 |
|---|---|---|---|---|---|---|---|---|---|
| pan.baidu.com/api/filemanager | api | POST | copy/move/rename/delete 四合一（web 客户端同款） | Cookie(BDUSS+STOKEN) | opera&async=0&ondup&clienttype=8&app_id=250528&web=1；body: filelist | A | **0 (W4 2026-10-29，四 opera 全过)** | 实证不需要 | **filelist 官方口径：move/copy=每项 path+dest+newname；rename=path+newname；delete=纯路径数组**；from/to 形态=errno 2；info[] 逐条 errno；move/copy 回 to_path/to_fs_id；delete 进回收站 |
| pan.baidu.com/rest/2.0/xpan/file?method=filemanager | xpan | POST | copy/move/rename/delete 四合一（官方文档口径） | Cookie 或 access_token | opera&filelist=JSON&async(0/1/2)&ondup | D+C | 未实测（xpan 写面疑同 9019 墙，见 G6） | 无 rand 概念 | bdpan 字串实证 opera=rename；errno -9/111/-7 |
| pcs.baidu.com/rest/2.0/pcs/file?method=move | pcs遗产 | POST | 移动/重命名（rename=move 单条） | Cookie(BDUSS) | param=JSON(fileid+to) | B | 未实测 | 蓝本不带 | prepare.go:283-331 |
| pcs.baidu.com/rest/2.0/pcs/file?method=copy | pcs遗产 | POST | 复制（旧） | Cookie(BDUSS) | param=JSON | B | 未实测 | 蓝本不带 | prepare.go:324-326 |
| pcs.baidu.com/rest/2.0/pcs/file?method=delete | pcs遗产 | POST | 删除（旧） | Cookie(BDUSS) | param=fsids | B | 未实测 | 蓝本不带 | prepare.go:252-269 |

### G8 upload（三段 + 秒传 + 旧通道）

| 端点 | 家族 | 方法 | 用途 | 认证 | 关键参数 | 证据级 | 活性 | rand必要性 | 备注 |
|---|---|---|---|---|---|---|---|---|---|
| pan.baidu.com/api/precreate（xpan/file?method=precreate） | xpan/api | POST | 上传① 预创建 | Cookie 或 access_token | path&size&isdir&block_list=MD5 数组&autoinit=1&rtype&content-md5&slice-md5(前 256KB)&local_ctime/mtime&web=1&app_id=250528 | B+D | **0 (W4 2026-10-29)** | 实证不需要 | 响应 uploadid+block_list=待传分片序号；**return_type=2 秒传在本账号未达成**（V1/V2/V3-数据腿/V4-服务端指纹四变体全 miss，疑服务端 md5 混淆阻断索引，漂移账 #14）；errno -7/-10 |
| {UPLOAD_HOST}/rest/2.0/pcs/superfile2?method=upload&type=tmpfile | d.pcs | POST | 上传② 分片 | Cookie(BDUSS) | query: uploadid&partseq&vip=2&web=1&app_id&path；form: path+file(multipart) | B+D+C | **0 (W4 2026-10-29)** | 实证不需要 | **门=参数完整度（path query+form 双放+vip=2+web=1+app_id）；UA 双腿均放行**（ss-judge 1029 重放：native UA+全参=200/md5 回执；W4 初判「CEF UA 必带」系诊断矩阵变量未隔离误归因，勘误见 replica/ERRATA_1029.md）；失败信使=error_code（31023=缺参/31024=缺 app_id）非 errno；host 从 locateupload servers[] 取（c5.pcs.baidu.com 实测）；分片 4/16/64MB；superfile3 灰度中 |
| pan.baidu.com/api/create（xpan/file?method=create） | xpan/api | POST | 上传③ 合并/建文件 | 同上 | path&size&isdir&block_list&uploadid&rtype&clienttype=8&app_id&web=1 | B+D | **0 (W4 2026-10-29)** | 实证不需要 | errno=0 回 fs_id+md5（**md5 为混淆体，含非 hex 字符**）；分片未注册时 errno=404；zip_quality/is_revision 可选 |
| pcs.baidu.com/rest/2.0/pcs/file?method=upload | pcs遗产 | POST | 单步上传≤2GB（含旧 tmpfile 分片形态） | Cookie(BDUSS) | path&ondup&file（multipart） | B+D | 未实测 | 蓝本不带 | prepare.go:526-577 两形态；errno 31061/31064 |
| d.pcs.baidu.com/rest/2.0/pcs/file?method=locateupload | d.pcs | GET | 上传服务器发现 | Cookie(BDUSS) | upload_version=2.0 | A+B | 抓包在役 2026-10-29 | 客户端带/待验 | **8.2.5 唯一在役 pcs 域调用** |
| pan.baidu.com/rest/2.0/xpan/file?method=create（旧秒传） | xpan | POST | 秒传（旧 access_token 形态） | Cookie+access_token | block_list&rtype=3 | B | 未实测 | 无 rand 概念 | prepare.go:334-357 |
| pan.baidu.com/api/precreate + data_offset（V2 秒传） | api | POST | 秒传 V2 | Cookie(BDUSS) | content-md5&slice-md5&data=md5(uk+content_md5+ts)&data_offset/length/content | B | 未实测 | 蓝本不带 | offset=mixedMD5 前 8hex % (size-subSize+1)；return_type=2=秒传成 |

### G9 download

| 端点 | 家族 | 方法 | 用途 | 认证 | 关键参数 | 证据级 | 活性 | rand必要性 | 备注 |
|---|---|---|---|---|---|---|---|---|---|
| pcs.baidu.com/rest/2.0/pcs/file?method=locatedownload | pcs遗产 | GET | 下载直链定位（安卓伪装） | Cookie(BDUSS) | ant=1&check_blue=1&es=1&esl=1&ver=4.0&clienttype=17 + sign 四参数(time/rand/devuid/cuid) | B | 未实测（8.2.5 零出现） | **带 LocateDownloadSign（唯一真签名腿）** | 漂移：8.2.5 客户端已不用此腿 |
| pan.baidu.com/api/download | api | POST | web 下载直链 | Cookie(BDUSS+STOKEN) | sign=Base64(Sign2(sign3,sign1))&timestamp&fidlist | B | 未实测 | 无 rand（有 RC4 sign） | sign1/3 来自 /disk/home；errno 112/113 自愈重取 |
| pan.baidu.com/rest/2.0/xpan/file?method=download | xpan | GET | 官方直连下载 | access_token | check_blue=1&esl=1&path | D | 未实测 | 无 | — |
| dlink（d.pcs.baidu.com 系列域） | d.pcs | GET | 实际文件传输 | Cookie(BDUSS+STOKEN) 或 dlink 追加 access_token | Range 有界 ≤~5MB（CT11 节点 403 31326） | D+B | **0 (W4 2026-10-29：4MB×3 块 Range 多线程，md5 与源一致，2.21MB/s)** | 无 | web dlink 实测**浏览器 UA+Cookie 直收**（蓝本坑位口吻一致）；8h 有效；302 跟随保留鉴权 |
| pcs.baidu.com/rest/2.0/pcs/file（stream）?method=download | pcs遗产 | GET | 下载执行（旧） | Cookie(BDUSS) | path | B | 未实测 | 蓝本不带 | download.go:106-125 |

### G10 share（条件门）

| 端点 | 家族 | 方法 | 用途 | 认证 | 关键参数 | 证据级 | 活性 | rand必要性 | 备注 |
|---|---|---|---|---|---|---|---|---|---|
| pan.baidu.com/share/pset | api | POST | 创建分享（旧代写面） | Cookie(BDUSS+STOKEN) | path_list&schannel=4&channel_list=[]&period&pwd&share_type=9 | A | **0 (W5 2026-10-29，1 发即成)** | 蓝本不带 | **旧代写面实测存活**（官方 2026-09-16「下线」宣未落此端点，漂移账 #15）；path_list=纯路径 JSON 数组（蓝本形态）首试即过；提取码分享 schannel=4+pwd 放行；响应含 shareid/link/shorturl/qrcodeurl/expiredType 族（prepare.go:739-760） |
| pan.baidu.com/share/cancel | api | POST | 取消分享 | 同上 | shareid_list | A | **0 (W5 2026-10-29)** | 蓝本不带 | shareid_list=JSON 数组；取消自建测试分享实证 + record 列表复核该 shareid 消失（prepare.go:762-780） |
| pan.baidu.com/share/record | api | GET | 分享列表（蓝本形态） | Cookie(BDUSS) | page&desc=1&order=time | A | **0 (W1 2026-10-29, count=86；W5 复测 count=43→44 含临时测试分享)** | **实证不需要** | prepare.go:783-801 同款 |
| pan.baidu.com/rest/2.0/xpan/share?method=record | xpan | GET | 分享列表（xpan 形态） | Cookie(BDUSS) | page | A | **0 (W1 2026-10-29, count=30 nextpage=1)** | **实证不需要** | 官方「旧版下线」后只读面仍活→漂移账 #5 |
| pan.baidu.com/share/surlinfoinrecord | api | GET | 分享详情（含密码） | Cookie(BDUSS) | shareid&sign=md5(shareID+"_sharesurlinfo!@#") | A | **0 (W5 2026-10-29，顶层 pwd 明文回)** | 无 rand（有 sign） | 自有分享提取码收割实证（转存链取码步）；netdisksign/share_sign.go:11-20 |
| pan.baidu.com/apaas/1.0/share/set | union-apaas | POST | 创建分享（2026-09-16 新代） | access_token | product=netdisk&fsid_list&period&pwd(4 位)&remark | D | 未实测（付费接口） | 无 | 返回 short_url/share_id |
| apaas 分享提取码验证 | union-apaas | POST | 收割加密提取码 spwd（转存前置） | access_token | short_url&pwd | D | 未实测 | 无 | — |
| apaas 查询分享文件信息 | union-apaas | POST | 分享内 fsid 列表（转存 fsid 来源） | access_token | short_url | D | 未实测 | 无 | — |

### G11 transfer（条件门）

| 端点 | 家族 | 方法 | 用途 | 认证 | 关键参数 | 证据级 | 活性 | rand必要性 | 备注 |
|---|---|---|---|---|---|---|---|---|---|
| pan.baidu.com/share/verify | api | POST | 旧转存①提取码校验 | Cookie(BDUSS+STOKEN) | shareid&uk&time&clienttype=1 + body pwd&vcode&bdstoken → randsk | A | **0 (W5 2026-10-29，randsk 48 位回)** | 蓝本不带 | 自有分享+surlinfo 取码实测通过；-9 提取码错；8001 触发验证码 |
| pan.baidu.com/share/list | api | GET | 旧转存②分享文件列表 | Cookie(BDUSS+STOKEN+randsk) | shorturl&root=1&web=5&channel=chunlei&app_id=250528 | A | **0 (W5 2026-10-29，fs_id 字符串形态)** | 蓝本不带 | shorturl=去前导'1'形态首试即过；randsk 以 BDCLND cookie 携带；拿 fs_id |
| pan.baidu.com/share/transfer | api | POST | 旧转存③入库 | 同上 | body fsidlist&path；query 全参 app_id&channel=chunlei&clienttype=0&web=1&**shareid&from(=shareUK)**&bdstoken（蓝本 transfer.go:79-85） | A | **2 (W5×2 不带 bdstoken；W6 2026-10-30×1 带 bdstoken 仍 errno 2——bdstoken 单因假设证伪，见 ERRATA_1030.md)** | 蓝本不带 | **链活到末段独此门**：三发实测均 errno 2（跳级探针钉死断点在 transfer POST，前置五跳全绿）；蓝本全参形态（shareid+from+bdstoken）W6 已实装+单测，1 发复测留 W7；errno 12 上限/-30 同名/4 重复；#546 stoken 偶发失效 |
| pan.baidu.com/apaas/1.0/share/verify | union-apaas | POST | 新代分享校验（bdpan 在用） | access_token&appid | product=netdisk&short_url | D+C | 未实测 | 无 | bdpan 字串实证 |
| pan.baidu.com/apaas/1.0/share/transfer | union-apaas | POST | 新代转存（异步） | 同上 | fsid_list&to_path&spwd&async=2&ondup | D+C | 未实测 | 无 | 返回 task_id；上限 500/3000/50000 |
| pan.baidu.com/apaas/1.0/share/taskquery | union-apaas | GET | 转存任务查询 | 同上 | task_id | D | 未实测 | 无 | status/succNum；13062/13070/13071 |
| pan.baidu.com/mbox/msg/transfer | api | POST | 群文件转存 | Cookie(BDUSS) | — | B | **-10 全网下线**（bdp 2026-08 实测） | — | UI 入口已移除，勿投入 |

### G12 recycle（条件门）

| 端点 | 家族 | 方法 | 用途 | 认证 | 关键参数 | 证据级 | 活性 | rand必要性 | 备注 |
|---|---|---|---|---|---|---|---|---|---|
| pan.baidu.com/api/recycle/list | api | GET | 回收站列表 | Cookie(BDUSS) | num=100&page | A | **0 (W1 2026-10-29)** | **实证不需要** | 条件门读面证据成立 |
| pcs.baidu.com/rest/2.0/pcs/file?method=restore | pcs遗产 | POST | 回收站还原 | Cookie(BDUSS) | multipart param=fsids | B | 未实测（W2/W4 写面） | 蓝本不带 | prepare.go:839-867 |
| pan.baidu.com/api/recycle/delete | api | POST | 回收站删除 | Cookie(BDUSS+STOKEN) | fidlist | B | 未实测 | 蓝本不带 | prepare.go:870-882 |
| pcs.baidu.com/rest/2.0/pcs/file?method=delete&type=recycle | pcs遗产 | GET | 回收站清空 | Cookie(BDUSS) | type=recycle | B | 未实测 | 蓝本不带 | prepare.go:885-896 |

### G13 mirror（增量镜像）

| 端点 | 家族 | 方法 | 用途 | 认证 | 关键参数 | 证据级 | 活性 | rand必要性 | 备注 |
|---|---|---|---|---|---|---|---|---|---|
| pan.baidu.com/api/filediff | api | POST | 秒级增量游标轮询（mirror 主通道） | Cookie(BDUSS) | query: block_list=1&clienttype=8&deviceid&dname；body: cursor(base64)&action=manual | A | **2 (W1 2026-10-29，空 cursor=参数错非拒；抓包 970 次在役)** | **实证不需要**（200 JSON 无签名墙；极简 query 被 RST→参数完整度有门） | 响应回新 cursor；**W4 冷启动三形态（无 cursor 键/空串/"0"）全 errno=2——游标引导链未激活，遗留**（首游标疑来自客户端本地持久化或 rand 族强校验，见 §4.2）；**W5 mirror 增量暂走「本地扫描+远端 ls 对账」面（当日 26 文件两遍增量=0 实证），本游标链恢复后可换轴** |
| pan.baidu.com/api/batch/filediff | api | GET | 增量（蓝本旧形态） | Cookie(BDUSS) | cursor+LocateDownloadSign 四参数 | B | 未实测（8.2.5 零出现） | 带 sign | 同域两代实现→漂移账 #9 |

### G14 doctor（通道健康/漂移复验）

复验面=W1 六点体检（loginStatus/quota/xpan-list/xpan-search/recycle-list/share-record）+ 下列两支点。
**W5 复验器已实装**（replica/bdncore/doctor.py `bdn doctor`）：八针只读体检（凭据活性/api 读探针/quota/四族协议指纹 vs 本表 A 级预期/locateupload/precreate 缺参门探针）→ ok/degraded/dead + 漂移清单；2026-10-29 实测 verdict=ok、8 发、指纹零漂移。

| 端点 | 家族 | 方法 | 用途 | 认证 | 关键参数 | 证据级 | 活性 | rand必要性 | 备注 |
|---|---|---|---|---|---|---|---|---|---|
| diskapi.baidu.com/rest/2.0/netdisk/timestamp?method=get | 其他 | GET | 服务端时间戳（漂移检测） | 无 | method=get | C | 未实测 | 无 | 客户端在用 |
| diskapi.baidu.com/rest/2.0/netdisk/log?method=set | 其他 | POST | 遥测上报 | — | — | C | — | — | **复刻零遥测不采**（仅记录） |
| mcp-pan.baidu.com/sse | MCP | SSE | 官方 MCP 16 工具（T1 辅助） | Bearer access_token | Authorization（Query/Header 二选一） | D | 未实测 | 无 | 无 delete/download 工具 |

### G15 平台辅助/会话保活（非命令面；8.2.5 抓包在役——T3 会话模板素材）

| 端点 | 家族 | 方法 | 用途 | 认证 | 关键参数 | 证据级 | 活性 | rand必要性 | 备注 |
|---|---|---|---|---|---|---|---|---|---|
| pan.baidu.com/api/account/getprivilege | api | POST | 权益 | Cookie(BDUSS) | sourcetype=2 | A | 抓包在役 2026-10-29 | 客户端带/待验 | — |
| pan.baidu.com/api/account/getdeviceswitch | api | POST | 设备开关 | Cookie(BDUSS) | seg=2&switch=192 | A | 抓包在役 | 同上 | — |
| pan.baidu.com/api/multidevice/check | api | POST | 多端检查 | Cookie(BDUSS) | deviceid | A | 抓包在役 | 同上 | — |
| pan.baidu.com/api/device/anticheck | api | POST | 设备风控反查 | Cookie(BDUSS) | 通用模板 | A | 抓包在役 | 同上 | — |
| pan.baidu.com/api/report/user | api | POST | 设备上报 | Cookie(BDUSS) | deviceid | A | 抓包在役 | 同上 | — |
| pan.baidu.com/rest/2.0/dss/device?method=register | api | POST | 长连设备注册 | Cookie+bdstoken(query) | type=0&appid=250528&bdstoken | A | 抓包在役 | 同上 | bdstoken 消费面 |
| pan.baidu.com/rest/2.0/dss/online?method=report | api | POST | 长连心跳上报 | Cookie+bdstoken(query) | appid=250528&bdstoken | A+C | 抓包在役 | 同上 | YunDls 字串同款实证 |
| pan.baidu.com/xep/getcfg | api | POST | 客户端配置 | Cookie(BDUSS) | app=netdisk&type=2&os=Windows | A | 抓包在役 | 同上 | — |
| pan.baidu.com/rest/2.0/membership/user?method=identify | api | POST | 会员识别 | Cookie(BDUSS) | method=identify | A | 抓包在役 | 同上 | — |
| pan.baidu.com/rest/2.0/membership/user/info?method=rights | api | POST | 会员权益 | Cookie(BDUSS) | method=rights | A | 抓包在役 | 同上 | — |
| pan.baidu.com/rest/2.0/membership/product?method=abconfig | api | POST | 会员商品 AB 配置 | Cookie(BDUSS) | from=pc_experiments | A | 抓包在役 | 同上 | — |
| pan.baidu.com/rest/2.0/membership/privilege?method=query | api | POST | 特权查询 | Cookie(BDUSS) | type=28&status=0,1 | A | 抓包在役 | 同上 | — |
| pan.baidu.com/act/api/conf | api | POST | 活动配置 | Cookie(BDUSS) | conf_key=ee_org_potential_user_conf | A | 抓包在役 | 同上 | — |
| pan.baidu.com/act/v2/bchannel/list | api | POST | 渠道列表 | Cookie(BDUSS) | 通用模板 | A | 抓包在役 | 同上 | — |
| pan.baidu.com/act/v2/uinfo/get | api | POST | 活动用户态 | Cookie(BDUSS) | action=new_user_365_real_status | A | 抓包在役 | 同上 | — |
| pan.baidu.com/act/v2/component/storageget | api | POST | 组件存储 | Cookie(BDUSS) | keys=pclogin_<uk>&tid&ptid | A | 抓包在役 | 同上 | — |
| pan.baidu.com/mid_enterprise_v2/api/enterprise/organization/allorganizationinfo | api | POST | 企业组织信息 | Cookie(BDUSS) | cid=0&app_id=24029990 | A | 抓包在役 | 同上 | 本账号=企业管理员 |
| pan.baidu.com/api/enterprise/organization/isorgpotentialuser | api | POST | 企业潜在用户判定 | Cookie(BDUSS) | 通用模板 | A | 抓包在役 | 同上 | — |
| pan.baidu.com/rest/2.0/knowledge/subnotice | api | POST | 知识库订阅通知 | Cookie(BDUSS) | — | A | 抓包在役 | 同上 | 增值杂项 |
| pan.baidu.com/rest/2.0/knowledge/sub/exist | api | POST | 知识库订阅存在性 | Cookie(BDUSS) | share_uk&surl | A | 抓包在役 | 同上 | — |
| pan.baidu.com/rest/2.0/sbox/user/query | api | POST | sbox 用户查询 | Cookie(BDUSS) | — | A | 抓包在役 | 同上 | — |
| pan.baidu.com/rest/2.0/aisearch/user/get | api | POST | AI 搜索用户态 | Cookie(BDUSS) | — | A | 抓包在役 | 同上 | — |
| pan.baidu.com/notice/newnum | api | POST | 通知计数 | Cookie(BDUSS) | — | A | 抓包在役 | 同上 | — |
| pan.baidu.com/api/flow/info | api | POST | 流量信息 | Cookie(BDUSS) | — | A | 抓包在役 | 同上 | — |
| pan.baidu.com/rest/2.0/pcs/adx | pcs遗产 | GET | 广告位（m=tab&uk） | Cookie(BDUSS) | m=tab&uk | A | 抓包在役（pcs 域残留活口之二） | 客户端带/待验 | 8.2.5 仍在用 pcs 遗产域的例外 |
| pan.baidu.com/aiknowledgeapi/record/notice | api | POST | AI 知识通知 | Cookie(BDUSS) | — | A | 抓包在役 | 同上 | — |
| pan.baidu.com/api/certuser/get | api | POST | 认证用户 | Cookie(BDUSS) | — | A | 抓包在役 | 同上 | — |
| wan.baidu.com/gameapi | 其他 | GET | 网盘小游戏配置 | 无 | action=pan_micro_game_config | A | 抓包在役 | 同上 | — |
| pan.baidu.com/api/analytics | api | GET | CEF 页面/事件埋点 | Cookie | PAGE_VIEW/事件流 | A | 抓包在役 | 同上 | **复刻零遥测不采** |
| pan.baidu.com/api/getsyscfg | api | GET | 系统配置 | Cookie | cfg_category_keys=[{web_auto_yun}] | A | 抓包在役 | 同上 | — |
| mbd.baidu.com/ztbox | 其他 | GET | 埋点上报 | 无 | action=zpblog | A | 抓包在役 | — | 零遥测不采 |
| hm.baidu.com/hm.js + hm.gif | 其他 | GET | 百度统计 | 无 | — | A | 抓包在役 | — | 零遥测不采 |
| sp1.baidu.com/5b1ZeDe5KgQFm2e88IuM_a/mwb2.gif | 其他 | GET | 前端性能 TTFB | 无 | — | A | 抓包在役 | — | 零遥测不采 |
| nd-static.bdstatic.com | 其他 | GET | 静态资源 | 无 | — | A | 抓包在役 | — | 静态腿 |
| staticsns.cdn.bcebos.com | 其他 | GET | 静态资源 | 无 | — | A | 抓包在役 | — | — |
| himg.bdimg.com | 其他 | GET | 头像 | 无 | — | A | 抓包在役 | — | — |

### G16 分发/长连底座（记录面；bdpan/客户端字符串实证）

| 端点 | 家族 | 方法 | 用途 | 认证 | 关键参数 | 证据级 | 活性 | rand必要性 | 备注 |
|---|---|---|---|---|---|---|---|---|---|
| 180.76.76.200/v4/resolve | 其他 | GET | HTTPDNS（netbase 域名解析） | sign | account_id=171195&type=dual_stack&dn&sign&t | C | 未实测 | — | sign 算法待静态腿（漂移账 #12） |
| update.pan.baidu.com/statistics | 其他 | GET | 热更统计上报 | — | — | C | 未实测 | — | 零遥测不采 |
| issuecdn.baidupcs.com/issue/netdisk/* | 其他 | GET | 热更 CAB/CLI 分发（bdpan 官方 CDN） | 无 | — | C | bdpan 分发在役 | — | BrowserEngine 热更链同域 |
| d/c/c2/c3.pcs.baidu.com | d.pcs | GET | 下载分片 shard 域 | dlink | — | C | 未实测 | — | YunLogic 字串 |
| *.pcs.baidu-int.com / baidupcs.baidu-int.com | 其他 | — | 内网 PCS/缩略图域（泄漏进发布版） | — | — | C | — | — | 仅记录，公网不可用 |
| passport.baidu.com / wappass.baidu.com（+rdtest/qatest 测试域） | 其他 | GET | 登录/换票域（BDUSS 收割面） | 账密 | winsdk.txt/win-conf.txt 远程登录配置 | C | 未实测 | — | logonbd 字串；测试域一并内置 |
| pan.baidu.com/union/spirit/launch | union-apaas | GET | 联盟拉起 | — | — | C | 未实测 | — | bdpan 字串 |
| aippt.baidu.com | 其他 | — | AI PPT 集成 | — | — | C | — | — | bdpan 字串 |

## 2. 凭据形态

| 凭据 | 形态/长度 | 承载 | 用途 | 证据 |
|---|---|---|---|---|
| **BDUSS** | base62，192 位，**可含 `-`**（本机样本实证） | Cookie，域 `.baidu.com` | 主凭据，全 API 面 | A（1000+ 条流量）+B（baidupcs.go:214-230） |
| **STOKEN** | 64 位 hex | Cookie，域 `.baidu.com` | 写面/转存/dlink 必需（#546：对非官方客户端校验趋严、偶发失效→需重试+刷新编排） | A+B（SetStoken baidupcs.go:327-340） |
| Cookie 全家族 | BAIDUID(37)/PANPSC(343)/ab_sr(262)/ndut_fmt(64)/*_BFESS/HMACCOUNT | Cookie | 复刻最小集=**BDUSS+STOKEN 两条即可**（W1 九发实证） | A |
| **bdstoken** | 32 位 hex | query 参数（dss/*）与 body（share/verify） | 长连设备注册/心跳 + web 写操作防 CSRF；由 loginStatus / gettemplatevariable / 分享页明文发放 | A+B |
| access_token | OAuth2（30 天） | query 参数 | T1 官方通道（沙箱）；refresh_token 10 年一次性禁循环刷 | D+C |
| randsk | 转存中间产物 | Cookie（verify 后发放） | 旧转存链 share/list+transfer 前置 | B |
| SBOXTKN | — | Cookie | sbox 域（SetSboxtkn） | B |
| rand/rand2/logid/time | rand=40hex×2、logid=base64("ts,rand")、time=unix | query 参数 | **疑似签名族，读面已实证非强制**（见 §4）；生成算法待 kernel_btsdk.dll 静态腿 | A |

## 3. UA 双轨（原文照抄）

| 轨 | UA 原文 | 证据 | 用途 |
|---|---|---|---|
| **原生腿（主力）** | `netdisk;8.2.5.103;PC;PC-Windows;10.0.19045;WindowsBaiduYunGuanJia` | A（281+ 条）+W1 九发在用 | 全 API 面（W1 实测与 BDUSS 配套 errno=0） |
| **CEF UI 腿** | `Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) baidunetdisk/8.2.5 Chrome/108.0.5359.215 Electron/22.3.27 Safari/537.36;netdisk;8.2.5.103;PC;PC-Windows;10.0.19045;WindowsBaiduYunGuanJia` | A（63 条） | 页面/XHR（clienttype=8&app_id=250528&web=1 变体）；superfile2 上传用此 UA 可用但**非必需**（1029 勘误：门=参数完整度，native UA 全参亦 200） |
| CEF 资源腿 | 同上但无 `;netdisk;...` 尾巴 | A | 静态图 |
| 蓝本安卓伪装 | `netdisk;P2SP;3.0.0.8;netdisk;11.12.3;ANG-AN00;android-android;10.0;JSbridge4.4.0;jointBridge;1.1.0;` | B（baidupcs.go:116） | pcs 遗产腿（locatedownload 等） |
| dlink 官方要求 | `pan.baidu.com` | D | dlink 下载缺此 UA=31326 防盗链 |
| web dlink | 浏览器 UA（netdisk UA 会得 118 字节错误页） | B（bdp 实测） | web 版 dlink |
| 分享页访问 | netdisk UA（Chrome UA 触发反爬无 loginstate 页，#534） | B | 转存链 |
| bdpan CLI | `BaiduPanGoSDK/1.0` / `bdpan/%s (%s/%s)` | C | T1 通道 |

## 4. 签名面（无头签名 + query rand 族）

1. **无头签名**：全部请求头普查无 Sign/sign2/bd-Log-Id/PAN-*/Authorization——签名不进头（A 级普查）。
2. **query 签名族**：`rand`(40hex)+`rand2`(40hex) 逐请求随机、`time`=unix、`logid`=base64("unix时间戳,随机数")。
3. **rand/rand2 实测非强制（读面）**：W1 九发全零 rand/rand2 → quota/xpan-search/xpan-share-record/share-record/recycle-list errno=0，filediff 获 200 JSON（errno=2 为参数错）；加 V1/V3 冒烟 loginStatus/api-list/xpan-list——**读面 8+ 端点签名零强制**。写面（pset/filemanager/transfer）与传输面（superfile2/dlink）待 W2/W4 验证。
4. **参数完整度门**：filediff 极简 query（仅 clienttype=8）遭 TCP RST；补齐 channel/version/deviceid/dname（仍零 rand）即 200——门在参数完整度不在签名。
5. **算法签名四件套**（蓝本 netdisksign，纯算法可 Python 直译）：
   - Sign2 = RC4(KSA+PRGA, key=sign3, data=sign1)；web 下载签名=Base64(Sign2)
   - sign1/sign3/timestamp 来源：GET /disk/home 正则抓取（过期 errno 112/113 自动重取）
   - LocateDownloadSign：rand=sha1(hex(sha1(BDUSS))+uid+32 字节盐+time+devuid)；devuid=MD5(bduss).hex 大写+"|0"
   - ShareSURLInfoSign：md5(shareID+"_sharesurlinfo!@#")
6. **官方通道**无 rand 概念：一律 access_token query 鉴权。

## 5. 错误码表

| 域 | 错误码 | 语义 | 证据 |
|---|---|---|---|
| 风控/熔断（bdn 全线停机线） | **31119 / 31329** | 账号异常/风控——立即全通道停+官方客户端交叉验证+冷却 | 战役红线（W1 未触发） |
| 限流 | **20012**（次数上限）/ **31034**（接口频控） | 限流；被动记录+熔断，禁主动探底 | D |
| 权限 | 20011（授权用户数超）/20013（无接口权限）/31024（上传权限）/20020（沙箱路径越权） | T1 沙箱体系 | D |
| token | 20016（过期）/20017（无效）/31045（校验失败）/**-6**（身份失败） | OAuth/access_token 族 | D（-6 任务书点名） |
| 文件域 | -9（不存在）/-7（文件名非法或权限）/-8（已存在）/10（创建失败）/111（异步任务中）/31190（文件未找到）/31355（参数） | filemanager/create 族 | D |
| 上传 | 31061（已存在）/31064（路径错）/31299（首片<4MB）/31363（分片缺失）/31364（超分片上限）/31365（超总量）/-10（容量不足） | 三段流族 | D |
| 上传（蓝本补） | 31112（配额满） | 上传引擎熔断 | B（upload_task_unit.go:253） |
| 下载 | 31326（防盗链，UA 缺 pan.baidu.com）/31360（dlink 过期可重查）/9013（黑名单账号）/31326+hitcode 104（CT11 Range>5MB 越界） | 下载族 | D+B（bdp） |
| 转存（旧链） | -9（提取码错）/8001（触发验证码）/12（超转存上限，响应含 target_file_nums_limit）/4（重复）/-30（同名）/**2（share/transfer 参数门——W5 两发缺 bdstoken；W6 一发带 bdstoken 仍 2，真因=缺 shareid/from 全参，ERRATA_1030）** | share/verify→transfer | B+A（W5+W6） |
| 转存（apaas 新代） | 13001（分享状态异常）/13003（提取码错）/13010（分享文件不存在）/13041/13045/13063/13072（普通达限）/13073（会员达限）/13076（已存在）/13077（容量不足）/13062/13070（任务不存在）/13071（他任务进行中） | apaas 族 | D |
| 转存（通用） | 10（已存在）/12（批量出错）/255（数量太多） | 平台级 | D |
| 详情 | 42211-42214（图片详情失败/共享目录上传者/鉴权/详情失败）/42905（uinfo 可重试） | meta 族 | D |
| 签名过期 | 112/113 | web 下载 sign 失效→重取自愈 | B（download.go:165-171） |
| 通用参数 | **2**（参数错误——W1 filediff 空 cursor 实测；W4 filemanager from/to 形态同码） | 通用 | A（W1/W4） |
| 写面风控 | **9019 need verify**（xpan 写面验证墙）；**404**（/api/create 时 uploadid 无已注册分片） | xpan 写 / 上传③ | A（W4） |
| superfile2 | **31023** param error（缺参：path 未双放/缺 vip/web/app_id；与 UA 无关——judge 1029 native UA 全参重放 200）；**31024** app id empty | 上传② | A（W4+judge 复核） |
| mbox | -10（群转存全网下线） | 勿投入 | B（bdp 实测） |
| 蓝本自定义 | 1919810（rsync）/114514（skip） | 引擎内部码非服务端 | B |

## 6. 协议代际漂移账

| # | 漂移 | 证据级 |
|---|---|---|
| 1 | **pcs.baidu.com 旧域族退役**：蓝本 13 用法（quota/list/meta/mkdir/move/copy/delete/search/upload/locatedownload/download 等）在 8.2.5 抓包零出现；身份/配额/列表已结构性迁移 `pan.baidu.com/api/*`。例外活口：`d.pcs locateupload`（上传发现，A 在役）+ `pcs/adx`（广告，A 在役）+ superfile2（上传分片，官方现行 D） | A+B |
| 2 | clienttype=17（安卓伪装，locatedownload 专用）在 8.2.5 不用；现行=clienttype=8 + channel=00000000000000000000000040000001 | A+B |
| 3 | api/quota 双形态：8.2.5 客户端 POST（带 rand 模板）；官方文档 GET——两形态同日皆活（W1 GET errno=0 + 抓包 POST 在役） | A+D |
| 4 | **xpan/multifile?method=metas → 404 已死**（W1 实测）；现行=xpan/multimedia?method=filemetas | A+D |
| 5 | 分享服务代际：旧 xpan/share 写面官方 2026-09-16 下线→apaas 付费新代；但**只读面 xpan/share?method=record 与 share/record 同日双活**（W1 各 errno=0）——下线口径仅覆盖写面 | A+D |
| 6 | /mbox/msg/transfer 群转存全网下线（-10，UI 入口同除） | B |
| 7 | PCS list 1000 条上限→蓝本已迁 web /api/list（#511，2026 修复） | B |
| 8 | superfile3 灰度中：YunLogic 配置开关 upload_using_superfile3_count/percent（三档分块 4/16/64MB 逻辑并存） | C+B |
| 9 | filediff 双代并存：蓝本 api/batch/filediff（GET+LocateDownloadSign）vs 8.2.5 api/filediff（POST+cursor body，无 sign 族参数）——8.2.5 已弃 batch 形态 | A+B |
| 10 | 长连推送/心跳不走 HTTP 代理：直连 3 IP（119.249.103.49 等）抓包够不着，dss/device+online 为其 HTTP 注册面——协议补齐需静态腿（kernel_btsdk/YunDls） | A |
| 11 | 认证代际：Cookie(BDUSS/STOKEN)（T2/T3 主凭据）vs OAuth access_token（T1，2026-06-03 后新应用沙箱锁死 /apps/{appname}）双体系并行 | A+D |
| 12 | 开放问题：rand/rand2 生成算法（疑 kernel_btsdk.dll）、HTTPDNS sign 算法（account_id=171195）、netbase Cronet pinning 是否启用——均待静态腿 | A+C |
| 13 | **写面通道代际（W4 实测 2026-10-29）**：/api 家族写面（api/create + api/filemanager，web 客户端同款 query=clienttype=8&app_id=250528&web=1）全通；xpan 写面 9019 need verify 风控墙（本账号死路）；pcs 遗产 mkdir 假成功（errno=0 不落盘）。写面唯一可靠通道=/api 家族 | A（W4） |
| 14 | **服务端 md5 混淆（W4 实测）**：/api 三段上传落盘后 create/metas 回的 md5 含非 hex 字符（如 `…2775j4f…`），与本地真实 md5 不符 → precreate 秒传索引永不命中（四变体实测全 return_type=1）；下载侧 md5 校验必须比对本地源 md5 | A（W4） |
| 15 | **旧代分享/转存链实测存活（W5 2026-10-29）**：官方 2026-09-16「旧分享服务下线」宣后，pset（创建）/cancel（取消）/surlinfoinrecord（取码，顶层 pwd 明文）/share/verify（randsk 回）/share/list（fs_id 字符串形态）五端点当日全 errno=0——「下线」实际只覆盖 apaas 迁移的官方口径面，旧链读写均在役；唯 share/transfer 存 **参数门 errno 2**（W6 勘误：bdstoken 单因证伪——带 bdstoken 仍 2，真因疑缺 shareid/from 全参（蓝本 transfer.go:79-85），全参形态已实装待 W7 复测，ERRATA_1030.md） | A（W5）+A（W6 复测） |

## 7. W1 普查回执

9/12 发（quota POST 兜底未触发），零 rand/rand2，零风控码，凭据全程掩码——原始账本见 `analysis/W1_LIVENESS.md`。活性/rand 两列已回填，涉及端点全部升 A 级+2026-10-29 日期戳。下一步（W2）：客户端 UI 会话恢复后补抓写面（pset/filemanager/transfer/recycle-restore），落写侧活性证据。

## 8. W4 写面+传输回执（2026-10-29）

replica/tests/smoke_w4_live.py 全序活体（a-h）：写面全部限定 /API复刻测试_1029/ 围栏，控制面≤80 发预算内，熔断全程闭合，凭据全程掩码。写面通道漂移 #13/#14 当日实测定型；秒传与 filediff 冷启动两处遗留如实记账（见上表）。

## 9. W5 路由/体检/镜像/分享回执（2026-10-29）

replica/tests/smoke_w5_live.py + _diag_w5_transfer.py 全序活体：围栏 /API复刻测试_1029/，熔断全程闭合，凭据全程掩码，原始输出全档 tests/_diag_archive/（W4 勘误纪律）。

- **doctor 八针**：verdict=ok，8/8 针全绿（loginStatus 4998.8ms 冷启 / quota 总 18.8TB / api:list 根 18 项=基线 17+围栏产物（信息项）/ filemetas / share/record 43 条 / recycle / locateupload 8 servers / precreate 缺参门 errno 2=参数完整度门在位），协议指纹零漂移，8 发。
- **mirror 两遍**：..\analysis（29 文件/5,112,199B，3 空文件跳过）→ /API复刻测试_1029/mirror_test/：pass1 上传 26/26（控制面 58 发+数据面 26 发/5.1MB，215.9s，建目录 4 段）；pass2 **增量=0 上传**（26 未变，3 发）；CLI pass3 复证 0/0/0。远端只增不删全程（remote_only=0）。
- **share 写面**：pset 创建 errno=0（1 发，shareid=65048642201，带提取码）；cancel errno=0（1 发）；record 列表复核该 shareid 消失。
- **transfer 链**：surlinfoinrecord（errno 0，顶层 pwd）→ verify（errno 0，randsk 48 位）→ share/list（errno 0，去前导'1'形态）→ share/transfer **errno 2**（两发硬帽用尽；缺 bdstoken 实测定位，携带形态已实装+单测，复测 1 发留 W6）——b 腿按纪律未硬闯，条件门收口=参数门非 9019/付费墙。【W6 勘误 1030：复测带 bdstoken 仍 errno 2，「缺 bdstoken」单因证伪；真因=缺 shareid/from 全参（蓝本 transfer.go:79-85），全参形态已实装待 W7——ERRATA_1030.md】
- **账本（如实）**：主账 doctor+share/transfer 族 27 发（≤80；含 transfer CLI 子进程 6 发与诊断探针 6 发两笔未回 JSON 事后补记）；mirror 单列 64 发（≤120）；数据面 26 发/5,112,199B；share create 1/2 发、transfer POST 2/2；远端零删除。
