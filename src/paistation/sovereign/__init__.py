"""主权层（VISION_V4 P0）：用户数字资产的法定持有层。

markdown 为源、人机双读、append-only 时间线、决策记忆含被否方案、
MANIFEST 指纹可校验、遗忘双时态可审计。
"""
from .format import SOVEREIGN_SPEC_VERSION, build_manifest, vault_validate
from .vault import Decision, DecisionLedger, MemoryEntry, MemoryVault

__all__ = [
    "SOVEREIGN_SPEC_VERSION",
    "build_manifest",
    "vault_validate",
    "Decision",
    "DecisionLedger",
    "MemoryEntry",
    "MemoryVault",
]
