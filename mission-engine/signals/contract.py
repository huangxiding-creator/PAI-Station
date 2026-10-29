# -*- coding: utf-8 -*-
"""signals/contract.py — Signal 统一契约（W3.1，PROPOSAL §8 铁则）。

引擎核心只认本契约不认任何具体来源；「七路」仅为 v1 内置件，源数量无上限。
六件套缺一不可：source_type / payload / evidence / jtbd_tags / ts / confidence。
数字零造假精神：evidence 非空可溯源，无证据的信号一律 ContractError 拒收。
"""
from __future__ import annotations

import hashlib
import json
from dataclasses import dataclass
from datetime import datetime


class ContractError(ValueError):
    """Signal 契约违例（拒收该信号，不拖垮总线——对齐 organ_probe 单故障隔离哲学）。"""


def _canon(obj) -> str:
    """规范化 JSON 序列化（dedup_key 稳定性的基础；不可序列化即契约违例）。"""
    return json.dumps(obj, ensure_ascii=False, sort_keys=True, separators=(",", ":"))


def _parse_ts(ts) -> datetime:
    s = ts.strip() if isinstance(ts, str) else ""
    try:
        return datetime.fromisoformat(s.replace(" ", "T", 1))
    except ValueError:
        raise ContractError(
            f"ts 不可解析: {ts!r}（期望 YYYY-MM-DD HH:MM:SS 或 ISO8601）") from None


@dataclass
class Signal:
    source_type: str            # 信号源标识（=Adapter.source_type）
    payload: dict               # 信号本体（给锻造厂的原料）
    evidence: object            # 溯源体（非空：录音ID/群名+消息ID/URL…）
    jtbd_tags: list             # JTBD 标签（["需求-标书复刻", ...]，可为空）
    ts: str                     # 信号发生时刻（本地时区）
    confidence: float           # 适配器置信度 0.0-1.0

    def validate(self) -> "Signal":
        if not (isinstance(self.source_type, str) and self.source_type.strip()):
            raise ContractError("source_type 必须为非空 str")
        if not (isinstance(self.payload, dict) and self.payload):
            raise ContractError("payload 必须为非空 dict")
        if self.evidence is None or self.evidence == "" or self.evidence == {} or self.evidence == []:
            raise ContractError("evidence 不得为空（数字零造假：无证据不收）")
        if not isinstance(self.jtbd_tags, list) or not all(
                isinstance(t, str) for t in self.jtbd_tags):
            raise ContractError("jtbd_tags 必须为 list[str]")
        _parse_ts(self.ts)
        if not isinstance(self.confidence, (int, float)) \
                or not 0.0 <= float(self.confidence) <= 1.0:
            raise ContractError(f"confidence 必须在 0.0-1.0: {self.confidence!r}")
        for name in ("payload", "evidence"):      # 落账即序列化，此处提前拒不可序列化体
            try:
                _canon(getattr(self, name))
            except (TypeError, ValueError) as e:
                raise ContractError(f"{name} 不可JSON序列化: {e}") from None
        return self

    def dedup_key(self) -> str:
        """同源同证据=同一信号（evidence 应携带稳定唯一键，如录音ID/消息ID）。"""
        return hashlib.sha1(
            f"{self.source_type}\x00{_canon(self.evidence)}".encode("utf-8")).hexdigest()

    def to_dict(self) -> dict:
        return {"source_type": self.source_type, "payload": self.payload,
                "evidence": self.evidence, "jtbd_tags": self.jtbd_tags,
                "ts": self.ts, "confidence": self.confidence}
