# -*- coding: utf-8 -*-
"""brick 建筑本体词库加载器（v2.7 波B，巨人 BrickSchema/Brick，BSD-3，stdlib only 纯读）。

数据源（全部由 seeds/brick/_work/build_seeds.py 从 Brick v1.4.4 release 编译版 Brick.ttl
构建，零手填；中文化出自 seeds/brick/_zh_map.json 人工映射 v1，296 词）：
  seeds/brick/EQUIP.json   设备域 = brick:Equipment 子树（暖通空调/电气/给排水/消防/
                           电梯/安防/表计/自控，含 REC 互认 ICT 类），354 类；
  seeds/brick/LOC.json     空间域 = brick:Location 遗产词表（v1.4.4 已整体弃用，deprecated
                           如实标注）+ REC rec:Space 现行空间词表，227 类；
  seeds/brick/POINT.json   点域 = brick:Point 子树（传感器/设定值/命令/状态/报警/参数），
                           867 类；
  seeds/brick/CORE.json    基座闭包 = 元类/系统/环路/量/物质 + REC 资产/主体/事件/信息/
                           建筑构件，179 类（父级解析所需）；
  seeds/brick/LICENSE      BSD-3 许可证原件留档（Brick Consortium, Inc.）。
  合计 1627 类；id=前缀类名（如 "brick:Air_Handling_Unit"）——brick:/rec: 存在同名局部类
  （如 Room），故 id 必须带命名空间前缀。

纪律：
  - 确定性：纯读不写、无随机、无时钟；重复加载结果深度相等（幂等）。
  - 中文化如实：zh 只出自 manual_v1 映射；未映射概念 zh=None 如实保留英文标签。
  - 层级合法：parent/parents 必须可在注册表内解析（无孤儿）；本加载器对此做硬校验。
  - 弃用如实：brick 遗产位置类 v1.4.4 已弃用（迁移至 REC），deprecated=true 保留不剔除，
    供弹接口默认过滤弃用类。
  - 蓝图兼容：本词库为独立种子格式（kind=brick_domain_seed），不进入既有蓝图渲染链，
    新字段均为增量，不影响 v1/v2 双模式渲染。

接线说明（收口波专用，本波禁碰 engine.py/blueprint.py）：
  工程域蓝图（建筑工程/机电安装）L2 生成时混入 brick 术语供弹——在 blueprint.py 的
  L2 品目生成处调用本模块：
      from catalog_engine import brick_lex
      terms = brick_lex.engineering_terms(domains=("EQUIP", "LOC", "POINT"),
                                          max_depth=4, require_zh=True)
  返回 [{id, term, zh, en, domain, depth, deprecated}, ...]（term=zh or en，已过滤弃用类），
  按域并入 L2 品名/检索弹药；L3 细化层去掉 max_depth 限制、require_zh=False 以保留
  英文专业词。种子文件与 _zh_map.json 扩充后无需改 blueprint，重新构建即可。
"""
from __future__ import annotations

import json
import re
from pathlib import Path

SEEDS_DIR = Path(__file__).resolve().parents[1] / "seeds" / "brick"
LICENSE_FILE = SEEDS_DIR / "LICENSE"

# 主干三域（任务点名：建筑设备/空间/点）+ 闭包基座（父级解析所需），定序展示用
TRUNK_DOMAINS = ("EQUIP", "LOC", "POINT")
CLOSURE_DOMAINS = ("CORE",)
EXPECTED_DOMAINS = TRUNK_DOMAINS + CLOSURE_DOMAINS

_DOMAIN_FILE = re.compile(r"^(EQUIP|LOC|POINT|CORE)\.json$")

CONCEPT_KEYS = ("id", "en", "label_source", "zh", "zh_source", "iri",
                "domain", "namespace", "parent", "parents", "depth", "deprecated")

# IRI 命名空间契约（出处核验用）
NS_IRI = {
    "brick": "https://brickschema.org/schema/Brick#",
    "rec": "https://w3id.org/rec#",
}


def _read_json(path: Path) -> dict:
    """UTF-8 读 JSON（绝不写、绝不猜编码）。"""
    return json.loads(path.read_text(encoding="utf-8"))


def domain_files() -> list:
    """seeds/brick 下的域种子文件（<域码>.json），按文件名排序（确定性）。"""
    return sorted(p for p in SEEDS_DIR.iterdir() if _DOMAIN_FILE.match(p.name))


def load_domain(domain: str) -> dict:
    """读单个域种子（如 'EQUIP'）；缺文件抛 FileNotFoundError（如实失败，不静默空返）。"""
    path = SEEDS_DIR / f"{domain}.json"
    if not path.exists():
        raise FileNotFoundError(f"brick 域种子缺失: {path}")
    return _read_json(path)


