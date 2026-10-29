# -*- coding: utf-8 -*-
"""百度文库渠道适配器（W5，元数据层）。

配方照抄 W3.5 实测（kb_rev/web_search_capture/search_api.py + capture.md，勿改端点）：
    POST https://wenku.baidu.com/gsula/sula/syncmrecall
    body={"requests":[{"sceneID":"PCSearch","params":{"word":词,"pn":页,"noCacheMembershipCard":True}}]}
    桌面 UA，零 Cookie 零登录。
铁律：无登录/零下载/间隔>=3s/日上限500(可配 KB_WENKU_MIN_INTERVAL / KB_WENKU_DAILY_LIMIT)。
映射：fileType 1→doc 2→pdf 3→ppt 4→xls 5→txt 7→epub 16→ebook；
     sellType∈{2,5}→badge=wenku_vip/perm=yellow（任务指定启发式，语义未核验见 capture.md §5），其余 green。

ndview 侧门元数据增强（wenku-search-reverse 1024 接线，复刻件
逆向工程/wenku-search-reverse/replica/wenku_full_api.py 同源配方）：
    GET https://wenku.baidu.com/ndview/{docId}.html（view 页对非浏览器指纹 403，侧门实证 200）
    → var pageData.readerInfo → 按 docId 对 syncmrecall 命中条目批量补强 FileMeta：
    pages 缺(无/0)则补权威总页数(page||originalPage||freePage)，增强项(page/show_page/
    preview_full/kind/tpl_key/tpl_name/页几何/copy_unlimited/can_free_down)进 extra['ndview']。
    同步收编 syncmrecall 17 字段卡现有 FileMeta 未消费的 4 项（copyable/createTime/tagList/cover）。
    2.0 A1 目录层深化：tags（标签）/category（类目）进 extra['ndview']（白名单 +2 键；
    pageData.docInfo 候选键兜底合入——提取件 wenku_taxonomy.py，候选键缺席如实不造）。
铁律（免费层零下载）：ndview 只取元数据——htmlUrls 载荷/rsign/md5sum/bucketNum/storeId/
    rtcsRangeInfo 属 type3 BOS 直链下载道（付费履约层），本适配器一律不碰不透传；
    htmlUrls 仅读结构形态判三型（§5.2 唯一权威序），不取任何 URL 值。
频控：ndview 子配额=独立 RateLimiter（间隔1s/日800，可配 KB_WENKU_NDVIEW_MIN_INTERVAL /
    KB_WENKU_NDVIEW_DAILY_LIMIT）；失败 fail-soft 退回现状（syncmrecall 原字段原样保留）。
开关：默认关（离线测试零网络纪律）——KB_WENKU_NDVIEW=1 或构造参 ndview=True 开启。
"""
import json
import re
import ssl
import time
import urllib.parse
import urllib.request

from kb_factory.channel_adapters.base import (CircuitOpenError, ChannelAdapter, FileMeta,
                                              RateLimiter, RateLimitExceeded)
from kb_factory.channel_adapters.wenku_taxonomy import (merge_docinfo_taxonomy,
                                                        taxonomy_fields)

_URL = "https://wenku.baidu.com/gsula/sula/syncmrecall"
_UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) "
       "Chrome/129.0.0.0 Safari/537.36")
_FMT = {1: "doc", 2: "pdf", 3: "ppt", 4: "xls", 5: "txt", 7: "epub", 16: "ebook"}
_VIP_SELL = {2, 5}
_MAX_PAGES = 50  # 翻页安全上限（12条/页×50页远超 per_topic 需求）

# ndview 侧门（wenku-search-reverse 实测配方；view 页 403 勿撞，侧门 200 含 var pageData）
_NDVIEW_TMPL = "https://wenku.baidu.com/ndview/{doc_id}.html"
# GET 头（复刻件同源）：UA/Sec-Ch-Ua/Platform 三头同源自洽（Chrome129+Windows+Not_A Brand，
# T41 P0-1 指纹口径），ndview 对非浏览器指纹有 WAF 打分，Sec-Ch 系列对放行有实质影响。
_NDVIEW_HEADERS = {"User-Agent": _UA,
                   "Accept": "text/html,application/xhtml+xml,*/*;q=0.8",
                   "Accept-Language": "zh-CN,zh;q=0.9",
                   "Referer": "https://wenku.baidu.com/",
                   "Sec-Ch-Ua": '"Google Chrome";v="129","Chromium";v="129","Not_A Brand";v="24"',
                   "Sec-Ch-Ua-Mobile": "?0",
                   "Sec-Ch-Ua-Platform": '"Windows"',
                   "Upgrade-Insecure-Requests": "1"}
