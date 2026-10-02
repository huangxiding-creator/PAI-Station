# pilot_features 试点产品零件调研（研报付费阅读小程序）

- channel: pilot_features | generated_at: 2026-09-27T21:15+08:00 | docs: 26 条
- 定向调研范围：长文档渲染 / 语音录入 / AI 对话 RAG / 内容安全 / 登录用户体系 / 防盗版
- 所有官方 API 结论均给出 developers.weixin.qq.com / docs.cloudbase.net / cloud.tencent.com 文档 URL，URL 均实测可访问（200 或 webReader 渲染出正文）

## 人读索引表

### 腿1 长文档在小程序内渲染 + 前20页付费墙

| # | 类型 | 标题 | URL | 要点 | 星 | 可信度 |
|---|------|------|-----|------|----|--------|
| 1 | api | wx.openDocument | https://developers.weixin.qq.com/miniprogram/dev/api/file/wx.openDocument.html | 打开本地 PDF；需先 downloadFile；**无页码范围参数，无法原生限制只读前20页** | - | 0.95 |
| 2 | doc | web-view 组件 | https://developers.weixin.qq.com/miniprogram/dev/component/web-view.html | 在线 PDF 预览备选；**个人主体不可用**；业务域名需 ICP+HTTPS+校验文件 | - | 0.95 |
| 3 | repo | xiaowangzhixiao/wechat-miniprogram-pdf | https://github.com/xiaowangzhixiao/wechat-miniprogram-pdf | PDF.js Canvas 原生渲染（页数可控/可加水印）；2026-07 仍更新但仅 2 星 | 2 | 0.6 |
| 4 | repo | zprial/wx-book | https://github.com/zprial/wx-book | 仿追书神器小说阅读器：书架/章节/进度骨架可借鉴；2019 停更 | 169 | 0.7 |
| 5 | repo | vace/wechatapp-news-reader | https://github.com/vace/wechatapp-news-reader | 新闻阅读器，长文图文排版参考 | 526 | 0.7 |
| 6 | api | wx.requestVirtualPayment | https://developers.weixin.qq.com/miniprogram/dev/api/payment/wx.requestVirtualPayment.html | 虚拟支付拉起；**2026-04-01 起虚拟交易强制走此通道**；iOS 端 2026 已开放 | - | 0.9 |
| 7 | repo | devoink/miniprogram-virtual-pay | https://github.com/devoink/miniprogram-virtual-pay | requestVirtualPayment 轻封装（原生+UniApp）；0 星需自测 | 0 | 0.6 |

### 腿2 语音录入

| # | 类型 | 标题 | URL | 要点 | 星 | 可信度 |
|---|------|------|-----|------|----|--------|
| 8 | api | RecorderManager.start | https://developers.weixin.qq.com/miniprogram/dev/api/media/recorder/RecorderManager.start.html | 单次上限 10 分钟；mp3/aac/wav/PCM；frameSize 分片回调；3.17.3+ voiceRecognition 模式 | - | 0.95 |
| 9 | doc | 微信同声传译插件 WechatSI | https://mp.weixin.qq.com/wxopen/plugindevdoc?appid=wx069ba97219f34d2c | 官方免费实时语音识别（getRecordRecognitionManager）+翻译+TTS；**疑似仅企业主体可添加**；社区有配额波动反馈 | - | 0.85 |
| 10 | doc | 腾讯云 ASR 计费概述 | https://cloud.tencent.com/document/product/1093/35686 | 一句话识别(≤60s 按次)/录音文件识别(按时长)/实时识别；后付费默认+每月免费额度 | - | 0.85 |

### 腿3 AI 对话（研报问答 RAG）

