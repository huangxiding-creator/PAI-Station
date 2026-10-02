# 微信小程序框架/UI/工程化开源生态清点（fw-ui 渠道）

- 生成时间：2026-09-27T13:10:07Z  
- 条目总数：**79**（repo 实测 74 条 + degraded 5 条）  
- 数据来源：`gh api repos/{owner}/{repo}` 全量实测（stars/forks/pushed_at/archived 均为 GitHub API 原值，抓取日 2026-09-27）

## 跨端框架（17）

| repo | stars | forks | 语言 | license | 最后 push | 状态 | 定位（对工厂价值） |
|---|---:|---:|---|---|---|---|---|
| [dcloudio/uni-app](https://github.com/dcloudio/uni-app) | 41,617 | 3,708 | JavaScript | Apache-2.0 | 2026-09-26 | 活跃 | Vue 语法跨端开发框架，一套代码编译到微信/支付宝/百度小程序+H5+App，国内跨端生态两强之一 |
| [NervJS/taro](https://github.com/NervJS/taro) | 37,702 | 4,872 | TypeScript | NOASSERTION | 2026-09-24 | 活跃 | 京东开源的开放跨端跨框架解决方案，支持 React/Vue 语法编译到全平台小程序/H5/RN，与 uni-app 并列国内两强 |
| [Tencent/wepy](https://github.com/Tencent/wepy) | 22,540 | 3,012 | JavaScript | NOASSERTION | 2026-03-18 | **ARCHIVED** | 腾讯最早的组件化小程序框架（Vue 风格语法），历史地位重要但已明确退役 |
| [Meituan-Dianping/mpvue](https://github.com/Meituan-Dianping/mpvue) | 20,241 | 2,021 | JavaScript | MIT | 2022-03-02 | 停更(2022-03) | 美团点评出品的 Vue.js 小程序框架，2018 年现象级项目 |
| [Tencent/omi](https://github.com/Tencent/omi) | 13,272 | 1,254 | TypeScript | NOASSERTION | 2026-09-24 | 活跃 | 腾讯通用 Web Components 框架（omi），附带 omix 小程序状态管理扩展，主战场是 Web 而非小程序 |
| [didi/chameleon](https://github.com/didi/chameleon) | 8,944 | 688 | JavaScript | Apache-2.0 | 2023-01-07 | **ARCHIVED** | 滴滴多端统一框架，主打『一端所见即多端所见』 |
| [alibaba/rax](https://github.com/alibaba/rax) | 8,019 | 611 | JavaScript | NOASSERTION | 2023-03-27 | 停更(2023-03) | 阿里渐进式跨端框架，曾支撑大量阿里系应用（含小程序渲染） |
| [Tencent/kbone](https://github.com/Tencent/kbone) | 4,921 | 453 | JavaScript | NOASSERTION | 2025-10-20 | 缓维护 | 腾讯官方的小程序与 Web 同构解决方案：模拟 Web 环境（含 DOM/事件）让 Web 代码跑进小程序 |
| [remaxjs/remax](https://github.com/remaxjs/remax) | 4,552 | 365 | TypeScript | MIT | 2024-03-07 | **ARCHIVED** | 『用真正的 React 运行时构建小程序』框架，思路影响了整个行业 |
| [didi/mpx](https://github.com/didi/mpx) | 3,939 | 393 | JavaScript | Apache-2.0 | 2026-09-24 | 活跃 | 滴滴增强型跨端小程序框架，深度性能优化（渲染/包体）+完整工程化，跨端第二梯队最强者 |
| [eleme/morjs](https://github.com/eleme/morjs) | 2,111 | 130 | TypeScript | MIT | 2025-11-06 | 缓维护 | 蚂蚁集团（饿了么团队）出品的基于编译时增强的多端研发框架，支付宝系官方推荐路线（GitHub 真身 eleme/morjs，ant-inst/alipay 均为误传 404） |
| [weidian-inc/hera](https://github.com/weidian-inc/hera) | 1,501 | 313 | Objective-C | NOASSERTION | 2022-12-07 | 停更(2022-12) | 微店出品的把小程序 API Web 化运行框架 |
| [ant-move/Antmove](https://github.com/ant-move/Antmove) | 1,328 | 152 | JavaScript | - | 2023-11-06 | 停更(2023-11) | 蚂蚁的小程序跨端迁移转换器（微信→支付宝/百度/QQ 等） |
| [tinajs/tina](https://github.com/tinajs/tina) | 1,327 | 128 | JavaScript | Apache-2.0 | 2026-06-10 | 活跃 | 轻量级小程序渐进式框架（类 Vue 语法增强） |
| [ant-design/ant-design-mini](https://github.com/ant-design/ant-design-mini) | 551 | 152 | TypeScript | MIT | 2026-06-01 | 活跃 | 蚂蚁 Ant Design 的小程序组件体系（支付宝小程序向为主，Lottie/跨端） |
| [ecomfe/okam](https://github.com/ecomfe/okam) | 414 | 60 | JavaScript | MIT | 2023-01-08 | 停更(2023-01) | 百度 EFE 出品的小程序一体化开发框架（百度系框架代表，okam 即任务清单里的『Baidu okam』真身） |
| [wechat-miniprogram/glass-easel](https://github.com/wechat-miniprogram/glass-easel) | 332 | 45 | TypeScript | MIT | 2026-09-10 | 活跃 | 微信官方新一代组件框架：小程序组件系统的 TypeScript 实现，是 Skyline 渲染引擎与官方底座演进的基石，官方活跃维护 |
## UI 组件库（14）

| repo | stars | forks | 语言 | license | 最后 push | 状态 | 定位（对工厂价值） |
|---|---:|---:|---|---|---|---|---|
| [Tencent/weui](https://github.com/Tencent/weui) | 27,437 | 6,273 | HTML | NOASSERTION | 2026-03-12 | 活跃 | 微信官方设计语言 WEUI 的原始样式库（weui-wxss 传承者），微信生态视觉规范的事实基线 |
| [youzan/vant-weapp](https://github.com/youzan/vant-weapp) | 18,457 | 3,459 | JavaScript | MIT | 2026-05-09 | 活跃 | 有赞出品的小程序 UI 组件库，组件数量/质量/文档全维度第一梯队，MIT 开源，被海量商业项目验证 |
| [weilanwl/coloruicss](https://github.com/weilanwl/coloruicss) | 12,376 | 2,181 | Vue | MIT | 2024-04-08 | 停更(2024-04) | 高饱和色彩视觉系组件库（纯 CSS 组件+模板，跨 uni-app） |
| [TalkingData/iview-weapp](https://github.com/TalkingData/iview-weapp) | 6,601 | 1,144 | Less | NOASSERTION | 2023-03-01 | 停更(2023-03) | TalkingData 出品的高质量微信小程序 UI 组件库（iView 系） |
| [wux-weapp/wux-weapp](https://github.com/wux-weapp/wux-weapp) | 5,039 | 868 | JavaScript | MIT | 2024-04-25 | 停更(2024-04) | 老牌微信小程序 UI 组件库（skyvow/wux-weapp 是旧地址，现 org 迁移至 wux-weapp） |
| [logamee/lin-ui](https://github.com/logamee/lin-ui) | 4,145 | 473 | JavaScript | MIT | 2023-08-11 | 停更(2023-08) | 简洁/易用/灵活的微信原生小程序组件库（原 TaleLin/lin-ui，repo 已迁移） |
| [dingyong0214/ThorUI-uniapp](https://github.com/dingyong0214/ThorUI-uniapp) | 2,782 | 392 | Vue | MIT | 2024-05-30 | 停更(2024-05) | ThorUI 组件库 uni-app 版（组件+模板，部分收费） |
| [wechat-miniprogram/weui-miniprogram](https://github.com/wechat-miniprogram/weui-miniprogram) | 2,429 | 549 | TypeScript | MIT | 2026-04-28 | 活跃 | 微信官方 WeUI 组件库扩展版（表单/弹层等扩展组件，TS） |
| [Tencent/tdesign-miniprogram](https://github.com/Tencent/tdesign-miniprogram) | 1,771 | 339 | Vue | MIT | 2026-09-23 | 活跃 | 腾讯 TDesign 企业级设计体系的小程序实现（微信+uniapp 双支持） |
| [climblee/uv-ui](https://github.com/climblee/uv-ui) | 1,352 | 69 | Vue | MIT | 2024-07-28 | 停更(2024-07) | uView 生态兼容增强版（基于 uni-app+uView2.x，兼容 vue3/2、多端、单独导入） |
| [dingyong0214/ThorUI](https://github.com/dingyong0214/ThorUI) | 1,154 | 156 | JavaScript | MIT | 2024-05-30 | 停更(2024-05) | ThorUI 微信原生小程序组件库（gh search 定位真身 dingyong0214，非 thorui org） |
| [wechat-miniprogram/kbone-ui](https://github.com/wechat-miniprogram/kbone-ui) | 441 | 41 | Vue | MIT | 2025-07-07 | **ARCHIVED** | 官方 kbone 配套多端组件库（Web 同构向） |
| [FIRST UI](https://www.firstui.cn) | - | - | - | - | - | degraded | 收费商业小程序组件库（非开源）：文档公开、组件源码收费授权，提供 uni-app/原生多版本 |
| [uView (uview-ui)](https://www.uviewui.com) | - | - | - | - | - | degraded | uView 曾是 uni-app 生态最大 UI 库之一；其官方 GitHub 仓（uviewui/uview-ui、umicro/uview-ui 均实测 404）已不可寻，主要经 npm/官网分发，社区由 climblee/uv-ui 继承兼容 |
## 工程化/样式工具链（11）

| repo | stars | forks | 语言 | license | 最后 push | 状态 | 定位（对工厂价值） |
|---|---:|---:|---|---|---|---|---|
| [sonofmagic/weapp-tailwindcss](https://github.com/sonofmagic/weapp-tailwindcss) | 1,864 | 103 | TypeScript | MIT | 2026-09-27 | 活跃 | 把 Tailwind CSS 原子化开发体验带进全端小程序的事实标准方案（作者 icebreaker/sonofmagic），tailwind v3/v4 全支持、esbuild/postcss/webpack/vite 全接入 |
| [wechat-miniprogram/api-typings](https://github.com/wechat-miniprogram/api-typings) | 804 | 117 | TypeScript | MIT | 2026-09-01 | 活跃 | 微信官方小程序 API TypeScript 类型定义 |
| [weapp-vite/weapp-vite](https://github.com/weapp-vite/weapp-vite) | 486 | 30 | TypeScript | MIT | 2026-09-27 | 活跃 | 原生小程序 vite 工程化方案（构建提速/插件机制/TS 支持），与 weapp-tailwindcss 同一作者生态 |
| [MellowCo/unocss-preset-weapp](https://github.com/MellowCo/unocss-preset-weapp) | 456 | 40 | CSS | MIT | 2025-12-20 | 缓维护 | UnoCSS 小程序 preset（weapp 语法兼容） |
| [unocss-applet/unocss-applet](https://github.com/unocss-applet/unocss-applet) | 255 | 13 | CSS | MIT | 2026-09-10 | 活跃 | UnoCSS 在小程序（UniApp/Taro）的语法兼容层 |
| [ruochuan12/mini-ci](https://github.com/ruochuan12/mini-ci) | 220 | 29 | TypeScript | MIT | 2024-08-09 | 停更(2024-08) | miniprogram-ci 的 CLI/npm 包装（上传/预览/构建），源码可读性好的参考实现 |
| [wechat-miniprogram/miniprogram-cli](https://github.com/wechat-miniprogram/miniprogram-cli) | 72 | 41 | JavaScript | MIT | 2026-06-09 | **ARCHIVED** | 微信官方 CLI（项目脚手架等） |
| [wechat-miniprogram/mpflow](https://github.com/wechat-miniprogram/mpflow) | 66 | 14 | TypeScript | MIT | 2026-09-17 | 活跃 | 微信官方小程序工程化 CLI（基于 Vue 生态构建） |
| [echoings/actions.mini-program](https://github.com/echoings/actions.mini-program) | 14 | 10 | TypeScript | MIT | 2021-03-07 | 停更(2021-03) | GitHub Actions 小程序上传/预览 action（marketplace 老牌） |
| [hocgin/action-wechat-miniprogram-upload](https://github.com/hocgin/action-wechat-miniprogram-upload) | 7 | 0 | TypeScript | - | 2022-11-12 | 停更(2022-11) | GitHub Action 上传微信小程序（Go 实现） |
| [miniprogram-ci](https://developers.weixin.qq.com/miniprogram/dev/devtools/ci.html) | - | - | - | - | - | degraded | 微信官方 CI 库：上传/预览/构建 npm/机器人，是小程序自动化发布流水线的核心依赖 |
## 图表/可视化（5）

| repo | stars | forks | 语言 | license | 最后 push | 状态 | 定位（对工厂价值） |
|---|---:|---:|---|---|---|---|---|
| [ecomfe/echarts-for-weixin](https://github.com/ecomfe/echarts-for-weixin) | 7,512 | 1,590 | JavaScript | BSD-3-Clause | 2024-06-09 | 停更(2024-06) | Apache ECharts 官方小程序适配（百度 EFE 维护），功能最强的小程序图表方案 |
| [xiaolin3303/wx-charts](https://github.com/xiaolin3303/wx-charts) | 4,988 | 1,649 | JavaScript | MIT | 2023-10-14 | 停更(2023-10) | 轻量原生微信小程序图表库（canvas） |
| [antvis/wx-f2](https://github.com/antvis/wx-f2) | 1,296 | 183 | JavaScript | MIT | 2021-09-03 | 停更(2021-09) | 蚂蚁 AntV F2 移动端图表的小程序适配 |
| [junbin-yang/uCharts-v3](https://github.com/junbin-yang/uCharts-v3) | 42 | 5 | TypeScript | Apache-2.0 | 2026-02-07 | 活跃 | uCharts v3 的第三方 GitHub 演进/镜像仓 |
| [uCharts](https://gitee.com/uCharts/uCharts) | - | - | - | - | - | degraded | 跨端图表库（canvas 实现，全端小程序+H5）社区强者，官方主仓在 Gitee，GitHub 无官方仓（qiun/ucharts 实测 404） |
## 富文本/Markdown 渲染（5）

| repo | stars | forks | 语言 | license | 最后 push | 状态 | 定位（对工厂价值） |
|---|---:|---:|---|---|---|---|---|
| [icindy/wxParse](https://github.com/icindy/wxParse) | 7,716 | 1,793 | JavaScript | MIT | 2020-03-19 | 停更(2020-03) | 初代小程序富文本解析组件（2016-2018 统治期） |
| [jin-yufeng/mp-html](https://github.com/jin-yufeng/mp-html) | 3,750 | 530 | JavaScript | MIT | 2026-04-19 | 活跃 | 小程序富文本组件事实标准：渲染+编辑 html，多端（微信/QQ/百度/支付宝/头条/uni-app）支持，插件体系完善 |
| [sbfkcel/towxml](https://github.com/sbfkcel/towxml) | 2,898 | 356 | JavaScript | - | 2026-04-14 | 活跃 | 微信小程序 HTML/Markdown 双渲染库（markdown 支持是其长项，含公式/代码高亮） |
| [TooBug/wemark](https://github.com/TooBug/wemark) | 1,312 | 170 | JavaScript | - | 2023-07-05 | 停更(2023-07) | 微信小程序 Markdown 渲染库 |
| [ant-design/x-markdown-mini](https://github.com/ant-design/x-markdown-mini) | 28 | 6 | TypeScript | MIT | 2026-08-31 | 活跃 | 蚂蚁 x 系列的 Markdown 小程序渲染组件，2026-08 新出（28 stars） |
## 状态管理/数据（5）

| repo | stars | forks | 语言 | license | 最后 push | 状态 | 定位（对工厂价值） |
|---|---:|---:|---|---|---|---|---|
| [Tencent/westore](https://github.com/Tencent/westore) | 4,282 | 478 | JavaScript | - | 2026-05-01 | 活跃 | 腾讯出品的小程序 MVVM 分层架构/状态管理（内置 diff 的高性能 store） |
| [wechat-miniprogram/computed](https://github.com/wechat-miniprogram/computed) | 696 | 61 | TypeScript | MIT | 2026-08-24 | 活跃 | 微信官方 computed/watch 扩展（给小程序 Page/Component 加计算属性） |
| [wechat-miniprogram/mobx-miniprogram-bindings](https://github.com/wechat-miniprogram/mobx-miniprogram-bindings) | 249 | 25 | TypeScript | MIT | 2026-09-16 | 活跃 | 微信官方 MobX 绑定辅助库（把 mobx store 接到页面/组件） |
| [wechat-miniprogram/miniprogram-api-promise](https://github.com/wechat-miniprogram/miniprogram-api-promise) | 62 | 14 | JavaScript | - | 2020-01-15 | 停更(2020-01) | 微信官方 wx API promise 化库 |
| [wechat-miniprogram/mobx](https://github.com/wechat-miniprogram/mobx) | 61 | 12 | TypeScript | MIT | 2024-05-15 | 停更(2024-05) | 微信官方维护的 mobx 小程序适配（即 mobx-miniprogram，独立 repo 在此） |
## 实用库（9）

| repo | stars | forks | 语言 | license | 最后 push | 状态 | 定位（对工厂价值） |
|---|---:|---:|---|---|---|---|---|
| [yingye/weapp-qrcode](https://github.com/yingye/weapp-qrcode) | 1,718 | 958 | JavaScript | MIT | 2023-01-04 | 停更(2023-01) | 小程序二维码生成库（canvas，支持 logo/样式） |
| [charleslo1/weapp-cookie](https://github.com/charleslo1/weapp-cookie) | 848 | 96 | JavaScript | MIT | 2026-09-25 | 活跃 | 小程序 cookie 支持库（自动处理 set-cookie/携带），让服务端会话体系无缝接入 |
| [wechat-miniprogram/threejs-miniprogram](https://github.com/wechat-miniprogram/threejs-miniprogram) | 799 | 238 | JavaScript | MIT | 2023-05-22 | 停更(2023-05) | 微信官方 three.js 适配（3D/WebGL） |
| [wechat-miniprogram/recycle-view](https://github.com/wechat-miniprogram/recycle-view) | 641 | 75 | JavaScript | MIT | 2023-09-11 | 停更(2023-09) | 微信官方长列表回收渲染组件（recycle-view） |
| [wechat-miniprogram/miniprogram-simulate](https://github.com/wechat-miniprogram/miniprogram-simulate) | 536 | 64 | JavaScript | MIT | 2026-06-30 | 活跃 | 微信官方自定义组件单元测试工具集 |
| [wechat-miniprogram/sm-crypto](https://github.com/wechat-miniprogram/sm-crypto) | 481 | 92 | JavaScript | MIT | 2026-06-25 | **ARCHIVED** | 微信官方国密库（sm2/sm3/sm4） |
| [wechat-miniprogram/lottie-miniprogram](https://github.com/wechat-miniprogram/lottie-miniprogram) | 432 | 52 | JavaScript | MIT | 2024-05-07 | 停更(2024-05) | 微信官方 lottie 动画支持 |
| [wechat-miniprogram/miniprogram-compat](https://github.com/wechat-miniprogram/miniprogram-compat) | 105 | 3 | JavaScript | - | 2025-12-25 | 缓维护 | 微信官方基础库兼容层（低版本基础库 polyfill） |
| [miniprogram-automator](https://developers.weixin.qq.com/miniprogram/dev/devtools/auto/) | - | - | - | - | - | degraded | 微信官方自动化测试库（通过开发者工具驱动小程序做 E2E：页面跳转/元素操作/截图） |
## 模板/脚手架（9）

| repo | stars | forks | 语言 | license | 最后 push | 状态 | 定位（对工厂价值） |
|---|---:|---:|---|---|---|---|---|
| [wechat-miniprogram/miniprogram-demo](https://github.com/wechat-miniprogram/miniprogram-demo) | 7,243 | 2,208 | JavaScript | MIT | 2026-09-11 | 活跃 | 微信官方小程序组件与 API 示例全集（每个能力一段可跑代码） |
| [Tencent/tdesign-miniprogram-starter-retail](https://github.com/Tencent/tdesign-miniprogram-starter-retail) | 860 | 211 | JavaScript | MIT | 2026-09-01 | 活跃 | TDesign 零售行业小程序起手模板（组件+页面骨架） |
| [finalvip/weapp_template](https://github.com/finalvip/weapp_template) | 784 | 218 | JavaScript | - | 2018-08-21 | 停更(2018-08) | 老牌通用小程序模板 |
| [viarotel-org/vite-uniapp-template](https://github.com/viarotel-org/vite-uniapp-template) | 589 | 111 | JavaScript | MIT | 2026-02-27 | 活跃 | vite+uniapp+ts+unocss 现代化模板 |
| [lexmin0412/taro3-react-template](https://github.com/lexmin0412/taro3-react-template) | 128 | 37 | TypeScript | - | 2025-03-21 | 缓维护 | taro3+react18+ts 模板 |
| [xlzy520/uniapp-tailwind-uview-starter](https://github.com/xlzy520/uniapp-tailwind-uview-starter) | 110 | 37 | JavaScript | - | 2025-09-17 | 缓维护 | uniapp+tailwindcss+uview 起手式 |
| [lencx/create-mpl](https://github.com/lencx/create-mpl) | 59 | 14 | TypeScript | MIT | 2022-11-25 | 停更(2022-11) | 小程序项目脚手架 CLI（npm create） |
| [NewFuture/miniprogram-template](https://github.com/NewFuture/miniprogram-template) | 48 | 14 | TypeScript | MIT | 2021-09-27 | **ARCHIVED** | TS+gulp 小程序模板（已归档） |
| [icebreaker-template/native-weapp-tailwindcss-template](https://github.com/icebreaker-template/native-weapp-tailwindcss-template) | 5 | 0 | SCSS | - | 2025-08-19 | **ARCHIVED** | 原生小程序+tailwind 模板（已归档，作者精力转向 weapp-tailwindcss 主库） |
## 官方新基建/AI（4）

| repo | stars | forks | 语言 | license | 最后 push | 状态 | 定位（对工厂价值） |
|---|---:|---:|---|---|---|---|---|
| [wechat-miniprogram/ai-mode-demo](https://github.com/wechat-miniprogram/ai-mode-demo) | 296 | 55 | JavaScript | MIT | 2026-07-03 | 活跃 | 微信官方 AI 模式示例工程 |
| [wechat-miniprogram/ai-mode-skills](https://github.com/wechat-miniprogram/ai-mode-skills) | 203 | 11 | JavaScript | MIT | 2026-09-10 | 活跃 | 微信官方 AI 模式技能集（2026 新：AI 辅助小程序开发能力包） |
| [wechat-miniprogram/awesome-skyline](https://github.com/wechat-miniprogram/awesome-skyline) | 198 | 52 | - | MIT | 2025-10-22 | 缓维护 | 官方 Skyline 渲染引擎资源合集（新一代渲染引擎迁移指南） |
| [wechat-miniprogram/miniprogram-slim](https://github.com/wechat-miniprogram/miniprogram-slim) | 129 | 12 | JavaScript | MIT | 2022-12-11 | **ARCHIVED** | 微信官方包体瘦身工具（依赖分析/裁剪） |

## 工厂零件推荐位（每类第一名及理由）

| 类目 | 推荐件 | 实测 stars | 理由 |
|---|---|---:|---|
| 跨端框架 | dcloudio/uni-app（React 栈备选 NervJS/taro） | 41617 / 37702 | 两强都活跃；uni-app 生态+人才池最大、taro 是 React/TS 正统。工厂走 Vue 选 uni-app，走 React 选 taro，二选一不要混。 |
| UI 组件库 | youzan/vant-weapp | 18457 | MIT 商业级、组件全、文档好，微信原生向第一；官方系备选 tdesign-miniprogram（1771，2026-09 高频发版，长期主义）。 |
| 工程化/样式 | sonofmagic/weapp-tailwindcss | 1864 | 抓取当天仍在发版，tailwind v3/v4 全端支持；配合作者同生态 weapp-vite（486）构成原生小程序现代工程底座。 |
| 图表/可视化 | ecomfe/echarts-for-weixin | 7512 | ECharts 全功能官方适配，研报图表（K线/地图/大数据量）一步到位；适配层 2024 后未推但稳定。 |
| 富文本/Markdown | jin-yufeng/mp-html | 3750 | 富文本渲染事实标准（多端+编辑+插件），研报阅读试点 HTML 基座；Markdown 直渲染补 sbfkcel/towxml（2898）。 |
| 状态管理 | wechat-miniprogram/mobx-miniprogram-bindings | 249 | 官方维护、2026-09 活跃；轻量场景直接用官方 computed（696）。westore（4282）stars 更高但节奏一般。 |
| 实用库 | charleslo1/weapp-cookie + wechat-miniprogram/miniprogram-simulate | 848 / 536 | cookie 库是唯一 2026 仍活跃的高星 util（对接 Web 会话刚需）；simulate 是官方组件单测件（2026-06 活跃）。sm-crypto（481）已封存式归档，可用但须自担维护。 |
| 模板/脚手架 | wechat-miniprogram/miniprogram-demo | 7243 | 官方组件/API 示例全集=代码生成 few-shot 语料库；行业起手式参考 tdesign-starter-retail（860，活跃）。 |
| 发布流水线 | miniprogram-ci（npm，官方） | - | 上传/预览唯一正门，npm-only 无 GitHub 仓；GH Actions 现成 action 全停更（echoings 2021/hocgin 2022），自写 20 行脚本最稳。 |

## 坑清单（archived / 停更 / 404）

**已归档（archived=true，禁入新项目）**：

- Tencent/wepy
- didi/chameleon
- remaxjs/remax
- wechat-miniprogram/kbone-ui
- wechat-miniprogram/miniprogram-cli
- wechat-miniprogram/sm-crypto
- NewFuture/miniprogram-template
- icebreaker-template/native-weapp-tailwindcss-template
- wechat-miniprogram/miniprogram-slim

**停更（最后 push 早于 2025 年，共 28 个）**：

- Meituan-Dianping/mpvue
- alibaba/rax
- weidian-inc/hera
- ant-move/Antmove
- ecomfe/okam
- weilanwl/coloruicss
- TalkingData/iview-weapp
- wux-weapp/wux-weapp
- logamee/lin-ui
- dingyong0214/ThorUI-uniapp
- climblee/uv-ui
- dingyong0214/ThorUI
- ruochuan12/mini-ci
- echoings/actions.mini-program
- hocgin/action-wechat-miniprogram-upload
- ecomfe/echarts-for-weixin
- xiaolin3303/wx-charts
- antvis/wx-f2
- icindy/wxParse
- TooBug/wemark
- wechat-miniprogram/miniprogram-api-promise
- wechat-miniprogram/mobx
- yingye/weapp-qrcode
- wechat-miniprogram/threejs-miniprogram
- wechat-miniprogram/recycle-view
- wechat-miniprogram/lottie-miniprogram
- finalvip/weapp_template
- lencx/create-mpl

**实测 404（跳过，真身已记录）**：

- qiun/ucharts (真身：gitee.com/uCharts，GitHub 无官方仓)
- ant-inst/morjs + alipay/morjs (真身：eleme/morjs)
- uviewui/uview-ui + umicro/uview-ui (官方 GitHub 仓已不存在)
- wechat-miniprogram/miniprogram-ci (官方 npm-only，无 GitHub 源码仓)
- wechat-miniprogram/miniprogram-ts-template (官方 TS 支撑件是 api-typings；TS 模板内建于开发者工具)
- wechat-miniprogram/miniprogram-automator (官方 npm-only)
- skyvow/wux-weapp (org 迁移：wux-weapp/wux-weapp)
- skyvow/weapp-gulp (已不存在，gulp 时代方案消亡)
- wangyupo/weapp-qrcode (真身：yingye/weapp-qrcode)
- charliegao/weapp-cookie (真身：charleslo1/weapp-cookie)
- jview666/jview-ui (jview 未找到有效开源仓)
- wendao/flyio (flyio 项目消亡，小程序场景由 wx.request 取代)
- wechat-miniprogram/mobx-miniprogram (真身 repo 名：wechat-miniprogram/mobx)

**关键生态事实**：

- UI 库半壁江山已停更（iview/wux/lin-ui/ColorUI/ThorUI 均 2023-2024 停），活跃的只剩 vant-weapp、tdesign、weui 系——工厂选型必须落在活跃件上。
- 富文本老方案 wxParse（7716 stars）2020 年即死，历史 stars 与可用性严重背离，选型只看 mp-html/towxml。
- GitHub Actions 小程序发布 action 无一存活（最高 14 stars 且 2021 停），发布环节必须自研薄脚本包 miniprogram-ci。
- 官方大量关键件（miniprogram-ci/miniprogram-automator）npm-only 无 GitHub 仓，CLI 包装层是社区唯一开源样例（ruochuan12/mini-ci，已停）。
- 微信 2026 新推 AI 模式（ai-mode-skills/ai-mode-demo）与 glass-easel/Skyline 底座演进，是官方 AI 编程与新一代渲染两大方向信号，工厂设计时应预留对接位。
