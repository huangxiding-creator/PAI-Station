r"""360 安全浏览器明文库行为数据提取（360History 加密容器的官方替代视图）。

360se6 User Data/Default 下六库为 Chromium 系明文 SQLite（2026-09-21 实证）：
  Top Sites               → 常去网站排行（thumbnails）
  Network Action Predictor → 逐 host 访问频率/时间戳（预取预测器≈历史聚合视图）
  Favicons                → 访问过的域名集合（icon_mapping）
  Shortcuts / Affiliation Database / DIPS → 辅助行为数据

加密容器 360History(4f99fac8) 30 变体全败（probe_360_history.py），行为画像走本明文路线。
红线：仅行为数据；assis2.db 密码库/Cookies/Login Data 绝不碰。

用法: python extract_360_behavior.py [--out 行为画像.json]
"""

from __future__ import annotations

import argparse
import json
import shutil
import sqlite3
import sys
import tempfile
from pathlib import Path

BASE = Path.home() / "AppData/Roaming/360se6/User Data/Default"


def q(db_name: str, sql: str, params: tuple = ()) -> list[dict]:
    """复制临时库再查（原库被浏览器进程锁着，只读复制安全）。"""
    tmp = Path(tempfile.mkstemp(suffix=".db")[1])
    conn = None
    try:
        shutil.copy(BASE / db_name, tmp)
        conn = sqlite3.connect(str(tmp))
        conn.row_factory = sqlite3.Row
        return [dict(r) for r in conn.execute(sql, params)]
    finally:
        if conn:
            conn.close()
        try:
            tmp.unlink()
        except OSError:
            pass


def top_sites() -> list[dict]:
    cols = {r["name"] for r in q("Top Sites", "PRAGMA table_info(thumbnails)")}
    order = "redirects DESC" if "redirects" in cols else "rowid"
    rows = q("Top Sites", f"SELECT * FROM thumbnails ORDER BY {order}")
    keep = [c for c in ("url", "title", "redirects", "last_updated") if c in cols]
    return [{c: r.get(c) for c in keep} for r in rows if r.get("url")]


def nap_hosts() -> list[dict]:
    """Network Action Predictor：host_redirect 表有 visit_count/launch_count。"""
    rows = q("Network Action Predictor",
             "SELECT * FROM resource_prefetch_predictor_host_redirect LIMIT 2000")
    return rows


def nap_origins() -> list[dict]:
    rows = q("Network Action Predictor",
             "SELECT * FROM resource_prefetch_predictor_origin LIMIT 2000")
    return rows


def favicon_domains() -> list[str]:
    rows = q("Favicons", "SELECT page_url FROM icon_mapping")
    seen, out = set(), []
    for r in rows:
        url = (r.get("page_url") or "").strip()
        if url and url not in seen:
            seen.add(url)
            out.append(url)
    return out


def shortcuts() -> list[dict]:
    return q("Shortcuts", "SELECT * FROM omni_box_shortcuts LIMIT 500")


def main() -> int:
    if hasattr(sys.stdout, "reconfigure"):
        sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    profile: dict = {}
    for key, fn in [("top_sites", top_sites), ("nap_hosts", nap_hosts),
                    ("nap_origins", nap_origins), ("favicon_pages", favicon_domains),
                    ("omnibox_shortcuts", shortcuts)]:
        try:
            profile[key] = fn()
            print(f"[ok] {key}: {len(profile[key])} 行")
        except Exception as exc:  # noqa: BLE001
            profile[key] = []
            print(f"[fail] {key}: {exc}")
    parser = argparse.ArgumentParser()
    parser.add_argument("--out", default=str(Path(__file__).parent / "behavior_360.json"))
    args = parser.parse_args()
    Path(args.out).write_text(
        json.dumps(profile, ensure_ascii=False, indent=1, default=lambda o: o.hex() if isinstance(o, (bytes, bytearray)) else str(o)),
        encoding="utf-8")
    print(f"[done] -> {args.out}")
    # 摘要
    ts = profile.get("top_sites", [])
    if ts:
        print("--- Top Sites 前十 ---")
        for t in ts[:10]:
            print(f"  {t.get('weight', 0):>4}  {t.get('title', '')[:30]}  {t.get('url', '')[:60]}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
