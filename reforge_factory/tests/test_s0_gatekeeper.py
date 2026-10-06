# -*- coding: utf-8 -*-
"""S0 门卫判级器单测 — 全夹具隔离 (零真池/零真注册表/零真战役目录).

覆盖: ①枚举 ②tiered 过/挂 (EPC49 冻结数字精确断言) ③T12 单挂
④fallback 总量门 ⑤corpus-fallback 回退扫描 ⑥no-ammo ⑦共性仓腿
(锚池真数镜像 + campaign 键剔除证明) ⑧覆盖腿 (编号目录/CNKI 别名/
own: 三归位 + 孤儿不数) ⑨RETREAT 缺口非空性质 ⑩报告落 00 子目录
⑪replay (只写 replay_out/ + 零通知探针) ⑫ast 零付费机检 ⑬门参数同源.

跑法: python -X utf8 tests/test_s0_gatekeeper.py   (pytest 兼容)
"""
import ast
import json
import sys
import tempfile
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from superline import contracts as C          # noqa: E402
from superline import s0_gatekeeper as sg     # noqa: E402

_TMP = Path(tempfile.mkdtemp(prefix="s0_test_"))
_POOLROOT = _TMP / "ammo_pool"
_POOLROOT.mkdir(parents=True)


def _pool(pid, *, tiers=None, state=None):
    """在临时池根下造池; tiers 非 None 则写 tiers.json (触发 tiered 模式)."""
    d = _POOLROOT / pid
    d.mkdir(parents=True, exist_ok=True)
    if tiers is not None:
        (d / "tiers.json").write_text(
            json.dumps(tiers, ensure_ascii=False), encoding="utf-8")
    if state is not None:
        (d / "pool_state.json").write_text(
            json.dumps(state, ensure_ascii=False), encoding="utf-8")
    return d


def _patch(anchor="ANCHOR", reg=None):
    """补丁口直赋 (sibling 惯例): 池根/锚池/注册表/回放出全指临时区."""
    sg.POOL_ROOT = _POOLROOT
    sg.STOCK_ANCHOR_POOL = anchor
    sg.REPLAY_OUT = _TMP / "replay_out"
    regf = _TMP / "reg.json"
    regf.write_text(json.dumps({"channels": reg or {}}, ensure_ascii=False),
                    encoding="utf-8")
    sg.REGISTRY_PATH = regf
    return regf


def _tr(t1, t2, configured=True):
    """tier_report 夹具 (镜像 ammo_pool.tier_report 返回键)."""
    return {"t1": t1, "t2": t2, "t3": 0, "t0": 0, "n1": 0, "n2": 0,
            "n3": 0, "n0": 0, "tiers_configured": configured,
            "t3_capped": 0, "gate_chars": t1 + t2,
            "gate_ok": configured and t1 >= 3_000_000
            and t1 + t2 >= 30_000_000}


# 默认好锚池 (真 EPC49 镜像: kb 2.23G + 真共性 stock 键, campaign 键混入)
_ANCHOR_STATE = {"by_engine": {
    "kb:lark_zhiku_file": 2_236_321_911, "stock:nb_library": 30_078_896,
    "stock:zhiku": 15_810_732, "kb:ima_public": 8_809_293,
    "stock:campaign_上海电力设计": 14_044_726}}
# 默认好覆盖池 (编号目录 + CNKI 别名 + own: 三归位齐活)
_OK_ENGINES = {"20_微信文章": 5_000, "CNKI": 7_000, "own:manual": 3_000,
               "giiisp_orphan": 9_000}
_OK_REG = {"cnki": {"disposition": "dispatch", "notes": "",
                    "engine_aliases": ["CNKI"]}}


def _pass_fixture():
    _patch(anchor="ANCHOR", reg=_OK_REG)
    _pool("ANCHOR", state=_ANCHOR_STATE)
    _pool("P-OK", tiers={"T1": ["中石化"]},
          state={"by_engine": _OK_ENGINES, "total_chars": 99_999_999})
    sg._tier_report = lambda pid: _tr(47_640_193, 0)


