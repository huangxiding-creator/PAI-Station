---
name: bdn
description: >-
  百度网盘全盘 CLI（bdn，本地协议实现，BDUSS 直连，零遥测）— 全盘/根目录级网盘操作：
  列目录、递归树、全盘搜索、配额、上传（断点续传）、下载（md5 校验/--svip 直链）、建/删/改/移动文件夹、回收站、我的分享记录、链路体检、增量镜像、拉取恢复（pull）、断点残留清理（clean）。
  TRIGGER: 用户要全盘或根目录级网盘操作，远端路径以 / 开头（「网盘根目录有什么」「上传到 /AI-Station-archive」「下载 /xxx」「搜全盘」「把 E:\xxx 镜像到网盘 /xxx」「在网盘建/删/改文件夹」「把网盘 /xxx 拉回本地」）；或用户提到 bdn；或批量镜像备份到网盘。
  DO NOT TRIGGER: /apps/bdpan/ 沙箱内操作、Agent 记忆备份恢复（kimiclaw/maxclaw/qclaw/openclaw）、转存他人分享链接、新建分享、开会员——这些一律走官方 baidu-drive 技能。
---

# bdn — 百度网盘全盘 CLI 技能

包装 `E:\AI-Station\逆向工程\baidu-netdisk\replica\bdn.py`（bdncore 协议核心）。
与官方 baidu-drive 技能**并存分区**：bdn 管全盘（/ 开头绝对路径），baidu-drive 管 /apps/bdpan/ 沙箱、记忆备份、转存、会员。分区路由详见 [references/zoning.md](references/zoning.md)。

## 调用形态

```powershell
python -I E:\AI-Station\逆向工程\baidu-netdisk\replica\bdn.py <子命令> [参数] --json
```

- 任何 cwd 都能跑（已验证）；`--json` 全命令支持，agent 一律加。
- 凭据默认 `E:\AI-Station\data\secrets\bdn_credentials.json`（gitignored）。可 `--cred <路径>` 或环境变量 `BDN_CREDENTIALS` 覆盖。
- **凭据文件禁读禁打印**。一切输出已内置掩码，不要试图还原。

## 退出码（每次调用后必查）

| 码 | 含义 | agent 动作 |
|---|---|---|
| 0 | 成功 | 继续任务 |
| 1 | 业务错（errno!=0 且非熔断） | 读 stderr 的 `[errno=N] 中文语义`，改参数或换路径重试 |
| 2 | 熔断或凭据错 | **立即停手报告用户**，见安全节 |
| 3 | rm 未加 --confirm（只列了清单，零执行） | 把清单呈给用户求确认，见安全节 |
| 130 | 用户中断 | 停 |

## 命令映射表（自然语言 → 子命令，共 16 个）

| 用户意图 | 命令 |
|---|---|
| 网盘根目录有什么 / 列某目录 | `ls /`、`ls /AI-Station-archive --page 2` |
| 递归看目录结构 | `tree /AI-Station-archive --depth 3` |
| 搜全盘 / 限某目录搜 | `search 报告`、`search 报告 --dir /AI-Station-archive` |
| 网盘还剩多少空间 | `quota` |
| 我是谁 / 登录态还活着吗 | `whoami` |
| 链路体检（时延/熔断状态） | `doctor` |
| 文件元信息（按 fs_id） | `meta 1234567890 9876543210` |
| 我的分享记录 | `shares` |
| 回收站有什么 | `recycle --page 1` |
| 建文件夹（幂等，已存在不是错） | `mkdir /AI-Station-archive/新项目` |
| 改名（newname 是纯文件名） | `rename /d/a.bin b.bin` |
| 移动 / 复制（dst 是目标目录） | `mv /d/a.bin /dst`、`cp /d/a.bin /dst` |
| 删除 | `rm /d/a.bin`（退出 3 只列清单）→ 用户明示确认 → `rm /d/a.bin --confirm` |
| 上传（本地 → 网盘全路径） | `upload E:\pkg.tar.gz /AI-Station-archive/项目/1029.tar.gz` |
| 下载（网盘 → 本地） | `download /AI-Station-archive/项目/1029.tar.gz E:\restore\1029.tar.gz` |

全参数与 JSON 输出字段详解：[references/commands.md](references/commands.md)。

## 安全节（精要；红线全表见 references/safety.md）

1. **rm 双确认**：先跑无 `--confirm`（列清单退出 3）→ 把清单逐条呈给用户 → **用户当次明示同意**后才加 `--confirm` 执行。删除=进回收站（可还原）。对齐全站清理纪律：用户未发话=一个都不删。
2. **凭据禁读禁打印**：`data\secrets\bdn_credentials.json` 不读、不 cat、不引用其字段值。doctor/whoami 输出已掩码，原样转述即可。
3. **限速默认开**：控制面自动节流（并发≤2、间隔≥1.5s），数据面分片并发≤8。**不要并行开多个 bdn 进程绕过节流**；批量任务串行跑。
4. **熔断（退出码 2）=停手报告**：errno 31119/31329（账号风控/黑名单）或 20012/31034（限流/配额）触发全局熔断，后续调用零触网直接失败。此时：停手 → 向用户报告触发码与已完成/未完成清单 → 建议用户官方客户端交叉验证账号 → 等冷却与用户指令，恢复先只读（doctor/whoami）。**禁止主动探底限流**（不打极限测试）。
5. **写操作遇异常先 doctor**：mkdir/rename/mv/cp/rm/upload 报错时，先跑 `doctor --json` 区分链路问题（roundtrip_ms 异常）还是凭据/风控（errno/circuit_open），再决定重试或上报。
6. **不破解付费墙/限速**；速度如实报（本账号 SVIP8 口径，不外推免费号）。只操作本人账号数据。

## 常见任务剧本

### 镜像备份（本地目录 → /AI-Station-archive/）

```powershell
# 1. 本地打 tar.gz（网盘结构惯例 AI-Station-archive/<项目>/<日期>.tar.gz）
# 2. 建远端目录（幂等）
python -I ...\bdn.py mkdir /AI-Station-archive/<项目> --json
# 3. 上传（断点续传：中断后重跑同命令即续）
python -I ...\bdn.py upload E:\tmp\<项目>-<日期>.tar.gz /AI-Station-archive/<项目>/<日期>.tar.gz --json
# 4. 对账：ls 该目录，size 与本地文件一致才算成功
python -I ...\bdn.py ls /AI-Station-archive/<项目> --json
```

报告格式：传输字节数（bytes_sent）、分片数（blocks_uploaded/blocks_total）、用时（elapsed_s）、对账结果。数字零造假，全部取自 --json 实测。

### 全盘找文件

`search` 是慢端点（空结果约 7s，命中 1.5-3s），预算要留够。key 含「来自：」前缀会 0 命中（服务端分词怪癖）——剥掉前缀再搜。

### 已知怪癖速查

- 秒传当前不可达（服务端 md5 混淆，战役遗留）→ upload 返回 `rapid:false` 是常态，不是故障。
- 空文件上传被引擎拒绝，先在本地过滤。
- tree 默认 20 发请求预算，全盘必截断（truncated:true 如实标注）；全量清点用 ls 分页翻。
- 回收站单页 100 满页，`--page 2` 续。
- 上传断点状态存本地 `.bdn_upload_state.json`，下载存 `.bdn_dl_state.json`；重跑同命令自动续传。
