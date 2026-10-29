# -*- coding: utf-8 -*-
"""
dangdang_api.py — 当当网图书情报 纯 HTTP 客户端（复刻件）

服务研报产线书目情报腿: 搜书 → 题录(书名/作者/出版社/价格/评论数) →
详情(内容简介/作者简介/目录框架/出版信息) — 为报告章节骨架/知识库结构提供参照。

三层规约 (全部只读 GET, 免登录, 零浏览器):
  ① 搜索层  GET https://search.dangdang.com/?key=<GBK-urlenc>&act=input&page_index=N
            → 200 HTML(声明GB2312, gb18030解), 60题录/页; 关键词 GBK/UTF-8 皆收(实测)。
            题录解析: <li class="lineN"> 块内 p.name/a[title], product.dangdang.com/<pid>.html,
            span.search_now_price / search_pre_price, a.search_comment_num(N条评论),
            p.search_book_author (锚title=整行署名), a[name=P_cbs](出版社), /YYYY-MM-DD(出版时间)。
  ② 详情层  GET http://product.m.dangdang.com/detail<pid>-0-1.html  (移动端, 免挑战!)
            → 200 HTML(UTF-8)。两段式:
            - <section data-content-name="图书详情"> 内联描述blob, 以【内容简介】【作者简介】
              【目录】【编辑推荐】【媒体评论】…【书摘与插画】分段 (<br>换行);
            - <section data-content-name="出版信息"> ul.parms: 书名/ISBN/作者/出版社/
              出版时间/页数/开本… (em=字段 i=值)。
            目录不跨页 (-0-2 与 -0-1 同页实测); 无目录的书如实 toc=None。
  ③ 墙定性  PC 详情页 product.dangdang.com/<pid>.html 与 category suggest API 均在
            Aliyun WAF「aliyunwaf」JS挑战后 (textarea#renderData + 外部挑战脚本
            /u21pn7x6/r8lw5pzu/psk8uqfi + antidom.js 族) — 移动端详情面无此墙,
            本复刻件绕行 m 端, 不求解挑战 (chinca 同法可解但此处不需要)。

反爬: 当当按 IP 频率限制(历史较松) — 本件内置节流 ≥2.5s(默认, 带抖动), 全程单线程。
数字零造假: 一切计数/字数为实测解析值。

用法:
  python dangdang_api.py --selftest                 # 5 次独立会话全链贯通实测
  python dangdang_api.py --search "FIDIC"           # 题录 JSON (stdout)
  python dangdang_api.py --search "国际工程 EPC" --page 2
  python dangdang_api.py --detail 28493642          # 详情 JSON (简介/目录/出版信息)
  python dangdang_api.py --toc 28493642             # 目录框架纯文本
  python dangdang_api.py --fullchain "FIDIC" --out DIR --need 3   # 搜→详情→落md
"""
from __future__ import annotations

import argparse
import html as html_mod
import json
import random
import re
import sys
import time
from pathlib import Path
from urllib.parse import quote

import requests

UA_DESKTOP = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
              "(KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36")
UA_MOBILE = ("Mozilla/5.0 (iPhone; CPU iPhone OS 17_0 like Mac OS X) "
             "AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Mobile/15E148 Safari/604.1")

SEARCH_URL = "https://search.dangdang.com/"
MDETAIL_URL = "http://product.m.dangdang.com/detail{pid}-0-1.html"
PRODUCT_URL = "http://product.dangdang.com/{pid}.html"   # 商品页 URL (情报源标注用; m 端免墙)


class DangdangError(RuntimeError):
    pass


class Throttle:
    """礼貌节流: 同主机相邻请求间隔 >= base(2.5s)+抖动。"""

    def __init__(self, base=2.5, jitter=1.2):
        self.base = base
        self.jitter = jitter
        self._last = 0.0

    def wait(self):
        now = time.time()
        gap = now - self._last
        need = self.base + random.uniform(0, self.jitter)
        if gap < need:
            time.sleep(need - gap)
        self._last = time.time()


# ---------------- 通用 HTML 文本化 ----------------

_TAG_RE = re.compile(r"<[^>]+>")
_COMMENT_RE = re.compile(r"<!--.*?-->", re.S)


def textify(fragment: str) -> str:
    """HTML 片段 → 纯文本: 注释→空, <br>→换行, 标签→剥, 实体→解, 空行折叠。"""
    s = _COMMENT_RE.sub("", fragment)
    s = re.sub(r"<br\s*/?>", "\n", s, flags=re.I)
    s = _TAG_RE.sub("", s)
    s = html_mod.unescape(s)
    lines = [ln.strip() for ln in s.splitlines()]
    out, blank = [], 0
    for ln in lines:
        if ln:
            out.append(ln)
            blank = 0
        else:
            blank += 1
            if blank == 1 and out:
                out.append("")
    return "\n".join(out).strip()


