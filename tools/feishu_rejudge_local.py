# -*- coding: utf-8 -*-
"""feishu_rejudge_local.py — 本地追赃腿: rejected 存量零下载重判 (1005).

根因: 旧 judge 窗口 text[:8000] + 存量班 head 窗口误杀大量真弹药
(stock:zhiku 8594件 4.16亿字 rejected 实锤). 现判定 = 全文窗口
(ammo_pool.judge_heuristic) + bge-m3 语义救回 (feishu_files_leg.SEM_TH).

翻案 = manifest 原位改行 (judge/reason/chars), 每 400 件持锁
fresh-read 原子写回 (与主腿 append 串行, 不丢行); 收尾 rebuild 重算.
"""
import json
import sys
import time
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path

sys.path.insert(0, r"E:\AI-Station\tools")
sys.path.insert(0, r"E:\AI-Station\reforge_factory")
sys.stdout.reconfigure(encoding="utf-8", errors="replace")

import ammo_pool as ap                      # noqa: E402
import feishu_files_leg as fl               # noqa: E402

CID = "EPC49-SEPDC"
CHUNK = 400
REASONS = {"stock_offtopic", "off_topic", "substance<300"}


def main() -> int:
    import urllib.request as _ur
    _rq = _ur.Request("http://127.0.0.1:11434/api/embeddings",
                      data=json.dumps({"model": "bge-m3",
                                       "prompt": fl.QUERY}).encode(),
                      headers={"Content-Type": "application/json"})
    qvec = json.loads(_ur.urlopen(_rq, timeout=120).read())["embedding"]
    print(f"[rejudge] qvec dim={len(qvec)} th={fl.SEM_TH}", flush=True)

    d = ap._camp_dir(CID)
    mp = d / "manifest.jsonl"
    kws = ap._load_state(d).get("kws", [])
    rows = [json.loads(x) for x in
            mp.read_text(encoding="utf-8").splitlines() if x.strip()]
    todo_idx = [i for i, r in enumerate(rows)
                if r.get("judge") == "rejected"
                and r.get("judge_reason") in REASONS
                and Path(r.get("source_path", "")).is_file()]
    print(f"[rejudge] 候选 {len(todo_idx)} 件 (本地文件在, kws={len(kws)})",
          flush=True)

    def extract(i):
        try:
            return i, ap.read_text_safe(Path(rows[i]["source_path"])) or ""
        except Exception:                       # noqa: BLE001 — fail-soft
            return i, ""

    n_flip = flip_chars = n_dead = 0
    flips: dict = {}
    t0 = time.time()
    ci = 0
    with ThreadPoolExecutor(4) as ex:           # 4线程抽文本, 主线程判
        for i, text in ex.map(extract, todo_idx):
            r = rows[i]
            fp = Path(r["source_path"])
            if len(text) < 50:
                n_dead += 1
            else:
                verdict, reason = ap.judge_heuristic(text, kws)
                if verdict == "rejected" and reason == "off_topic":
                    sim = fl.bge_sim(fp.stem + "\n" + text[:1500], qvec)
                    if sim >= fl.SEM_TH:
                        verdict, reason = "valid", f"semantic_rescue_{sim:.3f}"
                if verdict == "valid":
                    nr = {**r, "judge": "valid",
                          "judge_reason": f"rejudge_fulltext|{reason}",
                          "judge_engine": "heuristic+sem",
                          "chars": ap.count_chars(text)}
                    flips[(r["dedup_key"], r["source_path"])] = nr
                    n_flip += 1
                    flip_chars += nr["chars"]
            ci += 1
            if ci % CHUNK == 0:                 # 持锁 fresh-read 原位翻案
                _flush(d, mp, flips)
                print(f"[rejudge] {ci}/{len(todo_idx)} | 翻案累计 {n_flip} "
                      f"(+{flip_chars:,}字) | {time.time() - t0:.0f}s",
                      flush=True)
                flips = {}
    if flips:
        _flush(d, mp, flips)
    print(f"[rejudge] 判完: 翻案 {n_flip} (+{flip_chars:,}字) | "
          f"不可读 {n_dead} | {time.time() - t0:.0f}s → rebuild", flush=True)
    ap.rebuild(CID)
    return 0


def _flush(d: Path, mp: Path, flips: dict) -> None:
    """持锁 fresh-read 原位翻案 — 与主腿 append 串行, 追加行不丢."""
    if not flips:
        return
    with ap._pool_lock(d):
        fresh = [json.loads(x) for x in
                 mp.read_text(encoding="utf-8").splitlines() if x.strip()]
        for fr in fresh:
            k = (fr.get("dedup_key"), fr.get("source_path"))
            if k in flips and fr.get("judge") == "rejected":
                fr.update(flips[k])
        tmp = d / "manifest.tmp"
        tmp.write_text("\n".join(json.dumps(x, ensure_ascii=False)
                                 for x in fresh) + "\n", encoding="utf-8")
        tmp.replace(mp)


if __name__ == "__main__":
    sys.exit(main())
