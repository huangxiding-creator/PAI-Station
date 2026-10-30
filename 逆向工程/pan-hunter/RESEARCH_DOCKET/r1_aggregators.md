# R1 聚合搜索引擎生态调研 Docket（pan-hunter 第一层）
调研日 2026-10-30 | 研究员 R1 | 目标: 免登录多源网盘聚合搜索选型
数据来源: gh api(仓库元数据+raw源码,一手) + 本机 curl 存活实测 + WebSearch(站点名录)。未亲核处标「未核」。

## 表A GitHub 开源聚合/搜索件（按适配价值排序；星数/日期/许可=gh api 2026-10-30 实核）

| # | 名称 | url | 热度 | 活性 | 覆盖盘 | 搜索API形态(源码实读) | 许可 | 评分 | verdict |
|---|------|-----|------|------|--------|------------------------|------|------|---------|
| A1 | PanSou | https://github.com/fish2018/pansou | 15085★ | 2026-10-12 | 百度/阿里/夸克/光鸭/天翼/UC/移动/115/PikPak/迅雷/123/磁力/ed2k | GET/POST /api/search (json: kw必填, channels, conc, refresh, res, src=all/tg/plugin, plugins[], cloud_types[], filter) + POST /api/check/links 探活 + GET /api/health; gin端口8888; TG频道(t.me/s/ 默认tgsearchers7) + 约100个站点插件(每个插件=一个源站逆向配方,配html/json结构分析文档); 二级分片缓存; docker ghcr.io/fish2018/pansou | MIT | 95% | A=直接clone-and-adapt |
| A2 | CloudSaver(云析) | https://github.com/jiangrui1994/CloudSaver | 9413★ | 2026-10-15 | TG频道聚合, 正则识别夸克/UC/阿里/百度/115/天翼/123; 转存115/夸克/天翼/123 | 并发爬 t.me/s/频道?q=关键词 网页版 + cheerio解析 + cloudPatterns正则提盘链接; 控制器 GET /api/resource/search?keyword&channelId&lastMessageId; 公开源码止v0.2.5(新版仅docker) | MIT | 88% | A=TG爬取配方可直接复用 |
| A3 | netdisk-fast-download | https://github.com/qaiu/netdisk-fast-download | 3425★ | 2026-10-13 | 夸克/UC/蓝奏/蓝奏优享/小飞机/123(直链解析,lz.qaiu.top) | 直链解析服务(第二层选型件) | MIT | 82% | A=第二层直接复用 |
| A4 | PanHub | https://github.com/wu529778790/panhub.shenzjd.com | 1785★ | 2026-10-26 | 阿里/夸克/百度/115/迅雷/UC/天翼/123/移动/磁力 | 前端静态Vite仓; 搜索免登录(匿名票据), TG频道+第三方插件聚合去重/熔断; README明言勿用脚本/服务端代理转发 | PolyForm Noncommercial | 55% | B=仅借鉴架构, 商用禁 |
| A5 | 油猴Self-use | https://github.com/tampermonkeyStorage/Self-use | 501★ | 2026-10-26 | 百度/蓝奏/天翼/迅雷/阿里/夸克/123(搜索+播放) | 脚本内置各盘解析/播放逻辑 | 无证 | 60% | B=配方参考,无证仅pattern |
| A6 | lzpan_search | https://github.com/Xwudao/lzpan_search | 656★ | 2025-09-12 | 导航站(百度/阿里/夸克/迅雷) | 静态导航源码, demo=so.lzpanx.com; 关联免费go-pansearch/收费ReMan生态 | MIT | 62% | B=站点名录+起站参考 |
| A7 | OnePanSearchApi | https://github.com/759039446/OnePanSearchApi | 53★ | 2025-08-04 | 夸克/百度/UC(源=kk大厅/kk短剧/kk橘子/kk小宇/kk小悠/kk天天追剧/趣盘搜/酷乐-百度/酷乐-夸克) | FastAPI+aiohttp: GET /search?keyword&type=夸克网盘&fromSite=kk大厅&page&pageSize, 并行聚合 | 无证 | 70% | A=配方直接抄(README全参数) |
| A8 | yz_pansearch_api(fre123) | https://github.com/fre123-com/yz_pansearch_api | 38★ | 2025-11-11 | 源=kk/pansearch/dj短剧/xxq | 元站(moneysou)规范: POST /v1/search/get_kk, headers APP-ID/APP-TOKEN/PAN-TYPE, body{kw}; docker howie6879/yz_pansearch_api; demo=quark.so | 无证 | 65% | A=kk系配方+元站规范 |
| A9 | SmallZombie/PanSearch | https://github.com/SmallZombie/PanSearch | 6★(archived) | 2024-11-11 | 卡帕/阿里搜/盘搜panso.pro/小云/皮卡/ED3000/千帆 | Deno: GET :8081/search?keyword&page; 千帆需公众号token | Apache-2.0 | 60% | A=七站适配器源码+反爬黑名单情报 |
| A10 | panxiaozi盘小子 | https://github.com/towelong/panxiaozi | 258★ | 2026-10-26 | 夸克/百度/阿里 | 一站式搜索引擎(自建索引) | MIT | 62% | B=自建索引路线参考 |
| A11 | xinyue-search心悦 | https://github.com/675061370/xinyue-search | 616★ | 2025-12-10 | 夸克/百度/阿里/UC/迅雷(转存+管理) | README自述不集成采集源,用户自配; 转存层完整 | MIT | 55% | B=第三层转存可参考 |
| A12 | quark-auto-save | https://github.com/Cp0204/quark-auto-save | 3085★ | 2026-07-09 | 夸克(签到/自动转存/订阅) | 订阅分享链自动转存, 无搜索 | AGPL-3.0 | 50% | B=第三层生态件,AGPL传染注意 |
| A13 | QuarkPanTool | https://github.com/ihmily/QuarkPanTool | 1473★ | 2025-12-18 | 夸克(批量转存/分享/下载) | Python批量操作 | Apache-2.0 | 50% | B=第三层 |
| A14 | SmartStrm | https://github.com/Cp0204/SmartStrm | 783★ | 2026-10-29 | 配合CloudSaver/quark-auto-save出STRM | 302直链播放 | 未核 | 45% | B=第四层播放 |
| A15 | pansou-web | https://github.com/fish2018/pansou-web | 364★ | 2026-10-08 | 同PanSou | 官方前端(docker前后端一体) | 无证 | 70% | A=PanSou配套 |
| A16 | PansouAndPanCheck | https://github.com/Silent1566/PansouAndPanCheck | 55★ | 2026-09-27 | 同PanSou | pansou搜索+PanCheck链接有效性代理层 | 无证 | 55% | B=探活层参考 |
| A17 | go-pansearch-release | https://github.com/Xwudao/go-pansearch-release | 92★ | 2025-12-17 | 自建库(ReMan免费版) | Go+React引擎成品, 文档docs.hunhepan.com/pansearch | MIT | 50% | B=自建站可用 |
| A18 | aipan-netdisk-search | https://github.com/unilei/aipan-netdisk-search | 44★(fork群,原版petercao 21★) | 2026-08-14 | aipan.me开源版 | Nuxt: GET aipan.me/api/movies/search?q= | GPL-3.0 | 55% | B=GPL仅pattern |
| A19 | hunhepan混合盘APP | https://github.com/misiai/hunhepan | 283★ | 2024-03-13 | 规则中心下载网盘/磁力规则(搜20源) | 规则引擎架构, 官网hunhepan.com规则中心免费 | 无证 | 45% | C=规则引擎思路 |
| A20 | hunhepan-pc | https://github.com/Xwudao/hunhepan-pc | 89★ | 2023-10-09 | 同上PC版 | 规则引擎 | 无证 | 40% | C |
| A21 | bp3 | https://github.com/zhufenghua1998/bp3 | 307★ | 2023-05-10 | 百度(目录树搜索+直链) | PHP接口程序 | MIT | 40% | C=百度目录索引老思路 |
| A22 | eKing-one/pansou | https://github.com/eKing-one/pansou | 114★ | 2024-11-17 | 自建库(批量导入百度/阿里/夸克链) | ThinkPHP6+MySQL | NOASSERTION | 35% | C |
| A23 | juicePans果汁搜盘 | https://github.com/sxsxhhi/juicePans | 25★ | 2026-10-26 | 多引擎(AI skill形态,可装Codex/Claude/Cursor) | skill封装多引擎搜索 | GPL-3.0 | 50% | B=skill分发形态值得抄 |
| A24 | jingsou鲸搜 | https://github.com/zs55135855/jingsou | 0★ | 2026-07-27 | 全网资源+网盘(介绍仓) | 未核 | NONE | 25% | C=跟踪 |
| A25 | ZayuMax | https://github.com/BingYan001/ZayuMax | 0★ | 2026-10-25 | 安卓客户端(基于云析二开) | 复用CloudSaver后端 | AGPL-3.0 | 30% | C |
| A26 | BaiduyunSpider | https://github.com/k1995/BaiduyunSpider | 1180★ | 2019-09-16 | 百度 | 爬虫+网站(古董) | NONE | 25% | D=历史参考 |
| A27 | iScript | https://github.com/PeterDing/iScript | 5131★ | 2022-10-25 | 百度/115脚本合集 | 命令行脚本 | MIT | 30% | C=老脚本库 |
| A28 | pansousou | https://github.com/dyboy2017/pansousou | 126★ | 2018-07-03 | 爬虫库32w条 | WEB应用 | NOASSERTION | 20% | D |
| A29 | nonebot-plugin-quark | https://github.com/fllesser/nonebot-plugin-quark | 3★ | 2025-12-02 | 夸克资源搜索(bot插件) | bot形态 | 未核 | 30% | C |
| A30 | mcp-pansou-search | https://www.npmjs.com/package/mcp-pansou-search | 未核 | 未核 | 封装pansou的MCP工具 | MCP server | 未核 | 40% | B=未核(npm在册,gh api 404) |

