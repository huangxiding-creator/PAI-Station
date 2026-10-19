# 全链八关深坑大全（2026-10-19 v0.9.24 战役实锤）

SKILL.md 的条件加载参考：只在踩到对应关卡时读。每坑 = 症状 → 根因 → 解法，全部来自实战验证。

---

## 关4 部署 · TCB 凭证四坑

| # | 症状 | 根因 | 解法 |
|---|---|---|---|
| 1 | `node get_engine_url2.js` → `Token verification failed` | auth.json 临时凭证 **2h 寿命**（tmpExpired） | 扫码重登（`cloudbase login` 后台挂起，授权页给用户扫）；2h 窗口内干完全部部署 |
| 2 | 协议复刻刷新 POST `iaas.cloud.tencent.com/tcb_refresh`（credential+md5(mac)）→ `AUTH_FAIL 无效的身份凭证` | refreshToken 疑似**绑定登录时设备指纹**，换进程/复刻调用即判死 | 别复刻刷新；重扫码 |
| 3 | 永久 API 密钥（`data/secrets/tcb_api.secret`，SecretId=AKIDS…）能认证但 `DescribeEnvs` **空列表** | 密钥归属/主子账号错（「控制台建密钥」第四坑）；旧版 API 空回误导 | 建密钥后立即用 manager-node 新版 `env.list()` 验归属 |
| 4 | CLI 直跑报「请使用 tcb login 登录」 | env 变量注入的假密钥优先于 auth.json，CLI 不自动续期 | 干净 env 跑；登录态以 auth.json 两个镜像路径为准（`~/.cloudbase/` 与 `~/.config/.cloudbase/`） |

**部署通道事实**：`tcb run service:config` 是结构性死路（options 无 envId + checkTcbrEnv 拒非 tcbr）；改环境变量走 manager-node `update_envparams.js`（`deploy()` 更新分支不展开旧配置，`OpenAccessTypes` 必显式钉死）；纯代码部署走 CLI `cloudrun deploy`（EnvParams 不重置，实测零漂移）。

**tar 双剥坑**（旧 ECS 链遗产）：arcname 已带前缀时 `--strip-components=1` = 双剥，服务跑旧码出 404 fallthrough。

---

## 关5 DevTools · automator 六怪

1. **`.cjs` 强制**：宿主 package.json `"type":"module"` 下 `.js` 脚本 `require` 直接炸（`ReferenceError: require is not defined in ES module scope`）。
2. **`callMethod` 不稳**：`page.callMethod('onAskSend')` 报 `this.onAskSend is not a function`（方法明明在）→ 改 `page.$('.real-selector')` + `.tap()` 点真元素。
3. **H2 陷阱**（同款逻辑也在提审关）：按 ownText 找「提交审核」可能命中 `<h2>` 标题而非按钮——候选必须排除 `H1-H6` 并核对 tagName。
4. **超时瞬态**：`timeout waiting for automator response`（IDE 忙编译）→ sleep 15s 重试一次即愈。
5. **截图时紧时松**：截图调用偶发超时但 `page.data()` 活着——断言优先 data/元素查询，截图仅视觉存档。
6. **reload 失联**：`location.reload()` 后旧 tab 句柄 `ContextLostError` → 重载后**重取** `page.browser.get_tab(tid)`。

**语音双钮结构**（报告页）：`.rp-ask-hero-send`=文字发送，`.rp-ask-hero-voice`=按住说；textarea=`.rp-ask-input`。

---

## 关6 提审 · 向导与暗墙

### ret:58 暗墙（最高价值教训）
- **症状**：表单填好、「确定，继续提交」点了、弹窗关了——版本行纹丝不动（仍「提交审核」可点态）；无 toast 无报错。
- **定位**：`page.listen.start('wxamp')` 网络监听 → `GET /wxamp/cgi/route?path=/wxopen/wadevelopcode?action=submit_check` 返回 `{"ret":58}`——**队列占用**（已有版本审核中）的服务端静默拒绝。
- **解法**：撤回在审版本（控制台版本管理页；自动找不到入口时交用户手动撤+删旧开发版），队列清空后一次通过。
- **教训**：界面零反馈的失败必须下沉到网络层抓包；300ms 高频轮询 toast 抓不到的东西，RPC 响应一抓一个准。

