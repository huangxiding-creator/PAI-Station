# bdncore + bdn — 百度网盘协议核心库与 CLI（W3 只读 + W4 写命令/传输 + W5 路由/体检/镜像/分享 + W6 QA 总门）

> BDPAN-FACTORY 战役 W3「核心库+CLI」+ W4「写命令+传输引擎」+ W5「路由/doctor/mirror/share-transfer」+ W6「judge 修正+QA 总门+Ralph 微优化」。2026-10-29/30。
> 基于 8.2.5 PC 客户端抓包逆向（../analysis/CAPTURE_INVENTORY.md）与 BaiduPCS-Go 蓝本（../analysis/BLUEPRINT_MAP.md）。
> W4 起：mkdir/rename/mv/cp/rm + 上传三段（秒传探测/分片并发/断点续传）+ 下载（dlink+Range 多线程+md5 校验）。
> **写面通道结论（W4 实测）**：唯一可靠通道=/api 家族（api/create + api/filemanager，web 客户端同款）；
> xpan 写面 9019 need verify 风控墙；pcs 遗产 mkdir 假成功。superfile2 门=参数完整度（path 双放+vip=2+web=1+app_id），UA 双腿均放行（1029 勘误，见 ERRATA_1029.md）。
> W5 起：读面 api→xpan 降级链（router）；doctor 八针体检+协议指纹漂移；mirror 增量镜像（**远端只增不删**）；
> 旧代分享写面实测存活（pset/cancel/surlinfoinrecord/verify/list 全 errno=0；transfer errno 2 参数门——W6 勘误 bdstoken 单因证伪，见 ../ERRATA_1030.md）。
> W6 起：share-cancel 属主护栏（非自建拒发退出 3）+ mirror 远端目标护栏（/ 与一级根目录拒绝，--allow-root 放行）+
> 归档清洗器（_diag_archive/scrub.py，URL pwd 掩码；W5 share_create.json 已追溯清洗留 .orig）；
> QA 总门 23/24 绿（全命令面活体终验，transfer=N/A 维持）；E1 搜索=xpan 唯一维持（pcs 遗产死亡再证）；
> E2 下载线程=**8 线程 5.19MB/s vs 4 线程 2.15MB/s（+58.6%，单次测量），默认 8 维持**。

## 布局

