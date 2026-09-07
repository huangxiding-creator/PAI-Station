"""M0.4 白名单守卫：越界读被拒并留痕（锚点 0.5）。"""
import pytest

from paistation.security.audit import AuditLog
from paistation.security.file_guard import FileGuard, GuardViolation


@pytest.fixture
def dirs(tmp_path):
    inside = tmp_path / "vault"
    inside.mkdir()
    outside = tmp_path / "secret"
    outside.mkdir()
    (inside / "doc.md").write_text("内容", encoding="utf-8")
    (outside / "key.pem").write_text("k", encoding="utf-8")
    return inside, outside


def test_inside_passes(dirs):
    guard = FileGuard([str(dirs[0])])
    real = guard.check(str(dirs[0] / "doc.md"))
    assert real.endswith("doc.md")


def test_outside_denied_and_audited(dirs, tmp_path):
    a = AuditLog(str(tmp_path / "audit.db"))
    guard = FileGuard([str(dirs[0])], audit=a)
    with pytest.raises(GuardViolation, match="越界"):
        guard.check(str(dirs[1] / "key.pem"))
    rows = a.query(action="file_guard.deny")
    assert len(rows) == 1
    assert "key.pem" in rows[0]["detail"]["path"]


def test_dotdot_escape_denied(dirs):
    inside, outside = dirs
    guard = FileGuard([str(inside)])
    sneaky = inside / ".." / "secret" / "key.pem"
    with pytest.raises(GuardViolation):
        guard.check(str(sneaky))


def test_nonexistent_denied(dirs):
    guard = FileGuard([str(dirs[0])])
    with pytest.raises(GuardViolation, match="不存在"):
        guard.check(str(dirs[0] / "ghost.md"))


def test_allowed_dir_itself_passes_and_read_text(dirs):
    guard = FileGuard([str(dirs[0])])
    assert guard.read_text(str(dirs[0] / "doc.md")) == "内容"


def test_case_insensitive_prefix_no_false_positive(dirs):
    inside, outside = dirs
    guard = FileGuard([str(inside)])
    sibling = inside.parent / (inside.name + "x")
    sibling.mkdir()
    (sibling / "f.md").write_text("x", encoding="utf-8")
    with pytest.raises(GuardViolation):  # 前缀相似≠同目录
        guard.check(str(sibling / "f.md"))
