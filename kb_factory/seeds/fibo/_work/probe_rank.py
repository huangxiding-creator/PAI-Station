# -*- coding: utf-8 -*-
"""fibo 探针2：rdfs:label/owl:deprecated 修正版解析 + 按子孙数中枢度排名，
输出核心五模块(BE/CAE/FBC/FND/DER)候选映射清单（local_name|label|module|descendants|depth）。"""
import xml.etree.ElementTree as ET
from collections import Counter
from pathlib import Path

RAW = Path(__file__).resolve().parents[1] / "_raw" / "fibo-master_2026Q3"
NS_OWL = "{http://www.w3.org/2002/07/owl#}"
NS_RDFS = "{http://www.w3.org/2000/01/rdf-schema#}"
NS_RDF = "{http://www.w3.org/1999/02/22-rdf-syntax-ns#}"
FIBO_BASE = "https://spec.edmcouncil.org/fibo/ontology/"
CORE = {"BE", "CAE", "FBC", "FND", "DER"}

classes = {}
for f in sorted(RAW.rglob("*.rdf")):
    if f.name.startswith("All") or f.name.startswith("Metadata"):
        continue
    try:
        root = ET.parse(str(f)).getroot()
    except ET.ParseError:
        continue
    for el in root.iter():
        if el.tag != NS_OWL + "Class":
            continue
        iri = el.get(NS_RDF + "about")
        if not iri or not iri.startswith(FIBO_BASE):
            continue
        if any((d.text or "").strip().lower() == "true" for d in el.findall(NS_OWL + "deprecated")):
            continue
        label = None
        for lab in el.findall(NS_RDFS + "label"):
            t = (lab.text or "").strip()
            if t and (label is None or lab.get("{http://www.w3.org/XML/1998/namespace}lang") == "en"):
                label = t
        rec = classes.setdefault(iri, {"label": label, "parents": []})
        if label:
            rec["label"] = label
        for sub in el.findall(NS_RDFS + "subClassOf"):
            ref = sub.get(NS_RDF + "resource")
            if ref and ref not in rec["parents"]:
                rec["parents"].append(ref)

ln = {}
for iri in classes:
    mod = iri[len(FIBO_BASE):].split("/", 1)[0]
    if mod not in CORE:
        continue
    tail = iri.rstrip("/").rsplit("/", 1)[-1].rsplit("#", 1)[-1]
    ln[tail] = iri  # 局部名在核心五模块内唯一性观察
dups = [k for k, v in Counter(i.rstrip("/").rsplit("/", 1)[-1] for i in classes
        if i[len(FIBO_BASE):].split("/", 1)[0] in CORE).items() if v > 1]
print("dup_local_names:", len(dups), dups[:8])

# 子孙数 + 深度
kids = {i: [] for i in classes}
for i, r in classes.items():
    for p in r["parents"]:
        if p in classes:
            kids[p].append(i)
desc = {}
for i in classes:
    seen, st = set(), [i]
    while st:
        x = st.pop()
        for k in kids[x]:
            if k not in seen:
                seen.add(k)
                st.append(k)
    desc[i] = len(seen) - 1
depth = {}
for i in classes:
    d, cur, guard = 0, i, set()
    while True:
        ps = [p for p in classes[cur]["parents"] if p in classes]
        if not ps:
            break
        cur = ps[0]
        if cur in guard:
            break
        guard.add(cur)
        d += 1
    depth[i] = d

rows = [(i, classes[i]["label"], i[len(FIBO_BASE):].split("/", 1)[0], desc[i], depth[i])
        for i in classes if i[len(FIBO_BASE):].split("/", 1)[0] in CORE]
rows.sort(key=lambda r: (-r[3], r[4], r[0]))
out = Path(__file__).resolve().parent / "_rank_core5.txt"
out.write_text("\n".join(f"{i.rstrip('/').rsplit('/', 1)[-1]}|{lab}|{m}|desc={d}|dep={dp}"
                         for i, lab, m, d, dp in rows), encoding="utf-8")
print(f"core5_classes={len(rows)} total={len(classes)} wrote {out.name} lines={len(rows)}")
multi = sum(1 for i in classes if sum(1 for p in classes[i]['parents'] if p in classes) > 1)
print("multi_parent_fibo_classes(all modules):", multi)
