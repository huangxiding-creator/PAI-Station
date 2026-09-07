"""M1.2 ingest：guard 只读 → fast json_mode 摘要 → store 落库。"""
import json

import pytest

from paistation.memory.store import MemoryStore
from paistation.sense.ingest import Ingester


class FakeClient:
    def __init__(self, reply: dict):
        self._reply = reply
        self.calls: list[dict] = []

    def fast(self, prompt: str, context: str = "", json_mode: bool = False) -> dict:
        self.calls.append({"prompt": prompt, "json_mode": json_mode,
                           "context_len": len(context)})
        return {"text": json.dumps(self._reply, ensure_ascii=False), "usage": {},
                "confidence": 1.0}


@pytest.fixture
def store(tmp_path):
    s = MemoryStore(str(tmp_path / "memory.db"))
    yield s
    s.close()


@pytest.fixture
def guarded(tmp_path):
    """FileGuard 白名单 = tmp_path 本身。"""
    from paistation.security.audit import AuditLog
    from paistation.security.file_guard import FileGuard
    return FileGuard(allowed_dirs=[str(tmp_path)],
                     audit=AuditLog(str(tmp_path / "audit.db")))


def make_doc(tmp_path, name="doc.md", content="项目周报：本周完成风险排查与复盘。"):
    p = tmp_path / name
    p.write_text(content, encoding="utf-8")
    return str(p)


def test_ingest_happy_path(tmp_path, store, guarded):
    p = make_doc(tmp_path)
    client = FakeClient({"title": "项目周报", "summary": "风险排查与复盘", "score": 0.8})
    ing = Ingester(client=client, guard=guarded, store=store)
    result = ing.ingest_file(p)
    assert result["ok"] is True
    hits = store.search("风险排查")
    assert len(hits) == 1 and hits[0]["title"] == "项目周报"
    assert hits[0]["score"] == 0.8
    # json_mode 开启、正文进入 context
    assert client.calls[0]["json_mode"] is True
    assert client.calls[0]["context_len"] > 0


def test_ingest_rejects_outside_guard(tmp_path, store, guarded):
    client = FakeClient({"title": "x", "summary": "x", "score": 0.5})
    ing = Ingester(client=client, guard=guarded, store=store)
    result = ing.ingest_file("C:/Windows/system32/drivers/etc/hosts")
    assert result["ok"] is False
    assert client.calls == []          # 越界：不读文件也不调 LLM
    assert store.search("x") == []     # 不落库


def test_ingest_bad_json_falls_back(tmp_path, store, guarded):
    p = make_doc(tmp_path)
    client = FakeClient({"title": "t", "summary": "s", "score": 0.5})
    client.fast = lambda *a, **k: {"text": "不是JSON", "usage": {}, "confidence": 1.0}
    ing = Ingester(client=client, guard=guarded, store=store)
    result = ing.ingest_file(p)
    assert result["ok"] is True        # 降级：规则摘要仍落库
    hits = store.search("项目周报")
    assert len(hits) == 1
    assert 0.0 <= hits[0]["score"] <= 1.0


def test_ingest_score_clamped(tmp_path, store, guarded):
    p = make_doc(tmp_path)
    client = FakeClient({"title": "t", "summary": "分数测试", "score": 9.9})
    ing = Ingester(client=client, guard=guarded, store=store)
    assert ing.ingest_file(p)["ok"] is True
    assert store.search("分数测试")[0]["score"] <= 1.0


def test_ingest_batch_skips_missing(tmp_path, store, guarded):
    client = FakeClient({"title": "t", "summary": "s", "score": 0.5})
    ing = Ingester(client=client, guard=guarded, store=store)
    p = make_doc(tmp_path, "real.md")
    results = ing.ingest_batch([p, str(tmp_path / "gone.md")])
    assert len(results) == 2
    assert results[0]["ok"] is True and results[1]["ok"] is False
    assert len(client.calls) == 1      # 只对存在的文件调 LLM
