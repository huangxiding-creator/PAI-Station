# 百度网盘开放平台官方 API 全景调研（official_openapi.md）

调研日期：2026-10-29 · 研究员：Super-Skill Researcher
账号：pyeye@126.com · 需求口径：全盘文件操作 · 官方文档站：https://pan.baidu.com/union/doc/
方法：本地 bdpan 3.8.7 实测 + 官方文档 17 页逐页抓取 + 官方 GitHub org baidu-netdisk 核实。来源 URL 随条目标注。

## 结论速览（TL;DR）

1. 官方 API 动作覆盖 100%，路径覆盖约为全盘的 0%：13 类文件操作全部有官方端点，但一切读写被强制限制在 /apps/{appname}/ 单一应用目录，无任何「全部文件读写」申请通道（见第4节）。
2. 对「全盘」需求综合覆盖率约 10-15%：官方通道只能把 /apps/bdpan/ 当中转仓（上传入仓、分享出仓、转存入库），无法枚举/搬运网盘根目录及其他目录的存量文件。
3. 限速真相：接口级 QPS 官方明文「出于安全策略暂不支持公开」；可量化只有：未过审 10次/小时+10用户、过审白名单制、转存单次 500/3000/50000（普通/VIP/SVIP）、单文件 4/10/20GB、分片 4/16/32MB、设备码轮询大于等于5s、dlink 8小时。上传官方口径「仅对异常行为限制」；下载速度=账号会员等级（与官方客户端一致）。
4. bdpan CLI 是百度官方项目：官方 GitHub 仓库 baidu-netdisk/bdpan-storage（Apache-2.0，310 stars，2026-10-29 当日仍在发版），CLI 二进制从官方 CDN issuecdn.baidupcs.com/issue/netdisk/ai-bdpan/ 分发。本机 3.8.7 可用，官方已出 3.8.9。沙箱 /apps/bdpan/ 是官方 README 明文的 by-design 安全设计。

## 1. 接入与授权（现行方式）

### 1.1 开发者与应用申请
- 前置：百度账号 + 实名认证。个人认证可建 1 个应用，企业认证最多 10 个。
- 应用两模式：【个人使用】免审核直接上线，限 10 个授权用户；【公开发布】须上线审核，过审不限人数。
- 凭证四件套：AppId / AppKey / SecretKey / SignKey（控制台应用详情页发放）。
- 应用类别（软件/硬件/小程序）选定不可改；小程序类须企业认证。
- 来源：https://pan.baidu.com/union/doc/使用入门/创建应用/ ；https://pan.baidu.com/union/doc/使用入门/实名认证/实名认证介绍/

### 1.2 OAuth 三种流（端点与有效期）
- 授权码流：GET https://openapi.baidu.com/oauth/2.0/authorize（response_type=code, client_id=AppKey, redirect_uri, scope=basic,netdisk；code 10分钟一次性）→ GET https://openapi.baidu.com/oauth/2.0/token（grant_type=authorization_code + code + client_secret + redirect_uri）。可选 display/state/qrcode/force_login/device_id(硬件类必填)。
- 设备码流（bdpan OOB 即此）：GET https://openapi.baidu.com/oauth/2.0/device/code?response_type=device_code&client_id=AppKey&scope=basic,netdisk → GET https://openapi.baidu.com/oauth/2.0/token?grant_type=device_token&code=device_code&client_id&client_secret；轮询间隔大于等于5s、次数小于 expires_in/interval（例 300/5=60），device_code 300 秒过期。
- 简化模式（MCP 官方给的免建应用通道）：GET https://openapi.baidu.com/oauth/2.0/authorize?response_type=token&client_id=QHOuRXiepJBMjtk0esLhrPoNlQyYd0mF&redirect_uri=oob&scope=basic,netdisk&qrcode=1，浏览器地址栏直接回收 access_token。
- access_token 有效期 30 天（2592000 秒）；refresh_token 有效期 10 年但一次性——每次刷新返回新 refresh_token，刷新失败旧的即作废须重新授权，禁循环重试。
- 来源：https://pan.baidu.com/union/doc/使用入门/接入授权/授权码模式/ ；…/设备码模式授权/ ；https://pan.baidu.com/union/doc/mcp-server/操作指南/在-agent-中自定义使用/

## 2. xpan REST API 全表（endpoint + 关键参数）

