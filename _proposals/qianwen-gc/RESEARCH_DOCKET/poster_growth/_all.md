# 海报裂变增长调研（poster_growth）— 「总包千问」AI付费问答小程序

- 调研时间：2026-09-27 ~ 2026-09-28
- 条数：21（official_doc 3 / repo 4 / article 5 / case 9）
- 方法：官方文档服务端HTML全文解析 + GitHub API实证 + 产品社区搜索交叉（WebSearch）。标注规则：credibility high=官方原文或GitHub API实证；medium=精确文章URL已核；low=站点级URL/摘要级素材（内容经多源交叉但精确URL未落）。
- 机器可读版：同目录 `_all.json`

---

## 五问终答

### Q1 小程序码带参：wxacode.getUnlimited（scene参数）

**生成方式（三种，均合法，前端绝不可直调）：**
1. 服务端 HTTPS：`POST https://api.weixin.qq.com/wxa/getwxacodeunlimit?access_token=ACCESS_TOKEN`，请求体必须是 JSON 字符串（不支持 form 表单）；成功返回图片 Buffer（二进制），失败返回 JSON（errcode/errmsg）。支持加密请求。
2. 云函数：`cloud.openapi.wxacode.getUnlimited({page, scene, checkPath, envVersion})`（wx-server-sdk），出入参与 HTTPS 相同——对无自建服务器的团队是最短路径。
3. 第三方平台代调用：权限集 id=17，用 authorizer_access_token。

**scene 长度/字符限制（官方原文核验）：**
- 必填，**最大 32 个可见字符**；只支持数字、大小写英文及特殊字符 `!#$&'()*+,/:;=?@-._~`。
- **不支持 `%`** → 中文无法用 urlencode，需其他编码方式（实践通行做法：只传短 ID/数字码，长参数存数据库用短 key 映射）。
- 超限/非法报错：40129 invalid scene、40169 invalid length。
- `page` 不能携带参数（参数必须放 scene），根路径前不加 `/`；`check_path` 默认 true 时 page 必须是已发布页面（false 时允许未发布但 page 有 60000 个上限）；`scancode_time` 是系统保留参数不可配置（85096）。
- 频率限制 **5000次/分钟**，海报码按人发码的场景官方明确建议**预生成**；码永久有效、数量暂无限制（对比 getwxacode 10万个上限——裂变场景必须用本接口）。

**扫码进入解析：**
```js
Page({ onLoad(query) { const scene = decodeURIComponent(query.scene) /* 再按自定分隔符split解析k-v */ } })
```
- 小游戏：`wx.getLaunchOptionsSync()` 或 `wx.onShow` 中取 query。
- 调试：开发者工具「编译模式」自定义参数 scene=xxx（模拟值需 encodeURIComponent），否则本地无法复现扫码链路。

**个人/企业主体：** 官方文档「适用范围」表仅区分小程序/小游戏（均✔），**未按个人/企业主体区分**，且文档全文无个人主体限制条款——即文档层面个人主体小程序同样可调用。UNKNOWN 项：官方未逐字明示「个人主体可用」的表述，未找到微信开放社区的官方逐字答复佐证（属文档未明示、社区实践无主体门槛）。

### Q2 Canvas 海报生成方案（GitHub API 实证，2026-09-27）

| 库 | stars | 最后push | 状态 | 结论 |
|---|---|---|---|---|
| **Painter**（manycore-maas，原Kujiale-Mobile） | **4477** | 2024-03-12 | 未归档 | **首选**。JSON方式绘制，生态/案例最大，有可视化配置工具 lingxiaoyi.github.io/painter |
| **wxa-plugin-canvas**（jasondu） | **3188** | 2024-05-08 | 未归档 | **次选**。海报专用组件（poster标签），开箱即用，定制自由度低于Painter |
| wxml-to-canvas（官方wechat-miniprogram） | 168 | 2021-08-29 | **已归档** | 不推荐。官方出品但归档4年+，坑自己扛 |
| mp-painter（xlfsummer） | 70 | **2025-06-29** | 未归档 | 备选。维护最新，声明式，支持uniapp/原生/H5（canvas 2d栈），但社区小 |

**通用坑（社区文章交叉汇总）：** canvasToTempFilePath 在基础库 <2.20.0 有重大问题（用新 canvas 2d 接口规避）；npm 引入须构建 miniprogram_npm；canvas 不能 display:none 隐藏（用 position 移出屏外）；canvas-id 必须唯一；网络图片（头像/远程图）必须先 downloadFile/getImageInfo 下载到本地再绘制，否则白图；分享/保存图片 ≤128KB、建议 5:4 比例；html2canvas 等 web 方案小程序不支持。

### Q3 裂变玩法竞品案例

**知识付费类：** 千聊「邀请卡」=分享海报→几位好友扫码→达成任务→免费得课程（任务裂变标准形态）；小鹅通分销=学员成推广员→生成带专属二维码的分销海报→好友扫码付费→系统提示佣金（后台有裂变数据统计页；佣金结算依赖微信「商家转账到零钱」）；2018 刷屏三案例：网易戏精课（12小时13万+报名）、新世相营销课、三联中读分销——均属监管收紧前的高峰形态。36氪代际观察：新玩法从「一开始就要分享」进化为「免费免分享先进群、上课中再转发学习成果海报」。

