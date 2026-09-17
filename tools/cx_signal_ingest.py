# -*- coding: utf-8 -*-
"""信号流并入 CX 主时间轴（行为维 L3 补源）。

用法：
    python tools/cx_signal_ingest.py            # 全量幂等重跑（日文件只追加，秒级）
"""
from __future__ import annotations

import sys
from collections import Counter
from pathlib import Path

REPO = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(REPO / "src"))

from paistation.cx.ingest_signal import SOURCE, parse_signal_dir  # noqa: E402
from paistation.cx.timeline import TimelineStore  # noqa: E402

EVENTS_DIR = REPO / "data" / "signal_stream" / "events"
TIMELINE_DB = REPO / "data" / "cx" / "timeline.db"


def main() -> int:
    events = list(parse_signal_dir(EVENTS_DIR))
    store = TimelineStore(TIMELINE_DB)
    inserted, skipped = store.ingest(events)
    by_type = Counter(e.type for e in events)
    print(f"信号流入轴：解析 {len(events)} 条，新插 {inserted}，幂等跳过 {skipped}")
    print("类型分布:", dict(by_type.most_common()))
    print(f"timeline {SOURCE} 存量: {store.count(SOURCE)}")
    store.close()
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
