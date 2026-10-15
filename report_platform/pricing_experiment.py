# -*- coding: utf-8 -*-
"""pricing_experiment — 诱饵定价三档实验部署件生成器 (百倍V3 T-021 / REQ-033).

good-better-best 三档 + best 档同价诱饵变体 + 公示式阶梯涨价:
  good   单章拆分购   ¥199      (L2, 固定价 · 走量/低价锚)
  better 全本专题报告 ¥498 起   (L3, 阶梯价 · 每售满 50 份 +10%, ¥698 封顶)
  best   企业版       ¥1,999 起 (L4, 阶梯价 · 多席位+更新流+内训)
  decoy  企业版(单人授权·无更新流) — 与 best 同价的劣势变体 (decoy effect)

实证依据 (N2 卷宗 §18, 经济学人订阅诱饵实验, Dan Ariely):
  三选项组(含同价诱饵) 84% 选高价组合; 去诱饵两选项组仅 32% (+52pp)。
  → 假设: best 旁挂同价劣势变体后, best 档选择率从 ~32% 基线显著上移。

纪律:
  - 售量只从订单库实读 (sqlite 只读 URI); 无库/无表/异常 = 0, 绝不手拍。
  - 价档锚复用 reforge_factory/superline/product_family_gen.py PRICE_ANCHORS
    (T-017 六层变现面骨架), 本件不调价——调价走「需求雷达+实验数据+用户批准」三签。
  - 本件只产 pricing_<sku>.json 部署件, 不改任何站点模板/服务文件;
    接线三步见同目录 README_PRICING.md (部署件就绪 + diff 在案 = REQ-033.AC1)。

用法:
  py pricing_experiment.py --sku EPC-BID26                # 产 content/pricing_EPC-BID26.json
  py pricing_experiment.py --sku EPC-BID26 --out-dir site # 部署时落到 site/ 供静态口
"""
from __future__ import annotations

import argparse
import json
import re
import sqlite3
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

ROOT = Path(__file__).resolve().parent
DEFAULT_DB = ROOT / "report_platform.db"
DEFAULT_OUT = ROOT / "content"

# ------------------------------------------------ 实验元数据 (REQ-033 / N2 卷宗)
EXPERIMENT = {
    "id": "decoy-good-better-best-v1",
    "req": "REQ-033 / T-021",
    "hypothesis": ("best 档旁挂同价劣势变体后, best(企业版)档选择率向 84% "
                   "基线靠拢 (无诱饵对照 32%)"),
    "baseline": {
        "with_decoy_best_share_pct": 84,
        "without_decoy_best_share_pct": 32,
        "source": ("N2_变现外部先例卷.md §18 经济学人订阅诱饵实验 "
                   "(Dan Ariely《Predictably Irrational》, MIT 学生样本)"),
    },
    "metrics": {
        "primary": "best 档选择率 = (tier_best+tier_best_decoy 事件) / 全部 tier_* 选择事件",
        "per_tier": "各档选择率 = 该档选择事件 / 全部 tier_* 选择事件",
        "events": ["tier_good", "tier_better", "tier_best", "tier_best_decoy"],
    },
    "anchors_source": ("reforge_factory/superline/product_family_gen.py "
                       "PRICE_ANCHORS (T-017 六层变现面)"),
}

# 阶梯参数 (REQ-033: 公示意阶梯涨价)
LADDER_DEFAULTS = {"step_units": 50, "step_pct": 10}

# 三档锚 (与 product_family_gen.py PRICE_ANCHORS 对齐; ladder=None=固定价)
TIER_ANCHORS: dict[str, dict] = {
    "good": {"name": "单章拆分购", "base": 199, "cap": 199, "ladder": False,
             "price_band": "¥199",
             "format": "单章 PDF + 该章断言账本摘录",
             "role": "走量档 · 低价锚"},
    "better": {"name": "全本专题报告", "base": 498, "cap": 698, "ladder": True,
               "price_band": "¥498-698",
               "format": "全本 PDF + 断言账本附录 + 更新说明",
               "role": "主力成交档 · 阶梯价"},
    "best": {"name": "企业版", "base": 1999, "cap": 10000, "ladder": True,
             "price_band": "¥1,999-10,000",
             "format": "多席位授权 + 更新流 + 内训版",
             "role": "高价锚档 · 诱饵宿主"},
}

