# -*- coding: utf-8 -*-
"""migrate_to_yaml —— 种子真源迁移：旧种子 → seeds/taxonomy/<垂直域>.yaml 三件套
（KB-FACTORY v2.7 #6，Shopify/product-taxonomy 制式，MIT 蓝本）。

迁移范围（三垂直域，旧 JSON 一律保留不删——新制式为增量真源）：
  1) engineering_epc.yaml  工程总承包垂直域：六库 49 分组树（真源
     catalog_engine/taxonomy.py SIX_DOMAINS，逐字自 zhiku.js vaults 实读）
     + 每分组槽位实测（seeds/0*.json 蓝图内同名 l2 分组 file_count 之和，实读零手填）
  2) thuocl_lexicon.yaml   THUOCL 领域词表域：11 域摘要索引（真源
     seeds/thuocl/_summary.json + seeds/thuocl/<域>.json；词数据本体仍在 JSON）
  3) fibo_ontology.yaml    FIBO 财务本体检：8 模块索引 + FND 基座五概念组 +
     zh_map 台账（真源 seeds/fibo/*.json；2625 概念数据仍在 JSON——概念层级最深
     11 级，进不了 ≤3 级树制式，故只迁「模块索引」）

守恒硬门（migrate_report.json before/after 逐项相等，脚本内 assert 双保险）：
  49 分组数 / 每分组槽位数 / THUOCL 词数(143433) / fibo 概念数(2625)
  —— after 一律从落盘 YAML 回读实算（不信内存，数字零造假）。

制式（每垂直域一 YAML，五顶层件）：
  version / sources(出处与许可证) / tree(层级，深度硬顶 3) /
  attributes(属性字典，check_taxonomy 按此执法) / values(受控词表)

重跑：幂等可重入（YAML 确定性重写；migrate_report 仅 migrated_at 时间戳变化）。
收口波接线说明：本件是「一次性迁移器+对账器」，收口波无需再跑；后续真源更新
（zhiku.js 改版 / THUOCL 重收割 / FIBO 升 tag）改 YAML 后跑 check_taxonomy 全绿
即可，或增改本件重放迁移。
"""
from __future__ import annotations

import json
import re
import sys
from datetime import datetime, timezone
from pathlib import Path

import yaml

ROOT = Path(__file__).resolve().parents[3]          # kb_factory/
sys.path.insert(0, str(ROOT))

from catalog_engine.taxonomy import SIX_DOMAINS     # 只读引用（旧真源，不改动）
from catalog_engine.fibo_lex import TRUNK_MODULES, CLOSURE_MODULES  # 只读引用

SEEDS = ROOT / "seeds"
TAX = SEEDS / "taxonomy"
THUOCL = SEEDS / "thuocl"
FIBO = SEEDS / "fibo"

FORMAT_VERSION = "1.0.0"
TODAY = "2026-10-25"
_ID_RE = re.compile(r"^\d{2}_.+\.json$")
_MOD_RE = re.compile(r"^[A-Z][A-Z0-9]*\.json$")


def _dump(doc: dict, path: Path) -> None:
    """确定性写 YAML（保序、unicode、禁锚点展开流）。"""
    path.write_text(yaml.safe_dump(doc, allow_unicode=True, sort_keys=False,
                                    width=110, default_flow_style=False),
                    encoding="utf-8")


# ---------------------------------------------------------------- 1) 六库49分组
def census_slots() -> dict:
    """每分组槽位实测：扫 seeds/0*.json 蓝图，同名 l2 分组 file_count 求和。"""
    slots = {g: 0 for v in SIX_DOMAINS for g in v["groups"]}
    for path in sorted(SEEDS.iterdir()):
        if not _ID_RE.match(path.name):
            continue
        doc = json.loads(path.read_text(encoding="utf-8"))
        for l1 in doc.get("tree", {}).get("l1", []):
            for l2 in l1.get("l2", []) or []:
                if l2.get("name") in slots:
                    slots[l2["name"]] += int(l2.get("file_count", 0))
    return slots


