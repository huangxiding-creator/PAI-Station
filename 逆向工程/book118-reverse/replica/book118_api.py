# -*- coding: utf-8 -*-
"""book118（原创力文档 max.book118.com）纯 HTTP API 客户端 — 1024 全渠道 API 化令。

零浏览器零CDP零第三方依赖（stdlib urllib + CookieJar + ssl 协议直连）。
2026-10-24 逆向战役 逆向工程/book118-reverse/ 实测口径（captures/probe*_account.json 全账）：

检索面（本战役主战果 — 推翻 T19「匿名搜索登录墙」表象结论）：
  GET https://max.book118.com/user_center_v1/home/Search/newSearchApi.html?q=<词>&page=<N>
    XHR 后端（渲染页 search.html 内联 search_index.url.loadmore 明文）。匿名 200：
    {code:1, data:{check_code:0, limit_search:<int>, list:{total:<int>, docs:[…20字段]}}}
    docs 字段 = uname/encode_aid/url/senddate/litpic/highlight/title/checkdate/
    vip_type/is_free/filetype/filesize/pagenumber/needmoney/hits/es_score/
    es_score_level/pay_num/down_num/doc_score（题录全量元数据）。
  「登录墙」真相 = 渲染层表象：页面内联 base.limit_search=1 只驱动客户端 login 弹窗
  （static index_new.js search_login.init），端点本身匿名放行（limit_search=0）。
  匿名深度实测：page1-3 全绿；page5 仍吐 docs 但 limit_search=2（软限信号）；
  page10+ docs 空 + limit_search=1（硬停）。→ 复刻件按 docs 空停 + 可配页深。

文字层（免费预览文字 ≥500 字/份的兑现腿）：
  GET https://max.book118.com/user_center_v1/home/Search/getTxt.html?aid=<encode_aid>&detail_id=0&keywords=<词>
    匿名 200：{code:1, data:{text:<999字关键词高亮真文>, is_collected/label/
    recent_download/money/vip_type/is_free}}。实测多档件（is_free=0/needmoney=200/
    vip_type=1 与 is_free=0/needmoney=100/vip_type=0）均 999 字。

详情面（预览参数，收割引擎 T19 口径平移 + 纯HTTP首跳实证）：
  GET https://max.book118.com/html/<YYYY>/<MMDD>/<docid>.shtm
    匿名 200（礼貌节流下）→ 页内联 var base：pic:{aid,actual_page,preview_page,
    view_token}（view_token 可能为 '//view-cache.book118.com/…view_token=<tok>'
    包装形态，取内层 token）+ 顶层 senddate('32hex')。
  预览页清单（图片床，文字层归 OCR 管线不在本件）：
  GET https://openapi.book118.com/getPreview.html?project_id=1&aid=<pic.aid>&t=<senddate>&view_token=<tok>&page=<1|7|13…>&callback=jsonpReturn

已知墙（如实）：
  - SafeLine(雷池) v2 挑战（HTTP 468 + /.safeline/ JS）：**速率触发非恒墙**。
    礼貌节流（.shtm ≥8s）+ PHPSESSID 复用实测 4/4 全绿；连打会触发。
    挑战本体 = issue→WASM PoW→verify→Set-Cookie sl-challenge-jwt
    （captures/probe5_safeline_challenge.js 107KB Parcel bundle 已留档，
    解算另立战役）。本件策略：冷却重试（SHTM_COOLDOWN_S）+ 显式
    SafeLineChallenge 异常（kind=safeline_challenge, 证据路径随异常透出）。
  - NewView 遗产链：对非浏览器流量 200+空 body（T19 实测）——本件不走。
  - tdsearch.html（三方追加腿）：code=1000 空（base.third.status=0 不启用）。

纪律：只读 GET；节流内置（SEARCH_GAP_S/GETTXT_GAP_S/SHTM_GAP_S）；每实例独立
CookieJar=独立会话；数字零造假（一切计数实测返回）；不破付费（收费件仅取题录+
免费 999 字预览文字，perm=yellow 标注，付费页图/原件不碰）。
"""
from __future__ import annotations

import json
import re
import ssl
import time
import urllib.error
import urllib.parse
import urllib.request
from dataclasses import dataclass, field
from http.cookiejar import CookieJar
from typing import Any

