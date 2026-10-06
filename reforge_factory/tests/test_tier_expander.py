# -*- coding: utf-8 -*-
"""S0-2 词表生成器单测 — 全夹具隔离 (零真池/零真战役目录/零网络).

覆盖: ①枚举/预算 ②报告名提取 ③规则变体链 (EPC50/EPC49/中冶长天 三锚)
④存量挖掘四门 (共现门/停用门/频次门/缩略词停用) ⑤六槽诚实语义
(查无=词空) ⑥online 腿可注入且离线绝不触 ⑦prior_t2 排除自家池
⑧落盘只写 tiers_draft (绝不写 tiers.json) ⑨replay 过/挂双路
⑩ast 零付费机检 ⑪entity_seed (FT-6 底座) 接线.

跑法: python -X utf8 tests/test_tier_expander.py   (pytest 兼容)
"""
import ast
import json
import sys
import tempfile
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from superline import tier_expander as te   # noqa: E402

_TMP = Path(tempfile.mkdtemp(prefix="s02_test_"))
_POOLROOT = _TMP / "ammo_pool"
_POOLROOT.mkdir(parents=True)
_REPLAY_OUT = _TMP / "replay_out_tier"


def _patch():
    """补丁口直赋 (sibling 惯例): 池根/回放出全指临时区."""
    te.POOL_ROOT = _POOLROOT
    te.REPLAY_OUT = _REPLAY_OUT


def _pool(pid, tiers=None, manifest_lines=()):
    d = _POOLROOT / pid
    d.mkdir(parents=True, exist_ok=True)
    if tiers is not None:
        (d / "tiers.json").write_text(
            json.dumps(tiers, ensure_ascii=False), encoding="utf-8")
    if manifest_lines:
        (d / "manifest.jsonl").write_text(
            "\n".join(manifest_lines), encoding="utf-8")
    return d


def _battle(bid, *, config=None, keywords=None, corpus=()):
    """临时战役目录: config/keywords/04 语料文件名 (不读正文)."""
    bd = _TMP / bid
    bd.mkdir(parents=True, exist_ok=True)
    if config is not None:
        (bd / "research_config.json").write_text(
            json.dumps(config, ensure_ascii=False), encoding="utf-8")
    if keywords is not None:
        (bd / "search_keywords.json").write_text(
            json.dumps(keywords, ensure_ascii=False), encoding="utf-8")
    d04 = bd / "04 网络调研搜集的资料"
    d04.mkdir(exist_ok=True)
    for f in corpus:
        (d04 / f).touch()
    return bd


# ------------------------------------------------ ① 枚举/预算
def test_constants():
    assert len(te.SIX_SLOTS) == 6 and te.SIX_SLOTS[0] == "company"
    assert te.ZERO_PAID is True
    assert te.TIME_BUDGET_SEC == 30 * 60     # 验收: 单战役 <30min
    assert te.ALIAS_FREQ_MIN == 2


# ------------------------------------------------ ② 报告名 → 企业全称
def test_extract_company_name():
    assert te.extract_company_name(
        "《中石化南京工程有限公司怎么干EPC总承包？》") == "中石化南京工程有限公司"
    assert te.extract_company_name(
        "四川电力设计咨询有限责任公司如何做EPC？") == "四川电力设计咨询有限责任公司"
    assert te.extract_company_name(
        "中冶长天国际工程有限责任公司") == "中冶长天国际工程有限责任公司"  # 透传


# ------------------------------------------------ ③ 规则变体链 (三战役锚)
def test_name_variants_epc50_chain():
    vs = {v["word"]: v["rule"] for v in te.name_variants("中石化南京工程有限公司")}
    assert vs["中石化南京工程有限公司"] == "rule:full"
    assert vs["中石化南京工程"] == "rule:legal-strip"
    assert vs["中石化南京"] == "rule:tail-strip"
    assert vs["南京工程有限公司"] == "rule:prefix-drop-3"   # 中石化|南京工程 形
    assert all(len(w) >= 4 for w in vs)                      # 链剥最短保留


def test_name_variants_epc49_chain():
    vs = {v["word"] for v in te.name_variants("四川电力设计咨询有限责任公司")}
    # 设计咨询=复合尾词整剥 (长在前): …设计咨询 → 四川电力, 无 设计 中间态
    assert {"四川电力设计咨询有限责任公司", "四川电力设计咨询",
            "四川电力"} <= vs