def build_engineering() -> tuple[dict, dict]:
    """engineering_epc.yaml + before 计数（真源实读）。"""
    slots = census_slots()
    libs = []
    beforeGPL = {}
    for v in SIX_DOMAINS:
        kids = []
        for i, g in enumerate(v["groups"], start=1):
            kids.append({"type": "group", "id": f"{v['code']}-{i:02d}",
                         "name": g, "slots": slots[g]})
        libs.append({"type": "library", "id": v["code"], "name": v["name"],
                     "desc": v["desc"], "children": kids})
        beforeGPL[v["code"]] = len(v["groups"])
    doc = {
        "version": FORMAT_VERSION,
        "updated": TODAY,
        "kind": "taxonomy_seed_v1",
        "sources": [
            {"name": "Shopify/product-taxonomy", "url": "https://github.com/Shopify/product-taxonomy",
             "license": "MIT", "role": "制式蓝本（垂直域 YAML 三件套：tree/attributes/values）"},
            {"name": "总包智库 zhiku.js vaults", "path": "微信小程序/zongbao-ai/pages/zhiku/zhiku.js",
             "version": "v0.9.3", "role": "六库与 49 分组名逐字源（经 catalog_engine/taxonomy.py "
             "SIX_DOMAINS 实读，2026-10-21）", "license": "内部资产（不分发）"},
            {"name": "seeds/0*.json 蓝图槽位实测", "role": "每分组 slots 实测源（同名 l2 分组 "
             "file_count 求和；38 分组×10 槽出自律所 seeds/05，11 分组未实灌=0）"},
        ],
        "tree": {"type": "root", "id": "engineering_epc", "name": "工程总承包",
                 "children": libs},
        "attributes": {
            "root": {"id": {"type": "string", "required": True, "pattern": "^[a-z][a-z0-9_]*$"},
                     "name": {"type": "string", "required": True}},
            "library": {"id": {"type": "string", "required": True, "pattern": "^[A-Z]{2}$"},
                        "name": {"type": "string", "required": True, "vocab": "library_names"},
                        "desc": {"type": "string", "required": True}},
            "group": {"id": {"type": "string", "required": True, "pattern": "^[A-Z]{2}-[0-9]{2}$"},
                      "name": {"type": "string", "required": True, "vocab": "group_names"},
                      "slots": {"type": "integer", "required": True, "min": 0,
                                "desc": "蓝图实灌文件槽位数（seeds/0*.json 同名 l2 分组 file_count 之和；未实灌=0）"}},
        },
        "values": {
            "library_names": [v["name"] for v in SIX_DOMAINS],
            "group_names": [g for v in SIX_DOMAINS for g in v["groups"]],
        },
    }
    before = {"libraries": len(SIX_DOMAINS), "groups": sum(beforeGPL.values()),
              "groups_per_library": beforeGPL,
              "slots_per_group": slots, "slots_total": sum(slots.values())}
    return doc, before


def recount_engineering(doc: dict) -> dict:
    """after 计数：从落盘 YAML 结构实算（与 before 同形，逐项可对）。"""
    gpl, slots = {}, {}
    for lib in doc["tree"]["children"]:
        gpl[lib["id"]] = len(lib["children"])
        for g in lib["children"]:
            slots[g["name"]] = slots.get(g["name"], 0) + g["slots"]
    return {"libraries": len(doc["tree"]["children"]), "groups": sum(gpl.values()),
            "groups_per_library": gpl, "slots_per_group": slots,
            "slots_total": sum(slots.values())}


