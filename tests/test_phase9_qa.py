"""Phase 9 QA 补强：覆盖盲区补测——服务入口装配/CLI 分发/市场 zip 安装。

三个高风险零/低覆盖点：entry.py（看护器重拉落点，0%）/main.py
CLI 分发（用户面契约）/market.install zip 链（M6.8 重构后经
import_from 的完整路径）。
"""
import zipfile
from pathlib import Path

import pytest

from paistation.main import main
from paistation.resident import entry

# ---- entry.py：装配链（降级矩阵下骨架不散） ----

def test_default_data_dir_env_override(monkeypatch, tmp_path):
    monkeypatch.setenv("PAI_STATION_DATA_DIR", str(tmp_path / "custom"))
    assert entry.default_data_dir() == str(tmp_path / "custom")
    monkeypatch.delenv("PAI_STATION_DATA_DIR")
    assert entry.default_data_dir().endswith("PAI-Station")


def test_build_daemon_assembles_degraded(tmp_path):
    """无任何模型时装配仍成功：authkey/事件流/管线全就位（缺件降级）。"""
    daemon = entry.build_daemon(data_dir=str(tmp_path))
    assert (tmp_path / "pipe.authkey").is_file()    # 密钥一次生成落盘
    assert len(daemon._services) >= 1               # 感知管线在列
    assert daemon.pipe_address.endswith("pai-station")


def test_entry_requires_subcommand():
    with pytest.raises(SystemExit) as ei:
        entry.main([])
    assert ei.value.code == 2               # argparse required=True


# ---- main.py：CLI 分发契约 ----

def _write_ini(tmp_path):
    p = tmp_path / "pai.ini"
    p.write_text(f"[sense]\nwatch_dirs = {tmp_path}\n", encoding="utf-8")
    return str(p)


def test_main_no_args_shows_help(capsys):
    assert main([]) == 0
    assert "paistation" in capsys.readouterr().out


def test_main_version_flag():
    with pytest.raises(SystemExit) as ei:
        main(["--version"])
    assert ei.value.code == 0


def test_main_check_dispatch(tmp_path, capsys):
    missing = str(tmp_path / "不存在.ini")
    assert main(["--check", "--config", missing]) == 1
    assert "配置非法" in capsys.readouterr().out
    assert main(["--check", "--config", _write_ini(tmp_path)]) == 0


# ---- market.py：zip 安装链（M6.8 重构后全路径） ----

def _mk_skill(root: Path, name: str) -> Path:
    d = root / name
    d.mkdir(parents=True)
    (d / "SKILL.md").write_text(
        f"---\nname: {name}\ndescription: {name}\n---\n\n# {name}\n步骤。\n",
        encoding="utf-8")
    return d


def test_market_zip_install_roundtrip(tmp_path):
    from paistation.skills.market import SkillMarket
    src = _mk_skill(tmp_path, "索赔报告")
    market = SkillMarket(base="https://example.invalid/market")
    zpath = market.pack(str(src), str(tmp_path / "out"))
    payload = Path(zpath).read_bytes()

    def fetch(url):
        assert url.endswith(".zip")
        return payload

    installed = market.install("索赔报告", str(tmp_path / "dest"), fetch)
    assert (Path(installed) / "SKILL.md").is_file()
    # zip 内带 meta.yaml（pack 时自动补）
    with zipfile.ZipFile(zpath) as zf:
        assert any(n.endswith("meta.yaml") for n in zf.namelist())


def test_market_install_fetch_all_down(tmp_path):
    from paistation.skills.market import SkillMarket
    market = SkillMarket(base="https://example.invalid/market")

    def boom(url):
        raise OSError("市场不可达")

    with pytest.raises(FileNotFoundError):
        market.install("任意技能", str(tmp_path / "dest"), boom)
