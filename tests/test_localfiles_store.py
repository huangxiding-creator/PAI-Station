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


def test_backfill_reupserted_chunk_not_counted_failed(tmp_path):
    """并发重注册 UNIQUE 回归（2026-09-18 夜 11,329 次白磨实证）：

    提取端把已嵌 chunk 重新注册回 none 态（同 chunk_id）时，
    backfill 重嵌撞 chunks_vec 主键。sqlite_vec 虚拟表不支持
    OR REPLACE 冲突解决会抛 UNIQUE——须吞掉并点亮状态行，
    不得计失败（否则夜夜重试已嵌块，吞吐腰斩）。
    """
    idx = ChunkIndex(tmp_path / "t.db", embedder=_fake_embedder,
                     embedder_ver="fake")
    idx.upsert_file("a.md", ["并发重注册回归块"], LOGIC)
    assert idx.backfill()["embedded"] == 0  # 正常路径已嵌
    # 模拟提取端并发重注册：同 chunk_id 行翻回 none
    idx._db.execute(
        "UPDATE chunks SET embedding_status='none'"
        " WHERE chunk_id=(SELECT chunk_id FROM chunks LIMIT 1)")
    idx._db.commit()
    r = idx.backfill()
    assert r["failed"] == 0
    assert r["rows_lit"] >= 1  # 状态行被点亮而非失败
    st = idx._db.execute(
        "SELECT embedding_status FROM chunks").fetchall()
    assert all(row["embedding_status"] == "embedded" for row in st)
    idx.close()


def _fake_batch_embedder(texts: list[str]) -> list[list[float]]:
    return [_fake_embedder(t) for t in texts]


def test_backfill_fresh_process_precheck_not_blind(tmp_path):
    """夜跑形态回归（2026-09-18 04:17 轮 11,388 次白磨）：补嵌进程
    直接 backfill、进程内从不 upsert——旧版 _vec_ready 惰性置位让
    预检分流整体失效（_vec_has 恒 False），已嵌块真重嵌撞 UNIQUE。
    vec0 表在库即装载（_init_vec_if_present），预检从首批起生效。"""
    import sqlite3

    # 进程 A：正常嵌入（建 vec 表 + 写向量 + 点亮）
    idxA = ChunkIndex(tmp_path / "t.db", embedder=_fake_embedder,
                      embedder_ver="fake")
    idxA.upsert_file("a.md", ["夜跑盲区块甲", "夜跑盲区块乙"], LOGIC)
    idxA.close()
    # 进程间：提取端把状态打回 none（模拟 --no-embed 重注册）
    con = sqlite3.connect(tmp_path / "t.db")
    con.execute("UPDATE chunks SET embedding_status='none'")
    con.commit()
    con.close()
    # 进程 B：全新补嵌进程，嵌入器为哨兵——真被调用即测试失败
    def _must_not_embed(text):
        raise AssertionError("预检失效：向量在库的块被重嵌")

    idxB = ChunkIndex(tmp_path / "t.db", embedder=_must_not_embed,
                      embedder_ver="fake")
    r = idxB.backfill()
    assert r["failed"] == 0 and r["embedded"] == 0 and r["rows_lit"] == 2
    n = idxB._db.execute(
        "SELECT COUNT(*) n FROM chunks"
        " WHERE embedding_status='embedded'").fetchone()["n"]
    assert n == 2
    idxB.close()


def test_backfill_raced_unique_self_heals(tmp_path):
    """UNIQUE 竞态自愈（预检与提交之间被并发者抢先写入）：嵌入器在
    返回前经第二连接写入同 chunk 向量 → 主路提交撞 UNIQUE → 点亮
    计 healed 不计 failed（旧版留 none 态夜夜重试已嵌块）。"""
    import sqlite3
    import sqlite_vec

    from paistation.sense.localfiles.store import _chunk_id

    db = tmp_path / "t.db"
    idxA = ChunkIndex(db, embedder=_fake_embedder, embedder_ver="fake")
    idxA.upsert_file("anchor.md", ["锚点块"], LOGIC)  # 建 vec 表
    idxA.close()
    idxN = ChunkIndex(db)  # 提取端（无嵌入器）新增待嵌块
    idxN.upsert_file("race.md", ["竞态块甲", "竞态块乙"], LOGIC)
    idxN.close()

    def racer(text):  # 并发者：抢先经第二连接写同 chunk 向量
        con = sqlite3.connect(db)
        con.enable_load_extension(True)
        sqlite_vec.load(con)
        con.execute(
            "INSERT INTO chunks_vec(chunk_id, embedding) VALUES(?,?)",
            (_chunk_id(text),
             sqlite_vec.serialize_float32(_fake_embedder(text))))
        con.commit()
        con.close()
        return _fake_embedder(text)

    idx = ChunkIndex(db, embedder=racer, embedder_ver="fake")
    r = idx.backfill()
    assert r["healed"] == 2 and r["failed"] == 0 and r["embedded"] == 0
    n = idx._db.execute(
        "SELECT COUNT(*) n FROM chunks"
        " WHERE embedding_status='none'").fetchone()["n"]
    assert n == 0
    idx.close()


