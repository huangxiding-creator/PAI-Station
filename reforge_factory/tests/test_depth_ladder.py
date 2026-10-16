# -*- coding: utf-8 -*-
"""depth_ladder 单测 — P 轴深度阶梯传感器 (T-007D / REQ-023).

覆盖: ①五级分布+分母对拍 (分母=question_tree 实际 EEI 数, REQ-023 铁律)
②关键 EEI ≥L3 占比与 green 阈值 ③纯规则逐级判定 (L1..L5) ④树缺失 fail-soft
⑤真实池只读 (manifest/树字节不变) ⑥双落盘 (completeness/P_axis.json +
depth_ladder.json 三必字段) ⑦key 兜底链 (树标记→T1 挂钩→全体) ⑧CLI 退出码
⑨不可变 ⑩ast 零网络根模块.
"""
from __future__ import annotations

import ast
import json
import sys
import tempfile
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "completeness"))
import depth_ladder as DL                     # noqa: E402

DENSE = ("2023年全省新签合同额123.45亿元、同比增速6.7%、利润总额8.9亿元")
TABLE = "指标|数值|同比\n新签合同额|123.45亿元|6.7%\n营业收入|98.7亿元|5.4%"


def _row(node: str, *, url: str = "https://solo.cn/x", sp: str = "",
         stance: str = "support", head: str = "纯文字提及工程总承包招投标概念",
         engine: str = "rss:test", dedup: str = "", judge: str = "valid",
         **extra) -> dict:
    d = {"dedup_key": dedup or f"{node}-{url}", "engine": engine,
         "url_norm": url, "source_path": sp or f"E:/pool/{node}.md",
         "chars": 100, "judge": judge, "tree_node": node,
         "stance": stance, "text_head": head, "grade": "B"}
    d.update(extra)
    return d


def _eei(eid: str, *, key: bool = False, stance: str = "support") -> dict:
    e = {"id": eid, "need": f"正面证据: {eid}", "grades": ["B"],
         "stance": stance, "channels_hint": [], "queries": [],
         "status": "zero"}
    if key:
        e["key"] = True
    return e


def _build_pool(camp: Path, *, extra_zero_eei: bool = False,
                tiers: dict | None = None) -> Path:
    """10 EEI 夹具: 2×L1 / 3×L2 / 3×L3 / 1×L4 / 1×L5, 关键 4 个全 L3+."""
    eeis: list[dict] = []
    rows: list[dict] = []
    for eid in ("E01", "E02"):                              # L1 仅提及
        eeis.append(_eei(eid))
        rows.append(_row(eid))
    eeis.append(_eei("E03"))                                # L2 量词密集
    rows.append(_row("E03", head=DENSE, url="https://d1.cn/a"))
    eeis.append(_eei("E04"))                                # L2 数字表格
    rows.append(_row("E04", head=TABLE, url="https://d2.cn/a"))
    eeis.append(_eei("E05"))                                # L2 单源但有数据
    rows.append(_row("E05", head=DENSE, url="https://d3.cn/a"))
    for eid, (h1, h2) in {"E06": ("h6a.cn", "h6b.cn"),    # L3 双源×3 (关键)
                          "E07": ("h7a.cn", "h7b.cn"),
                          "E08": ("h8a.cn", "h8b.cn")}.items():
        eeis.append(_eei(eid, key=True))
        rows.append(_row(eid, url=f"https://{h1}/x", head=DENSE))
        rows.append(_row(eid, url=f"https://{h2}/y"))
    eeis.append(_eei("E09"))                                # L4 反证 (单源)
    rows.append(_row("E09", stance="against",
                     head="围标串标风险与失败反例讨论", url="https://h9.cn/z"))
    eeis.append(_eei("E10", key=True))                      # L5 own_calc (关键)
    rows.append(_row("E10", engine="own_calc:模型测算",
                     url="https://h10.cn/z"))
    if extra_zero_eei:
        eeis.append(_eei("E11"))                            # 零据 → L0
    camp.mkdir(parents=True, exist_ok=True)
    (camp / "manifest.jsonl").write_text(
        "\n".join(json.dumps(x, ensure_ascii=False) for x in rows),
        encoding="utf-8")
    tree = {"campaign": camp.name, "topic": "T", "region": "R",
            "subquestions": [{"id": "Q1", "dim": "政策监管", "text": "tx",
                              "eeis": eeis}]}
    (camp / "question_tree.json").write_text(
        json.dumps(tree, ensure_ascii=False), encoding="utf-8")
    if tiers is not None:
        (camp / "tiers.json").write_text(
            json.dumps(tiers, ensure_ascii=False), encoding="utf-8")
    return camp


