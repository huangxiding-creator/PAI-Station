# -*- coding: utf-8 -*-
"""test_coverage_facets — B 轴十面×facet 点亮矩阵传感器 (T-007B / REQ-024).

REQ-024.AC1 证明 (tmp 合成池, 真实池零接触):
  a) 十面夹具: 8 面 L2/L3 证据 + 1 面仅 L1 单条 + 1 面零证据
     → lit_count=8 / lit_ratio=0.8 / green=False; L1 面不点亮 (核心断言)
  b) 深度阶梯: 1 条=L1 提及 / ≥2 条单 host=L2 数据 / ≥2 独立 host=L3 双源
  c) judge!=valid 不计数; 挂到树外节点的证据不计数 (note 透明)
  d) 双落盘: coverage_facets.json (REQ-024.AC1 锚点) 与 completeness/B_axis.json
     同负载, schema 含 axis/sensor/facets/lit_count/lit_ratio/green
  e) 全十面 L2+ → lit_count=10, green=True
  f) 树缺失 → fail-soft: 十面全 unlit + note, 不虚报, 照常落盘
  g) dim→十面映射: v0 六维精确表 + 扩展四面恒等 + 关键词回退 + 未映射显式 None

跑法: py -m pytest reforge_factory/tests/test_coverage_facets.py -q
"""
import json
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from completeness.coverage_facets import (   # noqa: E402
    TEN_FACETS, dim_to_facet, scan)

# 合成树维度 → 期望面 (v0 六维 + 扩展四面同名)
DIM2FACET = {"政策监管": "政策法规", "市场规模": "市场行情",
             "竞争格局": "竞争格局", "项目案例": "案例实践",
             "风险事件": "风险纠纷", "财务经营": "财务经营",
             "技术方案": "技术方案", "组织人事": "组织人事",
             "国际对标": "国际对标", "渠道生态": "渠道生态"}

_N = [0]


def _row(node: str, host: str, judge: str = "valid",
         stance: str = "support") -> dict:
    """manifest 行合成 (字段与 ammo_pool.ingest 落盘行同构)."""
    _N[0] += 1
    return {"ts": "2026-10-15T10:00:00", "engine": "test",
            "source_path": f"E:/tmp/{host}_{_N[0]}.txt",
            "url_norm": f"http://{host}/p{_N[0]}", "chars": 500,
            "credibility": "web", "dedup_key": f"k{_N[0]}",
            "judge": judge, "judge_reason": "", "judge_engine": "",
            "tree_node": node, "stance": stance, "budget_band": "",
            "text_head": f"合成证据 {node}@{host}#{_N[0]} " + "内容互异 " * 12}


def _mk_camp(base: Path, tree: bool = True, rows: list | None = None) -> Path:
    """十面合成池: question_tree.json (10 子问×1 EEI) + manifest.jsonl."""
    d = base / "CAMP"
    d.mkdir(parents=True, exist_ok=True)
    if tree:
        subs = [{"id": f"Q{i+1}", "dim": dim, "text": f"{dim} 合成子问题",
                 "falsifiable": True,
                 "eeis": [{"id": f"Q{i+1}-E1", "need": f"{dim} 证据需求",
                           "stance": "support", "status": "zero"}]}
                for i, dim in enumerate(DIM2FACET)]
        (d / "question_tree.json").write_text(json.dumps(
            {"campaign": "CAMP", "topic": "合成战役", "region": "全国",
             "subquestions": subs,
             "stats": {"subquestions": 10, "eeis": 10}}, ensure_ascii=False),
            encoding="utf-8")
    (d / "manifest.jsonl").write_text(
        "\n".join(json.dumps(r, ensure_ascii=False) for r in (rows or [])),
        encoding="utf-8")
    return d


