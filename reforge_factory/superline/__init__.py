# -*- coding: utf-8 -*-
"""superline — 超级生产线 (报告名→顶级研报) 标准件包, P0-P2 38 件落位处.

契约层 contracts 是唯一公共依赖 (常量唯一事实源 + 纯函数校验器 + 指纹);
各阶段件 (s0_gatekeeper/charter_gate/framework_gen/chapter_matrix/...)
按 superline/README.md 任务板逐件进驻. 版本横幅纪律 (杜绝跑旧代码):
每件 CLI 启动必打 superline.__version__.
"""
__version__ = "0.1.0"

from . import contracts  # noqa: F401  (契约层随包即载)