def test_name_variants_zhychangtian_chain():
    vs = {v["word"] for v in te.name_variants("中冶长天国际工程有限责任公司")}
    assert {"中冶长天国际工程有限责任公司", "中冶长天国际工程",
            "中冶长天国际", "中冶长天"} <= vs


# ------------------------------------------------ ④ 存量挖掘四门
def test_mine_aliases_gates():
    _patch()
    variants = te.name_variants("中石化南京工程有限公司")
    anchor = "《中石化南京工程有限公司怎么干EPC总承包？》"
    pfx = f"E:/x/{anchor}/04/20_微信文章/"
    lines = [
        f'{{"source_path": "{pfx}SNEI Wins 2024 PMI Award.md"}}',
        f'{{"source_path": "{pfx}中石化南京工程 SNEI 中标复盘.md"}}',
        f'{{"source_path": "{pfx}中石化胜利电站投产.md"}}',       # 文件名 freq=1
        '{"source_path": "E:/裁判文书/被告四川中石化集团纠纷判决书.md"}',
        '{"source_path": "E:/裁判文书/被告四川中石化集团裁定书2.md"}',
        '{"source_path": "E:/NB卷/宏观/GDP 与 PMI 展望.md"}',      # 无共现 → 门外
    ]
    mf = _TMP / "m_gates.jsonl"
    mf.write_text("\n".join(lines), encoding="utf-8")
    out = te.mine_aliases(variants, [mf], [], battle_anchor=anchor)
    acro = dict(out["acronyms_battle"] + out["acronyms_pool"])
    cjk = dict(out["cjk_battle"] + out["cjk_pool"])
    assert dict(out["acronyms_battle"]).get("SNEI") == 2   # 战役桶 (含锚)
    assert not ({"PMI", "GDP", "EPC", "EP"} & set(acro))   # 停用∪门外
    assert cjk.get("中石化南京工程", 0) >= 3                # 目录+文件名命中
    assert cjk.get("中石化集团", 0) == 2                    # 池桶: 母公司信号
    assert "中石化南京工程有" not in cjk                    # 变体左截断弃
    assert "中石化胜利" not in cjk                          # 频次门: 仅 1 次不进
    assert not any(("被告" in w) or ("判决" in w) or ("裁定" in w)
                   for w in cjk)                           # 司法停用门
    assert all("中石" in w for w in cjk)                   # 共现门不变式
    assert not any(("怎么干" in w) or ("总承包" in w) or ("公司" in w)
                   for w in cjk), list(cjk)[:8]            # 停用门不变式


# ------------------------------------------------ ④b 加权类: 组织尾/机构邻接
def test_mine_ranking_orgtail_and_adjacency():
    _patch()
    variants = te.name_variants("四川电力设计咨询有限责任公司")
    toks = [a + b for a in "甲乙丙丁戊己" for b in "子丑寅卯辰巳"]  # 36 组
    lines = [f'{{"source_path": "E:/p/四川{t}充数语料.md"}}'
             for t in toks for _ in range(2)]              # 高频非组织尾噪声
    lines += ['{"source_path": "E:/p/四川院 数字化转型.md"}'] * 5
    lines += ['{"source_path": "E:/p/中电建四川院 RPA 落地.md"}'] * 2
    lines += ['{"source_path": "E:/p/四川电力SEDC公司 战略合作.md"}'] * 3
    lines += ['{"source_path": "E:/p/四川电力PPT 行业大会分享.md"}'] * 8
    mf = _TMP / "m_rank.jsonl"
    mf.write_text("\n".join(lines), encoding="utf-8")
    out = te.mine_aliases(variants, [mf], [])
    cjk = [w for w, f in out["cjk_pool"]]
    assert "四川院" in cjk and "中电建四川院" in cjk   # 组织尾加权挤进帽内
    order = [w for w, f in out["acronyms_pool"]]
    assert "SEDC" in order and "PPT" in order
    assert order.index("SEDC") < order.index("PPT")     # 机构邻接加权在前


