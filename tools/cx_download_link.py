# -*- coding: utf-8 -*-
"""浏览器下载链对齐：双浏览器 History 快照 → file_sources 表 → files 对齐报表。

用法：python tools/cx_download_link.py
"""
from __future__ import annotations

import glob
import shutil
import sqlite3
import sys
import tempfile
from pathlib import Path
from urllib.parse import urlparse

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

REPO = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(REPO / "src"))

from paistation.cx.download_link import extract_downloads, save_sources  # noqa: E402

INV = REPO / "data/local_index/inventory.db"
BROWSERS = {
    "edge": "C:/Users/91216/AppData/Local/Microsoft/Edge/User Data/*/History",
    "chrome": "C:/Users/91216/AppData/Local/Google/Chrome/User Data/*/History",
}


def snapshot(history: str, tmpdir: Path) -> Path:
    """History* 三件套拷临时目录（绕浏览器锁），返回快照路径。"""
    dst = tmpdir / ("h%d.db" % abs(hash(history)))
    shutil.copy2(history, dst)
    for side in glob.glob(history + "-*"):
        shutil.copy2(side, str(dst) + "-" + side.rsplit("-", 1)[-1])
    return dst


def main() -> int:
    inv = sqlite3.connect(str(INV))
    total_new = 0
    with tempfile.TemporaryDirectory() as td:
        tmpdir = Path(td)
        for browser, pattern in BROWSERS.items():
            for history in glob.glob(pattern):
                if Path(history).parent.name in ("System Profile", "Guest Profile"):
                    continue
                snap = snapshot(history, tmpdir)
                rows = extract_downloads(snap, browser)
                if rows:
                    n = save_sources(inv, rows)
                    total_new += n
                    print(f"{browser}({Path(history).parent.name}): "
                          f"{len(rows)} 条，新入 {n}")

    n_src = inv.execute("SELECT COUNT(*) FROM file_sources").fetchone()[0]
    matched = inv.execute(
        "SELECT COUNT(*) FROM file_sources s JOIN files f ON s.path=f.path"
    ).fetchone()[0]
    print(f"\nfile_sources 共 {n_src} 条；对上 files 清单 {matched} 条")
    print("\n== 来源域名 Top 10 ==")
    for host, n in inv.execute(
        "SELECT substr(url, instr(url,'://')+3), COUNT(*) c FROM file_sources "
        "WHERE url LIKE 'http%' GROUP BY substr(url,1,instr(substr(url,9),'/')+8) "
        "ORDER BY c DESC LIMIT 10"
    ).fetchall():
        print(f"{n:4d}  {host[:70]}")
    print("\n== 最新下载 8 条 ==")
    for path, url, ts in inv.execute(
        "SELECT path, url, downloaded_at FROM file_sources "
        "ORDER BY downloaded_at DESC LIMIT 8"
    ):
        print(f"{ts}  {path[:60]}  ← {urlparse(url).netloc}")
    inv.commit()
    inv.close()
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
