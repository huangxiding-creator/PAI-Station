"""M2.5 金标准问答集（20 条）：索引→混合检索→pack 注入全链路验收。

金标语义：真实问句必须命中正确文件且关键词进入上下文包——
这是"无限上下文"承诺的可证伪测试，检索质量退化即红。
"""
import json
from pathlib import Path

import pytest

from paistation.memory.embeddings import HashingEmbedder
from paistation.memory.hybrid import FtsRoute, HybridRetriever, VecRoute
from paistation.memory.index import FileIndexer
from paistation.memory.inject import ContextInjector

CORPUS = Path(__file__).parent / "fixtures" / "golden_corpus"
QA = [json.loads(line) for line in
      (Path(__file__).parent / "fixtures" / "golden_qa.jsonl")
      .read_text(encoding="utf-8").splitlines() if line.strip()]


@pytest.fixture(scope="module")
def injector(tmp_path_factory):
    work = tmp_path_factory.mktemp("golden")
    vec = VecRoute(db_path=work / "vec.db", embedder=HashingEmbedder(dim=256))
    fts = FtsRoute(db_path=work / "fts.db")
    FileIndexer(routes=[vec, fts]).scan(CORPUS)
    retriever = HybridRetriever(routes={"vec": vec, "fts": fts})
    return ContextInjector(retriever=retriever)


@pytest.mark.parametrize("item", QA, ids=lambda it: it["q"][:18])
def test_golden_qa(item, injector):
    hits = injector._retriever.retrieve(item["q"], k=5, budget_tokens=3000)
    assert hits, f"零命中: {item['q']}"
    top_paths = [h.path for h in hits[:5]]
    assert any(expect in p for p in top_paths
               for expect in item["expect_paths"]), (
        f"未命中目标文件: {item['q']} -> {top_paths}")
    pack = injector.build(item["q"], k=5, budget_tokens=3000)
    assert item["expect_keyword"] in pack, f"关键词未入包: {item['q']}"


def test_golden_qa_has_twenty_items():
    assert len(QA) == 20
