# -*- coding: utf-8 -*-
"""道客巴巴（doc88）渠道适配器（W5，元数据层）。
配方照抄 doc88-reverse 战役实测复刻件（逆向工程/doc88-reverse/replica/doc88_api.py，
端点与正则勿改）：
- 主搜索 GET /search/post.do?from=1&f=0&h=1&pageRange=0&pageNum=&format=&p={页码}
  &q={URL编码关键词}&sDate=&eDate=&ct=0 → HTML 片段（每页 9 条题录，条目块以
  <div class="sd-list-con"> 分隔），免登录零 Cookie；
- 免费文字层 GET /doc.php?act=get_intro&p={intropath}（题录 intropath 属性，如
  /2017/05/05/6562828517966.xml.gz）→ 站方摘要正文；只进 extra["intro"]（≤200字
  截断），不落盘不下载——整本预览（图片型 SWF/ebt 管线）与付费墙本层不碰。
铁律：免登录(零Cookie)/零下载/间隔>=3s/日上限300（可配 KB_DOC88_MIN_INTERVAL /
KB_DOC88_DAILY_LIMIT / KB_DOC88_INTRO_MAX）。WAF 特征字「网络环境安全验证」→
Doc88WAFWall 如实降级返回已取得部分（不硬闯不换栈绕）。
映射：站方大写格式 PDF/DOC/PPT/XLS/TXT → 归一小写，未知→bin（wenku 口径）；
题录属公开免费层：一律 badge=green_free / perm=green（题录口径，不判付费墙）。
"""
import html as _html
import os
import re
import ssl
import time
import urllib.parse
import urllib.request

from kb_factory.channel_adapters.base import (ChannelAdapter, FileMeta, RateLimiter)

BASE = "https://www.doc88.com"
_UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) "
       "Chrome/129.0.0.0 Safari/537.36")
_SEARCH_REFERER = BASE + "/tag/"      # search 腿 Referer（replica doc88_search 实测口径）
_INTRO_REFERER = BASE + "/"           # intro 腿 Referer（replica _get 默认口径）
WAF_MARKER = "网络环境安全验证"        # replica WAF_MARKER 同源（勿改写）
_POST_DO_TMPL = (BASE + "/search/post.do?from=1&f=0&h=1&pageRange=0&pageNum="
                 "&format={fmt}&p={page}&q={q}&sDate=&eDate=&ct=0")
_INTRO_TMPL = BASE + "/doc.php?act=get_intro&p={path}"
_INTRO_MAX_CHARS = 200                # 免费文字层只进 extra 摘要（≤200字）
_MAX_PAGES = 50                       # 翻页安全上限（9条/页×50页远超 per_topic 需求）
_KNOWN_FMT = {"doc", "pdf", "ppt", "xls", "txt", "epub"}   # FileMeta.fmt 规范名子集

# ---- 题录解析正则（照抄 replica doc88_api.py 实测基线） ----
_ITEM_SPLIT_RE = re.compile(r'<div class="sd-list-con">')
_TITLE_A_RE = re.compile(
    r'<a\s+href="(?P<href>[^"]+)"\s+target="_blank"\s+class="sd-title"\s+'
    r'title="(?P<title>[^"]*)"')
_TITLE_A_RE2 = re.compile(          # 属性序变体兜底（class 在前）
    r'<a\s+(?:[^>]*?)class="sd-title"(?:[^>]*?)title="(?P<title>[^"]*)"(?:[^>]*?)>'
    r'\s*(?P<inner>.*?)</a>', re.S)
_INTROPATH_RE = re.compile(r'intropath="(/[^"]+\.xml\.gz)"')
_PCODE_RE = re.compile(r"/p-(\d{6,20})\.html")
_TYPE_IMG_RE = re.compile(r'<img class="type" src="[^"]*/type/([A-Z]+)\.png')
_FIELD_RE = re.compile(
    r"上传时间：(?P<date>\d{4}-\d{2}-\d{2}).*?页数：(?P<pages>\d+).*?"
    r"格式：(?P<fmt>[A-Z]+).*?浏览：\s*(?P<views>\d+)", re.S)
_TOTAL_RE = re.compile(r"约有(?P<total>[\d,]+)篇(?:,以下是第(?P<from>\d+)-(?P<to>\d+)篇)?")
_TAG_RE = re.compile(r"<[^>]+>")