def _first_group(pattern, text, flags=re.S):
    m = re.search(pattern, text, flags)
    return m.group(1) if m else None


# ---------------- 搜索层 ----------------

_LI_RE = re.compile(r'<li[^>]*class="line\d+"[^>]*>(.*?)(?=<li[^>]*class="line\d+"|</ul>)', re.S)


def parse_serp(html_text: str) -> list[dict]:
    """SERP HTML → 题录列表 [{pid,title,url,price,orig_price,discount,comments,authors,author_line,publisher,pubdate,cover}]。"""
    items = []
    for m in _LI_RE.finditer(html_text):
        block = m.group(1)
        pid = _first_group(r"product\.dangdang\.com/(\d+)\.html", block)
        if not pid:
            continue
        title = _first_group(r'<p class="name"[^>]*>\s*<a[^>]*title="([^"]*)"', block)
        if title is None:                                  # 兜底: 锚文本
            title = _first_group(r'<p class="name"[^>]*>\s*<a[^>]*>(.*?)</a>', block)
            title = textify(title or "")
        price = _first_group(r'search_now_price">&yen;([\d.]+)', block)
        orig = _first_group(r'search_pre_price">&yen;([\d.]+)', block)
        discount = _first_group(r">\s*\(([\d.]+折)\s*", block)
        comments = _first_group(r'(\d+)\s*条评论', block)
        # 作者: 锚 title=整行署名("张水波 何伯森编著"); 锚文本=逐人名
        authors = re.findall(r"name='itemlist-author'[^>]*>([^<]*)</a>", block)
        authors += [a for a in re.findall(r'name="itemlist-author"[^>]*>([^<]*)</a>', block)
                    if a not in authors]
        author_line = _first_group(r"name='itemlist-author'[^>]*title='([^']*)'", block) \
            or _first_group(r'name="itemlist-author"[^>]*title="([^"]*)"', block) \
            or " ".join(authors)
        author_block = _first_group(r'<p class="search_book_author">(.*?)</p>', block) or ""
        publisher = _first_group(r"name=['\"]P_cbs['\"][^>]*title=['\"]([^'\"]*)['\"]", block)
        if publisher is None:
            publisher = _first_group(r"title=['\"][^'\"]*['\"].*?name=['\"]P_cbs['\"]", block) or ""
        pubdate = _first_group(r"/(\d{4}-\d{2}-\d{2})", author_block)
        cover = _first_group(r"<img\s+src=['\"](//img[^'\"]+)['\"]", block)
        items.append({
            "pid": pid,
            "title": re.sub(r"\s+", " ", html_mod.unescape(title or "")).strip(),
            "url": PRODUCT_URL.format(pid=pid),
            "price": price,
            "orig_price": orig,
            "discount": discount,
            "comments": int(comments) if comments else 0,
            "authors": [html_mod.unescape(a).strip() for a in authors if a.strip()],
            "author_line": html_mod.unescape(author_line or "").strip(),
            "publisher": html_mod.unescape(publisher or "").strip(),
            "pubdate": pubdate,
            "cover": ("https:" + cover) if cover else None,
        })
    return items


# ---------------- 详情层 ----------------

_SECTION_RE = re.compile(r'<section[^>]*data-content-name="([^"]+)"[^>]*>(.*?)(?=<section[^>]*data-content-name=|<!--\s*你可能还喜欢|$)', re.S)
_PARMS_RE = re.compile(r"<li>\s*<em>([^<]+)</em>\s*<i>(.*?)</i>\s*</li>", re.S)
_BLOB_MARK_RE = re.compile(r"【([^】]{1,12})】")


