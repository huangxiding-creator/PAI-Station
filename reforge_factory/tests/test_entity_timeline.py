# -*- coding: utf-8 -*-
"""T-007A / REQ-021 — T 轴传感器 entity_timeline 测试 (全史时间账本).

tmp 池夹具: 合成 manifest 行跨 2015-2026 (2018 空窗), 含成立里程碑、
中标/上市里程碑、rejected 行不计数、dedup_key 重复行不虚账;
覆盖: year_counts 断言 / 空窗检出 / milestone 抽取 / 豁免后 green 翻转 /
对象词表缺失 fail-soft / 双落盘 (completeness/T_axis.json + timeline.json).
"""
from __future__ import annotations

import itertools
import json
import sys
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))  # reforge_factory/

from completeness import entity_timeline as et  # noqa: E402

CID = "TEST-ETL"
OBJ = "甲公司"
CUR = 2026  # current_year 显式注入, 测试不依赖真实时钟
_seq = itertools.count(1)                      # 确定性 dedup_key 序号 (防 hash 随机脆断)


def _row(year: int, text: str, *, judge: str = "valid", dedup: str | None = None,
         fname: str | None = None) -> dict:
    """合成 manifest 行 (path/text 摘要字段同真实池结构)."""
    return {"ts": "2026-10-15T00:00:00", "engine": "test", "judge": judge,
            "dedup_key": dedup or f"k{next(_seq)}",
            "source_path": f"D:\\pool\\{fname or f'doc{year}.pdf'}",
            "url_norm": "", "text_head": text[:500]}


def _fixture_rows() -> list[dict]:
    """2015-2026 逐年证据, 2018 缺; 成立锚 2015; 中标 2020 / 上市 2024;
    一条 rejected 行与一条 dedup 重复行用于防虚账."""
    rows = [
        _row(2015, f"{OBJ}成立于2015年3月，注册资本一亿元", fname="成立.pdf"),
    ]
    for y in range(2016, 2027):
        if y == 2018:            # 空窗年: 无任何含对象名的证据行
            continue
        if y == 2020:
            rows.append(_row(y, f"{OBJ}2020年中标某EPC总承包项目，合同额12亿",
                             fname="中标公告2020.pdf"))
        elif y == 2024:
            rows.append(_row(y, f"{OBJ}于2024年6月上市，募资30亿",
                             fname="上市招股书.pdf"))
        else:
            rows.append(_row(y, f"{OBJ}{y}年度经营情况综述，营收平稳增长"))
    # rejected 行: 不得计数 (即使含年份+对象名)
    rows.append(_row(2019, f"{OBJ}2019年重复采集件", judge="rejected"))
    # dedup_key 重复行: manifest 行=文件×问题对, 行累加=虚账 → 只计一次
    rows.append(_row(2021, f"{OBJ}2021年同文件第二问题对", dedup="dup-2021"))
    rows.append(_row(2021, f"{OBJ}2021年同文件第三问题对", dedup="dup-2021"))
    # 不含对象名的行: 不计入对象时间轴 (即使有年份)
    rows.append(_row(2018, "2018年别的公司年报，与对象无关"))
    return rows


def _make_pool(tmp_path: Path, rows: list[dict], *, t1: list[str] | None) -> Path:
    """tmp 池: ammo_pool 根 + TEST-ETL 战役 (manifest + 可选 tiers)."""
    root = tmp_path / "ammo_pool"
    camp = root / CID
    camp.mkdir(parents=True)
    (camp / "manifest.jsonl").write_text(
        "\n".join(json.dumps(r, ensure_ascii=False) for r in rows) + "\n",
        encoding="utf-8")
    if t1 is not None:
        (camp / "tiers.json").write_text(
            json.dumps({"T1": t1, "T2": []}, ensure_ascii=False), encoding="utf-8")
    return root


@pytest.fixture
def pool(tmp_path: Path) -> Path:
    return _make_pool(tmp_path, _fixture_rows(), t1=[OBJ])


def test_year_counts_dedup_and_zero_fill(pool: Path) -> None:
    rec = et.scan(CID, [OBJ], pool_root=pool, current_year=CUR)
    yc = rec["year_counts"]
    # 成立锚 2015 → 账本跨 2015..2026, 缺年零填
    assert set(yc) == {str(y) for y in range(2015, CUR + 1)}
    assert yc["2017"] == 1 and yc["2019"] == 1        # 常规年 1 行
    assert yc["2021"] == 2                            # 常规 1 + 同键去重后 1 (未去重=3)
    assert yc["2018"] == 0                            # 空窗 (无关行不算)
    assert yc["2015"] == 1 and yc["2026"] == 1
    assert rec["axis"] == "T" and rec["sensor"] == "entity_timeline"
    assert rec["object_terms"] == [OBJ]
    assert rec["founded_year"] == 2015
    assert rec["founded_year_estimated"] is False     # 成立里程碑在档


