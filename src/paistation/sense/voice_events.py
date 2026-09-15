"""M1.7 统一事件流（ARCHITECTURE §3 数据契约）：感知→主动层唯一交接面。

事件按日落文件（events/YYYY-MM-DD.jsonl），追加写+读侧过滤。
隐私红线（NFR2）：evidence 只带 segment_ms/audio_hash（PCM 的 SHA1
短哈希），原始音频即采即弃零落盘。
"""
from __future__ import annotations

import hashlib
import json
import os
from datetime import datetime

RATE = 16000
ALLOWED_TYPES = frozenset({
    "voice.transcript", "voice.utterance", "voice.wakeword",
    "ambient.event", "fs.change", "screen.ocr", "im.webhook", "cron.tick",
    "cloud.doc.change", "cloud.file.list",
    # M9 云感知连接器（腾讯会议/百度网盘/微信情报）
    "cloud.meeting.list", "cloud.drive.change", "cloud.wih.insight",
    # M7a 信号源补全（第 11 路调研：对标 ActivityWatch/银甲虫/screenpipe）
    "window.focus", "presence.afk", "clipboard.change", "browser.url",
    "process.snapshot", "session.state", "net.state",
})
_EVENT_FIELDS = ("ts", "type", "source", "text", "speaker", "evidence", "meta")


def audio_fingerprint(pcm) -> str:
    """PCM 短哈希（证据指纹，非存储）。"""
    import numpy as np
    return hashlib.sha1(np.ascontiguousarray(pcm).tobytes()).hexdigest()[:12]


def build_voice_event(text: str, source: str = "mic", speaker: str = "unknown",
                      segment_ms: list[int] | None = None,
                      audio_hash: str | None = None,
                      events: list[str] | None = None,
                      ts: datetime | None = None) -> dict:
    return {
        "ts": (ts or datetime.now()).isoformat(timespec="milliseconds"),
        "type": "voice.transcript",
        "source": source,
        "text": text,
        "speaker": speaker,
        "evidence": {"segment_ms": segment_ms or [],
                     "audio_hash": audio_hash or ""},
        "meta": {"events": events or []},
    }


def validate_event(ev: dict) -> bool:
    if not isinstance(ev, dict):
        return False
    if ev.get("type") not in ALLOWED_TYPES:
        return False
    if "ts" not in ev or "evidence" not in ev or "meta" not in ev:
        return False
    if ev["type"] == "voice.transcript" and not ev.get("text"):
        return False  # 空转写不入流
    return True


class EventStream:
    """追加写 jsonl（按日滚动）+读侧窗口。clock 可注入（测试假钟）。"""

    def __init__(self, data_dir, clock=None):
        self._dir = os.path.join(str(data_dir), "events")
        self._clock = clock or datetime.now

    def _path(self, day: datetime) -> str:
        return os.path.join(self._dir, f"{day:%Y-%m-%d}.jsonl")

    def append(self, ev: dict) -> bool:
        if not validate_event(ev):
            return False
        day = self._clock()
        os.makedirs(self._dir, exist_ok=True)
        with open(self._path(day), "a", encoding="utf-8") as fh:
            fh.write(json.dumps(ev, ensure_ascii=False) + "\n")
        return True

    def read_day(self, day: datetime) -> list[dict]:
        path = self._path(day)
        try:
            with open(path, encoding="utf-8") as fh:
                return [json.loads(line) for line in fh if line.strip()]
        except (OSError, json.JSONDecodeError):
            return []

    def read_today(self) -> list[dict]:
        return self.read_day(self._clock())

    def read_range(self, last_n: int) -> list[dict]:
        """最近 N 条（跨日拼接，时间升序）。"""
        day = self._clock()
        out: list[dict] = []
        for _ in range(31):  # 最多回看一个月
            day_events = self.read_day(day)
            out = day_events + out
            if len(out) >= last_n:
                break
            day = day.fromordinal(day.toordinal() - 1)
        return out[-last_n:] if last_n > 0 else out
