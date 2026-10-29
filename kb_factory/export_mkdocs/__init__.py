# -*- coding: utf-8 -*-
"""export_mkdocs——蓝图 → mkdocs 预览站点导出（v2.6 #5，KB-FACTORY 波B）。

公开入口：export_mkdocs.exporter.export_mkdocs(bp, out_dir)；
nav 数据单取：export_mkdocs.exporter.build_nav(bp)；
接线说明见 exporter 模块 docstring（收口波统一接线，本模块不碰 engine/blueprint）。
"""
from .exporter import ABOUT_MD, GUIDED_L1_NAME, build_nav, export_mkdocs  # noqa: F401
