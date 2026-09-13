"""M1.4 双路音频采集（03 卷 F 类）：mic=sounddevice / loopback=PyAudioWPatch。

纯逻辑（单位换算/重采样/环形缓冲）与采集薄壳分离：薄壳 lazy-import
音频依赖，本模块在无音频栈机器上仍可导入（打字/文件通道不受损——
降级矩阵"ASR 模型缺失"同款韧性）。
标准单位：管线内一律 float32 [-1,1] 单声道 16kHz；loopback 采集后
立即 downmix_resample 到该单位（显式交接契约）。
"""
from __future__ import annotations

import logging
import threading

import numpy as np

_log = logging.getLogger("paistation.sense.audio")

TARGET_RATE = 16000
PCM_FLOOR_DB = -120.0


# ---- 纯逻辑：单位换算 ----

def pcm_to_float(pcm: np.ndarray) -> np.ndarray:
    """int16 PCM → float32 [-1,1]。"""
    return pcm.astype(np.float32) / 32768.0


def rms_db(x: np.ndarray) -> float:
    """RMS 分贝（满幅=0dB，静音地板 -120dB）。"""
    x = np.asarray(x, dtype=np.float32)
    if x.size == 0:
        return PCM_FLOOR_DB
    rms = float(np.sqrt(np.mean(np.square(x))))
    if rms <= 0.0:
        return PCM_FLOOR_DB
    return max(20.0 * np.log10(rms), PCM_FLOOR_DB)


# ---- 纯逻辑：48k 立体声 → 16k 单声道 ----

def downmix_resample(x: np.ndarray, src_rate: int, dst_rate: int) -> np.ndarray:
    """任意声道/采样率 → 单声道 dst_rate float32。

    src%dst==0 时用块均值（自带粗糙抗混叠）；否则线性插值
    （上采样或非整数比场景，语音频段误差可接受）。
    """
    x = np.asarray(x, dtype=np.float32)
    if x.ndim == 2:  # (N, ch) → 声道均值单声道
        x = x.mean(axis=1)
    if src_rate == dst_rate:
        return x
    n_src = x.shape[0]
    n_dst = int(round(n_src * dst_rate / src_rate))
    if src_rate % dst_rate == 0 and n_dst > 0:
        # 块均值下采样（如 48000→16000 ÷3）
        usable = n_dst * (src_rate // dst_rate)
        return x[:usable].reshape(n_dst, src_rate // dst_rate).mean(axis=1)
    t_src = np.arange(n_src, dtype=np.float64) / src_rate
    t_dst = np.arange(n_dst, dtype=np.float64) / dst_rate
    return np.interp(t_dst, t_src, x).astype(np.float32)


# ---- 纯逻辑：环形缓冲（毫秒块 → 秒级窗口聚合）----

class BlockRing:
    """定容 FIFO：超容丢最旧（防内存膨胀），drain 排空/snapshot 不清。"""

    def __init__(self, max_seconds: float, rate: int = TARGET_RATE):
        self._cap = int(max_seconds * rate)
        self._rate = rate
        self._parts: list[np.ndarray] = []
        self._lock = threading.Lock()

    def append(self, block: np.ndarray) -> None:
        with self._lock:
            self._parts.append(np.asarray(block, dtype=np.float32))
            self._trim()

    def _concat(self) -> np.ndarray:
        return (np.concatenate(self._parts) if self._parts
                else np.zeros(0, dtype=np.float32))

    def drain(self) -> np.ndarray:
        with self._lock:
            out = self._concat()
            self._parts = []
            return out

    def snapshot(self) -> np.ndarray:
        with self._lock:
            return self._concat()

    def _trim(self) -> None:
        total = sum(p.shape[0] for p in self._parts)
        while total > self._cap and self._parts:
            drop = self._parts.pop(0)
            total -= drop.shape[0]


# ---- 采集薄壳（lazy-import，可注入式测试）----

class MicSource:
    """sounddevice 麦克风：16k 单声道 int16 块 → float32 on_block。"""

    def __init__(self, block_ms: int = 30):
        self._block_ms = block_ms
        self._stream = None

    def start(self, on_block) -> None:
        import sounddevice as sd

        blocksize = TARGET_RATE * self._block_ms // 1000
        self._stream = sd.InputStream(
            samplerate=TARGET_RATE, channels=1, dtype="int16",
            blocksize=blocksize,
            callback=lambda pcm, frames, t, st: on_block(pcm_to_float(pcm[:, 0])))
        self._stream.start()
        _log.info("MicSource 启动: %dms 块", self._block_ms)

    def stop(self) -> None:
        if self._stream:
            self._stream.stop()
            self._stream.close()
            self._stream = None


class LoopbackSource:
    """PyAudioWPatch WASAPI 环回：系统声 → downmix_resample → on_block。

    注意：系统静默时 WASAPI loopback 不吐块（03 卷已知坑）——上层
    SilentLoopKeeper 负责渲染不可闻静音维持数据流。
    """

    def __init__(self, block_ms: int = 30):
        self._block_ms = block_ms
        self._pyaudio = None
        self._stream = None

    def start(self, on_block) -> None:
        import pyaudiowpatch as pyaudio

        self._pyaudio = pyaudio.PyAudio()
        wasapi = self._pyaudio.get_default_wasapi_loopback()
        info = self._pyaudio.get_device_info_by_index(wasapi["index"])
        src_rate = int(info["defaultSampleRate"])
        channels = min(int(info["maxInputChannels"]), 2) or 2

        def callback(in_data, frame_count, time_info, status):
            pcm = np.frombuffer(in_data, dtype=np.int16)
            if channels > 1:
                pcm = pcm.reshape(-1, channels)
            on_block(downmix_resample(pcm_to_float(pcm), src_rate, TARGET_RATE))
            return (None, pyaudio.paContinue)

        self._stream = self._pyaudio.open(
            format=pyaudio.paInt16, channels=channels, rate=src_rate,
            input=True, output=False, stream_callback=callback,
            input_device_index=int(info["index"]))
        self._stream.start_stream()
        _log.info("LoopbackSource 启动: %dHz %dch → 16k mono",
                  src_rate, channels)

    def stop(self) -> None:
        if self._stream:
            self._stream.stop_stream()
            self._stream.close()
            self._stream = None
        if self._pyaudio:
            self._pyaudio.terminate()
            self._pyaudio = None


class SilentLoopKeeper:
    """静默保活：极低振幅渲染维持 WASAPI loopback 数据流（线程薄壳）。"""

    def __init__(self, amp: float = 1e-4, rate: int = 48000):
        self._amp = amp
        self._rate = rate
        self._stream = None

    def start(self) -> None:
        import numpy as _np
        import sounddevice as sd

        def gen():
            block = _np.full(1024, self._amp, dtype=_np.float32)
            while True:
                yield block.reshape(-1, 1)

        self._stream = sd.OutputStream(samplerate=self._rate, channels=1,
                                       dtype="float32", blocksize=1024)
        self._stream.start()
        threading.Thread(target=self._feed, args=(sd,), daemon=True).start()

    def _feed(self, sd) -> None:
        block = np.full(1024, self._amp, dtype=np.float32).reshape(-1, 1)
        while self._stream and self._stream.active:
            self._stream.write(block)

    def stop(self) -> None:
        if self._stream:
            self._stream.stop()
            self._stream.close()
            self._stream = None