class Doc88WAFWall(RuntimeError):
    """命中 WAF 特征字 → 如实报墙（wall_status=blocked_waf，replica 同口径）。"""
    wall_status = "blocked_waf"


def _strip_tags(s: str) -> str:
    return _TAG_RE.sub("", s).strip()


def _clean_intro(text: str) -> str:
    """免费文字层清洗：去标签+反转义+压空白（replica doc88_intro 同法）。"""
    return _html.unescape(_TAG_RE.sub(" ", text or "")).strip()


def _headers(referer: str) -> dict:
    return {"User-Agent": _UA, "Referer": referer, "Accept": "*/*",
            "Accept-Language": "zh-CN,zh;q=0.9"}


def _search_url(word: str, page: int) -> str:
    return _POST_DO_TMPL.format(fmt="", page=int(page), q=urllib.parse.quote(word))


def _urllib_fetch(word: str, page: int, timeout: float) -> str:
    """真网络腿：stdlib urllib GET post.do（测试用假 _fetch 替换，不打真网络）。"""
    req = urllib.request.Request(_search_url(word, page), headers=_headers(_SEARCH_REFERER))
    with urllib.request.urlopen(req, timeout=timeout,
                                context=ssl.create_default_context()) as r:
        text = r.read().decode("utf-8", "replace")
    if WAF_MARKER in text:
        raise Doc88WAFWall("search 命中 WAF 特征字（wall_status=blocked_waf，如实报墙）")
    return text


def _urllib_intro(intropath: str, timeout: float) -> str:
    """真网络腿：免费文字层 get_intro（只取文本，不落盘不下载）。"""
    url = _INTRO_TMPL.format(path=urllib.parse.quote(intropath))
    req = urllib.request.Request(url, headers=_headers(_INTRO_REFERER))
    with urllib.request.urlopen(req, timeout=timeout,
                                context=ssl.create_default_context()) as r:
        text = r.read().decode("utf-8", "replace")
    if WAF_MARKER in text:
        raise Doc88WAFWall("intro 命中 WAF 特征字（wall_status=blocked_waf，如实报墙）")
    return text


_fetch = _urllib_fetch        # 可 monkeypatch 的网络函数（单一定义点）
_intro_fetch = _urllib_intro  # 同上（免费文字层独立替换点）


def _norm_fmt(raw: str) -> str:
    f = (raw or "").strip().lower()
    return f if f in _KNOWN_FMT else "bin"   # 未知格式→bin（不透传裸站方值）


def _abs_url(href: str) -> str:
    if href.startswith("http"):
        return href
    if href.startswith("//"):
        return "https:" + href
    return BASE + (href if href.startswith("/") else "/" + href)


def _parse(html_text: str) -> tuple[list, str | None]:
    """post.do HTML → (题录 dict 列表, 站方总数原话「约有N篇」跨分片抖动如实保原文)。"""
    m = _TOTAL_RE.search(html_text)
    total_str = m.group("total") if m else None
    out = []
    for chunk in _ITEM_SPLIT_RE.split(html_text)[1:]:   # 首块=列表前导，弃
        a = _TITLE_A_RE.search(chunk) or _TITLE_A_RE2.search(chunk)
        if not a:
            if "sd-title" not in chunk:
                continue          # 非条目块（如尾部脚本），跳
            break                # 条目锚点形态未匹配：如实降级（不猜不造）
        href = a.groupdict().get("href") or ""
        pc = _PCODE_RE.search(href)
        if not pc:
            continue             # 锚点无 p_code（tag 链接等）：如实跳过
        title = a.group("title") or _strip_tags(a.group("inner") or "")
        ip = _INTROPATH_RE.search(chunk)
        f = _FIELD_RE.search(chunk)
        ti = _TYPE_IMG_RE.search(chunk)
        fmt_raw = (f.group("fmt") if f else "") or (ti.group(1) if ti else "")
        out.append({"doc_id": pc.group(1), "title": _html.unescape(title).strip(),
                    "source_url": _abs_url(href), "fmt": _norm_fmt(fmt_raw),
                    "fmt_raw": fmt_raw or None,
                    "pages": int(f.group("pages")) if f else None,
                    "views": int(f.group("views")) if f else None,
                    "upload_date": f.group("date") if f else None,
                    "intropath": ip.group(1) if ip else None})
    return out, total_str


