# -*- coding: utf-8 -*-
"""doc88_api — 道客巴巴「搜索选品→题录→免费文字层」纯 HTTP 复刻件（零浏览器零CDP零登录）。

战役 doc88-reverse（2026-10-24）。段1 选品端点定名（原 production_bridge 报
NotImplementedError「首页 JS 动态无直链」——实情：列表确为 JS 动态加载，但端点
明文住在 static.doc88.com/resources/js/search.js?v=2.50（未混淆 jQuery，非 bundle
打包），一次静态直读即全部出土）：

  端点规约（全部 GET，免登录零 Cookie，实测 200）：
  - 主搜索  /search/post.do?from=1&f={0相关性|其他排序}&h=1&pageRange=0&pageNum=
            &format={空|PDF|DOC|PPT|XLS|TXT}&p={页码}&q={URL编码关键词}&sDate=&eDate=&ct=0
            → HTML 片段（jQuery $("#result_content").html(msg) 注入），每页 9 条；
              #pageResult 隐藏 span 内「约有N篇,以下是第a-b篇」＝总数+本页范围；
              条目字段：标题(sd-title title 属性)/p_code(href p-{code}.html)/格式
              (type 图标+sd-intro)/页数/上传时间/浏览数/intropath 属性（摘要件路径）。
  - 联想    /search/suggest.do?q={kw} → JSON [{"title": ...}]（输入框下拉）
  - 相关词  /search/rk.do?q={kw}&ct=0 → JSON {"kwSb": "<li>…HTML"}（tag 链接）
  - 免费文字 /doc.php?act=get_intro&p={intropath}（如 /2017/05/05/6562828517966.xml.gz）
            → HTML/纯文摘要（真实文档开头正文段，站方懒加载摘要件；**这是 doc88
              公开面上唯一的免登录文字层**——整本预览是图片型 SWF（ebt 管线，
              段2/3/4 既有件管，本件不碰））。

墙（如实，不破）：
  - WAF 特征字「网络环境安全验证」（envelope.DOC88_WAF_MARKER 同源）→ Doc88WAFWall
    如实报墙不硬闯；本战役 stdlib urllib+浏览器 UA+首页 Referer 全程放行（实测）。
  - 付费下载/VIP 文档：p_download/登录墙判定归段2/3 既有件（adapters/doc88.py
    T36），本件只做公开面选品+摘要，不碰付费墙。
  - intropath 少数条目缺省（无摘要件）→ 如实 None；总数「约有N篇」跨分片有抖动
    （同词两次 12,179,090 vs 18,942,210）→ 台账如实记每次原值，不取均值不修数。

铁律：免登录(零Cookie)/只读/搜索腿节流>=3s/intro腿>=0.5s/数字零造假（请求台账
全实测落账）。用法：
  py -3 doc88_api.py --q "国际工程EPC" --out DIR [--need 3] [--pages 2] [--fmt PDF]
  py -3 doc88_api.py --accept 5   # 5 次独立会话贯通验收
"""
from __future__ import annotations

import argparse
import html as _html
import json
import re
import ssl
import sys
import time
import unicodedata
import urllib.parse
import urllib.request
from pathlib import Path

__all__ = ["Doc88WAFWall", "Doc88HTTPError", "Doc88ParseError",
           "doc88_search", "doc88_suggest", "doc88_related", "doc88_intro",
           "full_chain", "SearchResult", "SearchPage"]

# ---------------------------------------------------------------- 常量（全部实测定型）

BASE = "https://www.doc88.com"
_UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) "
       "Chrome/129.0.0.0 Safari/537.36")
_REFERER = BASE + "/"                     # 全腿带首页 Referer（实测放行口径）
TAG_REFERER = BASE + "/tag/"              # post.do 实测亦可用首页 Referer
WAF_MARKER = "网络环境安全验证"            # envelope.DOC88_WAF_MARKER 同源（勿改写）

SEARCH_MIN_INTERVAL = 3.0                 # 搜索腿节流（wenku-search-reverse 战役口径对齐）
INTRO_MIN_INTERVAL = 0.5                  # 摘要腿节流
_TIMEOUT = 20.0

