# -*- coding: utf-8 -*-
"""feishu_wiki_zongbao.py — 飞书总包智库知识库盘点器 (1004用户令接入).

phase=inventory: BFS 下钻 wiki 空间全节点树 → feishu_zongbao_nodes.json
phase=fetch:     逐 docx 节点取正文 → 02/54_飞书智库/ 一件一md
                 + 两级强相关判定直写 manifest (engine=feishu_zhiku)

空间: 总包智库 7689289338592431383 (四库体系) 优先;
      姊妹库(全量版/AI问答) --space-id 可指定复用本件.
节流 0.6s/请求; 断点续跑(已落盘跳过); 归档节点跳过.
"""
import json
import os
import subprocess
import sys
import time
from pathlib import Path

LARK = (r"C:\Users\91216\AppData\Roaming\npm\node_modules"
        r"\@larksuite\cli\bin\lark-cli.exe")
OUT_JSON = Path(r"E:\AI-Station\tools\feishu_zongbao_nodes.json")
BATTLE = (Path(r"E:\AI-Station\ResearchFactory-Eng\ResearchTopics")
          / "《四川电力设计咨询有限责任公司怎么干EPC总承包？》")
DOCS_DIR = [d for d in BATTLE.iterdir() if d.name.startswith("02")][0] \
    / "54_飞书智库"

sys.path.insert(0, r"E:\AI-Station\Auto_Manus")
sys.path.insert(0, r"E:\AI-Station\reforge_factory")

DEFAULT_SPACE = "7689289338592431383"  # 总包智库
SKIP_TITLE = ("归档",)


def lark(*args: str, timeout: int = 60, cwd: str | None = None) -> dict:
    env = {**os.environ, "LARKSUITE_CLI_NO_UPDATE_NOTIFIER": "1"}
    cp = subprocess.run(
        [str(LARK), *args, "--as", "user", "--json"],
        capture_output=True, text=True, encoding="utf-8", timeout=timeout,
        env=env, cwd=cwd,
    )
    return json.loads(cp.stdout or "{}")


def inventory(space: str, threads: int = 6) -> int:
    """并行 BFS 下钻 (单线程0.6s节流×5.5万节点=17h不可接受; 6线程+增量落盘)."""
    import threading
    from collections import deque
    lock = threading.Lock()
    seen: set = set()
    ROOT = "__root__"                      # 哨兵: 与真 token(None=根)区分, 防撞值死等
    queue: deque = deque([ROOT])
    nodes: list = []
    st = {"listed": 0, "inflight": 0}

    def worker(wid: int) -> None:
        while True:
            with lock:
                if not queue and st["inflight"] == 0:
                    return                 # 无任务且无在途 → 全局完
                if not queue:
                    wait = True            # 等在途产出新任务
                else:
                    wait = False
                    head = queue.popleft()
                    if head != ROOT:
                        if head in seen:
                            continue       # 已下钻过 (不动 inflight)
                        seen.add(head)
                    st["inflight"] += 1    # 领任务同锁块标记, 杜绝空窗
            if wait:
                time.sleep(0.15)
                continue
            token = None if head == ROOT else head  # None=根列表API形态
            print(f"[w{wid}] 下钻 {'ROOT' if token is None else token[:14]}", flush=True)
            page = None
            fails = 0
            while True:                    # 翻页
                args = ["wiki", "+node-list", "--space-id", space,
                        "--page-size", "50"]
                if token:  # token None=根列表; 其余=子节点下钻
                    args += ["--parent-node-token", token]
                if page:
                    args += ["--page-token", page]
                try:
                    d = lark(*args)
                    fails = 0
                except Exception as e:                     # noqa: BLE001
                    fails += 1
                    if fails >= 5:
                        break               # 该节点连败放弃, 防死循环
                    time.sleep(2)
                    continue
                if not (d.get("data") or {}).get("nodes") \
                        and token is None and page is None:
                    print(f"[debug] ROOT回包: {json.dumps(d, ensure_ascii=False)[:300]}", flush=True)
                data = d.get("data", {})
                batch = data.get("items") or data.get("nodes") or []
                add_q = []
                for n in batch:
                    with lock:
                        nodes.append(n)
                        st["listed"] += 1
                    # 坑: node-list 回包无 has_child 字段 — 无条件入队靠叶子空回包收敛
                    if not any(s in (n.get("title") or "") for s in SKIP_TITLE):
                        add_q.append(n.get("node_token"))
                with lock:
                    queue.extend(add_q)
                page = data.get("page_token") if data.get("has_more") else None
                if not page:
                    break
                time.sleep(0.3)
            with lock:
                st["inflight"] -= 1
            time.sleep(0.15)
            if wid == 0 and st["listed"] % 300 < 50:
                print(f"[inventory] 累计 {st['listed']} 节点 | "
                      f"队列 {len(queue)} 在途 {st['inflight']}", flush=True)

    t0 = time.time()
    print(f"[inventory] 启动 {threads} 线程", flush=True)
    ws = [threading.Thread(target=worker, args=(i,), daemon=True)
          for i in range(threads)]
    for w in ws:
        w.start()
    last_snap = 0
    while any(w.is_alive() for w in ws):   # 主线程: 每20s增量落盘防丢
        time.sleep(20)
        with lock:
            snap = list(nodes)
        if len(snap) - last_snap >= 500:
            OUT_JSON.write_text(json.dumps(snap, ensure_ascii=False),
                                encoding="utf-8")
            last_snap = len(snap)
            print(f"[snapshot] {len(snap)} 节点已落盘 | "
                  f"{time.time()-t0:.0f}s", flush=True)
    with lock:
        final = list(nodes)
    OUT_JSON.write_text(json.dumps(final, ensure_ascii=False),
                        encoding="utf-8")
    types: dict = {}
    for n in final:
        t = n.get("obj_type", "?")
        types[t] = types.get(t, 0) + 1
    print(f"[inventory] 完: {len(final)} 节点 | 类型分布 {types} | "
          f"{time.time()-t0:.0f}s", flush=True)
    return len(final)


