# -*- coding: utf-8 -*-
"""百度文库收割适配器地基（T18）：URL 规范化 + docId 提取 + search 段（WENKU_SPEC §2；FR2.1/FR2.AC1）。

本任务只落地基（任务卡路径纪律）：
- docId 提取：``extract_doc_id`` 纯解析（零网络）+ ``resolve_doc_id`` 重定向兜底
  （路径无 id 的跳转壳才走网络）；
- URL 规范化：``normalize_wenku_url`` → canonical ``https://wenku.baidu.com/view/{docId}.html``
  （剔 ?fr= 等全部 query；ndview/wapwenku/裸 id 归一 PC view）；
- ``WenkuDownloadAdapter``：DownloadAdapter 子类骨架，注册 channel="wenku"（site 同值对齐
  基类命名）；search 段挂 WenkuMetaAdapter（kb_factory/channel_adapters/wenku_meta.py 真符号，
  syncmrecall 免登录）+ docId/canonical 对齐。plan/fetch_ladder/verify 仅骨架抛
  NotImplementedError，由 T22（readerInfo 采集+ACS 补页）/T26/T31/T35（三型重组）在同文件
  续建——编排层（T40）只注册过验收适配器。

现场校准（2026-10-22 实测，证据固化在 tests/test_wenku_docid.py docstring；WENKU_SPEC §2
置信 medium → 实证修正）：
- docId 新式 = 40 位 hex（syncmrecall 12/12 条实测），老式 = 20~28 位 base62（SPEC §2）
  并存 → 字符域 [0-9A-Za-z_-]、长度 16~64 宽兼容；
- ndview/{docId}.html 是 view 的有效别名端点（HTTP 200 + var pageData，不重定向）；
- wapwenku.baidu.com/view/{docId}.html 重定向**丢 docId**（桌面 UA 301→wenku 首页；
  移动 UA 两跳→wk.baidu.com?pcf=2）→ 提取顺序必须是「先原始路径纯解析，后重定向兜底」；
- view 页纯 httpx 直连 403（WAF 指纹墙）→ 本件不抓 view 页（readerInfo 属 T22）。

T22 增量（readerInfo 采集+ACS 补页+信封陷阱+无进展熔断；FR2.2/FR2.3；§3.1/§3.2/§6.3/§8）：
- 初始 readerInfo = 纯 HTTP 免签挖取走 **ndview 侧门**（``fetch_page_data``；view 403 勿撞）
  → ``parse/inline_var.extract_page_data``；
- 免费额度不足（showPage<page）→ ``PagedFetcher.for_wenku`` 补页（rn=50 游标推进），
  每批经 ``signer.fetch_readerinfo``（PageSigner 鸭子型；匿名带签实测 OK/tri_cap 两态，
  T17 报告在案；账号登录态归 T29）；
- 信封 = ``envelope.judge_wenku`` 三态：code:0 陷阱（无 htmlUrls=Fail）/ tri_cap →
  NeedVerify 熔断退避**不判死**；
- 无进展熔断（连续 3 轮，paged_fetcher 内置）命中 FR2.3 判据（+showPage<page+非 tri_cap）
  → ``mark_wall_status`` 落 needs_vip_candidate 候选 + perm 备注 + ledger（正式标记归 T38）；
- ledger（HarvestAudit）如实记 showPage/page（SYNTHESIS 缺口#3 校准）；文件名清洗
  ``sanitize_title``（§5.1）。三型重组（T26/T31/T35）：T26 已在 fetch_ladder 接线三型
  分派（类型3 实装）；T31 实装类型2（纯图片+OCR 字数参照，§7.3+注记#5）；类型1 占位钉
  T35，结果落 ``last_reader_info``。
"""
from __future__ import annotations

import re
import urllib.parse
from dataclasses import dataclass

from kb_factory.channel_adapters.base import FileMeta
from kb_factory.channel_adapters.wenku_meta import WenkuMetaAdapter
from kb_factory.harvest_engine.adapters.base import (DownloadAdapter, HarvestPlan, LadderResult)

try:  # T22 增量件：合并后正名 kb_factory.harvest_engine.*；worktree 阶段回退顶层名
    from kb_factory.harvest_engine.adapters.base import (LADDER_ORDER, WALL_NEEDS_VIP_CANDIDATE,
                                                         mark_wall_status)
    from kb_factory.harvest_engine.envelope import EnvelopeFail, EnvelopeNeedVerify
    from kb_factory.harvest_engine.fetch.paged_fetcher import (NO_PROGRESS_LIMIT,
                                                               PagedFetchResult, PagedFetcher,
                                                               STOP_ABORTED, STOP_EXHAUSTED,
                                                               STOP_FETCH_FAILED,
                                                               STOP_NO_PROGRESS, BatchResponse)
    from kb_factory.harvest_engine.parse.inline_var import extract_page_data
except ImportError:
    from harvest_engine.adapters.base import (LADDER_ORDER, WALL_NEEDS_VIP_CANDIDATE,
                                              mark_wall_status)
    from harvest_engine.envelope import EnvelopeFail, EnvelopeNeedVerify
    from harvest_engine.fetch.paged_fetcher import (NO_PROGRESS_LIMIT, PagedFetchResult,
                                                    PagedFetcher, STOP_ABORTED, STOP_EXHAUSTED,
                                                    STOP_FETCH_FAILED, STOP_NO_PROGRESS,
                                                    BatchResponse)
    from harvest_engine.parse.inline_var import extract_page_data

__all__ = [
    "CANONICAL_BASE", "DOC_ID_MIN_LEN", "DOC_ID_MAX_LEN", "WENKU_HOST_RE", "VIEW_PATH_RE",
    "DOC_ID_RE", "canonical_view_url", "extract_doc_id", "normalize_wenku_url",
    "resolve_doc_id", "WenkuDownloadAdapter",
    # —— T22（readerInfo 采集+ACS 补页+信封陷阱+无进展熔断）——
    "NDVIEW_URL_TMPL", "WENKU_PAGE_LIMIT", "WenkuPageDataError", "sanitize_title",
    "reader_total_pages", "reader_show_pages", "html_urls_to_pages", "merge_html_urls",
    "fetch_page_data", "ReaderInfoLegResult",
]

CANONICAL_BASE = "https://wenku.baidu.com"   # PC canonical 站点基址

# docId 字符域：base62 + - _（SPEC §2 复刻建议正则 [0-9a-zA-Z_-]+ 收窄）；
# 长度 16~64：下限兼容老式 20~28 位（取 16 留余量），上限防误吃长路径段；
# 上不封死 28：现场校准实测新式为 40 位 hex（2026-10-22 syncmrecall 12/12）。
DOC_ID_MIN_LEN = 16
DOC_ID_MAX_LEN = 64
DOC_ID_RE = re.compile(rf"^[0-9A-Za-z_-]{{{DOC_ID_MIN_LEN},{DOC_ID_MAX_LEN}}}$")

# host 白名单：wenku.baidu.com 及其任意子域（www./m.）+ 移动站 wapwenku.baidu.com。
# wk.baidu.com 实测为 wapwenku 重定向落点但 docId 已丢——不入白名单（零造假：不猜）。
WENKU_HOST_RE = re.compile(r"^(?:[a-z0-9-]+\.)*wenku\.baidu\.com$|^wapwenku\.baidu\.com$", re.I)

# view/ndview 路径（.html 可省、尾斜杠容错）；wapwenku 同为 /view/{docId}.html。
VIEW_PATH_RE = re.compile(rf"^/(?:view|ndview)/([0-9A-Za-z_-]{{{DOC_ID_MIN_LEN},{DOC_ID_MAX_LEN}}})"
                          r"(?:\.html)?/?$")

#: 浏览器指纹快照（T41 P0-1 指纹统一，2026-10-23）：UA / Sec-CH-UA / Sec-CH-UA-Platform
#: 三头必须同源自洽——Chrome 129 + Windows + Sec-CH 含 Not_A Brand 条目。历史形态
#: （UA=Chrome/129 Windows ↔ Sec-CH-UA v=120 ↔ Platform macOS 三处互斥）系复刻 WENKU_SPEC
#: §3.1「buildHeaders 全套」的抄录失真，任何规则引擎仅凭头即可判死（PentAGI flow 11 判级
#: P0）。改版本时三处必须同步改——禁止单独改其一（见 test_wenku_readerinfo
#: test_fr2_2_p0_1_fingerprint_snapshot_self_consistent 守门）。
_UA_VERSION = "129"
_SEC_CH_UA = '"Google Chrome";v="129","Chromium";v="129","Not_A Brand";v="24"'
_SEC_CH_UA_PLATFORM = '"Windows"'

_DEFAULT_UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) "
               f"Chrome/{_UA_VERSION}.0.0.0 Safari/537.36")


def canonical_view_url(doc_id: str) -> str:
    """docId → PC canonical view URL（唯一规范化出口）。"""
    return f"{CANONICAL_BASE}/view/{doc_id}.html"


def extract_doc_id(url_or_id: str, *, depth: int = 0) -> str | None:
    """纯解析提取 docId（零网络；FR2.1：输入为 wenku URL 或裸 docId 时解析出 docId）。

    接受形态：
    - 裸 docId（16~64 位 [0-9A-Za-z_-]，新式 40 hex / 老式 20~28 base62 均可）；
    - wenku.baidu.com（含子域）/wapwenku.baidu.com 的 ``/view/{docId}.html``、
      ``/ndview/{docId}.html``（.html 可省；query 一律不参与，?fr= 等自动无效化）；
    - 移动页 ``?url=`` 跳转参数（SPEC §2）：指向 wenku view 页时解一层（depth 防深递归）。

    非 wenku 域、路径无 docId → None（如实，不猜）。
    """
    if not url_or_id:
        return None
    s = url_or_id.strip()
    if DOC_ID_RE.match(s):
        return s
    split = urllib.parse.urlsplit(s)
    host = (split.hostname or "").lower()
    if host:
        if not WENKU_HOST_RE.match(host):
            return None  # 非 wenku 域：不按 wenku 规则提取
    elif not s.lower().startswith(("view/", "ndview/")):
        return None  # 无 host 且非 wenku 相对 view 路径（避免误吃 example.com/view/.. 类串）
    m = VIEW_PATH_RE.match(split.path)
    if m:
        return m.group(1)
    if depth >= 1:
        return None
    qs = urllib.parse.parse_qs(split.query)
    for inner in qs.get("url", []):  # 移动页 ?url= 跳转参数（SPEC §2）
        if inner.startswith(("http://", "https://")):
            doc_id = extract_doc_id(inner, depth=depth + 1)
            if doc_id:
                return doc_id
    return None


def normalize_wenku_url(url: str) -> str | None:
    """URL 规范化（FR2.1）：任意 wenku URL/裸 docId → canonical PC view URL。

    剔除 ?fr= 等全部 query（现场校准：syncmrecall source_url 12/12 带 ?fr=incomeN-doc-search）；
    ndview/wapwenku/?url= 壳全部归一 ``https://wenku.baidu.com/view/{docId}.html``；
    解析不出 docId → None。
    """
    doc_id = extract_doc_id(url)
    return canonical_view_url(doc_id) if doc_id else None


def _httpx_redirect_chain(url: str, timeout: float) -> list[str]:
    """重定向兜底默认网络腿：httpx 跟随跳转，返回全跳链 URL（首跳→终跳）。

    桌面 UA + Accept-Language（§3.1 header 精简版：本腿只取 URL 链，不抓正文）。
    """
    import httpx  # 延迟导入：纯解析路径零 httpx 依赖
    r = httpx.get(url, follow_redirects=True, timeout=timeout,
                  headers={"User-Agent": _DEFAULT_UA, "Accept-Language": "zh-CN,zh;q=0.9"})
    return [str(h.url) for h in r.history] + [str(r.url)]


def resolve_doc_id(url: str, *, timeout: float = 15.0, fetch=None) -> str | None:
    """提取 docId：路径直取优先（零网络）；路径无 id（跳转壳/短链）才跟随重定向再取。

    顺序不可倒置（现场校准：wapwenku 重定向丢 docId，先网络后解析会丢）。
    fetch 注入点 = 重定向链网络腿，签名 ``fetch(url, timeout) -> list[str]``（默认
    ``_httpx_redirect_chain``；确定性测试注入用）；网络失败如实返回 None。
    """
    doc_id = extract_doc_id(url)
    if doc_id:
        return doc_id
    chain_fetch = fetch or _httpx_redirect_chain
    try:
        chain = chain_fetch(url, timeout)
    except Exception:
        return None
    for hop in chain or []:
        doc_id = extract_doc_id(hop)
        if doc_id:
            return doc_id
    return None


# ================================================================ T22：readerInfo 腿
# FR2.2/FR2.3；WENKU_SPEC §3.1/§3.2/§5.1/§6.3/§8。段3 的 L1/L2 数据采集在此实装；
# 三型重组（printToPDF）归 T26/T31/T35 在同文件续建。

NDVIEW_URL_TMPL = CANONICAL_BASE + "/ndview/{doc_id}.html"  # 侧门端点（T18 实证 200+var pageData）
WENKU_PAGE_LIMIT = 400                                       # 页数硬上限（§8-2 原文数值）
TITLE_BRAND_RE = re.compile(r"\s*-\s*百度文库|百度文库")      # 文件名去品牌后缀（W:805 原文正则）
TITLE_ILLEGAL_RE = re.compile(r"[\\/:*?\"<>|]")              # 非法字符→_（W:805 原文正则）
_PN_IN_URL_RE = re.compile(r"pn=(\d+)")                      # 类型2 URL 页号去重键（§3.2）


class WenkuPageDataError(RuntimeError):
    """view/ndview 页挖不出 var pageData（§8-1；FR2.AC3：无效 docId=403 同路报「无法提取 pageData」）。"""


def _view_headers(user_agent: str | None, cookie: str) -> dict:
    """初始页 GET 头（§3.1 buildHeaders 全套；Sec-Ch-Ua 系列对 WAF 有实质影响，§9）。

    T41 P0-1（2026-10-23）：Sec-Ch-Ua/Platform 与 UA 同源自洽（Chrome 129/Windows/
    Not_A Brand，模块级快照常量唯一源）——废除旧「UA=129 Windows ↔ Sec-CH v=120 ↔
    Platform macOS」三处互斥形态（主动自爆式指纹，研判在案 PENTAGI/wenku_assessment.md）。
    """
    headers = {
        "User-Agent": user_agent or _DEFAULT_UA,
        "Accept": ("text/html,application/xhtml+xml,application/xml;q=0.9,"
                   "image/avif,image/webp,*/*;q=0.8"),
        "Accept-Language": "zh-CN,zh;q=0.9",
        "Sec-Ch-Ua": _SEC_CH_UA,
        "Sec-Ch-Ua-Mobile": "?0",
        "Sec-Ch-Ua-Platform": _SEC_CH_UA_PLATFORM,
        "Upgrade-Insecure-Requests": "1",
    }
    if cookie:
        headers["Cookie"] = cookie
    return headers


