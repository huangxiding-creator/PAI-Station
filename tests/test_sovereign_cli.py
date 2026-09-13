"""Phase A5 CLI：`paistation --sovereign <action>` 七命令冒烟（main 直调）。"""
import pytest

from paistation.main import main
from paistation.sovereign.vault import DecisionLedger, MemoryVault


@pytest.fixture()
def env(tmp_path):
    data_dir = tmp_path / "data"
    data_dir.mkdir()
    ini = tmp_path / "pai.ini"
    ini.write_text(f"[privacy]\ndata_dir = {data_dir}\n"
                   f"[sense]\nwatch_dirs = {data_dir}\n", encoding="utf-8")
    from tests.test_sovereign_protocol import _seed_data
    _seed_data(data_dir)
    return tmp_path, data_dir, str(ini)


def _run(ini, *extra):
    return main(["--config", ini, "--sovereign", *extra])


def test_cli_remember(env):
    tmp, data_dir, ini = env
    assert _run(ini, "remember", "--target", "CLI 记住的条目") == 0
    assert any("CLI 记住的条目" in e.text
               for e in MemoryVault(data_dir / "sovereign").entries())


def test_cli_decide(env):
    tmp, data_dir, ini = env
    rc = _run(ini, "decide", "--target", "CLI 决策", "--chosen", "方案A",
              "--rationale", "测试", "--alts",
              '[{"option": "方案B", "why_rejected": "次优"}]')
    assert rc == 0
    assert any(d.topic == "CLI 决策" for d in
               DecisionLedger(data_dir / "sovereign" / "decisions")
               .list_decisions())


def test_cli_export_then_forget_then_import_restores(env):
    """主权包=恢复能力：忘掉→从包导入→资产复活（10× 判据闭环演示）。"""
    tmp, data_dir, ini = env
    bundle = tmp / "bundle"
    assert _run(ini, "export", "--dest", str(bundle)) == 0
    assert (bundle / "memory.md").is_file()
    # 遗忘一条
    assert _run(ini, "forget", "--kind", "memory", "--target",
                "常驻城市") == 0
    assert not any("常驻城市" in e.text
                   for e in MemoryVault(data_dir / "sovereign").entries())
    # 从包复活
    assert _run(ini, "import", "--src", str(bundle)) == 0
    assert any("常驻城市" in e.text
               for e in MemoryVault(data_dir / "sovereign").entries())


def test_cli_audit_writes_report_and_exits_zero(env):
    tmp, data_dir, ini = env
    assert _run(ini, "audit") == 0
    assert (data_dir / "sovereign" / "AUDIT.md").is_file()


def test_cli_heritage(env):
    tmp, data_dir, ini = env
    dest = tmp / "heritage"
    assert _run(ini, "heritage", "--dest", str(dest), "--heir", "李四") == 0
    assert (dest / "HEIRLOOM.md").is_file()
    assert (dest / "OFFLINE.md").is_file()
    assert "李四" in (dest / "HEIRLOOM.md").read_text(encoding="utf-8")
