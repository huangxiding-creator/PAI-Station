"""M2.5 检索注入接线：FTS 路由+文件索引增量+上下文注入器。"""
from pathlib import Path

import pytest

from paistation.memory.embeddings import HashingEmbedder
from paistation.memory.hybrid import FtsRoute, VecRoute


# ---- FTS5 路由（trigram 分词，中文子串可搜）----

def test_fts_roundtrip_substring_match(tmp_path):
    fts = FtsRoute(db_path=tmp_path / "fts.db")
    fts.upsert([("a.md", "腾讯会议企业版定价方案说明"),
                ("b.md", "周末钓鱼游记")])
    hits = fts.search("企业版定价", k=5)
    assert hits and hits[0].path == "a.md"
    assert hits[0].source == "fts"


def test_fts_upsert_replaces(tmp_path):
    fts = FtsRoute(db_path=tmp_path / "fts.db")
    fts.upsert([("doc.md", "旧内容是水利工程")])
    fts.upsert([("doc.md", "新内容是机器学习部署")])
    assert fts.search("水利工程", k=5) == []
    assert fts.search("机器学习", k=5)[0].path == "doc.md"


def test_fts_short_query_degrades_to_empty(tmp_path):
    """trigram 需 ≥3 字符：两字词查不到不报错（vec 路由兜底）。"""
    fts = FtsRoute(db_path=tmp_path / "fts.db")
    fts.upsert([("a.md", "定价策略相关内容")])
    assert fts.search("定价", k=5) == []


def test_fts_bad_query_never_raises(tmp_path):
    fts = FtsRoute(db_path=tmp_path / "fts.db")
    fts.upsert([("a.md", "内容")])
    assert fts.search('"引号 AND 注入"', k=5) == []


# ---- 文件索引器（mtime 水位线增量）----

def _make_corpus(root: Path) -> None:
    (root / "docs").mkdir(parents=True)
    (root / "docs" / "定价.md").write_text("腾讯会议企业版定价方案", encoding="utf-8")
    (root / "docs" / "游记.md").write_text("西峰山水库钓鱼记录", encoding="utf-8")
    (root / ".git").mkdir()
    (root / ".git" / "config").write_text("git内部文件不应索引", encoding="utf-8")
    (root / "blob.bin").write_bytes(b"\0" * 100)


def test_indexer_scans_and_ignores(tmp_path):
    from paistation.memory.index import FileIndexer

    _make_corpus(tmp_path)
    fts = FtsRoute(db_path=tmp_path / "fts.db")
    stats = FileIndexer(routes=[fts]).scan(tmp_path)
    assert stats["indexed"] == 2          # .git 与 .bin 被剪掉
    hits = fts.search("企业版定价", k=5)
    assert {h.path for h in hits} == {str(tmp_path / "docs" / "定价.md")}
    assert fts.search("git内部文件", k=5) == []


def test_indexer_incremental_skips_unchanged(tmp_path):
    from paistation.memory.index import FileIndexer

    _make_corpus(tmp_path)
    fts = FtsRoute(db_path=tmp_path / "fts.db")
    indexer = FileIndexer(routes=[fts],
                          state_path=tmp_path / "state.json")
    first = indexer.scan(tmp_path)
    second = indexer.scan(tmp_path)       # mtime 未变→零重嵌
    assert first["indexed"] == 2
    assert second["indexed"] == 0
    assert second["skipped_unchanged"] == 2

    target = tmp_path / "docs" / "定价.md"
    target.write_text("更新后的企业版定价与商业版对比", encoding="utf-8")
    third = indexer.scan(tmp_path)
    assert third["indexed"] == 1
    assert fts.search("商业版对比", k=5)[0].path == str(target)


# ---- 上下文注入器（检索→pack 组装）----

def test_injector_builds_context_pack(tmp_path):
    from paistation.memory.inject import ContextInjector

    _make_corpus(tmp_path)
    emb = HashingEmbedder(dim=256)
    vec = VecRoute(db_path=tmp_path / "vec.db", embedder=emb)
    fts = FtsRoute(db_path=tmp_path / "fts.db")
    from paistation.memory.index import FileIndexer
    from paistation.memory.hybrid import HybridRetriever

    FileIndexer(routes=[vec, fts]).scan(tmp_path)
    injector = ContextInjector(retriever=HybridRetriever(routes={"vec": vec, "fts": fts}))
    pack = injector.build("企业版定价方案", k=5, budget_tokens=2000)
    assert "定价.md" in pack
    assert "腾讯会议企业版定价" in pack          # 正文片段已注入
    assert pack.startswith("##")                 # 上下文包契约


def test_injector_empty_when_no_hits(tmp_path):
    from paistation.memory.hybrid import HybridRetriever
    from paistation.memory.inject import ContextInjector

    fts = FtsRoute(db_path=tmp_path / "fts.db")
    injector = ContextInjector(retriever=HybridRetriever(routes={"fts": fts}))
    assert injector.build("不存在的主题词组") == ""
