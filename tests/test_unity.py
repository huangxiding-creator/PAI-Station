"""M12 合一指数 U TDD（PROPOSAL_V2.md 1.3）：分域可度量，不做玄学。

U = 0.35·NPI + 0.35·F_pass + 0.30·(1 - C_rate)
- NPI = 0.4·采纳率 + 0.4·下一步命中 + 0.2·(1-纠偏幅度)（缺失分量弃权，
  采纳/命中全缺 → 0：无逼近数据不编造）
- F_pass = 初稿一次通过率（diff<阈值交付占比）；零交付 → 0
- C_rate = 每千字纠正次数归一（cap 5）；零交付 → 1（最大距离，不白给）
- 60 分奇点：该域"上岗"；全零数据 → U=0（诚实占位）
"""
import json
from datetime import date, datetime

from paistation.evolve.unity import (
    c_rate,
    dashboard,
    f_pass,
    npi,
    save_snapshot,
    u_score,
)


# ---------------------------------------------------------------- 分量

def test_npi_full_and_zero():
    assert abs(npi(1.0, 1.0, 0.0) - 1.0) < 1e-9
    assert abs(npi(0.0, 0.0, 0.0) - 0.2) < 1e-9      # 仅纠偏满分贡献 0.2
    assert abs(npi(1.0, 1.0, 1.0) - 0.8) < 1e-9      # 纠偏拉满扣 0.2


def test_npi_missing_components_dont_inflate():
    assert npi(None, None, None) == 0.0              # 无逼近数据 → 0
    assert abs(npi(1.0, 1.0, None) - 0.8) < 1e-9     # 缺 drift 弃权不补分
    assert npi(0.0, 0.0, None) == 0.0                # drift 缺席不得独活


def test_f_pass_ratio_and_zero():
    assert f_pass(passed=8, total=10) == 0.8
    assert f_pass(passed=0, total=0) == 0.0


def test_c_rate_normalized():
    assert abs(c_rate(corrections=10, kchars=2) - 1.0) < 1e-9   # 5/千字封顶
    assert c_rate(corrections=5, kchars=10) == 0.1
    assert c_rate(corrections=0, kchars=0) == 1.0    # 零交付最大距离


# ---------------------------------------------------------------- 合成

def test_u_score_perfect_domain():
    u = u_score(adoption=1.0, next_hit=1.0, drift=0.0,
                passed=10, total=10, corrections=0, kchars=100)
    assert abs(u - 1.0) < 1e-9


def test_u_score_zero_data():
    assert u_score(adoption=None, next_hit=None, drift=None,
                   passed=0, total=0, corrections=0, kchars=0) == 0.0


def test_u_score_partial_weights():
    """只 NPI 部分（0.8）、无交付 → 0.35×0.8。"""
    u = u_score(adoption=1.0, next_hit=1.0, drift=None,
                passed=0, total=0, corrections=0, kchars=0)
    assert abs(u - 0.28) < 1e-9


def test_u_score_60_singularity_threshold():
    """63 分过线、59 不过——奇点线在 60。"""
    high = u_score(0.9, 0.9, 0.2, 9, 10, 1, 50)
    assert high >= 0.60


# ---------------------------------------------------------------- 快照+仪表盘

def test_save_snapshot_iso_week_file(tmp_path):
    path = save_snapshot(tmp_path, domain="调研报告", u=63,
                         components={"npi": 0.7, "f_pass": 0.6, "c_rate": 0.1},
                         now=datetime(2026, 9, 11))
    assert path.name.startswith("unity_") and path.name.endswith(".json")
    row = json.loads(path.read_text(encoding="utf-8"))
    assert row["domain"] == "调研报告" and row["u"] == 63
    iso = datetime(2026, 9, 11).isocalendar()
    assert row["iso_week"] == f"{iso[0]}-W{iso[1]:02d}"
    assert row["date"] == "2026-09-11"


def test_dashboard_domains_trend_singularity(tmp_path):
    for day, u in ((date(2026, 8, 28), 41), (date(2026, 9, 11), 63)):
        save_snapshot(tmp_path, domain="调研报告", u=u,
                      components={"npi": 0.6, "f_pass": 0.5, "c_rate": 0.3},
                      now=datetime(day.year, day.month, day.day, 12))
    save_snapshot(tmp_path, domain="公众号写作", u=41,
                  components={"npi": 0.5, "f_pass": 0.4, "c_rate": 0.4},
                  now=datetime(2026, 9, 11, 12))
    text = dashboard(tmp_path)
    assert "调研报告" in text and "公众号写作" in text
    assert "↑" in text                                  # 周环比上升
    assert "上岗" in text                               # 63 ≥ 60 奇点
    lines = [ln for ln in text.splitlines() if "公众号写作" in ln]
    assert lines and "上岗" not in lines[0]             # 41 未过线


def test_dashboard_empty_root_honest_placeholder(tmp_path):
    text = dashboard(tmp_path)
    assert "暂无" in text or "U=0" in text              # 零数据不编造
