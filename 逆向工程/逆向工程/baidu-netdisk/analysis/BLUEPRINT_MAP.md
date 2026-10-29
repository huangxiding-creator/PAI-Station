# 百度网盘客户端逆向 — 巨人蓝本映射表（BLUEPRINT_MAP）

> 战役：百度网盘客户端逆向 / 巨人蓝本腿。日期：2026-10-29。
> 蓝本一：BaiduPCS-Go（Apache-2.0，活跃正统续作）@ blueprint/BaiduPCS-Go，HEAD `1b91318`（"fix: 跳过断开的软链接"），浅克隆 2.0M。
> 蓝本二：baiduwangpan-cli（MIT，Node.js）@ blueprint/baiduwangpan-cli，HEAD `76a1fee`，只为 docs/ 逆向文档 + BDUSS 收割思路。
> 克隆通道：直连与 7890 代理均断（SSL reset）；**ghfast.top 镜像直连克隆成功**（github.com 主域被针对性 reset，镜像与 api.github.com@7892 均通）。
> 行号引用基准：`BaiduPCS-Go/` = blueprint/BaiduPCS-Go/；`bdp/` = blueprint/baiduwangpan-cli/。

## 1. 端点常量表（12 项需求操作 → 源码位置）

三类 URL 生成器（先懂这个，全表就顺了）：
- `generatePCSURL` BaiduPCS-Go/baidupcs/baidupcs.go:420 → `pcs.baidu.com/rest/2.0/pcs/<sub>?app_id=&method=`（旧 PCS 域）
- `generatePCSURL2` baidupcs.go:437 → `pan.baidu.com/rest/2.0/<sub>?method=`（xpan 新域）
- `generatePanURL` baidupcs.go:456 → `pan.baidu.com/api/<sub>`（web 端接口）
- Host 常量：`PCSBaiduCom="pcs.baidu.com"` baidupcs.go:108；`PanBaiduCom="pan.baidu.com"` baidupcs.go:110；`baiduPcsComURL Host="baidupcs.com"` baidupcs.go:131-134

