# -*- coding: utf-8 -*-
"""fw-ui catalog: curated inclusion list with Chinese descriptions.
Hard numbers (stars/forks/pushed_at) come from gh api raw files, NOT from this file."""

CATALOG = {
    # ============ A. 跨端框架 ============
    "dcloudio/uni-app": ("framework", "Vue 语法跨端开发框架，一套代码编译到微信/支付宝/百度小程序+H5+App，国内跨端生态两强之一。DCloud 官方持续高频维护（本周仍在发版），配套 HBuilderX 工具链与海量插件市场。对工厂：人才池和组件生态最大，跨端需求默认起点；代价是深度原生定制受编译层约束。"),
    "NervJS/taro": ("framework", "京东开源的开放跨端跨框架解决方案，支持 React/Vue 语法编译到全平台小程序/H5/RN，与 uni-app 并列国内两强。2026-09 仍高频发版（4.x），CLI+插件体系成熟。对工厂：React/TS 技术栈首选，流水线集成友好。"),
    "Tencent/wepy": ("framework", "腾讯最早的组件化小程序框架（Vue 风格语法），历史地位重要但已明确退役。官方 repo 已归档（archived=true），不再演进。对工厂：仅作存量项目兼容参考，新项目禁入。"),
    "Meituan-Dianping/mpvue": ("framework", "美团点评出品的 Vue.js 小程序框架，2018 年现象级项目。2022-03 起停更，生态已迁移至 uni-app/taro。对工厂：仅作历史研究，禁入。"),
    "didi/chameleon": ("framework", "滴滴多端统一框架，主打『一端所见即多端所见』。已归档停维护。对工厂：出局，仅记录历史位。"),
    "alibaba/rax": ("framework", "阿里渐进式跨端框架，曾支撑大量阿里系应用（含小程序渲染）。2023-03 起无实质提交，团队精力转向 morjs。对工厂：出局，阿里系改看 eleme/morjs。"),
    "Tencent/omi": ("framework", "腾讯通用 Web Components 框架（omi），附带 omix 小程序状态管理扩展，主战场是 Web 而非小程序。仍在活跃维护。对工厂：小程序场景非主力，作能力备选记录。"),
    "Tencent/kbone": ("framework", "腾讯官方的小程序与 Web 同构解决方案：模拟 Web 环境（含 DOM/事件）让 Web 代码跑进小程序。2025-10 仍有维护节奏。对工厂：已有 Web 版研报站向小程序低成本搬运的桥梁，存量复用场景可评估。"),
    "remaxjs/remax": ("framework", "『用真正的 React 运行时构建小程序』框架，思路影响了整个行业。已归档（2024-03 停更）。对工厂：出局，React 向需求已被 Taro 覆盖。"),
    "didi/mpx": ("framework", "滴滴增强型跨端小程序框架，深度性能优化（渲染/包体）+完整工程化，跨端第二梯队最强者。2026-09 仍活跃发版。对工厂：对性能敏感的跨端项目备选，文档质量高。"),
    "eleme/morjs": ("framework", "蚂蚁集团（饿了么团队）出品的基于编译时增强的多端研发框架，支付宝系官方推荐路线（GitHub 真身 eleme/morjs，ant-inst/alipay 均为误传 404）。2025-11 有提交。对工厂：若要微信+支付宝双端发布，这是阿里系正规军。"),
    "weidian-inc/hera": ("framework", "微店出品的把小程序 API Web 化运行框架。2022 年停更。对工厂：出局，历史位。"),
    "ant-move/Antmove": ("framework", "蚂蚁的小程序跨端迁移转换器（微信→支付宝/百度/QQ 等）。2023-11 停更。对工厂：一次性存量迁移场景的工具记录。"),
    "tinajs/tina": ("framework", "轻量级小程序渐进式框架（类 Vue 语法增强）。社区小但 2026-06 仍有动静。对工厂：小众备选记录。"),
    "ecomfe/okam": ("framework", "百度 EFE 出品的小程序一体化开发框架（百度系框架代表，okam 即任务清单里的『Baidu okam』真身）。2023-01 停更。对工厂：出局，历史位。"),
    "wechat-miniprogram/glass-easel": ("framework", "微信官方新一代组件框架：小程序组件系统的 TypeScript 实现，是 Skyline 渲染引擎与官方底座演进的基石，官方活跃维护。对工厂：官方技术风向标（可独立用于 web/测试环境渲染小程序组件），工厂需跟踪但一般不直接依赖。"),
    "ant-design/ant-design-mini": ("framework", "蚂蚁 Ant Design 的小程序组件体系（支付宝小程序向为主，Lottie/跨端）。2026-06 仍维护。对工厂：支付宝端 UI/组件备选。"),

    # ============ B. UI 组件库 ============
    "Tencent/weui": ("ui", "微信官方设计语言 WEUI 的原始样式库（weui-wxss 传承者），微信生态视觉规范的事实基线。2026-03 仍更新。对工厂：任何自研视觉皮肤从这起步，跟官方审美对齐零成本。"),
    "youzan/vant-weapp": ("ui", "有赞出品的小程序 UI 组件库，组件数量/质量/文档全维度第一梯队，MIT 开源，被海量商业项目验证。2026-05 发版。对工厂：微信原生小程序 UI 的默认选择，与 TDesign 构成双强。"),
    "weilanwl/coloruicss": ("ui", "高饱和色彩视觉系组件库（纯 CSS 组件+模板，跨 uni-app）。2024-04 停更但 CSS 素材可直接复用。对工厂：定位视觉素材库而非工程组件，做皮肤参考。"),
    "TalkingData/iview-weapp": ("ui", "TalkingData 出品的高质量微信小程序 UI 组件库（iView 系）。2023-03 停更。对工厂：遗留系统兼容，新项目让位 vant/tdesign。"),
    "wux-weapp/wux-weapp": ("ui", "老牌微信小程序 UI 组件库（skyvow/wux-weapp 是旧地址，现 org 迁移至 wux-weapp）。2024-04 停更。对工厂：出局记录。"),
    "logamee/lin-ui": ("ui", "简洁/易用/灵活的微信原生小程序组件库（原 TaleLin/lin-ui，repo 已迁移）。2023-08 停更。对工厂：口碑好但维护断档，备选记录。"),
    "wechat-miniprogram/weui-miniprogram": ("ui", "微信官方 WeUI 组件库扩展版（表单/弹层等扩展组件，TS）。官方 2026-04 更新。对工厂：官方向保底组件库，与 WeUI 样式配套。"),
    "Tencent/tdesign-miniprogram": ("ui", "腾讯 TDesign 企业级设计体系的小程序实现（微信+uniapp 双支持）。2026-09 高频发版，腾讯内部产品线在用。对工厂：现代官方系首选，长期主义选择，与 vant 二选一。"),
    "dingyong0214/ThorUI-uniapp": ("ui", "ThorUI 组件库 uni-app 版（组件+模板，部分收费）。2024-05 停更。对工厂：历史参考。"),
    "dingyong0214/ThorUI": ("ui", "ThorUI 微信原生小程序组件库（gh search 定位真身 dingyong0214，非 thorui org）。2024-05 停更。对工厂：历史参考，商业模板思路可借鉴。"),
    "climblee/uv-ui": ("ui", "uView 生态兼容增强版（基于 uni-app+uView2.x，兼容 vue3/2、多端、单独导入）。2024-07 后无 push。对工厂：uni-app 路线的组件备选。"),
    "wechat-miniprogram/kbone-ui": ("ui", "官方 kbone 配套多端组件库（Web 同构向）。repo 已归档（archived=true）。对工厂：kbone 路线配套件，仅存量参考。"),

    # ============ C. 工程化/样式工具链 ============
    "sonofmagic/weapp-tailwindcss": ("tooling", "把 Tailwind CSS 原子化开发体验带进全端小程序的事实标准方案（作者 icebreaker/sonofmagic），tailwind v3/v4 全支持、esbuild/postcss/webpack/vite 全接入。2026-09-27 抓取当天仍在发版。对工厂：样式工程核心件首选。"),
    "wechat-miniprogram/api-typings": ("tooling", "微信官方小程序 API TypeScript 类型定义。2026-09 活跃。对工厂：TS 全流程工厂的必备底座。"),
    "weapp-vite/weapp-vite": ("tooling", "原生小程序 vite 工程化方案（构建提速/插件机制/TS 支持），与 weapp-tailwindcss 同一作者生态。2026-09-27 当天有 push。对工厂：原生小程序路线的构建核心候选。"),
    "MellowCo/unocss-preset-weapp": ("tooling", "UnoCSS 小程序 preset（weapp 语法兼容）。2025-12。对工厂：UnoCSS 路线样式件。"),
    "unocss-applet/unocss-applet": ("tooling", "UnoCSS 在小程序（UniApp/Taro）的语法兼容层。2026-09。对工厂：跨端框架走 UnoCSS 时的配套。"),
    "ruochuan12/mini-ci": ("tooling", "miniprogram-ci 的 CLI/npm 包装（上传/预览/构建），源码可读性好的参考实现。2024-08 停更。对工厂：自研发布脚本的最短路径样例。"),
    "wechat-miniprogram/mpflow": ("tooling", "微信官方小程序工程化 CLI（基于 Vue 生态构建）。2026-09 活跃。对工厂：官方工程化方向信号，值得跟踪。"),
    "wechat-miniprogram/miniprogram-cli": ("tooling", "微信官方 CLI（项目脚手架等）。repo 已归档（archived=true，官方脚手架位由开发者工具+api-typings 接棒）。对工厂：参考其脚手架实现即可，勿直接依赖。"),
    "echoings/actions.mini-program": ("tooling", "GitHub Actions 小程序上传/预览 action（marketplace 老牌）。2021-03 停更。对工厂：不建议依赖，直接用 miniprogram-ci 自写 action 更稳。"),
    "hocgin/action-wechat-miniprogram-upload": ("tooling", "GitHub Action 上传微信小程序（Go 实现）。2022-11 停更。对工厂：同上，参考实现。"),

    # ============ D. 图表/可视化 ============
    "ecomfe/echarts-for-weixin": ("charts", "Apache ECharts 官方小程序适配（百度 EFE 维护），功能最强的小程序图表方案。适配层 2024-06 后未再 push，但 ECharts 本体持续演进、适配面稳定。对工厂：研报图表默认选择（K线/地图/大数据量全覆盖）。"),
    "xiaolin3303/wx-charts": ("charts", "轻量原生微信小程序图表库（canvas）。2023-10 停更。对工厂：轻量场景备选，功能远弱于 echarts。"),
    "antvis/wx-f2": ("charts", "蚂蚁 AntV F2 移动端图表的小程序适配。2021-09 停更。对工厂：AntV 体系备选记录。"),
    "junbin-yang/uCharts-v3": ("charts", "uCharts v3 的第三方 GitHub 演进/镜像仓。42 stars 2026-02。对工厂：uCharts v3 源码在 GitHub 的可获取位。"),

    # ============ E. 富文本/Markdown 渲染 ============
    "icindy/wxParse": ("richtext", "初代小程序富文本解析组件（2016-2018 统治期）。2020 年起死。对工厂：禁入，已被 mp-html 全面取代，仅历史研究价值。"),
    "jin-yufeng/mp-html": ("richtext", "小程序富文本组件事实标准：渲染+编辑 html，多端（微信/QQ/百度/支付宝/头条/uni-app）支持，插件体系完善。2026-04 仍在修复。对工厂：研报阅读试点的 HTML 渲染基座首选。"),
    "sbfkcel/towxml": ("richtext", "微信小程序 HTML/Markdown 双渲染库（markdown 支持是其长项，含公式/代码高亮）。2026-04。对工厂：Markdown 直渲染研报的第一候选。"),
    "TooBug/wemark": ("richtext", "微信小程序 Markdown 渲染库。2023-07 停更。对工厂：被 towxml/mp-html 覆盖，历史位。"),
    "ant-design/x-markdown-mini": ("richtext", "蚂蚁 x 系列的 Markdown 小程序渲染组件，2026-08 新出（28 stars）。对工厂：观察位，蚂蚁系新动作信号。"),

    # ============ F. 状态管理/数据 ============
    "Tencent/westore": ("state", "腾讯出品的小程序 MVVM 分层架构/状态管理（内置 diff 的高性能 store）。2026-05 有 push。对工厂：原生路线重量级状态方案。"),
    "wechat-miniprogram/computed": ("state", "微信官方 computed/watch 扩展（给小程序 Page/Component 加计算属性）。2026-08 活跃。对工厂：官方轻量响应式增强，默认件。"),
    "wechat-miniprogram/mobx-miniprogram-bindings": ("state", "微信官方 MobX 绑定辅助库（把 mobx store 接到页面/组件）。2026-09-16 活跃。对工厂：中型以上应用的官方推荐状态方案。"),
    "wechat-miniprogram/mobx": ("state", "微信官方维护的 mobx 小程序适配（即 mobx-miniprogram，独立 repo 在此）。2024-05。对工厂：与 bindings 配套。"),
    "wechat-miniprogram/miniprogram-api-promise": ("state", "微信官方 wx API promise 化库。2020 后未更新但面小而稳。对工厂：async/await 工厂的小配件（也可自写 10 行）。"),

    # ============ G. 实用库 ============
    "yingye/weapp-qrcode": ("util", "小程序二维码生成库（canvas，支持 logo/样式）。2023-01 停更但功能成熟。对工厂：分享裂变场景现成件。"),
    "wechat-miniprogram/recycle-view": ("util", "微信官方长列表回收渲染组件（recycle-view）。2023-09（稳定）。对工厂：长feed流性能刚需件。"),
    "wechat-miniprogram/miniprogram-simulate": ("util", "微信官方自定义组件单元测试工具集。2026-06 活跃。对工厂：组件级自动化测试的官方位。"),
    "wechat-miniprogram/sm-crypto": ("util", "微信官方国密库（sm2/sm3/sm4）。官方 repo 已归档（archived=true，功能稳定后的封存式归档，npm 仍可用）。对工厂：合规加密（签名/脱敏）现成件，引入前自担长期维护。"),
    "wechat-miniprogram/lottie-miniprogram": ("util", "微信官方 lottie 动画支持。2024-05。对工厂：动效件。"),
    "wechat-miniprogram/threejs-miniprogram": ("util", "微信官方 three.js 适配（3D/WebGL）。2023-05。对工厂：3D 展示场景件。"),
    "charleslo1/weapp-cookie": ("util", "小程序 cookie 支持库（自动处理 set-cookie/携带），让服务端会话体系无缝接入。848 stars 且 2026-09-25 仍在维护（charliegao 地址已失效，真身 charleslo1）。对工厂：与已有 Web 后端会话体系对接的关键配件。"),
    "wechat-miniprogram/miniprogram-compat": ("util", "微信官方基础库兼容层（低版本基础库 polyfill）。2025-12。对工厂：老机型覆盖保底。"),

    # ============ H. 模板/脚手架 ============
    "wechat-miniprogram/miniprogram-demo": ("template", "微信官方小程序组件与 API 示例全集（每个能力一段可跑代码）。7243 stars，2026-09 活跃。对工厂：组件用法速查手册+AI 代码生成的 few-shot 语料库。"),
    "Tencent/tdesign-miniprogram-starter-retail": ("template", "TDesign 零售行业小程序起手模板（组件+页面骨架）。860 stars 2026-09 活跃。对工厂：行业模板范本，工厂『起手式』的直接参考。"),
    "finalvip/weapp_template": ("template", "老牌通用小程序模板。784 stars 但 2018 年后未更新。对工厂：仅历史参考。"),
    "viarotel-org/vite-uniapp-template": ("template", "vite+uniapp+ts+unocss 现代化模板。589 stars 2026-02。对工厂：uni-app 现代工程起手参考。"),
    "xlzy520/uniapp-tailwind-uview-starter": ("template", "uniapp+tailwindcss+uview 起手式。110 stars 2025-09。对工厂：组合验证样例。"),
    "lexmin0412/taro3-react-template": ("template", "taro3+react18+ts 模板。128 stars 2025-03。对工厂：taro 路线起手参考。"),
    "lencx/create-mpl": ("template", "小程序项目脚手架 CLI（npm create）。59 stars 2022 停。对工厂：脚手架思路参考。"),
    "NewFuture/miniprogram-template": ("template", "TS+gulp 小程序模板（已归档）。对工厂：历史参考。"),
    "icebreaker-template/native-weapp-tailwindcss-template": ("template", "原生小程序+tailwind 模板（已归档，作者精力转向 weapp-tailwindcss 主库）。对工厂：主库文档里的最新模板更值得跟。"),

    # ============ I. 官方新基建/AI ============
    "wechat-miniprogram/ai-mode-skills": ("official_ai", "微信官方 AI 模式技能集（2026 新：AI 辅助小程序开发能力包）。203 stars 2026-09。对工厂：官方 AI 编程接口位——工厂的 AI 生成代码可对接此通道分发。"),
    "wechat-miniprogram/ai-mode-demo": ("official_ai", "微信官方 AI 模式示例工程。296 stars 2026-07。对工厂：AI 模式用法样例。"),
    "wechat-miniprogram/awesome-skyline": ("official_ai", "官方 Skyline 渲染引擎资源合集（新一代渲染引擎迁移指南）。198 stars 2025-10。对工厂：性能升级路线跟踪位。"),
    "wechat-miniprogram/miniprogram-slim": ("official_ai", "微信官方包体瘦身工具（依赖分析/裁剪）。129 stars 2022-12 停。对工厂：过包体限制时的现成工具。"),
}

