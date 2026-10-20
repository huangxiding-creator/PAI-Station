# -*- coding: utf-8 -*-
"""jsfdd_corpus_scan — 裁判文书全量库定向扫 (SCHED 司法鉴定战役 T1 补粮).

逐年解压 F:/wenshu_bt/裁判文书全量数据/*.zip → 扫 CSV 行命中
(司法鉴定|工程造价鉴定|工程价款|对鉴定意见|不予受理) → 案文实体化 md
→ manifest 直写 EPC-SCHED (engine=wenshu:scan)。
用法: py -X utf8 tools/jsfdd_corpus_scan.py [--years 2017,2018,2019,2020,2021] [--max-hit 6000]
"""
from __future__ import annotations

import argparse
import csv
import sys as _sys
csv.field_size_limit(_sys.maxsize)
import hashlib
import io
import json
import re
import sys
import time
import zipfile
from pathlib import Path

sys.path.insert(0, r"E:\AI-Station\reforge_factory")
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
import ammo_pool as ap  # noqa: E402

ZIPS = Path(r"F:\wenshu_bt\裁判文书全量数据（已完成）")
OUT = Path(r"E:\AI-Station\data\wenshu_sched_scan")
HIT = re.compile(r"工期延误|工期顺延|延误索赔|赶工|停工损失|工期签证|网络计划|关键线路|进度偏差|施工组织设计")


def main() -> int:
    ap_ = argparse.ArgumentParser()
    ap_.add_argument("--years", default="2017,2018,2019,2020,2021")
    ap_.add_argument("--max-hit", type=int, default=6000)
    ns = ap_.parse_args()
    OUT.mkdir(parents=True, exist_ok=True)
    camp = ap._camp_dir("EPC-SCHED")
    keys = set()
    for x in (camp / "manifest.jsonl").read_text(encoding="utf-8").splitlines():
        if x.strip():
            keys.add(json.loads(x).get("dedup_key"))
    n_hit = 0
    ts = time.strftime("%Y-%m-%dT%H:%M:%S")
    with ap._pool_lock(camp):
        with (camp / "manifest.jsonl").open("a", encoding="utf-8") as out:
            for yr in ns.years.split(","):
                z = ZIPS / f"{yr.strip()}年裁判文书数据.zip"
                if not z.exists():
                    print(f"[scan] 缺卷 {z.name}"); continue
                with zipfile.ZipFile(z) as zf:
                    names = [n for n in zf.namelist() if n.lower().endswith(".csv")]
                    for nm in names:
                        try:
                            raw = zf.read(nm)
                        except Exception:
                            continue
                        try:
                            text = raw.decode("utf-8")
                        except UnicodeDecodeError:
                            text = raw.decode("gbk", errors="ignore")
                        rdr = csv.reader(io.StringIO(text))
                        header = next(rdr, None)
                        for row in rdr:
                            joined = "\n".join(c for c in row if c)
                            if len(joined) < 500:
                                continue
                            if not HIT.search(joined[:6000]):
                                continue
                            key = hashlib.md5(joined[:4000].encode()).hexdigest()[:16]
                            if key in keys:
                                continue
                            keys.add(key)
                            title = (row[0] if row else "")[:60] or f"{yr}案{n_hit}"
                            fp = OUT / f"{yr}_{n_hit:05d}_{re.sub(r'[^\w\u4e00-\u9fff]+','_',title)[:40]}.md"
                            fp.write_text(f"# {title}\n\n> 全量库 {z.name}/{nm} 命中司法鉴定词\n\n{joined[:30000]}\n", encoding="utf-8")
                            out.write(json.dumps({
                                "ts": ts, "engine": "wenshu:scan",
                                "source_path": str(fp), "url_norm": "",
                                "chars": min(len(joined), 30000),
                                "credibility": "archive", "dedup_key": key,
                                "judge": "valid", "judge_reason": "corpus_scan_hit",
                                "judge_engine": "stock2level", "tree_node": "",
                                "stance": "support", "grade": ""}, ensure_ascii=False) + "\n")
                            n_hit += 1
                            if n_hit % 500 == 0:
                                print(f"  命中 {n_hit}", flush=True)
                            if n_hit >= ns.max_hit:
                                break
                        if n_hit >= ns.max_hit:
                            break
                print(f"[scan] {yr} 卷完, 累计命中 {n_hit}", flush=True)
                if n_hit >= ns.max_hit:
                    break
    print(f"[scan] 总命中 {n_hit} → {OUT}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
