# -*- coding: utf-8 -*-
"""independence_audit 单测 — 独立性三键审计器 (断言链 W2-2).

覆盖: ①三键连通分量 (渠道垄断杀独立性: 同 engine 跨 host 跨 doc 仍 1 簇)
②真独立 (三键全异 → 2 簇) ③占位 URL 回退 source_path stem ④judge/无节点
过滤 ⑤campaign 落 sidecar + 树零据 EEI ⑥不可变 ⑦ast 零网络根模块.
"""
from __future__ import annotations

import ast
import json
import sys
import tempfile
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
import independence_audit as IA                   # noqa: E402


def _row(node: str, doc: str, engine: str, url: str = "https://w/",
         sp: str = "", judge: str = "valid", stance: str = "support") -> dict:
    return {"dedup_key": f"{doc}#{node}", "engine": engine, "url_norm": url,
            "source_path": sp or f"E:/pool/{doc}.md", "chars": 100,
            "judge": judge, "tree_node": node, "stance": stance}


# ------------------------------------------------ ① 渠道垄断杀独立性
def test_01_channel_monopoly_single_cluster():
    rows = [
        # 同 EEI: 同 engine(ima) 跨 host 跨 doc → 连通 → 1 独立源
        _row("E1", "d1", "51_ima知识库", url="https://site-a.cn/x"),
        _row("E1", "d2", "51_ima知识库", url="https://site-b.cn/y"),
        _row("E1", "d3", "51_ima知识库", url="https://site-c.cn/z"),
    ]
    r = IA.audit_rows(rows)
    assert r["per_eei"]["E1"]["independent_n"] == 1
    assert r["per_eei"]["E1"]["single_source"] is True
    assert r["per_eei"]["E1"]["hosts"] == ["site-a.cn", "site-b.cn",
                                           "site-c.cn"]   # host 多≠独立


# ------------------------------------------------ ② 三键全异 → 真独立
def test_02_truly_independent():
    rows = [
        _row("E2", "d1", "52_官网深挖", url="https://www.sasac.gov.cn/a"),
        _row("E2", "d2", "99_v2问答", url="https://w/", sp="E:/pool/nb.md"),
    ]
    r = IA.audit_rows(rows)
    assert r["per_eei"]["E2"]["independent_n"] == 2
    assert r["per_eei"]["E2"]["single_source"] is False


# ------------------------------------------------ ③ 占位 URL 回退 stem
def test_03_placeholder_host_fallback():
    rows = [_row("E3", "d1", "e1", url="https://w/", sp="E:/pool/docA.md"),
            _row("E3", "d2", "e2", url="https://w/", sp="E:/pool/docB.md")]
    r = IA.audit_rows(rows)
    assert r["per_eei"]["E3"]["hosts"] == ["docA", "docB"]  # stem 回退
    assert r["per_eei"]["E3"]["independent_n"] == 2         # engine 也异


# ------------------------------------------------ ④ 过滤: judge/无节点
def test_04_filter_invalid_and_nodeless():
    rows = [
        _row("E4", "d1", "e1"),
        _row("E4", "d9", "e9", judge="rejected"),            # 不计
        {"dedup_key": "x", "engine": "e2", "url_norm": "https://w/",
         "chars": 1, "judge": "valid", "stance": "support"},  # 无 tree_node
    ]
    r = IA.audit_rows(rows)
    assert r["with_evidence"] == 1
    assert r["per_eei"]["E4"]["docs"] == 1


# ------------------------------------------------ ⑤ campaign sidecar + 树
def test_05_campaign_sidecar_and_tree():
    tmp = Path(tempfile.mkdtemp(prefix="ind_test_"))
    camp = tmp / "CAMP-I"
    camp.mkdir(parents=True)
    rows = [_row("E1", "d1", "51_ima知识库", url="https://site-a.cn/x"),
            _row("E1", "d2", "51_ima知识库", url="https://site-b.cn/y"),
            _row("E5", "d5", "e5", url="https://w/")]
    (camp / "manifest.jsonl").write_text(
        "\n".join(json.dumps(x, ensure_ascii=False) for x in rows),
        encoding="utf-8")
    tree = {"subquestions": [{"eeis": [{"id": "E1"}, {"id": "E5"},
                                       {"id": "E9"}]}]}
    (camp / "question_tree.json").write_text(
        json.dumps(tree, ensure_ascii=False), encoding="utf-8")
    res = IA.audit_campaign("CAMP-I", tmp)
    sc = camp / "independence.json"
    assert sc.is_file()
    d = json.loads(sc.read_text(encoding="utf-8"))
    assert d["tree_eei_total"] == 3
    assert d["zero_evidence_eeis"] == ["E9"]
    assert d["tree_source"] == "v1"
    assert d["single_source_eeis"] == ["E1", "E5"]
    assert d["single_source_pct"] == 100.0            # 2/2 全单源
    assert any("单源" in w for w in res["warnings"])
    # 原 manifest 零改动
    assert len((camp / "manifest.jsonl").read_text(encoding="utf-8")
               .splitlines()) == 3


# ------------------------------------------------ ⑥ 不可变
def test_06_immutability():
    rows = [_row("E6", "d1", "e1"), _row("E6", "d2", "e2")]
    snap = json.dumps(rows, ensure_ascii=False, sort_keys=True)
    IA.audit_rows(rows)
    IA.cluster_count([("h", "e", "d"), ("h2", "e", "d2")])
    assert json.dumps(rows, ensure_ascii=False, sort_keys=True) == snap


# ------------------------------------------------ ⑦ ast 零网络机检
def test_07_ast_no_network():
    tree = ast.parse(Path(IA.__file__).read_text(encoding="utf-8"))
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
