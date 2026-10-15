# -*- coding: utf-8 -*-
"""pricing_experiment 单测 (REQ-033/AC1, T-021) — 三档结构/同价诱饵/阶梯状态机/零态.

- 三档 good-better-best 锚价与 T-017 product_family_gen PRICE_ANCHORS 对齐
- 诱饵变体与 best 恒同价且严格劣势 (decoy effect, N2 §18: 84% vs 32%)
- 阶梯状态机: sold=49 下一档未到 / sold=50 涨价生效 / cap 封顶
- 售量只读订单库: 无库/无表=0; 只计 paid+partial_refunded
"""
from __future__ import annotations

import json
import sqlite3
import sys
import tempfile
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
import pricing_experiment as PE   # noqa: E402


def _tmp_dir() -> Path:
    return Path(tempfile.mkdtemp(prefix="px_test_"))


def _db_with_orders(path: Path, rows: list[tuple[str, str]]) -> None:
    """合成订单库: (sku, state) 列表 → orders 表."""
    con = sqlite3.connect(str(path))
    con.execute("CREATE TABLE orders(id INTEGER PRIMARY KEY, created TEXT, "
                "sku TEXT, order_no TEXT, contact TEXT, note TEXT, "
                "state TEXT DEFAULT 'pending')")
    for i, (sku, st) in enumerate(rows):
        con.execute("INSERT INTO orders(created,sku,order_no,contact,note,"
                    "state) VALUES('t',?,?, 'c','n',?)", (sku, f"NO{i}", st))
    con.commit()
    con.close()


# ------------------------------------------------ 三档结构
def test_tiers_structure_good_better_best():
    t = PE.tiers("EPC-BID26")
    assert set(k for k in t) == {"good", "better", "best", "decoy"}
    g, b, s = t["good"], t["better"], t["best"]
    assert (g["name"], g["price"]) == ("单章拆分购", 199)
    assert (b["name"], b["base_price"], b["price"]) == ("全本专题报告", 498, 498)
    assert (s["name"], s["base_price"], s["price"]) == ("企业版", 1999, 1999)
    # 价带锚与 T-017 六层一致
    assert g["price_band"] == "¥199" and b["price_band"] == "¥498-698"
    assert s["price_band"] == "¥1,999-10,000"
    # 单调: good < better < best; good 固定价无阶梯
    assert g["price"] < b["price"] < s["price"]
    assert g["ladder"] is None and b["ladder"] and s["ladder"]
    # 阶梯封顶与锚带一致
    assert b["ladder"]["cap"] == 698 and s["ladder"]["cap"] == 10000


def test_tiers_rejects_unsafe_sku():
    for bad in ("", "../etc", "A/B", "sku!", "含中文"):
        try:
            PE.tiers(bad)
            raise AssertionError(f"应拒绝: {bad!r}")
        except ValueError:
            pass


# ------------------------------------------------ 同价诱饵变体
def test_decoy_present_same_price_and_inferior():
    t = PE.tiers("EPC-BID26")
    d, s = t["decoy"], t["best"]
    assert d["key"] == "best_decoy" and d["mirror"] == "best"
    assert d["same_price_with"] == "best"
    assert d["price"] == s["price"]            # 同价不变式
    assert d["name"] == "企业版（单人授权 · 无更新流）"
    assert len(d["inferior_to"]) >= 2          # 严格劣势可枚举
    assert any("更新流" in x for x in d["inferior_to"])


def test_decoy_tracks_best_when_ladder_steps():
    """best 涨档后诱饵仍同价 (sold=100 → best 两档 1999→2199→2419)."""
    t = PE.tiers("EPC-BID26", sold=100)
    assert t["best"]["ladder"]["steps_taken"] == 2
    assert t["best"]["price"] == 2419
    assert t["decoy"]["price"] == t["best"]["price"] == 2419


# ------------------------------------------------ 阶梯涨价状态机
def test_ladder_state_machine_49_then_50():
    st49 = PE.ladder_state(49, base=498, cap=698)
    assert st49["steps_taken"] == 0                 # 下一档未到
    assert st49["current_price"] == 498
    assert st49["next_price_at"] == 50 and st49["next_price"] == 548
    assert not st49["at_cap"]

    st50 = PE.ladder_state(50, base=498, cap=698)   # 第 50 份 → 涨价生效
    assert st50["steps_taken"] == 1
    assert st50["current_price"] == 548
    assert st50["next_price_at"] == 100 and st50["next_price"] == 603


