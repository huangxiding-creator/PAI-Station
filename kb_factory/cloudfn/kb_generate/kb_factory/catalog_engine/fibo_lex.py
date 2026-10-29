# -*- coding: utf-8 -*-
"""fibo 财务本体词库加载器（v2.7 #8，巨人 EDMCouncil/fibo，MIT，stdlib only 纯读）。

数据源（全部由 seeds/fibo/_work/build_seeds.py 从 FIBO master_2026Q3 构建，零手填）：
  seeds/fibo/<模块>.json   8 个模块种子 = 主干五模块（BE 基础实体 / CAE 企业行为与事件
                           （任务命名 CA）/ FBC 金融业务与商务 / FND 基础概念基座 /
                           LOAN 贷款）+ 父级传递闭包（DER 衍生品 / IND 指数与指标 /
                           SEC 证券），共 2625 类；
  seeds/fibo/_fnd_common.json  FND 基座思想五概念组（机构/主体/文件/时间/量），
                           六域知识库可整体挂接的可选公共层；
  seeds/fibo/_zh_map.json  人工中文映射表 v1（manual_v1，340 词）。

纪律：
  - 确定性：纯读不写、无随机、无时钟；重复加载结果深度相等（幂等）。
  - 中文化如实：zh 只出自 manual_v1 映射；未映射概念 zh=None 如实保留英文标签。
  - 层级合法：parent/parents 必须可在注册表内解析（无孤儿）；本加载器对此做硬校验。
  - 蓝图兼容：本词库为独立种子格式（kind=fibo_module_seed），不进入既有蓝图渲染链，
    新字段均为增量，不影响 v1/v2 双模式渲染。
"""
from __future__ import annotations

import json
import re
from pathlib import Path

SEEDS_DIR = Path(__file__).resolve().parents[1] / "seeds" / "fibo"

# 主干五模块（任务点名）+ 闭包三模块（层级无孤儿所需），定序展示用
TRUNK_MODULES = ("BE", "CAE", "FBC", "FND", "LOAN")
CLOSURE_MODULES = ("DER", "IND", "SEC")
EXPECTED_MODULES = TRUNK_MODULES + CLOSURE_MODULES

_MODULE_FILE = re.compile(r"^[A-Z][A-Z0-9]*\.json$")

CONCEPT_KEYS = ("id", "en", "label_source", "zh", "zh_source", "iri",
                "module", "subdomain", "parent", "parents", "depth")


def _read_json(path: Path) -> dict:
    """UTF-8 读 JSON（绝不写、绝不猜编码）。"""
    return json.loads(path.read_text(encoding="utf-8"))


def module_files() -> list:
    """seeds/fibo 下的模块种子文件（<大写码>.json），按文件名排序（确定性）。"""
    return sorted(p for p in SEEDS_DIR.iterdir() if _MODULE_FILE.match(p.name))


def load_module(module: str) -> dict:
    """读单个模块种子（如 'FBC'）；缺文件抛 FileNotFoundError（如实失败，不静默空返）。"""
    path = SEEDS_DIR / f"{module}.json"
    if not path.exists():
        raise FileNotFoundError(f"fibo 模块种子缺失: {path}")
    return _read_json(path)


def load_registry() -> dict:
    """合并全部模块种子 → {"concepts": {id: rec}, "modules": {mod: meta}}。

    id 全局唯一是硬门：撞 id 直接抛 ValueError（层级引用的根基，不容静默覆盖）。
    """
    concepts: dict = {}
    modules: dict = {}
    for path in module_files():
        doc = _read_json(path)
        if doc.get("kind") != "fibo_module_seed":
            raise ValueError(f"非 fibo 模块种子: {path.name} kind={doc.get('kind')!r}")
        mod = doc["module"]
        for rec in doc["concepts"]:
            cid = rec["id"]
            if cid in concepts:
                raise ValueError(f"fibo 概念 id 冲突: {cid}（{path.name} 与既有模块重复）")
            concepts[cid] = rec
        modules[mod] = {
            "module_zh": doc.get("module_zh"),
            "module_en": doc.get("module_en"),
            "note": doc.get("note"),
            "source": doc.get("source"),
            "stats_meta": doc.get("stats"),
        }
    return {"concepts": concepts, "modules": modules}


def _chain_depth(concepts: dict, cid: str) -> int:
    """沿主父类链实算深度（迭代 + 环保护；环时返回 -1 作异常标记）。"""
    depth, guard = 0, set()
    cur = cid
    while True:
        rec = concepts[cur]
        parent = rec["parent"]
        if parent is None:
            return depth
        if parent not in concepts or parent in guard:
            return -1
        guard.add(parent)
        cur = parent
        depth += 1


def validate(registry: dict) -> list:
    """层级合法门：无孤儿 / 无环 / depth 如实 / zh 源一致 / 英文标签非空。返回问题清单。"""
    problems: list = []
    concepts = registry["concepts"]
    for cid, rec in sorted(concepts.items()):
        for ref in ([rec["parent"]] if rec["parent"] else []) + list(rec["parents"]):
            if ref not in concepts:
                problems.append(f"orphan:{cid}->{ref}")
        real = _chain_depth(concepts, cid)
        if real < 0:
            problems.append(f"cycle:{cid}")
        elif real != rec["depth"]:
            problems.append(f"depth-drift:{cid} stored={rec['depth']} real={real}")
        if not (rec["en"] or "").strip():
            problems.append(f"empty-label:{cid}")
        if bool(rec["zh"]) != (rec["zh_source"] == "manual_v1"):
            problems.append(f"zh-source-mismatch:{cid}")
    return problems


def stats(registry: dict) -> dict:
    """实算统计（不信 meta，供与种子内 stats 对账——数字零造假）。"""
    concepts = registry["concepts"]
    per_module: dict = {}
    for rec in concepts.values():
        m = per_module.setdefault(rec["module"], {"classes": 0, "zh_mapped": 0,
                                                  "roots": 0, "max_depth": 0})
        m["classes"] += 1
        if rec["zh"]:
            m["zh_mapped"] += 1
        if rec["parent"] is None:
            m["roots"] += 1
        m["max_depth"] = max(m["max_depth"], rec["depth"])
    for m in per_module.values():
        m["zh_rate"] = round(m["zh_mapped"] / m["classes"], 4) if m["classes"] else 0.0
    n = len(concepts)
    mapped = sum(1 for r in concepts.values() if r["zh"])
    return {
        "modules": len(registry["modules"]),
        "concepts": n,
        "zh_mapped": mapped,
        "zh_rate": round(mapped / n, 4) if n else 0.0,
        "roots": sum(1 for r in concepts.values() if r["parent"] is None),
        "max_depth": max((r["depth"] for r in concepts.values()), default=0),
        "per_module": dict(sorted(per_module.items())),
    }


def children(registry: dict) -> dict:
    """主父类视角的子索引 {id: [子 id 排序]}（树渲染/扩库检索用）。"""
    kids: dict = {cid: [] for cid in registry["concepts"]}
    for cid, rec in registry["concepts"].items():
        if rec["parent"] in kids:
            kids[rec["parent"]].append(cid)
    return {cid: sorted(v) for cid, v in kids.items()}


def fnd_common() -> dict:
    """FND 基座公共层（机构/主体/文件/时间/量 五概念组，六库可选挂接）。"""
    doc = _read_json(SEEDS_DIR / "_fnd_common.json")
    if doc.get("kind") != "fibo_fnd_common":
        raise ValueError("fnd_common kind 不符")
    return doc