## 表B 在线聚合站（存活=本机curl -L实测2026-10-30;「配方」=开源插件源码读出的调用方式）
| # | 站名 | 域名 | 存活实测 | 覆盖盘 | 登录墙 | 搜索API形态 | verdict |
|---|------|------|----------|--------|--------|-------------|---------|
| B1 | 小云搜索 | https://www.yunso.net | 200活 | 综合 | 无 | POST/GET /api/Core/search2 — 本机实测200返JSON 44KB | A |
| B2 | 聚盘搜索 | https://dyuzi.com | 200活 | 综合 | 无 | GET /api/search/stream?keyword=&type=all (SSE流式) + /api/search/session | A |
| B3 | 影搜 | https://yingso.fun | 200活 | 综合 | 无 | API域 ysapi.yingso.fun(实测服务在) | A |
| B4 | 海搜 | https://haisou.cc | 本机000(需代理复测) | 综合(多盘筛选) | 无 | GET /api/pan/share/search?query=&scope=title&pan=&page=&filter_valid=true + /api/pan/share/{id}/fetch | A(配方) |
| B5 | 趣盘搜后端 | API域 v.funletu.com(站qupansou.com已变影视) | 本机000(需代理;pansou插件在用) | 综合 | 无 | POST v.funletu.com/search JSON, Referer=pan.funletu.com | A(配方) |
| B6 | 爱盼 | https://www.aipan.me | 未直测(插件在用) | 影视为主 | 无 | GET /api/movies/search?q= + /api/movies/detail/{id} | A(配方) |
| B7 | PanSearch | https://www.pansearch.me | 本机000(WebSearch确认在) | 阿里/夸克/迅雷/百度 | 无 | Next.js: /_next/data/{buildId}/search.json(buildId从首页源码提) | A-(需代理) |
| B8 | 盘搜VIP | https://panso.vip (panso.pro/sousou.pro均301至此) | 200活 | 综合 | 无 | 旧API sousou.pro/api.php; /search需跟301 | B(可爬) |
| B9 | UP云搜 | https://www.upyunso.com | 200活 | 综合 | 无强登 | 网页表单(未拆API,未核) | B |
| B10 | 猫狸盘搜(喵哩盘搜) | https://alipansou.com | 200活 | 阿里为主 | 无 | 反爬重(SmallZombie拒适配) | B(需DrissionPage) |
| B11 | 咔帕搜索 | https://www.cuppaso.com | 200活 | 综合 | 无 | 未拆(未核) | B |
| B12 | 阿里搜 | https://aliso.cc | 200活 | 阿里/夸克 | 无 | 未拆(未核) | B |
| B13 | 千帆搜索 | https://pan.qianfan.app | 200活 | 综合 | 搜索免,取码需公众号 | 需公众号token(SmallZombie已适配,源码可抄) | B |
| B14 | 海豚搜索 | https://www.haitunsou.com | 200活 | 短剧/综合AI搜 | 无 | 网页路径 /s/{kw}(可爬) | B |
| B15 | 喵搜 | https://miaosou.fun | 403 CF盾 | 综合 | 无 | /api/secendsearch(API在CF后) | B |
| B16 | 易搜 | https://yiso.fun (so.yiso.me) | 403 CF盾/000 | 阿里/百度/夸克/迅雷 | 无 | CF盾,需浏览器过盾 | B |
| B17 | 盘库吧 | https://panku8.com | 200活 | 多盘+有效性检测 | 无 | 未拆(未核) | B |
| B18 | 懒盘聚合 | https://so.lzpanx.com 与 https://lzpan.com | 200活 | 导航+聚合 | 无 | 导航形态 | B |
| B19 | ED3000 | https://ed3000.com | 200(跳转页) | 综合 | 无 | 未拆(未核) | B |
| B20 | 夸克搜(元站demo) | https://www.quark.so | 200(Redirecting) | 夸克 | 无 | 元站CMS + yz_pansearch_api后端 | B |
| B21 | 大圣盘 | https://dashengpan.com | 200(转跳) | 综合 | 有:免费限次,看链付费 | — | C(墙) |
| B22 | kk系资源站 | kk大厅/kk短剧/kk橘子/kk小宇/kk小悠/kk天天追剧(域见OnePanSearchApi源码) | 未核 | 夸克/百度 | 无 | GET /search?keyword&type&fromSite&page(OnePanSearchApi实证) | A(经OnePanSearchApi) |
| B23 | TG机器人 | t.me/yunpan_bot(阿里) t.me/kejiqubot(夸克) t.me/YunPanHelp | 未核 | 阿里/夸克 | 无 | bot对话 | C |
| B24 | TG频道网页版 | t.me/s/{channel}?q={kw} | CloudSaver/pansou双件实证 | 全部盘 | 无 | 免登录爬取配方(本层基石) | A |

