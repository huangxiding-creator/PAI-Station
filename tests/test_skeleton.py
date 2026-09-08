"""M0.1 骨架冒烟测试：--check 与 --version 行为（M0.2 起走完整校验器）。"""
from paistation import __version__
from paistation.main import check, main


def _valid_ini(tmp_path):
    p = tmp_path / "pai.ini"
    p.write_text(f"[sense]\nwatch_dirs = {tmp_path}\n", encoding="utf-8")
    return str(p)


def test_version():
    assert __version__ == "1.0.0"


def test_check_ok(tmp_path):
    assert check(_valid_ini(tmp_path)) == 0


def test_check_missing_file(tmp_path):
    assert check(str(tmp_path / "nope.ini")) == 1


def test_check_invalid_config_reports_error(tmp_path):
    p = tmp_path / "pai.ini"
    p.write_text("[llm]\nupgrade_confidence = 0.3\n", encoding="utf-8")
    assert check(str(p)) == 1


def test_cli_version(capsys):
    try:
        main(["--version"])
    except SystemExit as exc:
        assert exc.code == 0
    assert __version__ in capsys.readouterr().out
