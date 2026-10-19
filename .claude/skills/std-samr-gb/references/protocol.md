# std.samr.gov.cn 逆向协议全档（2026-10-19 实测）

## 站点结构

- 主站（检索/详情）：`https://std.samr.gov.cn`
- 阅读器（全文）：`https://openstd.samr.gov.cn`（`/bzgk/gb/*` 旧路径 301 → `/bzgk/std/*`）
- 检索页：`/gb/gbQuery`，核心 JS `js/gb-data.js`（bootstrap-table 列定义），请求参数在内联脚本

## 1. 检索 API

```
GET https://std.samr.gov.cn/gb/search/gbQueryPage
    ?searchText=<URL编码关键词>       # 同时匹配标准号与名称
    &ics=<URL编码类目全称>            # 如 43.道路车辆工程；空=全部
    &state=G_STATE:"现行"             # 多值逗号串: G_STATE:"现行",G_STATE:"废止"
    &ISSUE_DATE=-12                   # -1/-3/-6/-12/-24/-36 月
    &pageNumber=1&pageSize=500        # 实测 500 可用
Headers: 普通 UA 即可；Referer /gb/gbQuery 非必需
```

响应 JSON：`{"total":79826,"pageNumber":1,"rows":[{id,C_C_NAME,C_STD_CODE,STD_NATURE,ACT_DATE,STATE,ISSUE_DATE,PROJECT_ID}]}`
- 名称中命中词以 `<sacinfo>…</sacinfo>` 包裹（清洗后使用）
- STATE ∈ 现行/废止/即将实施/被代替（列表过滤器仅前三）

ICS 40 个一级类目（gbQuery 左栏）：01 综合…99 无标题，完整列表内嵌于 `samr_lib.ICS_CATEGORIES`。

## 2. 详情页

```
GET /gb/search/gbDetailed?id=<row.id>
```
- 字段：`<dt class="basicInfo-item name">`/`<dd class="basicInfo-item value">` 对 → 标准号/发布日期/实施日期/标准计划号/标准性质/中国标准分类号(CCS)/国际标准分类号(ICS)/归口单位/执行单位/主管部门
- **hcno**：页内 JS 硬编码 `newGbInfo?hcno=([0-9A-F]{32})`；无此串=无全文公开

## 3. 阅读器链（openstd）

```
① GET /bzgk/std/newGbInfo?hcno=XXX            # 建会话(JSESSIONID)
② GET /bzgk/std/showGb?type=online&hcno=XXX&request_locale=zh_CN
   必须带 Referer=①的URL，否则 302 回 ①&refer=outter
```

②的静态 HTML 含全部页面（无懒加载 DOM，滚动只是触发图片 XHR）：

```html
<div id="0" class="page" style="width:2315px;height:3274px" bg="TOKEN(URL编码)">
  <span class="pdfImg-4-2" style="background-position: -232px -0px;"></span>
```

- 页 div：width/height=显示尺寸；`bg`=该页所属分块 token（约 4-5 页/块，纯空白页无 span）
- span：`pdfImg-{L}-{T}` → 目标位 (L*10%, T*10%)（CSS 规则 1..9=10%..90%，0 或无规则=0）
- background-position → 源图内瓦片坐标；瓦片步长 232(x)×328(y)，运行时由偏移集合推导

## 4. 分块大图（核心反爬）

```
GET /bzgk/std/viewGbImg?fileName=<token>
Headers:
  Cache-Alive: chunked        # !!闸门：缺此头 → 302 → 静态直链 /bzgk/data/… 返回 0 字节
  Referer: …/bzgk/std/showGb…
  Accept: image/avif,image/webp,…   # 浏览器式
```
- 响应 webp，宽 2320，高=行数×328（13~22 行/块）
- 静态直链 `/bzgk/data/<STD>/<页宽>-<页高>-<idx>_<rand>.webp` 直接访问恒 0 字节（仅 302 目的地）

## 5. 重组算法

```
canvas = RGB(W,H) 白底
for (L,T,sx,sy) in page.spans:
    tile = chunk.crop(sx, sy, sx+232, sy+328)
    canvas.paste(tile.resize(≈W/10,H/10), (L*W/10, T*H/10))
token→chunk 匹配：组内 max(sy)+328 ≤ chunk.height，精确等高优先
```
验证：GB/T 47591-2026 与 GB/T 11836-2023 重组封面与浏览器渲染一致（视觉+行轮廓相关）。

## 6. 原生 PDF（机会通道）

```
GET /bzgk/std/showGb?type=download&hcno=  → 页面 isValid=='true' 时 JS 跳 viewGb
GET /bzgk/std/viewGb?hcno=                # curl 实测 0 字节（需完整浏览器链）
```
- 多数标准**无下载按钮**（只有 ck_btn 在线预览），FileOpen DRM 历史包袱
- 结论：图像重组为通用下载通道；`try_native_pdf()` 留作机会主义

## 7. 其他事实

- 全库 total=79826（2026-10-19）
- 检索 API 对裸 curl/requests 零拦截（无 WAF/验证码）
- 登录体系（/user/loginByUUID.do 等）与本链路无关，未逆向
- 阅读器有 console-ban.min.js（禁 F12）与 onlineLog 阅读时长埋点，均不影响协议
- DrissionPage 直跳 showGb 会被弹回；`location.href` 同页跳转或按钮点击可过（Referer 语义）

## 8. 工具坐标

- 核心库/CLI：`逆向工程/std-samr/samr_lib.py`、`cli.py`（同源复制于本 skill scripts/）
- 侦察产物：`逆向工程/std-samr/recon/`（home/gbquery/detail/showgb/newgbinfo HTML、ICS 列表）
- DP 侦察脚本：`逆向工程/std-samr/scripts/dp_recon_reader.py`（网络监听蓝本）、`dp_verify_page0.py`（渲染对拍）
- 实测样本：`逆向工程/std-samr/data/`（47591 chunk+页面）、根 `test_dl/`（11836/16752 PDF）