**答题/教育类：** 微信读书答题闯关=答错时邀请好友得续命卡（消耗品稀缺+邀请补量模型，与「送咨询次数」直接同构）；学而思2020=1元解锁第一节课+2位好友支付解锁后续（低价钩子+好友付费解锁）；任务宝模式=每人扫码自动生成专属海报、邀请2人解锁、进度实时提醒（工具约3000元/年，小程序自建等价物=getUnlimited按人发码+服务端计数+订阅消息推进度）。

**AI问答类「问题+答案预览+扫码看全文」先例：UNKNOWN**——未找到完全匹配的公开案例（多轮多源检索无命中）。结构上它是已知模式的杂交：内容预览钩子（有书/喜马拉雅「分享免费听」型）+ 解锁转化（学而思1元解锁型）+ 成就海报载体（36氪代际观察）。最接近的行为模型=微信读书续命卡（次数消耗）与小鹅通分销海报（专属码归因）。无先例既是风险（合规无判例可抄）也是差异化机会。

**财商类「扫码解锁」专项：UNKNOWN**——未命中财商课专属案例（长投/微淼未展开检索）；可复用模式即学而思1元解锁+任务宝专属海报，机制同构。

### Q4 微信分享合规红线（运营规范原文核验）

**会被封的边界（《微信小程序平台运营规范》5.1滥用分享，处理规则：限制活动页面→限制分享能力/朋友圈二维码识别能力→直至下架封号）：**
- 5.1.1 强制分享：**分享后才能解锁功能、查阅、下载**——「扫码解锁」设计的第一红线，解锁条件绝不能是「用户自己分享」。
- 5.1.3 诱导分享朋友圈：分享至朋友圈获取利益。「利益」官方定义含现金/实物/虚拟奖品（红包、优惠券、代金券、积分、话费、流量、**信息**等）。
- 5.1.4 无深度互动诱导分享：「深度互动」=被分享者理解内容并主动参与活动或业务流程的进入页面/点击等操作——邀请奖励应挂在被邀请者的深度行为上。
- 5.1.6 概率性收益、5.1.7 收益非即时获得（不满足即时性）、5.1.8 组队超5人、5.1.9 分享量大且转化率低（自动限流，连带开放平台账号）均违规。
- 5.3 网赚：诱导转发后得收益（现金/积分/礼品）即违规。5.9 多级分销：分级佣金/上下级代理/多层抽佣→封分享+支付直至封号（**邀请奖励只做一级**）。5.28 频率限制：利诱+分享过多→新增分享页面限制访问。
- **判例**：流利阅读/薄荷阅读「打卡返学费」2019年被处罚——利益与分享动作绑定即处罚，即使有真实内容消费。
- **附加捕获（对千问关键）**：5.13 虚拟支付——虚拟商品（含**解锁功能、订阅内容、付费功能**）必须接入小程序虚拟支付，不得引导至外部支付。「付费解锁看全文」是明文覆盖场景。

**海报转发朋友圈/群的操作路径：**
- 转发好友/群：页面配置 `onShareAppMessage`（可自定义 title/path/imageUrl，**path 可带参数**——归因可用）。
- 转发朋友圈：`onShareTimeline`（基础库2.11.3+，微信8.0.24+；须先配置 onShareAppMessage）。朋友圈打开进入「单页模式」：无登录态、禁跳转任何页面、禁支付/授权/保存相册、场景值=1154、onShareTimeline **不支持自定义页面路径**。官方运营须知：此能力为纯内容场景分享诉求，滥用营销诱导将被打击；单页模式不得诱导强制点「打开小程序」，应尽量呈现完整内容。
- **海报图片**发朋友圈：小程序无法直接替用户发图片到朋友圈——路径=canvas生成海报→canvasToTempFilePath→wx.saveImageToPhotosAlbum保存相册→用户手动发朋友圈。注意 saveImageToPhotosAlbum 在单页模式（1154）内禁用，须引导用户先「前往小程序」。

### Q5 裂变闭环数据：归因 → 邀请奖励

**归因链路（行业通行做法）：**
1. 服务端为每个邀请者生成 getUnlimited 码，`scene=邀请者短ID`（32字符内，如 `inv=8dK3x`；中文/长ID用短码+数据库映射）。
2. 海报 canvas 合成时把该码画入海报。
3. 新用户扫码 → 落地页 `onLoad` → `decodeURIComponent(query.scene)` → 解析出邀请者ID → 上报服务端落库绑定归因关系（不要只存前端缓存）。
4. 归因窗口：业界实践有72小时窗口/首次触达优先（AppTrace案例：跨平台参数传递+72小时归因，注册转化率+63%、获客成本-41%）。
5. 新用户判定=UnionID/OpenID + 手机号 + 设备指纹组合，单一维度必被刷。

