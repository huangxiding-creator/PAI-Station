# -*- coding: utf-8 -*-
"""T35 实弹探针：找类型1（rtcsRangeInfo>0，editor/XML 桶清单在身）文档。

口径对齐 T26/T31 探针（fixtures/_t31_probe_type2.py 同型）：syncmrecall 多词取候选 →
逐一 ndview 挖 readerInfo 判型（每件 1 请求，≤12 件），命中即收。产物落
fixtures/_t35_probe_type1.json（证据固化；type1 倾向词=新式在线编辑文档语境）。
"""
import json
import sys
import time
from pathlib import Path

_KB_DIR = Path(__file__).resolve().parents[3]  # kb_factory/（fixtures 深一层）
if (_KB_DIR / "__init__.py").exists():      # 主树：kb_factory 为包，仓根上路径
    sys.path.insert(0, str(_KB_DIR.parent))
else:                                        # worktree：顶层名回退（tests 同法）
    sys.path.insert(0, str(_KB_DIR))
    if not (_KB_DIR / "channel_adapters" / "base.py").exists():
        for _anc in _KB_DIR.parents:
            if (_anc / "kb_factory" / "channel_adapters" / "base.py").exists():
                sys.path.insert(1, str(_anc))
                break

try:  # 主树正名 kb_factory.*；worktree 回退顶层名（tests 双导入法同型）
    from kb_factory.harvest_engine.adapters.wenku import fetch_page_data, judge_doc_type
    from kb_factory.channel_adapters.wenku_meta import WenkuMetaAdapter
except ImportError:
    from harvest_engine.adapters.wenku import fetch_page_data, judge_doc_type
    from channel_adapters.wenku_meta import WenkuMetaAdapter

QUERIES = ("智能文档", "在线文档", "AI 生成", "协作文档", "新品发布", "数字化转型", "OKR", "周报模板")
MAX_PROBE = 24
OUT = Path(__file__).resolve().parent / "_t35_probe_type1.json"


def main() -> int:
    candidates, seen = [], set()
    for query in QUERIES:
        try:
            metas = WenkuMetaAdapter().metadata(query, 12)
        except Exception as exc:
            print(f"[probe] syncmrecall 软封/失败: {query}: {exc}")
            continue
        for m in metas:
            did = m.extra.get("doc_id")
            if did and did not in seen:
                seen.add(did)
                candidates.append({"doc_id": did, "title": m.title, "pages": m.pages})
    print(f"[probe] candidates={len(candidates)}")
    found_full, found_partial, rest = [], [], []
    for i, cand in enumerate(candidates[:MAX_PROBE]):
        try:
            page_data = fetch_page_data(cand["doc_id"])
        except Exception as exc:
            print(f"[probe] {i + 1}/{MAX_PROBE} {cand['doc_id'][:12]}… 挖取失败: {str(exc)[:80]}")
            time.sleep(1.0)
            continue
        ri = page_data["readerInfo"]
        dt = judge_doc_type(ri)
        rtcs = ri.get("rtcsRangeInfo") or []
        n_page = ri.get("page") or ri.get("originalPage") or ri.get("freePage") or 0
        n_show = ri.get("showPage") or 0
        rec = {"doc_id": cand["doc_id"], "title": str(page_data.get("title") or cand["title"]),
               "type": dt, "page": n_page, "showPage": n_show,
               "rtcs_len": len(rtcs), "tplKey": ri.get("tplKey"),
               "bucketNum": ri.get("bucketNum"), "rsign": ri.get("rsign"),
               "md5sum": ri.get("md5sum"),
               "rtcs_head": rtcs[:3]}
        print(f"[probe] {i + 1}/{MAX_PROBE} {cand['doc_id'][:12]}… type={dt} "
              f"page={n_page} showPage={n_show} rtcs={len(rtcs)}")
        if dt == "type1":
            (found_full if n_show >= n_page > 0 else found_partial).append(rec)
            if found_full:
                break
        else:
            rest.append(rec)
        time.sleep(1.0)
    payload = {"ts": time.strftime("%Y-%m-%dT%H:%M:%S"), "probed": min(len(candidates), MAX_PROBE),
               "candidates": len(candidates), "found_full": found_full,
               "found_partial": found_partial, "others": rest}
    OUT.write_text(json.dumps(payload, ensure_ascii=False, indent=1), encoding="utf-8")
    print(f"[probe] full={len(found_full)} partial={len(found_partial)} → {OUT.name}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
