"""CLI 入口：python -m paistation.sense.localfiles <scan|extract|status|search|profile>。

索引库默认落 data/local_index/（gitignored）。全量首扫属重活，
晚间跑（既有惯例）；日常增量随时可跑（断点续跑=重开即续）。
长跑模式 extract --loop：批次循环直至队列清空（只乘毒文件时收敛
停止），配合 pythonw + --log-file 即为计划任务的零弹窗形态。
"""
from __future__ import annotations

import argparse
import json
import logging
import sys
import time
from pathlib import Path

from paistation.sense.localfiles.domain import ScanDomain
from paistation.sense.localfiles.embedder import (
    DEFAULT_MODEL,
    make_ollama_batch_embedder,
    make_ollama_embedder,
    ollama_embedder_version,
)
from paistation.sense.localfiles.indexer import Indexer
from paistation.sense.localfiles.inventory import Inventory
from paistation.sense.localfiles.signals import SignalAnalyzer
from paistation.sense.localfiles.store import ChunkIndex

DEFAULT_DIR = Path("data/local_index")
POISON_STALL_BATCHES = 3  # 连续全失败批数上限：判定队列只剩毒文件


def _build(args):
    inv = Inventory(args.db_dir / "inventory.db")
    embedder = None
    batch_embedder = None
    ver = "none"
    if not args.no_embed:
        embedder = make_ollama_embedder(endpoint=args.ollama)
        if embedder is not None:
            ver = ollama_embedder_version(DEFAULT_MODEL)
            batch_embedder = make_ollama_batch_embedder()
            print(f"[嵌入] Ollama {DEFAULT_MODEL} 在位"
                  f"（批量{'✓' if batch_embedder else '✗'}）")
        else:
            print("[嵌入] 服务不在位 → keyword-only 降级（检索仍可用）")
    chunks = ChunkIndex(args.db_dir / "index.db", embedder=embedder,
                        embedder_ver=ver, batch_embedder=batch_embedder)
    domain = ScanDomain()
    return Indexer(domain, inv, chunks,
                   events_queue=args.db_dir / "usn_queue.jsonl"), inv, chunks


def _extract_loop(ix: Indexer, limit: int, log,
                  workers: int | None = None,
                  engine: str = "thread") -> dict:
    """断点续跑长跑：批次循环至队列清空；毒文件停机判定防死循环。

    pending() 含 failed 态（老 last_seen 排后），队列只剩毒文件时
    批批全失败——连续 POISON_STALL_BATCHES 批零产出即收敛退出。
    随时可停（Ctrl+C/杀进程）：进度全在 inventory 行级状态里。
    """
    total = {"processed": 0, "extracted": 0, "cached": 0, "failed": 0}
    stall = 0
    batch_no = 0
    while True:
        ev = ix.drain_events()  # 秒级事件通道：live_watch 产 → 此处入队
        if ev:
            log.info("秒级事件入队：%s", ev)
        r = ix.extract_pending(limit, workers=workers, engine=engine)
        if r["processed"] == 0:
            log.info("队列清空，长跑完成：总计 %s", total)
            break
        batch_no += 1
        for k in total:
            total[k] += r[k]
        log.info("批 %d：%s（累计 %s）", batch_no, r, total)
        if r["extracted"] == 0 and r["cached"] == 0:
            stall += 1
            if stall >= POISON_STALL_BATCHES:
                log.warning("连续 %d 批零产出：队列只剩毒文件，停机", stall)
                break
        else:
            stall = 0
    return total


def _embed_loop(chunks, batch: int, loop: bool, max_hours: float,
                log) -> dict:
    """补嵌长跑：循环至清空；max_hours>0 时到点优雅收工。

    203 万欠账块 30 块/s ≈ 18.5h——不限时会跟次日白天的 OCR 风暴
    抢一整天。断点=embedding_status，收工明夜续磨零浪费。
    """
    total = {"embedded": 0, "rows_lit": 0, "failed": 0}
    deadline = (time.monotonic() + max_hours * 3600
                if max_hours > 0 else None)
    while True:
        r = chunks.backfill(batch=batch)
        for k in total:
            total[k] += r[k]
        log.info("补嵌批：%s（累计 %s 剩 %s）", r, total, r["remaining"])
        if not loop or r["embedded"] == 0:
            break
        if deadline and time.monotonic() > deadline:
            log.info("补嵌达 %sh 预算优雅收工（断点=embedding_status，"
                     "明夜续磨）", max_hours)
            break
    return total