def _to_meta(x: dict, total_str: str | None = None) -> FileMeta:
    return FileMeta(
        title=x["title"],
        fmt=x["fmt"],
        pages=x["pages"],
        badge="green_free",                    # 题录属公开免费层（任务口径）
        perm="green",
        source_url=x["source_url"],
        extra={"doc_id": x["doc_id"], "views": x["views"],
               "upload_date": x["upload_date"], "intropath": x["intropath"],
               "fmt_raw": x["fmt_raw"], "total_str": total_str})


class Doc88Adapter(ChannelAdapter):
    channel = "doc88"

    def __init__(self, limiter: RateLimiter | None = None, timeout: float = 20.0,
                 retries: int = 1, intro_max: int | None = None, audit=None):
        if limiter is None:
            limiter = RateLimiter(
                min_interval=float(os.environ.get("KB_DOC88_MIN_INTERVAL", "3")),
                daily_limit=int(os.environ.get("KB_DOC88_DAILY_LIMIT", "300")),
                name="doc88")
        self.limiter = limiter
        self.timeout = timeout
        self.retries = retries   # 重试 1 次（含首次共 2 次尝试）
        if intro_max is None:
            intro_max = int(os.environ.get("KB_DOC88_INTRO_MAX", "3"))
        self.intro_max = max(0, int(intro_max))  # 每次 metadata 免费文字层拉取条数上限
        self.audit = audit       # None=不记审计（单测注入 tmp 审计时才落盘）

    def _log(self, event, query, t0, count, detail=""):
        if self.audit is not None:
            self.audit.log(channel=self.channel, event=event, query=query,
                           elapsed_ms=int((time.monotonic() - t0) * 1000),
                           count=count, detail=detail)

    def available(self) -> bool:
        s = self.limiter.status()
        return not s["circuit_open"] and s["count_today"] < s["daily_limit"]

    def get_intro(self, intropath: str) -> str | None:
        """免费文字层（get_intro）：摘要文本 ≤200 字只回内存（收进 extra），不落盘。"""
        if not intropath:
            return None
        try:
            self.limiter.acquire()   # 日上限/熔断：如实降级 None（绝不崩溃）
        except Exception as e:
            self._reason = f"{type(e).__name__}: {e}"
            return None
        t0 = time.monotonic()
        text, err = None, None
        for _attempt in range(self.retries + 1):
            try:
                text = _intro_fetch(intropath, self.timeout)
                break
            except Exception as e:   # 网络/WAF/超时：重试1次
                err = e
        if text is None:
            self.limiter.record_error()
            self._reason = f"{type(err).__name__}: {err}"
            self._log("intro_error", intropath, t0, 0, self._reason)
            return None
        self.limiter.record_success()
        intro = _clean_intro(text)[:_INTRO_MAX_CHARS]
        self._log("intro", intropath, t0, len(intro), f"chars={len(intro)}")
        return intro or None       # 200 空 body（站方摘要件不存在）→ 如实 None

    def metadata(self, query: str, limit: int = 12) -> list:
        out, page = [], 1
        try:
            while len(out) < limit and page <= _MAX_PAGES:
                self.limiter.acquire()   # 日上限/熔断在此抛（外层兜底绝不崩溃）
                t0 = time.monotonic()
                html, err = None, None
                for _attempt in range(self.retries + 1):
                    try:
                        html = _fetch(query, page, self.timeout)
                        break
                    except Exception as e:   # 网络/解析/WAF：重试1次
                        err = e
                if html is None:
                    self.limiter.record_error()
                    self._reason = f"{type(err).__name__}: {err}"
                    self._log("error", query, t0, 0, self._reason)
                    break          # 如实降级：返回已取得的部分
                self.limiter.record_success()
                raw, total_str = _parse(html)
                self._log("request", query, t0, len(raw), f"page={page}")
                if not raw:
                    break          # 空页停
                out.extend(_to_meta(x, total_str if page == 1 else None) for x in raw)
                page += 1
            out = out[:limit]
        except Exception as e:     # RateLimitExceeded/CircuitOpenError：契约绝不崩溃
            self._reason = f"{type(e).__name__}: {e}"
            self._log("degraded", query, time.monotonic(), len(out), self._reason)
            return out             # 已取得部分照实返回（零增量时为 []）
        for m in out[:self.intro_max]:   # 免费文字层：只进 extra["intro"] 摘要
            ip = m.extra.get("intropath")
            if not ip:
                continue
            intro = self.get_intro(ip)
            if intro:
                m.extra["intro"] = intro
        return out