| 需求操作 | 实际端点 | 构造位置（文件:行号） |
|---|---|---|
| 文件列表 | `pan.baidu.com/api/list?dir=&order=&desc=&num=&page=`（web 版翻页，修 #511） | BaiduPCS-Go/baidupcs/prepare.go:166-198 |
| 文件元信息 | PCS `file?method=meta` POST multipart param | prepare.go:141-158 |
| 搜索 | PCS `file?method=search&path=&wd=&re=` | prepare.go:232-249 |
| 新建目录 | PCS `file?method=mkdir&path=` POST | prepare.go:272-281 |
| 移动/重命名 | PCS `file?method=move` POST param（rename=move 单条） | prepare.go:283-331（op 分派 287-293） |
| 复制 | PCS `file?method=copy` POST param | prepare.go:283-313, 324-326 |
| 删除 | PCS `file?method=delete` POST param | prepare.go:252-269 |
| 回收站列表 | `pan.baidu.com/api/recycle/list?num=100&page=` | prepare.go:824-836 |
| 回收站还原 | PCS `file?method=restore` POST param(fs_id 列表) | prepare.go:839-867 |
| 回收站删除 | `pan.baidu.com/api/recycle/delete` POST fidlist | prepare.go:870-882 |
| 回收站清空 | PCS `file?method=delete&type=recycle` GET | prepare.go:885-896 |
| 上传①precreate | `pan.baidu.com/api/precreate` POST（content-md5/slice-md5/block_list/rtype=2） | prepare.go:604-628 |
| 上传②分片 | PCS `superfile2?method=upload&type=tmpfile&partseq=&partoffset=&uploadid=&vip=1`（multipart） | prepare.go:631-658 |
| 上传③合并 | `pan.baidu.com/api/create` POST uploadid/block_list/size/rtype | prepare.go:580-602 |
| 上传旧①② | PCS `file?method=upload type=tmpfile` / `file?method=upload&path=&ondup=` | prepare.go:554-577 / 526-551 |
| 秒传 | 新①`xpan/file?method=create&access_token=` POST block_list/rtype=3；新②`api/precreate` + data_offset/data_content | prepare.go:334-357（旧）、360-394（V2 秒传）、396-418（fake） |
| 下载直链① | PCS `file?method=locatedownload` + ant/check_blue/es/esl/ver=4.0/clienttype=17/... + sign 参数（见 §5） | prepare.go:453-495 |
| 下载直链② | `pan.baidu.com/api/download` POST sign/timestamp/fidlist（web 版，配合 panhome 签名） | prepare.go:498-523 |
| 下载执行 | PCS `file?method=download&path=`；流式 `stream?method=download` | BaiduPCS-Go/baidupcs/download.go:106-125 |
| 分享创建 | `pan.baidu.com/share/pset` POST path_list/schannel=4/pwd/period/share_type=9 | prepare.go:739-760 |
| 分享取消/列表 | `share/cancel` POST shareid_list；`share/record` GET page | prepare.go:762-801 |
| 分享详情(含密码) | `share/surlinfoinrecord?shareid=&sign=` | prepare.go:803-821 |
| 转存 | `share/verify`→`share/list`→`share/transfer`（三步编排，见 §8） | baidupcs/transfer.go:43-118 + internal/pcscommand/transfer.go:14-133 |
| 配额 | PCS `quota?method=info` | prepare.go:130-138；解析 baidupcs/quota.go:14-33 |
| 用户信息/UK | `pan.baidu.com/api/user/getinfo?need_selfinfo=1` | prepare.go:99-115 |
| bdstoken | `pan.baidu.com/api/gettemplatevariable?fields=["bdstoken"]` | prepare.go:220-229 |
| 上传服务器发现 | PCS `file?method=locateupload&upload_version=2.0` | prepare.go:117-128 |
| 离线下载 | `rest/2.0/services/cloud_dl` add_task/query_task/list_task/cancel/delete/clear | prepare.go:660-737 |
| 增量 diff | `pan.baidu.com/api/batch/filediff?cursor=` + sign | prepare.go:200-218 |

## 2. 认证（BDUSS / STOKEN / SBOXTKN）

- **全部走 Cookie，域 `.baidu.com`**（`DotBaiduCom` baidupcs.go:118），不是 URL 参数：
  - BDUSS：`NewPCS(appID, bduss)` 即 `Jar.SetCookies(pan.baidu.com, {BDUSS, Domain:.baidu.com})` baidupcs/baidupcs.go:214-230
  - 整串 cookie：`NewPCSWithCookieStr` baidupcs.go:241-258（`requester.ParseCookieStr` 解析）
  - STOKEN：`SetStoken` 同样写 Cookie baidupcs.go:327-340（转存必须）
  - SBOXTKN：`SetSboxtkn` baidupcs.go:343-356
  - accessToken（秒传转存用）：`SetaccessToken` 走 URL 参数 baidupcs.go:322-324
- Cookie 去重防串：`UpdatePCSCookies(reverse)` 同名只留最新 baidupcs.go:170-212（转存链中 verify 后调两次，pcscommand/transfer.go:76,113）
- 读取：`GetBDUSS` baidupcs.go:279 / `GetBAIDUID` baidupcs.go:293
- 登录接口本体不在 baidupcs 包：走外部库 `github.com/qjfoidnh/Baidu-Login v1.4.1`（go.mod:14）+ 贴吧接口 `tieba.NewUserInfoByBDUSS` 反查 uid（prepare.go:458）
- dlink 实际下载时也要带 BDUSS/STOKEN Cookie（bdp docs group-download-final-verdict.md:52 实测结论）

## 3. UA 常量与 app_id（原文照抄）

