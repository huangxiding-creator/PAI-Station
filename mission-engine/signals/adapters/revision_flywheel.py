# -*- coding: utf-8 -*-
"""signals/adapters/revision_flywheel.py — 反馈飞轮改版台账适配器（W3.2，七源第6源）。

数据源: data/feedback/revision_ledger.jsonl（feedback_revision_loop.py 每轮
改版回执：ts/sku/rev/fids/status/pdf_kb，实测1行且随飞轮自动增长）。
语义=买家反馈压力已物化为改版动作（哪些 SKU 被推着迭代=持续付费压力所在）。
sku+rev 为天然稳定主键。机器台账事实 → confidence=1.0。
"""
from __future__ import annotations

import json
from datetime import datetime, timedelta
from pathlib import Path

from ..contract import Signal
from .base import Adapter

LEDGER_DEFAULT = Path("E:/AI-Station/data/feedback/revision_ledger.jsonl")
DEFAULT_WINDOW_DAYS = 30


class RevisionFlywheelAdapter(Adapter):
    source_type = "revision_flywheel"

    def __init__(self, ledger_file: Path | str = LEDGER_DEFAULT,
                 window_days: int = DEFAULT_WINDOW_DAYS):
        self.ledger_file = Path(ledger_file)
        self.window_days = window_days

    def discover(self) -> list[str]:
        if not self.ledger_file.is_file():
            return []
        cutoff = datetime.now() - timedelta(days=self.window_days)
        lines: list[str] = []
        for ln in self.ledger_file.read_text(encoding="utf-8",
                                             errors="replace").splitlines():
            ln = ln.strip()
            if not ln:
                continue
            try:
                ts = (json.loads(ln).get("ts") or "")[:19].replace("T", " ", 1)
                if ts and datetime.fromisoformat(ts) < cutoff:
                    continue
            except ValueError:
                pass
            lines.append(ln)
        return lines

    def normalize(self, raw) -> Signal:
        d = json.loads(raw)
        sku = d.get("sku") or ""
        rev = d.get("rev")
        if not sku or not isinstance(rev, int):
            raise ValueError(f"飞轮行缺 sku/rev: sku={sku!r} rev={rev!r}")
        fids = d.get("fids") or []
        return Signal(
            source_type=self.source_type,
            payload={"sku": sku, "rev": rev, "status": d.get("status") or "",
                     "fids_count": len(fids), "pdf_kb": d.get("pdf_kb") or 0},
            evidence={"sku": sku, "rev": rev, "fids": fids},
            jtbd_tags=["反馈飞轮", f"sku-{sku}", f"rev{rev}",
                       str(d.get("status") or "")],
            ts=str(d.get("ts") or "")[:19].replace("T", " ", 1),
            confidence=1.0,                         # 机器台账事实
        )
