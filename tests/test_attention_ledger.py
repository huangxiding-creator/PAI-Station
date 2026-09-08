"""R4 T17 注意力账本：ROI 门槛 + 挡:递 ≥10:1 + 每周 5 件事。"""
import json

from paistation.soul.attention import AttentionLedger, roi_gate


def test_roi_gate_math():
    """ROI = 价值 / (时长+打扰成本)；5 分价值 / (8+2) 分钟 = 0.5。"""
    assert roi_gate(value_est=5, duration_min=8, disturb_cost_min=2,
                    min_roi=0.5) is True
    assert roi_gate(value_est=2, duration_min=8, disturb_cost_min=2,
                    min_roi=0.5) is False


def test_roi_gate_zero_duration_ok():
    assert roi_gate(value_est=3, duration_min=0, disturb_cost_min=0) is True


def test_ledger_records_delivered_and_blocked(tmp_path):
    led = AttentionLedger(str(tmp_path / "attention.json"))
    led.record_delivered(topic="投标文件提醒", value_est=8, duration_min=5,
                         disturb_cost_min=2)
    led.record_blocked(topic="垃圾群消息", value_est=1, duration_min=3,
                       disturb_cost_min=2)
    s = led.stats()
    assert s["delivered"] == 1 and s["blocked"] == 1
    assert s["delivered_avg_value"] == 8
    assert s["blocked_avg_value"] == 1


def test_discrimination_ratio_10x(tmp_path):
    """门槛的分辨力：递进均值 ÷ 挡掉均值 ≥10 → 证明挡对了。"""
    led = AttentionLedger(str(tmp_path / "attention.json"))
    led.record_delivered(topic="A", value_est=9, duration_min=3,
                         disturb_cost_min=1)
    led.record_blocked(topic="B", value_est=0.5, duration_min=3,
                       disturb_cost_min=1)
    assert led.discrimination() >= 10


def test_persistence_roundtrip(tmp_path):
    path = str(tmp_path / "attention.json")
    led = AttentionLedger(path)
    led.record_delivered(topic="X", value_est=7, duration_min=4,
                         disturb_cost_min=1)
    led2 = AttentionLedger(path)
    assert led2.stats()["delivered"] == 1
    data = json.loads(open(path, encoding="utf-8").read())
    assert data["records"][0]["topic"] == "X"  # 落盘可审计


def test_weekly_summary_top5(tmp_path):
    led = AttentionLedger(str(tmp_path / "attention.json"))
    for i in range(7):
        led.record_delivered(topic=f"事{i}", value_est=float(i),
                             duration_min=1, disturb_cost_min=1)
    led.record_blocked(topic="噪音", value_est=0.2, duration_min=1,
                       disturb_cost_min=1)
    text = led.weekly_summary()
    assert "事6" in text and "事5" in text  # 高价值在前
    assert "事0" not in text  # 只取前 5
    assert "挡掉 1" in text


def test_empty_ledger_degrades(tmp_path):
    led = AttentionLedger(str(tmp_path / "attention.json"))
    assert led.stats()["delivered"] == 0
    assert "本周" in led.weekly_summary()  # 空账本也有输出（诚实：没有数据）


def test_gate_decision_recorded_end_to_end(tmp_path):
    """完整闭环：候选 → 门槛判定 → 记账（递进/挡掉各归其位）。"""
    led = AttentionLedger(str(tmp_path / "attention.json"))

    def consider(topic, value, dur, cost):
        if roi_gate(value, dur, cost):
            led.record_delivered(topic, value, dur, cost)
        else:
            led.record_blocked(topic, value, dur, cost)

    consider("高价值", 8, 3, 1)
    consider("低价值", 1, 3, 1)
    s = led.stats()
    assert s["delivered"] == 1 and s["blocked"] == 1
