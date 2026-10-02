# voice_ocr 渠道调研全集 — 微信小程序「总包千问」语音对话与截图咨询

- retrieved_at: 2026-09-28
- 条数: 19（official_doc 12 / repo 3 / forum 4）
- 姊妹文件: `_all.json`（结构化 Doc 数组）
- 纪律: 全部结论有源可查；未核实处一律标 UNKNOWN / 未复核 / 社区口径

---

## 五问答案（先读这里）

### Q1 语音输入：WechatSI 插件（appid 请核实）→ **已核实为真**

- **appid 核实**：`wx069ba97219f66d99` 正确。官方文档（translator.html）+ 微信插件市场 + 多篇 2025-2026 教程三方一致。插件名「微信同声传译」，`app.json` 声明 `"WechatSI": {"version": "0.3.5", "provider": "wx069ba97219f66d66d99"}`。
- **实时识别 API**：`requirePlugin("WechatSI").getRecordRecognitionManager()` → `manager.start({duration:60000, lang:"zh_CN"})`；`onStop` 回调 `{result, tempFilePath, duration, fileSize}`；lang 支持 zh_CN/en_US/zh_HK/sichuanhua；duration 最大 60000ms；错误码 -30001~-40001；基础库 ≥1.9.94。注意：流式中间结果 `onRecognize` 是社区通用用法但**官方文档未列出**（社区口径）。
- **免费额度（官方 FAQ 原表，已核实）**：语音识别 250 条/分钟、**3 万条/天**；翻译 500 次/分钟、10 万次/天；语音合成 100 次/分钟、2 万次/天。**免费**；提额发邮件 wetranslate@tencent.com。对千问日咨询量而言等于无限免费用。
- **申请流程**：微信公众平台 → 设置 → 第三方设置 → 插件管理 → 搜「微信同声传译」添加 → app.json 声明。社区经验：需**已认证小程序**主体才能添加插件（官方未明文，社区观察）。
- **官方参考实现**：Tencent/Face2FaceTranslator（908★，微信官方团队，2026-09 仍更新）——接语音直接抄它。
- **替代方案（RecorderManager+云端 ASR）**：完全可行，是超 60 秒长语音/专业领域识别的后备腿（见 Q4）。短问答场景 WechatSI 免费额度足够，**首选 WechatSI**。

### Q2 语音播报（TTS）：免费优先

1. **首选：WechatSI 的 textToSpeech（免费，已核实）**——`plugin.textToSpeech({lang:"zh_CN", content:"..."})`；限制 content ≤50 字（长答案需分段合成）、返回的语音 URL **3 小时过期**（需即取即播或转存云存储）；额度 100 次/分钟、2 万次/天。
2. **云开发 AI+ 的 TTS（已核实存在）**：`docs.cloudbase.net/ai/agent/voice`——长文本语音合成 ≤10 万字符、10 音色（含大模型音色），SDK `ai.bot.textToSpeech({botId, voiceType:1, text})`，HTTP `POST /v1/aibot/bots/:botId/text-to-speech`；基于腾讯云语音 API **计费（单价 UNKNOWN）**，适合答案整段高质量播报的付费升级腿。
3. **播放**：合成结果用 `wx.createInnerAudioContext()` 播放。
4. 结论：**免费方案 = WechatSI textToSpeech 分段播报**；音质/长文需求再上云开发 TTS。

### Q3 截图咨询：图片→文字四路评估

| 路径 | 调用方式 | 费用 | 限制/结论 |
|---|---|---|---|
| ① 微信 OCR 插件 wx4418e3e031e551be | `ocr-navigator` 组件，certificateType 选证件类型 | 按次购套餐（有免费额度） | **仅证件识别（身份证/行驶证/银行卡/驾驶证/营业执照），无通用印刷体 → 不适用截图咨询，直接排除** |
| ② 云开发 AI+ 多模态（`wx.cloud.extend.AI`） | `createModel("cloudbase")` → `generateText({data:{model:"glm-5v-turbo", messages:[{content:[{type:"text"...},{type:"image_url", image_url:{url:"data:image/jpeg;base64,..."}}]}]}})`；当前多模态模型 glm-5v-turbo / qwen3.5-plus / kimi-k2.6 / kimi-k2.5 / kimi-k2.7-code（deepseek-v4-flash、hy3 纯文本）；**官方场景明列「截图问答、OCR 识别」**；图 base64 单张 ≤5MB 或 https 直链 | 新用户首月赠 100 万 token；成长计划资源包；glm-5v-turbo 单价 UNKNOWN | **首选**：与已有云开发栈同构、免鉴权、OpenAI 兼容消息格式，还能直接进答案生成而不止于 OCR |
| ③ 免费大模型 API 视觉（GLM） | GLM-4V-Flash（open.bigmodel.cn），OpenAI 兼容 image_url，**免费**；中英日韩 | 免费 | 具体速率/并发限制 UNKNOWN；工程图纸小字识别率需自测；laya-server 已有 GLM 免费链经验可复用 |
| ④ 微信服务端 OCR（通用印刷体） | 服务端 `POST /cv/ocr/comm`（commocr）或云调用 `ocr.printedText`，img=图片URL | 历史信息每日免费 100 次、超出购资源包（**本次未复核计费页原文，页面需登录——以服务市场计费页为准**） | 只能服务端调用（access_token）；纯 OCR 拿文字后再喂问答模型，两段式；适合做兜底 |

