"""液态架构核心包（M8，PROPOSAL_V2.md 第 3 章）。

目录即器官：每个器官有宪法（registry）、液态状态（state）、流转凭证（credential）。
引擎是新陈代谢层，只经凭证与状态与器官交互——R14 禁止直写他器官内部。
"""
from .credential import Credential, append_to_chain, audit_chain, issue, read_chain, verify
from .doctor import check
from .registry import ORGANS, OrganSpec, find, find_by_name, organ_dir
from .state import OrganState, advance_watermark, load_state, save_state, touch

__all__ = [
    "ORGANS", "OrganSpec", "find", "find_by_name", "organ_dir",
    "OrganState", "load_state", "save_state", "touch", "advance_watermark",
    "Credential", "issue", "verify", "append_to_chain", "read_chain", "audit_chain",
    "check",
]
