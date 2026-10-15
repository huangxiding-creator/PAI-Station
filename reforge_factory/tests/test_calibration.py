# -*- coding: utf-8 -*-
"""test_calibration — 校准预测抽取+Brier对账腿单测 (T-013B, REQ-042 / AC1).

覆盖:
  ① extract 抽取三形: 概率约X% / X%的概率 / 概率高达(约为)X%,
     须含将来时线索 (将/预计/有望/可能); 非概率百分数不抽; 上下文窗口截断;
     文内「验证口径：」行与「截止<日期>」就近捕获
  ② 概率边界拒绝: 0 / 100 / "70" / 70.5 / True 全拒且账本零残留
  ③ record 追加: 首条 C-0001 / id 自增 / 九字段 schema / 验证口径缺失拒 /
     due 默认 ts+6 个月 / require_min 门
  ④ settle Brier: 70%说中=0.09 / 70%说错=0.49 / 只动 outcome+brier 两字段 /
     未知 id / 二次回填 / 非 bool outcome 拒
  ⑤ --synthetic: 10 条内置合成样本跑出已知平均 Brier (手算对拍值 0.238),
     且不触碰账本文件
  ⑥ 不足 5 条 exit 2 (REQ-042 门): 3 条草稿 → rc=2 且账本零写入;
     5 条草稿 → rc=0 入账; 批内夹 100% 越界行 → rc=1 整批拒
  ⑦ report 统计: total/settled/mean_brier/hit_rate (--campaign / --all / --json)
  ⑧ settle CLI + 纯标准库 (ast 零网络 import)

红线: 全部用 tmp 夹具, 绝不写真实 reforge_factory/calibration_ledger.jsonl.

跑法: py -m pytest reforge_factory/tests/test_calibration.py -q
"""
from __future__ import annotations

import ast
import json
import re
import sys
from datetime import date
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
import calibration_extract as CX                      # noqa: E402
import brier_score as BS                              # noqa: E402

TS_RE = re.compile(r"^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}$")
DUE_RE = re.compile(r"^\d{4}-\d{2}-\d{2}$")

SCHEMA_FIELDS = ["id", "ts", "campaign", "prediction", "prob",
                 "verify_basis", "due", "outcome", "brier"]

DRAFT5 = """## 判断清单
新规密集换版后，代理机构退出潮将出现，概率约70%。验证口径：中国招标投标公共服务平台年度登记数对比
省级细则将扩散，70%的概率在2027年底前出现第三省跟进。
评标专家跨省抽取将常态化，概率高达90%。
修订案有望在2027年底前表决通过，概率约55%。
低于成本报价核查将趋严，概率约为80%。
"""


def _pred(prediction="测试判断", prob=70, verify_basis=None, due=None):
    d = {"prediction": prediction, "prob": prob}
    if verify_basis is not None:
        d["verify_basis"] = verify_basis
    if due is not None:
        d["due"] = due
    return d


# ------------------------------------------------ ① extract 三形
def test_a_extract_three_forms():
    preds = CX.extract(DRAFT5)
    assert [p["prob"] for p in preds] == [70, 70, 90, 55, 80]   # 文序
    assert "概率约70%" in preds[0]["prediction"]
    assert "70%的概率" in preds[1]["prediction"]
    assert "概率高达90%" in preds[2]["prediction"]
    # 文内「验证口径：」行就近捕获 (同段行内亦可)
    assert preds[0]["verify_basis"] == "中国招标投标公共服务平台年度登记数对比"
    assert preds[1]["verify_basis"] is None                    # 无口径行 → None


def test_a_extract_requires_future_cue():
    md = "当前中奖概率约50%。\n历史市占率30%的概率数据仅供参考。\n"
    assert CX.extract(md) == []            # 无 将/预计/有望/可能 线索 → 不抽


def test_a_extract_non_probability_percent_ignored():
    md = "覆盖率将达100%，市占率可能升至35%，但都不是概率化判断句。\n"
    assert CX.extract(md) == []            # 百分数无「概率」语义 → 不抽


def test_a_extract_context_window_truncated():
    pad = "很长的政策背景铺垫文字" * 20                       # 远超 120 字
    md = f"{pad}，代理机构退出潮将出现，概率约60%。{pad}\n"
    (pred,) = CX.extract(md)
    assert len(pred["prediction"]) <= 122                    # 120 + 省略号
    assert "概率约60%" in pred["prediction"]


