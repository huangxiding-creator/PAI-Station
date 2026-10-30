# W2 五盘免登发现层实测台账（2026-10-30 深夜）

> 二级能力（PROPOSAL §四）：大四盘+139 免登「发现层」=列表+探活，**零下载零凭据**。
> 语料=analysis/w1_gate_links.json（W1 门猎实收真实链接，**零新搜索**）。
> 铁律执行：单盘串行链间≥2s/盘间并发≤4/总预算≤150 发/**总实耗 148 发**（含 15 发定点调试，
> 账目见文末）/迅雷真验证码零触发（init 从未回 url 字段，熔断路径在代码未实战）/零删除零 git。

## 一、总裁决表

| 盘 | 链数 | 列表成功率 | 探活 | 墙型（实测定性） |
|---|---|---|---|---|
| 百度 | 8 | **6/8（75%）** | 8/8（6 活+2 死全判对） | 无码链=页面预热收匿名 Cookie（BAIDUID 族）后零 Cookie 直列（无预热 9/9 全 9019）；带码链 verify→randsk→BDCLND 全通（2 链 verify errno=0+randsk 发放实证）；-21=「来晚啦，该分享已被取消」如实判死；零验证码触发 |
| 阿里 | 8 | **7/8（87.5%）** | 8/8（7 活+1 Cancelled 判死） | get_share_by_anonymous 全匿名（share_id 须双入 query+body，仅 query 报 InvalidParameter.ShareId）；share_token→file/list（x-share-token 头）零用户态；ShareLink.Cancelled 判死 |
| 夸克 | 16 | **16/16（100%）** | 16/16 | token→stoken→detail 零 Cookie 全绿（含 2 带码链）；detail pdir_fid=0 根层+单目录下钻一层（84 子项全名全尺寸实证）；41031「分享者用户封禁」判死（1 链） |
| 迅雷 | 6 | **1/6** | 1/6（5 链 HTTP 400 invalid_argument 判「码/链废」待 W3 复核） | captcha/init 舞步通（九轮 md5 签名，盐取 pansou 本地仓 L1305；timestamp 必须字符串——int 报 meta scheme error）；**真验证码熔断零触发**；签名修复前 15 链全 captcha_invalid=代码病非盘墙 |
| 139 移动 | 2 | **2/2（100%）** | 2/2 | getOutLinkInfoV6 空 Cookie 列表全通（AES-128-CBC key 公开）；**提取码明文回吐实证**（n5ao/mmlx）；lkName 标题+单夹下钻实证；语料仅 2 链全跑 |

> **计数口径注（W3·judge#2 补注，逐盘声明）**：总表「链数」列=**跑批链次**（同链可因跨轮复测/
> 片段码 URL 变体多次计数），非独立链数。逐盘独立链口径（按盘型 share_id/URL 去重）：
> 百度 8（语料 raw=dedup=48 取样 8，全独立）｜阿里 7（raw=dedup=104）｜夸克 16 链次
> =两轮跨轮累计、独立 14（两轮间 2 链复测；语料 quark raw=1135/dedup=1131 存 4 条重复）｜
> **迅雷 6 链次=3 独立链**（VP1hRejZ/VP2WcZD_/VP2Ae5hV，其中 VP2WcZD_ 含中文片段码 URL 编码态
> 变体 2 次）｜139 语料仅 2 链（hash 路由型，URL 归一需按 #/w/i/ 尾码）。
> 在档复核警示：`w2_discovery_results.jsonl` 因旧 `unlink()` 重跑截断逻辑**只存末轮 8+7+8+4 行**，
> 前轮档已毁——judge#1 危害实证；W3 起 w2_discovery_run.py 已改 run-id 追加制（见脚本头注）。

> **迅雷 W3 复核行（judge#2 补录，2026-10-30 夜，analysis/w3_xunlei_results.jsonl）**：
> 新猎 130 独立链（TG×2 词+melost/panhunt/mikuclub/naspt×1 词共 8 发搜索；无码 54/带码 76；
> 排除 W2 三旧链）选样 6 新链逐链落档：**列表 2/6**（2 链 share_status=OK 真文件名列表；
> 4 链 400 invalid_argument，**双口径判死**=URL 内嵌码与空码复测皆 400，链废非码错位）。
> 真盐算法在档证据：14 次 captcha/init **全通零 captcha_invalid**、真验证码 url 字段零出现。
> 盘级结论：链路算法无病；TG 迅雷链存活率低（W2 1/3 独立链 + W3 2/6 = 3/9 活）是生态事实。
> 本腿发数：搜 9 + 验 28 = **37 发（超腿预算 30 达 7 发，超因判别复测两轮+代理重试，如实入账）**。

**发现层成立度：4.5/5 盘**（百度/阿里/夸克/139 列表链路全通；迅雷链路已通但样本链 5/6 码废，
盘级成功率待 W3 换新链复核——链路可用性以「最后目击(2026)」真文件名列表为证）。

## 二、逐盘证据（全实测，含修复攻防）

### 百度（一轮 9 链全败 → 预热修复 → 二轮 6/8）
- 一轮（无预热）：9/9 全 `list errno=9019` —— pansou 零 Cookie 配方的缺环=其 httpClient 自带 Cookie 罐
- 修复：GET 分享页预热收匿名 Cookie（零凭据）→ 二轮无码链 6/6 `errno=0` root 列表
- 带码链 ×2（pwd=qiye）：verify POST `errno=0`+`randsk` 发放（舞步实证）→ list `-21`「来晚啦，该分享已被取消」→ **正确判死**（链本身已亡，非配方败）
- errno 谱实测：0=活 / -21=取消 / 9019=无预热反爬 / 8001（验证码软门）零触发

### 阿里（一轮 share_id 仅 query 全败 → body 双入 → 二轮 7/8）
- 一轮 9/9 `InvalidParameter.ShareId: share_id is not valid` → 修复（query+body 双入）
- 二轮：7 链 `get_share_by_anonymous`→`share_token`→`file/list`（x-share-token）全通；
  1 链 `ShareLink.Cancelled:share_link is cancelled by the creator` 判死
- 注：pAtQuWA2fdT 链 file_count=1 但 items=0（root 口径回退已修，未复测——预算封账，W3 顺带）

### 夸克（两轮 16/16 + 子层下钻实证）
- token（含 2 条带码链 passcode 全通）→ detail(pdir_fid=0,_sort=file_type:asc) 根层
- 单目录根下钻一层：`4d4f7daa67d3`→4 子项（大平层.zip 1.26GB 等）；`0a78c60ed400`→**84 子项全名全尺寸**（1.mp4 24.1MB…）
- 判死族：41031 分享者封禁 / 提取码错误 / 失效——message 字段直读（`msg` 空是字段名坑，已修）

### 迅雷（签名攻防 3 轮才通——臆造盐教训在案）
- 攻防：①int timestamp→400 `meta scheme error, expect string`（改 str 过）；②**臆造九轮短盐→400 invalid captcha_sign**
  （教训：凭记忆写的算法=臆造，已在 engine/pansou 本地仓 L1302-1323 逐行核对修正——首轮即 content+长盐连拼九轮 md5）
- 通链实证：`VP1hRejZ…?pwd=4gcx` → share_status=OK，文件「最后目击(2026)」（带码链列名成功）
- 5 链 400 invalid_argument（TG 语料码/链陈旧疑）；**captcha/init 响应 url 字段（真验证码）全程零出现=熔断路径未实战**
- 中文片段码 `#（提取码：j5n9` 解析已入 strip_pwd（含 URL 编码态）

### 139 移动（2/2 满绿，语料仅此 2 链）
- `2wFGVXneonin0`：lkName=《穿成乱世寡嫂靠空间南迁搞基建》连载至781集；**提取码回吐=n5ao**；根=1 夹→下钻 2 子夹（0001-0500/0501-1000）
- `2v3EzZfWKgRkw`：《从恋综开始翻盘》858集完；提取码回吐=mmlx；同构 2 子夹
- 空 Cookie/AES 密钥公开/YunX 注释实锤互证

## 三、预算账（数字零造假，148/150）

| 轮 | 发数 | 内容 |
|---|---|---|
| 预试+定点调试 | 15 | 冒烟 1+夸克结构 4+迅雷签名 3+百度带码 3+夸克 pdir_fid 4 |
| 一轮跑批 | 42 | 五盘 31 链（旧配方，暴露 4 病灶） |
| 二轮跑批 | 63 | 五盘 26 链（百度预热/阿里 body/夸克 pdir_fid 修复后） |
| 终验轮 | 16 | 迅雷 ts 修复前 6+139/夸克终验 10 |
| 迅雷签名后验 | 6 | 真盐算法 3 链 |
| 迅雷片段码验 | 6 | 中文码 3 链 |
| **合计** | **148 ≤ 150** | 零超发 |

台账文件：`analysis/w2_discovery_ledger.jsonl`（105 发）+ `analysis/w2_verify_ledger.jsonl`（28 发）+
调试 15 发（会话内留痕如上）；逐链结果 `analysis/w2_discovery_results.jsonl` + `analysis/w2_verify_results.jsonl`。

## 四、代码件清单（W2 落地）

- `engine/sourcehub/discovery/`：base（预算账本+DResult 契约）+ baidu/aliyun/quark/xunlei/pan139 五 adapter + 注册表
- `engine/sourcehub/plugins/`：插件框架（默认全关/config.json 唯一开关/凭据只查存在性）+ baidu_bdn（包装 bdn.py）+ pan123 预留位 + README 契约
- `ph.py`：`discover <url>` 子命令 + search 发现/交付两栏 + doctor 插件态
- `searchagg.py`：记账行 disks 字段（judge#1）+ 命中 URL 归档位
- `scripts/w2_discovery_run.py` / `w2_verify_fixes.py` / `w2_disk_recount.py`

## 五、遗留（W3 候选）

1. ~~迅雷盘级成功率复核~~（✅W3 已毕：新猎 130 链选 6 落档，列表 2/6，4 死链双口径判死；
   真盐 14 次 init 全通——见上方 W3 复核行与 analysis/w3_xunlei_results.jsonl）
2. 阿里 root 口径回退复测（pAtQuWA2fdT）
3. 发现层下钻深度参数化（现=根层+单目录一层；夸克/139 已实证可继续下钻）
4. 迅雷真验证码熔断实战样本（本批零触发，路径在代码未验证）
5. 123 插件位登录实现（用户自供官方凭据后）
