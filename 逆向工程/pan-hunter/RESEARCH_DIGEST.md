# PAN-HUNTER 战役合成卷（RESEARCH_DIGEST）

合成日 2026-10-30 | 合成官: PAN-HUNTER 战役 | 输入: RESEARCH_DOCKET r1-r6 六卷宗（结论直接采信并标注出处卷号）
纪律: 数字零造假——全部计数为本合成对六卷宗 markdown 表格数据行的逐行实点，非卷宗自报数。

---

## 一、去重计数（计数方法透明）

### 1.1 口径

- **raw_total** = 六卷宗「入表条目」之和 = 各卷 markdown 表格**数据行**逐行实点。不计入：各卷 §0 总裁决矩阵（R3 四盘/R4 六盘，系卷内合成行非收录条目）；段落体与行内列举（R1 表C 死站名单 20 域名、R2 的 pansou 122 插件全量名单、R5 A2 驱动级编号列表与光鸭专项叙述）。
- **unique_total** = 按「同一 GitHub 仓(owner/name)／同一主域名／同名项目」合并。细则：项目部署实例计回母项目（pansou 自部署/官方实例=pansou）；同家族不同仓/不同域名单列（hunhepan APP/hunhepan-pc/hunhepan.com 官网API 三条独立；aipan 开源仓与 aipan.me 站点独立）；捆绑行保留 1 条 unique 并注明内部重叠（R6「直链小件组」内含 189-down 与 R4 重复）；纯指针行（R4 UC 表「LinkSwift/YunX/YunGet 的UC·见各节」）计为重复行。
- **dup_count** = raw_total − unique_total = 被合并掉的重复行数。

### 1.2 逐卷实点账

| 卷 | 实表数据行 | 分节账 | 卷宗自标 | 差异说明 |
|---|---|---|---|---|
| R1 | 54 | 表A 30 + 表B 24 | — | 表C 死站名单为段落体 20 域名，未入表不计 |
| R2 | 67 | 一4 + 二21 + 三25 + 四6 + 五4 + 六7 | — | 122 插件全量名单为行内列举不计 |
| R3 | 55 | 百度15 + 阿里12 + 夸克11 + 迅雷7 + 跨盘10 | 54 | 自标与实表差1（百度段标14实表15行）；§0 四盘裁决4行系合成不计 |
| R4 | 52 | 天翼8 + 移动5 + 沃盘6 + 115十二 + 123八 + UC6 + 跨盘7 | 46 | 自标46与实表52不符（实点为准）；§0 六盘裁决6行不计 |
| R5 | 37 | A1仓5 + A4项目14 + B盘18 | 54 | 自标54含 A2 驱动级11与光鸭专项等叙述体条目，非表行 |
| R6 | 59 | 通用16 + 盘专9 + 聚合12 + 目录2 + 尸案11 + 反爬9 | 45 | 自标45（A8/B21/C13/D9 加总51）为 verdict 分布口径，与表行不一致 |
| **合计** | **324** | | | raw=六卷实点之和，自检通过 |

### 1.3 去重结果

- **raw_total = 324**；**dup_count = 88**（R1 0 / R2 23 / R3 11 / R4 23 / R5 14 / R6 17）；**unique_total = 236**。
- 自检：各卷净新增 54+44+44+29+23+42 = 236 = 324−88。

### 1.4 跨卷重复榜首（合并台账）

| 实体 | 入表行数 | 出现卷 | 备注 |
|---|---|---|---|
| pansou (fish2018) | 11 | R1/R2/R3/R5/R6 五卷 | R3 内 5 行=四盘免登校验配方+母体；R2 内 3 行=自部署+官方实例+复用表 |
| OpenList | 10 | R3×2/R4×6/R5/R6 | R4 六节各引一次驱动面；AGPL 只抄协议 |
| LinkSwift | 10 | R3×3/R4×3/R5/R6×2 | 百度/夸克面+跨盘+天翼+UC指针+README名录；AGPL 只借端点情报 |
| netdisk-fast-download (qaiu) | 7 | R1/R4×5/R5 | R4 以 UcTool/P115Tool/Ye2Tool/EC/跨盘五形态出现 |
| CloudSaver | 5 | R1/R4×2/R5/R6 | TG 腿地骨；开源钉 v0.2.5 |
| quark-auto-save | 4 | R1/R3/R5/R6 | AGPL pattern only |
| PanHub(wu 系) | 3 | R1/R4/R6 | 另 yymhai/PanHub(panhub.fun) 2 行独立实体仅现于 R2 |
| PanIndex | 3 | R4/R5/R6 | libsgh 主仓，R6 走 px-org 镜像 |
| alist | 3 | R3/R5/R6 | AlistGo/alist-org 同项目易名 |
| yz_pansearch_api | 3 | R1/R2/R5 | fre123 元站规范 |
| aliyundrive-webdav | 3行 | R3/R6×2 | R6 含项目行+归档案卷行 |
| SmartStrm | 3 | R1/R4/R5 | |
| R1↔R2 站点重合 | 16 实体/17 行 | R1/R2 | yunso/dyuzi/yingso/haisou/qupansou/pansearch.me/sousou/upyunso(2行)/alipansou/haitunsou/miaosou/yiso/qianfan/cuppaso/kk系/t.me-s |
| 其余双卷件 | 各2行 | — | pansou-web/QuarkPanTool/iScript/xinyue-search/urldb/YunX/BaiduPCS-Go/JxPan/lzpan_search/go-pansearch-release/SmallZombie·PanSearch/OnePanSearchApi/油猴Self-use/mcp-pansou-search/BaiduyunSpider/TG机器人生态 |

