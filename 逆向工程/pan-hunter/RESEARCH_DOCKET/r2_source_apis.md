# R2 搜索源 API 清单与调用形态（pan-hunter 战役）

研究员 R2 | 2026-10-30 | 母港：免登录网盘资源检索 CLI
评级：A=无门槛直调（实测 200 JSON）｜B=需 UA/Referer/简单门票，或 TLS 指纹被拦（浏览器栈可过）｜C=需解析 HTML（含 JWT/base64 解码层）｜D=登录/验证码/加密配置/强反爬
探针环境：本机 curl（Chrome UA，直连）。000/TLS reset = Cloudflare 对 curl TLS 指纹的拦截，不代表源死。实测=当日 200 验证；代码实证=权威开源项目源码内硬编码调用；未核=未实测。

## 一、实测 A 级（无门槛直调，当日 200 JSON）

| # | 源名 | endpoint | 调用形态 | 返回 | 覆盖盘 | 门票 | verdict | 出处 |
|---|------|----------|----------|------|--------|------|---------|------|
| 1 | ikantv/naspt | https://api.naspt.vip/api/open/pansou/search?kw=<kw>&limit=<n> | GET | JSON data[] | 聚合（TG源库） | 无（UA 即可） | A 实测 | fish2018/pansou plugin/ikantv |
| 2 | 影盘社 melost | https://www.melost.cn/v1/search/disk | POST JSON {page,q,user:"",exact:false,size,adv_params:{}} | JSON data.total/search_result | 全盘混合 | 无（UA 即可） | A 实测（total=178 验证） | pansou plugin/melost |
| 3 | panhunt 聚合 | https://s.panhunt.com/api/search | POST JSON {kw,page} + Referer: https://s.panhunt.com/ | JSON data.merged_by_type{pan,magnet} | 聚合+磁力 | 无 token 可用 | A 实测（total=51 验证） | taffy-owo/quarry sources/panhunt.py |
| 4 | pansou 自部署 | http://<自部署>:8888/api/search | POST JSON {kw,page} | JSON 统一聚合 | 13+ 盘 | 自部署免 key（AUTH 默认关） | A（自部署后） | fish2018/pansou（MIT 15085 星，2026-10-12 活跃） |

## 二、B 级：JSON API·代码实证（本机 curl TLS 拦/未过测，常规浏览器 TLS 预期可过）

