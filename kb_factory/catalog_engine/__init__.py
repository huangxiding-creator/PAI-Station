# -*- coding: utf-8 -*-
"""catalog_engine（KB-CAT v2）——KB-FACTORY 编目引擎。

纯 Python 3.13 stdlib，零第三方依赖、零 LLM 调用。
输入：需求 JSON {domain, keywords, intent, size_hint}
输出：知识库蓝图 JSON {domain, need, tree, ratio, stats, quote, provenance}

v2 模块：document_engine(文件驱动) + doc_search(多源检索) +
        structure_miner(结构种子) + evidence(证据锚定) + lint(反模式门) +
        corrector(自纠环) + schema_synth(Schema先行) + contract(映射契约) +
        multistore(类型化多库) + ascode(即代码导出)

确定性纪律：全流程无随机源、无时钟依赖；同输入必同输出。
"""
from .engine import build_blueprint, validate_need, ENGINE_VERSION
from . import taxonomy, blueprint, metadata, document_engine, structure_miner
from . import storm_breadth

__all__ = ["build_blueprint", "validate_need", "ENGINE_VERSION",
           "taxonomy", "blueprint", "metadata", "document_engine", "structure_miner",
            "storm_breadth"]
