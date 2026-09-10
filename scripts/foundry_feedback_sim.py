"""M7.3 实跑验收：3 条模拟反馈 → GLM 评分 → 阶梯返款 → 免疫沉淀 → 下版注入可验。

用法: python scripts/foundry_feedback_sim.py
产物: data/foundry/ledger/（immune/epc-fde-ai.json + feedback_ledger.jsonl）
"""
import json
import os
import sys

sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(
    os.path.abspath(__file__))), "src"))
sys.stdout.reconfigure(encoding="utf-8", errors="replace")

from paistation import config
from paistation.foundry.feedback import (
    deposit_immune_rule, load_immune_rules, refund_tier, score_feedback,
)
from paistation.llm.zhipu_client import ZhipuClient

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
LEDGER = os.path.join(ROOT, "data", "foundry", "ledger")
PRICE = 498

FEEDBACKS = [
    {"minutes": 25, "text": "我花了25分钟读完第3章。3.2节的WBS表缺责任人和工期两列，"
                            "建议补上并给出填写示例；数据化看板的指标没有计算公式，没法照抄。",
     "rule": "3.2节 WBS 表必须含责任人与工期两列，并附填写示例"},
    {"minutes": 45, "text": "整体框架清楚。第5章抄作业工具包的清单太多，打印出来两页，"
                            "建议按优先级排序并标星号，方便先做前三条。",
     "rule": "抄作业清单须按优先级排序并用星标突出前 3 条"},
    {"minutes": 18, "text": "还不错，加油。",
     "rule": "灌水反馈（无具体指向）——不入基因库"},
]


def main():
    cfg = config.load(os.path.join(ROOT, "config", "pai.ini"))
    key = config.resolve_api_key(cfg)
    client = ZhipuClient(
        key, [cfg["llm"]["fast_model"], cfg["llm"]["deep_model"]],
        vision_model=cfg["llm"]["vision_model"])

    for fb in FEEDBACKS:
        score = score_feedback(fb["text"], fast_fn=client.fast)
        refund = refund_tier(fb["minutes"], price=PRICE, quality=score["quality"])
        rule_added = "" if refund["amount"] == 0 and score["quality"] < 4 else fb["rule"]
        if score["quality"] >= 4:
            deposit_immune_rule("epc-fde-ai", fb["rule"], quality=score["quality"],
                                ledger_dir=LEDGER, minutes=fb["minutes"],
                                refund_amount=refund["amount"])
        print(f"[feedback] {fb['minutes']}min quality={score['quality']} "
              f"(诚{score['sincerity']}/具{score['specificity']}/行{score['actionability']}) "
              f"→ 返款 {refund['tier']} = ¥{refund['amount']}"
              f"{'｜免疫入库' if score['quality'] >= 4 else '｜不入库'}", flush=True)

    rules = load_immune_rules("epc-fde-ai", ledger_dir=LEDGER)
    print(f"[inject] 下一版生成将注入 {len(rules)} 条免疫规则：", flush=True)
    for r in rules:
        print(f"  - {r}", flush=True)
    print(f"[ledger] {os.path.join(LEDGER, 'feedback_ledger.jsonl')}", flush=True)


if __name__ == "__main__":
    main()