# ---------------------------------------------------------------- 2) THUOCL 摘要
def build_thuocl() -> tuple[dict, dict]:
    """thuocl_lexicon.yaml + before 计数（真源 _summary.json + 各域 JSON）。"""
    summary = json.loads((THUOCL / "_summary.json").read_text(encoding="utf-8"))
    domains = []
    for row in summary["domains"]:                      # 已按 domain_en 排序
        pj = json.loads((THUOCL / f"{row['domain_en']}.json").read_text(encoding="utf-8"))
        domains.append({"type": "domain", "id": row["domain_en"], "name": row["domain_cn"],
                        "word_count": row["word_count"], "skipped_lines": row["skipped_lines"],
                        "dropped_df_le1": row["dropped_df_le1"],
                        "raw_file": pj["raw_file"], "raw_sha256": pj["raw_sha256"],
                        "mapped_groups": list(row["mapped_groups"])})
    doc = {
        "version": FORMAT_VERSION,
        "updated": TODAY,
        "kind": "taxonomy_seed_v1",
        "sources": [
            {"name": "Shopify/product-taxonomy", "url": "https://github.com/Shopify/product-taxonomy",
             "license": "MIT", "role": "制式蓝本"},
            {"name": "thunlp/THUOCL", "url": "https://github.com/thunlp/THUOCL",
             "license": "MIT", "role": "领域词表上游（11 域；词数据本体仍在 seeds/thuocl/<域>.json，本件只迁摘要索引）"},
            {"name": "seeds/thuocl/_summary.json", "built_at": summary["built_at"],
             "role": "摘要真源（迁移 before 侧；built_at 原样固化供 loader 复原）"},
        ],
        "tree": {"type": "root", "id": "thuocl", "name": "THUOCL 领域词表",
                 "groups_total": summary["groups_total"],
                 "map_valid_pct": summary["map_valid_pct"],
                 "children": domains},
        "attributes": {
            "root": {"id": {"type": "string", "required": True, "pattern": "^[a-z][a-z0-9_]*$"},
                     "name": {"type": "string", "required": True},
                     "groups_total": {"type": "integer", "required": True, "min": 0,
                                      "desc": "六库分组总数（对账用，源自 _summary.json 同名字段）"},
                     "map_valid_pct": {"type": "integer", "required": True, "min": 0}},
            "domain": {"id": {"type": "string", "required": True, "pattern": "^[A-Za-z][A-Za-z0-9_]*$"},
                       "name": {"type": "string", "required": True, "vocab": "domain_names"},
                       "word_count": {"type": "integer", "required": True, "min": 0},
                       "skipped_lines": {"type": "integer", "required": True, "min": 0},
                       "dropped_df_le1": {"type": "integer", "required": True, "min": 0},
                       "raw_file": {"type": "string", "required": True,
                                    "pattern": "^THUOCL_[A-Za-z]+\\.txt$"},
                       "raw_sha256": {"type": "string", "required": True, "pattern": "^[0-9a-f]{64}$"},
                       "mapped_groups": {"type": "array", "required": True,
                                         "vocab_ref": "engineering_epc.yaml:values.group_names",
                                         "desc": "就近映射目标分组名（受控引用六库 49 分组词表）"}},
        },
        "values": {
            "domain_names": [d["domain_cn"] for d in summary["domains"]],
        },
    }
    before = {"domains": summary["domain_count"],
              "total_word_count": summary["total_word_count"],
              "per_domain_word_count": {r["domain_en"]: r["word_count"] for r in summary["domains"]},
              "skipped_lines": summary["skipped_lines"],
              "dropped_df_le1": summary["dropped_df_le1"],
              "mapping_edges": sum(len(r["mapped_groups"]) for r in summary["domains"]),
              "groups_hit": summary["groups_hit"]}
    return doc, before


def recount_thuocl(doc: dict) -> dict:
    per = {d["id"]: d["word_count"] for d in doc["tree"]["children"]}
    return {"domains": len(doc["tree"]["children"]),
            "total_word_count": sum(per.values()), "per_domain_word_count": per,
            "skipped_lines": sum(d["skipped_lines"] for d in doc["tree"]["children"]),
            "dropped_df_le1": sum(d["dropped_df_le1"] for d in doc["tree"]["children"]),
            "mapping_edges": sum(len(d["mapped_groups"]) for d in doc["tree"]["children"]),
            "groups_hit": len({g for d in doc["tree"]["children"] for g in d["mapped_groups"]})}