# docId 形态（harvest_engine T18 现场校准同口径）：base62+-_，16~64（新式 40 hex/老式 20~28）
_DOC_ID_RE = re.compile(r"^[0-9A-Za-z_-]{16,64}$")
# ndview 增强白名单（铁律守门：下载道字段不在其内，越此集即违约）
# 2.0 A1 深化：+tags/category 两键（目录层情报，候选键防御性扫描——真键名缺席
# 如实不造，提取件=wenku_taxonomy.py 新文件，接线见该文件头）
_NDVIEW_KEYS = frozenset({"page", "original_page", "free_page", "show_page", "preview_full",
                          "kind", "tpl_key", "tpl_name", "page_width_px", "page_height_px",
                          "copy_unlimited", "can_free_down", "tags", "category"})


def _payload(word: str, pn: int) -> dict:
    return {"requests": [{"sceneID": "PCSearch",
                          "params": {"word": word, "pn": pn, "noCacheMembershipCard": True}}]}


def _headers(word: str) -> dict:
    return {"User-Agent": _UA, "Content-Type": "application/json;charset=utf-8",
            "Accept": "application/json, text/plain, */*",
            "Referer": "https://wenku.baidu.com/search?word=" + urllib.parse.quote(word),
            "Origin": "https://wenku.baidu.com", "Accept-Language": "zh-CN,zh;q=0.9"}


def _urllib_fetch(word: str, pn: int, timeout: float) -> dict:
    """真网络腿：stdlib urllib POST（测试用假 _fetch 替换，不打真网络）。"""
    body = json.dumps(_payload(word, pn), ensure_ascii=False).encode("utf-8")
    req = urllib.request.Request(_URL, data=body, headers=_headers(word), method="POST")
    with urllib.request.urlopen(req, timeout=timeout,
                                context=ssl.create_default_context()) as r:
        return json.loads(r.read().decode("utf-8", "replace"))


_fetch = _urllib_fetch  # 可 monkeypatch 的网络函数（单一定义点）


# ---------------------------------------------------------------- ndview 侧门（元数据增强）

def _extract_pagedata(html: str) -> dict | None:
    """`var pageData` 锚点 → 引号/转义感知花括号配平 → 严格 JSON（复刻件/harvest_engine 同型）。"""
    anchor = html.find("var pageData")
    if anchor < 0:
        return None
    start = html.find("{", anchor)
    if start < 0:
        return None
    depth, in_str, quote, escaped = 0, False, "", False
    for i in range(start, len(html)):
        ch = html[i]
        if in_str:
            if escaped:
                escaped = False
                continue
            if ch == "\\":
                escaped = True
                continue
            if ch == quote:
                in_str = False
            continue
        if ch in ('"', "'"):
            in_str, quote = True, ch
            continue
        if ch == "{":
            depth += 1
        elif ch == "}":
            depth -= 1
            if depth == 0:
                try:
                    return json.loads(html[start:i + 1])
                except json.JSONDecodeError:
                    return None
    return None


def _ndview_urllib_fetch(doc_id: str, timeout: float):
    """ndview 真网络腿（stdlib urllib，与检索腿同栈）：GET 侧门 → readerInfo dict。

    200 但挖不出 var pageData（WAF 页/删件同路）→ 如实 None；网络/HTTP 异常照抛
    （上层 _enrich_ndview fail-soft 兜住）。只读元数据，零下载零落盘。
    2.0 A1 深化：pageData.docInfo 的类目/标签候选键合入返回 dict（浅拷贝，
    readerInfo 已有键不覆写）——候选集/零造假口径见 wenku_taxonomy.py。
    """
    req = urllib.request.Request(_NDVIEW_TMPL.format(doc_id=doc_id),
                                 headers=dict(_NDVIEW_HEADERS))
    with urllib.request.urlopen(req, timeout=timeout,
                                context=ssl.create_default_context()) as r:
        html = r.read().decode("utf-8", "replace")
    pd = _extract_pagedata(html)
    if isinstance(pd, dict) and isinstance(pd.get("readerInfo"), dict):
        return merge_docinfo_taxonomy(pd["readerInfo"], pd)
    return None


_ndview_fetch = _ndview_urllib_fetch  # 可 monkeypatch 的 ndview 网络函数（单一定义点）


def _pos_int(v):
    """正整数语义化（JS 真值跳过 0/空；bool 排除）：非正/非数字 → None。"""
    if isinstance(v, bool):
        return None
    if isinstance(v, int):
        return v if v > 0 else None
    if isinstance(v, str) and v.strip().isdigit():
        n = int(v)
        return n if n > 0 else None
    return None


def _num(v):
    """parseFloat 语义数值化（pageInfo 实弹为字符串 "892.979"）：非数字 → None（不造假 0）。"""
    if isinstance(v, bool):
        return None
    if isinstance(v, (int, float)):
        return float(v)
    if isinstance(v, str):
        try:
            return float(v.strip())
        except ValueError:
            return None
    return None