| 常量 | 原文 | 位置 |
|---|---|---|
| `NetdiskUA` | `netdisk;P2SP;3.0.0.8;netdisk;11.12.3;ANG-AN00;android-android;10.0;JSbridge4.4.0;jointBridge;1.1.0;` | baidupcs.go:116 |
| `PanAppID` | `250528` | baidupcs.go:114 |
| `requester.UserAgent`（浏览器兜底） | `Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_2) ... Chrome/63.0.3239.132 ...` | requester/requester.go:6,11 |
| `PanHomeUserAgent` | `Mozilla/5.0` | baidupcs/internal/panhome/panhome.go:20 |
| 转存页面 UA | Chrome/76 Windows（`transfer.go:168`）+ NetdiskUA 访分享页（transfer.go:124，修 #534：Chrome UA 会被反爬弹无 loginstate 页，**netdisk UA 才放行**） |

UA 分派：`sendReqReturnResp` reqTypePCS→pcsUA / reqTypePan→panUA（默认 NetdiskUA，`lazyInit` baidupcs.go:267-269）；可 `SetPCSUserAgent`/`SetPanUserAgent` 覆盖 baidupcs.go:358-361,388-391。

## 4. netdisksign 签名包（baidupcs/netdisksign/）

四件套，全部无外部依赖、可 1:1 翻译成 Python：
1. **Sign2 = RC4**（KSA+PRGA 标准流程，key=sign3、data=sign1）netdisksign/sign2.go:3-36；测试向量 sign2_test.go:15。调用点：panhome/sign.go:35（web 下载签名 = Base64(Sign2(sign3,sign1))，sign.go:29-41）
2. **sign1/sign3/timestamp 抓取**：GET `pan.baidu.com/disk/home`（UA=Mozilla/5.0，不跟随重定向；跳 passport.baidu.com = cookie 无效），正则 `"sign1":"(.*?)"..."sign3":"(.*?)","timestamp":(\d*?),` panhome/parse.go:13,19-66；签名过期自动重取（download.go:165-171 遇 errno 112/113 重置）
3. **LocateDownloadSign（安卓端下载签名）**：`rand = sha1( hex(sha1(BDUSS)) + uid + 盐 + time + devuid )`，盐为 32 字节固定串（位于 locatedownloadsign.go:42 字节数组）；`URLParam()=time=&rand=&devuid=&cuid=` locatedownloadsign.go:50-52；devuid=`MD5(bduss).hex 大写 + "|0"` devuid.go:11-20。调用点：prepare.go:209（diff）、469（locatedownload）
4. **ShareSURLInfoSign**：`md5(shareID + "_sharesurlinfo!@#")` hex share_sign.go:11-20；调用 prepare.go:809

## 5. 下载（d.pcs 直链构造与限速对策）

- **d.pcs 直链不是拼出来的，是 API 返回的**：`locatedownload` 响应 `urls[]`（取 encrypt==0 的明文条目，域名为 d.pcs.baidu.com 系列），`URLInfo.SingleURL/LastURL` 只改 scheme baidupcs/download.go:57-103；web 版 `/api/download` 返回 `dlink`（download.go:150-177）
- locatedownload 完整参数串（安卓伪装）：ant=1/check_blue=1/es=1/esl=1/app_id=250528/method=locatedownload/path=/ver=4.0/clienttype=17/channel=0/apn_id=1_0/freeisp=0/queryfree=0/use=0 + §4.3 的 sign 四参数 prepare.go:470-490；UA 必须 panUA（NetdiskUA）prepare.go:493
- dlink 下载要求：带 BDUSS/STOKEN Cookie + **浏览器 UA**（netdisk UA 在 web dlink 上返回 118 字节错误页——bdp docs group-transfer-reverse-engineering.md:58 实测）
- 首块探测：`InitRangeSize=32KB` download.go:15
- 限速对策（issue #549 实测：非会员 cookie 登录 50k→400k 即被掐断循环）：工程层多线程+分块续传（requester/downloader/downloader.go:170 按 blockSize 切 Range），蓝本无协议层破解
- PCS 服务器池：`locateupload` 拿 servers 列表随机挑一个 `GetRandomPCSHost` baidupcs/upload.go:226-258（pcsAddr 可 `SetPCSAddr` 钉死 baidupcs.go:364）

## 6. 秒传细节（slice-md5 / block_list / data=md5(uk+content_md5+ts)）

