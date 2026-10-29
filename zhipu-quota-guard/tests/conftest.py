"""pytest 引导：zhipu-quota-guard 根注入 sys.path，使 zqg 包可被测试导入。

后续所有 zqg 测试任务（T-03+）复用本文件；verify 命令从仓库根以
`python -m pytest zhipu-quota-guard/tests/...` 调用时，本文件保证 import zqg 生效。
"""
import sys
from pathlib import Path

_PKG_ROOT = str(Path(__file__).resolve().parent.parent)
if _PKG_ROOT not in sys.path:
    sys.path.insert(0, _PKG_ROOT)
