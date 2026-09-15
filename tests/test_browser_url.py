"""M7a 浏览器 URL 流：尾缀剥离 / URL 直取 / History 副本反查 / 缓存。"""
import sqlite3

from paistation.sense.browser_url import (
    DomainResolver,
    domain_from_text,
    strip_browser_suffix,
)


def test_strip_browser_suffix():
    assert strip_browser_suffix("某页面 - Google Chrome") == "某页面"
    assert strip_browser_suffix("某页面 — Microsoft Edge") == "某页面"
    assert strip_browser_suffix("某页面 – Mozilla Firefox") == "某页面"
    assert strip_browser_suffix("无尾缀标题") == "无尾缀标题"
    assert strip_browser_suffix("") == ""


def test_domain_from_text():
    assert domain_from_text("https://www.github.com/foo/bar") == "github.com"
    assert domain_from_text("github.com") == "github.com"
    assert domain_from_text("http://Docs.Google.COM/doc") == "docs.google.com"
    assert domain_from_text("hello world") == ""
    assert domain_from_text("") == ""


def _make_history(path, rows):
    """造 Chromium urls 表 fixture（title, url, last_visit_time）。"""
    db = sqlite3.connect(str(path))
    try:
        db.execute("CREATE TABLE urls (id INTEGER PRIMARY KEY, url TEXT,"
                   " title TEXT, visit_count INTEGER,"
                   " last_visit_time INTEGER)")
        db.executemany("INSERT INTO urls (url, title, last_visit_time)"
                       " VALUES (?, ?, ?)", rows)
        db.commit()
    finally:
        db.close()  # 显式关：Windows 下句柄悬空会让 unlink 报 32


def test_resolve_via_history_copy(tmp_path):
    history = tmp_path / "History"
    _make_history(str(history), [
        ("https://news.ycombinator.com/item?id=1", "Hacker News", 100),
        ("https://github.com/pai-station", "某仓库 · GitHub", 200),
    ])
    r = DomainResolver(
        clock=lambda: 0.0,
        history_paths={"chrome": str(history)})
    # 标题含浏览器尾缀 → 剥离后按 History 反查最近访问
    assert r.resolve("chrome.exe", "某仓库 · GitHub - Google Chrome") \
        == "github.com"


def test_resolve_url_like_title_direct():
    r = DomainResolver(clock=lambda: 0.0, history_paths={})
    assert r.resolve("msedge.exe", "github.com/explore - Microsoft Edge") \
        == "github.com"


def test_resolve_non_browser_empty():
    r = DomainResolver(clock=lambda: 0.0, history_paths={})
    assert r.resolve("wps.exe", "文档 - WPS") == ""
    assert r.resolve("chrome.exe", "") == ""


def test_cache_avoids_reread(tmp_path):
    """缓存命中后即使 History 文件消失也返回缓存值（10min TTL）。"""
    history = tmp_path / "History"
    _make_history(str(history), [
        ("https://www.zhihu.com/question/1", "知乎问题", 300)])
    r = DomainResolver(clock=lambda: 0.0,
                       history_paths={"chrome": str(history)})
    assert r.resolve("chrome.exe", "知乎问题 - Google Chrome") == "zhihu.com"
    history.unlink()
    assert r.resolve("chrome.exe", "知乎问题 - Google Chrome") == "zhihu.com"
