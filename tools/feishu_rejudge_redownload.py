# -*- coding: utf-8 -*-
"""feishu_rejudge_redownload.py — 重下追赃腿: 附件腿误杀件重下重判 (1005).

根因: 旧 sanitize 把 _token 拼在扩展名后 (xxx.pdf_Ab3fK2x9) 污染后缀,
7,414 件二进制附件全按乱码 rejected (chars=二进制假字数). 本腿按
url_norm 恢复 wiki token, 重下 (旧扩展名先验 + 魔数嗅探兜底) →
全文窗口判定 + bge 语义救回 → manifest 原位翻案 (chars 一并换真值).

下载 4 并发错峰 (主腿 16 在跑, 总 20 < 24 撞线值); 提不出的格式
(mp4/jpg/doc/ppt 等) 跳过留痕.
"""
import json
import re
import sys
import threading
import time
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path

sys.path.insert(0, r"E:\AI-Station\tools")
sys.path.insert(0, r"E:\AI-Station\reforge_factory")
sys.stdout.reconfigure(encoding="utf-8", errors="replace")

import ammo_pool as ap                      # noqa: E402
import feishu_files_leg as fl               # noqa: E402

CID = "EPC49-SEPDC"
STAGE2 = Path(r"E:\AI-Station\tools\_feishu_stage2")
CHUNK = 200
DL_CONC = 4
SKIP_EXTS = {"mp4", "jpg", "jpeg", "png", "gif", "zip", "rar", "7z",
             "xlsx", "xls", "mp3", "wav", "exe", "iso", "doc", "ppt",
             "pd", "html", "htm"}


def main() -> int:
    import urllib.request as _ur
    _rq = _ur.Request("http://127.0.0.1:11434/api/embeddings",
                      data=json.dumps({"model": "bge-m3",
                                       "prompt": fl.QUERY}).encode(),
                      headers={"Content-Type": "application/json"})
    qvec = json.loads(_ur.urlopen(_rq, timeout=120).read())["embedding"]

    d = ap._camp_dir(CID)
    mp = d / "manifest.jsonl"
    kws = ap._load_state(d).get("kws", [])
    rows = [json.loads(x) for x in
            mp.read_text(encoding="utf-8").splitlines() if x.strip()]
    todo = []
    for r in rows:
        if r.get("judge") != "rejected" \
                or r.get("engine") != "kb:lark_zhiku_file" \
                or "feishu.cn/wiki/" not in (r.get("url_norm") or ""):
            continue
        tok = r["url_norm"].rsplit("/", 1)[-1]
        m = re.search(r'\.([A-Za-z0-9]{2,5})_[A-Za-z0-9]{8}$',
                      r.get("source_path", ""))
        ext = (m.group(1).lower() if m else "")
        if ext in SKIP_EXTS:
            continue
        todo.append({"tok": tok, "ext": ext, "row": r})
    print(f"[rejudge2] 重下候选 {len(todo)} 件 (kws={len(kws)}) "
          f"th={fl.SEM_TH}", flush=True)
    STAGE2.mkdir(parents=True, exist_ok=True)

    import queue as _q
    fq: _q.Queue = _q.Queue()
    texts: dict = {}
    lock = threading.Lock()
    st = {"ok": 0, "fail": 0, "flip": 0, "chars": 0, "seen": set()}

    def dl_feed(item):
        dest = STAGE2 / f"r2_{item['tok'][:16]}{('.' + item['ext']) if item['ext'] else ''}"
        item["dest"] = str(dest)
        if fl.download(item["tok"], dest):
            fixed = fl.sniff_fix(dest)
            if fixed != dest:
                item["dest"] = str(fixed)
            fq.put(item)
        else:
            item["fail"] = True
            with lock:
                st["fail"] += 1

    def ex_worker():
        while True:
            item = fq.get()
            if item is None:
                return
            with lock:
                if item["tok"] in st["seen"]:
                    fq.task_done()
                    continue
                st["seen"].add(item["tok"])
            texts[item["dest"]] = ap.read_text_safe(
                Path(item["dest"])) or ""
            fq.task_done()

    exs = [threading.Thread(target=ex_worker, daemon=True)
           for _ in range(4)]
    for t_ in exs:
        t_.start()

    def judge_one(item):
        text = texts.get(item["dest"], "")
        r = item["row"]
        if len(text) < 50:
            return None
        verdict, reason = ap.judge_heuristic(text, kws)
        if verdict == "rejected" and reason == "off_topic":
            sim = fl.bge_sim(Path(item["dest"]).stem + "\n" + text[:1500],
                             qvec)
            if sim >= fl.SEM_TH:
                verdict, reason = "valid", f"semantic_rescue_{sim:.3f}"
        return {**r, "judge": verdict,
                "judge_reason": (f"rejudge_redl|{reason}"
                                 if verdict == "valid" else reason),
                "judge_engine": "heuristic+sem",
                "chars": ap.count_chars(text)}

    t0 = time.time()
    flips: dict = {}
    n_done = 0
    with ThreadPoolExecutor(DL_CONC) as ex:
        futs = [ex.submit(dl_feed, it) for it in todo]
        # 边下边判: 轮询 texts (抽取线程产出) + fail 标记剔除
        pending_items = list(todo)
        while pending_items or not all(f.done() for f in futs):
            time.sleep(2)
            still = []
            for it in pending_items:
                if it.get("fail"):
                    n_done += 1
                    continue
                dest = it.get("dest")
                if dest and dest in texts:
                    nr = judge_one(it)
                    if nr:
                        flips[(nr["dedup_key"], nr["source_path"])] = nr
                        if nr["judge"] == "valid":
                            st["flip"] += 1
                            st["chars"] += nr["chars"]
                    try:
                        Path(dest).unlink(missing_ok=True)
                    except OSError:
                        pass
                    n_done += 1
                    if n_done % CHUNK == 0:
                        _flush(d, mp, flips)
                        print(f"[rejudge2] {n_done}/{len(todo)} | "
                              f"翻案 {st['flip']} (+{st['chars']:,}字) "
                              f"| fail {st['fail']} | "
                              f"{time.time() - t0:.0f}s", flush=True)
                        flips = {}
                    continue
                still.append(it)
            pending_items = still
    for _ in exs:
        fq.put(None)
    for t_ in exs:
        t_.join()
    if flips:
        _flush(d, mp, flips)
    print(f"[rejudge2] 完: 判 {n_done} | 翻案 {st['flip']} "
          f"(+{st['chars']:,}字) | dl败 {st['fail']} | "
          f"{time.time() - t0:.0f}s → rebuild", flush=True)
    ap.rebuild(CID)
    return 0


def _flush(d: Path, mp: Path, flips: dict) -> None:
    """持锁 fresh-read 原位翻案 — 与主腿/本地追赃 flush 串行."""
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
