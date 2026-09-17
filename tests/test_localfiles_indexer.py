"""编排器端到端：首扫建缓存 → 二次全扫零解析（P1 验收）。"""
import os
import time

from paistation.sense.localfiles.domain import ScanDomain
from paistation.sense.localfiles.indexer import Indexer
from paistation.sense.localfiles.inventory import Inventory
from paistation.sense.localfiles.store import ChunkIndex


def _make_indexer(tmp_path):
    root = tmp_path / "universe"
    (root / "docs").mkdir(parents=True)
    domain = ScanDomain(includes=[str(root)],
                        exclude_names=["node_modules", ".git"])
    inv = Inventory(tmp_path / "inv.db")
    chunks = ChunkIndex(tmp_path / "idx.db")  # 无嵌入器 → keyword-only
    return Indexer(domain, inv, chunks,
                   events_queue=tmp_path / "usn_queue.jsonl"), root


def test_full_cycle_and_zero_reparse_second_pass(tmp_path):
    ix, root = _make_indexer(tmp_path)
    (root / "docs" / "note.md").write_text(
        "# 项目档案\n\n本地文件宇宙扫描方案已批准执行。", encoding="utf-8")
    (root / "docs" / "data.csv").write_text("a,b\n1,2\n", encoding="utf-8")
    (root / "img.png").write_bytes(b"\x89PNG fake")

    r1 = ix.full_cycle()
    assert r1["added"] == 3 and r1["extracted"] == 2  # png 走 metadata-only
    assert ix._chunks.stats()["chunks"] > 0

    # P1 验收：二次全扫——枚举照跑，解析零次（缓存全命中）
    r2 = ix.full_cycle()
    assert r2["added"] == 0 and r2["changed"] == 0
    assert r2["processed"] == 0  # pending 队列空：无待提取
    ix.close()


def test_modified_file_reextracts_and_rechunks(tmp_path):
    ix, root = _make_indexer(tmp_path)
    f = root / "docs" / "note.md"
    f.write_text("旧内容第一版", encoding="utf-8")
    ix.full_cycle()
    before = ix._chunks.stats()["chunks"]

    f.write_text("新内容第二版，加了更多文字", encoding="utf-8")
    os.utime(f, (time.time() + 5, time.time() + 5))  # mtime 推进触发差分
    r = ix.full_cycle()
    assert r["changed"] == 1 and r["extracted"] == 1
    after = ix._chunks.stats()["chunks"]
    assert ix._chunks.search("第二版")  # 新内容可检索
    assert before >= 1 and after >= 1
    ix.close()


def test_touch_without_content_change_revives_cache(tmp_path):
    ix, root = _make_indexer(tmp_path)
    f = root / "docs" / "note.md"
    f.write_text("稳定内容", encoding="utf-8")
    ix.full_cycle()
    # 只推 mtime 不改内容（touch 场景）：应走缓存复活而非重提取
    os.utime(f, (time.time() + 10, time.time() + 10))
    r = ix.full_cycle()
    assert r["changed"] == 1
    assert r["extracted"] == 0 and r["cached"] == 1  # hash 一致 → 复活
    ix.close()


def test_poison_file_does_not_block_batch(tmp_path):
    ix, root = _make_indexer(tmp_path)
    (root / "bad.pdf").write_bytes(b"totally not a pdf")
    (root / "good.md").write_text("好文件内容", encoding="utf-8")
    r = ix.full_cycle()
    assert r["failed"] == 1 and r["extracted"] == 1  # 毒文件不崩批
    ix.close()


def test_secret_file_registered_not_extracted(tmp_path):
    ix, root = _make_indexer(tmp_path)
    (root / "api_secret.txt").write_text("sk-真密钥不该被索引", encoding="utf-8")
    (root / "普通.md").write_text("正常文件", encoding="utf-8")
    r = ix.full_cycle()
    assert r["extracted"] == 1  # 只有普通文件进了提取
    row = ix._inv._db.execute(
        "SELECT status FROM files WHERE path LIKE '%secret%'").fetchone()
    assert row["status"] == "secret"  # 红线：只登记不提取
    assert ix._chunks.stats()["files"] == 1
    ix.close()


def test_metadata_only_skips_hashing(tmp_path):
    """零解析路由不 hash：大视频/压缩包全量 hash 是纯 IO 浪费。"""
    ix, root = _make_indexer(tmp_path)
    big = root / "video.mp4"
    big.write_bytes(b"\x00" * 8192)
    r = ix.full_cycle()
    assert r["extracted"] == 0  # mp4 = metadata-only，零解析
    row = ix._inv._db.execute(
        "SELECT status, hash_full FROM files WHERE path LIKE '%video%'").fetchone()
    assert row["status"] == "ok" and row["hash_full"] == ""
    ix.close()


def test_parallel_batch_all_ok(tmp_path):
    """并行满水：一批多文件全提取，语义与串行一致。"""
    ix, root = _make_indexer(tmp_path)
    for i in range(12):
        (root / f"p{i}.txt").write_text(f"内容{i}" * 20, encoding="utf-8")
    ix.scan()
    r = ix.extract_pending(200, workers=4)
    assert r["extracted"] == 12 and r["failed"] == 0
    assert len(ix._inv.search_paths("p", limit=20)) >= 12
    ix.close()


