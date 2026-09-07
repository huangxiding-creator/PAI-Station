"""M1 记忆库：SQLite FTS5 存储（upsert 幂等/中文子串检索/统计）。"""
import pytest

from paistation.memory.store import MemoryStore


@pytest.fixture
def store(tmp_path):
    s = MemoryStore(str(tmp_path / "memory.db"))
    yield s
    s.close()


def test_upsert_and_search_chinese(store):
    store.upsert(path="C:/docs/周报.md", title="周报", summary="本周项目风险排查",
                 score=0.8, size=100)
    hits = store.search("风险排查")
    assert len(hits) == 1
    assert hits[0]["path"] == "C:/docs/周报.md"
    assert hits[0]["score"] == 0.8


def test_upsert_idempotent_by_path(store):
    store.upsert(path="a.md", title="旧", summary="旧摘要", score=0.1, size=1)
    store.upsert(path="a.md", title="新", summary="新摘要", score=0.9, size=2)
    hits = store.search("新摘要")
    assert len(hits) == 1
    assert hits[0]["title"] == "新"


def test_search_english_substring(store):
    store.upsert(path="b.py", title="config", summary="zhipu client port", score=0.5, size=1)
    assert store.search("zhipu")[0]["path"] == "b.py"


def test_search_no_hit(store):
    store.upsert(path="c.md", title="t", summary="s", score=0.5, size=1)
    assert store.search("不存在的词组") == []


def test_search_limit(store):
    for i in range(5):
        store.upsert(path=f"f{i}.md", title=f"t{i}", summary="共同关键词", score=0.5, size=1)
    assert len(store.search("共同关键词", limit=3)) == 3


def test_stats_by_suffix_and_dir(store):
    store.upsert(path="C:/docs/a.md", title="a", summary="s", score=0.5, size=10)
    store.upsert(path="C:/docs/b.md", title="b", summary="s", score=0.5, size=20)
    store.upsert(path="C:/code/c.py", title="c", summary="s", score=0.5, size=5)
    stats = store.stats()
    assert stats["total"] == 3
    assert stats["by_suffix"][".md"] == 2
    assert stats["by_suffix"][".py"] == 1
    assert stats["by_dir"]["c:/docs"] == 2


def test_like_fallback_when_no_fts(store):
    """旧 SQLite 回退：强制关 FTS 后 LIKE 仍可中文检索。"""
    store._fts = False
    store.upsert(path="d:/n/备份.md", title="备份", summary="回退检索测试", score=0.5)
    assert store.search("回退检索")[0]["path"] == "d:/n/备份.md"