def test_a_extract_due_date_normalized():
    md = "第三省跟进将落地，70%的概率复制青海模式。截止2027年6月30日\n"
    (pred,) = CX.extract(md)
    assert pred["due"] == "2027-06-30"
    md2 = "修订案将表决，概率约55%，截止 2027-12-31 复核。\n"
    (p2,) = CX.extract(md2)
    assert p2["due"] == "2027-12-31"


def test_a_extract_dedup_same_sentence():
    md = "同一句判断将只记一次，概率约70%。同一句判断将只记一次，概率约70%。\n"
    preds = CX.extract(md)
    assert len(preds) == 1


# ------------------------------------------------ ② 概率边界拒绝
def test_b_prob_bounds_rejected(tmp_path):
    ledger = tmp_path / "calibration_ledger.jsonl"
    for bad in (0, 100, -1, "70", 70.5, True, None):
        try:
            CX.record([_pred(prob=bad, verify_basis="口径")], "T013B-TEST",
                      ledger=ledger)
            raise AssertionError(f"prob={bad!r} 应拒 (1-99)")
        except ValueError:
            pass
    assert not ledger.exists()                               # 账本零残留


# ------------------------------------------------ ③ record 追加
def test_c_record_append_and_schema(tmp_path):
    ledger = tmp_path / "calibration_ledger.jsonl"
    a = CX.record([_pred(verify_basis="口径A")], "T013B-TEST", ledger=ledger)
    b = CX.record([_pred(prob=30, verify_basis="口径B", due="2027-06-30"),
                   _pred(prob=45, verify_basis="口径C")],
                  "T013B-TEST", ledger=ledger)
    assert [r["id"] for r in a + b] == ["C-0001", "C-0002", "C-0003"]
    lines = ledger.read_text(encoding="utf-8").splitlines()
    assert len(lines) == 3                                   # 追加式只增
    on_disk = [json.loads(x) for x in lines]
    assert on_disk == a + b                                  # 返回值 == 落盘值
    assert list(on_disk[0]) == SCHEMA_FIELDS                 # 九字段 schema 序
    assert TS_RE.match(on_disk[0]["ts"])
    assert on_disk[1]["due"] == "2027-06-30"                 # 显式 due 直通
    assert on_disk[0]["outcome"] is None and on_disk[0]["brier"] is None


def test_c_record_verify_basis_required(tmp_path):
    ledger = tmp_path / "calibration_ledger.jsonl"
    try:
        CX.record([_pred()], "T013B-TEST", ledger=ledger)    # 无任何口径
        raise AssertionError("验证口径缺失应拒")
    except ValueError as exc:
        assert "验证口径" in str(exc)
    assert not ledger.exists()


def test_c_record_due_default_six_months(tmp_path):
    ledger = tmp_path / "calibration_ledger.jsonl"
    (rec,) = CX.record([_pred(verify_basis="口径")], "T013B-TEST", ledger=ledger)
    base = date.fromisoformat(rec["ts"][:10])
    assert rec["due"] == CX.add_months(base, 6)               # 默认 +6 个月
    assert DUE_RE.match(rec["due"])


def test_c_record_require_min_gate(tmp_path):
    ledger = tmp_path / "calibration_ledger.jsonl"
    four = [_pred(prob=p, verify_basis="口径") for p in (10, 20, 30, 40)]
    try:
        CX.record(four, "T013B-TEST", ledger=ledger, require_min=5)
        raise AssertionError("不足 5 条应触发 REQ-042 门")
    except ValueError as exc:
        assert "REQ-042" in str(exc)
    assert not ledger.exists()                                # 门未过零写入


def test_c_record_atomic_batch(tmp_path):
    """批内混入一行非法 → 整批拒, 不留半批 (校验先行, 追加在后)."""
    ledger = tmp_path / "calibration_ledger.jsonl"
    batch = [_pred(prob=50, verify_basis="口径"),
             _pred(prob=100, verify_basis="口径")]
    try:
        CX.record(batch, "T013B-TEST", ledger=ledger)
        raise AssertionError("批内越界应整批拒")
    except ValueError:
        pass
    assert not ledger.exists()