# 同价诱饵变体: 与 best 同价但严格劣势 → best 成为占优选项
DECOY_DEF = {
    "name": "企业版（单人授权 · 无更新流）",
    "format": "单席位 PDF 授权（无更新流 · 无内训版 · 无多席位）",
    "same_price_with": "best",
    "mirror": "best",
    "inferior_to": [
        "同价但仅 1 席位（best = 多席位授权）",
        "同价但无更新流（best = 含更新流）",
        "同价但无内训版（best = 含内训版）",
    ],
    "role": "同价诱饵变体 —— 使 best 成为占优选项 (decoy effect, N2 §18)",
}

_SAFE_SKU = re.compile(r"^[A-Za-z0-9][A-Za-z0-9._-]{0,63}$")

# 已售口径: paid + partial_refunded (部分退款保留阅读权=成交仍立);
# 全额 refunded 不计。与 pay.py 退款状态机一致。
_SOLD_SQL = ("SELECT COUNT(*) FROM orders "
             "WHERE sku=? AND state IN ('paid','partial_refunded')")


def _check_sku(sku: str) -> str:
    if not _SAFE_SKU.match(sku or ""):
        raise ValueError(f"非法 sku: {sku!r} (仅字母/数字/._-)")
    return sku


# ------------------------------------------------ 阶梯涨价状态机 (纯函数)
def ladder_state(sold: int, base: int, cap: int,
                 step_units: int = LADDER_DEFAULTS["step_units"],
                 step_pct: int = LADDER_DEFAULTS["step_pct"]) -> dict:
    """售量 → 当前阶梯价状态。纯函数, 不落盘。

    steps_taken = sold // step_units (每售满 step_units 份上浮一档)
    current     = base ×(1+pct)^steps, 逐档取整到元, cap 封顶
    sold=49 → steps 0 (下一档未到, next_price_at=50)
    sold=50 → steps 1 (涨价生效)
    """
    if sold < 0:
        raise ValueError("sold 不能为负")
    if cap < base:
        raise ValueError("cap 不应低于 base")

    def _walk(steps: int) -> int:
        price = base
        for _ in range(steps):
            price = min(int(price * (100 + step_pct) / 100 + 0.5), cap)
            if price >= cap:
                return cap
        return price

    steps_taken = sold // step_units
    current = _walk(steps_taken)
    at_cap = current >= cap
    next_price = current if at_cap else _walk(steps_taken + 1)
    return {
        "sold": sold,
        "base_price": base,
        "steps_taken": steps_taken,
        "current_price": current,
        "step_units": step_units,
        "step_pct": step_pct,
        "next_price_at": (steps_taken + 1) * step_units,
        "next_price": next_price,
        "cap": cap,
        "at_cap": at_cap,
    }


def public_notice(sold: int, better: dict) -> str:
    """公示式阶梯涨价文案 (better=主力档状态)."""
    if better["at_cap"]:
        return (f"阶梯涨价公示：全本 ¥{better['base_price']} 起 · 每售满 "
                f"{better['step_units']} 份上浮 {better['step_pct']}% —— "
                f"当前已售 {sold} 份，已达封顶价 ¥{better['cap']}。")
    remain = better["next_price_at"] - sold
    return (f"阶梯涨价公示：全本 ¥{better['base_price']} 起 · 每售满 "
            f"{better['step_units']} 份上浮 {better['step_pct']}% · "
            f"¥{better['cap']} 封顶 —— 当前已售 {sold} 份，"
            f"售满 {better['next_price_at']} 份后涨至 ¥{better['next_price']}"
            f"（还差 {remain} 份）。")


# ------------------------------------------------ 售量实读 (订单库只读)
def sold_count(db_path: Path | str, sku: str) -> int:
    """订单库实读已售份数 (只读 URI 连接; 无库/无 orders 表/异常 = 0)."""
    p = Path(db_path)
    if not p.is_file():
        return 0
    try:
        con = sqlite3.connect(f"file:{p.as_posix()}?mode=ro", uri=True)
        try:
            row = con.execute(_SOLD_SQL, (sku,)).fetchone()
            return int(row[0]) if row else 0
        finally:
            con.close()
    except sqlite3.Error:
        return 0


