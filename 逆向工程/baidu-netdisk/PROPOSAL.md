# PROPOSAL v2 · BDPAN-FACTORY
# 百度网盘 8.2.5 → 全功能 API/CLI 化（三通道工厂·对抗验证定稿版）

- 日期：2026-10-29 · 状态：**待批**（红队终审 GO-WITH-AMENDMENTS，10 条修正案已全部吸收）
- 方法论：super-skill V4.1.16 全程 + REA × Reverse 三件套 × PentAGI（8443 复活）+ 5 路并行逆向 + 3 路调研 + 5 员对抗验证工作流
- 证据：全部落盘 `逆向工程/baidu-netdisk/`（analysis/ 7 件 · captures/ · RESEARCH_DOCKET/ 3 件 · blueprint/ 3 仓）

---

## 一、原始指令 → 北极星

你的指令：逆向本机百度网盘客户端 → 上传/下载/删除/检索、文件夹增删改 → API/CLI 化，Claude Code 命令行可用。
你确认的北极星：**全盘访问 + 自主可控 + 零遥测**（零遥测限定 T2/T3 通道；T1 官方通道默认关闭、按需启用并明示其遥测可能）。

## 二、战果与证据（全实测，件件有出处）

| # | 事实 | 证据 |
|---|---|---|
| 1 | **T2 通道端到端已打通**：抓包所得 BDUSS(192位,含`-`)+STOKEN(64位) Cookie + 8.2.5 原生 UA，实测 `api/loginStatus` errno=0（账号回显 pyeyeye / uk=587408217）+ `api/list?dir=/` errno=0 **根目录 17 项全盘读**；且**未带 rand/rand2 签名参数照样放行**（签名非强制已获部分实证） | 工作流 V1/V3 冒烟（本提案附录 A） |
| 2 | xpan 家族 2026-10 对纯 Cookie 仍 errno=0 放行（`rest/2.0/xpan/file?method=list` 实测，oper_id 与 uk 一致） | V3 实测 |
| 3 | 客户端不锁证书（1152 条 HTTPS 过 mitm 零失败）；无任何签名头；query 签名仅 rand/rand2/logid；双 UA 实测原文 | analysis/CAPTURE_INVENTORY.md |
| 4 | 87 端点/9 域名全表落盘；`api/filediff` 游标增量同步为最高频主通道（970 次） | 同上 |
| 5 | 协议代际漂移账：蓝本 pcs 旧域 13 用法+RC4 签名套件+clienttype=17 在 8.2.5 全部退役；身份/配额/列表已结构性迁移至 `pan.baidu.com/api/*`；唯 d.pcs locateupload 在役 | V3 漂移 diff |
| 6 | CArchive 凭据魔数=代码层字段名常量（YunDls.dll .rdata），**本地零明文凭据**（2977 文件/9.7GB 全扫零命中）——取凭据无本地捷径，但 vault 已在手（事实 1） | V2 裁决 |
| 7 | VMProtect 仅主 EXE+BULL 库；kernel/netbase/btsdk 无壳；热更链全破译（今天 18:06 刚发生一次） | analysis/STATIC_PROTECTION_IPC.md |
| 8 | BaiduPCS-Go（Apache-2.0）12 操作行号级映射；动态分块 4/16/64MB；`data=md5(uk+content_md5+ts)` | analysis/BLUEPRINT_MAP.md |
| 9 | 官方开放平台对「全盘」覆盖仅 10-15%（沙箱 by-design、无全盘申请通道、2026-06 收紧、分享/转存付费化 apaas） | RESEARCH_DOCKET/official_openapi.md |
| 10 | bdpan 3.8.7 官方 CLI **已登录 pyeyeye，Token 有效 23 天 12 小时**（本会话两次实测，输出落盘；有 v3.8.9 可升级，按纪律升级需你明示） | analysis/BDPAN_WHOAMI_1029.txt |
| 11 | 账号实为**企业 SVIP8 管理员号**（总包智（海南）教育科技，vip_type=21）——红线与风控策略按企业资产等级执行 | CAPTURE_INVENTORY §七 |
| 12 | 零写操作证据现状：抓包与冒烟全部只读；写侧（上传/删除/搜索/分享）端点未捕获、风控恰恰开在写侧 | 红队 kill#1（存活） |