# ------------------------------------------------ ① 枚举
def test_verdicts_enum():
    assert sg.VERDICTS == ("PASS", "RETREAT")
    assert sg.ZERO_PAID is True


# ------------------------------------------------ ② tiered 过门 (EPC50 形)
def test_tiered_pass():
    _pass_fixture()
    doc = sg.judge("中石化南京工程有限公司怎么干EPC总承包？",
                   battle="EPC50-SNEI", pool_id="P-OK")
    assert doc["verdict"] == "PASS" and doc["gaps"] == []
    a = doc["legs"]["ammo"]
    assert a["mode"] == "tiered" and a["ok"] and a["t12"] == 47_640_193
    assert doc["legs"]["coverage"]["n"] == 3


# ------------------------------------------------ ③ tiered 挂 (EPC49 冻结数字)
def test_tiered_fail_epc49_frozen_numbers():
    _pass_fixture()
    sg._tier_report = lambda pid: _tr(1_747_449, 21_547_644)
    _pool("EPC49-SEPDC", tiers={"T1": ["四川电力"]},
          state={"by_engine": _OK_ENGINES})
    doc = sg.judge("四川电力设计咨询有限责任公司怎么干EPC总承包？",
                   pool_id="EPC49-SEPDC")
    assert doc["verdict"] == "RETREAT"
    gaps = "\n".join(doc["gaps"])
    assert "弹药分层门未过: T1=1,747,449 < 3,000,000 (缺 1,252,551 字)" in gaps
    assert ("弹药分层门未过: T1+T2=23,295,093 < 30,000,000 "
            "(缺 6,704,907 字)") in gaps


# ------------------------------------------------ ④ T12 单挂 (T1 够 T12 缺)
def test_tiered_t12_only_fail():
    _pass_fixture()
    sg._tier_report = lambda pid: _tr(5_000_000, 1_000_000)
    doc = sg.judge("测试战役", pool_id="P-OK")
    gaps = "\n".join(doc["gaps"])
    assert "T1+T2=6,000,000 < 30,000,000 (缺 24,000,000 字)" in gaps
    assert "T1=5,000,000 <" not in gaps          # T1 过门不该出 T1 行


# ------------------------------------------------ ⑤ fallback 总量门 (2亿)
def test_fallback_gate():
    _pass_fixture()
    _pool("P-FB", state={"total_chars": 100_000_000,
                         "by_engine": {"a": 100_000_000}})   # 无 tiers
    doc = sg.judge("旧池战役", pool_id="P-FB")
    assert doc["legs"]["ammo"]["mode"] == "fallback"
    assert ("弹药总量门未过: 100,000,000 < 200,000,000 "
            "(缺 100,000,000 字)") in "\n".join(doc["gaps"])
    # total_chars 缺失时回退 by_engine 求和
    _pool("P-FB2", state={"by_engine": {"a": 250_000_000}})
    doc2 = sg.judge("旧池战役2", pool_id="P-FB2")
    assert doc2["legs"]["ammo"]["ok"] is True   # 弹药腿过 (挂别腿不拦断言)


# ------------------------------------------------ ⑥ corpus-fallback 回退扫描
def test_corpus_fallback():
    _pass_fixture()
    bd = _TMP / "battle_old"
    (bd / "02 初次网络调研").mkdir(parents=True)
    (bd / "02 初次网络调研" / "a.md").write_text("甲" * 1000, encoding="utf-8")
    (bd / "04 网络调研搜集的资料" / "sub").mkdir(parents=True)
    (bd / "04 网络调研搜集的资料" / "sub" / "b.txt").write_text(
        "乙" * 500, encoding="utf-8")
    (bd / "99 不算的目录").mkdir()
    (bd / "99 不算的目录" / "c.md").write_text("丙" * 9999, encoding="utf-8")
    doc = sg.judge("旧战役", battle_dir=str(bd))
    a = doc["legs"]["ammo"]
    assert a["mode"] == "corpus-fallback"
    assert a["corpus_chars"] == 1500 and a["corpus_files"] == 2  # 99 目录不算
    assert ("战役语料回退门未过: 语料 1,500 字 (扫描 2 文件) < 200,000,000 "
            "(缺 199,998,500 字)") in "\n".join(doc["gaps"])


