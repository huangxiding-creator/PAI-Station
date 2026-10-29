# -*- coding: utf-8 -*-
"""fibo 种子构建器：解析 _raw 下 FIBO RDF（纯 stdlib xml.etree，零第三方包），
取主干五模块（BE/CAE/FBC/FND/LOAN）+ fibo 父级传递闭包（DER/IND/SEC），
中文化按 _zh_map.json 人工映射表，落 seeds/fibo/<模块>.json 与 _fnd_common.json。

纪律：只新增不改删；全序确定性输出（同输入必同字节）；未映射概念如实保留英文。
任务口径「CA 企业法人」——FIBO 2026Q3 实际模块为 CAE（Corporate Actions and Events
企业行为与事件），企业法人本体在 BE/LegalEntities，已在 CAE.json meta 如实注明。
"""
import hashlib
import json
import re
import xml.etree.ElementTree as ET
from collections import Counter
from pathlib import Path

HERE = Path(__file__).resolve().parent            # seeds/fibo/_work
FIBO_DIR = HERE.parent                             # seeds/fibo
RAW = FIBO_DIR / "_raw" / "fibo-master_2026Q3"
TARBALL = FIBO_DIR / "_raw" / "fibo_master_2026Q3.tar.gz"
TAG = "master_2026Q3"
REPO = "EDMCouncil/fibo"
FIBO_BASE = "https://spec.edmcouncil.org/fibo/ontology/"
TRUNK = {"BE", "CAE", "FBC", "FND", "LOAN"}        # 主干五模块（任务点名 BE/CA(=CAE)/FBC + FND基座 + 贷款示例）
NS_OWL = "{http://www.w3.org/2002/07/owl#}"
NS_RDFS = "{http://www.w3.org/2000/01/rdf-schema#}"
NS_RDF = "{http://www.w3.org/1999/02/22-rdf-syntax-ns#}"
XML_LANG = "{http://www.w3.org/XML/1998/namespace}lang"

MODULE_ZH = {
    "BE": ("基础实体", "Business Entities"),
    "CAE": ("企业行为与事件", "Corporate Actions and Events"),
    "FBC": ("金融业务与商务", "Financial Business and Commerce"),
    "FND": ("基础概念基座", "Foundations"),
    "DER": ("衍生品", "Derivatives"),
    "IND": ("指数与指标", "Indices and Indicators"),
    "LOAN": ("贷款", "Loans"),
    "SEC": ("证券", "Securities"),
}