def _httpx_fetch_html(url: str, headers: dict, timeout: float) -> tuple[int, str]:
    """初始腿缺省网络腿：httpx 直连（T18 实证 ndview 直连 200 含 var pageData；view 页 403 勿撞）。"""
    import httpx  # 延迟导入：纯解析路径零 httpx 依赖（对齐 _httpx_redirect_chain）
    r = httpx.get(url, headers=headers, timeout=timeout, follow_redirects=True)
    return r.status_code, r.text


def _coerce_positive_int(value) -> int | None:
    """JS 真值语义的数值化（W:789 ``||`` 链）：0/''/None/非数字 → None（照抄原作跳过行为）。"""
    if isinstance(value, bool):
        return None
    if isinstance(value, int):
        return value if value > 0 else None
    if isinstance(value, float) and value.is_integer():
        return int(value) if value > 0 else None
    if isinstance(value, str):
        s = value.strip()
        return int(s) if s.isdigit() and int(s) > 0 else None
    return None


def sanitize_title(title: str, fallback: str = "") -> str:
    """文件名清洗（§5.1/W:805 原序）：去「- 百度文库/百度文库」品牌后缀+trim →
    空则回落 fallback（原作=docId）→ 非法字符 ``[\\\\/:*?\"<>|]`` 全部→ ``_``。"""
    base = TITLE_BRAND_RE.sub("", title or "").strip()
    if not base:
        base = str(fallback or "").strip()
    return TITLE_ILLEGAL_RE.sub("_", base)


def reader_total_pages(reader_info: dict) -> int:
    """总页数 = page || originalPage || freePage || 0（§3.2/W:789 先命中；JS 真值跳过 0/空）。"""
    info = reader_info if isinstance(reader_info, dict) else {}
    for key in ("page", "originalPage", "freePage"):
        n = _coerce_positive_int(info.get(key))
        if n is not None:
            return n
    return 0


def reader_show_pages(reader_info: dict) -> int:
    """已可得页数 = showPage || 0（免费额度游标，§5.1）。"""
    if not isinstance(reader_info, dict):
        return 0
    return _coerce_positive_int(reader_info.get("showPage")) or 0


def _entry_page_index(entry) -> int | None:
    """类型3 条目页号（§5.1 pageIndex，1 起）；非 dict/无页号 → None。"""
    if not isinstance(entry, dict):
        return None
    return _coerce_positive_int(entry.get("pageIndex"))


def html_urls_to_pages(html_urls) -> dict:
    """htmlUrls → ``{int 页号: 载荷}`` 页索引（类型2 数组按 ``pn=``；类型3 对象按 pageIndex
    分桶并页）。不可索引项（无 pn=/pageIndex）如实不计——页库存只收可定位页，数字零造假。"""
    pages: dict = {}
    if isinstance(html_urls, list):
        for item in html_urls:
            if isinstance(item, str):
                m = _PN_IN_URL_RE.search(item)
                if m:
                    pages[int(m.group(1))] = item
    elif isinstance(html_urls, dict):
        for kind in ("json", "png", "ttf"):
            entries = html_urls.get(kind)
            if isinstance(entries, list):
                for entry in entries:
                    pi = _entry_page_index(entry)
                    if pi is not None:
                        slot = pages.setdefault(pi, {})
                        if isinstance(slot, dict):
                            slot[kind] = entry
    return pages


def merge_html_urls(reader_info: dict, html_urls, seen: set) -> dict:
    """把一批补页 ``htmlUrls`` 并入 ``readerInfo.htmlUrls``（原作 W:207-259 语义）。

    - 类型2 批（数组）：只并入既有数组型 readerInfo.htmlUrls（原作同限）；去重键=pn= 页号，
      无 pn= 项以原文为键并入数组但不占页号；
    - 类型3 批（对象）：readerInfo.htmlUrls 缺失/为数组 → 重建 ``{json,png,ttf}`` 三桶
      （原作同语义）；三键各按 pageIndex 去重追加+升序排序（原作 mergeBy）；
    - 返回本批**新页** ``{int 页号: 载荷}``（去重以 seen 页号集为准——含初始库存与既往批）。
    """
    new_pages: dict = {}
    if isinstance(html_urls, list):
        current = reader_info.get("htmlUrls")
        if not isinstance(current, list):
            return new_pages  # 原作：数组批只并入既有数组型，否则整批弃
        for item in html_urls:
            m = _PN_IN_URL_RE.search(item) if isinstance(item, str) else None
            if m is not None:
                pn = int(m.group(1))
                if pn in seen:
                    continue
                seen.add(pn)
                current.append(item)
                new_pages[pn] = item
            elif item not in current:
                current.append(item)  # 无 pn= 项：原文为键并入（不占页号）
    elif isinstance(html_urls, dict):
        current = reader_info.get("htmlUrls")
        if not isinstance(current, dict):
            reader_info["htmlUrls"] = current = {"json": [], "png": [], "ttf": []}
        for kind in ("json", "png", "ttf"):
            batch = html_urls.get(kind)
            if not isinstance(batch, list):
                continue
            base = current.get(kind)
            if not isinstance(base, list):
                base = current[kind] = []
            known = {_entry_page_index(e) for e in base}
            for entry in batch:
                pi = _entry_page_index(entry)
                if pi is None or pi in known:
                    continue  # 原作 mergeBy：pageIndex 已在即不追加
                base.append(entry)
                known.add(pi)
                if pi not in seen:
                    seen.add(pi)
                    slot = new_pages.setdefault(pi, {})
                    if isinstance(slot, dict):
                        slot[kind] = entry
            base.sort(key=lambda e: (_entry_page_index(e) is None, _entry_page_index(e) or 0))
    return new_pages


def fetch_page_data(doc_id: str, *, cookie: str = "", timeout: float = 15.0,
                    user_agent: str | None = None, fetch_html=None) -> dict:
    """初始 readerInfo 挖取（FR2.2①；§3.1）：GET **ndview 侧门**（T18 实证直连 200 含
    ``var pageData``；view 页 403 勿撞）→ ``parse/inline_var.extract_page_data``。

    产物 = ``pageData`` dict（含 ``title``/``readerInfo``）；无锚点/坏 JSON/缺 readerInfo →
    ``WenkuPageDataError``（消息含「无法提取 pageData」+「failed to extract pageData from
    HTML」双语文案，§8-1/FR2.AC3）。fetch_html 注入点 = 网络腿（确定性测试用），签名
    ``fetch(url, headers, timeout) -> (status, html)``。
    """
    if not isinstance(doc_id, str) or not DOC_ID_RE.match(doc_id):
        raise ValueError(f"非法 wenku docId 形态: {doc_id!r}"
                         f"（合法=[0-9A-Za-z_-]{{{DOC_ID_MIN_LEN},{DOC_ID_MAX_LEN}}}）")
    url = NDVIEW_URL_TMPL.format(doc_id=doc_id)
    leg = fetch_html or _httpx_fetch_html
    status, html = leg(url, _view_headers(user_agent, cookie), timeout)
    page_data = extract_page_data(html) if isinstance(html, str) else None
    if not isinstance(page_data, dict) or not isinstance(page_data.get("readerInfo"), dict):
        raise WenkuPageDataError(
            f"无法提取 pageData（failed to extract pageData from HTML，§8-1）: "
            f"ndview http={status} doc_id={doc_id} "
            f"len={len(html) if isinstance(html, str) else -1}")
    return page_data


@dataclass
class ReaderInfoLegResult:
    """readerInfo 腿终态产物（T22；重组输入件——T26/T31/T35 消费 reader_info 做三型分派）。

    计数与页数全实测（数字零造假）：show_page=补页后终态游标；coverage 形态
    ``"showPage/page"``（对齐 LadderResult.coverage 口径，FR2.AC4）。
    """

    doc_id: str
    title_raw: str                              # pageData.title 原样
    title_clean: str                            # 清洗后文件名基干（§5.1）
    page: int                                   # 总页数（page||originalPage||freePage||0）
    show_page: int                              # 终态已可得页数（游标回写后）
    page_data: dict                             # 初始 pageData 全量
    reader_info: dict                           # 合并后 readerInfo（htmlUrls/showPage 已并，W:207-261）
    fill_needed: bool                           # 免费额度不足（showPage<page，§3.2 触发条件）
    fill: PagedFetchResult | None               # 补页终态（未触发=None）
    stop_kind: str                              # not_needed/exhausted/no_progress/tri_cap/envelope_fail/aborted/page_limit
    tri_cap_seen: bool                          # 曾触发验证码信封（NeedVerify，不判死）
    html_urls_pages: dict                       # {int 页号: 载荷} 页库存（初始+补页合并）
    wall_status: str | None                     # FR2.3 判据命中=needs_vip_candidate；否则 None
    coverage: str                               # "showPage/page"
    detail: str