## 三、100 倍升维（诚实版分解，红队修正后）

你的原始想法 = 逆向 → 12 操作 CLI（单通道、黑盒、一次性、孤立）。
本提案 = **网盘操作系统层**（bdn CLI + 协议资产 + 全站集成）：

1. **冗余如实**：端点族级冗余（api/* 新代 + xpan 中代 + pcs 遗产代=蓝本）+ 1 条独立凭据域沙箱腿（T1 OAuth，与 BDUSS 无关）。全盘维度冗余≈1.5 通道，**非 3×**；BDUSS 为 T2/T3 共用单点——一次风控或网页端登出即双通道同死 → 对冲：凭据收割 runbook（浏览器 headless 重收，你已授权账密）+ bdpan OAuth 独立域 + 熔断处置链
2. **巨人杠杆 10×**：蓝本解决 90% 规格；逆向只补 8.2.5 差分（差分已完成，见事实 3-5）；如实代价=同时维护两代协议的翻译层
3. **零遥测 ∞×**（T2/T3）：官方 bdpan 每调用回传会话上下文（旗标语义官方未文档化）；bdn 全本地
4. **全站集成 5×**：mirror 备份链一键化 + **新建独立 bdn 技能**（不动官方 baidu-drive skill——update.sh 会覆写、且其遥测强制令与北极星冲突；触发词分区：沙箱/记忆备份→官方 skill 原样，全盘→bdn）
5. **协议资产化 ∞×**：PROTOCOL.md（证据分级）+ 版本指纹 + doctor 漂移复验器——百度今天改协议，明早 doctor 一跑即知改了哪

## 四、架构（五层）

```
L5 资产层   PROTOCOL.md(证据分级) + 版本指纹 + doctor 复验器 + 第7战役方法论模板
L4 集成层   bdn 新技能(独立于官方 baidu-drive) + mirror 备份链 + Claude Code 自然语言直达
L3 CLI      bdn：16 命令全 --json、幂等、退出码规范
L2 传输引擎 上传三段(precreate/superfile2/create)+秒传(best-effort)+分片断点续传
            下载 dlink 多线程 Range+断点+md5 校验
L1 协议核心 bdncore(Python)：会话(BDUSS自愈+收割runbook)·节流器(双平面)·错误分类(errno→语义)
L0 通道     T2 PCS/api 主力(全盘,已实测打通) · T3 客户端档(会话模板+filediff+只读端点族已实证,
            写/传端点待二轮补抓) · T1 bdpan 子进程(默认关,按需开,沙箱+遥测如实标注)
```

## 五、bdn 命令面（16 命令 = 13 硬门 + 3 条件门）

```
whoami | quota | ls | tree | search* | meta | mkdir | rename | mv | cp | rm(双确认)
upload(秒传+断点) | download(多线程+校验)
share* | transfer* | recycle*          (*=条件门：端点活性证据齐则实现并验收，否则 N/A 出库+文档化原因)
mirror(备份链增量镜像) | doctor(通道健康+漂移复验)
```

## 六、验收门（数字零造假·红队修正版）

1. 13 硬门命令全绿实测（--json 输出+退出码）
2. 写路径前置冒烟：第一笔线上写=无害 `mkdir /API复刻测试_1029/`，**官方客户端交叉可见**后才放全量
3. 上传三档：1KB/10MB/200MB，200MB 中途 kill 续传成功
4. 下载 md5 与源一致；速度如实报（**不破解非会员限速**——本账号 SVIP8 口径，结论不外推免费号）
5. 秒传 best-effort：二传传输字节数=0 实证；失败如实红、不阻塞三段上传主链；秒传链接转存/FakeRapidUpload 出范围（官方已封）
6. 限流观测=**被动遥测**：正常作业中遭遇 errno 20012/31034 即记录+熔断；**禁止主动探底限流/黑名单**（生产备份账号不打极限测试）
7. 分期复审：W4 后 go/no-go 复审，过了才放 W5-W6

## 七、红线（企业 SVIP8 账号等级执行）

1. 不破解付费墙（限速/会员专属/付费 apaas 分享转存不实现）；不做 P2P 提速
2. `rm` 双确认（CLI 列清单+二次确认，对齐清理纪律）
3. 密钥外置 `.bdn/secret`（gitignored）永不进仓；vault 迁移后即从 captures 移除明文
4. 双平面节流：控制面（元数据 API）并发≤2、间隔≥1.5s；数据面（分片传输）并发≤8、全速但受服务器限制
5. 熔断处置链：31119/31329 或连续 errno 异常 → 全通道停 → 官方客户端交叉验证账号状态 → 冷却期 → 恢复先只读
6. 个人/企业自有账号互操作性用途；不分发、不碰他人数据
7. T1 bdpan 遥测旗标：启用 T1 时不传 `--session-input`（能省则省），并在 skill 文档明示残余遥测可能

## 八、波次（批准后自主，P8 worker+judge 编队；工期如实：核心五件 3-5 天智能体作业）

| 波 | 内容 | 出口门 |
|---|---|---|
| W0 | 核查 pyeye@126.com 开放平台控制台有无 2026-06-03 前存量宽权限应用（有则 T1 升格）；vault→`.bdn/secret` 迁移 | 核查结论+凭据迁移完成 |
| W1 | PROTOCOL.md 规格书（证据分级；8.2.5 实测端点≥50 条 + 蓝本端点 100% 带活性标记）；rand/rand2 强校验逐端点验证表 | 分级覆盖率门 |
| W2 | **二轮主动补抓**（需客户端 UI 会话恢复：你扫码一次，或授权我用账密自动登录）；捕获 搜索/建夹/上传/下载/分享/回收站 全写场景 | 写侧端点入表；share/transfer/recycle 定生死 |
| W3 | bdncore+bdn 骨架+8 只读命令（T2 主力+T3 会话模板） | 8 命令绿 |
| W4 | 写命令+传输引擎；首写=mkdir 冒烟+客户端交叉可见 | 五节验收门 1-5 |
| W4.5 | **go/no-go 复审**（数字报告呈你，过了放 W5-W6） | 你裁决 |
| W5 | bdn 独立技能+mirror 备份链+doctor 复验器+三通道路由降级 | 降级切换实测绿 |
| W6 | QA 总门+Ralph loop×3+方法论沉淀（第 7 战役模板） | 13+3 门终态报告 |

## 九、已花/将花

今日已花 ~73 万 token（8 腿调研逆向 + 5 员验证，全落盘复用）。W1-W6 如上期。

## 十、待你裁决

1. **全案批准**（推荐，GO-WITH-AMENDMENTS 版）——W0-W6 自主，W4.5 复审呈你
2. **缩范围**——只要 T2+bdn 核心 13 命令，砍集成层
3. **调整**——任何修改意见

### 随批注记（不阻塞，需要你知悉/择机处理）
- **客户端 UI 停在扫码页**（重启后 Web 会话清了；原生 BDUSS 仍有效）：W2 需要恢复，你扫码一次或授权代登
- **用户级 Root 库存旧 mitmproxy CA**（2026-07-19 签发，非本次植入）：交互终端跑 `certutil -user -delstore Root mitmproxy` 可清（删除类操作，待你明示）
- 残留临时件 `E:\AI-Station\_tmp_v1_credcheck\`（V1 验证脚本）：按清理纪律不自主删
- bdpan 有 v3.8.9 可升级：按纪律等你明示

---

## 附录 A · 对抗验证工作流结果（5 员，328k token）

| 员 | 裁决 |
|---|---|
| V1 凭据活性 | **GO**：loginStatus+根目录列表 errno=0（3 次只读 GET，凭据全程掩码） |
| V2 CArchive | 裁决「两腿各对一半」：魔数=代码常量非数据文件；本地零明文；取凭据靠 vault+收割 runbook |
| V3 端点活性 | **GO**：xpan 放行；漂移账全录（pcs 旧族退役确认） |
| V4 完备性 | 7 项过度声明（4 高 3 中）→ 全部吸收进本 v2 |
| J1 红队 | **GO-WITH-AMENDMENTS**：10 条修正案全采纳；其中「bdpan Token 造假」一条经复核为**引用纪律违规而非造假**（会话实测真值，现已落盘 BDPAN_WHOAMI_1029.txt 立证） |