常量（baidupcs/upload.go:14-35）：
- `SliceMD5Size = 256KB`（:26）；`EmptyContentMD5 = d41d8cd98f00b204e9800998ecf8427e`（:28）
- 分块三档：`Min 4MB`（:20）/ `Middle 16MB`（:18）/ `Max 64MB`（:16，注意不是 32MB）；阈值 `8GB→16MB`、`32GB→64MB`（:30-32）
- 分块选择：`getBlockSize` internal/pcsfunctions/pcsupload/utils.go:11-20；切块 `uploader.SplitBlock` requester/uploader/block.go:38-46
- **动态 offset 公式就在这**：`creaetDataOffset` pcsupload/utils.go:22-38 = `offset = int64(md5(str(uk)+content_md5+str(ts)).hex[0:8], 16) % (fileSize - subSize + 1)`（mixedMD5 前 8 hex 转 64 位再取模）——即任务书里的 data=md5(uk+content_md5+ts)；随 data_offset 一起 POST 的还有 data_length/data_content（prepare.go:366-378）
- V2 秒传链（api/precreate）：content-md5 + slice-md5(前 256KB 的 md5) + block_list(JSON 数组串) + rtype 策略；响应 `return_type=2` 即秒传成功 / `=1` 拿 uploadid 走分片 pcsupload/upload_task_unit.go:240-246
- 秒传信息收割（别人盘里的文件）：`GetRapidUploadInfoByLink` baidupcs/extends.go:130-268 —— 对直链发 `Range: bytes=0-262143` + panUA，从响应头拿 `Content-MD5`/`x-bs-meta-crc32`/`Content-Disposition` 文件名，正文前 256KB 现算 slice-md5（extends.go:239-253）；≤256KB 时 slice=content（:229-237）；Content-MD5 缺失时切 web `method=download` 接口重试（:110-116, 121-127）
- 旧式秒传（xpan create + access_token）：prepare.go:334-357；FakeRapidUpload（伪造 block_list 占位）：fakeBlockListMD5 upload.go:49-50 + prepare.go:396-418
- 通用秒传链接格式（导出侧）：`md5#slice_md5#length#filename` main.go:1325；秒传链接转存已被官方封（pcscommand/transfer.go:36-38 "秒传已不再被支持"）
- FixMD5（md5 损坏文件重秒传修复）：extends.go:271-329

## 7. 上传三段编排（引擎层，可复用）

`pcsupload/upload_task_unit.go`：precreate(:240 前构造) → return_type=2 秒传成功(:240-246) / =1 → `NewPCSUpload`(internal/pcsfunctions/pcsupload/upload.go:52，实现 uploader.MultiUpload 三钩子 precreate/superfile2/create) → 断点库 UploadingDatabase(:288-289)；配额满 errno 31112(:253)；rsync/skip 自定义码 1919810/114514(:255-273)。

## 8. 转存/分享（实现 + 已知坑）

**转存七步**（internal/pcscommand/transfer.go `RunShareTransfer`:14-133）：
1. 正则从整段分享文本提取链接+提取码（:19-26）；surl 特征串解析（:44-51）
2. `AccessSharePage(first=true)`：UA=NetdiskUA 访问 `pan.baidu.com/s/<surl>`，正则抓页面 `loginstate` JSON 拿 bdstoken/uk/share_uk/shareid（baidupcs/transfer.go:120-162；正则修 #534 见 :149）
3. `POST /share/verify?shareid&time&clienttype=1&uk` body pwd/vcode=null/bdstoken → randsk（pcscommand:59-74；提取码错 errno=-9 transfer.go:110-112；触发验证 errno=8001 transfer.go:58-60）
4. `UpdatePCSCookies(true)`（:76）
5. `AccessSharePage(first=false)` 二次访问（:78）
6. `GET /share/list?shorturl&root=1&web=5&channel=chunlei&app_id=250528` 拿 fs_id 列表（:83-92，baidupcs/transfer.go:43-92）
7. `POST /share/transfer?app_id=250528&channel=chunlei&clienttype=0&web=1` body fsidlist+path（:114，baidupcs/transfer.go:164-236）；errno 12=超转存数上限（响应里有 target_file_nums_limit，:199-208）、-30=同名、4=重复