通用：主域 https://pan.baidu.com；鉴权一律 query 参数 access_token；官方示例 UA 固定 pan.baidu.com。

### 2.1 用户与容量
| 功能 | Method | Endpoint | 关键参数与返回 |
|---|---|---|---|
| 用户信息 | GET | /rest/2.0/xpan/nas?method=uinfo | vip_version=v2；返回 baidu_name/netdisk_name/avatar_url/vip_type(0普通/1会员/2超级)/uk；errno 42905 可重试 |
| 网盘容量 | GET | /api/quota | checkfree=1&checkexpire=1；返回 total/used/free/expire(7天内到期)；样例 total≈2.2TB |

### 2.2 文件信息
| 功能 | Method | Endpoint | 关键参数 |
|---|---|---|---|
| 文件列表 | GET | /rest/2.0/xpan/file?method=list | dir(绝对路径默认/)、order(time/name/size)、desc、start(从0)、limit(默认1000,建议不超1000)、web=1(缩略图+dir_empty)、folder=1(仅目录)、showempty、page+num 组 |
| 递归列表 | GET | /rest/2.0/xpan/file?method=listall | 文档页「递归获取文件列表」；2026-06-03 政策点名端点，沙箱内 |
| 关键词搜索 | GET | /rest/2.0/xpan/file?method=search | key(最大30个UTF-8字符)、dir(默认根)、recursion=1、category(1视频/2音频/3图片/4文档/5应用/6其他/7种子)、num(默认500固定不可改)、翻页靠响应 has_more，无 page 参数 |
| 语义搜索 | GET | 文档页「搜索文件语义搜索」 | 自然语言 query；MCP 对应工具 file_semantics_search |
| 文件详情(单) | GET | /rest/2.0/xpan/file?method=meta | path(URL编码绝对路径)；dlink=1 出下载链 |
| 文件详情(路径批量) | POST | /rest/2.0/xpan/file?method=filemetas | target=JSON路径数组；dlink/blocks/media/web |
| 文件详情(fsids批量) | GET | /rest/2.0/xpan/multimedia?method=filemetas | fsids=JSON数组最多100个；dlink=1/thumb=1/extra=1/needmedia/detail；返回 block_list(每4MB分片MD5)/media_info/duration |
| dlink 下载 | GET | dlink 追加 access_token | UA 必须 pan.baidu.com（缺则31326防盗链）；dlink 约8小时有效(31360过期可重查)；支持 Range 断点(bytes=0-499等)；可能302须跟随并保留鉴权 |
| 直连下载 | GET | /rest/2.0/xpan/file?method=download | 固定 check_blue=1&esl=1；需 access_token/app_id/user_id/path |
| 详情错误码 | — | — | 42211 图片详情失败(可重试)/42212 共享目录上传者信息/42213 共享目录鉴权/42214 文件详情失败 |

### 2.3 文件管理（四合一）
| 功能 | Method | Endpoint | 关键参数 |
|---|---|---|---|
| 复制/移动/重命名/删除 | POST | /rest/2.0/xpan/file?method=filemanager | opera=copy 或 move 或 rename 或 delete；filelist=JSON数组（copy/move 每项 path+dest+newname；rename 每项 path+newname；delete 为纯路径数组）；async(0同步/1服务端自适应/2异步，以是否返回 taskid 为准)；ondup(fail/newcopy/overwrite/skip,delete不用)；errno -9 不存在/111 其他异步任务中/-7 文件名非法 |

