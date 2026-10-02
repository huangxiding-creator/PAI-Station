# 测试与终验体系（BOOT-SIM 版本门 + 三线终验 + 模拟器自测）

范本工程：总包AI顾问（WeAppForge/projects/zongbao-ai + services/qianwen-engine）。
测试金字塔自底向上六层（与文末「层间关系速查」图对应）：服务端 pytest → BOOT-SIM 结构化版本门（包级静态断言）→ CI robot 上传（构建门）→ DevTools 模拟器六页自测 → 提审前三线终验；上线后由真机联调雷达兜底。每层都是 CI 可判据（exit code / 0 错误 / 全绿清单），不是"人眼看看"。

## 1. BOOT-SIM 结构化版本门模式

设计思想：**需求即测试**。每一条用户令、每一次合规要求，都写成一条 `check(name, cond, detail)`；stub 微信环境（纯文件静态断言，不启 DevTools、不碰网络）；结尾 `sys.exit(1 if fails else 0)`，exit 1 即 CI 判据。上传前必须 BOOT-SIM 全绿才允许 robot 上传。

范本：`E:\AI-Station\WeAppForge\work\bootsim_v3.py`（385 行）。骨架三件套照抄即可起步：

```python
ROOT = r"E:\AI-Station\WeAppForge\projects\zongbao-ai"
checks = []

def check(name, cond, detail=""):
    checks.append((name, bool(cond), detail))

def read(path):
    return open(os.path.join(ROOT, path), encoding="utf-8").read()

# ...全部断言...

fails = [c for c in checks if not c[1]]
for name, ok, detail in checks:
    print(("PASS " if ok else "FAIL ") + name + (("  " + detail) if detail and not ok else ""))
print(f"\nBOOT-SIM: {len(checks) - len(fails)}/{len(checks)} PASS")
sys.exit(1 if fails else 0)
```

断言数维护法=**随版本单调增长，只增不删**（老检查除非功能下线否则永续在役）。实测演进线（全部有台账背书）：

| 版本 | 断言数 | 版本 | 断言数 |
|---|---|---|---|
| v0.1 harness | 26 | v0.5.1 | 109/109 |
| v0.4.0 | 59/59 | v0.6.0 | 126/126 |
| v0.4.2 | 67/67 | v0.7.1 | 158/158 |
| v0.5.0 | 98/98 | v0.7.3 | 205/205 |
| — | — | v0.7.6 | 241/241 |

每次新增=新用户令整段落检查（如 0930 v0.7.0 十一点令、1001 v0.7.3 十一点令各有专段——两次「十一点令」同名不同日，勿混），旧段落保留=回归防线（老病复发立即红）。

**坑**（版本标记三处联动漏一处）：
- 表象：BOOT-SIM 绿但传上去的包版本号对不上，版本史错乱（0.7.0 系域名换轨前所传，只能以 0.7.1 为提审对象）。
- 根因：版本号散落 package.json / my 页脚 / bootsim 断言三处，只 bump 一处。
- 修法：版本断言同时钉两处——`check("my 版本标记 v0.7.6", "v0.7.6" in my_wxml)` + `check("package.json version=0.7.6", pkg["version"] == "0.7.6")`，bump 时三处联动。

**配方**（stub 微信环境的最小启动序列——结构断言先落地，再叠需求断言）：

