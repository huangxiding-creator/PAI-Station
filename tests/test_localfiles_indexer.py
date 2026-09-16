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
    return Indexer(domain, inv, chunks), root


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
