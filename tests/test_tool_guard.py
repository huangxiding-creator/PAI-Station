"""M3 工具守卫：危险命令三级分级 allow/ask/deny。"""
import pytest

from paistation.security.tool_guard import ToolGuard


@pytest.fixture
def guard(tmp_path):
    from paistation.security.audit import AuditLog
    return ToolGuard(audit=AuditLog(str(tmp_path / "audit.db")))


def test_readonly_commands_allowed(guard):
    for cmd in ("dir", "ls -la", "type a.txt", "cat b.md", "git status",
                "git log --oneline", "python -m pytest -q"):
        assert guard.classify(cmd) == "allow", cmd


def test_destructive_denied(guard):
    for cmd in ("rm -rf /", "rm -rf C:\\Users", "format C:", "rd /s /q C:\\Windows",
                "shutdown /s /t 0", "del /f /q C:\\Windows\\system32\\x",
                "reg delete HKLM /f", "diskpart clean"):
        assert guard.classify(cmd) == "deny", cmd


def test_sensitive_asks(guard):
    for cmd in ("curl -O https://x.com/a.exe", "pip install requests",
                "git push origin main", "npm install left-pad"):
        assert guard.classify(cmd) == "ask", cmd


def test_case_and_padding_insensitive(guard):
    assert guard.classify("RM -RF /") == "deny"
    assert guard.classify("  Format  C:  ") == "deny"


def test_word_boundary_no_false_positive(guard):
    """rmrf.py 是文件名不是命令；'perform at' 不含 format。"""
    assert guard.classify("python rmrf.py") == "allow"
    assert guard.classify("echo format-the-report") == "allow"


def test_check_returns_reason_and_audits(guard):
    r = guard.check("format D:")
    assert r["verdict"] == "deny" and r["matched"]
    rows = guard._audit.query(action="tool_guard.deny")
    assert len(rows) == 1 and "format" in rows[0]["detail"]["command"]


def test_check_allow_audits_nothing(guard):
    guard.check("git status")
    assert guard._audit.query(action="tool_guard.deny") == []
    assert guard._audit.query(action="tool_guard.ask") == []


def test_empty_command_allowed(guard):
    assert guard.check("")["verdict"] == "allow"
