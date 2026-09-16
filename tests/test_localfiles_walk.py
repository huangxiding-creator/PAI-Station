"""L0 枚举：walker 真目录 + es.exe 可注入 runner + 自动降级。"""
from datetime import datetime

from paistation.sense.localfiles.domain import ScanDomain
from paistation.sense.localfiles.walk import EverythingEnumerator, WalkerEnumerator, enumerate_files


def _tree(tmp_path):
    root = tmp_path / "proj"
    (root / "docs").mkdir(parents=True)
    (root / "node_modules" / "pkg").mkdir(parents=True)
    (root / "docs" / "a.md").write_text("hello", encoding="utf-8")
    (root / "docs" / "s_secret.txt").write_text("x", encoding="utf-8")
    (root / "node_modules" / "pkg" / "b.js").write_text("x", encoding="utf-8")
    (root / "c.txt").write_text("world", encoding="utf-8")
    return ScanDomain(includes=[str(root)],
                      exclude_names=["node_modules"]), root


def test_walker_enumerates_and_prunes(tmp_path):
    domain, root = _tree(tmp_path)
    records = WalkerEnumerator(workers=2).enumerate(domain)
    paths = {r["path"] for r in records}
    assert str(root / "docs" / "a.md") in paths
    assert str(root / "c.txt") in paths
    assert not any("node_modules" in p for p in paths)  # 整树剪枝
    secret = [r for r in records if r["secret"]]
    assert len(secret) == 1 and secret[0]["path"].endswith("s_secret.txt")
    md = next(r for r in records if r["path"].endswith("a.md"))
    assert md["size"] == 5 and md["mtime"] > 0


def _csv(*rows):
    lines = ["Filename,Size,Date Modified"]
    lines += [f'"{p}",{size},{dm}' for p, size, dm in rows]
    return "\n".join(lines)


def test_everything_backend_with_fake_runner(tmp_path):
    domain, root = _tree(tmp_path)
    target = str(root / "docs" / "a.md")
    es = EverythingEnumerator(
        es_exe="fake://es.exe",
        runner=lambda cmd, **kw: _csv((target, 5, "2026-06-20T13:34:58.5288214")))
    assert es.available
    records = es.enumerate(domain)
    assert [r["path"] for r in records] == [target]
    rec = records[0]
    assert rec["size"] == 5  # CSV 列直取，零 stat
    assert rec["mtime"] == int(datetime(2026, 6, 20, 13, 34, 58).timestamp())


def test_everything_filters_uncovered_paths(tmp_path):
    domain, root = _tree(tmp_path)
    outside = str(tmp_path / "elsewhere" / "x.md")
    es = EverythingEnumerator(
        es_exe="fake://es.exe",
        runner=lambda cmd, **kw: _csv(
            (str(root / "c.txt"), 5, "2026-06-20T13:34:58.5288214"),
            (outside, 5, "2026-06-20T13:34:58.5288214")))
    records = es.enumerate(domain)
    assert [r["path"] for r in records] == [str(root / "c.txt")]


def test_unavailable_backend_falls_back_to_walker(tmp_path):
    domain, _ = _tree(tmp_path)
    records, backend = enumerate_files(
        domain, es=EverythingEnumerator(es_exe=None, runner=lambda *a, **k: ""))
    assert backend == "walker"  # es 缺席（es_exe=None 且 PATH 无 es）
    assert records


def test_everything_failure_degrades(tmp_path, caplog):
    domain, _ = _tree(tmp_path)

    def boom(cmd, **kw):
        raise RuntimeError("es exploded")

    records, backend = enumerate_files(
        domain, es=EverythingEnumerator(es_exe="fake://es.exe", runner=boom))
    assert backend == "walker" and records  # 抖动降级不致命


def test_walker_carries_birthtime_atime(tmp_path):
    domain, root = _tree(tmp_path)
    records = WalkerEnumerator(workers=2).enumerate(domain)
    md = next(r for r in records if r["path"].endswith("a.md"))
    assert md["birthtime"] > 0 and md["atime"] > 0  # 零额外 stat 成本


def _csv5(*rows):
    lines = ["Filename,Size,Date Modified,Date Created,Date Accessed"]
    lines += [f'"{p}",{size},{dm},{dc},{da}' for p, size, dm, dc, da in rows]
    return "\n".join(lines)


def test_everything_csv5_birthtime_atime(tmp_path):
    # 列序真机实证（2026-09-17）：Filename,Size,Date Modified,
    # Date Created,Date Accessed
    domain, root = _tree(tmp_path)
    target = str(root / "docs" / "a.md")
    es = EverythingEnumerator(
        es_exe="fake://es.exe",
        runner=lambda cmd, **kw: _csv5(
            (target, 5, "2026-06-20T13:34:58.5288214",
             "2025-01-01T08:00:00.0000000", "2026-07-01T09:00:00.0000000")))
    rec = es.enumerate(domain)[0]
    assert rec["birthtime"] == int(datetime(2025, 1, 1, 8, 0, 0).timestamp())
    assert rec["atime"] == int(datetime(2026, 7, 1, 9, 0, 0).timestamp())


def test_everything_csv3_backcompat_zero_dates(tmp_path):
    # 老 3 列 CSV（dm-only）：birthtime/atime 缺省 0 不炸
    domain, root = _tree(tmp_path)
    target = str(root / "docs" / "a.md")
    es = EverythingEnumerator(
        es_exe="fake://es.exe",
        runner=lambda cmd, **kw: _csv((target, 5, "2026-06-20T13:34:58.5288214")))
    rec = es.enumerate(domain)[0]
    assert rec["birthtime"] == 0 and rec["atime"] == 0
