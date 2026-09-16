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

from paistation.cx.download_link import (  # noqa: E402
    extract_downloads,
    save_sources,
    zone_source,
)

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


def ads_sweep(inv) -> int:
    """ADS 兜底通道：全清单活文件读 Zone.Identifier（跳过云盘占位）。

    History 只见浏览器下载；微信/IM/邮件附件等落盘文件靠 ADS 补齐来源。
    """
    from paistation.sense.localfiles.triage import CLOUD_PLACEHOLDER_PREFIXES
    paths = [r[0] for r in inv.execute(
        "SELECT path FROM files WHERE status IN ('ok','pending','failed')"
        " AND secret=0").fetchall()]
    records, scanned = [], 0
    for p in paths:
        low = p.replace("\\", "/").lower()
        if any(low.startswith(x) for x in CLOUD_PLACEHOLDER_PREFIXES):
            continue  # 占位文件读流会触发拉云
        rec = zone_source(p)
        scanned += 1
        if rec:
            records.append(rec)
    n = save_sources(inv, records) if records else 0
    print(f"zone(ADS): 清扫 {scanned} 文件，带来源流 {len(records)}，"
          f"新入 {n}")
    return n


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
    total_new += ads_sweep(inv)

    n_src = inv.execute("SELECT COUNT(*) FROM file_sources").fetchone()[0]
    matched = inv.execute(
        "SELECT COUNT(*) FROM file_sources s JOIN files f ON s.path=f.path"
    ).fetchone()[0]
    zone_only = inv.execute(
        "SELECT COUNT(*) FROM file_sources z WHERE z.browser='zone' AND NOT"
        " EXISTS (SELECT 1 FROM file_sources b WHERE b.path=z.path"
        " AND b.browser!='zone')").fetchone()[0]
    print(f"\nfile_sources 共 {n_src} 条；对上 files 清单 {matched} 条；"
          f"ADS 独有来源 {zone_only} 条")
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