| # | 类型 | 标题 | URL | 要点 | 星 | 可信度 |
|---|------|------|-----|------|----|--------|
| 11 | doc | 云开发 AI 大模型（wx.cloud.extend.AI） | https://docs.cloudbase.net/ai/overview | 小程序直连 DeepSeek/混元等；基础库 3.7.1+；计费入云开发环境额度；Agent 可传研报做知识库问答 | - | 0.9 |
| 12 | repo | TencentCloudBase/cloudbase-agent-ui | https://github.com/TencentCloudBase/cloudbase-agent-ui | 官方 AI 对话组件（小程序/React）：流式+多轮+消息渲染 | 96 | 0.9 |
| 13 | doc | CloudBase 流式 Chatbot 三路径 | https://docs.cloudbase.net/ai/best-practice/streaming-chatbot | agent-ui 零代码 / 手写 SSE 云函数 / Vercel AI SDK | - | 0.9 |
| 14 | api | wx.request enableChunked | https://developers.weixin.qq.com/miniprogram/dev/api/network/request/wx.request.html | 流式接收底座；2.20.2+；默认 false；高性能模式下强制 HTTP1 | - | 0.95 |
| 15 | api | RequestTask.onChunkReceived | https://developers.weixin.qq.com/miniprogram/dev/api/network/request/RequestTask.onChunkReceived.html | 分块回调 res.data 是 **ArrayBuffer** 需自行解码 | - | 0.95 |
| 16 | repo | leon-fong/ChatGPT-miniprogram | https://github.com/leon-fong/ChatGPT-miniprogram | AI 对话小程序最小结构参考 | 378 | 0.7 |
| 17 | repo | oldinaction/ChatGPT-MP | https://github.com/oldinaction/ChatGPT-MP | 流式打字机+**次数限制+分享增加次数**（商业化额度设计可抄）；含后端代理写法 | 352 | 0.7 |
| 18 | doc | 腾讯云向量数据库 VectorDB | https://cloud.tencent.com/product/vdb | RAG 检索升级件；起步用云开发 Agent 知识库零运维 | - | 0.85 |

### 腿4 内容安全合规

| # | 类型 | 标题 | URL | 要点 | 星 | 可信度 |
|---|------|------|-----|------|----|--------|
| 19 | api | security.msgSecCheck v2 | https://developers.weixin.qq.com/miniprogram/dev/OpenApiDoc/sec-center/sec-check/msgSecCheck.html | 文本过检：2500 字/次；需 openid+scene；免费 4000 次/分、200 万次/天；用户输入与 AI 输出都应过检 | - | 0.95 |
| 20 | api | security.mediaCheckAsync | https://developers.weixin.qq.com/miniprogram/dev/OpenApiDoc/sec-center/sec-check/mediaCheckAsync.html | 图片/音频异步检测；回调取结果；UGC 场景备用 | - | 0.9 |

### 腿5 登录与用户体系

| # | 类型 | 标题 | URL | 要点 | 星 | 可信度 |
|---|------|------|-----|------|----|--------|
| 21 | api | auth.code2Session | https://developers.weixin.qq.com/miniprogram/dev/OpenApiDoc/user-management/code2Session.html | wx.login code→openid/session_key；绑开放平台才返回 unionid；openid 做已购记录主键即可 | - | 0.95 |
| 22 | doc | UnionID 机制说明 | https://developers.weixin.qq.com/miniprogram/dev/framework/open-ability/union-id.html | 同主体多端打通需微信开放平台账号绑定；单小程序试点可不做 | - | 0.9 |
| 23 | doc | getPhoneNumber 收费说明 | https://developers.weixin.qq.com/miniprogram/dev/framework/open-ability/getPhoneNumber.html | 快速验证 0.03 元/次、实时 0.04 元/次、1000 次免费；**试点期用 openid 完全可不采手机号** | - | 0.95 |

### 腿6 内容防盗版

| # | 类型 | 标题 | URL | 要点 | 星 | 可信度 |
|---|------|------|-----|------|----|--------|
| 24 | api | wx.onUserCaptureScreen | https://developers.weixin.qq.com/miniprogram/dev/api/device/screen/wx.onUserCaptureScreen.html | 截屏监听（2.29.0+）；iOS 仅主动截屏回调、安卓全回调；只通知不拦截 | - | 0.95 |
| 25 | api | wx.setVisualEffectOnCapture | https://developers.weixin.qq.com/miniprogram/dev/api/device/screen/wx.setVisualEffectOnCapture.html | 截/录屏时隐藏页面内容（hidden）；**仅 iOS**；3.0.0+ | - | 0.9 |
| 26 | repo | Byclemon/watermark-camera | https://github.com/Byclemon/watermark-camera | canvas 文字水印绘制逻辑可迁移为正文动态水印层 | 83 | 0.6 |

## 试点产品每条腿的零件选型建议表

