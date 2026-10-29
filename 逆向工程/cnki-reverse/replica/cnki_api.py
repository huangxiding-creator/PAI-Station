# -*- coding: utf-8 -*-
"""知网(CNKI)检索面 API 复刻件 — 检索题录 + 免费摘要 纯 HTTP 双腿

逆向结论 (2026-10-24, 逆向工程/cnki-reverse):
  免浏览器免登录双腿, openresty 只封 /api/ 前缀(实测 403), 老版小写路径裸奔:
    1) GET  search.cnki.com.cn/Search/Result?content=<kw>   → Set-Cookie: SID_search (预热, 拿会话)
    2) POST search.cnki.com.cn/search/listresult            → 200 text/html 结果列表(~100KB/页)
       表单: Content=<kw>&Order=2&Page=<n>  (Order 2=相关度, Page 从 1 起)
       ※ 同型 /api/search/listresult 与 /api/fileterresultapi/articlefileter 均 openresty 403,
         唯 /search/listresult (前端 Page0 旧函数的调用路径) 存活 — 1024 战役四路全死的真正缺口
       列表项字段: 题名(a@title)/摘要片段(p.nr)/作者(data-key@?author=)/期刊/年期/类型/关键词
    3) GET  www.cnki.com.cn/Article/CJFDTOTAL-XXXX.htm      → 免费详情页(无需登录)
       【摘要】块 ~150字 服务端截断(免费面原样, 拿不到更长 — wap 触屏详情 404 实证)

边界纪律: 只读 GET/POST 检索; 不碰付费全文/CAJ/PDF; 不破滑块(kns8s 入口墙未动);
  节流 >=1.0s/req; 仅供公开题录/摘要检索用途。
实测: requests 2.34.2 直连即通(无 TLS 指纹墙), 2026-10-24 五独立会话验收见 captures/。
"""
from __future__ import annotations

import argparse
import io
import json
import re
import sys
import time
from dataclasses import dataclass, asdict, field

import requests
from urllib.parse import quote

BASE = "https://search.cnki.com.cn"
UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
      "(KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36")
_TAG = re.compile(r"<[^>]+>")


class CnkiBlockedError(RuntimeError):
    """openresty 403 或会话失效 — 自愈: 冷却后换新会话重预热。"""


@dataclass
class Record:
    title: str
    authors: list = field(default_factory=list)
    journal: str = ""
    year_issue: str = ""
    doc_type: str = ""
    keywords: list = field(default_factory=list)
    snippet: str = ""
    detail_url: str = ""
    abstract: str = ""


@dataclass
class SearchResult:
    keyword: str
    page: int = 1
    total_count: int = 0
    total_pages: int = 0
    records: list = field(default_factory=list)


