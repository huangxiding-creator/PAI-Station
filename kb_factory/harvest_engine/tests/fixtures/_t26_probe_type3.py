# -*- coding: utf-8 -*-
"""T26 实弹选件探针：syncmrecall 多取几件 → 逐一 ndview 挖 readerInfo 判型（每件1请求，≤8件）。

任务卡口径：找**类型3**（htmlUrls 对象且 json.length>0）文档，找到即收。不限 perm——
VIP 件也有免费预览页（showPage 游标如实），重组按可得页数如实落账。
产物：判型表 + 全部类型3 命件的 readerInfo 摘要落 _t26_probe_type3.json（fixtures 内，
供离线 fixture 校准；pageLoadUrl 为服务端预签名公开地址，无凭据）。
"""
import json
import sys
import time
from pathlib import Path

_KB_DIR = Path(__file__).resolve().parents[4]  # E:\AI-Station（kb_factory 包根的父目录）
sys.path.insert(0, str(_KB_DIR))

from kb_factory.channel_adapters.wenku_meta import WenkuMetaAdapter  # noqa: E402
from kb_factory.harvest_engine.adapters.wenku import (  # noqa: E402
    fetch_page_data, reader_show_pages, reader_total_pages)

OUT = Path(__file__).resolve().parent / "_t26_probe_type3.json"
QUERIES = ["水利施工组织设计", "项目管理制度", "工程监理细则"]  # 多词多取几件
MAX_PROBE = 8


def judge_type(ri: dict) -> str:
    hu = ri.get("htmlUrls")
    if isinstance(hu, dict) and len(hu.get("json") or []) > 0:
        return "type3"
    if isinstance(hu, list) and len(hu) > 0:
        return "type2"
    if isinstance(ri.get("rtcsRangeInfo") or [], list) and ri.get("rtcsRangeInfo"):
        return "type1"
    return "unknown"


def main() -> None:
    meta_ad = WenkuMetaAdapter()
    candidates, seen = [], set()
    for q in QUERIES:
        for m in meta_ad.metadata(q, 12):
            did = m.extra.get("doc_id")
            if did and did not in seen:
                seen.add(did)
                candidates.append({"doc_id": did, "title": m.title, "pages": m.pages,
                                   "perm": m.perm, "query": q})
    candidates.sort(key=lambda c: (c["pages"] or 999))  # 小文档优先（实弹提速+缺口小）
    rows, hits = [], []
    for c in candidates[:MAX_PROBE]:
        try:
            pd = fetch_page_data(c["doc_id"])
        except Exception as exc:
            rows.append({**c, "type": "error", "err": f"{type(exc).__name__}: {exc}"[:120]})
            continue
        ri = pd["readerInfo"]
        t = judge_type(ri)
        page, show = reader_total_pages(ri), reader_show_pages(ri)
        row = {**c, "type": t, "page": page, "showPage": show, "tplKey": ri.get("tplKey"),
               "json_len": len((ri.get("htmlUrls") or {}).get("json") or [])
               if isinstance(ri.get("htmlUrls"), dict) else None}
        rows.append(row)
        print(f"[probe] {c['doc_id'][:12]}… type={t} page={page} showPage={show} "
              f"tpl={row['tplKey']} json_len={row['json_len']} perm={c['perm']} "
              f"title={c['title'][:20]}")
        if t == "type3":
            hits.append({"doc_id": c["doc_id"], "title": pd.get("title"), "page": page,
                         "showPage": show, "tplKey": ri.get("tplKey"),
                         "readerInfo": ri})
        time.sleep(1.0)  # 探针节流（自律，SPEC §9）
    OUT.write_text(json.dumps({"rows": rows, "type3_hits": hits}, ensure_ascii=False, indent=1),
                   encoding="utf-8")
    print(f"[probe] done rows={len(rows)} type3_hits={len(hits)} -> {OUT.name}")


if __name__ == "__main__":
    main()