# ------------------------------------------------ 三档结构 + 诱饵 (纯函数)
def tiers(sku: str, sold: int = 0) -> dict:
    """sku(+售量) → 三档结构 + 同价诱饵 + 阶梯状态。纯函数不落盘。

    good 固定 ¥199; better/best 按 sold 走阶梯; decoy 镜像 best 现价
    (同价不变式: decoy.price == best.price 恒成立)。
    """
    _check_sku(sku)
    out: dict[str, dict] = {}
    for key, a in TIER_ANCHORS.items():
        row = {"key": key, "name": a["name"], "price_band": a["price_band"],
               "format": a["format"], "role": a["role"],
               "base_price": a["base"]}
        if a["ladder"]:
            st = ladder_state(sold, a["base"], a["cap"])
            row["price"] = st["current_price"]
            row["ladder"] = st
        else:
            row["price"] = a["base"]
            row["ladder"] = None
        out[key] = row
    best_price = out["best"]["price"]
    out["decoy"] = {"key": "best_decoy", "name": DECOY_DEF["name"],
                    "price": best_price,
                    "same_price_with": DECOY_DEF["same_price_with"],
                    "mirror": DECOY_DEF["mirror"],
                    "format": DECOY_DEF["format"],
                    "inferior_to": list(DECOY_DEF["inferior_to"]),
                    "role": DECOY_DEF["role"]}
    return out


def build_pricing(sku: str, db_path: Path | str | None = None,
                  out_dir: Path | str | None = None) -> dict:
    """组装完整 pricing_<sku>.json 部署件并落盘 (只增)。

    db 缺席/无库 → sold=0 零态 (阶梯停在第 0 档, 绝不手拍售量)。
    返回完整 doc; 落盘路径 doc["written_to"]。
    """
    sku = _check_sku(sku)
    sold = sold_count(DEFAULT_DB if db_path is None else Path(db_path), sku)
    t = tiers(sku, sold)
    better_ladder = t["better"]["ladder"]
    doc = {
        "schema": "pricing-experiment/v1",
        "sku": sku,
        "generated": time.strftime("%Y-%m-%d %H:%M"),
        "experiment": EXPERIMENT,
        "tiers": {k: t[k] for k in ("good", "better", "best")},
        "decoy": t["decoy"],
        "ladder": {
            "sold": sold,
            "sold_source": ("report_platform.db#orders "
                            "(state IN paid,partial_refunded; 订单库只读实读)"),
            "step_units": better_ladder["step_units"],
            "step_pct": better_ladder["step_pct"],
            "next_price_at": better_ladder["next_price_at"],
            "next_price": better_ladder["next_price"],
            "public_notice": public_notice(sold, better_ladder),
        },
    }
    if out_dir is not None:
        out = Path(out_dir)
        out.mkdir(parents=True, exist_ok=True)
        pj = out / f"pricing_{sku}.json"
        pj.write_text(json.dumps(doc, ensure_ascii=False, indent=1),
                      encoding="utf-8")
        doc["written_to"] = str(pj)
    return doc


def _main(argv: list[str]) -> int:
    ap = argparse.ArgumentParser(
        description="诱饵定价三档实验部署件生成器 (T-021/REQ-033)")
    ap.add_argument("--sku", required=True, help="SKU 如 EPC-BID26")
    ap.add_argument("--db", default=str(DEFAULT_DB),
                    help="订单库路径 (只读; 缺席=售量 0)")
    ap.add_argument("--out-dir", default=str(DEFAULT_OUT),
                    help=f"输出目录 (默认 {DEFAULT_OUT})")
    ns = ap.parse_args(argv)
    doc = build_pricing(ns.sku, db_path=ns.db, out_dir=ns.out_dir)
    print(f"[pricing] sku={doc['sku']} sold={doc['ladder']['sold']} "
          f"(db={ns.db})")
    for k in ("good", "better", "best"):
        t = doc["tiers"][k]
        print(f"[pricing] {k:6} {t['name']} ¥{t['price']:,} "
              f"({t['price_band']}) — {t['role']}")
    print(f"[pricing] decoy  {doc['decoy']['name']} ¥{doc['decoy']['price']:,} "
          f"(同价劣势变体)")
    print(f"[pricing] ladder {doc['ladder']['public_notice']}")
    if "written_to" in doc:
        print(f"[pricing] → {doc['written_to']}")
    return 0


if __name__ == "__main__":
    sys.exit(_main(sys.argv[1:]))