| # | 源名 | endpoint | 调用形态 | 返回 | 覆盖盘 | 门票 | verdict | 出处 |
|---|------|----------|----------|------|--------|------|---------|------|
| 5 | 易搜 yiso | https://yiso.fun/api/search?name=<kw>&from=ali | GET + UA + Referer(yiso.fun) | JSON data.list[]（fileInfos/url） | 阿里 | 无；CF 拦 curl TLS（实测 403 oldie 模板） | B/C | sec-an/TV_Spider spider/yiso.py；镜像 yiso.work |
| 6 | 云搜 yunso | https://www.yunso.net/api/Core/search2 | POST form wd/mode/scope_content/stype/uk/page/limit/screen_filetype | JSON | 百度/夸克/UC | 无（Chrome UA） | B（探针 000 未核） | pansou plugin/yunso |
| 7 | 海搜 haisou | https://haisou.cc/api/pan/share/search?query=<kw>&scope=title&pan=<盘>&page=<n>&filter_valid=true&filter_has_files=false | GET | JSON | 全盘（可按 pan 筛） | 无 | B（探针 000 未核） | pansou plugin/haisou |
| 8 | sdso | https://sdso.top/api/sd/search?name=<kw>&pageNo=<n>&from=<盘> | GET | JSON | 全盘（from 筛盘） | 无 | B（实测 200 但返 SPA HTML 壳，头待调，未核） | pansou plugin/sdso |
| 9 | 搜搜 sousou | https://sousou.pro/api.php?action=search&q=<kw>&page=<n>&per_size=<n>&type=<t> | GET | JSON | 全盘 | 无 | B（实测 567 反爬码，未核） | pansou plugin/sousou |
| 10 | 即刻盘 jikepan | https://api.jikepan.xyz/search | POST JSON {name,is_all:false} | JSON | 夸克/混合 | 无 | B（探针 000 未核） | pansou plugin/jikepan |
| 11 | 趣盘搜 qupansou | https://v.funletu.com/search | POST JSON {params:{searchtext},page:{pageSize,pageIndex},order:{prop,order}} | JSON | 全盘 | 无 | B（探针 000 未核） | pansou plugin/qupansou |
| 12 | 混合盘 hunhepan | https://hunhepan.com/open/search/disk | POST JSON {page,q,size}（同 melost 骨架） | JSON | 全盘混合 | 无（开放 API，官方文档仓 Xwudao/hunhepan-docs） | B（探针 000 未核） | pansou plugin/hunhepan |
| 13 | 秒搜 miaoso | https://miaosou.fun/api/secendsearch?name=<kw>&pageNo=1 | GET + 硬编码 satoken 头 + Referer(miaosou.fun) | JSON | 全盘 | 共享 satoken（源码明文，过期需换） | B/C（实测 403 CF） | pansou plugin/miaoso |
| 14 | 盘友圈 panyq | https://panyq.com/api/search?sign=<sign>&page=<n> | GET；sign 从首页 HTML 正则抓（sign/sha/hash 三元组，panyq.go:979-1004） | JSON | TG 盘资源 | sign=一次性门票 | B/C | pansou plugin/panyq |
| 15 | 搜帕尼亚 sopanya | https://sopanya.com/api/other/web_search?title=<kw>&is_type=-1 | GET | SSE 流（data: JSON 行） | 全盘 | 无静态门票；实测触发安全验证 SSE 消息 | B/D（有行为风控） | pansou plugin/sopanya（探针实证） |
| 16 | 爱盘搜 aipanso | https://aipanso.com/search?page=1&k=<kw>&p=baidu | GET（p=盘型） | 实测返 SPA HTML 壳（前端再取数） | 百度/夸克 | 无 | B/C 实测 200 | pansou plugin/xdpan |
| 17 | 77听 ting77 | https://sou.77ting.top/search?q=<kw> | GET | 未核（JSON/HTML 待验） | 影视盘 | 无 | B 未核 | pansou plugin/ting77 |
| 18 | 聚盘搜 jupansou | https://dyuzi.com（搜索 URL 由 kw 拼接） | GET | 未核 | 全盘 | 无 | B 未核 | pansou plugin/jupansou |
| 19 | 灵犀 lingjisp | https://web5.mukaku.com/prod/api/v1/ | GET（v1 前缀 API） | 未核 | 全盘 | 无 | B 未核 | pansou plugin/lingjisp |
| 20 | meitizy | https://apis.451024.xyz | GET（API 网关型域名） | 未核 | 未核 | 无 | B 未核 | pansou plugin/meitizy |
| 21 | squark | https://squark.cc.cd/api/search（kw encodeURIComponent 拼接） | GET | JSON 未核 | 夸克 | 无 | B（探针 000 未核） | pansou plugin/quarkres |
| 22 | quarksoo | https://quarksoo.cc/search.php | GET | 未核 | 夸克 | 无 | B 未核 | pansou plugin/quarksoo |
| 23 | 老UP云搜 api | https://api.upyunso.com/search?keyword=<kw>&page=1&s_type=2 + Referer/Origin=upyunso.com | GET；响应体整体 base64，decode 后 JSON result.items[]，详情 decode 出 res_url 直链 | base64(JSON) | 全盘 | 无静态门票；CF 拦 curl（探针 000） | B/C | franksun1211/TXT mhqtv/py/py_yunso.py（TVBox 生态） |
| 24 | UP云搜新版 | https://www.upyunso.com（AES-128-CBC，key=iv=qq1920520460qqxx + HMAC upyunso_hmac_s3cr3t_2026；临时注册拿 token，down_count 配额耗尽再注册） | 加密 POST | JSON | 全盘 | 临时注册 token（全自动可产） | B（可自动化，工程量大） | taffy-owo/quarry sources/upyunso.py（MIT-0） |
| 25 | pansou 官方公开实例 | https://so.252035.xyz、https://ps.252035.xyz/api/search | POST JSON {kw,page} + Authorization: Bearer <token> + Referer | JSON（同 pansou 自部署） | 13+ 盘 | 需 token；且 TLS 指纹检查拒 httpx，须 urllib/浏览器栈 | B（门票+TLS 双门槛） | quarry sources/ps252035.py 注释实证 |

## 三、C 级：HTML 解析源（GET 网页 + xpath/正则，无门票或轻门票）

