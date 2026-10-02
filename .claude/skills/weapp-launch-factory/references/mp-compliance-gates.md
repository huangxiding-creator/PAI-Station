# 微信小程序提审合规门全集（血泪实证版）

来源：总包AI顾问（WeAppForge/projects/zongbao-ai + services/qianwen-engine）0.7.4 拒审 → 0.7.6 提审成功全弧线。实证基座=`E:\AI-Station\WeAppForge\work\bootsim_v3.py`（BOOT-SIM 241/241）+ `E:\AI-Station\services\qianwen-engine\`。本文所有检查名照抄 bootsim 原字符串，所有代码片段摘自真实文件。

## 0. 总原则：可证成口径（一切宣传语须能举证；夸大=驳回）

**简述**：审核员与广告法的共同问题是「你能证明吗」。每句对外文案都要么有事实支撑、要么降级到可证成的中性表述。本项目把这条固化为检查名：`hero 口径=AI 检索行业知识库生成（可证成）`。

| 原文案 | 问题 | 可证成改法（实证） |
|---|---|---|
| 10年沉淀 | 无法举证的资历宣称 | `持续建设`（检查名：`zhiku 说法=持续建设（夸大宣传归零）`，"10年沉淀" 反向断言） |
| 顶级总包智库 | 极限词（广告法9条） | `AI 检索行业知识库`（ask hero / home.wxml / answer.js 同一串口径三处统一） |
| 病毒环/裂变增长 | 诱导性增长措辞 | 中性注释（见门 2） |
| 7×24 服务 | 时限承诺无法举证 | 删除（`ask hero 无 7×24 时限承诺`） |

**坑**
- 表象：文案「听起来有气势」就上线。
- 根因：宣传口径与可举证事实脱节；审核对抗审查（本项目 1001 合规对抗审查产出 8 confirmed）专门盯这个。
- 修法：每个对外名词问一句「证据在哪」；答不出就换成机制描述（做什么）而非效果宣称（有多好）。

**配方**（bootsim 真实片段，正向+反向双断言）：
```python
check("hero 口径=AI 检索行业知识库生成（可证成）",
      "AI 检索行业知识库" in ask_wxml and "AI 检索行业知识库" in read("pages/home/home.wxml")
      and "顶级" not in pot_wxml)
