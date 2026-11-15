# -*- coding: utf-8 -*-
"""signals/adapters/demand_ledger.py — 需求台账适配器（W3.2，七源第4源）。

数据源: data/demand_ledger/signals.jsonl（demand_ledger.py 聚合产线落账，
实测408行；多渠道面 source_face: mp_feedback/ask/comments/sph…，
含完整 jtbd{trigger,job_statement,outcome}+urgency+score）。
signal_id=dl_ 时间戳短哈希，上游幂等键，直接作 dedup 证据主键。
"""
from __future__ import annotations

import hashlib
import json
from datetime import datetime, timedelta
from pathlib import Path

from ..contract import Signal
from .base import Adapter

LEDGER_DEFAULT = Path("E:/AI-Station/data/demand_ledger/signals.jsonl")
ENGINE_LEDGER_DEFAULT = Path(__file__).resolve().parents[2] / "ledger" / "signals.jsonl"
DEFAULT_WINDOW_DAYS = 30


class DemandLedgerAdapter(Adapter):
    source_type = "demand_ledger"

    def __init__(self, ledger_file: Path | str = LEDGER_DEFAULT,
                 window_days: int = DEFAULT_WINDOW_DAYS,
                 engine_ledger: Path | str = ENGINE_LEDGER_DEFAULT):
        self.ledger_file = Path(ledger_file)
        self.window_days = window_days
        self.engine_ledger = Path(engine_ledger)

    def _seen_content_keys(self) -> set[tuple[str, str]]:
        """1115修(e):扫引擎主账本全部本源历史行,建(quote哈希,face)内容级索引。
        上游signal_id行号每日漂移致键级去重失效(四日链dl_20744→20747实证),
        内容级对账=零一次性重发(直接换键会重发30天窗全量1598行)。"""
        seen = set()
        if not self.engine_ledger.is_file():
            return seen
        for ln in self.engine_ledger.read_text(encoding="utf-8",
                                               errors="replace").splitlines():
            ln = ln.strip()
            if not ln:
                continue
            try:
                rec = json.loads(ln)
            except ValueError:
                continue
            sig = rec.get("signal") or {}
            if sig.get("source_type") != self.source_type:
                continue
            p = sig.get("payload") or {}
            q = p.get("demand_quote") or ""
            if q:
                seen.add((hashlib.md5(
                    q.encode("utf-8")).hexdigest(), p.get("source_face") or ""))
        return seen

    def discover(self) -> list[str]:
        if not self.ledger_file.is_file():
            return []
        seen = self._seen_content_keys()
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
            try:                                   # 1115修(e):内容级滤已入账行
                d = json.loads(ln)
                q = d.get("demand_quote") or ""
                if q and (hashlib.md5(q.encode("utf-8")).hexdigest(),
                          d.get("source_face") or "") in seen:
                    continue
            except ValueError:
                pass
            lines.append(ln)
        return lines

    @staticmethod
    def _stable_evidence(sid: str, source_ref: str) -> dict:
        """1115修:上游signal_id=dl_<行号>_<内容哈希>,行号每日漂移(+1)致dedup失效
        同quote重复发(四日链dl_20744→20747实证,后缀恒定)。剥行号前缀留内容哈希
        作稳定主键;raw原值保留审计。首次切换会一次性重发全量(新键),次日归零。"""
        parts = sid.split("_", 2)
        stable = f"dl_{parts[2]}" if len(parts) == 3 and parts[2] else sid
        ev = {"signal_id": stable, "source_ref": source_ref}
        if stable != sid:
            ev["signal_id_raw"] = sid
        return ev

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
            evidence=self._stable_evidence(sid, d.get("source_ref") or ""),
            jtbd_tags=["需求台账", str(d.get("source_face") or ""),
                       str(jtbd.get("outcome") or ""),
                       f"urgency-{d.get('urgency') or ''}"],
            ts=str(d.get("ts") or "")[:19].replace("T", " ", 1),
            confidence=min((d.get("score") or 0) / 100, 1.0),
        )
