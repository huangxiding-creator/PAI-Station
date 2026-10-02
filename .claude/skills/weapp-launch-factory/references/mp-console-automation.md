# 微信公众平台控制台自动化配方（Vue 动态页实操血泪版）

> 适用：mp.weixin.qq.com 控制台（Vue 单页应用）。场景=提审向导 / 选体验版 / 加合法域名 /
> 查审核状态等一切控制台操作。1002 全链实测（0.7.6 提交审核三步向导全过）。
> 配套工具：Chrome MCP（`mcp__plugin_superpowers-chrome_chrome__use_browser`）。

## 0. 铁律（先读这个再动手）

1. **浏览器与用户共享**——动手前必 `list_tabs` 确认目标标签页 index，绝不扰动用户标签页；
   标签页会随用户开/关漂移（index 0→1→2），每次 eval 前重新确认。
2. **绝不用 XPath `text()` 匹配按钮文本**——翻译扩展会把文本包进
   `<span data-component="translate">`，XPath text() 对它失明（详见 §1）。
3. **同一次 eval 里绝不连点 checkbox+按钮**——Vue 来不及 digest，第二步白点（§3）。
4. **「选为体验版」绝不能用祖先遍历定位**——曾因此误点 0.4.2 行的按钮弹出危险切换
   对话框。正解=按版本号文本锚定所在 `.code_version_log` 块（§6）。
5. 每步 click 后必须**回读 DOM 验证状态变了**，没变≠成功。

## 1. 找真按钮：翻译扩展 span 包裹（头号坑）

**表象**：`els[j].textContent.trim()==='下一步'` 能匹配到 span，点它无反应；
XPath `//button[text()="下一步"]` 匹配为空。

**根因**：浏览器翻译扩展把按钮文本包进
`<span data-component="translate">下一步</span>`，文本节点不再是 button 的直接子节点。

**配方（照抄级）**：按「自有文本节点」找 span，再 `closest` 上溯真按钮：

```javascript
// 在页面上下文 eval：找文本为 txt 的元素所在的真按钮
var txt = '下一步';
var spans = document.querySelectorAll('span, a, button');
var hit = null;
for (var i = 0; i < spans.length; i++) {
  var el = spans[i];
  // 自有文本节点（childNodes 里有 nodeType===3 且非空白）才算"自己写着这几个字"
  var own = false;
  for (var k = 0; k < el.childNodes.length; k++) {
    var n = el.childNodes[k];
    if (n.nodeType === 3 && n.textContent.trim() === txt) { own = true; break; }
  }
  if (own) {
    var real = el.closest('button') || el.closest('a');
    if (real) hit = real; // 后命中者更深层，循环继续取最深的
  }
}
if (hit) { hit.setAttribute('data-wf-real', '1'); 'MARKED'; } else { 'NOT_FOUND'; }
```

然后 Chrome MCP `click` 用 `button[data-wf-real]`（或 `a[data-wf-real]`）选器，
**trusted click** 比 eval `.click()` 可靠（部分 Vue 监听只认 trusted 事件）。

注意：页面里同文案按钮可能有多层 wrapper 共享（嵌套容器），取**最深命中**。

## 2. 判断弹窗/元素可见性

mp 控制台把隐藏对话框**预渲染**在 DOM 里（`display:none` 的也在），querySelector
一抓一堆。可见性判据：

```javascript
el.offsetParent !== null   // 真·可见（display:none 时为 null）
```

嵌套 wrapper 可达 4 层深，按钮可能只在外层 wrapper——内层找不到时向
`closest('.xxx-dialog')` 外层找。

## 3. checkbox 勾选（提审向导第一步：同意须知）

**表象**：querySelector 'input[type=checkbox]' 与 label 双双命中，循环 click 三次后
反而没勾上。

**根因**：input 和 label 都绑了 toggle，一次「点击」被算成多次切换。

**配方**：只 click 一次，然后**立即验证**：

```javascript
var cb = document.querySelector('input[type=checkbox]');
cb.click();            // eval 一次
// —— 下一次 eval（分开！）——
document.querySelector('input[type=checkbox]').checked   // 必须为 true 才算勾上
```

**同 tick 禁忌**：勾选 checkbox + 点「下一步」必须拆成**两次独立 eval 调用**——
同一次 eval 里连做，Vue 不消化，第二步白点（1002 实锤：对话框纹丝不动，
拆开后即通）。

## 4. textarea 填值喂 Vue v-model（提审表单·版本描述）

**表象**：`ta.value = txt` 赋值后输入框计数器不动，提交时 Vue data 里还是旧值。

**根因**：Vue v-model 监听 input 事件，直接改 value 属性不触发。

**配方（原生 setter + 派发事件，照抄级）**：

```javascript
var ta = document.querySelector('textarea');   // 见 §4b 的选坑
var txt = '……版本描述全文……';
var setter = Object.getOwnPropertyDescriptor(window.HTMLTextAreaElement.prototype, 'value').set;
setter.call(ta, txt);
ta.dispatchEvent(new Event('input', { bubbles: true }));
ta.dispatchEvent(new Event('change', { bubbles: true }));
// 验证：计数器文本必须与字数一致（如 184/200）
(document.querySelector('.counter,.text-counter') || {}).textContent
```

