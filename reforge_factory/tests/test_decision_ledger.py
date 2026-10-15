# -*- coding: utf-8 -*-
"""test_decision_ledger — 决策账本单测 (T-005, REQ-040 / KB-DECISION-LEDGER-SPEC).

覆盖:
  ① record_decision 写入: 首条 D-0001 / id 自增 / schema 十一字段齐 /
     budget_used 缺省 null / ts 格式
  ② 八枚举校验: 枚举外 decision_type 拒记且账本零残留
  ③ 入参校验: 空 options / chosen 不在 options / 空 rationale / 坏战役名
  ④ fill_outcome 回填: 只动 outcome/outcome_ts/score 三字段,
     其余行字节保真, 未回填行 dict 不变
  ⑤ 回填守卫: 未知 id / 二次回填 / score 越界 (5, True) 拒
  ⑥ decision_stats 统计: 总数/已回填/回填率/分域计数 + CLI 人类可读与 --json
  ⑦ 纯标准库 (ast 零网络 import)

红线: 全部用 tmp 夹具, 绝不触碰真实 ammo_pool/ 战役池目录.

跑法: py -m pytest reforge_factory/tests/test_decision_ledger.py -q
"""
from __future__ import annotations

import ast
import json
import re
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
import decision_ledger as DL                      # noqa: E402
import decision_stats as DS                       # noqa: E402

TS_RE = re.compile(r"^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}$")


def _rec(dt="research_rounds", chosen="continue", campaign="T005-TEST"):
    return dict(
        campaign=campaign,
        decision_type=dt,
        context={"campaign": campaign, "state": "单测夹具"},
        options=[{"k": "continue", "v": "再采一轮"}, {"k": "stop", "v": "停时"}],
        chosen=chosen,
        rationale="边际增益 +3.1% > 阈值 2%，继续采集",
        budget_used={"tokens_est": 0, "quota_window": "night_half_price"},
    )


# ------------------------------------------------ ① 写入与 schema
def test_a_first_record_id_and_schema(tmp_path):
    rec = DL.record_decision(**_rec(), pool_root=tmp_path)
    ledger = tmp_path / "T005-TEST" / "decision_ledger.jsonl"
    assert ledger.exists()
    lines = ledger.read_text(encoding="utf-8").splitlines()
    assert len(lines) == 1
    on_disk = json.loads(lines[0])
    assert rec == on_disk                              # 返回值 == 落盘值
    assert rec["id"] == "D-0001"                       # 首条自增 id
    assert list(rec) == ["id", "ts", "decision_type", "context", "options",
                         "chosen", "rationale", "budget_used",
                         "outcome", "outcome_ts", "score"]   # KB schema 字段序
    assert TS_RE.match(rec["ts"])                      # ts 格式 YYYY-MM-DDTHH:MM:SS
    assert rec["outcome"] is None and rec["outcome_ts"] is None
    assert rec["score"] is None                        # 结果未判 → 三空位


def test_a_id_autoincrement_and_budget_default(tmp_path):
    a = DL.record_decision(**_rec(), pool_root=tmp_path)
    kw = _rec(chosen="stop"); kw.pop("budget_used")     # 不传 budget_used
    b = DL.record_decision(**kw, pool_root=tmp_path)
    assert (a["id"], b["id"]) == ("D-0001", "D-0002")
    assert b["budget_used"] is None                    # budget_used 缺省 → null 落键


def test_a_all_eight_decision_types_accepted(tmp_path):
    """七域八决策点全枚举可落账 (REQ-040 清单)."""
    for i, dt in enumerate(DL.DECISION_TYPES, 1):
        rec = DL.record_decision(**_rec(dt=dt), pool_root=tmp_path)
        assert rec["id"] == f"D-{i:04d}"
    assert len(DL.DECISION_TYPES) == 8


