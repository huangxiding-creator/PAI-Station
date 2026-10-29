# -*- coding: utf-8 -*-
"""book118（原创力文档）收割适配器 T19：PREVIEW_DATA→openapi getPreview 预览页清单链。

本任务范围 = search + plan + fetch_ladder(预览页清单腿) + verify 四段骨架；图床拉取/魔数
识别/像素拼 PDF 归 T23，OCR 归 T26。BOOK118_SPEC §1/§2/§3/§5 语义移植（上游
wxynihao/book118-downloader MIT，Java 语义零 GPL 复刻）。

2026-10-22 活探针修正（探针留档 tests/fixtures/_probe_t19_*.json/html，主链 2 请求级验证）：
1. **首跳实况与规格推断不符**：NewView 端点对 curl/curl_cffi(chrome124)/httpx(HTTP/1.1)/
   headless Playwright Chromium 一律 200+空 body（指纹墙已全面拦非真人流量；规格 §3
   「Playwright 可过」系未实测推断，三份 _probe_newview_*.html 均 0 字节即旁证）。
   现行可行首跳 = **文档 .shtm 详情页**（Playwright 过 SafeLine(雷池) JS 挑战——httpx 直打
   得 468 挑战页）→ 页内联 ``var base`` 配置挖预览参数（pic/office 块：加密 aid/actual_page/
   preview_page/view_token + 顶层 senddate）。
2. **openapi 方言换代**：现行参数 = ``project_id=1&aid={加密aid}&t={senddate}&view_token=..&page=N``
   （无 aid_encode；t 即页面 senddate 哈希）。2026-08 旧方言 aid_encode 的金样 token 今日
   仍 200 但 data 全空串（图 URL 过期形态）→ envelope 首键闸门如实判败。**page≥7 批必须带
   ``callback=jsonpReturn``**（不带则返回空 URL 形态；带了 wrapper 与缺省同名，page=1 无碍）。
3. **6 页/批在新方言复现**：preview=62 文档 page=1→keys 1-6、page=7(带 callback)→keys 7 起；
   未对齐 page（如 2）服务端回落返第 1 批 keys 1-6 → 状态机只发对齐批(1,7,13,..)，
   envelope ``expect_first_page=i`` 口径不变（T02/T06 件零改动）。
4. **匿名搜索登录墙**：search.html?q= 的 tdsearch 结果 XHR 被 examine.js+登录弹窗闸死
   （匿名渲染页 0 条 .shtm 结果链接）；search() 如实返回 []+reason，账号 cookie 到位后
   同一解析路自然复活（FR3 商业编目依赖此墙如实标注）。

数字零造假：页清单/actual/preview/retries 全为实发实测值；token 台账 put/get（命中免首跳，
键=(site, aid, project_id)，aid_encode/t 留档）；网络注入点 page_loader/transport（单测确定性，
实弹用缺省真实现）。删除文档（404「该文档已经被删除了」）与无预览（无 view_token）是
显式分支不是异常吞没。
"""
from __future__ import annotations

import json
import random
import re
import time
from collections.abc import Callable
from dataclasses import dataclass
from pathlib import Path
from typing import Any
from urllib.parse import quote

try:  # 合并后正名 kb_factory.harvest_engine.*；worktree 阶段回退顶层名（同 envelope.py）
    from kb_factory.channel_adapters.base import FileMeta
    from kb_factory.harvest_engine.adapters.base import (
        HarvestPlan, LadderResult, DownloadAdapter)
    from kb_factory.harvest_engine.envelope import judge_book118
    from kb_factory.harvest_engine.fetch.paged_fetcher import (
        BatchResponse, PagedFetchResult, PagedFetcher)
    from kb_factory.harvest_engine.parse.inline_var import extract_preview_data
    from kb_factory.harvest_engine.parse.jsonp import strip_jsonp
except ImportError:  # pragma: no cover - worktree 阶段路径
    from channel_adapters.base import FileMeta  # type: ignore
    from harvest_engine.adapters.base import (  # type: ignore
        HarvestPlan, LadderResult, DownloadAdapter)
    from harvest_engine.envelope import judge_book118  # type: ignore
    from harvest_engine.fetch.paged_fetcher import (  # type: ignore
        BatchResponse, PagedFetchResult, PagedFetcher)
    from harvest_engine.parse.inline_var import extract_preview_data  # type: ignore
    from harvest_engine.parse.jsonp import strip_jsonp  # type: ignore

__all__ = [
    "Book118PreviewError", "PreviewParams", "Book118Adapter", "parse_document_id",
    "extract_shtm_config", "preview_list_complete", "SITE", "OPENAPI_URL", "CALLBACK",
    "PROJECT_ID_DEFAULT", "SEARCH_LOGIN_WALL_MARKERS", "FMT_MAP",
    # T41 P0-2 重试分层（数据错 vs 网络错）
    "BOOK118_DATA_ERROR_KINDS", "DATA_RETRY_MAX", "DATA_RETRY_BACKOFF_S",
    "NET_RETRY_MAX", "NET_RETRY_BACKOFF_S", "BACKOFF_JITTER",
    # T23 图床拉取+魔数识别+像素拼 PDF（FR3.1 收割腿）
    "Book118ImageError", "PageImageRecord", "PreviewPdfResult", "image_url_pair",
    "PAGE_IMAGE_GAP_S", "IMAGE_RETRY_PER_SCHEME", "IMAGE_MAGIC_FORMATS",
    # T33 OCR 文字层钩子+GT 取样协议（FR3.2/FR3.AC2）
    "ocr_pages_lines", "make_pdf_ocr_searchable",
]

SITE = "book118"
HOME_URL = "https://max.book118.com/"
OPENAPI_URL = "https://openapi.book118.com/getPreview.html"
SEARCH_URL = "https://max.book118.com/search.html?q="          # q= 形态（word= 渲染空壳，实测）
CALLBACK = "jsonpReturn"       # 与缺省 wrapper 同名：page≥7 批不带它返回空 URL 形态（实测）
PROJECT_ID_DEFAULT = 1         # 页面无此字段，站方 JS 硬编码 1（getPreview XHR 实测）
HTTP_TIMEOUT_S = 30.0          # BOOK118_SPEC §3：全程 30s 连接/读取超时（Java 原作同值）
CHALLENGE_WAIT_S = 15.0        # SafeLine(雷池) JS 挑战自解等待上限（实测 1-3s 内自跳）
CHALLENGE_MARKER = ".safeline"  # 挑战页特征（html head 内 /.safeline/static/...，实测）

#: 匿名搜索登录墙特征（layui 弹窗内嵌 login iframe；实测 2026-10-22）
SEARCH_LOGIN_WALL_MARKERS = ("login/popindex", "登录后操作")

