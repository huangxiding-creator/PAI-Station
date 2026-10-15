# -*- coding: utf-8 -*-
"""test_tree_backfill — 存量判挂树回填器 (T-023 B/P 轴解锁前置腿).

AC 证明 (tmp 合成池):
  a) 命中子问题 token 的 valid 行被挂到正确维度 EEI (政策监管→E 槽);
  b) 反证词表命中 → against 槽 + stance=against;
  c) 权威信号 (credibility=official) → 权威口径槽;
  d) 只升不逆: tree_node 非空的行原样保留 (含 stance 不改);
  e) 非 valid 行不挂; 关键词不命中行诚实留空;
  f) 幂等: 第二次跑 attached=0; 备份文件只建一次;
  g) 行数守恒 + 行序保持 + 既有字段不丢。

跑法: py -m pytest reforge_factory/tests/test_tree_backfill.py -q
"""
import json
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from tree_backfill import backfill   # noqa: E402


def _tree() -> dict:
    return {"campaign": "CAMP", "topic": "工程总承包招投标合规",
            "region": "全国", "subquestions": [
                {"id": "Q1", "dim": "政策监管",
                 "text": "工程总承包 主管部门与监管框架",
                 "eeis": [
                     {"id": "Q1-E1", "need": "正面证据: 监管框架 数据",
                      "stance": "support", "status": "zero"},
                     {"id": "Q1-E2", "need": "反面证据: 处罚 案例",
                      "stance": "against", "status": "zero"},
                     {"id": "Q1-E3", "need": "权威口径: 官方统计原文",
                      "stance": "support", "status": "zero"}]},
                {"id": "Q2", "dim": "财务经营",
                 "text": "头部企业营收毛利率趋势",
                 "eeis": [
                     {"id": "Q2-E1", "need": "正面证据: 营收 数据",
                      "stance": "support", "status": "zero"}]},
                {"id": "Q3", "dim": "风险事件",
                 "text": "重大质量安全事故与行政处罚",
                 "eeis": [
                     {"id": "Q3-E1", "need": "正面证据: 事故 数据",
                      "stance": "support", "status": "zero"},
                     {"id": "Q3-E2", "need": "反面证据: 处罚 案例",
                      "stance": "against", "status": "zero"}]}]}


def _row(i: int, head: str, judge: str = "valid", tree: str = "",
         cred: str = "media", engine: str = "test") -> dict:
    return {"ts": "2026-10-15T10:00:00", "engine": engine,
            "source_path": f"E:/tmp/f{i}.txt", "url_norm": "", "chars": 500,
            "credibility": cred, "dedup_key": f"k{i}", "judge": judge,
            "judge_reason": "", "judge_engine": "", "tree_node": tree,
            "stance": "support", "budget_band": "", "text_head": head}


def _mk(base: Path, rows: list[dict]) -> Path:
    d = base / "CAMP"
    d.mkdir(parents=True)
    (d / "question_tree.json").write_text(
        json.dumps(_tree(), ensure_ascii=False), encoding="utf-8")
    (d / "manifest.jsonl").write_text(
        "".join(json.dumps(r, ensure_ascii=False) + "\n" for r in rows),
        encoding="utf-8")
    return d


def test_backfill_slots_and_discipline(tmp_path):
    rows = [
        _row(1, "工程总承包 招投标监管框架 政策文件全文"),          # → Q1 正面
        _row(2, "某公司围标串标被行政处罚 通报"),                     # → Q3 反面
        _row(3, "官方统计公报 政策法规原文", cred="official"),       # → Q1 权威
        _row(4, "头部企业营收 毛利率 现金流分析"),                   # → Q2 正面
        _row(5, "完全无关的美食菜谱介绍"),                           # 留空
        _row(6, "工程总承包 监管政策", judge="pending"),            # 非 valid
        _row(7, "工程总承包 主管监管框架", tree="Q9-E9"),            # 只升不逆
    ]
    d = _mk(tmp_path, rows)
    rep = backfill("CAMP", dry=False, pool_root=tmp_path)

    assert rep["attached"] == 4
    assert rep["kept_existing"] == 1
    assert rep["skip_not_valid"] == 1
    assert rep["below_min_score"] == 1

    got = [json.loads(x) for x in
           (d / "manifest.jsonl").read_text(encoding="utf-8").splitlines()]
    assert len(got) == 7                                   # 行数守恒+序保持
    assert got[0]["tree_node"] == "Q1-E1" and got[0]["stance"] == "support"
    assert got[1]["tree_node"] == "Q3-E2" and got[1]["stance"] == "against"
    assert got[2]["tree_node"] == "Q1-E3"
    assert got[3]["tree_node"] == "Q2-E1"
    assert got[4]["tree_node"] == ""                        # 诚实留空
    assert got[5]["tree_node"] == ""                        # pending 不挂
    assert got[6]["tree_node"] == "Q9-E9"                   # 既有不覆写
    assert got[0]["chars"] == 500 and got[0]["engine"] == "test"  # 字段不丢

    bak = d / "manifest.pre-tree-backfill.bak.jsonl"
    assert bak.is_file()
    assert len(bak.read_text(encoding="utf-8").splitlines()) == 7

    rep2 = backfill("CAMP", dry=False, pool_root=tmp_path)  # 幂等
    assert rep2["attached"] == 0 and rep2["kept_existing"] == 5
    assert "backup" not in rep2          # 零新挂=零写入, 不动备份


def test_backfill_dry_writes_nothing(tmp_path):
    d = _mk(tmp_path, [_row(1, "工程总承包 监管框架 政策")])
    rep = backfill("CAMP", dry=True, pool_root=tmp_path)
    assert rep["dry"] and rep["attached"] == 1
    got = json.loads((d / "manifest.jsonl").read_text(encoding="utf-8"))
    assert got["tree_node"] == ""                           # dry 不落盘
    assert not (d / "manifest.pre-tree-backfill.bak.jsonl").exists()
