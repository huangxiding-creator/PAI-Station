"""M1.4 音频采集：块流纯逻辑（重采样/环形缓冲/静默保活判定）。"""
import numpy as np
import pytest

from paistation.sense.audio import (
    BlockRing,
    downmix_resample,
    pcm_to_float,
    rms_db,
)


def _sin(freq, seconds, sr=48000, amp=0.5):
    t = np.arange(int(sr * seconds)) / sr
    return (amp * np.sin(2 * np.pi * freq * t)).astype(np.float32)


# ---- 单位换算（火星轨道器教训：单位显式）----

def test_pcm16_to_float_range():
    pcm = np.array([0, 32767, -32768], dtype=np.int16)
    f = pcm_to_float(pcm)
    assert f.dtype == np.float32
    assert f[0] == 0.0 and pytest.approx(f[1], abs=1e-4) == 1.0
    assert pytest.approx(f[2], abs=1e-4) == -1.0


def test_rms_db_silence_and_loud():
    silent = np.zeros(4800, dtype=np.float32)
    assert rms_db(silent) == -120.0  # 地板
    loud = np.full(4800, 0.5, dtype=np.float32)
    assert -8.0 < rms_db(loud) < -4.0  # 20*log10(0.5)≈-6dB


# ---- 48k 立体声 → 16k 单声道（loopback 通路标准变换单位）----

def test_downmix_resample_stereo_to_16k_mono():
    left = _sin(440, 1.0, sr=48000)
    stereo = np.stack([left, left * 0.5], axis=1)  # (N, 2)
    mono = downmix_resample(stereo, src_rate=48000, dst_rate=16000)
    assert mono.ndim == 1
    assert mono.shape[0] == 16000  # 1 秒 → 16000 样本（±1 块容差）
    # 频率保真：重采样后主频仍是 440Hz（FFT 峰值）
    spec = np.abs(np.fft.rfft(mono))
    peak_hz = np.argmax(spec) * 16000 / len(mono)
    assert 400 < peak_hz < 480


def test_downmix_resample_passthrough_when_same_rate():
    mono_in = _sin(440, 0.5, sr=16000)
    out = downmix_resample(mono_in, src_rate=16000, dst_rate=16000)
    assert out is mono_in  # 同率直通零拷贝


def test_downmix_resample_mono_48k_to_16k():
    x = _sin(1000, 0.5, sr=48000)
    out = downmix_resample(x, src_rate=48000, dst_rate=16000)
    assert abs(out.shape[0] - 8000) <= 2


# ---- 环形缓冲（VAD 前置聚合：毫秒级块 → 秒级窗口）----

def test_ring_append_and_drain_fifo():
    ring = BlockRing(max_seconds=2.0, rate=16000)
    ring.append(np.ones(16000, dtype=np.float32))  # 1s
    ring.append(np.full(8000, 2.0, dtype=np.float32))  # 0.5s
    out = ring.drain()
    assert out.shape == (24000,)
    assert out[0] == 1.0 and out[-1] == 2.0  # FIFO
    assert ring.drain().shape == (0,)  # 排空


def test_ring_evicts_oldest_beyond_capacity():
    ring = BlockRing(max_seconds=1.0, rate=16000)
    ring.append(np.full(16000, 1.0, dtype=np.float32))
    ring.append(np.full(16000, 2.0, dtype=np.float32))  # 超容：挤掉最旧
    out = ring.drain()
    assert out.shape == (16000,)
    assert out[0] == 2.0


def test_ring_snapshot_keeps_data():
    ring = BlockRing(max_seconds=2.0, rate=16000)
    ring.append(np.ones(16000, dtype=np.float32))
    snap = ring.snapshot()
    assert snap.shape == (16000,)
    assert ring.snapshot().shape == (16000,)  # 快照不清空
    assert ring.drain().shape == (16000,)  # 数据还在
