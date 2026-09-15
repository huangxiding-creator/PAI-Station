"""CLI 入口：python -m paistation.sense.localfiles <scan|extract|status|search|profile>。

索引库默认落 data/local_index/（gitignored）。全量首扫属重活，
晚间跑（既有惯例）；日常增量随时可跑（断点续跑=重开即续）。
"""
from __future__ import annotations

import argparse
import json
import sys
from pathlib import Path

from paistation.sense.localfiles.domain import ScanDomain
from paistation.sense.localfiles.embedder import (
    DEFAULT_MODEL,
    make_ollama_embedder,
    ollama_embedder_version,
)
from paistation.sense.localfiles.indexer import Indexer
from paistation.sense.localfiles.inventory import Inventory
from paistation.sense.localfiles.signals import SignalAnalyzer
from paistation.sense.localfiles.store import ChunkIndex

DEFAULT_DIR = Path("data/local_index")


def _build(args):
    inv = Inventory(args.db_dir / "inventory.db")
    embedder = None
    ver = "none"
    if not args.no_embed:
        embedder = make_ollama_embedder(endpoint=args.ollama)
        if embedder is not None:
            ver = ollama_embedder_version(DEFAULT_MODEL)
            print(f"[嵌入] Ollama {DEFAULT_MODEL} 在位")
        else:
            print("[嵌入] 服务不在位 → keyword-only 降级（检索仍可用）")
    chunks = ChunkIndex(args.db_dir / "index.db", embedder=embedder,
                        embedder_ver=ver)
    domain = ScanDomain()
    return Indexer(domain, inv, chunks), inv, chunks


def main(argv=None) -> int:
    ap = argparse.ArgumentParser(prog="paistation.sense.localfiles")
    ap.add_argument("--db-dir", type=Path, default=DEFAULT_DIR)
    sub = ap.add_subparsers(dest="cmd", required=True)
    sub.add_parser("scan", help="L0 枚举 + 清单差分（只 stat 不读内容）")
    ex = sub.add_parser("extract", help="提取待处理队列 → chunk 入库")
    ex.add_argument("--limit", type=int, default=200)
    sub.add_parser("cycle", help="scan + extract 一键")
    sub.add_parser("status", help="索引状态统计")
    sq = sub.add_parser("search", help="混合检索")
    sq.add_argument("query", nargs="+")
    sq.add_argument("-k", type=int, default=8)
    pr = sub.add_parser("profile", help="生成 LOCAL_FILES_PROFILE.md")
    pr.add_argument("-o", type=Path, default=None)
    ap.add_argument("--no-embed", action="store_true",
                    help="跳过嵌入器探测（纯 keyword 模式）")
    ap.add_argument("--ollama", default="http://127.0.0.1:11434/api/embeddings")
    args = ap.parse_args(argv)

    if args.cmd == "status":
        inv = Inventory(args.db_dir / "inventory.db")
        print(json.dumps(inv.stats(), ensure_ascii=False, indent=2))
        return 0

    ix, inv, chunks = _build(args)
    try:
        if args.cmd == "scan":
            print(json.dumps(ix.scan(), ensure_ascii=False, indent=2))
        elif args.cmd == "extract":
            print(json.dumps(ix.extract_pending(args.limit),
                             ensure_ascii=False, indent=2))
        elif args.cmd == "cycle":
            print(json.dumps(ix.full_cycle(), ensure_ascii=False, indent=2))
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
