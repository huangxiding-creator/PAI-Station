# Phase 5 · 架构设计（ADR 形式）

## 总体架构（三层，对齐 VISION.md）

```
┌─ L1 登录层（浏览器仅此一层）─────────────────────────┐
│ scripts/weread_login.py                              │
│   DrissionPage(可见窗口, browser_profile, :9333)     │
│   → 扫码 → 轮询 /web/user → 提取 cookie              │
│   → data/weread/_auth/weread_auth.json + 续期        │
├─ L2 提取层（纯 API，stdlib urllib 直连）─────────────┤
│ src/paistation/forge/weread.py      WeReadClient     │
│   search() / book_info() / chapters() / extract_book()│
│ src/paistation/forge/weread_sign.py 签名（独立可换）  │
│ src/paistation/forge/weread_html.py HTML→MD 转换器    │
├─ L3 导出层───────────────────────────────────────────┤
│ src/paistation/forge/weread.py: to_markdown(book)    │
│ scripts/weread_to_docx.py           MD→DOCX 专业排版 │
│ scripts/weread_batch.py             批量断点续采+护栏 │
└──────────────────────────────────────────────────────┘
data/weread/
  _auth/weread_auth.json      登录态（gitignored, data/ 全域已忽略）
  _recon/                     搜索结果/failed/熔断记录（证据链）
  {书名}/book.json            原料（结构化全书）
  {书名}/{书名}.md            人读版
  {书名}/{书名}.docx          专业排版版
  {书名}/images/              本地化图片
```

## 关键 ADR

### ADR-1 提取主路线 = API 签名直调（用户已批准）
- 为什么：速度秒级/章、无持续自动化暴露、可断点续采；签名算法已被 touchFish 完整还原（确定性算法可移植可对拍）。
- 代价：官方改版需重逆向 → 签名独立成 `weread_sign.py` 模块，失败时报"签名可能变更"而非静默；Canvas Hook 只留接口位不实现。

### ADR-2 登录 = 页面内扫码（非本地生成二维码）
- 为什么：登录流量与真人 100% 一致（零风控差异）；免 qrcode 依赖；browser_profile 顺带持久化第二登录层。
- 登录后所有请求走 Python urllib + Cookie 头（与 touchFish/obsidian-plugin 同形态——社区封号报告最少的调用类别）。

### ADR-3 纯 stdlib HTTP（不用 requests 库调用渠道 API）
- 为什么：对齐 forge/hundun.py 既有风格；`ProxyHandler({})` 直连铁律显式表达；opener 可注入便于 FakeOpener 单测（tests/test_hundun_api.py 同款假件模式）。

### ADR-4 签名算法放 forge 而非 scripts
- 为什么：它是协议知识不是脚本逻辑；单测向量对拍放 tests/test_weread_sign.py；scripts 只做编排。

### ADR-5 HTML→MD 自写转换器（stdlib html.parser）
- 为什么：书内 HTML 元素集合有限（p/h1-6/span(class 样式语义)/img/sup/blockquote/table 罕见）；自写可控降级路径（未识别标签→纯文本，内容永不丢）；避免引入 bs4 依赖。金标准样本进单测。

### ADR-6 DOCX 直接从结构化 Book 对象生成（非 MD→DOCX 复用 hundun 配方）
- 为什么：需求是"专业级排版"——封面/目录/Heading 层级/图片嵌入/页码，MD 三级映射到不了；Book 对象信息量 > MD。共享中文字体配方（run.font.name + eastAsia 雅黑/宋体）。

### ADR-7 安全护栏集中在客户端 `_guard()` 钩子
- 每个 API 调用经过：间隔节流（上次请求时间 + 随机 1.5~3.5s）→ 响应健康检查（-2012/验证页特征/连续异常计数熔断）→ 日志。
- 批量层再加：单书冷却 120s、日限额（读 `data/weread/_recon/daily_count.json` 当日已提取数）。

## 模块契约（API_DESIGN）

### forge/weread_sign.py
```python
def calc_hash(data: str) -> str          # md5 前3 + 类型标记hex + 2+md5末2 + 长度
def bkdr_hash(text: str) -> str          # 131 累乘 32位截断
def build_app_id(ua: str) -> str         # "wb"+段长%10串+"h"+bkdr16
def sign(payload: dict) -> str           # 排序 k=v& 拼接 → 双累加器异或 → hex
```

### forge/weread.py
```python
class WeReadClient:
    def __init__(self, auth_path=None, opener=None)   # 载入 auth.json
    def is_logged_in() -> bool                         # GET /web/user
    def refresh_cookies() -> bool                      # 首页 Set-Cookie 续期
    def search(keyword, max_books=20) -> list[dict]
    def book_info(book_id) -> dict                     # 含权限预检字段
    def chapter_infos(book_id) -> list[dict]           # 章节树
    def chapter_html(book_id, chapter_uid, fmt) -> str # 签名+解混淆+拼接
    def extract_book(book_id, on_progress=None) -> dict  # → Book 对象
def deobfuscate(text) -> str                           # chk剥离+交换还原+b64解码
def to_markdown(book) -> str
def to_docx(book, out_path) -> None                    # L3（python-docx）
```

### Book 对象 schema（book.json）
```json
{"bookId": "...", "title": "...", "author": "...", "cover": "...",
 "format": "epub", "intro": "...", "totalWords": 0,
 "fetchedAt": "ISO时间", "partial": false, "partialReason": "",
 "chapters": [{"chapterUid": 1, "title": "...", "level": 1,
                "html": "...", "text": "...", "images": [{"src","local","alt"}]}]}
```