def test_hung_file_times_out_without_blocking_batch(
        tmp_path, monkeypatch):
    """滚动窗口收割：一个挂死文件只烧自己的超时预算，其余照常入库
    （头部收割 + fut.cancel，槽位不连坐）。"""
    import paistation.sense.localfiles.indexer as ixmod
    monkeypatch.setattr(ixmod, "EXTRACT_TIMEOUT_S", 0.4)

    real_extract = ixmod.extract  # 先留原函数，补丁后再引用

    def fake_extract(path, kind, parser_id):
        import time as _t
        if "hang" in path:
            _t.sleep(5.0)  # 远超预算
        return real_extract(path, kind, parser_id)

    monkeypatch.setattr(ixmod, "extract", fake_extract)
    ix, root = _make_indexer(tmp_path)
    for i in range(6):
        (root / f"ok{i}.txt").write_text(f"正常{i}" * 10, encoding="utf-8")
    (root / "hang.txt").write_text("挂死文件", encoding="utf-8")
    ix.scan()
    r = ix.extract_pending(200, workers=4)
    assert r["failed"] == 1
    assert r["extracted"] == 6  # 挂死者不连坐
    ix.close()


def test_proc_engine_end_to_end(tmp_path):
    """进程引擎（spawn 真并行）：语义与线程引擎一致，全量入库。"""
    ix, root = _make_indexer(tmp_path)
    for i in range(6):
        (root / f"pr{i}.txt").write_text(f"进程引擎内容{i}" * 15,
                                         encoding="utf-8")
    ix.scan()
    r = ix.extract_pending(200, workers=3, engine="proc")
    assert r["extracted"] == 6 and r["failed"] == 0
    assert any("进程引擎内容" in h.text for h in
               ix._chunks.search("进程引擎内容", k=5))
    ix.close()


# ---------- USN rename 保语义换路径（秒级通道新事件形态） ----------

def _queue_event(tmp_path, ev):
    import json as _json
    with open(tmp_path / "usn_queue.jsonl", "a", encoding="utf-8") as fh:
        fh.write(_json.dumps(ev, ensure_ascii=False) + "\n")


def test_drain_rename_preserves_extraction_state(tmp_path):
    """rename 事件：状态/提取指纹/chunk 全保留，只换路径零重嵌。"""
    ix, root = _make_indexer(tmp_path)
    f = root / "docs" / "note.md"
    f.write_text("工程款支付条件谈判纪要全文", encoding="utf-8")
    ix.full_cycle()
    ix.drain_events()  # 清空本轮可能的 created 事件
    inv = ix._inv
    old = str(f).replace("\\", "/")
    row = inv._db.execute(
        "SELECT status, extracted_at, parser_id FROM files"
        " WHERE path=?", (old,)).fetchone()
    assert row and row["status"] == "ok"
    n_chunks = ix._chunks._db.execute(
        "SELECT COUNT(*) FROM chunks WHERE path=?", (old,)).fetchone()[0]
    assert n_chunks >= 1

    dest = str(root / "docs" / "moved.md").replace("\\", "/")
    _queue_event(tmp_path, {"path": old, "op": "renamed", "dest": dest})
    stats = ix.drain_events()
    assert stats.get("renamed") == 1
    # 库行整行保留只换主键
    row2 = inv._db.execute(
        "SELECT status, extracted_at, parser_id FROM files"
        " WHERE path=?", (dest,)).fetchone()
    assert row2 and row2["status"] == "ok"
    assert row2["extracted_at"] == row["extracted_at"]
    assert inv._db.execute(
        "SELECT COUNT(*) FROM files WHERE path=?", (old,)).fetchone()[0] == 0
    # chunk 跟到新路径，检索仍命中（fts 元前缀已重建）
    assert ix._chunks._db.execute(
        "SELECT COUNT(*) FROM chunks WHERE path=?",
        (dest,)).fetchone()[0] == n_chunks
    assert ix._chunks.search("支付条件谈判")
    ix.close()


def test_drain_rename_unknown_old_falls_to_created(tmp_path):
    """旧路径不在库（域外移入）：新路径按新增走，不炸不丢。"""
    ix, root = _make_indexer(tmp_path)
    dest_file = root / "docs" / "outside.md"
    dest_file.write_text("域外移入的内容", encoding="utf-8")
    dest = str(dest_file).replace("\\", "/")
    _queue_event(tmp_path, {"path": "E:/不存在/旧路径.md",
                            "op": "renamed", "dest": dest})
    stats = ix.drain_events()
    assert stats.get("renamed") is None
    row = ix._inv._db.execute(
        "SELECT status FROM files WHERE path=?", (dest,)).fetchone()
    assert row and row["status"] == "pending"
    ix.close()


def test_walk_records_carry_frn(tmp_path):
    """walk 枚举记录携带 NTFS 引用号（USN 反解钥匙，非零可稳定）。"""
    ix, root = _make_indexer(tmp_path)
    f = root / "docs" / "note.md"
    f.write_text("内容", encoding="utf-8")
    ix.full_cycle()
    row = ix._inv._db.execute(
        "SELECT frn FROM files WHERE path LIKE '%note.md'").fetchone()
    assert row and row["frn"] > 0
    ix.close()