class WenkuDownloadAdapter(DownloadAdapter):
    """wenku 收割适配器（T18 地基+T22 readerInfo 腿）：段1/2 可用；段3=L1/L2 数据采集
    实装（三型重组归 T26/T31/T35）；段4 骨架留后继。

    - 注册名：``channel = site = "wenku"``（channel 对齐元数据层 ChannelAdapter 命名，
      供 orchestrator（T40）注册表消费；本件不写容器逻辑）。
    - search = 委派 WenkuMetaAdapter（syncmrecall 免登录，元数据层真符号复用，不重写
      端点配方）+ docId/canonical 对齐：URL 实测提取优先、响应 docID 字段兜底；
      ``source_url`` 原样保留（零造假），canonical 落 ``extra["canonical_url"]``。
    - plan/fetch_ladder（T22 采集+T26 三型分派）：meta 无 docId → NotImplementedError
      消息仍钉 T22/T26/T31/T35（T18 锁定契约，test_wenku_docid 在案）；有 docId →
      plan 出 HarvestPlan；fetch_ladder 跑完 readerInfo 腿（结果落 ``last_reader_info``）
      后按 §5.2 三型分派：类型3 → reconstruct_type3（T26 实装，产 PDF）；类型2 →
      _reconstruct_type2（T31 实装：纯图片重组+OCR 字数参照）；类型1 → 占位钉 T35。
    """

    site = "wenku"
    channel = "wenku"

    def __init__(self, meta_adapter: WenkuMetaAdapter | None = None, timeout: float = 15.0, *,
                 audit=None, signer=None, fill_min_interval: float = 1.0,
                 fill_no_progress_limit: int = NO_PROGRESS_LIMIT):
        """keyword-only 增参（T18 位置契约不动）：

        - audit：HarvestAudit 型 ledger（None=不落账）；readerinfo_init/readerinfo_fill/
          wall_status 三事件如实一行，detail 带 showPage/page（FR2.3 两字段落账）；
        - signer：常驻签名窗（PageSigner 或带 ``fetch_readerinfo`` 的鸭子型）；补页腿用，
          可被 collect_reader_info/fetch_ladder 调用级覆盖；
        - fill_min_interval/fill_no_progress_limit：补页节流与无进展熔断阈值（FR2.3=3）。
        """
        self.timeout = timeout
        self.meta = meta_adapter or WenkuMetaAdapter(timeout=timeout)
        self.audit = audit
        self.signer = signer
        self.fill_min_interval = float(fill_min_interval)
        self.fill_no_progress_limit = int(fill_no_progress_limit)
        self.last_reader_info: ReaderInfoLegResult | None = None

    def search(self, query: str, limit: int) -> list[FileMeta]:
        """段1：按查询词检 ≤limit 条 FileMeta（FR2.AC1：syncmrecall 免登录 ≥10 条实测达标）。"""
        metas = self.meta.metadata(query, limit)
        for meta in metas:
            raw = meta.extra.get("doc_id")
            doc_id = extract_doc_id(meta.source_url or "") or (
                raw if isinstance(raw, str) and DOC_ID_RE.match(raw) else None)
            if doc_id:
                meta.extra["doc_id"] = doc_id                 # URL 实测优先，响应 docID 兜底
                meta.extra["canonical_url"] = canonical_view_url(doc_id)
        return metas

    def _doc_id_of(self, meta: FileMeta) -> str | None:
        """FileMeta → docId：``extra['doc_id']``（形校验）优先，``source_url`` 解析兜底。"""
        extra = getattr(meta, "extra", None)
        raw = extra.get("doc_id") if isinstance(extra, dict) else None
        if isinstance(raw, str) and DOC_ID_RE.match(raw):
            return raw
        return extract_doc_id(meta.source_url or "")

    def plan(self, meta: FileMeta) -> HarvestPlan:
        """段2（T22 实装）：docId 对齐 → 收割计划（ladder_try=L1→L2→L3、双红线检查点开）。

        meta 无 docId（extra/source_url 均解析不出）→ NotImplementedError（T18 锁定契约，
        消息钉 T22，test_wenku_docid 在案；零网络即抛）。
        """
        doc_id = self._doc_id_of(meta)
        if not doc_id:
            raise NotImplementedError(
                "wenku 段2 plan 属 T22（readerInfo/补页）续建: meta 无 docId"
                "（FileMeta.extra['doc_id'] 或 source_url 任一须可解析，WENKU_SPEC §2）")
        return HarvestPlan(meta=meta, slot=f"wenku:{doc_id}",
                           ladder_try=tuple(LADDER_ORDER), red_check=True)

    def collect_reader_info(self, doc_id: str, *, meta: FileMeta | None = None, signer=None,
                            fetch_html=None, cookie: str = "", timeout: float | None = None,
                            min_interval: float | None = None,
                            no_progress_limit: int | None = None) -> ReaderInfoLegResult:
        """readerInfo 腿（FR2.2 全四步 + FR2.3 判据积累；段3 的 L1/L2 数据采集本体）。

        ① 初始：``fetch_page_data``（ndview 侧门纯 HTTP 免签）→ pageData/readerInfo；
        ② 补页：``page>0 且 showPage<page``（§3.2 触发条件）→ ``PagedFetcher.for_wenku``
        （rn=50、pn=showPage+1、服务端 showPage 游标推进、信封失败即停 max_retries=0）；
        每批经 ``signer.fetch_readerinfo``（PageSigner 鸭子型；真网络签名窗归 T17 件）；
        ③ 信封：``judge_wenku`` 三态（经 signer 件 judge_readerinfo 收口）——EnvelopeOK 并页
        推进；EnvelopeNeedVerify(tri_cap) 熔断退避**不判死**（R12/R13；账号池归 T29）；
        EnvelopeFail（code:0 无页数据/fetch_null）中断补页循环（§8-4）；
        ④ 无进展熔断：连续 ``no_progress_limit``（缺省 3，FR2.3）轮零推进 → paged_fetcher
        内置熔断；命中 FR2.3 判据（no_progress+showPage<page+非 tri_cap）→
        ``mark_wall_status`` 落 needs_vip_candidate + FileMeta.perm 备注 + ledger 行
        （正式标记验收归 T38）。

        page>400 → stop_kind="page_limit"（§8-2 原文文案入 detail），不进补页。
        signer 缺席且需补页 → RuntimeError（不静默跳过）；结果同步落 ``self.last_reader_info``。
        """
        if not isinstance(doc_id, str) or not DOC_ID_RE.match(doc_id):
            raise ValueError(f"非法 wenku docId 形态: {doc_id!r}"
                             f"（合法=[0-9A-Za-z_-]{{{DOC_ID_MIN_LEN},{DOC_ID_MAX_LEN}}}）")
        try:
            page_data = fetch_page_data(doc_id, cookie=cookie,
                                        timeout=self.timeout if timeout is None else timeout,
                                        fetch_html=fetch_html)
        except WenkuPageDataError as exc:
            if self.audit is not None:
                self.audit.request("wenku", "readerinfo_init", doc_id, 0, "fail", str(exc)[:300])
            raise
        title_raw = str(page_data.get("title") or "")
        reader_info = page_data["readerInfo"]
        page = reader_total_pages(reader_info)
        show_page = reader_show_pages(reader_info)
        inventory = html_urls_to_pages(reader_info.get("htmlUrls"))
        seen = set(inventory)
        title_clean = sanitize_title(title_raw, fallback=doc_id)
        detail_bits = [f"via=ndview showPage={show_page}/page={page} "
                       f"coverage={show_page}/{page} 库存页={len(inventory)}",
                       f"title_clean={title_clean[:60]}"]

        fill_needed = page > 0 and show_page < page      # §3.2 触发条件（原作 W:195-196）
        stop_kind = "not_needed"
        if page > WENKU_PAGE_LIMIT:                       # §8-2 硬上限（中止，不补页）
            stop_kind = "page_limit"
            fill_needed = False
            detail_bits.append(f"该文档共 {page} 页，超出最大支持页数 "
                               f"{WENKU_PAGE_LIMIT} 页，暂不支持下载（§8-2）")
        if self.audit is not None:
            self.audit.request("wenku", "readerinfo_init", doc_id, page,
                               "fail" if stop_kind == "page_limit" else "ok",
                               detail_bits[0] + ("" if stop_kind != "page_limit" else
                                                 f" 超出最大支持页数{WENKU_PAGE_LIMIT}"))

        fill: PagedFetchResult | None = None
        tri_cap_seen = False
        if fill_needed:
            effective_signer = signer or self.signer
            if effective_signer is None:
                raise RuntimeError(
                    "免费额度不足（showPage<page）需 ACS 补页，但未注入 signer"
                    "（PageSigner 或带 fetch_readerinfo 的签名窗，T17 件）")

            def _fill_fetch(req: dict) -> BatchResponse:
                """批请求 → BatchResponse：信封三态映射 + htmlUrls 并页（数字零造假）。"""
                nonlocal tri_cap_seen
                got = effective_signer.fetch_readerinfo(doc_id, pn=int(req["pn"]),
                                                        rn=int(req["rn"]),
                                                        referer=canonical_view_url(doc_id))
                verdict = got.verdict
                if isinstance(verdict, EnvelopeNeedVerify):   # tri_cap：熔断退避不判死（§6.3）
                    tri_cap_seen = True
                    return BatchResponse(ok=False, detail=f"tri_cap 验证码信封（熔断退避）: "
                                                         f"{verdict.detail}")
                if isinstance(verdict, EnvelopeFail):         # code:0 陷阱/fetch_null → §8-4 即断
                    return BatchResponse(ok=False,
                                         detail=f"envelope_fail({verdict.kind}): {verdict.detail}")
                new_pages = merge_html_urls(reader_info, verdict.facts.get("html_urls"), seen)
                inventory.update(new_pages)
                return BatchResponse(ok=True, pages=new_pages,
                                     cursor=_coerce_positive_int(verdict.facts.get("show_page")))

            fetcher = PagedFetcher.for_wenku(
                _fill_fetch, start_show_page=show_page, total_pages=page,
                min_interval=self.fill_min_interval if min_interval is None else min_interval,
                no_progress_limit=(self.fill_no_progress_limit if no_progress_limit is None
                                   else no_progress_limit))
            fill = fetcher.run()
            show_page = max(show_page, fill.cursor)
            reader_info["showPage"] = show_page            # 游标回写 readerInfo（W:261 同型）
            detail_bits.append(f"fill: requests={fill.requests} batches_ok={fill.batches_ok} "
                               f"rounds={fill.no_progress_rounds} stop={fill.stopped_reason}")
            if fill.stopped_reason == STOP_EXHAUSTED:
                stop_kind = "exhausted"
            elif fill.stopped_reason == STOP_NO_PROGRESS:
                stop_kind = "no_progress"
            elif fill.stopped_reason == STOP_ABORTED:
                stop_kind = "aborted"
            else:  # fetch_failed（max_retries=0 即断；tri_cap 优先归因）
                stop_kind = "tri_cap" if tri_cap_seen else "envelope_fail"
            if self.audit is not None:
                status = ("ok" if stop_kind == "exhausted"
                          else "need_verify" if stop_kind == "tri_cap" else "fail")
                self.audit.request(
                    "wenku", "readerinfo_fill", doc_id, fill.requests, status,
                    f"stop={stop_kind} showPage={show_page}/page={page} "
                    f"coverage={show_page}/{page} "
                    f"tri_cap={'yes' if tri_cap_seen else 'no'} {fill.detail[:200]}")

        coverage = f"{show_page}/{page}"
        wall_status = None
        if stop_kind == "no_progress" and show_page < page and not tri_cap_seen:
            # FR2.3 判据齐备：连续3轮零进展+showPage<page+非tri_cap → 推断标记（正式验收归 T38）
            wall_status = WALL_NEEDS_VIP_CANDIDATE
            if meta is not None:
                mark_wall_status(meta, wall_status)
                note = "needs_vip_candidate(推断:连续补页零进展)"
                meta.perm = f"{meta.perm}|{note}" if meta.perm else note
            if self.audit is not None:
                self.audit.request(
                    "wenku", "wall_status", doc_id, 0, wall_status,
                    f"FR2.3 推断判据: 连续{(fill.no_progress_rounds if fill else 0)}轮零进展"
                    f"+showPage={show_page}<page={page}+非tri_cap; coverage={coverage}")
            detail_bits.append(f"wall={wall_status}")
        if tri_cap_seen:
            detail_bits.append("tri_cap_seen=yes（不判死；账号登录态归 T29）")

        result = ReaderInfoLegResult(
            doc_id=doc_id, title_raw=title_raw, title_clean=title_clean, page=page,
            show_page=show_page, page_data=page_data, reader_info=reader_info,
            fill_needed=fill_needed, fill=fill, stop_kind=stop_kind, tri_cap_seen=tri_cap_seen,
            html_urls_pages=inventory, wall_status=wall_status, coverage=coverage,
            detail="; ".join(detail_bits))
        self.last_reader_info = result
        return result

    def fetch_ladder(self, plan: HarvestPlan, *, signer=None, fetch_html=None,
                     asset_fetch=None, out_dir=None,
                     asset_min_interval: float | None = None,
                     ocr_fn=None, editor_html=None, editor_clicked=None, cookie: str = "",
                     now_ms: int | None = None) -> LadderResult:
        """段3（T26 接线三型分派；类型3=T26 实装；类型2=T31 实装；类型1=T35 实装）。

        meta 无 docId → NotImplementedError（T18 锁定契约，零网络即抛，消息钉
        T26/T31/T35）；有 docId → ``collect_reader_info``（T22 腿：ndview 初始+ACS 补页
        +信封+熔断，结果落 ``self.last_reader_info``）→ ``dispatch_reconstruction``
        （§5.2 三型分派+ledger recon_dispatch；类型1 editor/XML 重组=T35 实装——占位钉
        已全部兑现，「T26/T31/T35」组字样仅存 verify 半，T18/T22 锁定契约测试
        （test_wenku_docid/test_wenku_readerinfo 在案）不破）。

        keyword-only 注入（只增不改）：asset_fetch=资产网络腿注入点（类型3 三腿/类型2
        图片腿/类型1 getbdjson 桶腿）、out_dir=PDF 落盘目录、asset_min_interval=资产腿
        间节流、ocr_fn=类型2 OCR 参照子系统边界注入点（T23/book118 同缝）、
        editor_html/editor_clicked=类型1 editor 腿预提取产物（``extract_editor_html``
        两段式调用面；缺省=径走 XML 降级腿）、cookie=类型1 数据腿 Cookie、now_ms=
        getbdjson ``_={Date.now()}`` 确定性注入。
        """
        doc_id = self._doc_id_of(plan.meta)
        if not doc_id:
            raise NotImplementedError("wenku 段3 fetch_ladder 属 T26/T31/T35（三型重组）在同文件续建")
        bundle = self.collect_reader_info(doc_id, meta=plan.meta, signer=signer or self.signer,
                                          fetch_html=fetch_html)
        return self.dispatch_reconstruction(bundle, asset_fetch=asset_fetch, out_dir=out_dir,
                                            min_interval=asset_min_interval, ocr_fn=ocr_fn,
                                            editor_html=editor_html,
                                            editor_clicked=editor_clicked, cookie=cookie,
                                            now_ms=now_ms)

    def dispatch_reconstruction(self, bundle: ReaderInfoLegResult, *, asset_fetch=None,
                                out_dir=None, min_interval: float | None = None,
                                ocr_fn=None, editor_html=None, editor_clicked=None,
                                cookie: str = "", now_ms: int | None = None,
                                xml_sleep=None) -> LadderResult:
        """三型分派（§5.2 唯一权威序）+ ledger ``recon_dispatch``（tplKey+三分支命中，
        FR2.AC2 判型落账）：type3 → reconstruct_type3（T26 实装）；type2 →
        _reconstruct_type2（T31 实装：纯图片+OCR 字数参照）；type1 → _reconstruct_type1
        （T35 实装：editor 滚动展开+XML 降级+注记#5）；皆不中 → WenkuUnknownTypeError
        （§8-9）。

        独立公开=两段式调用面（先 ``collect_reader_info`` 后分派——外层签名窗/浏览器
        须先收口再打印的场景，Playwright sync 不可嵌套）；fetch_ladder 即采集后径调本件。
        类型1 的 editor 腿=调用方先以 ``extract_editor_html``（真浏览器生命周期归调用方）
        提取后经 editor_html/editor_clicked 注入；未注入=径走 XML 降级腿（§7.4 步5）。
        """
        doc_type = judge_doc_type(bundle.reader_info)
        tpl_key = bundle.reader_info.get("tplKey")
        if self.audit is not None:
            self.audit.request(
                "wenku", "recon_dispatch", bundle.doc_id, bundle.page, doc_type,
                f"tplKey={tpl_key} branch={doc_type} "
                f"showPage/page={bundle.show_page}/{bundle.page} coverage={bundle.coverage} "
                f"stop_kind={bundle.stop_kind}")
        if doc_type == DOC_TYPE_3:
            return self.reconstruct_type3(bundle, asset_fetch=asset_fetch, out_dir=out_dir,
                                          min_interval=min_interval)
        if doc_type == DOC_TYPE_2:
            return self._reconstruct_type2(bundle, asset_fetch=asset_fetch, out_dir=out_dir,
                                           min_interval=min_interval, ocr_fn=ocr_fn)
        if doc_type == DOC_TYPE_1:
            return self._reconstruct_type1(bundle, editor_html=editor_html,
                                           editor_clicked=editor_clicked, out_dir=out_dir,
                                           asset_fetch=asset_fetch, cookie=cookie,
                                           min_interval=min_interval, now_ms=now_ms,
                                           xml_sleep=xml_sleep)
        raise WenkuUnknownTypeError(
            f"未知文档类型: tplKey={tpl_key!r}, "
            f"rangeLen={len(bundle.reader_info.get('rtcsRangeInfo') or [])}（§8-9）")

    def reconstruct_type3(self, bundle: ReaderInfoLegResult, *, asset_fetch=None, out_dir=None,
                          min_interval: float | None = None, cookie: str = "") -> LadderResult:
        """类型3 重组全链（T26；FR2.2/FR2.AC2）：

        ``fetch_type3_assets``（ttf/json/png 三腿：占位图<2KB 丢弃+@font-face 注入
        ascent-override:80%/descent-override:20%）→ ``render_html_view``（§7.2 页容器/
        文字层 span/图片层背景裁剪）→ ``html_to_pdf``（printToPDF：print_background+
        prefer_css_page_size+margin 0，页几何权威=@page）→ pypdfium2 实测核验
        （页数==重组页数、逐页尺寸==pageInfo px→pt，容差 PAGE_SIZE_TOL_PT）。
        chars=pageJson word 节点码点实测（数字零造假）；wall_status/coverage 从
        readerInfo 腿透传（部分收割如实）。临时 HTML 用毕即删（原作 W:683 同型）。
        """
        out = Path(out_dir) if out_dir is not None else Path.cwd() / "kb_harvest_out" / "wenku"
        out.mkdir(parents=True, exist_ok=True)
        assets = fetch_type3_assets(
            bundle.reader_info, asset_fetch=asset_fetch, cookie=cookie, timeout=self.timeout,
            min_interval=self.fill_min_interval if min_interval is None else min_interval)
        tpl_key = bundle.reader_info.get("tplKey")
        if not assets.pages:
            detail = (f"type3 零可用页: json_ok=0 json_skip={assets.stats['json_skip']} "
                      f"ttf={assets.stats['ttf_ok']}ok/{assets.stats['ttf_skip']}skip "
                      f"tplKey={tpl_key} coverage={bundle.coverage}")
            if self.audit is not None:
                self.audit.request("wenku", "recon_type3", bundle.doc_id, 0, "fail", detail)
            return LadderResult(ok=False, ladder_used="L1", pages=0,
                                wall_status=bundle.wall_status, coverage=bundle.coverage,
                                detail=detail)
        html = render_html_view(bundle.title_raw, bundle.reader_info, assets.pages,
                                assets.font_css)
        html_path = out / f"_render_type3_{bundle.doc_id}.html"
        pdf_path = out / f"{bundle.title_clean or bundle.doc_id}.pdf"
        html_path.write_text(html, encoding="utf-8")
        try:
            html_to_pdf(html_path, pdf_path)
        finally:
            html_path.unlink(missing_ok=True)  # 临时件即删（原作 W:683 同型）
        import pypdfium2 as pdfium  # 延迟导入（对齐 book118 件；NFR6 禁 fitz）
        doc = pdfium.PdfDocument(str(pdf_path))
        try:
            sizes = [(pg.get_width(), pg.get_height()) for pg in doc]
        finally:
            doc.close()
        chars = sum(len(node.get("c") or "")
                    for page in assets.pages
                    for node in (page.page_json.get("body") or [])
                    if isinstance(node, dict) and node.get("t") == "word"
                    and isinstance(node.get("c"), str))
        page_w, page_h = page_info_dims(bundle.reader_info)
        exp_w_pt, exp_h_pt = page_w / PX_PER_PT_CSS, page_h / PX_PER_PT_CSS
        geo_ok = (len(sizes) == len(assets.pages)
                  and all(abs(w - exp_w_pt) <= PAGE_SIZE_TOL_PT
                          and abs(h - exp_h_pt) <= PAGE_SIZE_TOL_PT for w, h in sizes))
        ok = geo_ok and pdf_path.is_file()
        detail = (f"type3 recon: tplKey={tpl_key} showPage/page={bundle.show_page}/{bundle.page}"
                  f" pages={len(sizes)}/{len(assets.pages)} chars={chars} geo_ok={geo_ok} "
                  f"@page={page_w:g}x{page_h:g}px->{exp_w_pt:.2f}x{exp_h_pt:.2f}pt "
                  f"measured={sizes[0][0]:.2f}x{sizes[0][1]:.2f}pt "
                  f"stats={assets.stats} pdf={pdf_path.name}")
        if self.audit is not None:
            self.audit.request("wenku", "recon_type3", bundle.doc_id, len(assets.pages),
                               "ok" if ok else "fail", detail[:400])
        return LadderResult(ok=ok, ladder_used="L1", artifact_path=str(pdf_path),
                            pages=len(sizes), chars=chars, wall_status=bundle.wall_status,
                            coverage=bundle.coverage, detail=detail)

    def _reconstruct_type2(self, bundle: ReaderInfoLegResult, *, asset_fetch=None, out_dir=None,
                           min_interval: float | None = None, cookie: str = "",
                           ocr_fn=None) -> LadderResult:
        """类型2（纯图片）重组全链（T31 实装；FR2.2/FR2.AC2；§5.2 分支2+§7.3+注记#5）：

        ``fetch_type2_images``（htmlUrls 数组逐页下载，judge_page_png 四步链占位图丢弃）
        → ``render_image_html``（§7.3 逐字 CSS：.page 宽高=pageInfo（类型2 缺省
        2400×1500）、img object-fit:contain）→ ``html_to_pdf``（printToPDF 页几何权威=
        @page）→ 注记#5 字数参照（SPEC_REVIEW 残留#5 落地）：``ocr_fn``（缺省
        render/ocr 二级管线）先 render/ocr 实测产 searchable PDF（带 OCR 文字层）+
        ref_chars，再过质检门——manifest ref_chars_source="type2"（quality_gate 五型
        词表之 type2=「wenku 类型2=OCR 全文」，**不走 pageJson**）；四门真跑（全量=
        expected_pages / 丢页缺页=preview_limit 部分收割合法形态）。chars=OCR 文字层
        字数；wall_status/coverage 从 readerInfo 腿透传；临时 HTML 用毕即删（W:683
        同型）。「T26/T31/T35」占位组字样保留给类型1/verify 的 T35 半（T35 续建）。
        """
        out = Path(out_dir) if out_dir is not None else Path.cwd() / "kb_harvest_out" / "wenku"
        out.mkdir(parents=True, exist_ok=True)
        assets = fetch_type2_images(
            bundle.reader_info, asset_fetch=asset_fetch, cookie=cookie, timeout=self.timeout,
            min_interval=self.fill_min_interval if min_interval is None else min_interval)
        tpl_key = bundle.reader_info.get("tplKey")
        if not assets.pages:
            detail = (f"type2 零可用页: img_kept=0 img_drop={assets.stats['img_drop']} "
                      f"tplKey={tpl_key} coverage={bundle.coverage}")
            if self.audit is not None:
                self.audit.request("wenku", "recon_type2", bundle.doc_id, 0, "fail", detail)
            return LadderResult(ok=False, ladder_used="L1", pages=0,
                                wall_status=bundle.wall_status, coverage=bundle.coverage,
                                detail=detail)
        stem = bundle.title_clean or bundle.doc_id
        image_pdf = out / f"{stem}.pdf"           # 纯图打印件（@page 几何权威，门③抽帧源）
        html = render_image_html(bundle.title_raw, bundle.reader_info, assets.pages)
        html_path = out / f"_render_type2_{bundle.doc_id}.html"
        html_path.write_text(html, encoding="utf-8")
        try:
            html_to_pdf(html_path, image_pdf)
        finally:
            html_path.unlink(missing_ok=True)     # 临时件即删（原作 W:683 同型）
        import pypdfium2 as pdfium  # 延迟导入（对齐类型3；NFR6 禁 fitz）
        image_sizes = _pdf_page_sizes(pdfium, image_pdf)
        page_w, page_h = type2_page_dims(bundle.reader_info)
        exp_w_pt, exp_h_pt = page_w / PX_PER_PT_CSS, page_h / PX_PER_PT_CSS
        geo_ok = (len(image_sizes) == len(assets.pages)
                  and all(abs(w - exp_w_pt) <= PAGE_SIZE_TOL_PT
                          and abs(h - exp_h_pt) <= PAGE_SIZE_TOL_PT for w, h in image_sizes))
        # —— 注记#5：产物过质检门前先 render/ocr 实测产 ref_chars（不走 pageJson）——
        searchable_pdf = out / f"{stem}_ocr.pdf"  # 带 OCR 文字层交付件（门②吃文字层）
        ref_fn = ocr_fn or _ocr_ref
        ref_chars = int(ref_fn(image_pdf, searchable_pdf))
        manifest = {"pdf_path": str(searchable_pdf), "ref_chars": ref_chars,
                    "ref_chars_source": TYPE2_REF_CHARS_SOURCE}
        if len(assets.pages) == bundle.page > 0:
            manifest["expected_pages"] = bundle.page
        else:
            manifest["preview_limit"] = len(assets.pages)  # 丢页/部分库存=部分收割合法形态
        manifest_path = out / f"{stem}_manifest.json"
        gate, gate_pass = [], None
        art_sizes: list = []
        if ref_chars >= 1:
            manifest_path.write_text(json.dumps(manifest, ensure_ascii=False, indent=1),
                                     encoding="utf-8")
            checked = _quality_gate.load_manifest(manifest_path)  # schema 校验（词表/正整数）
            gate = _quality_gate.run_gate(checked)
            gate_pass = all(g.passed for g in gate)
            art_sizes = _pdf_page_sizes(pdfium, searchable_pdf)
        ok = bool(geo_ok and searchable_pdf.is_file() and ref_chars >= 1
                  and len(art_sizes) == len(assets.pages) and gate_pass)
        gate_bits = "/".join(f"{g.name}:{'P' if g.passed else 'F'}" for g in gate) or "n/a"
        shown = (art_sizes or image_sizes)[0]
        detail = (f"type2 recon: tplKey={tpl_key} showPage/page={bundle.show_page}/{bundle.page} "
                  f"pages={len(art_sizes)}/{len(assets.pages)} chars={ref_chars}(ocr) "
                  f"manifest={manifest_path.name} geo_ok={geo_ok} "
                  f"@page={page_w:g}x{page_h:g}px->{exp_w_pt:.2f}x{exp_h_pt:.2f}pt "
                  f"measured={shown[0]:.2f}x{shown[1]:.2f}pt "
                  f"stats={assets.stats} gate={gate_bits} "
                  f"ref_chars_source={TYPE2_REF_CHARS_SOURCE}(ocr) pdf={searchable_pdf.name}")
        if self.audit is not None:
            self.audit.request("wenku", "recon_type2", bundle.doc_id, len(assets.pages),
                               "ok" if ok else "fail", detail[:400])
            if gate:
                self.audit.request(
                    "wenku", "quality_gate", bundle.doc_id,
                    sum(1 for g in gate if g.passed), "ok" if gate_pass else "fail",
                    f"gate={gate_bits} ref_chars={ref_chars}(ocr) "
                    f"ref_chars_source={TYPE2_REF_CHARS_SOURCE} pdf={searchable_pdf.name}")
        return LadderResult(ok=ok, ladder_used="L1", artifact_path=str(searchable_pdf),
                            pages=len(art_sizes), chars=ref_chars,
                            wall_status=bundle.wall_status, coverage=bundle.coverage,
                            detail=detail)

    def extract_editor_html(self, doc_id: str, *, signer=None, page=None,
                            warmup_url: str | None = None, referer: str | None = None,
                            sleep=None, nav_timeout_ms: int | None = None,
                            warmup_settle_ms: int = 1000,
                            log=None) -> "EditorExtractResult":
        """类型1 editor 腿（T35；FR2.AC2①；§7.4 步1-3+§9「必须真浏览器」清单#2）：

        隐藏页载 ``view/{docId}.html`` → ``run_editor_sequence``（§7.4 全套时序：5s→
        15 轮 scrollBy(0,2000)/500ms→三文案展开点击→5s→25 轮滚动→3s→抽 ``.ql-editor``
        innerHTML）。两种页来源（二选一）：

        - ``page``：调用方注入页（浏览器生命周期归调用方——Playwright sync 不可嵌套，
          打印腿须等本腿收口后再开；离线 route fixture 同缝）；
        - ``signer``（缺省=``self.signer``）：**签名窗 session 复用**——在
          ``signer.context`` 开新页（原作 ``BrowserWindow(session: signer.ses)`` 同型，
          含其流量闸门三组正则：静态资源拦截不碍 .ql-editor DOM 文本），用毕即关页
          （不动签名窗本体）；signer 已收口=硬报。

        过百度安全验证口径（T28 经验，2026-10-22 实测裸 goto 撞「百度安全验证」行为墙）：
        ``warmup_url`` 先访落 cookie（goto domcontentloaded+固定 settle）再跳 view 页，
        view 页 goto 带 ``referer``（缺省=wenku 首页）。sleep 注入点=§7.4 节拍确定性
        （live 真节拍勿注入）；log 注入点=过程记录。ql 抽不到（type3 误判/WAF 页）→
        ``ql_html=''`` 如实返回（调用方据此走 XML 降级，§7.4 步5）。
        """
        if not isinstance(doc_id, str) or not DOC_ID_RE.match(doc_id):
            raise ValueError(f"非法 wenku docId 形态: {doc_id!r}"
                             f"（合法=[0-9A-Za-z_-]{{{DOC_ID_MIN_LEN},{DOC_ID_MAX_LEN}}}）")
        own_page = False
        if page is None:
            effective_signer = signer or self.signer
            if effective_signer is None:
                raise RuntimeError(
                    "类型1 editor 腿需真浏览器页：注入 page（调用方管理生命周期）或 signer"
                    "（签名窗 session 复用=signer.context 开页）；两者皆缺"
                    "（WENKU_SPEC §9「必须真浏览器」清单#2）")
            if getattr(effective_signer, "closed", False):
                raise RuntimeError("signer 已收口：editor 腿须在签名窗存活期开页"
                                   "（session 复用 signer.ses；或注入 caller 页）")
            context = getattr(effective_signer, "context", None)
            if context is None:
                raise RuntimeError("signer 缺 context（PageSigner 鸭子型契约漂移）")
            page = context.new_page()
            own_page = True
            source = "signer_session"
        else:
            source = "caller_page"
        effective_referer = referer or WENKU_ASSET_REFERER
        if nav_timeout_ms is None:
            nav_timeout_ms = 30000  # 对齐 browser.kit.NAV_TIMEOUT_MS（避免模块级 playwright 依赖）
        try:
            if warmup_url:
                page.goto(warmup_url, timeout=nav_timeout_ms, wait_until="domcontentloaded")
                page.wait_for_timeout(warmup_settle_ms)
            page.goto(canonical_view_url(doc_id), timeout=nav_timeout_ms,
                      wait_until="domcontentloaded", referer=effective_referer)
            ql_html, clicked = run_editor_sequence(page, sleep=sleep, log=log)
        finally:
            if own_page:
                try:
                    page.close()
                except Exception:
                    pass  # 页随上下文已亡等幂等场景（对齐 PageSigner.close 同型容错）
        detail = (f"source={source} warmup={'yes' if warmup_url else 'no'} "
                  f"referer={effective_referer} clicked={clicked or '-'} ql_len={len(ql_html)}")
        return EditorExtractResult(ql_html=ql_html, clicked_text=clicked, source=source,
                                   warmup_used=bool(warmup_url), referer=effective_referer,
                                   detail=detail)

    def _reconstruct_type1(self, bundle: ReaderInfoLegResult, *, editor_html=None,
                           editor_clicked=None, out_dir=None, asset_fetch=None,
                           cookie: str = "", min_interval: float | None = None,
                           now_ms: int | None = None, xml_sleep=None) -> LadderResult:
        """类型1（editor 滚动展开+XML 降级）重组全链（T35 实装；FR2.2/FR2.AC2；§5.2
        分支3+§7.4/§7.5+注记#5）：

        - editor 主径（editor_html 非空=``extract_editor_html`` 预提取产物）：
          ``render_editor_html``（calls 偏移 510 A4 流式模板逐字，ql innerHTML 原样内联）
          → ``html_to_pdf``（extra_css=@page A4 补齐——Electron printToPDF 缺省页尺寸
          =A4、Playwright pdf 缺省=Letter，模板串保持逐字仅补页几何）→ pypdfium2 实测
          页数/逐页 A4 尺寸；流式页数=涌现值（无源声明页可比对）→ manifest
          preview_limit=实测页数如实记；
        - XML 降级径（editor 缺席+rtcsRangeInfo 在场，§7.4 步5 同型）：``fetch_xml_blocks``
          （§6.4 桶式拉取 3 项/桶+md5sum 无键名直拼怪癖）→ 零桶如实 ok=False（不产空件）
          → ``render_xml_html``（§7.5 逐字+A4 流式+BOS docconvert896 图 src）→ 同打印
          链；全桶==page → manifest expected_pages，缺桶=preview_limit（部分收割合法）；
        - 注记#5（SPEC_REVIEW 残留#5）：字数参照=DOM 文本字数（editor 径=editor DOM、
          XML 径=document.xml 页对象树——同一编辑器文档的服务端 DOM），manifest
          ref_chars_source="type1"（quality_gate 五型词表之 type1=editor DOM 文本，
          不走 pageJson/OCR）；质检门四门真跑；
        - §8-8：editor 空 且 rtcsRangeInfo 空 → ``WenkuEditorEmptyError``（原文文案中止）；
          wall_status/coverage 从采集腿透传；临时 HTML 用毕即删（W:683 同型）。
        """
        out = Path(out_dir) if out_dir is not None else Path.cwd() / "kb_harvest_out" / "wenku"
        out.mkdir(parents=True, exist_ok=True)
        doc_id = bundle.doc_id
        tpl_key = bundle.reader_info.get("tplKey")
        rtcs = bundle.reader_info.get("rtcsRangeInfo") or []
        stem = bundle.title_clean or doc_id
        if editor_html:
            branch = "editor"
            ref_chars = editor_dom_text_chars(editor_html)          # 注记#5：editor DOM 文本
            html = render_editor_html(bundle.title_raw, editor_html)
            n_src_pages = None                                       # 流式页数=涌现值
        elif isinstance(rtcs, list) and len(rtcs) > 0:
            branch = "xml_degrade"
            assets = fetch_xml_blocks(
                bundle.reader_info, asset_fetch=asset_fetch, cookie=cookie, timeout=self.timeout,
                now_ms=now_ms,
                min_interval=self.fill_min_interval if min_interval is None else min_interval,
                sleep=xml_sleep)
            if not assets.blocks:
                detail = (f"type1 零可用桶: branch=xml_degrade "
                          f"requests={assets.stats['requests']} "
                          f"buckets_ok={assets.stats['buckets_ok']} "
                          f"empty={assets.stats['buckets_empty']} tplKey={tpl_key} "
                          f"rtcs={len(rtcs)} coverage={bundle.coverage}")
                if self.audit is not None:
                    self.audit.request("wenku", "recon_type1", doc_id, 0, "fail", detail[:400])
                return LadderResult(ok=False, ladder_used="L1", pages=0,
                                    wall_status=bundle.wall_status, coverage=bundle.coverage,
                                    detail=detail)
            ref_chars = xml_dom_text_chars(assets.blocks)            # 注记#5：同词（服务端 DOM）
            html = render_xml_html(bundle.title_raw, assets.blocks, doc_id)
            n_src_pages = len(assets.blocks)
        else:
            raise WenkuEditorEmptyError(                             # §8-8 原文文案
                "未找到 .ql-editor 内容且无 rtcsRangeInfo 可降级（§8-8；"
                f"tplKey={tpl_key!r}）")
        html_path = out / f"_render_type1_{doc_id}.html"
        pdf_path = out / f"{stem}.pdf"
        html_path.write_text(html, encoding="utf-8")
        try:
            html_to_pdf(html_path, pdf_path, extra_css=A4_PAGE_CSS)
        finally:
            html_path.unlink(missing_ok=True)                         # 临时件即删（W:683 同型）
        import pypdfium2 as pdfium  # 延迟导入（对齐类型3/类型2；NFR6 禁 fitz）
        sizes = _pdf_page_sizes(pdfium, pdf_path)
        manifest = {"pdf_path": str(pdf_path), "ref_chars": ref_chars,
                    "ref_chars_source": TYPE1_REF_CHARS_SOURCE}
        if branch == "xml_degrade" and n_src_pages == bundle.page > 0:
            manifest["expected_pages"] = bundle.page
        else:
            manifest["preview_limit"] = n_src_pages if branch == "xml_degrade" else len(sizes)
        manifest_path = out / f"{stem}_manifest.json"
        gate, gate_pass = [], None
        if ref_chars >= 1 and sizes:  # 零页/零字=manifest 参照不合格（preview_limit 须≥1），如实不落门
            manifest_path.write_text(json.dumps(manifest, ensure_ascii=False, indent=1),
                                     encoding="utf-8")
            checked = _quality_gate.load_manifest(manifest_path)      # schema 校验（词表/正整数）
            gate = _quality_gate.run_gate(checked)
            gate_pass = all(g.passed for g in gate)
        ok = bool(pdf_path.is_file() and sizes and ref_chars >= 1 and gate_pass)
        gate_bits = "/".join(f"{g.name}:{'P' if g.passed else 'F'}" for g in gate) or "n/a"
        ref_tag = "editor-dom" if branch == "editor" else "xml-dom"
        detail = (f"type1 recon: branch={branch} tplKey={tpl_key} "
                  f"showPage/page={bundle.show_page}/{bundle.page} pages={len(sizes)} "
                  f"chars={ref_chars}({ref_tag}) rtcs={len(rtcs)} "
                  f"clicked={editor_clicked or '-'} geo=A4@595.28x841.89pt "
                  f"measured={sizes[0][0]:.2f}x{sizes[0][1]:.2f}pt gate={gate_bits} "
                  f"ref_chars_source={TYPE1_REF_CHARS_SOURCE} pdf={pdf_path.name}")
        if self.audit is not None:
            self.audit.request("wenku", "recon_type1", doc_id, len(sizes),
                               "ok" if ok else "fail", detail[:400])
            if gate:
                self.audit.request(
                    "wenku", "quality_gate", doc_id,
                    sum(1 for g in gate if g.passed), "ok" if gate_pass else "fail",
                    f"gate={gate_bits} ref_chars={ref_chars}({ref_tag}) "
                    f"ref_chars_source={TYPE1_REF_CHARS_SOURCE} pdf={pdf_path.name}")
        return LadderResult(ok=ok, ladder_used="L1", artifact_path=str(pdf_path),
                            pages=len(sizes), chars=ref_chars, wall_status=bundle.wall_status,
                            coverage=bundle.coverage, detail=detail)

    def verify(self, result: LadderResult) -> bool:
        """段4 骨架：质检核验属 T26/T31/T35+quality_gate 对接，在同文件续建。"""
        raise NotImplementedError("wenku 段4 verify 属 T26/T31/T35+质检门对接续建")


