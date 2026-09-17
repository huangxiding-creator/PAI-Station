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


def test_gone_file_resurrects_on_reappearance(tmp_path):
    """后端覆盖差自愈：gone 行再次被扫到（内容未变）→ 回待处理，
    不留僵尸盲区（2026-09-17 walker/es 差 6,119 行 gone 实锤）。"""
    inv = Inventory(tmp_path / "inv.db")
    inv.apply_scan([_rec("a.txt"), _rec("key.pem", secret=1)])
    inv.apply_scan([])  # 全消失
    # 原样重现：内容未变走 _touch 路径
    inv.apply_scan([_rec("a.txt"), _rec("key.pem", secret=1)])
    st = {r["path"]: r["status"] for r in inv._db.execute(
        "SELECT path, status FROM files")}
    assert st["a.txt"] == "pending"  # 复活回队
    assert st["key.pem"] == "secret"  # secret 复活仍守红线
    assert [r["path"] for r in inv.pending()] == ["a.txt"]
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


def test_scan_stores_birthtime_atime(tmp_path):
    """NTFS 三时间戳（K）：创建/访问时间随扫描入库，变更行与 touch 均刷新。"""
    inv = Inventory(tmp_path / "inv.db")
    inv.apply_scan([_rec_ts("a.txt", birthtime=900.0, atime=1100.0)])
    row = inv._db.execute(
        "SELECT birthtime, atime FROM files WHERE path='a.txt'").fetchone()
    assert row["birthtime"] == 900.0 and row["atime"] == 1100.0
    # 不带时间字段的记录缺省 0（老后端兼容）
    inv.apply_scan([_rec("b.txt")])
    row = inv._db.execute(
        "SELECT birthtime FROM files WHERE path='b.txt'").fetchone()
    assert row["birthtime"] == 0
    # 变更行刷新
    inv.apply_scan([_rec_ts("a.txt", size=11, mtime=1001.0, atime=1200.0)])
    assert inv._db.execute(
        "SELECT atime FROM files WHERE path='a.txt'").fetchone()["atime"] == 1200.0
    # 不变行 touch 也刷新（访问时间随时在变）
    inv.apply_scan([_rec_ts("a.txt", size=11, mtime=1001.0, atime=1300.0)])
    assert inv._db.execute(
        "SELECT atime FROM files WHERE path='a.txt'").fetchone()["atime"] == 1300.0
    inv.close()


def _rec_ts(path, size=10, mtime=1000.0, birthtime=0.0, atime=0.0):
    return {"path": path, "size": size, "mtime": mtime, "secret": 0,
            "birthtime": birthtime, "atime": atime}


# ---------- 秒级事件通道（09-17 live-watch 线） ----------

def test_apply_event_lifecycle(tmp_path):
    """added→changed→touched→deleted 四态；skipped/secret 行守护。"""
    import os

    from paistation.sense.localfiles.inventory import Inventory

    inv = Inventory(tmp_path / "inv.db")
    f = tmp_path / "新文件.txt"
    f.write_text("v1")
    st = os.stat(f)
    rec = {"path": str(f), "size": st.st_size, "mtime": int(st.st_mtime),
           "secret": 0}
    assert inv.apply_event(rec, "created") == "added"
    assert [r["path"] for r in inv.pending()] == [
        str(f).replace(chr(92), "/")]
    # 内容变 → changed 回 pending
    f.write_text("v2 变更")
    st = os.stat(f)
    rec2 = {"path": str(f), "size": st.st_size, "mtime": int(st.st_mtime),
            "secret": 0}
    assert inv.apply_event(rec2, "modified") == "changed"
    # 未变 → touched（不回队）
    assert inv.apply_event(rec2, "modified") == "touched"
    assert inv.apply_event({"path": str(f)}, "deleted") == "gone"
    row = inv._db.execute(
        "SELECT status FROM files WHERE path=?", (str(f).replace(
            chr(92), "/"),)).fetchone()
    assert row["status"] == "gone"
    inv.close()


def test_apply_event_never_flags_others_gone(tmp_path):
    """单行补丁语义：apply_event 绝不把未提及行标 gone。"""
    from paistation.sense.localfiles.inventory import Inventory

    inv = Inventory(tmp_path / "inv.db")
    inv.apply_scan([_rec("a.txt")])
    inv.apply_event({"path": "b.txt", "size": 1, "mtime": 1}, "created")
    st = {r["path"]: r["status"] for r in inv._db.execute(
        "SELECT path, status FROM files")}
    assert st["a.txt"] == "pending"  # 未被误伤
    inv.close()


def test_drain_events_offset_and_semantics(tmp_path):
    """jsonl 续读 + offset 推进 + deleted/moved/瞬时文件语义。"""
    import json as j

    from paistation.sense.localfiles.domain import ScanDomain
    from paistation.sense.localfiles.indexer import Indexer
    from paistation.sense.localfiles.inventory import Inventory
    from paistation.sense.localfiles.store import ChunkIndex

    q = tmp_path / "usn_queue.jsonl"
    inv = Inventory(tmp_path / "inv.db")
    ix = Indexer(ScanDomain(), inv, ChunkIndex(tmp_path / "idx.db"),
                 events_queue=q)
    live = tmp_path / "实况.txt"
    live.write_text("现场记录")
    dead = tmp_path / "已删.txt"
    dead.write_text("待删除")  # 真实存在才过 stat（瞬时文件会被跳过）
    with q.open("a", encoding="utf-8") as fh:
        fh.write(j.dumps({"ts": 1, "op": "created", "path": str(live)}) + '\n')
        fh.write(j.dumps({"ts": 2, "op": "created",
                          "path": str(dead)}) + '\n')
    st1 = ix.drain_events()
    assert st1.get("added") == 2
    # 第二轮：dead 删除 + 幽灵路径（stat 失败）+ moved
    with q.open("a", encoding="utf-8") as fh:
        fh.write(j.dumps({"ts": 3, "op": "deleted", "path": str(dead)}) + '\n')
        fh.write(j.dumps({"ts": 4, "op": "created",
                          "path": str(tmp_path / "幽灵.txt")}) + '\n')
    st2 = ix.drain_events()
    assert st2.get("gone") == 1 and "幽灵" not in str(st2)
    # offset 推进：三跑零新事件
    assert ix.drain_events() == {}
    row = inv._db.execute("SELECT status FROM files WHERE path=?",
                          (str(dead).replace(chr(92), "/"),)).fetchone()
    assert row["status"] == "gone"
    ix.close()