class CnkiApi:
    LIST_RE = re.compile(
        r'<div class="list-item">(.*?)(?=<div class="list-item">|<div class="page|<script|$)', re.S)
    TOTAL_RE = re.compile(r'\$\("#totalcount"\)\.html\("(\d+)"\)')
    PAGES_RE = re.compile(r'\$\("#hidTotalPageCount"\)\.val\("(\d+)"\)')

    def __init__(self, throttle: float = 1.0, timeout: int = 25, verbose: bool = True):
        self.throttle = throttle
        self.timeout = timeout
        self.verbose = verbose
        self._t = 0.0
        self.s = requests.Session()
        self.s.headers.update({"User-Agent": UA, "Accept-Language": "zh-CN,zh;q=0.9,en;q=0.8"})

    def _tick(self):
        d = time.time() - self._t
        if d < self.throttle:
            time.sleep(self.throttle - d)
        self._t = time.time()

    def _log(self, *a):
        if self.verbose:
            print("[cnki]", *a, file=sys.stderr)

    def warmup(self, keyword: str) -> str:
        """预热: GET SERP 壳页, 换取 SID_search 会话 cookie。"""
        self._tick()
        r = self.s.get(BASE + "/Search/Result", params={"content": keyword},
                       timeout=self.timeout)
        if r.status_code != 200:
            raise CnkiBlockedError("warmup HTTP %s" % r.status_code)
        self._log("warmup ok, cookies=%s" % list(self.s.cookies.keys()))
        return r.url

    def search(self, keyword: str, page: int = 1, order: int = 2, warm: bool = True):
        """检索一页 -> SearchResult。首次调用自动预热。"""
        if warm:
            self.warmup(keyword)
        self._tick()
        r = self.s.post(
            BASE + "/search/listresult",
            data={"Content": keyword, "Order": order, "Page": page},
            headers={"Referer": BASE + "/Search/Result?content=" + quote(keyword),
                     "Origin": BASE, "X-Requested-With": "XMLHttpRequest"},
            timeout=self.timeout)
        if r.status_code == 403:
            raise CnkiBlockedError("listresult 403 (openresty) — 冷却换会话")
        if r.status_code != 200:
            raise CnkiBlockedError("listresult HTTP %s" % r.status_code)
        res = SearchResult(keyword=keyword, page=page)
        m = self.TOTAL_RE.search(r.text)
        res.total_count = int(m.group(1)) if m else 0
        m = self.PAGES_RE.search(r.text)
        res.total_pages = int(m.group(1)) if m else 0
        for chunk in self.LIST_RE.findall(r.text):
            rec = self._parse_item(chunk)
            if rec and rec.title:
                res.records.append(rec)
        self._log("search '%s' p%d: %d recs, total=%d"
                  % (keyword, page, len(res.records), res.total_count))
        return res

    def _parse_item(self, h):
        rec = Record(title="")
        m = re.search(r'<p class="tit clearfix">.*?<a href="([^"]+)"[^>]*title="([^"]*)"', h, re.S)
        if not m:
            return None
        rec.detail_url = m.group(1)
        if rec.detail_url.startswith("//"):
            rec.detail_url = "https:" + rec.detail_url
        rec.title = m.group(2).strip()
        m = re.search(r'<p class="nr">(.*?)</p>', h, re.S)
        if m:
            rec.snippet = _strip(m.group(1)).strip()
        rec.authors = [a for a in re.findall(
            r'<a data-key="([^"]*)"[^>]*href="[^"]*/Search/Result\?author=', h) if a]
        m = re.search(r"《(.*?)》", h, re.S)
        if m:
            rec.journal = _strip(m.group(1)).strip()
        if not rec.journal:
            m = re.search(r'<span title="([^"]+)">\s*[^<]*</span>', h)
            if m and m.group(1).strip():
                rec.journal = m.group(1).strip()
        m = re.search(r"<span>\s*(\d{4}年\d+期)\s*</span>", h)
        if m:
            rec.year_issue = m.group(1)
        else:
            m = re.search(r"<span>\s*(\d{4}-\d{2}-\d{2})\s*</span>", h)
            rec.year_issue = m.group(1) if m else ""
        m = re.search(r"</a>\s*<span>\s*(期刊|学位论文|会议|报纸|年鉴|专利|标准|成果|图书)\s*</span>", h)
        rec.doc_type = m.group(1) if m else ""
        if not rec.doc_type:
            m = re.search(r"<span>\s*(期刊|学位论文|会议|报纸|年鉴|专利|标准|成果|图书)\s*</span>", h)
            rec.doc_type = m.group(1) if m else ""
        if "/CCND/" in rec.detail_url:
            rec.doc_type = "报纸"  # CCND=中国重要报纸全文库, URL 实证
        inf = re.search(r'<div class="info">(.*?)</div>', h, re.S)
        if inf:
            rec.keywords = [x.strip() for x in dict.fromkeys(
                re.findall(r'<a data-key="[^"]*">([^<]+)</a>', inf.group(1))) if x.strip()]
        return rec

    def fetch_abstract(self, rec):
        """GET 知网空间免费详情页, 提取【摘要】(免费面 ~150 字截断, 服务端行为)。"""
        if not rec.detail_url:
            rec.abstract = ""
            return ""
        self._tick()
        try:
            r = self.s.get(rec.detail_url, timeout=self.timeout,
                           headers={"Referer": BASE + "/"})
        except requests.RequestException as e:
            self._log("detail err: %r" % e)
            rec.abstract = ""
            return ""
        if r.status_code != 200:
            rec.abstract = ""
            return ""
        m = re.search(r"【摘要】[：:]?\s*</?(?:font|strong|/)[^>]*>*\s*(.*?)</div>", r.text, re.S)
        if not m:
            m = re.search(r"【摘要】[：:]?\s*(.*?)(?:【|</div>|</p>)", r.text, re.S)
        if m:
            rec.abstract = _strip(m.group(1)).strip()
            return rec.abstract
        # 报纸详情页 (mall.cnki.net/magazine/article/): paragraph 块 = 导语摘要
        m = re.search(r'<div class="paragraph">\s*<div>(.*?)<span>', r.text, re.S)
        if m:
            rec.abstract = _strip(m.group(1)).strip()
        return rec.abstract

    def search_pages(self, keyword: str, pages: int = 2, order: int = 2, abstract_top: int = 0):
        """多页检索 + 可选给前 N 条补详情页摘要。"""
        all_recs = []
        for p in range(1, pages + 1):
            res = self.search(keyword, page=p, order=order, warm=(p == 1))
            all_recs.extend(res.records)
        if abstract_top > 0:
            for rec in all_recs[:abstract_top]:
                self.fetch_abstract(rec)
                self._log("abstract: %s -> %d chars" % (rec.title[:30], len(rec.abstract)))
        return all_recs


def _strip(s):
    return _TAG.sub("", s).replace("&nbsp;", " ").replace("&amp;", "&").strip()


def main():
    try:
        sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8")
    except (AttributeError, ValueError):
        pass
    ap = argparse.ArgumentParser(
        description="CNKI 检索面纯 HTTP 复刻件 (search.cnki.com.cn 老版免登录通道)")
    ap.add_argument("keyword", help="检索词, 如: 国际工程 EPC")
    ap.add_argument("--pages", type=int, default=2, help="抓取页数 (默认 2, 每页约 19-20 条)")
    ap.add_argument("--abstracts", type=int, default=5,
                    help="前 N 条补详情页免费摘要 (默认 5, 0=不取)")
    ap.add_argument("--json", help="结果落盘 JSON 路径 (可选)")
    a = ap.parse_args()

    api = CnkiApi()
    recs = api.search_pages(a.keyword, pages=a.pages, abstract_top=a.abstracts)
    out = {"keyword": a.keyword, "pages": a.pages, "fetched_records": len(recs),
           "records": [asdict(r) for r in recs]}
    for i, r in enumerate(recs):
        print("%3d. %s" % (i + 1, r.title))
        print("     %s | %s | %s | %s" % (",".join(r.authors), r.journal, r.year_issue, r.doc_type))
        text = r.abstract or r.snippet
        if text:
            print("     摘要: %s" % text[:100])
    print()
    print("== 共 %d 条题录 ==" % len(recs))
    if a.json:
        with open(a.json, "w", encoding="utf-8") as f:
            json.dump(out, f, ensure_ascii=False, indent=1)
        print("saved:", a.json)
    return 0


if __name__ == "__main__":
    sys.exit(main())
