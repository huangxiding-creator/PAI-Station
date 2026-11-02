# -*- coding: utf-8 -*-
"""lumpsum_e3_columns — E3 官方栏目页直抓法 (site:检索空后的换法, 1102).

思路: 不靠搜索引擎 site: 语法(反爬空回), 直接 jina reader 抓官方栏目列表页
→ 正则提文章链接(官方域内) → 逐篇抓全文(≥400字) → 入池(engine=website:official)
→ 直挂对应 E3 tree_node. 栏目=真实存在的公开统计/文件栏目.
用法: py -X utf8 lumpsum_e3_columns.py [--dry]
"""
from __future__ import annotations

import argparse
import json
import re
import subprocess
import sys
import time
import urllib.request
from pathlib import Path
from urllib.parse import urljoin, urlsplit

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
REPO = Path(r"E:\AI-Station")
POOL = REPO / "ammo_pool" / "EPC-LUMPSUM"
MANIFEST = POOL / "manifest.jsonl"
HD = POOL / "e3_columns"
HDR = {"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64)"}

#: 栏目页 → E3 挂靠 (栏目为官方公开统计/文件/通报列表页)
COLUMNS = [
    ("Q4-E3", "http://www.mohurd.gov.cn/gongkai/fdzdgknr/tjgb/index.html",
     "mohurd.gov.cn"),
    ("Q6-E3", "http://www.mohurd.gov.cn/gongkai/fdzdgknr/tjgb/index.html",
     "mohurd.gov.cn"),
    ("Q16-E3", "http://www.mohurd.gov.cn/gongkai/fdzdgknr/tjgb/index.html",
     "mohurd.gov.cn"),
    ("Q12-E3", "http://www.mohurd.gov.cn/gongkai/fdzdgknr/tzgg/index.html",
     "mohurd.gov.cn"),
    ("Q13-E3", "http://www.mohurd.gov.cn/gongkai/fdzdgknr/tzgg/index.html",
     "mohurd.gov.cn"),
    ("Q23-E3", "https://www.mofcom.gov.cn/zwgk/tjsj/index.html",
     "mofcom.gov.cn"),
    ("Q24-E3", "https://www.mofcom.gov.cn/zwgk/tjsj/index.html",
     "mofcom.gov.cn"),
    ("Q21-E3", "http://www.mohrss.gov.cn/xxgk2020/fdzdgknr/index.html",
     "mohrss.gov.cn"),
    ("Q14-E3", "https://www.court.gov.cn/zixun-gengduo.html",
     "court.gov.cn"),
    ("Q22-E3", "https://www.court.gov.cn/zixun-gengduo.html",
     "court.gov.cn"),
]


def fetch(url: str, limit=200_000) -> str:
    try:
        req = urllib.request.Request("https://r.jina.ai/" + url, headers=HDR)
        with urllib.request.urlopen(req, timeout=45) as r:
            return r.read(limit).decode("utf-8", "replace")
    except Exception:  # noqa: BLE001
        # 直连兜底
        try:
            req = urllib.request.Request(url, headers=HDR)
            with urllib.request.urlopen(req, timeout=30) as r:
                return r.read(limit).decode("utf-8", "replace")
        except Exception:  # noqa: BLE001
            return ""


def article_links(page_text: str, base: str, domain: str) -> list[str]:
    urls = re.findall("https?://" + re.escape(domain) + r"[^\s)\]}\"'<>]+", page_text)
    seen, out = set(), []
    for u in urls:
        u = u.rstrip(".,;")
        if u.endswith((".html", ".htm", ".shtml")) and u not in seen:
            seen.add(u)
            out.append(u)
    return out[:4]


def sh(cmd, timeout=120):
    r = subprocess.run(cmd, capture_output=True, text=True,
                       encoding="utf-8", errors="replace", timeout=timeout)
    return (r.stdout or "") + (r.stderr or "")


def tag(path: Path, eei: str) -> bool:
    rows = [json.loads(x) for x in MANIFEST.read_text(encoding="utf-8").splitlines() if x.strip()]
    hit = False
    for r in rows:
        if str(path) == str(r.get("source_path", "")) and not r.get("tree_node"):
            r["tree_node"] = eei
            hit = True
    if hit:
        MANIFEST.write_text("\n".join(json.dumps(r, ensure_ascii=False) for r in rows) + "\n",
                            encoding="utf-8")
    return hit


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--dry", action="store_true")
    ns = ap.parse_args()
    HD.mkdir(exist_ok=True)
    n_ok = 0
    col_cache = {}
    for eei, col_url, domain in COLUMNS:
        if col_url not in col_cache:
            col_cache[col_url] = fetch(col_url)
            time.sleep(1)
        links = article_links(col_cache.get(col_url, ""), col_url, domain)
        got = 0
        for u in links[:2]:
            full = fetch(u)
            if len(full) < 400:
                continue
            f = HD / f"{eei}_{urlsplit(u).path.strip('/').replace('/', '_')[-46:] or 'art'}.md"
            f.write_text(f"# 官方栏目文章: {u}\n\n(E3权威位直抓, 栏目={col_url})\n\n{full}\n",
                         encoding="utf-8")
            if ns.dry:
                got += 1
                n_ok += 1
                continue
            r = sh(["py", "-X", "utf8", str(REPO / "reforge_factory" / "ammo_pool.py"),
                    "ingest", "EPC-LUMPSUM", "--file", str(f),
                    "--engine", "website:official"])
            if "[pool]" in r and tag(f, eei):
                got += 1
                n_ok += 1
            time.sleep(1)
        print(f"  {eei} 栏目链接{len(links)} +入池{got}", flush=True)
    print(f"[e3-columns] 官方栏目直抓入池: {n_ok} ({'DRY' if ns.dry else '已写'})")
    return 0


if __name__ == "__main__":
    sys.exit(main())