def _fixture_rows() -> list[dict]:
    """8 面 L2/L3 + 案例实践仅 L1 (Q4 单条) + 渠道生态零 (Q10 无行)."""
    rows: list[dict] = []
    for i in range(1, 11):                      # Q1..Q10 ↔ DIM2FACET 序
        node = f"Q{i}-E1"
        if i == 4:                              # 案例实践: 仅 1 条 → L1 不亮
            rows.append(_row(node, "case.example.com"))
        elif i == 10:                           # 渠道生态: 零证据 → L0
            continue
        elif i % 2:                             # 双源 → L3
            rows.append(_row(node, "a.example.com"))
            rows.append(_row(node, "b.example.com", stance="against"))
        else:                                   # 多条单 host → L2
            rows.append(_row(node, "single.example.com/x1"))
            rows.append(_row(node, "single.example.com/x2"))
    rows.append(_row("Q1-E1", "c.example.com", judge="rejected"))  # 不计数
    rows.append(_row("Q99-E1", "z.example.com"))                    # 树外节点
    return rows


# ---------- a) 十面夹具: lit_count=8 / L1 面不点亮 / 比例 ----------

def test_a_eight_lit_and_l1_facet_not_lit(tmp_path):
    d = _mk_camp(tmp_path, rows=_fixture_rows())
    rec = scan("CAMP", pool_root=tmp_path, write=False)
    assert rec["axis"] == "B" and rec["sensor"] == "coverage_facets"
    assert rec["campaign"] == "CAMP"
    f = rec["facets"]
    assert set(f) == set(TEN_FACETS)            # 十面全在档 (缺格禁隐身)
    assert rec["lit_count"] == 8
    assert rec["lit_ratio"] == 0.8
    assert rec["green"] is False                # 8/10 ≠ 全亮
    assert f["案例实践"]["lit"] is False        # L1 仅记提及, 不点亮 (核心)
    assert f["案例实践"]["best_depth"] == "L1"
    assert f["案例实践"]["evidence"] == 1
    assert f["渠道生态"]["lit"] is False        # 零证据面
    assert f["渠道生态"]["best_depth"] == "L0"
    assert f["渠道生态"]["evidence"] == 0
    assert f["政策法规"]["evidence"] == 2       # rejected 行不计 (2 非 3)


# ---------- b) 深度阶梯: L1 提及 / L2 数据 / L3 双源 ----------

def test_b_depth_ladder_l1_l2_l3(tmp_path):
    d = _mk_camp(tmp_path, rows=_fixture_rows())
    f = scan("CAMP", pool_root=tmp_path, write=False)["facets"]
    assert f["案例实践"]["best_depth"] == "L1"          # 1 条=提及
    assert f["市场行情"]["best_depth"] == "L2"          # 2 条同 host=数据
    assert f["市场行情"]["lit"] is True                 # Q2 维名=市场规模→面市场行情
    assert f["政策法规"]["best_depth"] == "L3"          # 2 独立 host=双源
    assert f["政策法规"]["hosts"] == 2
    assert f["政策法规"]["stance"] == {"support": 1, "against": 1}


# ---------- c) 树外挂点透明: 不计数但 note 在案 ----------

def test_c_off_tree_and_unattached_rows_noted(tmp_path):
    d = _mk_camp(tmp_path, rows=_fixture_rows() + [
        _row("", "na.example.com"),               # 未挂树 (tree_node 空)
    ])
    rec = scan("CAMP", pool_root=tmp_path, write=False)
    assert rec["facets"]["政策法规"]["evidence"] == 2  # 树外/未挂树均未计入
    joined = " ".join(rec["notes"])
    assert "树外" in joined and "未挂树" in joined


# ---------- d) 双落盘: coverage_facets.json + completeness/B_axis.json ----------