| # | 源名 | endpoint/形态 | 覆盖盘 | 备注 | 出处 |
|---|------|---------------|--------|------|------|
| 26 | 找资源 zhaozy | https://zhaoziyuan.la/so?filename=<kw>&t=<1视频/7文件夹> + Referer | 阿里 | HTML 列表 xpath //li[@class=clear]/div/div[@class=news_text]/a；探针 000=CF 拦 curl | TVBox py_zhaozy.py / CatVodTVSpider Zhaozy.java |
| 27 | PanSearch | https://www.pansearch.me/search?keyword=<kw>（HTML）；另有 POST /api/search JSON（未核） | 全盘 | HTML 内正则 抽 序号:链接 对；CF 拦 curl（探针 000） | fre123-com/yz_pansearch_api pansearch_spider.py；PanHub config |
| 28 | 苏苏打 susuifa | https://susuifa.com GET 搜索 | 全盘 | 结果链接为 JWT，base64 解 payload 取 data.url 真链（decodeJWTURL:504） | pansou plugin/susu |
| 29 | 学霸盘 | https://www.xuebapan.com/s/<kw>-1.html（kw 去横杠截 30 字） | 百度 | HTML+正则抽 password/date；纯 UA | akai-do/supansou backend/search_engine/xuebapan.py |
| 30 | 云搜 yuneu | https://so.yuneu.com/search?q=<kw>&format=video&page=<n> | 百度/夸克 | 实测 301（跟随目标待核）；TVBox 全盘.js 在用 | jak0099/dr js/搜索/全盘搜.js |
| 31 | 海豚搜 | https://www.haitunsou.com/s/<kw>.html | 全盘 | HTML | pansou plugin/haitunsou |
| 32 | 2小盘 | https://www.2xiaopan.one/vod/search/wd/<kw>.html（翻页 /page/<n>/wd/） | 小众盘 | HTML | pansou plugin/erxiaopan |
| 33 | 搜数据 | https://sou.s.soushuju.cn/?search=<kw> | 全盘 | HTML | fre123 yz_pansearch_api soushuju_spider.py |
| 34 | KK看吧 | https://z.kkkob.com/app/index.html（app 取数）、http://m.kkqws.com；PanHub 用 http://s.kkkob.com/v/api | 全盘 | HTML/混合 | fre123 kk_spider.py；PanHub config.py |
| 35 | 下小七 xxq | http://okkmm.com、http://so1.l71.top | 全盘 | HTML | fre123 xxq_spider.py |
| 36 | 奇乐搜 | https://www.qileso.com/tag/quark | 夸克 | HTML | PanHub config.py |
| 37 | 心悦搜 | https://www.xinyueso.com/s/ | 全盘 | HTML | PanHub config.py |
| 38 | PanHub | https://panhub.fun/s/ | 全盘 | HTML | yymhai/PanHub config.py |
| 39 | 猫狸盘搜 alipansou | https://alipansou.com | 阿里 | HTML（站内搜索页，API 细节未核） | dl666123 云盘清单 |
| 40 | 猫猫 clmao | https://clm64.top | 全盘 | 未核 | pansou plugin/clmao |
| 41 | 夸克猫 kkmao | https://www.kuakemao.com/ | 夸克 | 未核 | pansou plugin/kkmao |
| 42 | 凭链 pinglian | https://pinglian.lol | 全盘 | 未核 | pansou plugin/panlian |
| 43 | PanWiki | https://www.panwiki.com | 全盘 | 未核 | pansou plugin/panwiki |
| 44 | 盘尊 panzun | https://www.panzun.cc | 全盘 | 未核 | pansou plugin/panzun |
| 45 | 91panta | https://www.91panta.cn/search | 全盘（Discuz 系） | HTML，UA+Referer | pansou plugin/panta |
| 46 | 趣盘社 | https://www.qupanshe.com | 夸克 | 未核 | pansou plugin/qupanshe |
| 47 | 欧歌/玩偶 CMS | https://woog.nxog.eu.org/api.php/provide/vod?wd=<kw> | 影视盘+磁力 | 苹果CMS 标准采集 API（免门票） | pansou plugin/ouge、wanou |
| 48 | Flarum 系三源 | bixbiy.com/api/discussions、pan666.net/api/discussions、quark4k.com/api/discussions（?q=<kw>） | 夸克 | Flarum 标准 JSON API | pansou plugin/bixin、pan666、quark4k |
| 49 | mikuclub | https://www.mikuclub.uk/wp-json/utils/v2/post_list | 网盘资源 | WordPress JSON API | pansou plugin/mikuclub |
| 50 | leso / miosou | https://www.leso.cc、https://miosou.cc | 全盘 | 未核 | pansou plugin/leso、miosou |

