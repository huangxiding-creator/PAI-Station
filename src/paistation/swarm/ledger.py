"""积分账本：jsonl 只增不删（红线 R4 同款纪律）。

事件三类：mint（建账初始分）/ swap_in（收包支出，负数）/
income（回执确认收入，正数）。余额=全量事件求和，派生不落盘——
账本没有「改余额」这个动作，翻案=再追加一条，永不改写历史。

收入事件带 receipt_sha 做幂等键：同一张回执确认两次，第二次直接拒。
"""
from __future__ import annotations

import hashlib
import json
import os
import time

KINDS = ("mint", "swap_in", "income")


class PointsLedger:

    def __init__(self, path: str, site_id: str = ""):
        self._path = path
        self._site_id = site_id
        os.makedirs(os.path.dirname(path) or ".", exist_ok=True)
        if not os.path.isfile(path):
            open(path, "w", encoding="utf-8").close()

    # ---- 读 ----

    def events(self) -> list[dict]:
        rows: list[dict] = []
        with open(self._path, encoding="utf-8") as fh:
            for line in fh:
                line = line.strip()
                if not line:
                    continue
                try:
                    rows.append(json.loads(line))
                except ValueError:
                    continue  # 尾部半行（崩溃残留）读侧跳过，写侧只追加
        return rows

    def balance(self) -> int:
        return sum(int(e.get("points", 0)) for e in self.events())

    def _last_seq(self) -> int:
        rows = self.events()
        return rows[-1]["seq"] if rows else 0

    # ---- 写（只追加） ----

    def append(self, kind: str, package: str = "", counterparty: str = "",
               points: int = 0, extra: dict | None = None) -> dict:
        if kind not in KINDS:
            raise ValueError(f"未知事件类型 {kind}（合法：{KINDS}）")
        row = {"seq": self._last_seq() + 1,
               "ts": time.strftime("%Y-%m-%dT%H:%M:%S+08:00"),
               "site": self._site_id, "kind": kind, "package": package,
               "counterparty": counterparty, "points": int(points)}
        if extra:
            row.update(extra)
        with open(self._path, "a", encoding="utf-8") as fh:
            fh.write(json.dumps(row, ensure_ascii=False) + "\n")
        return row

    def ensure_mint(self, amount: int = 100) -> dict | None:
        """建账初始分，幂等（已有 mint 则零动作）。"""
        if any(e["kind"] == "mint" for e in self.events()):
            return None
        return self.append("mint", points=amount)

    # ---- 回执幂等 ----

    @staticmethod
    def receipt_sha(receipt: dict) -> str:
        core = {k: receipt.get(k) for k in
                ("spec", "package", "from_site", "to_site",
                 "payload_sha256", "price_points")}
        return hashlib.sha256(json.dumps(
            core, ensure_ascii=False, sort_keys=True).encode()).hexdigest()

    def has_receipt(self, receipt: dict) -> bool:
        sha = self.receipt_sha(receipt)
        return any(e.get("receipt_sha") == sha for e in self.events())
