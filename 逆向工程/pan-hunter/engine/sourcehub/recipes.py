# -*- coding: utf-8 -*-
"""PAN-HUNTER L1 搜索源配方表（W0 · 2026-10-30）

出处纪律：每条配方的 endpoint/参数/头均自 fish2018/pansou plugin/（MIT，engine/pansou 冻结副本）
或 RESEARCH_DOCKET/r2_source_apis.md 逐行摘录，零猜测；配不齐的如实标 note。
运行形态：W0 架构裁决=「pansou 作配方库不作运行时」（取舍证据见 analysis/SOURCE_AUDIT_1030.md §1），
本表即配方库的 Python 化，执行器=core.py（curl_cffi impersonate）。

字段：
  name      源名（对齐 r2 编目）
  method    GET/POST
  url       完整 endpoint（{kw}=URL编码关键词）
  headers   附加头（UA 由 core 统一注入）
  json_body POST JSON 体（None=无）
  form_body POST form 体（None=无）
  kind      解析形态 json/html/sse/base64/tg/flarum/signflow
  kw_mode   all=3 关键词全跑 / first=仅关键词1（本日已证墙源省预算）
  note      出处与备注（含 pansou 插件名）
"""
from urllib.parse import quote

UA_NOTE = "UA/Referer 照抄 pansou 插件"  # 统一说明

def _q(kw: str) -> str:
    return quote(kw, safe="")


class Recipe(dict):
    """配方条目（dict 语法糖，便于 JSONL 落账）。"""
    def __init__(self, name, method, url, kind, *, headers=None, json_body=None,
                 form_body=None, kw_mode="all", note=""):
        super().__init__(name=name, method=method, url=url, kind=kind,
                         headers=headers or {}, json_body=json_body,
                         form_body=form_body, kw_mode=kw_mode, note=note)


def _xuebapan_kw(kw: str) -> str:
    # pansou plugin/xuebapan（经 akai-do/supansou 同构）：kw 去横杠去空格截 30 字
    return kw.replace("-", "").replace(" ", "")[:30]