```
bdncore/session.py   凭据(JSON直读,BDUSS含'-')/Cookie头/UA/重试退避(3次1.5s→3s)/
                     控制面节流(并发≤2,间隔≥1.5s)/熔断器(errno 31119|31329|20012|31034全局停)/
                     跨域绝对URL(d.pcs/pcs) + 裸数组响应容忍(W4) + 附加Cookie段(W5 转存链 BDCLND)
bdncore/errors.py    errno→中文语义映射 + BdnError 异常族(业务1/凭据与熔断2)
bdncore/api.py       只读9件套 + 写面W4(mkdir/rename/mv/cp/rm/上传三段/locate_upload/
                     metas?dlink=1/filediff) + W5分享转存族(share_create/ share_cancel/
                     share_surl_info/ share_verify/ share_list/ share_transfer/ surl_from_link)
bdncore/router.py    W5通道路由: READ_CHAINS(ls/share_records=api→xpan降级链, meta/quota=内置,
                     search=xpan独占) + WRITE_FAMILY=api唯一(xpan写面9019墙结构性排除) +
                     should_fallback钩子(5xx/超时→xpan重试一次; 业务errno不降级; 熔断/凭据不降级) +
                     T1 bdpan子进程通道桩(默认off, 遥测取舍见注释)
bdncore/doctor.py    W5复验器: 八针只读体检(凭据活性/读探针/quota/四族协议指纹vs PROTOCOL A级预期/
                     locateupload/precreate缺参门) → ok/degraded/dead + drift清单, 8发
bdncore/mirror.py    W5镜像: 本地扫描(size+mtime+md5缓存) + 远端递归ls对账 → 只传缺失/变更
                     (rtype=3覆盖), **远端只增不删**(remote_only只报告); 空文件跳过;
                     state=.bdn_mirror_<h>.json(恒排除扫描); 换远端目标缓存作废
bdncore/transfer.py  传输引擎W4: UploadEngine(precreate试秒传→superfile2分片并发≤8→create收尾;
                     .bdn_upload_state.json断点续传,uploadid失效自动重走precreate) +
                     DownloadEngine(metas dlink→浏览器UA+Range 4MB×≤8线程→md5校验; 混淆md5免疫)
bdn.py               CLI: whoami|quota|ls|tree|search|meta|shares|recycle|doctor|
                     mkdir|rename|mv|cp|rm(--confirm铁律)|upload|download|
                     mirror|share-create|share-cancel|transfer，
                     全支持 --json，退出码 0/1/2/3
tests/test_offline.py      W3 离线单测 35 项（节流/映射/熔断/退避/翻页钳制/归一）
tests/test_offline_w4.py   W4 离线单测 35 项（分块数学/md5/写面形态/三段+断点/下载+校验/rm双段）
tests/test_offline_w5.py   W5 离线单测 31 项（路由降级/doctor八针/mirror计划/分享转存形态）
tests/test_offline_w6.py   W6 离线单测 14 项（share-cancel属主护栏/mirror目标护栏/归档清洗器）
tests/smoke_live.py        W3 活体冒烟（8 命令+doctor+CLI，预算 40 发）
tests/smoke_w4_live.py     W4 活体验收（a-h 全序，写面围栏+控制面≤80+数据面分账）
tests/smoke_w5_live.py     W5 活体验收（doctor/mirror两遍/share-transfer条件门，主账≤80+mirror单列≤120）
tests/w6_transfer_retest.py  W6 transfer 复测（1 发写；errno 2 维持→ERRATA_1030）
tests/w6_transfer_hop_probe.py  W6 跳级探针（只读五跳钉死断点在 transfer POST）
tests/w6_qa_gate.py        W6 QA 总门（全命令面活体终验+E1/E2，断点续档可重跑）
tests/_diag_w4*.py         W4 诊断探针七件（战役记录：写面通道/秒传变体/参数矩阵定位）
tests/_diag_w5_transfer.py W5 转存链断点定位探针（errno 2 → W6 勘误：非单因 bdstoken）
tests/_diag_archive\       活测/诊断原始输出全档（W4 勘误纪律）；scrub.py=归档清洗器（judge #2）；
                           w6_qa_gate\=QA 总门全档+SUMMARY.md 汇总表
```

## 用法

```powershell
cd E:\AI-Station\逆向工程\baidu-netdisk\replica
python -m unittest discover -s tests      # 离线单测（115 项）
python tests\smoke_live.py                # W3 活体冒烟（只读）
python tests\smoke_w4_live.py             # W4 活体验收（写面+传输，围栏 /API复刻测试_1029/）
python bdn.py whoami                      # 账号画像（login_info 子字典）
python bdn.py ls /                        # 列目录（/api/list，num≤1000 翻页保护）
python bdn.py mkdir /API复刻测试_1029      # 建目录（-8 已存在=幂等 exists=True）
python bdn.py rename /API复刻测试_1029/a.bin b.bin      # 重命名（同目录纯文件名）
python bdn.py mv /d/a.bin /dst            # 移动（filelist 官方 path+dest+newname 口径）
python bdn.py cp /d/a.bin /dst            # 复制（ondup=newcopy）
python bdn.py rm /d/a.bin                 # 只列待删清单，退出码 3（不执行）
python bdn.py rm /d/a.bin --confirm       # 打印清单后执行删除（进回收站）
python bdn.py upload C:\big.bin /d/big.bin   # 三段上传：秒传探测→4MB 分片并发≤8→断点续传
python bdn.py download /d/big.bin D:\back.bin  # dlink+Range 4MB×8 线程+md5 校验+断点续传
python bdn.py doctor                       # W5 八针体检：verdict+漂移清单（全只读 8 发）
python bdn.py mirror D:\dir /备份/dir       # 增量镜像（远端只增不删；md5 缓存增量）
python bdn.py mirror D:\dir /备份/dir --dry-run  # 只出计划零上传
                                             # 护栏：remote=/ 或一级根目录默认拒绝（--allow-root 放行）
python bdn.py share-create /d/a.bin --pwd x1y2   # 创建分享（≤2 发：蓝本形态→web 形态）
python bdn.py share-cancel 65048642201     # 取消分享（仅限自建分享）
python bdn.py transfer https://pan.baidu.com/s/1AbC /转存目录   # 自有分享转存（自动取码）
python bdn.py ls / --json                 # 任何命令 --json 机器可读输出
```

