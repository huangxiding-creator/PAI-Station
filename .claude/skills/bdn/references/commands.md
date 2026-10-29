# bdn 全命令参考（16 子命令，2026-10-29 自 `python -I bdn.py <cmd> --help` 实测提取）

CLI 真身：`E:\AI-Station\逆向工程\baidu-netdisk\replica\bdn.py`（依赖同目录 `bdncore\`）。
所有示例假设 `BDN=E:\AI-Station\逆向工程\baidu-netdisk\replica\bdn.py`。

## 全局参数

| 参数 | 说明 |
|---|---|
| `--cred CRED` | 凭据 JSON 路径。默认顺序：`--cred` > 环境变量 `BDN_CREDENTIALS` > 内置路径 `E:\AI-Station\data\secrets\bdn_credentials.json` |
| `-h / --help` | 帮助（任何层级可用，纯本地零网络） |

通用约定：
- **每个子命令都接受 `--json`**（输出机器可读 JSON；不加则输出人读表格）。
- 远端路径一律 `/` 开头**全盘绝对路径**（这是 bdn 与官方 bdpan 沙箱的本质区别）。
- 退出码：0=成功 / 1=业务错 / 2=熔断或凭据错 / 3=rm 未加 --confirm / 130=中断。
- 控制面自动节流：并发≤2、请求起点间隔≥1.5s、ls num 钳制≤1000、单目录翻页护栏≤10 页。

---

## 只读九命令

### whoami — 登录态/账号画像

```
python -I %BDN% whoami [--json]
```

JSON 输出 = loginStatus 的 `account` 子字典：

| 字段 | 说明 |
|---|---|
| `username` | 账号名 |
| `uk` | 用户唯一 ID |
| `vip_level` / `vip_type` | 会员等级/类型 |
| 其他 | 原样透传（人读模式 bdstoken 打印为掩码） |

### quota — 网盘配额

```
python -I %BDN% quota [--json]
```

| 字段 | 说明 |
|---|---|
| `total` / `used` / `free` | 字节数（int） |
| `total_h` / `used_h` / `free_h` | 人类可读（如 4379.8GB） |

### ls — 列目录

```
python -I %BDN% ls [path] [--page PAGE] [--num NUM] [--json]
```

| 参数 | 默认 | 说明 |
|---|---|---|
| `path`（可选位置参数） | `/` | 远端绝对路径，如 `/` 或 `/来自：分享` |
| `--page` | 1 | 页码 |
| `--num` | 1000 | 每页条数（钳制≤1000） |

JSON：`{dir, count, entries:[{isdir, size, name, fs_id}]}`。翻页护栏：单目录≤10 页。

### tree — 递归树

```
python -I %BDN% tree [path] [--depth DEPTH] [--max-requests MAX_REQUESTS] [--num NUM] [--json]
```

| 参数 | 默认 | 说明 |
|---|---|---|
| `path`（可选） | `/` | 远端绝对路径 |
| `--depth` | 3 | 深度上限 |
| `--max-requests` | 20 | 请求预算（本盘根 17 目录全树必然截断，属设计） |
| `--num` | 1000 | 每目录列页大小 |

JSON：`{root, nodes, dirs, requests, truncated, depth_limit, max_depth_reached, tree:[嵌套{name,isdir,children,pruned_depth}]}`。`truncated:true` 时如实告知用户「预算截断，非全量」。

### search — 搜索（xpan，慢端点）

```
python -I %BDN% search key [--dir DIR] [--no-recursion] [--num NUM] [--json]
```

| 参数 | 默认 | 说明 |
|---|---|---|
| `key`（必填） | — | 关键词。含「来自：」前缀→0 命中（服务端分词怪癖），先剥前缀 |
| `--dir` | `/` | 限定目录（默认全盘） |
| `--no-recursion` | 关 | 加上=不递归（recursion=0） |
| `--num` | 100 | 条数 |

JSON：`{key, dir, recursion(0/1), count, entries:[{path, size, isdir}]}`。
耗时预期：空结果约 7.3s、命中 1.5-3s——批量搜索预算要留够。

### meta — 文件元信息（按 fs_id）

```
python -I %BDN% meta fsids [fsids ...] [--json]
```

| 参数 | 说明 |
|---|---|
| `fsids`（必填，多条） | fs_id，空格或逗号分隔（`123 456` 或 `123,456` 均可） |

JSON：`{fsids, source(实际命中的端点), count, entries:[{fs_id, path, size, isdir, category}]}`。
fs_id 从 `ls` 的 entries 里取。

### shares — 我的分享记录（只读）

```
python -I %BDN% shares [--page PAGE] [--json]
```

| 参数 | 默认 | 说明 |
|---|---|---|
| `--page` | 1 | 页码 |

JSON：`{page, count, entries:[{shareid, shortlink, typical_path, ctime, views, downloads, status, passwd}]}`。
`passwd` 已在协议层掩码（`"***"` 或空串）——**bdn 只能读记录，不能新建分享**；新建/管理分享走官方 baidu-drive 技能。

### recycle — 回收站列表（只读）

```
python -I %BDN% recycle [--page PAGE] [--num NUM] [--json]
```

| 参数 | 默认 | 说明 |
|---|---|---|
| `--page` | 1 | 页码 |
| `--num` | 100 | 每页（钳制≤200）。满页 100=还有下一页 |

JSON：`{page, count, entries:[{fs_id, name, size, isdir}]}`（已归一化字段名）。
bdn 无「还原/清空回收站」命令——只有 rm（删除=进回收站）。

### doctor — 链路体检

```
python -I %BDN% doctor [--json]
```

JSON：

| 字段 | 说明 |
|---|---|
| `roundtrip_ms` | loginStatus 往返时延（冷几百 ms/热几十 ms 属正常） |
| `errno` | 0=通 |
| `http` | 最后请求 HTTP 状态 |
| `requests_total` | 本进程累计请求数 |
| `circuit_open` | 熔断器状态（true=已全局停） |
| `credentials` | `{cred_path, bduss(掩码), stoken(掩码), ua}` |

用途：写操作异常时先跑它定界（链路/凭据/风控）；也是熔断冷却后恢复的首个只读探针。

---

## 写命令七件（W4）

### mkdir — 新建目录（幂等）

```
python -I %BDN% mkdir path [--json]
```

| 参数 | 说明 |
|---|---|
| `path`（必填） | 远端绝对路径，如 `/AI-Station-archive/新项目` |

JSON：`{errno, path, exists, requests}`。`exists:true`（errno -8）=已存在，幂等成功，不是错误。

### rename — 重命名（同目录）

```
python -I %BDN% rename path newname [--json]
```

| 参数 | 说明 |
|---|---|
| `path` | 远端绝对路径 |
| `newname` | **纯文件名，不带路径**（带路径会错） |

JSON：`{errno, path, newname, info, requests}`。

### mv / cp — 移动 / 复制

```
python -I %BDN% mv src dst [--json]
python -I %BDN% cp src dst [--json]
```

| 参数 | 说明 |
|---|---|
| `src` | 远端源路径 |
| `dst` | **目标目录**（远端绝对路径；同名冲突自动 ondup=newcopy 生成副本） |

JSON：`{errno, op("move"|"copy"), src, dst, info, taskid, requests}`。返回 `taskid` = 异步任务，大目录移动后建议 `ls dst` 对账。

### rm — 删除（进回收站）·双确认铁律

```
python -I %BDN% rm paths [paths ...] [--confirm] [--json]
```

| 参数 | 说明 |
|---|---|
| `paths`（必填，多条） | 远端绝对路径 |
| `--confirm` | **显式确认才执行**；无此旗标只列待删清单并退出 3，零删除 |

两段流：
1. `rm /d/a.bin` → 打印逐条清单（含 fs_id/大小；缺失项标 `?`），JSON `{errno:0, executed:false, exit:3, count, entries, requests, note}`，退出码 3。
2. 用户明示同意后 `rm /d/a.bin --confirm` → 先打印清单再执行。JSON `{errno, executed, deleted:[], missing_skipped:[], info, taskid, count, requests}`。

agent 纪律：两段之间必须把清单呈报用户并获**当次明示**同意（见 safety.md 第 2 条）。删除=移入回收站，可用官方客户端还原。

### upload — 上传（三段+秒传探测+断点续传）

```
python -I %BDN% upload local remote [--json]
```

| 参数 | 说明 |
|---|---|
| `local` | 本地文件路径（如 `E:\tmp\pkg-1029.tar.gz`） |
| `remote` | 远端绝对路径**含文件名**（如 `/AI-Station-archive/项目/1029.tar.gz`） |

JSON：`{errno, rapid, path, size, fs_id, return_type, bytes_sent, data_requests, blocks_total, blocks_uploaded, resumed, uploadid(非秒传时), elapsed_s, control_requests, requests}`。

| 字段 | 说明 |
|---|---|
| `rapid` | true=秒传零传输；**当前账号服务端 md5 混淆导致秒传不可达，false 是常态** |
| `return_type` | 1=三段全量 / 2=秒传命中 |
| `resumed` | true=本次走了断点续传（部分分片复用） |
| `blocks_uploaded/blocks_total` | 分片进度（4MB/片） |

行为：分片并发≤8；状态存本地 `.bdn_upload_state.json`（local 同目录），中断后**重跑同命令**自动续传；uploadid 失效自动重走 precreate。空文件被引擎显式拒绝。实测速度参考：热跑约 10.5MB/s（SVIP8 口径）。

### download — 下载（dlink+Range 多线程+md5 校验+断点续传）

```
python -I %BDN% download remote local [--json]
```

| 参数 | 说明 |
|---|---|
| `remote` | 远端绝对路径 |
| `local` | 本地落盘路径（如 `E:\restore\1029.tar.gz`） |

JSON：`{errno, path(remote), local, size, chunks_total, chunks_this_run, resumed, bytes_received, data_requests, md5_ok, md5, elapsed_s, speed_mb_s, control_requests, requests}`。

| 字段 | 说明 |
|---|---|
| `chunks_this_run/chunks_total` | 4MB 分片进度；resumed=true 时 this_run<total |
| `md5_ok` | true=校验通过；服务端 md5 为混淆体（非 hex）时跳过比对（`md5_ok:false`+人读显示「未比对」），此时用 `ls`/`meta` 的 size 对账兜底 |

行为：Range 4MB×≤8 线程；状态存 `.bdn_dl_state.json`，中断重跑同命令续传。实测约 2.21MB/s（10MB 样本）。

---

## 常见 errno 速查（完整表在 bdncore\errors.py）

| errno | 语义 | agent 动作 |
|---|---|---|
| -6 / 111 | 身份失效/凭证异常 | 退出 2，报告用户（凭据需重收） |
| -7 / 2 | 参数错误 | 检查路径拼写/参数形态 |
| -8 | 已存在 | mkdir 幂等成功；其他场景换名 |
| -30 | 目标位置存在同名 | 换名或先确认覆盖策略 |
| 31112 | 网盘配额已满 | 停，报告 quota 数字 |
| 8001 | 触发验证码 | 停手报告（无打码腿） |
| **20012 / 31034** | 限流/配额受限（**熔断级**） | 退出 2，停手报告 |
| **31119 / 31329** | 账号风控/黑名单（**熔断级**） | 退出 2，停手报告 |

熔断（CIRCUIT_ERRNOS = {31119, 31329, 20012, 31034}）触发后本进程后续调用零触网直接抛 BdnCircuitOpen；处置链见 safety.md 第 5 条。
