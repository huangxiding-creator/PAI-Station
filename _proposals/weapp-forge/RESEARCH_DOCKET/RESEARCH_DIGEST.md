# RESEARCH_DIGEST — 小程序全流程工厂（weapp-forge）

> 2026-09-27 · 840 个唯一条目（GitHub 328 + npm 351 + 5 深度渠道 234，聚合去重实测）· 全部脚本实跑，零编造
> 数据目录：`RESEARCH_DOCKET/{github,npm_pypi,official_eco,frameworks_ui,skills_mcp_ai,wechat_pay,pilot_features}/`，总索引 `_INVENTORY.md`

## 一、总盘子

| 渠道 | 条目 | 核心结论 |
|---|---|---|
| github 广扫 | 328 | 生态巨大但**编排层空心**：发布类 action 无一存活（最高 14★、2021 停） |
| npm 广扫 | 351 | miniprogram-ci 7.2万月载、simulate 7.8万月载、api-typings 69.4万月载——官方件下载量巨大，全在"零件层" |
| official_eco | 57 | **微信官方三件大事**：AI 开发模式协议 / DevTools 2.0 MCP 市场分发 / 官方 GitHub 布局剧变（三主仓下架） |
| frameworks_ui | 79 | 零件世界级成熟：uni-app 41.6k★、taro 37.7k★、vant-weapp 18.4k★、mp-html 3.75k★；但 9 archived + 28 停更——选型必须挑活的 |
| skills_mcp_ai | 49 | **缺口实锤**：端到端口号项目全部 0-2★ 零落地；支付执行无 MCP；审核/类目/发布无任何工具 |
| wechat_pay | 27 | 数字内容唯一合规通道=虚拟支付；**2026-09 个人主体新开**（月限10万）；企业档费率更优 |
| pilot_features | 26 | 试点六腿零件全齐；三个负面事实（openDocument 无页码范围/个人主体禁 web-view/虚拟支付强制官方通道） |

## 二、微信官方生态三件大事（决定工厂架构）

1. **官方「AI 开发模式」平台级协议**（最重磅）：`wechat-miniprogram/ai-mode-skills`（203★，wxa-skills-generate/validate/eval 三件套，把任意小程序改造成可被微信"小微" SubAgent 调度的原子接口+组件）+ `ai-mode-demo`（296★，AI Handoff 接力 wx.onAgentHandoff + mcp.json 适配范式）。**官方评测指南：四指标各≥60 分才被微信 AI 调用、Intent≥50、复杂用例通过率≥30%**——直接当工厂「出厂合格判据」。
2. **DevTools 2.0+ 内建 MCP 分发**：Ctrl+Shift+X 扩展面板 → MCP 市场可装 CloudBase MCP；官方已在三处以 Agent Skills 形态发布（skyline-skills / cloudbase-skills / ai-mode-skills）；「微信开发者工具 Skill」公测（wechatide 导出，覆盖打开/编译/预览/上传/云开发）。**编译腿直接建在官方件上，不碰第三方 MCP**（社区最热 yfmeii 175★ 已挂"建议迁移官方"）。
3. **官方 GitHub 布局剧变**：miniprogram-ci / automator / minitest 三主仓从 wechat-miniprogram org 下架（404 实测）；ci 迁 `miniprogram-ci-dist`（2026-09-18 活跃发版，2.1.47）；automator npm 28 个月未更新（社区兼容替代 `@weapp-vite/miniprogram-automator`）；minitest 全网无踪——**测试腿需双保险**。

## 三、零件选型定论（51 候选实测，median 成熟度 68.9/100，22 个 mature）

