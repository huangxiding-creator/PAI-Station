# -*- coding: utf-8 -*-
"""种子治理迁移测试（KB-FACTORY v2.7 #6，Shopify 制式三件套迁移验收）。

判据对应（ac 编号即测试名后缀，供追溯）：
  ac1 新制式齐全：seeds/taxonomy 三件 YAML 五顶层件齐 + CHANGELOG + migrate_report + 校验器在位
  ac2 守恒硬门：migrate_report PASS，且**测试独立重算**（不信报告自述）——
      49 分组数 / 每分组槽位 / THUOCL 词数(143433) / fibo 概念数(2625) 逐项相等
  ac3 向后兼容不删旧件：旧 JSON 种子全量在位（六库蓝图 10 / THUOCL 11+1 / FIBO 8+2）
  ac4 loader 兼容契约：YAML 路径产出与旧真源深度相等；回退路径相等；幂等
  ac5 深度与许可证：树深 ≤3（工程域恰 3）；sources 逐件带许可证/出处
"""
import json
import re
import subprocess
import sys
from pathlib import Path

import yaml

ROOT = Path(__file__).resolve().parents[1]          # kb_factory/
sys.path.insert(0, str(ROOT))

import taxonomy_loader as tl                        # noqa: E402
from catalog_engine.taxonomy import SIX_DOMAINS     # noqa: E402

TAX = ROOT / "seeds" / "taxonomy"
FAMILIES = ("engineering_epc", "thuocl_lexicon", "fibo_ontology")

SHA256_RE = re.compile(r"^[0-9a-f]{64}$")
_BLUEPRINT_RE = re.compile(r"^\d{2}_.+\.json$")
_FIBO_RE = re.compile(r"^[A-Z][A-Z0-9]*\.json$")


def _load(name):
    return yaml.safe_load((TAX / f"{name}.yaml").read_text(encoding="utf-8"))


def _legacy_slots():
    """旧侧每分组槽位独立重算（扫 seeds/0*.json，同迁移器口径但不共享代码路径）。"""
    slots = {g: 0 for v in SIX_DOMAINS for g in v["groups"]}
    for path in sorted((ROOT / "seeds").iterdir()):
        if not _BLUEPRINT_RE.match(path.name):
            continue
        doc = json.loads(path.read_text(encoding="utf-8"))
        for l1 in doc.get("tree", {}).get("l1", []):
            for l2 in l1.get("l2", []) or []:
                if l2.get("name") in slots:
                    slots[l2["name"]] += int(l2.get("file_count", 0))
    return slots


# ------------------------------------------------------------------ ac1 新制式齐全
def test_ac1_format_files_and_sections():
    """ac1：三件 YAML + CHANGELOG + migrate_report + check_taxonomy.py 齐备；五顶层件齐。"""
    for extra in ("CHANGELOG.md", "migrate_report.json", "check_taxonomy.py",
                  "_work/migrate_to_yaml.py"):
        assert (TAX / extra).exists(), f"缺 {extra}"
    for name in FAMILIES:
        doc = _load(name)
        for key in ("version", "sources", "tree", "attributes", "values"):
            assert key in doc, f"{name}.yaml 缺顶层件 {key}"
        assert isinstance(doc["version"], str) and doc["version"]
        assert doc["sources"], f"{name}.yaml sources 空"
        assert doc["tree"]["id"] and doc["tree"]["name"]


# ------------------------------------------------------------------ ac2 守恒硬门
def test_ac2_conservation_report_pass():
    """ac2a：migrate_report 自述 PASS / 三族 conserved / 校验器 0 错。"""
    report = json.loads((TAX / "migrate_report.json").read_text(encoding="utf-8"))
    assert report["conservation"] == "PASS"
    assert report["validator_errors"] == 0
    for name in FAMILIES:
        fam = report["families"][name]
        assert fam["conserved"] is True
        assert fam["before"] == fam["after"], f"{name} 报告内 before/after 不等"