def test_no_embed_reupsert_preserves_embedded(tmp_path):
    """提取侧 none 洪峰根治（2026-09-18 remaining 2.43M→2.70M 实证）：
    --no-embed 夜跑整文件重写不得把向量在库的旧块打回 none——差分
    复用（向量按 chunk_id 存活于 chunks_vec）下沉到提取端。"""
    db = tmp_path / "t.db"
    idxA = ChunkIndex(db, embedder=_fake_embedder, embedder_ver="fake")
    assert idxA.upsert_file(
        "a.md", ["洪峰根治块甲", "洪峰根治块乙"], LOGIC)["embedded"] == 2
    idxA.close()
    idxN = ChunkIndex(db)  # 无嵌入器 = 提取端夜跑形态
    r2 = idxN.upsert_file(
        "a.md", ["洪峰根治块甲", "洪峰根治块乙"], LOGIC)
    st = {row["embedding_status"] for row in idxN._db.execute(
        "SELECT DISTINCT embedding_status FROM chunks")}
    assert st == {"embedded"}  # 不再打回 none
    assert r2["reused"] == 2   # 向量复用如实计数
    assert idxN._pending_count() == 0  # 欠账口径不虚增
    idxN.close()


def test_backfill_tier_priority(tmp_path, monkeypatch):
    """分层选块（2026-09-18 pending 分布定层）：前层不空不落下层——
    高价值语料先上桌，本人痕迹磨完才轮到全局兜底。结果带 tier 留痕。"""
    import paistation.sense.localfiles.store as st

    monkeypatch.setattr(st, "BACKFILL_TIERS", (
        (("gold/*",), ()),
        ((), ()),  # 全局兜底
    ))
    idx0 = ChunkIndex(tmp_path / "t.db")  # 提取端先入库（none 态）
    idx0.upsert_file("bulk/大库文件.md", ["垫底大库块"], LOGIC)
    idx0.upsert_file("gold/本人痕迹.md", ["优先层块甲", "优先层块乙"], LOGIC)
    idx0.close()
    idx = ChunkIndex(tmp_path / "t.db", embedder=_fake_embedder,
                     embedder_ver="fake")
    r1 = idx.backfill(batch=8)
    assert r1["tier"] == 0 and r1["embedded"] == 2  # 只磨优先层
    st_bulk = idx._db.execute(
        "SELECT embedding_status FROM chunks WHERE path LIKE 'bulk%'"
    ).fetchone()
    assert st_bulk["embedding_status"] == "none"  # 垫底块未动
    r2 = idx.backfill(batch=8)  # 优先层已空 → 兜底层
    assert r2["tier"] == 1 and r2["embedded"] == 1
    assert idx._pending_count() == 0
    idx.close()


def test_backfill_slice_size_tunable(tmp_path):
    """--slice 调优杠杆：批嵌每片块数可调（大片摊薄单次推理开销）。"""
    sizes = []

    def spy_batch(texts):
        sizes.append(len(texts))
        return _fake_batch_embedder(texts)

    idx0 = ChunkIndex(tmp_path / "t.db")  # 提取端先入库（none 态）
    idx0.upsert_file("a.md", [f"片大小块{i}" for i in range(6)], LOGIC)
    idx0.close()
    idx = ChunkIndex(tmp_path / "t.db", embedder=_fake_embedder,
                     embedder_ver="fake", batch_embedder=spy_batch)
    r = idx.backfill(batch=64, slice_size=2)
    assert r["embedded"] == 6 and sizes == [2, 2, 2]
    idx.close()


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


# ---------- 查询侧 jieba 分词（无空格中文整串零命中根治） ----------

def test_unsegmented_cjk_query_hits(tmp_path):
    """整串『尾款划抵244』不切分时按 7 字短语 trigram 匹配必零命中。"""
    idx = ChunkIndex(tmp_path / "t.db")
    idx.upsert_file("pay.pdf", ["尾款支付说明：金额 244 万元予以划抵处理"], LOGIC)
    idx.upsert_file("noise.md", ["完全无关的菜谱文本若干"], LOGIC)
    hits = idx.search("尾款划抵244")
    assert hits and hits[0].path == "pay.pdf"


def test_all_two_char_words_rebuild_phrase(tmp_path):
    """全 2 字词查询（工程质量）邻接拼接重建 ≥3 字短语保住 FTS 快路径。"""
    idx = ChunkIndex(tmp_path / "t.db")
    idx.upsert_file("doc.md", ["工程质量问题的整改通知全文"], LOGIC)
    hits = idx.search("工程质量")
    assert hits and hits[0].path == "doc.md"


def test_segment_cjk_ascii_untouched():
    from paistation.sense.localfiles.store import _segment_cjk

    assert _segment_cjk("rrf fuse") == ["rrf fuse"]
    assert _segment_cjk("244") == ["244"]


def test_segment_cjk_expands_phrase():
    from paistation.sense.localfiles.store import _segment_cjk

    out = _segment_cjk("尾款划抵244")
    assert out[0] == "尾款划抵244"  # 原短语保留（精确命中优先）
    assert "244" in out  # 单词进 FTS OR / shorts


def test_segment_cjk_jieba_absent_degrades(monkeypatch):
    """jieba 导入失败 → 原词返回，检索降级不崩（嵌入器同哲学）。"""
    import builtins

    from paistation.sense.localfiles import store as st

    monkeypatch.setattr(st, "_jieba_tried", True)
    monkeypatch.setattr(st, "_jieba_cut", None)
    assert st._segment_cjk("尾款划抵244") == ["尾款划抵244"]

    real_import = builtins.__import__

    def fake_import(name, *a, **k):
        if name == "jieba":
            raise ImportError("no jieba")
        return real_import(name, *a, **k)

    monkeypatch.setattr(st, "_jieba_tried", False)
    monkeypatch.setattr(builtins, "__import__", fake_import)
    assert st._segment_cjk("工程质量问题") == ["工程质量问题"]
    assert st._jieba_cut is None  # 失败记忆：后续调用不再重试导入
