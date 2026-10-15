# -*- coding: utf-8 -*-
"""product_family_gen 单测 — 六层变现面 SKU 骨架生成器 (T-017 / REQ-031).

覆盖: ①合成 corpus_stats → 六层全在 ②价格带=默认锚 (¥0/9.9/199/498-698/
1999-10000/议价) + 调价三签 note ③徽章==实数对拍 (每个数字都可回溯到
corpus_stats, 零手拍) ④缺 stats 字段 → null 如实不造假 ⑤read_corpus_stats
真读 pool_state/question_tree/independence/framework + 空池全 null
⑥落盘 json+md (六层表) + tiers 兼容键 ⑦纯函数不突变 ⑧ast 零网络根模块.
"""
from __future__ import annotations

import ast
import copy
import json
import sys
import tempfile
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from superline import product_family_gen as PF            # noqa: E402


STATS = {"t1_chars": 28_338_760, "items": 5279, "eei_count": 560,
         "independent_sources": 9, "chapters": 15}
EXP = {"T1语料万字": 2834, "在档条目": 5279, "EEI数": 560,
       "独立源数": 9, "章数": 15}          # 28,338,760 → round → 2834 万字


# ------------------------------------------------ ① 六层全在
def test_01_six_layers_present():
    d = PF.gen("EPC-BID26", dict(STATS))
    assert d["campaign"] == "EPC-BID26"
    layers = d["layers"]
    assert [L["layer"] for L in layers] == ["L0", "L1", "L2", "L3", "L4", "L5"]
    for L in layers:
        for key in ("layer", "name", "price_band", "format",
                    "sample_hook", "badges"):
            assert L.get(key) is not None, f"{L.get('layer')} 缺 {key}"
        assert isinstance(L["badges"], dict) and L["badges"]


# ------------------------------------------------ ② 价格带=默认锚
def test_02_price_bands():
    d = PF.gen("C", dict(STATS))
    by = {L["layer"]: L for L in d["layers"]}
    assert by["L0"]["price"] == 0 and by["L0"]["price_band"] == "¥0"
    assert by["L1"]["price"] == 9.9 and by["L1"]["price_band"] == "¥9.9"
    assert by["L2"]["price"] == 199 and by["L2"]["price_band"] == "¥199"
    assert (by["L3"]["price_lo"], by["L3"]["price_hi"]) == (498, 698)
    assert by["L3"]["price_band"] == "¥498-698"
    assert (by["L4"]["price_lo"], by["L4"]["price_hi"]) == (1999, 10000)
    assert by["L4"]["price_band"] == "¥1,999-10,000"
    assert by["L5"]["price"] is None            # 订阅/定制 = 议价线索
    assert "议价" in by["L5"]["price_band"]
    for kw in ("需求雷达", "实验数据", "用户批准"):
        assert kw in d["price_note"], kw        # 调价三签
    assert d["price_anchors"]["L3"]["price_hi"] == 698


# ------------------------------------------------ ③ 徽章==实数对拍 (零手拍)
def test_03_badges_match_stats():
    d = PF.gen("C", dict(STATS))
    for L in d["layers"]:
        for k, v in L["badges"].items():
            assert v == EXP[k], f"{L['layer']}.{k}={v} != 实数 {EXP[k]}"
    by = {L["layer"]: L for L in d["layers"]}
    assert "2834" in by["L0"]["sample_hook"]                    # 万字语料
    assert "560" in by["L1"]["sample_hook"]                     # EEI 实数
    assert "15 章" in by["L2"]["sample_hook"]
    assert "15 章" in by["L3"]["sample_hook"] \
        and "9 个独立源" in by["L3"]["sample_hook"]
    assert "5279" in by["L4"]["sample_hook"] and "2834" in by["L4"]["sample_hook"]
    assert "560" in by["L5"]["sample_hook"]
    d2 = PF.gen("C", dict(STATS))                               # 重算一致=可对账
    d2.pop("generated"), d.pop("generated")
    assert d == d2


# ------------------------------------------------ ④ 缺 stats 字段 → null 不造假
def test_04_missing_stats_null():
    none_stats = {k: None for k in STATS}
    d = PF.gen("C", dict(none_stats))
    for L in d["layers"]:
        assert all(v is None for v in L["badges"].values()), \
            f"{L['layer']} 缺账字段必须 null, 得 {L['badges']}"
    joined = json.dumps(d, ensure_ascii=False)
    for fabricated in ("560", "5279", "2834", "15 章", "9 个独立源"):
        assert fabricated not in joined, fabricated        # 不冒充实数
    for L in d["layers"]:                                   # 钩子如实降级
        assert "不标数" in L["sample_hook"] or "点亮" in L["sample_hook"], \
            L["sample_hook"]