def test_ac2_groups_and_slots_recomputed():
    """ac2b：49 分组数与每分组槽位独立重算守恒（测试自算两侧，不信报告）。"""
    doc = _load("engineering_epc")
    libs = doc["tree"]["children"]
    # 库数与逐库分组数（旧侧 SIX_DOMAINS 实读）
    assert [lib["id"] for lib in libs] == [v["code"] for v in SIX_DOMAINS]
    assert [lib["name"] for lib in libs] == [v["name"] for v in SIX_DOMAINS]
    assert {lib["id"]: len(lib["children"]) for lib in libs} == \
        {v["code"]: len(v["groups"]) for v in SIX_DOMAINS}
    assert sum(len(lib["children"]) for lib in libs) == 49
    # 分组名逐字守恒（旧侧逐字提取源）
    old_names = [g for v in SIX_DOMAINS for g in v["groups"]]
    new_names = [g["name"] for lib in libs for g in lib["children"]]
    assert new_names == old_names, "49 分组名逐字不符"
    # 每分组槽位：新侧 YAML 实读 == 旧侧蓝图独立重算
    new_slots = {g["name"]: g["slots"] for lib in libs for g in lib["children"]}
    assert new_slots == _legacy_slots(), "每分组槽位数不守恒"
    assert sum(new_slots.values()) == 380 and sum(1 for v in new_slots.values() if v) == 38


def test_ac2_thuocl_words_recomputed():
    """ac2c：THUOCL 词数 143433 与逐域词数独立重算守恒。"""
    doc = _load("thuocl_lexicon")
    summary = json.loads((ROOT / "seeds" / "thuocl" / "_summary.json").read_text(encoding="utf-8"))
    per_yaml = {d["id"]: d["word_count"] for d in doc["tree"]["children"]}
    per_json = {r["domain_en"]: r["word_count"] for r in summary["domains"]}
    assert per_yaml == per_json, "逐域词数不守恒"
    assert sum(per_yaml.values()) == 143433
    assert len(per_yaml) == 11


def test_ac2_fibo_concepts_recomputed():
    """ac2d：fibo 概念数 2625 与逐模块概念数独立重算守恒；zh_map/基座组对账。"""
    doc = _load("fibo_ontology")
    layers = {c["id"]: c for c in doc["tree"]["children"]}
    per_yaml = {m["id"]: m["classes"] for m in layers["modules"]["children"]}
    per_json = {}
    for path in sorted((ROOT / "seeds" / "fibo").iterdir()):
        if _FIBO_RE.match(path.name):
            d = json.loads(path.read_text(encoding="utf-8"))
            per_json[d["module"]] = d["stats"]["classes"]
    assert per_yaml == per_json, "逐模块概念数不守恒"
    assert sum(per_yaml.values()) == 2625 and len(per_yaml) == 8
    fnd = layers["fnd_common"]["children"]
    assert [g["id"] for g in fnd] == ["organizations", "parties", "documents", "time", "quantities"]
    assert sum(g["concepts"] for g in fnd) == 107
    zm = next(s for s in doc["sources"] if s["name"].endswith("_zh_map.json"))
    assert zm["entries"] == 340


# ------------------------------------------------------------------ ac3 旧件不删
def test_ac3_legacy_seeds_untouched():
    """ac3：旧 JSON 种子全量在位（向后兼容不删旧件）。"""
    seeds = ROOT / "seeds"
    blueprints = sorted(p.name for p in seeds.iterdir() if _BLUEPRINT_RE.match(p.name))
    assert len(blueprints) == 10, f"六库蓝图种子应 10 件，实得 {blueprints}"
    thuocl = sorted(p.name for p in (seeds / "thuocl").glob("*.json"))
    assert len([n for n in thuocl if not n.startswith("_")]) == 11
    assert (seeds / "thuocl" / "_summary.json").exists()
    fibo_mods = [p.name for p in (seeds / "fibo").iterdir() if _FIBO_RE.match(p.name)]
    assert len(fibo_mods) == 8
    for extra in ("_zh_map.json", "_fnd_common.json"):
        assert (seeds / "fibo" / extra).exists()


# ------------------------------------------------------------------ ac4 loader 兼容
def test_ac4_loader_backcompat_six():
    """ac4a：six_domains() 与 taxonomy.SIX_DOMAINS 深度相等；49 分组集一致。"""
    assert tl.six_domains() == SIX_DOMAINS
    assert len(tl.six_groups49()) == 49
    assert tl.six_groups49() == {g for v in SIX_DOMAINS for g in v["groups"]}