# ================================================================ T26：类型3 重组（JSON+PNG+TTF → printToPDF）
# FR2.2/FR2.AC2；WENKU_SPEC §5.1/§5.2/§5.4/§6.5/§6.6/§7.1/§7.2。三条资产腿均为预签名
# 直链（纯 httpx 带 Cookie+UA+Referer，无 Acs-Token，§9「可纯 httpx」清单）+ 本地
# Chromium 无头打印（pdf/html_print_pdf 真符号：html_to_pdf）。类型2（T31）/类型1
# （T35）重组在本文件续建——fetch_ladder 三型分派已接线（见上）。

import base64
import time
from pathlib import Path

try:  # T26 增量件（双导入法对齐文件头；真符号复用不重写）
    from kb_factory.harvest_engine.assets.magic_check import judge_page_png
    from kb_factory.harvest_engine.parse.jsonp import JsonpError, strip_jsonp
    from kb_factory.harvest_engine.pdf.html_print_pdf import (PX_PER_PT_CSS,
                                                              build_font_face_css,
                                                              html_to_pdf)
except ImportError:
    from harvest_engine.assets.magic_check import judge_page_png
    from harvest_engine.parse.jsonp import JsonpError, strip_jsonp
    from harvest_engine.pdf.html_print_pdf import (PX_PER_PT_CSS, build_font_face_css,
                                                   html_to_pdf)