def fetch(space: str, threads: int = 6) -> int:
    """并行取 docx 正文 (单线程0.6s×1740篇=17min; 6线程≈5min)."""
    import threading
    from collections import deque
    from epc49_stock_ingest import L1_KWS, judge_stock
    import ammo_pool as ap
    nodes = [n for n in json.loads(OUT_JSON.read_text(encoding="utf-8"))
             if n.get("obj_type") == "docx"]
    DOCS_DIR.mkdir(parents=True, exist_ok=True)
    camp = ap._camp_dir("EPC49-SEPDC")
    mp = camp / "manifest.jsonl"
    lock = threading.Lock()
    queue: deque = deque(nodes)
    st = {"ok": 0, "fail": 0, "skip": 0}

    def worker() -> None:
        while True:
            with lock:
                if not queue:
                    return
                n = queue.popleft()
            title = (n.get("title") or "").strip() or "untitled"
            fp = DOCS_DIR / (title[:60].replace("/", "／") + ".md")
            if fp.exists():
                with lock:
                    st["skip"] += 1
                continue
            try:  # docx 正文: docs +fetch markdown (回包 data.document.content)
                d = lark("docs", "+fetch", "--doc",
                         n.get("obj_token") or n.get("node_token"),
                         "--doc-format", "markdown", timeout=120)
                body = ((d.get("data") or {}).get("document")
                        or {}).get("content") or ""
            except Exception:                              # noqa: BLE001
                with lock:
                    st["fail"] += 1
                time.sleep(1)
                continue
            if len(body) > 50:
                verdict, reason = judge_stock(title + "\n" + body, L1_KWS)
                ch = ap.count_chars(body)
                row = {"ts": time.strftime("%Y-%m-%dT%H:%M:%S"),
                       "engine": "feishu_zhiku", "source_path": str(fp),
                       "url_norm": n.get("url", ""),
                       "chars": ch, "credibility": "archive",
                       "dedup_key": ap.dedup_key(None, title + body[:5000]),
                       "judge": verdict, "judge_reason": reason,
                       "judge_engine": "stock2level", "tree_node": "",
                       "stance": "support", "grade": "B"}
                with ap._pool_lock(camp):
                    with mp.open("a", encoding="utf-8") as fh:
                        fh.write(json.dumps(row, ensure_ascii=False) + "\n")
                fp.write_text(f"# {title}\n\n{body}", encoding="utf-8",
                              newline="\n")
                with lock:
                    st["ok"] += 1
            time.sleep(0.15)
            with lock:
                if (st["ok"] + st["skip"]) % 100 == 0 and st["ok"]:
                    print(f"[fetch] 取 {st['ok']} | skip {st['skip']} | "
                          f"fail {st['fail']} | 余 {len(queue)}", flush=True)

    ws = [threading.Thread(target=worker, daemon=True) for _ in range(threads)]
    for w in ws:
        w.start()
    for w in ws:
        w.join()
    print(f"[fetch] 完: {st['ok']} 篇落盘入池 | skip {st['skip']} | "
          f"fail {st['fail']}", flush=True)
    ap.rebuild("EPC49-SEPDC")
    return st["ok"]


def main() -> int:
    phase = sys.argv[1] if len(sys.argv) > 1 else "inventory"
    space = DEFAULT_SPACE
    if "--space-id" in sys.argv:
        space = sys.argv[sys.argv.index("--space-id") + 1]
    threads = 6
    if "--threads" in sys.argv:
        threads = int(sys.argv[sys.argv.index("--threads") + 1])
    out_json_override = None
    if "--out" in sys.argv:
        out_json_override = sys.argv[sys.argv.index("--out") + 1]
    if out_json_override:
        globals()["OUT_JSON"] = Path(out_json_override)
    if phase == "inventory":
        return 0 if inventory(space, threads=threads) else 1
    if phase == "fetch":
        return 0 if fetch(space, threads=threads) >= 0 else 1
    print("用法: feishu_wiki_zongbao.py [inventory|fetch] [--space-id ID]")
    return 2


if __name__ == "__main__":
    sys.exit(main())
