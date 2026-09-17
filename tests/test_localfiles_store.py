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


def test_mixed_long_short_terms_and_filter(tmp_path):
    """混合查询（长词+双字短词）：FTS 候选内 AND 过滤，毫秒级精确
    （09-17 白龟湖实战：『尾款 划抵 244』整串 LIKE 永远零命中）。"""
    idx = ChunkIndex(tmp_path / "t.db")
    idx.upsert_file("pay.pdf", ["尾款支付说明：其余 244 万元从前期支付给贵公司的款项中划抵"], LOGIC)
    idx.upsert_file("noise.md", ["无关文本 244 号宿舍楼施工记录"], LOGIC)
    hits = idx.search("尾款 划抵 244")
    assert len(hits) == 1 and hits[0].path == "pay.pdf"


def test_short_filter_empty_falls_back_to_long_hits(tmp_path):
    """短词过滤后空：退回长词命中保召回（不空手）。"""
    idx = ChunkIndex(tmp_path / "t.db")
    idx.upsert_file("a.md", ["水库大坝安全监测规范正文"], LOGIC)
    hits = idx.search("大坝 安全监测")  # "大坝"不在文本 → 过滤空 → 退回
    assert hits and hits[0].source == "fts"


def test_pure_short_terms_and_then_or(tmp_path):
    """纯双字词：AND 一次扫命中；AND 空走 OR 兜底。"""
    idx = ChunkIndex(tmp_path / "t.db")
    idx.upsert_file("a.md", ["合同里约定了尾款划抵条款"], LOGIC)
    idx.upsert_file("b.md", ["只有尾款字样的另一份"], LOGIC)
    idx.upsert_file("c.md", ["完全无关"], LOGIC)
    assert idx.search("尾款 划抵")[0].path == "a.md"  # AND 命中
    idx2 = ChunkIndex(tmp_path / "t2.db")
    idx2.upsert_file("x.md", ["尾款说明"], LOGIC)
    idx2.upsert_file("y.md", ["划抵说明"], LOGIC)
    hits = idx2.search("尾款 划抵")  # 无同块双词 → OR 兜底
    assert len(hits) == 2


def test_like_wildcards_escaped(tmp_path):
    """查询含 %/_ 字面量：转义后不误当通配符。"""
    idx = ChunkIndex(tmp_path / "t.db")
    idx.upsert_file("a.md", ["进度 100% 完成"], LOGIC)
    idx.upsert_file("b.md", ["进度 9999 完成毫无关系的内容"], LOGIC)
    hits = idx.search("100%")  # % 不当通配 → 只命中字面 100%
    assert len(hits) == 1 and hits[0].path == "a.md"


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


def test_backfill_embeds_stale_none_chunks(tmp_path):
    """存量补嵌：--no-embed 时代入库的 none 块批量点亮；同 chunk_id
    跨文件多行只嵌一次但全部点亮（chunks_vec 主键即去重键）；
    断点=embedding_status，二跑零产出；无嵌入器报错不动库。"""
    # 先无嵌入器入库（模拟 --no-embed 时代）
    idx0 = ChunkIndex(tmp_path / "t.db")
    idx0.upsert_file("a.md", ["共享文本块", "独有块甲"], LOGIC)
    idx0.upsert_file("b.md", ["共享文本块", "独有块乙"], LOGIC)
    idx0.close()
    # 无嵌入器 backfill → 拒跑
    idx1 = ChunkIndex(tmp_path / "t.db")
    assert "error" in idx1.backfill()
    idx1.close()
    # 带嵌入器补嵌：3 个 unique 块（共享块去重）点亮 4 行
    idx = ChunkIndex(tmp_path / "t.db", embedder=_fake_embedder,
                     embedder_ver="fake")
    r = idx.backfill()
    assert r["embedded"] == 3 and r["rows_lit"] == 4
    st = idx._db.execute(
        "SELECT embedding_status, COUNT(*) n FROM chunks"
        " GROUP BY embedding_status").fetchall()
    assert {row["embedding_status"]: row["n"] for row in st} == {"embedded": 4}
    # 语义路由立即可用
    hits = idx.search("共享文本")
    assert hits and {h.path for h in hits} == {"a.md", "b.md"}
    # 断点续跑：二跑零产出
    assert idx.backfill()["embedded"] == 0
    idx.close()


def _fake_batch_embedder(texts: list[str]) -> list[list[float]]:
    return [_fake_embedder(t) for t in texts]


def test_backfill_batch_route_with_poison_fallback(tmp_path):
    """批量补嵌：128/片一次推理；毒片降级逐条救回好块（坏块跳过）。"""
    idx0 = ChunkIndex(tmp_path / "t.db")
    idx0.upsert_file("a.md", [f"批量块{i}的内容文字" for i in range(4)], LOGIC)
    idx0.close()

    calls = {"n": 0}

    def flaky(texts):
        calls["n"] += 1
        if calls["n"] == 1:  # 首片含毒块：整片炸
            raise RuntimeError("GPU OOM on poison chunk")
        return _fake_batch_embedder(texts)

    idx = ChunkIndex(tmp_path / "t.db", embedder=_fake_embedder,
                     embedder_ver="fake", batch_embedder=flaky)
    r = idx.backfill()
    # 首片炸 → 逐条救：好块 embedded，毒块失败跳过
    assert r["embedded"] == 4 and r["failed"] == 0 and calls["n"] >= 2
    assert idx.backfill()["embedded"] == 0  # 断点续跑
    idx.close()