def _tmp_camp() -> Path:
    """临时 pool 根 (战役目录 = root/'CAMP-P')."""
    return Path(tempfile.mkdtemp(prefix="dl_test_"))


# ------------------------------------------------ ① 五级分布 + 分母对拍
def test_01_dist_and_denominator():
    root = _tmp_camp()
    camp = _build_pool(root / "CAMP-P")
    r = DL.scan("CAMP-P", root, write=False)
    assert r["eei_total"] == 10
    assert r["l_dist"] == {"L0": 0, "L1": 2, "L2": 3, "L3": 3,
                           "L4": 1, "L5": 1, "L6": 0}
    assert sum(r["l_dist"].values()) == r["eei_total"]      # 分布=分母
    # 分母对拍: 与树文件实际 EEI 数逐个对账 (REQ-023: 分母=树实际输出数)
    tree = json.loads((camp / "question_tree.json").read_text(encoding="utf-8"))
    n_tree = sum(len(q["eeis"]) for q in tree["subquestions"])
    assert r["eei_total"] == n_tree == 10
    # 零据 EEI 记 L0 不记 L1 (零据≠提及)
    root2 = _tmp_camp()
    camp2 = _build_pool(root2 / "CAMP-P", extra_zero_eei=True)
    r2 = DL.scan("CAMP-P", root2, write=False)
    tree2 = json.loads((camp2 / "question_tree.json").read_text(encoding="utf-8"))
    assert r2["eei_total"] == sum(len(q["eeis"])
                                  for q in tree2["subquestions"]) == 11
    assert r2["l_dist"]["L0"] == 1 and r2["l_dist"]["L1"] == 2


# ------------------------------------------------ ② 关键 EEI 占比 + green
def test_02_key_pct_and_green():
    root = _tmp_camp()
    _build_pool(root / "CAMP-P")
    r = DL.scan("CAMP-P", root, write=False)
    assert r["key_eei_source"] == "tree_marker"
    assert r["key_eei_total"] == 4                       # E06-E08 + E10
    assert r["key_eei_ge_l3"] == 4                       # 全部 ≥L3
    assert r["key_eei_ge_l3_pct"] == 1.0
    assert r["green"] is True                            # 1.0 >= 0.9


# ------------------------------------------------ ③ 纯规则逐级判定
def test_03_level_rules_pure():
    lv = DL.eei_level
    assert lv({"id": "A"}, []).startswith("L0")          # 零据
    assert lv({"id": "A"}, [_row("A")]) .startswith("L1")
    assert lv({"id": "A"}, [_row("A", head=DENSE)]).startswith("L2")
    assert lv({"id": "A"}, [_row("A", url="https://a.cn/1", head=DENSE),
                            _row("A", url="https://b.cn/2")]).startswith("L3")
    # 占位 URL 回退 source_path stem (与 independence_audit 同口径)
    assert lv({"id": "A"}, [_row("A", url="https://w/", sp="E:/pool/d1.md"),
                            _row("A", url="https://w/", sp="E:/pool/d2.md",
                                 dedup="k2")]).startswith("L3")
    # L4: 行 stance=against
    assert lv({"id": "A"}, [_row("A", stance="against")]).startswith("L4")
    # L4: 树内反证位 (EEI stance=against) 已有据
    assert lv({"id": "A", "stance": "against"},
              [_row("A")]).startswith("L4")
    # L5: 行源标记 own_calc (engine / source_path / 专用字段)
    assert lv({"id": "A"}, [_row("A", engine="own_calc:v1")]).startswith("L5")
    assert lv({"id": "A"}, [_row("A", sp="E:/pool/自算台账.md",
                                 dedup="k3")]).startswith("L5")
    assert lv({"id": "A"}, [_row("A", dedup="k4",
                                 **{"own_calc": "回归测算"})]).startswith("L5")
    # judge!=valid 不计证据
    assert lv({"id": "A"}, [_row("A", judge="rejected")]).startswith("L0")
    # 数据密度检测器: 量词密集 / 表格 / 纯文字
    assert DL.is_data_dense(DENSE) and DL.is_data_dense(TABLE)
    assert not DL.is_data_dense("本文概述了工程总承包的基本概念与流程")