### 2.4 上传（标准三段流 + 辅助）
| 功能 | Method | Endpoint | 关键参数 |
|---|---|---|---|
| ① 预上传 | POST | /rest/2.0/xpan/file?method=precreate | path/size/isdir/block_list(32位小写MD5的JSON数组)/autoinit=1/rtype(1冲突改名/2 block_list不同才改名/3覆盖)/content-md5/slice-md5(前256KB)/local_ctime/local_mtime；返回 uploadid + 待传分片序号 block_list(空数组等价[0])；errno -7 名称或权限/-10 容量不足 |
| ② 分片上传 | POST | https://{UPLOAD_HOST}/rest/2.0/pcs/superfile2?method=upload&type=tmpfile | multipart：path(须与①一致)/uploadid/partseq(从0)/file；UPLOAD_HOST 由「获取上传域名」接口动态取，官方禁硬编码；errno 31024 无上传权限/31299 首片小于4MB/31364 超分片上限/31363 分片缺失 |
| ③ 创建文件(兼新建文件夹) | POST | /rest/2.0/xpan/file?method=create | path/size/isdir/block_list/uploadid 全部与①一致；isdir=1 时免①②直接建目录；rtype 0失败/1改名/2差异改名/3覆盖；可选 zip_quality(50/70/100图片压缩)+zip_sign、is_revision 多版本、mode、exif_info；errno -8 已存在/-10 满/10 创建失败/31190 文件未找到/31355 参数/31365 超总大小 |
| 单步上传(小文件) | POST | https://{UPLOAD_HOST}/rest/2.0/pcs/file?method=upload | multipart：path/ondup(fail/overwrite/newcopy)/file；上限 2GB；errno 31024/31061 已存在/31064 上传路径错误 |
| 获取上传域名 | — | 独立文档页「获取上传域名」 | 官方上传调试工具 https://pan.baidu.com/union/devtool/upload |

分片/文件上限（官方原数）：分片 普通4MB/会员16MB/SVIP32MB；单文件 普通4GB/会员10GB/SVIP20GB；分片数不超过1024；不超过4MB文件整文件单MD5免切。普通用户经开放平台禁传视频与 Live Photo。

### 2.5 分享与转存（2026-09-16 起新版=付费 apaas，旧版 xpan/share 已下线）
| 功能 | Method | Endpoint | 关键参数 |
|---|---|---|---|
| 创建分享 | POST | https://pan.baidu.com/apaas/1.0/share/set?product=netdisk | multipart：fsid_list(JSON)/period(天)/pwd(4位数字+小写字母)/remark/ticket(package_type=47 加速流量包)；返回 short_url/link/share_id；官方明示「本接口为付费接口」 |
| 提取码验证 | POST | apaas 分享提取码验证 | 返回加密提取码 spwd（转存必需） |
| 查询分享文件信息 | — | apaas 查询分享文件信息 | 取分享内 fsid 列表（转存 fsid_list 的来源） |
| 分享转存 | POST | https://pan.baidu.com/apaas/1.0/share/transfer?product=netdisk | query: short_url(22位短码)/appid/access_token/device_id(硬件)；form: fsid_list/to_path/spwd/async=2(官方建议)/ondup(fail或newcopy)；返回 data.task_id(0=同步)；同为付费接口 |
| 转存任务查询 | GET | https://pan.baidu.com/apaas/1.0/share/taskquery | appid/access_token/task_id；status=pending/running/success/fail；progress；succNum；desc.list[].to_fs_id；示例 num_limit=5000/num_limit_no_vip=2000；errno 2/-6/13998/13062/13070 任务不存在/13071 他任务进行中 |
| 转存错误码族 | — | — | 13001 分享状态异常/13003 提取码错/13010 分享文件不存在/13041 非该分享文件/13045 转自己的分享/13063 转存失败/13072 普通用户达转存上限/13073 会员达上限/13076 已存在/13077 容量不足 |

### 2.6 官方 MCP Server（Agent 专用通道）
- 端点：https://mcp-pan.baidu.com/sse（SSE 传输）；鉴权 Authorization: Bearer <access_token>（Query/Header 二选一，同传优先校验 Query 且不回退）。
- 16 个工具：file_list / file_doc_list / file_image_list / file_video_list / file_meta(fsids 最多10) / file_keyword_search / file_semantics_search(自然语言) / make_dir / file_copy / file_move / file_rename / file_upload_by_url(URL 离线转存,默认目录 /来自：mcp_server) / file_sharelink_set(period 默认7天, pwd 默认1234) / user_info / get_quota。注意：无 file_delete 工具、无直接 download 工具。
- 正式接入=平台合作制（强制扫码授权码模式 qrcode=1，联系 ext_mars-union@baidu.com）；自定义接入用自己 OAuth token 写 mcp.json。
- 源码仓库：https://github.com/baidu-netdisk/mcp（MIT, 154 stars）。
- 来源：https://pan.baidu.com/union/doc/mcp-server/使用概述/ ；…/tools-能力文档/ ；…/操作指南/快速开始/ ；…/在-agent-中自定义使用/ （均更新 2026-07-28）