**已知坑（issue 实查）**：
- **#546**「还是偶尔会报网盘stoken 错误，以及文件重复（但实际并没有重复）」——唯一评论"同样的问题"，**未根治**：上游对非官方客户端 STOKEN 校验趋严、偶发失效；对策=失败重试整链+重新 `AccessSharePage` 刷 token（蓝本自带 SetSignExpires 类似的 112/113 自愈，download.go:165-171）
- **#549**「断断续续是被官方识别了吗」——非会员下载限速循环（50k→400k 掐断→0k→循环），无评论无修复；协议层无解，工程对策=多 PCS host + 分块并发 + 限速自适应
- 相关 #534（Chrome UA 反爬→netdisk UA）已修：transfer.go:124,149；#511（PCS list 1000 条上限→改 web /api/list）已修：prepare.go:162-165
- **群文件转存 `/mbox/msg/transfer` 已被百度全网下线**（errno=-10，UI 入口也移除）——见附录 A，别投入

## 9. 可 import 性与两路线评估

**baidupcs 包就是设计好的库**（baidupcs.go:1 注释"RESTful API 工具包"）：`NewPCS(appID, bduss)` 一个入口，全部操作都是 `(pcs *BaiduPCS)` 方法，入参出参干净（paths.../cpmvJSON.../RapidUploadInfo 结构体），无 UI 耦合（internal/pcscommand 才是 CLI 层）。go.mod 依赖轻（jsoniter/gjson/cli/Baidu-Login，go 1.23）。
- 高层 API 面（直接调）：FilesDirectoriesList/Meta/BatchMeta/Search（file_directory.go:110,132,208,257）、Mkdir/Remove（rm_mkdir.go:28,9）、Rename/Copy/Move（cp_mv_rename.go:9,17,22）、QuotaInfo（quota.go:14）、RecycleList/Restore/Delete/Clear（recycle.go:47,69,87,100）、ShareSet/Cancel/List/SURLInfo（share.go:72,106,119,156）、RapidUpload/FakeRapidUpload（upload.go:105,117）、UploadTmpFile/UploadCreateSuperFile（upload.go:176,205）、LocateDownload/LocatePanAPIDownload（download.go:128,151）、UK/BDSToken（baidupcs.go:474,501）、缓存版 CacheFilesDirectoriesList（cache.go:22）
- 引擎层（internal/pcsfunctions/pcsupload）也可整体复用：断点库+MultiUpload 编排
- bdp（Node）的用法实证了第三条路：**直接 spawn BaiduPCS-Go.exe 当引擎**，自己只包编排（bdp/lib/pcs-extra.js）——坑：操作类命令**失败退出码仍 0**，必须解析输出文本（pcs-extra.js:10-11 实测注释）

| 维度 | A. Go 库直用（fork/加薄层） | B. Python 复刻 |
|---|---|---|
| 协议正确性 | 开箱即用（含 #511/#534 等热修复） | 需翻译 §1-§6 全表；签名/秒传/分块逻辑直给（本表即规格） |
| 12 项需求覆盖 | 全覆盖（端点表 §1 = 现成代码） | 同样可达，逐条照抄参数即可 |
| 与既有 Python 产线整合 | 需 go 编译/子进程桥（bdp 模式）或 cgo/gRPC | 原生 requests + 本表，零桥接 |
| 维护成本 | 上游活跃可定期 rebase | 百度改协议时自己修（可借鉴上游 diff） |
| 工作量估计 | 薄 CLI/服务封装 1-2 天 | 核心五件（URL 表+Cookie 认证+四签名+秒传+上传三段）3-5 天；转存链照 §8 抄 1 天 |
| 建议场景 | 要稳、要全、能带 Go 工具链 | 产线是 Python、要嵌管线（本站现状） |

**初步建议：混合——Python 复刻为主（本表即规格书，签名四件套纯算法可直译），BaiduPCS-Go.exe 作对照验证器**（同参数同 cookie 跑一遍 diff 响应，协议漂移时用上游 diff 定位）。

