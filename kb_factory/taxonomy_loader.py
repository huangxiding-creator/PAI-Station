# -*- coding: utf-8 -*-
"""taxonomy_loader —— 种子分类法 loader 兼容层（KB-FACTORY v2.7 #6，Shopify 制式迁移配套）。

读取次序（向后兼容铁律）：YAML 优先，缺则回退旧真源——
  six_domains()      engineering_epc.yaml → 缺则 catalog_engine/taxonomy.py SIX_DOMAINS
  thuocl_summary()   thuocl_lexicon.yaml  → 缺则 seeds/thuocl/_summary.json
  fibo_module_index() fibo_ontology.yaml → 缺则 seeds/fibo/*.json 实读拼装
  group_slots()      engineering_epc.yaml → 缺则扫 seeds/0*.json 蓝图实测

兼容契约（测试硬断言，非口头）：YAML 路径产出与旧真源产出**深度相等**——
  six_domains() == taxonomy.SIX_DOMAINS
  thuocl_summary() == json(seeds/thuocl/_summary.json)
  fibo_module_index() == 由 seeds/fibo/*.json 拼装的等形 dict
故消费端从旧真源切到本 loader 是零行为漂移的纯换线。

纪律：纯读不写、无随机、无时钟；幂等（重复调用结果深度相等）；
YAML 数据位 seeds/taxonomy/（新制式增量真源，旧 JSON 一律保留不删）。

收口波接线说明（本任务不接线，只留口）：
  1) engine 侧：engine.py 的 taxonomy.SIX_DOMAINS 引用可换 six_domains()（等价由
     test_taxonomy_migration.py::test_loader_backcompat_six 保证）；blueprint 选库
     逻辑零改动即可享 YAML 真源；
  2) lexicon 侧：thuocl_lex.py / fibo_lex.py 的词数据本体（words/concepts）不迁，
     仍读 JSON；本 loader 只供「分类法/索引」层——两层职责不混；
  3) 门禁位：seeds/taxonomy/check_taxonomy.py 全库 0 错后方可读本层（校验器先行，
     loader 不做校验——执法与取数分离）。
"""
from __future__ import annotations

import copy
import json
import re
from pathlib import Path

# yaml 惰性化（1026 云托管宪法部署实锤：python:3-slim 零三方包，顶层 import 即崩
# 证据链；YAML 文件在位才真正需要它——缺席走旧真源回退，回退路径零 yaml）
try:
    import yaml
except ImportError:  # pragma: no cover —— 容器/极简环境
    yaml = None

SEEDS_DIR = Path(__file__).resolve().parent / "seeds"
TAXONOMY_DIR = SEEDS_DIR / "taxonomy"

_SEED_BLUEPRINT_RE = re.compile(r"^\d{2}_.+\.json$")
_FIBO_MODULE_RE = re.compile(r"^[A-Z][A-Z0-9]*\.json$")

# fibo 模块节点的非统计键（统计键=与模块 JSON stats 键族同构的平铺位）
_FIBO_MODULE_META_KEYS = ("type", "id", "name", "module_en", "role", "note")


def _load_yaml(filename: str, taxonomy_dir=None):
    """读单件 YAML；缺文件/坏文件返回 None（走回退，不静默造数据）。"""
    d = Path(taxonomy_dir) if taxonomy_dir is not None else TAXONOMY_DIR
    path = d / filename
    if not path.exists():
        return None
    if yaml is None:
        raise ImportError("PyYAML 未安装（极简环境）——走旧真源回退")
    return yaml.safe_load(path.read_text(encoding="utf-8"))


# ------------------------------------------------------------------ 六库 49 分组
def six_domains(taxonomy_dir=None) -> list:
    """六库 49 分组 → [{code,name,desc,groups}]（形状逐字兼容 taxonomy.SIX_DOMAINS）。"""
    doc = _load_yaml("engineering_epc.yaml", taxonomy_dir)
    if doc is None:
        from catalog_engine.taxonomy import SIX_DOMAINS   # 回退旧真源（Python 实读版）
        return copy.deepcopy(SIX_DOMAINS)
    return [{"code": lib["id"], "name": lib["name"], "desc": lib["desc"],
             "groups": [g["name"] for g in lib["children"]]}
            for lib in doc["tree"]["children"]]


def six_groups49(taxonomy_dir=None) -> set:
    """49 分组名集合（同 build_seeds.py 口径：{g for v in SIX_DOMAINS for g in v["groups"]}）。"""
    return {g for v in six_domains(taxonomy_dir) for g in v["groups"]}


def group_slots(taxonomy_dir=None) -> dict:
    """每分组蓝图实灌槽位 {分组名: 槽位数}（YAML 优先；缺则扫 seeds/0*.json 实测）。"""
    doc = _load_yaml("engineering_epc.yaml", taxonomy_dir)
    if doc is not None:
        slots = {}
        for lib in doc["tree"]["children"]:
            for g in lib["children"]:
                slots[g["name"]] = slots.get(g["name"], 0) + g["slots"]
        return slots
    slots = {g: 0 for v in six_domains() for g in v["groups"]}
    for path in sorted(SEEDS_DIR.iterdir()):
        if not _SEED_BLUEPRINT_RE.match(path.name):
            continue
        bp = json.loads(path.read_text(encoding="utf-8"))
        for l1 in bp.get("tree", {}).get("l1", []):
            for l2 in l1.get("l2", []) or []:
                if l2.get("name") in slots:
                    slots[l2["name"]] += int(l2.get("file_count", 0))
    return slots


