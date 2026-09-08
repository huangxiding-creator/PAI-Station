"""R8 T16 价值账本 + T22 avatar.pai 传承 + T24 恐怖时刻/奇点宣告 + T27 ¥0对账单。"""
import json
import os

from paistation.soul.avatar import export_avatar
from paistation.soul.moments import (SingularityWatch, horror_calendar,
                                     singularity_message)
from paistation.soul.value_ledger import ValueLedger


# ---- T16/T27 价值账本 ----

def test_value_ledger_records_three_layers(tmp_path):
    led = ValueLedger(str(tmp_path / "value.json"))
    led.record_saved(hours=3.0, wage=100, note="自动周报")
    led.record_asset(uses=5, unit_value=20, note="技能卡复用")
    led.record_ecosystem(income=10, note="市场分成")
    s = led.totals()
    assert s["saved"] == 300 and s["asset"] == 100 and s["ecosystem"] == 10
    assert s["total"] == 410


def test_counterfactual_cost_from_price_table(tmp_path):
    """牌价表可配（INI 思想）：tokens × 牌价 = 等价付费成本。"""
    led = ValueLedger(str(tmp_path / "value.json"),
                      price_per_1k={"fast": 0.001, "deep": 0.014})
    led.record_tokens(model="fast", tokens=100_000)
    led.record_tokens(model="deep", tokens=50_000)
    assert abs(led.counterfactual_cost() - (0.1 + 0.7)) < 0.001  # ¥0.8


def test_zero_bill_monthly(tmp_path):
    led = ValueLedger(str(tmp_path / "value.json"))
    led.record_saved(hours=28.3, wage=100)
    led.record_tokens(model="fast", tokens=1_000_000,
                      price=None) if False else led.record_tokens(
        model="deep", tokens=10_000)
    bill = led.zero_bill_report(month="2026-09")
    assert "¥0" in bill
    assert "2830" in bill  # ¥2,830 等价付费成本装置


def test_ledger_persistence(tmp_path):
    path = str(tmp_path / "value.json")
    ValueLedger(path).record_saved(hours=1, wage=100)
    assert ValueLedger(path).totals()["saved"] == 100


# ---- T24 恐怖时刻 + 奇点宣告 ----

def test_horror_calendar_first_times():
    cal = horror_calendar([
        {"week": "W36", "first_time": "自动生成首扫镜像报告"},
        {"week": "W37", "first_time": "Sign V3 逆向打通"},
        {"week": "W37", "first_time": None},  # 无新能力周
    ])
    assert "Sign V3 逆向打通" in cal
    assert "上周我还不会" in cal


def test_singularity_message_ceremony():
    msg = singularity_message(domain="周报撰写", score=72)
    assert "60 分奇点" in msg or "奇点" in msg
    assert "周报撰写" in msg
    assert "移交" in msg  # 岗位交接仪式


def test_singularity_watch_triggers_once(tmp_path):
    w = SingularityWatch(str(tmp_path / "sing.json"))
    assert w.check_and_announce("周报", 65) is not None   # 首跨 60 → 宣告
    assert w.check_and_announce("周报", 70) is None       # 已宣告过不再刷屏
    assert w.check_and_announce("周报", 58) is None       # 跌回不宣告


# ---- T22 avatar.pai 传承 ----

def test_export_avatar_contains_skills_not_privacy(tmp_path):
    skills = tmp_path / "skills"
    for name in ("周报三段式", "投标清单法"):
        d = skills / name
        d.mkdir(parents=True)
        (d / "SKILL.md").write_text(
            f"---\nname: {name}\ndescription: d\n---\n# {name}\n步骤", encoding="utf-8")
    out = tmp_path / "avatar.pai"
    export_avatar(str(skills), str(out), learned_from="张总的 AI 工作站")
    data = json.loads(out.read_text(encoding="utf-8"))
    names = [s["name"] for s in data["skills"]]
    assert "周报三段式" in names
    assert data["learned_from"] == "张总的 AI 工作站"
    assert "privacy" not in json.dumps(data)  # 只传方法不传隐私
    assert "opt-in" in data["ethics"]  # 三铁律自说明


def test_export_avatar_declares_revocable(tmp_path):
    skills = tmp_path / "skills"
    skills.mkdir()
    out = tmp_path / "avatar.pai"
    export_avatar(str(skills), str(out))
    data = json.loads(out.read_text(encoding="utf-8"))
    assert "可吊销" in data["ethics"]
    assert data["skills"] == []  # 空技能也合法导出