# ------------------------------------------------ ⑦ no-ammo
def test_no_ammo():
    _pass_fixture()
    doc = sg.judge("空战役", battle_dir="")
    a = doc["legs"]["ammo"]
    assert a["mode"] == "no-ammo" and a["ok"] is False
    assert "无弹药证据: 池缺失且战役目录不可读" in doc["gaps"]


# ------------------------------------------------ ⑧ 共性仓腿: campaign 键剔除
def test_stock_anchor_excludes_campaign_keys():
    _pass_fixture()
    leg = sg._leg_stock("")
    # 真锚池镜像: campaign 键 14,044,726 被剔除, 其余四键合计
    expect = (2_236_321_911 + 30_078_896 + 15_810_732 + 8_809_293)
    assert leg["ok"] and leg["stock_chars"] == expect
    assert "stock:campaign_上海电力设计" not in leg["keys"]
    # 只有 campaign 键 → 共性 0 → 挂 (剔键证明)
    _pool("ONLY-CAMPAIGN", state={"by_engine": {
        "stock:campaign_上海电力设计": 100_000_000}})
    _patch(anchor="ONLY-CAMPAIGN")
    leg2 = sg._leg_stock("")
    assert leg2["ok"] is False and leg2["stock_chars"] == 0
    assert ("共性库存量仓未达标: 锚池 ONLY-CAMPAIGN 共性键 0 < 30,000,000 "
            "(缺 30,000,000 字)") in leg2["gaps"]


# ------------------------------------------------ ⑨ 覆盖腿: 三归位 + 孤儿
def test_coverage_three_resolutions():
    _pass_fixture()
    leg = sg._leg_coverage("P-OK", "")
    assert sorted(leg["engines"]) == ["20_微信文章", "CNKI", "own:manual"]
    assert leg["ok"] and leg["n"] == 3            # 孤儿 giiisp 不数
    # 摘掉 own: 只剩 2 → 挂
    _pool("P-THIN", state={"by_engine": {"20_微信文章": 5, "CNKI": 7}})
    leg2 = sg._leg_coverage("P-THIN", "")
    assert leg2["ok"] is False and leg2["n"] == 2
    assert ("渠道覆盖不足: 有效引擎 2 < 3 (20_微信文章, CNKI)"
            ) in leg2["gaps"]
    # 注册表缺 CNKI 别名 → 只剩编号目录 1 条
    _patch(anchor="ANCHOR", reg={})
    sg.POOL_ROOT = _POOLROOT
    leg3 = sg._leg_coverage("P-THIN", "")
    assert leg3["n"] == 1                          # CNKI 失映射


# ------------------------------------------------ ⑩ RETREAT 缺口非空性质
def test_retreat_gaps_always_nonempty():
    _pass_fixture()
    sg._tier_report = lambda pid: _tr(1_747_449, 21_547_644)
    bd = _TMP / "battle_prop"
    (bd / "02 x").mkdir(parents=True)
    (bd / "02 x" / "a.md").write_text("x", encoding="utf-8")
    scenes = [
        sg.judge("挂腿A", pool_id="P-OK"),                    # tiered 挂
        sg.judge("挂腿A2", pool_id="P-FB"),                   # fallback 挂
        sg.judge("挂腿A3", battle_dir=str(bd)),               # corpus 挂
        sg.judge("挂腿A4"),                                   # no-ammo
    ]
    for doc in scenes:
        assert doc["verdict"] == "RETREAT"
        assert len(doc["gaps"]) >= 1, doc["battle"]