# ------------------------------------------------ ④ 树缺失 fail-soft
def test_04_tree_missing_fail_soft():
    root = _tmp_camp()
    camp = root / "CAMP-P"
    camp.mkdir(parents=True)
    (camp / "manifest.jsonl").write_text(
        json.dumps(_row("E01"), ensure_ascii=False), encoding="utf-8")
    r = DL.scan("CAMP-P", root, write=True)             # 不抛异常
    assert r["eei_total"] == 0 and r["green"] is False
    assert r["l_dist"] == {k: 0 for k in
                           ("L0", "L1", "L2", "L3", "L4", "L5", "L6")}
    assert any("question_tree" in n for n in r["notes"])
    assert (camp / "completeness" / "P_axis.json").is_file()   # fail-soft 落盘
    assert (camp / "depth_ladder.json").is_file()


# ------------------------------------------------ ⑤ 真实池只读
def test_05_pool_readonly():
    root = _tmp_camp()
    camp = _build_pool(root / "CAMP-P")
    before = {p.name: p.read_bytes()
              for p in camp.iterdir() if p.is_file()}
    DL.scan("CAMP-P", root, write=True)
    after = {p.name: p.read_bytes()
             for p in camp.iterdir() if p.is_file()}
    for name, b in before.items():                      # 原文件一字节不动
        assert after[name] == b, f"改写了只读资产: {name}"
    # 新增仅 depth_ladder.json + completeness/P_axis.json 两个输出件
    added = set(after) - set(before)
    assert added == {"depth_ladder.json"}
    assert (camp / "completeness" / "P_axis.json").is_file()


# ------------------------------------------------ ⑥ 双落盘 + 三必字段
def test_06_dual_output_required_fields():
    root = _tmp_camp()
    _build_pool(root / "CAMP-P")
    r = DL.scan("CAMP-P", root, write=True)
    p_axis = json.loads((root / "CAMP-P" / "completeness" / "P_axis.json")
                        .read_text(encoding="utf-8"))
    p_req = json.loads((root / "CAMP-P" / "depth_ladder.json")
                       .read_text(encoding="utf-8"))
    for d in (p_axis, p_req):
        assert {"eei_total", "l_dist", "key_eei_ge_l3_pct"} <= set(d)
        assert d["axis"] == "P" and d["sensor"] == "depth_ladder"
    assert p_axis["eei_total"] == p_req["eei_total"] == r["eei_total"]
    assert p_axis["l_dist"] == p_req["l_dist"]
    assert p_axis["key_eei_ge_l3_pct"] == p_req["key_eei_ge_l3_pct"]


