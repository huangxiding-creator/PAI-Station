"""M8.3 器官健康巡检 TDD：12 器官完整性体检（宪法/状态/骨架/凭证目录）。"""
from pathlib import Path

from paistation.organ import doctor


def test_doctor_full_house(tmp_path):
    import subprocess, sys
    repo_root = Path(__file__).resolve().parents[1]
    subprocess.run([sys.executable, "tools/bootstrap_organs.py",
                    "--root", str(tmp_path)], check=True,
                   capture_output=True, cwd=repo_root)
    report = doctor.check(tmp_path)
    assert report["organs"] == 12
    assert report["missing_readme"] == []
    assert report["missing_state"] == []
    assert report["healthy"] is True


def test_doctor_detects_missing_constitution(tmp_path):
    import subprocess, sys
    repo_root = Path(__file__).resolve().parents[1]
    subprocess.run([sys.executable, "tools/bootstrap_organs.py",
                    "--root", str(tmp_path)], check=True,
                   capture_output=True, cwd=repo_root)
    (tmp_path / "07 任务" / "README.md").unlink()
    report = doctor.check(tmp_path)
    assert "07 任务" in report["missing_readme"]
    assert report["healthy"] is False
