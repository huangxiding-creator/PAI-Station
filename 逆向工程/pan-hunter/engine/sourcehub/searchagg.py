# -*- coding: utf-8 -*-
"""PAN-HUNTER L1 聚合搜索层（W1 · 2026-10-31）

9 活源（W0 实测口径）× 泛盘链提取 × 盘型红绿灯标注。
频控铁律：单源串行间隔≥2s 随机（SearchSession 内建）；直连失败→代理单发重试（即用即弃）。
记账：每发（含重试）落 JSONL；SearchLedger 全局计数（数字零造假）。
"""
from __future__ import annotations

import json
import random
import re
import threading
import time
from dataclasses import dataclass, field, asdict

from curl_cffi import requests as creq

from adapters import disk_of_url, light_of
from recipes import RECIPES, build_request

LIVE_SOURCES = ["melost", "mikuclub", "panhunt", "hunhepan", "naspt", "pansearch",
                "tg_tgsearchers7", "bixin", "miosou"]   # W0 实测 9 活源

PROXY = "http://127.0.0.1:7892"
PROXIES = {"http": PROXY, "https": PROXY}
IMPERSONATE = "chrome124"
UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
      "(KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36")
INTERVAL = (2.0, 3.5)
TIMEOUT = 15

_URL_RE = re.compile(r'https?://[^\s"\'<>\\）】\]\)）]+|magnet:\?xt=urn:btih:[A-Za-z0-9]+|ed2k://\|[^|]+\|/')
_TRIM = ".,;:!?）)】]\"'、。；！？"


@dataclass
class Hit:
    url: str
    disk: str
    light: str
    title: str = ""
    source: str = ""


class SearchLedger:
    """全线程搜索记账（含重试）。"""

    def __init__(self, jsonl_path: str | None = None):
        self.lock = threading.Lock()
        self.rows: list[dict] = []
        self.jsonl_path = jsonl_path

    def log(self, **row):
        row["ts"] = time.strftime("%H:%M:%S")
        with self.lock:
            self.rows.append(row)
            if self.jsonl_path:
                with open(self.jsonl_path, "a", encoding="utf-8") as f:
                    f.write(json.dumps(row, ensure_ascii=False) + "\n")

    @property
    def shots(self) -> int:
        return len(self.rows)

    def by_source(self) -> dict[str, int]:
        out: dict[str, int] = {}
        for r in self.rows:
            out[r["source"]] = out.get(r["source"], 0) + 1
        return out


GLOBAL_LEDGER = SearchLedger()


class SearchSession:
    """单源会话：源内串行 + 间隔≥2s 抖动 + 直连→代理重试。"""

    def __init__(self, source: str, ledger: SearchLedger | None = None):
        self.source = source
        self.recipe = next(r for r in RECIPES if r["name"] == source)
        self.ledger = ledger or GLOBAL_LEDGER
        self._last = 0.0

    def _pace(self):
        wait = self._last + random.uniform(*INTERVAL) - time.time()
        if wait > 0:
            time.sleep(wait)
        self._last = time.time()

    def _fetch(self, proxies) -> tuple[int, str]:
        method, url, headers, jb, fb = build_request(self.recipe, self._kw)
        h = {"User-Agent": UA, "Accept-Language": "zh-CN,zh;q=0.9,en;q=0.8"}
        h.update(headers)
        kw = dict(headers=h, timeout=TIMEOUT, impersonate=IMPERSONATE)
        if proxies:
            kw["proxies"] = proxies
        if method == "POST":
            if jb is not None:
                kw["json"] = jb
            elif fb is not None:
                kw["data"] = fb
            r = creq.post(url, **kw)
        else:
            r = creq.get(url, **kw)
        return r.status_code, r.text or ""

    def search(self, kw: str) -> list[Hit]:
        """关键词 → 命中（去重）。网络失败自动代理重试一发。"""
        self._kw = kw
        hits: list[Hit] = []
        for path in ("direct", "proxy_retry"):
            self._pace()
            t0 = time.time()
            try:
                status, body = self._fetch(PROXIES if path == "proxy_retry" else None)
                hits = extract_hits(body, self.source)
                self.ledger.log(source=self.source, kw=kw, path=path, status=status,
                                hits=len(hits), elapsed=round(time.time() - t0, 1))
                return hits
            except Exception as e:
                self.ledger.log(source=self.source, kw=kw, path=path, status=0,
                                hits=0, error=f"{type(e).__name__}:{str(e)[:60]}",
                                elapsed=round(time.time() - t0, 1))
                continue
        return hits


def extract_hits(body: str, source: str) -> list[Hit]:
    """响应体 → 盘链命中（泛 URL 提取 + 盘型标注 + 按 URL 去重）。"""
    out: dict[str, Hit] = {}
    norm = body.replace("\\/", "/")   # JSON 转义斜杠归一（naspt/panhunt 型）
    for m in _URL_RE.finditer(norm):
        u = m.group(0).rstrip(_TRIM)
        disk = disk_of_url(u)
        if not disk:
            continue
        if u not in out:
            out[u] = Hit(url=u, disk=disk, light=light_of(disk), source=source)
    return list(out.values())


def search_all(kw: str, sources: list[str] | None = None,
               max_workers: int = 4, ledger: SearchLedger | None = None) -> list[Hit]:
    """聚合多源并发（≤4 铁律；源内串行由 SearchSession 保）。"""
    from concurrent.futures import ThreadPoolExecutor
    ledger = ledger or GLOBAL_LEDGER
    sources = sources or LIVE_SOURCES
    found: list[Hit] = []
    lock = threading.Lock()
    sessions = {s: SearchSession(s, ledger) for s in sources}

    def _job(s):
        hs = sessions[s].search(kw)
        with lock:
            found.extend(hs)
        return hs

    with ThreadPoolExecutor(max_workers=min(max_workers, len(sources))) as pool:
        list(pool.map(_job, sources))
    # 跨源去重（URL 归一：去 query 里的密码差异不丢——保留原样，仅同 URL 去重）
    dedup: dict[str, Hit] = {}
    for h in found:
        if h.url not in dedup:
            dedup[h.url] = h
    return list(dedup.values())
