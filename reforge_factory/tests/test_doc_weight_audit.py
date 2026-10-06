# -*- coding: utf-8 -*-
"""doc_weight_audit 单测 — 当量去重审计器 (断言链 W1-1).

覆盖: ①同文档挂多节点 → 行级通胀/文档级真值 ②judge 过滤 ③单文档节点
清单 ④渠道集中度 ⑤审计落 sidecar 且原 manifest 零改动 ⑥不可变 ⑦ast
零网络根模块.
"""
from __future__ import annotations

import ast
import json
import sys
import tempfile
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
import doc_weight_audit as dw                # noqa: E402


def _row(base: str, node: str, chars: int, engine: str = "52_官网深挖",
         judge: str = "valid") -> dict:
    return {"dedup_key": f"{base}#{node}", "engine": engine,
            "url_norm": "https://w/", "chars": chars, "judge": judge,
            "tree_node": node, "stance": "support"}


_ROWS = [
    # doc1 (1000 字) 挂 3 节点 → 行级 3000, 文档级 1000
    _row("E:/pool/doc1.md", "T1", 1000),
    _row("E:/pool/doc1.md", "T2", 1000),
    _row("E:/pool/doc1.md", "T3", 1000),
    # doc2 (500 字) 仅挂 T2 → T2 双文档
    _row("E:/pool/doc2.md", "T2", 500, engine="99_v2问答"),
    # rejected 不计
    _row("E:/pool/doc3.md", "T4", 9000, judge="rejected"),
]


# ------------------------------------------------ ① 通胀与文档级真值
def test_01_inflation_and_doc_chars():
    r = dw.audit_rows(_ROWS)
    assert r["rows_valid"] == 4
    assert r["row_chars"] == 3500
    assert r["doc_count"] == 2
    assert r["doc_chars"] == 1500
    assert r["inflation_x"] == 2.33
    assert r["doc_mean_chars"] == 750


# ------------------------------------------------ ③ 单文档节点清单
def test_02_single_doc_nodes():
    r = dw.audit_rows(_ROWS)
    assert r["node_count"] == 3              # T4 无 valid 行
    assert r["single_doc_nodes"] == ["T1", "T3"]
    assert r["single_doc_node_pct"] == 66.67


# ------------------------------------------------ ④ 渠道集中度
def test_03_engine_concentration():
    r = dw.audit_rows(_ROWS)
    assert r["engine_doc_counts"] == {"52_官网深挖": 1, "99_v2问答": 1}
    assert r["top_engine"]["doc_pct"] == 50.0


# ------------------------------------------------ ⑤ 审计落 sidecar + 告警
def test_04_campaign_sidecar_and_warnings():
    tmp = Path(tempfile.mkdtemp(prefix="dw_test_"))
    camp = tmp / "CAMP-Y"
    camp.mkdir(parents=True)
    (camp / "manifest.jsonl").write_text(
        "\n".join(json.dumps(r, ensure_ascii=False) for r in _ROWS),
        encoding="utf-8")
    res = dw.audit_campaign("CAMP-Y", tmp)
    sc = camp / "doc_weight.json"
    assert sc.is_file()
    d = json.loads(sc.read_text(encoding="utf-8"))
    assert d["doc_chars"] == 1500 and d["cid"] == "CAMP-Y"
    assert any("通胀" in w for w in res["warnings"])   # 2.33x > 2.0 触发
    assert res["tree_eei_total"] == 0                  # 无树文件
    # 原 manifest 零改动
    assert len((camp / "manifest.jsonl").read_text(encoding="utf-8")
               .splitlines()) == 5


# ------------------------------------------------ ⑤b 有树文件 → 零据 EEI
def test_05_tree_zero_eei():
    tmp = Path(tempfile.mkdtemp(prefix="dw_test2_"))
    camp = tmp / "CAMP-Z"
    camp.mkdir(parents=True)
    (camp / "manifest.jsonl").write_text(
        json.dumps(_row("E:/d.md", "T1", 100), ensure_ascii=False),
        encoding="utf-8")
    tree = {"subquestions": [{"eeis": [{"id": "T1"}, {"id": "T2"},
                                       {"id": "T3"}, {"id": "T4"}]}]}
    (camp / "question_tree.json").write_text(
        json.dumps(tree, ensure_ascii=False), encoding="utf-8")
    res = dw.audit_campaign("CAMP-Z", tmp)
    assert res["tree_eei_total"] == 4
    assert res["node_count"] == 1
    assert res["zero_doc_eei"] == 3


# ------------------------------------------------ ⑥ 不可变
def test_06_immutability():
    snap = json.dumps(_ROWS, ensure_ascii=False, sort_keys=True)
    dw.audit_rows(_ROWS)
    assert json.dumps(_ROWS, ensure_ascii=False, sort_keys=True) == snap


# ------------------------------------------------ ⑦ ast 零网络机检
def test_07_ast_no_network():
    tree = ast.parse(Path(dw.__file__).read_text(encoding="utf-8"))
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