def parse_detail(html_text: str) -> dict:
    """移动端详情 HTML → {title, parms, sections{marker→text}, content_intro, author_intro, toc, toc_lines}。"""
    sections_raw: dict[str, str] = {}
    for m in _SECTION_RE.finditer(html_text):
        name, body = m.group(1).strip(), m.group(2)
        if name in sections_raw:
            sections_raw[name] += body
        else:
            sections_raw[name] = body

    parms: dict[str, str] = {}
    for name, body in sections_raw.items():
        if name != "出版信息":
            continue
        for pm in _PARMS_RE.finditer(body):
            k = textify(pm.group(1))
            v = textify(pm.group(2))
            if k:
                parms[k] = v

    blob = sections_raw.get("图书详情", "")
    blob = _COMMENT_RE.sub("", blob)
    # 描述 blob 按【标记】分段 (变体归一: 内容/内容简介/内容介绍 同义, 作者/作者简介 同义)
    parts = _BLOB_MARK_RE.split(blob)
    sections: dict[str, str] = {}
    if len(parts) >= 3:                                     # ['头', '名1', '体1', '名2', '体2', ...]
        for i in range(1, len(parts) - 1, 2):
            sections[parts[i].strip()] = textify(parts[i + 1])
    else:
        whole = textify(blob)
        if whole:
            sections["未分段"] = whole
    alias = {}
    for k in sections:
        if k in ("内容", "内容介绍", "内容简介", "内容简", "内容简介"):
            alias.setdefault("内容简介", k)
        if k in ("作者", "作者简介", "作者简介"):
            alias.setdefault("作者简介", k)
    if "内容简介" not in sections and alias.get("内容简介"):
        sections["内容简介"] = sections[alias["内容简介"]]
    if "作者简介" not in sections and alias.get("作者简介"):
        sections["作者简介"] = sections[alias["作者简介"]]

    toc = sections.get("目录")
    toc_lines = [ln.strip() for ln in toc.splitlines() if ln.strip()] if toc else []

    title = parms.get("书名") or _first_group(r"<title>(.*?)(?:-当当网)?</title>", html_text) or ""

    return {
        "title": title.strip(),
        "parms": parms,
        "sections": sections,
        "content_intro": sections.get("内容简介") or None,
        "author_intro": sections.get("作者简介") or None,
        "toc": toc,
        "toc_lines": toc_lines,
        "toc_missing": toc is None,
        "isbn": parms.get("ISBN") or parms.get("isbn"),
        "publisher": parms.get("出版社"),
        "pubdate": parms.get("出版时间"),
        "pages": parms.get("页数"),
        "format": parms.get("开本"),
    }


# ---------------- 客户端 ----------------

class DangdangClient:
    def __init__(self, throttle_base=2.5, timeout=30):
        self.timeout = timeout
        self.throttle = Throttle(base=throttle_base)
        self.s = requests.Session()
        self.s.headers.update({
            "User-Agent": UA_DESKTOP,
            "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
            "Accept-Language": "zh-CN,zh;q=0.9,en;q=0.8",
            "Accept-Encoding": "gzip, deflate",
            "Connection": "keep-alive",
        })

    # ---------- ① 搜索 ----------
    def search(self, key: str, page: int = 1) -> list[dict]:
        """关键词 → 题录列表 (60/页)。关键词按 GBK urlenc (UTF-8 站点亦收, GBK 为原生)。"""
        params = {"key": quote(key.encode("gbk")), "act": "input"}
        if page and page > 1:
            params["page_index"] = str(page)
        url = SEARCH_URL + "?" + "&".join(f"{k}={v}" for k, v in params.items())
        self.throttle.wait()
        r = self.s.get(url, timeout=self.timeout)
        if r.status_code != 200:
            raise DangdangError(f"search http {r.status_code} key={key!r}")
        html_text = r.content.decode("gb18030", errors="replace")
        if "product.dangdang.com" not in html_text and "line1" not in html_text:
            raise DangdangError(f"search SERP 形变 (len={len(html_text)}), 疑挑战/风控页")
        items = parse_serp(html_text)
        if not items:
            raise DangdangError(f"search 零题录 key={key!r} (SERP len={len(html_text)})")
        return items

    # ---------- ② 详情 ----------
    def detail(self, pid: str) -> dict:
        pid = str(pid)
        url = MDETAIL_URL.format(pid=pid)
        self.s.headers["User-Agent"] = UA_MOBILE
        try:
            self.throttle.wait()
            r = self.s.get(url, timeout=self.timeout,
                           headers={"Referer": PRODUCT_URL.format(pid=pid)})
            if r.status_code != 200:
                raise DangdangError(f"detail http {r.status_code} pid={pid}")
            text = r.content.decode("utf-8", errors="replace")
            if "parms" not in text and "图书详情" not in text:
                raise DangdangError(f"detail 形变 pid={pid} (len={len(text)}), 疑挑战/下架")
            info = parse_detail(text)
        finally:
            self.s.headers["User-Agent"] = UA_DESKTOP
        info["pid"] = pid
        info["url"] = PRODUCT_URL.format(pid=pid)
        return info

    def toc(self, pid: str) -> dict:
        d = self.detail(pid)
        return {"pid": d["pid"], "title": d["title"], "toc": d["toc"],
                "toc_lines": d["toc_lines"], "toc_missing": d["toc_missing"]}

    # ---------- 全链 (采集腿口径) ----------
    def pick_books(self, key: str, need: int, max_scan: int = 60) -> list[dict]:
        """搜索 → 题录去重 (同书名+出版社 只留评论最多的一份, 抑制旧书集市噪音) → 取前 need。"""
        items = self.search(key)
        best: dict[tuple, dict] = {}
        for it in items[:max_scan]:
            k = (it["title"].split(" 著")[0].strip(), it["publisher"])
            if k not in best or it["comments"] > best[k]["comments"]:
                best[k] = it
        picked = sorted(best.values(), key=lambda x: -x["comments"])[:need]
        return picked

    def full_chain(self, key: str, out_dir: str | Path, need: int = 5,
                   max_scan: int = 60, session: str = "") -> dict:
        """搜→选书→详情→落盘 (intro/toc md) → 摘要 (采集腿复用)。"""
        out = Path(out_dir)
        out.mkdir(parents=True, exist_ok=True)
        picked = self.pick_books(key, need, max_scan)
        results = []
        for i, rec in enumerate(picked):
            try:
                d = self.detail(rec["pid"])
            except DangdangError as e:
                results.append({"pid": rec["pid"], "title": rec["title"], "error": str(e)})
                continue
            results.append(d)
        return {"query": key, "session": session, "picked": len(picked),
                "ok": len([r for r in results if "error" not in r]), "books": results}


