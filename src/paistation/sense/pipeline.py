"""M1 感知管线（03 卷缝合）：双路采集→VAD 守门→ASR→事件流。

线程纪律：音频回调只入队（微秒级，绝不阻塞采集线程）；VAD+ASR
推理全在单 worker 线程序列化（int8 CPU 20x 实时，串行够用）。
暂停语义（daemon tick(paused)）：停采集+丢新块，已入队段处理完。
降级矩阵：无 silero→能量分段；无 ASR→voice.utterance（有段无文）。
"""
from __future__ import annotations

import logging
import queue
import threading

import numpy as np

from paistation.sense.audio import BlockRing, MicSource, rms_db
from paistation.sense.vad_gate import SileroVad, SpeechSegmenter, make_vad
from paistation.sense.voice_events import EventStream, audio_fingerprint

_log = logging.getLogger("paistation.sense.pipeline")

RATE = 16000
BLOCK_MS = 30
ENERGY_PRECHECK_DB = -45.0  # 回调级粗筛：低于此直接丢（省 worker 带宽）


class VoicePipeline:
    """daemon 服务协议：name/start/stop/tick(paused)。"""

    name = "sense.voice"

    def __init__(self, stream: EventStream, vad_model=None,
                 model_dir=None, on_event=None, mic=False, loopback=False):
        self._stream = stream
        self._vad_model = vad_model
        self._model_dir = model_dir
        self._on_event = on_event
        self._want_mic = mic
        self._want_loopback = loopback
        self._q: queue.Queue = queue.Queue(maxsize=2000)
        self._worker: threading.Thread | None = None
        self._stopping = threading.Event()
        self._paused = False
        self._mic: MicSource | None = None
        self._loopback = None
        self._vad = None            # SileroVad 或 None（能量模式）
        self._segmenter: SpeechSegmenter | None = None
        self._asr = None
        self._ring = BlockRing(max_seconds=30.0)
        self._t_ms = 0
        self.started = False

    # ---- 生命周期 ----

    def start(self) -> None:
        self._vad = make_vad("auto", self._vad_model)
        if not isinstance(self._vad, SileroVad):
            self._segmenter = SpeechSegmenter(preroll_ms=200, hangover_ms=600)
        if self._model_dir:
            try:
                from paistation.sense.asr import AsrEngine
                self._asr = AsrEngine(self._model_dir)
            except Exception as exc:  # noqa: BLE001 - ASR 缺席走降级
                _log.warning("ASR 引擎缺席（降级 utterance 模式）: %s", exc)
        if self._want_mic:
            self._mic = MicSource()
            self._mic.start(self._on_block)
        if self._want_loopback:
            try:
                from paistation.sense.audio import LoopbackSource
                self._loopback = LoopbackSource()
                self._loopback.start(self._on_block)
            except Exception as exc:  # noqa: BLE001 - 系统声缺席不连坐麦克风
                _log.warning("loopback 启动失败（忽略）: %s", exc)
        self._stopping.clear()
        self._worker = threading.Thread(target=self._run, name="pai-voice",
                                        daemon=True)
        self._worker.start()
        self.started = True
        _log.info("VoicePipeline 启动: vad=%s asr=%s",
                  type(self._vad).__name__, bool(self._asr))

    def stop(self) -> None:
        self._stopping.set()
        if self._mic:
            self._mic.stop()
        if self._loopback:
            self._loopback.stop()
        if self._worker:
            self._worker.join(timeout=10)
        self.started = False

    def tick(self, paused: bool) -> None:
        """daemon 心跳回调：暂停=停采集，恢复=重启采集（自愈）。"""
        if paused == self._paused:
            return
        self._paused = paused
        if paused:
            if self._mic:
                self._mic.stop()
            if self._loopback:
                self._loopback.stop()
        else:
            if self._want_mic and self._mic:
                try:
                    self._mic.start(self._on_block)
                except Exception as exc:  # noqa: BLE001
                    _log.warning("mic 重启失败: %s", exc)
            if self._want_loopback and self._loopback:
                try:
                    self._loopback.start(self._on_block)
                except Exception as exc:  # noqa: BLE001
                    _log.warning("loopback 重启失败: %s", exc)

    @property
    def paused(self) -> bool:
        return self._paused

    # ---- 采集回调（微秒级）----

    def _on_block(self, block: np.ndarray) -> None:
        if self._paused or self._stopping.is_set():
            return
        if rms_db(block) < ENERGY_PRECHECK_DB:
            return  # 粗筛：深静默直接丢
        try:
            self._q.put_nowait(np.asarray(block, dtype=np.float32))
        except queue.Full:
            pass  # 过载丢块保采集（worker 过慢的保险丝）

    # ---- worker：VAD→ASR→事件 ----

    def _run(self) -> None:
        while not self._stopping.is_set():
            try:
                block = self._q.get(timeout=0.5)
            except queue.Empty:
                if isinstance(self._vad, SileroVad):
                    continue  # silero 无 flush-on-idle；段由其内部缓冲管理
                continue
            try:
                self._process(block)
            except Exception as exc:  # noqa: BLE001 - 单块故障不杀 worker
                _log.warning("块处理异常（忽略）: %s", exc)
        # 收尾：强制闭合开口段（能量路径 flush / silero 路径 flush+收割）
        if self._segmenter:
            for event in self._segmenter.flush():
                if event["event"] == "speech_end":
                    self._emit_from_energy(event["seg"])
        if isinstance(self._vad, SileroVad):
            self._vad.flush()
            for seg in self._vad.drain_segments():
                self._emit_from_silero(seg)

    def _process(self, block: np.ndarray) -> None:
        if isinstance(self._vad, SileroVad):
            self._vad.feed(block)
            for seg in self._vad.drain_segments():
                self._emit_from_silero(seg)
        else:
            self._ring.append(block)
            for event in self._segmenter.feed(block):
                if event["event"] == "speech_end":
                    self._emit_from_energy(event["seg"])
        self._t_ms += BLOCK_MS

    # ---- 段→事件 ----

    def _slice_ring(self, start_ms: int, end_ms: int) -> np.ndarray:
        audio = self._ring.snapshot()
        s = max(0, int(start_ms * RATE / 1000))
        e = min(len(audio), int(end_ms * RATE / 1000))
        return audio[s:e] if e > s else np.zeros(0, dtype=np.float32)

    def _emit_from_energy(self, seg: dict) -> None:
        pcm = self._slice_ring(seg["start_ms"], seg["end_ms"])
        self._emit_segment(pcm, [seg["start_ms"], seg["end_ms"]])

    def _emit_from_silero(self, seg: dict) -> None:
        # silero 段自带样本；start_ms 为相对流起点的绝对偏移
        self._emit_segment_event(seg.get("pcm"), seg)

    def _emit_segment(self, pcm: np.ndarray, seg_ms: list[int]) -> None:
        self._emit_segment_event(pcm, {"start_ms": seg_ms[0],
                                       "end_ms": seg_ms[1]})

    def _emit_segment_event(self, pcm, seg_info: dict) -> None:
        start_ms, end_ms = seg_info.get("start_ms", 0), seg_info.get("end_ms", 0)
        if pcm is None or len(pcm) < RATE // 4:  # <250ms 不值得转写
            return
        seg_ms = [start_ms, end_ms]
        fingerprint = audio_fingerprint(pcm)
        if self._asr is None:
            self._publish("voice.utterance", text="", seg_ms=seg_ms,
                          audio_hash=fingerprint, events=[])
            return
        result = self._asr.transcribe(pcm)
        if not result["text"]:
            self._publish("voice.utterance", text="", seg_ms=seg_ms,
                          audio_hash=fingerprint, events=[])
            return
        self._publish("voice.transcript", text=result["text"], seg_ms=seg_ms,
                      audio_hash=fingerprint, events=result["events"])

    def _publish(self, ev_type: str, text: str, seg_ms: list[int],
                 audio_hash: str, events: list[str]) -> None:
        ev = {"ts": _now_iso(), "type": ev_type, "source": "mic",
              "text": text, "speaker": "unknown",
              "evidence": {"segment_ms": seg_ms, "audio_hash": audio_hash},
              "meta": {"events": events}}
        if not self._stream.append(ev):
            return
        if self._on_event:
            try:
                self._on_event(ev)
            except Exception as exc:  # noqa: BLE001 - 订阅者故障不杀管线
                _log.warning("on_event 回调异常（忽略）: %s", exc)


def _now_iso() -> str:
    from datetime import datetime
    return datetime.now().isoformat(timespec="milliseconds")
