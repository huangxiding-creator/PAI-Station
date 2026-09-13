"""Phase B4 金标准增长管线：origin 溯源 + 质量闸防稀释。

Qodo Cover 反面教训：测试长出来≠有用——拒收不稀释，已入库不删（只增）。
"""
import json

import pytest

from paistation.gate.golden_growth import add_golden, growth_report


@pytest.fixture()
def fixture_file(tmp_path):
    path = tmp_path / "golden_qa.jsonl"
    rows = [
        {"q": "企业微信定价多少", "expect_paths": ["定价"], "expect_keyword": "680"},
        {"q": "投标保证金比例", "expect_paths": ["保证金"], "expect_keyword": "2%"},
    ]
    path.write_text("\n".join(json.dumps(r, ensure_ascii=False)
                              for r in rows) + "\n", encoding="utf-8")
    return path


def test_add_accepted_with_origin(fixture_file):
    r = add_golden(fixture_file, "深基坑支护要点是什么",
                  expect_paths=["深基坑"], expect_keyword="支护",
                  origin="task:T-101")
    assert r["accepted"] is True
    rows = [json.loads(x) for x in
            fixture_file.read_text(encoding="utf-8").splitlines() if x.strip()]
    assert len(rows) == 3
    assert rows[-1]["origin"] == "task:T-101"


def test_reject_exact_duplicate(fixture_file):
    r = add_golden(fixture_file, "企业微信定价多少",
                   expect_paths=["定价"], expect_keyword="680", origin="task")
    assert r["accepted"] is False
    assert "重复" in r["reason"]


def test_reject_near_duplicate(fixture_file):
    """词面高度相似=稀释，拒收（Qodo Cover 反面）。"""
    r = add_golden(fixture_file, "企业微信的定价是多少呀",
                   expect_paths=["定价"], expect_keyword="680", origin="task")
    assert r["accepted"] is False
    assert "相似" in r["reason"]


def test_reject_missing_fields(fixture_file):
    r = add_golden(fixture_file, "", expect_paths=[], expect_keyword="",
                   origin="task")
    assert r["accepted"] is False
    assert "字段" in r["reason"]


def test_reject_bad_origin(fixture_file):
    r = add_golden(fixture_file, "全新问题内容",
                   expect_paths=["x"], expect_keyword="y", origin="")
    assert r["accepted"] is False
    assert "origin" in r["reason"]


def test_rejected_not_written(fixture_file):
    """拒收=不入库（已入库条目永不删，R 只增不删）。"""
    before = fixture_file.read_text(encoding="utf-8")
    add_golden(fixture_file, "企业微信定价多少",
               expect_paths=["定价"], expect_keyword="680", origin="task")
    assert fixture_file.read_text(encoding="utf-8") == before


def test_growth_report(fixture_file):
    add_golden(fixture_file, "全新问题内容甲",
               expect_paths=["x"], expect_keyword="y", origin="task:T-9")
    report = growth_report(fixture_file)
    assert report["total"] == 3
    assert report["by_origin"]["task:T-9"] == 1
    assert "legacy" in report["by_origin"]     # 无 origin 字段=legacy 存量


def test_real_fixture_untouched_by_report():
    """报告对真实金标准只读（40 条是 V3 资产，绝不改写）。"""
    from pathlib import Path

    real = Path("tests/fixtures/golden_qa.jsonl")
    report = growth_report(real)
    assert report["total"] == 40
    assert report["by_origin"]["legacy"] == 40
