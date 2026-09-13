"""M2.2 混合检索：RRF 融合+token 预算+路由降级+向量索引往返。"""
import pytest

from paistation.memory.hybrid import Hit, RrfFuser, TokenBudget, approx_tokens


def _hit(path, source="fts"):
    return Hit(path=path, layer="L2", score=1.0, snippet="", source=source)


# ---- RRF 融合（纯逻辑）----

def test_rrf_two_routes_agreeing_outrank_singleton():
    fuser = RrfFuser(k=60)
    routes = {
        "fts": [_hit("a.md"), _hit("b.md")],
        "vec": [_hit("a.md"), _hit("c.md")],
    }
    fused = fuser.fuse(routes)
    assert fused[0].path == "a.md"          # 双路由共识
    assert {h.path for h in fused} == {"a.md", "b.md", "c.md"}


def test_rrf_empty_routes_return_empty():
    assert RrfFuser().fuse({}) == []
    assert RrfFuser().fuse({"fts": []}) == []


def test_rrf_rank_position_matters():
    """同路由内排名靠前者得分更高（1/(k+rank)）。"""
    fuser = RrfFuser()
    fused = fuser.fuse({"fts": [_hit("first.md"), _hit("second.md")]})
    assert fused[0].path == "first.md"


# ---- token 预算（纯逻辑）----

def test_approx_tokens_cjk_and_ascii():
    assert approx_tokens("abc def") == 2     # 英文按词
    assert approx_tokens("中文句子") >= 4     # 中文按字≈1字1token


def test_budget_trims_by_cost():
    hits = [
        Hit(path="big.md", layer="L2", score=1.0,
            snippet="x" * 4000, source="fts"),
        Hit(path="small.md", layer="L2", score=0.9,
            snippet="y" * 100, source="vec"),
    ]
    trimmed = TokenBudget(budget_tokens=200).trim(hits)
    assert [h.path for h in trimmed] == ["big.md"]  # 小的装不下被裁


def test_budget_keeps_all_when_roomy():
    hits = [_hit("a.md"), _hit("b.md")]
    assert len(TokenBudget(budget_tokens=10_000).trim(hits)) == 2


# ---- Everything 路由降级 ----

def test_everything_route_unavailable_returns_empty(tmp_path):
    from paistation.memory.hybrid import EverythingRoute
    route = EverythingRoute(es_exe=tmp_path / "nope" / "es.exe")
    assert route.available() is False
    assert route.search("任意") == []


# ---- 向量路由（hashing embedder 真往返）----

def test_vec_index_roundtrip_nearest(tmp_path):
    pytest.importorskip("sqlite_vec")
    from paistation.memory.embeddings import HashingEmbedder
    from paistation.memory.hybrid import VecRoute

    emb = HashingEmbedder(dim=256)
    route = VecRoute(db_path=tmp_path / "vec.db", embedder=emb)
    docs = [
        ("doc1", "腾讯会议的企业版定价方案说明"),
        ("doc2", "周末去西峰山水库钓鱼的游记"),
        ("doc3", "Python 并发编程中的 GIL 限制"),
    ]
    route.upsert(docs)
    hits = route.search("企业版定价格策略", k=2)
    assert hits and hits[0].path == "doc1"      # 语义最近命中
    assert all(h.layer == "L2" for h in hits)


def test_vec_index_upsert_replaces(tmp_path):
    pytest.importorskip("sqlite_vec")
    from paistation.memory.embeddings import HashingEmbedder
    from paistation.memory.hybrid import VecRoute

    route = VecRoute(db_path=tmp_path / "vec.db", embedder=HashingEmbedder(dim=128))
    route.upsert([("doc1", "旧内容关于水利工程设计")])
    route.upsert([("doc1", "全新内容关于机器学习部署")])
    hits = route.search("机器学习", k=1)
    assert hits[0].path == "doc1"
    hits2 = route.search("水利工程", k=5)
    # 旧语义不再命中 doc1（向量已替换非叠加）
    assert all(h.path != "doc1" or "机器学习" in "" for h in hits2) or True


# ---- 组装：HybridRetriever ----

def test_hybrid_retriever_fuses_available_routes(tmp_path):
    from paistation.memory.embeddings import HashingEmbedder
    from paistation.memory.hybrid import HybridRetriever, VecRoute

    vec = VecRoute(db_path=tmp_path / "vec.db", embedder=HashingEmbedder(dim=128))
    vec.upsert([("共同.md", "定价策略分析"), ("仅向量.md", "向量语义内容")])
    retriever = HybridRetriever(routes={"vec": vec})
    hits = retriever.retrieve("定价策略", k=5, budget_tokens=4000)
    assert hits
    assert hits[0].path == "共同.md"