## 附录 A：baiduwangpan-cli（bdp）增量逆向成果

**A1. 群文件下载终审**（bdp/docs/group-download-final-verdict.md，2026-08-12 SVIP 实测）：
- 唯一可行路线 `POST /api/sharedownload?sign=&timestamp=`（**sign/timestamp 留空**），body `uk=<分享者uk>&product=mbox&encrypt=0&primaryid=<msg_id>&fid_list=["<fs_id>"]&extra={"type":"group","gid":"<gid>"}`（group-transfer-reverse-engineering.md:51-53）→ 明文 dlink（d.pcs.baidu.com，8h 有效）
- 限制：单文件 ≤~20MB（大文件返回动态加密 list，前端无解密代码，AES/RC4 全试失败）；同消息多文件 zip（`type=batch`）总包 ≤~100MB（31090 package too large）；zip 按消息归组
- `/mbox/msg/transfer` 群转存**全网下线**（非空目录一律 errno=-10，logId=base64(BAIDUID)+channel=chunlei 补参也无效，UI 入口已移除）——旧开源资料（DuPanSync 等）不再适用
- mbox 浏览 API 全表：`/mbox/group/list`、`/mbox/group/listshare`（翻页 last_msg_time）、`/mbox/msg/shareinfo`、`/mbox/group/getinfo`（群主 uk）、`/imbox/msg/pull`（group-transfer-reverse-engineering.md §一/§六）

**A2. HTTP Range 免下载 cat/grep**（bdp/lib/pan.js）：
- 思路：拿 dlink 后不发整文件，`curlRange(dlink, start, end, ua)` 按需取片段（pan.js:96-104）；cat=头部片段(:142)、grep=4MB 块流式(:152,256)、tail=尾段(:168)、预览=头部字节(:223)
- **硬坑：百度 CT11 节点只允许有界 Range ≤~5MB**，越界 403 error_code 31326 hitcode 104（pan.js:248,256 注释实测）；分块 DOWNLOAD_CHUNK=4MB 天然续传（:357）
- 引擎命令实测坑：BaiduPCS-Go v4.0.1 操作类命令（mv/cp/share/offlinedl）**失败时退出码 0**，错误只在输出文本（bdp/lib/pcs-extra.js:10-11）——子进程方案必须解析输出

**A3. BDUSS 浏览器收割**（bdp/lib/browser-login.js）：
- 找本机 Chrome/Edge（Win 候选路径清单 :13-27）→ 独立 profile 启动 `--remote-debugging-port` → 用户登录 `pan.baidu.com/disk/main` → DevTools HTTP 接口（/json/version 等）读会话 cookie 里 BDUSS/STOKEN → 写入配置
- 与本站 DrissionPage 常规打法等价，可平移到 9338 profile 法；PAN_HOME 常量 :7、APP_ID=250528 :9

**A4. 工程/升级坑**（bdp/docs/upgrade-report-bdp-1.1.0.md）：npm 分发 BaiduPCS-Go 二进制的镜像 fallback 链（ghfast/ghproxy 优先、GitHub 兜底 :110）；限流预算（--max-pages=50/--max-requests=400）；partial 结果落盘语义（--save-partial）。对 Python 复刻同样适用：镜像下载源顺序 + 请求预算 + 部分结果可恢复。

## 附录 B：蓝本未覆盖的需求缺口（复刻时需自建）

1. **群文件（mbox）**：BaiduPCS-Go 明确不支持（作者拒 issue #353），全套要走附录 A1 的 bdp 路线
2. **秒传链接转存**：上游已删（pcscommand/transfer.go:36-38），若要支持需自行实现旧 bdlink 解析（且官方已封，价值低）
3. **账号池/多账号轮换**：蓝本单账号 pcsconfig，无池化
4. **验证码（vcode）**：转存 verify 只传 "null"（pcscommand:67-68），遇真验证码无解，需自建打码腿
5. **持续集成级限速自适应**：#549 只有多线程分块，无自适应调速逻辑
6. **分享页风控升级**（#546 stoken 偶发）：蓝本无重试编排，需自包重试+刷新 token