```python
app_json = json.load(open(os.path.join(ROOT, "app.json"), encoding="utf-8"))
check("app.json pages 七页（问/锅/智/答/我+legal+home 兼容）", app_json["pages"] == [
    "pages/ask/ask", "pages/pot/pot", "pages/zhiku/zhiku", "pages/answer/answer",
    "pages/my/my", "pages/legal/privacy", "pages/home/home"])
check("app.json 入口页仍是 ask（第一位）", app_json["pages"][0] == "pages/ask/ask")
check("app.json tabBar.custom=true", app_json["tabBar"].get("custom") is True)
check("app.json lazyCodeLoading", app_json.get("lazyCodeLoading") == "requiredComponents")

for p in app_json["pages"]:
    wxml = read(p + ".wxml")
    js = read(p + ".js")
    json_ = json.load(open(os.path.join(ROOT, p + ".json"), encoding="utf-8"))
    check(f"{p} json navigationStyle=custom", json_.get("navigationStyle") == "custom")
    check(f"{p} js Page() 工厂", "Page({" in js)
    for binder in re.findall(r'bindtap="(\w+)"', wxml):
        check(f"{p} wxml bindtap:{binder} 在 js 有实现", binder in js, binder)
    check(f"{p} nav 绑定存在", "nav.statusBarHeight" in wxml)
```

## 2. 断言分类学

BOOT-SIM 的 241 条断言分四类，写新检查时先归类再动笔：

| 类别 | 断言对象 | 代表检查（原字符串照抄） | 手法 |
|---|---|---|---|
| 结构断言 | app.json 页表/路由/tabBar/四件套 | `app.json pages 七页（问/锅/智/答/我+legal+home 兼容）`、`app.json tab2=智库 tab3=我的（锅圈居中）`、`custom-tab-bar/index.{ext} 存在` | json.load 精确等值 / os.path.exists |
| 行为断言 | wxml 事件绑定在 js 有实现 | `{p} wxml bindtap:{binder} 在 js 有实现`、`ask AI优化提问按钮+实现`、`answer 导出/纠错实现齐（onCopy 已删）` | re.findall(bindtap) 逐个 `in js` |
| 卫生断言 | 全包归零扫描 | `工程大脑字眼全局归零（→总包智库）`、`包内零老标讯/哈萨藏字样`、`复制全文/onCopy 全局归零（zhiku 复制链接除外）`、`极限词/敏感增长措辞全局归零（顶级/病毒/裂变）` | os.walk(ROOT) 后缀过滤 (js/wxml/wxss/json/wxs) 逐文件读 |
| 契约断言 | 前后端路由对齐 | `api followup/followups/digest/poster 四端点`、`服务端 msg_sec_check v2 实现`、`服务端 pot 举报端点` | 同时读小程序 utils/api.js 与引擎源码字符串互证 |

卫生断言的全包扫描模板（注意 try/except 跳过编码异常文件）：

```python
_brain_hits = []
for _base, _dirs, _files in os.walk(ROOT):
    for _fn in _files:
        if _fn.rsplit(".", 1)[-1] in ("js", "wxml", "wxss", "json"):
            _p = os.path.join(_base, _fn)
            try:
                _src = open(_p, encoding="utf-8").read()
            except Exception:
                continue
            if "工程大脑" in _src:
                _brain_hits.append(os.path.relpath(_p, ROOT))
check("工程大脑字眼全局归零（→总包智库）", not _brain_hits, str(_brain_hits))
```

高价值断言三技巧（照抄级）：

```python
# ① 计数断言：数量即需求（五枚按钮/三真实互动/两处震动全带 fail）
check("answer pill-row 五小按钮（复制全文已下线）", "pill-row" in ans_wxml and ans_wxml.count('class="pill-glyph"') == 5)
check("answer 赠次只在真实互动（v0.7.6：有用/纠错/共享入锅圈三动作，无分享导出赠次）",
      ans_js.count("this._reward(") == 3 and "onExport" in ans_js)
check("ask vibrateShort 恰 2 处调用且全带 fail", ask_js.count("wx.vibrateShort({ type: 'light', fail: () => {} })") == 2)

# ② 布局顺序断言：字符位置即 DOM 顺序（输入框→AI优化左|咨询右）
_opt = ask_wxml.find("opt-btn"); _cta = ask_wxml.find("ask-btn"); _inp = ask_wxml.find("ask-input")
check("ask 布局=输入框→按钮排（AI优化左|咨询右）", 0 <= _inp < _opt < _cta, f"{_inp}/{_opt}/{_cta}")

# ③ 标签配对粗检：编译前抢先抓 wxml 结构坏
for tag in ["view", "block", "scroll-view", "template"]:
    opens = len(re.findall(rf"<{tag}[\s>]", wxml))
    closes = len(re.findall(rf"</{tag}>", wxml))
    selfclosed = len(re.findall(rf"<{tag}[^>]*/>", wxml))
    check(f"{p} <{tag}> 配对 {opens}=={closes}+{selfclosed}", opens == closes + selfclosed, ...)
```

