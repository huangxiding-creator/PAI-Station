# -*- coding: utf-8 -*-
"""appendix_builder 单测 — T-014 / REQ-026 / KB-PROCESS-APPENDIX-SPEC.

覆盖: ①四件全落 appendix/ ②PRISMA 漏斗计数对拍 (识别=manifest 总行数 →
judge 三态 → 有效分层 T1/T2/T3 字符, 全部实算) ③pool_state 对账零差+漂移检测
④快照清单统计+抽检回放 (sha256 实测) ⑤ACH 无假设 degraded 路径+有假设全路径
⑥覆盖热图内嵌兜底渲染+heatmap_gen 防御式 import 成功路径 ⑦真实池只读
⑧CLI 退出码 ⑨ast 零网络根模块.
"""
from __future__ import annotations

import ast
import hashlib
import json
import sys
import types
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
import appendix_builder as AB                     # noqa: E402


# ---------- 夹具 ----------
def _row(node: str, *, judge: str = "valid", stance: str = "support",
         src: str = "", url: str = "", chars: int = 100, grade: str = "B",
         dedup: str = "", engine: str = "rss:t", **extra) -> dict:
    d = {"dedup_key": dedup or f"dk-{node}-{src or url}", "engine": engine,
         "url_norm": url, "source_path": src or f"E:/tmp/{node}.md",
         "chars": chars, "judge": judge, "tree_node": node,
         "stance": stance, "text_head": f"{node} 正文头部", "grade": grade,
         "ts": "2026-10-20T10:00:00", "judge_reason": "r", "judge_engine": "he"}
    d.update(extra)
    return d


def _write_manifest(camp: Path, rows: list[dict]) -> None:
    (camp / "manifest.jsonl").write_text(
        "\n".join(json.dumps(r, ensure_ascii=False) for r in rows) + "\n",
        encoding="utf-8")


def _snapshot_row(camp: Path, node: str, text: str, **kw) -> dict:
    """带在盘快照体的 valid 行 (内容模式, 与 ammo_pool 口径一致)."""
    digest = hashlib.sha256(text.encode("utf-8")).hexdigest()
    rel = f"snapshots/{digest[:16]}/content.txt"
    fp = camp / rel
    fp.parent.mkdir(parents=True, exist_ok=True)
    fp.write_text(text, encoding="utf-8")
    (camp / "snapshots" / digest[:16] / "meta.json").write_text(
        json.dumps({"mode": "content", "sha256": digest}, ensure_ascii=False),
        encoding="utf-8")
    return _row(node, **kw, snapshot_hash=digest,
                snapshot_ts="2026-10-20T10:00:01", snapshot_url=rel,
                snapshot_mode="content")


def _build_pool(tmp_path: Path, *, pool_state: dict | None = None,
                with_hypotheses: bool = False,
                with_tree: bool = True) -> Path:
    """合成战役池: 4 valid (T1/T2/T3/T0 各一) + 2 rejected + 1 pending."""
    camp = tmp_path / "ammo" / "T-CAMP"
    camp.mkdir(parents=True)
    snap = _snapshot_row(camp, "EEI-2", "快照正文 ABC 反证内容",
                         stance="against", src="E:/tmp/招投标法.md",
                         url="https://h2.cn/x", chars=120)
    rows = [
        _row("EEI-1", src="E:/tmp/EPC专项分析.md",      # 课题词 → T3
             url="https://h1.cn/a", chars=110),
        snap,                                            # T1 词表命中
        _row("EEI-1", src="E:/tmp/总承包指南.md",         # T2 词表命中
             url="https://h1.cn/b", chars=130),
        _row("", src="E:/tmp/泛命中散文.md", url="", chars=90),   # T0 未挂树
        _row("EEI-9", judge="rejected", src="E:/tmp/废.md"),
        _row("EEI-9", judge="rejected", src="E:/tmp/废2.md"),
        _row("EEI-9", judge="pending", src="E:/tmp/待.md"),
        _row("EEI-2", judge="pending", src="E:/tmp/待2.md",
             snapshot_pending=True),
    ]
    _write_manifest(camp, rows)
    st = pool_state if pool_state is not None else {
        "campaign": "T-CAMP", "kws": ["专项"], "total_chars": 450,
        "items": 4, "pending_items": 2, "rejected_items": 2,
        "pending_chars": 0, "rejected_chars": 200}
    (camp / "pool_state.json").write_text(
        json.dumps(st, ensure_ascii=False), encoding="utf-8")
    (camp / "tiers.json").write_text(
        json.dumps({"T1": ["招投标"], "T2": ["总承包"]}, ensure_ascii=False),
        encoding="utf-8")
    if with_tree:
        tree: dict = {"topic": "测试课题", "subquestions": [
            {"id": "Q1", "eeis": [
                {"id": "EEI-1", "stance": "support"},
                {"id": "EEI-2", "stance": "against"}]}]}
        if with_hypotheses:
            tree["hypotheses"] = [
                {"id": "H1", "text": "市场扩张", "prior": 0.4},
                {"id": "H2", "text": "市场恶化", "prior": 0.3},
                {"id": "H3", "text": "区域分化", "prior": 0.3}]
        (camp / "question_tree.json").write_text(
            json.dumps(tree, ensure_ascii=False), encoding="utf-8")
    led = [
        {"ts": "t1", "axis": "T", "sensor": "entity_timeline", "score": 0.5,
         "green": False, "waived": False, "missing": False, "note": ""},
        {"ts": "t1", "axis": "B", "sensor": "coverage_facets", "score": 0.8,
         "green": True, "waived": False, "missing": False, "note": ""},
        {"ts": "t1", "axis": "D", "sensor": "dimension_matrix", "score": 0.7,
         "green": False, "waived": True, "missing": False,
         "note": "人工豁免样例"},
        {"ts": "t1", "axis": "P", "sensor": "depth_ladder", "score": 0.0,
         "green": False, "waived": False, "missing": True, "note": "缺轴样例"},
        {"ts": "t1", "axis": "C", "sensor": "channel_matrix", "score": 0.6,
         "green": False, "waived": False, "missing": False, "note": ""},
        {"ts": "t1", "axis": "CIdx", "campaign": "T-CAMP",
         "cidx": 0.5234, "all_green": False, "missing_axes": ["P"],
         "waived_axes": ["D"]}]
    (camp / "completeness_ledger.jsonl").write_text(
        "\n".join(json.dumps(r, ensure_ascii=False) for r in led) + "\n",
        encoding="utf-8")
    return camp


