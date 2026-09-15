"""P2 chunk 库：trigram 中文检索 + 差分重嵌 + RRF 融合 + 降级。"""
from paistation.sense.localfiles.chunker import CHUNKER_VER, chunk_text
from paistation.sense.localfiles.store import ChunkIndex


def _fake_embedder(text: str) -> list[float]:
    """确定性假嵌入：词袋哈希 → 8 维（不追求语义，只测机制）。"""
    vec = [0.0] * 8
    for ch in text:
        vec[ord(ch) % 8] += 1.0
    norm = sum(v * v for v in vec) ** 0.5 or 1.0
    return [round(v / norm, 6) for v in vec]


LOGIC = f"{CHUNKER_VER}+fake"


def test_chunker_structure_aware():
    text = ("# 项目周报\n\n连接器已落地。\n\n# 下周计划\n\n"
            "开始 P2 语义层建设，包含混合检索与增量重嵌。")
    chunks = chunk_text(text)
    assert len(chunks) >= 2  # 标题切界
    assert chunks[0].startswith("# 项目周报")


def test_chunker_greedy_packing():
    paras = [f"段落{i}内容。" for i in range(30)]
    chunks = chunk_text("\n\n".join(paras))
    assert all(len(c) <= 900 for c in chunks)
    assert "".join(c.replace("\n", "") for c in chunks).count("段落") == 30


def test_fts_chinese_search(tmp_path):
    idx = ChunkIndex(tmp_path / "t.db")  # 无嵌入器 → keyword-only
    idx.upsert_file("a.md", ["本地文件宇宙扫描方案已批准", "无关内容块"], LOGIC)
    hits = idx.search("文件宇宙")
    assert len(hits) == 1 and "扫描方案" in hits[0].text
    assert hits[0].source == "fts"


def test_differential_reembed(tmp_path):
    idx = ChunkIndex(tmp_path / "t.db", embedder=_fake_embedder,
                     embedder_ver="fake")
    texts = ["第一块内容甲", "第二块内容乙", "第三块内容丙"]
    r1 = idx.upsert_file("a.md", texts, LOGIC)
    assert r1["embedded"] == 3 and r1["reused"] == 0
    # 二次写入同内容：全部复用旧向量，零次真嵌（改一字只重嵌一块的地基）
    r2 = idx.upsert_file("a.md", texts, LOGIC)
    assert r2["embedded"] == 0 and r2["reused"] == 3
    # 只改第三块：只嵌 1 块
    r3 = idx.upsert_file("a.md", texts[:2] + ["第三块内容改"], LOGIC)
    assert r3["embedded"] == 1 and r3["reused"] == 2


def test_vec_route_participates_in_rrf(tmp_path):
    idx = ChunkIndex(tmp_path / "t.db", embedder=_fake_embedder,
                     embedder_ver="fake")
    idx.upsert_file("a.md", ["合同评审的流程说明"], LOGIC)
    idx.upsert_file("b.md", ["完全无关的菜谱文本"], LOGIC)
    hits = idx.search("合同评审")  # fts+vec 双路
    assert hits and hits[0].path == "a.md"


def test_embedder_failure_degrades_to_keyword(tmp_path):
    def broken(text: str) -> list[float]:
        raise RuntimeError("embedding service down")

    idx = ChunkIndex(tmp_path / "t.db", embedder=broken, embedder_ver="broken")
    r = idx.upsert_file("a.md", ["降级纪律测试块"], LOGIC)
    assert r["embedded"] == 0  # 失败 → none 状态，块仍在
    hits = idx.search("降级纪律")
    assert hits and hits[0].source == "fts"  # 检索永不 502


def test_stats(tmp_path):
    idx = ChunkIndex(tmp_path / "t.db", embedder=_fake_embedder,
                     embedder_ver="fake")
    idx.upsert_file("a.md", ["块一", "块二"], LOGIC)
    s = idx.stats()
    assert s["chunks"] == 2 and s["files"] == 1 and s["embedder"] == "fake"