**奖励设计常见做法（与合规的对齐）：**
- **双向奖励**（邀请者+被邀请者都得，知乎裂变指南归类为「邀请裂变」模式）；**只做一级**（规避5.9多级分销）。
- 奖励挂「被邀请者完成深度互动/付费」（学而思=2好友支付才解锁；微信读书续命卡=邀请成功即得）而非挂「分享动作」——后者即5.1.1/5.1.3/流利阅读判例红线；5.1.7 要求承诺的收益即时兑现。
- 「送咨询次数」=消耗型虚拟权益，与微信读书续命卡同构；转化最高点=次数用尽时弹出邀请提示（摘要级方法论，无精确文章URL）。
- 防刷：事前黑名单/风控评估，事中设备指纹（模拟器/root/群控）、IP画像、虚拟号拦截，事后留存异常检测、奖励延迟到关键行为完成后发放（网易易盾/数美实践）。
- 千问落地建议组合：AI问答海报=用户自己的问题+答案预览（成就型载体）+scene归因码 + 奖励=被邀者完成首次提问/付费后双方各得咨询次数（深度互动+即时+一级）。

---

## 文档清单（21条）

| # | 类型 | 标题 | URL | 信号 | 可信度 |
|---|---|---|---|---|---|
| 1 | official_doc | 获取不限制的小程序码 getUnlimitedQRCode | developers.weixin.qq.com/.../api_getunlimitedqrcode.html | 全文核验 | high |
| 2 | official_doc | 分享到朋友圈（单页模式与限制） | developers.weixin.qq.com/.../share-timeline.html | 全文核验 | high |
| 3 | official_doc | 微信小程序平台运营规范（5.1/5.3/5.9/5.13/5.16/5.28） | developers.weixin.qq.com/miniprogram/product/ | 逐条原文提取 | high |
| 4 | repo | Painter（manycore-maas，原Kujiale-Mobile） | github.com/manycore-maas/Painter | 4477★/588f/2024-03-12 | high |
| 5 | repo | wxa-plugin-canvas（jasondu） | github.com/jasondu/wxa-plugin-canvas | 3188★/485f/2024-05-08 | high |
| 6 | repo | wxml-to-canvas（官方，已归档） | github.com/wechat-miniprogram/wxml-to-canvas | 168★/2021-08-29/archived | high |
| 7 | repo | mp-painter（xlfsummer） | github.com/xlfsummer/mp-painter | 70★/2025-06-29 | high |
| 8 | article | uni-app生成小程序码和scene参数爬坑指南（艺灵） | yilingsj.com/xwzj/2020-12-26/uni-app-wxacode-getUnlimited.html | 精确URL | medium |
| 9 | article | scene参数全链路解析（CSDN） | blog.csdn.net/Superxpang/article/details/145034656 | 精确URL | medium |
| 10 | article | uniapp scene参数踩坑总结（CSDN） | blog.csdn.net/u014724048/article/details/131823162 | 精确URL | medium |
| 11 | article | Java生成微信小程序二维码（掘金） | juejin.cn/post/7340229050235961398 | 精确URL | medium |
| 12 | article | 微信营销玩法总结思维导图（Processon） | processon.com | 站点级 | low |
| 13 | case | 微信生态裂变玩法全拆解——千聊邀请卡（2018） | cjzzc.com | 站点级 | low |
| 14 | case | 如何设计一款社交营销裂变产品（woshipm） | woshipm.com | 站点级 | low |
| 15 | case | 王六六线上裂变指南——任务宝模式（growthhk） | growthhk.cn | 站点级 | low |
| 16 | case | 学而思2020：1元解锁+好友支付解锁（dcbbs拆解） | dcbbs.com | 站点级 | low |
| 17 | case | 流量池思维裂变指南（知乎/woshipm） | zhuanlan.zhihu.com | 站点级 | low |
| 18 | case | 互联网运营20年：裂变海报代际演化（36氪） | 36kr.com | 站点级 | low |
| 19 | case | 微信读书答题续命卡+MGM近似案例（搜狐等） | sohu.com | 站点级 | low |
| 20 | case | 小鹅通分销闭环+小裂变员工码海报（xiaoe-tech/doc.xiaoliebian.com） | xiaoe-tech.com | 站点级 | low |
| 21 | case | 流利阅读/薄荷阅读打卡返学费被处罚（2019判例） | UNKNOWN | 多源摘要交叉 | low |

## UNKNOWN 汇总（不许编造项）

1. **AI问答类小程序「问题+答案预览+扫码看全文」海报裂变直接先例：UNKNOWN**（无完全匹配公开案例，仅有同构机制：学而思1元解锁/任务宝/微信读书续命卡）。
2. **财商类「扫码解锁」专属案例：UNKNOWN**（未命中，可复用学而思+任务宝模式）。
3. **个人主体调用 getUnlimited 的官方逐字承诺：UNKNOWN**（适用范围表未按主体区分=文档层面无限制，但无「个人主体可用」明示条文/社区官方答复佐证）。
4. 多条竞品文章仅获站点级/摘要级素材（#12-21），精确文章URL未落盘——内容经多源交叉，引用时建议二次核URL。
5. 「阶梯邀请（1人+5次/3人+20次）+次数用尽时提示转化最高」为摘要级方法论，未见精确出处文章，按推断性内容对待。
