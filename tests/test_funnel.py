"""M11 漏斗三段 + 定价实验 TDD（PROPOSAL_V2.md 7.3/7.4）。

三段：¥9.8-19.8 钩子（试读 20%+反馈入口）→ ¥198-498 全案 → 定制线索。
定价实验：plan_id 哈希稳定分 A/B 桶（A=低价位，B=高价位）。
红线：全案成品只留 data/（本地），商店目录只放 manifest+试读（付费内容
不上公开仓库）。
"""
import json

from paistation.foundry.funnel import (
    FUNNEL,
    Funnel,
    assign_variant,
    free_taste,
    funnel_stats,
    make_skus,
    variant_price,
    write_sku,
)


def _plan(n_sections=10):
    chapters = []
    per_chapter = [n_sections - n_sections // 2, n_sections // 2]
    for c in range(2):
        chapters.append({
            "title": f"第{c + 1}章 治理", "framework": "诊断→机会→路线",
            "sections": [{"title": f"{c + 1}.{i + 1} 节", "framework": "5W1H",
                          "components": ["key_points"], "content": f"内容{c}-{i}"}
                         for i in range(per_chapter[c])]})
    return {"title": "EPC 风险方案", "chapters": chapters,
            "score": 71, "passed": True}


# ---------------------------------------------------------------- 定价实验

def test_variant_stable_and_priced_in_band():
    assert assign_variant("epc-fde-ai") == assign_variant("epc-fde-ai")
    for plan_id in ("a", "b", "epc", "zeng", "x9"):
        v = assign_variant(plan_id)
        assert v in ("A", "B")
        lo, hi = FUNNEL["hook"]
        assert lo <= variant_price(FUNNEL["hook"], v) <= hi
        lo, hi = FUNNEL["full"]
        assert lo <= variant_price(FUNNEL["full"], v) <= hi


def test_variant_a_low_b_high():
    assert variant_price(FUNNEL["hook"], "A") == 9.8
    assert variant_price(FUNNEL["hook"], "B") == 19.8
    assert variant_price(FUNNEL["full"], "A") == 198
    assert variant_price(FUNNEL["full"], "B") == 498


# ---------------------------------------------------------------- 试读 20%

def test_free_taste_twenty_percent_min_one():
    taste = free_taste(_plan(10))                 # 10 节 → 2 节
    assert len(taste) == 2
    assert taste[0]["content"].startswith("内容")
    assert free_taste(_plan(1))                   # 1 节 → 至少 1 节
    one = free_taste(_plan(1))
    assert len(one) == 1


# ---------------------------------------------------------------- SKU

def test_make_skus_three_tiers():
    plan = _plan()
    manifest = make_skus(plan, plan_id="epc-x")
    assert set(manifest["skus"]) == {"hook", "full", "custom"}
    assert manifest["skus"]["custom"]["price"] == "面议"
    assert manifest["skus"]["hook"]["taste_sections"] == len(free_taste(plan))
    assert manifest["score"] == 71


# ---------------------------------------------------------------- 落盘 + 商店

def test_write_sku_manifest_taste_index_no_full_leak(tmp_path):
    plan = _plan()
    write_sku(tmp_path, plan, plan_id="epc-x")
    store = tmp_path / "09 发布" / "store"
    sku_dir = store / "epc-x"
    manifest = json.loads((sku_dir / "manifest.json").read_text(encoding="utf-8"))
    assert manifest["title"] == "EPC 风险方案"
    taste = (sku_dir / "试读.md").read_text(encoding="utf-8")
    assert "内容0-0" in taste and "反馈" in taste       # 试读含正文+反馈入口
    assert not list(sku_dir.glob("plan.json"))          # 全案不进商店目录
    index = json.loads((store / "index.json").read_text(encoding="utf-8"))
    assert index["count"] == 1 and index["skus"][0]["id"] == "epc-x"


def test_store_index_accumulates(tmp_path):
    write_sku(tmp_path, _plan(), plan_id="p1")
    write_sku(tmp_path, _plan(), plan_id="p2")
    index = json.loads(
        (tmp_path / "09 发布" / "store" / "index.json")
        .read_text(encoding="utf-8"))
    assert index["count"] == 2


# ---------------------------------------------------------------- 账本+指标

def test_track_events_and_stats_7_4(tmp_path):
    f = Funnel(str(tmp_path))
    f.track("purchase", "p1", price=198)
    f.track("purchase", "p2", price=9.8)
    f.track("feedback", "p1", refund=0)
    f.track("custom_lead", "p1", contact="企微")
    write_sku(tmp_path, _plan(), plan_id="p1")
    stats = funnel_stats(tmp_path)
    assert stats["revenue"] == 207.8
    assert stats["feedback"] == 1 and stats["leads"] == 1
    assert stats["skus"] == 1
    assert stats["goals"] == {"skus": 20, "revenue": 10000,
                              "feedback": 60, "leads": 3}


def test_stats_zero_state_honest(tmp_path):
    stats = funnel_stats(tmp_path)
    assert stats["revenue"] == 0 and stats["feedback"] == 0
    assert stats["skus"] == 0