def _judge_kind(ri: dict) -> str:
    """三型形态判定（§5.2 唯一权威序）：htmlUrls 对象带 json → type3 / 数组 → type2 /
    rtcsRangeInfo → type1 / 皆无 → unknown。只读结构形态，不取任何载荷 URL。"""
    hu = ri.get("htmlUrls")
    if isinstance(hu, dict) and len(hu.get("json") or []) > 0:
        return "type3"
    if isinstance(hu, list) and len(hu) > 0:
        return "type2"
    rtcs = ri.get("rtcsRangeInfo")
    if isinstance(rtcs, list) and len(rtcs) > 0:
        return "type1"
    return "unknown"


def _ndview_extra(ri: dict) -> dict:
    """readerInfo → 元数据白名单 dict（缺席字段如实不造：None 一律剔除）。

    铁律守门：htmlUrls 载荷/rsign/md5sum/bucketNum/storeId/rtcsRangeInfo 等下载道
    字段不进本函数产出（§ 免费层零下载）；产出一律 ⊆ _NDVIEW_KEYS。
    """
    info = ri.get("pageInfo") if isinstance(ri.get("pageInfo"), dict) else {}
    pwa = ri.get("readPagePwa") if isinstance(ri.get("readPagePwa"), dict) else {}
    copy_unlimited = ri.get("copyUnlimited")
    can_free_down = pwa.get("canFreeDown")
    out = {"page": _pos_int(ri.get("page")) or _pos_int(ri.get("originalPage"))
           or _pos_int(ri.get("freePage")),
           "original_page": _pos_int(ri.get("originalPage")),
           "free_page": _pos_int(ri.get("freePage")),
           "show_page": _pos_int(ri.get("showPage")),
           "kind": _judge_kind(ri),
           "tpl_key": ri.get("tplKey") or None,
           "tpl_name": ri.get("tplName") or None,
           "page_width_px": _num(info.get("pageWidth")),
           "page_height_px": _num(info.get("pageHeight")),
           "copy_unlimited": copy_unlimited if isinstance(copy_unlimited, bool) else None,
           "can_free_down": can_free_down if isinstance(can_free_down, bool) else None}
    if out["page"] and out["show_page"]:
        out["preview_full"] = out["show_page"] >= out["page"]
    out.update(taxonomy_fields(ri))    # 目录层：tags/category（候选键缺席=成员如实省略）
    return {k: v for k, v in out.items() if v is not None}


def _merge_ndview(meta: FileMeta, ri: dict) -> None:
    """ndview 补强并入 FileMeta（就地）：pages 缺(无/0)才补权威总页数（已有值不动，
    ndview 侧页数仍在 extra['ndview'].page 可查，零造假可对账）；增强项进 extra['ndview']。"""
    nd = _ndview_extra(ri)
    if nd.get("page") and not (isinstance(meta.pages, int) and meta.pages > 0):
        meta.pages = nd["page"]
    if nd:
        meta.extra["ndview"] = nd


def _strip_em(s):
    return re.sub(r"</?em>", "", s or "")


def _parse(j: dict) -> list:
    """从响应提取 .data.items.PCSearch.result.items 的 data 列表（配方路径照抄）。"""
    res = (j.get("data", {}).get("items", {}).get("PCSearch") or {}).get("result", {})
    return [it.get("data", {}) for it in res.get("items", []) if it.get("data")]


def _to_meta(x: dict) -> FileMeta:
    vip = x.get("sellType") in _VIP_SELL
    return FileMeta(
        title=_strip_em(x.get("title")),
        fmt=_FMT.get(x.get("fileType"), "bin"),  # 未知fileType→bin（judge警告修复：不再透传裸数字）
        pages=x.get("pageNum"),
        badge="wenku_vip" if vip else "green_free",
        perm="yellow" if vip else "green",
        source_url=x.get("url") or None,
        extra={"doc_id": x.get("docID"), "sell_type": x.get("sellType"),
               "views": x.get("viewCount"), "downloads": x.get("downloadCount"),
               "score": x.get("qualityScore"), "abstract": _strip_em(x.get("content"))[:150],
               # 17 字段卡原有未消费项（同一响应零额外请求；缺席如实 None/[]）
               "copyable": x.get("copyable"), "create_time": x.get("createTime"),
               "tags": x.get("tagList") or [], "cover": x.get("cover")},
    )