# --- T41 P0-2 重试分层（数据错 vs 网络错；2026-10-23，研判 PENTAGI/book118_assessment.md）---
#: 数据形态错（envelope kind）：missing_first_key=服务端不吐本批首键（T37 实测 62 页件
#: openapi 28 发中 17 发=missing_first_key 重试，占 61% 纯冗余——本质是数据异常/软限速
#: 信号而非网络瞬时抖动）；empty_data=status 200 空 data（频控形态）。此类**不进网络重试
#: 层**：单独限 ≤DATA_RETRY_MAX 次、指数退避 DATA_RETRY_BACKOFF_S + jitter ±50%。
BOOK118_DATA_ERROR_KINDS = frozenset({"missing_first_key", "empty_data"})
DATA_RETRY_MAX = 2
DATA_RETRY_BACKOFF_S = (2.0, 6.0)   # 研判「退避 2s→30s」家族在 ≤2 次上限下的取值
#: 网络类错（传输异常/HTTP!=200/JsonpError 风控壳/信封 status 错）：≤NET_RETRY_MAX 次
#: 指数退避 NET_RETRY_BACKOFF_S + jitter ±50%（研判⑤：网络错退避重试 ≤3）。
NET_RETRY_MAX = 3
NET_RETRY_BACKOFF_S = (1.0, 3.0, 9.0)
BACKOFF_JITTER = 0.5                # 退避抖动幅度 ±50%（消除固定时序指纹，研判 P1-3 同源）

#: 删除文档特征（BOOK118_SPEC §3 实测 113657916：404 + 该标题页）
DOC_DELETED_MARKER = "该文档已经被删除"

#: 详情页 title 锚（var base = { ... title: '..文档名.docx', ...}，单引号 JS 串）
_FMT_MAP = {"doc": "doc", "docx": "doc", "pdf": "pdf", "ppt": "ppt", "pptx": "ppt",
            "xls": "xls", "xlsx": "xls", "txt": "txt", "epub": "epub"}
FMT_MAP = _FMT_MAP

# --- .shtm 内联配置挖掘锚（两份活样本 6115103231005025/5110103104004213 双验证；2026-10-22）---
#: 加密 aid：office/pic 块开括号后首键（base.detail 的 aid 是文档编号，勿混）
RE_INTERNAL_AID = re.compile(r"(?:office|pic)\s*:\s*\{\s*aid\s*:\s*(\d+)")
RE_ACTUAL_PAGE = re.compile(r"actual_page\s*:\s*(\d+)")            # office/pic 两处同值，取首
RE_PREVIEW_PAGE = re.compile(r"preview_page\s*:\s*(\d+)")          # 全页唯一位（pic 块）
RE_VIEW_TOKEN = re.compile(r"view_token\s*:\s*'([^']*)'")          # 单引号值；渲染态会轮换，新旧均有效
RE_SENDDATE = re.compile(r"senddate\s*:\s*'([0-9a-f]{32})'")       # 顶层；= openapi t 参数
RE_TITLE = re.compile(r"title\s*:\s*'((?:[^'\\]|\\.)*)'")          # JS 单引号串（含 \. 转义容忍）
RE_FORMAT = re.compile(r"format\s*:\s*'(\w+)'")
#: 搜索渲染页结果链接（.shtm 文档页；匿名登录墙下 0 命中即如实 []）
RE_SEARCH_DOC_LINK = re.compile(
    r'<a\b[^>]*href="(/html/\d{4}/\d{4}/(\d+)\.shtm)"[^>]*>(.*?)</a>', re.S)


class Book118PreviewError(Exception):
    """预览链失败（kind 机器可读：no_doc_id/no_browser/first_hop_failed/doc_deleted/
    no_preview_data/openapi_failed）。"""

    def __init__(self, kind: str, detail: str = ""):
        super().__init__(f"{kind}: {detail}")
        self.kind = kind
        self.detail = detail


def parse_document_id(text: str) -> str | None:
    """输入（文档编号/文档页链接/NewView 链接）→ 文档编号字符串；不可解析 None。

    Java 原作 parseDocumentId 语义移植（BOOK118_SPEC §1①）：去锚点/查询串 → 取路径末段 →
    拼出全部数字。本件扩展：末段无数字而查询串含 ``aid=数字`` 时取 aid 值（NewView URL 形态）。
    """
    s = (text or "").strip()
    if not s:
        return None
    anchor = s.find("#")
    if anchor >= 0:
        s = s[:anchor]
    query_at = s.find("?")
    query = s[query_at + 1:] if query_at >= 0 else ""
    if query_at >= 0:
        s = s[:query_at]
    last = s.rsplit("/", 1)[-1]
    digits = "".join(re.findall(r"\d+", last))
    if digits:
        return digits
    m = re.search(r"(?:^|&)aid=(\d+)", query)  # NewView 形态扩展
    return m.group(1) if m else None


def extract_shtm_config(html: str) -> dict | None:
    """.shtm 详情页内联配置 → 预览参数字典；无有效预览（无 view_token/aid）None。

    活形态（2026-10-22 双样本验证）::

        var base = { ..., senddate: '{32位hex}', ..., title: '...docx', format: 'docx',
                     office|pic: { aid: {加密aid}, actual_page: N, ..., preview_page: M,
                                   view_token: '...' } }
    """
    if not html:
        return None
    m_aid = RE_INTERNAL_AID.search(html)
    m_token = RE_VIEW_TOKEN.search(html)
    if m_aid is None or m_token is None or not m_token.group(1):
        return None
    m_preview = RE_PREVIEW_PAGE.search(html)
    m_actual = RE_ACTUAL_PAGE.search(html)
    m_send = RE_SENDDATE.search(html)
    m_title = RE_TITLE.search(html)
    m_fmt = RE_FORMAT.search(html)
    cfg: dict[str, Any] = {
        "aid": int(m_aid.group(1)),
        "view_token": m_token.group(1),
        "preview_page": int(m_preview.group(1)) if m_preview else None,
        "actual_page": int(m_actual.group(1)) if m_actual else None,
        "t": m_send.group(1) if m_send else None,
        "title": m_title.group(1) if m_title else "",
        "filetype": m_fmt.group(1) if m_fmt else "",
    }
    return cfg


def preview_list_complete(page_numbers: list[int], limit: int | None) -> bool:
    """页清单完整性门（纯函数）：1..limit 连续无缺（limit=None 时只验非空连续）。"""
    if not page_numbers:
        return False
    if page_numbers != list(range(1, len(page_numbers) + 1)):
        return False
    return limit is None or len(page_numbers) == int(limit)


@dataclass
class PreviewParams:
    """openapi getPreview 请求参数集（首跳挖出或台账命中）。"""

    doc_id: str
    project_id: int
    aid: int
    view_token: str
    t: str | None = None               # 新方言 senddate（现行站方 JS 用）
    aid_encode: str | None = None      # 旧方言（2026-08 Java 原作/台账复用）
    title: str = ""
    filetype: str = ""
    preview_page: int | None = None    # .shtm 挖出的可预览页数（状态机 total_pages 预置）
    actual_page: int | None = None
    source: str = "shtm"               # shtm/newview/ledger（审计留痕）

    def request_params(self, page: int) -> dict:
        """第 page 批请求参数（方言自动：有 t 走新方言，否则 aid_encode 旧方言）。"""
        params: dict[str, Any] = {"project_id": self.project_id, "aid": self.aid,
                                  "view_token": self.view_token, "page": int(page),
                                  "callback": CALLBACK}
        if self.t:
            params["t"] = self.t
        elif self.aid_encode:
            params["aid_encode"] = self.aid_encode
        return params