#: 三型判定词（§5.2 三分支+兜底；ledger recon_dispatch.status 即此词）
DOC_TYPE_3 = "type3"          # 1. JSON+PNG+TTF（htmlUrls 对象且 json.length>0）
DOC_TYPE_2 = "type2"          # 2. 纯图片（htmlUrls 数组且 length>0）
DOC_TYPE_1 = "type1"          # 3. editor（rtcsRangeInfo.length>0）
DOC_TYPE_UNKNOWN = "unknown"  # 4. 三者皆不中（§8-9）

WKRETYPE_URL_TMPL = ("https://wkretype.bdimg.com/retype/pipe/{store_id}"
                     "?pn={pn}&t=ttf&rn=1&v=6{param}")  # §6.5；param 自带前导 &（实弹实锤）
WENKU_ASSET_REFERER = "https://wenku.baidu.com/"        # §6.2/§6.5/§6.6 三腿同 Referer
#: 资产腿安全缺省节流（T41 P0-3，2026-10-23）：fetch_type3_assets/fetch_type2_images/
#: fetch_xml_blocks 三函数 min_interval 缺省 0.5s。历史缺省 0.0=节流默认关闭——T38 未失控
#: 纯因调用方恰好显式注入 0.5（wenku_accept.py 五处）属「运气式安全」；安全默认应开非关
#: （任何新调用路径忘注入时仍有 0.5s/腿兜底；显式传 0 仍可关闭=确定性测试/离线注入不受影响）。
WENKU_ASSET_MIN_INTERVAL = 0.5
TYPE3_DEFAULT_PAGE_W = 892.0    # §5.1 pageInfo.pageWidth 缺省（W:821 原作 0x37c）
TYPE3_DEFAULT_PAGE_H = 1262.0   # §5.1 pageInfo.pageHeight 缺省（W:821 原作 0x4ee）
PAGE_SIZE_TOL_PT = 0.6          # 页几何核验容差（pt；@page 小数 px 的浮点尾差）

#: ---------------------------------------------------------------------------
#: T41 P0-2/P0-4 网络栈暴露面文档化处置（2026-10-23，研判=PENTAGI/wenku_assessment.md）：
#:
#: - **P0-2（TLS/JA3+HTTP/2 指纹裸露）**：ndview/三资产腿/图片腿/XML 桶腿全走纯 httpx
#:   （OpenSSL 缺省 ClientHello+h2 SETTINGS），与「Chrome/129」UA 声明跨层矛盾；view 页
#:   对纯 httpx 403 已实证指纹墙在位，四侧门端点当前 200 是未收紧空窗期非安全态。本波
#:   处置=①安全缺省节流（WENKU_ASSET_MIN_INTERVAL=0.5，P0-3 同款）压突刺面；②中期修法
#:   记档=网络栈迁 curl_cffi impersonate="chrome129"（JA3/JA4+h2 SETTINGS+头序同步伪造，
#:   版本与 _UA_VERSION 锁同值）——换栈属 e2e 全链回归面，由编排层按波次统一收编，不在
#:   本波单侧实施。
#: - **P0-4（同会话多 TLS 栈并存，架构级）**：补页腿=PageSigner 真浏览器 in-page fetch
#:   （真 Chrome TLS）与资产腿 httpx（Python TLS）同 IP 同会话交替——站方一旦上线 IP 级
#:   TLS 指纹时序关联即最高置信爬虫信号。现役缓解位：rn=50 批单发/轮+fill_min_interval
#:   =1.0s 批间+3 轮零进展熔断（补页流量实弹仅 3 发/件）+资产腿 0.5s 缺省节流+NetCache
#:   预算硬顶。中期修法=轻量资产腿并入 signer in-page fetch 通道（同栈）或 curl_cffi
#:   对齐 signer 浏览器指纹→整会话单一浏览器栈（编排层架构项，记档待排）。
#: ---------------------------------------------------------------------------

_AT_FONT_FACE_RE = re.compile(r"@font-face\s*\{")            # §6.5/W:497 替换锚
_FONT_OVERRIDE_PAIR_RE = re.compile(r"ascent-override:([^;}]+);descent-override:([^;}]+);")


class WenkuUnknownTypeError(RuntimeError):
    """三型全不匹配（§8-9：未知文档类型: tplKey=..., rangeLen=...）。"""


def _num(value, default: float = 0.0) -> float:
    """parseFloat 语义数值化（§5.1 pageInfo 实弹为字符串 "892.979"）：空/非数字→default。"""
    if isinstance(value, bool):
        return default
    if isinstance(value, (int, float)):
        return float(value)
    if isinstance(value, str):
        try:
            return float(value.strip())
        except ValueError:
            return default
    return default


def judge_doc_type(reader_info: dict) -> str:
    """三型分支判定（§5.2 原序，唯一权威序）：

    1. htmlUrls 对象且 json.length>0 → type3；2. htmlUrls 数组且 length>0 → type2；
    3. rtcsRangeInfo.length>0 → type1；4. 皆不中 → unknown（§8-9）。
    """
    info = reader_info if isinstance(reader_info, dict) else {}
    html_urls = info.get("htmlUrls")
    if isinstance(html_urls, dict) and len(html_urls.get("json") or []) > 0:
        return DOC_TYPE_3
    if isinstance(html_urls, list) and len(html_urls) > 0:
        return DOC_TYPE_2
    rtcs = info.get("rtcsRangeInfo")
    if isinstance(rtcs, list) and len(rtcs) > 0:
        return DOC_TYPE_1
    return DOC_TYPE_UNKNOWN


def page_info_dims(reader_info: dict) -> tuple[float, float]:
    """页几何（§5.1/W:821）：pageInfo.pageWidth/pageHeight，缺省 892×1262（值可数字/字符串）。"""
    info = reader_info if isinstance(reader_info, dict) else {}
    page_info = info.get("pageInfo")
    page_info = page_info if isinstance(page_info, dict) else {}
    return (_num(page_info.get("pageWidth"), TYPE3_DEFAULT_PAGE_W),
            _num(page_info.get("pageHeight"), TYPE3_DEFAULT_PAGE_H))


def font_override_inject() -> str:
    """wkretype @font-face 替换片段（§6.5/W:497）：``@font-face {ascent-override:80%;
    descent-override:20%;``——80%/20% 比例唯一权威源=pdf/html_print_pdf.
    build_font_face_css 真符号（正则提取其 override 值），本件不另写死数字，
    与打印链字体钩子口径永不分叉。"""
    m = _FONT_OVERRIDE_PAIR_RE.search(build_font_face_css())
    if m is None:
        raise RuntimeError("build_font_face_css 产物缺 ascent/descent-override 对"
                           "（T26 字体口径源符号漂移，需两件同步修）")
    return f"@font-face {{ascent-override:{m.group(1)};descent-override:{m.group(2)};"


def _esc_html(text) -> str:
    """HTML 转义（原作 esc 同面）：& < > " ' → 实体（style 属性与文字节点共用）。"""
    return (str(text).replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;")
            .replace('"', "&quot;").replace("'", "&#39;"))


def _css_len(value) -> str:
    """样式数值单位化：裸数字 → ``Npx``；已带单位（字母尾/%）原样。"""
    s = str(value).strip()
    if s and (s[-1].isalpha() or s[-1] == "%"):
        return s
    return f"{s}px"


def _style_class_map(page_json: dict) -> dict:
    """pageJson.style[] → ``{类名: 样式dict}``（§5.4：c 可单值/数组，实弹为数字 id 列表；
    同类名多次出现按出现序合并覆盖——原作 Object.assign 同语义）。"""
    cmap: dict = {}
    for entry in page_json.get("style") or []:
        if not isinstance(entry, dict):
            continue
        names = entry.get("c")
        names = names if isinstance(names, list) else [names]
        styles = entry.get("s") if isinstance(entry.get("s"), dict) else {}
        for name in names:
            key = str(name)
            cmap[key] = {**cmap.get(key, {}), **styles}
    return cmap