# ------------------------------------------------------------------ THUOCL 摘要
def thuocl_summary(taxonomy_dir=None) -> dict:
    """THUOCL 摘要 → 与 seeds/thuocl/_summary.json 全形全等（含 built_at 原样复原）。"""
    doc = _load_yaml("thuocl_lexicon.yaml", taxonomy_dir)
    if doc is None:
        return json.loads((SEEDS_DIR / "thuocl" / "_summary.json").read_text(encoding="utf-8"))
    upstream = next(s for s in doc["sources"] if s["name"] == "thunlp/THUOCL")
    legacy = next(s for s in doc["sources"] if s["name"].endswith("_summary.json"))
    root = doc["tree"]
    rows = [{"domain_en": d["id"], "domain_cn": d["name"], "word_count": d["word_count"],
             "skipped_lines": d["skipped_lines"], "dropped_df_le1": d["dropped_df_le1"],
             "mapped_groups": list(d["mapped_groups"])} for d in root["children"]]
    hit = sorted({g for r in rows for g in r["mapped_groups"]})
    return {"source": "THUOCL", "upstream": upstream["url"], "license": upstream["license"],
            "built_at": legacy["built_at"], "domain_count": len(rows),
            "total_word_count": sum(r["word_count"] for r in rows),
            "skipped_lines": sum(r["skipped_lines"] for r in rows),
            "dropped_df_le1": sum(r["dropped_df_le1"] for r in rows),
            "groups_total": root["groups_total"], "groups_hit": len(hit),
            "map_valid_pct": root["map_valid_pct"], "hit_groups": hit, "domains": rows}


# ------------------------------------------------------------------ FIBO 模块索引
def fibo_module_index(taxonomy_dir=None) -> dict:
    """FIBO 模块索引 → {"modules":{模块码:meta+stats}, "trunk/closure_modules",
    "fnd_common":{组键:{zh,desc,concepts}}, "zh_map":{version,entries}}。"""
    doc = _load_yaml("fibo_ontology.yaml", taxonomy_dir)
    if doc is not None:
        src = next(s for s in doc["sources"] if s["name"] == "EDMCouncil/fibo")
        source = {"repo": src["repo"], "tag": src["tag"], "license": src["license"],
                  "license_copyright": src["license_copyright"], "url": src["url"],
                  "tarball_sha256": src["tarball_sha256"]}
        layers = {c["id"]: c for c in doc["tree"]["children"]}
        modules = {}
        for m in layers["modules"]["children"]:
            modules[m["id"]] = {
                "module_zh": m["name"], "module_en": m["module_en"], "note": m["note"],
                "source": dict(source),
                "stats": {k: v for k, v in m.items() if k not in _FIBO_MODULE_META_KEYS}}
        fnd = {g["id"]: {"zh": g["name"], "desc": g["desc"], "concepts": g["concepts"]}
               for g in layers["fnd_common"]["children"]}
        zm = next(s for s in doc["sources"] if s["name"].endswith("_zh_map.json"))
        values = doc.get("values", {})
        return {"modules": modules,
                "trunk_modules": list(values.get("trunk_modules", [])),
                "closure_modules": list(values.get("closure_modules", [])),
                "fnd_common": fnd,
                "zh_map": {"version": zm["version"], "entries": zm["entries"]}}
    # 回退：seeds/fibo/*.json 实读拼装（与 YAML 路径等形）
    fibo_dir = SEEDS_DIR / "fibo"
    modules = {}
    for path in sorted(fibo_dir.iterdir()):
        if not _FIBO_MODULE_RE.match(path.name):
            continue
        d = json.loads(path.read_text(encoding="utf-8"))
        modules[d["module"]] = {"module_zh": d["module_zh"], "module_en": d["module_en"],
                                "note": d["note"], "source": dict(d["source"]),
                                "stats": dict(d["stats"])}
    from catalog_engine.fibo_lex import TRUNK_MODULES, CLOSURE_MODULES
    fnd_doc = json.loads((fibo_dir / "_fnd_common.json").read_text(encoding="utf-8"))
    zm_doc = json.loads((fibo_dir / "_zh_map.json").read_text(encoding="utf-8"))
    return {"modules": modules, "trunk_modules": list(TRUNK_MODULES),
            "closure_modules": list(CLOSURE_MODULES),
            "fnd_common": {g["key"]: {"zh": g["zh"], "desc": g["desc"],
                                      "concepts": len(g["concepts"])} for g in fnd_doc["groups"]},
            "zh_map": {"version": zm_doc["version"], "entries": len(zm_doc["entries"])}}
