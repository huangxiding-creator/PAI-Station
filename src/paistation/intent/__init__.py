"""M7 意图层：活动 → 意图（分段 → L1 快通道 → L2 慢通道 → 拒识门 → 记忆/飞轮）。

方法论栈六组件（RESEARCH_DOCKET/v3/11-intent-recognition）：
  - segmenter     银甲虫 task-blocks 断块规则 + TaskTracer 资源绑定
  - l1_fast       规则级联快通道（纯本地零 LLM）
  - l2_slow       LLM 段摘要 + UItron 三档复杂度路由
  - reject_gate   xvfeng 双层拒识（无关是一等输出，fail-closed）
  - intent_memory MIRIX↔profile 五层对接（workflow 层）
  - flywheel      纠正飞轮（晨报修正→样本库→ICL，SummAct 路线）
"""
from .flywheel import IntentSampleStore, build_icl, note_correction
from .intent_memory import recent_intents, record_intent
from .l1_fast import CATEGORIES, CONFIDENCE, classify
from .l2_slow import build_messages, parse_llm_json, route, summarize_block
from .reject_gate import DEFAULTS, gate
from .segmenter import (
    attach_resources,
    blocks_from_events,
    build_blocks,
    samples_from_events,
)

__all__ = [
    "CATEGORIES", "CONFIDENCE", "classify",
    "build_messages", "parse_llm_json", "route", "summarize_block",
    "DEFAULTS", "gate",
    "attach_resources", "blocks_from_events", "build_blocks",
    "samples_from_events",
    "IntentSampleStore", "build_icl", "note_correction",
    "record_intent", "recent_intents",
]