def _word_span(node: dict, cmap: dict) -> str:
    """文字节点 → 绝对定位 span（§7.2/W:577-591）。

    样式合成=类引用 r[] 依序合并 → 内联 s 覆盖（原作 Object.assign 链）；属性五件：
    color / font-family（加 ,sans-serif 尾）/ font-size / bold=='true' / letter-spacing。
    行高=高（line-height:{h}px 配 ascent-override 字体做纵向对齐）。
    """
    p = node.get("p") if isinstance(node.get("p"), dict) else {}
    merged: dict = {}
    for ref in node.get("r") or []:
        if not isinstance(ref, bool) and isinstance(ref, (str, int, float)):
            merged.update(cmap.get(str(ref), {}))
    inline = node.get("s") if isinstance(node.get("s"), dict) else {}
    style = {**merged, **inline}
    x, y = _num(p.get("x")), _num(p.get("y"))
    h = _num(p.get("h"))
    pieces = []
    if style.get("color"):
        pieces.append(f"color:{style['color']};")
    if style.get("font-family"):
        pieces.append(f"font-family:'{style['font-family']}',sans-serif;")
    if style.get("font-size"):
        pieces.append(f"font-size:{_css_len(style['font-size'])};")
    bold = style.get("bold")
    if bold is True or str(bold).strip().lower() == "true":
        pieces.append("font-weight:bold;")
    if style.get("letter-spacing"):
        pieces.append(f"letter-spacing:{_css_len(style['letter-spacing'])};")
    css = (f"position:absolute;z-index:1;left:{x}px;top:{y}px;height:{h}px;"
           f"line-height:{h}px;white-space:nowrap;color:#000;" + "".join(pieces))
    return f'<span style="{_esc_html(css)}">{_esc_html(node.get("c") or "")}</span>'


def _pic_div(node: dict, png_url: str | None, png_w: int, png_h: int) -> str:
    """图片节点 → 裁剪定位 div（§7.2/W:610-624）。

    ``scale = iw>0 ? w/iw : 1``；background-size=pngW/H×scale 取整（pngW 缺席=auto）；
    偏移=ix/iy×scale 取整；高=ih 数字时 ih×scale 取整否则原高。底图（png_url）
    缺席（下载失败/占位图丢弃）→ 空串（仅文字层，原作同语义）。
    """
    p = node.get("p") if isinstance(node.get("p"), dict) else {}
    crop = node.get("c") if isinstance(node.get("c"), dict) else None
    if crop is None or not png_url:
        return ""
    x, y = _num(p.get("x")), _num(p.get("y"))
    w, h = _num(p.get("w")), _num(p.get("h"))
    iw, ih = crop.get("iw"), crop.get("ih")
    scale = (w / iw) if isinstance(iw, (int, float)) and not isinstance(iw, bool) and iw > 0 else 1.0
    bg_w = round(png_w * scale) if png_w else "auto"
    bg_h = round(png_h * scale) if png_h else "auto"
    off_x, off_y = round(_num(crop.get("ix")) * scale), round(_num(crop.get("iy")) * scale)
    height = (round(ih * scale) if isinstance(ih, (int, float)) and not isinstance(ih, bool)
              else h)

    def _unit(v):
        return f"{v}px" if isinstance(v, (int, float)) else str(v)

    css = (f"position:absolute;left:{x}px;top:{y}px;width:{w}px;height:{height}px;"
           f"overflow:hidden;background:url('{png_url}') {off_x}px {off_y}px no-repeat;"
           f"background-size:{_unit(bg_w)} {_unit(bg_h)}")
    return f'<div style="{_esc_html(css)}"></div>'


@dataclass
class Type3Page:
    """单页重组素材（fetchHtmlViewPages 同构；png_url=None=底图缺席（丢弃/无 png 条目））。"""

    p: int               # 页号（1 起）
    page_json: dict      # pageLoadUrl JSONP 剥壳后 pageJson（§5.4）
    png_url: str | None  # PNG 底图 data URI（judge_page_png 四步链幸存者）
    png_w: int           # 底图 IHDR 宽（缺席=0）
    png_h: int           # 底图 IHDR 高（缺席=0）


@dataclass
class Type3Assets:
    """类型3 资产腿终态（计数全实测，数字零造假）。"""

    font_css: str        # wkretype @font-face 集（已注入 ascent/descent-override）
    pages: list          # list[Type3Page]，页号升序
    stats: dict          # requests/ttf_ok/ttf_skip/json_ok/json_skip/png_kept/png_drop


def _httpx_fetch_asset(url: str, headers: dict, timeout: float, *, binary: bool = False):
    """资产腿缺省网络腿：httpx 直连（gzip 自动解压——wkretype 实弹为 gzip 编码 CSS）。"""
    import httpx  # 延迟导入：纯解析路径零 httpx 依赖（对齐文件头两件）
    r = httpx.get(url, headers=headers, timeout=timeout, follow_redirects=True)
    return r.status_code, (r.content if binary else r.text)


def fetch_type3_assets(reader_info: dict, *, asset_fetch=None, cookie: str = "",
                       user_agent: str | None = None, timeout: float = 15.0,
                       min_interval: float = WENKU_ASSET_MIN_INTERVAL, sleep=None) -> Type3Assets:
    """类型3 三条资产腿（§6.5 ttf / §6.2 逐页 json / §6.6 png）→ Type3Assets。

    - ttf：GET wkretype pipe（§6.5 URL 模板，param 自带前导 &）；响应不含 ``@font-face``
      → 跳过该页字体（§8-5）；幸存集统一 ``@font-face{`` → override 注入片段替换（§6.5/W:497）；
    - json：逐页 GET pageLoadUrl（§3.1 全套头+Referer wenku；任意状态码都交 strip_jsonp
      试解，失败跳过该页 §8-6——原作 validateStatus:()=>true 同语义）；
    - png：png 条目在且该页 json 幸存才拉（原作同序）；非 2xx/非字节 → 弃；
      字节过 judge_page_png 四步链（>200B/魔数/IHDR/占位图<2KB 丢弃——真符号），
      幸存 → data URI 内嵌；
    - 页序=1..max(pageIndex)（json/png/ttf 三桶取 max，原作 Math.max 同口径）；
      json 条目缺席的页号如实跳过（原作 find 无命中 continue）。
    asset_fetch 注入点=资产网络腿（确定性测试用），签名
    ``(url, headers, timeout, *, binary) -> (status, text|bytes)``；min_interval/sleep=
    腿间节流（§9 速率自律；缺省=WENKU_ASSET_MIN_INTERVAL=0.5s 安全默认，T41 P0-3——
    显式传 0 关闭仅供确定性测试）。逐腿异常=单腿失败跳过（原作 try/catch 容错面）。
    """
    leg = asset_fetch or _httpx_fetch_asset
    do_sleep = sleep or time.sleep
    html_urls = reader_info.get("htmlUrls") if isinstance(reader_info, dict) else None
    html_urls = html_urls if isinstance(html_urls, dict) else {}
    json_map: dict = {}
    for entry in html_urls.get("json") or []:
        pi = _entry_page_index(entry)
        if pi is not None and isinstance(entry, dict):
            json_map[pi] = entry
    png_map: dict = {}
    for entry in html_urls.get("png") or []:
        pi = _entry_page_index(entry)
        if pi is not None and isinstance(entry, dict):
            png_map[pi] = entry
    ttf_entries = [e for e in html_urls.get("ttf") or [] if isinstance(e, dict)]
    page_w, page_h = page_info_dims(reader_info)
    text_headers = _view_headers(user_agent, cookie)
    text_headers["Referer"] = WENKU_ASSET_REFERER
    png_headers = {"User-Agent": user_agent or _DEFAULT_UA, "Referer": WENKU_ASSET_REFERER}
    stats = {"requests": 0, "ttf_ok": 0, "ttf_skip": 0,
             "json_ok": 0, "json_skip": 0, "png_kept": 0, "png_drop": 0}

    def _paced(url: str, headers: dict, binary: bool):
        if min_interval > 0 and stats["requests"] > 0:
            do_sleep(min_interval)
        stats["requests"] += 1
        return leg(url, headers, timeout, binary=binary)

    # —— ttf 字体 CSS 腿（§6.5）——
    store_id = reader_info.get("storeId")
    css_parts: list[str] = []
    for entry in ttf_entries:
        pn = _entry_page_index(entry)
        if not store_id or pn is None:
            stats["ttf_skip"] += 1
            continue
        url = WKRETYPE_URL_TMPL.format(store_id=store_id, pn=pn,
                                       param=str(entry.get("param") or ""))
        try:
            status, text = _paced(url, text_headers, False)
        except Exception:
            status, text = 0, None
        if (isinstance(status, int) and 200 <= status < 300
                and isinstance(text, str) and "@font-face" in text):
            css_parts.append(text)
            stats["ttf_ok"] += 1
        else:
            stats["ttf_skip"] += 1  # §8-5：ttf 返回无效数据（不含 @font-face）→ 跳过
    font_css = _AT_FONT_FACE_RE.sub(font_override_inject(), "\n".join(css_parts))

    # —— 逐页 json+png 腿（§6.2/§6.6）——
    max_pn = 0
    for pi in list(json_map) + list(png_map):
        max_pn = max(max_pn, pi)
    for entry in ttf_entries:
        pi = _entry_page_index(entry)
        if pi is not None:
            max_pn = max(max_pn, pi)
    pages: list[Type3Page] = []
    for pn in range(1, max_pn + 1):
        jentry = json_map.get(pn)
        if not isinstance(jentry, dict) or not jentry.get("pageLoadUrl"):
            continue  # 该页无文字层条目：如实跳过（原作 find 无命中 continue）
        try:
            _, text = _paced(jentry["pageLoadUrl"], text_headers, False)
        except Exception:
            text = None
        try:
            page_json = strip_jsonp(text) if isinstance(text, str) else None
        except JsonpError:
            page_json = None
        if not isinstance(page_json, dict):
            stats["json_skip"] += 1  # §8-6：page N 数据解析失败 → 跳过该页
            continue
        stats["json_ok"] += 1
        png_url, png_w, png_h = None, 0, 0
        pentry = png_map.get(pn)
        if isinstance(pentry, dict) and pentry.get("pageLoadUrl"):
            try:
                status, data = _paced(pentry["pageLoadUrl"], png_headers, True)
            except Exception:
                status, data = 0, None
            if (isinstance(status, int) and 200 <= status < 300
                    and isinstance(data, (bytes, bytearray)) and data):
                verdict = judge_page_png(bytes(data), page_w, page_h)  # 四步链真符号
                if verdict.keep:
                    png_url = ("data:image/png;base64,"
                               + base64.b64encode(bytes(data)).decode("ascii"))
                    png_w, png_h = verdict.width or 0, verdict.height or 0
                    stats["png_kept"] += 1
                else:
                    stats["png_drop"] += 1  # §8-7：占位图/魔数不符 → 丢弃底图仅文字层
            else:
                stats["png_drop"] += 1
        pages.append(Type3Page(p=pn, page_json=page_json, png_url=png_url,
                               png_w=png_w, png_h=png_h))
    return Type3Assets(font_css=font_css, pages=pages, stats=stats)


def render_html_view(title: str, reader_info: dict, pages: list, font_css: str = "") -> str:
    """类型3 重组 HTML（§7.2 renderHtmlView，W:502-658 复刻）。

    - 文档级 CSS（calls 偏移 44124）+ wkretype 字体 CSS 注入同一 ``<style>``；
      ``@page`` 尺寸=pageInfo 文档级页宽高（px）——printToPDF 页几何唯一权威
      （preferCSSPageSize，§7.1：忽略 pdf() 的 width/height 参数）；
    - 页容器=class page 绝对定位盒（宽高=pageJson.page.pw/ph，缺省回落 pageInfo）；
      文字层 span=绝对定位+行高=高；图片层 div=背景裁剪（scale=w/iw）；
      文字层/图片层各自独立 100% 覆盖层（原作同构）；
    - 图片节点取 body[]（t=='pic'，实弹实锤：底图以 body 节点携带）∪ pics[]
      （t in {'pic','img'}，§5.4 规格面）——两源并集，如实渲染。
    """
    page_w, page_h = page_info_dims(reader_info)
    chunks: list[str] = []
    for page in pages:
        if isinstance(page, Type3Page):
            page_json, png_url, png_w, png_h = (page.page_json, page.png_url,
                                                page.png_w, page.png_h)
        elif isinstance(page, dict):  # 字典形态（W:544 fetchHtmlViewPages 原键）兼容
            page_json = page.get("page_json")
            png_url, png_w, png_h = page.get("png_url"), page.get("png_w"), page.get("png_h")
        else:
            continue
        page_json = page_json if isinstance(page_json, dict) else {}
        png_w, png_h = int(png_w or 0), int(png_h or 0)
        node_page = page_json.get("page") if isinstance(page_json.get("page"), dict) else {}
        pw = _num(node_page.get("pw"), page_w)
        ph = _num(node_page.get("ph"), page_h)
        cmap = _style_class_map(page_json)
        body_nodes = [n for n in (page_json.get("body") or []) if isinstance(n, dict)]
        spans = [_word_span(n, cmap) for n in body_nodes
                 if n.get("t") == "word" and isinstance(n.get("c"), str)]
        pic_nodes = [n for n in body_nodes if n.get("t") in ("pic", "img")]
        for n in page_json.get("pics") or []:
            if isinstance(n, dict) and n.get("t") in ("pic", "img") and n not in pic_nodes:
                pic_nodes.append(n)
        pics = [_pic_div(n, png_url, png_w, png_h) for n in pic_nodes]
        chunks.append(
            '<div class="page" style="width:' + f"{pw}" + 'px;height:' + f"{ph}"
            + 'px;position:relative;overflow:hidden">'
            + '<div style="position:absolute;left:0;top:0;width:100%;height:100%">'
            + "".join(spans) + '</div>'
            + '<div style="position:absolute;left:0;top:0;width:100%;height:100%">'
            + "".join(pics) + '</div></div>')
    doc_css = ("body{margin:0;font-family:sans-serif}"
               ".page{page-break-after:always;background:#fff}"
               ".page:last-child{page-break-after:auto}"
               f"@page{{size:{page_w}px {page_h}px;margin:0}}")
    return ("<!doctype html><html><head><meta charset='utf-8'>"
            f"<title>{_esc_html(title)}</title><style>{doc_css}\n{font_css}</style></head>"
            f"<body>{''.join(chunks)}</body></html>")


__all__ += [
    # —— T26（类型3 重组：JSON+PNG+TTF → printToPDF）——
    "DOC_TYPE_1", "DOC_TYPE_2", "DOC_TYPE_3", "DOC_TYPE_UNKNOWN",
    "WKRETYPE_URL_TMPL", "WENKU_ASSET_REFERER", "WENKU_ASSET_MIN_INTERVAL",
    "TYPE3_DEFAULT_PAGE_W", "TYPE3_DEFAULT_PAGE_H",
    "PAGE_SIZE_TOL_PT", "WenkuUnknownTypeError", "Type3Assets", "Type3Page",
    "judge_doc_type", "page_info_dims", "font_override_inject", "fetch_type3_assets",
    "render_html_view",
]
__all__ += ["dispatch_reconstruction"]  # T26 三型分派（fetch_ladder 同体；两段式调用面）