def test_mine_acronym_adjacency_freq1_enters():
    """机构邻接缩略词频次1也进门 (EPC49 真坑: SEDC公司 仅 1 次论文标题)."""
    _patch()
    variants = te.name_variants("四川电力设计咨询有限责任公司")
    anchor = "《四川电力设计咨询有限责任公司怎么干EPC总承包？》"
    lines = ['{"source_path": "E:/p/《四川电力设计咨询有限责任公司怎么干EPC总承包？》'
             '/02/输变电工程EPC总承包模式研究——以SEDC公司水电站项目为例.pdf"}',
             '{"source_path": "E:/p/' + anchor + '/02/四川电力 PPT 大会分享1.md"}',
             '{"source_path": "E:/p/' + anchor + '/02/四川电力 PPT 大会分享2.md"}']  # 泛词频次2
    mf = _TMP / "m_adj1.jsonl"
    mf.write_text("\n".join(lines), encoding="utf-8")
    out = te.mine_aliases(variants, [mf], [], battle_anchor=anchor)
    battle_acro = dict(out["acronyms_battle"])
    assert battle_acro.get("SEDC") == 1            # 邻接加权: 频次1进门
    order = [w for w, f in out["acronyms_battle"]]
    assert order.index("SEDC") < order.index("PPT")  # 加权类排泛词前
    assert "EP" not in battle_acro                  # 无邻接短缩略仍拦


# ------------------------------------------------ ⑤ 六槽诚实语义
def test_expand_slots_honesty_offline():
    _patch()
    _pool("OTHER", tiers={"T1": ["x"], "T2": ["外部竞对甲", "外部竞对乙"]})
    bd = _battle("battleA",
                 config={"research_target": "中石化南京工程有限公司",
                         "flagship_projects": ["宁波乙烯项目"],
                         "competitors": ["中石化洛阳工程"]},
                 corpus=("中石化南京工程 一.md", "中石化南京工程 二.md"))
    doc = te.expand("《中石化南京工程有限公司怎么干EPC总承包？》",
                    battle="battleA", battle_dir=str(bd), pool_id="P1")
    assert set(doc["slots"]) == set(te.SIX_SLOTS)
    for s in te.SIX_SLOTS:                             # 非空即填/查无必空
        slot = doc["slots"][s]
        assert slot["status"] in ("filled", "查无")
        assert (slot["status"] == "filled") == bool(slot["words"])
    assert doc["slots"]["company"]["status"] == "filled"
    assert doc["slots"]["flagship_projects"]["words"][0]["word"] == "宁波乙烯项目"
    comp = {w["word"]: w["source"] for w in doc["slots"]["competitors"]["words"]}
    assert comp["中石化洛阳工程"].startswith("config")
    assert comp["外部竞对甲"] == "prior_tiers:OTHER.T2"
    assert doc["honest_empty"] == ["former_names", "subsidiaries"]
    assert doc["zero_paid"] is True
    got = set(doc["t1_draft"])                         # 规则四变体全覆盖
    assert {"中石化南京工程有限公司", "中石化南京工程", "中石化南京",
            "南京工程有限公司"} <= got
    assert doc["elapsed_sec"] < te.TIME_BUDGET_SEC


# ------------------------------------------------ ⑥ online 腿: 可注入·离线不触
def test_online_leg_injected_and_offline_never_touches():
    _patch()
    bd = _battle("battleB")                            # 无 config → 多槽查无
    calls = []

    def _fake(q):
        calls.append(q)
        return ["东方化工设计院"] if "子公司" in q else ["某集团"]
    orig = te._free_search
    te._free_search = _fake
    try:
        doc = te.expand("《中石化南京工程有限公司怎么干EPC总承包？》",
                        battle_dir=str(bd), online=True)
        assert calls and any("母公司" in q for q in calls)
        assert doc["slots"]["parent"]["status"] == "filled"
        assert doc["slots"]["parent"]["words"][0]["source"] == "free_search"
        assert "parent" not in doc["honest_empty"]
        calls.clear()
        te.expand("《中石化南京工程有限公司怎么干EPC总承包？》",
                  battle_dir=str(bd), online=False)
        assert not calls                               # 离线绝不触检索腿
    finally:
        te._free_search = orig


# ------------------------------------------------ ⑦ prior_t2 排除自家池
def test_prior_t2_excludes_own_pool():
    _patch()
    _pool("OTHER", tiers={"T2": ["外部竞对"]})
    _pool("OWN", tiers={"T2": ["自家竞对"]})
    doc = te.expand("《中石化南京工程有限公司怎么干EPC总承包？》", pool_id="OWN")
    words = [w["word"] for w in doc["slots"]["competitors"]["words"]]
    assert "外部竞对" in words and "自家竞对" not in words   # 防自证


