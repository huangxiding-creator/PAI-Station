# -*- coding: utf-8 -*-
"""v3_constitution_audit 单测 — 宪法红线审计件 (REQ-000 删除守卫 / REQ-003 推送冻结).

覆盖: ① scan 对含 rmtree 调用的 .py 命中 ② 干净文件零命中 ③ tests/ 白名单
跳过 tmp 清理 ④ 白名单不外溢到非 tests 文件 ⑤⑥ audit_push_freeze mock 两态
(本地领先=pass / 远程领先=violated) ⑦ 无远程跟踪=pass ⑧ main() 退出码契约
(0=通过 / 2=违宪)。全程只读, 绝不真跑任何 git 写操作。
"""
from __future__ import annotations

import json
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
import v3_constitution_audit as vca          # noqa: E402


def _write(root: Path, rel: str, text: str) -> Path:
    p = root / rel
    p.parent.mkdir(parents=True, exist_ok=True)
    p.write_text(text, encoding="utf-8")
    return p


def _git_script(monkeypatch, script: dict) -> None:
    """把 _run_git 替换为查表假体: key=参数元组, value=(rc, stdout)。零真实 git。"""
    def fake(args, cwd=None):
        rc, out = script.get(tuple(args), (128, ""))
        return rc, out.strip()          # 还原 _run_git 的 stdout.strip() 契约
    monkeypatch.setattr(vca, "_run_git", fake)


# ------------------------------------------------ ① 删除守卫命中
def test_01_scan_hits_rmtree(tmp_path):
    f = _write(tmp_path, "bad_worker.py",
               "import shutil\nshutil.rmtree(tmpdir)\n")
    hits = vca.scan_deletion_calls([tmp_path])
    assert len(hits) == 1
    h = hits[0]
    assert h["file"] == str(f)
    assert h["line"] == 2
    assert "rmtree" in h["code"]
    assert h["pattern"] == "rmtree"


# ------------------------------------------------ ② 干净文件零命中
def test_02_scan_clean_file_zero_hits(tmp_path):
    _write(tmp_path, "clean_worker.py",
           "x = 1 + 1\nprint('safe')\n")
    assert vca.scan_deletion_calls([tmp_path]) == []


# ------------------------------------------------ ③ tests/ 白名单: tmp 清理跳过
def test_03_tests_tmp_whitelist(tmp_path):
    _write(tmp_path, "tests/test_fixture_cleanup.py",
           "def cleanup(tmp_path):\n    tmp_path.unlink()\n")
    assert vca.scan_deletion_calls([tmp_path]) == []


# ------------------------------------------------ ④ 白名单不外溢: 非 tests 文件同语句仍命中
def test_04_whitelist_only_for_tests(tmp_path):
    _write(tmp_path, "prod_like.py",
           "import shutil\nshutil.rmtree(tmp_export_dir)\n")
    hits = vca.scan_deletion_calls([tmp_path])
    assert len(hits) == 1
    assert hits[0]["line"] == 2


# ------------------------------------------------ ⑤ 推送冻结: 本地领先 = pass
def test_05_push_freeze_local_ahead_pass(monkeypatch):
    _git_script(monkeypatch, {
        ("rev-parse", "--verify", "origin/main"): (0, "aaa111\n"),
        ("rev-parse", "--verify", "main"): (0, "bbb222\n"),
        ("merge-base", "--is-ancestor", "origin/main", "main"): (0, ""),
    })
    r = vca.audit_push_freeze()
    assert r["status"] == "pass"
    assert r["origin_main"] == "aaa111"
    assert r["local_main"] == "bbb222"


# ------------------------------------------------ ⑥ 推送冻结: 远程领先 = violated
def test_06_push_freeze_remote_ahead_violated(monkeypatch):
    _git_script(monkeypatch, {
        ("rev-parse", "--verify", "origin/main"): (0, "aaa111\n"),
        ("rev-parse", "--verify", "main"): (0, "bbb222\n"),
        ("merge-base", "--is-ancestor", "origin/main", "main"): (1, ""),
    })
    r = vca.audit_push_freeze()
    assert r["status"] == "violated"
    assert r["origin_main"] == "aaa111"


# ------------------------------------------------ ⑦ 推送冻结: 无远程跟踪 = pass
def test_07_push_freeze_no_remote_pass(monkeypatch):
    _git_script(monkeypatch, {
        ("rev-parse", "--verify", "origin/main"):
            (128, "fatal: Needed a single revision\n"),
    })
    r = vca.audit_push_freeze()
    assert r["status"] == "pass"
    assert "无远程跟踪" in r["reason"]
    assert r["origin_main"] is None


# ------------------------------------------------ ⑧ main() 退出码契约
def test_08_main_exit_codes(monkeypatch, tmp_path, capsys):
    monkeypatch.setattr(
        vca, "audit_push_freeze",
        lambda repo_root=None: {"status": "pass", "reason": "mock 冻结健康",
                                "origin_main": None, "local_main": None})
    _write(tmp_path, "bad_worker.py", "import shutil\nshutil.rmtree(tmpdir)\n")
    assert vca.main(["--json", str(tmp_path)]) == 2
    data = json.loads(capsys.readouterr().out)
    assert data["verdict"] == "violated"
    assert data["deletion_guard"]["hit_count"] == 1

    clean_dir = tmp_path / "clean_only"
    clean_dir.mkdir()
    _write(clean_dir, "ok.py", "y = 2\n")
    assert vca.main(["--json", str(clean_dir)]) == 0
    data = json.loads(capsys.readouterr().out)
    assert data["verdict"] == "pass"
    assert data["deletion_guard"]["hit_count"] == 0