check("zhiku 说法=持续建设（夸大宣传归零）", "持续建设" in read("pages/zhiku/zhiku.wxml") and "10年沉淀" not in read("pages/zhiku/zhiku.wxml"))
```

## 1. AI 生成内容显著标识门

**简述**：0.7.4 拒审唯一根因（audit_id=599847676 失败原因1）=《关于"人工智能生成合成内容需增加显著标识"公告》（代码注释里留档公告号 000ce4a4）。凡 AI 生成内容触达用户的每个面——首屏、正文、追问、公开列表、弹窗、协议、跳板页、导出物、分享海报——都要有显著标识。0.7.5+ 补标识后 0.7.6 于 2026-10-02 10:12:15 提审成功（提交时点状态=审核中；结果以审核回执为准）。记忆档案记账「12 前端位+2 海报位」；按当前代码 grep 逐位核得 10 处用户可见前端位+2 处海报位，合计 12 处显著标识：

| # | 位置 | 真实实现（文件:行） | 标识文案 |
|---|---|---|---|
| 1 | ask 首屏常驻 | pages/ask/ask.wxml:41-44（ai-flag） | 本服务内容由人工智能（AI）生成，仅供参考，不构成专业意见 |
| 2 | answer 页首常驻 | pages/answer/answer.wxml:23-27（ai-flag） | 本回答内容由人工智能（AI）生成，仅供参考，不构成专业意见 |
| 3 | answer 正文卡尾 | pages/answer/answer.wxml:228-229（ai-note） | 内容由 AI 生成 · 仅供参考，不构成专业意见 · 重要事项请咨询具备资质的专业人士 |
| 4 | answer 追问尾 | pages/answer/answer.wxml:306（fu-ai-note） | 追问回答同样由 AI 生成 · 仅供参考 |
| 5 | pot 页首常驻 | pages/pot/pot.wxml:18-21（ai-flag） | 本展区问答内容由人工智能（AI）生成 · 仅供参考 |
| 6 | pot 列表尾 | pages/pot/pot.wxml:81（pot-ai-note） | 本展区问答内容由 AI 生成 · 仅供参考 · 发现不当内容可点「举报」 |
| 7 | 首次提问隐私弹窗 | pages/ask/ask.js:222-225 | 本服务解答内容由人工智能（AI）生成，仅供参考。 |
| 8 | 用户协议 | pages/legal/privacy.wxml:19 | 本工具输出的内容由人工智能生成……不构成专业意见或法律意见 |
| 9 | home 跳板页 | pages/home/home.wxml:7 | 专业解答 · AI 检索行业知识库生成 |
| 10 | 导出 Markdown 尾注 | pages/answer/answer.js:310 | *由 总包AI顾问（AI 检索行业知识库生成）生成 · 仅供参考，不构成正式法律意见* |
| 11 | 海报行动卡 | services/qianwen-engine/.../poster.py:211 | 内容由 AI 生成 · 仅供参考（渲进图片本体） |
| 12 | 海报页脚 | poster.py:231 | 内容由 AI 生成 · 仅供参考，不构成正式法律意见（渲进图片本体） |

关键设计：标识**常驻**且覆盖**全状态**——生成中/正文/追问都可见（ask.wxml:23 注释原话「常驻，生成中/正文/追问全状态可见」），不是埋在折叠里。

**坑**
- 表象：提审驳回，失败原因指向「人工智能生成合成内容需增加显著标识」。
- 根因：只在答案正文尾部放了一行小字；海报图、公开列表（锅圈）、追问流、弹窗、导出物都是 AI 内容触达面却无标识；图片类内容无法靠 DOM 检查发现缺标识，必须渲进图片本体。
- 修法：按「触达面清单」逐面补（上表 12 位）；海报用绘图库把文字直接画进 PNG；每处进 bootsim 断言防回退。

**配方**（真实片段）：
```xml
<!-- pages/ask/ask.wxml:41（源文件注释照抄） -->
<!-- v0.7.5 深度合成合规：AI 生成内容显著标识（首屏常驻，公告 000ce4a4 要求） -->
<view class="ai-flag rise" style="animation-delay: 45ms">
  <view class="ai-flag-badge">AI</view>
  <view class="ai-flag-text">本服务内容由人工智能（AI）生成，仅供参考，不构成专业意见</view>
</view>
```
```python
# poster.py:211 / 231 —— 海报标识渲进图片本体
d.text((104, cy0 + 204), "内容由 AI 生成 · 仅供参考", font=f_cap, fill=MIST)
d.text((M, 1276), "内容由 AI 生成 · 仅供参考，不构成正式法律意见", font=f_foot, fill=INK_SOFT)
```
```python
# bootsim B 组断言（检查名照抄）
check("answer 正文卡常驻 AI 生成标识", "内容由 AI 生成" in ans_wxml and "ai-note" in ans_wxml)
check("answer 追问卡 AI 标识", "追问回答同样由 AI 生成" in ans_wxml)
check("pot 锅圈 AI 标识（公开展示面）", "内容由 AI 生成" in pot_wxml and "pot-ai-note" in pot_wxml)
```

## 2. 诱导分享门

**简述**：运营规范 3.2.1——「分享行为 + 次数/奖励」=利益诱导，必拆。0.7.6 合规终版把「分享 +1 次」激励整体下线：分享钮保留 `open-type="share"` 纯系统分享，赠次只留**真实互动**三动作（有用/纠错/共享入锅圈），判据=`ans_js.count("this._reward(") == 3`。

| 形态 | 合规性 | 实证 |
|---|---|---|
| 分享按钮 open-type=share，无奖励 | 合规（纯功能） | answer.wxml 分享小钮 `open-type="share"` |
| 分享 → 送次数/解锁 | 违规（3.2.1 利益激励） | 0.7.5 前的 shareReward 已删（`api optimize 客户端（shareReward 已随分享激励下线）`） |
| 写具体纠错意见 → +1 次 | 可用（真实互动） | `answer 纠错须写具体意见（必填才赠次）`——空文本 toast「写点具体意见才能领次数哦」不赠 |
| 点「有用」→ +1 次 | 可用（真实互动） | like → granted → `_reward('「有用」是给同行的掌声')` |
| 共享进锅圈 → +1 次 | 可用（真实互动+公开贡献） | onShareOn → api.shareOn → `_reward('共享进锅圈，帮到更多同行')` |
| 分享文案含「转发后领奖」暗示 | 违规 | 检查名：`answer 互动二动作文案（有用/纠错，v0.7.6 分享激励下线）`——"/ 分享" 与 "导出 —— " 字样反向断言归零 |

**坑**
- 表象：功能上线时加「分享送次数」拉传播，提审被驳或上线后被举报下架。
- 根因：把增长杠杆建在利益激励上，踩 3.2.1；连带文案（「分享领次数」）与代码注释（「双病毒环」）都会被对抗审查揪出。
- 修法：激励只挂真实互动动作；分享路径纯化；连注释一起中性化（`answer 分享回流注释中性（无病毒环措辞）`——断言「携带小程序入口」存在且「病毒」不存在）。

**配方**（真实片段）：
```javascript
// pages/answer/answer.js —— 纯分享，无任何赠次钩子
onShareAppMessage() {
  // 用户令 v0.5.0：分享标题统一为「总包AI顾问-免费咨询」
  return { title: '总包AI顾问-免费咨询', path: '/pages/answer/answer?id=' + this.data.id };
}
```
```python
# bootsim 判据：赠次调用点计数=3（有用/纠错/共享），分享/导出零挂钩
check("answer 赠次只在真实互动（v0.7.6：有用/纠错/共享入锅圈三动作，无分享导出赠次）",
      ans_js.count("this._reward(") == 3 and "onExport" in ans_js)
