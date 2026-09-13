"""Phase B2 记忆自检三套统一入口：冲突消解/结构回归/遗忘合规。

自检=只读不变量检测器（消解动作在 profile.record 已内置）：
①冲突：同 (layer,key) active 条目 ≤1；②结构：vault_validate 纯读（不重算
manifest，篡改可测）+画像结构；③遗忘：坟回流（与 audit_vault 同语义）。
"""
import json

import pytest

from paistation.gate.selfcheck import selfcheck


@pytest.fixture()
def seeded(tmp_path):
    from tests.test_sovereign_protocol import _seed_data

    data_dir = tmp_path / "data"
    data_dir.mkdir()
    _seed_data(data_dir)
    return data_dir


def test_all_green_when_healthy(seeded):
    r = selfcheck(seeded)
    assert r["ok"] is True
    assert r["conflicts"] == []
    assert r["structure"]["ok"] is True
    assert r["forget"] == []


def test_conflict_detected_when_duplicate_active(seeded):
    # 绕过 record 直改 JSONL：制造同 key 双 active（不变量被破坏）
    path = seeded / "profile" / "entries.jsonl"
    rows = [json.loads(x) for x in
            path.read_text(encoding="utf-8").splitlines() if x.strip()]
    dup = dict(rows[0])
    dup["id"] = "deadbeef01"
    dup["value"] = rows[0]["value"] + "-冲突副本"
    path.write_text("\n".join(json.dumps(x, ensure_ascii=True)
                              for x in rows + [dup]) + "\n", encoding="utf-8")
    r = selfcheck(seeded)
    assert r["ok"] is False
    assert len(r["conflicts"]) == 1
    assert r["conflicts"][0]["active_count"] == 2


def test_structure_regression_detects_tamper(seeded):
    # 篡改 memory.md 且不更新 MANIFEST：纯读校验必须报 tampered
    target = seeded / "sovereign" / "memory.md"
    target.write_text(target.read_text(encoding="utf-8") + "\n- [x] 偷偷加的\n",
                      encoding="utf-8")
    r = selfcheck(seeded)
    assert r["ok"] is False
    assert r["structure"]["ok"] is False
    assert r["structure"]["tampered"] or r["structure"]["unmanifested"]


def test_forget_violation_when_tomb_leaks_back(seeded):
    from paistation.sovereign.protocol import forget

    forget(seeded, "memory", "常驻城市")
    # 偷偷把被忘内容写回活动视图（僵尸复活）
    target = seeded / "sovereign" / "memory.md"
    target.write_text(target.read_text(encoding="utf-8")
                      + "- [2026-09-13T00:00:00] 常驻城市=北京\n", encoding="utf-8")
    r = selfcheck(seeded)
    assert r["ok"] is False
    assert len(r["forget"]) >= 1
    assert r["forget"][0]["kind"] == "memory"


def test_report_written(seeded):
    r = selfcheck(seeded)
    report = seeded / "gate" / "SELFCHECK.md"
    assert report.is_file()
    assert "自检" in report.read_text(encoding="utf-8")
    assert r["report"] == report


def test_cli_selfcheck_action(seeded, tmp_path):
    from paistation.main import main

    ini = tmp_path / "pai.ini"
    ini.write_text(f"[privacy]\ndata_dir = {seeded}\n"
                   f"[sense]\nwatch_dirs = {seeded}\n", encoding="utf-8")
    rc = main(["--config", str(ini), "--sovereign", "selfcheck"])
    assert rc == 0
    assert (seeded / "gate" / "SELFCHECK.md").is_file()
