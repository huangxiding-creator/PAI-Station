# -*- coding: utf-8 -*-
"""redteam_gate 单测 — 红队轮双门+KAC+ICD203+校准账本 (断言链 W4-2).

覆盖: ①ICD 203 七档表映射 ②置信度三因子自动推导 (含碎片化降档)
③分句禁同句机检 ④premortem 双门登记簿 (100% 映射{缓解|接受}/post 门
证据回应/条数 3-5) ⑤KAC (linchpin 指标门/双跑留痕) ⑥启发式兜底产登记簿
⑦icd203 行 (T0/预测 100% 标注/missing 旗标) ⑧校准账本 (≥5 门/指纹
去重/Brier 对账) ⑨战役四门汇总 sidecar ⑩ast 零网络根模块.
"""
from __future__ import annotations

import ast
import json
import sys
import tempfile
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from superline import redteam_gate as RT                # noqa: E402


# ------------------------------------------------ ① 七档表
def test_01_likelihood_band():
    assert RT.likelihood_band(3)[0] == "几乎不可能"
    assert RT.likelihood_band(50) == ("大致均等", "35-65%")
    assert RT.likelihood_band(90)[0] == "很可能"
    assert RT.likelihood_band(99)[0] == "几乎肯定"
    assert RT.likelihood_band(100)[0] == RT.likelihood_band(99)[0]  # 钳位
    assert len(RT.LIKELIHOOD_BANDS) == 7


# ------------------------------------------------ ② 置信度三因子
def test_02_derive_confidence():
    assert RT.derive_confidence(2, "A", 2) == "high"
    assert RT.derive_confidence(2, "B", 2) == "high"
    assert RT.derive_confidence(2, "C", 2) == "moderate"
    assert RT.derive_confidence(1, "A", 1) == "moderate"
    assert RT.derive_confidence(1, "C", 1) == "low"
    assert RT.derive_confidence(1, "A", 5) == "low"      # 碎片化降档
    assert RT.derive_confidence(2, "A", 9) == "high"     # 双独立在, 冗余不降档


# ------------------------------------------------ ③ 分句禁同句
def test_03_split_violations():
    bad = "该判断很可能成立，高置信。"
    assert len(RT.split_violations(bad)) == 1
    good = "该判断很可能成立。置信度为中等，依据独立源两处。"
    assert RT.split_violations(good) == []               # 分句即合规
    assert RT.split_violations("普通句无标注。") == []


# ------------------------------------------------ ④ premortem 双门
def test_04_validate_premortem():
    ok = [{"risk": "r1", "disposition": "缓解", "measure": "m",
           "reason": "", "evidence": "e"},
          {"risk": "r2", "disposition": "接受", "measure": "",
           "reason": "为什么", "evidence": "e"},
          {"risk": "r3", "disposition": "缓解", "measure": "m",
           "reason": "", "evidence": "e"}]
    assert RT.validate_premortem(ok, "post") == []
    no_ev = [{**ok[0], "evidence": ""}]
    errs = RT.validate_premortem([*ok[:2], *no_ev], "post")
    assert any("evidence" in e for e in errs)
    assert RT.validate_premortem(ok, "pre") == []        # pre 门不要 evidence
    bad_disp = [{**ok[0], "disposition": "悬置"}]
    assert any("disposition" in e for e in RT.validate_premortem(
        [*ok[:2], *bad_disp], "pre"))
    no_measure = [{**ok[0], "measure": ""}]
    assert any("measure" in e for e in RT.validate_premortem(
        [*ok[:2], *no_measure], "pre"))
    assert any("条数" in e for e in RT.validate_premortem(ok[:1], "pre"))


# ------------------------------------------------ ⑤ KAC
def test_05_validate_kac():
    asm = [{"text": "行业扩张持续", "linchpin": True,
            "basis": "b", "abandon_if": ["订单增速转负"]},
           {"text": "次假设", "linchpin": False, "basis": "b",
            "abandon_if": []}]
    assert RT.validate_kac(asm, ["start", "final"]) == []
    errs = RT.validate_kac([{**asm[0], "abandon_if": []}], ["start"])
    assert any("abandon_if" in e for e in errs)
    assert any("final" in e for e in errs)               # 双跑缺一


# ------------------------------------------------ ⑥ 启发式兜底
def test_06_heuristic_premortem():
    ledger = {"stats": {"claims": 5, "by_state": {"单源": 4, "未确证": 1},
                        "t0_blocked": 1},
              "claims": [{"类型": "预测"}, {"类型": "事实"}]}
    items = RT.heuristic_premortem(ledger)
    assert 3 <= len(items) <= 5
    assert all(i["disposition"] in RT.DISPOSITIONS for i in items)
    assert any(i["disposition"] == "接受" for i in items)
    assert all(i.get("evidence") for i in items)         # 兜底也带证据锚