# ------------------------------------------------ ⑦ key 兜底链
def test_07_key_fallback_chain():
    # 7a: 无树标记 → tiers.json T1 词表挂钩 (标题级, 与 tier_report 同口径)
    root = _tmp_camp()
    camp = _build_pool(root / "CAMP-P", tiers={"T1": ["招标投标法"], "T2": ["泛词"]})
    # E01 行 source_path=E:/pool/E01.md 不含 T1 词; 给 E01 换个 T1 标题行
    rows = [json.loads(x) for x in (camp / "manifest.jsonl")
            .read_text(encoding="utf-8").splitlines()]
    rows.append(_row("E01", sp="E:/pool/招标投标法解读.md", dedup="t1row"))
    (camp / "manifest.jsonl").write_text(
        "\n".join(json.dumps(x, ensure_ascii=False) for x in rows),
        encoding="utf-8")
    # 抹掉树内 key 标记 → 验 t1_linked 层
    tree = json.loads((camp / "question_tree.json").read_text(encoding="utf-8"))
    for q in tree["subquestions"]:
        for e in q["eeis"]:
            e.pop("key", None)
    (camp / "question_tree.json").write_text(
        json.dumps(tree, ensure_ascii=False), encoding="utf-8")
    r = DL.scan("CAMP-P", root, write=False)
    assert r["key_eei_source"] == "t1_linked"
    assert r["key_eei_total"] == 1 and "E01" in r["key_eeis"]
    assert r["green"] is False                       # E01 仅 L1 → 0/1 < 0.9
    assert r["key_eei_ge_l3_pct"] == 0.0
    # 7b: 无树标记无 tiers.json → 全体兜底 (key_eei_source 记录依据)
    root2 = _tmp_camp()
    camp2 = _build_pool(root2 / "CAMP-P")            # 树内 E06-E08/E10 有标记…
    # 抹掉树标记验全体兜底
    tree = json.loads((camp2 / "question_tree.json").read_text(encoding="utf-8"))
    for q in tree["subquestions"]:
        for e in q["eeis"]:
            e.pop("key", None)
    (camp2 / "question_tree.json").write_text(
        json.dumps(tree, ensure_ascii=False), encoding="utf-8")
    r2 = DL.scan("CAMP-P", root2, write=False)
    assert r2["key_eei_source"] == "all_fallback"
    assert r2["key_eei_total"] == 10                 # 分母内全体
    assert r2["key_eei_ge_l3"] == 5                  # L3×3 + L4 + L5
    assert r2["key_eei_ge_l3_pct"] == 0.5 and r2["green"] is False


# ------------------------------------------------ ⑧ CLI 退出码 (0/2)
def test_08_cli_exit_codes():
    root = _tmp_camp()
    _build_pool(root / "CAMP-P")
    assert DL._main(["--campaign", "CAMP-P",
                     "--pool-root", str(root)]) == 0
    root2 = _tmp_camp()
    (root2 / "CAMP-P").mkdir(parents=True)           # 空战役: 无树 → 拦门
    assert DL._main(["--campaign", "CAMP-P",
                     "--pool-root", str(root2)]) == 2


# ------------------------------------------------ ⑨ 不可变
def test_09_immutability():
    root = _tmp_camp()
    camp = _build_pool(root)
    rows = [json.loads(x) for x in (camp / "manifest.jsonl")
            .read_text(encoding="utf-8").splitlines()]
    tree = json.loads((camp / "question_tree.json").read_text(encoding="utf-8"))
    snap = (json.dumps(rows, ensure_ascii=False, sort_keys=True),
            json.dumps(tree, ensure_ascii=False, sort_keys=True))
    DL.scan_rows(tree, rows, [])
    DL.is_data_dense(DENSE)
    assert (json.dumps(rows, ensure_ascii=False, sort_keys=True),
            json.dumps(tree, ensure_ascii=False, sort_keys=True)) == snap


# ------------------------------------------------ ⑩ ast 零网络根模块
def test_10_ast_no_network():
    tree = ast.parse(Path(DL.__file__).read_text(encoding="utf-8"))
    mods = set()
    for n in ast.walk(tree):
        if isinstance(n, ast.Import):
            mods.update(a.name.split(".")[0] for a in n.names)
        elif isinstance(n, ast.ImportFrom) and n.module:
            mods.add(n.module.split(".")[0])
    assert not (mods & {"urllib", "requests", "httpx", "curl_cffi",
                        "socket"}), f"网络根模块混入: {mods}"


# ------------------------------------------------ ⑪-⑬ L6 (V-003 / REQ-020)
def _write_excl(camp: Path, rows: list[dict]) -> None:
    (camp / "ach_exclusions.jsonl").write_text(
        "\n".join(json.dumps(x, ensure_ascii=False) for x in rows),
        encoding="utf-8")