# ------------------------------------------------ ⑪ 报告落 00 子目录 / 战役根
def test_report_lands_in_00_subdir():
    doc = {"schema": "s0_gatekeeper_v1", "battle": "X", "title": "t",
           "verdict": "RETREAT",
           "legs": {"ammo": {"ok": False, "mode": "no-ammo"},
                    "corpus_stock": {"ok": True, "stock_chars": 1,
                                     "floor": 30_000_000, "anchor": "A"},
                    "coverage": {"ok": True, "n": 3, "engines": []}},
           "gaps": ["g1"], "gate_params": C.gate_defaults(),
           "zero_paid": True, "version": "0.1.0"}
    bd = _TMP / "battleA"
    (bd / "00 研究报告需求").mkdir(parents=True)
    out = sg.render(doc, battle_dir=str(bd))
    assert out == bd / "00 研究报告需求"
    assert (out / "s0_gatekeeper.json").is_file()
    assert "缺口清单" in (out / "s0_gatekeeper.md").read_text(encoding="utf-8")
    bd2 = _TMP / "battleB"                          # 无 00 子目录 → 战役根
    bd2.mkdir()
    assert sg.render(doc, battle_dir=str(bd2)) == bd2


# ------------------------------------------------ ⑫ replay: 只写 replay_out
def test_replay_logic():
    _pass_fixture()
    bd = _TMP / "battle_small"
    (bd / "02 初次网络调研").mkdir(parents=True)
    (bd / "02 初次网络调研" / "a.md").write_text("x" * 100, encoding="utf-8")
    mf = _TMP / "mini_manifest.json"
    mf.write_text(json.dumps({
        "battles": [
            {"battle": "P-OK", "title": "甲", "battle_dir": str(bd),
             "pool": "P-OK", "ground_truth": {"ammo_met": True}},
            {"battle": "R-1", "title": "乙", "battle_dir": str(bd),
             "pool": "", "ground_truth": {"ammo_met": False}},
            {"battle": "R-2", "title": "丙", "battle_dir": "",
             "pool": "", "ground_truth": {"ammo_met": False}}],
        "bar": {"min_consistency": 2}}, ensure_ascii=False), encoding="utf-8")

    def _boom(doc):        # 通知探针: replay 永不通知, 调用即炸
        raise AssertionError("replay 不得发通知")
    sg.notify_retreat = _boom
    rc = sg.replay(str(mf))                          # 探针被调会直接抛
    assert rc == 0
    out = _TMP / "replay_out"
    assert (out / "P-OK" / "s0_gatekeeper.json").is_file()
    j = json.loads((out / "R-1" / "s0_gatekeeper.json").read_text(
        encoding="utf-8"))
    assert j["verdict"] == "RETREAT" and j["gaps"]
    summary = json.loads((out / "replay_summary.json").read_text(
        encoding="utf-8"))
    assert summary["consistent"] == 3 and summary["retreat_gaps_ok"] is True
    # 真战役目录零污染: battle_small 下只有夹具自建文件
    assert not (bd / "s0_gatekeeper.json").exists()
    assert not any(p.name.startswith("s0_")
                   for p in bd.rglob("*") if p.is_file())


# ------------------------------------------------ ⑬ ast 零付费机检
def test_zero_paid_no_network_imports():
    src = Path(sg.__file__).read_text(encoding="utf-8")
    mods = set()
    for node in ast.walk(ast.parse(src)):
        if isinstance(node, ast.Import):
            mods.update(a.name.split(".")[0] for a in node.names)
        elif isinstance(node, ast.ImportFrom) and node.module:
            mods.add(node.module.split(".")[0])
    banned = {"urllib", "requests", "httpx", "curl_cffi", "socket"}
    assert not (mods & banned), f"判级器禁网络根模块: {mods & banned}"


# ------------------------------------------------ ⑭ 门参数动态同源
def test_gate_params_same_source():
    gp = C.gate_defaults()
    assert set(gp) == {"t1_min_chars", "t12_min_chars",
                       "t3_cap_chars", "fallback_total_chars"}
    assert (gp["t1_min_chars"], gp["t12_min_chars"], gp["t3_cap_chars"],
            gp["fallback_total_chars"]) == (3_000_000, 30_000_000,
                                            50_000_000, 200_000_000)
    _pass_fixture()
    doc = sg.judge("同源", pool_id="P-OK")
    assert doc["gate_params"] == gp           # doc 快照与 contracts 全等


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