# ---------- ① 四件全落 ----------
def test_four_files_land(tmp_path):
    camp = _build_pool(tmp_path)
    draft = tmp_path / "draft"
    summary = AB.build("T-CAMP", draft, pool_root=camp.parent)
    app = draft / "appendix"
    for name in ("prisma_funnel.md", "ach_matrix.md",
                 "coverage_heatmap.md", "evidence_stamps.json"):
        assert (app / name).is_file(), f"缺附录件 {name}"
    assert summary["campaign"] == "T-CAMP"
    assert summary["files"] == 4


# ---------- ② 漏斗计数对拍 ----------
def test_funnel_counts_match_manifest(tmp_path):
    camp = _build_pool(tmp_path)
    draft = tmp_path / "draft"
    AB.build("T-CAMP", draft, pool_root=camp.parent)
    md = (draft / "appendix" / "prisma_funnel.md").read_text(encoding="utf-8")
    # 识别 = manifest 总行数
    assert "识别 (identified)" in md and "| 8 |" in md
    # judge 三态: valid 4 / rejected 2 / pending 2
    assert "judge=valid" in md and "| 4 |" in md
    assert "judge=rejected" in md and "| 2 |" in md
    assert "judge=pending" in md and "| 2 |" in md
    # 有效分层: T1=招投标法(快照行) 120 字 / T2=总承包指南 130 / T3=课题词 110
    assert "T1" in md and "| 1 | 120 |" in md
    assert "T2" in md and "| 1 | 130 |" in md
    assert "T3" in md and "| 1 | 110 |" in md
    assert "T0" in md and "| 1 | 90 |" in md       # 泛命中单列不计入
    # 每步一句理由模板行 (PRISMA 2020 口径)
    for step in ("识别", "入池判定", "有效分层"):
        assert step in md


# ---------- ③ 对账零差 + 漂移检测 ----------
def test_reconcile_zero_diff_and_detects_drift(tmp_path):
    camp = _build_pool(tmp_path)
    draft = tmp_path / "draft"
    s1 = AB.build("T-CAMP", draft, pool_root=camp.parent)
    assert s1["reconcile"]["ok"] is True
    assert s1["reconcile"]["diffs"] == []
    # 篡改 pool_state → 有差必须被抓到
    bad = _build_pool(tmp_path / "bad", pool_state={
        "campaign": "T-CAMP", "kws": [], "total_chars": 450,
        "items": 5, "pending_items": 2, "rejected_items": 2})
    s2 = AB.build("T-CAMP", tmp_path / "bad" / "draft",
                  pool_root=bad.parent)
    assert s2["reconcile"]["ok"] is False
    assert any(d["field"] == "items" for d in s2["reconcile"]["diffs"])