# ================================================================ T31：类型2 重组（纯图片）→ printToPDF + OCR 字数参照
# FR2.2/FR2.AC2；WENKU_SPEC §5.2 分支2+§7.3 renderImageHtml+§9「可纯 httpx」清单+
# SPEC_REVIEW 残留#5（类型2 字数参照=OCR 文字层，pageJson 仅类型3）。图片腿=htmlUrls
# 数组直链（UA+Referer+Cookie，无 Acs-Token）；打印腿=本地 Chromium 无头（真符号
# html_to_pdf）；字数参照腿=render/ocr 二级管线（T13 真符号 make_pdf_searchable，
# ocr_fn 注入点=T23/book118 同缝）；质检门=quality_gate 四门真跑（manifest 落盘经
# load_manifest schema 校验）。类型1（T35）重组在本文件续建。

import json

try:  # T31 增量件（双导入法对齐文件头；paddle 引擎在 render.ocr 内部懒加载）
    from kb_factory.harvest_engine import quality_gate as _quality_gate
    from kb_factory.harvest_engine.render.ocr import make_pdf_searchable as _make_pdf_searchable
except ImportError:
    from harvest_engine import quality_gate as _quality_gate  # type: ignore
    from harvest_engine.render.ocr import make_pdf_searchable as _make_pdf_searchable  # type: ignore

TYPE2_DEFAULT_PAGE_W = 2400.0   # §5.1/W:834 类型2 pageInfo 缺省宽（类型3 缺省 892 不混用）
TYPE2_DEFAULT_PAGE_H = 1500.0   # §5.1/W:834 类型2 pageInfo 缺省高
#: 注记#5：类型2 字数参照=OCR 文字层——quality_gate 五型词表词（词义钉死「wenku
#: 类型2=OCR 全文」，不走 pageJson；SPEC_REVIEW 残留#5 落地）。
TYPE2_REF_CHARS_SOURCE = "type2"


def type2_page_dims(reader_info: dict) -> tuple[float, float]:
    """类型2 页几何（§5.1/W:834）：pageInfo.pageWidth/pageHeight parseFloat（实弹字符串
    小数），缺省 **2400×1500**（类型2 专属缺省——与类型3 的 892×1262 分立，W:821/834）。
    """
    info = reader_info if isinstance(reader_info, dict) else {}
    page_info = info.get("pageInfo")
    page_info = page_info if isinstance(page_info, dict) else {}
    return (_num(page_info.get("pageWidth"), TYPE2_DEFAULT_PAGE_W),
            _num(page_info.get("pageHeight"), TYPE2_DEFAULT_PAGE_H))


@dataclass
class Type2Page:
    """类型2 单页素材（四步链幸存者）：原直链留档 + data URI 内嵌（打印零网络）+
    IHDR 实测宽高。"""

    p: int               # 页号（pn= 索引，1 起）
    url: str             # htmlUrls 原直链
    data_uri: str        # data:image/png;base64,... 内嵌
    w: int               # IHDR 宽
    h: int               # IHDR 高


@dataclass
class Type2Assets:
    """类型2 图片腿终态（计数全实测，数字零造假）。"""

    pages: list          # list[Type2Page] 页号升序
    stats: dict          # requests/img_kept/img_drop


def fetch_type2_images(reader_info: dict, *, asset_fetch=None, cookie: str = "",
                       user_agent: str | None = None, timeout: float = 15.0,
                       min_interval: float = WENKU_ASSET_MIN_INTERVAL, sleep=None) -> Type2Assets:
    """类型2 图片腿（§5.2 数组消费+§9 可纯 httpx+§6.6 四步链）：

    htmlUrls 数组经 ``html_urls_to_pages``（T22 真符号：pn= 索引去重；无 pn= 项如实
    不计页号）→ 页号升序逐页 GET（头=UA+Referer wenku+Cookie，§6.6 png 腿原作口径）→
    ``judge_page_png`` 四步链（>200B/PNG 魔数/IHDR/占位图<2KB 全幅丢弃——真符号）→
    幸存 data URI 内嵌。逐腿异常/非 2xx/判弃=单页跳过（原作 try/catch 容错面），主循环
    不中断；页库存只收幸存页（数字零造假）。asset_fetch 注入点=网络腿（确定性测试用），
    签名 ``(url, headers, timeout, *, binary) -> (status, bytes|str)``；min_interval/sleep=
    腿间节流（§9 速率自律；缺省=WENKU_ASSET_MIN_INTERVAL=0.5s 安全默认，T41 P0-3——
    显式传 0 关闭仅供确定性测试）。
    """
    leg = asset_fetch or _httpx_fetch_asset
    do_sleep = sleep or time.sleep
    urls = html_urls_to_pages(reader_info.get("htmlUrls") if isinstance(reader_info, dict) else None)
    page_w, page_h = type2_page_dims(reader_info)
    headers = {"User-Agent": user_agent or _DEFAULT_UA, "Referer": WENKU_ASSET_REFERER}
    if cookie:
        headers["Cookie"] = cookie
    stats = {"requests": 0, "img_kept": 0, "img_drop": 0}
    pages: list[Type2Page] = []
    for pn in sorted(urls):
        if min_interval > 0 and stats["requests"] > 0:
            do_sleep(min_interval)
        stats["requests"] += 1
        try:
            status, data = leg(urls[pn], headers, timeout, binary=True)
        except Exception:
            status, data = 0, None
        if not (isinstance(status, int) and 200 <= status < 300
                and isinstance(data, (bytes, bytearray)) and data):
            stats["img_drop"] += 1
            continue
        verdict = judge_page_png(bytes(data), page_w, page_h)
        if not verdict.keep:
            stats["img_drop"] += 1   # §8-7 同链：占位图/魔数不符/≤200B → 丢弃该页
            continue
        pages.append(Type2Page(p=pn, url=urls[pn],
                               data_uri="data:image/png;base64,"
                                        + base64.b64encode(bytes(data)).decode("ascii"),
                               w=verdict.width or 0, h=verdict.height or 0))
        stats["img_kept"] += 1
    return Type2Assets(pages=pages, stats=stats)


def render_image_html(title: str, reader_info: dict, pages: list) -> str:
    """类型2 重组 HTML（§7.3 renderImageHtml，W:370-380 复刻）。

    - 文档级 CSS 逐字：``body{margin:0}`` + ``.page{page-break-after:always;
      width:{W}px;height:{H}px;overflow:hidden}`` + ``.page:last-child{page-break-after:
      auto}`` + ``img{width:100%;height:100%;display:block;object-fit:contain}`` +
      ``@page{size:{W}px {H}px;margin:0}``——W/H=pageInfo（类型2 缺省 2400×1500），
      printToPDF 页几何唯一权威（preferCSSPageSize，§7.1）；
    - 每页 ``<div class="page"><img src="{data_uri}"/></div>``——原作 src=远端直链；
      复刻按任务卡先逐页下载判件后内嵌 data URI（打印零网络，判件幸存者才成页）；
    - title 转义；零幸存页 → 空 body（调用方零可用页先行短路，此为防御形态）。
    """
    page_w, page_h = type2_page_dims(reader_info)
    chunks: list[str] = []
    for page in pages:
        if isinstance(page, Type2Page):
            src = page.data_uri
        elif isinstance(page, dict):  # 字典形态兼容（url/data_uri 键）
            src = str(page.get("data_uri") or page.get("url") or "")
        else:
            continue
        if src:
            chunks.append(f'<div class="page"><img src="{_esc_html(src)}"/></div>')
    doc_css = ("body{margin:0}"
               f".page{{page-break-after:always;width:{page_w:g}px;height:{page_h:g}px;"
               "overflow:hidden}"
               ".page:last-child{page-break-after:auto}"
               "img{width:100%;height:100%;display:block;object-fit:contain}"
               f"@page{{size:{page_w:g}px {page_h:g}px;margin:0}}")
    return ("<!doctype html><html><head><meta charset='utf-8'>"
            f"<title>{_esc_html(title)}</title><style>{doc_css}</style></head>"
            f"<body>{''.join(chunks)}</body></html>")


def _pdf_page_sizes(pdfium, pdf_path) -> list:
    """pypdfium2 实测逐页尺寸（pt；NFR6 禁 fitz；句柄关净）。"""
    doc = pdfium.PdfDocument(str(pdf_path))
    try:
        return [(pg.get_width(), pg.get_height()) for pg in doc]
    finally:
        doc.close()


def _ocr_ref(image_pdf, out_pdf) -> int:
    """类型2 字数参照缺省（注记#5）：render/ocr.make_pdf_searchable 二级管线实测 chars
    （抽帧→paddleocr 识别→回注 searchable PDF；勿手填，NFR2）。"""
    return int(_make_pdf_searchable(str(image_pdf), str(out_pdf)).chars)


__all__ += [
    # —— T31（类型2 重组：纯图片 → printToPDF + OCR 字数参照）——
    "TYPE2_DEFAULT_PAGE_W", "TYPE2_DEFAULT_PAGE_H", "TYPE2_REF_CHARS_SOURCE",
    "Type2Page", "Type2Assets", "type2_page_dims", "fetch_type2_images", "render_image_html",
]


# ================================================================ T35：类型1 重组（editor 滚动展开 + XML 降级）→ printToPDF
# FR2.2/FR2.AC2；WENKU_SPEC §5.2 分支3+§6.4 wkrtcs getbdjson+§7.4 editor 时序+§7.5
# renderXmlHtml+注记#5（类型1 字数参照=editor DOM 文本）。editor 腿=真浏览器（§9「必须
# 真浏览器」清单#2）：§7.4 全套时序（5s→15×(scrollBy(0,2000)/500ms)→三文案展开点击→
# 5s→25×(scrollBy/500ms)→3s→抽 .ql-editor innerHTML）+ T28 暖启动口径（warmup_url 先访
# 落 cookie+referer 过百度安全验证行为墙——2026-10-22 T28 实测裸 goto 撞墙）；签名窗
# session 复用=signer.context 开页（原作 BrowserWindow session=signer.ses 同型，含其
# 流量闸门三组正则——静态资源拦截不碍 .ql-editor DOM 文本）。XML 降级腿=纯 httpx（§9
# 「可纯 httpx」清单）§6.4 桶式拉取（3 项/桶、**md5sum 无键名直拼**原样照抄——原作逐段
# 核验如此，服务端容错）。打印腿=html_to_pdf（真符号）+ extra_css ``@page{size:A4;margin:0}``
# （Electron printToPDF 缺省页尺寸=A4、Playwright pdf 缺省=Letter——页几何权威仍归 CSS，
# 模板串保持逐字仅补 @page）。verify 段4 占位钉保留（质检门对接归后继）。

from html import unescape as _html_unescape

__all__ += [
    # —— T35（类型1 重组：editor 滚动展开 + XML 降级 → printToPDF）——
    "WKRTCS_GETBDJSON_BASE", "RTCS_BUCKET_SIZE", "GETBDJSON_CALLBACK_TMPL",
    "BOS_DOCCONVERT_TMPL", "TYPE1_REF_CHARS_SOURCE", "A4_PAGE_CSS",
    "EDITOR_WAIT_INIT_S", "EDITOR_SCROLL_ROUNDS_1", "EDITOR_SCROLL_ROUNDS_2",
    "EDITOR_SCROLL_STEP_PX", "EDITOR_SCROLL_INTERVAL_S", "EDITOR_WAIT_EXPAND_S",
    "EDITOR_WAIT_FINAL_S", "EDITOR_EXPAND_TEXTS", "EDITOR_SCROLL_JS", "EDITOR_EXPAND_JS",
    "EDITOR_QL_HTML_JS", "TYPE1_EDITOR_CSS", "TYPE1_XML_CSS",
    "WenkuEditorEmptyError", "Type1XmlAssets", "EditorExtractResult",
    "build_getbdjson_url", "style_obj_to_css", "render_xml_node", "render_xml_html",
    "render_editor_html", "editor_dom_text_chars", "xml_dom_text_chars",
    "fetch_xml_blocks", "run_editor_sequence",
]

WKRTCS_GETBDJSON_BASE = "https://wkrtcs.bdimg.com/rtcs/getbdjson"   # §6.4 类型1 XML 桶端点
RTCS_BUCKET_SIZE = 3                                                # §6.4/W:300 每桶 3 项（i+=3）
GETBDJSON_CALLBACK_TMPL = "sf_edu_wenku_rtcs_doc_jsonp_1_{i}"       # §6.4 callback 桶序号 1 起
BOS_DOCCONVERT_TMPL = "https://wkbjcloudbos.bdimg.com/v1/docconvert896/wk/{doc_id}/{c}"
#: 注记#5：类型1 字数参照=editor DOM 文本——quality_gate 五型词表词（词义钉死
#: 「wenku 类型1=editor DOM 文本」，不走 pageJson/OCR；XML 降级径同词=服务端 DOM）。
TYPE1_REF_CHARS_SOURCE = "type1"
#: printToPDF 缺省页尺寸 A4 的 Playwright 补齐位（页几何权威仍归 CSS @page；模板逐字不动）。
A4_PAGE_CSS = "@page{size:A4;margin:0}"

# —— §7.4 editor 时序（原文数值，唯一权威；live 真节拍实测 5+15×0.5+5+25×0.5+3≈30.5s）——
EDITOR_WAIT_INIT_S = 5.0        # 载入后先等 5s（W:865-870 await sleep(0x1388)）
EDITOR_SCROLL_ROUNDS_1 = 15     # 第一轮滚动 15 次（W:871-874）
EDITOR_SCROLL_ROUNDS_2 = 25     # 展开后滚动 25 次（W:882-885）
EDITOR_SCROLL_STEP_PX = 2000    # scrollBy 步长（原文）
EDITOR_SCROLL_INTERVAL_S = 0.5  # 每轮 500ms（原文 0x1f4）
EDITOR_WAIT_EXPAND_S = 5.0      # 展开点击后再等 5s（原文 0x1388）
EDITOR_WAIT_FINAL_S = 3.0       # 抽取前最后等 3s（原文 0xbb8）
EDITOR_EXPAND_TEXTS = ("查看剩余全文", "继续阅读", "展开全文")  # 三文案（§7.4/calls 52176）

#: 滚动脚本（原文逐字）；三文案展开点击（calls 52176 原文逐字）；.ql-editor 抽取式
#: （calls 52645 原文逐字）。
EDITOR_SCROLL_JS = "window.scrollBy(0, 2000)"
EDITOR_EXPAND_JS = (
    "\n      (function() {\n"
    "        for (const text of ['查看剩余全文', '继续阅读', '展开全文']) {\n"
    "          const els = [...document.querySelectorAll('a,button,span,div')]"
    ".filter(el => el.textContent.includes(text));\n"
    "          if (els.length) { els[0].click(); return text; }\n"
    "        }\n"
    "        return null;\n"
    "      })()\n"
    "    ")
EDITOR_QL_HTML_JS = (
    "\n      (function() { const ql = document.querySelector('.ql-editor'); "
    "return ql ? ql.innerHTML : ''; })()\n    "
)

#: editor 主径 A4 流式模板（calls 偏移 510 原文逐字；body 自带 padding 20mm 18mm——
#: 打印 margin 全 0，版心由 body padding 承担）。
TYPE1_EDITOR_CSS = (
    'body{font-family:"PingFang SC","Microsoft YaHei","微软雅黑","SimSun","宋体",Arial,'
    'sans-serif;margin:0;padding:20mm 18mm;color:#000;max-width:210mm;box-sizing:border-box}\n'
    'p{margin:0;padding:0}img{max-width:100%;height:auto}')
