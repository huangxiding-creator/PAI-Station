"""Phase E 商业化与治理：章程三律/小时数报表/托管层最小可用/顺差仪表盘。"""
import json

from paistation.governance.charter import audit_charter, generate_charter
from paistation.governance.dashboard import render_dashboard
from paistation.governance.hosted import backup_data, sync_vault
from paistation.governance.hours import hours_report

# ---- E1 治理章程 ----

def test_charter_contains_three_laws():
    md = generate_charter()
    assert "永不卖用户数据" in md
    assert "数据本地" in md
    assert "一键带走" in md


def test_charter_lists_open_core_boundary():
    md = generate_charter()
    assert "开源核心" in md
    assert "商业边界" in md
    assert "sovereign" in md          # 主权层在开源核心清单


def test_audit_charter_passes_on_real_repo():
    """验收判据：代码库结构与章程一致（章程列的目录都真实存在）。"""
    from pathlib import Path

    report = audit_charter(Path(__file__).resolve().parents[1])
    assert report["consistent"] is True, report["missing"]
    assert report["core_dirs"]


def test_audit_charter_fails_when_dir_missing(tmp_path):
    report = audit_charter(tmp_path)
    assert report["consistent"] is False
    assert report["missing"]


# ---- E2 小时数报表 ----

def _seed_home(tmp_path):
    from paistation.control.meter import Meter

    gate = tmp_path / "gate" / "exits.jsonl"
    gate.parent.mkdir(parents=True)
    rows = [
        {"task_id": "T-1", "status": "done", "done": True},
        {"task_id": "T-2", "status": "done", "done": True},
        {"task_id": "T-3", "status": "failed", "done": False},
    ]
    gate.write_text("\n".join(json.dumps(r) for r in rows) + "\n",
                    encoding="utf-8")
    m = Meter(tmp_path)
    m.record("T-1", seconds=3600, tokens=1000)
    m.record("T-2", seconds=1800, tokens=500)
    m.record("T-3", seconds=600)
    return tmp_path


def test_hours_report_counts_done_only(tmp_path):
    home = _seed_home(tmp_path)
    r = hours_report(home)
    assert r["done_tasks"] == 2
    assert r["human_hours"] == 1.5        # (3600+1800)/3600，只计 done


def test_hours_report_renders_md(tmp_path):
    home = _seed_home(tmp_path)
    md = hours_report(home, render=True)
    assert "替你完成的小时数" in md
    assert "1.5" in md


# ---- E3 托管层最小可用 ----

def test_sync_vault_exports(tmp_path):
    from tests.test_sovereign_protocol import _seed_data

    data_dir = tmp_path / "data"
    data_dir.mkdir()
    _seed_data(data_dir)
    dest = tmp_path / "sync-out"
    report = sync_vault(data_dir, dest)
    assert (dest / "memory.md").is_file()
    assert report["files"] >= 3


def test_backup_creates_timestamped_zip(tmp_path):
    from tests.test_sovereign_protocol import _seed_data

    data_dir = tmp_path / "data"
    data_dir.mkdir()
    _seed_data(data_dir)
    backups = tmp_path / "backups"
    first = backup_data(data_dir, backups)
    assert first.is_file() and first.suffix == ".zip"
    second = backup_data(data_dir, backups)
    assert second.is_file()
    assert len(list(backups.glob("*.zip"))) == 2     # 只增不删


# ---- E4 顺差仪表盘 ----

def test_dashboard_renders_surplus(tmp_path):
    from paistation.control.meter import Meter

    m = Meter(tmp_path)
    m.record("intake:weread", tokens=10_000)
    m.record("output:report", tokens=3_000)
    md = render_dashboard(tmp_path)
    assert "信息贸易顺差" in md
    assert "摄入" in md and "产出" in md


def test_dashboard_flags_deficit(tmp_path):
    from paistation.control.meter import Meter

    m = Meter(tmp_path)
    m.record("intake:weread", tokens=10_000)
    m.record("output:report", tokens=100)
    md = render_dashboard(tmp_path)
    assert "逆差" in md