RECIPES = [
    # --- A 级直调（r2 §一，当日 200 实测）---
    Recipe("naspt", "GET",
           "https://api.naspt.vip/api/open/pansou/search?kw={kw}&limit=20", "json",
           note="r2#1 A级实测 | pansou plugin/ikantv"),
    Recipe("melost", "POST", "https://www.melost.cn/v1/search/disk", "json",
           json_body={"page": 1, "q": "{kw}", "user": "", "exact": False,
                      "user_distinct": False, "format": [], "share_time": "",
                      "share_year": "", "size": 20, "order": "", "type": "",
                      "search_ticket": "", "exclude_user": [], "adv_params": {}},
           note="r2#2 A级实测 total=178 | pansou plugin/melost"),
    Recipe("panhunt", "POST", "https://s.panhunt.com/api/search", "json",
           headers={"Referer": "https://s.panhunt.com/"},
           json_body={"kw": "{kw}", "page": 1},
           note="r2#3 A级实测 total=51 | quarry sources/panhunt.py"),

    # --- TG 腿 ---
    Recipe("tg_tgsearchers7", "GET",
           "https://t.me/s/tgsearchers7?q={kw}", "tg",
           note="r2 §五 t.me/s/ 频道爬（pansou 默认频道 tgsearchers7）"),

    # --- B 级 JSON API ---
    Recipe("yunso", "POST", "https://www.yunso.net/api/Core/search2", "json",
           headers={"Referer": "https://www.yunso.net/"},
           form_body={"wd": "{kw}", "mode": "", "scope_content": "", "stype": "",
                      "uk": "", "page": "1", "limit": "10", "screen_filetype": ""},
           note="r2#6 | pansou plugin/yunso；W0 实测 curl_cffi 直连 200"),
    Recipe("haisou", "GET",
           "https://haisou.cc/api/pan/share/search?query={kw}&scope=title&page=1", "json",
           kw_mode="first",
           note="r2#7 | pansou plugin/haisou；W0 当日直连reset/代理h2reset/代理v1超时"),
    Recipe("sdso", "GET",
           "https://sdso.top/api/sd/search?name={kw}&pageNo=1&from=quark", "json",
           note="r2#8 | pansou plugin/sdso；from 值域 baidu/quark/xunlei/ali（源码 SupportedCloudTypes）"),
    Recipe("sousou", "GET",
           "https://sousou.pro/api.php?action=search&q={kw}&page=1&per_size=20&type=QUARK", "json",
           note="r2#9 | pansou plugin/sousou；type 值域 QUARK/BDY/ALY/XUNLEI/UC/115（源码 supportedDiskTypes）"),
    Recipe("jikepan", "POST", "https://api.jikepan.xyz/search", "json",
           headers={"Referer": "https://jikepan.xyz/"},
           json_body={"name": "{kw}", "is_all": False},
           note="r2#10 | pansou plugin/jikepan"),
    Recipe("funletu", "POST", "https://v.funletu.com/search", "json",
           headers={"Referer": "https://pan.funletu.com/"},
           json_body={"params": {"searchtext": "{kw}"}, "page": {"pageSize": 10, "pageIndex": 1},
                      "order": {"prop": "", "order": ""}},
           kw_mode="first",
           note="r2#11 | pansou plugin/qupansou；W0 当日代理+noVerify=404（疑站变 fireoa，R1 已预警）"),
    Recipe("hunhepan", "POST", "https://hunhepan.com/open/search/disk", "json",
           json_body={"page": 1, "q": "{kw}", "size": 20},
           note="r2#12 | pansou plugin/hunhepan（Xwudao/hunhepan-docs 官方开放API）"),
    Recipe("miaosou", "GET",
           "https://miaosou.fun/api/secendsearch?name={kw}&pageNo=1", "json",
           headers={"Referer": "https://miaosou.fun/",
                    "satoken": "c2F0b2tlbjpubXNwYXJrLWxvZ2luLmNvbTo0MDI4ODMxOTSNejZhUzdHeUtFSTh1TERqcGljS0pleUw"},
           kw_mode="first",
           note="r2#13 | pansou plugin/miaoso 共享 satoken（会过期）；W0 当日 CF 403 oldie"),
    Recipe("sopanya", "GET",
           "https://sopanya.com/api/other/web_search?title={kw}&is_type=-1", "sse",
           note="r2#15 | pansou plugin/sopanya；SSE 流，有行为风控"),
    Recipe("aipanso", "GET",
           "https://aipanso.com/search?page=1&k={kw}&p=baidu", "html",
           note="r2#16 | pansou plugin/xdpan；r2 实测返 SPA HTML 壳"),
    Recipe("ting77", "GET", "https://sou.77ting.top/search?q={kw}", "json",
           note="r2#17 | pansou plugin/ting77（GAP A12 未核项，本审计核）"),
    Recipe("squark", "GET", "https://squark.cc.cd/api/search{kw}", "json",
           note="r2#21 | pansou plugin/quarkres；kw 整体 URL 编码拼接（源码 apiBase+QueryEscape）"),
    Recipe("quarksoo", "GET", "https://quarksoo.cc/search.php?q={kw}", "html",
           note="r2#22 | pansou plugin/quarksoo（搜索参数名未在摘录中，q= 为探针形态，GAP A12）"),
    Recipe("upyunso", "GET",
           "https://api.upyunso.com/search?keyword={kw}&page=1&s_type=2", "base64",
           headers={"Referer": "https://www.upyunso.com/", "Origin": "https://www.upyunso.com"},
           note="r2#23 | TVBox 生态 py_yunso.py；响应体整体 base64"),
    Recipe("yuneu", "GET",
           "https://so.yuneu.com/search?q={kw}&format=video&page=1", "html",
           note="r2#30 | jak0099/dr 全盘搜.js；r2 实测 301"),
    Recipe("panyq", "GET", "https://panyq.com/", "signflow",
           kw_mode="first",
           note="r2#14 | pansou plugin/panyq：首页正则抓 sign → GET /api/search?sign&page=1（关键词不入参=最新流）"),

    # --- C 级 HTML ---
    Recipe("pansearch", "GET", "https://www.pansearch.me/search?keyword={kw}", "html",
           note="r2#27 | fre123 pansearch_spider.py；W0 实测代理 200"),
    Recipe("zhaozy", "GET", "https://zhaoziyuan.la/so?filename={kw}&t=1", "html",
           headers={"Referer": "https://zhaoziyuan.la/"},
           note="r2#26 | TVBox py_zhaozy.py"),
    Recipe("susuifa", "GET", "https://susuifa.com/?type=post&s={kw}", "html",
           note="r2#28 | pansou plugin/susu（WordPress ?s= 形态）；JWT 链接需 decodeJWTURL"),
    Recipe("xuebapan", "GET", "https://www.xuebapan.com/s/{kw}-1.html", "html",
           note="r2#29 | kw 去横杠去空格截30字（supansou 同构）"),
    Recipe("haitunsou", "GET", "https://www.haitunsou.com/s/{kw}.html", "html",
           note="r2#31 | pansou plugin/haitunsou 源码 searchURL"),
    Recipe("erxiaopan", "GET", "https://www.2xiaopan.one/vod/search/wd/{kw}.html", "html",
           note="r2#32 | pansou plugin/erxiaopan"),
    Recipe("kkmao", "GET", "https://www.kuakemao.com/?s={kw}", "html",
           note="r2#41 | pansou plugin/kkmao（WordPress ?s=%s 源码）"),
    Recipe("panta", "GET", "https://www.91panta.cn/search?keyword={kw}", "html",
           note="r2#45 | pansou plugin/panta 源码 search?keyword=%s"),
    Recipe("ouge", "GET", "https://woog.nxog.eu.org/api.php/provide/vod?ac=detail&wd={kw}", "json",
           note="r2#47 | pansou plugin/ouge 苹果CMS 采集API"),
    Recipe("bixin", "GET",
           "https://www.bixbiy.com/api/discussions?filter[q]={kw}&include=mostRelevantPost&page[offset]=0&page[limit]=20",
           "flarum",
           note="r2#48 | pansou plugin/bixin Flarum 标准API"),
    Recipe("pan666", "GET",
           "https://pan666.net/api/discussions?filter[q]={kw}&include=mostRelevantPost&page[offset]=0&page[limit]=20",
           "flarum",
           note="r2#48 | pansou plugin/pan666 Flarum 标准API"),
    Recipe("quark4k", "GET",
           "https://quark4k.com/api/discussions?filter[q]={kw}&include=mostRelevantPost&page[offset]=0&page[limit]=20",
           "flarum",
           note="r2#48 | pansou plugin/quark4k Flarum 标准API"),
    Recipe("mikuclub", "GET",
           "https://www.mikuclub.uk/wp-json/utils/v2/post_list?search={kw}&page=", "json",
           note="r2#49 | pansou plugin/mikuclub WordPress JSON API"),
    Recipe("leso", "POST", "https://www.leso.cc/search.php?searchsubmit=yes", "html",
           form_body={"mod": "forum", "srchtxt": "{kw}", "searchsubmit": "yes"},
           note="r2#50 | pansou plugin/leso 源码 POST form（Discuz 系）"),
    Recipe("miosou", "GET", "https://miosou.cc/miov1/search?keyword={kw}", "sse",
           headers={"Accept": "text/event-stream", "Referer": "https://miosou.cc/"},
           note="r2#50 | pansou plugin/miosou；源码带 Anubis 门（ensureGate），预期墙"),
    Recipe("clmao", "GET", "https://clm64.top/search?word={kw}&sort=time", "html",
           note="r2#40 | pansou plugin/clmao 源码 searchURL；kw GBK 编码后 QueryEscape（此处先 UTF-8 探针）"),
    Recipe("lingjisp", "GET",
           "https://web5.mukaku.com/prod/api/v1/getVideoList?app_id=83768d9ad4&identity=23734adac0301bccdcb107c4aa21f96c&sb={kw}&page=1&limit=20",
           "json",
           note="r2#19 | pansou plugin/lingjisp 源码常量（app_id/identity 系上游硬编码，作协议情报）"),
    Recipe("meitizy", "POST", "https://apis.451024.xyz/api/media/search", "json",
           json_body={"title": "{kw}", "page": 1, "size": 20},
           note="r2#20 | pansou plugin/meitizy 源码 searchRequest{Title,Page,Size}"),
]


def build_request(recipe: Recipe, kw: str):
    """配方 × 关键词 → (method, url, headers, json_body, form_body)。kw 逐槽替换。"""
    method = recipe["method"]
    url = recipe["url"].replace("{kw}", _q(kw))
    if recipe["name"] == "squark":
        url = "https://squark.cc.cd/api/search" + _q(kw)  # kw 整体编码拼接
    elif recipe["name"] == "xuebapan":
        url = f"https://www.xuebapan.com/s/{_q(_xuebapan_kw(kw))}-1.html"
    jb, fb = recipe["json_body"], recipe["form_body"]
    if jb:
        jb = {k: (v.replace("{kw}", kw) if isinstance(v, str) else v) for k, v in jb.items()}
        if isinstance(jb.get("params"), dict):
            jb["params"] = {k: (v.replace("{kw}", kw) if isinstance(v, str) else v)
                            for k, v in jb["params"].items()}
    if fb:
        fb = {k: (v.replace("{kw}", kw) if isinstance(v, str) else v) for k, v in fb.items()}
    return method, url, dict(recipe["headers"]), jb, fb