def test_gap_detection_and_green(pool: Path) -> None:
    rec = et.scan(CID, [OBJ], pool_root=pool, current_year=CUR)
    assert rec["gap_years"] == [2018]
    assert rec["gap_waivers"] == []                  # 待人工/后续填
    assert rec["green"] is False                     # 有未豁免空窗年


def test_founded_year_estimated_fallback(tmp_path: Path) -> None:
    rows = [r for r in _fixture_rows() if "成立" not in r["text_head"]]
    root = _make_pool(tmp_path, rows, t1=[OBJ])
    rec = et.scan(CID, [OBJ], pool_root=root, current_year=CUR)
    assert rec["founded_year"] == 2016 - 1            # 最早证据年-1
    assert rec["founded_year_estimated"] is True
    assert 2015 in rec["gap_years"]                   # 估计成立年前一年即空窗


def test_milestone_extraction(pool: Path) -> None:
    rec = et.scan(CID, [OBJ], pool_root=pool, current_year=CUR)
    ms = {(m["year"], m["keyword"]) for m in rec["milestones"]}
    assert (2015, "成立") in ms
    assert (2020, "中标") in ms
    assert (2024, "上市") in ms
    # rejected 行与不含对象名的行不产生里程碑
    assert not any(m["year"] == 2019 and m["keyword"] == "重复" for m in rec["milestones"])
    for m in rec["milestones"]:
        assert m["title"] and m["source_path"]


def test_waiver_flips_green_and_is_immutable(pool: Path) -> None:
    rec = et.scan(CID, [OBJ], pool_root=pool, current_year=CUR)
    waived = et.apply_waivers(rec, [{"year": 2018, "reason": "三史+官网+年报均查无"}])
    assert waived["green"] is True                    # 豁免后翻转
    assert waived["gap_waivers"] == [{"year": 2018, "reason": "三史+官网+年报均查无"}]
    assert rec["green"] is False and rec["gap_waivers"] == []   # 原对象分毫不动
    # 无 reason 的豁免不算数 (REQ-021: 豁免年 100% 带 reason)
    bad = et.apply_waivers(rec, [{"year": 2018, "reason": ""}])
    assert bad["green"] is False


def test_missing_object_terms_fail_soft(tmp_path: Path) -> None:
    root = _make_pool(tmp_path, _fixture_rows(), t1=None)      # 无 tiers.json
    rec = et.scan(CID, [], pool_root=root, current_year=CUR)   # 不抛异常
    assert rec["object_terms_missing"] is True
    assert rec["year_counts"]                          # 降级仍出全池年谱
    assert rec["green"] is False                       # 对象未定 → 不可判绿


def test_manifest_missing_raises(tmp_path: Path) -> None:
    root = tmp_path / "ammo_pool" / CID
    root.mkdir(parents=True)
    with pytest.raises(FileNotFoundError):
        et.scan(CID, [OBJ], pool_root=root, current_year=CUR)


def test_write_axis_dual_output_and_waiver_preserved(pool: Path) -> None:
    rec = et.scan(CID, [OBJ], pool_root=pool, current_year=CUR)
    rec = et.apply_waivers(rec, [{"year": 2018, "reason": "三史+官网+年报均查无"}])
    written = et.write_axis(rec, CID, pool_root=pool)
    assert {p.name for p in written} == {"T_axis.json", "timeline.json"}
    axis = json.loads((pool / CID / "completeness" / "T_axis.json").read_text(encoding="utf-8"))
    root_tl = json.loads((pool / CID / "timeline.json").read_text(encoding="utf-8"))
    assert axis == root_tl == rec                     # 双落盘同内容 (REQ-021.AC1 正名)
    # 重跑不抹人工豁免: 人工把豁免写进池内 timeline.json 后再跑 main → 保留且 green 翻转
    tl_path = pool / CID / "timeline.json"
    tl = json.loads(tl_path.read_text(encoding="utf-8"))
    tl["gap_waivers"] = [{"year": 2018, "reason": "三史+官网+年报均查无"}]
    tl_path.write_text(json.dumps(tl, ensure_ascii=False), encoding="utf-8")
    assert et.main(["--campaign", CID, "--pool-root", str(pool),
                    "--current-year", str(CUR)]) == 0
    tl2 = json.loads(tl_path.read_text(encoding="utf-8"))
    assert tl2["gap_waivers"] == [{"year": 2018, "reason": "三史+官网+年报均查无"}]
    assert tl2["green"] is True
    assert json.loads((pool / CID / "completeness" / "T_axis.json")
                      .read_text(encoding="utf-8"))["green"] is True


def test_cli_main_end_to_end(pool: Path, capsys) -> None:
    rc = et.main(["--campaign", CID, "--pool-root", str(pool),
                  "--current-year", str(CUR)])
    assert rc == 0
    out = capsys.readouterr().out
    assert "T_axis.json" in out and "timeline.json" in out
    tl = json.loads((pool / CID / "timeline.json").read_text(encoding="utf-8"))
    assert tl["gap_years"] == [2018] and tl["green"] is False
