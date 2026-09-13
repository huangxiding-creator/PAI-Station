"""M1.6 ASR（03 卷 A 类，ADR-5）：SenseVoice-Small int8 CPU 常开转写。

升级位：Fun-ASR-Nano GGUF（llama.cpp 单二进制）——本模块接口
`transcribe(pcm16k) -> {text, lang, events[]}` 保持不变，后端可换。
模型缺失时上层降级（VAD+事件标签），本模块不提供假实现。
"""
from __future__ import annotations

import logging
import os

import numpy as np

_log = logging.getLogger("paistation.sense.asr")

RATE = 16000
SENSEVOICE_DIR_PREFIX = "sherpa-onnx-sense-voice"
DEFAULT_ROOTS = (
    "models",
    os.path.expandvars(r"%APPDATA%\PAI-Station\models"),
)


class ModelManager:
    """候选根目录扫描：SenseVoice int8 目录就绪判定（model.int8.onnx+tokens）。"""

    def __init__(self, roots: tuple[str, ...] | list[str] | None = None):
        self._roots = tuple(roots) if roots else DEFAULT_ROOTS

    def sensevoice_path(self) -> str | None:
        for root in self._roots:
            try:
                entries = sorted(os.listdir(root))
            except OSError:
                continue
            for name in entries:
                if not name.startswith(SENSEVOICE_DIR_PREFIX):
                    continue
                d = os.path.join(root, name)
                if (os.path.isfile(os.path.join(d, "model.int8.onnx"))
                        and os.path.isfile(os.path.join(d, "tokens.txt"))):
                    return d
        return None


def find_model_dir() -> str | None:
    """默认根扫描（开发 models/ 与用户 %APPDATA% 双位）。"""
    return ModelManager().sensevoice_path()


class AsrEngine:
    """sherpa-onnx OfflineRecognizer(SenseVoice) 薄壳。

    线程数按硬件保守取 2（8GB 档可跑）；int8 量化模型。
    """

    def __init__(self, model_dir: str, num_threads: int = 2):
        import sherpa_onnx

        # sherpa-onnx 1.13.x：工厂方法构造（int8 模型路径直传）
        self._recognizer = sherpa_onnx.OfflineRecognizer.from_sense_voice(
            model=os.path.join(model_dir, "model.int8.onnx"),
            tokens=os.path.join(model_dir, "tokens.txt"),
            num_threads=num_threads,
            language="",
            use_itn=True,
        )
        _log.info("AsrEngine 就绪: %s (threads=%d)", model_dir, num_threads)

    def transcribe(self, pcm16k: np.ndarray) -> dict:
        """整段转写（VAD 闭合段粒度）。返回 {text, lang, events}。"""
        samples = np.ascontiguousarray(pcm16k, dtype=np.float32)
        stream = self._recognizer.create_stream()
        stream.accept_waveform(RATE, samples)
        self._recognizer.decode_stream(stream)
        text = (stream.result.text or "").strip()
        # SenseVoice 输出带 <|zh|><|NEUTRAL|> 等标签前缀——剥离
        clean = self._strip_tags(text)
        return {"text": clean, "lang": "zh",
                "events": self._extract_events(clean)}

    @staticmethod
    def _strip_tags(text: str) -> str:
        out = []
        for part in text.replace("<", "\n<").split("\n"):
            part = part.strip()
            if not part.startswith("<|") and not part.startswith("<"):
                out.append(part)
        return "".join(out).strip()

    @staticmethod
    def _extract_events(text: str) -> list[str]:
        """指令句里的显式事件线索（轻量规则层；LLM 任务卡在 proactive 层）。"""
        events = []
        if any(k in text for k in ("调研", "查一下", "搜一下", "研究")):
            events.append("intent.research")
        if any(k in text for k in ("明天", "今天", "下午", "上午", "点之前", "之前")):
            events.append("has_deadline")
        if any(k in text for k in ("帮我", "帮忙", "给我")):
            events.append("intent.delegate")
        return events
