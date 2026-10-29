# -*- coding: utf-8 -*-
"""signals/adapters/moments.py — 朋友圈洞察适配器（W3.2，七源第3源）。

数据源: wechat-24h-ops/data/sensing/YYYYMMDD.jsonl 中 face=="moments" 行
（上游=moments_miner.py 朋友圈深读: SNS抓取→LLM map-reduce→sensing.ledger.add，
quote 截80字，score0=urgency 30/50/70 映射）。face=="group" 行归 rion/群洞察
线（W3.2b 已另行覆盖），本适配器只收朋友圈面。

dedup 用 sensing 账本自带的 key（上游 add() 幂等键，稳定唯一）。
"""
from __future__ import annotations

import json
from datetime import datetime, timedelta
from pathlib import Path

from ..contract import Signal
from .base import Adapter

SENSING_DIR_DEFAULT = Path("E:/AI-Station/wechat-24h-ops/data/sensing")
DEFAULT_WINDOW_DAYS = 30           # 落账去重幂等，宽窗零成本（追账友好）


class MomentsAdapter(Adapter):
    source_type = "moments"

    def __init__(self, sensing_dir: Path | str = SENSING_DIR_DEFAULT,
                 window_days: int = DEFAULT_WINDOW_DAYS):
        self.sensing_dir = Path(sensing_dir)
        self.window_days = window_days

    def discover(self) -> list[str]:
        """窗口内日期文件中 face==moments 的原始行；文件名非法/窗外跳过。"""
        if not self.sensing_dir.is_dir():
            return []
        cutoff = int((datetime.now() - timedelta(days=self.window_days))
                     .strftime("%Y%m%d"))
        lines: list[str] = []
        for fp in sorted(self.sensing_dir.glob("*.jsonl")):
            if not fp.stem.isdigit() or int(fp.stem) < cutoff:
                continue
            for ln in fp.read_text(encoding="utf-8",
                                   errors="replace").splitlines():
                ln = ln.strip()
                if ln and '"moments"' in ln:          # 粗滤，normalize 精判
                    lines.append(ln)
        return lines

    def normalize(self, raw) -> Signal:
        d = json.loads(raw)                        # 坏行 ValueError → reject 留痕
        if d.get("face") != "moments":
            return None                            # 非朋友圈面=已知过滤跳过
        key = d.get("key") or ""
        if not key:
            raise ValueError("sensing 行缺 key（幂等键）")
        ref = d.get("ref") or {}
        ts = str(d.get("ts") or "").replace("T", " ", 1)
        return Signal(
            source_type=self.source_type,
            payload={"quote": d.get("quote") or "",
                     "wxid": ref.get("wxid", ""),
                     "mine": ref.get("mine", ""),
                     "private_level": d.get("private_level", "")},
            evidence={"key": key, "quote_full_hash": d.get("quote_full_hash", "")},
            jtbd_tags=["朋友圈", str(ref.get("mine") or "")],
            ts=ts,
            confidence=min((d.get("score0") or 0) / 100, 1.0),
        )
