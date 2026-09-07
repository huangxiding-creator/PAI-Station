"""M0.1 骨架冒烟测试：--check 与 --version 行为。"""
from paistation import __version__
from paistation.main import check, main


def test_version():
    assert __version__ == "0.1.0"


def test_check_ok_with_default_ini(tmp_path):
    ini = tmp_path / "pai.ini"
    ini.write_text("[llm]\nmodel = glm-4.7-flash\n[sense]\nenabled = 1\n",
                   encoding="utf-8")
    assert check(str(ini)) == 0


def test_check_missing_file(tmp_path):
    assert check(str(tmp_path / "nope.ini")) == 1


def test_check_missing_section(tmp_path):
    ini = tmp_path / "pai.ini"
    ini.write_text("[llm]\nmodel = glm-4.7-flash\n", encoding="utf-8")
    assert check(str(ini)) == 1


def test_cli_version(capsys):
    try:
        main(["--version"])
    except SystemExit as exc:
        assert exc.code == 0
    assert __version__ in capsys.readouterr().out