__all__ = [
    "Book118Client", "Book118ApiError", "SafeLineChallenge", "DocHit", "search",
    "preview_text", "cli",
]

SITE = "book118"
BASE = "https://max.book118.com"
OPENAPI = "https://openapi.book118.com/getPreview.html"
UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
      "(KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36")

#: 节流（实测安全值：probe5 8s 间隔 4/4 全绿；probe4 连打触发 468）
#: doclist 题录标题扩展名 → 格式（FileMeta.fmt 同族口径）
_FMT = {'doc': 'doc', 'docx': 'doc', 'pdf': 'pdf', 'ppt': 'ppt', 'pptx': 'ppt',
        'xls': 'xls', 'xlsx': 'xls', 'txt': 'txt', 'epub': 'epub'}

SEARCH_GAP_S = 3.0       # 检索腿（任务书红线 ≥3s）
GETTXT_GAP_S = 1.0       # 文字段腿
SHTM_GAP_S = 8.0         # .shtm 详情腿（SafeLine 速率敏感）
OPENAPI_GAP_S = 1.0      # openapi 预览批腿
SHTM_COOLDOWN_S = 65.0   # 468 触发后冷却
HTTP_TIMEOUT_S = 30.0

#: 匿名翻页硬停口径（probe3 实测 page10+ docs 空；留 1 页余量）
MAX_PAGES_DEFAULT = 5

CHALLENGE_MARKERS = (".safeline", "SafeLineChallenge")


class Book118ApiError(Exception):
    """API 失败（kind 机器可读：http_<code>/ safeline_challenge/ search_quota/
    no_docs/ bad_json/ api_status/ api_code/ net/ doc_deleted/ no_preview_data）。"""

    def __init__(self, kind: str, detail: str = ""):
        super().__init__(f"{kind}: {detail}")
        self.kind = kind
        self.detail = detail


class SearchQuota(Book118ApiError):
    """匿名检索配额墙（端点级实证形态：code=1 + limit_search>=1 + list=[]）。

    非登录墙（登录只影响配额额度）：当日实测先吐 7 发（limit_search=0 全绿），
    后置此形态；getTxt/doclist/.shtm/openapi 诸面不受此配额影响（同期全绿）。
    恢复窗口 >40min（1024 实测未恢复；按小时窗管理，产线宜账号态或错峰）。
    """

    def __init__(self, detail: str = ""):
        super().__init__("search_quota", detail)


class SafeLineChallenge(Book118ApiError):
    """SafeLine v2 挑战（468）：速率触发，冷却重试仍 468 才抛给调用方。"""

    def __init__(self, detail: str = ""):
        super().__init__("safeline_challenge", detail)


@dataclass
class DocHit:
    """newSearchApi 单条题录（20 字段全量透传 + 规范化键，零造假）。"""

    encode_aid: str
    title: str
    url: str = ""
    filetype: str = ""
    filesize: str = ""
    pagenumber: str = ""
    is_free: str = ""
    needmoney: str = ""
    vip_type: str = ""
    hits: str = ""
    down_num: str = ""
    pay_num: str = ""
    doc_score: str = ""
    es_score: str = ""
    senddate: str = ""
    uname: str = ""
    raw: dict = field(default_factory=dict)

    @property
    def shtm_url(self) -> str:
        return BASE + self.url if self.url.startswith("/") else self.url

    @property
    def paid(self) -> bool:
        """收费形态（needmoney>0 或 vip_type>0；题录级黄线标注用）。"""
        try:
            return int(self.needmoney or 0) > 0 or int(self.vip_type or 0) > 0
        except ValueError:
            return False


