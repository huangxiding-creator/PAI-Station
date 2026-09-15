"""M8 感知升级件：屏幕观察档位制（tier 0 无 / 1 OCR / 2 VLM）。

方法论栈第⑦层：hardest 档混杂块的终极证据来源。档位制（UI-TARS
思想）：能力在位才升档，缺件降级不阻塞——与 M6 分发器哲学一致。
隐私红线：前台黑名单窗口（allowed_fn False）→ 零截屏零观察，
提供方根本不被调用（不是截了再丢）。

真实引擎接入位：ocr_fn ← tesseract/PaddleOCR（模型在位后），
vlm_fn ← sense.vision.describe_event(vision_fn, path)。当前默认
tier 0（无引擎在位时意图层照常运转，hardest 档降级纯 LLM）。
"""
from __future__ import annotations

_ENRICH_LIMIT = 4000                    # 屏幕文本入 prompt 上限


def detect_tier(ocr_fn=None, vlm_fn=None) -> int:
    """在位能力 → 档位：2 VLM > 1 OCR > 0 无。"""
    if vlm_fn is not None:
        return 2
    if ocr_fn is not None:
        return 1
    return 0


class ScreenObserver:
    """hardest 档屏幕观察提供方（l2_slow 的 screen 接缝）。"""

    def __init__(self, ocr_fn=None, vlm_fn=None, allowed_fn=None):
        self._ocr = ocr_fn
        self._vlm = vlm_fn
        self._allowed = allowed_fn      # () -> bool（False=前台黑名单）
        self.tier = detect_tier(ocr_fn, vlm_fn)

    def observe(self) -> dict | None:
        """→ {"tier", "text"}；任何缺席/失败/拦截 → None（fail-soft）。"""
        if self.tier == 0:
            return None
        if self._allowed is not None:
            try:
                if not self._allowed():
                    return None         # 隐私红线：提供方零调用
            except Exception:  # noqa: BLE001 - 判定失败保守放弃
                return None
        fn = self._vlm or self._ocr
        try:
            text = (fn() or "").strip()
        except Exception:  # noqa: BLE001 - 引擎失败不杀 L2
            return None
        if not text:
            return None
        return {"tier": self.tier, "text": text[:_ENRICH_LIMIT]}