# ------------------------------------------------ ④ settle Brier
def test_d_settle_brier_values(tmp_path):
    ledger = tmp_path / "calibration_ledger.jsonl"
    probs = [70, 70, 30, 90]
    rows = CX.record([_pred(prob=p, verify_basis="口径") for p in probs],
                     "T013B-TEST", ledger=ledger)
    upd = BS.settle(rows[0]["id"], True, ledger=ledger)       # 0.7 说中
    assert upd["outcome"] is True
    assert upd["brier"] == 0.09                               # (0.7-1)² = 0.09
    assert BS.settle(rows[1]["id"], False, ledger=ledger)["brier"] == 0.49
    assert BS.settle(rows[2]["id"], False, ledger=ledger)["brier"] == 0.09
    assert BS.settle(rows[3]["id"], True, ledger=ledger)["brier"] == 0.01


def test_d_settle_touches_only_outcome_brier(tmp_path):
    ledger = tmp_path / "calibration_ledger.jsonl"
    rows = CX.record([_pred(prob=p, verify_basis="口径") for p in (60, 70, 80)],
                     "T013B-TEST", ledger=ledger)
    raw_before = ledger.read_bytes().splitlines(keepends=True)
    recs_before = [json.loads(x) for x in raw_before]

    upd = BS.settle(rows[1]["id"], True, ledger=ledger)

    raw_after = ledger.read_bytes().splitlines(keepends=True)
    assert len(raw_after) == 3                                # 行数不变
    assert raw_after[0] == raw_before[0]                      # 其余行字节保真
    assert raw_after[2] == raw_before[2]
    mid = json.loads(raw_after[1])
    for k in ("id", "ts", "campaign", "prediction", "prob",
              "verify_basis", "due"):                          # 只动两字段
        assert mid[k] == recs_before[1][k]
    assert mid["outcome"] is True and mid["brier"] == 0.09
    assert upd == mid


def test_d_settle_guards(tmp_path):
    ledger = tmp_path / "calibration_ledger.jsonl"
    (row,) = CX.record([_pred(verify_basis="口径")], "T013B-TEST", ledger=ledger)
    try:
        BS.settle("C-9999", True, ledger=ledger)
        raise AssertionError("未知 id 应拒")
    except ValueError:
        pass
    BS.settle(row["id"], False, ledger=ledger)
    try:
        BS.settle(row["id"], True, ledger=ledger)             # 二次回填翻案
        raise AssertionError("已对账记录应拒绝二次回填")
    except ValueError:
        pass
    for bad in (1, "true", None):
        try:
            BS.settle("C-0001", bad, ledger=ledger)
            raise AssertionError(f"非 bool outcome={bad!r} 应拒")
        except ValueError:
            pass


# ------------------------------------------------ ⑤ --synthetic 已知分
def test_e_synthetic_known_score():
    assert len(BS.SYNTHETIC_SAMPLES) == 10
    # 手算对拍值 (写死): Σ(0.09,0.49,0.04,0.64,0.16,0.36,0.01,0.25,0.25,0.09)/10
    assert BS.SYNTHETIC_MEAN_BRIER == 0.238
    mean = sum(BS.brier(p, o) for p, o in BS.SYNTHETIC_SAMPLES) / 10
    assert abs(mean - 0.238) < 1e-12


def test_e_synthetic_cli_and_ledger_untouched(tmp_path, capsys, monkeypatch):
    monkeypatch.setattr(CX, "DEFAULT_LEDGER", tmp_path / "ledger.jsonl")
    rc = BS.main(["--synthetic"])
    out = capsys.readouterr().out
    assert rc == 0
    assert "0.238" in out and "n=10" in out
    assert not (tmp_path / "ledger.jsonl").exists()           # 不碰账本


# ------------------------------------------------ ⑥ 不足 5 条 exit 2
def test_f_cli_gate_exit2(tmp_path, capsys):
    short = "判断一将出现，概率约60%。\n判断二预计落地，概率约50%。\n判断三有望兑现，概率约40%。\n"
    draft = tmp_path / "short.md"
    draft.write_text(short, encoding="utf-8")
    ledger = tmp_path / "ledger.jsonl"
    rc = CX.main(["--draft", str(draft), "--campaign", "T013B-TEST",
                  "--verify-basis", "口径", "--ledger", str(ledger)])
    assert rc == 2                                            # REQ-042 门
    assert "REQ-042" in capsys.readouterr().err
    assert not ledger.exists()                                # 门未过不入账


