"""M6.3/M6.9 打包工件一致性：installer/build/postinstall 与入口对齐。"""
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def test_installer_iss_present_and_user_scope():
    iss = ROOT / "setup" / "installer.iss"
    assert iss.is_file()
    text = iss.read_text(encoding="utf-8")
    # 免管理员：装到用户目录（{localappdata}），家用笔记本不动系统区
    assert "{localappdata}" in text
    assert "postinstall" in text.lower()


def test_build_and_postinstall_scripts_present():
    assert (ROOT / "setup" / "build.ps1").is_file()
    post = (ROOT / "setup" / "postinstall.ps1").read_text(encoding="utf-8")
    # 干净环境验收链：离线装依赖→自检
    assert "--offline" in post or "wheels" in post.lower()
    assert "doctor" in post


def test_console_script_registered():
    pyproject = (ROOT / "pyproject.toml").read_text(encoding="utf-8")
    assert re.search(r"paistation\s*=\s*\"paistation\.main:main\"", pyproject)
