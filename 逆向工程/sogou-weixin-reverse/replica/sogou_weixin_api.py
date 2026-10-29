# -*- coding: utf-8 -*-
"""搜狗微信搜索 API 复刻件 — 检索/链接解析/全文提取 纯 HTTP 三合一

逆向结论 (2026-10-24, 逆向工程/sogou-weixin-reverse):
  四段全链, 零浏览器, curl_cffi impersonate=chrome 过 TLS 指纹:
    1) GET  weixin.sogou.com/            → Set-Cookie: ABTEST, SUID        (预热)
    2) GET  /weixin?type=2&query=…&page=… → Set-Cookie: SNUID (域=.sogou.com)
       结果锚 a[uigs=article_title_N] href=/link?url=…&token=<hex+SNUID+hex>(token 与会话绑定)
       账号 span.all-time-y2 / 摘要 p.txt-info / 发布 epoch timeConvert('…')
    3) GET  /link?url=…&token=… (同会话+Referer=检索页)
       → 200 GBK 页, 真实链接被拆成 url+='碎片'; 拼接得
         mp.weixin.qq.com/s?src=3&timestamp=…&ver=1&signature=… (短时效签名链)
       ※ 缺 SNUID 时该腿 302 → /antispider/ (probe2 实证), 故不可跳过第 2 段
    4) GET  签名链 (Referer=/link链) → 349KB 级文章 HTML
       msg_title / js_content / og:nickname / createTime / biz / data-src 图床链

纪律: 节流 ≥1.5s/req; antispider 命中不硬刚(抛 SogouBlockedError);
      签名链短时效 → resolve 后立即 fetch; 仅供公开检索用途。
"""
from __future__ import annotations

import argparse
import html as html_mod
import json
import random
import re
import sys
import time
from dataclasses import dataclass, field, asdict
from datetime import datetime
from pathlib import Path
from urllib.parse import quote_plus, urljoin

from curl_cffi import requests

BASE = "https://weixin.sogou.com"
_UA_H = {"Accept-Language": "zh-CN,zh;q=0.9"}
_TAG = re.compile(r"<[^>]+>|<!--.*?-->", re.S)


class SogouBlockedError(RuntimeError):
    """命中 antispider 闸门 — 自愈路径: 冷却数分钟后换新会话(新 SUID)重预热。"""


@dataclass
class ArticleHit:
    title: str
    account: str
    snippet: str
    publish_time: str          # ISO 日期(由 epoch 换算)或原始文本
    link_url: str              # 搜狗 /link 临时链(含 token, 短时效)
    token: str = ""
    resolved_url: str = ""     # mp 签名链(resolve 后填充)


@dataclass
class ArticleFull:
    url: str
    permanent_url: str
    title: str
    account: str
    publish_time: str
    text: str                  # 正文纯文本
    html: str = ""             # js_content 原始 HTML(可选留档)
    images: list = field(default_factory=list)
    biz: str = ""
    raw_len: int = 0


def _strip(s: str) -> str:
    return re.sub(r"\s+", " ", html_mod.unescape(_TAG.sub("", s))).strip()


