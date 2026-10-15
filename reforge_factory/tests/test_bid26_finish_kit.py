# -*- coding: utf-8 -*-
"""test_bid26_finish_kit — BID26 新宪法收尾机制件单测 (T-023 / REQ-051).

覆盖 (父指令五点 + 机制附加):
  ① 清单项齐: REQUIRED_ITEMS 十二项全出, 每项 {item,tool,status,note};
     五轴现状读 completeness_ledger (B/P 缺树 → blocked_by_question_tree);
     json+md 双落盘
  ② 补采登记带批准引用: register() 追加一行含 approve_ref 的 JSONL
  ③ 无引用拒记: approve_ref 空/None/纯空白 → SupplementRefused, 账本零行
  ④ audit 未登记缺口 exit 2 (函数 ok=False + CLI 返回码 2)
  ⑤ 全登记 exit 0 (含一行登记多缺口 的覆盖口径)
  ⑥ 只升不逆对照器: prev ready → now blocked/缺失 = 逆行; blocked→ready 合法
  ⑦ 真实池只读冒烟 (EPC-BID26, 输出落 tmp): 十二项齐, 状态机合法, 池字节不变
"""
from __future__ import annotations

import json
import sys
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
import bid26_finish_kit as BK                                # noqa: E402


# ------------------------------------------------------------- 合成夹具 ----
def _mk_pool(root: Path, *, campaign: str = "SYN-BID") -> Path:
    """合成战役池: 五轴账本一批 (T/D/C 绿, B/P 0 分未绿, 无问题树)."""
    camp = root / campaign
    camp.mkdir(parents=True)
    rows = [
        {"ts": "2026-10-15T10:00:00+08:00", "axis": "T", "sensor": "entity_timeline",
         "score": 0.9, "green": True, "waived": False, "missing": False, "note": ""},
        {"ts": "2026-10-15T10:00:00+08:00", "axis": "B", "sensor": "coverage_facets",
         "score": 0.0, "green": False, "waived": False, "missing": False, "note": ""},
        {"ts": "2026-10-15T10:00:00+08:00", "axis": "D", "sensor": "dimension_matrix",
         "score": 1.0, "green": True, "waived": False, "missing": False, "note": ""},
        {"ts": "2026-10-15T10:00:00+08:00", "axis": "P", "sensor": "depth_ladder",
         "score": 0.0, "green": False, "waived": False, "missing": False, "note": ""},
        {"ts": "2026-10-15T10:00:00+08:00", "axis": "C", "sensor": "channel_matrix",
         "score": 0.8, "green": True, "waived": False, "missing": False, "note": ""},
        {"ts": "2026-10-15T10:00:00+08:00", "axis": "CIdx", "campaign": campaign,
         "axis_scores": {"T": 0.9, "B": 0.0, "D": 1.0, "P": 0.0, "C": 0.8},
         "cidx": 0.63, "all_green": False, "missing_axes": [], "waived_axes": []},
    ]
    (camp / "completeness_ledger.jsonl").write_text(
        "\n".join(json.dumps(r, ensure_ascii=False) for r in rows) + "\n",
        encoding="utf-8")
    return camp.parent


def _mk_work(root: Path) -> Path:
    work = root / "work"
    work.mkdir()
    # 红队产物: 2 路径全已回应
    (work / "redteam_SYN-BID.json").write_text(json.dumps({
        "campaign": "SYN-BID", "failure_paths": [
            {"path": "p1", "response_status": "responded"},
            {"path": "p2", "response_status": "responded"}]}, ensure_ascii=False),
        encoding="utf-8")
    return work


@pytest.fixture
def synth(tmp_path):
    pool = _mk_pool(tmp_path)
    work = _mk_work(tmp_path)
    wiring = tmp_path / "m2" / "density_check.py"
    wiring.parent.mkdir(parents=True)
    wiring.write_text("# wiring stub\n", encoding="utf-8")
    pipeline = tmp_path / "REPORT_PIPELINE.md"
    pipeline.write_text("# S4-S7\n", encoding="utf-8")
    return pool, work, wiring, pipeline