| 环节 | 首选零件 | 实测信号 | 备选 |
|---|---|---|---|
| 语言底座 | 原生 TS + api-typings | 69.4万月载 | — |
| UI 组件 | vant-weapp 18,457★（活跃） | tdesign / weui 27,437★ | iview/wux/lin-ui/ColorUI/ThorUI 全停更勿用 |
| 样式 | weapp-tailwindcss 1,864★（当天发版） | — | — |
| 构建 | miniprogram-ci（npm build/upload/preview 全含） | 7.2万月载 | weapp-vite 486★ |
| 富文本渲染 | mp-html 3,750★ | towxml 2,898★ | wxParse 7,716★ **已死勿用** |
| 阅读器结构 | wx-book 169★ | news-reader 526★ | 自研分章 |
| 上传/密钥 | miniprogram-ci upload（IP白名单+上传密钥体系） | 官方在役 | DevTools CLI V2 + HTTP V2 |
| 自动化回归 | automator 5.9万月载 | @weapp-vite 替代兜底 | minitest 已停摆 |
| 组件单测 | miniprogram-simulate 7.8万月载 | 官方在役 | — |
| 云后端 | CloudBase（云函数2.0/静态托管/AI） | CloudBase-AI-Toolkit 1,126★ 43+tools | 自建服务器 |
| AI 对话 | wx.cloud.extend.AI（DeepSeek/混元）+ cloudbase-agent-ui 96★ | 官方 | 自建代理 enableChunked 流式 |
| 语音 | 同声传译插件 WechatSI（官方免费实时） | 腾讯云 ASR 厘级/次兜底 | — |
| 支付 | wx.requestVirtualPayment（虚拟支付，数字内容唯一合规通道） | 企业档（费率优于个人档） | 标准商户号 JSAPI 不适用于数字内容 |
| 内容安全 | msgSecCheck v2 云调用 | 免费 200万次/天 | mediaCheckAsync |
| 图表 | echarts-for-weixin 7,512★ | wx-charts 4,988★ | uCharts 官方仓在 gitee |

## 四、缺口 = 护城河（五条全部实锤）

1. **编排层完全空白** — 官方积木最全但无人串联成流水线（GH Actions 发布 action 无一存活；"端到端"项目 0-2★ 零落地）
2. **审核/类目/合规 AI 化空白** — 最中国特色环节，海外工具永远不会做
3. **支付执行无 MCP** — 知识有（wechatpay-skills 359★）工具无
4. **需求断层量化** — skills.sh 同市场安装量差 124×（1,324 vs 16.5万）
5. **试点细分零竞品** — "研报付费阅读小程序"无成建制竞品，零件全现成

## 五、微信支付接入答案（用户点名问题）

**三路线**：①标准商户号 JSAPI v3（企业/个体户；小程序内卖数字内容**违规**）②CloudPay/云托管 uniPay（工程封装好，**不降资质门槛**）③**虚拟支付=数字内容唯一合规通道**（2026-04 起强制官方通道；2026-09 个人主体新开：月限10万、安卓1%/iOS12%；**企业档费率更优**）。
**本方案路径**：用户视频号已企业认证→企业资质在手→小程序按**企业主体**注册→虚拟支付企业档；研报以 **PDF 文件交付**（规避"信息发布平台"形态）；iOS 端 12% 抽成与 45-60 天账期进入定价与现金流模型。
**红线**：外链 H5 支付规避=微信明令违规（2018 公告起），绝不采用；session_key/支付密钥绝不进前端。

## 六、试点六腿选型（research 实测）

1. 长文档：**章节化自渲染**（mp-html）+「试读版/完整版双 PDF」——openDocument 无页码范围参数（官方确认），前20页免费必须在内容层做
2. 付费解锁：虚拟支付 + openid→后台订单持久化（幂等发货）；参考 devoink/miniprogram-virtual-pay
3. 语音：WechatSI 实时出字 + 键盘降级
4. AI 对话：云开发 extend.AI + agent-ui 组件 + 官方知识库上传研报=零代码 RAG
5. 内容安全：用户输入先检 + AI 输出异步二检（财经内容硬要求）
6. 防盗版：canvas 动态水印 + iOS setVisualEffectOnCapture + onUserCaptureScreen

## 七、诚实降级记录

官方 3 仓库下架、3 文档页 404、DevTools 版本页 SPA 未穿透（多源交叉证实 2.0+）；WechatSI 个人主体可用性存疑（企业主体规避）；skillsmp/superpowers JS 渲染未穿透；企业档虚拟支付精确费率、秒哒付费档、有赞价格未验证——均已标注待核实，未入决策链。