## 3. 限速真相表

| 维度 | 普通用户/未过审 | 过审应用 | 会员 VIP | 超级会员 SVIP | 超限错误码 | 来源 |
|---|---|---|---|---|---|---|
| 接口频率 | 10次/每小时（未过审应用） | 白名单制按需分配（逐接口申请扩容） | — | — | 20012 调用次数上限触发限流、31034 命中接口频控 | 权限与配额页 |
| 授权用户数 | 10 个（未过审） | 不限 | — | — | 20011 | 同上 |
| 接口 QPS 具体值 | 官方不公开（原话「出于安全策略暂不支持公开」） | 同左 | — | — | — | FAQ 下载页 |
| 上传大小 | 单文件4GB/分片4MB/禁传视频与LivePhoto | 同左 | 10GB/16MB | 20GB/32MB | 31365 超总量、31364 超分片、31299 首片小于4MB | 上传能力说明+分片上传页 |
| 上传带宽 | 「开放平台仅对异常行为进行相应限制，不会影响正常使用」 | 同左 | 同左 | 同左 | — | 上传能力说明页 |
| 下载速度 | 与网盘官方客户端一致（按账号等级） | 同左 | 更快 | 最快 | 9013 黑名单账号(hit black uid file) | FAQ 下载页 |
| 下载文件数 | 「数量没有限制」；大于50MB 浏览器禁下（任何 UA 都受限，仅原生 app 不受限） | 同左 | 同左 | 同左 | 31326 防盗链 | FAQ 下载页 |
| 单次转存 | 500 | 同左 | 3000 | 50000 | 13072 普通上限/13073 会员上限 | 分享转存页官方原文 |
| dlink 有效期 | 8 小时 | 同左 | 同左 | 同左 | 31360 过期可重查 | 查询文件信息页 |
| 设备码轮询 | 间隔大于等于5秒，次数小于 expires_in/interval | 同左 | — | — | — | 设备码页 |
| 分片数量 | 不超过 1024 | 同左 | 同左 | 同左 | — | 上传能力说明页 |

要点：个人与企业的差别不在 QPS 数字，而在「可建应用数 1 比 10 + 过审后白名单配额」；全站无任何公开 QPS/日配额数字。平台级公共错误码族：限流=20012+31034；权限=20013 无接口权限/31024/20020 路径越权/20011；token=20016 过期/20017 无效/31045 校验失败/-6 身份失败；转存=10 已存在/12 批量出错/255 数量太多/111 异步任务中。OpenAuth 侧错误码表 https://openauth.baidu.com/doc/appendix.html#_4-openapi错误码列表 （来源 https://pan.baidu.com/union/doc/平台简介/错误码/ 更新2026-08-13）

## 4. 沙箱真相（关键结论）

1. 强制单目录：第三方应用只拥有一个目录，必须位于 /apps 下，默认 /apps/{appname}（用户侧显示「我的应用数据/{appname}」）。权限按 AppId 隔离，同开发者多应用不互通。官方明文禁止对权限外目录做查询、读取、下载、转存、上传、移动、复制、删除，并禁止以路径拼接、历史链接、缓存记录绕过；违者「限制接口、强制整改、收回权限」。来源：https://pan.baidu.com/union/doc/使用入门/权限与配额/
2. 2026-06-03 新政（收紧铁证）：该日期后创建的应用，download / listall / filemanager / precreate / meta / move 六端点仅支持访问 /apps/{appname} 目录下文件；2026-07-03 权限与配额页补「应用目录权限细则」。来源：https://pan.baidu.com/union/doc/更新日志/文档更新日志/ （2026.7.14 与 2026.7.3 条）+ https://pan.baidu.com/union/doc/使用入门/创建应用/
3. 无「全部文件读写」通道：全站无该 scope、无申请入口。2026-06-03 前创建的老应用曾享更宽目录权限（历史红利）；changelog 还出现「暂停个人应用创建」字样后被删除——个人应用政策处于收紧周期。UNVERIFIED：pyeye@126.com 名下是否有 2026-06-03 前存量宽权限应用（需控制台实查）。
4. 沙箱是 feature 不是 bug：官方 bdpan README「安全设计」首条即「所有操作限制在 /apps/bdpan/ 目录，无法访问用户其他文件」。来源：https://github.com/baidu-netdisk/bdpan-storage
5. MCP 公开 client_id（QHOuRXiepJBMjtk0esLhrPoNlQyYd0mF）简化授权同受沙箱约束（scope 仍 basic,netdisk）。

