# -*- coding: utf-8 -*-
"""完备性热图生成器 — 兼容入口 (T-009 / REQ-025).

实装在 completeness/heatmap_gen.py (与 cidx.py 同包); 本文件只做转发,
两条导入路径等价:
    from heatmap_gen import render            # reforge_factory 在 sys.path
    from completeness.heatmap_gen import render
"""
from completeness.heatmap_gen import (  # noqa: F401
    APPROVAL,
    AXIS_NAMES,
    DEFAULT_OUT_DIR,
    MARKS,
    STATE_LEGEND,
    STATE_LABELS,
    build_payload,
    render,
    render_md,
)