check("answer.js 无 exportReward 调用", "exportReward" not in ans_js)
check("answer 分享回流注释中性（无病毒环措辞）", "携带小程序入口" in ans_js and "病毒" not in ans_js)
```

## 3. 极限词与夸大宣传门

**简述**：广告法 9 条（「顶级」类极限用语）/28 条（虚假宣传）。做法=全包 walk 扫描禁词 + 服务范围措辞降级。bootsim A 组用 os.walk 遍历全部 js/wxml/wxss/json，禁词零命中才过。

**禁词扫描清单（实证集）**：`顶级`、`病毒`、`裂变`、`法务`、`诉讼`（服务范围声明位）、`7×24`（时限承诺位）、`10年沉淀`（资历宣称位）、`工程大脑`（改名后的旧口径残留）。

**坑**
- 表象：某页角落一句「顶级体验」或注释里「裂变拉新」。
- 根因：极限词不只活在文案里——注释、旧变量名、被注释掉的代码同样会被审到；且「法务/诉讼」字样会让类目审核按法律咨询服务对待（见门 6）。
- 修法：walk 全包字符扫描（不放过任何扩展名内的命中），命中即改；改名功能（工程大脑→总包智库）要全局归零断言。

**配方**（真实片段，全包 walk 范式）：
```python
_jurisdiction_hits = []
for _base, _dirs, _files in os.walk(ROOT):
    for _fn in _files:
        if _fn.rsplit(".", 1)[-1] in ("js", "wxml", "wxss", "json"):
            _p = os.path.join(_base, _fn)
            try:
                _src = open(_p, encoding="utf-8").read()
            except Exception:
                continue
            if "顶级" in _src or "病毒" in _src or "裂变" in _src:
                _jurisdiction_hits.append(os.path.relpath(_p, ROOT))
