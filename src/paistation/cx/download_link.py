# -*- coding: utf-8 -*-
"""浏览器下载链：Chromium History downloads 表 → 文件来源溯源。

K 组方案（2026-09-17）：主键是路径不是 hash——current_path 归一后对齐
inventory.files.path；site_url 给来源域名；时间 1601 微秒纪元。
浏览器库被锁，调用方先快照拷贝。
"""
from __future__ import annotations

import sqlite3
from datetime import datetime, timedelta, timezone

_EPOCH_1601 = datetime(1601, 1, 1, tzinfo=timezone.utc)


def _norm(p: str) -> str:
    s = (p or "").replace("\\", "/")
    while "//" in s:
        s = s.replace("//", "/")
    return s


def chromium_time(us) -> str | None:
    """Chromium 微秒时间戳（1601 纪元）→ 本地 'YYYY-MM-DD HH:MM'。"""
    if not us:
        return None
    dt = _EPOCH_1601 + timedelta(microseconds=int(us))
    return dt.astimezone().strftime("%Y-%m-%d %H:%M")


def extract_downloads(history_db, browser: str) -> list[dict]:
    """读快照 History 的 downloads → [{path,url,downloaded_at,browser}]。"""
    conn = sqlite3.connect(f"file:{history_db}?mode=ro", uri=True)
    try:
        rows = conn.execute(
            "SELECT current_path, target_path, start_time, site_url, tab_url"
            " FROM downloads WHERE state=1"
        ).fetchall()
    finally:
        conn.close()
    out = []
    for cur, tgt, ts, site, tab in rows:
        path = _norm(cur or tgt or "")
        if not path:
            continue
        out.append({
            "path": path,
            "url": site or tab or "",
            "downloaded_at": chromium_time(ts) or "",
            "browser": browser,
        })
    return out


def save_sources(conn: sqlite3.Connection, records: list[dict]) -> int:
    """写入/更新 file_sources 表（PK path+browser，幂等）。返回新建行数。"""
    conn.execute(
        "CREATE TABLE IF NOT EXISTS file_sources("
        "path TEXT, browser TEXT, url TEXT, downloaded_at TEXT,"
        " PRIMARY KEY(path, browser))")
    added = 0
    with conn:
        for r in records:
            cur = conn.execute(
                "INSERT OR IGNORE INTO file_sources VALUES(?,?,?,?)",
                (r["path"], r["browser"], r["url"], r["downloaded_at"]))
            added += cur.rowcount
    return added
