# -*- coding: utf-8 -*-
r"""E1 收官工具：收割一件战役相关全文 → 入 ammo_pool → judge → 点亮 by_engine。

用法: py -3 kb_factory/harvest_engine/e2e/light_by_engine.py <战役CID> <检索词> [--max-probe 8]
纪律：探针≤max-probe 发（每候选 1 发 ndview）+收割件资产腿真实发生计 harvest_audit 台账；
免费全页件（showPage==page）才收，不触签名器；kw/实质量由产线 judge 权威裁定，本件不预判过。
"""
import sys, json, time
from pathlib import Path

ROOT = Path(__file__).resolve().parents[3]
sys.path.insert(0, str(ROOT))

from kb_factory.harvest_engine.adapters.wenku import (
    WenkuDownloadAdapter, fetch_page_data,
)

CID = sys.argv[1] if len(sys.argv) > 1 else "EPC-OVERSEAS"
QUERY = sys.argv[2] if len(sys.argv) > 2 else "FIDIC 合同"
MAX_PROBE = 8

ad = WenkuDownloadAdapter()
metas = ad.search(QUERY, 12)
print(f"[search] {QUERY} -> {len(metas)} 条")

picked = None
for i, m in enumerate(metas[:MAX_PROBE]):
    did = m.extra.get("doc_id")
    if not did:
        continue
    try:
        pd = fetch_page_data(did)
    except Exception as e:
        print(f"[probe {i}] {did[:8]}… fetch fail: {e}")
        continue
    ri = (pd or {}).get("readerInfo") or {}
    page, show = ri.get("page") or ri.get("originalPage") or 0, ri.get("showPage") or 0
    hu = ri.get("htmlUrls")
    is_type3 = isinstance(hu, dict) and len(hu.get("json", [])) > 0
    print(f"[probe {i}] {did[:8]}… type3={is_type3} show/page={show}/{page} vip={m.extra.get('vip')}")
    if is_type3 and page and show == page and 0 < page <= 20:
        picked = (m, did)
        break
    time.sleep(1.0)

if not picked:
    print("[lit] 未找到免费全页 type3 件 — 如实退出（不凑数）")
    sys.exit(3)

meta, did = picked
print(f"[lit] 收割 {did} 「{meta.title[:40]}」")
result = ad.fetch_ladder(ad.plan(meta))
print(f"[lit] fetch_ladder ok={result.ok} ladder={result.ladder_used} pages={result.pages} "
      f"chars={result.chars} artifact={result.artifact_path}")
if not result.ok or not result.artifact_path:
    sys.exit(4)

pdf = Path(result.artifact_path)
import pypdfium2 as pdfium
doc = pdfium.PdfDocument(str(pdf))
text = "".join(page.get_textpage().get_text_range() for page in doc)
print(f"[lit] PDF 文本实测 {len(text.strip())} 字")

sys.path.insert(0, str(ROOT / "reforge_factory"))
import ammo_pool
rc = ammo_pool.ingest(CID, str(pdf), "kb_harvest:wenku",
                      url=meta.source_url or f"https://wenku.baidu.com/view/{did}.html")
print(f"[lit] ingest rc={rc}")
jr = ammo_pool.judge(CID, limit=100000)  # 1026补丁: 默认500只判头部, 尾行永远进不了批次
print(f"[lit] judge rc={jr}")
s = json.load(open(ROOT / "ammo_pool" / CID / "pool_state.json", encoding="utf-8"))
kh = {k: v for k, v in s.get("by_engine", {}).items() if "kb_harvest" in k}
print(f"[lit] by_engine kb_harvest = {kh}")
print("[lit] DONE" if kh else "[lit] 未点亮 — 查 judge 判因（manifest 尾行 judge_reason）")
