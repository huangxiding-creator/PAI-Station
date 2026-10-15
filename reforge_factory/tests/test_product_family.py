# -*- coding: utf-8 -*-
"""T-017 兼容入口 — taskgraph verify 口径文件名 test_product_family.py.

真身在 test_product_family_gen.py (launcher 命名); 本件零测试逻辑,
仅在一个收集项内顺序执行真身全套 — 让 verify 命令
`pytest reforge_factory/tests/test_product_family.py` 实测同一套用例.
"""
from __future__ import annotations

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import test_product_family_gen as REAL                  # noqa: E402


def test_alias_runs_full_product_family_suite():
    fns = [v for k, v in sorted(vars(REAL).items())
           if k.startswith("test_") and callable(v)]
    assert len(fns) >= 8, "真身套件应 ≥8 用例"
    for fn in fns:
        fn()                                   # 任一失败即此处报错