class WenkuMetaAdapter(ChannelAdapter):
    channel = "wenku"

    def __init__(self, limiter: RateLimiter | None = None, timeout: float = 15.0,
                 retries: int = 1, audit=None, ndview: bool | None = None,
                 ndview_limiter: RateLimiter | None = None):
        import os
        if limiter is None:
            limiter = RateLimiter(
                min_interval=float(os.environ.get("KB_WENKU_MIN_INTERVAL", "3")),
                daily_limit=int(os.environ.get("KB_WENKU_DAILY_LIMIT", "500")),
                name="wenku")
        self.limiter = limiter
        # ndview 增强：默认关（KB_WENKU_NDVIEW=1 / ndview=True / 注入 ndview_limiter 任一开）
        # ——默认关是离线测试零网络纪律所迫（在役适配器谨慎最小改，行为不静默漂移）。
        if ndview is None:
            ndview = os.environ.get("KB_WENKU_NDVIEW", "0") == "1"
        self.ndview = bool(ndview) or ndview_limiter is not None
        if ndview_limiter is None and self.ndview:
            ndview_limiter = RateLimiter(
                min_interval=float(os.environ.get("KB_WENKU_NDVIEW_MIN_INTERVAL", "1")),
                daily_limit=int(os.environ.get("KB_WENKU_NDVIEW_DAILY_LIMIT", "800")),
                name="wenku_ndview")
        self.ndview_limiter = ndview_limiter
        self.timeout = timeout
        self.retries = retries  # 重试 1 次（含首次共 2 次尝试）
        self.audit = audit      # None=不记审计（单测注入 tmp 审计时才落盘）

    def _log(self, event, query, t0, count, detail=""):
        if self.audit is not None:
            self.audit.log(channel=self.channel, event=event, query=query,
                           elapsed_ms=int((time.monotonic() - t0) * 1000), count=count,
                           detail=detail)

    def available(self) -> bool:
        s = self.limiter.status()
        return not s["circuit_open"] and s["count_today"] < s["daily_limit"]

    def metadata(self, query: str, limit: int = 12) -> list:
        out, pn = [], 1
        while len(out) < limit and pn <= _MAX_PAGES:
            self.limiter.acquire()  # 日上限/熔断在此抛 RateLimitExceeded / CircuitOpenError
            t0 = time.monotonic()
            j, err = None, None
            for _attempt in range(self.retries + 1):
                try:
                    j = _fetch(query, pn, self.timeout)
                    break
                except Exception as e:  # 网络/解析失败：重试1次
                    err = e
            if j is None:
                self.limiter.record_error()
                self._log("error", query, t0, 0, f"{type(err).__name__}: {err}")
                break  # 如实降级：返回已取得的部分
            self.limiter.record_success()
            raw = _parse(j)
            self._log("request", query, t0, len(raw), f"pn={pn}")
            if not raw:
                break  # 空页停
            out.extend(_to_meta(x) for x in raw)
            pn += 1
        out = out[:limit]
        if self.ndview and out:
            self._enrich_ndview(out, query)  # ndview 失败→退回现状（fail-soft，不动已有字段）
        return out

    def _enrich_ndview(self, metas: list, query: str) -> None:
        """ndview 侧门按 docId 批量补强（只补返回条目，省子配额）。

        fail-soft 三层：①子配额尽/熔断 → 整批退回现状（审计 ndview_degrade 一行即停）；
        ②单条网络失败/挖不出 pageData → 该条退回现状继续下一条（ndview_error）；
        ③docId 形态不合 → 如实跳过不硬凑。重复 docId 复用同次结果（不二发）。
        """
        cache: dict = {}
        for m in metas:
            doc_id = m.extra.get("doc_id")
            if not isinstance(doc_id, str) or not _DOC_ID_RE.match(doc_id):
                continue
            if doc_id in cache:
                if cache[doc_id]:
                    _merge_ndview(m, cache[doc_id])
                continue
            try:
                self.ndview_limiter.acquire()  # 子配额：间隔/日上限/熔断在此抛
            except (RateLimitExceeded, CircuitOpenError) as e:
                self._log("ndview_degrade", query, time.monotonic(), 0,
                          f"{type(e).__name__}: {e}")
                return
            t0 = time.monotonic()
            try:
                ri = _ndview_fetch(doc_id, self.timeout)
            except Exception as e:  # 网络/HTTP 失败：单条降级继续
                self.ndview_limiter.record_error()
                self._log("ndview_error", query, t0, 0, f"{type(e).__name__}: {e}")
                cache[doc_id] = None
                continue
            if not isinstance(ri, dict):
                self.ndview_limiter.record_error()  # 200 但无 pageData（WAF/删件同路）
                self._log("ndview_error", query, t0, 0, "no readerInfo")
                cache[doc_id] = None
                continue
            self.ndview_limiter.record_success()
            _merge_ndview(m, ri)
            cache[doc_id] = ri
            self._log("ndview", query, t0, 1,
                      f"doc={doc_id[:12]} show/page={_pos_int(ri.get('showPage')) or 0}"
                      f"/{_pos_int(ri.get('page')) or 0} kind={_judge_kind(ri)}")
