# GITHUB_DISCOVERY_REPORT — zongbao-ai-v0917（分享启用 + 记录删除）

> 检索环境注记：本机 web_search/webReader MCP 配额 2026-10-26 前耗尽；WebFetch 域名
> 策略拦截 developers.weixin.qq.com。官方文档改用 curl 直拉原文（HTTP 200，两页全文
> 落档后提取），GitHub 侧以可本地验证的仓库与官方源为主——每个来源标注验证状态，
> 无臆造条目（宪法 C12）。

## 巨人清单（≥3）

### 1. 微信官方文档（今日 curl 实拉验证 ✅）

- `developers.weixin.qq.com/miniprogram/dev/reference/api/Page.html`（63,788B）
- `developers.weixin.qq.com/miniprogram/dev/framework/open-ability/share-timeline.html`（149,645B）

**采到的硬语义（直接决定 P4/P5 设计）**：
- 「转发给朋友」亮灯条件 = 页面定义 `onShareAppMessage`；「分享到朋友圈」亮灯条件 =
  **先**定义 onShareAppMessage **再**定义 `onShareTimeline`（两步门槛）——截图灰按钮
  根因确证。
- onShareTimeline 基础库 ≥2.11.3；返回 {title, query, imageUrl}，**不支持自定义 path**；
  web-view 页不支持发起分享；低版本客户端进升级提示页。
- **单页模式**：朋友圈打开≠打开小程序，进入场景值 1154 的单页运行态——无登录态
  （wx.login 不可用）、顶部导航/底部「前往小程序」操作栏固定不可定制、**适用于纯
  内容展示、不适用于较多交互页**；不得诱导/强制点「打开小程序」，应尽量呈现完整内容；
  wx.getSystemInfo 的 safeArea 返回整屏。

### 2. 本仓过审先例（本地代码验证 ✅——最贴合的"巨人"）

- `pages/answer/answer.js:631` / `report.js:257` / `research.js:104` / `zhiku.js:100`
  的 onShareAppMessage：七轮过审形态（品牌前缀标题+详情 path 携参+分享标题=品牌名）。
- 删除功能同构先例：`answer_export_unlocks`/`get_answer_visible` 的 owner 门+可见性门
  双轨（v0.9.14 锅圈腿）；`_ANSWER_UPGRADES` 列迁移机制（sqlite/mysql 双方言平滑 ALTER）。
- qw-pop 自绘弹窗系统（v0.9.7，规避原生 modal 4 字按钮硬限）——删除确认弹窗直接复用。

### 3. GitHub 生态仓（今日 api.github.com 逐仓验证 HTTP 200 ✅）

- `github.com/Tencent/tdesign-miniprogram` — 腾讯官方小程序组件库（Flint 设计体系）；
  surveyed：本轮零新组件引入，弹窗/交互沿用自研 qw-pop。
- `github.com/NervJS/taro` — 多端框架（weapp 生态主流）；surveied：本项目原生 WXML，
  无迁移动机。
- `github.com/tiangolo/fastapi` — **引擎本体在用框架**（引擎全端点同构先例的出处，
  DELETE 端点直接写 FastAPI 路由，非引入）。
- `github.com/wechat-miniprogram/miniprogram-cli` — 官方工具链生态（miniprogram-ci
  上传通道的上游生态位；本仓 upload_qianwen.mjs 已在役）。

（候选剔除：weixin/miniprogram-demo 今日 404——组织名已变迁，未列入；无关候选不凑数。）

### 4. 云开发 CloudBase manager-node（本地 node_modules 验证 ✅）

- `@cloudbase/manager-node` 5.9.0（E:\AI-Station\data\state\mn_client）：TCB 部署通道
  （028 号部署今日实证在役），删除端点上云走同一条 deploy 管线。

## 结论（缝合怪律一：clone-and-adapt）

得分 ≥80%：**全量克隆本仓过审先例 + 官方文档语义**，无外部依赖引入。新写的只有
「10 页 × 2 个 handler 的静态文案」「DELETE /api/answers/{aid} 软删端点」「my 页删除
交互」三块，全部有逐字模板。

## 对 P4 的直接影响（设计约束输入）

1. 每页必须**先有 onShareAppMessage 才能有 onShareTimeline**——两 handler 同页成对。
2. 内容型页（research/report/answer/zhiku/pot/legal）朋友圈 query 携最小参数；
   强交互页（ask/home/my/invoice）朋友圈亮灯但不携 query，单页模式走既有无登录态
   fail-open 降级（quotaError/骨架态已在役），不新建造假内容页。
3. 朋友圈单页模式文案红线：不写「点击打开小程序查看完整内容」类诱导（运营规范+
   官方注意事项），页面自然呈现既有内容。