# ------------------------------------------------ ⑦ icd203 行
def test_07_icd203_rows():
    ledger = {"claims": [
        {"claim_id": "C0001", "断言": "营收 100 亿元", "T0": True,
         "类型": "事实", "独立源数": 2, "最优等级": "A", "证据ids": ["D1", "D2"]},
        {"claim_id": "C0006", "断言": "预计五年内超 60%", "T0": True,
         "类型": "预测", "独立源数": 1, "最优等级": "A", "证据ids": ["D3"]},
        {"claim_id": "C0007", "断言": "普通句", "T0": False,
         "类型": "事实", "独立源数": 1, "最优等级": "C", "证据ids": ["D4"]}]}
    authored = {"C0001": {"p": 90, "verification": "年报",
                          "deadline": "2027-04-30"}}
    rows = RT.icd203_rows(ledger, authored)
    assert [r["claim_id"] for r in rows] == ["C0001", "C0006"]  # T0/预测 100%
    assert rows[0]["likelihood"].startswith("很可能")
    assert rows[0]["confidence"] == "high"                # 双独立+A 自动推导
    assert rows[1]["missing"] is True                     # 未标注被旗标


# ------------------------------------------------ ⑧ 校准账本
def test_08_calibration_ledger():
    tmp = Path(tempfile.mkdtemp(prefix="rt_test_")) / "cal.jsonl"
    items = [{"判断": f"判断{i}", "probability": 0.7,
              "verification": "口径", "deadline": "2027-12-31"}
             for i in range(5)]
    assert RT.append_predictions(tmp, "CAMP", items) == 5
    assert RT.append_predictions(tmp, "CAMP", items) == 0   # 指纹去重
    r = RT.score_matured(tmp, "CAMP", {"判断0": 1, "判断1": 0})
    assert r["scored"] == 2
    assert r["mean_brier"] == round(((0.7 - 1) ** 2 + (0.7 - 0) ** 2) / 2, 4)
    rows = [json.loads(x) for x in tmp.read_text(
        encoding="utf-8").splitlines()]
    assert sum(1 for x in rows if x["brier"] is not None) == 2
    assert RT.score_matured(tmp, "CAMP", {"判断0": 1})["scored"] == 0  # 幂等


# ------------------------------------------------ ⑨ 战役四门
def test_09_campaign_audit():
    tmp = Path(tempfile.mkdtemp(prefix="rt_test_"))
    camp = tmp / "CAMP-R"
    camp.mkdir(parents=True)
    (camp / "claim_ledger.json").write_text(json.dumps({
        "stats": {"claims": 2, "by_state": {"单源": 2}, "t0_blocked": 0},
        "claims": [
            {"claim_id": "C0001", "断言": "营收 100 亿元", "T0": True,
             "类型": "事实", "独立源数": 2, "最优等级": "A",
             "证据ids": ["D1", "D2"]}]}, ensure_ascii=False),
        encoding="utf-8")
    # 无登记簿 → 双门 FAIL (真拒)
    r = RT.audit_campaign("CAMP-R", tmp, "", heuristic=False)
    assert r["gates"]["premortem"]["pass"] is False
    assert r["gates"]["kac"]["pass"] is False
    assert r["gates"]["calibration"]["pass"] is False      # 0 < 5
    # 启发式 + 人工 authored icd203/校准 → 四门 PASS
    pm = {"gates": {"pre": RT.heuristic_premortem(
        {"stats": {"claims": 2, "by_state": {"单源": 2}, "t0_blocked": 1},
                   "claims": [{"类型": "预测"}]}),
        "post": RT.heuristic_premortem(
        {"stats": {"claims": 2, "by_state": {"单源": 2}, "t0_blocked": 1},
                   "claims": [{"类型": "预测"}]})}}
    (camp / "premortem.json").write_text(json.dumps(pm, ensure_ascii=False),
                                         encoding="utf-8")
    (camp / "kac.json").write_text(json.dumps({
        "assumptions": [{"text": "a", "linchpin": True, "basis": "b",
                         "abandon_if": ["x"]}],
        "phases": ["start", "final"]}, ensure_ascii=False), encoding="utf-8")
    (camp / "icd203.json").write_text(json.dumps(
        {"C0001": {"p": 90, "verification": "年报",
                   "deadline": "2027-04-30"}}, ensure_ascii=False),
        encoding="utf-8")
    RT.append_predictions(camp / "calibration_ledger.jsonl", "CAMP-R", [
        {"判断": f"判断{i}", "probability": 0.6, "verification": "口径",
         "deadline": "2027-12-31"} for i in range(5)])
    r2 = RT.audit_campaign("CAMP-R", tmp,
                           "该判断很可能成立。置信度高，因有独立源。")
    assert r2["gates"]["premortem"]["pass"] is True
    assert r2["gates"]["kac"]["pass"] is True
    assert r2["gates"]["icd203"]["pass"] is True
    assert r2["gates"]["calibration"]["pass"] is True
    assert r2["overall_pass"] is True
    assert (camp / "redteam.json").is_file()


# ------------------------------------------------ ⑩ ast 零网络机检
def test_10_ast_no_network():
    tree = ast.parse(Path(RT.__file__).read_text(encoding="utf-8"))
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
