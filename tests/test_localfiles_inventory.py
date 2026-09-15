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