---

## 二、盘级矩阵（21 行 = 20 实存盘 + 1 组证伪盘）

图例: 绿=免登全通 / 黄=半通 / 红=硬墙 / ？=未核。配方来源列只列 A 级件（许可友好可直接克隆者加注许可）。出处=结论所采卷号。

| 盘 | 列表免登 | 直链免登 | 配方来源(A级件) | 备注 | 出处 |
|---|---|---|---|---|---|
| 百度网盘 | 绿 | 红 | pansou check_service.go(MIT) | 无码链零Cookie直拉；有码链 verify 零Cookie→BDCLND 单Cookie；2025-07 分享页下载关闭，dlink 需 AccessToken/BDUSS，生态退到 SVIP 号池中转；8001=验证码软门熔断；errno 105/115/117/145 不重试 | R3 |
| 阿里云盘 | 绿 | 红 | pansou(MIT)+go-aliyundrive | get_share_by_anonymous + get_share_token 全匿名；直链 GetDownloadUrl 强制 OAuth，2023 整改后第三方 token 高危；boxplayer share.ts(GPL) 提供在役链路可对照 | R3 |
| 夸克网盘 | 绿 | 红 | pansou(MIT)+quark-auto-save(AGPL pattern) | sharepage/token→stoken→detail 零Cookie；file/download 需 __puus 且下载票绑请求 IP；免费号约0.06MB/s | R3 |
| 迅雷/快传 | 绿带门 | 红 | pansou checkXunlei(MIT) | captcha/init 签名舞步(固定 client_id/device_id 在役)；响应带 url 字段=真验证码即熔断；分享页跳 APP | R3 |
| UC网盘 | 绿 | 绿 | nfd UcTool(MIT) | 实测端点活无墙；pc-api.uc.cn 三步免登；__puus 55min 刷新守护；R5 判「黄偏红」系 JxPan 登录态路线视角，采信 R4 实测+nfd MIT 配方，留复测项 | R4(冲突R5) |
| 115网盘 | 绿 | 绿 | nfd P115Tool(MIT) | share/snap 实测活无墙；share/skip_login_downurl=官方保留免登直链端点；开放平台 2026-08 停服反成 webapi 活路；游客限额/UA 风控未实测 | R4 |
| 123云盘 | 绿 | 绿 | nfd Ye2Tool(MIT)+OpenList 123_share(AGPL只取事实) | api.123278.com 实测活；download_info+encode123 六段签名，token 可选注入；分享域名 20+ 轮换需字典化；免费层额度未实测 | R4 |
| 移动云盘139 | 绿 | 红 | YunX(AGPL 只取端点事实) | 列表端点空 cookie 可列(YunX 注释实锤)；AES 密钥公开(PVGDwmcvfs1uV3d1)、getOutLinkGeneral 明文回吐提取码；dlFromOutLinkV3 要 authorization，游客化待实测；半天量可上岗 | R4 |
| 天翼云盘189 | 黄(要SSK) | 红 | 无A级件 | getShareInfo 实测 InvalidSessionKey；现役件全账号化；突破口=H5 首访匿名 SESSION，未核 | R4 |
| 沃盘联通 | 红 | 红 | 无 | SPA 无公开分享 API；开源全账号客户端；生态最小，六盘最低优先 | R4 |
| 蓝奏云 | 绿 | 绿 | OpenList lanzou driver(AGPL pattern)+LanZouCloud-API 等 MIT 系 | 分享页游客解析+acw_sc__v2 挑战自动计算；富矿 | R5 |
| 蓝奏优享 | 绿 | 绿 | OpenList ilanzou(AGPL pattern)+ilanzou_encryptHex | unproved 命名空间(未实名) API 游客可调 | R5 |
| 光鸭云盘 | 绿 | 绿？(未核) | OpenList guangyapan(AGPL pattern)+JxPan(Apache-2.0) | 官网明示分享可开「免登录下载」(盘级绿)；但 get_share_access_token 匿名态是否可用未核(JxPan 包登录 Bearer)；注册 2TB/不限速 | R5 |
| 小飞机盘 | 绿 | 绿 | JxPan FeijipanParser(Apache-2.0)+nfd(MIT) | nfd 在役支持 | R5 |
| 亿方云 | 绿 | 绿 | nfd(MIT) | nfd README 实测示例在册(/parser?url=&pwd=)；注意 ecpan≠139 同名陷阱 | R4/R5 |
| 文叔叔 | 绿 | 绿 | pattern 件(无许可仅参照) | 产品即免登收发,收件码制 | R5 |
| 奶牛快传 | 绿 | 绿 | cowtransfer-uploader/imacks/kitUIN(三 MIT) | 取件码制免登 | R5 |
| 城通网盘 | 黄 | 黄 | ctfile-cli(MIT)+ctfileGet(pattern) | 游客可解一次性直连但限速风控重；**本仓 ebook-treasure 实证: 24k 书库在册而 ctfile 直链 API 已死** | R5+本仓 |
| 曲奇云盘 | 黄？(未核) | ？ | OpenAList 曲奇驱动(cookie 型) | 原版 2024-10 停服转 Pro,新接口未核,盘半死 | R5 |
| 微云 | 红 | 红 | 无 | driver 强 cookie,公网无免登直链方法 | R5 |
| 超能邮箱盘/净垚网盘 | —(不存在) | — | — | WebSearch 证伪:超能=搜索APP名称混淆,净垚=公司名非网盘;需求方名字先验真 | R5 |

