# -*- coding: utf-8 -*-
"""ach_arena v1 持久化单测 (V-002 / REQ-021 / 百倍V4).

覆盖: ①合成树+池 → run_persistent 落盘 jsonl + 行 schema 必字段
②排除链证据绑定: excluded 行 evidence_ids ⊆ manifest dedup_key 且
host 去重生效 (同 host+tree_node 只计一次) ③无挂树反证行 → 全
inconclusive / rival_excluded=false; contradict 行全假设 -0.5 排除
④树无 hypotheses → HYPOTHESIS_SEEDS 三假设兜底 ⑤CLI 退出码 (0/2)
⑥追加语义 (重跑加行不覆盖) ⑦真实池只读 (manifest/树字节不动).
"""
from __future__ import annotations

import json
import sys
import tempfile
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
import ach_arena as AA                                  # noqa: E402

TREE_HYPS = [
    {"id": "H1", "text": "总量扩张", "prior": 0.4},
    {"id": "H2", "text": "总量恶化", "prior": 0.3},
    {"id": "H3", "text": "结构分化", "prior": 0.3},
]
REQUIRED = {"hypothesis", "verdict", "rival_excluded", "evidence_ids",
            "exclusion_reason", "ts"}


def _row(dedup: str, node: str = "Q1-E1", *, stance: str = "against",
         grade: str = "A", url: str = "https://a.cn/x",
         judge: str = "valid") -> dict:
    return {"dedup_key": dedup, "tree_node": node, "stance": stance,
            "grade": grade, "url_norm": url, "judge": judge,
            "source_path": f"E:/pool/{dedup}.md", "chars": 100}


def _build(root: Path, rows: list[dict], hyps: list | None = TREE_HYPS,
           camp: str = "CAMP-A") -> Path:
    d = root / camp
    d.mkdir(parents=True, exist_ok=True)
    (d / "manifest.jsonl").write_text(
        "\n".join(json.dumps(r, ensure_ascii=False) for r in rows),
        encoding="utf-8")
    tree = {"campaign": camp, "topic": "T", "region": "R",
            "hypotheses": hyps, "subquestions": []}
    (d / "question_tree.json").write_text(
        json.dumps(tree, ensure_ascii=False), encoding="utf-8")
    return d


def _tmp_root() -> Path:
    return Path(tempfile.mkdtemp(prefix="ach_v1_test_"))


# ------------------------------------------------ ① 落盘 + schema
def test_01_persistent_writes_jsonl_schema():
    root = _tmp_root()
    camp = _build(root, [
        _row("k1", url="https://a.cn/x"),
        _row("k2", url="https://b.cn/y", grade="B"),
        _row("k3", url="https://a.cn/z"),               # 同 host → 去重
    ])
    out_rows = AA.run_persistent("CAMP-A", pool_root=root)
    p = camp / "ach_exclusions.jsonl"
    assert p.is_file()
    lines = [json.loads(x) for x in
             p.read_text(encoding="utf-8").splitlines() if x.strip()]
    assert len(lines) == 3 == len(out_rows)             # 每假设一行
    for r in lines:
        assert REQUIRED <= set(r)
        assert r["verdict"] in ("excluded", "supported", "inconclusive")
        assert isinstance(r["rival_excluded"], bool)
        assert isinstance(r["evidence_ids"], list)
    assert [r["hypothesis"] for r in lines] == ["H1", "H2", "H3"]


# ------------------------------------------------ ② 排除链证据绑定 + 去重
def test_02_exclusion_chain_binds_evidence_ids():
    root = _tmp_root()
    _build(root, [
        _row("k1", url="https://a.cn/x"),               # A 级 against
        _row("k2", url="https://b.cn/y", grade="B"),    # B 级 against
        _row("k3", url="https://a.cn/z"),               # 同 host a.cn → 去重
        _row("k4", node="Q1-E2", stance="support"),     # support 不入排除账
        _row("k5", judge="rejected"),                   # 非 valid 不计
        _row("k6", node=""),                            # 未挂树不计
    ])
    rows = {r["hypothesis"]: r for r in
            AA.run_persistent("CAMP-A", pool_root=root)}
    # 手算 (against: H1=-1.0, H2=+1.0, H3=+0.3; A=1.0, B=0.7):
    #   H1 = -(1.0+0.7) = -1.7 → excluded + rival_excluded
    #   H2 = +1.7 → supported
    #   H3 = +0.3×1.7 = +0.51 → supported
    assert rows["H1"]["verdict"] == "excluded"
    assert rows["H1"]["rival_excluded"] is True
    assert rows["H1"]["score"] == -1.7
    assert rows["H1"]["evidence_ids"] == ["k1", "k2"]   # k3 被 host 去重
    assert rows["H2"]["score"] == 1.7 and rows["H2"]["verdict"] == "supported"
    assert rows["H2"]["rival_excluded"] is False
    assert rows["H3"]["score"] == 0.51 and rows["H3"]["verdict"] == "supported"
    # 绑定的证据条目全部是 manifest 里的 against/valid 挂树行
    assert set(rows["H1"]["evidence_ids"]) <= {"k1", "k2", "k3"}
    assert "k4" not in rows["H1"]["evidence_ids"]