# ---------- ④ 快照清单统计 + 抽检回放 ----------
def test_evidence_stamps_stats_and_replay(tmp_path):
    camp = _build_pool(tmp_path)
    draft = tmp_path / "draft"
    s = AB.build("T-CAMP", draft, pool_root=camp.parent, sample=5)
    st = json.loads((draft / "appendix" / "evidence_stamps.json")
                    .read_text(encoding="utf-8"))
    assert st["stats"]["valid_total"] == 4
    assert st["stats"]["with_snapshot"] == 1
    assert st["stats"]["coverage_pct"] == 25.0
    assert len(st["stamps"]) == 1
    stamp = st["stamps"][0]
    assert stamp["tree_node"] == "EEI-2"
    assert stamp["snapshot_hash"] and stamp["snapshot_ts"]
    # 抽检回放全过 (sha256 与快照体实测一致)
    assert s["sample_replay"]["sampled"] == 1
    assert s["sample_replay"]["replayed"] == 1
    assert s["sample_replay"]["broken"] == 0
    # 快照体被删 → 回放必须报 broken
    for f in (camp / "snapshots").rglob("content.txt"):
        f.unlink()
    s2 = AB.build("T-CAMP", tmp_path / "draft2", pool_root=camp.parent,
                  sample=5)
    assert s2["sample_replay"]["broken"] == 1
    md = (tmp_path / "draft2" / "appendix" / "evidence_stamps.json")
    assert md.is_file()


# ---------- ⑤ ACH: 无假设 degraded / 有假设全路径 ----------
def test_ach_degraded_without_hypotheses(tmp_path):
    camp = _build_pool(tmp_path)                  # 树无 hypotheses
    draft = tmp_path / "draft"
    AB.build("T-CAMP", draft, pool_root=camp.parent)
    md = (draft / "appendix" / "ach_matrix.md").read_text(encoding="utf-8")
    assert "degraded" in md                       # 雏形必须显式降级标记
    assert "EEI-2" in md                          # against 证据按 EEI 归组
    assert "against" in md


def test_ach_full_with_hypotheses(tmp_path):
    camp = _build_pool(tmp_path, with_hypotheses=True)
    draft = tmp_path / "draft"
    AB.build("T-CAMP", draft, pool_root=camp.parent)
    md = (draft / "appendix" / "ach_matrix.md").read_text(encoding="utf-8")
    assert "degraded" not in md
    for h in ("H1", "H2", "H3"):                  # 证据×假设矩阵列齐
        assert h in md
    assert "排除" in md                            # 排除法排序在档


def test_ach_arena_product_preferred(tmp_path):
    """战役在档 ach_arena 产物优先转录 (不重算)."""
    camp = _build_pool(tmp_path)
    (camp / "ach_arena.json").write_text(
        json.dumps({"ranked": [{"id": "H2", "score": -3.2}]},
                   ensure_ascii=False), encoding="utf-8")
    draft = tmp_path / "draft"
    AB.build("T-CAMP", draft, pool_root=camp.parent)
    md = (draft / "appendix" / "ach_matrix.md").read_text(encoding="utf-8")
    assert "ach_arena.json" in md and "-3.2" in md


# ---------- ⑥ 热图: 内嵌兜底 + heatmap_gen 成功路径 ----------
def test_heatmap_fallback_internal(tmp_path, monkeypatch):
    """强制兜底 (render 抛异常) — 与 T-009 是否落盘无关的确定性路径."""
    camp = _build_pool(tmp_path)
    boom = types.ModuleType("completeness.heatmap_gen")

    def _raise(**kw):
        raise RuntimeError("heatmap_gen 不可用样例")
    boom.render = _raise
    monkeypatch.setitem(sys.modules, "completeness.heatmap_gen", boom)
    draft = tmp_path / "draft"
    AB.build("T-CAMP", draft, pool_root=camp.parent)
    md = (draft / "appendix" / "coverage_heatmap.md").read_text(encoding="utf-8")
    for axis in ("T", "B", "D", "P", "C"):        # 五轴行齐
        assert f"| {axis} " in md
    assert "CIdx" in md and "0.5234" in md        # 完备度指数
    assert "豁免" in md and "缺轴" in md          # 豁免/降级清单
    assert "entity_timeline" in md


def test_heatmap_uses_heatmap_gen_when_present(tmp_path, monkeypatch):
    """T-009 heatmap_gen 在档 → 防御式 import 成功则调用其 render."""
    camp = _build_pool(tmp_path)
    stub = types.ModuleType("completeness.heatmap_gen")
    stub.render = lambda campaign, pool_root, **kw: (
        f"STUB-HEATMAP[{campaign}@{pool_root}]")
    monkeypatch.setitem(sys.modules, "completeness.heatmap_gen", stub)
    draft = tmp_path / "draft"
    AB.build("T-CAMP", draft, pool_root=camp.parent)
    md = (draft / "appendix" / "coverage_heatmap.md").read_text(encoding="utf-8")
    assert "STUB-HEATMAP[T-CAMP" in md