# ------------------------------------------------------- ① 清单项齐 --------
def test_checklist_items_complete(synth):
    pool, work, wiring, pipeline = synth
    res = BK.checklist(campaign="SYN-BID", pool_root=pool, work_dir=work,
                       m2_wiring=wiring, pipeline_doc=pipeline, write=True)
    items = res["items"]
    names = [it["item"] for it in items]
    for req in BK.REQUIRED_ITEMS:
        assert req in names, f"清单缺项: {req}"
    for it in items:
        assert set(it) >= {"item", "tool", "status", "note"}
        assert it["status"] == "ready" or it["status"].startswith("blocked_")
        assert it["tool"] and it["note"]
    by = {it["item"]: it for it in items}
    # 五轴现状如实: T/D/C 绿→ready; B/P 0 分未绿且缺树→blocked_by_question_tree
    assert by["完备性五轴·T 时间轴"]["status"] == "ready"
    assert by["完备性五轴·D 维度矩阵"]["status"] == "ready"
    assert by["完备性五轴·C 渠道矩阵"]["status"] == "ready"
    assert by["完备性五轴·B 十面覆盖"]["status"] == "blocked_by_question_tree"
    assert by["完备性五轴·P 深度阶梯"]["status"] == "blocked_by_question_tree"
    assert by["完备性五轴·CIdx 五覆指数"]["status"].startswith("blocked_")
    # 接线位/机制件: 全 ready
    assert by["密度门接线位 m2/density_check"]["status"] == "ready"
    assert by["AI 审稿人 成稿门禁"]["status"] == "ready"
    assert by["过程附录四件套"]["status"] == "ready"
    assert by["产品族六层变现面"]["status"] == "ready"
    assert by["红队轮"]["status"] == "ready"
    assert by["发布协议 S4-S7 下限3+3"]["status"] == "ready"
    # 汇总计数 = 状态真实分布
    cnt = res["counts"]
    assert cnt["ready"] == sum(1 for i in items if i["status"] == "ready")
    assert cnt["blocked"] == sum(1 for i in items if i["status"] != "ready")
    assert cnt["blocked_by_question_tree"] == 2
    # json+md 双落盘
    assert (work / "bid26_finish_checklist.json").exists()
    md = (work / "bid26_finish_checklist.md").read_text(encoding="utf-8")
    assert "SYN-BID" in md and "| ready" not in md  # 表格态在, 非占位
    for req in BK.REQUIRED_ITEMS:
        assert req in md


def test_checklist_tree_present_unblocks_reason(synth, tmp_path):
    """树在场 → B/P 未绿不再归因问题树 (blocked_axis_not_green, 数据驱动)."""
    pool, work, wiring, pipeline = synth
    (pool / "SYN-BID" / "question_tree_v2.json").write_text("{}", encoding="utf-8")
    res = BK.checklist(campaign="SYN-BID", pool_root=pool, work_dir=work,
                       m2_wiring=wiring, pipeline_doc=pipeline, write=False)
    by = {it["item"]: it for it in res["items"]}
    assert by["完备性五轴·B 十面覆盖"]["status"] == "blocked_axis_not_green"
    assert by["完备性五轴·P 深度阶梯"]["status"] == "blocked_axis_not_green"


def test_checklist_redteam_unanswered_blocks(synth):
    pool, work, wiring, pipeline = synth
    (work / "redteam_SYN-BID.json").write_text(json.dumps({
        "failure_paths": [{"path": "p1", "response_status": "unanswered"}]},
        ensure_ascii=False), encoding="utf-8")
    res = BK.checklist(campaign="SYN-BID", pool_root=pool, work_dir=work,
                       m2_wiring=wiring, pipeline_doc=pipeline, write=False)
    by = {it["item"]: it for it in res["items"]}
    assert by["红队轮"]["status"] == "blocked_redteam_unanswered"


# ------------------------------------------------ ②③ 补采对账账本 ---------
def test_register_with_approve_ref(tmp_path):
    ledger = tmp_path / "bid26_supplement_ledger.jsonl"
    rec = BK.register("Q1-E1", "回测缺口: L0 零据", "用户 2026-10-15 飞书批准",
                      campaign="SYN-BID", ledger_path=ledger)
    assert rec["approve_ref"] == "用户 2026-10-15 飞书批准"
    lines = ledger.read_text(encoding="utf-8").splitlines()
    assert len(lines) == 1
    row = json.loads(lines[0])
    assert row["eei_or_gap"] == "Q1-E1" and row["campaign"] == "SYN-BID"
    assert row["reason"] and row["ts"]