class Book118Adapter(DownloadAdapter):
    """book118 四段适配器（本任务=search/plan/预览页清单腿/verify；T23 图床拼 PDF 续写）。

    生命周期纪律（browser/kit 同款）：browser 由调用方（fixture/orchestrator）launch/close；
    本件每次首跳/搜索自开上下文、finally 必关（零泄漏）。缺省 page_loader=Playwright 真浏览器
    （过 SafeLine 挑战），缺省 transport=httpx 直连（openapi 无指纹墙，规格 §3 实测）。
    """

    site = SITE

    def __init__(self, *, browser=None, browser_kit=None, store=None, audit=None,
                 page_loader: Callable[[str], str] | None = None,
                 transport: Callable[[dict], tuple[int, str]] | None = None,
                 sleep: Callable[[float], None] = time.sleep):
        self._browser = getattr(browser_kit, "browser", None) or browser
        self._ua = getattr(browser_kit, "user_agent", None)
        self._store = store
        self._audit = audit
        self._page_loader = page_loader          # 注入点①：首跳/搜索页面 HTML（测试确定性）
        self._transport = transport              # 注入点②：openapi (status, body)（测试确定性）
        self._sleep = sleep
        self._http = None                        # 惰性 httpx.Client（transport 未注入时）
        self._reason = ""                        # search 不可用原因（进审计，不造假）

    # ---------------------------------------------------------------- 段1 search

    def search(self, query: str, limit: int) -> list[FileMeta]:
        """按查询词检 ≤limit 条 FileMeta（.shtm 渲染结果解析；匿名登录墙如实 []+reason）。"""
        limit_n = max(1, int(limit))
        url = SEARCH_URL + quote(query)
        try:
            html = self._load_page(url)
        except Book118PreviewError as exc:
            self._reason = exc.kind
            self._audit_row("search", query, 0, "fail", exc.kind)
            return []
        metas = self._parse_search_results(html)
        if not metas:
            walled = any(m in html for m in SEARCH_LOGIN_WALL_MARKERS)
            self._reason = ("login_gated" if walled else "empty_result")
            self._audit_row("search", query, 0, "fail", self._reason)
            return []
        self._reason = ""
        out = metas[:limit_n]
        self._audit_row("search", query, len(out), "ok", f"query={query!r}")
        return out

    @staticmethod
    def _parse_search_results(html: str) -> list[FileMeta]:
        """渲染态搜索页 → FileMeta 列表（去重保序；title 取锚文本，空则用编号，不造假）。"""
        metas: list[FileMeta] = []
        seen: set[str] = set()
        for m in RE_SEARCH_DOC_LINK.finditer(html):
            path, doc_id, inner = m.group(1), m.group(2), m.group(3)
            if doc_id in seen:
                continue
            seen.add(doc_id)
            text = re.sub(r"<[^>]+>", " ", inner)
            text = re.sub(r"\s+", " ", text).strip()
            title = text or doc_id
            suffix = title.rsplit(".", 1)[-1].lower() if "." in title else ""
            metas.append(FileMeta(
                title=title, fmt=_FMT_MAP.get(suffix, suffix or "doc"),
                source_url=HOME_URL.rstrip("/") + path,
                extra={"book118_doc_id": doc_id}))
        return metas

    # ---------------------------------------------------------------- 段2 plan

    def plan(self, meta: FileMeta) -> HarvestPlan:
        """单文档 → 收割计划（slot=文档编号；本任务只承预览页清单腿，梯队序沿用基座缺省）。"""
        doc_id = meta.extra.get("book118_doc_id") or parse_document_id(meta.source_url or "")
        return HarvestPlan(meta=meta, slot=str(doc_id or ""))

    # ---------------------------------------------------------------- 段3 fetch_ladder

    def fetch_ladder(self, plan: HarvestPlan) -> LadderResult:
        """预览页清单腿：参数获取（台账命中免首跳→.shtm 首跳→NewView 遗产回退）→
        PagedFetcher.for_book118 六页批分页拉取 → 页清单+actual/preview 入 FileMeta.extra。

        图床下载/拼 PDF 属 T23：本段产物=页清单（artifact_path=None 如实）。
        """
        meta = plan.meta
        doc_id = meta.extra.get("book118_doc_id") or parse_document_id(meta.source_url or "")
        if not doc_id:
            raise Book118PreviewError("no_doc_id",
                                      f"meta 无 book118_doc_id 且 source_url 不可解析: {meta!r}")
        meta.extra["book118_doc_id"] = str(doc_id)
        try:
            params = self._acquire_params(str(doc_id), meta)
        except Book118PreviewError as exc:
            self._audit_row("fetch_ladder", str(doc_id), 0, "fail", exc.kind)
            return LadderResult(ok=False, pages=0, coverage="0/?",
                                detail=f"params_failed kind={exc.kind} {exc.detail}")
        retry_stats: dict = {"data": 0, "net": 0}
        fetch_fn = self._make_fetch_fn(params, str(doc_id), retry_stats)
        # T41 P0-3（2026-10-23）：total_pages 不再预置 .shtm 声明值——ArithmeticStep.absorb
        # 对 limit 取 max()，声明 preview=10>openapi 实测 6 会把 limit 锁死在 10 造成
        # missing_first_key 风暴（T37 实测形态）；首响应 openapi pages.preview=唯一事实源。
        # T41 P0-2：max_retries=0——重试策略全在 fetch_fn 闭包按错误类分层（数据错
        # ≤2/网络错 ≤3 退避+jitter），状态机不再同层加打。
        fetcher = PagedFetcher.for_book118(fetch_fn, total_pages=None,
                                           sleep=self._sleep, max_retries=0)
        fres: PagedFetchResult = fetcher.run()
        return self._collect(plan, params, fres, retry_stats)

    def _collect(self, plan: HarvestPlan, params: PreviewParams,
                 fres: PagedFetchResult, retry_stats: dict | None = None) -> LadderResult:
        """终态归集：页清单/actual/preview/filetype 落 FileMeta.extra，产 LadderResult。

        T41 P0-3（2026-10-23）preview 形态漂移二次校验——openapi 实测=唯一事实源：
        ① .shtm 声明值 vs openapi 实测上限不一致 → ``book118_preview_drift`` 留档
        （双值并记）+ preview_drift 审计告警，页参照恒用实测值（声明值不得覆盖）；
        ② openapi 上限 vs 实吐页数短收 → 页参照降级为实吐页数+partial 标注（「预览
        部分」合法形态），禁上限值覆盖实收。T41 P0-2：retries 口径=状态机重试(恒 0)+
        批内分层重试（data/net 分列，详见 _make_fetch_fn）。
        """
        meta = plan.meta
        page_numbers = fres.page_numbers
        meta.extra["book118_aid"] = params.aid
        meta.extra["book118_project_id"] = params.project_id
        if fres.limit is not None:
            meta.extra["book118_pages_preview"] = int(fres.limit)
        actual = fres.headers.get("pages_actual")
        if actual is None and params.actual_page is not None:
            actual = params.actual_page
        if actual is not None:
            meta.extra["book118_pages_actual"] = int(actual)
        if fres.headers.get("filetype") or params.filetype:
            meta.extra["book118_filetype"] = fres.headers.get("filetype") or params.filetype
        meta.extra["book118_page_urls"] = dict(fres.pages)
        preview = fres.limit
        # —— T41 P0-3 ①：shtm 声明 vs openapi 实测 ——
        declared = params.preview_page
        if (declared is not None and fres.limit is not None
                and int(declared) != int(fres.limit)):
            meta.extra["book118_preview_drift"] = {"shtm_declared": int(declared),
                                                   "openapi_measured": int(fres.limit)}
            self._audit_row(
                "preview_drift", str(meta.extra.get("book118_doc_id") or ""),
                int(fres.limit), "drift",
                f"shtm声明 preview={int(declared)} vs openapi实测={int(fres.limit)}"
                f"——以实测为准（T41 P0-3）")
        # —— T41 P0-3 ②：openapi 上限 vs 实吐短收（实吐=唯一事实源，降级标注）——
        if fres.limit is not None and 0 < len(page_numbers) < int(fres.limit):
            drift = meta.extra.setdefault("book118_preview_drift", {})
            drift.update(openapi_limit=int(fres.limit), received=len(page_numbers))
            meta.extra["book118_pages_preview"] = len(page_numbers)
            meta.extra["book118_partial_preview"] = True
            self._audit_row(
                "preview_drift", str(meta.extra.get("book118_doc_id") or ""),
                len(page_numbers), "drift",
                f"openapi上限={int(fres.limit)} 实吐={len(page_numbers)}——页参照降级为"
                f"实吐+partial（T41 P0-3）")
        if preview is not None and actual is not None and int(preview) < int(actual):
            meta.extra["book118_partial_preview"] = True   # 收费形态：只取 preview 页（FR3.AC1 标注）
        complete = preview_list_complete(page_numbers, preview)
        ok = fres.ok and complete
        rs = retry_stats or {}
        retry_bits = (f"retries={int(fres.retries) + int(rs.get('data', 0)) + int(rs.get('net', 0))}"
                      f"(data={int(rs.get('data', 0))},net={int(rs.get('net', 0))})")
        self._audit_row("fetch_ladder", str(meta.extra["book118_doc_id"]),
                        len(page_numbers), "ok" if ok else "fail",
                        f"batches={fres.batches_ok} requests={fres.requests} "
                        f"{retry_bits} stopped={fres.stopped_reason} "
                        f"params_source={params.source}")
        return LadderResult(
            ok=ok, ladder_used="L1" if ok else None, pages=len(page_numbers),
            coverage=fres.coverage,
            detail=(f"params={params.source} batches={fres.batches_ok} "
                    f"requests={fres.requests} {retry_bits} "
                    f"stopped={fres.stopped_reason} complete={complete}"
                    + (f"; notes={fres.detail}" if fres.detail else "")))

    # ---------------------------------------------------------------- 段4 verify

    def verify(self, result: LadderResult) -> bool:
        """预览页清单质检门：ok 且页数≥1 且 coverage got==limit（完整收割；数字零造假）。"""
        if not result.ok or not result.pages or result.pages < 1:
            return False
        m = re.fullmatch(r"(\d+)/(\d+|\?)", result.coverage or "")
        if m is None:
            return False
        got, limit = m.group(1), m.group(2)
        if int(got) != result.pages:
            return False
        return limit == "?" or int(got) == int(limit)

    # ---------------------------------------------------------------- 参数获取（三级）

    def _acquire_params(self, doc_id: str, meta: FileMeta) -> PreviewParams:
        """台账命中（免首跳）→ .shtm 首跳（现行主链）→ NewView 遗产回退；失败显式 kind。"""
        hit = self._ledger_lookup(meta)
        if hit is not None:
            self._audit_row("first_hop", doc_id, 1, "ok", "ledger_hit")
            return hit
        html = self._first_hop_shtm(doc_id, meta)
        if html is None:
            raise Book118PreviewError("first_hop_failed",
                                      "无 .shtm source_url 且 NewView 遗产链未吐数据")
        return html

    def _ledger_lookup(self, meta: FileMeta) -> PreviewParams | None:
        """token 台账命中（键=(site, aid, project_id)，aid/pid 由既往 FileMeta.extra 携带）。"""
        if self._store is None:
            return None
        aid, pid = meta.extra.get("book118_aid"), meta.extra.get("book118_project_id")
        if aid is None or pid is None:
            return None
        rec = self._store.get_token(site=SITE, aid=aid, project_id=pid)
        if rec is None:
            return None
        return PreviewParams(
            doc_id=str(meta.extra.get("book118_doc_id") or rec.get("aid_encode") or ""),
            project_id=int(rec["project_id"]), aid=int(rec["aid"]),
            view_token=rec["token"], t=rec.get("t"), aid_encode=rec.get("aid_encode"),
            title=rec.get("title") or "", filetype=rec.get("filetype") or "",
            preview_page=rec.get("preview_page"), actual_page=rec.get("actual_page"),
            source="ledger")

    def _first_hop_shtm(self, doc_id: str, meta: FileMeta) -> PreviewParams | None:
        """Playwright 开 .shtm 过 SafeLine 挑战挖内联配置；404 删除页/无预览显式 kind。"""
        source_url = meta.source_url or ""
        if not source_url.rstrip("/").endswith(".shtm"):
            source_url = ""      # 只有编号无 .shtm 路径 → 直接试 NewView 遗产链
        html = self._load_page(source_url) if source_url else ""
        if html and DOC_DELETED_MARKER in html:
            raise Book118PreviewError("doc_deleted", f"{doc_id} 404 删除页")
        cfg = extract_shtm_config(html) if html else None
        if cfg is not None:
            return self._remember(doc_id, cfg, source="shtm")
        legacy = self._first_hop_newview(doc_id)      # NewView 遗产链回退（规格 §1②）
        if legacy is not None:
            return legacy
        raise Book118PreviewError(
            "no_preview_data",
            f"{doc_id} 页面无 view_token/aid（不支持预览或访问受限）；html_len={len(html)}")

    def _first_hop_newview(self, doc_id: str) -> PreviewParams | None:
        """NewView 遗产链（BOOK118_SPEC §1/§2）：PREVIEW_DATA 四字段（2026-10-22 实测指纹墙
        全拦，保留作规格口径回退与台账旧方言复用）。"""
        url = (HOME_URL + "index.php?g=Home&m=NewView&a=index&aid=" + doc_id)
        html = self._load_page(url)
        if not html:
            return None
        if DOC_DELETED_MARKER in html:
            raise Book118PreviewError("doc_deleted", f"{doc_id} 404 删除页")
        pd = extract_preview_data(html)
        if pd is None:
            return None
        return self._remember(doc_id, {
            "aid": int(pd["aid"]), "view_token": pd["view_token"], "t": None,
            "aid_encode": pd["aid_encode"], "title": "", "filetype": "",
            "preview_page": None, "actual_page": None,
            "project_id": pd["project_id"]}, source="newview")

    def _remember(self, doc_id: str, cfg: dict, *, source: str) -> PreviewParams:
        """挖到参数 → PreviewParams + token 台账留档（view_token 跨月稳定，BOOK118_SPEC §2）。"""
        params = PreviewParams(
            doc_id=str(doc_id), project_id=int(cfg.get("project_id") or PROJECT_ID_DEFAULT),
            aid=int(cfg["aid"]), view_token=cfg["view_token"], t=cfg.get("t"),
            aid_encode=cfg.get("aid_encode") or str(doc_id), title=cfg.get("title") or "",
            filetype=cfg.get("filetype") or "", preview_page=cfg.get("preview_page"),
            actual_page=cfg.get("actual_page"), source=source)
        if self._store is not None:
            self._store.put_token(params.view_token, site=SITE, aid=params.aid,
                                  project_id=params.project_id, aid_encode=params.aid_encode,
                                  t=params.t, title=params.title, filetype=params.filetype,
                                  preview_page=params.preview_page,
                                  actual_page=params.actual_page)
        self._audit_row("first_hop", str(doc_id), 1, "ok", f"source={source}")
        return params

    # ---------------------------------------------------------------- openapi 批拉取

    def _make_fetch_fn(self, params: PreviewParams, doc_id: str,
                       retry_stats: dict | None = None):
        """站点响应→BatchResponse 归一（T06 缝）+ T41 P0-2 批内分层重试（数据错≠网络错）。

        重试策略全在本闭包内按错误类分层（fetcher 侧 max_retries=0，状态机不再同层加打）：
        - 数据形态错（envelope kind∈BOOK118_DATA_ERROR_KINDS，如 missing_first_key——
          服务端不吐本批首键）：**不进网络重试层**，单独限 ≤DATA_RETRY_MAX 次、退避
          DATA_RETRY_BACKOFF_S+jitter（T37 实测 62 页件 17/28 发=此类冗余重试占 61%）；
        - 网络类错（传输异常/HTTP!=200/JsonpError 风控壳/信封 status 错）：≤NET_RETRY_MAX
          次指数退避 NET_RETRY_BACKOFF_S+jitter；
        - 每次重试=真发（经 transport，调用方预算/台账如实计数）+openapi_retry 审计行；
          类预算耗尽即返回 ok=False（PagedFetcher 即 fetch_failed 如实停）。
        """
        stats = retry_stats if retry_stats is not None else {"data": 0, "net": 0}

        def _backoff(kind: str, tried: int, page: int) -> None:
            table = DATA_RETRY_BACKOFF_S if kind == "data" else NET_RETRY_BACKOFF_S
            cap = DATA_RETRY_MAX if kind == "data" else NET_RETRY_MAX
            base = table[min(tried - 1, len(table) - 1)]
            self._sleep(base * random.uniform(1.0 - BACKOFF_JITTER, 1.0 + BACKOFF_JITTER))
            self._audit_row("openapi_retry", doc_id, 0, "retry",
                            f"page={page} class={kind} retry={tried}/{cap} "
                            f"backoff={base:g}s(jitter±{int(BACKOFF_JITTER * 100)}%)")

        def _net_gate(page: int, detail: str, tried: int):
            """网络类错重试闸：有额度→None（退避后由调用侧 continue 重试）；耗尽→终态响应。"""
            if tried >= NET_RETRY_MAX:
                return BatchResponse(ok=False,
                                     detail=f"{detail} net_retries={tried}/{NET_RETRY_MAX}")
            return None

        def fetch_fn(req: dict) -> BatchResponse:
            page = int(req["page"])
            net_tried = data_tried = 0
            while True:
                qp = params.request_params(page)
                try:
                    status, body = self._call_openapi(qp)
                except Exception as exc:                 # ConnectError/Timeout…=网络类错
                    got = _net_gate(page, f"{type(exc).__name__} page={page}", net_tried)
                    if got is not None:
                        return got
                    net_tried += 1
                    stats["net"] += 1
                    _backoff("net", net_tried, page)
                    continue
                if status != 200:
                    got = _net_gate(page, f"http={status} page={page}", net_tried)
                    if got is not None:
                        return got
                    net_tried += 1
                    stats["net"] += 1
                    _backoff("net", net_tried, page)
                    continue
                try:
                    payload = strip_jsonp(body, CALLBACK)
                except Exception as exc:                 # JsonpError：风控壳/非 JSON 形态=网络类
                    got = _net_gate(page, f"{type(exc).__name__} page={page}", net_tried)
                    if got is not None:
                        return got
                    net_tried += 1
                    stats["net"] += 1
                    _backoff("net", net_tried, page)
                    continue
                verdict = judge_book118(payload, expect_first_page=page)
                if verdict.state == "ok":
                    facts = verdict.facts
                    headers = {}
                    if facts.get("pages_actual") is not None:
                        headers["pages_actual"] = int(facts["pages_actual"])
                    if facts.get("filetype"):
                        headers["filetype"] = facts["filetype"]
                    limit = facts.get("pages_preview")
                    return BatchResponse(ok=True, pages=dict(facts["page_urls"]),
                                         headers=headers,
                                         limit=int(limit) if limit is not None else None)
                kind = getattr(verdict, "kind", "?")
                detail = f"page={page} {kind}"
                if kind in BOOK118_DATA_ERROR_KINDS:     # 数据形态错：不进网络重试层
                    if data_tried >= DATA_RETRY_MAX:
                        return BatchResponse(
                            ok=False,
                            detail=f"{detail} data_retries={data_tried}/{DATA_RETRY_MAX}")
                    data_tried += 1
                    stats["data"] += 1
                    _backoff("data", data_tried, page)
                    continue
                got = _net_gate(page, detail, net_tried)
                if got is not None:
                    return got
                net_tried += 1
                stats["net"] += 1
                _backoff("net", net_tried, page)
                continue
        return fetch_fn

    def _call_openapi(self, params: dict) -> tuple[int, str]:
        """openapi HTTP 层（注入点②；缺省 httpx 30s 协议直连，Referer=首页，openapi 无指纹墙）。

        trust_env=False 是硬口径：httpx 的 trust_env=True 在 Windows 会吞注册表系统代理
        （urllib.getproxies 读 Internet Settings）——本机 Clash 注册表代理常死（7892 拒连），
        2026-10-22 实弹实锤 6 连 ConnectError 即此因；openapi/图床按 SPEC §3 协议直连，
        站点代理策略归 orchestrator，不在适配器层继承系统代理。
        """
        if self._transport is not None:
            return self._transport(params)
        if self._http is None:
            import httpx
            self._http = httpx.Client(
                timeout=HTTP_TIMEOUT_S, trust_env=False,
                headers={"User-Agent": self._ua or _DEFAULT_UA,
                         "Referer": HOME_URL})
        r = self._http.get(OPENAPI_URL, params=params)
        return r.status_code, r.text

    # ---------------------------------------------------------------- 页面加载（注入点①）

    def _load_page(self, url: str) -> str:
        """浏览器页加载：缺省 Playwright 过 SafeLine 挑战后取 content（上下文 finally 必关）。"""
        if self._page_loader is not None:
            return self._page_loader(url)
        if self._browser is None:
            raise Book118PreviewError("no_browser", "未注入 browser/page_loader，无法首跳")
        ctx = self._browser.new_context(user_agent=self._ua or _DEFAULT_UA)
        try:
            page = ctx.new_page()
            page.goto(url, timeout=HTTP_TIMEOUT_S * 1000, wait_until="domcontentloaded")
            deadline = time.monotonic() + CHALLENGE_WAIT_S
            html = page.content()
            while CHALLENGE_MARKER in html[:4000] and time.monotonic() < deadline:
                self._sleep(1.0)
                html = page.content()
            return html
        finally:
            ctx.close()

    # ---------------------------------------------------------------- 审计

    def _audit_row(self, event: str, docid: str, count: int, status: str,
                   detail: str) -> None:
        """审计一行（HarvestAudit 在位才写；缺席静默——审计不阻塞收割链）。"""
        if self._audit is not None:
            self._audit.request(site=SITE, event=event, query_or_docid=str(docid),
                                count=int(count), status=status, detail=detail)

    @property
    def reason(self) -> str:
        """search 不可用原因（login_gated/empty_result/no_browser/…；空串=可用）。"""
        return self._reason

    # ------------------------------------------------- T23：图床拉取+魔数识别+像素拼 PDF

    _img_http = None  # 惰性图床 httpx.Client（类级缺省；实例首用时建，不触 __init__ 既有件）

    def download_page_images(self, page_urls: dict, out_dir, doc_id: str = "",
                             *, image_transport: Callable[[str], tuple[int, bytes]] | None = None
                             ) -> list:
        """页清单 → view-cache 页图直下+魔数识别落盘（T23 腿①；FR3.1/BOOK118_SPEC §3/§5）。

        - 页号 int 数值排序（"10"<"2" 字典序坑，envelope/SYNTHESIS 同口径）；
        - https 优先 http 兜底（§5-5），每协议 IMAGE_RETRY_PER_SCHEME 次、30s 超时；
          非 5xx/429 状态（如 404）不重试直切下一协议；
        - 魔数识别 sniff_format 定真身与落盘扩展名（R16：.png 实为 GIF89a，扩展名不可信）；
        - URL 原样透传勿二次编码（fastdfs 文件名含 @/= 属正常，§3）；缺省 httpx
          trust_env=False 协议直连（T19 Windows 注册表代理坑实锤；图床无指纹墙，§3）；
        - 未知魔数/双协议耗尽=失败页：store.mark_failed 记账（失败页重单 resume 口径），
          成功页 unfailed 除名；有失败页即抛 Book118ImageError（成功页已落盘不回滚）。
        - image_transport 注入点③：吃绝对 URL 吐 (状态码, 图字节)（离线确定性；网络层
          异常=抛异常形态，照实计尝试）。
        """
        norm = {int(k): str(v) for k, v in (page_urls or {}).items()}
        pages = sorted(norm)
        if not pages:
            raise Book118ImageError("no_page_list", "页清单为空（先跑 fetch_ladder 再进本腿）")
        _, sniff_format = _import_image_stack()
        out = Path(out_dir)
        out.mkdir(parents=True, exist_ok=True)
        transport = image_transport or self._image_transport
        records: list[PageImageRecord] = []
        failures: list[str] = []
        doc = str(doc_id or "")
        for i, page in enumerate(pages):
            raw_url = norm[page]
            https_url, http_url = image_url_pair(raw_url)
            got = None      # (scheme_used, status, body)
            attempts: list[str] = []
            for scheme, target in (("https", https_url), ("http", http_url)):
                for _ in range(IMAGE_RETRY_PER_SCHEME):
                    tag = scheme
                    try:
                        status, body = transport(target)
                    except Exception as exc:      # 网络层异常（ConnectError/Timeout…）
                        tag = f"{scheme}!{type(exc).__name__}"
                        attempts.append(tag)
                        continue
                    if status == 200 and body:
                        got = (scheme, int(status), body)
                        break
                    tag = f"{scheme}:{status or 0}"
                    attempts.append(tag)
                    if not (status >= 500 or status == 429):   # 404 等：换协议，不空耗重试
                        break
                if got is not None:
                    break
            if got is None:
                failures.append(f"page={page} attempts={','.join(attempts) or 'no_attempt'}")
                self._mark_page_failed(doc, page, "download_failed")
                self._audit_row("page_image", doc, 0, "fail",
                                f"page={page} attempts={','.join(attempts)}")
                continue
            scheme, status, body = got
            fmt = sniff_format(body)
            if fmt not in IMAGE_MAGIC_FORMATS:    # 未知/非图魔数：不赌扩展名，按失败页处理
                failures.append(f"page={page} unknown_magic={fmt!r} bytes={len(body)}")
                self._mark_page_failed(doc, page, f"unknown_magic={fmt!r}")
                self._audit_row("page_image", doc, 0, "fail",
                                f"page={page} unknown_magic={fmt!r} bytes={len(body)}")
                continue
            path = out / f"{page:04d}.{fmt}"
            path.write_bytes(body)
            records.append(PageImageRecord(page=page, url=raw_url, scheme_used=scheme,
                                           status=status, fmt=fmt, byte_len=len(body),
                                           path=path))
            if self._store is not None and doc:
                self._store.unfailed(site=SITE, doc=doc, page=page)
            self._audit_row("page_image", doc, len(body), "ok",
                            f"page={page} scheme={scheme} fmt={fmt} bytes={len(body)}")
            if i < len(pages) - 1:
                self._sleep(PAGE_IMAGE_GAP_S)     # 页间礼貌间隔（可注入；SPEC 未钉图床频控）
        self._audit_row("page_images", doc, len(records),
                        "ok" if not failures else "fail",
                        f"ok={len(records)} fail={len(failures)}"
                        + ("; " + "; ".join(failures[:5]) if failures else ""))
        if failures:
            raise Book118ImageError(
                "page_image_failed",
                f"{len(failures)}/{len(pages)} 页失败: " + "; ".join(failures[:8]))
        return records

    def harvest_preview_pdf(self, meta: FileMeta, work_dir, *,
                            image_transport: Callable[[str], tuple[int, bytes]] | None = None,
                            ocr_fn: Callable | None = None,
                            ocr_layer: bool = True) -> "PreviewPdfResult":
        """FR3.1 收割腿全链：页清单→图直下→魔数识别→int 排序→像素拼 PDF→OCR 参照→质检门。

        前置=fetch_ladder 已把 book118_page_urls/页数入 meta.extra（T19 口径：int 页号→
        协议相对 URL）；无页清单显式 Book118ImageError(no_page_list)。

        - 像素拼 PDF=pdf/image_pdf.build_image_pdf（页序=页号 int 序，页几何=图像素 1px=1pt），
          页数 pypdfium2 实测（数字零造假）；
        - 收费形态（preview<actual / book118_partial_preview）：FileMeta 形态标注
          「预览部分」+perm=yellow（黄线透明），manifest 用 preview_limit（quality_gate
          部分收割合法口径）；全预览形态 manifest 用 expected_pages（==actual）；
        - OCR 文字层钩子（T33/FR3.2）挂参 ocr_layer 可选启用：True（缺省）=拼 PDF 后
          make_pdf_ocr_searchable 产 searchable PDF（空文本行过滤），质检门参照=其实测
          chars（ref_chars_source=book118）；False=像素 PDF 先行、文字层后补（编排层可
          再调钩子）——无字数参照即不落 manifest 不跑质检门（load_manifest 硬拒
          ref_chars<1，零造假：无文字层=无参照=门不判过，verify_pdf 如实 False）；
          GT 取词协议（FR3.AC2）归 tests/test_book118_ocr_gt.py；
        - ocr_fn 注入点④：Callable[[图PDF, 出PDF], int]（OCR 子系统边界，离线确定性）。
        - T41 P0-4（2026-10-23）收费内容法律面处置（研判要求的处置文字，代码级落地）：
          收割范围=站方**免费公开预览页**（无登录态、无付费墙绕过、无账号面）；「仅保存
          预览部分、不做全量重构」从约定升为**代码级硬约束**——落盘前按
          ``book118_pages_preview`` 预览页数上限强制截断（超限页不下载不落盘，正常链路
          openapi 只发预览页故为空操作；防御新调用路径喂超限清单）；per-doc 许可元数据
          =FileMeta.extra（partial/preview/actual/preview_drift 留档）；留存/删除策略=
          work 目录产物生命周期归编排层，台账 ledger 每请求一行全程可追溯每份文档的
          授权依据（免费公开预览额度）；OCR 再加工产物仅覆盖预览页（衍生内容不越界）。
        """
        extra = meta.extra or {}
        page_urls = extra.get("book118_page_urls") or {}
        if not page_urls:
            raise Book118ImageError(
                "no_page_list",
                f"meta.extra 无 book118_page_urls（先跑 fetch_ladder）：doc_id="
                f"{extra.get('book118_doc_id')!r}")
        doc_id = str(extra.get("book118_doc_id") or "")
        work = Path(work_dir)
        # —— T41 P0-4 法律面硬约束：预览页数上限落盘前强制截断（仅保存预览部分）——
        preview_cap = extra.get("book118_pages_preview")
        if preview_cap is not None and len(page_urls) > int(preview_cap):
            keep = set(sorted(int(k) for k in page_urls)[:int(preview_cap)])
            dropped = sorted(set(int(k) for k in page_urls) - keep)
            page_urls = {k: v for k, v in page_urls.items() if int(k) in keep}
            self._audit_row(
                "preview_cap", doc_id, int(preview_cap), "truncate",
                f"法律面硬约束：页清单超预览上限，落盘前截断弃页={dropped}"
                f"（仅保存预览部分，T41 P0-4）")
        records = self.download_page_images(page_urls, work / "pages", doc_id,
                                            image_transport=image_transport)
        build_image_pdf, _ = _import_image_stack()
        stem = doc_id or "book118"
        image_pdf = build_image_pdf([r.path for r in records], work / f"{stem}.pdf",
                                    title=meta.title or None)
        pdfium = _import_pdfium()
        with pdfium.PdfDocument(str(image_pdf)) as doc:
            pages_measured = len(doc)            # 实测页数（不拿清单长度冒充）
        preview = extra.get("book118_pages_preview")
        actual = extra.get("book118_pages_actual")
        partial = bool(extra.get("book118_partial_preview")) or (
            preview is not None and actual is not None and int(preview) < int(actual))
        if partial:                              # 收费/部分预览形态：黄线+「预览部分」
            meta.perm = "yellow"
            meta.extra["book118_form"] = "预览部分"
        if ocr_layer:                              # OCR 文字层钩子（T33 挂参，缺省启用）
            searchable_pdf = work / f"{stem}_ocr.pdf"
            ref_fn = ocr_fn or self._ocr_ref
            ref_chars = int(ref_fn(image_pdf, searchable_pdf))
            manifest = {"pdf_path": str(searchable_pdf), "ref_chars": ref_chars,
                        "ref_chars_source": "book118"}
            if partial:
                manifest["preview_limit"] = int(preview if preview is not None else len(records))
            else:
                manifest["expected_pages"] = int(
                    actual if actual is not None
                    else (preview if preview is not None else len(records)))
            manifest_path = work / f"{stem}_manifest.json"
            manifest_path.write_text(json.dumps(manifest, ensure_ascii=False, indent=1),
                                     encoding="utf-8")
            quality_gate = _import_quality_gate()
            checked = quality_gate.load_manifest(manifest_path)   # schema 校验（词表/正整数）
            gate = quality_gate.run_gate(checked)
            meta.extra["book118_manifest"] = str(manifest_path)
        else:                                      # 像素 PDF 先行：无参照不落 manifest 不跑门
            searchable_pdf = None
            manifest_path = None
            manifest = None
            checked = None
            ref_chars = 0
            gate = []
        meta.extra["book118_image_pdf"] = str(image_pdf)
        self._audit_row("pdf_build", doc_id, pages_measured, "ok",
                        f"image_pdf={image_pdf.name} pages={pages_measured} "
                        f"partial={partial} ocr_layer={'on' if ocr_layer else 'off'} "
                        f"ref_chars={ref_chars}")
        self._audit_row("quality_gate", doc_id, sum(1 for g in gate if g.passed),
                        "ok" if all(g.passed for g in gate) else "fail",
                        " ".join(f"{g.name}={'PASS' if g.passed else 'FAIL'}" for g in gate))
        return PreviewPdfResult(image_pdf=image_pdf, searchable_pdf=searchable_pdf,
                                manifest_path=manifest_path, manifest=checked,
                                pages=pages_measured, page_records=records,
                                ref_chars=ref_chars, gate_outcomes=gate, partial=partial)

    def verify_pdf(self, result: "PreviewPdfResult") -> bool:
        """T23 质检门收口：四门全过 且 实测页数==页清单页数≥1（partial 参照=preview_limit）。"""
        if not result.gate_outcomes or not all(g.passed for g in result.gate_outcomes):
            return False
        return result.pages == len(result.page_records) and result.pages >= 1

    def _mark_page_failed(self, doc: str, page: int, detail: str) -> None:
        """失败页记账（store 在场才写；doc 空=无台账键，只走审计）。"""
        if self._store is not None and doc:
            self._store.mark_failed(site=SITE, doc=doc, page=page, detail=detail)

    def _image_transport(self, url: str) -> tuple[int, bytes]:
        """图床 HTTP 层缺省（httpx 30s 协议直连，trust_env=False 硬口径同 _call_openapi；
        裸 GET 无 Referer——SPEC §2/§3 探针实锤 _probe_page1.png 成功形态）。"""
        if self._img_http is None:
            import httpx
            self._img_http = httpx.Client(
                timeout=HTTP_TIMEOUT_S, trust_env=False, follow_redirects=True,
                headers={"User-Agent": self._ua or _DEFAULT_UA})
        r = self._img_http.get(url)
        return r.status_code, r.content

    @staticmethod
    def _ocr_ref(image_pdf: Path, out_pdf: Path) -> int:
        """OCR 全文参照缺省（T33 钩子 make_pdf_ocr_searchable 实测 chars——勿手填，NFR2；
        空文本行过滤：paddle 偶发空行，回注件拒空串）。"""
        return int(make_pdf_ocr_searchable(image_pdf, out_pdf).chars)


