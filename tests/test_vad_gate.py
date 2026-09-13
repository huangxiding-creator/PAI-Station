"""M1.5 VAD 守门：能量分段状态机（纯逻辑）+ silero 集成（模型在位时）。"""
import numpy as np
import pytest

from paistation.sense.audio import rms_db
from paistation.sense.vad_gate import EnergyVad, SpeechSegmenter


def _speech(seconds, sr=16000, amp=0.4):
    t = np.arange(int(sr * seconds)) / sr
    return (amp * np.sin(2 * np.pi * 220 * t)
            * (0.6 + 0.4 * np.sin(2 * np.pi * 3 * t))).astype(np.float32)


def _noise(seconds, sr=16000, amp=0.002):
    rng = np.random.default_rng(42)
    return (rng.normal(0, amp, int(sr * seconds))).astype(np.float32)


def _blocks(x, block_ms=30, sr=16000):
    n = sr * block_ms // 1000
    return [x[i:i + n] for i in range(0, len(x), n)]


# ---- 能量 VAD（纯逻辑）----

def test_energy_vad_speech_vs_noise():
    vad = EnergyVad(threshold_db=-35.0)
    assert vad.feed(_speech(0.5)) is True
    assert vad.feed(_noise(0.5)) is False


# ---- 分段状态机（纯逻辑：挂起/预滚/闭合段）----

def test_segmenter_emits_one_closed_segment():
    seg = SpeechSegmenter(threshold_db=-35.0, preroll_ms=200, hangover_ms=500)
    audio = np.concatenate([_noise(0.5), _speech(1.0), _noise(0.8)])
    events = []
    for b in _blocks(audio):
        events += seg.feed(b)
    kinds = [e["event"] for e in events]
    assert kinds.count("speech_start") == 1
    assert kinds.count("speech_end") == 1
    segs = seg.closed_segments
    assert len(segs) == 1
    s = segs[0]
    # 语音实际区间 500-1500ms；含 200ms 预滚、500ms 挂起尾部
    assert s["start_ms"] <= 500 and s["start_ms"] >= 300   # 预滚回卷
    assert s["end_ms"] >= 1500 and s["end_ms"] <= 2100     # 含挂起


def test_segmenter_two_utterances_with_gap():
    seg = SpeechSegmenter(threshold_db=-35.0, preroll_ms=100, hangover_ms=300)
    audio = np.concatenate([_speech(0.6), _noise(1.2), _speech(0.6)])
    for b in _blocks(audio):
        seg.feed(b)
    seg.flush()  # 流末强制闭合尾段（与生产语义一致）
    assert len(seg.closed_segments) == 2


def test_segmenter_pure_silence_emits_nothing():
    seg = SpeechSegmenter(threshold_db=-35.0)
    for b in _blocks(_noise(3.0)):
        seg.feed(b)
    assert seg.closed_segments == []
    assert seg.speech_ms == 0


def test_segmenter_preroll_rolls_back_into_noise():
    """预滚窗口必须回卷到语音起点之前（不能吃掉词首）。"""
    seg = SpeechSegmenter(threshold_db=-35.0, preroll_ms=240, hangover_ms=200)
    audio = np.concatenate([_noise(1.0), _speech(1.0)])
    for b in _blocks(audio):
        seg.feed(b)
    seg.flush()
    s = seg.closed_segments[0]
    assert s["start_ms"] <= 1000  # 回卷进静音段


def test_segmenter_flush_closes_open_speech():
    seg = SpeechSegmenter(threshold_db=-35.0, preroll_ms=100, hangover_ms=500)
    audio = np.concatenate([_noise(0.5), _speech(1.5)])
    for b in _blocks(audio):
        seg.feed(b)
    assert seg.closed_segments == []          # 挂起未到期：不闭合
    seg.flush()
    assert len(seg.closed_segments) == 1       # flush 强制闭合


def test_segmenter_speech_ms_accumulates():
    seg = SpeechSegmenter(threshold_db=-35.0, preroll_ms=0, hangover_ms=200)
    audio = np.concatenate([_speech(1.0), _noise(1.0)])
    for b in _blocks(audio):
        seg.feed(b)
    seg.flush()
    total = sum(s["end_ms"] - s["start_ms"] for s in seg.closed_segments)
    assert 800 <= total <= 2200  # 约 1s 语音（预滚/挂起容差）
    assert seg.speech_ms > 0


# ---- silero-vad 集成（模型文件在位才跑；CI/无网机器跳过）----

def _silero_model_path():
    import os
    for root in ("models", os.path.expandvars(r"%APPDATA%\PAI-Station\models")):
        p = os.path.join(root, "silero_vad.onnx")
        if os.path.exists(p) and os.path.getsize(p) > 500_000:
            return p
    return None


def _load_tts_fixture():
    """SAPI 合成的真实中文语音（22.05k→16k），无隐私、可入库复跑。"""
    import os
    import wave

    from paistation.sense.audio import downmix_resample, pcm_to_float
    path = os.path.join(os.path.dirname(__file__), "fixtures", "tts_zh.wav")
    if not os.path.exists(path):
        return None
    with wave.open(path) as w:
        rate = w.getframerate()
        pcm = np.frombuffer(w.readframes(w.getnframes()), dtype=np.int16)
    x = downmix_resample(pcm_to_float(pcm), rate, 16000)
    noise = _noise(1.0)
    return np.concatenate([noise, x, noise])


def test_silero_vad_segments_speech():
    path = _silero_model_path()
    audio = _load_tts_fixture()
    if path is None or audio is None:
        pytest.skip("silero 模型或 TTS 夹具缺位（非阻塞：能量 VAD 兜底在位）")
    from paistation.sense.vad_gate import SileroVad
    vad = SileroVad(model_path=path)
    for b in _blocks(audio):
        vad.feed(b)
    vad.flush()
    segs = vad.drain_segments()
    assert len(segs) >= 1
    assert any(s["end_ms"] - s["start_ms"] > 2000 for s in segs)
    # 分段窗内必须真有语音能量（对齐校验，不是随机切）
    for s in segs:
        chunk = audio[int(s["start_ms"]) * 16:int(s["end_ms"]) * 16]
        if len(chunk) > 1600:
            assert rms_db(chunk) > -35.0


def test_silero_missing_model_falls_back(tmp_path, monkeypatch):
    """模型缺失 → 自动退能量 VAD（降级矩阵），不抛异常。"""
    from paistation.sense.vad_gate import make_vad
    vad = make_vad(backend="auto", model_path=tmp_path / "nope.onnx")
    assert isinstance(vad, EnergyVad)