**推荐组合**：②为主（截图直接进多模态模型一跳出答案）+ ③为免费溢出腿；①排除；④备选。

### Q4 录音咨询完整链路（RecorderManager → 上传 → ASR）

1. **录音**：`wx.getRecorderManager().start({duration:60000, sampleRate:44100, numberOfChannels:1, encodeBitRate:192000, format:"aac", frameSize:50})`；`onStop` 拿 `res.tempFilePath`；首次触发 scope.record 授权弹窗。
2. **上传**：`wx.cloud.uploadFile`（云开发，免鉴权、免域名白名单）或 `wx.uploadFile`（自建后端）。
3. **ASR 三选**：
   - **云开发 AI+ 一句话识别**：`ai.bot.speechToText({botId, engSerViceType:"16k_zh", voiceFormat:"mp3", url})`，≤60s、≤3MB，与云开发栈同构（费用随腾讯云语音，UNKNOWN）；
   - **腾讯云语音识别**（product/1093）：一句话识别/录音文件识别/实时识别，长音频最强；免费额度为活动制（当前准确额度 UNKNOWN）；
   - **WechatSI 插件**：60 秒内语音**免上传免后端**直接出文字，免费 3 万条/天。
4. **工程建议**：≤60s 问答走 WechatSI（零成本零后端）；>60s 或要保留录音凭证走 RecorderManager+云开发上传+ASR。

### Q5 主体/类目要求

- **核心约束在 AI 问答本身，不在语音/OCR**：「总包千问」接大模型做 AI 问答 → 类目必须含「**深度合成-AI问答**」，该类目**仅限企业主体**（个人主体不可选；个体工商户口径社区帖不一，以类目页实际为准）。
- **资质二选一**：自研模型需自家《互联网信息服务算法备案》（生成合成类）；用第三方（云开发 AI+/GLM 等）需**服务商《算法备案凭证》（或审批中截图）+ 合作协议/订单（订单产品名须与备案算法名完全一致）**，另需第三方服务《在用证明》（含小程序主体/appid/订单有效期）。用**微信云开发 AI 能力可由平台生成「在用证明」**，显著简化材料。
- **AI 生成内容需显著标识**（《生成式人工智能服务管理暂行办法》《互联网信息服务深度合成管理规定》）。
- 语音/OCR 能力本身**不新增类目要求**：WechatSI/OCR 插件走插件管理添加（社区经验：需已认证主体）；录音仅需用户授权 scope.record；相册/拍照走 chooseMedia 用户交互，无类目影响。
- 当前主体形态若为个人 → 上线 AI 问答前必须升级企业主体，这是所有功能的前置门。

---

## UNKNOWN / 未复核清单（不许编造，留待上线前复核）

1. 服务端 OCR（commocr）**当前**每日免费额度（历史 100 次/日；计费页需登录，本次未复核）。
2. CloudBase AI+ glm-5v-turbo 等**具体单价**与成长计划资源包细则。
3. 云开发 TTS/ASR（腾讯云语音）计费单价。
4. 腾讯云 ASR 当前免费额度（活动制，公网口径 1500 次/30h 等不一）。
5. GLM-4V-Flash 并发/速率限制（文档未列）。
6. WechatSI「需认证小程序才能添加插件」为社区经验，官方未明文。
7. WechatSI `onRecognize` 流式回调：社区通用但官方文档未列。
8. 个体工商户能否选深度合成类目：社区口径不一。

---

## 文档清单（19 条）

