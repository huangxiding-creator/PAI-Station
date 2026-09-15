"""M7b 意图层：活动 → 意图 最小闭环（分段 → L1 快通道 → 拒识门）。

方法论栈第①②④层（RESEARCH_DOCKET/v3/11-intent-recognition）：
  - segmenter  银甲虫 task-blocks 断块规则 + TaskTracer 资源绑定
  - l1_fast    规则级联快通道（纯本地零 LLM，嵌入召回升级位留 M7c）
  - reject_gate  xvfeng 双层拒识（无关是一等输出，fail-closed）
"""
from .l1_fast import CATEGORIES, CONFIDENCE, classify
from .reject_gate import DEFAULTS, gate
from .segmenter import (
    attach_resources,
    blocks_from_events,
    build_blocks,
    samples_from_events,
)

__all__ = [
    "CATEGORIES", "CONFIDENCE", "classify",
    "DEFAULTS", "gate",
    "attach_resources", "blocks_from_events", "build_blocks",
    "samples_from_events",
]