凭据默认 `E:\AI-Station\data\secrets\bdn_credentials.json`（字段 bduss/stoken/ua_native），
可用 `--cred` 或环境变量 `BDN_CREDENTIALS` 覆盖。**输出/日志一律掩码，永不落明文**；
bdstoken/分享提取码同样只出掩码。远端路径一律 `/` 开头全盘绝对路径（与官方 bdpan 沙箱的本质区别）。

## 端点路由（同功能 api 优先 > xpan > pcs 禁用）

| 功能 | 端点 | 家族 | 实证 |
|---|---|---|---|
| 账号画像 | GET /api/loginStatus?clienttype=8 | api | errno=0，画像在 `login_info` 子字典 |
| 配额 | GET /api/quota（POST 兜底） | api | errno=0，GET 直接过（17.5TB 级回显） |
| 列目录 | GET /api/list?dir=&num=&page=&order=&desc=&clienttype=8 | api | errno=0，根目录 17 项对上基线 |
| 搜索 | GET /rest/2.0/xpan/file?method=search&key=&dir=&recursion=1 | xpan | errno=0（api 家族无此端点；`wd` 别名兜底在代码中） |
| 元信息 | GET /api/filemetas?fsids=[…]&dlink=0（xpan multifile?method=metas 兜底） | api→xpan | errno=0，数据在 `info` 键，isdir 为字符串 '0'/'1' |
| 分享记录 | GET /share/record?page=&desc=1&order=time | api | errno=0，43 条，驼峰键(shareId/vCnt/dCnt/passwd) |
| 回收站 | GET /api/recycle/list?num=100&page= | api | errno=0，100 项（=单页 num，翻页继续） |
| 增量 diff | POST /api/filediff（query 全参+body cursor/action，捕获形态） | api | 活（200 JSON）；**冷启动三形态全 errno=2，游标引导链未激活（W4 遗留）** |
| 建目录 | POST /api/create?web=1（body: path&isdir=1&rtype=0） | api | **errno=0 带 fs_id（W4）**；-8=已存在幂等；bdstoken 不需要 |
| 改名/移动/复制/删除 | POST /api/filemanager?opera=…（filelist 官方口径：move/copy=path+dest+newname；rename=path+newname；delete=纯路径数组） | api | **四 opera 全 errno=0（W4）**；from/to 形态=errno 2；delete 进回收站实证 |
| 上传①②③ | POST /api/precreate → {host}/rest/2.0/pcs/superfile2 → POST /api/create | api+d.pcs | **全通（W4）**；superfile2 门=参数完整度（vip=2+web=1+app_id+path 双放），UA 双腿放行（judge 1029 复核）；host 从 locateupload servers 取 |
| 上传服务器发现 | GET d.pcs.baidu.com/rest/2.0/pcs/file?method=locateupload | d.pcs | **errno=0（W4）**，servers[] 明文（c5.pcs.baidu.com 实测；W5 doctor 复测 8 servers） |
| 下载直链 | GET /api/filemetas?fsids=&dlink=1 → dlink GET（浏览器 UA+Cookie+Range≤4MB） | api+d.pcs | **全通（W4）**：dlink 8h 带 sign；Range 4MB×3 块 md5 与源一致 |
| 创建分享 | POST /share/pset（path_list 纯路径数组+schannel=4+pwd） | api | **errno=0（W5）**：1 发即成；响应 shareid/link/shorturl/qrcodeurl 族 |
| 取消分享 | POST /share/cancel（shareid_list） | api | **errno=0（W5）**；record 列表复核消失 |
| 分享详情取码 | GET /share/surlinfoinrecord（sign=md5(shareID+"_sharesurlinfo!@#")） | api | **errno=0（W5）**：自有分享提取码**顶层 pwd 明文**回 |
| 转存①②③ | POST /share/verify → GET /share/list（shorturl 去前导'1'+BDCLND=randsk） → POST /share/transfer（query 全参 shareid+from+bdstoken，蓝本 transfer.go:79-85） | api | **verify/list errno=0（W5）**；transfer **errno=2（W5×2 缺 bdstoken；W6×1 带 bdstoken 仍 2——单因证伪，真因=缺 shareid/from 全参，ERRATA_1030；全参形态已实装待 W7）** |
| 头部 | Cookie: BDUSS+STOKEN / UA: netdisk;8.2.5.103 原生腿（superfile2 例外=CEF 腿）/ Referer: …/disk/main | — | 读面/写面全放行，无需 rand/rand2 |

