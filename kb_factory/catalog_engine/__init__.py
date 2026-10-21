# -*- coding: utf-8 -*-
"""catalog_engine（KB-CAT v1）——KB-FACTORY 编目引擎。

纯 Python 3.13 stdlib，零第三方依赖、零 LLM 调用。
输入：需求 JSON {domain, keywords, intent, size_hint}
输出：知识库蓝图 JSON {domain, need, tree, ratio, stats, quote, provenance}

确定性纪律：全流程无随机源、无时钟依赖；同输入必同输出。
如未来需要抖动，一律以 sha256(规范化输入 JSON) 为种子（见 engine.need_hash8），
禁止 random/randomize 无种子使用。
"""
from .engine import build_blueprint, validate_need, ENGINE_VERSION
from . import taxonomy, blueprint, metadata

__all__ = ["build_blueprint", "validate_need", "ENGINE_VERSION",
           "taxonomy", "blueprint", "metadata"]