_DEFAULT_UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
               "(KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36")


# ---------------------------------------------------------------- T23 图床收割腿（模块级件）

#: 页间礼貌间隔（SPEC §3 只钉 openapi 批间 1s；图床无实测频控，0.25s 保守值，注入点可零）
PAGE_IMAGE_GAP_S = 0.25
#: 每协议尝试次数（https 耗尽换 http 再耗尽；SPEC §3 批重试上限 5 的同族保守值）
IMAGE_RETRY_PER_SCHEME = 2
#: 可入 PDF 的图魔数词表（sniff_format 口径；book118 实测=.png URL 实为 GIF89a，§3）
IMAGE_MAGIC_FORMATS = frozenset({"gif", "png"})


class Book118ImageError(Exception):
    """图床收割腿失败（kind 机器可读：no_page_list/page_image_failed）。"""

    def __init__(self, kind: str, detail: str = ""):
        super().__init__(f"{kind}: {detail}")
        self.kind = kind
        self.detail = detail


def image_url_pair(url: str) -> tuple[str, str]:
    """图床 URL → (https 首试, http 兜底) 绝对对（BOOK118_SPEC §3/§5-5）。

    协议相对 ``//`` 只补 scheme；绝对 URL 换协议头；路径/查询**原样透传**——
    fastdfs 文件名含 ``@``/``=`` 属正常（§3 两形态实测），勿二次编码破坏。
    """
    u = (url or "").strip()
    if u.startswith("//"):
        return "https:" + u, "http:" + u
    if u.startswith("https://"):
        return u, "http://" + u[len("https://"):]
    if u.startswith("http://"):
        return "https://" + u[len("http://"):], u
    return "https://" + u, "http://" + u     # 裸路径防御形态（线上未见）