## 5. bdpan CLI 官方背景

- 官方仓库：https://github.com/baidu-netdisk/bdpan-storage —— Apache-2.0，310 stars，建于 2026-03-12，最近推送 2026-10-29（gh api 实测）。定位「Agent Skill for Baidu Netdisk」，README 明示适配 Claude Code / Cursor / Codex / Gemini CLI / OpenClaw 等。
- 版本账：Skill v1.7.7（2026-10-29 发布）/v1.7.6(1016)/v1.7.5(0903)/v1.7.4(0811)/v1.7.3(0730)；本机 CLI 3.8.7 构建于 2026-09-03（恰为 v1.7.5 期）；官方最新 CLI v3.8.9（本机 version --check 实测提示）。CLI 二进制与 Skill 分开发版：Skill 层走 GitHub Release，CLI 层走官方 CDN https://issuecdn.baidupcs.com/issue/netdisk/ai-bdpan/{os}/{ver}/bdpan-{ver}-{os}-{arch}.zip（baidupcs.com=网盘官方分发域，项目代号 ai-bdpan）。
- 官方 Skill 页：https://pan.baidu.com/apaastobui/developer#/developer/skill
- 能力边界（本机 --help 实测子命令）：upload/download/transfer(list+select)/share/search/ls/mv/cp/rename/rm/mkdir/whoami/vip/aippt/version/install/update/completion。沙箱=/apps/bdpan/。转存走异步 task_id（status=submitted）+任务查询；分享/转存能调新版 apaas 付费接口=百度给自家 CLI 开了后端权益（普通个人开发者须购买分享服务才能调）。
- 遥测字段：全局旗标 --agentname / --anonymous-id / --session-id / --session-input / --traceid / --uid（本机 help 实测）。官方文档只解释 --uid/--traceid（Agent 回端链接上下文，skill 文档 bdpan-commands.md）；其余四个含 --session-input（help 描述「当前用户输入」）无任何官方文档说明——用途 UNVERIFIED，按字段名判为会话遥测上报，建议敏感输入不经该旗标传递。
- 平台支持：官方 README 平台表写 Windows 原生不支持/WSL 支持，但官方 CDN 实际发布 win 原生包且本机 Win10 原生实跑 3.8.7 正常（安装于 C:\Users\91216\AppData\Local\bdpan\bdpan.exe，配置 C:\Users\91216\.config\bdpan\config.json）——README 表滞后于事实。
- BETA 公测期声明（README 原文）：建议备份重要数据并人工审核每条 AI 执行的命令。
- 同族官方资产（gh api 实测）：baidu-netdisk/mcp（MIT,154 stars,官方 MCP Server 源码,2025-09 后未更）、baidu-netdisk/baidu-drive-sdk-go（Apache-2.0,10 stars,官方 Go SDK,2026-09-26 有推送）、baidu-netdisk/baidu-drive-backup。

## 6. 结论：官方通道对「全盘」需求的覆盖度

| 用户需求（全盘口径） | 官方 API 有无该动作 | 能否触及全盘路径 | 判定 |
|---|---|---|---|
| 列表/枚举任意目录 | 有(list/listall) | 否，仅 /apps/{appname} | 缺 |
| 搜索全盘 | 有(search/语义搜索) | 否（权限细则同限沙箱） | 缺 |
| 文件详情/元数据 | 有(meta/filemetas) | 否 | 缺 |
| 上传 | 有(precreate+superfile2+create) | 仅入沙箱 | 中转仓可用 |
| 下载任意文件 | 有(dlink) | 否，仅沙箱内文件 | 中转仓可用 |
| 移动/复制/重命名/删除 | 有(filemanager) | 否 | 缺 |
| 新建文件夹 | 有(create isdir=1) | 仅沙箱内 | 部分 |
| 配额查询 | 有(api/quota) | 全盘级 | 可用 |
| 分享创建 | 有(apaas share/set) | 仅沙箱内文件可分享；付费接口 | 部分 |
| 分享转存入库 | 有(share/transfer) | 入库目标限沙箱 | 中转仓可用 |
| 回收站操作 | 无公开 API | — | 缺 |
| 离线下载 | 仅 MCP file_upload_by_url（存沙箱） | 部分 | 部分 |