矩阵小结: 绿盘免登全链 10 个(UC/115/123/蓝奏/蓝奏优享/光鸭待核/小飞机/亿方云/文叔叔/奶牛)，黄盘列表绿直链红 5 个(百度/阿里/夸克/迅雷/139)，墙盘 4 个(天翼/沃盘/微云/曲奇半死)，证伪 2 个。
---

## 三、A级件甄选（跨卷合并去重，按 可克隆性×覆盖面×许可 排序前12）

| 榜位 | 件 | 许可 | 一句话凭什么 | 出处 |
|---|---|---|---|---|
| 1 | fish2018/pansou | MIT | 唯一 T0：检索聚合引擎+122 源插件配方库+四盘及115/天翼/123/移动免登校验配方+/api/check/links 探活+二级分片缓存，五卷共认 clone-and-adapt 母体 | R1/R2/R3/R5/R6 |
| 2 | qaiu/netdisk-fast-download (nfd) | MIT | 第二层直答：UC/115/123/蓝奏/蓝奏优享/小飞机/亿方云/移动云盘分享直链解析，parser 插件化+公益API在役，三绿盘 A 配方直接出自此件 | R1/R4/R5 |
| 3 | lexiforest/curl_cffi | MIT | 搜索源 HTTP 层标准答案：TLS/HTTP2 指纹 impersonate，破 CF 对 curl 的 000/403 头号地形；UA 与 TLS 同源一致 | R2/R6 |
| 4 | aria2 (RPC 伴生) | GPL-2.0(独立进程无传染) | 下载执行层定稿：JSON-RPC 驱动、-x16 分段、断点、--checksum；GPL 经进程隔离合规 | R6 |
| 5 | CloudSaver 钉 v0.2.5 源码版 | MIT | TG 腿地骨：t.me/s/ 频道网页版免登爬取+cheerio+cloudPatterns 正则，唯一不依赖第三方站点善意的搜索源；暗坑=新版仅docker与源码不对应，钉死 v0.2.5 | R1/R4/R5/R6 |
| 6 | ByLsPro/JxPan | Apache-2.0 | 长尾盘直链百科：未加密源码.js 含光鸭/小飞机/优享/移动云/豆包/189 等 10 盘 Parser，源码可改 | R3/R5 |
| 7 | taffy-owo/quarry | MIT-0 | 适配器范式+密钥情报：upyunso AES-128(key=iv=qq1920520460qqxx)+HMAC 逆完件、ps252035 TLS 指纹拒 httpx 须 urllib 实证 | R2 |
| 8 | yt-dlp | Unlicense | 架构纪律蓝本：每站点一个 extractor 类+独立测试，源插件化制度的黄金标准 | R6 |
| 9 | 奶牛三 MIT 库 (Mikubill/cowtransfer-uploader + imacks/cowtransfer + kitUIN/CowtransferAPI) | MIT×3 | 奶牛快传免登收发全链即抄 | R5 |
| 10 | 蓝奏 MIT 系 (zaxtyson/LanZouCloud-API 810★ + chenhb23/lanzouyun-disk + rachpt/lanzou-gui) | MIT | 蓝奏云游客解析+直链富矿，多件互证 | R5 |
| 11 | Cadair/parfive | MIT | Python asyncio 下载库(并发/重试/进度)，小文件兜底直接 pip 进 CLI | R6 |
| 12 | SmallZombie/PanSearch | Apache-2.0 | 七站聚合适配器源码+反爬黑名单情报(拒适配名单即地形图) | R1/R5 |

