"""P3 意图结算预留：任务卡→价值当量账本（per-outcome 计量层）。

E2E 主线：事件→任务卡（M3）→交付回执（M4 Deliverer）→价值入账→
对账单（per-outcome：每个成果一条显式汇率推导的价值当量，可审计）。
"""
import json

import pytest

from paistation.execute.deliver import Deliverer, RecordingNotifier
from paistation.proactive.taskcards import extract_task_cards
from paistation.sovereign.settle import OutcomeLedger, classify, ingest, rate

# ---------- 定价表：显式汇率，可审计 ----------

def test_classify_keywords():
    assert classify("帮我调研一下腾讯办公助手的定价")[0] == "research"
    assert classify("整理今天的会议纪要")[0] == "summary"
    assert classify("汇总各标段的报价")[0] == "summary"
    assert classify("审核分包合同条款")[0] == "review"
    assert classify("写一份白龟湖项目报告")[0] == "report"
    assert classify("随便弄个东西")[0] == "misc"


def test_rate_deterministic_and_auditable():
    p1, basis = rate("调研竞品定价", 8000)
    p2, basis2 = rate("调研竞品定价", 8000)
    assert p1 == p2 and basis == basis2          # 确定性
    assert p1 > 0 and "research" in basis and "chars" in basis
    big, _ = rate("调研竞品定价", 30000)
    assert big > p1                                # 更大成果更高当量


# ---------- 账本：只增不删+幂等 ----------

def _receipt(card_id="c1", title="调研X", artifact="08 成果/x.md",
             chars=5000, ts="2026-09-17T10:00:00"):
    return {"ts": ts, "card_id": card_id, "title": title,
            "artifact": artifact, "chars": chars}


def test_ledger_append_only_and_idempotent(tmp_path):
    led = OutcomeLedger(str(tmp_path / "value.jsonl"))
    row = led.settle(_receipt())
    assert row["value_points"] > 0 and row["kind"] == "outcome"
    assert led.settle(_receipt()) is None          # 同一回执二次入账拒
    rows = led.events()
    assert len(rows) == 1 and rows[0]["seq"] == 1
    row2 = led.settle(_receipt(title="调研Y", artifact="08 成果/y.md"))
    assert [r["seq"] for r in led.events()] == [1, 2]   # 序号单调
    assert rows[0]["settle_key"] != row2["settle_key"]


def test_ledger_unknown_kind_rejected(tmp_path):
    led = OutcomeLedger(str(tmp_path / "value.jsonl"))
    with pytest.raises(ValueError, match="未知事件"):
        led.append("steal", points=999)


def test_ledger_survives_partial_trailing_line(tmp_path):
    path = tmp_path / "value.jsonl"
    led = OutcomeLedger(str(path))
    led.settle(_receipt())
    with open(path, "a", encoding="utf-8") as fh:
        fh.write('{"seq": 2, "kind": "outc')      # 模拟写一半断电
    led2 = OutcomeLedger(str(path))
    assert len(led2.events()) == 1                 # 读侧跳过半行
    led2.settle(_receipt(title="调研Z", artifact="z.md"))   # 写侧续写不撞号
    assert led2.events()[-1]["seq"] == 2


# ---------- 对账单 ----------

def test_statement_aggregates_per_outcome(tmp_path):
    led = OutcomeLedger(str(tmp_path / "value.jsonl"))
    led.settle(_receipt(title="调研A", artifact="a.md", chars=8000))
    led.settle(_receipt(card_id="c2", title="汇总B", artifact="b.md",
                        chars=1200, ts="2026-09-16T09:00:00"))
    st = led.statement()
    assert st["outcomes"] == 2
    assert st["by_task_type"]["research"] > st["by_task_type"]["summary"]
    assert set(st["by_day"]) == {"2026-09-17", "2026-09-16"}
    assert st["total_points"] == sum(v for v in st["by_task_type"].values())
    # 人力小时当量 = 总分 / 显式时薪汇率，账单上看得见依据
    assert st["hours_equivalent"] == round(st["total_points"] / 25, 2)
    assert st["rate_note"]                          # 汇率声明必在


# ---------- 回执桥：M4 既有基建 → 价值账本 ----------

def test_ingest_receipts_file_idempotent(tmp_path):
    rdir = tmp_path / "deliveries"
    rdir.mkdir()
    lines = [_receipt(), _receipt(card_id="c2", title="汇总B",
                                  artifact="b.md", chars=1200)]
    (rdir / "receipts.jsonl").write_text(
        "\n".join(json.dumps(x, ensure_ascii=False) for x in lines),
        encoding="utf-8")
    led = OutcomeLedger(str(tmp_path / "value.jsonl"))
    assert ingest(str(rdir / "receipts.jsonl"), led) == 2
    assert ingest(str(rdir / "receipts.jsonl"), led) == 0   # 重跑零重复
    assert ingest(str(tmp_path / "none.jsonl"), led) == 0   # 回执缺位=空转


# ---------- E2E：意图→卡→交付→入账→对账（per-outcome 验收主线）----------

def test_e2e_cards_to_value_statement(tmp_path):
    events = [
        {"text": "请帮我调研一下江巷灌区的数字孪生方案，周五要结果",
         "source": "mic"},
        {"text": "别忘了汇总本周的安全检查记录", "source": "meeting"},
    ]
    cards = extract_task_cards(events)
    assert len(cards) == 2
    deliverer = Deliverer(tmp_path, notifier=RecordingNotifier())
    for card in cards:
        deliverer.deliver(card, "成果正文" * 500)   # ~2000 字
    led = OutcomeLedger(str(tmp_path / "value.jsonl"))
    n = ingest(str(tmp_path / "deliveries" / "receipts.jsonl"), led)
    assert n == 2
    st = led.statement()
    assert st["outcomes"] == 2 and st["total_points"] > 0
    # per-outcome：每个成果独立一条，basis 可审计
    for row in led.events():
        assert row["card_id"] and row["value_points"] > 0 and row["basis"]


# ---------- CLI ----------

def test_cli_statement_and_demo(tmp_path, capsys):
    from paistation.sovereign.settle.__main__ import main
    rdir = tmp_path / "deliveries"
    rdir.mkdir()
    (rdir / "receipts.jsonl").write_text(
        json.dumps(_receipt(), ensure_ascii=False), encoding="utf-8")
    assert main(["--root", str(tmp_path), "settle"]) == 0
    out = capsys.readouterr().out
    assert "settled: 1" in out
    assert main(["--root", str(tmp_path), "statement"]) == 0
    out = capsys.readouterr().out
    assert "价值当量" in out and "research" in out
    assert main(["--root", str(tmp_path), "demo"]) == 0
    assert "demo" in capsys.readouterr().out.lower()