# FND 基座思想·五概念组（机构/主体/文件/时间/量）——六库可选公共层选目（硬校验：缺一即失败）
FND_COMMON_GROUPS = [
    ("organizations", "机构", "组织与机构形态：雇佣关系、法人组织、政府与公司族谱",
     ["Employee", "Employer", "Employment", "Group", "BusinessEntity",
      "FunctionalBusinessEntity", "Corporation", "JointStockCompany", "PubliclyHeldCompany",
      "PrivatelyHeldCompany", "JointVenture", "Partnership", "Trust", "CooperativeSociety",
      "NotForProfitOrganization", "NonGovernmentalOrganization", "GovernmentBody", "Government",
      "Branch", "Division", "HoldingCompany",
      "Subsidiary", "Affiliate", "Executive", "CorporateOfficer"]),
    ("parties", "主体", "参与方与角色：自然人、当事方、合同角色、控制关系",
     ["Person", "Adult", "Minor", "Signatory", "AuthorizedIndividual", "LegalAgent",
      "RegisteredAgent", "ThirdPartyAgent", "Buyer", "Counterparty", "TransactionParty",
      "ContractParty", "ContractThirdParty", "ControllingParty", "ControlledParty", "Owner",
      "Customer", "Investor", "Shareholder", "VotingShareholder", "Obligor", "Obligee",
      "SyndicateMember", "Servicer", "Comaker", "Issuer"]),
    ("documents", "文件", "文书与记录：合同文书、身份证件、报告与记录",
     ["ContractDocument", "IdentityDocument", "Passport", "BirthCertificate", "DriversLicense",
      "FinancialRecord", "Report", "TermSheet", "AssessmentReport", "Opinion", "Publication",
      "CreditReport", "IncomeVerificationReport", "PublicRecord", "Constitution"]),
    ("time", "时间", "时间与事件：发生、日程、循环间隔、营业日历与生命周期",
     ["Occurrence", "OccurrenceKind", "Schedule", "RegularSchedule", "RecurrenceInterval",
      "ExplicitRecurrenceInterval", "BusinessRecurrenceInterval", "BusinessDayConvention",
      "BusinessCalendar", "CalculatedDate", "RelativeDate", "SpecifiedDate", "AnchorDate",
      "Age", "CalendarPeriod", "CalculationPeriod", "TimeDirection", "LifecycleEvent",
      "LifecycleStage", "LifecycleStatus"]),
    ("quantities", "量", "量与度量：货币金额、统计度量、价格、利率与汇率",
     ["MonetaryAmount", "AmountOfMoney", "PercentageMonetaryAmount", "QuantitativeValue",
      "StatisticalMeasure", "QualifiedMeasure", "ScopedMeasure", "Formula", "Mean",
      "ArithmeticMean", "Dispersion", "Price", "MonetaryPrice", "InterestRate",
      "ExchangeRate", "Index", "Value", "Rating", "Yield", "CreditRating", "Exposure"]),
]


def camel_split(name: str) -> str:
    """CamelCase 局部名 → 空格分词英文标签（无 rdfs:label 时的兜底，label_source=derived）。"""
    return re.sub(r"(?<=[a-z0-9])(?=[A-Z])", " ", name).replace("_", " ").strip()


def parse_all():
    """解析全部域目录 .rdf（跳过 All*/Metadata* 聚合与元数据卡）。返回 iri -> rec。"""
    classes = {}
    files_used = 0
    for f in sorted(RAW.rglob("*.rdf")):
        rel = str(f.relative_to(RAW)).replace("\\", "/")
        top = rel.split("/", 1)[0]
        if top not in MODULE_ZH:          # 只解析可能进入闭包的域目录（BP/MD/ACTUS/EXMP 等不进）
            continue
        if f.name.startswith("All") or f.name.startswith("Metadata"):
            continue
        root = ET.parse(str(f)).getroot()
        hit = False
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
                if t and (label is None or lab.get(XML_LANG) == "en"):
                    label = t
            rec = classes.setdefault(iri, {"label": None, "parents": [], "file": rel})
            if label:
                rec["label"] = label
            for sub in el.findall(NS_RDFS + "subClassOf"):
                ref = sub.get(NS_RDF + "resource")     # 匿名 Restriction 无 resource，自然跳过
                if ref and ref not in rec["parents"]:
                    rec["parents"].append(ref)
            hit = True
        if hit:
            files_used += 1
    return classes, files_used


def closure(classes):
    """主干五模块的 fibo 命名空间父级传递闭包 → 发射模块集。"""
    mods = {iri[len(FIBO_BASE):].split("/", 1)[0] for iri in classes}
    emit = set(TRUNK)
    changed = True
    while changed:
        changed = False
        for iri, rec in classes.items():
            if iri[len(FIBO_BASE):].split("/", 1)[0] not in emit:
                continue
            for p in rec["parents"]:
                if p.startswith(FIBO_BASE):
                    pm = p[len(FIBO_BASE):].split("/", 1)[0]
                    if pm in mods and pm not in emit:
                        emit.add(pm)
                        changed = True
    return emit


