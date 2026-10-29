# -*- coding: utf-8 -*-
"""corpus_align（KB-FACTORY v2.7 #14）——BERTopic 语料对齐校验腿。

独立于 catalog_engine（引擎 stdlib-only 宪法不破）；重依赖惰性化：
bertopic/sentence-transformers/torch 任一缺席 → align_corpus fail-soft
返回 {available: False, reason}，绝不崩、绝不自动安装（装齐自动启用）。

用法：
    from corpus_align import align_corpus
    report = align_corpus(整库文档列表, 蓝图JSON)
    report["blind_spots"]   # 盲区清单：语料成簇但蓝图 L2 接不住 → 建议加目录
    report["outliers"]      # 待归位清单：BERTopic 判离群的文档
    report["available"] is False 时看 report["reason"]（依赖缺席/语料不足/网络受限）
"""
from .aligner import (DEFAULT_LEX_WEIGHT, DEFAULT_MATCH_THRESHOLD, DEFAULT_MODEL, MIN_DOCS,
                      REQUIRED_DEPS, align_corpus, bigram_jaccard, doc_name, doc_text,
                      iter_l2, match_clusters_to_l2, probe_deps)

__all__ = ["align_corpus", "probe_deps", "iter_l2", "bigram_jaccard", "match_clusters_to_l2",
           "doc_text", "doc_name", "REQUIRED_DEPS", "DEFAULT_MODEL",
           "DEFAULT_MATCH_THRESHOLD", "DEFAULT_LEX_WEIGHT", "MIN_DOCS"]