class SogouWeixinAPI:
    def __init__(self, throttle: float = 1.5, proxy: str | None = None, verbose: bool = True):
        self.s = requests.Session(impersonate="chrome")
        self.proxies = {"http": f"http://{proxy}", "https": f"http://{proxy}"} if proxy else None
        self.throttle = throttle
        self.verbose = verbose
        self._last_req = 0.0
        self._search_url = ""

    def _get(self, url: str, referer: str = "", **kw) -> requests.Response:
        gap = self.throttle + random.uniform(0.1, 0.6)
        wait = self._last_req + gap - time.time()
        if wait > 0:
            time.sleep(wait)
        r = self.s.get(url, headers={**_UA_H, **({"Referer": referer} if referer else {})},
                       proxies=self.proxies, timeout=30, **kw)
        self._last_req = time.time()
        return r

    def _log(self, *a):
        if self.verbose:
            print(*a, file=sys.stderr)

    # ---------- 段 1+2: 检索 ----------
    def search(self, query: str, page: int = 1) -> list[ArticleHit]:
        if page == 1 and not self._search_url:            # 首检索前预热(ABTEST/SUID)
            self._get(f"{BASE}/")
            self._tick()
        url = f"{BASE}/weixin?type=2&query={quote_plus(query)}&page={page}&ie=utf8"
        referer = self._search_url or f"{BASE}/"
        r = self._get(url, referer=referer)
        self._search_url = url
        if "antispider" in str(r.url) or r.status_code != 200:
            raise SogouBlockedError(f"检索被拦: HTTP {r.status_code} → {str(r.url)[:90]}")
        h = r.text
        if "article_title_" not in h:
            return []
        hits: list[ArticleHit] = []
        # 条目块: <li id="sogou_vr_11002601_box_N"> … </li>
        #   标题锚 a[uigs=article_title_N](href 含 &amp; 须 unescape, <!--red_beg--> 高亮由 _strip 清除)
        #   摘要 p.txt-info | 账号 span.all-time-y2 | 发布时间 <script>document.write(timeConvert('epoch'))
        for blk in h.split('<li id="sogou_vr_11002601_box_')[1:]:
            m = re.search(r'<a[^>]*href="([^"]+)"[^>]*uigs="article_title_(\d+)"[^>]*>(.*?)</a>', blk, re.S)
            if not m:
                continue
            link = html_mod.unescape(urljoin(BASE, m.group(1)))
            tok = re.search(r"[?&]token=([0-9A-F]+)", link)
            acc = re.search(r'<span class="all-time-y2">(.*?)</span>', blk, re.S)
            sn = re.search(r'class="txt-info"[^>]*>(.*?)</p>', blk, re.S)
            ep = re.search(r"timeConvert\('(\d+)'", blk)
            ptime = ""
            if ep:
                try:
                    ptime = datetime.fromtimestamp(int(ep.group(1))).strftime("%Y-%m-%d")
                except Exception:
                    ptime = ep.group(1)
            hits.append(ArticleHit(title=_strip(m.group(3)),
                                   account=_strip(acc.group(1)) if acc else "",
                                   snippet=_strip(sn.group(1))[:200] if sn else "",
                                   publish_time=ptime, link_url=link,
                                   token=tok.group(1) if tok else ""))
        self._log(f"[search] {len(hits)} hits (page {page})")
        return hits

    def _tick(self):
        time.sleep(self.throttle)

    # ---------- 段 3: /link 解析 ----------
    def resolve(self, link_url: str) -> str:
        r = self._get(link_url, referer=self._search_url or f"{BASE}/", allow_redirects=False)
        if r.status_code in (301, 302, 303, 307, 308) and "antispider" in r.headers.get("location", ""):
            raise SogouBlockedError(f"/link 被闸: 会话缺 SNUID 或已过期 → {r.headers['location'][:90]}")
        txt = r.content.decode("gbk", "replace")
        frags = re.findall(r"url\s*\+=\s*'([^']*)'", txt)
        if frags:
            url = "".join(frags)
        else:                                              # 兜底: 未碎片化形态
            m = re.search(r'(https?://mp\.weixin\.qq\.com/s?[^\'"<>\\ ]+)', txt)
            url = html_mod.unescape(m.group(1)) if m else ""
        if "signature=" not in url:
            raise SogouBlockedError(f"/link 返回异常(无签名链): HTTP {r.status_code} len={len(r.content)}")
        self._log(f"[resolve] ok {url[:100]}")
        return url

    # ---------- 段 4: 全文 ----------
    def fetch_article(self, signed_url: str, referer: str = "") -> ArticleFull:
        r = self._get(signed_url, referer=referer or self._search_url or BASE)
        raw = r.content.decode("utf-8", "replace")
        def g(p):
            m = re.search(p, raw, re.S)
            return m.group(1).strip() if m else ""
        title = g(r"var\s+msg_title\s*=\s*'(.*?)'") or g(r'property="og:title"\s+content="([^"]+)"')
        account = (g(r'property="og:nickname"\s+content="([^"]+)"')
                   or g(r"var\s+nickname\s*=\s*htmlDecode\('(.*?)'\)")
                   or g(r"var\s+nickname\s*=\s*'(.*?)'")
                   or _strip(g(r'<a[^>]*id="js_name"[^>]*>(.*?)</a>')))
        ptime = (g(r"var\s+createTime\s*=\s*'(.*?)'")
                 or g(r'property="article:published_time"[^>]*content="([^"]+)"'))
        js = re.search(r'<div[^>]*id="js_content"[^>]*>(.*?)</div>\s*(?:<script|</div>)', raw, re.S)
        content_html = js.group(1) if js else ""
        text = re.sub(r"\n{2,}", "\n", _TAG.sub("", html_mod.unescape(content_html))) \
            .replace("\xa0", " ").strip()
        images = sorted(set(re.findall(r'(?:data-src|src)="(https://mmbiz\.qpic\.cn/[^"]+)"', content_html)))
        # 永久链要素: __biz/mid/idx/sn (页内多处出现, 取稳定 var 声明或参数)
        biz = g(r"var\s+biz\s*=\s*\"(.*?)\"") or g(r'__biz["\']?\s*[:=]\s*["\']?(M[A-Za-z0-9=]+)')
        mid = g(r"[?&]mid=(\d+)") or g(r"var\s+msg_mid[^;]*?(\d{9,})")
        idx = g(r"[?&]idx=(\d+)") or "1"
        sn = g(r"[?&]sn=([0-9a-f]+)")
        perm = (f"https://mp.weixin.qq.com/s?__biz={biz}&mid={mid}&idx={idx}&sn={sn}"
                if biz and mid and sn else "")
        return ArticleFull(url=str(r.url)[:300], permanent_url=perm, title=title, account=account,
                           publish_time=ptime, text=text, html=content_html, images=images,
                           biz=biz, raw_len=len(r.content))

    # ---------- 便捷: 检索并取全文 ----------
    def search_and_fetch(self, query: str, top: int = 1, page: int = 1) -> tuple[list[ArticleHit], list[ArticleFull]]:
        hits = self.search(query, page=page)
        arts = []
        for hk in hits[:top]:
            hk.resolved_url = self.resolve(hk.link_url)
            arts.append(self.fetch_article(hk.resolved_url, referer=hk.link_url))
        return hits, arts


