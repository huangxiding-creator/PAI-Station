# -*- coding: utf-8 -*-
"""brick 种子构建器：解析 _raw/Brick_v1.4.4.ttl（v1.4.4 release 编译版，纯 stdlib 行式解析），
取建筑设备/空间/点(传感器)三域 + 父级闭包基座，按 _zh_map.json 人工映射中文化，
落 seeds/brick/{EQUIP,LOC,POINT,CORE}.json。

纪律：只新增不改删；全序确定性输出（同输入必同字节）；未映射类如实保留英文（zh=None）；
brick 遗产位置词表 v1.4.4 已整体弃用（迁移至 REC 空间词表），deprecated=true 如实标注不剔除。

域划分（优先级 EQUIP > LOC > POINT > CORE，互斥完备）：
  EQUIP  设备域   = brick:Equipment 子树（含 v1.4 与 REC 互认的 ICT/控制器类）
  LOC    空间域   = brick:Location 子树（遗产，全量 deprecated）∪ rec:Space 子树（现行）
  POINT  点域     = brick:Point 子树（传感器/设定值/命令/状态/报警/参数）
  CORE   基座闭包 = 其余全部（元类/系统/环路/量/物质 + REC 资产/主体/事件/信息/构件）
"""
import hashlib
import json
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent          # seeds/brick/_work
BRICK_DIR = HERE.parent                          # seeds/brick
RAW = BRICK_DIR / "_raw" / "Brick_v1.4.4.ttl"
sys.path.insert(0, str(HERE))
from probe_parse import parse  # noqa: E402

REPO = "BrickSchema/Brick"
TAG = "v1.4.4"
ASSET_SHA256 = "b65720b7b9b64c646745c689777e6138c0d59ce0088df0aeb78fbd444d04d8e7"
NS_EXPAND = {
    "brick": "https://brickschema.org/schema/Brick#",
    "rec": "https://w3id.org/rec#",
}
DOMAIN_META = {
    "EQUIP": ("设备域", "Building Equipment",
              "建筑设备类层级：暖通空调/电气/给排水/消防/电梯/安防/表计/自控设备（含 v1.4 与 REC 互认类）"),
    "LOC": ("空间域", "Location and Space",
            "空间词表双轨：brick:Location 遗产类（v1.4.4 已整体弃用，deprecated 如实标注）+ "
            "REC rec:Space 现行空间类（房间/楼层/园区），供建筑工程库对照使用"),
    "POINT": ("点域", "Points (Sensors, Setpoints, Commands, Status, Alarms, Parameters)",
              "点位类层级：传感器/设定值/命令/状态/报警/参数——楼宇自控与机电安装调试的核心词汇"),
    "CORE": ("基座闭包", "Closure Base",
             "父级闭包基座：Brick 元类(Entity/Class)/系统/环路/量/物质 + REC 资产/主体/事件/信息/建筑构件"),
}


def load_registry():
    subs = parse()
    # 散述行兜底：列 0 的「<s> owl:deprecated true ;」也在编译版中存在
    import re
    dep_re = re.compile(r"^(\S+)\s+owl:deprecated\s+true\s*;")
    for line in RAW.open(encoding="utf-8"):
        m = dep_re.match(line)
        if m and m.group(1) in subs:
            subs[m.group(1)]["deprecated"] = True
    classes = {s: r for s, r in subs.items()
               if s.split(":")[0] in ("brick", "rec")
               and ("rdfs:Class" in r["types"] or "owl:Class" in r["types"])}
    # 域划分
    kids = {}
    for s, r in classes.items():
        for p in r["parents"]:
            if p in classes:
                kids.setdefault(p, []).append(s)

    def closure(root):
        seen, stack = set(), [root]
        while stack:
            n = stack.pop()
            for k in kids.get(n, []):
                if k not in seen:
                    seen.add(k)
                    stack.append(k)
        return seen

    equip = closure("brick:Equipment") | {"brick:Equipment"}
    loc = (closure("brick:Location") | {"brick:Location",
                                        "rec:Space"}) | closure("rec:Space")
    point = closure("brick:Point") | {"brick:Point"}

    def domain_of(cid):
        if cid in equip:
            return "EQUIP"
        if cid in loc:
            return "LOC"
        if cid in point:
            return "POINT"
        return "CORE"

    # 主父链深度（首个可解析父；硬失败于环）
    depth_memo = {}

    def depth(cid, guard=None):
        if cid in depth_memo:
            return depth_memo[cid]
        guard = guard or set()
        rec_ = classes[cid]
        resolvable = [p for p in rec_["parents"] if p in classes]
        if not resolvable:
            d = 0
        else:
            p = resolvable[0]
            if p in guard:
                raise SystemExit(f"父链成环: {cid} -> {p}")
            guard.add(cid)
            d = 1 + depth(p, guard)
        depth_memo[cid] = d
        return d

    zh_doc = json.loads((BRICK_DIR / "_zh_map.json").read_text(encoding="utf-8"))
    zh_map = zh_doc["entries"]
    unknown = [k for k in zh_map if k not in classes]
    if unknown:
        raise SystemExit(f"_zh_map 键不在类集: {sorted(unknown)}")

    concepts, external_edges = {}, 0
    for cid, r in classes.items():
        ns, local = cid.split(":", 1)
        resolvable = [p for p in r["parents"] if p in classes]
        external_edges += len(r["parents"]) - len(resolvable)
        concepts[cid] = {
            "id": cid,
            "en": r["label"],
            "label_source": "rdfs:label",
            "zh": zh_map.get(cid),
            "zh_source": "manual_v1" if cid in zh_map else None,
            "iri": NS_EXPAND[ns] + local,
            "domain": domain_of(cid),
            "namespace": ns,
            "parent": resolvable[0] if resolvable else None,
            "parents": resolvable,
            "depth": depth(cid),
            "deprecated": bool(r["deprecated"]),
        }
    return concepts, external_edges


