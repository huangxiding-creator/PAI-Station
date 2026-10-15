# -*- coding: utf-8 -*-
"""reforge_factory/channels: 建渠器 (channel_builder) 落地的渠道适配器包.

T-015 / REQ-029 后半: 每个适配器函数返回统一 Doc 列表
[{title, url, year, abstract_head, source}] (abstract_head = 摘要前 300 字)。
首批 = 学术 API 三件套 (academic.py, 免 key)。
"""
from __future__ import annotations
