# -*- coding: utf-8 -*-
"""sales_kit 单测 — 付费研报转化面生成器 (旗舰 F0).

覆盖: ①徽章零手拍 (值与 sidecar 逐项对账) ②简介含三卖点+徽章+购买栏
③目录章 100% 覆盖 + 每章定位句 ④framework 缺失硬拒 ⑤sidecar 缺席容错
(徽章降级不崩) ⑥落盘两件 + 不可变 ⑦ast 零网络根模块.
"""
from __future__ import annotations

import ast
import json
import sys
import tempfile
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from superline import sales_kit as SK              # noqa: E402


def _mk(tmp: Path):
    battle = tmp / "battle"
    pool = tmp / "pool" / "CAMP-S"
    battle.mkdir(parents=True)
    pool.mkdir(parents=True)
    fw = {"report_title": "《测试蓝皮书》", "chapters": [
        {"id": "ch01", "title": "产业全景",
         "description": "市场总量与竞争格局。含政策周期分析。"},
        {"id": "ch02", "title": "企业图谱",
         "description": "五十家总包企业深度画像。"}]}
    (battle / "framework.json").write_text(
        json.dumps(fw, ensure_ascii=False), encoding="utf-8")
    (pool / "claim_ledger.json").write_text(json.dumps({
        "stats": {"claims": 10, "by_state": {"双独立源确证": 8, "单源": 2},
                  "citation_recall": 1.0, "citation_precision": 0.95}},
        ensure_ascii=False), encoding="utf-8")
    (pool / "independence.json").write_text(json.dumps({
        "per_eei": {"E1": {"independent_n": 9}, "E2": {"independent_n": 3}},
        "with_evidence": 2}, ensure_ascii=False), encoding="utf-8")
    (pool / "doc_weight.json").write_text(json.dumps({
        "doc_level": {"n_docs": 867, "chars": 12937514}},
        ensure_ascii=False), encoding="utf-8")
    (pool / "grade_summary.json").write_text(json.dumps({
        "grades": {"A": 368, "B": 61, "C": 1132}}, ensure_ascii=False),
        encoding="utf-8")
    (pool / "charts_gate.json").write_text(json.dumps({
        "coverage": {"coverage": 1.0}}, ensure_ascii=False), encoding="utf-8")
    return battle, pool, fw


# ------------------------------------------------ ① 徽章零手拍
def test_01_badges_recompute():
    tmp = Path(tempfile.mkdtemp(prefix="sk_test_"))
    battle, pool, fw = _mk(tmp)
    b = SK.compute_badges(pool, fw)
    assert b["断言总数"] == 10
    assert b["双独立源确证率"] == 80.0
    assert b["引用召回率"] == 1.0
    assert b["独立信息源数"] == 9
    assert b["在档文档数"] == 867
    assert b["文档级语料万字"] == 1294            # 12,937,514 → 1294 万字
    assert b["A级占比%"] == round(368 * 100.0 / 1561, 1)
    assert b["表锚覆盖率"] == 1.0
    b2 = SK.compute_badges(pool, fw)              # 重算一致=可对账
    assert b == b2


# ------------------------------------------------ ② 简介要件
def test_02_blurb_contents():
    tmp = Path(tempfile.mkdtemp(prefix="sk_test_"))
    battle, pool, fw = _mk(tmp)
    b = SK.compute_badges(pool, fw)
    txt = SK.gen_blurb("《测试蓝皮书》", b, 10000, "卷一",
                       ["样章钩子一：单断言 9 独立源"])
    for key in ("你将得到", "信任徽章", "10 条断言", "80.0%", "¥10,000",
                "扫码下单", "样章钩子一"):
        assert key in txt, key


# ------------------------------------------------ ③ 目录 100% 覆盖
def test_03_outline_coverage():
    tmp = Path(tempfile.mkdtemp(prefix="sk_test_"))
    battle, pool, fw = _mk(tmp)
    b = SK.compute_badges(pool, fw)
    txt = SK.gen_outline(fw, b, "卷一")
    assert "ch01 产业全景" in txt and "ch02 企业图谱" in txt
    assert "市场总量与竞争格局" in txt          # 每章定位句
    assert txt.count("## ") == 2


# ------------------------------------------------ ④ framework 硬拒
def test_04_framework_required():
    tmp = Path(tempfile.mkdtemp(prefix="sk_test_"))
    empty = tmp / "empty"
    empty.mkdir()
    try:
        SK.build(empty, tmp, 10000, "卷一")
        raise AssertionError("framework 缺失应硬拒")
    except ValueError:
        pass


# ------------------------------------------------ ⑤ sidecar 缺席容错
def test_05_tolerant_missing_sidecars():
    tmp = Path(tempfile.mkdtemp(prefix="sk_test_"))
    battle, pool, fw = _mk(tmp)
    for f in ("claim_ledger.json", "independence.json", "doc_weight.json",
              "grade_summary.json", "charts_gate.json"):
        (pool / f).unlink()
    b = SK.compute_badges(pool, fw)
    assert b["断言总数"] == 0 and b["章数"] == 2   # 降级不崩
    txt = SK.gen_blurb("t", b, 10000, "卷一", [])
    assert "¥10,000" in txt


# ------------------------------------------------ ⑥ 落盘两件 + 不可变
def test_06_build_writes():
    tmp = Path(tempfile.mkdtemp(prefix="sk_test_"))
    battle, pool, fw = _mk(tmp)
    snap = (battle / "framework.json").read_text(encoding="utf-8")
    r = SK.build(battle, pool, 10000, "卷一", ["钩子"])
    assert (battle / "blurb.md").is_file()
    assert (battle / "outline_sales.md").is_file()
    assert r["coverage_ok"] is True
    assert (battle / "framework.json").read_text(encoding="utf-8") == snap


# ------------------------------------------------ ⑦ ast 零网络机检
def test_07_ast_no_network():
    tree = ast.parse(Path(SK.__file__).read_text(encoding="utf-8"))
    mods = set()
    for n in ast.walk(tree):
        if isinstance(n, ast.Import):
            mods.update(a.name.split(".")[0] for a in n.names)
        elif isinstance(n, ast.ImportFrom) and n.module:
            mods.add(n.module.split(".")[0])
    assert not (mods & {"urllib", "requests", "httpx", "curl_cffi",
                        "socket"}), f"网络根模块混入: {mods}"


if __name__ == "__main__":
    fns = [v for k, v in sorted(globals().items())
           if k.startswith("test_") and callable(v)]
    fail = 0
    for fn in fns:
        try:
            fn()
            print(f"  PASS {fn.__name__}")
        except Exception as e:
            fail += 1
            print(f"  FAIL {fn.__name__}: {type(e).__name__}: {e}")
    print(f"\n{len(fns) - fail}/{len(fns)} passed")
    sys.exit(1 if fail else 0)
