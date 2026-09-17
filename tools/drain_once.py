"""一次性消费 usn_queue.jsonl（验证 USN v2 → drain_events 闭环，不提取）。"""
import sys
from pathlib import Path

sys.path.insert(0, r"E:\AI-Station\src")

from paistation.sense.localfiles.domain import ScanDomain
from paistation.sense.localfiles.indexer import Indexer
from paistation.sense.localfiles.inventory import Inventory
from paistation.sense.localfiles.store import ChunkIndex

DB = Path(r"E:\AI-Station\data\local_index")
inv = Inventory(DB / "inventory.db")
chunks = ChunkIndex(DB / "index.db")
ix = Indexer(ScanDomain(), inv, chunks,
             events_queue=DB / "usn_queue.jsonl")
stats = ix.drain_events(limit=1_000_000)
print("drain stats:", stats)
ix.close()
