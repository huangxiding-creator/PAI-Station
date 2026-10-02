# GitHub 开源库调研：渲染 / 视觉 / 分享增强（总包AI顾问）

- 调研日期：2026-09-29
- 调研渠道：WebSearch（免费）+ GitHub API（星数/许可证/维护状态逐仓库实测）+ webReader 抓 README
- 背景：现有自研零依赖 md2blocks.js（199 行 JS + 174 行 WXSS，块数组直接 wx:for，藏青/橙蓝图视觉体系，后端导出 Word/PDF/MD），主包约 1MB（2MB 主包墙约束下余量有限）。

## 渠道结论

1. **渲染层：保留自研 md2blocks，不换 towxml。** towxml（2.9k 星，活跃）生态最全（Markdown/HTML/ECharts/LaTeX/yUML），但三笔账都亏：①体积账——dist 全量数百 KB，主包 1MB/2MB 墙下吃掉 1/4 余量（echarts/latex/yuml 模块可裁剪但仍是重件）；②视觉账——towxml 自带整套 WXSS 样式体系，与我们"块级全自定义排版"的品牌化答案卡定位正面冲突（Gitter 用它渲染 README 很美，那是通用文档场景，不是品牌卡片场景）；③链路账——后端导出链与块结构解耦于同一套解析，换渲染层会打断。唯一保留的期权：工程公式高频出现时按需拷贝其 latex 模块（MIT）。
2. **海报分享（最高价值项）：采纳 Painter 的 JSON→Canvas 模型，落地走"手绘 Canvas 2D + 后端小程序码"。** Painter（4.5k 星，Apache-2.0）原生支持 text/image/rect/**qrcode** 四类元素、渐变/圆角/阴影、LRU 图片缓存、绘图出错自动重绘——模型设计优秀；但库本体 2024-03 起停更、canvas2d 支持仍标"测试态"，直接依赖有长期风险。推荐路径：借鉴其 JSON Palette 思想，用官方 Canvas 2D 接口手绘单张固定版式答案卡（约 200-300 行）；若求快可直接引入 Painter 先验证增长假设。
3. **二维码最佳实践：分享卡上的码用后端 `wxacode.getUnlimited`（小程序码），不用前端 weapp-qrcode 生成普通 QR。** 小程序码 scene 参数可携带分享者 ID 做增长归因，扫码直达小程序；普通二维码扫码走网页跳转链路、无法带参归因。weapp-qrcode 仅在"活码/外部链接"场景备选。
4. **骨架屏：零依赖方案胜出，不引库。** 微信开发者工具自带"骨架屏"一键生成（产出 .skeleton.wxml/.wxss 按页面定制）；再配 ~20 行 CSS shimmer 渐变动画即可与藏青/橙品牌统一。jayZOU/skeleton（546 星）2020 年起停更，Vant/TDesign 的 Skeleton 组件为此引入整套库不值。
5. **组件库：Vant Weapp（18.5k 星）与 TDesign（腾讯官方，维护最活跃，当天仍有提交）都整体 SKIP。** 全自定义视觉体系下换库成本 > 收益，且样式覆盖成本高；仅 Toast/Popup 等无品牌价值的基础件可 cherry-pick，若真要选优先 TDesign（设计 token 更现代、活跃度更高）。
6. **动画：lottie-miniprogram（官方，432 星）SKIP。** canvas 实现有性能瓶颈，多实例同屏会崩、不支持 eval/new Function；我们现有 CSS 动画足够，等待态用骨架屏+呼吸动画替代。
7. **数学公式（工程公式场景）：当前不投入。** katex-mini（135 星）无 LICENSE 文件 = 法律风险，直接排除；若公式频率上升，优先后端 KaTeX 渲染成图片/SVG 下发（后端零成本复用，前端零依赖），其次 towxml latex 模块按需拷贝。
8. **视觉灵感：抄技法不抄风格。** Gitter（3.7k 星，"颜值最高的 GitHub 小程序"）看 dark mode 与 markdown 排版层次；ColorUI（12.4k 星，纯视觉库）看渐变/阴影/高饱和点缀技法——均只做参考，蓝图视觉体系（藏青/橙）不变。

## 库清单

| # | 库 | 地址 | 星数 | 许可证 | 维护状态 | 一句话定位 | 接入成本（全自定义视觉 app） | 结论 |
|---|---|---|---|---|---|---|---|---|
| 1 | Painter | https://github.com/manycore-maas/Painter | 4,477 | Apache-2.0 | 停更（末次 push 2024-03） | JSON 配置→Canvas 生成朋友圈图，"像写 CSS 一样画图" | 低-中：组件形式引入，自带 Painter/Pen/Palette 架构；qrcode/text/image/rect、渐变、圆角、阴影、LRU 图片缓存、出错重绘全都有 | **ADAPT**（采纳 JSON 布局模型；库本体可直引快速验证，长期建议手绘） |
| 2 | wxa-plugin-canvas | https://github.com/jasondu/wxa-plugin-canvas | 3,188 | Apache-2.0 | 停更（2024-05） | 海报组件，设计稿 1:1 生成，含 poster+Qrcode 组件 | 低：npm（需钉版本号防坑）/源码拷贝；坑：画布图片不显示、版本兼容 | **备选**（与 Painter 二选一，Painter 功能面更全） |
| 3 | towxml | https://github.com/sbfkcel/towxml | 2,898 | MIT（package.json 声明，根目录无 LICENSE 文件） | 活跃（2026-04） | HTML/Markdown→WXML 渲染库，3.0+ 支持 ECharts/LaTeX/yUML/待办 | 高：自带整套样式体系与全自定义视觉冲突；dist 数百 KB 挤占主包；流式场景有社区衍生 towxml-stream-typer（仅 5 星，不成气候） | **SKIP 主渲染**；latex 模块留作公式期权 |
| 4 | mp-html | https://github.com/jin-yufeng/mp-html | 3,751 | MIT | 活跃（2026-04） | 全平台小程序富文本(HTML)渲染+编辑组件，插件体系 | 中：面向 HTML 富文本，需先 md→html 转换；与块渲染思路不同轨 | **SKIP** |
| 5 | Vant Weapp | https://github.com/youzan/vant-weapp | 18,457 | MIT | 活跃（2026-05） | 有赞小程序 UI 组件库，事实标准 | 高：整套设计语言换装，覆盖自定义 WXSS 工作量大 | **SKIP**（无品牌基础件可 cherry-pick 单组件） |
| 6 | TDesign miniprogram | https://github.com/Tencent/tdesign-miniprogram | 1,770 | MIT | 极活跃（调研当日仍有 push） | 腾讯官方设计系统小程序版，含 Skeleton/SwipeCell 等 | 高：同上 | **SKIP**（若未来真引组件库，优先它而非 Vant） |
| 7 | lottie-miniprogram | https://github.com/wechat-miniprogram/lottie-miniprogram | 432 | MIT | 缓更（2024-05） | 微信官方 Lottie（AE→JSON）动画库，canvas 渲染 | 中：canvas 性能瓶颈，多实例同屏可致崩溃，不支持 eval/new Function | **SKIP** |
| 8 | weapp-qrcode | https://github.com/yingye/weapp-qrcode | 1,718 | MIT | 停更（2023-01） | 小程序内生成二维码（canvas），轻量 | 低：单文件引入 | **备选**（分享卡二维码应优先后端小程序码 API，见技法 1） |
| 9 | katex-mini | https://github.com/rojer95/katex-mini | 135 | **无 LICENSE（法律风险）** | 缓更（2025-10） | 小程序内 KaTeX 渲染 LaTeX 公式，不依赖服务端 | 中 | **SKIP**（许可证不明 + 公式优先后端渲染） |
| 10 | jayZOU/skeleton | https://github.com/jayZOU/skeleton | 546 | MIT | 停更（2020-10） | 自动生成小程序骨架屏页面 | — | **SKIP**（开发者工具自带骨架屏生成，零依赖更优） |
| 11 | wxml-to-canvas（官方） | https://github.com/wechat-miniprogram/wxml-to-canvas | 168 | MIT | 停更（2021-08） | 官方 WXML→canvas 截图组件，CSS 子集支持有限 | 中 | **SKIP** |
| 12 | wxml2canvas-2d | https://github.com/ChrisChan13/wxml2canvas-2d | 124 | MIT | 缓更（2025-08） | WXML 转 canvas 图片（Canvas 2D 接口版） | 中 | 备选（海报路径若想"写 WXML 出图"可试） |
| 13 | wemark | https://github.com/TooBug/wemark | 1,312 | 无 LICENSE | 停更（2023-07） | 腾讯系 Markdown 渲染库（Gitter 曾对比后弃用） | — | **SKIP** |
| 14 | Gitter（视觉参考） | https://github.com/nslogx/Gitter | 3,678 | Apache-2.0 | 停更（2021-08） | "颜值最高"的 GitHub 小程序客户端，towxml+Taro UI | — | **参考**：dark mode、markdown 排版层次、列表卡片化 |
| 15 | ColorUI（视觉参考） | https://github.com/weilanwl/coloruicss | 12,375 | MIT | 缓更（2024-04） | 纯视觉向小程序组件库，高饱和/渐变/阴影技法 | — | **参考**：只抄卡片阴影层次与点缀色技法 |

> 数据说明：星数/许可证/末次 push 均为 GitHub API 当日实测（2026-09-29）；Painter 仓库已从 Kujiale-Mobile 迁移至 manycore-maas；wechat-miniprogram/wxa-plugin-canvas 旧地址 404，现役地址为 jasondu/wxa-plugin-canvas。

## 可直接采纳技法（按影响力排序）

1. **【海报分享·增长核心】Canvas 2D 手绘答案分享卡 + 后端小程序码**（预计 1-2 天）
   - 版式：藏青底 + 橙色点睛（沿用蓝图视觉），内容 = 问题摘要 + 最有分量的一句结论 + 品牌"总包AI顾问" + 右下角小程序码 + 分享者归因。
   - 二维码：后端调 `wxacode.getUnlimited` 生成小程序码（scene=分享者id/答案id），**不要**前端 weapp-qrcode 生成普通 QR——小程序码扫码直达且可归因，是裂变数据闭环的关键。
   - 实现借鉴 Painter 的 JSON Palette 思想（把版式描述成数据、绘制器只认 JSON），但用官方 Canvas 2D 接口手写约 200-300 行，避免依赖停更库；求快可先直引 Painter 验证增长假设再决定是否重写。
   - 出口：保存相册 + 分享朋友圈（onShareAppMessage 卡片图）双通道。
2. **【骨架屏】开发者工具一键生成 + 手写 shimmer 动画**（预计半天）
   - 微信开发者工具自带骨架屏生成（对 index/detail 页各生成 .skeleton.wxml/.wxss）；
   - shimmer 用 WXSS `background: linear-gradient(135deg, ...)` + `background-position` 位移动画 1.2s 循环，基色取藏青系深浅两阶，与品牌统一；
   - 覆盖点：首页加载、答案页流式返回前的正文占位（按块类型预置骨架块：标题块=粗条、段落块=三条细线、表格块=网格框）。
3. **【流式等待态】纯 CSS 打字光标/呼吸点**（预计 1 小时）
   - AI 生成中在答案区尾部渲染"▍呼吸闪烁"光标或三点呼吸动画，配合现有块渲染器逐块上屏；
   - towxml-stream-typer 一类流式库星数过低（5 星）不成气候，增量解析思想可日后并入 md2blocks（安全出块容错已有基础）。
4. **【视觉技法包】从 ColorUI/Gitter 定向抄三招**（预计半天）
   - 卡片多层阴影（外层大而淡 + 内层小而实）做答案卡层次感；
   - 深底高饱和点缀色纪律：每屏橙色元素 ≤3 处（CTA/徽标/数据高亮）；
   - Gitter 的 dark mode 配色梯度表作答深色模式预案参考。
5. **【公式预案】后端 KaTeX→图片管线**（仅当公式频率上升时启动）
   - 优先：后端 KaTeX 渲染公式为图片/SVG 下发 URL，前端 md2blocks 加一个 `{t:'formula', src}` 块类型即可，前端零依赖；
   - 次优：按需拷贝 towxml 的 latex 模块（MIT）。
6. **【组件 cherry-pick 纪律】**
   - 仅 Toast/Dialog/Popup 等无品牌价值的基础件考虑 TDesign 单组件按需引入（npm 构建）；任何带视觉皮肤嫌疑的组件一律自绘，守住全自定义视觉护城河。

---
*来源：GitHub API 实测 + [towxml](https://github.com/sbfkcel/towxml) / [Painter](https://github.com/manycore-maas/Painter) / [wxa-plugin-canvas](https://github.com/jasondu/wxa-plugin-canvas) 仓库与 README；微信官方骨架屏文档（developers.weixin.qq.com/miniprogram/dev/devtools/skeleton.html）；Gitter/wemark/ColorUI 等社区评测。*