def test_ac4_loader_backcompat_thuocl():
    """ac4b：thuocl_summary() 与 _summary.json 全形全等（含 built_at）。"""
    legacy = json.loads((ROOT / "seeds" / "thuocl" / "_summary.json").read_text(encoding="utf-8"))
    assert tl.thuocl_summary() == legacy


def test_ac4_loader_backcompat_fibo():
    """ac4c：fibo_module_index() 与旧 JSON 拼装结果深度相等。"""
    legacy = tl.fibo_module_index(taxonomy_dir=ROOT / "seeds" / "__no_such_dir__")  # 强制回退旧源
    got = tl.fibo_module_index()                                                     # YAML 路径
    assert got == legacy
    assert sum(m["stats"]["classes"] for m in got["modules"].values()) == 2625
    assert got["zh_map"]["entries"] == 340


def test_ac4_loader_fallback_and_idempotent(tmp_path):
    """ac4d：YAML 缺席回退旧真源（三路全等旧 JSON/Python）；重复调用幂等；group_slots 两路同值。"""
    empty = tmp_path / "empty_taxonomy"          # 空目录 → 全部回退
    empty.mkdir()
    legacy_summary = json.loads(
        (ROOT / "seeds" / "thuocl" / "_summary.json").read_text(encoding="utf-8"))
    assert tl.six_domains(taxonomy_dir=empty) == SIX_DOMAINS
    assert tl.thuocl_summary(taxonomy_dir=empty) == legacy_summary
    assert tl.fibo_module_index(taxonomy_dir=empty) == tl.fibo_module_index(taxonomy_dir=empty)
    assert tl.six_domains() == tl.six_domains()          # 幂等
    assert tl.thuocl_summary() == tl.thuocl_summary()
    assert tl.fibo_module_index() == tl.fibo_module_index()
    slots_yaml = tl.group_slots()
    assert slots_yaml == _legacy_slots()                 # 槽位两路同值
    assert tl.group_slots(taxonomy_dir=empty) == slots_yaml


# ------------------------------------------------------------------ ac5 深度与出处
def test_ac5_depth_within_limit_and_licenses():
    """ac5：全库树深 ≤3（工程域恰 3 级）；sources 逐件带出处，巨人源带许可证。"""
    def max_depth(node, d=1):
        kids = node.get("children") or []
        return max([d] + [max_depth(c, d + 1) for c in kids])

    for name in FAMILIES:
        doc = _load(name)
        assert max_depth(doc["tree"]) <= 3, f"{name} 树深越限"
    eng = _load("engineering_epc")
    assert max_depth(eng["tree"]) == 3, "工程域应为 根→库→分组 恰三级"
    for name in FAMILIES:
        doc = _load(name)
        giant = [s for s in doc["sources"] if s["name"] in ("Shopify/product-taxonomy",
                                                            "thunlp/THUOCL", "EDMCouncil/fibo")]
        assert giant, f"{name} 缺巨人出处"
        for s in giant:
            assert s.get("license") == "MIT", f"{name} 巨人源 {s['name']} 许可证缺失"
    fibo = _load("fibo_ontology")
    src = next(s for s in fibo["sources"] if s["name"] == "EDMCouncil/fibo")
    assert SHA256_RE.match(src["tarball_sha256"]) and src["tag"] == "master_2026Q3"


def test_ac5_validator_cli_green():
    """ac5b：校验器 CLI 真入口全绿（rc=0，--json errors=0）。"""
    import os
    env = dict(os.environ, PYTHONIOENCODING="utf-8")
    r = subprocess.run([sys.executable, "-X", "utf8", str(TAX / "check_taxonomy.py"), "--json"],
                       capture_output=True, text=True, encoding="utf-8", errors="replace",
                       timeout=300, env=env)
    assert r.returncode == 0, f"rc={r.returncode}\n{r.stdout}\n{r.stderr}"
    payload = json.loads(r.stdout)
    assert payload["errors"] == 0 and payload["files"] == 3
