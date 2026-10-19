---
name: weapp-fullchain-deploy
description: 微信小程序版本全链交付八关（代码→对抗审查→测试→云托管部署→DevTools实证→提审→推送→百度备份）的操作手册。当用户要发布/更新小程序版本、提审、部署引擎、DevTools 验证、上传代码或全链收官时使用。主役项目：总包AI顾问（wx5cee, 微信小程序/zongbao-ai + services/qianwen-engine）。
---

# 微信小程序全链交付八关

## Purpose

一次版本上线走完八关，每关有硬门与实证，不跳关。主役双仓：**客户端**（`E:/AI-Station/微信小程序/zongbao-ai`，appid wx5cee1574ce45819b）与**引擎**（`E:/AI-Station/services/qianwen-engine`，TCB CloudRun 服务 `qianwen-engine`）。

## Workflow

### 关1 代码（双轨并行）
- 引擎改完即 `cd services/qianwen-engine && py -X utf8 -m pytest tests/ -q` 全绿才进关2。
- 客户端改完 `node --check` 每个 .js；产品文案/结构变更时**同笔**同步 BOOT-SIM 锚点（关3）。
- 版本号三处同步：`utils/telemetry.js` VER + `pages/my/my.wxml` 页脚 + `package.json` version。

### 关2 对抗审查（变现代码必过）
- 用 Workflow 跑「5 维度扫描 → 去重 → 每发现 3 镜对抗验证（code-repro/spec-contract/impact-severity，≥2 票存活）」；产出 confirmed/refuted 两栏，确认项全修全测后才许部署。
- 维度模板：配额记账正确性 / 并发与事务 / API契约与客户端兼容 / LLM成本与滥用面 / 产品经济性。
- 验证器会留 `_repro_*.py` 实证脚本——入档不删（既有惯例）。

### 关3 测试（锚点纪律）
- 引擎：pytest 全量。客户端：`py -X utf8 WeAppForge/work/bootsim_v3.py`，**N/N 全 PASS** 才进关4。
- 锚点漂移≠产品回归：先判断「锚旧」还是「真破」，锚旧则改锚并让锚点断言**新契约**（改文案必带改锚，防止下次盲飞）。

### 关4 部署（TCB CloudRun）
```bash
# 1) 重建 staging（含 content 层，幂等）
py -X utf8 WeAppForge/work/mp_cancel_logout/qw_tcb_prep.py
# 2) CLI 部署（EnvParams 不重置；灰度问答喂回车）
cd data/state && printf '\n' | "C:\Users\91216\AppData\Roaming\npm\cloudbase.cmd" cloudrun deploy \
  -s qianwen-engine --source qw_deploy_stage_1007 --port 8080 --min-num 1 --max-num 2 \
  --vpc-config '{"vpcId":"vpc-hv6ji25g","vpcCIDR":"172.17.0.0/16","subnetId":"subnet-ksblbg8p","subnetCIDR":"172.17.0.0/20"}' \
  --open-access-types PUBLIC,MINIAPP --force --wait
```
- **验证三板斧**：`cloudrun detail --json`（Status normal + EnvParams 键全）→ `/api/health` → **行为指纹探针**（铸 HMAC token 打真端点，断言新语义如 left 值/回答长度）。
- 部署前先判线上版本行为指纹，确认没有半成品在跑（staging 构建可能吸工作区草稿）。
- TCB 凭证：扫码登录后 **2h 窗口内干完全部部署**；详见 references（refreshToken 绑设备指纹、API key 查无环境等坑）。

### 关5 DevTools 实证（客户端改动必过）
```bash
"E:\WeChatDevTools\cli.bat" auto --project "E:\AI-Station\微信小程序\zongbao-ai" --auto-port 9420
node /e/AI-Station/WeAppForge/_v0923_devtools_smoke.cjs   # 蓝本：连9420→reLaunch报告页→查page.data→填textarea→tap真钮→截图
```
- automator 在 `WeAppForge/node_modules`；宿主 package.json 是 `"type":"module"` → 脚本必须 **.cjs**。
- 断言优先级：`page.data()` 状态 > 元素级查询（`$('.cls')` + `.text()`）> 截图 + 视觉模型。
- `callMethod` 在部分版本不稳 → **tap 真实元素**；automator 偶发 `timeout waiting for response` → 等 15s 重试一次。
- **端口红线**：自动化只用 9420；9222（WeAIPO）/9336（mp控制台）/9337（视频号）禁碰。

### 关6 提审（外向动作，需用户明示令）
1. 上传：`NODE_OPTIONS="--require E:/AI-Station/WeAppForge/work/localstorage-shim.cjs" node work/upload_qianwen.mjs <ver> "<desc>"`（robot 1-30 自动轮转，防顶体验版钉位；Node25 不带 shim 会 exit0 假成功）。
2. 侦察：`py -3.11 -X utf8 WeAppForge/work/mp_cancel_logout/recon_0924.py`（版本行 + 提交审核钮在位 + **队列占用检查**）。
3. **队列铁律**：已有版本在审（审核中）时新提交会被 `submit_check ret:58` 静默拒绝（无任何报错文案）——先撤回在审版本（控制台手动或找撤回入口），再提。
4. 向导：蓝本 `_wiz_router_0924.py`（弹窗路由版，DrissionPage 走 9336 常驻控制台）。弹窗链：插件新版本(确认)→相关须知(勾选+下一步)→安全测试(继续提交)→接口扫描(等1-3min)→表单(描述+无需登录+不加急+隐私按用户令)→提交→确定，继续提交。
5. 终验：重载版本页断言新版本行「审核中」+ 提交审核时间戳。
- **绝不加急；只提交一次；隐私组选择（采集/未采集）遵用户当次明示**（历史坑：fill 曾误翻，语义影响接口权限回收）。
- 提审向导三坑（H2 陷阱 / a.btn_primary 真身 / 弹窗 DOM 缓存）详见 references。

### 关7 推送（冻结令：等用户明示）
```bash
git push origin main
```
- 撞远端拒绝（多会话并行同工异哈）时：**先树级比对** `git diff <local> origin/main --stat`，若远端已含本地内容、只缺末笔 → `git reset --soft origin/main` 折叠为净增单笔再推；盲目 rebase 会连环冲突。
- 未提交改动先 `git stash`，推完 `stash pop` 还原。

### 关8 备份（增量 bundle → 百度网盘）
```bash
py -X utf8 tools/repo_baidu_backup.py --repo PAI-Station
```
- 增量 bundle 要求 head 谱系可达；推送前发生过历史重构（reset/rebase）会自动升 **full**（安全兜底，正常现象）。
- 完成后核对 `tools/repo_backup_state.json` 的 last_head == 刚推的 HEAD。

## Output Contract

收官汇报含：八关各一行的状态与实证（测试 N/N、部署版本号、DevTools 断言结果、提审时间戳与 robot 号、推送区间、备份文件名）；未过之门如实标注卡点。

## Operating Rules

1. 提审是外向不可逆动作：**用户明示令才执行**；队列占用先报岔口让用户拍板（撤旧提新 vs 等过审）。
2. push 与百度备份默认冻结，等用户明示令（本仓宪法）。
3. 八关不跳关、不并测：上一关不全绿不开下一关（用户令「100%完美运行才可提审」）。
4. 深坑细节（TCB 凭证四坑、向导选择器陷阱、ret:58、automator 怪癖、BOOT-SIM 锚点史）读 `references/pits.md`，不要凭记忆复述。