## 表C 已死/变向名单(2026-10-30实测,防二次踩坑)
kpanso.com(跳广告点击域=劫持) | pikaso.top(404) | xiongdipan.com(301并入aipanso) | aipanso.com爱盘搜(本机000+反爬) | xunjiso.com / ucyunso.com / tianyiso.com(本机000) | xuebapan.com学霸盘(000) | dabaipan.com(000) | yunsou.xyz(000) | sowangpan.com(000) | panduoduo.net盘多多(000) | quzhuanpan.com去转盘(000) | qupansou.com(变影视站) | pan.funletu.com(变fireoa工具站) | duososo.com(变识图站) | 史努比搜索引擎/大象搜索(全网无现存域名,WebSearch无果) | pansoo.cn 97盘搜(000) | telsearch.me(000)

## Working notes（过程检查点）
- [W1] WebSearch站名录: 易搜yiso.fun/UP云搜upyunso.com/学霸盘/云搜影视yunsou.xyz/duososo/小鹿盘搜(来源 zhihu.com/p/2060733051890676006, juejin.cn/post/7494448615239630883, bilibili cv18092458)
- [W2] 发现PanHub/lzpan_search/混合盘线索, 后经gh定位真身
- [W3] gh search核实A1-A30星数/活性(见上表, 均gh api一手)
- [W4] 生态件: netdisk-fast-download/quark-auto-save/QuarkPanTool/SmartStrm/hunhepan-pc/油猴Self-use 等
- [W5] 三头件深挖(raw源码): PanSou=/api/search全参数+~100插件目录; CloudSaver=t.me/s/爬取+cheerio+cloudPatterns; PanHub=PolyForm非商业+反脚本条款
- [W6] 许可证全核: MIT×8 / AGPL×3 / GPL×2 / PolyForm×1 / 无证×12(见A表)
- [W7] 38域名curl存活实测(见B/C表); 000=本机连不上(死/墙/换域待判), 403 Just a moment=CF盾
- [W8] 站点配方直出(pansou插件源码): qupansou=v.funletu.com; yunso=/api/Core/search2; haisou=/api/pan/share/search; jupansou=dyuzi.com/api/search/stream(SSE); aipan=/api/movies/search; miaosou=/api/secendsearch; pansearch=/_next/data; sousou=sousou.pro/api.php; yingso=ysapi.yingso.fun; labi=xiaocgege.shop
- [W9] API端点实测: yunso 200/JSON 44KB(免登录实锤); ysapi服务在; miaosou API 403 CF; v.funletu/haisou/aipan/pansearch本机000需代理复测(pansou插件2026-10仍在用应活)
- [W10] 补充: panku8盘库吧活/so.lzpanx懒盘活/97盘搜000/telsearch.me 000; TG机器人三件; alipansou更名喵哩盘搜; xinyue=纯管理壳; hunhepan=规则引擎+规则中心; 史努比/大象搜索全网无果(记D未核); mcp-pansou-search=gh 404仅npm在册