def main(argv=None) -> int:
    ap = argparse.ArgumentParser(prog="paistation.sense.localfiles")
    ap.add_argument("--db-dir", type=Path, default=DEFAULT_DIR)
    ap.add_argument("--log-file", type=Path, default=None,
                    help="日志落盘（pythonw 零弹窗计划任务必带）")
    sub = ap.add_subparsers(dest="cmd", required=True)
    sub.add_parser("scan", help="L0 枚举 + 清单差分（只 stat 不读内容）")
    ex = sub.add_parser("extract", help="提取待处理队列 → chunk 入库")
    ex.add_argument("--limit", type=int, default=200)
    ex.add_argument("--workers", type=int, default=None,
                    help="并行工人数（thread 默认 8 / proc 默认 12）")
    ex.add_argument("--proc", action="store_true",
                    help="进程引擎（spawn 真并行破 GIL，生产位推荐）")
    ex.add_argument("--loop", action="store_true",
                    help="断点续跑长跑模式（计划任务用）")
    sub.add_parser("cycle", help="scan + extract 一键")
    em = sub.add_parser("embed", help="存量 none 块批量补嵌（断点续跑）")
    em.add_argument("--batch", type=int, default=256)
    em.add_argument("--loop", action="store_true",
                    help="循环至补嵌完成（夜间长跑）")
    em.add_argument("--max-hours", type=float, default=0,
                    help="长跑时长预算（0=不限；到点优雅收工，明夜续磨）")
    sub.add_parser("status", help="索引状态统计")
    sq = sub.add_parser("search", help="混合检索")
    sq.add_argument("query", nargs="+")
    sq.add_argument("-k", type=int, default=8)
    pr = sub.add_parser("profile", help="生成 LOCAL_FILES_PROFILE.md")
    pr.add_argument("-o", type=Path, default=None)
    sub.add_parser("mcp", help="MCP stdio 服务器（只读检索暴露给 agent 会话）")
    ap.add_argument("--no-embed", action="store_true",
                    help="跳过嵌入器探测（纯 keyword 模式）")
    ap.add_argument("--ollama", default="http://127.0.0.1:11434/api/embeddings")
    args = ap.parse_args(argv)

    if args.log_file:
        args.log_file.parent.mkdir(parents=True, exist_ok=True)
        handlers = [logging.FileHandler(args.log_file, encoding="utf-8")]
        if sys.stderr is not None:  # pythonw 下 stderr 为 None，跳过控制台
            handlers.append(logging.StreamHandler(sys.stderr))
        logging.basicConfig(
            level=logging.INFO,
            format="%(asctime)s %(levelname)s %(message)s",
            handlers=handlers)
    log = logging.getLogger("paistation.sense.localfiles.cli")

    if args.cmd == "status":
        inv = Inventory(args.db_dir / "inventory.db")
        print(json.dumps(inv.stats(), ensure_ascii=False, indent=2))
        return 0

    if args.cmd == "mcp":  # stdout 即协议通道：禁 banner、禁打印
        from paistation.sense.localfiles.mcp_server import LocalFilesMcpService, force_utf8_stdio
        from paistation.sense.localfiles.mcp_server import serve as mcp_serve
        force_utf8_stdio()
        svc = LocalFilesMcpService.open(args.db_dir)
        try:
            mcp_serve(sys.stdin, sys.stdout, svc)
        finally:
            svc.close()
        return 0

    ix, inv, chunks = _build(args)
    try:
        if args.cmd == "scan":
            print(json.dumps(ix.scan(), ensure_ascii=False, indent=2))
        elif args.cmd == "extract":
            if args.loop:
                total = _extract_loop(ix, args.limit, log,
                                      workers=args.workers,
                                      engine="proc" if args.proc else "thread")
                print(json.dumps(total, ensure_ascii=False, indent=2))
            else:
                print(json.dumps(
                    ix.extract_pending(
                        args.limit, workers=args.workers,
                        engine="proc" if args.proc else "thread"),
                    ensure_ascii=False, indent=2))
        elif args.cmd == "cycle":
            print(json.dumps(ix.full_cycle(), ensure_ascii=False, indent=2))
        elif args.cmd == "embed":
            if chunks.stats()["embedder"] == "none":
                print("[嵌入] Ollama 不在位，拒绝空转（先启动服务）")
                return 1
            total = _embed_loop(chunks, args.batch, args.loop,
                                args.max_hours, log)
            print(json.dumps(total, ensure_ascii=False, indent=2))
        elif args.cmd == "search":
            query = " ".join(args.query)
            for h in chunks.search(query, k=args.k):
                print(f"[{h.source:>7}] {h.path} #{h.seq}"
                      f" (score={h.score})\n    {h.text[:120]}")
        elif args.cmd == "profile":
            report = SignalAnalyzer(inv, chunks).analyze()
            out = args.o or (args.db_dir / "LOCAL_FILES_PROFILE.md")
            out.parent.mkdir(parents=True, exist_ok=True)
            out.write_text(report.to_profile_md(), encoding="utf-8")
            print(f"画像已生成: {out}（待办线索 {len(report.todos)} 条）")
        return 0
    finally:
        ix.close()


if __name__ == "__main__":
    sys.exit(main())