# ------------------------------------------------ ⑤ read_corpus_stats 真读
def test_05_read_corpus_stats():
    tmp = Path(tempfile.mkdtemp(prefix="pfg_test_"))
    pool = tmp / "pool" / "CAMP"
    pool.mkdir(parents=True)
    (pool / "pool_state.json").write_text(json.dumps(
        {"total_chars": 12345678, "items": 4321}), encoding="utf-8")
    (pool / "question_tree.json").write_text(json.dumps(
        {"stats": {"subquestions": 20, "eeis": 77, "queries": 210}}),
        encoding="utf-8")
    (pool / "independence.json").write_text(json.dumps(
        {"per_eei": {"E1": {"independent_n": 5}, "E2": {"independent_n": 11}}}),
        encoding="utf-8")
    battle = tmp / "battle"
    battle.mkdir()
    (battle / "framework.json").write_text(json.dumps(
        {"chapters": [{"id": f"ch{i:02d}"} for i in range(10)]}),
        encoding="utf-8")
    st = PF.read_corpus_stats(pool, battle)
    assert st["t1_chars"] == 12345678 and st["items"] == 4321
    assert st["eei_count"] == 77
    assert st["independent_sources"] == 11            # max per-EEI 独立源
    assert st["chapters"] == 10
    for field, anchor in PF.SOURCE_ANCHORS.items():
        assert anchor in st["sources"][field], field  # 对账锚齐
    # 无树无账 (BID26 形): 只读得到 pool_state, 其余如实 null
    bare = tmp / "pool" / "BARE"
    bare.mkdir(parents=True)
    (bare / "pool_state.json").write_text(json.dumps(
        {"total_chars": 12345678, "items": 4321}), encoding="utf-8")
    st2 = PF.read_corpus_stats(bare)
    assert st2["t1_chars"] == 12345678 and st2["items"] == 4321
    assert st2["eei_count"] is None and st2["chapters"] is None
    assert st2["independent_sources"] is None
    # 空池 → 全 null
    empty = tmp / "empty"
    empty.mkdir()
    st3 = PF.read_corpus_stats(empty)
    assert all(st3[k] is None for k in
               ("t1_chars", "items", "eei_count",
                "independent_sources", "chapters"))


# ------------------------------------------------ ⑥ 落盘 json+md + tiers 兼容键
def test_06_outputs_written():
    tmp = Path(tempfile.mkdtemp(prefix="pfg_out_"))
    d = PF.gen("EPC-BID26", dict(STATS))
    pj, pm = PF.write(d, tmp)
    assert pj.name == "product_family_EPC-BID26.json"
    assert pm.name == "product_family_EPC-BID26.md"
    d2 = json.loads(pj.read_text(encoding="utf-8"))
    assert d2 == json.loads(json.dumps(d))            # 落盘=内存 (JSON 干净)
    assert d2["tiers"] == d2["layers"]                # taskgraph verify 兼容键
    md = pm.read_text(encoding="utf-8")
    for L in d["layers"]:                             # 六层表逐层在
        assert L["name"] in md and L["price_band"] in md
    assert md.count("\n| L") >= 6
    assert "¥498-698" in md and "¥1,999-10,000" in md
    assert "null" in json.dumps(                      # 缺账渲染 null 如实
        PF.gen("C", {k: None for k in STATS}), ensure_ascii=False)


# ------------------------------------------------ ⑦ 纯函数不突变
def test_07_no_mutation():
    snap = copy.deepcopy(STATS)
    anchors_snap = copy.deepcopy(PF.PRICE_ANCHORS)
    PF.gen("C", dict(STATS))
    assert STATS == snap                              # 入参不被突变
    assert PF.PRICE_ANCHORS == anchors_snap           # 锚表不被改写
    d = PF.gen("C", dict(STATS))
    assert isinstance(d["corpus_stats"]["t1_chars"], int)
    assert d["corpus_stats"]["eei_count"] == 560      # 原始实数随行


# ------------------------------------------------ ⑧ ast 零网络机检
def test_08_ast_no_network():
    tree = ast.parse(Path(PF.__file__).read_text(encoding="utf-8"))
    mods = set()
    for n in ast.walk(tree):
        if isinstance(n, ast.Import):
            mods.update(a.name.split(".")[0] for a in n.names)
        elif isinstance(n, ast.ImportFrom) and n.module:
            mods.add(n.module.split(".")[0])
    assert not (mods & {"urllib", "requests", "httpx", "curl_cffi",
                        "socket"}), f"网络根模块混入: {mods}"


if __name__ == "__main__":
    fns = [v for k, v in sorted(globals().items())
           if k.startswith("test_") and callable(v)]
    fail = 0
    for fn in fns:
        try:
            fn()
            print(f"  PASS {fn.__name__}")
        except Exception as e:
            fail += 1
            print(f"  FAIL {fn.__name__}: {type(e).__name__}: {e}")
    print(f"\n{len(fns) - fail}/{len(fns)} passed")
    sys.exit(1 if fail else 0)
