"""M7a 浏览器 URL 流（银甲虫招式：标题→History SQLite 只读副本反查域名）。

免装浏览器扩展即得 URL 信号（ActivityWatch 需扩展，我们不需）。
Chrome/Edge/Brave 同 Chromium schema；Firefox 无 SQLite 读取路径（仅标题
域名直取）。History 文件被运行中浏览器锁住 → 复制到临时文件再只读。
缓存 10 分钟（银甲虫 domainCache 同款）。全程只读用户文件（红线）。
"""
from __future__ import annotations

import os
import re
import shutil
import sqlite3
import tempfile
from urllib.parse import urlparse

_BROWSER_SUFFIX = re.compile(
    r"\s*[-–—]\s*(Google Chrome|Microsoft Edge|Mozilla Firefox|"
    r"Chromium|Brave|Opera|Vivaldi|Arc)$", re.IGNORECASE)
_URLISH = re.compile(r"^(https?://)?([\w-]+\.)+[a-z]{2,}(/\S*)?$",
                     re.IGNORECASE)

# 进程名 → History 相对路径（Chromium 系同 schema）
_HISTORY_PATHS = {
    "chrome": os.path.join("Google", "Chrome", "User Data", "Default",
                           "History"),
    "msedge": os.path.join("Microsoft", "Edge", "User Data", "Default",
                           "History"),
    "brave": os.path.join("BraveSoftware", "Brave-Browser", "User Data",
                          "Default", "History"),
}
_BROWSER_PROCESSES = frozenset(_HISTORY_PATHS) | {"firefox"}


def strip_browser_suffix(title: str) -> str:
    """去掉「页面标题 - Google Chrome」尾缀 → 纯页面标题。"""
    return _BROWSER_SUFFIX.sub("", (title or "").strip()).strip()


def looks_like_url(text: str) -> bool:
    """文本是否形如 URL（剪贴板密码形状判定的豁免项）。"""
    return bool(_URLISH.match((text or "").strip()))


def domain_from_text(text: str) -> str:
    """文本若形如 URL → 域名（去 www.）；否则空串。"""
    t = (text or "").strip()
    if not looks_like_url(t):
        return ""
    if "://" not in t:
        t = "http://" + t
    try:
        host = urlparse(t).hostname or ""
    except ValueError:
        return ""
    return host[4:] if host.lower().startswith("www.") else host.lower()


def lookup_history_title(history_path: str, title: str) -> str:
    """History SQLite（副本）按标题反查最近 URL → 域名；失败空串。"""
    if not title or not os.path.exists(history_path):
        return ""
    fd, tmp = tempfile.mkstemp(suffix=".sqlite")
    os.close(fd)
    try:
        shutil.copyfile(history_path, tmp)
        conn = sqlite3.connect(tmp)
        try:
            row = conn.execute(
                "SELECT url FROM urls WHERE title = ? OR title LIKE ? "
                "ORDER BY last_visit_time DESC LIMIT 1",
                (title, f"%{title}%")).fetchone()
        finally:
            conn.close()  # 显式关：Windows 下句柄不闭则临时副本删不掉
        if not row or not row[0]:
            return ""
        return domain_from_text(row[0])
    except Exception:  # noqa: BLE001 - 文件锁/损坏/非 Windows
        return ""
    finally:
        try:
            os.unlink(tmp)
        except OSError:
            pass


class DomainResolver:
    """标题→域名解析：URL 直取 → History 反查 → 10 分钟缓存。"""

    def __init__(self, ttl_sec: float = 600.0, clock=None,
                 history_paths: dict | None = None):
        self._ttl = ttl_sec
        self._mono = clock or _default_clock
        self._paths = history_paths or {
            key: os.path.join(os.environ.get("LOCALAPPDATA", ""), rel)
            for key, rel in _HISTORY_PATHS.items()}
        self._cache: dict[str, tuple[str, float]] = {}

    def resolve(self, browser_process: str, title: str) -> str:
        """浏览器进程名+窗口标题 → 域名（非浏览器/查不到 → 空串）。"""
        browser = (browser_process or "").lower().replace(".exe", "")
        if browser not in _BROWSER_PROCESSES:
            return ""
        page = strip_browser_suffix(title)
        if not page:
            return ""
        direct = domain_from_text(page)
        if direct:
            return self._cached("direct:" + page, direct)
        hit = self._cache.get(page)
        if hit and self._mono() - hit[1] < self._ttl:
            return hit[0]
        domain = ""
        path = self._paths.get(browser)
        if path:
            domain = lookup_history_title(path, page)
        return self._cached(page, domain)

    def _cached(self, key: str, domain: str) -> str:
        self._cache[key] = (domain, self._mono())
        return domain


def _default_clock() -> float:
    import time
    return time.monotonic()