pansou 122 插件全量名单（影视站为主，泛盘类已尽列上表）：
488run 5266ys ahhhhfs aikanzy aipan alupan ash bixin btbtlb buerchen cldi clmao clxiong cyg daishudj diduan discourse djgou duanjuw duoduo dy4k dygang dyyj dyyjpro erxiao erxiaopan feikuai gaoqing888 gying haisou haitunsou hdmoli hdr4k hjzhencai huban hunhepan ikantv javdb jikepan jsnoteclub jupansou jutoushe kkmao kkv kpkuang labi leijing leso libvio lingjisp lou1 meitizy melost miaoso mikuclub miosou mizixing muou nsgame nyaa ouge pan365 pan666 panlian pansearch panta panwiki panyq panzun pianku pioz qingying qiwei qqpd quark4k quarkres quarksoo quarktv qupanshe qupansou rrbt sdso shandian sopanya sousou susu thepiratebay ting77 u3c3 wanou weibo woniu wuji xb6v xdpan xdyh xiaoji xiaokupan xiaoyu xiaozhang xinjuc xuexizhinan xys yingso yiove ypfxw yuhuage yulinshufa yunso yunsou zhizhen zlxapp zxzj（源：/tmp/pansou_ref tarball plugin/ 目录）

## 四、D 级（登录/验证码/加密配置，免登录 CLI 口径下不优先）

| 源名 | 门槛 | 出处 |
|------|------|------|
| 千帆搜索 pan.qianfan.app / tg.qianfan.app | 需登录 | dl666123 清单 |
| 奈斯搜索 niceso.fun | 需登录 | dl666123 清单 |
| 咔帕搜索 cuppaso.fun | 关注公众号拿验证码 | dl666123 清单 |
| 影搜 ysapi.yingso.fun | 先 GET 接口配置（URLVersion/UserID）→ payload AES 加密 → POST /{版本}/search | pansou plugin/yingso（可破但工程量大） |
| 来搜一下 laisoyixia.com | 未核（疑似轻门票） | dl666123 清单 |
| 奇妙聚合 magicalsearch.top | 未核 | dl666123 清单 |

## 五、Telegram 搜索引擎类（兼收）

| 源名 | endpoint | 形态 | verdict | 出处 |
|------|----------|------|---------|------|
| Telegago | https://telegago.com/?q=<kw> | Google CSE 定制搜索（302 到谷歌域，需浏览器渲染） | C | bellingcat/toolkit、XORCISM connectors/telegago |
| lyzem.com | https://lyzem.com/search?q=<kw> | TG 全文搜索网页 | C 未核 | OSINT 清单常见 |
| sssoou.com | https://www.sssoou.com/ | TG 中文资源搜索网页 | C 未核 | dl666123 清单 |
| t.me/s/ 频道直爬 | https://t.me/s/<channel> | 频道网页版逐条翻（pansou 的 TG 搜索即此法，无 API 门票） | A（单频道口径） | fish2018/pansou 源码 |

## 六、引擎/复用资产（拿来主义，先于自研）

| 项目 | 星/许可 | 活跃 | 我们拿什么 | 采用方式 |
|------|---------|------|------------|----------|
| fish2018/pansou | 15085 MIT | 2026-10-12 | 122 源插件全量调用形态（本报告主矿）、统一 /api/search 聚合、AUTH 可关 | reuse：自部署当聚合底座（fit 95%） |
| taffy-owo/quarry | MIT-0 | 2026-05-19 | upyunso AES 逆完件、panhunt/ps252035 适配器、TLS 指纹经验 | reuse（适配器范式+密钥情报） |
| akai-do/supansou | MIT | 2026-10-21 | xuebapan 引擎、拼写容错/有效性检测思路 | pattern |
| yymhai/PanHub | Apache-2.0 | 2026-02-04 | 5 源配置化清单+UA 池 | pattern |
| 759039446/OnePanSearchApi | 无 LICENSE | 2025-08 | pansearch/kkkob driver 范式 | pattern only（无许可） |
| fre123-com/yz_pansearch_api | 未标 | 2025-11 | pansearch/soushuju/kk/xxq 四爬虫 | pattern only |
| TVBox 猫爪生态（sec-an/TV_Spider、franksun1211、liu673cn/drpy） | 多数无许可 | 持续 | yiso/zhaozy/upyunso 老 API 调用形态 | pattern only |

## 七、反爬地形摘要

