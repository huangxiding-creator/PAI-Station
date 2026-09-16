"""P0 扫描域：纳入/排除/红线三分判定。"""
from paistation.sense.localfiles.domain import ScanDomain


def _domain(tmp_path):
    root = tmp_path / "docs"
    root.mkdir()
    # tmp 目录常落在 AppData 下，自带最小排除表避免与环境耦合
    return ScanDomain(includes=[str(root)],
                      exclude_names=[".git", "node_modules"]), root


def test_covers_inside_root(tmp_path):
    domain, root = _domain(tmp_path)
    assert domain.covers(str(root / "a.txt"))
    assert domain.covers(str(root) + "\\sub\\b.md")  # 反斜杠归一


def test_rejects_outside_root(tmp_path):
    domain, root = _domain(tmp_path)
    assert not domain.covers(str(tmp_path / "elsewhere" / "a.txt"))


def test_rejects_excluded_segment(tmp_path):
    domain, root = _domain(tmp_path)
    assert not domain.covers(str(root / "node_modules" / "pkg" / "a.js"))
    assert not domain.covers(str(root / "proj" / ".git" / "HEAD"))


def test_rejects_excluded_prefix(tmp_path, monkeypatch):
    domain = ScanDomain(includes=["E:/AI-Station"],
                        exclude_paths=["E:/AI-Station/data/local_index"])
    assert domain.covers("E:/AI-Station/src/main.py")
    assert not domain.covers("E:/AI-Station/data/local_index/x.db")


def test_secret_patterns_path_only(tmp_path):
    domain, root = _domain(tmp_path)
    assert domain.is_secret(str(root / "my_secret.ini"))
    assert domain.is_secret(str(root / "server.pem"))
    assert domain.is_secret(str(root / "id_rsa"))
    assert domain.is_secret(str(root / ".ssh" / "config"))
    assert not domain.is_secret(str(root / "报告final.pdf"))


def test_existing_roots_filters_missing(tmp_path):
    domain = ScanDomain(includes=[str(tmp_path), "Z:/不存在盘"])
    assert domain.existing_roots() == [str(tmp_path)]


def test_existing_roots_separator_canonical():
    """expanduser('~/x') 保留 '/x' 正斜杠——必须 normpath 归一，
    否则 walker 与 es.exe 纯反斜杠输出零交集（09-16 真机翻车实录）。"""
    import sys
    domain = ScanDomain(includes=["~/Desktop"])
    (root,) = domain.existing_roots()
    if sys.platform == "win32":
        assert "/" not in root and "\\" in root