备选池(未进前12): akai-do/supansou(MIT, 拼写容错/有效性检测)、AriaNg(MIT, aria2 控制台自用)、Kubespider(Apache-2.0, 编排形态最近件)、go-pansearch-release(MIT)、OpenList driver 协议(AGPL 只抄接口协议)、boxplayer share.ts(GPL, 阿里匿名链路对照)、xinyue-search(MIT, 转存层)。
本仓资产直入架构位(不占开源榜): bdn(百度全盘 CLI=下载引擎复用+百度本地凭据插件)、kb_factory/harvest_engine(DownloadAdapter 四段=适配器蓝本)、ebook-treasure(城通 24k 书库+直链API已死实证)、OPE(调度基建)。

---

## 四、三层架构定稿（基于卷宗证据）

**总形: CLI 母体 + MCP 头(mcp-pansou-search 先例,检索能力进 AI 客户端零成本)。三层各定一主件,自研面收窄到「源插件+免登凭据零托管」。**

### L1 搜索源层（发现）
- **主件: pansou 自部署**(MIT, AUTH 默认关) 当聚合底座——/api/search 一端点吃全参,插件目录约100站点配方,二级缓存直接可用。
- **三路并发冗余**: ① pansou 核心+插件库；② TG 腿=t.me/s/ 频道爬取(CloudSaver cheerio+cloudPatterns 配方,与 pansou TG 引擎双实现互备,唯一不依赖第三方站点善意的源)；③ 直连腿=A 级直调源即刻接入(api.naspt.vip / melost.cn / s.panhunt.com 实测 200 零门票)+七渠道复刻件(sogou/metaso 等,站内在役)。
- **HTTP 层统一 curl_cffi impersonate**(破 CF TLS 指纹墙=头号地形);频控三律入引擎: 并发≤4/源+全局随机间隔2-5s、指数退避+单源熔断(一源死不停机)、指纹与UA同源。
- **源插件制度抄 yt-dlp extractor 纪律**: 每源一插件+独立测试;探活走 pansou /api/check/links;死站名单(20+)证明源半衰期短,健康轮为必配件。

### L2 解析层（列表/取链）
- **骨架: kb_factory/harvest_engine 的 DownloadAdapter 四段**(本仓 W1-T01 已落地,恰为「下载器抽象」落点——R6 同判)。
- 每盘一个 adapter,免登配方全部有出处: 百度=verify→randsk→share/list 仅带 BDCLND(R3 pansou 配方);阿里=anonymous→share_token→file/list(R3);夸克/UC=token→stoken→detail(R3/R4,nfd 三步);115=snap→skip_login_downurl(R4);123=share/get→download_info+encode123 签名+域名字典(R4);139=AES 密钥+getOutLinkInfoV6(R4);迅雷=captcha_sign 舞步+真码熔断(R3);长尾(蓝奏/优享/光鸭/小飞机/亿方云/奶牛)=nfd+JxPan 配方(R5)。
- **许可纪律**: AGPL 件(OpenList/LinkSwift/YunX/quark-auto-save)只抄端点事实与协议,不拷码;GPL 件仅对照。
- **去重归一**: 同一资源多盘多链的归并(名称/大小指纹)在解析层出口统一。

