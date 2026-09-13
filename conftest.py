"""pytest 引导：仓库根入 sys.path，使 scripts.* 可被测试导入
（python -m pytest 与裸 pytest 两种调用方式行为一致）。"""
import sys
from pathlib import Path

_ROOT = str(Path(__file__).resolve().parent)
if _ROOT not in sys.path:
    sys.path.insert(0, _ROOT)
