# -*- coding: utf-8 -*-
"""z.ai 站 provider（美元域）。ADR2：与 bigmodel 同构，仅差 base_url/provider 名。"""
from __future__ import annotations

from .base import BaseProvider


class ZaiProvider(BaseProvider):
    name = "zai"
    base_url = "https://api.z.ai"