### L3 下载层（执行）
- **主引擎: aria2 RPC 伴生进程**(JSON-RPC 驱动,GPL 进程隔离)+parfive 小文件兜底。
- **本地凭据插件制(黄盘二级能力)**: bdn 作百度本地凭据插件(用户自供 BDUSS,零托管),夸克/阿里同模式;插件不入核心、默认关闭、明示用户自担。
- **城通教训入档**: ebook-treasure 实证 ctfile 直链 API 已死,城通只做发现+一次性直连尝试,不承诺。
- **调度: OPE 基建复用**(队列/变体/守护),对齐站内纪律(全链零浏览器,DrissionPage 仅认证腿;并发≤4;让路令/高峰令自动生效)。
---

## 五、GAP 清单（摘要,全账见 GAP_REPORT.md）

卷宗自标未核 18 项 + 合成官新发现 12 项,合计 30 项。要害五条: 光鸭 share token 匿名态未核(一级能力名单唯一悬念);UC 判色 R4/R5 冲突需一次实测定案;115/123/UC 游客限额与限速全未实测(一级能力的容量红线未知);天翼匿名 SESSION 与 139 直链游客化两个突破点未攻;源存活衰减无监控机制(死站 20+ 证明必须配健康轮)。

---

## 六、提案骨架

- **产品名**: PAN-HUNTER(工作名;对外发布名另议,域名/品牌不带 pan+破解字样——百度维权常态化教训 R6)。形态=CLI + MCP 头。
- **北极星**: 免登录公开分享资源的「一次搜索,全网可得,绿盘直下」——零账号、零凭据托管的检索→列表→取链→下载全链。北极星指标=单关键词 60 秒内命中源数 × 绿盘可直下文件数(实测口径,禁手填)。
- **能力分级**:
  - 一级(绿盘免登全链): UC/115/123/蓝奏/蓝奏优享/小飞机/亿方云/文叔叔/奶牛/光鸭(待核转正)——搜索→列表→直链→下载全免登。
  - 二级(黄盘免登索引+可选本地凭据插件): 百度/阿里/夸克/迅雷/139——免登列表+探活收录;下载走用户本地自供凭据插件(bdn 模式),零托管、默认关。
  - 三级(红盘仅发现): 沃盘/微云/曲奇(半死)——只收录链接+探活,不承诺下载。
- **波次草案**:
  - W0 基建(约半周): pansou 自部署+curl_cffi 接入+aria2 RPC 伴生+harvest_engine 适配器骨架对接+OPE 调度挂接。
  - W1 一级能力(主力周): nfd 三件套克隆(UcTool/P115Tool/Ye2Tool)+JxPan 长尾四盘+奶牛/蓝奏 MIT 件+A 级直调三源+TG 腿;光鸭匿名态实测决定转正与否。
  - W2 二级能力: 四大盘免登列表+探活(百度/阿里/夸克/迅雷配方全在手)+bdn 本地凭据插件+139 列表(半天量)。
  - W3 长尾攻坚+健康轮: 天翼匿名 SSK 攻坚/139 直链游客化/123 域名字典化/曲奇 Pro 核验/源健康轮上线。
  - W4 产品化: MCP 头+CLI 打磨+文档+发布链(对齐站内报告发布协议另议)。
- **红线(防死三原则入宪)**:
  1. **法务隔离**——只做免登录公开分享链接的索引+用户自有通道下载;不碰限速破解/账号池/向下载收费。PanDownload(刑事)/常某(收费即恶意)/盘多多(民事)三案为分水岭;变现挂工具/知识库/整编交付,不挂下载行为。
  2. **双解耦架构**——源插件化(yt-dlp extractor 纪律)×下载器抽象(OpenList driver 协议+aria2 执行),任何单源/单盘/单作者死亡可热插拔;关键适配层多维护者留 fork 后路(iikira 蒸发教训)。
  3. **凭据零托管**——免登态检索(门票+指纹卫生+频控三律),永不代收用户盘 Cookie;速盘偷 BDUSS 与 AList 卖身两案证明托管凭据=信任死刑;登录态功能一律用户本地自供密钥。
  - 附站内纪律: 并发≤4/全链零浏览器(DrissionPage 仅认证腿)/让路令与高峰令自动生效/数字零造假延伸到产品指标。

---

## 附: 计数自检链

raw 324 = 54+67+55+52+37+59(逐行实点,与各卷自标差异已列 1.2);dup 88 = R2 23+R3 11+R4 23+R5 14+R6 17;unique 236 = 324−88 = 各卷净新增 54+44+44+29+23+42。盘矩阵 21 行=20 实存盘+1 组证伪盘(超 14 盘军令达标)。A 级榜 12+备选 7+本仓资产 4。