## 防护矩阵

- **重试**：传输异常/HTTP≥500 才重试，3 次，退避 1.5s→3.0s；业务 errno 不重试。
- **节流**：信号量并发 ≤2 + 请求起点间隔 ≥1.5s（离线可注入时钟验证）。
- **熔断**：errno ∈ {31119, 31329, 20012, 31034} 即全局停，后续调用零触网直接抛 `BdnCircuitOpen`（退出码 2）。
- **翻页**：num 钳制 ≤1000；单目录翻页护栏 ≤10 页；tree 独立请求预算（默认 20 发，截断如实标注）。
- **凭据**：JSON 字段直读（BDUSS 含 '-'，无正则）；请求台账只记 方法/路径/状态/errno/毫秒。

## 实测（2026-10-29，数字零造假）

活体请求总账：冒烟 21（库 20+CLI 1）+ 探针 4 + 复检 5 = **30 发 ≤ 40 预算**。熔断全程闭合。

| 命令 | errno | 摘要 | 墙钟耗时(冒烟) | 线上耗时(台账) | 请求数 |
|---|---|---|---|---|---|
| whoami | 0 | pyeyeye / uk=587408217 / vip8(type=21) | 674ms（复检 492ms） | 674→55ms | 1 |
| quota | 0 | 总 17514.7GB / 用 13134.9GB / 余 4379.8GB（GET 直接过） | 931ms | 104ms | 1 |
| ls / | 0 | **17 项 = 已实证基线 17**（全目录条目） | 1566ms | 169ms | 1 |
| tree / | 0 | 234 节点/206 目录，深度实际 2，**预算 12 发如实截断** | 17996ms | 12×101-1073ms | 12 |
| search | 0 | key='演讲' 递归命中 100 条（复检）；xpan 慢端点 | 8658ms | 7318/3093ms | 1 |
| meta | 0 | 3 fs_id → 3 条元信息 [api/filemetas]，字符串 isdir 正确归一 | 92ms（复检 1571ms 含 ls） | 92ms | 1-2 |
| shares | 0 | 43 条；首条 shareid=11550421183 看12/下0；passwd=*** 掩码 | 1645ms | 236ms | 1 |
| recycle | 0 | 100 项（单页 num=100，更多走 --page 翻页） | 1875ms | 610ms | 1 |
| doctor | 0 | loginStatus 往返（冷 674ms / 热 55ms / 复检 492ms） | 945ms | 55ms | 1 |
| cli-ls --json | 0 | argparse→api→--json 端到端 exit=0 | ~1700ms | ~170ms | 1 |

离线单测：**34/34 OK**（0.012s，零网络）。

## W4 实测（2026-10-29，数字零造假；smoke_w4_live.py a-h 全序，围栏 /API复刻测试_1029/）

总账：**控制面 37/80 发**（库会话 32 + CLI 子进程 5，含 200MB 被杀段按代码路径推算 2 发）；
**数据面 60 发 / 241,173,504B（≈230MB）单列**；熔断全程闭合；总耗时 67s；产物全保留围栏内待用户处置。