def main():
    zh_map_doc = json.loads((FIBO_DIR / "_zh_map.json").read_text(encoding="utf-8"))
    zh_map = zh_map_doc["entries"]
    classes, files_used = parse_all()
    emit = closure(classes)
    sha = hashlib.sha256(TARBALL.read_bytes()).hexdigest()

    pool = {iri: rec for iri, rec in classes.items()
            if iri[len(FIBO_BASE):].split("/", 1)[0] in emit}

    # 局部名 → id 三级消歧（确定性）：裸局部名 → 加模块前缀 → 加子域 → IRI 哈希尾缀兜底
    local_counts = Counter(iri.rstrip("/").rsplit("/", 1)[-1] for iri in pool)
    def mod_of(iri):
        return iri[len(FIBO_BASE):].split("/", 1)[0]
    def sub_of(iri):
        rest = iri[len(FIBO_BASE):].split("/", 1)[1] if "/" in iri[len(FIBO_BASE):] else ""
        return rest.split("/", 1)[0] if "/" in rest else ""
    id_of = {}
    for iri in sorted(pool):
        local = iri.rstrip("/").rsplit("/", 1)[-1]
        id_of[iri] = local if local_counts[local] == 1 else f"{mod_of(iri)}.{local}"
    for _ in range(4):  # 极罕见情形（同模块同子域同名）迭代收敛
        seen = {}
        dup = False
        for iri, cid in sorted(id_of.items()):
            if cid in seen:
                a, b = seen[cid], iri
                for x in (a, b):
                    sub = sub_of(x)
                    id_of[x] = (f"{mod_of(x)}.{sub}.{id_of[x].rsplit('.', 1)[-1]}"
                                if sub else id_of[x] + "." + hashlib.sha256(x.encode()).hexdigest()[:6])
                dup = True
            else:
                seen[cid] = iri
        if not dup:
            break
    else:  # 兜底：唯一化失败则哈希尾缀（确定性）
        for iri, cid in sorted(id_of.items()):
            if sum(1 for c in id_of.values() if c == cid) > 1:
                id_of[iri] = cid + "." + hashlib.sha256(iri.encode()).hexdigest()[:6]
    collisions = sorted((cid, mod_of(i)) for i, cid in id_of.items() if "." in cid)

    # 概念记录 + 统计
    applied = set()
    concepts = {}
    ext_edges = Counter()
    for iri in sorted(pool):
        rec = pool[iri]
        mod = iri[len(FIBO_BASE):].split("/", 1)[0]
        rest = iri[len(FIBO_BASE):].split("/", 1)[1] if "/" in iri[len(FIBO_BASE):] else ""
        subdomain = rest.split("/", 1)[0] if "/" in rest else ""
        local = iri.rstrip("/").rsplit("/", 1)[-1]
        parents_in = []
        for p in rec["parents"]:
            if p.startswith(FIBO_BASE) and p in pool:
                parents_in.append(p)
            elif not p.startswith(FIBO_BASE):
                ext_edges[mod] += 1          # OMG Commons 等外部父类，如实计数后舍弃
        zh = zh_map.get(local)
        if zh:
            applied.add(local)
        concepts[iri] = {
            "id": id_of[iri],
            "en": rec["label"] or camel_split(local),
            "label_source": "rdfs:label" if rec["label"] else "derived",
            "zh": zh,
            "zh_source": "manual_v1" if zh else None,
            "iri": iri,
            "module": mod,
            "subdomain": subdomain,
            "parent": id_of[sorted(parents_in)[0]] if parents_in else None,   # 主父类=IRI 序最小（确定性）
            "parents": sorted(id_of[p] for p in parents_in),
        }

    # 深度（沿主父类上溯，环保护，id->iri 索引）
    iri_of = {c["id"]: i for i, c in concepts.items()}
    memo = {}
    def depth_by_id(cid, guard=()):
        if cid in memo:
            return memo[cid]
        if cid in guard:
            return 0                       # 环保护（FIBO 正常无环，防御性归零）
        c = concepts[iri_of[cid]]
        d = 0 if c["parent"] is None else 1 + depth_by_id(c["parent"], guard + (cid,))
        memo[cid] = d
        return d
    for c in concepts.values():
        c["depth"] = depth_by_id(c["id"])

    # 逐模块落盘
    out_files = []
    for mod in sorted(emit):
        zh_name, en_name = MODULE_ZH[mod]
        rows = sorted((c for c in concepts.values() if c["module"] == mod),
                      key=lambda c: (c["subdomain"], c["id"]))
        n = len(rows)
        mapped = sum(1 for c in rows if c["zh"])
        roots = sum(1 for c in rows if c["parent"] is None)
        multi = sum(1 for c in rows if len(c["parents"]) > 1)
        derived = sum(1 for c in rows if c["label_source"] == "derived")
        doc = {
            "kind": "fibo_module_seed",
            "module": mod,
            "module_zh": zh_name,
            "module_en": en_name,
            "note": ("任务命名 CA，FIBO 2026Q3 实际模块码为 CAE（企业行为与事件）；"
                     "企业法人本体在 BE/LegalEntities") if mod == "CAE" else
                    ("主干模块（任务点名）" if mod in TRUNK else "主干父级闭包纳入（层级无孤儿所需）"),
            "source": {
                "repo": REPO, "tag": TAG, "license": "MIT",
                "license_copyright": "Copyright (c) 2020 Enterprise Data Management Council",
                "url": f"https://github.com/{REPO}/tree/{TAG}",
                "tarball_sha256": sha,
            },
            "stats": {
                "classes": n, "zh_mapped": mapped,
                "zh_rate": round(mapped / n, 4) if n else 0.0,
                "roots": roots, "max_depth": max((c["depth"] for c in rows), default=0),
                "multi_parent_classes": multi, "derived_labels": derived,
                "external_parent_edges_dropped": ext_edges[mod],
            },
            "concepts": rows,
        }
        path = FIBO_DIR / f"{mod}.json"
        path.write_text(json.dumps(doc, ensure_ascii=False, indent=1), encoding="utf-8")
        out_files.append(path.name)

    # FND 基座公共层（六库可选·五概念组）
    reg = {c["id"]: c for c in concepts.values()}
    groups = []
    for key, zh, desc, ids in FND_COMMON_GROUPS:
        missing = [i for i in ids if i not in reg]
        if missing:
            raise SystemExit(f"FND_COMMON 组[{key}]选目缺类: {missing}")
        seen = []
        for i in ids:
            if i in seen:
                continue
            seen.append(i)
        groups.append({
            "key": key, "zh": zh, "desc": desc,
            "concepts": [{"id": i, "en": reg[i]["en"], "zh": reg[i]["zh"], "module": reg[i]["module"]}
                         for i in seen],
        })
    fnd_doc = {
        "kind": "fibo_fnd_common",
        "zh": "FIBO 基座公共层（六库可选）",
        "note": "FND 基座思想蒸馏：机构/主体/文件/时间/量 五概念组，六域知识库可整体挂接为可选公共层；"
                "概念实例逐条可在模块种子中按 id 追溯（含 IRI 与层级）。",
        "source": {
            "repo": REPO, "tag": TAG, "license": "MIT",
            "license_copyright": "Copyright (c) 2020 Enterprise Data Management Council",
            "url": f"https://github.com/{REPO}/tree/{TAG}",
            "tarball_sha256": sha,
        },
        "groups": groups,
    }
    (FIBO_DIR / "_fnd_common.json").write_text(
        json.dumps(fnd_doc, ensure_ascii=False, indent=1), encoding="utf-8")

    unused = sorted(set(zh_map) - applied)
    total = len(concepts)
    print(f"modules={sorted(emit)} files_parsed={files_used} classes={total}")
    print(f"zh_map entries={len(zh_map)} applied={len(applied)} unused={len(unused)} {unused}")
    print(f"zh_rate_total={round(len(applied) / total, 4)} collisions={collisions}")
    print(f"wrote: {out_files} + _fnd_common.json")


if __name__ == "__main__":
    main()