| 腿 | 首选零件 | 备选 | 风险与对策 |
|----|----------|------|-----------|
| 1a 长文档渲染 | **章节化自渲染**：研报源（md/docx）按章切分 → 小程序原生 rich-text/自定义排版（结构借 zprial/wx-book，排版借 wechatapp-news-reader） | 双 PDF 方案：试读版（前20页）+完整版两份文件，downloadFile+openDocument 分别打开；企业主体可 web-view 嵌自建 H5 阅读器 | openDocument 无页级权限控制是官方 API 确认的硬限制；PDF.js canvas 路线（wechat-miniprogram-pdf）成熟度低，仅作三选 |
| 1b 前20页免费+付费墙 | 内容层切分 + 付费墙组件（第 20 页末尾插解锁卡）+ 已购状态 openid→后台订单表持久化（本地 storage 仅做缓存） | 会员订阅模式（安卓/鸿蒙、iOS 均已开放官方会员订阅） | **2026-04-01 新规：虚拟交易必须走官方虚拟支付**，普通 wx.requestPayment 卖内容有下架风险；费率约 12-20% 计入定价 |
| 2 语音录入 | **WechatSI 同声传译插件**（免费、官方、实时出字）+ RecorderManager 兜底 | 腾讯云 ASR 一句话识别（云函数调用，按次计费、有免费额度，成本厘级/次） | WechatSI 需企业主体且社区有稳定性反馈→必须做「识别失败转键盘输入」降级 |
| 3 AI 对话 RAG | **云开发 AI（wx.cloud.extend.AI）+ cloudbase-agent-ui 官方组件**：Agent 知识库上传研报=零代码 RAG，流式/多轮内置 | 自建 OpenAI 兼容代理（云函数存 key，绝不进前端）+ wx.request enableChunked/onChunkReceived 收流（参考 streaming-chatbot 文档路径2、ChatGPT-MP） | 模型调用按量计费需设每日额度；检索质量不满意时升级 VectorDB 自控切分 |
| 4 内容安全 | **msgSecCheck v2**（云调用）：用户提问先检、AI 回答异步二检；免费 200 万次/天 | mediaCheckAsync 覆盖用户上传图片 | AI 输出同属平台内容责任，不做先检后显有处罚风险；财经内容建议叠加免责声明 |
| 5 登录用户体系 | **wx.login + code2Session**，openid 为用户主键，云函数免维护 secret | 需要手机号时按次调用 getPhoneNumber（0.03 元/次） | 手机号非必需，试点期不采可省成本；多端打通（unionid）推迟到矩阵化阶段 |
| 6 内容防盗版 | 动态水印（openid 脱敏+时间戳平铺 canvas 层，借 watermark-camera 绘制逻辑）+ iOS setVisualEffectOnCapture 隐藏 + onUserCaptureScreen 弹版权提醒 | 高价值研报正文不提供整本 PDF 下载，仅在线分章阅读 | 安卓无法防截屏/录屏，水印+溯源是威慑上限；「下载解锁」档位要接受离线扩散风险定价 |

## 最大技术风险 Top3

1. **虚拟支付合规门（最高优先）**：2026-04-01 起小程序虚拟交易（内容付费解锁属此类）强制接入官方虚拟支付接口（wx.requestVirtualPayment），费率与类目准入（企业/个体户/个人不同通道）直接决定商业模型；若误用普通支付/外链引导支付将面临限流下架。落地前须先过类目准入与费率核算。
2. **PDF 前 20 页无原生权限控制**：openDocument 无页码范围参数（官方文档确认），前 20 页免费只能在内容层解决——章节化自渲染（工作量在排版）或双 PDF 文件（工作量在文件生产管线）；PDF.js canvas 自渲染路线成熟度不足。
3. **AI 对话的内容安全与类目资质**：研报问答输出涉投资信息，msgSecCheck 过检是硬要求，且金融/财经类目对主体资质可能有额外要求（需在注册类目阶段与平台确认），叠加模型按量计费失控风险——三者都要在上线前有明确答案。

## 附：已验证不可行/需谨慎的路径

- 个人主体：web-view 不可用、WechatSI 插件疑似不可添加 → 试点建议直接以企业/个体户主体注册。
- 高性能模式下 enableChunked 强制 HTTP1，自建流式代理时不要开启 useHighPerformanceMode。
- session_key 严禁下发前端；模型 API key 只能存云函数环境变量。
