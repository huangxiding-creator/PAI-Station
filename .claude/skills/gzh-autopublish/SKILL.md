---
name: gzh-autopublish
description: 微信公众号三号自动发表全链（cookie 管理/UI 草稿投递/发表确认）。当用户要发布公众号文章、推送宣传文到3个公众号、管理公众号草稿、或公众号 API 404 时使用。触发词：公众号发布、发文、三号发布、宣传文推送、草稿投递、mp.weixin 逆向。
---

# 公众号三号自动发表全链

2026-11-18 实战全通（首单「电力行业技术规范标准」三号齐发）。三号：acct01总包说/acct05工程行业大脑/acct07总包之声。

## 全链流程（五段）

```
① 登录: DrissionPage 载 autopub profile → mp.weixin.qq.com → 扫码 → cookie+token 落盘
② 素材: POST /cgi-bin/filetransfer?action=upload_material&scene=1  (filetransfer 是唯一活口!)
③ 草稿: UI 剪贴板投递（CF_HTML 正文 + DIB 图片）
④ 标题: JS 注入 title 输入框
⑤ 发表: UI 点「发表」→确认框→「群发成功」
```

## 坑与解（全部实锤）

| 坑 | 解 |
|---|---|
| `material/add_material`、`media/uploadimg`、`draft_add`、`freepublish` 全 404 | 新版关闭。**素材走 `filetransfer?action=upload_material`**（200，返回 content=media_id） |
| `operate_appmsg sub=create ret=0` 假发布 | 那是「新建转载任务」非群发。真发表必须 UI 点「发表」按钮 |
| 标题框 `.input()` 不生效 | **JS 注入**: `run_js('e=document.getElementById("title"); e.value="..."; e.dispatchEvent(new Event("input",{bubbles:true}))')` |
| 发表按钮「该元素没有位置及大小」 | **JS 直点**: `run_js('btns.find(b=>b.textContent.trim()==="发表").click()')` |
| cookie 过期/浏览器停在登录页 | **cookie 重注入**: 读 mp_cred json → set.cookies → get token URL → 登录态恢复（免重扫） |
| DrissionPage 连不上/PageDisconnected | 查 chrome.exe 真实路径（Program Files 而非 AppData）；杀残留 profile chrome；清 Singleton 锁 |
| `ChromiumPage(addr_or_port=)` 报错 | 4.1.1.4 用 `ChromiumOptions().set_local_port(port)` |
| 后台任务 cwd 变 E:\e\... | 命令内用绝对正斜杠路径，勿依赖 cd |
| git bash 吃 `/远端路径` | 命令前缀 `MSYS_NO_PATHCONV=1` |

## 核心脚本（全部在 E:\AI-Station\电力KB收割\，可直接复用改参）

| 脚本 | 功能 |
|---|---|
| `mp_login_all.py` | 三号并排弹码（DrissionPage 载 F:\We-AIPO\autopub\data\browser_profiles\acctXX + 独立口 9341/42/43）→ 扫码 → mp_cred_acctXX.json（cookie+token） |
| `draft_push.py` | API 投草稿（filetransfer+draft_add —— draft_add 已死仅存档） |
| `ui_draft_push.py` | **UI 剪贴板投草稿**（CF_HTML 正文 + win32clipboard DIB 粘贴二维码图 → 自动上传为正文图；保存草稿） |
| `assets/mp_publish_draft.py` | **草稿→群发一键发表腿**（1119 实战：API 入箱稿 → 控制台 UI 发表全链） |
| `publish_done_*.png` | 发表成功页截图样例 |

## 发表腿（草稿→群发，1119 KB宣传第三篇实战固化）

前提：稿已入目标号草稿箱（push_article.py API 路或 ui_draft_push）。然后：

1. **验号**（⚠ profile 映射会漂移！mp_login_all.py 写的映射已过期，1119 实测真身=）
   `acct05@9341=总包之声 ｜ acct01@9342=总包说 ｜ acct07@9343=工程行业大脑`
   死会话用对应 mp_cred_acctXX.json cookie 重注入复活；**发表前必须读首页账号名核对身份**（错号=文章发错公众号）
2. **草稿定位**：活页内同源 XHR `appmsg?action=list_ex&type=77`（勿用文件cookie+活token混浆=陈账假象）；命中 appmsgid
3. **进编辑器**：列表页目标卡悬停 → 点「编辑」tooltip 宿主 A（**新标签页**打开 appmsg_edit）——直拼旧 edit_v2 URL=死白页（按钮永不渲染）
4. **发表**：编辑器 tab 内 JS 点 `发表` 按钮 → 确认框「已开启群发通知」→ 点 **`继续发表`**（精确匹配！`发表`子串匹配点不中）→ 等 ~8s 落「已发表页」
5. **TRUTH**：同源 `appmsgpublish?sub=list` 含目标题名 + 截图取证（零造假）

**编辑器页按钮全集**（找钮时对照）：发表/预览/保存为草稿/返回原草稿；卡片动作=编辑(icon+tooltip)/删除(primary)+取消。

### UI 投递核心代码（剪贴板）
```python
import win32clipboard as clip
def set_clipboard_html(html):  # CF_HTML
    cf = clip.RegisterClipboardFormat("HTML Format")
    # header(Version/StartHTML/EndHTML/StartFragment/EndFragment) + <!--StartFragment-->html<!--EndFragment-->
def set_clipboard_dib(path):   # 图片
    Image.open(path).convert("RGB").save(buf,"BMP"); clip.SetClipboardData(clip.CF_DIB, buf[14:])
# 编辑器: ele('@contenteditable=true').click() → actions.key_down('ctrl').type('v').key_up('ctrl')
```

## API 活口清单（2026-11 实测）

| 接口 | 状态 |
|---|---|
| GET `/cgi-bin/appmsg?action=list_ex&type=77\|10&token=` | ✅ 草稿列表（新草稿在 type=77！） |
| POST `/cgi-bin/filetransfer?action=upload_material&scene=1` | ✅ 素材上传（返回 content=media_id） |
| GET `/cgi-bin/appmsgpublish?sub=list&type=101_1_102_103` | ✅ 发布记录（异步索引有延迟） |
| GET `/cgi-bin/operate_appmsg` | ✅ 老图文列表（AppMsgItemList） |
| POST `/cgi-bin/operate_appmsg?t=ajax-response&sub=create&type=77&a2p_appmsgid=X` | ⚠️ 新建转载任务≠群发 |
| `material/add_material` `media/uploadimg` `appmsg/draft_add` `freepublish` | ❌ 404 |

## 注意
- 群发每日限额（订阅号1次/天）；发表是真实推送，确认目标正确再点
- mp_cred_*.json 含登录 cookie（敏感，gitignore）
- profile 复用 F:\We-AIPO\autopub 的 browser_profiles（Chrome 156 兼容）
