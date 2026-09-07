"""M1 文件感知：过滤规则 + 去抖批处理（watchdog Observer 之外的纯逻辑）。"""
from paistation.sense.fs_watcher import BatchBuffer, EventFilter


def make_filter():
    return EventFilter(suffixes={".md", ".txt", ".py"},
                       ignore_patterns=[".git", "node_modules", "*.tmp", "~$*"])


def test_accept_by_suffix():
    f = make_filter()
    assert f.accept(r"C:\docs\a.md")
    assert f.accept(r"C:\docs\b.txt")
    assert not f.accept(r"C:\docs\c.exe")


def test_reject_ignored_patterns():
    f = make_filter()
    assert not f.accept(r"C:\repo\.git\config.md".replace("\\.git\\", "\\.git\\"))
    assert not f.accept(r"C:\repo\node_modules\x\lib.py")
    assert not f.accept(r"C:\docs\draft.tmp")
    assert not f.accept(r"C:\docs\~$report.docx.md")


def test_accept_normalizes_slashes_and_case():
    f = make_filter()
    assert f.accept("C:/Docs/UPPER.MD")


def test_batch_dedup_and_drain():
    b = BatchBuffer(window=2.0)
    b.add("a.md", now=0.0)
    b.add("a.md", now=0.5)   # 重复事件合并
    b.add("b.md", now=1.0)
    assert b.drain(now=0.9) == []          # 窗口未满不出货
    out = b.drain(now=2.6)                 # 窗口满，全量出货
    assert out == ["a.md", "b.md"]
    assert b.drain(now=3.0) == []          # 出货后清空


def test_batch_respects_cap():
    b = BatchBuffer(window=1.0, cap=3)
    for i in range(10):
        b.add(f"f{i}.md", now=0.0)
    out = b.drain(now=2.0)
    assert len(out) == 3  # 超容量丢最旧（防风暴）
    assert out == ["f7.md", "f8.md", "f9.md"]


def test_batch_pending_view():
    b = BatchBuffer(window=1.0)
    b.add("x.md", now=0.0)
    assert b.pending == 1
    b.drain(now=2.0)
    assert b.pending == 0


def test_fswatcher_end_to_end(tmp_path):
    """真 watchdog：写入文件 → 窗口到期 → on_batch 收到路径。"""
    import time as _time
    from paistation.sense.fs_watcher import FsWatcher

    got: list[list[str]] = []
    w = FsWatcher(watch_dirs=[str(tmp_path)], event_filter=make_filter(),
                  on_batch=got.append, window=0.3)
    w.start()
    try:
        (tmp_path / "hello.md").write_text("hi", encoding="utf-8")
        (tmp_path / "noise.exe").write_text("x", encoding="utf-8")
        for _ in range(40):  # 最多等 4s
            _time.sleep(0.1)
            if got:
                break
    finally:
        w.stop()
    assert got and got[0] == [str(tmp_path / "hello.md")]
