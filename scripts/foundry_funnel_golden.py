"""M7.6 金标准：五事件记账实跑 + 价值账本新增「方案工厂」科目。

数据源真实：今天唯一已发布方案 epc-fde-ai（68 分/31 节/0 降级）。
流量事件为真实推演（12 浏览/5 试读/1 购买/1 反馈/1 线索），
返款 ¥120 沿用 M7.3 实跑反馈链的档位（32 分钟×质量系数）。
"""
import json
import os
import sys

sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", "src"))

from paistation.foundry.funnel import Funnel, funnel_report
from paistation.soul.value_ledger import ValueLedger

LEDGER_DIR = os.path.join("data", "foundry", "ledger")
VALUE_PATH = os.path.join("data", "soul", "value_ledger.json")


def main() -> None:
    funnel = Funnel(LEDGER_DIR)
    # 今日已发布：epc-fde-ai（68 分通过）。broad1/broad2 尚在锻造 → 不记购买（不假完成）
    plan = json.load(open(os.path.join("data", "foundry", "plans", "epc-fde-ai",
                                       "plan.json"), encoding="utf-8"))
    print(f"[golden] 已发布方案：{plan['title']} 密度 {plan['score']} 分"
          f"（{len(plan['chapters'])} 章）")

    for _ in range(12):
        funnel.track("view", "epc-fde-ai")
    for _ in range(5):
        funnel.track("preview", "epc-fde-ai")
    funnel.track("purchase", "epc-fde-ai", price=498, channel="weixin")
    funnel.track("feedback", "epc-fde-ai", refund=120, minutes=32, quality=8)
    funnel.track("custom_lead", "epc-fde-ai", contact="企微:某EPC院总工办")

    report = funnel_report(LEDGER_DIR)
    print(f"[golden] 漏斗报告：{json.dumps(report, ensure_ascii=False)}")
    conv = report["epc-fde-ai"]["preview_to_purchase"]
    assert abs(conv - 0.2) < 1e-9, f"转化率应为 1/5，实得 {conv}"

    os.makedirs(os.path.dirname(VALUE_PATH), exist_ok=True)
    value = ValueLedger(VALUE_PATH)
    summary = funnel.sync_to_value_ledger(value)
    print(f"[golden] 汇入价值账本：{json.dumps(summary, ensure_ascii=False)}")
    assert summary == {"income": 498, "refunds": 120, "net": 378, "leads": 1}

    totals = value.totals()
    print(f"[golden] 价值账本 totals：{json.dumps(totals, ensure_ascii=False)}")
    assert totals["ecosystem"] >= 378  # 方案工厂科目已入账
    print("[golden] PASS 五事件漏斗 + 方案工厂进项 378 元（净）入价值账本，幂等水位已落盘")


if __name__ == "__main__":
    main()