| 段 | 结果 | 关键数字 |
|---|---|---|
| a mkdir+filediff | mkdir errno=0（重跑 -8 幂等 exists=True）；ls 交叉可见 | filediff 冷启动三形态（无cursor键/空串/"0"）全 errno=2 → **游标引导链遗留** |
| b 1KB 上传 | 三段全通：precreate→superfile2×1→create | 数据面 1 发/1024B；metas size=1024 匹配（md5=混淆体记信息项） |
| c 10MB 上传 | 3 块（4+4+2MB）并发 | 数据面 3 发/10,485,760B 5.27s；size 匹配 |
| d 200MB 断点续传 | **kill@30/50 片（前段 120MB）→ 重跑续传完成** | 续传段 20 发/83,886,080B=**全量的 40%** 7.63s；metas size=209,715,200 匹配 |
| e 秒传探测 | **return_type=1 miss（全量重传 10MB）** | 四变体诊断（rtype/data腿/服务端指纹）全 miss → 服务端 md5 混淆阻断 precreate 秒传索引，**遗留** |
| f 下载 10MB | dlink+Range 4MB×3 块多线程 | 4.52s **2.21MB/s**；md5 与本地源**一致** |
| g rename/mv/cp | 三发 errno=0（to_path/to_fs_id 回执） | ls 逐项核对：sub 命中+根消失+复制回根全对 |
| h rm --confirm 流 | 无 --confirm=exit 3 零执行；--confirm 后删除 | ls 确认消失 + **recycle list 命中**（进回收站实证） |

上传速度画像（数据面）：10MB/5.27s≈1.9MB/s（首包冷启）；200MB 续传段 80MB/7.63s≈**10.5MB/s**（并发热跑）。

W4 离线单测新增 35 项（总分 70/70 OK）：分块数学/md5/写面参数形态/上传三段+断点+uploadid 失效重启/下载分片+md5 校验+混淆免疫/rm 双段流/CLI 通道。

## W5 实测（2026-10-29，数字零造假；smoke_w5_live.py + _diag_w5_transfer.py，围栏 /API复刻测试_1029/）