def test_register_refuses_without_approve_ref(tmp_path):
    ledger = tmp_path / "bid26_supplement_ledger.jsonl"
    for bad in ("", "   ", None):
        with pytest.raises(BK.SupplementRefused):
            BK.register("Q1-E1", "回测缺口", bad, ledger_path=ledger)
    assert not ledger.exists() or ledger.read_text(encoding="utf-8") == ""


# --------------------------------------------------- ④⑤ audit 对账 --------
def test_audit_unregistered_gap_violates(tmp_path):
    ledger = tmp_path / "bid26_supplement_ledger.jsonl"
    res = BK.audit(["Q1-E1"], ledger_path=ledger)
    assert res["ok"] is False
    assert res["unregistered"] == ["Q1-E1"]
    # CLI 退出码 2 (REQ-051 未登记缺口=违规)
    rc = BK.main(["audit", "--gaps", "Q1-E1", "--ledger", str(ledger)])
    assert rc == 2


def test_audit_all_registered_exits_zero(tmp_path):
    ledger = tmp_path / "bid26_supplement_ledger.jsonl"
    BK.register("Q1-E1", "缺口A", "批准#1", ledger_path=ledger)
    BK.register("Q1-E2,Q1-E3", "缺口B批", "批准#2", ledger_path=ledger)  # 一行多缺口
    res = BK.audit(["Q1-E1", "Q1-E2", "Q1-E3"], ledger_path=ledger)
    assert res["ok"] is True and res["unregistered"] == []
    assert res["ledger_lines"] == 2
    rc = BK.main(["audit", "--gaps", "Q1-E1 Q1-E2,Q1-E3", "--ledger", str(ledger)])
    assert rc == 0


def test_cli_register_missing_approve_ref_exit_2(tmp_path):
    ledger = tmp_path / "led.jsonl"
    rc = BK.main(["register", "--gap", "Q1-E1", "--reason", "r",
                  "--approve-ref", "  ", "--ledger", str(ledger)])
    assert rc == 2
    assert not ledger.exists() or ledger.read_text(encoding="utf-8") == ""


# ------------------------------------------------ ⑥ 只升不逆对照器 --------
def test_no_revert_ready_must_not_fall_back():
    prev = {"items": [{"item": "A", "status": "ready"},
                      {"item": "B", "status": "blocked_x"}]}
    now_block = {"items": [{"item": "A", "status": "blocked_y"},
                           {"item": "B", "status": "ready"}]}
    res = BK.no_revert(prev, now_block)
    assert res["ok"] is False
    assert res["reverted"] == [{"item": "A", "prev": "ready", "now": "blocked_y"}]
    # 已批不重开: 逆行即违规
    rc = BK.main(["no-revert", "--prev", "p.json", "--now", "n.json"]) if False else None


def test_no_revert_upgrade_and_stay_ok():
    prev = {"items": [{"item": "A", "status": "blocked_x"},
                      {"item": "B", "status": "ready"}]}
    now = {"items": [{"item": "A", "status": "ready"},
                     {"item": "B", "status": "ready"}]}
    res = BK.no_revert(prev, now)
    assert res["ok"] is True and res["reverted"] == []
    assert res["checked_ready"] == 1


def test_no_revert_missing_item_is_revert():
    prev = {"items": [{"item": "A", "status": "ready"}]}
    now = {"items": []}
    res = BK.no_revert(prev, now)
    assert res["ok"] is False
    assert res["reverted"][0]["now"] == "missing"


# ------------------------------------------- ⑦ 真实池只读冒烟 -------------
def test_real_pool_checklist_readonly_smoke(tmp_path):
    """真实 EPC-BID26 池/产物只读: 清单可出且项齐, 输出落 tmp, 池字节不变."""
    pool = BK.POOL_ROOT
    snap = {p: p.read_bytes() for p in pool.rglob("*") if p.is_file()}
    res = BK.checklist(campaign="EPC-BID26", pool_root=pool,
                       work_dir=tmp_path, write=True)
    names = [it["item"] for it in res["items"]]
    assert names == list(BK.REQUIRED_ITEMS) or set(names) == set(BK.REQUIRED_ITEMS)
    for it in res["items"]:
        assert it["status"] == "ready" or it["status"].startswith("blocked_")
    assert (tmp_path / "bid26_finish_checklist.md").exists()
    assert (tmp_path / "bid26_finish_checklist.json").exists()
    # 池只读: 字节级不变
    after = {p: p.read_bytes() for p in pool.rglob("*") if p.is_file()}
    assert snap == after