#: XML 降级径 A4 流式模板（§7.5/W:321-369 原文逐字；.page 承担版心+分页）。
TYPE1_XML_CSS = (
    'body{font-family:"PingFang SC","Microsoft YaHei","微软雅黑","SimSun","宋体",Arial,'
    'sans-serif;margin:0;color:#000}\n'
    '.page{width:210mm;padding:20mm 18mm;box-sizing:border-box;page-break-after:always}\n'
    '.page:last-child{page-break-after:auto}p{margin:0;padding:0}span{white-space:pre-wrap}')

#: encodeURIComponent 等价保留字集（JS：A-Za-z0-9-_.!~*'()）。
_URI_SAFE = "-_.!~*'()"


class WenkuEditorEmptyError(RuntimeError):
    """§8-8：.ql-editor 空且无 rtcsRangeInfo 可降级（原文文案中止，不产空件）。"""


def _now_ms() -> int:
    """Date.now() 同型毫秒时钟（可被调用方 now_ms 注入替代=确定性）。"""
    return int(time.time() * 1000)


def build_getbdjson_url(reader_info: dict, bucket_items: list, bucket_index: int, *,
                        now_ms: int | None = None) -> str:
    """§6.4 getbdjson URL 逐段组装（calls 26905-27294 已逐段核验的原文模板）：

    ``https://wkrtcs.bdimg.com/rtcs/getbdjson?bucketNum={ri.bucketNum}&pn={桶内首页.page}&
    rn={3}&range={encodeURIComponent(各项.range 以 _ 连接)}&rsign={ri.rsign}&dataType=rtcs&
    isWpNote=false{ri.md5sum}&callback=sf_edu_wenku_rtcs_doc_jsonp_1_{桶序号}&_={Date.now()}``

    **md5sum 无键名直拼怪癖原样照抄**（值直接拼在 ``isWpNote=false`` 之后，无 ``&md5sum=``
    键名——对源码逐段核验如此，服务端容错，SPEC 置信 medium）；rsign/bucketNum/pn 原样
    拼接不转义（原作字符串直拼同型）；仅 range 走 encodeURIComponent 等价编码。
    """
    info = reader_info if isinstance(reader_info, dict) else {}

    def _val(key):
        v = info.get(key)
        return str(v) if v not in (None, "") else ""

    first_page = ""
    if bucket_items and isinstance(bucket_items[0], dict):
        first_page = str(bucket_items[0].get("page", ""))
    ranges = "_".join(str(e.get("range", "")) if isinstance(e, dict) else "" for e in bucket_items)
    return (f"{WKRTCS_GETBDJSON_BASE}?bucketNum={_val('bucketNum')}"
            f"&pn={first_page}&rn={RTCS_BUCKET_SIZE}"
            f"&range={urllib.parse.quote(ranges, safe=_URI_SAFE)}"
            f"&rsign={_val('rsign')}"
            f"&dataType=rtcs&isWpNote=false{_val('md5sum')}"
            f"&callback={GETBDJSON_CALLBACK_TMPL.format(i=bucket_index)}"
            f"&_={_now_ms() if now_ms is None else int(now_ms)}")


@dataclass
class Type1XmlAssets:
    """类型1 XML 降级腿终态（计数全实测，数字零造假）。"""

    blocks: list      # list[dict] document.xml 页对象并集（桶序；{c:[节点], style:{...}}）
    stats: dict       # requests/buckets_ok/buckets_empty


def fetch_xml_blocks(reader_info: dict, *, asset_fetch=None, cookie: str = "",
                     user_agent: str | None = None, timeout: float = 15.0,
                     now_ms: int | None = None,
                     min_interval: float = WENKU_ASSET_MIN_INTERVAL,
                     sleep=None) -> Type1XmlAssets:
    """类型1 XML 降级桶式拉取（§6.4/W:277-320 fetchXmlBlocks 复刻）：

    rtcsRangeInfo 每 3 项一桶（桶序号 1 起）→ GET wkrtcs getbdjson（头=§3.1 全套+
    ``Referer: https://wenku.baidu.com/``，无 Acs-Token——§9「可纯 httpx」清单）→
    JSONP 剥壳取 ``document.xml``（页对象数组）桶式并集。端点 params error（2026-10-22
    合成令牌单发实测：200+rtcs({"status":{"code":200002,"error":"params error"}})）/缺
    document.xml/坏体 → 空桶如实计数不中断（原作 ``||[]`` 同型）。asset_fetch 注入点=
    网络腿（确定性测试用），签名 ``(url, headers, timeout, *, binary) -> (status, text)``
    ；now_ms=``_={Date.now()}`` 确定性注入；min_interval/sleep=桶间节流（§9 速率自律；
    缺省=WENKU_ASSET_MIN_INTERVAL=0.5s 安全默认，T41 P0-3——显式传 0 关闭仅供确定性测试）。
    """
    leg = asset_fetch or _httpx_fetch_asset
    do_sleep = sleep or time.sleep
    rtcs = reader_info.get("rtcsRangeInfo") if isinstance(reader_info, dict) else None
    rtcs = [e for e in (rtcs or []) if isinstance(e, dict)]
    headers = _view_headers(user_agent, cookie)
    headers["Referer"] = WENKU_ASSET_REFERER
    stats = {"requests": 0, "buckets_ok": 0, "buckets_empty": 0}
    blocks: list = []
    for i in range(0, len(rtcs), RTCS_BUCKET_SIZE):
        bucket = rtcs[i:i + RTCS_BUCKET_SIZE]
        index = i // RTCS_BUCKET_SIZE + 1
        if min_interval > 0 and stats["requests"] > 0:
            do_sleep(min_interval)
        stats["requests"] += 1
        url = build_getbdjson_url(reader_info, bucket, index, now_ms=now_ms)
        try:
            _, text = leg(url, headers, timeout, binary=False)
        except Exception:
            text = None
        try:
            payload = strip_jsonp(text) if isinstance(text, str) else None
        except JsonpError:
            payload = None
        got = payload.get("document.xml") if isinstance(payload, dict) else None
        if isinstance(got, list) and got:
            blocks.extend(got)
            stats["buckets_ok"] += 1
        else:
            stats["buckets_empty"] += 1  # 空桶如实（params error/缺键/坏体；原作 ||[] 同型）
    return Type1XmlAssets(blocks=blocks, stats=stats)


def style_obj_to_css(style) -> str:
    """styleObjToCss（§7.5/W:321-329 原型）：``{k: v}`` → ``k:v;k:v``（值原样，无单位化）。"""
    if not isinstance(style, dict):
        return ""
    return ";".join(f"{k}:{v}" for k, v in style.items())


def render_xml_node(node, cmap: dict, doc_id: str) -> str:
    """renderXmlNode（§7.5/W:331-368 原型，逐分支照抄）：

    - 裸字符串节点 → esc 原文；非 dict/空 → ``''``；
    - ``t=='img' && c`` → ``<img src="BOS docconvert896/wk/{docId}/{c}" style="max-width:
      100%;width:{w||'auto'}px;height:auto;display:block;margin:8px auto" onerror=
      "this.style.display='none'"/>``（w 缺席=``width:auto px`` 原文怪癖——非法声明被
      浏览器丢弃回落 max-width，原作如此照抄；onerror=打印时 BOS 图挂了不露裂图）；
    - ``c`` 为字符串 → ``<span style="{r 类引用合成}">{esc(c)}</span>``（r 可单值/数组，
      cmap=页级 ``{类名: 样式dict}``，未命中引用如实跳过）；
    - 子节点数组递归（join 空串）；标签映射 ``t=='p'→p、t=='span'→span、其余→div``。
    """
    if isinstance(node, str):
        return _esc_html(node)
    if not isinstance(node, dict):
        return ""
    if node.get("t") == "img" and node.get("c"):
        w = node.get("w")
        w = str(w) if w not in (None, "") else "auto"                # W 原文 node.w || 'auto'
        src = BOS_DOCCONVERT_TMPL.format(doc_id=doc_id, c=node["c"])
        return (f'<img src="{_esc_html(src)}" style="max-width:100%;width:{_esc_html(w)}px;'
                'height:auto;display:block;margin:8px auto" '
                "onerror=\"this.style.display='none'\"/>")
    refs = node.get("r")
    if isinstance(refs, list):
        pass
    elif refs:
        refs = [refs]
    else:
        refs = []
    css = ";".join(filter(None, (style_obj_to_css(cmap.get(str(r))) for r in refs)))
    if isinstance(node.get("c"), str):
        return f'<span style="{_esc_html(css)}">{_esc_html(node["c"])}</span>'
    children = node.get("c")
    inner = ("".join(render_xml_node(ch, cmap, doc_id) for ch in children)
             if isinstance(children, list) else "")
    tag = "p" if node.get("t") == "p" else ("span" if node.get("t") == "span" else "div")
    return f'<{tag} style="{_esc_html(css)}">{inner}</{tag}>'


def render_xml_html(title: str, blocks: list, doc_id: str) -> str:
    """类型1 XML 降级重组 HTML（§7.5/W:321-369 renderXmlHtml 复刻，模板逐字）：

    每页对象 → ``<div class="page">`` + 节点递归（节点间 ``\n`` 连接），页间 ``\n``；
    文档级 CSS=TYPE1_XML_CSS 原文（A4 流式：.page 210mm 版心+page-break-after:always，
    span pre-wrap 保空格）；title 转义；打印页几何=``extra_css @page A4`` 补齐位。
    """
    pages = "\n".join(
        '<div class="page">'
        + "\n".join(render_xml_node(n, ((b.get("style") if isinstance(b, dict) else None) or {}),
                                     doc_id)
                    for n in ((b.get("c") if isinstance(b, dict) else None) or []))
        + "</div>"
        for b in blocks if isinstance(b, dict))
    return ("<!doctype html><html><head><meta charset='utf-8'>"
            f"<title>{_esc_html(title)}</title>\n<style>{TYPE1_XML_CSS}</style>\n</head><body>"
            f"{pages}</body></html>")


def render_editor_html(title: str, ql_inner_html: str) -> str:
    """类型1 editor 主径重组 HTML（§7.4 步4/calls 偏移 510 模板逐字）：

    ``<title>`` 转义 + calls510 CSS 原文（body padding 20mm 18mm 版心+max-width:210mm+
    p{margin:0;padding:0}+img max-width:100%）+ **.ql-editor innerHTML 原样内联**（不清洗
    不转义——原作直接拼）；PDF 页=A4（extra_css @page 补齐位）。
    """
    return ("<!doctype html><html><head><meta charset='utf-8'>"
            f"<title>{_esc_html(title)}</title>\n<style>{TYPE1_EDITOR_CSS}</style>\n</head>"
            f"<body>{ql_inner_html or ''}</body></html>")


_TAG_RE = re.compile(r"<[^>]*>")            # DOM 文本抽取：剥标签
_WS_RE_T35 = re.compile(r"\s+")            # 非空白口径（对齐 quality_gate 门②）


def editor_dom_text_chars(ql_inner_html) -> int:
    """注记#5（SPEC_REVIEW 残留#5 落地）：类型1 字数参照=editor DOM 文本字数——
    ``.ql-editor innerHTML`` 剥标签+解实体（html.unescape）后非空白字符数（与
    quality_gate 门② PDF 文字层非空白口径同构；数字零造假：实测计数勿手填）。"""
    text = _html_unescape(_TAG_RE.sub(" ", ql_inner_html or ""))
    return len(_WS_RE_T35.sub("", text))


def xml_dom_text_chars(blocks) -> int:
    """XML 降级径字数参照（同词 type1=editor DOM 文本——document.xml 页对象树=同一编辑器
    文档的服务端 DOM）：裸字符串节点+c 字符串节点递归合计（img 节点不计字），非空白口径。"""
    def _walk(node) -> str:
        if isinstance(node, str):
            return node
        if not isinstance(node, dict):
            return ""
        if node.get("t") == "img":
            return ""  # img 的 c=BOS 对象名（渲染成图，无可见文本）——不计字
        out = node["c"] if isinstance(node.get("c"), str) else ""
        kids = node.get("c")
        if isinstance(kids, list):
            out += "".join(_walk(k) for k in kids)
        return out

    text = "\n".join(_walk(b) for b in (blocks or []) if isinstance(b, dict))
    return len(_WS_RE_T35.sub("", text))


@dataclass
class EditorExtractResult:
    """editor 腿终态产物（字段全实测，数字零造假）。"""

    ql_html: str              # .ql-editor innerHTML（未找到=''）
    clicked_text: str | None  # 展开命中文案（'查看剩余全文'/'继续阅读'/'展开全文'；None=未命中）
    source: str               # caller_page=调用方注入页 | signer_session=signer.context 开页
    warmup_used: bool         # 是否走了暖启动先访（T28 口径）
    referer: str              # view 页 goto referer（缺省 wenku 首页）
    detail: str               # 事实串（source/warmup/clicked/ql_len）


def run_editor_sequence(page, *, sleep=None, log=None) -> tuple[str, str | None]:
    """§7.4 步2-3 全套时序（原文数值唯一权威，W:865-889 复刻）：

    等5s → 15 轮 ``window.scrollBy(0,2000)``（每轮 500ms）→ 三文案展开点击脚本（calls
    52176 原文：a,button,span,div 首中文案即点击返文案）→ 等5s → 25 轮滚动（500ms）→
    等3s → ``.ql-editor innerHTML`` 抽取式（calls 52645 原文）。返回 ``(ql_html,
    clicked_text)``。sleep 注入点=节拍确定性（离线用例）；log 注入点=过程记录（展开
    命中/降级日志面）。page=Playwright Page 鸭子型（goto/evaluate 由调用面注入）。
    """
    do_sleep = sleep or time.sleep
    note = log or (lambda msg: None)
    do_sleep(EDITOR_WAIT_INIT_S)
    for _ in range(EDITOR_SCROLL_ROUNDS_1):
        page.evaluate(EDITOR_SCROLL_JS)
        do_sleep(EDITOR_SCROLL_INTERVAL_S)
    clicked = page.evaluate(EDITOR_EXPAND_JS)
    if clicked:
        note(f"editor 展开命中: {clicked}")
    do_sleep(EDITOR_WAIT_EXPAND_S)
    for _ in range(EDITOR_SCROLL_ROUNDS_2):
        page.evaluate(EDITOR_SCROLL_JS)
        do_sleep(EDITOR_SCROLL_INTERVAL_S)
    do_sleep(EDITOR_WAIT_FINAL_S)
    ql_html = page.evaluate(EDITOR_QL_HTML_JS)
    return ((ql_html if isinstance(ql_html, str) else ""),
            (clicked if isinstance(clicked, str) else None))
