# -*- coding: utf-8 -*-
"""bigmodel 站 provider（人民币域镜像）。ADR2：与 z.ai 同构，仅差 base_url/provider 名。"""
from __future__ import annotations

from .base import BaseProvider


class BigmodelProvider(BaseProvider):
    name = "bigmodel"
    base_url = "https://open.bigmodel.cn"
