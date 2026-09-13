"""M1 感知管线集成：块→VAD→(段)→ASR→事件流，回调零阻塞+暂停语义。"""
import json
import os
import queue
import time

import numpy as np
import pytest

from paistation.sense.pipeline import VoicePipeline
from paistation.sense.voice_events import EventStream


def _tts_16k():
    import wave

    from paistation.sense.audio import downmix_resample, pcm_to_float
    path = os.path.join(os.path.dirname(__file__), "fixtures", "tts_zh.wav")
    if not os.path.exists(path):
        return None
    with wave.open(path) as w:
        rate = w.getframerate()
        pcm = np.frombuffer(w.readframes(w.getnframes()), dtype=np.int16)
    return downmix_resample(pcm_to_float(pcm), rate, 16000)


def _silero_path():
    p = os.path.join("models", "silero_vad.onnx")
    return p if os.path.exists(p) else None


def _blocks(x, ms=30, sr=16000):
    n = sr * ms // 1000
    return [x[i:i + n] for i in range(0, len(x), n)]


def test_pipeline_end_to_end_tts_to_event(tmp_path):
    audio = _tts_16k()
    if audio is None or _silero_path() is None:
        pytest.skip("TTS 夹具或 silero 模型缺位")
    try:
        from paistation.sense.asr import AsrEngine, ModelManager  # noqa: F401
        if ModelManager().sensevoice_path() is None:
            pytest.skip("SenseVoice 模型未下载")
    except Exception:
        pytest.skip("sherpa_onnx 不可用")

    stream = EventStream(data_dir=tmp_path)
    seen = queue.Queue()
    from paistation.sense.asr import ModelManager
    pipe = VoicePipeline(stream=stream, vad_model=_silero_path(),
                         model_dir=ModelManager().sensevoice_path(),
                         on_event=lambda ev: seen.put(ev))
    pipe.start()

    t0 = time.time()
    for b in _blocks(audio):
        pipe._on_block(b)  # 直接喂块（真麦克风在集成探针里验）
    # 无尾静默时段由 stop flush 闭合：短等实时到达，兜底取收尾段
    ev = None
    try:
        ev = seen.get(timeout=5)
    except queue.Empty:
        pass
    pipe.stop()
    if ev is None:
        try:
            ev = seen.get(timeout=5)
        except queue.Empty:
            pass
    assert ev is not None, "喂块+收尾后仍未产出语音事件"
    assert ev["type"] == "voice.transcript"
    assert "调研" in ev["text"] or "腾讯" in ev["text"]
    assert ev["evidence"]["segment_ms"], "证据指针缺失"
    # 落盘校验
    events = stream.read_today()
    assert any(e["text"] == ev["text"] for e in events)
    # 性能（含模型冷加载+推理；FR1 的 10s 口径适用于常驻热引擎的实时段）
    assert time.time() - t0 < 60


def test_pipeline_energy_fallback_without_models(tmp_path):
    """无 silero/无 ASR：管线不炸，产出 voice.utterance（无文本）。"""
    audio = _tts_16k()
    if audio is None:
        pytest.skip("TTS 夹具缺位")
    stream = EventStream(data_dir=tmp_path)
    seen = queue.Queue()
    pipe = VoicePipeline(stream=stream, vad_model=None,
                         on_event=lambda ev: seen.put(ev))
    pipe.start()
    for b in _blocks(audio):
        pipe._on_block(b)
    ev = None
    deadline = time.time() + 10
    while time.time() < deadline:
        try:
            ev = seen.get(timeout=1)
            break
        except queue.Empty:
            continue
    pipe.stop()
    if ev is None:  # 收尾 flush 闭合开口段
        try:
            ev = seen.get(timeout=3)
        except queue.Empty:
            pass
    assert ev is not None
    assert ev["type"] == "voice.utterance"  # 降级：有段无转写
    assert ev["evidence"]["segment_ms"]


def test_pipeline_pause_blocks_processing(tmp_path):
    stream = EventStream(data_dir=tmp_path)
    pipe = VoicePipeline(stream=stream, vad_model=None)
    pipe.start()
    pipe.tick(paused=True)
    assert pipe.paused is True
    x = np.zeros(480, dtype=np.float32)  # 静音块：暂停期直接丢弃
    pipe._on_block(x)
    assert pipe._q.empty()
    pipe.stop()


def test_pipeline_rejects_noise_only(tmp_path):
    """纯噪声 3 秒：不产出任何事件（VAD 守门有效）。"""
    stream = EventStream(data_dir=tmp_path)
    seen = queue.Queue()
    pipe = VoicePipeline(stream=stream, vad_model=None,
                         on_event=lambda ev: seen.put(ev))
    pipe.start()
    rng = np.random.default_rng(3)
    for b in _blocks(rng.normal(0, 0.002, 48000).astype(np.float32)):
        pipe._on_block(b)
    time.sleep(0.5)
    pipe.stop()
    assert seen.empty()
    assert stream.read_today() == []
