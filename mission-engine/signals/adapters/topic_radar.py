# -*- coding: utf-8 -*-
"""signals/adapters/topic_radar.py — 需求雷达原始信号适配器（W3.2，七源第5源）。

数据源: data/demand_signals/radar_signals.jsonl（demand_signals_* 三采集腿
ask/comments/sph 落账+intent分类，实测70行；radar_topics.md 的上游原料）。
上游无稳定 id → evidence 键=radar_+sha1(ts|actor|text)[:12]（内容指纹，
同条重拉稳定=幂等）。intent=="无关噪声" 显式跳过（normalize 返回 None，
冒烟/测试类行已在噪音面）。confidence 为适配器声明启发：
否定抱怨0.7（强负信号）/具体问题0.6 /其余0.5——非实测分，仅排序用。
"""
from __future__ import annotations

import hashlib
import json
from datetime import datetime, timedelta
from pathlib import Path

from ..contract import Signal
from .base import Adapter

RADAR_DEFAULT = Path("E:/AI-Station/data/demand_signals/radar_signals.jsonl")
DEFAULT_WINDOW_DAYS = 30
_CONF = {"否定抱怨": 0.7, "具体问题": 0.6}      # 其余可读 intent=0.5


class TopicRadarAdapter(Adapter):
    source_type = "topic_radar"

    def __init__(self, radar_file: Path | str = RADAR_DEFAULT,
                 window_days: int = DEFAULT_WINDOW_DAYS):
        self.radar_file = Path(radar_file)
        self.window_days = window_days

    def discover(self) -> list[str]:
        if not self.radar_file.is_file():
            return []
        cutoff = datetime.now() - timedelta(days=self.window_days)
        lines: list[str] = []
        for ln in self.radar_file.read_text(encoding="utf-8",
                                            errors="replace").splitlines():
            ln = ln.strip()
            if not ln:
                continue
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
        if d.get("intent") == "无关噪声":
            return None                            # 冒烟/测试类噪音显式跳过
        ts = str(d.get("ts") or "")[:19].replace("T", " ", 1)
        actor = str(d.get("actor") or "")
        text = str(d.get("text") or "")
        if not (ts and text):
            raise ValueError("radar 行缺 ts/text")
        fp = "radar_" + hashlib.sha1(
            f"{ts}|{actor}|{text}".encode("utf-8")).hexdigest()[:12]
        intent = str(d.get("intent") or "")
        topic = d.get("topic") or ""
        return Signal(
            source_type=self.source_type,
            payload={"text": text, "source": d.get("source") or "",
                     "channel": d.get("channel") or "", "actor": actor,
                     "intent": intent, "topic": topic},
            evidence={"fingerprint": fp, "channel": d.get("channel") or ""},
            jtbd_tags=["需求雷达", intent, str(topic)],
            ts=ts,
            confidence=_CONF.get(intent, 0.5),
        )
