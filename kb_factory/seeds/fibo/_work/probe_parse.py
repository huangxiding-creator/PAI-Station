# -*- coding: utf-8 -*-
"""fibo 探针：纯 stdlib xml.etree 解析 _raw 下全部 .rdf，摸底类清单/父级闭包/规模。
只读不改，探明后即弃（对齐 gb/_work 探针纪律）。"""
import json
import sys
import xml.etree.ElementTree as ET
from collections import Counter
from pathlib import Path

RAW = Path(__file__).resolve().parents[1] / "_raw" / "fibo-master_2026Q3"
NS_OWL = "{http://www.w3.org/2002/07/owl#}"
NS_RDFS = "{http://www.w3.org/2000/01/rdf-schema#}"
NS_RDF = "{http://www.w3.org/1999/02/22-rdf-syntax-ns#}"
NS_SKOS = "{http://www.w3.org/2004/02/skos/core#}"
NS_CMNS_AV = "{https://www.omg.org/spec/Commons/AnnotationVocabulary/}"
FIBO_BASE = "https://spec.edmcouncil.org/fibo/ontology/"


def local_name(iri: str) -> str:
    """IRI 末段局部名：#/ 或 / 之后的最后一段。"""
    for sep in ("#", "/"):
        if sep in iri:
            tail = iri.rsplit(sep, 1)[-1]
            if tail:
                return tail
    return iri


classes = {}  # iri -> dict
deprecated = 0
files = sorted(RAW.rglob("*.rdf"))
for f in files:
    if f.name.startswith("All") or f.name.startswith("Metadata"):
        continue  # 聚合导入文件/元数据卡，无类定义
    try:
        root = ET.parse(str(f)).getroot()
    except ET.ParseError as e:
        print(f"PARSE_FAIL {f.relative_to(RAW)}: {e}")
        continue
    for el in root.iter():
        if el.tag != NS_OWL + "Class":
            continue
        iri = el.get(NS_RDF + "about")
        if not iri or not iri.startswith(FIBO_BASE):
            continue
        if el.get(NS_CMNS_AV + "deprecated") == "true" or el.get(NS_OWL + "deprecated") == "true":
            deprecated += 1
            continue
        parents = []
        for sub in el.findall(NS_RDFS + "subClassOf"):
            ref = sub.get(NS_RDF + "resource")
            if ref:  # 具名父类（匿名 Restriction 跳过）
                parents.append(ref)
        label = None
        for lab in el.findall(NS_SKOS + "prefLabel"):
            label = (lab.text or "").strip() or label
        rec = classes.get(iri) or {"iri": iri, "label": label, "parents": [], "file": str(f.relative_to(RAW)).replace("\\", "/")}
        if label:
            rec["label"] = label
        for p in parents:
            if p not in rec["parents"]:
                rec["parents"].append(p)
        classes[iri] = rec

print(f"files={len(files)} fibo_classes={len(classes)} deprecated_skipped={deprecated}")
mods = Counter(i[len(FIBO_BASE):].split("/", 1)[0] for i in classes)
print("per_module:", dict(sorted(mods.items())))

core = {"BE", "CAE", "FBC", "FND"}
fibo_parent_out = Counter()   # 四核心模块类的父类落在其他 fibo 模块 → 闭包缺口
ext_parent = Counter()        # 父类在 fibo 之外（OMG Commons 等）
resolved = 0
for iri, rec in classes.items():
    mod = iri[len(FIBO_BASE):].split("/", 1)[0]
    if mod not in core:
        continue
    for p in rec["parents"]:
        if p.startswith(FIBO_BASE):
            pmod = p[len(FIBO_BASE):].split("/", 1)[0]
            if pmod not in core:
                fibo_parent_out[pmod] += 1
            elif p in classes:
                resolved += 1
        else:
            ext_parent[p.rsplit("#", 1)[0].rsplit("/", 1)[-1]] += 1

print("core4_parent_into_other_fibo_modules:", dict(fibo_parent_out))
print("external_parent_prefix_top:", ext_parent.most_common(12))
# 核心四模块内部 fibo 父类缺失（非四模块、或不在类清单）
missing = []
for iri, rec in classes.items():
    mod = iri[len(FIBO_BASE):].split("/", 1)[0]
    if mod not in core:
        continue
    for p in rec["parents"]:
        if p.startswith(FIBO_BASE) and p[len(FIBO_BASE):].split("/", 1)[0] in core and p not in classes:
            missing.append((iri, p))
print("core4_missing_fibo_parents:", len(missing), missing[:5])
# 无 prefLabel 的类
nolabel = sum(1 for r in classes.values() if not r.get("label"))
print(f"no_preflabel={nolabel}")
# 根类（无任何 fibo 命名空间父类）在四模块中的数量
roots = sum(1 for iri, r in classes.items()
            if iri[len(FIBO_BASE):].split("/", 1)[0] in core
            and not any(p.startswith(FIBO_BASE) and p in classes for p in r["parents"]))
print("core4_roots(no_fibo_parent_in_registry)=", roots)