def test_ladder_steps_and_cap():
    st = PE.ladder_state(150, base=498, cap=698)    # 三档: 548→603→663
    assert (st["steps_taken"], st["current_price"]) == (3, 663)
    capped = PE.ladder_state(200, base=498, cap=698)  # 729>698 → 封顶
    assert capped["current_price"] == 698 and capped["at_cap"]
    assert capped["next_price"] == 698              # 封顶后不再涨
    for bad in ((-1, 498, 698), (0, 698, 498)):
        try:
            PE.ladder_state(*bad)
            raise AssertionError(f"应拒绝: {bad}")
        except ValueError:
            pass


def test_ladder_pct_rounds_to_yuan():
    st = PE.ladder_state(50, base=1999, cap=10000)  # 1999×1.1=2198.9→2199
    assert st["current_price"] == 2199


# ------------------------------------------------ 售量实读 (订单库只读)
def test_sold_count_zero_when_db_missing():
    assert PE.sold_count(_tmp_dir() / "nope.db", "EPC-BID26") == 0


def test_sold_count_zero_when_no_orders_table():
    d = _tmp_dir()
    p = d / "empty.db"
    con = sqlite3.connect(str(p))                   # 有库无表 → 0 不炸
    con.execute("CREATE TABLE events(id INT)")
    con.commit()
    con.close()
    assert PE.sold_count(p, "EPC-BID26") == 0


def test_sold_count_reads_paid_only():
    d = _tmp_dir()
    p = d / "orders.db"
    _db_with_orders(p, [
        ("EPC-BID26", "paid"),              # 计
        ("EPC-BID26", "pending"),           # 不计
        ("EPC-BID26", "refunded"),          # 不计
        ("EPC-BID26", "partial_refunded"),  # 计 (部分退款仍成交)
        ("OTHER-SKU", "paid"),              # 不计 (异 SKU)
    ])
    assert PE.sold_count(p, "EPC-BID26") == 2


# ------------------------------------------------ 部署件组装 + 零态
def test_build_pricing_zero_state_writes_json():
    d = _tmp_dir()
    doc = PE.build_pricing("EPC-BID26", db_path=d / "nope.db", out_dir=d)
    pj = d / "pricing_EPC-BID26.json"
    assert pj.is_file() and doc["written_to"] == str(pj)
    loaded = json.loads(pj.read_text(encoding="utf-8"))
    assert loaded["schema"] == "pricing-experiment/v1"
    assert loaded["sku"] == "EPC-BID26"
    # 零态: 无库 sold=0, 阶梯停第 0 档
    assert loaded["ladder"]["sold"] == 0
    assert loaded["tiers"]["better"]["price"] == 498
    assert loaded["ladder"]["next_price_at"] == 50
    assert loaded["ladder"]["step_pct"] == 10
    assert loaded["tiers"]["best"]["price"] == 1999
    assert loaded["decoy"]["price"] == 1999


def test_build_pricing_reads_db_and_ladder_moves():
    d = _tmp_dir()
    p = d / "orders.db"
    _db_with_orders(p, [("EPC-BID26", "paid")] * 50)
    doc = PE.build_pricing("EPC-BID26", db_path=p, out_dir=d)
    assert doc["ladder"]["sold"] == 50
    assert doc["tiers"]["better"]["price"] == 548      # 涨价生效
    assert doc["tiers"]["best"]["price"] == 2199
    assert doc["decoy"]["price"] == doc["tiers"]["best"]["price"]


# ------------------------------------------------ 公示文案 + 实验口径
def test_public_notice_is_public_and_tracks_state():
    st = PE.public_notice(49, PE.ladder_state(49, 498, 698))
    assert "已售 49" in st and "50" in st and "¥548" in st and "还差 1 份" in st
    cap = PE.public_notice(200, PE.ladder_state(200, 498, 698))
    assert "封顶" in cap and "¥698" in cap


def test_experiment_block_carries_decoy_baseline():
    doc = PE.build_pricing("EPC-BID26", db_path=None, out_dir=_tmp_dir())
    ex = doc["experiment"]
    assert ex["baseline"]["with_decoy_best_share_pct"] == 84
    assert ex["baseline"]["without_decoy_best_share_pct"] == 32
    assert "N2" in ex["baseline"]["source"]
    assert "tier_best" in ex["metrics"]["events"]