**坑**（WXML 里写方法调用）：
- 表象：真机白屏/渲染层报错，静态字符串检查全绿。
- 根因：WXML 表达式不允许 JS 方法调用，`{{ x.trim() }}` 直接炸。
- 修法：卫生断言补一条 `check("answer WXML 零方法调用绑定（WXML 禁 trim()）", ".trim()" not in ans_wxml)`——把这类错误从真机提前到上传前。

**坑**（跨仓契约漂移）：
- 表象：小程序端调 `/api/xxx` 404，各自单测都绿。
- 根因：前端 utils/api.js 与引擎 app.py 路由各自演进，无对齐门。
- 修法：BOOT-SIM 直接读引擎源码互证——`ENGINE = r"E:\AI-Station\services\qianwen-engine"`，`check("服务端 pot 举报端点", "/api/pot/report" in _app_py)`；终验阶段另做全量路由对齐（见第 7 节 19/19）。

## 3. 服务端 pytest 纪律

范本：`E:\AI-Station\services\qianwen-engine\tests\`（test_api.py / test_store.py / test_pay_sign.py / test_metaso_kb.py）。演进：28/28（v0.5.1）→ 38/38（v0.6.0）→ 46/46（v0.7.0 上云行）→ 47/47（v0.7.3）。

纪律三条：
1. **fixture 禁碰真网**。本地 `data/secrets/` 下存在真实密钥文件时，测试进程必须在 fixture 里显式 mock 掉外呼（否则 pytest 一跑就烧真网/真积分）。test_api.py 的 client fixture 是定型模板：

```python
@pytest.fixture()
def client(tmp_path, monkeypatch):
    from fastapi.testclient import TestClient
    from qianwen_engine import app as app_mod, store

    monkeypatch.setattr(config, "DB_PATH", tmp_path / "t.sqlite")     # DB 进临时目录
    monkeypatch.setattr(config, "DATA_DIR", tmp_path)
    store._init_done = False

    monkeypatch.setattr(wechat, "code2session",
                        lambda code: {"openid": f"open-{code}", "unionid": ""})
    # v0.7.4 UGC 安检门默认放行（离线测试不碰微信 API；闸门专测单独覆写）
    monkeypatch.setattr(wechat, "msg_sec_check", lambda content, openid, scene=2: True)
    monkeypatch.setattr(metaso_kb, "ask", lambda q, model="fast", sleep=None, on_event=None: _kb_answer(q))
    monkeypatch.setattr(metaso_kb, "_guard_enter", lambda cost=3: None)   # 护栏不干扰
    monkeypatch.setattr(metaso_kb, "_record", lambda ok: None)
    # v0.5.1 智谱免费链：默认走"未配置"分支（KB 回落已被 mock，全离线），
    # 真实 zhipu.secret 存在也不许测试进程碰网络。
    monkeypatch.setattr(zhipu, "configured", lambda: False)
    monkeypatch.setattr(zhipu, "rewrite", lambda prompt: (_ for _ in ()).throw(
        RuntimeError("测试默认禁用 zhipu")))

    with TestClient(app_mod.app) as c:
        c.headers.update({"Authorization": "Bearer " + wechat.issue_token("open-t1")})
        yield c
    store._init_done = False