class Book118Client:
    """book118 纯 HTTP 会话客户端（每实例独立 CookieJar=独立会话）。

    协议直连（ProxyHandler({})）：本机系统代理常死（T19 实锤 7892 拒连），
    且站方无地域限制——直连即最快最稳路径。
    """

    def __init__(self, *, ua: str = UA, throttle: dict[str, float] | None = None):
        self._ua = ua
        self.jar = CookieJar()
        self._ctx = ssl.create_default_context()
        self._opener = urllib.request.build_opener(
            urllib.request.ProxyHandler({}),
            urllib.request.HTTPSHandler(context=self._ctx),
            urllib.request.HTTPCookieProcessor(self.jar))
        g = {"search": SEARCH_GAP_S, "gettxt": GETTXT_GAP_S,
             "shtm": SHTM_GAP_S, "openapi": OPENAPI_GAP_S}
        g.update(throttle or {})
        self._gap = g
        self._last: dict[str, float] = {}
        self.requests = 0            # 实测请求计数（零造假）
        self.last_search_total: int | None = None

    # ------------------------------------------------------------ 基础传输
    def _throttle(self, leg: str) -> None:
        gap = self._gap.get(leg, 1.0)
        last = self._last.get(leg)
        wait = gap - (time.monotonic() - last) if last else 0.0
        if wait > 0:
            time.sleep(wait)
        self._last[leg] = time.monotonic()

    def _get(self, url: str, *, leg: str, referer: str = BASE + "/",
             xhr: bool = True, retry_468: bool = True) -> bytes:
        headers = {"User-Agent": self._ua, "Referer": referer,
                   "Accept-Language": "zh-CN,zh;q=0.9", "Connection": "close"}
        if xhr:
            headers["Accept"] = "application/json, text/javascript, */*; q=0.01"
            headers["X-Requested-With"] = "XMLHttpRequest"
        else:
            headers["Accept"] = "text/html,application/xhtml+xml,*/*;q=0.8"
        try:
            self._throttle(leg)
            self.requests += 1
            with self._opener.open(
                    urllib.request.Request(url, headers=headers),
                    timeout=HTTP_TIMEOUT_S) as r:
                return r.read()
        except urllib.error.HTTPError as e:
            body = e.read()
            if e.code == 468 and retry_468:
                # SafeLine 速率墙：冷却一轮再试一次（probe5 实测冷却+节流可复绿）
                time.sleep(SHTM_COOLDOWN_S)
                return self._get(url, leg=leg, referer=referer, xhr=xhr,
                                 retry_468=False)
            if e.code == 468:
                raise SafeLineChallenge(
                    f"468 挑战页 {len(body)}B（冷却重试仍墙；"
                    f"解算件 captures/probe5_safeline_challenge.js 已留档）") from e
            raise Book118ApiError(f"http_{e.code}", f"{url} → {e.code} {len(body)}B") from e
        except urllib.error.URLError as e:
            raise Book118ApiError("net", f"{type(e.reason).__name__}: {e.reason}") from e

    # ------------------------------------------------------------ ① 检索面
    def search(self, query: str, limit: int = 10, *,
               max_pages: int = MAX_PAGES_DEFAULT) -> list[DocHit]:
        """纯 HTTP 题录检索：newSearchApi 翻页聚合，docs 空即停（零造假）。

        limit ≤0 视为不限（翻到硬停）。返回按站方序（es_score 排序，勿重排）。
        """
        out: list[DocHit] = []
        seen: set[str] = set()
        page = 1
        limit_n = int(limit) if limit and int(limit) > 0 else 0
        while page <= max_pages:
            q = urllib.parse.quote(query)
            body = self._get(
                f"{BASE}/user_center_v1/home/Search/newSearchApi.html?q={q}&page={page}",
                leg="search", referer=f"{BASE}/search.html?q={q}")
            try:
                j = json.loads(body.decode("utf-8", "replace"))
            except ValueError as e:
                raise Book118ApiError("bad_json", f"page={page} {e}") from e
            if int(j.get("code", 0)) != 1:
                raise Book118ApiError("api_code", f"page={page} code={j.get('code')}")
            data = j.get("data") or {}
            lst = data.get("list") or {}
            docs = lst.get("docs") or []
            if page == 1:
                self.last_search_total = lst.get("total")
            if not docs:
                if page == 1 and int(data.get("limit_search", 0) or 0) >= 1:
                    raise SearchQuota(           # 端点级实证：配额墙非登录墙
                        f"page=1 docs空 limit_search={data.get('limit_search')}"
                        f"（本轮已发 {self.requests} 发；getTxt/browse 不受影响）")
                break                      # 匿名深度硬停（limit_search 形态）
            for d in docs:
                aid = str(d.get("encode_aid") or "")
                if not aid or aid in seen:
                    continue
                seen.add(aid)
                out.append(DocHit(
                    encode_aid=aid, title=str(d.get("title") or ""),
                    url=str(d.get("url") or ""),
                    filetype=str(d.get("filetype") or ""),
                    filesize=str(d.get("filesize") or ""),
                    pagenumber=str(d.get("pagenumber") or ""),
                    is_free=str(d.get("is_free") or ""),
                    needmoney=str(d.get("needmoney") or ""),
                    vip_type=str(d.get("vip_type") or ""),
                    hits=str(d.get("hits") or ""),
                    down_num=str(d.get("down_num") or ""),
                    pay_num=str(d.get("pay_num") or ""),
                    doc_score=str(d.get("doc_score") or ""),
                    es_score=str(d.get("es_score") or ""),
                    senddate=str(d.get("senddate") or ""),
                    uname=str(d.get("uname") or ""),
                    raw=d))
                if limit_n and len(out) >= limit_n:
                    return out
            page += 1
        return out

    # ------------------------------------------------------------ ② 文字段
    def preview_text(self, encode_aid: str, keywords: str) -> dict[str, Any]:
        """getTxt 免费预览文字（实测 999 字/件，关键词高亮真文）。"""
        q = urllib.parse.quote(keywords)
        body = self._get(
            f"{BASE}/user_center_v1/home/Search/getTxt.html"
            f"?aid={urllib.parse.quote(str(encode_aid))}&detail_id=0&keywords={q}",
            leg="gettxt", referer=f"{BASE}/search.html?q={q}")
        try:
            j = json.loads(body.decode("utf-8", "replace"))
        except ValueError as e:
            raise Book118ApiError("bad_json", f"getTxt {encode_aid} {e}") from e
        if int(j.get("code", 0)) != 1:
            raise Book118ApiError("api_code", f"getTxt code={j.get('code')}")
        d = j.get("data") or {}
        return {"text": str(d.get("text") or ""), "chars": len(str(d.get("text") or "")),
                "is_free": d.get("is_free"), "vip_type": d.get("vip_type"),
                "money": d.get("money"), "is_collected": d.get("is_collected")}

    def search_with_text(self, query: str, limit: int = 10, *,
                         text_min_chars: int = 0) -> list[dict[str, Any]]:
        """检索+逐件文字段（≥text_min_chars 才收，验收口径 ≥500）。"""
        hits = self.search(query, limit)
        rows: list[dict[str, Any]] = []
        for h in hits:
            try:
                pv = self.preview_text(h.encode_aid, query)
            except Book118ApiError:
                pv = {"text": "", "chars": 0}
            row = {"encode_aid": h.encode_aid, "title": h.title,
                   "shtm_url": h.shtm_url, "filetype": h.filetype,
                   "pagenumber": h.pagenumber, "is_free": h.is_free,
                   "needmoney": h.needmoney, "vip_type": h.vip_type,
                   "hits": h.hits, "es_score": h.es_score,
                   "paid": h.paid, "text_chars": pv["chars"],
                   "text": pv["text"]}
            rows.append(row)
        if text_min_chars:
            rows = [r for r in rows if r["text_chars"] >= text_min_chars]
        return rows

    # ------------------------------------------------------------ ①b 浏览面（免配额）
    #: doclist 分类页（/doclist/list-<id>[-<page>].html）：静态 .shtm 直链清单，
    #: 匿名无配额（1024 实测 quota 墙期仍全绿）；条目=title+hits+pages。
    RE_DOCLIST_ITEM = re.compile(
        r'href="(/html/\d{4}/\d{4}/(\d+)\.shtm)"[^>]*title="([^"]+)"', re.S)
    RE_DOCLIST_META = re.compile(
        r'(\d+)页')                        # 条目行尾「N页」页数标注

    def browse(self, list_id: int, page: int = 1) -> list[dict[str, Any]]:
        """doclist 分类页题录（ungated；每页 80 条，深翻 ≤50 页）。

        返回 [{doc_id, shtm_url, title, filetype, hits, pages}]。题录标题带
        扩展名后缀 → filetype 推断；hits/pages 取条目行内数字（无则空串，零造假）。
        """
        url = (f"{BASE}/doclist/list-{int(list_id)}.html" if page <= 1 else
               f"{BASE}/doclist/list-{int(list_id)}-{int(page)}.html")
        body = self._get(url, leg="shtm", referer=BASE + "/doclist/",
                         xhr=False)
        h = body.decode("utf-8", "replace")
        out: list[dict[str, Any]] = []
        seen: set[str] = set()
        # 条目=链接+title 属性 + 行内元数据（hits 数字 / N页）
        for m in self.RE_DOCLIST_ITEM.finditer(h):
            path, doc_id, title = m.group(1), m.group(2), m.group(3)
            if doc_id in seen:
                continue
            seen.add(doc_id)
            # 条目纯文本尾部 = 「<序号> <标题> <hits> <N>页」——标签剥离后取尾双数
            tail = re.sub(r"<[^>]+>", " ", h[m.end():m.end() + 800])
            tail = re.sub(r"\s+", " ", tail)
            mm = re.search(r"(\d+)\s+(\d+)\s*页", tail)
            hits = mm.group(1) if mm else ""
            pages = mm.group(2) if mm else ""
            suffix = title.rsplit(".", 1)[-1].lower() if "." in title else ""
            out.append({"doc_id": doc_id, "shtm_url": BASE + path,
                        "title": title,
                        "filetype": _FMT.get(suffix, suffix or "doc"),
                        "hits": hits, "pages": pages})
        return out

    # ------------------------------------------------------------ ③ 详情/预览参数
    def doc_detail(self, shtm_url_or_docid: str) -> dict[str, Any]:
        """.shtm 详情页 → 预览参数（pic.aid/view_token 内层/senddate/页数）。

        view_token 双形态：裸 token（旧档）或 '//view-cache…view_token=<tok>'
        包装（新档）——统一取内层 token。
        """
        u = str(shtm_url_or_docid)
        if not u.startswith("http"):
            docid = "".join(re.findall(r"\d+", u))
            u = f"{BASE}/index.php?g=Home&m=NewView&a=index&aid={docid}"  # 不可用面
            raise Book118ApiError(
                "no_shtm_url",
                "请给完整 .shtm URL（题录行 shtm_url）；裸编号路径不可推（缺 YYYY/MMDD）")
        body = self._get(u, leg="shtm", referer=BASE + "/", xhr=False)
        h = body.decode("utf-8", "replace")
        if "该文档已经被删除" in h:
            raise Book118ApiError("doc_deleted", u)
        aid = re.search(r"pic\s*:\s*\{\s*aid\s*:\s*(\d+)", h)
        vt_wrap = re.search(r"view_token=(1_vf[^'&\s]+)", h)
        vt_raw = re.search(r"view_token\s*:\s*'([^']+)'", h)
        send = re.search(r"senddate\s*:\s*'([0-9a-f]{32})'", h)
        pre = re.search(r"preview_page\s*:\s*(\d+)", h)
        act = re.search(r"actual_page\s*:\s*(\d+)", h)
        if not (aid and send):
            raise Book118ApiError("no_preview_data", f"{u} 无 pic.aid/senddate")
        tok = (vt_wrap.group(1) if vt_wrap
               else (vt_raw.group(1) if vt_raw else ""))
        if tok.startswith("//") or "view_token=" in tok:
            tok = re.search(r"view_token=([^&'\" ]+)", tok)
            tok = tok.group(1) if tok else ""
        return {"shtm_url": u, "aid": int(aid.group(1)), "view_token": tok,
                "t": send.group(1),
                "preview_page": int(pre.group(1)) if pre else None,
                "actual_page": int(act.group(1)) if act else None,
                "project_id": 1}

    def preview_pages(self, detail: dict[str, Any], *,
                      max_batches: int = 3) -> dict[int, str]:
        """openapi getPreview 页图清单批拉取（6页/批，page=1,7,13…对齐批）。

        返回 {页号: 图URL}。图片床文字层归 OCR 管线（harvest_engine T13/T33），
        本件只出清单（对接点：Book118Adapter.fetch_ladder 同源参数）。
        """
        pages: dict[int, str] = {}
        batch = 1
        for i in range(max_batches):
            payload = None
            for attempt in (1, 2, 3):    # T41: empty_data 形态实测占 61%——退避重打
                qs = ("project_id={project_id}&aid={aid}&t={t}&view_token={vt}"
                      "&page={p}&callback=jsonpReturn").format(
                    project_id=detail.get("project_id", 1), aid=detail["aid"],
                    t=detail["t"],
                    vt=urllib.parse.quote(detail["view_token"], safe="@_"),
                    p=batch)
                body = self._get(OPENAPI + "?" + qs, leg="openapi",
                                 referer=BASE + "/")
                txt = body.decode("utf-8", "replace").strip()
                m = re.search(r"jsonpReturn\((.*)\)\s*;?\s*$", txt, re.S) if txt else None
                try:
                    cand = json.loads(m.group(1) if m else txt) if txt else None
                except ValueError:
                    cand = None            # 非 JSON 风控壳：退避重试
                if isinstance(cand, dict) and cand.get("code") == 100:
                    raise Book118ApiError(  # 系统错误（参数形态件）不属抖动——如实停
                        "api_status",
                        f"openapi code=100 {cand.get('message', '')}"
                        f"（aid={detail['aid']}）")
                if isinstance(cand, dict) and isinstance(cand.get("data"), dict) \
                        and cand["data"]:
                    payload = cand
                    break
                time.sleep(2.0 * attempt)  # 数据形态错退避（T41 家族）
            if payload is None:
                break                       # 连续空批：预览清单到此为止（如实）
            urlmap = payload.get("data") or {}     # data 本体=页号→图URL 映射
            if not isinstance(urlmap, dict) or not urlmap:
                break
            for k, v in urlmap.items():
                try:
                    pages[int(k)] = str(v)
                except (TypeError, ValueError):
                    continue
            batch += 6
        return pages


