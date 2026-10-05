# -*- coding: utf-8 -*-
"""FT-6 实体覆盖账本测试 — 检索穷举可证明 (对标 LDR#0 SimpleQA 机制).

覆盖四条铁律 + CLI 回路:
  1. 2 NAMES×3 DESCRIPTORS 课题: backfill+record 迭代到穷尽, 全程零重复
     组合, 覆盖矩阵无白格 (每格都被显式搜过);
  2. 年份范围展开 2019-2023 → 5 年;
  3. 连续 3 次零结果 → narrow_hint 触发; 有结果 → 连击清零;
  4. 不可变: record_searched/record_result 后原 ledger 分毫不动.
"""
from __future__ import annotations

import json
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))  # reforge_factory/

import entity_coverage as ec  # noqa: E402

NAMES = ["甲公司", "乙公司"]
DESCRIPTORS = ["营收", "诉讼", "专利"]


def _topic_ledger() -> dict:
    """模拟 5 实体课题 (2 NAMES × 3 DESCRIPTORS)."""
    led = ec.new_ledger("示范课题")
    return {**led, "entities": {**led["entities"], "NAMES": NAMES,
                                "DESCRIPTORS": DESCRIPTORS}}


def _snapshot(obj: dict) -> str:
    return json.dumps(obj, ensure_ascii=False, sort_keys=True)


def test_new_ledger_shape() -> None:
    led = ec.new_ledger("课题X")
    assert led["topic"] == "课题X"
    assert set(led["entities"]) == set(ec.ENTITY_KINDS)
    assert all(v == [] for v in led["entities"].values())
    assert led["searched"] == [] and led["combos"] == []
    assert led["zero_result_streak"] == 0 and led["ts"]


def test_exhaust_backfill_no_dup_no_whitecell() -> None:
    """迭代回填直到穷尽: 零重复组合 + 2×3 矩阵无白格 (cap=2 逼多轮)."""
    led = _topic_ledger()
    seen: list[tuple[str, ...]] = []
    rounds = 0
    while True:
        sugg = ec.unsearched_combos(led, cap=2)
        if not sugg:
            break
        rounds += 1
        assert rounds <= 20, "回填不收敛 (死循环防护)"
        for s in sugg:
            led = ec.record_searched(led, s["query"], s["combo"])
            led = ec.record_result(led, 3)          # 有结果
            seen.append(tuple(s["combo"]))
        assert len(seen) == len(set(seen)), "全程出现重复组合"
    assert rounds >= 3 and len(seen) == 6            # 6 组合分多轮吃完
    matrix = {tuple(sorted([n, d])) for n in NAMES for d in DESCRIPTORS}
    assert set(seen) == matrix                       # 覆盖矩阵无白格
    assert {tuple(c) for c in led["combos"]} == matrix
    assert ec.unsearched_combos(led) == []           # 穷尽 = 无未搜组合
    assert ec.narrow_hint(led) is None               # 有结果, 连击已清零


def test_detect_entities_digit_boundary() -> None:
    """F1 数字边界守卫: 含数字实体值两侧不得再贴数字 —
    2015 不命中 12015, 3500 不命中 35000; 单年 TEMPORAL 同受保护;
    纯 CJK 值保持子串命中."""
    led = ec.new_ledger("T")
    led = {**led, "entities": {**led["entities"],
                               "NUMERICAL": ["2015", "3500"],
                               "NAMES": ["甲公司"],
                               "TEMPORAL": ["2019"]}}
    assert ec.detect_entities(led, "营收12015万元") == []     # 2015 被守卫挡下
    assert ec.detect_entities(led, "用工35000人") == []       # 3500 不命中 35000
    assert ec.detect_entities(led, "签约12019项目") == []     # 单年 TEMPORAL 受保护
    assert sorted(ec.detect_entities(led, "2015年签约3500万")) == [
        "2015", "3500"]                                      # 正常边界仍命中
    assert sorted(ec.detect_entities(led, "2019年甲公司营收")) == [
        "2019", "甲公司"]
    assert ec.detect_entities(led, "子公司甲公司集团") == ["甲公司"]  # CJK 子串不变


