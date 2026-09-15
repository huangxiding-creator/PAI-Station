"""L0 枚举：walker 真目录 + es.exe 可注入 runner + 自动降级。"""
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


def test_everything_backend_with_fake_runner(tmp_path):
    domain, root = _tree(tmp_path)
    target = str(root / "docs" / "a.md")
    es = EverythingEnumerator(
        es_exe="fake://es.exe", runner=lambda cmd, **kw: f'"{target}"\n')
    assert es.available
    records = es.enumerate(domain)
    assert [r["path"] for r in records] == [target]


def test_everything_filters_uncovered_paths(tmp_path):
    domain, root = _tree(tmp_path)
    outside = str(tmp_path / "elsewhere" / "x.md")
    es = EverythingEnumerator(
        es_exe="fake://es.exe",
        runner=lambda cmd, **kw: f'"{str(root / "c.txt")}"\n"{outside}"\n')
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