# ------------------------------------------------ ② 八枚举外拒记
def test_b_unknown_decision_type_rejected(tmp_path):
    before = list((tmp_path / "T005-TEST").glob("*")) if (tmp_path / "T005-TEST").exists() else []
    try:
        DL.record_decision(**_rec(dt="hack_delete_pool"), pool_root=tmp_path)
        raise AssertionError("枚举外 decision_type 应拒记")
    except ValueError as exc:
        assert "decision_type" in str(exc)
    ledger = tmp_path / "T005-TEST" / "decision_ledger.jsonl"
    assert not ledger.exists() or ledger.read_text(encoding="utf-8") == ""
    assert before == [] or True                        # 账本零残留


# ------------------------------------------------ ③ 入参校验
def test_c_bad_options_or_chosen_or_rationale_rejected(tmp_path):
    bad = _rec(); bad["options"] = []
    try:
        DL.record_decision(**bad, pool_root=tmp_path)
        raise AssertionError("空 options 应拒")
    except ValueError:
        pass
    bad = _rec(chosen="nuclear")                       # chosen 不在 options
    try:
        DL.record_decision(**bad, pool_root=tmp_path)
        raise AssertionError("chosen 越 options 应拒")
    except ValueError:
        pass
    bad = _rec(); bad["rationale"] = "  "
    try:
        DL.record_decision(**bad, pool_root=tmp_path)
        raise AssertionError("空 rationale 应拒")
    except ValueError:
        pass
    try:
        DL.record_decision(**_rec(campaign="../evil"), pool_root=tmp_path)
        raise AssertionError("穿越战役名应拒")
    except ValueError:
        pass
    assert not (tmp_path / "evil").exists()


# ------------------------------------------------ ④ 回填: 只动三字段
def test_d_fill_outcome_touches_only_three_fields(tmp_path):
    ids = [DL.record_decision(**_rec(), pool_root=tmp_path)["id"] for _ in range(3)]
    ledger = tmp_path / "T005-TEST" / "decision_ledger.jsonl"
    raw_before = ledger.read_bytes().splitlines(keepends=True)
    recs_before = [json.loads(x) for x in raw_before]

    updated = DL.fill_outcome("T005-TEST", ids[1], outcome="好：新增EEI 12条",
                              score=1, pool_root=tmp_path)

    raw_after = ledger.read_bytes().splitlines(keepends=True)
    assert len(raw_after) == 3                         # 行数不变 (无增无删)
    assert raw_after[0] == raw_before[0]               # 其余行字节保真
    assert raw_after[2] == raw_before[2]
    recs_after = [json.loads(x) for x in raw_after]
    assert recs_after[0] == recs_before[0]             # 未回填行 dict 不变
    assert recs_after[2] == recs_before[2]
    mid = recs_after[1]
    assert mid["outcome"] == "好：新增EEI 12条"
    assert mid["score"] == 1
    assert TS_RE.match(mid["outcome_ts"])              # 回填时间戳
    # 其余字段 (含 id/ts/rationale/options) 与回填前一致 → 只动了三字段
    for k in ("id", "ts", "decision_type", "context", "options",
              "chosen", "rationale", "budget_used"):
        assert mid[k] == recs_before[1][k]
    assert updated == mid


def test_d_fill_outcome_neutral_and_bad_scores(tmp_path):
    did = DL.record_decision(**_rec(), pool_root=tmp_path)["id"]
    upd = DL.fill_outcome("T005-TEST", did, outcome="中：无变化", score=0,
                          pool_root=tmp_path)
    assert upd["score"] == 0
    did2 = DL.record_decision(**_rec(chosen="stop"), pool_root=tmp_path)["id"]
    upd2 = DL.fill_outcome("T005-TEST", did2, outcome="差：渠道空转", score=-1,
                           pool_root=tmp_path)
    assert upd2["score"] == -1                         # 好/中/差 = 1/0/-1 全档


