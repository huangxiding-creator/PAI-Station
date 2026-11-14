# 微信分享两 handler 亮灯语义（2026-10-13 官方文档实拉）

来源：developers.weixin.qq.com/miniprogram/dev/reference/api/Page.html +
framework/open-ability/share-timeline.html（curl HTTP 200 原文提取）。

## 亮灯规则（截图灰按钮根因）

1. 「转发给朋友」可用 ⇔ 页面定义 `onShareAppMessage`（返回 {title, path, imageUrl}）。
2. 「分享到朋友圈」可用 ⇔ **先**满足 1，**且**页面定义 `onShareTimeline`（基础库
   ≥2.11.3）。两步门槛，缺一即灰。
3. onShareTimeline 返回 {title, query, imageUrl}：**不支持自定义 path**（只影响本页
   query）；web-view 页不支持发起分享；低版本客户端显示升级提示页。

## 单页模式（场景值 1154）

- 朋友圈打开≠打开小程序：进入无登录态单页运行态（wx.login 等登录接口不可用）。
- 顶部导航栏+底部「前往小程序」操作栏为平台固定 UI，不可定制。
- 官方定位：适用于**纯内容展示**页；较多交互页不建议。
- 合规红线：不得诱导/强制点「打开小程序」；应尽可能呈现完整内容。
- wx.getSystemInfo 的 safeArea 返回整屏；navigationBarFit 可调相交状态。

## 本项目落地决策（v0917）

- 10 页全量 onShareAppMessage（用户令字面）；同页成对补 onShareTimeline。
- query 携参仅内容型自洽页（report?sku= / answer?id= / research / zhiku / pot /
  legal 不带参）；ask/home/my/invoice 朋友圈亮灯不携参。
- 单页模式无登录态 → 走各页既有 fail-open 降级（quotaError/骨架态在役），不新建
  诱导性内容页。
