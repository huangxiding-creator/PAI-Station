# -*- coding: utf-8 -*-
"""backfill_pool_rows — Phase B: 把 Phase A 收到的全文回灌到 EPC-OVERSEAS 池原线索行.

背景: 78条 kb_harvest:wenku URL-only 线索行 (source_path="", chars=0, pending/file_missing)
已有 dedup_key=u:<sha(url)>。CLI ingest --url <原URL> 会被 URL 去重挡下 ("跳过 (重复)"),
因此正确回灌 = 原行就地升级 (保 url_norm/dedup_key/tree_node/stance/engine 不变,
只补 source_path/chars/text_head/credibility 并重置 judge=pending 让 judge 重判),
并在 _pool_lock 下同步 pool_state 待审计账 (模仿 ingest 记账), 行保全不增不删.

用法: py -X utf8 backfill_pool_rows.py [--dry]
"""
from __future__ import annotations
import json, sys, time
from pathlib import Path

sys.path.insert(0, r"E:\AI-Station\reforge_factory")
import ammo_pool as AP

CAMP = "EPC-OVERSEAS"
RES_F = Path(
    r"E:\AI-Station\ammo_pool\EPC-OVERSEAS\staging\kb_harvest\wenku_full"
    r"\_backfill_results.jsonl")


def main() -> int:
    dry = "--dry" in sys.argv
    results = {}
    for l in RES_F.read_text(encoding="utf-8").splitlines():
        if l.strip():
            r = json.loads(l)
            results[r["url"]] = r
    d = AP._camp_dir(CAMP)
    mp = d / "manifest.jsonl"
    with AP._pool_lock(d):
        rows = [json.loads(x) for x in
                mp.read_text(encoding="utf-8").splitlines() if x.strip()]
        updated, missed_file, no_result, skipped_status = [], [], [], []
        for i, row in enumerate(rows):
            if (row.get("engine") != "kb_harvest:wenku"
                    or row.get("judge") != "pending"
                    or row.get("judge_reason") != "file_missing"
                    or row.get("chars") != 0):
                continue
            url = row.get("url_norm", "")
            res = results.get(url)
            if not res:
                no_result.append(url)
                continue
            if not str(res.get("status", "")).startswith("saved"):
                skipped_status.append((url, res.get("status")))
                continue
            fp = Path(res["file"])
            if not fp.is_file():
                missed_file.append(str(fp))
                continue
            text = AP.read_text_safe(fp)
            if len(text) < 50:
                missed_file.append(str(fp))
                continue
            ch = AP.count_chars(text)
            row.update(
                lead_ts=row.get("ts", ""),
                ts=time.strftime("%Y-%m-%dT%H:%M:%S"),
                source_path=str(fp),
                chars=ch,
                text_head=text[:500],
                credibility="research",
                judge="pending", judge_reason="", judge_engine="",
                wall_status="free_full" if res.get("status") == "saved_full"
                else "free_partial",
                backfill="wenku_full_api 2026-10-24 (URL-only线索回灌真全文)",
            )
            updated.append((url, ch, res.get("status")))
        if not dry:
            tmp = d / "manifest.tmp"
            tmp.write_text("\n".join(json.dumps(r, ensure_ascii=False)
                                     for r in rows) + "\n", encoding="utf-8")
            tmp.replace(mp)
            s = AP._load_state(d)
            tot = sum(ch for _, ch, _ in updated)
            ns = {**s, "pending_chars": s.get("pending_chars", 0) + tot,
                  "pending_items": s.get("pending_items", 0) + len(updated)}
            AP._save_state(d, ns)
    full = sum(1 for _, _, st in updated if st == "saved_full")
    part = len(updated) - full
    print(f"[backfill] updated={len(updated)} (full={full} partial={part}) "
          f"chars={sum(ch for _, ch, _ in updated):,}")
    print(f"[backfill] 未回灌: 无结果行={len(no_result)} 状态未saved={len(skipped_status)} "
          f"文件缺失={len(missed_file)}")
    for u, st in skipped_status[:10]:
        print(f"  skip {u[-30:]} {st}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