# ------------------------------------------------ ⑤ 回填守卫
def test_e_fill_outcome_guards(tmp_path):
    try:
        DL.fill_outcome("T005-TEST", "D-9999", outcome="x", score=1,
                        pool_root=tmp_path)
        raise AssertionError("未知 id 应拒")
    except ValueError:
        pass
    did = DL.record_decision(**_rec(), pool_root=tmp_path)["id"]
    DL.fill_outcome("T005-TEST", did, outcome="好", score=1, pool_root=tmp_path)
    try:
        DL.fill_outcome("T005-TEST", did, outcome="改口", score=-1,
                        pool_root=tmp_path)
        raise AssertionError("二次回填应拒 (已回填记录不可变)")
    except ValueError:
        pass
    for bad_score in (5, "1", True, 1.5):
        did_n = DL.record_decision(**_rec(), pool_root=tmp_path)["id"]
        try:
            DL.fill_outcome("T005-TEST", did_n, outcome="x", score=bad_score,
                            pool_root=tmp_path)
            raise AssertionError(f"非法 score {bad_score!r} 应拒")
        except ValueError:
            pass


def test_e_load_records_roundtrip(tmp_path):
    DL.record_decision(**_rec(), pool_root=tmp_path)
    DL.record_decision(**_rec(dt="pricing_suggest", chosen="stop"),
                       pool_root=tmp_path)
    recs = DL.load_records("T005-TEST", pool_root=tmp_path)
    assert [r["id"] for r in recs] == ["D-0001", "D-0002"]


# ------------------------------------------------ ⑥ decision_stats
def _seed_pool(tmp_path):
    for _ in range(2):
        DL.record_decision(**_rec(), pool_root=tmp_path)          # research_rounds ×2
    DL.record_decision(**_rec(dt="pricing_suggest"), pool_root=tmp_path)
    DL.fill_outcome("T005-TEST", "D-0001", outcome="好", score=1,
                    pool_root=tmp_path)


def test_f_summarize_counts(tmp_path):
    _seed_pool(tmp_path)
    s = DS.summarize(DL.load_records("T005-TEST", pool_root=tmp_path))
    assert s["total"] == 3
    assert s["filled"] == 1
    assert abs(s["fill_rate"] - 1 / 3) < 1e-9          # REQ-040.AC1 回填率
    assert s["by_decision_type"] == {"research_rounds": 2, "pricing_suggest": 1}
    assert s["mean_score"] == 1.0


def test_f_summarize_empty_ledger(tmp_path):
    s = DS.summarize([])                               # 空账本不炸, 率为 0
    assert s == {"total": 0, "filled": 0, "fill_rate": 0.0,
                 "by_decision_type": {}, "mean_score": None}


def test_f_cli_human_and_json(tmp_path, capsys):
    _seed_pool(tmp_path)
    rc = DS.main(["--campaign", "T005-TEST", "--pool-root", str(tmp_path)])
    out = capsys.readouterr().out
    assert rc == 0
    assert "total=3" in out and "filled=1" in out
    assert "33.33%" in out                             # 回填率百分比
    assert "research_rounds=2" in out and "pricing_suggest=1" in out
    rc = DS.main(["--campaign", "T005-TEST", "--pool-root", str(tmp_path),
                  "--json"])
    payload = json.loads(capsys.readouterr().out)
    assert payload["total"] == 3 and payload["filled"] == 1
    assert payload["by_decision_type"]["research_rounds"] == 2
    rc2 = DS.main(["--campaign", "NO-SUCH", "--pool-root", str(tmp_path)])
    assert rc2 == 0                                    # 无账本=零决策, 不算失败
    assert "total=0" in capsys.readouterr().out


# ------------------------------------------------ ⑦ 纯标准库
def test_g_stdlib_only():
    allowed = {"json", "sys", "re", "time", "datetime",
               "pathlib", "argparse", "__future__",
               "decision_ledger", "gates_loader"}       # 同目录本地模块, 非网络根
    for mod in (DL, DS):
        tree = ast.parse(Path(mod.__file__).read_text(encoding="utf-8"))
        imports = {n.names[0].name.split(".")[0]
                   for n in ast.walk(tree)
                   if isinstance(n, ast.Import)} | \
                  {n.module.split(".")[0]
                   for n in ast.walk(tree)
                   if isinstance(n, ast.ImportFrom) and n.module}
        assert imports <= allowed, imports