def test_year_range_expansion() -> None:
    """"2019-2023" → 逐年 5 条组合; cap 截断生效."""
    assert ec.expand_years(["2019-2023"]) == [
        "2019", "2020", "2021", "2022", "2023"]
    led = ec.new_ledger("年报课题")
    led = {**led, "entities": {**led["entities"], "NAMES": ["X集团"],
                               "TEMPORAL": ["2019-2023"]}}
    sugg = ec.unsearched_combos(led, cap=20)
    assert len(sugg) == 5
    years = {c for s in sugg for c in s["combo"] if c.isdigit()}
    assert years == {"2019", "2020", "2021", "2022", "2023"}
    assert all(s["query"].startswith("年报课题") for s in sugg)
    assert len(ec.unsearched_combos(led, cap=2)) == 2  # cap 截断


def test_narrow_hint_streak() -> None:
    """3 次零结果触发窄检索预警; 有结果清零."""
    led = ec.new_ledger("T")
    assert ec.narrow_hint(led) is None
    for _ in range(2):
        led = ec.record_result(led, 0)
    assert ec.narrow_hint(led) is None               # streak=2 还不触发
    led = ec.record_result(led, 0)
    assert ec.narrow_hint(led) == "检索太窄了: 减少约束词/换同义词/去掉一个实体维度"
    led = ec.record_result(led, 7)
    assert led["zero_result_streak"] == 0 and ec.narrow_hint(led) is None


def test_immutability() -> None:
    """record_* 返回新对象, 原 ledger 不动 (含嵌套 entities)."""
    led = _topic_ledger()
    snap = _snapshot(led)
    led2 = ec.record_searched(led, "示范课题 甲公司 营收", ["营收", "甲公司"])
    led3 = ec.record_result(led2, 0)
    assert _snapshot(led) == snap                    # 原账本分毫不动
    assert led2 is not led and led3 is not led2
    assert led["searched"] == [] and led["combos"] == []
    assert led2["searched"] == ["示范课题 甲公司 营收"]
    assert led2["combos"] == [["甲公司", "营收"]]      # 排序去重组合键
    assert led3["zero_result_streak"] == 1 and led2["zero_result_streak"] == 0
    assert _snapshot(led2) != snap                   # 新对象确有变化


def test_cli_roundtrip(tmp_path: Path, monkeypatch, capsys) -> None:
    """init/record/backfill CLI 回路 (POOL_ROOT 指到临时目录, 不碰真池);
    未知 cid 报错不猜."""
    monkeypatch.setattr(ec, "POOL_ROOT", tmp_path)
    assert ec.main(["init", "--cid", "FT6-CLI", "--topic", "课题",
                    "--entity", "NAMES=甲,乙",
                    "--entity", "TEMPORAL=2019-2020"]) == 0
    assert (tmp_path / "FT6-CLI" / ec.STATE_NAME).is_file()
    assert ec.main(["backfill", "--cid", "FT6-CLI", "--cap", "3"]) == 0
    out = capsys.readouterr().out
    assert "[backfill] 课题 甲 营收" not in out       # 无 DESCRIPTORS 无笛卡尔
    assert ec.main(["record", "--cid", "FT6-CLI",
                    "--query", "课题 甲 2019 年报", "--hits", "2"]) == 0
    led = json.loads((tmp_path / "FT6-CLI" / ec.STATE_NAME)
                     .read_text(encoding="utf-8"))
    assert led["searched"] == ["课题 甲 2019 年报"]
    assert led["combos"] == [["2019", "甲"]]          # 反查实体 → 组合键
    assert led["zero_result_streak"] == 0
    sugg = ec.unsearched_combos(led, cap=20)
    assert all(s["combo"] != ["2019", "甲"] for s in sugg)  # 已搜被过滤
    assert ec.main(["record", "--cid", "NOPE-X", "--query", "q"]) == 1
    assert ec.main(["init", "--cid", "坏 id!", "--topic", "x"]) == 1
