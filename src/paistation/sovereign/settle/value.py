"""P3 意图结算预留：任务卡→价值当量账本（per-outcome 计量层）。

「按成果计价，模型越强我越便宜」的计量基建（DISRUPTION_PLAN 假设③）：
交付回执（M4 Deliverer 的 deliveries/receipts.jsonl）→ 价值当量入账 →
对账单。**价值当量是显式汇率表推导的计量单位，不是市场价格声明**——
每个数字都带 basis 审计串（任务类型×基点×体量系数×字数），可重放。

账本纪律与 swarm 积分账本同款：jsonl 只增不删，余额/对账单=派生可重放；
回执 settle_key 幂等，同一交付永不双记。
"""
from __future__ import annotations

import hashlib
import json
from pathlib import Path

KINDS = ("outcome",)

# 显式汇率卡（用户可改；改表只影响新入账，历史 basis 已冻结在事件里）
RATE_CARD: dict[str, int] = {
    "report": 50,    # 报告/方案
    "research": 40,  # 调研
    "summary": 20,   # 汇总/整理/纪要
    "review": 15,    # 审核/评审
    "data": 20,      # 表格/清单
    "misc": 10,
}
SIZE_TIERS = ((20000, 2.0), (5000, 1.5), (1000, 1.0))  # 以下退 0.5
POINTS_PER_HOUR = 25   # 1 人力小时当量 = 25 点（显式常数，对账单声明）
_TIERS_NOTE = "/".join(f"≥{floor}字×{factor}" for floor, factor in SIZE_TIERS)
RATE_NOTE = (f"汇率卡 {RATE_CARD} × 体量档 {_TIERS_NOTE}（以下×0.5）；"
             f"1 人力小时当量 = {POINTS_PER_HOUR} 点")

_TYPE_KEYWORDS = (
    ("research", ("调研", "侦察", "摸底")),
    ("report", ("报告", "方案", "标书", "论文")),
    ("summary", ("汇总", "整理", "纪要", "总结", "归档")),
    ("review", ("审核", "评审", "审阅", "校核")),
    ("data", ("表格", "清单", "台账")),
)


def classify(title: str) -> tuple[str, str]:
    """标题→（任务类型, 命中关键词）。无命中回 (misc, "")。"""
    for task_type, keys in _TYPE_KEYWORDS:
        for kw in keys:
            if kw in title:
                return task_type, kw
    return "misc", ""


def rate(title: str, chars: int) -> tuple[int, str]:
    """成果→（价值当量点数, 审计串）。确定性纯函数，同一输入永远同一输出。"""
    task_type, kw = classify(title)
    base = RATE_CARD[task_type]
    factor = next((f for floor, f in SIZE_TIERS if chars >= floor), 0.5)
    points = int(round(base * factor))
    basis = (f"task={task_type}({kw or '无命中'}) base={base} "
             f"size=x{factor} chars={chars}")
    return points, basis


def _settle_key(receipt: dict) -> str:
    raw = "|".join(str(receipt.get(k, "")) for k in
                   ("ts", "card_id", "artifact", "chars"))
    return hashlib.sha256(raw.encode("utf-8")).hexdigest()[:16]


class OutcomeLedger:
    """价值当量账本：jsonl 只增不删，事件带审计 basis。"""

    def __init__(self, path: str | Path):
        self._path = Path(path)

    # ---- 读侧 ----

    def events(self) -> list[dict]:
        if not self._path.is_file():
            return []
        rows: list[dict] = []
        for line in self._path.read_text(encoding="utf-8").splitlines():
            line = line.strip()
            if not line:
                continue
            try:
                rows.append(json.loads(line))
            except ValueError:      # 尾部半行（断电）跳过不连坐
                continue
        return rows

    def statement(self) -> dict:
        rows = [r for r in self.events() if r.get("kind") == "outcome"]
        by_type: dict[str, int] = {}
        by_day: dict[str, int] = {}
        for r in rows:
            by_type[r["task_type"]] = by_type.get(r["task_type"], 0) \
                + r["value_points"]
            day = str(r.get("ts", ""))[:10]
            by_day[day] = by_day.get(day, 0) + r["value_points"]
        total = sum(by_type.values())
        return {"outcomes": len(rows), "total_points": total,
                "by_task_type": by_type, "by_day": by_day,
                "hours_equivalent": round(total / POINTS_PER_HOUR, 2),
                "rate_note": RATE_NOTE}

    # ---- 写侧 ----

    def append(self, kind: str, **fields) -> dict:
        if kind not in KINDS:
            raise ValueError(f"未知事件类型: {kind}")
        rows = self.events()
        row = {"seq": (rows[-1]["seq"] + 1) if rows else 1,
               "kind": kind, **fields}
        self._write_line(json.dumps(row, ensure_ascii=False))
        return row

    def _write_line(self, line: str) -> None:
        """追加一行；断电半行先封口，永不拼在残行后。"""
        self._path.parent.mkdir(parents=True, exist_ok=True)
        needs_nl = (self._path.is_file()
                    and self._path.stat().st_size > 0
                    and not self._path.read_bytes().endswith(b"\n"))
        with open(self._path, "a", encoding="utf-8") as fh:
            if needs_nl:
                fh.write("\n")
            fh.write(line + "\n")

    def settle(self, receipt: dict) -> dict | None:
        """交付回执→价值事件。幂等：同一回执二次入账回 None。"""
        key = _settle_key(receipt)
        if any(r.get("settle_key") == key for r in self.events()):
            return None
        points, basis = rate(receipt.get("title", ""), int(receipt.get("chars", 0)))
        task_type, _ = classify(receipt.get("title", ""))
        return self.append("outcome",
                           ts=receipt.get("ts", ""),
                           card_id=receipt.get("card_id", ""),
                           title=receipt.get("title", ""),
                           artifact=receipt.get("artifact", ""),
                           chars=receipt.get("chars", 0),
                           task_type=task_type,
                           value_points=points,
                           basis=basis,
                           settle_key=key)


def ingest(receipts_path: str | Path, ledger: OutcomeLedger) -> int:
    """M4 交付回执桥：receipts.jsonl→价值账本。回执缺位=空转，重复=零新入账。"""
    path = Path(receipts_path)
    if not path.is_file():
        return 0
    count = 0
    for line in path.read_text(encoding="utf-8").splitlines():
        line = line.strip()
        if not line:
            continue
        try:
            receipt = json.loads(line)
        except ValueError:
            continue
        if ledger.settle(receipt) is not None:
            count += 1
    return count