**吃进判据**：counter 文本（如「184/200」）与回读 `ta.value.length` 一致才算 Vue
吃进；不一致=白填，重来。

### 4b. textarea 选择器坑（备案表单同款）

页面常藏**隐藏 JSON 槽 textarea**（存表单草稿的），`querySelector('textarea')`
首匹配可能命中它——文本误灌进 JSON 槽，提交硬卡。

**配方**：用 placeholder 匹配真身（ICP 备案表单实测）：

```javascript
var tas = document.querySelectorAll('textarea');
var real = null;
for (var i = 0; i < tas.length; i++) {
  var ph = tas[i].getAttribute('placeholder') || '';
  if (ph.indexOf('请根据实际情况填写') >= 0) { real = tas[i]; break; } // 按真 placeholder 文案锚定
}
```

## 5. 提审三步向导全链（1002 实测全通）

```
入口：版本管理 → 开发版本 → 提交审核
┌─ 第1步 须知弹窗：checkbox 勾选（§3 两段式）→「下一步」（§1 真按钮）
├─ 第2步 安全测试提醒弹窗：「继续提交」
└─ 第3步 主表单整页（URL 出现 get_class?action=get_class 参数即到达）：
     ├─ 类目确认（如已设好不动）
     ├─ 版本描述 textarea（§4 配方；≤200 字，见下方模板）
     ├─ 测试账号 = 无需登录（登录即用的公益工具选这个）
     ├─ 企业微信 = 否
     ├─ 隐私 = 采集用户隐私（若采集了 openid）
     ├─ 订单中心 path 留空（非交易类）
     ├─ 审核加急 = 只能在此处选，提交后无法改（免费加急额度在此用）
     └─ 提交按钮是 <a class="btn btn_primary">（不是 <button>！§1 配方天然覆盖 a）
        → 先 scrollIntoView 再 click
终验：页面回「已提交审核」+ 版本页显示「审核版本 0.7.x · 审核中 · 时间戳」
```

**版本描述模板（184/200 实测过审待验，AI 类必含标识说明）**：
> 工程行业免费公益问答工具，无付费项。测试路径：微信登录后首页输入工程问题（如
> "EPC合同工期延误怎么索赔"），AI流式生成解答；要点速览、依据来源、继续追问均免费。
> ×××为用户自愿共享的公开问答展区，已接内容安全检测并提供举报入口。本次更新：所有
> AI生成内容处已加显著标识（含导出海报），分享激励已下线。收集信息仅微信openid与
> 提问内容。无需测试账号，微信登录即用。

要点：功能怎么测 / AI标识整改说明 / 收集了什么 / 测试账号说明——四件必写。

## 6. 「选为体验版」安全定位（危险操作！）

**事故实录**：用祖先遍历（`closest` 从某按钮向上找行）定位「选为体验版」，误命中
0.4.2 历史行的按钮，弹出危险切换对话框。

**配方**：以**目标版本号文本**锚定其所在版本块，再在块内找按钮：

```javascript
var blocks = document.querySelectorAll('.code_version_log');   // 版本记录块
var target = null;
for (var i = 0; i < blocks.length; i++) {
  if (blocks[i].textContent.indexOf('0.7.6') >= 0) { target = blocks[i]; break; }
}
// 在 target 内找「选为体验版」按钮（§1 自有文本节点配方，作用域限 target）
```

## 7. 审核状态查询（⚠ API 死路实锤，走控制台/手机推送）

**`get_latest_auditstatus` 仅第三方平台可调**——自管理小程序用自家 appsecret
换 token 后调用回 `errcode 86000 "should be called only from third party"`
（2026-10-02 实测）。别再往这条路写监视器；且该接口是 GET（POST 回 43001）。

自管理小程序查审核状态的两条真通道：

1. **管理员手机推送（主通道，零成本）**：审核结果出来微信「公众平台安全助手」
   直接推到管理员手机——用户永远比我先知道。
2. **控制台 UI（自动化通道）**：mp.weixin.qq.com 版本管理页看「审核中/通过/被拒」
   + 被拒时的失败原因（0.7.4 的 audit_id+失败原因即从控制台通知拿到）。
   长效监视=会话级 durable cron 每 3h 跑一轮浏览器探查（先 list_tabs 确认浏览器
   空闲，忙则静默收队；审核中只记日志不扰用户，状态变化才上报）。

若仍想留 API 探针（如未来接第三方平台代管）：云助手 inline 探针读 secret 时注意
secret 文件多为 `appid=…/appsecret=…` 多行键值且 CRLF——`cat` 整读必挂，
须 `sed -n 's/^appsecret=//p' 文件 | head -1 | tr -d '\r\n'`。

## 8. 其他控制台操作备忘

- **request 合法域名**：`modify_domain` API 对自有 appid 回 40014——**只能控制台手加**
  （开发管理→开发设置→服务器域名）。自动化到此为止，此步留给用户或 UI 自动化。
- **第三方插件添加**（如 WechatSI）：设置→第三方设置→插件管理，加完才允许 app.json
  声明（未加先声明=传包被拒）。验证铁证=上传回包 `pluginInfo` 带插件本体字节数。
- 控制台是 Vue 动态页：URL 不随内部导航变，别用 navigate 直达深层页——从入口页
  逐步点击进。
