# -*- coding: utf-8 -*-
"""signals/adapters/demand_ledger.py — 需求台账适配器（W3.2，七源第4源）。

数据源: data/demand_ledger/signals.jsonl（demand_ledger.py 聚合产线落账，
实测408行；多渠道面 source_face: mp_feedback/ask/comments/sph…，
含完整 jtbd{trigger,job_statement,outcome}+urgency+score）。
signal_id=dl_ 时间戳短哈希，上游幂等键，直接作 dedup 证据主键。
"""
from __future__ import annotations

import json
from datetime import datetime, timedelta
from pathlib import Path

from ..contract import Signal
from .base import Adapter

LEDGER_DEFAULT = Path("E:/AI-Station/data/demand_ledger/signals.jsonl")
DEFAULT_WINDOW_DAYS = 30


class DemandLedgerAdapter(Adapter):
    source_type = "demand_ledger"

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
            ts = ""
            try:                                    # 窗外行粗跳（坏行留给 normalize）
                ts = (json.loads(ln).get("ts") or "")[:19].replace("T", " ", 1)
                if ts and datetime.fromisoformat(ts) < cutoff:
                    continue
            except ValueError:
                pass
            lines.append(ln)
        return lines

    def normalize(self, raw) -> Signal:
        d = json.loads(raw)
        sid = d.get("signal_id") or ""
        if not sid.startswith("dl_"):
            raise ValueError(f"signal_id 格式非法: {sid!r}")
        jtbd = d.get("jtbd") or {}
        return Signal(
            source_type=self.source_type,
            payload={"demand_quote": d.get("demand_quote") or "",
                     "jtbd": jtbd,
                     "source_face": d.get("source_face") or "",
                     "frequency": d.get("frequency") or 0,
                     "urgency": d.get("urgency") or "",
                     "score": d.get("score") or 0},
            evidence={"signal_id": sid, "source_ref": d.get("source_ref") or ""},
            jtbd_tags=["需求台账", str(d.get("source_face") or ""),
                       str(jtbd.get("outcome") or ""),
                       f"urgency-{d.get('urgency') or ''}"],
            ts=str(d.get("ts") or "")[:19].replace("T", " ", 1),
            confidence=min((d.get("score") or 0) / 100, 1.0),
        )
