"""市场环漏斗账本（M7.6 / PROPOSAL_M7 §5.3）——五事件记账 + 价值账本打通。

五事件：浏览 → 试读 → 购买 → 反馈 → 定制线索（转化率漏斗）。
进项路由：购买收入 − 返款 = 净进项，一笔记入 soul.ValueLedger.ecosystem
科目（方案工厂科目），幂等水位防重复记账（只增不删铁律）。
"""

import datetime
import json
import os

EVENTS = ("view", "preview", "purchase", "feedback", "custom_lead")

_LEDGER_NAME = "funnel_ledger.jsonl"
_SYNC_NAME = "sync_state.json"


class Funnel:
    """漏斗账本：track 落 jsonl（追加式），sync 幂等汇入价值账本。"""

    def __init__(self, ledger_dir: str):
        self._dir = ledger_dir
        self._path = os.path.join(ledger_dir, _LEDGER_NAME)
        os.makedirs(ledger_dir, exist_ok=True)

    @property
    def ledger_path(self) -> str:
        return self._path

    def _entries(self) -> list[dict]:
        if not os.path.exists(self._path):
            return []
        out = []
        for line in open(self._path, encoding="utf-8"):
            line = line.strip()
            if line:
                try:
                    out.append(json.loads(line))
                except ValueError:
                    continue  # 损坏行容错跳过，不崩账本
        return out

    def track(self, event: str, slug: str, **detail) -> dict:
        """记一笔漏斗事件。event 必须是五事件之一，未知事件拒绝（防脏数据）。"""
        if event not in EVENTS:
            legal = "/".join(EVENTS)
            raise ValueError(f"未知漏斗事件：{event}（合法：{legal}）")
        entry = {"event": event, "slug": slug,
                 "ts": datetime.datetime.now().isoformat(timespec="seconds"),
                 **detail}
        with open(self._path, "a", encoding="utf-8") as f:
            f.write(json.dumps(entry, ensure_ascii=False) + "\n")
        return entry

    # ---------- 汇入价值账本 ----------

    def sync_to_value_ledger(self, value_ledger) -> dict:
        """自上次水位以来的购买/返款/线索汇入 ValueLedger（幂等）。

        返回本次汇入摘要 {income, refunds, net, leads}；无新事件时全零且不记账。
        """
        entries = self._entries()
        state_path = os.path.join(self._dir, _SYNC_NAME)
        watermark = 0
        if os.path.exists(state_path):
            try:
                watermark = json.load(open(state_path, encoding="utf-8")).get("n", 0)
            except (OSError, ValueError):
                watermark = 0
        fresh = entries[watermark:]

        income = sum(e.get("price", 0) for e in fresh if e["event"] == "purchase")
        refunds = sum(e.get("refund", 0) for e in fresh if e["event"] == "feedback")
        leads = sum(1 for e in fresh if e["event"] == "custom_lead")
        net = income - refunds

        slugs = sorted({e["slug"] for e in fresh}) or ["-"]
        if net != 0:
            value_ledger.record_ecosystem(
                net, note=f"方案工厂进项：收入{income}−返款{refunds}"
                          f"（{','.join(slugs)}）")
        if leads:
            value_ledger.record_ecosystem(
                0, note=f"定制线索 +{leads}（{','.join(slugs)}）")

        json.dump({"n": len(entries)}, open(state_path, "w", encoding="utf-8"))
        return {"income": income, "refunds": refunds, "net": net, "leads": leads}


def funnel_report(ledger_dir: str) -> dict:
    """按 slug 聚合五事件计数 + 试读→购买转化率（漏斗健康度）。"""
    funnel = Funnel(ledger_dir)
    report: dict[str, dict] = {}
    for e in funnel._entries():
        slot = report.setdefault(e["slug"], {k: 0 for k in EVENTS}
                                 | {"preview_to_purchase": 0.0})
        slot[e["event"]] += 1
    for slot in report.values():
        if slot["preview"]:
            slot["preview_to_purchase"] = round(slot["purchase"] / slot["preview"], 4)
    return report
