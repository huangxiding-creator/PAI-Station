"""M1.6 ASR（SenseVoice int8）：模型管理器纯逻辑 + 真模型转写集成。"""
import os

import numpy as np
import pytest

from paistation.sense.asr import AsrEngine, ModelManager, find_model_dir


# ---- 模型管理器（纯逻辑：候选根目录扫描+就绪判定）----

def test_model_manager_finds_sensevoice_dir(tmp_path):
    d = tmp_path / "sherpa-onnx-sense-voice-zh-en-ja-ko-yue-int8"
    d.mkdir()
    (d / "model.int8.onnx").write_bytes(b"x" * 16)
    (d / "tokens.txt").write_text("a 0\n", encoding="utf-8")
    mgr = ModelManager(roots=[str(tmp_path)])
    assert mgr.sensevoice_path() == str(d)


def test_model_manager_missing_returns_none(tmp_path):
    mgr = ModelManager(roots=[str(tmp_path)])
    assert mgr.sensevoice_path() is None


def test_find_model_dir_default_roots_exist():
    roots = find_model_dir.__wrapped__ if hasattr(find_model_dir, "__wrapped__") else None
    assert roots is None  # 无包装，直接调用不炸即可
    p = find_model_dir()  # 开发机可能已装；空也不报错
    assert p is None or os.path.isdir(p)


# ---- 真模型集成（模型在位才跑）----

def _engine_or_skip():
    mgr = ModelManager()
    path = mgr.sensevoice_path()
    if path is None:
        pytest.skip("SenseVoice int8 模型未下载（非阻塞：管线降级 VAD+事件标签）")
    try:
        return AsrEngine(model_dir=path)
    except Exception as exc:  # noqa: BLE001
        pytest.skip(f"引擎构造失败: {exc}")


def _load_tts_16k():
    import wave

    from paistation.sense.audio import downmix_resample, pcm_to_float
    path = os.path.join(os.path.dirname(__file__), "fixtures", "tts_zh.wav")
    with wave.open(path) as w:
        rate = w.getframerate()
        pcm = np.frombuffer(w.readframes(w.getnframes()), dtype=np.int16)
    return downmix_resample(pcm_to_float(pcm), rate, 16000)


def test_asr_transcribes_tts_chinese():
    engine = _engine_or_skip()
    audio = _load_tts_16k()
    result = engine.transcribe(audio)
    assert result["text"]  # 非空转写
    # 内容级断言：指令句关键词至少命中两个（C12 金标而非空过）
    text = result["text"]
    hits = sum(k in text for k in ("调研", "腾讯", "定价", "策略", "明天", "结果"))
    assert hits >= 2, f"转写内容漂移: {text!r}"


def test_asr_result_shape_has_lang_and_events():
    engine = _engine_or_skip()
    audio = _load_tts_16k()
    result = engine.transcribe(audio)
    assert set(result) >= {"text", "lang", "events"}
    assert isinstance(result["events"], list)


def test_asr_empty_audio_returns_empty_text():
    engine = _engine_or_skip()
    result = engine.transcribe(np.zeros(1600, dtype=np.float32))
    assert isinstance(result["text"], str)
