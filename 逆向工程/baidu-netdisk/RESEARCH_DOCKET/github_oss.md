# 百度网盘全盘 API/CLI 化 — GitHub/PyPI 巨人调研 (2026-10-29)

## Working notes (checkpoint log)

- [gh api 实测] iikira/BaiduPCS-Go 主仓 404 Not Found —— 仓库已删除/转移（非 archived 状态）。来源: gh api repos/iikira/BaiduPCS-Go, 2026-10-29
- [gh api 实测] houtianze/bypy: 8587 stars, MIT, Python, pushed 2025-04-02, 未 archived。来源: gh api, 2026-10-29
- [gh api 实测] PeterDing/BaiduPCS-Py: 876 stars, pushed 2024-06-18, 未 archived（baidupcs-py 真身）
- [gh api 实测] Jack-261108/BaiduPCS-Py: 4 stars, pushed 2026-09-23 —— 2026 仍在推的 fork，待查内容
- [gh api 实测] qjfoidnh/BaiduPCS-Go (iikira 正统继承者): 5851 stars, Apache-2.0, Go, 717 forks, 241 open issues, pushed 2026-09-09, 未archived; 描述="iikira/BaiduPCS-Go原版基础上集成了分享链接/秒传链接转存功能"; releases: v4.0.2(2026-08-21)/v4.0.1(2026-03-26)/v4.0.0(2025-10-28) —— 2025-2026 持续发版
- [gh api 实测] PeterDing/BaiduPCS-Py: MIT, Python, desc="BaiduPCS API & App 百度网盘客户端 和 API", 63 open issues
- [gh api issues 实测] qjfoidnh issue 流水至 2026-10-25 (#553 离线下载36040) → 项目活着; 风控信号: #546 stoken偶发错误(2026-09-16), #549 限速"断断续续被识别?"(2026-09-29), #548 登录后ls失败(2026-09-18 open), #542 v4.0.2无法上传目录(open); 转存修复活跃: #534-538(2026-08)
- [源码实测] qjfoidnh/BaiduPCS-Go baidupcs/upload.go: SliceMD5Size=256*KB(line26); RapidUpload(targetPath,policy,uploadid,contentMD5,sliceMD5,crc32,blockListMD5...)(line105); FakeRapidUpload=仅precreate构造秒传链接(line116) —— 秒传算法权威出处之一
- [源码实测] qjfoidnh 上传三段链: internal/pcsfunctions/pcsupload/upload.go PCSUpload.Precreate()/TmpFile(partSeq)/CreateSuperFile() + superfile2 见 baidupcs/{baidupcs,prepare,upload}.go; upload_task_unit.go L223 getBlockSize 动态分片(utils.go L11: Min/Middle/Max 三档, 按 MiddleUploadThreshold/MaxUploadThreshold 分档=4/16/32MB 协议); L237 precreate 参数=hex(SliceMD5)+b64Content+CRC32; utils.go creaetDataOffset=uk+contentMD5+ts 拼串取md5(秒传data参数)
- [PyPI JSON API 实测] baidupcs-py: 最新 0.7.6 @ 2023-03-22, requires_python ">=3.7,<3.11" —— PyPI 侧 3.5 年未发版+锁旧 Python; bypy: 1.8.9 @ 2025-04-02(1.8.8@2025-03-31, 1.8.7@2025-02-01) 仍在发
- [WebSearch] 新生候选: imzusheng/BaiduNetdisk-Web(官方开放API+Vue3), PeterDing/baidupan-rs(Rust CLI), codemofa/BaiduPanAPI(需装11.8.2客户端+pan.alltoapi.com授权码=第三方中转,不可控); 来源见文末搜索记录
- [README 实测] baidu-netdisk/bdpan-storage(官方org): 安全表格明文"所有操作限制在 /apps/bdpan/ 目录，无法操作用户的其他文件"(L124); 删除需双确认(L125); OAuth 2.0 授权码模式(L127); 转存目标目录=我的应用程序/bdpan/(L117) —— 官方件全员沙箱, 全盘需求只能走 BDUSS/客户端协议路线
- [gh api 实测] baidu-netdisk 官方org四仓: bdpan-storage(310★,Apache-2.0,Shell,2026-10-29今晨仍在推,Agent Skill for Claude Code/Cursor/OpenClaw), baidu-drive-sdk-go(10★,Apache-2.0,2026-09-26), mcp(154★,MIT,Python,2025-09-23), baidu-drive-backup(3★)
- [gh api 实测] Coder-AIX/BaiduDiskMCP: 3★, Svelte, 无license, pushed 2026-10-26 —— 新生MCP, 无license=只可pattern参考
- [gh api 实测] PeterDing/baidupan-rs: 3★, NOASSERTION, 2017-12 停更 —— 死
- [README gb18030 实测] qjfoidnh 命令全表: cd/pwd/ls/tree/meta/search/上传(最大128G)/下载/修复文件MD5/mkdir/rm/cp/mv=移动+重命名/转存(含带密码链接)/分享三件套(设置/列出/取消)/回收站三件套(列表/还原/删除清空) —— 十项需求全覆盖, 基于iikira v3.6.2 续作
- [WebSearch 实测] iikira 原仓 2020-04~06 作者自删(V2EX t/680836 社区讨论, 无官方声明, 猜测百度压力); 存档镜像=felixonmars/BaiduPCS-Go(967★)+fzfile/BaiduPCS-Go; WinGet 亦有 qjfoidnh.BaiduPCS-Go 分发
- [npm registry 实测] 新件: @netdisk-sdk/baidu-sdk(2025-09-22), baidupan-cli(2026-03-10), @hukewu-com/bdisk(2026-03-26), @statsmind-ai/baidudisk(2026-08-21), baiduwangpan-cli(2026-08-12) —— 待逐个定性
- [README 实测] NkAntony777/baiduwangpan-cli (npm:baiduwangpan-cli, MIT, Node>=14): 全盘访问"不受/apps/目录限制读写任意路径"; bdp ls/search/cat(免下载HTTP Range限1MB)/head/tail/grep/peek/get(断点续传)/put/mv/cp/quota/du/recycle三件套/offline/share set+cancel/groups/gshares/gls/gsearch/gdownload(群文件免转存直下,逆向sharedownload API)/gtree; --json全命令; 双模式CLI+require(); 引擎=安装时自动下载 BaiduPCS-Go v4.0.1(即qjfoidnh系); docs/group-transfer-reverse-engineering.md=群转存逆向文档; 4★早期项目bus factor风险

---

## 正式报告 (全部数据为 2026-10-29 gh api / PyPI JSON / npm registry 实测)

### 排名表

| # | 项目 | stars | 最后提交 | 语言 | 许可证 | 全盘? | adapt-score |
|---|------|-------|----------|------|--------|-------|-------------|
| 1 | [qjfoidnh/BaiduPCS-Go](https://github.com/qjfoidnh/BaiduPCS-Go) | 5851 | 2026-09-09 | Go | Apache-2.0 | 是 | **92** |
| 2 | [NkAntony777/baiduwangpan-cli](https://github.com/NkAntony777/baiduwangpan-cli) (npm 同名) | 4 | 2026-10 链活跃 | JS | MIT | 是 | 78 |
| 3 | [PeterDing/BaiduPCS-Py](https://github.com/PeterDing/BaiduPCS-Py) | 876 | 2024-06-18 | Python | MIT | 是 | 70 |
| 4 | [Jack-261108/BaiduPCS-Py](https://github.com/Jack-261108/BaiduPCS-Py) | 4 | 2026-09-23 | Python | 继承MIT | 是 | 62 |
| 5 | [houtianze/bypy](https://github.com/houtianze/bypy) | 8587 | 2025-04-02 | Python | MIT | 否(沙箱) | 45 |
| 6 | [baidu-netdisk 官方org](https://github.com/baidu-netdisk) (bdpan-storage 310★/mcp 154★/sdk-go 10★) | — | 2026-10-29 | Shell/Py/Go | Apache-2.0/MIT | 否(沙箱) | 40 |
| 7 | [AlistGo/alist](https://github.com/AlistGo/alist) drivers/baidu_netdisk | 50371 | 2026-10-21 | Go | **AGPL-3.0** | 是 | 55(仅pattern) |
| 8 | [peterq/pan-light](https://github.com/peterq/pan-light) | 12120 | 2023-09-17 | Go+Electron | LGPL-3.0 | 是 | 35 |
| 9 | [felixonmars/BaiduPCS-Go](https://github.com/felixonmars/BaiduPCS-Go) | 967 | 2020-12 | Go | 继承 | 是 | 20(存档镜像) |
| 10 | [codemofa/BaiduPanAPI](https://github.com/codemofa/BaiduPanAPI) | 小 | 2021 | — | — | 中转 | 15 |

### 各项目详情与"我们取什么"

**1. qjfoidnh/BaiduPCS-Go — 最佳蓝本 (clone-and-adapt)**
- url: https://github.com/qjfoidnh/BaiduPCS-Go ; 5851★ / 717 forks / Apache-2.0 / Go / pushed 2026-09-09 / releases v4.0.2(2026-08-21)·v4.0.1·v4.0.0(2025-10-28)；WinGet 分发 `qjfoidnh.BaiduPCS-Go`
- 定位: iikira 原版 v3.6.2 的正统续作（原仓 2020-04~06 作者自删，社区共识见 [V2EX t/680836](https://www.v2ex.com/t/680836)，无官方声明）
- 登录链: BDUSS/STOKEN cookie（浏览器提取或 `-bduss=` 传入）；`netdisksign/` 内有 locatedownload 签名与 devuid 计算
- 覆盖操作: cd/pwd/ls/tree/meta/**search**/**download**(d.pcs直链+断点续传+并行)/**upload**(≤128G, precreate+superfile2+create 三段+秒传)/修复MD5/mkdir/rm/cp/mv=移动+重命名/**转存**(含带密码链接, 2026-08 #534-538 密集修复 base64url surl 正则/STOKEN 误报)/**分享**三件套/回收站三件套/离线下载 —— 十项需求 100% 覆盖
- 活跃证据: issue 流水至 [2026-10-25 #553](https://github.com/qjfoidnh/BaiduPCS-Go/issues/553)；feat PR #550 transfer --list(2026-10-08)·#551 prefer_ipv6(2026-10-12)
- 风险在案: [#546](https://github.com/qjfoidnh/BaiduPCS-Go/issues/546) stoken 偶发错误(2026-09-16 open) / [#549](https://github.com/qjfoidnh/BaiduPCS-Go/issues/549) 限速"被识别"疑虑 / [#548](https://github.com/qjfoidnh/BaiduPCS-Go/issues/548) 登录后 ls 失败个例 / [#542](https://github.com/qjfoidnh/BaiduPCS-Go/issues/542) v4.0.2 无法上传目录(open) —— 均为非全体性报告，项目本体可用
- 我们取: 整仓 clone-and-adapt；`baidupcs/` 包即纯 API 层(不含 CLI)，可直接被 Go 程序 import 改造

**2. NkAntony777/baiduwangpan-cli — Agent 层现成件**
- npm `baiduwangpan-cli` (2026-03 首发) / MIT (c) 2026 / Node≥14 / 双模式 CLI+require() / 全命令 `--json`
- 全盘机制: 底座=安装时自动下载 **BaiduPCS-Go v4.0.1 引擎**（即 #1），登录=浏览器抓 pan.baidu.com/passport 的 BDUSS+STOKEN（lib/browser-login.js 实测 5 处登录相关引用）
- 独家增量(逆向件): `bdp cat/head/tail/grep/peek` 免下载读文件(HTTP Range, ≤1MB) / mbox 群聊 API(groups/gshares/gls/gsearch) / **sharedownload 群文件免转存直下** / docs/group-transfer-reverse-engineering.md 等三篇逆向文档
- 我们取: 若走 Node 栈可直接用；重点是抄它的 Range 读文件与群文件逆向增量；4★ bus factor，勿当唯一底座

**3. PeterDing/BaiduPCS-Py — Python 路线参照**
- 876★ / MIT / pushed 2024-06-18 / PyPI 0.7.6@2023-03-22 且锁 `>=3.7,<3.11` —— 主仓 2.4 年、PyPI 3.5 年未动，实质停滞
- 登录: `BaiduPCSApi(bduss=bduss, cookies=cookies)` 手工提 cookie（README 实测）
- 能力: 多账号/cat/ls/rm/mv/cp/search/加密解密文件/分享/转存/离线下载（README 目录实测），Python 全操作实现最全者
- 我们取: 纯 Python 实现的协议对照教材；若必须 Python 栈，配合 #4 fork 或按其源码续修

**4. Jack-261108/BaiduPCS-Py fork**: 2026-09-23 仍在修"new Baidu Pan locals-data inline JSON share page"等回归（commits 实测），4★ 个人维护，作 #3 的补丁源

**5. houtianze/bypy**: 8587★/MIT/PyPI 1.8.9@2025-04-02 仍在发，但官方 OAuth → **锁 /apps/bypy 沙箱**，全盘需求直接出局；只取其 OAuth refresh-token 工程细节

**6. baidu-netdisk 官方 org**: bdpan-storage(310★, Apache-2.0, 今晨仍推, Agent Skill 形态) / mcp(154★, MIT, 2025-09) / baidu-drive-sdk-go(10★)。README 安全表 L124 实测明文: "所有操作限制在 /apps/bdpan/ 目录，**无法操作用户的其他文件**"，转存目标也锁 /apps/bdpan/。官方合规路线与全盘需求根本冲突；仅当未来申请到"全部文件"权限scope时才值得回头看 sdk-go

**7. AlistGo/alist baidu driver**: 50371★/2026-10-21 活跃，driver.go 实测含 getSliceSize 动态分片+256KB SliceMD5 全上传协议；**AGPL-3.0 → 只可 pattern 参考，禁抄代码**

**8-10**: pan-light(12120★, 2023 停更, 历史教材) / felixonmars 镜像(原仓存档) / codemofa(第三方 relay 不可控) —— 均不采用

### 秒传算法权威出处（源码级核实，按优先级）
1. **qjfoidnh/BaiduPCS-Go**:
   - `baidupcs/upload.go` L26 `SliceMD5Size = 256 * KB`；L105 `RapidUpload(targetPath, policy, uploadid, contentMD5, sliceMD5, dataContent, crc32, offset, length, totalSize, dataTime, blockListMD5)`；L116 `FakeRapidUpload`=仅 precreate 构造秒传链接
   - `internal/pcsfunctions/pcsupload/utils.go` L11 `getBlockSize`: 按文件大小三档动态分片(Min/Middle/MaxUploadBlockSize = 4/16/32MB 协议)；L22 `creaetDataOffset` = `uk+contentMD5+timestamp` 拼串取 md5（秒传 data 参数构造）
   - `internal/pcsfunctions/pcsupload/upload.go`: `PCSUpload.Precreate()/TmpFile(partSeq)/CreateSuperFile()` 三段链; superfile2 端点见 `baidupcs/{baidupcs,prepare,upload}.go`（code search 实测命中 4 文件）
   - `internal/pcsfunctions/pcsupload/upload_task_unit.go` L223/L237: 分块 md5 计算 + precreate 参数拼装(hex SliceMD5 + b64Content + CRC32)
2. **PeterDing/BaiduPCS-Py**: 同协议 Python 实现（对照翻译用）
3. **AlistGo/alist drivers/baidu_netdisk/driver.go**: sliceSize 动态分片+256KB 佐证（AGPL 只读勿抄）
4. 历史源头: PeterDing/iScript `pan.baidu.com.py`（BaiduPCS-Py 前身）

### 抓包/协议文档仓
- 唯一找到的近期公开协议逆向文档: NkAntony777/baiduwangpan-cli `docs/group-transfer-reverse-engineering.md` + `group-download-final-verdict.md`（群转存/mbox/sharedownload）
- 未发现独立维护的"百度网盘协议/抓包"文档仓（搜 "baidu netdisk protocol" 无专门命中）；本机 8.2.5 CEF 客户端抓包仍需自采，蓝本签名细节可对照 qjfoidnh `baidupcs/netdisksign/`

### 三强推荐
1. **qjfoidnh/BaiduPCS-Go (92/100) — 唯一 clone-and-adapt 蓝本**: Apache-2.0 宽松、2026-10 仍活跃修协议、十项操作全覆盖、`baidupcs/` 包天然是可 import 的 API 层、秒传/三段上传/下载签名全部源码在案。改造点=把 CLI 层换成 API server/函数层，登录改走本机 8.2.5 客户端 cookie 注入。
2. **NkAntony777/baiduwangpan-cli (78/100) — 零成本 Agent 壳+独家逆向增量**: 它已替我们做完"BaiduPCS-Go 引擎 + BDUSS 浏览器登录 + --json Agent 化"，额外白送免下载 cat/grep 与群文件直下两块独家逆向；MIT 可合流。因 4★ bus factor，只作增量层不作底座。
3. **PeterDing/BaiduPCS-Py (70/100) — Python 栈备胎与协议教材**: 全操作 MIT Python 实现，主仓停滞但 Jack-261108 fork 2026-09 仍在修；仅当强需求 Python 原生栈时启用。
- 结论性排除: 官方 bdpan/bypy/OAuth 系（沙箱=与全盘需求根本冲突）、alist（AGPL 传染）、iikira 原仓（2020 已删）、baidupan-rs（2017 死）。

### 搜索记录（部分 WebSearch 来源）
- [V2EX: iikira/BaiduPCS-Go 仓库被删了?](https://www.v2ex.com/t/680836)
- [qjfoidnh/BaiduPCS-Go](https://github.com/qjfoidnh/BaiduPCS-Go) / [winstall 分发页](https://winstall.app/apps/qjfoidnh.BaiduPCS-Go)
- [imzusheng/BaiduNetdisk-Web](https://github.com/imzusheng/BaiduNetdisk-Web)（官方开放API+Vue3，沙箱系）
- [PeterDing/baidupan-rs](https://github.com/PeterDing/baidupan-rs)（2017 停更）
- [codemofa/BaiduPanAPI](https://github.com/codemofa/BaiduPanAPI)（第三方中转，弃）