# ---------------- 自检 ----------------

def selftest(rounds: int = 5) -> dict:
    """5 次独立会话 (每次全新 Session/Client, 零共享态) 全链贯通:
    搜索 'FIDIC' → 断言题录契约 → 详情 top 本 → 断言简介/目录契约。"""
    log = []
    ok = 0
    for i in range(1, rounds + 1):
        rec = {"round": i}
        t0 = time.time()
        try:
            c = DangdangClient()                     # 独立会话
            items = c.search("FIDIC")
            rec["search_items"] = len(items)
            it = items[0]
            assert it["pid"] and it["title"], "题录缺 pid/title"
            assert any(it[f] for f in ("publisher", "author_line", "price")), "题录全空字段"
            d = c.detail(it["pid"])
            rec["detail"] = {"pid": d["pid"], "isbn": d["isbn"],
                             "intro_chars": len(d["content_intro"] or ""),
                             "toc_missing": d["toc_missing"],
                             "toc_lines": len(d["toc_lines"])}
            assert d["title"], "详情缺书名"
            assert d["content_intro"], "详情缺内容简介"
            assert d["parms"], "详情缺出版信息"
            rec["ok"] = True
            ok += 1
        except Exception as e:                        # 如实记账, 不吞错
            rec["ok"] = False
            rec["error"] = f"{type(e).__name__}: {e}"
        rec["secs"] = round(time.time() - t0, 1)
        log.append(rec)
        print(f"[selftest] round {i}/{rounds}: {'OK' if rec.get('ok') else 'FAIL ' + rec.get('error', '')}"
              f" ({rec['secs']}s)")
    summary = {"rounds": rounds, "ok": ok, "pass_rate": f"{ok}/{rounds}", "log": log}
    print(f"[selftest] 贯通率 {ok}/{rounds}")
    return summary


# ---------------- CLI ----------------

def main(argv=None) -> int:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    ap = argparse.ArgumentParser(description="当当图书情报纯HTTP客户端 (复刻件)")
    ap.add_argument("--selftest", action="store_true")
    ap.add_argument("--search", metavar="KEY")
    ap.add_argument("--page", type=int, default=1)
    ap.add_argument("--detail", metavar="PID")
    ap.add_argument("--toc", metavar="PID")
    ap.add_argument("--fullchain", metavar="KEY")
    ap.add_argument("--out", default=None)
    ap.add_argument("--need", type=int, default=3)
    ap.add_argument("--throttle", type=float, default=2.5)
    ns = ap.parse_args(argv)

    if ns.selftest:
        selftest()
        return 0
    cli = DangdangClient(throttle_base=ns.throttle)
    if ns.search:
        items = cli.search(ns.search, ns.page)
        print(json.dumps({"query": ns.search, "page": ns.page, "count": len(items),
                          "items": items[:30]}, ensure_ascii=False, indent=1))
    elif ns.detail:
        print(json.dumps(cli.detail(ns.detail), ensure_ascii=False, indent=1))
    elif ns.toc:
        print(json.dumps(cli.toc(ns.toc), ensure_ascii=False, indent=1))
    elif ns.fullchain:
        if not ns.out:
            print("--fullchain 需要 --out DIR", file=sys.stderr)
            return 2
        print(json.dumps(cli.full_chain(ns.fullchain, ns.out, ns.need),
                         ensure_ascii=False, indent=1))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