def test_f_cli_success_five(tmp_path, capsys):
    draft = tmp_path / "d5.md"
    draft.write_text(DRAFT5, encoding="utf-8")
    ledger = tmp_path / "ledger.jsonl"
    rc = CX.main(["--draft", str(draft), "--campaign", "T013B-TEST",
                  "--verify-basis", "兜底口径", "--ledger", str(ledger)])
    assert rc == 0
    out = capsys.readouterr().out
    assert "recorded=5" in out
    rows = [json.loads(x) for x in
            ledger.read_text(encoding="utf-8").splitlines()]
    assert len(rows) == 5 and rows[0]["id"] == "C-0001"
    assert rows[0]["verify_basis"] == "中国招标投标公共服务平台年度登记数对比"


def test_f_cli_rejects_batch_with_out_of_range(tmp_path):
    dirty = DRAFT5 + "极端行将出现，概率约100%。\n"            # 批内 100% 越界
    draft = tmp_path / "d6.md"
    draft.write_text(dirty, encoding="utf-8")
    ledger = tmp_path / "ledger.jsonl"
    rc = CX.main(["--draft", str(draft), "--campaign", "T013B-TEST",
                  "--verify-basis", "口径", "--ledger", str(ledger)])
    assert rc == 1                                            # 参数/校验错
    assert not ledger.exists()                                # 整批拒零残留


# ------------------------------------------------ ⑦ report 统计
def _seed(tmp_path):
    ledger = tmp_path / "ledger.jsonl"
    a = CX.record([_pred(prob=p, verify_basis="口径") for p in (70, 70, 30)],
                  "T013B-A", ledger=ledger)
    CX.record([_pred(prob=80, verify_basis="口径")], "T013B-B", ledger=ledger)
    BS.settle(a[0]["id"], True, ledger=ledger)                # 0.09
    BS.settle(a[1]["id"], False, ledger=ledger)               # 0.49
    return ledger


def test_g_summarize_stats(tmp_path):
    ledger = _seed(tmp_path)
    rows = CX.load_rows(ledger=ledger)
    s = BS.summarize([r for r in rows if r["campaign"] == "T013B-A"])
    assert s["total"] == 3 and s["settled"] == 2 and s["pending"] == 1
    assert s["mean_brier"] == 0.29                            # (0.09+0.49)/2
    assert s["hit_rate"] == 0.5                               # 1/2 说中
    assert BS.summarize([] ) == {"total": 0, "settled": 0, "pending": 0,
                                 "mean_brier": None, "hit_rate": None}


def test_g_report_cli(tmp_path, capsys):
    ledger = _seed(tmp_path)
    rc = BS.main(["--campaign", "T013B-A", "--ledger", str(ledger)])
    out = capsys.readouterr().out
    assert rc == 0
    assert "total=3" in out and "settled=2" in out
    assert "mean_brier=0.29" in out and "hit_rate=50.00%" in out
    rc = BS.main(["--all", "--ledger", str(ledger)])
    assert "total=4" in capsys.readouterr().out               # 跨战役聚合
    rc = BS.main(["--campaign", "T013B-A", "--ledger", str(ledger), "--json"])
    payload = json.loads(capsys.readouterr().out)
    assert payload["total"] == 3 and payload["mean_brier"] == 0.29


# ------------------------------------------------ ⑧ settle CLI + 纯标准库
def test_h_cli_settle(tmp_path, capsys):
    ledger = _seed(tmp_path)                                  # C-0003 未对账
    rc = BS.main(["--settle", "C-0003", "--outcome", "false",
                  "--ledger", str(ledger)])
    assert rc == 0
    rows = {r["id"]: r for r in CX.load_rows(ledger=ledger)}
    assert rows["C-0003"]["outcome"] is False
    assert rows["C-0003"]["brier"] == 0.09                    # (0.3-0)²
    rc = BS.main(["--settle", "C-0003", "--outcome", "true",
                  "--ledger", str(ledger)])
    assert rc == 1                                            # 二次回填 → 错误码


def test_h_stdlib_only():
    allowed = {"json", "sys", "re", "datetime", "pathlib", "argparse",
               "__future__", "calibration_extract"}           # 同目录本地模块
    for mod in (CX, BS):
        tree = ast.parse(Path(mod.__file__).read_text(encoding="utf-8"))
        imports = {n.names[0].name.split(".")[0]
                   for n in ast.walk(tree)
                   if isinstance(n, ast.Import)} | \
                  {n.module.split(".")[0]
                   for n in ast.walk(tree)
                   if isinstance(n, ast.ImportFrom) and n.module}
        assert imports <= allowed, (mod.__name__, imports)
