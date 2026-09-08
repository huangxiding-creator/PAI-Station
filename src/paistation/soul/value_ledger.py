"""价值账本（提案第 26 章 T16/T27）：V = H·w + ΣAᵢ·rᵢ + E，而 C≈0。

三层价值：saved（替你省的小时×时薪）/ asset（技能资产复用）/
ecosystem（生态分成）。counterfactual：等价付费 API 成本（牌价表可配）。
月度 ¥0 对账单——恐怖装置：等价付费成本 vs 你的账单。
"""
import json
import os
import time

_DEFAULT_PRICE = {"fast": 0.001, "deep": 0.014, "vision": 0.006}


class ValueLedger:
    """三层价值 + token 牌价记账；JSON 落盘可审计。"""

    def __init__(self, json_path: str, price_per_1k: dict | None = None,
                 now_fn=time.time):
        self._path = json_path
        self._now = now_fn
        self._price = dict(_DEFAULT_PRICE)
        if price_per_1k:
            self._price.update(price_per_1k)
        parent = os.path.dirname(os.path.abspath(json_path))
        os.makedirs(parent, exist_ok=True)
        try:
            with open(self._path, encoding="utf-8") as fh:
                self._events = json.load(fh).get("events", [])
        except (OSError, ValueError):
            self._events = []

    def _save(self) -> None:
        with open(self._path, "w", encoding="utf-8") as fh:
            json.dump({"events": self._events}, fh, ensure_ascii=False, indent=1)

    def _append(self, kind: str, value: float, note: str = "") -> None:
        self._events.append({"ts": self._now(), "kind": kind,
                             "value": round(float(value), 2), "note": note})
        self._save()

    def record_saved(self, hours: float, wage: float, note: str = "") -> None:
        self._append("saved", hours * wage, note)

    def record_asset(self, uses: int, unit_value: float,
                     note: str = "") -> None:
        self._append("asset", uses * unit_value, note)

    def record_ecosystem(self, income: float, note: str = "") -> None:
        self._append("ecosystem", income, note)

    def record_tokens(self, model: str, tokens: int, price: float | None = None,
                      note: str = "") -> None:
        per_1k = self._price.get(model, 0.0) if price is None else price
        self._append(f"tokens:{model}", tokens / 1000 * per_1k, note)

    def totals(self) -> dict:
        out = {"saved": 0.0, "asset": 0.0, "ecosystem": 0.0}
        for e in self._events:
            if e["kind"] in out:
                out[e["kind"]] += e["value"]
        out = {k: round(v, 2) for k, v in out.items()}
        out["total"] = round(sum(out.values()), 2)
        return out

    def counterfactual_cost(self) -> float:
        """token 牌价总和 = 若用付费 API 要花的钱（¥）。"""
        return round(sum(e["value"] for e in self._events
                         if e["kind"].startswith("tokens:")), 2)

    def zero_bill_report(self, month: str = "") -> str:
        """¥0 复利对账单：等价付费成本 vs 你的账单（月度恐怖装置）。"""
        t = self.totals()
        cf = self.counterfactual_cost()
        equivalent = t["total"] + cf
        return (f"【{month} ¥0 复利对账单】\n"
                f"- 替你省下：¥{t['saved']:g}（{t['saved']:g} = 小时×时薪）\n"
                f"- 资产复利：¥{t['asset']:g}\n"
                f"- 等价付费 API 成本：¥{cf + t['saved']:g}\n"
                f"- 你的账单：¥0\n"
                f"等价付费成本合计 ¥{equivalent + t['saved']:g} vs 你的账单 ¥0——"
                "这就是免费链极限工程学")
