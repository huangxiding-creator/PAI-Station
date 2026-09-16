"""P0 清单 + P1 提取缓存：代际差分与缓存命中。"""

from paistation.sense.localfiles.inventory import Inventory, file_hashes


def _rec(path, size=10, mtime=1000.0, secret=0):
    return {"path": path, "size": size, "mtime": mtime, "secret": secret}


def test_first_scan_all_added(tmp_path):
    inv = Inventory(tmp_path / "inv.db")
    diff = inv.apply_scan([_rec("a.txt"), _rec("b.pdf"), _rec("s.pem", secret=1)])
    assert len(diff.added) == 3 and not diff.changed and not diff.gone
    stats = inv.stats()
    assert stats["by_status"]["pending"] == 2
    assert stats["by_status"]["secret"] == 1  # 红线只登记
    inv.close()


def test_second_scan_unchanged_zero_diff(tmp_path):
    inv = Inventory(tmp_path / "inv.db")
    inv.apply_scan([_rec("a.txt")])
    diff2 = inv.apply_scan([_rec("a.txt")])  # size/mtime 全同
    assert not diff2.added and not diff2.changed and not diff2.gone
    inv.close()


def test_mtime_change_marks_changed(tmp_path):
    inv = Inventory(tmp_path / "inv.db")
    inv.apply_scan([_rec("a.txt", mtime=1.0)])
    diff2 = inv.apply_scan([_rec("a.txt", mtime=2.0)])
    assert diff2.changed and diff2.changed[0]["mtime"] == 2.0
    inv.close()


def test_backend_switch_mtime_fraction_tolerated(tmp_path):
    """walker 浮点 mtime → es 整秒 mtime：不得误判「已变更」触发全量重提取。"""
    inv = Inventory(tmp_path / "inv.db")
    inv.apply_scan([_rec("a.txt", mtime=1000.7)])
    diff = inv.apply_scan([_rec("a.txt", mtime=1000)])  # 整秒截断口径
    assert not diff.changed and not diff.added
    row = inv._db.execute(
        "SELECT mtime FROM files WHERE path='a.txt'").fetchone()
    assert row["mtime"] == 1000  # _touch 自愈归一
    inv.close()


def test_skipped_status_sticky_across_rescan(tmp_path):
    """DB 级隔离（WeDrive 占位等）不得被后续扫描无条件打回 pending
    （09-16 双会话实测：占位文件回队即挂起拉云拖死整轮提取）。"""
    inv = Inventory(tmp_path / "inv.db")
    inv.apply_scan([_rec("a.txt", mtime=1.0)])
    inv._db.execute("UPDATE files SET status='skipped' WHERE path='a.txt'")
    inv._db.commit()
    diff = inv.apply_scan([_rec("a.txt", mtime=2.0)])  # 变更行也保持 skipped
    assert diff.changed  # 差分照报
    row = inv._db.execute(
        "SELECT status FROM files WHERE path='a.txt'").fetchone()
    assert row["status"] == "skipped"
    assert [r["path"] for r in inv.pending()] == []  # 队外
    inv.close()


def test_missing_file_marked_gone_not_deleted(tmp_path):
    inv = Inventory(tmp_path / "inv.db")
    inv.apply_scan([_rec("a.txt"), _rec("b.txt")])
    diff2 = inv.apply_scan([_rec("a.txt")])  # b 消失
    assert diff2.gone == ["b.txt"]
    row = inv._db.execute(
        "SELECT status FROM files WHERE path='b.txt'").fetchone()
    assert row["status"] == "gone"  # ADD-only：行保留
    inv.close()


def test_extract_cache_roundtrip(tmp_path):
    inv = Inventory(tmp_path / "inv.db")
    inv.apply_scan([_rec("a.pdf")])
    assert not inv.cache_hit("a.pdf", 10, 1000.0, "pymupdf", "v1")
    inv.mark_extracted("a.pdf", "pymupdf", "v1", "deadbeef", "pdf")
    assert inv.cache_hit("a.pdf", 10, 1000.0, "pymupdf", "v1")
    assert not inv.cache_hit("a.pdf", 10, 1000.0, "pymupdf", "v2")  # 升版本失效
    assert not inv.cache_hit("a.pdf", 11, 1000.0, "pymupdf", "v1")  # size 变失效
    inv.close()


def test_pending_excludes_secret(tmp_path):
    inv = Inventory(tmp_path / "inv.db")
    inv.apply_scan([_rec("a.pdf"), _rec("s.pem", secret=1)])
    paths = [r["path"] for r in inv.pending()]
    assert paths == ["a.pdf"]
    inv.close()


def test_file_hashes_partial_vs_full(tmp_path):
    f = tmp_path / "big.bin"
    f.write_bytes(b"x" * 8192)  # 超 4096 窗口
    partial, full = file_hashes(str(f))
    assert partial != full
    assert len(full) == 64
    # 只改尾部：partial 不变、full 变（初筛省 IO 的意义）
    f.write_bytes(b"x" * 4096 + b"y" * 4096)
    partial2, full2 = file_hashes(str(f))
    assert partial2 == partial and full2 != full


def test_search_paths(tmp_path):
    inv = Inventory(tmp_path / "inv.db")
    inv.apply_scan([_rec("docs/report_final.pdf"), _rec("docs/draft.docx")])
    hits = inv.search_paths("report")
    assert len(hits) == 1 and "report" in hits[0]["path"]
    inv.close()


def test_path_normalization_no_double_write(tmp_path):
    """路径归一：E:\\a\\b 与 E:/a/b 是同一文件，绝不双写（2026-09-17 I 组实查 bug）。"""
    back = "E:" + chr(92) + "a" + chr(92) + "b.txt"
    inv = Inventory(tmp_path / "inv.db")
    inv.apply_scan([_rec(back), _rec("E:/a/b.txt")])
    assert inv.stats()["total_alive"] == 1
    # 跨代形态切换（gen1 反斜杠、gen2 正斜杠）不算 gone 也不算 added
    diff = inv.apply_scan([_rec(back)])
    assert not diff.added and not diff.gone
    inv.close()