_CTX = ssl.create_default_context()

# post.do 固定 query 骨架（search.js searchDoc() 逐参复刻；t= 时间戳实测可省）
_POST_DO_TMPL = (BASE + "/search/post.do?from=1&f=0&h=1&pageRange=0&pageNum="
                 "&format={fmt}&p={page}&q={q}&sDate=&eDate=&ct=0")


# ---------------------------------------------------------------- 异常族

class Doc88WAFWall(RuntimeError):
    """命中 WAF 特征字「网络环境安全验证」→ 如实报墙（不硬闯不换栈绕）。

    wall_status 语义对齐 adapters/doc88.Doc88WAFBlocked（blocked_waf）。
    """

    wall_status = "blocked_waf"


class Doc88HTTPError(RuntimeError):
    """网络腿非 200（带状态码便于台账归因）。"""

    def __init__(self, leg: str, status: int, detail: str = ""):
        super().__init__(f"{leg} http={status} {detail}")
        self.leg, self.status = leg, status


class Doc88ParseError(RuntimeError):
    """返回体形态与实测基线不符（站改版哨兵——如实炸不猜）。"""


# ---------------------------------------------------------------- 请求台账（数字零造假）

class _Ledger:
    """每腿一行：leg/url/status/bytes/elapsed_ms/waf——贯通率/请求账全出此账本。"""

    def __init__(self):
        self.rows: list[dict] = []
        self._last: dict[str, float] = {}

    def pace(self, key: str, min_interval: float) -> float:
        last = self._last.get(key)
        wait = 0.0
        if last is not None:
            wait = max(0.0, min_interval - (time.monotonic() - last))
            if wait:
                time.sleep(wait)
        self._last[key] = time.monotonic()
        return wait

    def log(self, leg: str, url: str, status: int, body: bytes, t0: float):
        self.rows.append({"leg": leg, "url": url[:180], "status": status,
                          "bytes": len(body),
                          "elapsed_ms": int((time.monotonic() - t0) * 1000),
                          "waf": WAF_MARKER in body.decode("utf-8", errors="replace")})


LEDGER = _Ledger()


def _get(url: str, leg: str, *, min_interval: float, referer: str = _REFERER) -> bytes:
    """单腿 GET：节流+浏览器 UA+Referer → 200 字节；WAF 特征字→Doc88WAFWall。"""
    LEDGER.pace(leg, min_interval)
    req = urllib.request.Request(url, headers={
        "User-Agent": _UA, "Referer": referer, "Accept": "*/*",
        "Accept-Language": "zh-CN,zh;q=0.9",
    })
    t0 = time.monotonic()
    try:
        with urllib.request.urlopen(req, timeout=_TIMEOUT, context=_CTX) as resp:
            body = resp.read()
            status = resp.status
    except urllib.error.HTTPError as exc:
        body = exc.read() if hasattr(exc, "read") else b""
        LEDGER.log(leg, url, exc.code, body, t0)
        raise Doc88HTTPError(leg, exc.code) from exc
    LEDGER.log(leg, url, status, body, t0)
    text = body.decode("utf-8", errors="replace")
    if WAF_MARKER in text:
        raise Doc88WAFWall(f"{leg} 命中 WAF 特征字（wall_status=blocked_waf，如实报墙）")
    if status != 200:
        raise Doc88HTTPError(leg, status)
    return body


# ---------------------------------------------------------------- 题录解析（纯解析零网络）

_ITEM_SPLIT_RE = re.compile(r'<div class="sd-list-con">')
_TITLE_A_RE = re.compile(
    r'<a\s+href="(?P<href>[^"]+)"\s+target="_blank"\s+class="sd-title"\s+'
    r'title="(?P<title>[^"]*)"')