@dataclass(frozen=True)
class PageImageRecord:
    """单页图直下实测记录（R16 魔数真身；数字零造假）。"""

    page: int
    url: str            # 页清单原始 URL（协议相对原样）
    scheme_used: str    # 命中协议 https/http
    status: int         # HTTP 状态码（网络异常=0）
    fmt: str            # sniff_format 魔数真身（gif/png）
    byte_len: int       # 实测字节数
    path: Path          # 落盘路径（扩展名=魔数真身，非源 .png）


# ---------------------------------------------------------------- T33 OCR 文字层钩子（FR3.2）

def ocr_pages_lines(frames, ocr_image_fn) -> list:
    """帧 → 页行集（T33/FR3.2）：空文本行过滤——paddle 偶发空文本行，回注件拒空串
    （T34/docin 成品腿同坑同拼法，三原语第二步的 book118 装配层）。

    ocr_image_fn 注入点：识别函数（缺省 render/ocr.ocr_image；测试注入确定性行集）。
    """
    return [[ln for ln in ocr_image_fn(frame) if ln.text] for frame in frames]


def make_pdf_ocr_searchable(image_pdf, out_pdf):
    """OCR 文字层钩子（拼 PDF 后可选启用）：三原语 render_pages→ocr_image（空行过滤）
    →build_searchable_pdf，产出可搜索 PDF + 实测统计（chars 实测勿手填，NFR2）。

    与 T13 make_pdf_searchable 的差异=第二步空文本行过滤（paddle 偶发空行会让
    build_searchable_pdf 回注拒空串而炸——book118 装配层兜住，对齐 docin 成品腿）。
    """
    ocr_mod = _import_ocr()
    frames = ocr_mod.render_pages(str(image_pdf))
    pages_lines = ocr_pages_lines(frames, ocr_mod.ocr_image)
    return ocr_mod.build_searchable_pdf(frames, pages_lines, str(out_pdf))