def test_11_l6_with_exclusion_trace():
    """有排除留痕 → L6: E10 (L5 own_calc) 关联假设 rival_excluded=true
    且 evidence_ids 绑定 manifest 行 → 升 L6 (L5 基础上, 其余不变)."""
    root = _tmp_camp()
    camp = _build_pool(root / "CAMP-P")
    _write_excl(camp, [                             # E10 行 dedup_key 回挂
        {"hypothesis": "H2", "verdict": "excluded", "rival_excluded": True,
         "evidence_ids": ["E10-https://h10.cn/z"],
         "exclusion_reason": "排除分 -1.0", "ts": "2026-10-16T00:00:00"},
    ])
    assert DL.check_l6("CAMP-P", "E10", root) is True
    r = DL.scan("CAMP-P", root, write=False)
    assert r["eei_levels"]["E10"] == "L6"
    assert r["l_dist"] == {"L0": 0, "L1": 2, "L2": 3, "L3": 3,
                           "L4": 1, "L5": 0, "L6": 1}   # L5→L6 挪桶
    assert sum(r["l_dist"].values()) == r["eei_total"]
    assert r["key_eei_ge_l3"] == 4                   # L6 仍 ≥L3, green 不掉
    assert r["green"] is True
    assert any("L6" in n for n in r["notes"])
    # 非 L5 的 EEI 即使命中留痕也不升 (L6 必须在 L5 基础上)
    assert r["eei_levels"]["E09"] == "L4"


def test_12_l5_when_trace_not_bound():
    """无有效留痕 → 保持 L5 (不升): rival_excluded=false 行 /
    evidence_ids 空行 — 判据三件套缺一即不判 L6."""
    # 12a: 留痕在但 rival_excluded=false (仅 supported/inconclusive 行)
    root = _tmp_camp()
    camp = _build_pool(root / "CAMP-P")
    _write_excl(camp, [
        {"hypothesis": "H2", "verdict": "supported", "rival_excluded": False,
         "evidence_ids": ["E10-https://h10.cn/z"],
         "exclusion_reason": "净支持", "ts": "2026-10-16T00:00:00"},
    ])
    assert DL.check_l6("CAMP-P", "E10", root) is False
    r = DL.scan("CAMP-P", root, write=False)
    assert r["eei_levels"]["E10"] == "L5" and r["l_dist"]["L6"] == 0
    assert r["l_dist"]["L5"] == 1
    # 12b: rival_excluded=true 但 evidence_ids 空 (无证据绑定)
    root2 = _tmp_camp()
    camp2 = _build_pool(root2 / "CAMP-P")
    _write_excl(camp2, [
        {"hypothesis": "H2", "verdict": "excluded", "rival_excluded": True,
         "evidence_ids": [], "exclusion_reason": "无绑定", "ts": "t"},
    ])
    assert DL.check_l6("CAMP-P", "E10", root2) is False
    assert DL.scan("CAMP-P", root2, write=False)["eei_levels"]["E10"] == "L5"


def test_13_l5_when_ach_missing():
    """ach 缺失 → L5 (fail-soft 不炸): 无 ach_exclusions.jsonl 时
    L6 桶恒空, L1-L5 原口径不受影响."""
    root = _tmp_camp()
    _build_pool(root / "CAMP-P")
    assert not (root / "CAMP-P" / "ach_exclusions.jsonl").exists()
    assert DL.check_l6("CAMP-P", "E10", root) is False
    r = DL.scan("CAMP-P", root, write=False)
    assert r["eei_levels"]["E10"] == "L5" and r["l_dist"]["L6"] == 0
    assert r["ach_exclusion_rows"] == 0
    assert any("ach_exclusions" in n for n in r["notes"])
    # 坏 JSON 行 fail-soft: 只跳坏行, 好行照常判 L6
    root2 = _tmp_camp()
    camp2 = _build_pool(root2 / "CAMP-P")
    (camp2 / "ach_exclusions.jsonl").write_text(
        "{bad json\n" + json.dumps({
            "hypothesis": "H2", "verdict": "excluded", "rival_excluded": True,
            "evidence_ids": ["E10-https://h10.cn/z"],
            "exclusion_reason": "x", "ts": "t"}, ensure_ascii=False) + "\n",
        encoding="utf-8")
    assert DL.check_l6("CAMP-P", "E10", root2) is True


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