_TITLE_A_RE2 = re.compile(                      # 属性序变体兜底（class 在前）
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


class SearchResult:
    """单条题录（字段全出站方 HTML，零推断零造假；intropath 缺省如实 None）。"""

    __slots__ = ("title", "p_code", "url", "fmt", "pages", "upload_date",
                 "views", "intropath")

    def __init__(self, title: str, p_code: str, url: str, fmt: str, pages: int,
                 upload_date: str, views: int, intropath: str | None):
        self.title, self.p_code, self.url, self.fmt = title, p_code, url, fmt
        self.pages, self.upload_date, self.views = pages, upload_date, views
        self.intropath = intropath

    def to_dict(self) -> dict:
        return {"title": self.title, "p_code": self.p_code, "url": self.url,
                "fmt": self.fmt, "pages": self.pages,
                "upload_date": self.upload_date, "views": self.views,
                "intropath": self.intropath}


class SearchPage:
    """单页搜索结果：total_str（站方原话「约有N篇」，跨分片抖动如实保原文）+ 题录表。"""

    def __init__(self, total_str: str | None, shown: tuple[int, int] | None,
                 results: list[SearchResult]):
        self.total_str, self.shown, self.results = total_str, shown, results


def _strip_tags(s: str) -> str:
    return _TAG_RE.sub("", s).strip()


def parse_post_do(html_text: str) -> SearchPage:
    """post.do HTML 片段 → SearchPage（字段全实测自站方标记，解析败如实炸）。"""
    m = _TOTAL_RE.search(html_text)
    total_str = m.group("total") if m else None
    shown = (int(m.group("from")), int(m.group("to"))) if m and m.group("from") else None
    results: list[SearchResult] = []
    chunks = _ITEM_SPLIT_RE.split(html_text)
    for chunk in chunks[1:]:                     # 首块=列表前导，弃
        a = _TITLE_A_RE.search(chunk) or _TITLE_A_RE2.search(chunk)
        if not a:
            if "sd-title" not in chunk:
                continue                         # 非条目块（如尾部脚本），跳
            raise Doc88ParseError("sd-title 条目存在但锚点形态未匹配（站改版哨兵）")
        href = a.groupdict().get("href") or ""
        title = a.group("title") or _strip_tags(a.group("inner") or "")
        title = _html.unescape(title).strip()
        pc = _PCODE_RE.search(href)
        if not pc:
            raise Doc88ParseError(f"条目 href 无 p_code：{href[:120]!r}")
        ip = _INTROPATH_RE.search(chunk)
        f = _FIELD_RE.search(chunk)
        ti = _TYPE_IMG_RE.search(chunk)
        fmt = (f.group("fmt") if f else "") or (ti.group(1) if ti else "")
        results.append(SearchResult(
            title=title, p_code=pc.group(1), url=href, fmt=fmt,
            pages=int(f.group("pages")) if f else 0,
            upload_date=f.group("date") if f else "",
            views=int(f.group("views")) if f else 0,
            intropath=ip.group(1) if ip else None))
    return SearchPage(total_str, shown, results)


# ---------------------------------------------------------------- 四端点（纯 HTTP）

def doc88_search(query: str, *, page: int = 1, fmt: str = "") -> SearchPage:
    """主搜索选品端点：/search/post.do（每页 9 条题录，免登录）。"""
    url = _POST_DO_TMPL.format(page=int(page), fmt=urllib.parse.quote(fmt or ""),
                               q=urllib.parse.quote(query))
    body = _get(url, "search", min_interval=SEARCH_MIN_INTERVAL,
                referer=TAG_REFERER)
    return parse_post_do(body.decode("utf-8", errors="replace"))


def doc88_suggest(query: str) -> list[str]:
    """联想端点：/search/suggest.do → [title]（JSON 数组，容错裸解）。"""
    url = BASE + "/search/suggest.do?q=" + urllib.parse.quote(query)
    body = _get(url, "suggest", min_interval=SEARCH_MIN_INTERVAL)
    try:
        data = json.loads(body.decode("utf-8", errors="replace"))
    except json.JSONDecodeError as exc:
        raise Doc88ParseError(f"suggest 非预期 JSON：{exc}") from exc
    return [str(it.get("title", "")).strip() for it in data if isinstance(it, dict)]


def doc88_related(query: str) -> list[str]:
    """相关词端点：/search/rk.do → kwSb HTML 的 <a> 文本表（tag 扩展词，选品辅助）。"""
    url = BASE + "/search/rk.do?q=" + urllib.parse.quote(query) + "&ct=0"
    body = _get(url, "rk", min_interval=SEARCH_MIN_INTERVAL)
    text = body.decode("utf-8", errors="replace")
    try:
        kw_html = json.loads(text).get("kwSb", "")
    except json.JSONDecodeError:
        kw_html = text
    return [t.strip() for t in (_TAG_RE.sub("\n", kw_html).split("\n"))
            if t.strip()]


def doc88_intro(intropath: str) -> str:
    """免费文字层端点：/doc.php?act=get_intro&p={intropath} → 摘要正文。

    intropath 从题录条目属性取（如 /2017/05/05/6562828517966.xml.gz）；
    返回站方摘要件渲染文本（文档开头真实正文段）。这是 doc88 公开面唯一
    免登录文字层——整本预览是图片型 SWF（ebt 管线既有件，本件不碰）。
    """
    if not intropath.startswith("/"):
        raise Doc88ParseError(f"intropath 须以 / 起（站方属性原样）：{intropath!r}")
    url = BASE + "/doc.php?act=get_intro&p=" + urllib.parse.quote(intropath)
    body = _get(url, "intro", min_interval=INTRO_MIN_INTERVAL)
    return _html.unescape(_TAG_RE.sub(" ", body.decode("utf-8", errors="replace"))).strip()


# ---------------------------------------------------------------- 全链编排

def cjk_chars(text: str) -> int:
    """CJK 字符计数（验收口径：真文字非元数据；quality_gate.count_chars 同思想）。"""
    return sum(1 for ch in text if "CJK" in unicodedata.name(ch, ""))


def full_chain(query: str, *, need: int = 3, pages: int = 2, fmt: str = "",
               ) -> dict:
    """搜索→题录→免费文字 全链（单会话）：每条题录尽量取摘要文字。

    - 题录取 need 条 + 冗余候选（站方部分文档 intropath 有名无实——get_intro
      实测回 200 空 body 0B，摘要件不存在；如实记 texts_err 后取下位候选补位，
      不造假不重试硬闯）；
    - 返回 {query, page_facts, metas, texts, stats}——texts 键=p_code；
      摘要腿失败如实挂账 texts_err[p_code]=原因，不降级不造假。
    """
    metas: list[dict] = []
    seen: set[str] = set()
    page_facts: list[dict] = []
    target = max(1, need) * 2                  # 冗余候选池（空摘要件补位用）
    for p in range(1, max(1, int(pages)) + 1):
        page = doc88_search(query, page=p, fmt=fmt)
        page_facts.append({"page": p, "total_str": page.total_str,
                           "shown": page.shown, "count": len(page.results)})
        for r in page.results:
            if r.p_code not in seen:
                seen.add(r.p_code)
                metas.append(r.to_dict())
        if len(metas) >= target:
            break
    texts: dict[str, str] = {}
    texts_err: dict[str, str] = {}
    kept: list[dict] = []
    for m in metas:
        if len(kept) >= max(1, need) and len(texts) >= max(1, need):
            break
        if not m["intropath"]:
            texts_err[m["p_code"]] = "intropath 缺省（站方无摘要件，如实 None）"
            continue
        try:
            text = doc88_intro(m["intropath"])
        except (Doc88HTTPError, Doc88WAFWall, Doc88ParseError) as exc:
            texts_err[m["p_code"]] = f"{type(exc).__name__}: {exc}"
            continue
        if not text:
            texts_err[m["p_code"]] = "get_intro 200 空 body 0B（站方摘要件不存在，如实挂账）"
            continue
        texts[m["p_code"]] = text
        kept.append(m)                          # 有效题录=有摘要文字者
    metas = kept if kept else metas[:max(1, need)]
    stats = {
        "query": query, "metas": len(metas), "texts_ok": len(texts),
        "texts_err": len(texts_err),
        "texts_cjk": {pc: cjk_chars(t) for pc, t in texts.items()},
        "requests": len(LEDGER.rows),
    }
    return {"query": query, "page_facts": page_facts, "metas": metas,
            "texts": texts, "texts_err": texts_err, "stats": stats}


# ---------------------------------------------------------------- CLI（含 5 会话验收）

def _run_session(query: str, out_dir: Path, *, need: int, pages: int,
                 session: str, fmt: str = "") -> dict:
    out_dir.mkdir(parents=True, exist_ok=True)
    LEDGER.rows.clear()
    result = full_chain(query, need=need, pages=pages, fmt=fmt)
    for m in result["metas"]:
        safe = re.sub(r'[\\/:*?"<>|\s]+', "_", m["title"])[:60] or m["p_code"]
        md = [f"# {m['title']}", "",
              f"- p_code: {m['p_code']}", f"- url: {m['url']}",
              f"- 格式: {m['fmt']} | 页数: {m['pages']} | "
              f"上传: {m['upload_date']} | 浏览: {m['views']}", ""]
        if m["p_code"] in result["texts"]:
            md += ["## 免费文字层（get_intro 摘要，免登录实测提取）", "",
                   result["texts"][m["p_code"]], ""]
        else:
            md += [f"> 摘要提取失败：{result['texts_err'].get(m['p_code'], '未取')}", ""]
        (out_dir / f"{safe}_{m['p_code'][-6:]}.md").write_text(
            "\n".join(md), encoding="utf-8")
    with (out_dir / "_ledger.jsonl").open("w", encoding="utf-8") as fh:
        for row in LEDGER.rows:
            fh.write(json.dumps(row, ensure_ascii=False) + "\n")
    ok = (len(result["metas"]) >= 3
          and sum(1 for c in result["stats"]["texts_cjk"].values() if c >= 30) >= 3)
    summary = {"session": session, "query": query, "ok": ok,
               "stats": result["stats"], "page_facts": result["page_facts"],
               "gate": "题录>=3 且 CJK>=30 的免费文字>=3（全实测）"}
    (out_dir / "_session_summary.json").write_text(
        json.dumps(summary, ensure_ascii=False, indent=1), encoding="utf-8")
    return summary


_ACCEPT_QUERIES = [                  # 「国际工程 EPC」类查询 5 变体（wenku 战役口径）
    "国际工程EPC", "国际工程 EPC", "EPC总承包 国际工程",
    "国际工程EPC合同管理", "海外EPC项目",
]


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(description="doc88 纯 HTTP 选品+免费文字层复刻件")
    ap.add_argument("--q", help="搜索词")
    ap.add_argument("--out", help="输出目录（默认 captures/run）")
    ap.add_argument("--need", type=int, default=3, help="题录目标条数")
    ap.add_argument("--pages", type=int, default=2,
                    help="扫描页数（默认 2：need 冗余候选池，空摘要件补位）")
    ap.add_argument("--fmt", default="", help="格式过滤：PDF/DOC/PPT/XLS/TXT")
    ap.add_argument("--accept", type=int, metavar="N",
                    help="N 次独立会话贯通验收（EPC 类查询轮换）")
    args = ap.parse_args(argv)
    root = Path(__file__).resolve().parent.parent / "captures"
    if args.accept:
        n_ok = 0
        for i in range(1, int(args.accept) + 1):
            q = _ACCEPT_QUERIES[(i - 1) % len(_ACCEPT_QUERIES)]
            s = _run_session(q, root / f"accept_s{i}", need=args.need,
                             pages=args.pages, session=f"accept_s{i}")
            n_ok += 1 if s["ok"] else 0
            print(f"[{i}/{args.accept}] {'PASS' if s['ok'] else 'FAIL'} "
                  f"q={q!r} metas={s['stats']['metas']} "
                  f"texts_ok={s['stats']['texts_ok']} "
                  f"cjk={s['stats']['texts_cjk']}")
        print(f"贯通率: {n_ok}/{args.accept}")
        return 0 if n_ok == int(args.accept) else 1
    if not args.q:
        ap.print_usage()
        return 2
    out = Path(args.out) if args.out else root / "run"
    s = _run_session(args.q, out, need=args.need, pages=args.pages,
                     session="cli")
    print(json.dumps(s, ensure_ascii=False, indent=1))
    return 0 if s["ok"] else 1


if __name__ == "__main__":
    sys.exit(main())