# ------------------------------------------------ ⑧ 落盘: 只写草稿不写真词表
def test_render_writes_draft_never_real_tiers():
    _patch()
    bd = _battle("battleC", config={"flagship_projects": ["p1"]})
    (bd / "00 研究报告需求").mkdir()
    doc = te.expand("《中石化南京工程有限公司怎么干EPC总承包？》")
    out = te.render(doc, battle_dir=str(bd))
    assert out == bd / "00 研究报告需求"
    assert (out / "tiers_draft.json").is_file()
    assert "人工过目定稿" in (out / "tiers_draft.md").read_text(encoding="utf-8")
    r = te.render(doc, battle="battleC", replay_mode=True)
    assert r == _REPLAY_OUT / "battleC"
    assert not any(p.name == "tiers.json"
                   for p in list(bd.rglob("*")) + list(_REPLAY_OUT.rglob("*")))


# ------------------------------------------------ ⑨ replay: 过/挂双路
def test_replay_logic_pass_and_fail():
    _patch()
    bd = _battle("battleR", corpus=("中冶长天语料甲.md", "中冶长天语料乙.md"))
    pfx = "E:/x/《中石化南京工程有限公司怎么干EPC总承包？》/04/20_微信文章/"
    _pool("P-B2", manifest_lines=[          # SNEI 靠池存量 (缩略词频次门)
        f'{{"source_path": "{pfx}SNEI Wins Award.md"}}',
        f'{{"source_path": "{pfx}SNEI 新签 EPC 大单.md"}}'])
    mf = _TMP / "mini_replay.json"
    mf.write_text(json.dumps({
        "bar": {"min_recall": 0.9},
        "battles": [
            {"battle": "B1",
             "title": "《中冶长天国际工程有限责任公司怎么干EPC总承包？》",
             "battle_dir": str(bd), "pool": "",
             "ground_truth": {"t1": ["中冶长天国际工程有限责任公司",
                                     "中冶长天国际工程", "中冶长天"]}},
            {"battle": "B2",
             "title": "《中石化南京工程有限公司怎么干EPC总承包？》",
             "battle_dir": "", "pool": "P-B2",
             "ground_truth": {"t1": ["中石化南京工程", "南京工程有限公司",
                                     "SNEI", "中石化南京"]}}]},
        ensure_ascii=False), encoding="utf-8")
    rc = te.replay(str(mf))
    assert rc == 0
    summary = json.loads((_REPLAY_OUT / "replay_summary.json").read_text(
        encoding="utf-8"))
    assert summary["zero_paid"] is True and summary["rc"] == 0
    assert all(r["recall"] >= 0.9 and r["ok"] and r["honest"]
               and r["filled"] >= 1 for r in summary["rows"])
    assert not (bd / "tiers_draft.json").exists()      # 真战役目录零污染
    mf2 = _TMP / "mini_replay_bad.json"                # 挂门: 召回 50% < 90%
    mf2.write_text(json.dumps({"battles": [
        {"battle": "B3", "title": "《中石化南京工程有限公司怎么干EPC总承包？》",
         "battle_dir": "", "pool": "",
         "ground_truth": {"t1": ["中石化南京工程", "不存在的历史曾用名"]}}]},
        ensure_ascii=False), encoding="utf-8")
    assert te.replay(str(mf2)) == 1


# ------------------------------------------------ ⑩ ast 零付费机检
def test_zero_paid_no_network_imports():
    src = Path(te.__file__).read_text(encoding="utf-8")
    mods = set()
    for node in ast.walk(ast.parse(src)):
        if isinstance(node, ast.Import):
            mods.update(a.name.split(".")[0] for a in node.names)
        elif isinstance(node, ast.ImportFrom) and node.module:
            mods.add(node.module.split(".")[0])
    banned = {"urllib", "requests", "httpx", "curl_cffi", "socket"}
    assert not (mods & banned), f"词表生成器禁网络根模块: {mods & banned}"


# ------------------------------------------------ ⑪ entity_seed (FT-6 底座)
def test_entity_seed_wires_ft6():
    _patch()
    doc = te.expand("《中石化南京工程有限公司怎么干EPC总承包？》")
    seed = te.entity_seed(doc)
    assert seed["topic"] == "中石化南京工程有限公司"
    assert "中石化南京工程" in seed["NAMES"]


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