# ---------------------------------------------------------------- 3) FIBO 模块索引
def build_fibo() -> tuple[dict, dict]:
    """fibo_ontology.yaml + before 计数（真源模块 JSON + _zh_map + _fnd_common）。"""
    zh_map = json.loads((FIBO / "_zh_map.json").read_text(encoding="utf-8"))
    fnd = json.loads((FIBO / "_fnd_common.json").read_text(encoding="utf-8"))
    fibo_src = None
    mods, per_classes = [], {}
    stat_keys = None
    for path in sorted(FIBO.iterdir()):
        if not _MOD_RE.match(path.name):
            continue
        d = json.loads(path.read_text(encoding="utf-8"))
        if stat_keys is None:
            stat_keys = set(d["stats"])
        assert set(d["stats"]) == stat_keys, f"{path.name} stats 键族不齐: {set(d['stats'])}"
        if fibo_src is None:
            fibo_src = d["source"]
        else:
            assert d["source"] == fibo_src, f"{path.name} source 与他模块不一致"
        role = "trunk" if d["module"] in TRUNK_MODULES else (
            "closure" if d["module"] in CLOSURE_MODULES else None)
        assert role, f"{d['module']} 既非主干也非闭包（口径漂移，停）"
        node = {"type": "module", "id": d["module"], "name": d["module_zh"],
                "module_en": d["module_en"], "role": role, "note": d["note"]}
        node.update(d["stats"])                          # 8 项统计原样平铺（对账位）
        mods.append(node)
        per_classes[d["module"]] = d["stats"]["classes"]
    fnd_groups = [{"type": "fnd_common_group", "id": g["key"], "name": g["zh"],
                   "desc": g["desc"], "concepts": len(g["concepts"])} for g in fnd["groups"]]
    doc = {
        "version": FORMAT_VERSION,
        "updated": TODAY,
        "kind": "taxonomy_seed_v1",
        "sources": [
            {"name": "Shopify/product-taxonomy", "url": "https://github.com/Shopify/product-taxonomy",
             "license": "MIT", "role": "制式蓝本"},
            {"name": "EDMCouncil/fibo", "repo": fibo_src["repo"], "tag": fibo_src["tag"],
             "url": fibo_src["url"], "license": fibo_src["license"],
             "license_copyright": fibo_src["license_copyright"],
             "tarball_sha256": fibo_src["tarball_sha256"],
             "role": "本体上游（2625 概念数据仍在 seeds/fibo/<模块>.json；概念层级最深 11 级，"
                     "进不了 ≤3 级树制式，本件只迁模块索引）"},
            {"name": "seeds/fibo/_zh_map.json", "version": zh_map["version"],
             "entries": len(zh_map["entries"]),
             "role": "人工中文映射表 v1 台账位（entries=词数对账）"},
            {"name": "seeds/fibo/_fnd_common.json",
             "role": "FND 基座公共层真源（五概念组逐组概念计数入树）"},
        ],
        "tree": {"type": "root", "id": "fibo", "name": "FIBO 财务本体", "children": [
            {"type": "layer", "id": "modules", "name": "模块层", "children": mods},
            {"type": "layer", "id": "fnd_common", "name": "FND 基座公共层（六库可选）",
             "children": fnd_groups},
        ]},
        "attributes": _fibo_attributes(sorted(stat_keys)),
        "values": {
            "module_names": [m["name"] for m in mods],
            "module_roles": ["trunk", "closure"],
            "trunk_modules": list(TRUNK_MODULES),
            "closure_modules": list(CLOSURE_MODULES),
            "fnd_common_keys": [g["id"] for g in fnd_groups],
        },
    }
    before = {"modules": len(mods), "concepts": sum(per_classes.values()),
              "per_module_classes": per_classes,
              "trunk_modules": len(TRUNK_MODULES), "closure_modules": len(CLOSURE_MODULES),
              "zh_map_entries": len(zh_map["entries"]),
              "fnd_common_groups": len(fnd_groups),
              "fnd_common_concepts": sum(g["concepts"] for g in fnd_groups)}
    return doc, before


