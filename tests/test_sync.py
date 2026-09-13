"""M6.6 GitHub 备份同步（FR14 指令②）：本地进化始终有远端备份。

用户自配仓库；secrets/凭据/事件流硬排除；断网积压补推。
测试用本地 bare 仓库当远端（零网络）。
"""
import subprocess

from paistation.skills.forge import SkillForge
from paistation.skills.sync import BackupSync


def _bare(path):
    path.mkdir(parents=True, exist_ok=True)
    subprocess.run(["git", "init", "-q", "--bare", str(path)],
                   check=True, capture_output=True)
    return path


def _mk_skill(forge):
    forge.record_case({"ts": "2026-09-13T10:00:00", "task_title": "调研定价0",
                       "skill": None, "approach": "手工", "outcome": "success",
                       "duration_s": 60, "artifacts": []})
    for i in range(1, 3):
        forge.record_case({"ts": f"2026-09-13T1{i}:00:00",
                           "task_title": f"调研定价{i}", "skill": None,
                           "approach": "手工", "outcome": "success",
                           "duration_s": 60, "artifacts": []})
    cand = forge.propose()[0]
    forge.promote(cand, approved=True)
    return cand["name"]


def test_push_to_user_remote(tmp_path):
    remote = _bare(tmp_path / "backup.git")
    repo_dir = tmp_path / "skills"
    forge = SkillForge(data_dir=tmp_path, repo_dir=repo_dir)
    _mk_skill(forge)

    sync = BackupSync(data_dir=tmp_path, repo_dir=repo_dir)
    sync.configure(remote=str(remote), branch="main")
    result = sync.push()
    assert result["pushed"] is True
    # 远端确实收到 main 分支与技能文件
    out = subprocess.run(
        ["git", "-C", str(remote), "ls-tree", "-r", "--name-only", "main"],
        capture_output=True, text=True, encoding="utf-8")
    assert "SKILL.md" in out.stdout


def test_secrets_hard_excluded(tmp_path):
    remote = _bare(tmp_path / "backup.git")
    repo_dir = tmp_path / "skills"
    forge = SkillForge(data_dir=tmp_path, repo_dir=repo_dir)
    _mk_skill(forge)
    # 模拟敏感文件混入技能库目录
    (repo_dir / "_credentials").mkdir(exist_ok=True)
    (repo_dir / "_credentials" / "authkey.txt").write_text("sk-secret",
                                                           encoding="utf-8")

    sync = BackupSync(data_dir=tmp_path, repo_dir=repo_dir)
    sync.configure(remote=str(remote), branch="main")
    result = sync.push()
    assert result["pushed"] is True
    # .gitignore 硬排除生效：远端不含凭据
    out = subprocess.run(
        ["git", "-C", str(remote), "ls-tree", "-r", "--name-only", "main"],
        capture_output=True, text=True, encoding="utf-8")
    assert "authkey" not in out.stdout
    assert "_credentials" not in out.stdout


def test_offline_queues_and_backlog_flushes(tmp_path):
    repo_dir = tmp_path / "skills"
    forge = SkillForge(data_dir=tmp_path, repo_dir=repo_dir)
    _mk_skill(forge)

    sync = BackupSync(data_dir=tmp_path, repo_dir=repo_dir)
    sync.configure(remote=str(tmp_path / "不存在的远端"), branch="main")
    r1 = sync.push()
    assert r1["pushed"] is False and r1["queued"] is True   # 断网积压

    remote = _bare(tmp_path / "backup.git")
    sync.configure(remote=str(remote), branch="main")
    r2 = sync.push()
    assert r2["pushed"] is True and r2["flushed"] >= 1       # 补推清账
