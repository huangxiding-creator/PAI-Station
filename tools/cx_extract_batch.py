# -*- coding: utf-8 -*-
"""高价值优先提取批（白昼批）：消费 priority 队列 top-N，不触发全盘扫描。

用法：python tools/cx_extract_batch.py [limit=3000]
夜跑 full_cycle 之外的加餐——队列头永远是主业/高价值文件。
"""
from __future__ import annotations

import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

REPO = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(REPO / "src"))

from paistation.sense.localfiles.domain import ScanDomain  # noqa: E402
from paistation.sense.localfiles.indexer import Indexer  # noqa: E402
from paistation.sense.localfiles.inventory import Inventory  # noqa: E402
from paistation.sense.localfiles.store import ChunkIndex  # noqa: E402

LF_DIR = REPO / "data/local_index"


def main() -> int:
    limit = int(sys.argv[1]) if len(sys.argv) > 1 else 3000
    inv = Inventory(LF_DIR / "inventory.db")
    chunks = ChunkIndex(LF_DIR / "index.db")
    idx = Indexer(ScanDomain(), inv, chunks)
    t0 = time.time()
    report = idx.extract_pending(limit)
    dt = time.time() - t0
    print(f"limit={limit} 耗时 {dt/60:.1f} 分钟：{report}")
    head = inv.pending(1)
    if head:
        print(f"队首剩余：{head[0]['priority']:.1f} {head[0]['path'][:70]}")
    idx.close()
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
