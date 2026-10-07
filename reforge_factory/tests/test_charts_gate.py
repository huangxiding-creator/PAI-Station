# -*- coding: utf-8 -*-
"""charts_gate 单测 — 数据表先行门: 终稿数字 100% 表锚 (断言链 W5-3).

覆盖: ①登记簿六件套校验 (缺件/重复表号/列数不齐/幽灵文档锚) ②数字
表锚覆盖 (单元格命中/[[T:]] 行级锚/无表锚 FAIL) ③空登记簿真拒
④表格行与标题行不计正文数字 ⑤战役 sidecar + registry join ⑥不可变
⑦ast 零网络根模块.
"""
from __future__ import annotations

import ast
import json
import sys
import tempfile
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from superline import charts_gate as CG              # noqa: E402


_T = [{
    "table_id": "T01", "caption": "人才培养指标", "口径": "官网新闻披露口径",
    "时点": "2024-12-31", "source_docs": ["D1314"],
    "columns": ["年度", "指标", "数值"],
    "rows": [["2024", "新员工培训人次", "约 300 人次"]],
}, {
    "table_id": "T02", "caption": "数字化交付占比 (预测)", "口径": "公司规划口径",
    "时点": "2027-12-31", "source_docs": ["D1314", "D1530"],
    "columns": ["情形", "占比"],
    "rows": [["基准", "60%"], ["乐观", "75%"]],
}]


# ------------------------------------------------ ① 登记簿校验
def test_01_validate_tables():
    assert CG.validate_tables(_T, {"D1314", "D1530"}) == []
    errs = CG.validate_tables([{**_T[0], "口径": "", "table_id": "T01"},
                               {**_T[1], "table_id": "T01"}],
                              {"D1314", "D1530"})
    assert any("口径" in e for e in errs)
    assert any("重复" in e for e in errs)
    bad_cols = CG.validate_tables(
        [{**_T[0], "rows": [["2024", "只两列"]]}], {"D1314"})
    assert any("列数" in e for e in bad_cols)
    ghost = CG.validate_tables(_T, {"D9999"})
    assert any("未落账" in e for e in ghost)


# ------------------------------------------------ ② 覆盖判据
def test_02_coverage():
    md = ("培训覆盖约 300 人次，形成机制。数字化占比将超过 60%。"
          "另有口径外数字 9999 吨未入表。")
    r = CG.number_coverage(md, _T)
    assert r["total"] == 3
    assert r["covered"] == 2                    # 300人次+60% 命中单元格
    assert [u["num"] for u in r["uncovered"]] == ["9999 吨"]
    assert r["pass"] is False
    anchored = "行业总量按外部口径引用 8888 万元[[T:T02]]。"
    r2 = CG.number_coverage(anchored, _T)
    assert r2["covered"] == 1                   # [[T:]] 行级锚兜底
    assert r2["pass"] is True
    clean = "培训覆盖约 300 人次。"
    assert CG.number_coverage(clean, _T)["pass"] is True


# ------------------------------------------------ ③ 空登记簿真拒
def test_03_empty_registry():
    assert any("为空" in e for e in CG.validate_tables([], None))
    r = CG.number_coverage("产值 100 亿元。", [])
    assert r["pass"] is False


# ------------------------------------------------ ④ 表格/标题行不计
def test_04_skip_table_heading_lines():
    md = ("| 年度 | 数值 |\n|---|---|\n| 2024 | 5000 万元 |\n"
          "# 标题 7777 亿元\n正文干净无数字句。")
    r = CG.number_coverage(md, _T)
    assert r["total"] == 0


# ------------------------------------------------ ⑤ 战役 sidecar
def test_05_campaign_sidecar():
    tmp = Path(tempfile.mkdtemp(prefix="cg_test_"))
    camp = tmp / "CAMP-C"
    camp.mkdir(parents=True)
    (camp / "tables.json").write_text(
        json.dumps({"tables": _T}, ensure_ascii=False), encoding="utf-8")
    (camp / "doc_registry.json").write_text(json.dumps(
        {"docs": [{"id": x} for x in ("D1314", "D1530")]},
        ensure_ascii=False), encoding="utf-8")
    draft = tmp / "d.md"
    draft.write_text("培训覆盖约 300 人次。数字化占比将超过 60%。\n",
                     encoding="utf-8")
    r = CG.audit_campaign(draft, "CAMP-C", tmp)
    assert r["registry_errors"] == []
    assert r["coverage"]["pass"] is True
    assert r["overall_pass"] is True
    out = camp / "charts_gate.json"
    assert out.is_file()
    snap = json.dumps(_T, ensure_ascii=False, sort_keys=True)
    assert json.dumps(_T, ensure_ascii=False, sort_keys=True) == snap


# ------------------------------------------------ ⑥ 不可变
def test_06_immutability():
    snap = json.dumps(_T, ensure_ascii=False, sort_keys=True)
    CG.number_coverage("300 人次 与 60%。", _T)
    CG.validate_tables(_T, None)
    assert json.dumps(_T, ensure_ascii=False, sort_keys=True) == snap


# ------------------------------------------------ ⑦ ast 零网络机检
def test_07_ast_no_network():
    tree = ast.parse(Path(CG.__file__).read_text(encoding="utf-8"))
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
