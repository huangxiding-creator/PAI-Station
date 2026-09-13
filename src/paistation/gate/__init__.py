"""出口闸/验证资产包（Phase B，P4 支柱）。

- exit：确定性 done token（evidence over narrative）
- selfcheck：记忆自检三套统一入口
- golden_growth：金标准增长管线
"""
from .exit import ExitToken, last_token, read_exits, validate_token, write_exit_token

__all__ = ["ExitToken", "last_token", "read_exits", "validate_token",
           "write_exit_token"]