```

2. **测试名/docstring 对齐需求号**。测试即需求台账，翻测试文件就能翻出产品决策史。实例（原字符串照抄）：

```python
def test_strip_md(): ...
def test_share_on_sec_check_gate(client, monkeypatch):
    """v0.7.4 提审合规：共享入锅圈前过 msgSecCheck——risky 拒 400 / 检测不可用 503（fail-closed）。"""

def test_pot_ordering_recency_and_interaction(client):
    """排序（用户令 0930 第 9 条）：时间最新优先，互动数据可反超（1 互动≈半天）。"""

def test_pending_partial_stream(client, monkeypatch):
    """v0.7.0 流式（用户令 0930 第 2 条）：pending 态携带 partial 增量正文。"""
```

3. **错误路径全覆盖**。每端点至少：正常 200 + 重复 400 + 越权 404 + 超限 429 + 上游故障 502/503。fail-closed 语义必须专测（安检挂了要 503 拒收，不是放行）：

```python
def _boom(content, openid, scene=2):
    raise RuntimeError("msgSecCheck 45009")
monkeypatch.setattr(wechat, "msg_sec_check", _boom)
assert client.post(f"/api/answer/{aid}/share_on").status_code == 503
```

**坑**（测试假设了环境默认值）：
- 表象：本机绿、ECS 红（或反之），同一测试两处结果不同。
- 根因：`POSTER_QR_ENV_VERSION` 本机+线上曾被误置 release（正式版未发布前置 release=海报码开出旧 1.0.7），测试又写死"默认是 trial"。
- 修法：测试改**方向无关断言**——不假设默认值，只验证"切换 env 后缓存失效重生成"：

```python
_default_env = config.POSTER_QR_ENV_VERSION               # 方向无关：不假设默认 trial/release
monkeypatch.setattr(config, "POSTER_QR_ENV_VERSION",
                    "trial" if _default_env != "trial" else "release")
assert client.get(f"/api/answer/{aid}/poster").status_code == 200
assert builds["n"] == 2                                  # env 切换 → 重新生成
```

**坑**（异步竞态导致测试偶发红）：
- 表象：批量导出测试时绿时红。
- 根因：答案还在 pending 态就去导出。
- 修法：竞态容忍写进断言并注明原因——`assert empty.status_code in (200, 404)   # pending 未完成不计（竞态下可能 404）`；配合 `_wait_ready` 轮询助手（100 次 × 0.05s）等异步答案落定。

## 4. 三线终验定型

提审前终验三线（1002 用户令「功能+填写都确认才提交」定型，RUN_LEDGER #82 全绿实录）：

| 线 | 内容 | 判据 |
|---|---|---|
| ① API 面 | root/pot/quota 端点 401 fail-closed 探针 | 未带 token 全部 401，无匿名泄露面 |
| ② 模拟器六页 | DevTools 巡检 ask/pot/zhiku/my/legal/answer | 全 0 JS 错误；额度链 login→token→quota 200（4/6）；答案页 14 blocks 渲染 |
| ③ 表单核对 | mp 控制台提审表单六项 | 版本描述 184/200（含 AI 标识+分享激励下线说明）/ 测试账号=无需登录 / 企业微信=否 / 隐私指引=采集用户隐私 / 订单 path 空 / 不加急 |

第①线的机制背书在 pytest 层已有同类（test_answer_requires_owner 换人 token 得 404），终验时是对**生产 ECS** 打真探针。第②线展开见第 5 节。第③线的控制台自动化坑（翻译扩展 span 包裹/checkbox 单点验 checked）不在本文档范围，见 references/mp-console-automation.md。