# degraded 条目：GitHub 无官方 repo / 收费产品，产品形态记录
DEGRADED = {
    "uCharts": ("charts", "https://gitee.com/uCharts/uCharts",
        "跨端图表库（canvas 实现，全端小程序+H5）社区强者，官方主仓在 Gitee，GitHub 无官方仓（qiun/ucharts 实测 404）。npm @qiun/ucharts 分发，GitHub 上仅第三方演进仓 junbin-yang/uCharts-v3（42 stars）。对工厂：uni-app 路线主力图表；原生路线用 echarts-for-weixin。",
        "GitHub 官方仓 404，主仓在 gitee.com/uCharts"),
    "FIRST UI": ("ui", "https://www.firstui.cn",
        "收费商业小程序组件库（非开源）：文档公开、组件源码收费授权，提供 uni-app/原生多版本。对工厂：预算允许的商业加速器选项，无开源可审计，生态依赖单点。",
        "收费商业产品，无开源 repo 可清点"),
    "miniprogram-ci": ("tooling", "https://developers.weixin.qq.com/miniprogram/dev/devtools/ci.html",
        "微信官方 CI 库：上传/预览/构建 npm/机器人，是小程序自动化发布流水线的核心依赖。仅 npm 分发（miniprogram-ci），GitHub 无源码仓（wechat-miniprogram/miniprogram-ci 实测 404），社区包装层见 ruochuan12/mini-ci。对工厂：发布环节的官方唯一正门。",
        "官方 npm-only，GitHub 无公开源码仓"),
    "uView (uview-ui)": ("ui", "https://www.uviewui.com",
        "uView 曾是 uni-app 生态最大 UI 库之一；其官方 GitHub 仓（uviewui/uview-ui、umicro/uview-ui 均实测 404）已不可寻，主要经 npm/官网分发，社区由 climblee/uv-ui 继承兼容。对工厂：直接选 uv-ui 或 vant 系，避免依赖悬空仓。",
        "官方 GitHub 仓 404，生态由 uv-ui 继承"),
    "miniprogram-automator": ("util", "https://developers.weixin.qq.com/miniprogram/dev/devtools/auto/",
        "微信官方自动化测试库（通过开发者工具驱动小程序做 E2E：页面跳转/元素操作/截图）。GitHub 无公开仓（wechat-miniprogram/miniprogram-automator 实测 404），npm 分发。对工厂：E2E 环节官方正门，配合 miniprogram-simulate 组成双层测试。",
        "官方 npm-only，GitHub 无公开仓"),
}

NOT_FOUND_404 = [
    "qiun/ucharts (真身：gitee.com/uCharts，GitHub 无官方仓)",
    "ant-inst/morjs + alipay/morjs (真身：eleme/morjs)",
    "uviewui/uview-ui + umicro/uview-ui (官方 GitHub 仓已不存在)",
    "wechat-miniprogram/miniprogram-ci (官方 npm-only，无 GitHub 源码仓)",
    "wechat-miniprogram/miniprogram-ts-template (官方 TS 支撑件是 api-typings；TS 模板内建于开发者工具)",
    "wechat-miniprogram/miniprogram-automator (官方 npm-only)",
    "skyvow/wux-weapp (org 迁移：wux-weapp/wux-weapp)",
    "skyvow/weapp-gulp (已不存在，gulp 时代方案消亡)",
    "wangyupo/weapp-qrcode (真身：yingye/weapp-qrcode)",
    "charliegao/weapp-cookie (真身：charleslo1/weapp-cookie)",
    "jview666/jview-ui (jview 未找到有效开源仓)",
    "wendao/flyio (flyio 项目消亡，小程序场景由 wx.request 取代)",
    "wechat-miniprogram/mobx-miniprogram (真身 repo 名：wechat-miniprogram/mobx)",
]