| # | 类型 | 标题 | URL | 信号 | 可信度 |
|---|---|---|---|---|---|
| 1 | official_doc | 微信开放文档·微信同声传译插件（WechatSI） | https://developers.weixin.qq.com/miniprogram/dev/platform-capabilities/extended/translator.html | — | high |
| 2 | official_doc | 微信服务端 OCR 接口列表 | https://developers.weixin.qq.com/miniprogram/dev/server/API/img-ocr | — | high |
| 3 | official_doc | 通用印刷体识别（commocr） | https://developers.weixin.qq.com/miniprogram/dev/server/API/img-ocr/ocr/api_commocr.html | — | high |
| 4 | official_doc | RecorderManager 录音管理器 | https://developers.weixin.qq.com/miniprogram/dev/api/media/recorder/RecorderManager.html | — | high |
| 5 | official_doc | 官方 OCR 插件『OCR支持』文档（w3cschool 镜像） | https://www.w3cschool.cn/weixinapp/weixinapp-zxk938q3.html | — | medium |
| 6 | official_doc | CloudBase·多模态理解（截图问答/OCR 官方场景） | https://docs.cloudbase.net/ai/model/multimodal | — | high |
| 7 | official_doc | CloudBase·语音能力接入（ASR+TTS） | https://docs.cloudbase.net/ai/agent/voice | — | high |
| 8 | official_doc | CloudBase·HTTP API 文字转语音 | https://docs.cloudbase.net/http-api/ai-bot/text-to-speech | — | medium |
| 9 | official_doc | CloudBase·AI+ 简介（大模型接入总览） | https://docs.cloudbase.net/ai/introduce | — | high |
| 10 | repo | Tencent/Face2FaceTranslator（官方 WechatSI 演示） | https://github.com/Tencent/Face2FaceTranslator | 908★ | high |
| 11 | repo | JasonLam0990/HeartSound | https://github.com/JasonLam0990/HeartSound | 57★ | medium |
| 12 | repo | Resulte/SpeechProcessMiniProgram | https://github.com/Resulte/SpeechProcessMiniProgram | 12★ | medium |
| 13 | official_doc | 智谱 GLM-4V-Flash 免费视觉模型 API | https://open.bigmodel.cn/dev/api/vlm/glm-4v-flash | — | high |
| 14 | official_doc | 腾讯云·语音识别产品文档 | https://cloud.tencent.com/document/product/1093 | — | high |
| 15 | forum | CSDN·WechatSI 通用接入教程 | https://blog.csdn.net/m0_64705796/article/details/160140765 | — | medium |
| 16 | forum | SegmentFault·微信同声传译插件介绍 | https://segmentfault.com/a/1190000017084914 | — | medium |
| 17 | forum | 微信开放社区·WechatSI 插件搜索不到（认证主体问题） | https://developers.weixin.qq.com/community/develop/doc/000020702b0a70d1f915207c96bc00 | — | medium |
| 18 | forum | 阿里云开发者社区·OCR 插件接入实录 | https://developer.aliyun.com/article/1626167 | — | medium |
| 19 | forum | 微信开放社区·深度合成类目与《在用证明》实操（多帖汇总） | https://developers.weixin.qq.com/community/develop/doc | — | medium |

## 关键代码速查

```json
// app.json — WechatSI（appid 已核实）
"plugins": { "WechatSI": { "version": "0.3.5", "provider": "wx069ba97219f66d66d99" } }
```

```javascript
// 语音识别（流式，官方）
const plugin = requirePlugin("WechatSI");
const manager = plugin.getRecordRecognitionManager();
manager.onStop = (res) => { /* res.result 文字 */ };
manager.start({ duration: 60000, lang: "zh_CN" }); // duration 最大 60000

// TTS（免费，≤50字/次，URL 3小时过期）
plugin.textToSpeech({ lang: "zh_CN", content: text, success: (res) => play(res.filename) });
```

```javascript
// 截图咨询（CloudBase 多模态，官方代码形态）
const model = wx.cloud.extend.AI.createModel("cloudbase");
const res = await model.generateText({ data: {
  model: "glm-5v-turbo",
  messages: [{ role: "user", content: [
    { type: "text", text: "这是工程截图，请…" },
    { type: "image_url", image_url: { url: "data:image/jpeg;base64,..." } } // 单张 ≤5MB
  ]}]
}});
```

```javascript
// 录音（官方示例）
const rm = wx.getRecorderManager();
rm.onStop((res) => upload(res.tempFilePath));
rm.start({ duration: 60000, sampleRate: 44100, numberOfChannels: 1,
           encodeBitRate: 192000, format: "aac", frameSize: 50 });
```