### 向导选择器三坑
1. **弹窗 DOM 缓存**：`document.querySelectorAll('.weui-desktop-dialog')` 返回**所有历史弹窗**（含隐藏）——必须逐祖先 `getComputedStyle` 判真可见（display/visibility/offsetParent 三查）。
2. **真提交钮是 `a.btn_primary`**：不在 `button` 里；页面还有同名 H2 标题与多个「提交」假身——ownText 精确匹配 + tagName 过滤 + `a.btn_primary` 优先。
3. **表单在独立 tab**（`wadevelopcode/get_class`）：DrissionPage 须 `page.browser.tab_ids` 遍历切 tab，主 tab 句柄读不到表单。

### 弹窗接力全序（0.9.24 实测）
0.9.24 行「提交审核」→（插件新版本：确认）→（相关须知：勾选+下一步）→（安全测试提醒：继续提交）→（接口权限检测中…**等 1-3 分钟别动**）→ 表单 tab 开 → 填描述+单选 → `a.btn_primary` 提交 →（确认提交审核：确定，继续提交）→ 重载版本页验「审核中」。
- 弹窗会**超时自消并杀死整条链**——路由器脚本要 1s 轮询即时接住每只弹窗（蓝本 `_wiz_router_0924.py`）。

### 表单三单选语义
- 无需登录账号即可使用 / **审核加急=否（铁律：绝不加急）** / 隐私组（采集 vs 未采集）——**隐私组必须遵用户当次明示**：选「未采集」若代码实际调用隐私接口，发布后接口权限会被回收（语音等功能废）；历史 fill 逻辑曾自动误翻，需人工终核。

### 上传坑
- Node25+ 上传**必带** `NODE_OPTIONS="--require …/localstorage-shim.cjs"`（corecompiler 子进程 localStorage.getItem 崩，**exit 0 假成功**）。
- robot 1-30 轮转防「同 robot 再上传顶掉体验版钉位 → 扫码页面不存在」；上传后跑体验版健康探针（探针脚本若报 `python` 找不到=别名坑，用 `py` 手动补跑）。

---

## 关3 测试 · BOOT-SIM 锚点纪律

- 锚点断言的是**产品契约快照**（文案/结构/配置字面）——产品改版后锚点必漂移；判断「锚旧 vs 真破」后，改锚要让断言指向**新契约**（如「免费优先铁律：rp-bar 无价格无购买解锁」），不是简单放宽。
- 版本三处（telemetry VER / my 页脚 / package.json）改一必同步三，锚点会三处交叉断言——漏一处即 FAIL 且难定位（历史曾因此连环 5 FAIL）。

---

## 关7 推送 · 多会话同工异哈

- **症状**：push 被拒 non-fast-forward；`git log origin/main..HEAD` 显示本地有对方已推内容的**异哈同工**提交；盲目 `pull --rebase` 连环冲突（未提交改动还会挡路）。
- **解法序**：`git stash` → 树级比对 `git diff <local-head> origin/main --stat` → 若远端已含本地内容只缺末笔 → `git reset --soft origin/main` 折叠净增单笔 → push → `stash pop`。零内容丢失，历史干净。
- 判据：diff 全是「远端缺我的新增」(deletions 为主) 即可折叠；若双向都有独占改动才走真 rebase。

---

## 关8 备份 · 谱系断裂自动升全量

- 增量 bundle 依赖 `last_head` 在新 HEAD 祖先链上；push 前做过 reset/rebase（关7 的折叠法）→ 谱系断 → 脚本自动 full（安全兜底）。看到 `full_*.bundle` 别慌，先查 `repo_backup_state.json` 的 last_head 是否等于刚推 HEAD。

---

## 通用 · 端口与红线速查

| 端口/资源 | 归属 | 纪律 |
|---|---|---|
| 9420 | DevTools 自动化（本链专用） | 唯一可自用自动化口 |
| 9222 | WeAIPO 浏览器 | 免打扰禁碰 |
| 9336 | mp 控制台常驻 Chrome | 提审向导唯一合法口；登录态过期等人工扫码 |
| 9337 | 视频号专用 | 禁碰 |
| robot 1-30 | miniprogram-ci 上传位 | 自动轮转，被钉记录永不复用 |