# ---------------------------------------------------------------- 模块级便捷口

def search(query: str, limit: int = 10) -> list[DocHit]:
    """一次性检索（独立会话；逐站账在返回前即终态，无残留客户端）。"""
    return Book118Client().search(query, limit)


def preview_text(encode_aid: str, keywords: str) -> dict[str, Any]:
    """一次性文字段（独立会话）。"""
    return Book118Client().preview_text(encode_aid, keywords)


# ---------------------------------------------------------------- CLI

def _cli() -> int:
    import argparse
    from pathlib import Path
    ap = argparse.ArgumentParser(
        prog="py -3 book118_api.py",
        description="book118 纯 HTTP API（检索题录 + 免费预览文字 ≥500字 + 预览参数）")
    sub = ap.add_subparsers(dest="cmd", required=True)
    sp = sub.add_parser("search", help="题录检索（--with-text 附 999 字预览文字）")
    sp.add_argument("query")
    sp.add_argument("--limit", type=int, default=10)
    sp.add_argument("--with-text", action="store_true")
    sp.add_argument("--min-chars", type=int, default=0, help="文字段最低字数过滤")
    sp.add_argument("--json", default="", help="结果落盘路径（缺省打印）")
    dp = sub.add_parser("detail", help=".shtm 详情 → 预览参数 + 页图清单(≤3批)")
    dp.add_argument("shtm_url")
    dp.add_argument("--pages", action="store_true", help="附 openapi 页图清单")
    dp.add_argument("--json", default="")
    args = ap.parse_args()
    cli_ = Book118Client()
    if args.cmd == "search":
        if args.with_text:
            rows = cli_.search_with_text(args.query, args.limit,
                                         text_min_chars=args.min_chars)
            out = {"query": args.query, "total": cli_.last_search_total,
                   "requests": cli_.requests, "rows": rows}
        else:
            hits = cli_.search(args.query, args.limit)
            out = {"query": args.query, "total": cli_.last_search_total,
                   "requests": cli_.requests,
                   "hits": [h.__dict__ | {"shtm_url": h.shtm_url, "paid": h.paid}
                            for h in hits]}
    else:
        detail = cli_.doc_detail(args.shtm_url)
        out = {"detail": detail, "requests": cli_.requests}
        if args.pages:
            out["preview_pages"] = cli_.preview_pages(detail)
            out["requests"] = cli_.requests
    text = json.dumps(out, ensure_ascii=False, indent=1)
    if args.json:
        Path(args.json).write_text(text, encoding="utf-8")
        print(f"[book118_api] {cli_.requests} 发 → {args.json}")
    else:
        print(text)
    return 0


if __name__ == "__main__":
    raise SystemExit(_cli())
