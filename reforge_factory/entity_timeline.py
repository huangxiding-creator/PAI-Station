# -*- coding: utf-8 -*-
"""T-007A 兼容 shim — 正体在 completeness/entity_timeline.py (taskgraph
files 清单历史路径 → 转发导入与 CLI, 不另持逻辑)."""
from __future__ import annotations

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))   # reforge_factory/

from completeness.entity_timeline import (            # noqa: E402,F401
    DEFAULT_POOL_ROOT, EVENT_WORDS, apply_waivers, load_existing_waivers,
    load_object_terms, main, scan, write_axis,
)

if __name__ == "__main__":
    sys.exit(main())