- 动作维度：13/13 全覆盖；路径维度：1 个应用目录=全盘的极小切片。按可完成用户任务加权，综合覆盖率约 10-15%。
- 缺口清单：根目录与非 /apps 存量文件的枚举/读写；回收站；全盘备份/镜像；官方分享接口付费化（个人开发者无免费分享 API 面）；QPS 不透明无法做容量规划。
- 补齐路径（非开放平台面，另行 docket）：官方 Web/客户端私有接口路线；或确认账号下是否存在 2026-06-03 前创建的存量宽权限个人应用（历史红利，控制台实查可定）。
- bdpan 状态结论：本机 3.8.7=官方正品、原生 Win 实测可用、可升 3.8.9；它是「沙箱内全功能 + 分享/转存官方权益加持」的最强合法通道，但天生只能管 /apps/bdpan/，对全盘无能为力——与全部官方 API 同一物理边界。

## 附录：Working notes（随查随记原始账，全部已于正文折叠引用）

- 本机 bdpan 3.8.7（Git Commit 32440e1, Build 2026-09-03）原生 Windows 安装实测；v3.8.9 已发布。来源：本机 bdpan version --check。
- Checkpoint1：沙箱铁律（/apps 单目录+AppId 隔离+禁越权）/ 限速（未过审10次每小时+10用户,白名单制,20011/20012/20013）/ 设备码流端点与30天+10年 token。来源：权限与配额、创建应用、设备码模式授权三页。
- Checkpoint2：授权码流全参数（code 10分钟一次性）/ list 参数表 / filemanager 四 opera。来源：授权码模式、获取文件列表、管理文件三页。
- Checkpoint3：search key 30字符+num 500固定 / metas 三变体 fsids 上限100+dlink 8小时 / 上传三段流+4G-10G-20G+1024片+「仅限异常行为」+普通用户禁传视频。来源：搜索、查询文件信息、上传能力说明三页。
- Checkpoint4：precreate 参数 / superfile2 分片4-16-32MB与错误码31024/31299/31364/31363 / 下载三段+UA 防盗链31326+50MB 浏览器禁下+Range。来源：预上传、分片上传、下载三页。
- Checkpoint5：create 参数（isdir=1 建目录免①②）/ api/quota / 新版分享创建=apaas/1.0/share/set 付费接口。
- Checkpoint6：新版转存 apaas/1.0/share/transfer 全参数与错误码族；转存数量官方原文 普通500/普通会员3000/超级会员50000。
- Checkpoint7：FAQ 下载（速度=账号等级、频控不公开、数量无限、9013 黑名单、云 md5 非真实 md5 属产品策略）；MCP 概述；平台错误码全表+OpenAuth 附表。
- Checkpoint8：MCP 端点 mcp-pan.baidu.com/sse + 公开 client_id QHOuRXiepJBMjtk0esLhrPoNlQyYd0mF + 16 工具清单（无 delete/download）。
- Checkpoint9：用户信息 uinfo 端点 + 官方 Go SDK github.com/baidu-netdisk/baidu-drive-sdk-go；bdpan 无独立公开文档站。
- Checkpoint10（gh api 实测 2026-10-29）：baidu-netdisk/bdpan-storage（Apache-2.0/310 stars/created 2026-03-12/pushed 2026-10-29）；README 安全设计（作用域隔离/删除双确认/OAuth2.0/stdin 传码/SHA256/禁静默更新/BETA）；skill releases v1.7.7(1029) 至 v1.7.2(0722)；baidu-netdisk/mcp、baidu-drive-sdk-go、baidu-drive-backup 三伴生仓库。
- 文档更新日志要点（https://pan.baidu.com/union/doc/更新日志/文档更新日志/）：2026.10.20 设备绑定新字段+token FAQ；2026.9.16 文件分享服务（旧）下线、新文档集上线；2026.9.17 基础网盘服务接口文档补全；2026.7.30 MCP 文档重组；2026.7.14+7.3 沙箱六端点新政入档。

—— 调研收官。核心判断：官方通道=动作全、路径锁死；bdpan=官方正品、沙箱同锁；全盘需求缺口 85-90%，须由非开放平台路线补齐（另行 docket）。