check("极限词/敏感增长措辞全局归零（顶级/病毒/裂变）", not _jurisdiction_hits, str(_jurisdiction_hits))
check("ask hero 无「法务/诉讼」服务范围声明", "法务" not in ask_wxml and "诉讼" not in ask_wxml)
check("ask hero 无 7×24 时限承诺", "7×24" not in ask_wxml and "7×24" not in my_wxml)
```

## 4. 隐私合规门

**简述**：隐私保护指引与实际采集必须一致；静默登录收集 openid 须明示用途。四件套：legal 协议页 + 首次提问告知弹窗 + my 页入口 + 运行时实证（wx.getPrivacySetting 契约名比对）。

| 检查点 | 判据（bootsim 检查名照抄） |
|---|---|
| legal 页四件套 | `legal 页四件套存在`（js/wxml/wxss/json） |
| 协议双区块+openid 明示 | `legal 页含用户协议+隐私政策双区块` |
| 首次使用告知门 | `ask 首次提问隐私告知（qw_privacy_ok 门）` |
| my 页入口 | `my 页用户协议·隐私政策入口`（goPrivacy） |
| 剪贴板声明 | privacy.wxml:33-34「三、剪切板」区块：仅主动点击时写入、不读取 |
| 运行时实证 | wx.getPrivacySetting 契约名 live 比对 + setClipboardData 通过=剪贴板已声明（0.7.6 提审前实证） |

**坑**
- 表象：隐私指引勾了「不收集」但代码里 wx.login 换 openid、setClipboardData 在跑；或指引声明了剪贴板但实际没用到（过度声明）。
- 根因：声明与实现两张皮；静默登录最容易漏——用户无感知≠免告知。
- 修法：①静态：把每项采集 API 写进指引并互相对账；②运行时：模拟器真实调 wx.getPrivacySetting 比对契约名列表，实际触发 setClipboardData 验证不弹拦截。

**配方**（真实片段）：
```xml
<!-- pages/legal/privacy.wxml:30（openid 静默登录明示原文） -->
为提供服务，我们在小程序启动时通过微信官方登录接口获取您的微信登录凭证（openid），
用于识别账号与咨询额度记账（该凭证不含您的手机号等敏感身份信息）；同时收集：
① 您主动提交的问题文本、纠错意见，用于生成与改进回答；
② 您自愿共享的问答内容，用于锅圈公开展示。
我们不收集您的手机号、位置、通讯录、相册等个人信息。
```
```javascript
// pages/ask/ask.js:218-235 —— 首次提问前隐私告知门（同意一次记忆，拒绝则不发起登录）
if (!wx.getStorageSync('qw_privacy_ok')) {
  wx.showModal({
    title: '隐私保护告知',
    content: '为提供咨询服务，我们将通过微信登录获取您的 openid 用于额度记账，'
      + '并将您提交的问题与生成的回答存储在服务器；您自愿共享的问答将在「锅圈」公开展示，可随时取消共享。'
      + '本服务解答内容由人工智能（AI）生成，仅供参考。'
      + '详见「我的 · 用户协议与隐私政策」。',
    confirmText: '同意并继续', cancelText: '不同意',
    success: (r) => { if (!r.confirm) return; wx.setStorageSync('qw_privacy_ok', 1); this._doSubmit(q); }
  });
  return;
}
```
```python
check("ask 首次提问隐私告知（qw_privacy_ok 门）", "qw_privacy_ok" in ask_js and "隐私保护告知" in ask_js)
```

## 5. UGC 内容安全门

**简述**：用户内容一旦公开展示（锅圈=共享问答展区），双闸必上：前端举报入口 + 服务端 security.msgSecCheck v2 预检，且安检 API 异常时 fail-closed（宁可拒共享不放行）。session_key 不落盘。

| 层 | 实现 | 判据 |
|---|---|---|
| 前端举报 | pot.wxml `catchtap="onReport"`（catchtap 防冒泡）+ 必填原因 | `pot 举报入口（onReport + catchtap 防冒泡）`、`pot 举报必填原因`（「请填写举报原因」） |
| 客户端 API | utils/api.js potReport | `api potReport 客户端` |
| 服务端安检 | wechat.py `msg_sec_check()` v2（scene=2 评论场景） | `服务端 msg_sec_check v2 实现`（`msg_sec_check` + `"version": "2"`） |
| 入库前闸 | app.py share_on：question 与 answer_full 双检 | `share_on 入库前过安检门（fail-closed 503）` |
| 举报端点 | `/api/pot/report`（每用户每条限一次，无奖励） | `服务端 pot 举报端点` |
| 凭据卫生 | session_key 不再落盘 | `session_key 不再落盘`（`save_session` not in app.py） |

**坑**
- 表象一：安检 API 偶发挂→图省事 catch 后放行内容入库。
- 根因：把可用性置于安全之上；UGC 一旦展出违规内容，责任在小程序方。
- 修法：fail-closed——异常抛 RuntimeError → 调用方转 503「内容安全检测暂不可用，请稍后再试」；不通过转 400「内容未通过安全检测，暂不能共享」。
- 表象二：举报按钮点按触发列表项跳转（事件冒泡）。
- 根因：bindtap 冒泡到父容器。
- 修法：`catchtap`。bootsim 断言里专门写死这一字形。

**配方**（真实片段）：
```python
# services/qianwen-engine/qianwen_engine/wechat.py:148-176
def msg_sec_check(content: str, openid: str, scene: int = 2) -> bool:
    """security.msgSecCheck v2：UGC 公开展示门（v0.7.4 提审合规）。

    scene=2 评论场景；openid 须为本小程序用户（共享者本人）。
    返回 True=通过（suggest=pass）；review/risky → False；
    API 异常抛 RuntimeError（调用方 fail-closed，宁可拒共享不放行）。"""
    text = (content or "").strip()
    if not text:
        return True
    ...
        r = cr.post(
            "https://api.weixin.qq.com/wxa/msg_sec_check?access_token=" + _access_token(),
            json={"content": text[:2500], "version": "2", "scene": scene, "openid": openid},
            impersonate="chrome", timeout=15,
        )
    ...
    return result.get("suggest") == "pass"