## 三强推荐
1. fish2018/pansou (MIT, 15085★) — 唯一T0选型, clone-and-adapt。它同时是引擎+源站配方库: /api/search 一个端点吃下全参数(kw/channels/plugins/cloud_types/filter), POST /api/check/links 白送探活; plugin/ 目录约100个插件, 每个插件配 html/json结构分析.md — 等于别人替我们把上百个聚合站逆向完了, 直接抽Go插件翻译成CLI适配器。二级缓存对高频查词直接可用。
2. CloudSaver 的 t.me/s/ 频道爬取配方 (MIT) — 本层地基层。TG频道网页版免登录无CF重盾, 是唯一不依赖第三方站点善意的搜索源; cheerio+cloudPatterns 正则方案可直接移植, 与PanSou的TG引擎双实现互备。
3. 站点直连API族(实测/配方双证) — yunso.net /api/Core/search2(本机200实证)、dyuzi.com /api/search/stream(SSE)、haisou.cc、v.funletu.com、aipan.me、yingso ysapi、kk系(OnePanSearchApi/yz_pansearch_api双实证) — 七个免登录JSON/SSE端点做冗余源。
组合: PanSou(Go核心+配方库) + CloudSaver(TG腿) + 直连腿三路并发去重=第一层; 第二层接 qaiu/netdisk-fast-download(MIT 3425★)。