**坑**（终验打了假探针）：
- 表象：check_path=true 探针全部 41030 报"页面不存在"，钉位明明健康。
- 根因：该探针只按**线上版已发布页面表**校验，不读体验版钉位——它是恒假阴性机器，出码硬闸等于没设。
- 修法：出码改"码内显式 page + check_path=false"（`getwxacodeunlimit {"page":"pages/ask/ask","env_version":"trial"}`），BOOT-SIM 加防线 `check("出码器=码内显式page+免老表校验（新解析）", '"pages/ask/ask"' in sf_py and 'check_path":false' in sf_py)`；钉位健康真判据=用户手机扫显式 page 码 + 引擎雷达（第 6 节）。

## 5. DevTools automator 配方

模拟器自测=零缺陷门主力（1001 午收官实录：开发者工具 automator(9420) + IDE CDP(9333)，六腿全绿且逐条对生产 DB 核验）。六腿明细：

| 腿 | 操作 | 核验 |
|---|---|---|
| 1 | 真机链路：ask 提问→answer | 真 KB 咨询 2271 字/14.9s，生产 DB 同步 |
| 2 | 额度 | 6→5（quota 扣减实证） |
| 3 | 历史列表 | 含退次徽章 |
| 4 | 追问 | 智谱接地（fuLeftA9/fuLeftG19 双限额读数） |
| 5 | 互动 | 点赞+奖次（REW\|like\|x1） |
| 6 | 海报 | 生成缓存 env=trial 223593B（POSTER_QR_ENV 修复在役） |

附加实证：home 跳板 reLaunch 干净栈（page_stack 查证）；全页 walk 零 JS 错误（4 条良性警告不算错误）；ask/answer 双页视觉 PASS。

工具链：wechat-devtools-mcp（IDE 以 cdp_enabled=true 打开，CDP 端口与 inspector/navigate 一致）+ wechat_automator（auto_port 9420）。核心动作三式（fn_source 为工具契约示意形态，非源文件摘录；六腿核验值为 1001 实测）：

```text
# ① 跑认证 wx.request：evaluate + fn_source（AppService 内执行，返回 Promise 会被等待）
fn_source: 'function(){ return new Promise((resolve) => {
  wx.request({ url: BASE + "/api/login", method: "POST",
    data: { code: "sim" }, success: (r) => resolve(r.data),
    fail: (e) => resolve({ err: e.errMsg }) }); }); }'
# 认证链 login→token→quota 200 即由此式串联

# ② 查页面栈：page_stack —— home 跳板 reLaunch 后栈里只剩咨询页=干净栈实证

# ③ 数据体检：page_data —— 读 answer 页 blocks/streamChars/fuLeftA 等状态位与 DB 交叉核验
```

CDP 日志采集用 inspector（cdp 动作可回放缓冲区内历史消息；console 动作只收连接后事件，排查 exception 建议 ≥8s）；判定=过滤出真 JS 错误，良性警告（如渲染提示类）不计入——1001 实测 4 良性警告判 0 错误。

**坑**（本机 DevTools CLI 损坏）：
- 表象：CLI 起调 exit 9（User Data .cli 握手文件 ENOENT），模拟器自测整个跑不起来。
- 根因：开发者工具本地安装损伤；包编译健康另有 CI 上传全量构建背书，不阻塞发版。
- 修法：模拟器腿挂低优先，用 BOOT-SIM（静态）+ CI 上传（构建）双背书先走；IDE 修复后模拟器腿恢复为提审前必跑（0.7.6 三线终验即在其恢复后完成）。

## 6. 真机联调雷达

换版后入口层是否真活，不靠用户投诉，靠 DB 雷达：

- **users 表 quota_day/free_used** = 登录+用量雷达（该表无 last_seen 列，活性判据=计数对比基线）。
- **answers 表最新成功咨询时间 vs 上传时间** = 零流量即入口层死（0929 教训级：上传后雷达持续零流量→发现钉位被顶/老表解析 404）。
- ECS 真实 DB 路径：`/opt/qianwen/data/qianwen/db.sqlite`（**qianwen.db 是空壳诱饵**，config 里 DB_PATH=db.sqlite——连错库=雷达全瞎）。

