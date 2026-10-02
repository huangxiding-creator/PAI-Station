# 体验版钉位、出码交付与「页面不存在」根治链

> 这是 zongbao-ai 弧线三次复发三次加防线换来的教训级资产。任何「新包上传→给用户/
> 测试者可扫码体验」的场景都必须读这份再动手。

## 0. 问题本质（一段话）

体验版（trial）**钉在某个开发版本记录上**。三个独立机制会让「无路径入口」
（控制台自带体验码、最近使用、会话卡片）解析到**线上老版本的页面表**：

1. **robot 顶替**：miniprogram-ci 同一 robot 再上传会**替换该机器人名下的开发版本
   记录**——体验版若钉着它，即被顶掉悬空（旧版功能凭空消失）。
2. **线上老页面表**：一切无 path 入口默认页解析参照**已发布线上版**的页面表。
   老线上版只有 `home/home`+`my/my`，新包没有 home/home → 必 404「页面不存在」。
3. **钉位停在旧版**：用户重钉动作滞后，体验版还钉在缺新页面的老版本上。

三机制独立成立，单修任何一个都不够——必须**包级根治**（§1）+**码级根治**（§2）
+**流程根治**（§3）三层齐上。

## 1. 包级根治：home/home 兼容跳板页（一次写入，永久免疫）

在 app.json 里殿后注册 `pages/home/home`，落地即跳真首页：

```javascript
// pages/home/home.js —— onLoad 里：
wx.reLaunch({ url: '/pages/ask/ask', fail: () => {
  wx.switchTab({ url: '/pages/ask/ask' });   // reLaunch 失败兜底
}});
// wxml 记得带 statusBarHeight 占位（nav 兼容）+ 蓝图闪屏
```

要点：
- app.json `pages` 数组**入口页仍是真首页**（第一位），home 殿后——不影响正常入口。
- 老表里有 home/home，新包也有 home/home → 无论按哪张表解析都命中，落地即跳。
- BOOT-SIM 断言：`"pages/home/home" in app_json["pages"]` + `reLaunch in home.js` +
  `switchTab in home.js` 三条钉死。
- **注意**：线上从未发过版的新 appid（无老页面表）理论无此问题，但带上无害——
  保险带总是便宜的。

## 2. 码级根治：永不 404 码配方（每次换版交付必备）

出码（`wxacode.getUnlimited`）三参数钉死：

```python
{
  "page": "pages/home/home",     # 新老包双环境都在页面表里的路径
  "check_path": false,           # 关键！true 会按【线上版页面表】校验，新页面必 41030
  "env_version": "trial",        # trial / develop / release 三态
  "scene": "s=p&a={aid}",        # ≤32 字节，业务参数走 scene
}
```

**check_path 语义坑（自纠错实录）**：曾以为 `check_path=true` 探针能读钉位健康——
错，它只按线上版已发布表校验，钉位健康时真页面也 41030 → 恒假阴性机器。
它不是钉位探针，是线上表校验器。

**scene 深链闭环**：出码带 scene 时，落地页（ask 与 home 都要）必须解析：
`onLoad(options)` → `decodeURIComponent(options.scene)` → 按 `s=p&a=` 跳
`answer?id=`，重试上限 3 次防循环。

**海报二维码专用**：`env_version` 读服务端 config（如 `POSTER_QR_ENV_VERSION`），
**发布前必须钉 trial**——提前置 release = 海报上印着老线上版码，用户扫了进旧版
（0.7.0 时代实锤事故）。发布日一行切 release（见 §5）。

## 3. 流程根治：robot 轮转 + 换版交付三件套

### 3a. robot 1..N 轮转（防顶替）

uploader 里维护 `robot_cursor.txt`，每次上传 robot = cursor+1（1..30 循环）：
**一个版本一个机器人**，永不替换任何被钉记录。上传后自动跑通道体检探针
（出码+解析）确认链路活。

### 3b. 换版交付三件套（给用户的标配）

1. **永不 404 码**（§2 配方，env_version=trial）——桥发件箱/桌面弹窗双路交付。
2. **「钉完立刻自测」指令**——让用户控制台把新版选为体验版后，**当场扫码走一单**
   （钉位状态是换版事故的唯一变量，等发现晚了就是用户替你测bug）。
3. **雷达监视基线**——记录 users/answers 表当前最新成功时间；用户扫码后对比，
   零新流量=入口层死了，立刻回查钉位。

