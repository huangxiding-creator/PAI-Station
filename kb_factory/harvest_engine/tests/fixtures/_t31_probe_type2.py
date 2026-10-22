# -*- coding: utf-8 -*-
"""T31 实弹选件探针：syncmrecall 多取几件（类型2 倾向词）→ 逐一 ndview 挖 readerInfo 判型
（每件 1 请求，≤8 件）。任务卡口径：找**类型2**（htmlUrls 数组且 length>0）；类型3 占多数
需筛选。另记各件 htmlUrls 形态（png 桶有无/数组长度）——供「寻件困难→合成 htmlUrls 数组
样本」口径的可行性校准。产物：判型表 _t31_probe_type2.json（fixtures 内；URL 为服务端
预签名公开地址，无凭据）。"""
import json
import sys
import time
from pathlib import Path

_KB_DIR = Path(__file__).resolve().parents[4]  # E:\AI-Station（kb_factory 包根的父目录）
sys.path.insert(0, str(_KB_DIR))

from kb_factory.channel_adapters.wenku_meta import WenkuMetaAdapter  # noqa: E402
from kb_factory.harvest_engine.adapters.wenku import (  # noqa: E402
    fetch_page_data, judge_doc_type, reader_show_pages, reader_total_pages)

OUT = Path(__file__).resolve().parent / "_t31_probe_type2.json"
# 类型2（纯图片/扫描件/PPT 图文化）倾向词 + T26 校准词兜底
QUERIES = ["手抄报", "PPT模板", "试卷", "项目管理制度"]
MAX_PROBE = 8


def main() -> None:
    meta_ad = WenkuMetaAdapter()
    candidates, seen = [], set()
    for q in QUERIES:
        try:
            metas = meta_ad.metadata(q, 12)
        except Exception as exc:  # syncmrecall 软封前科（DEVLOG 1014）：如实记，换词续试
            print(f"[probe] search {q!r} error: {type(exc).__name__}: {exc}"[:160])
            continue
        for m in metas:
            did = m.extra.get("doc_id")
            if did and did not in seen:
                seen.add(did)
                candidates.append({"doc_id": did, "title": m.title, "pages": m.pages,
                                   "perm": m.perm, "query": q})
        if len(candidates) >= MAX_PROBE * 2:
            break
    print(f"[probe] candidates={len(candidates)}")
    candidates.sort(key=lambda c: (c["pages"] or 999))  # 小文档优先（实弹提速+缺口小）
    rows, hits = [], []
    for c in candidates[:MAX_PROBE]:
        try:
            pd = fetch_page_data(c["doc_id"])
        except Exception as exc:
            rows.append({**c, "type": "error", "err": f"{type(exc).__name__}: {exc}"[:120]})
            continue
        ri = pd["readerInfo"]
        t = judge_doc_type(ri)
        page, show = reader_total_pages(ri), reader_show_pages(ri)
        hu = ri.get("htmlUrls")
        shape = {"arr_len": len(hu) if isinstance(hu, list) else None,
                 "png_len": len(hu.get("png") or []) if isinstance(hu, dict) else None,
                 "json_len": len(hu.get("json") or []) if isinstance(hu, dict) else None}
        row = {**c, "type": t, "page": page, "showPage": show,
               "tplKey": ri.get("tplKey"), "htmlUrls_shape": shape}
        rows.append(row)
        print(f"[probe] {c['doc_id'][:12]}… type={t} page={page} showPage={show} "
              f"tpl={row['tplKey']} shape={shape} perm={c['perm']} title={c['title'][:20]}")
        if t == "type2":
            hits.append({"doc_id": c["doc_id"], "title": pd.get("title"), "page": page,
                         "showPage": show, "tplKey": ri.get("tplKey"), "readerInfo": ri})
        time.sleep(1.0)  # 探针节流（自律，SPEC §9）
    OUT.write_text(json.dumps({"rows": rows, "type2_hits": hits}, ensure_ascii=False, indent=1),
                   encoding="utf-8")
    print(f"[probe] done rows={len(rows)} type2_hits={len(hits)} -> {OUT.name}")


if __name__ == "__main__":
    main()