def load_registry() -> dict:
    """合并全部域种子 → {"concepts": {id: rec}, "domains": {dom: meta}}。

    id 全局唯一是硬门：撞 id 直接抛 ValueError（层级引用的根基，不容静默覆盖）。
    """
    concepts: dict = {}
    domains: dict = {}
    for path in domain_files():
        doc = _read_json(path)
        if doc.get("kind") != "brick_domain_seed":
            raise ValueError(f"非 brick 域种子: {path.name} kind={doc.get('kind')!r}")
        dom = doc["domain"]
        for rec in doc["concepts"]:
            cid = rec["id"]
            if cid in concepts:
                raise ValueError(f"brick 概念 id 冲突: {cid}（{path.name} 与既有域重复）")
            concepts[cid] = rec
        domains[dom] = {
            "domain_zh": doc.get("domain_zh"),
            "domain_en": doc.get("domain_en"),
            "note": doc.get("note"),
            "source": doc.get("source"),
            "stats_meta": doc.get("stats"),
        }
    return {"concepts": concepts, "domains": domains}


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
    """层级合法门：无孤儿 / 无环 / depth 如实 / zh 源一致 / 英文标签非空 / 域一致 /
    deprecated 为布尔。返回问题清单。"""
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
        if rec["domain"] not in EXPECTED_DOMAINS:
            problems.append(f"unknown-domain:{cid}:{rec['domain']}")
        if rec["namespace"] != cid.split(":")[0] or not rec["iri"].startswith(
                NS_IRI.get(rec["namespace"], "\x00")):
            problems.append(f"iri-contract:{cid}")
        if not isinstance(rec["deprecated"], bool):
            problems.append(f"deprecated-not-bool:{cid}")
    return problems


def stats(registry: dict) -> dict:
    """实算统计（不信 meta，供与种子内 stats 对账——数字零造假）。"""
    concepts = registry["concepts"]
    per_domain: dict = {}
    for rec in concepts.values():
        d = per_domain.setdefault(rec["domain"], {"classes": 0, "zh_mapped": 0,
                                                  "roots": 0, "max_depth": 0,
                                                  "deprecated": 0})
        d["classes"] += 1
        if rec["zh"]:
            d["zh_mapped"] += 1
        if rec["parent"] is None:
            d["roots"] += 1
        d["max_depth"] = max(d["max_depth"], rec["depth"])
        if rec["deprecated"]:
            d["deprecated"] += 1
    for d in per_domain.values():
        d["zh_rate"] = round(d["zh_mapped"] / d["classes"], 4) if d["classes"] else 0.0
    n = len(concepts)
    mapped = sum(1 for r in concepts.values() if r["zh"])
    return {
        "domains": len(registry["domains"]),
        "concepts": n,
        "zh_mapped": mapped,
        "zh_rate": round(mapped / n, 4) if n else 0.0,
        "roots": sum(1 for r in concepts.values() if r["parent"] is None),
        "max_depth": max((r["depth"] for r in concepts.values()), default=0),
        "deprecated": sum(1 for r in concepts.values() if r["deprecated"]),
        "per_domain": dict(sorted(per_domain.items())),
    }


def children(registry: dict) -> dict:
    """主父类视角的子索引 {id: [子 id 排序]}（树渲染/扩库检索用）。"""
    kids: dict = {cid: [] for cid in registry["concepts"]}
    for cid, rec in registry["concepts"].items():
        if rec["parent"] in kids:
            kids[rec["parent"]].append(cid)
    return {cid: sorted(v) for cid, v in kids.items()}


def engineering_terms(domains=TRUNK_DOMAINS, max_depth=None,
                      require_zh=False, include_deprecated=False) -> list:
    """工程域蓝图 L2/L3 供弹接口（收口波接线点，见模块 docstring 接线说明）。

    返回按 (domain, depth, id) 全序的条目列表：
      {"id", "term"(=zh 或 en，未映射如实英文), "zh", "en", "domain", "depth", "deprecated"}
    默认过滤弃用类（brick 遗产位置词表）；require_zh=True 时只给已中文化类
    （L2 品名用），False 时全量（L3 深层专业词，英文如实保留）。
    """
    registry = load_registry()
    out = []
    for cid, rec in sorted(registry["concepts"].items(),
                           key=lambda kv: (kv[1]["domain"], kv[1]["depth"], kv[0])):
        if rec["domain"] not in domains:
            continue
        if not include_deprecated and rec["deprecated"]:
            continue
        if max_depth is not None and rec["depth"] > max_depth:
            continue
        if require_zh and not rec["zh"]:
            continue
        out.append({"id": cid, "term": rec["zh"] or rec["en"], "zh": rec["zh"],
                    "en": rec["en"], "domain": rec["domain"],
                    "depth": rec["depth"], "deprecated": rec["deprecated"]})
    return out