def stats_of(concepts):
    per = {}
    for c in concepts.values():
        m = per.setdefault(c["domain"], {"classes": 0, "zh_mapped": 0, "roots": 0,
                                         "max_depth": 0, "deprecated": 0,
                                         "multi_parent_classes": 0})
        m["classes"] += 1
        m["zh_mapped"] += 1 if c["zh"] else 0
        m["roots"] += 1 if c["parent"] is None else 0
        m["max_depth"] = max(m["max_depth"], c["depth"])
        m["deprecated"] += 1 if c["deprecated"] else 0
        m["multi_parent_classes"] += 1 if len(c["parents"]) > 1 else 0
    for m in per.values():
        m["zh_rate"] = round(m["zh_mapped"] / m["classes"], 4) if m["classes"] else 0.0
    return per


def main():
    sha = hashlib.sha256(RAW.read_bytes()).hexdigest()
    if sha != ASSET_SHA256:
        raise SystemExit(f"tarball sha256 漂移: {sha}")
    concepts, external_edges = load_registry()
    per = stats_of(concepts)
    for dom in ("EQUIP", "LOC", "POINT", "CORE"):
        sub = sorted((c for c in concepts.values() if c["domain"] == dom),
                     key=lambda c: c["id"])
        doc = {
            "kind": "brick_domain_seed",
            "domain": dom,
            "domain_zh": DOMAIN_META[dom][0],
            "domain_en": DOMAIN_META[dom][1],
            "note": DOMAIN_META[dom][2],
            "source": {
                "repo": REPO,
                "tag": TAG,
                "license": "BSD-3-Clause",
                "license_copyright": "Copyright (c) 2016-2026, Brick Consortium, Inc.",
                "url": f"https://github.com/{REPO}/releases/tag/{TAG}",
                "asset": "Brick.ttl（release 编译版，含 Brick+REC 对齐）",
                "asset_sha256": ASSET_SHA256,
                "license_file": "seeds/brick/LICENSE",
            },
            "stats": per[dom],
            "concepts": sub,
        }
        out = BRICK_DIR / f"{dom}.json"
        out.write_text(json.dumps(doc, ensure_ascii=False, indent=1) + "\n",
                       encoding="utf-8", newline="\n")
        print(f"{out.name}: classes={per[dom]['classes']} zh={per[dom]['zh_mapped']} "
              f"({per[dom]['zh_rate']}) roots={per[dom]['roots']} "
              f"max_depth={per[dom]['max_depth']} deprecated={per[dom]['deprecated']}")
    n = len(concepts)
    mapped = sum(1 for c in concepts.values() if c["zh"])
    # 注册表级无孤儿硬门
    orphans = [c["id"] for c in concepts.values()
               if any(p and p not in concepts for p in c["parents"])]
    if orphans:
        raise SystemExit(f"孤儿父引用: {orphans[:5]}")
    print(f"TOTAL classes={n} zh_mapped={mapped} "
          f"zh_rate={round(mapped / n, 4)} external_edges_dropped={external_edges}")
    if n < 800:
        raise SystemExit(f"导入类数 {n} < 800 门")


if __name__ == "__main__":
    main()
