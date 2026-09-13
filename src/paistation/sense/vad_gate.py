"""M1.5 VAD 守门（03 卷 C 类）：silero-vad 常开 + 能量 VAD 兜底。

VAD 是感知管线的"CPU 守门员"：静默期只跑能量直方图（微秒级），
超阈才唤醒后级（ASR/事件分类）——NFR1 静默 CPU<5% 的第一道闸。
SileroVad=sherpa-onnx 封装（512 样本窗）；模型缺失自动退化 EnergyVad
（降级矩阵：感知退 VAD+事件标签，打字/文件通道不受损）。
"""
from __future__ import annotations

import logging
import os
from collections import deque

import numpy as np

from paistation.sense.audio import rms_db

_log = logging.getLogger("paistation.sense.vad")

RATE = 16000


class EnergyVad:
    """单块能量判定：rms_db 超阈即语音。零依赖兜底。"""

    def __init__(self, threshold_db: float = -35.0):
        self._threshold = threshold_db

    def feed(self, block: np.ndarray) -> bool:
        return bool(rms_db(block) > self._threshold)


class SpeechSegmenter:
    """能量分段状态机：预滚回卷词首 + 挂起容忍停顿 + flush 强制闭合。

    纯逻辑可单测；供 EnergyVad 模式与唤醒词预充共享。
    """

    def __init__(self, threshold_db: float = -35.0, preroll_ms: int = 200,
                 hangover_ms: int = 600, block_ms: int = 30):
        self._vad = EnergyVad(threshold_db)
        self._preroll = preroll_ms
        self._hangover = hangover_ms
        self._block_ms = block_ms
        self._t_ms = 0
        self._in_speech = False
        self._speech_started_ms = 0
        self._last_speech_ms = 0
        self._ring: deque[tuple[int, np.ndarray]] = deque()  # (t_ms, block) 预滚窗
        self._speech_ms_total = 0
        self.closed_segments: list[dict] = []

    def feed(self, block: np.ndarray) -> list[dict]:
        events: list[dict] = []
        is_speech = self._vad.feed(block)
        self._ring.append((self._t_ms, block))
        ring_span = self._t_ms + self._block_ms - self._ring[0][0]
        while len(self._ring) > 1 and ring_span - self._block_ms >= self._preroll:
            _, dropped = self._ring.popleft()
            ring_span = self._t_ms + self._block_ms - self._ring[0][0]

        if is_speech:
            if not self._in_speech:
                self._in_speech = True
                # 回卷：起点=预滚窗内最早的块
                self._speech_started_ms = self._ring[0][0]
                events.append({"event": "speech_start",
                               "ms": self._speech_started_ms})
            self._last_speech_ms = self._t_ms + self._block_ms
            self._speech_ms_total += self._block_ms
        elif self._in_speech:
            if self._t_ms - self._last_speech_ms >= self._hangover:
                events.append(self._close())
        self._t_ms += self._block_ms
        return events

    def _close(self) -> dict:
        self._in_speech = False
        seg = {"start_ms": self._speech_started_ms,
               "end_ms": self._last_speech_ms,
               "duration_ms": self._last_speech_ms - self._speech_started_ms}
        self.closed_segments.append(seg)
        return {"event": "speech_end", "ms": self._last_speech_ms, "seg": seg}

    def flush(self) -> list[dict]:
        """流终止时强制闭合进行中的语音段。"""
        if self._in_speech:
            return [self._close()]
        return []

    @property
    def speech_ms(self) -> int:
        return self._speech_ms_total


class SileroVad:
    """sherpa-onnx silero-vad 封装：512 样本窗流式分段。

    新版 API：SileroVadModelConfig → VadModelConfig → VoiceActivityDetector。
    段对象带绝对样本偏移（start），换算 ms 供事件流 evidence。
    """

    WINDOW = 512

    def __init__(self, model_path: str, threshold: float = 0.5,
                 min_silence_ms: int = 500, min_speech_ms: int = 250):
        import sherpa_onnx

        silero = sherpa_onnx.SileroVadModelConfig(
            model=model_path,
            threshold=threshold,
            min_silence_duration=min_silence_ms / 1000.0,
            min_speech_duration=min_speech_ms / 1000.0,
            window_size=self.WINDOW,
        )
        self._vad = sherpa_onnx.VoiceActivityDetector(
            sherpa_onnx.VadModelConfig(silero_vad=silero))
        self._buf = np.zeros(0, dtype=np.float32)
        self._segments: list[dict] = []

    def feed(self, block: np.ndarray) -> None:
        self._buf = np.concatenate([self._buf, block.astype(np.float32)])
        while len(self._buf) >= self.WINDOW:
            window, self._buf = (self._buf[:self.WINDOW],
                                 self._buf[self.WINDOW:])
            self._vad.accept_waveform(window)
            self._harvest()

    def _harvest(self) -> None:
        import sherpa_onnx  # noqa: F401 - 类型引用

        while not self._vad.empty():
            seg = self._vad.front
            start_ms = int(round(seg.start / RATE * 1000))
            dur_ms = int(round(len(seg.samples) / RATE * 1000))
            self._segments.append({"start_ms": start_ms, "end_ms": start_ms + dur_ms,
                                   "duration_ms": dur_ms})
            self._vad.pop()

    def flush(self) -> None:
        self._vad.flush()
        self._harvest()

    def drain_segments(self) -> list[dict]:
        out, self._segments = self._segments, []
        return out


def make_vad(backend: str = "auto", model_path=None, threshold_db: float = -35.0):
    """工厂：auto=silero（模型在位）→能量兜底；energy=强制兜底。"""
    if backend in ("auto", "silero") and model_path and os.path.exists(model_path):
        try:
            return SileroVad(str(model_path))
        except Exception as exc:  # noqa: BLE001 - 模型损坏不阻塞感知
            _log.warning("silero 加载失败退能量 VAD: %s", exc)
    if backend == "silero":
        _log.warning("silero 模型缺失（%s），退能量 VAD", model_path)
    return EnergyVad(threshold_db)