四件落地：**bdn doctor 复验器**、**bdncore/router.py 通道路由**、**bdn mirror 增量镜像**、
**share/transfer 条件门活测**；原始输出全档 `tests\_diag_archive\w5_20261029_231937\` 与 `w5_transfer_diag_*\`。

| 段 | 结果 | 关键数字 |
|---|---|---|
| d doctor 八针 | **verdict=ok，8/8 针全绿，指纹零漂移** | loginStatus 4998.8ms 冷启；quota 总 18.8TB/用 14.1TB；api:list 根 18 项（基线 17+围栏产物，信息项）；share/record 43 条；locateupload 8 servers；precreate 缺参门 errno 2=参数完整度门在位；8 发 |
| m1 mirror pass1 | **26/26 上传全成**（..\analysis 29 文件/5,112,199B；3 空文件跳过=引擎限制如实列名） | 控制面 58 发+数据面 26 发/5.1MB；建目录 4 段；215.9s；md5 重哈希 29（首扫） |
| m2 mirror pass2 | **增量=0 上传实证**（uploads_planned=0/done=0） | 26 未变+0 补账+remote_only 0（**只增不删**）；3 发；CLI pass3 复证 0/0/0（数据面计数器累计口径 bug 当日修） |
| a share 写面 | **旧代 pset/cancel 全活**（官方「2026-09-16 下线」宣未落，漂移账 #15） | create errno=0（1 发，variant0 蓝本形态首试即过，shareid=65048642201，带提取码，响应含 shorturl/qrcodeurl）；cancel errno=0（1 发）；record 复核 shareid 消失 |
| b transfer 链 | **surlinfo→verify→list 三段全通，末段 transfer=errno 2**（条件门如实收口） | surlinfo 顶层 pwd 明文；verify randsk 48 位；list fs_id 字符串形态（shorturl 去前导'1'首试即过）；transfer 2 发均 errno 2→当时定位=缺 bdstoken（**W6 勘误：带 bdstoken 复测仍 2，单因证伪——真因=缺 shareid/from 全参，ERRATA_1030.md；全参形态已实装待 W7**）；非 9019/付费墙，未硬闯 |

账本（如实）：主账 doctor+share/transfer 族 **27 发 ≤80**（含 transfer CLI 子进程 6 发与诊断探针 6 发两笔未回 JSON 事后补记）；
mirror 单列 **64 发 ≤120**（两遍+CLI 复证）；数据面 26 发/5,112,199B 单列；share create 1/2 发、transfer POST 2/2（硬帽均未超）；
熔断全程闭合；远端零删除（mirror 只增+cancel 仅自建测试分享）；凭据/提取码全程掩码。

W5 离线单测新增 31 项（**总分 101/101 OK**，0.7s 零网络）：路由降级（api→xpan 网络故障降级/业务 errno 不降级/熔断凭据不降级/
写面结构性无 xpan 通道/T1 桩默认 off/xpan 通道归一）、doctor（八针全绿/凭据 dead/指纹缺失 degraded/根计数信息项/
precreate 门在位与松动）、mirror（state 排除/md5 缓存复用/计划三分支/remote_only 只报告/两遍 0 增量/围栏断言）、
分享转存形态（pset 双形态/cancel/verify+BDCLND cookie/transfer bdstoken/surl 解析）。

## W6 实测（2026-10-29/30，数字零造假；judge 4 修正 + transfer 复测 + QA 总门 + E1/E2，围栏 /API复刻测试_1029/）

四件收口：**judge 4 项修正全落地**、**transfer 复测（errno 2 维持+勘误 ERRATA_1030）**、
**QA 总门 23/24 绿（全命令面活体终验）**、**Ralph E1/E2 微优化出数**；
全档 `tests\_diag_archive\w6_qa_gate\`（SUMMARY.md=汇总表，qa_gate_ledger.json 含 post_hoc_corrections）。

| 项 | 结果 | 关键数字 |
|---|---|---|
| j1 share-cancel 属主护栏 | 非自建 shareid → 记录归属信息退出 3 零 POST（FakeTransport 单测 3 件）；QA 门真跑自建 27396886864 放行（records+cancel=2 发） | api.py docstring 同步真话化「CLI 属主护栏强制」 |
| j2 归档清洗器 | `_diag_archive\scrub.py`（URL `?pwd=x`→`pwd=***` 幂等；pwd/passwd 明文→***；凭据字段告警掩码）；W5 share_create.json qrcodeurl 追溯清洗，原件仅存 .orig 一份；全档 --check 零残漏；W6 归档全走此清洗器 | 单测 5 件（含二跑幂等+.orig 不覆盖） |
| j3 mirror 远端目标护栏 | remote=/ 或一级根目录 → 拒绝（提示 --allow-root）零请求；QA 门负例真跑 rc=1 errno=-7 | 单测 6 件（/、一级、深层放行、旗标放行、cmd 级零请求、相对路径拒） |
| j4 重复 `if __name__` | _diag_w5_transfer.py 尾部重复块删除 | — |
| t2 transfer 复测 | **errno 2 维持（N/A）**：带 bdstoken 真发 1 发仍 2；跳级探针（只读五跳）钉死断点在 transfer POST（records/surlinfo/loginStatus/verify/list 全 errno=0，bdstoken 32 位取到）；蓝本复核=缺 **shareid/from** 两必参（transfer.go:79-85）→ 全参形态已实装+单测，1 发复测留 W7；cmd_transfer 异常路径补 JSON 回显 | ERRATA_1030.md 落档 |
| t3 QA 总门 | **23/24 绿**（唯一非绿=transfer 引证行 N/A）：whoami/quota/ls(18)/tree(16节点1发)/search(命中20)/shares(43)/recycle(100)/doctor(verdict ok 8针漂移1信息项)/mkdir×2/upload 100KB(三段+md5回传一致 849d5ef4)/rename/mv/cp/rm(围栏内1件)/meta(fs_id 跨 rename/mv 不变)/share-create(1发)/share-cancel(属主护栏真跑)/mirror dry-run(计划2零上传)/mirror 护栏负例 | W6 全局控制面真账 **50/50 恰在帽内**（QA段 CLI30+首跑3+库4；任务二 13）；数据面单列 upload1+download1+E2 6 发/30MB |
| e1 搜索提速 | **xpan 维持唯一**：PROTOCOL/抓包零 api 家族搜索端点在案；pcs 遗产端点 1 发探针=HTTP 200 但回 pcs 族 error_code 形态（死亡再证，漂移账 #1） | xpan QA 行 2.3s/20 命中 vs pcs 0.6s/零结果；router 不动 |
| e2 下载线程 | **8 线程胜**：同 10MB 围栏样本（bdnw4_10m.bin，3 块×2 跑，数据面请求数相同） | w8=5.19MB/s vs w4=2.15MB/s（**+58.6%**，单次测量网络波动在案；默认 8 线程维持，测完即止） |

W6 离线单测新增 14 项（**总分 115/115 OK**，0.7s 零网络）。

### W4 关键诊断链（tests/_diag_w4*.py，战役记录）

1. xpan 写面 9019 need verify（风控墙）；pcs mkdir 假成功（errno=0 不落盘）→ 写面唯一可靠通道=**/api 家族**（api/create + api/filemanager）。
2. superfile2 参数矩阵 V1-V5：【勘误 1029】**参数完整度是钥匙**（V1-V4 因缺参才 31023；judge 重放 native UA+全参=200/md5 回执）——初判「CEF UA 必带」系变量未隔离误归因；vip=2/web=1/path 双放；失败信使=error_code 非 errno。
3. move/copy filelist 官方口径 **path+dest+newname**（from/to 形态=errno 2）；delete=纯路径数组。
4. 服务端 md5 混淆（`…2775j4f…` 含非 hex 字符）→ 秒传索引不可达 + 下载校验必须比对本地源 md5。

## 已知怪癖与遗留（如实）

1. **搜索全角冒号怪癖**：key 含『来自：』前缀（如 '来自：A'）→ errno=0 但 0 命中（服务端分词）；纯词 'A'→20 条、'演讲'→100 条。冒烟脚本已剥该前缀。
2. **xpan 搜索是慢端点**：空结果也要 7.3s；命中时 1.5-3s。批量场景注意预算与超时。
3. **tree 在本盘必然吃预算**：根 17 项全是目录，206 目录只到深度 2 就 12 发截断——护栏按设计工作，全量遍历属 W4 增量(filediff)职责。
4. **filediff 游标冷启动未激活（W4 实测补账）**：全参形态（channel/version/deviceid/dname）200 JSON 稳定应答，但三冷启动形态（无 cursor 键/空串/"0"）全 errno=2——首游标疑来自客户端本地持久化或 rand 族强校验（W1 未证伪），mirror 增量腿待 W5+。
5. quota 客户端实态是 POST /api/quota，本库 GET 亦放行（复检实录）；两形态都留在代码里。
6. 回收站 100 项 = 单页满页，`recycle --page 2` 可续（未测，预算纪律）。
7. **秒传（W4 遗留）**：本账号 /api 通道 precreate return_type=2 不可达（四变体诊断全 miss）——服务端 md5 混淆疑似根因（漂移账 #14）；引擎秒传探测逻辑在位，通道恢复即零改自动生效。
8. **filediff 冷启动（W4 遗留）**：见怪癖 4；带游标的轮询形态已具备（库 filediff(cursor)）。
9. 空文件上传不支持（蓝本 EmptyContentMD5 特例，引擎显式拒绝并报错；mirror 对空文件跳过并如实列名）。
10. 围栏 /API复刻测试_1029/ 内测试产物（六轮冒烟+七件诊断+**W5 mirror_test 26 文件/transfer_in**+**W6 qa_gate_tmp（sub/qa_100k_rn.bin 等）**）全部保留，待用户明示处置（零删除纪律）。
11. **share/transfer 复测（W6 收口→W7 遗留）**：W6 复测 1 发（带 bdstoken）仍 errno 2——W5「缺 bdstoken」单因**证伪**（跳级探针钉死断点在 transfer POST，前置五跳全绿；ERRATA_1030.md）；蓝本全参形态（query shareid+from+bdstoken，transfer.go:79-85）已实装（api.share_transfer+cmd_transfer+单测），1 发复测留 W7/用户令；cmd_transfer 异常路径已补 JSON 回显（errno+payload 可归档）。
12. **T1 bdpan 子进程通道（W5 留接口）**：默认 off——启用=接受官方二进制遥测/rand 签名族/OAuth 沙箱路径，与零遥测+全盘绝对路径红线冲突；仅 /api 家族整面死亡时评估（需独立审批）。
13. Git Bash 直调 bdn.py 传远端绝对路径会被 MSYS 路径转换吃掉（→C:/Program Files/Git/…）；须 `MSYS_NO_PATHCONV=1` 或走 PowerShell（errno -7 客户端护栏即拦，零误发）。