### 3c. 钉位判据（没有 API，别瞎造探针）

- **无 API 可查钉位**——「重选体验版」只有用户控制台能做。
- 真判据=用户手机扫**显式 page 码** + 引擎侧雷达（answers 表最新成功咨询时间
  vs 上传时间，零流量即入口层死）。
- 桌面微信当试验台有限制：桌面账号可能无体验版权限，协议链回落老壳——
  **手机才是终审**。桌面可用 `weixin://dl/business/?t=` 协议码（generatescheme）
  拉起+PrintWindow 截图+像素探针辨版本（导航栏颜色等像素级差异）。

## 4. 版本切换的用户指令模板（照抄改版本号）

> 新版 v0.7.6 已传后台。请：
> ① mp.weixin.qq.com → 版本管理 → 找到 0.7.6（总包君 09:57 传）→「选为体验版」
>    （会弹确认对话框，确认即可）
> ② 立刻扫这个码（附永不404码），输入任意工程问题走通一单，告诉我结果。
> 若报「页面不存在」：先确认选中的是 0.7.6 那一行（不是旧版本），再扫码。

## 5. 发布日切换清单（审核通过→发布）

1. 控制台「发布」线上版。
2. **POSTER_QR_ENV_VERSION trial→release**：服务端 config 一行 + 重启 +
   （若有 CloudBase/其他部署位同步改）。
3. 海报缓存按 env 隔离的会自动失效重生成——验证一张新海报码可扫进**线上版**。
4. 发布后线上老页面表问题消失，但 home/home 跳板保留（防回退场景）。
5. 更新 BOOT-SIM 断言里的版本标记，跑全量门。

## 6. 快速诊断决策树（用户报「页面不存在/旧版」时）

```
用户扫的是什么码？
├─ 控制台自带体验码/最近使用/会话卡（无路径入口）
│   → 老页面表机制：包里有 home/home 吗？
│     ├─ 无 → 补 home/home 再上传（§1）
│     └─ 有 → 钉位停在旧版？→ 用户重钉（§4 模板）
└─ 我们出的显式 page 码
    → check_path=false 了吗？scene 解析落地了吗？
    → robot 顶替？查 robot 台账每版一机器人了吗？
终判据：引擎雷达 answers 表有无新成功记录（零流量=入口死，有流量=页面层活）
```

## 7. 码的交付通道双保险（码出了还要送达到手机）

出码只是生产，送达是另一半——双路交付，单路死不阻塞：

| 通道 | 形态 | 要点 |
|---|---|---|
| 微信桥发件箱 | `~/.wechat-claude-code/outbound-spool/` 落 JSON `{text, file}`，桥进程投递到手机 | 纯文件写=主通道（python subprocess 弹窗会阻塞挂死 120s，别用进程链弹）；通道可能整段死（ilink ret:-2 持续），死则静默切桌面路 |
| 桌面弹码 | bash 直接弹图（`cmd //c start` 拆成 bash 跑，不阻塞） | sanctioned 兜底；Windows 不弹窗铁律的例外=「必须显示到桌面上的」此类 |

纪律：发送前查重（防迟到重复投递）、长任务静默、总结只发一次。

## 8. robot 台账与上传回包验真

robot 轮转不是设完就忘，要留审计链：

```javascript
// 上传器里（upload_qianwen.mjs 实形）
const robot = (last % 30) + 1;                    // 1..30 循环
fs.writeFileSync(CURSOR, String(robot));          // 游标前移
fs.appendFileSync('work/robot_registry.jsonl',    // 逐版审计：时间/版本/robot
  JSON.stringify({ time: new Date().toISOString(), version, desc, robot }) + '\n');
```

- **事故复盘靠台账**：0930 钉位复发时逐行核实「5 版本 5 机器人零顶替」，一条
  jsonl 就排除了 robot 顶替假设——没有台账就要靠猜。
- **上传回包必验铁证**：`UPLOAD_OK` + 包字节数（subPackageInfo）+ robot 号 +
  （带插件时）`pluginInfo` 插件本体字节数。exit 0 ≠ 成功（Node25 ESM 空转
  exit 0 假成功实锤）。
- 上传后自动跑通道体检（`TRIAL_HEALTH` → `CHANNEL_OK`），BROKEN 时给用户的
  唯一修复动作=重钉体验版（§4 模板）。
