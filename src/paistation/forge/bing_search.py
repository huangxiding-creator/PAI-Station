"""Bing 网页检索器（M9.5 渠道件）：国内可达、零登录、零个人账号风险。

账号安全说明：cn.bing.com 公开搜索页，无需登录，不属于个人账号采集
（账号安全红线不适用）；仍配礼貌节流（调用方控制）。
解析策略：b_algo 块 → 首个外链（URL）+ 块内长文本段（标题/摘要）。
"""
from __future__ import annotations

import re
import urllib.parse
import urllib.request
from dataclasses import dataclass

_UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
       "(KHTML, like Gecko) Chrome/126.0 Safari/537.36")
_BLOCK = re.compile(r'<li class="b_algo".*?</li>', re.S)
_LINK = re.compile(r'<a[^>]+href="(https?://[^"]+)"[^>]*>', re.S)
_TEXT = re.compile(r">([^<>]{12,200})<")
_TAG = re.compile(r"<[^>]+>")


@dataclass(frozen=True)
class SearchResult:
    title: str
    url: str
    snippet: str
    source: str = "bing"


def _clean(text: str) -> str:
    text = _TAG.sub("", text)
    return (text.replace("&ensp;", " ").replace("&#0183;", "·")
            .replace("&amp;", "&").replace("&quot;", '"')
            .replace("&#39;", "'").strip())


def parse_html(html: str, max_results: int = 8) -> list[dict]:
    """解析 Bing 结果页 → [{title,url,snippet,source}]（纯函数，可测）。"""
    results: list[dict] = []
    seen: set[str] = set()
    for block in _BLOCK.findall(html or ""):
        links = _LINK.findall(block)
        url = next((u for u in links
                    if "bing.com" not in urllib.parse.urlparse(u).netloc), "")
        if not url or url in seen:
            continue
        seen.add(url)
        texts = [_clean(t) for t in _TEXT.findall(block)]
        texts = [t for t in texts if t and "›" not in t]
        title = texts[0] if texts else url
        snippet = texts[1] if len(texts) > 1 else ""
        results.append({"title": title[:120], "url": url,
                        "snippet": snippet[:300], "source": "bing"})
        if len(results) >= max_results:
            break
    return results


def search(query: str, max_results: int = 8, timeout: int = 20) -> list[dict]:
    """检索并解析；网络/解析异常返回空表（调用方如实降级）。"""
    q = urllib.parse.quote(query)
    req = urllib.request.Request(
        f"https://cn.bing.com/search?q={q}&count=10&mkt=zh-CN",
        headers={"User-Agent": _UA, "Accept-Language": "zh-CN,zh;q=0.9"})
    try:
        with urllib.request.urlopen(req, timeout=timeout) as resp:
            html = resp.read().decode("utf-8", "ignore")
    except (OSError, urllib.error.URLError):
        return []
    return parse_html(html, max_results)