# ------------------------------------------------ ③ 无反证 / contradict
def test_03_no_counter_evidence_rival_false():
    root = _tmp_root()
    _build(root, [_row("s1", stance="support", url="https://a.cn/x"),
                  _row("s2", stance="neutral", url="https://b.cn/y")])
    for r in AA.run_persistent("CAMP-A", pool_root=root):
        assert r["verdict"] == "inconclusive"
        assert r["rival_excluded"] is False             # 无反证不排除 (铁律)
        assert r["evidence_ids"] == []
    # contradict 行 (数据矛盾): 全假设 -0.5 → 各自排除且留痕
    root2 = _tmp_root()
    _build(root2, [_row("c1", stance="contradict", url="https://a.cn/x")])
    rows2 = {r["hypothesis"]: r for r in
             AA.run_persistent("CAMP-A", pool_root=root2)}
    for hid in ("H1", "H2", "H3"):
        assert rows2[hid]["score"] == -0.5
        assert rows2[hid]["verdict"] == "excluded"
        assert rows2[hid]["rival_excluded"] is True
        assert rows2[hid]["evidence_ids"] == ["c1"]


# ------------------------------------------------ ④ 种子兜底
def test_04_hypothesis_seeds_fallback():
    # 4a: 树在但无 hypotheses 字段 → HYPOTHESIS_SEEDS 三假设
    root = _tmp_root()
    _build(root, [_row("k1")], hyps=None)
    rows = AA.run_persistent("CAMP-A", pool_root=root)
    assert [r["hypothesis"] for r in rows] == \
        [h["id"] for h in AA.HYPOTHESIS_SEEDS]
    assert all(r["hypothesis_source"] == "HYPOTHESIS_SEEDS" for r in rows)
    # 4b: 无树文件 → 同兜底, 挂树反证行照常计 (fail-soft 不炸)
    root2 = _tmp_root()
    camp = _build(root2, [_row("k1")])
    (camp / "question_tree.json").unlink()
    rows2 = AA.run_persistent("CAMP-A", pool_root=root2)
    assert len(rows2) == 3
    assert {r["hypothesis"] for r in rows2} == {"H1", "H2", "H3"}
    assert (camp / "ach_exclusions.jsonl").is_file()


# ------------------------------------------------ ⑤ CLI 退出码
def test_05_cli_exit_codes():
    root = _tmp_root()
    _build(root, [_row("k1"), _row("k2", url="https://b.cn/y", grade="B")])
    out = root / "cli_out.jsonl"
    assert AA.main(["--campaign", "CAMP-A", "--persistent",
                    "--out", str(out), "--pool-root", str(root)]) == 0
    assert out.is_file() and len(out.read_text(
        encoding="utf-8").splitlines()) == 3
    # 池目录不存在 → 2 (拼写防线, 不静默落盘)
    assert AA.main(["--campaign", "NOPE", "--persistent",
                    "--out", str(root / "x.jsonl"),
                    "--pool-root", str(root)]) == 2
    assert not (root / "x.jsonl").exists()


# ------------------------------------------------ ⑥ 追加语义 (只增不删)
def test_06_append_semantics():
    root = _tmp_root()
    camp = _build(root, [_row("k1"), _row("k2", url="https://b.cn/y",
                                          grade="B")])
    AA.run_persistent("CAMP-A", pool_root=root)
    AA.run_persistent("CAMP-A", pool_root=root)
    lines = [x for x in camp.joinpath("ach_exclusions.jsonl")
             .read_text(encoding="utf-8").splitlines() if x.strip()]
    assert len(lines) == 6                              # 重跑加行不覆盖


# ------------------------------------------------ ⑦ 真实池只读
def test_07_pool_readonly():
    root = _tmp_root()
    camp = _build(root, [_row("k1")])
    before = {p.name: p.read_bytes() for p in camp.iterdir() if p.is_file()}
    AA.run_persistent("CAMP-A", pool_root=root)
    after = {p.name: p.read_bytes() for p in camp.iterdir() if p.is_file()}
    for name, b in before.items():                      # 原文件一字节不动
        assert after[name] == b, f"改写了只读资产: {name}"
    assert set(after) - set(before) == {"ach_exclusions.jsonl"}


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
