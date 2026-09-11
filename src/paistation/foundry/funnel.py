"""市场环漏斗（M7.6 五事件账本 + M11 三段定价/上架/7.4 指标）。

M7.6：浏览→试读→购买→反馈→定制线索五事件记账；进项路由
购买收入−返款=净进项 → soul.ValueLedger.ecosystem（幂等水位防重复）。
M11（PROPOSAL_V2.md 7.3/7.4）：
- 三段：¥9.8-19.8 钩子（试读 20%+反馈入口）→ ¥198-498 全案 → 定制线索
- 定价实验：plan_id 哈希稳定分 A/B 桶（A=低价位 B=高价位）
- 上架：manifest+试读进 09 发布/store（全案只留 data/，付费内容不上公开仓）
- funnel_stats：7.4 四指标快照（上架/净进账/反馈/线索，零数据=0 不编造）
"""

import datetime
import hashlib
import json
import math
import os
import tempfile
from pathlib import Path

from ..organ.registry import find_by_name, organ_dir

EVENTS = ("view", "preview", "purchase", "feedback", "custom_lead")

_LEDGER_NAME = "funnel_ledger.jsonl"
_SYNC_NAME = "sync_state.json"

# M11 三段价格带（钩子/全案）
FUNNEL = {"hook": (9.8, 19.8), "full": (198, 498)}

# 7.4 节 90 天可证伪目标
GOALS = {"skus": 20, "revenue": 10000, "feedback": 60, "leads": 3}


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


# ==================== M11：三段定价 + 上架 + 7.4 指标 ====================

def assign_variant(plan_id: str) -> str:
    """定价实验分桶：plan_id sha256 稳定哈希 → A/B（复现可回溯）。"""
    digest = hashlib.sha256(plan_id.encode("utf-8")).hexdigest()
    return "A" if int(digest[:8], 16) % 2 == 0 else "B"


def variant_price(band: tuple[float, float], variant: str) -> float:
    """A=低价位，B=高价位（区间端点，实验对比最大化）。"""
    lo, hi = band
    return float(lo if variant == "A" else hi)


def free_taste(plan: dict, fraction: float = 0.2) -> list[dict]:
    """试读节选：按节数取前 20%（向上取整，至少 1 节）——09 器官质量门。"""
    sections = [(ch, sec) for ch in plan.get("chapters", [])
                for sec in ch.get("sections", [])]
    if not sections:
        return []
    take = max(1, math.ceil(len(sections) * fraction))
    return [{"chapter": ch["title"], "title": sec.get("title", ""),
             "framework": sec.get("framework", ""),
             "content": sec.get("content", "")}
            for ch, sec in sections[:take]]


def make_skus(plan: dict, plan_id: str) -> dict:
    """三段 SKU manifest（商店上架单元；全案路径本地引用不外发）。"""
    variant = assign_variant(plan_id)
    taste = free_taste(plan)
    return {
        "plan_id": plan_id, "title": plan.get("title", plan_id),
        "score": plan.get("score", 0), "passed": plan.get("passed", False),
        "issued_at": datetime.datetime.now().isoformat(timespec="seconds"),
        "skus": {
            "hook": {"price": variant_price(FUNNEL["hook"], variant),
                     "band": list(FUNNEL["hook"]), "variant": variant,
                     "taste_sections": len(taste),
                     "content": "试读.md"},
            "full": {"price": variant_price(FUNNEL["full"], variant),
                     "band": list(FUNNEL["full"]), "variant": variant,
                     "content": "本地 data/foundry/plans/<id>/plan.md"},
            "custom": {"price": "面议",
                       "note": "定制开发线索——漏斗末端（方案落地陪跑）"},
        },
    }


def _store_dir(root: Path) -> Path:
    return organ_dir(Path(root), find_by_name("发布")) / "store"


def _atomic_json(path: Path, payload) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    fd, tmp = tempfile.mkstemp(dir=str(path.parent), suffix=".tmp")
    try:
        with os.fdopen(fd, "w", encoding="utf-8") as fh:
            json.dump(payload, fh, ensure_ascii=False, indent=1)
        os.replace(tmp, path)
    finally:
        if os.path.exists(tmp):
            os.unlink(tmp)


def write_sku(root: Path, plan: dict, plan_id: str) -> Path:
    """上架：manifest.json + 试读.md + 商店索引聚合（全案不进商店目录）。"""
    manifest = make_skus(plan, plan_id)
    sku_dir = _store_dir(root) / plan_id
    _atomic_json(sku_dir / "manifest.json", manifest)

    lines = [f"# {manifest['title']}（试读）", "",
             f"> 思想密度分 {manifest['score']}"
             f"｜钩子价 ¥{manifest['skus']['hook']['price']}"
             f"｜全案 ¥{manifest['skus']['full']['price']}", ""]
    for sec in free_taste(plan):
        lines += [f"## {sec['chapter']} · {sec['title']}", "",
                  f"*节框架：{sec['framework']}*", "", sec["content"], ""]
    lines += ["---", "【反馈入口】读后请留一条反馈（痛点/缺口/愿付价）——"
              "反馈驱动本方案下周进化。全案与定制开发请联系作者。"]
    sku_dir.mkdir(parents=True, exist_ok=True)
    (sku_dir / "试读.md").write_text("\n".join(lines), encoding="utf-8")

    index_path = _store_dir(root) / "index.json"
    try:
        index = json.loads(index_path.read_text(encoding="utf-8"))
    except (OSError, json.JSONDecodeError):
        index = {"count": 0, "skus": []}
    rows = [row for row in index.get("skus", []) if row.get("id") != plan_id]
    rows.append({"id": plan_id, "title": manifest["title"],
                 "score": manifest["score"],
                 "hook_price": manifest["skus"]["hook"]["price"],
                 "full_price": manifest["skus"]["full"]["price"],
                 "variant": manifest["skus"]["hook"]["variant"]})
    rows.sort(key=lambda r: r["id"])
    _atomic_json(index_path, {"count": len(rows), "skus": rows,
                              "updated_at": datetime.datetime.now().isoformat(
                                  timespec="seconds")})
    return sku_dir


def funnel_stats(root) -> dict:
    """7.4 四指标快照：上架数/净进账(购买−返款)/反馈条数/定制线索。

    零数据全零（诚实占位）；账本读 M7.6 五事件格式，与价值账本同源。
    """
    index_path = _store_dir(Path(root)) / "index.json"
    skus = 0
    try:
        skus = json.loads(index_path.read_text(encoding="utf-8")).get("count", 0)
    except (OSError, json.JSONDecodeError):
        pass
    revenue = feedback = leads = 0
    for entry in Funnel(str(Path(root)))._entries():
        if entry.get("event") == "purchase":
            revenue += float(entry.get("price", 0))
        elif entry.get("event") == "feedback":
            feedback += 1
            revenue -= float(entry.get("refund", 0))
        elif entry.get("event") == "custom_lead":
            leads += 1
    return {"skus": skus, "revenue": round(revenue, 2),
            "feedback": feedback, "leads": leads, "goals": dict(GOALS)}