def test_heatmap_gen_payload_shape_write_false(tmp_path, monkeypatch):
    """T-009 实测形态: render(write=False)→payload dict + render_md 取文;
    且必须 write=False (不触发 heatmap_gen 自己的 work/ 落盘副作用)."""
    camp = _build_pool(tmp_path)
    stub = types.ModuleType("completeness.heatmap_gen")
    seen: dict = {}

    def _render(campaign, out_dir=None, *, pool_root=None, write=True):
        seen["write"] = write
        return {"campaign": campaign, "cidx": 0.9}
    stub.render = _render
    stub.render_md = lambda p: f"# 真热图 {p['campaign']} CIdx={p['cidx']}"
    monkeypatch.setitem(sys.modules, "completeness.heatmap_gen", stub)
    draft = tmp_path / "draft"
    s = AB.build("T-CAMP", draft, pool_root=camp.parent)
    md = (draft / "appendix" / "coverage_heatmap.md").read_text(encoding="utf-8")
    assert s["heatmap_source"] == "heatmap_gen"
    assert "真热图 T-CAMP CIdx=0.9" in md
    assert seen["write"] is False


def test_heatmap_gen_never_called_with_write_true(tmp_path, monkeypatch):
    """副作用回归锁: 任何 write≠False 的 render 调用直接炸 → 必须走兜底,
    杜绝 heatmap_gen 默认写盘把测试产物泄进 V3 work/ (2026-10-15 事故位)."""
    camp = _build_pool(tmp_path)
    stub = types.ModuleType("completeness.heatmap_gen")

    def _strict(campaign, out_dir=None, *, pool_root=None, write=True):
        if write is not False:
            raise AssertionError("render 被以 write=True 调用 (副作用泄漏)")
        return {"campaign": campaign}
    stub.render = _strict

    def _md_boom(p):
        raise RuntimeError("render_md 不可用样例")
    stub.render_md = _md_boom
    monkeypatch.setitem(sys.modules, "completeness.heatmap_gen", stub)
    s = AB.build("T-CAMP", tmp_path / "draft", pool_root=camp.parent)
    assert s["heatmap_source"] == "internal"       # 全形态失败 → 内嵌兜底
    assert (tmp_path / "draft" / "appendix"
            / "coverage_heatmap.md").is_file()


# ---------- ⑦ 真实池只读 ----------
def test_pool_readonly(tmp_path):
    camp = _build_pool(tmp_path)
    before = {f.name: f.read_bytes() for f in camp.iterdir() if f.is_file()}
    AB.build("T-CAMP", tmp_path / "draft", pool_root=camp.parent)
    after = {f.name: f.read_bytes() for f in camp.iterdir() if f.is_file()}
    assert before == after                        # 池内原文件字节零改动


# ---------- ⑧ CLI ----------
def test_cli_exit_codes(tmp_path, capsys):
    camp = _build_pool(tmp_path)
    pool_root = camp.parent
    rc = AB.main(["--campaign", "T-CAMP", "--draft-dir",
                  str(tmp_path / "d1"), "--pool-root", str(pool_root),
                  "--reconcile", "--sample", "3"])
    assert rc == 0                                # 对账零差 + 回放全过
    out = capsys.readouterr().out
    assert "零差" in out
    bad = _build_pool(tmp_path / "bad", pool_state={
        "campaign": "T-CAMP", "kws": [], "total_chars": 0,
        "items": 9, "pending_items": 0, "rejected_items": 0})
    rc2 = AB.main(["--campaign", "T-CAMP", "--draft-dir",
                   str(tmp_path / "d2"), "--pool-root", str(bad.parent),
                   "--reconcile"])
    assert rc2 == 2                               # 有差即非零退出


# ---------- ⑨ ast 零网络根模块 ----------
def test_ast_no_network():
    src = (Path(AB.__file__).parent / "appendix_builder.py") \
        .read_text(encoding="utf-8")
    tree = ast.parse(src)
    bad = {"requests", "httpx", "urllib", "socket", "aiohttp"}
    for n in ast.walk(tree):
        if isinstance(n, ast.Import):
            assert not (set(a.name.split(".")[0] for a in n.names) & bad)
        if isinstance(n, ast.ImportFrom) and n.module:
            assert n.module.split(".")[0] not in bad