```
```python
# services/qianwen-engine/qianwen_engine/app.py:284-301 —— 入库前双检 + fail-closed
@app.post("/api/answer/{aid}/share_on")
def share_on(aid: str, request: Request):
    """本人的已完成问答 → 共享进锅圈（公共展区）+ 赠 1 次咨询机会。
    v0.7.4 提审合规：入库前过 security.msgSecCheck（UGC 公开展示门，fail-closed）。"""
    ...
    try:
        ok_q = wechat.msg_sec_check(row["question"], openid)
        ok_a = wechat.msg_sec_check(row["answer_full"], openid)
    except Exception as exc:  # noqa: BLE001
        raise HTTPException(503, "内容安全检测暂不可用，请稍后再试") from exc
    if not (ok_q and ok_a):
        raise HTTPException(400, "内容未通过安全检测，暂不能共享")
```

## 6. 类目与资质门

**简述**：服务范围措辞决定审核按哪个类目对待你。出现「法务/诉讼/法律咨询」字样→按法律咨询服务→需要律所资质，个人/一般企业主体拿不出=驳回。修法=措辞降级到「信息参考工具」。

| 禁/慎用 | 降级为（实证口径） |
|---|---|
| 法务、诉讼（服务范围声明） | 工程领域信息参考工具（privacy.wxml:19 原文「工程领域信息参考工具」） |
| 法律意见 | 「不构成专业意见或法律意见；重要事项请咨询具备相应资质的专业人士」（ai-note/协议/海报页脚三处统一） |
| 智库资历宣称 | AI 检索行业知识库（机制描述） |

**坑**
- 表象：内容明明是工程问答，审核却要求提交法律类目资质材料。
- 根因：hero/协议里出现「法务」「诉讼」「法律意见」等字样，触发类目重判。
- 修法：免责口径标准化——每处 AI 标识同时带「不构成专业意见/法律意见+请咨询具备资质的专业人士」双句；服务范围只写「信息参考」。

**配方**：
```python
check("ask hero 无「法务/诉讼」服务范围声明", "法务" not in ask_wxml and "诉讼" not in ask_wxml)
```

## 7. 提审表单六项核对单（mp 控制台，Vue 单页）

0.7.6 实证填法（版本描述 184/200，2026-10-02 10:12:15 提交成功）：

| 项 | 填法 | 要点 |
|---|---|---|
| 版本描述 | ≤200 字，**必须提及 AI 标识**（「所有 AI 生成内容均有显著标识」类语句）+ 主要功能 | textarea 用原生 setter+input 事件喂 Vue v-model；counter 显示 184/200 且**回读一致才算吃进** |
| 测试账号 | 无需登录（若需登录则必须给测试账号） | 本项目静默 openid 登录=审核员可直接体验 |
| 企业微信 | 否 | — |
| 隐私采集 | 采集用户隐私 | 与门 4 指引一致 |
| 订单 path | 空（无虚拟支付/电商则空） | — |
| 加急 | 只能在提交时选，过后不可补 | 默认不加急 |

流程：须知弹窗（checkbox 单击后**必验 `cb.checked`**——input+label 双匹配会翻成不勾）→ 安全测试提醒→继续提交 → 主表单 → 提交按钮是 `<a class="btn btn_primary">` **非 button 元素** → 页面回「已提交审核」。

**坑（mp 控制台自动化三坑，实证）**
- 表象一：XPath text() 匹配按钮失明。
- 根因：翻译扩展把按钮文本包进 `<span data-component="translate">`。
- 修法：真按钮=文本 span 的 `closest('button')`。
- 表象二：同 tick 连点 checkbox+下一步，第二步没反应。
- 根因：Vue 一帧只消化一次状态变更。
- 修法：分两次 eval。
- 表象三：点「选为体验版」误点进危险切换对话框。
- 根因：用祖先遍历定位按钮，命中了别版本行的按钮。
- 修法：`.code_version_log` 块内按版本号文本锚定。

**提审前三线终验（定型）**：①API 面 401 fail-closed 探针；②模拟器六页 walk 0 错误；③额度链 login→token→quota 200。

## 8. 每门的 bootsim 断言范式（需求即测试）

**简述**：合规要求不写成文档就烂掉——写成 `check()` 进版本门，每次上传前全量跑（0.7.6 时 241/241）。范式四型：

| 型 | 用法 | 实例（检查名照抄） |
|---|---|---|
| 字面存在 | 关键文案/类名/函数名 in 源 | `answer 正文卡常驻 AI 生成标识` |
| 字面反向 | 危险词 not in 源 | `ask hero 无 7×24 时限承诺` |
| 全包 walk 归零 | os.walk 扫禁词，命中列表进 detail | `极限词/敏感增长措辞全局归零（顶级/病毒/裂变）`、`工程大脑字眼全局归零（→总包智库）` |
| 计数判据 | 调用点精确计数 | `answer 赠次只在真实互动`（`count("this._reward(") == 3`） |

**坑**
- 表象：合规修完一版，下个迭代悄悄回退（文案改掉/按钮加回）。
- 根因：合规靠人记忆不靠机器。
- 修法：每门至少一条反向断言（禁止物）+一条正向断言（必须物）；跨文件依赖（服务端闸）也进同一套 bootsim——直接 open 引擎源文件断言（`_wx_py`/`_app_py`），前后端合规一张卷子。

**配方**（骨架，可直接扩）：
```python
def check(name, cond, detail=""):
    checks.append((name, bool(cond), detail))