def _fibo_attributes(stat_keys: list) -> dict:
    """fibo 属性字典：统计 8 键平铺为 integer/number 属性（与模块 JSON stats 键族同构）。"""
    module = {
        "id": {"type": "string", "required": True, "pattern": "^[A-Z][A-Z0-9]*$"},
        "name": {"type": "string", "required": True, "vocab": "module_names"},
        "module_en": {"type": "string", "required": True},
        "role": {"type": "string", "required": True, "vocab": "module_roles"},
        "note": {"type": "string", "required": True},
    }
    for k in stat_keys:
        module[k] = ({"type": "number", "required": True, "min": 0} if k == "zh_rate"
                     else {"type": "integer", "required": True, "min": 0})
    return {
        "root": {"id": {"type": "string", "required": True, "pattern": "^[a-z][a-z0-9_]*$"},
                 "name": {"type": "string", "required": True}},
        "layer": {"id": {"type": "string", "required": True, "pattern": "^[a-z][a-z0-9_]*$"},
                  "name": {"type": "string", "required": True}},
        "module": module,
        "fnd_common_group": {"id": {"type": "string", "required": True, "pattern": "^[a-z][a-z0-9_]*$"},
                             "name": {"type": "string", "required": True},
                             "desc": {"type": "string", "required": True},
                             "concepts": {"type": "integer", "required": True, "min": 1}},
    }


def recount_fibo(doc: dict) -> dict:
    layers = {c["id"]: c for c in doc["tree"]["children"]}
    mods = layers["modules"]["children"]
    per = {m["id"]: m["classes"] for m in mods}
    fndg = layers["fnd_common"]["children"]
    return {"modules": len(mods), "concepts": sum(per.values()), "per_module_classes": per,
            "trunk_modules": sum(1 for m in mods if m["role"] == "trunk"),
            "closure_modules": sum(1 for m in mods if m["role"] == "closure"),
            "zh_map_entries": next(s["entries"] for s in doc["sources"] if s["name"].endswith("_zh_map.json")),
            "fnd_common_groups": len(fndg),
            "fnd_common_concepts": sum(g["concepts"] for g in fndg)}


# ---------------------------------------------------------------- 主链
def main() -> int:
    TAX.mkdir(parents=True, exist_ok=True)
    families = {}
    built = [("engineering_epc", *build_engineering()),
             ("thuocl_lexicon", *build_thuocl()),
             ("fibo_ontology", *build_fibo())]
    for name, doc, before in built:
        path = TAX / f"{name}.yaml"
        _dump(doc, path)
        after = ({"engineering_epc": recount_engineering,
                  "thuocl_lexicon": recount_thuocl,
                  "fibo_ontology": recount_fibo}[name])(
            yaml.safe_load(path.read_text(encoding="utf-8")))   # 落盘回读实算
        assert before == after, f"{name} 守恒破口:\nbefore={before}\nafter={after}"
        families[name] = {"yaml": path.name, "before": before, "after": after,
                          "conserved": True}

    # 校验器全库门（importlib 按路径加载，不搞包游戏）
    import importlib.util
    spec = importlib.util.spec_from_file_location("check_taxonomy", TAX / "check_taxonomy.py")
    ct = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(ct)
    errors = ct.validate_library(TAX)

    report = {
        "kind": "taxonomy_migrate_report", "version": FORMAT_VERSION,
        "migrated_at": datetime.now(timezone.utc).isoformat(timespec="seconds"),
        "generator": "seeds/taxonomy/_work/migrate_to_yaml.py",
        "format": "seeds/taxonomy/<垂直域>.yaml 三件套（tree/attributes/values + version/sources）",
        "discipline": "旧 JSON 种子一律保留不删；新制式为增量真源；loader(taxonomy_loader.py) YAML 优先缺则回退",
        "families": families,
        "validator_errors": len(errors),
        "conservation": "PASS" if all(f["conserved"] for f in families.values()) and not errors else "FAIL",
    }
    (TAX / "migrate_report.json").write_text(
        json.dumps(report, ensure_ascii=False, indent=1), encoding="utf-8")

    for name, _, before in built:
        head = {k: v for k, v in before.items() if not isinstance(v, dict)}
        print(f"CONSERVED {name}: {head}")
    print(f"VALIDATOR errors={len(errors)}")
    for e in errors:
        print("  ", e)
    print("CONSERVATION:", report["conservation"])
    return 0 if report["conservation"] == "PASS" else 1


if __name__ == "__main__":
    sys.exit(main())