**坑**（换版交付后用户说"页面不存在"）：
- 表象：新版已上传 UPLOAD_OK，用户手机仍打开失败或打开旧版。
- 根因（三层，逐次发现）：① 同 robot 再上传顶掉被钉体验版（→robot 1..30 轮转，`check("uploader robot 1..30 轮转（防钉位孤儿）", "robot_cursor" in up_mjs and "robot," in up_mjs)`）；② 一切**无路径入口**（控制台体验码/最近使用/会话卡）默认页解析都参照线上版老页面表→新包没有老表页必 404（→包内补 home/home 兼容跳板页，落地即 reLaunch 咨询首页）；③ 钉位状态只有用户控制台能改。
- 修法：换版交付**必附两条**——(a)「钉完立刻自测」指令（写进给用户的换版话术）；(b) 永不 404 码：`page="pages/home/home"`（新老包双环境都在表）+ `env_version` 对应 + `check_path=false`，任何解析路径必命中。终局 cure=提审发布。

**配方**（雷达探针的云端通道要点，来自 1001 定型实录 work/ecs_probe2.py）：云助手 `--CommandContent` 必须纯文本（SQL 本体 b64 直灌绕引号地狱）、`--InstanceId.1` 数组形、回包 Output 即明文。

## 7. 提审前零缺陷门

全绿才许点提交。门的构成（1001 午零缺陷门 + 1002 提审前终验合并定型）：

| 门项 | 判据 | 实测基线 |
|---|---|---|
| 静态审计-console.log | 全包 0 处 | console.log 零 |
| 静态审计-TODO | 全包 0 处 | TODO 零 |
| 路由对齐 | utils/api.js 与 app.py 端点全量互证 | 19/19 对齐（pay_sign+unlock_paid 系拆付费墙后无害遗留，登记不修） |
| 编译 | CI 构建 0 错 0 警 | 0.7.6 上传前 0错0警 |
| BOOT-SIM | 版本门全绿 | 241/241 |
| 六页巡检 | 全 0 JS 错误 | 0 错误（4 良性警告） |
| 表单六项 | 三线终验第③线 | 见第 4 节表 |
| 合规标识 | AI 生成标识 12 前端位+2 海报位 | 0.7.4 拒审根因修复项，逐位断言在役 |

顺序：静态审计→BOOT-SIM→编译上传→模拟器六页→表单核对→（用户令确认）→提交。任何一项红=回到对应层修，不带病提审（0.7.4 拒审教训：AI 生成内容缺显著标识，audit_id 级失败原因实锤，修复成本=一轮版本周期）。

**坑**（静态审计的"无害遗留"误判为脏数据）：
- 表象：路由对齐时发现 pay_sign/unlock_paid 前端仍有引用，想清掉再提审。
- 根因：付费墙拆除后残留引用，但服务端端点仍在、无实际调用路径。
- 修法：区分"脏"与"无害遗留"——登记留痕（19/19 对齐时注明"系拆付费墙后无害遗留"），不为一轮提审引入额外改动面。判据：BOOT-SIM 已有 `check("api 支付腿撤除（paySign/unlockPaid）", "paySign" not in api_js and "unlockPaid" not in api_js)`——若该检查绿而对齐报告有残留，说明残留不在主链路。

## 附：层间关系速查

```
pytest(服务端契约/错误路径, 47/47)        ← 层1：引擎行为
  ↓
BOOT-SIM(包级静态断言, 241/241, exit 1)   ← 层2：需求即测试版本门，上传前跑
  ↓
CI robot 上传(构建背书, 0错0警)           ← 层3：编译门
  ↓
模拟器六页自测(automator 9420+CDP 9333)   ← 层4：运行时 0 JS 错误
  ↓
三线终验(API 401/六页/表单六项)           ← 层5：提审门，全绿才提交
  ↓
真机联调雷达(users/answers 表 vs 上传时间) ← 层6：上线后入口活性兜底
```
