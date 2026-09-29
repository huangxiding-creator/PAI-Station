# -*- coding: utf-8 -*-
"""秘塔网页会话管理——cookie + meta-token 持久化与刷新。

会话事实（2026-09-28 实弹验证）：
- 工程大脑 KB 线走网页会话（Cookie + <meta id="meta-token">），烧网页积分池
- metaso 网关按 TLS 指纹放行 → 一律 curl_cffi impersonate='chrome'
- 刷新：GET subject 页 → HTML 里 parse meta-token + Set-Cookie 合并
"""
from __future__ import annotations

import json
import re
import threading
import time
from typing import Optional

from curl_cffi import requests as cr

from . import config


class KbSessionError(RuntimeError):
    """会话失效，需要人工/登录流程恢复（P0 监控告警，P1 自动重登）。"""


_LOCK = threading.Lock()
_cached: Optional[dict] = None        # {cookie, token, updated_at}
_last_refresh = 0.0


def _read_file() -> Optional[dict]:
    if not config.KB_SESSION_FILE.exists():
        return None
    try:
        return json.loads(config.KB_SESSION_FILE.read_text(encoding="utf-8"))
    except Exception:
        return None


def _write_file(sess: dict) -> None:
    config.KB_SESSION_FILE.parent.mkdir(parents=True, exist_ok=True)
    config.KB_SESSION_FILE.write_text(
        json.dumps(sess, ensure_ascii=False, indent=2), encoding="utf-8"
    )


def get_session(force_refresh: bool = False) -> dict:
    """返回 {cookie, token}。文件 → 缓存 → 在线刷新。"""
    global _cached, _last_refresh
    with _LOCK:
        if force_refresh or _cached is None:
            _cached = _read_file()
        if _cached and not force_refresh:
            return _cached
        refreshed = _refresh_online()
        _cached = refreshed
        _write_file(refreshed)
        _last_refresh = time.time()
        return _cached


def _refresh_online() -> dict:
    """访问 subject 页解析 meta-token 并收集 cookie。"""
    try:
        r = cr.get(config.KB_PAGE_URL, impersonate="chrome", timeout=30)
        html = r.text
        m = re.search(r'<meta[^>]*id="meta-token"[^>]*content="([^"]+)"', html)
        if not m:
            m = re.search(r'<meta[^>]*content="([^"]+)"[^>]*id="meta-token"', html)
        if not m:
            raise KbSessionError("页面无 meta-token（未登录或改版）")
        cookie = "; ".join(f"{c.name}={c.value}" for c in r.cookies.jar) or _file_cookie()
        return {"cookie": cookie, "token": m.group(1), "updated_at": time.strftime("%Y-%m-%d %H:%M:%S")}
    except KbSessionError:
        raise
    except Exception as exc:  # noqa: BLE001
        raise KbSessionError(f"在线刷新失败: {exc}") from exc


def _file_cookie() -> str:
    sess = _read_file()
    return (sess or {}).get("cookie", "")


def invalidate() -> None:
    """标记会话失效（401/403/intro 页时调用，下次 get 强制在线刷新）。"""
    global _cached
    with _LOCK:
        _cached = None


def stale_seconds() -> float:
    """会话年龄（秒）；无会话返回 inf。"""
    global _cached
    if _cached is None:
        _cached = _read_file()
    if not _cached:
        return float("inf")
    ts = _cached.get("updated_at")
    if not ts:
        return float("inf")
    try:
        from datetime import datetime
        dt = datetime.strptime(ts, "%Y-%m-%d %H:%M:%S")
        return max(0.0, time.time() - dt.timestamp())
    except Exception:
        return float("inf")