def main() -> int:
    ap = argparse.ArgumentParser(description="搜狗微信搜索 API 复刻件 (检索/解析/全文)")
    ap.add_argument("query", nargs="+")
    ap.add_argument("--page", type=int, default=1)
    ap.add_argument("--top", type=int, default=0, help="取前 N 条全文(默认只列清单)")
    ap.add_argument("--json", action="store_true")
    ap.add_argument("--proxy", default=None)
    a = ap.parse_args()
    q = " ".join(a.query).strip()
    api = SogouWeixinAPI(proxy=a.proxy)
    try:
        hits, arts = api.search_and_fetch(q, top=a.top, page=a.page) if a.top else (api.search(q, page=a.page), [])
    except SogouBlockedError as e:
        print(f"[BLOCKED] {e}", file=sys.stderr)
        return 3
    if a.json:
        print(json.dumps({"query": q, "hits": [asdict(h) for h in hits],
                          "articles": [asdict(x) | {"html": "", "text": x.text} for x in arts]},
                         ensure_ascii=False, indent=1))
    else:
        print(f"# 搜狗微信检索 | {q} | page {a.page} | {len(hits)} 条")
        for i, h in enumerate(hits):
            print(f"\n[{i}] {h.title}\n    {h.account} · {h.publish_time}\n    {h.snippet[:80]}…\n    {h.link_url[:110]}")
        for i, x in enumerate(arts):
            print(f"\n===== 全文[{i}] {x.title} ({x.account} {x.publish_time}) 正文{x.text and len(x.text)}字 图{len(x.images)}张 =====")
            print(x.text[:600])
    return 0


if __name__ == "__main__":
    sys.exit(main())