def test_d_dual_write_schema(tmp_path):
    d = _mk_camp(tmp_path, rows=_fixture_rows())
    rec = scan("CAMP", pool_root=tmp_path)       # 默认写盘
    cf = json.loads((d / "coverage_facets.json").read_text(encoding="utf-8"))
    ba = json.loads((d / "completeness" / "B_axis.json")
                    .read_text(encoding="utf-8"))
    assert cf == ba == rec                       # 双落盘同负载 (一源两锚)
    for r in (cf, ba):
        assert r["axis"] == "B"
        assert r["sensor"] == "coverage_facets"
        assert r["lit_count"] == 8 and r["lit_ratio"] == 0.8
        assert r["green"] is False
        assert set(r["facets"]) == set(TEN_FACETS)
        assert r["facets"]["政策法规"]["lit"] is True
        assert r["lit_rule"]                      # 点亮口径自描述 (防伪)


# ---------- e) 全十面点亮 → green ----------

def test_e_all_ten_lit_green(tmp_path):
    rows = [r for i in range(1, 11) for r in
            (_row(f"Q{i}-E1", f"h{i}a.example.com"),
             _row(f"Q{i}-E1", f"h{i}b.example.com"))]
    _mk_camp(tmp_path, rows=rows)
    rec = scan("CAMP", pool_root=tmp_path, write=False)
    assert rec["lit_count"] == 10
    assert rec["lit_ratio"] == 1.0
    assert rec["green"] is True
    assert all(v["lit"] for v in rec["facets"].values())


# ---------- f) 树缺失 → fail-soft 全 unlit + note, 照常落盘 ----------

def test_f_missing_tree_fail_soft(tmp_path):
    d = _mk_camp(tmp_path, tree=False, rows=[_row("", "x.example.com")])
    rec = scan("CAMP", pool_root=tmp_path)
    assert rec["lit_count"] == 0 and rec["green"] is False
    assert set(rec["facets"]) == set(TEN_FACETS)
    assert all(v["lit"] is False and v["evidence"] == 0
               and v["best_depth"] == "L0"
               for v in rec["facets"].values())  # 十面全 unlit 不虚报
    assert any("问题树" in n for n in rec["notes"])
    assert (d / "coverage_facets.json").is_file()           # 照常落盘
    assert (d / "completeness" / "B_axis.json").is_file()


# ---------- g) dim→十面映射: 精确表 / 恒等 / 关键词回退 / 未映射 ----------

def test_g_dim_mapping_table_and_keywords():
    for dim, facet in DIM2FACET.items():        # v0 六维精确表
        assert dim_to_facet(dim) == facet
    assert dim_to_facet("政策法规") == "政策法规"          # 十面名恒等
    assert dim_to_facet("03_组织与人才") == "组织人事"     # 关键词回退
    assert dim_to_facet("08_风险管控") == "风险纠纷"
    assert dim_to_facet("10_市场与对标") == "市场行情"     # 对标≠国际, 市场优先
    assert dim_to_facet("05_设计管理") == "技术方案"
    assert dim_to_facet("06_采购与供应链") == "渠道生态"
    assert dim_to_facet("神秘未映射域") is None           # 未映射显式 None


def test_g_unmapped_dim_evidence_noted(tmp_path):
    subs = [{"id": "Q1", "dim": "政策监管", "text": "t",
             "eeis": [{"id": "Q1-E1", "need": "n", "stance": "support",
                       "status": "zero"}]},
            {"id": "Q2", "dim": "神秘未映射域", "text": "t",
             "eeis": [{"id": "Q2-E1", "need": "n", "stance": "support",
                       "status": "zero"}]}]
    d = tmp_path / "CAMP2"
    d.mkdir(parents=True)
    (d / "question_tree.json").write_text(json.dumps(
        {"subquestions": subs}, ensure_ascii=False), encoding="utf-8")
    (d / "manifest.jsonl").write_text(
        json.dumps(_row("Q2-E1", "u.example.com"), ensure_ascii=False),
        encoding="utf-8")
    rec = scan("CAMP2", pool_root=tmp_path, write=False)
    assert rec["facets"]["政策法规"]["evidence"] == 0    # 未映射维证据不入面
    assert any("未映射" in n and "神秘未映射域" in n for n in rec["notes"])