1. Cloudflare TLS 指纹墙是头号地形：yiso/pansearch.me/miaosou 探针 403（CF oldie 模板）、upyunso/zhaozy/jikepan/yunso/haisou/squark/hunhepan/qupansou 探针 000（TLS reset）。curl 必死；requests+浏览器栈（DrissionPage，本站默认）或 tls-client/urllib 可过——quarry 实证 ps.252035 拒 httpx 须 urllib 为同类。
2. 行为风控：sopanya 返 SSE 安全验证消息；sousou 返 567；需随机 UA + Referer + 限速。
3. 一次性门票族：panyq sign（首页正则抓）、miaosou 共享 satoken（源码明文、会过期）、upyunso 临时注册 token（down_count 配额）、yingso 接口配置+加密。
4. 无频控证据：melost/s.panhunt/api.naspt.vip 当日裸 curl 即 200 JSON 零门票（未见 issue 级频控证据，未核）。
5. pansearch.me 官方 API（POST /api/search JSON）存在但被 CF 罩住，浏览器栈下待核。

## 八、调用示例（伪代码 3 则）

```python
# 1) A 级直调：s.panhunt.com（实测 200，POST JSON + Referer）
import requests
r = requests.post("https://s.panhunt.com/api/search",
    json={"kw": keyword, "page": 1},
    headers={"Referer": "https://s.panhunt.com/", "User-Agent": UA_CHROME}, timeout=10)
for t, items in r.json()["data"]["merged_by_type"].items():   # pan / magnet
    for it in items:
        yield (it["name"], it["url"], t)

# 2) A 级直调：melost.cn（实测 200，POST JSON 全参数）
body = {"page": 1, "q": keyword, "user": "", "exact": False, "user_distinct": False,
        "format": [], "share_time": "", "share_year": "", "size": 20, "order": "",
        "type": "", "search_ticket": "", "exclude_user": [], "adv_params": {}}
r = requests.post("https://www.melost.cn/v1/search/disk", json=body,
    headers={"User-Agent": UA_CHROME}, timeout=10)
# r.json()["data"]["search_result"] 即结果列表

# 3) B/C 级：api.upyunso.com（GET + base64 解码层，Referer/Origin 必带，需浏览器级 TLS）
import base64, json
from urllib.parse import quote
r = requests.get("https://api.upyunso.com/search?keyword=%s&page=1&s_type=2" % quote(keyword),
    headers={"User-Agent": UA_CHROME, "Referer": "https://www.upyunso.com/",
             "Origin": "https://www.upyunso.com"}, timeout=10)
data = json.loads(base64.b64decode(r.text))      # 响应体整体 base64
for v in data["result"]["items"]:
    yield (v["file_name"], v["insert_time"])     # 详情 api.upyunso.com/{id} → base64 JSON 的 res_url=直链
```

## 九、Working notes（过程留痕）

- gh 已认证（github.com huangxiding-creator），代码搜索走 gh api search/code。
- taffy-owo/quarry（MIT-0，2026-05-19）：sources/ 含 panhunt/pansou/upyunso/ps252035 适配器；ps252035 TLS 指纹拒 httpx、upyunso AES key=iv=qq1920520460qqxx+临时注册配额，均为注释实证。
- fish2018/pansou：MIT 15085 星，2026-10-12 push；tarball 拉至 /tmp/pansou_ref 本地 grep，122 插件 URL 全表 + 12 个核心插件调用形态逐行摘录；README：AUTH_ENABLED 默认 false，自部署即免 key；TG 搜索=t.me/s/ 频道爬。
- sec-an/TV_Spider spider/yiso.py：yiso GET /api/search?name=&from=ali JSON；token 仅阿里转存播放用。
- dl666123/dl666123.github.io backup/云盘资源搜索合集.md：人工源清单（qianfan/alipansou/yiso/niceso/magicalsearch/sssoou/laisoyixia/cuppaso/pansearch）。
- 探针实录（2026-10-30 本机 curl，Chrome UA）：200=api.naspt.vip、melost、s.panhunt、sdso(HTML 壳)、sopanya(SSE 风控)、aipanso(HTML 壳)、telegago(302)、yuneu(301)；403(CF)=yiso、miaosou；000(TLS reset)=haisou、jikepan、yunso、zhaozy、squark、hunhepan、qupansou、upyunso、pansearch.me。
- 许可证核验：pansou=MIT、quarry=MIT-0、supansou=MIT、PanHub=Apache-2.0、OnePanSearchApi=无 LICENSE（pattern only）、yz_pansearch_api=未标。
- 未核项已逐条标注（ting77/jupansou/lingjisp/meitizy/quarksoo/leso/miosou 等只到插件 URL 实证层级）。