# 跨仓断言：服务端安检闸与前端同卷
ENGINE = r"E:\AI-Station\services\qianwen-engine"
_wx_py = open(os.path.join(ENGINE, "qianwen_engine", "wechat.py"), encoding="utf-8").read()
_app_py = open(os.path.join(ENGINE, "qianwen_engine", "app.py"), encoding="utf-8").read()
check("服务端 msg_sec_check v2 实现", "msg_sec_check" in _wx_py and '"version": "2"' in _wx_py)
check("share_on 入库前过安检门（fail-closed 503）",
      "msg_sec_check" in _app_py and "内容未通过安全检测" in _app_py and "503" in _app_py)
check("session_key 不再落盘", "save_session" not in _app_py)

fails = [c for c in checks if not c[1]]
for name, ok, detail in checks:
    print(("PASS " if ok else "FAIL ") + name + (("  " + detail) if detail and not ok else ""))
print(f"\nBOOT-SIM: {len(checks) - len(fails)}/{len(checks)} PASS")
sys.exit(1 if fails else 0)
```

发布后一行令（勿忘）：海报码环境 trial→release（config.py POSTER_QR_ENV_VERSION + ECS + CloudBase 同步改），否则正式版海报扫出旧体验版。

---
源文件索引：`E:\AI-Station\WeAppForge\work\bootsim_v3.py`（断言库）｜`E:\AI-Station\services\qianwen-engine\qianwen_engine\wechat.py` / `app.py` / `poster.py`（服务端闸与海报标识）｜`E:\AI-Station\WeAppForge\projects\zongbao-ai\pages\{ask,answer,pot,my,legal,home}\`（前端 12 标识位）。