@dataclass
class PreviewPdfResult:
    """T23 收割腿产物：页图实测记录+像素拼 PDF+OCR 参照+质检门四果。"""

    image_pdf: Path
    searchable_pdf: Path | None      # ocr_layer=False 时 None（像素 PDF 先行，文字层后补）
    manifest_path: Path | None       # 同上（无 OCR 参照不落 manifest，不伪造 ref_chars）
    manifest: dict | None
    pages: int
    page_records: list
    ref_chars: int
    gate_outcomes: list
    partial: bool


def _import_image_stack():
    """延迟导入束：image_pdf 拼件+magic_check 嗅探（worktree 阶段回退顶层名）。"""
    try:
        from kb_factory.harvest_engine.assets.magic_check import sniff_format
        from kb_factory.harvest_engine.pdf.image_pdf import build_image_pdf
    except ImportError:  # pragma: no cover - worktree 阶段路径
        from harvest_engine.assets.magic_check import sniff_format  # type: ignore
        from harvest_engine.pdf.image_pdf import build_image_pdf  # type: ignore
    return build_image_pdf, sniff_format


def _import_quality_gate():
    """延迟导入束：quality_gate 四门（pypdfium2 重件，不进模块顶层）。"""
    try:
        from kb_factory.harvest_engine import quality_gate
    except ImportError:  # pragma: no cover - worktree 阶段路径
        from harvest_engine import quality_gate  # type: ignore
    return quality_gate


def _import_pdfium():
    """延迟导入束：pypdfium2（页数实测；GPL 隔离 NFR6——零 fitz）。"""
    import pypdfium2
    return pypdfium2


def _import_ocr():
    """延迟导入束：T13 OCR 二级管线（paddle 引擎在函数内更惰性，此处只到模块级）。"""
    try:
        from kb_factory.harvest_engine.render import ocr
    except ImportError:  # pragma: no cover - worktree 阶段路径
        from harvest_engine.render import ocr  # type: ignore
    return ocr
