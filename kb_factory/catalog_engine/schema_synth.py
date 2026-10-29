# -*- coding: utf-8 -*-
"""Schema 先行合成器 —— 调研 Top 模式 #1（AutoSchemaKG）。

流程：语料概念化 → 推导三层 schema（上层/领域/应用）→ 再按 schema 做类型化抽取。
- 输入: DocFile 兼容对象列表（duck-typing，仅需 .title/.doc_type；
  document_engine.DocFile 直接可用，缺字段回退「其他」）
- 输出: DomainSchema —— 独立可评审的 JSON-LD 工件（save_schema 落盘，非内嵌蓝图）
stdlib only。
"""
from __future__ import annotations

import json
import re
from collections import Counter
from dataclasses import dataclass
from pathlib import Path

SCHEMA_VERSION = "1.0"

# ── 上层概念：doc_type → 层。与 document_engine.TRANSCEND_LAYERS 对齐；
#    「其他」= 不可分类，刻意不映射（正是 validate_schema 的 unclassified 来源）──
UPPER_LAYERS = [
    {"name": "合规底线", "desc": "法律法规与强制性标准——必须遵守的红线",
     "doc_types": ["法律法规", "国家标准"]},
    {"name": "技术标准", "desc": "行业技术标准与规范——工作开展的技术依据",
     "doc_types": ["行业标准", "国际标准", "技术规范"]},
    {"name": "操作实务", "desc": "案例、模板、操作指南——从理论到实践的桥梁",
     "doc_types": ["案例实务", "培训教材", "模板范本"]},
    {"name": "参考工具", "desc": "手册、图集、工具书——日常查阅的案头书",
     "doc_types": ["工具书"]},
]

# ── 应用类型：文档体裁归一化词汇表 ──
APPLICATION_TYPE_OF = {
    "法律法规": "法规",
    "国家标准": "标准项", "国际标准": "标准项", "行业标准": "标准项", "技术规范": "标准项",
    "案例实务": "案例", "培训教材": "案例",
    "模板范本": "模板",
    "工具书": "工具书",
}
APPLICATION_TYPE_ORDER = ["标准项", "法规", "案例", "模板", "工具书"]

_TYPE_TO_UPPER = {dt: layer["name"] for layer in UPPER_LAYERS for dt in layer["doc_types"]}

# ── 领域概念提取（TF 高频术语聚类）─────────────────────────────────────────
_CJK_RUN = re.compile(r"[一-鿿]+")
_MIN_SUBSTR = 2                  # 最短子串长度
_MIN_DF = 2                      # 文档频率门：至少出现于 2 个标题
_MAX_CONCEPTS = 8
_MAX_TERMS = 3

# 展示名修剪尾巴：种子名以通用词收尾时循环截短（水利水电工程施工→水利水电）
_NAME_TRIM_TAILS = ("工程", "技术", "施工", "组织", "通用", "设计")

# 停用词：纯体裁词/通用行政词——TF 再高也不是领域概念（精确匹配）
_CONCEPT_STOP = {
    "规范", "标准", "条例", "办法", "细则", "指南", "手册", "图集", "教程", "教材",
    "讲义", "课件", "范本", "模板", "合同", "协议", "案例", "实务", "操作", "实战",
    "实例", "表格",
    "管理", "设计", "施工", "组织", "安全", "技术", "工程", "建设", "项目", "监测",
    "验收", "勘察", "规划", "划分", "通用", "实用", "专业", "行业", "国家", "计价",
    "管理规范", "设计规范", "施工规范", "计价规范", "技术规程", "管理办法", "管理条例",
    "建设工程", "建设项目", "安全技术", "安全生产", "工程施工",
    "中华", "人民", "共和", "人民共和国", "中华人民共和", "中华人民共和国", "中国", "中华人民",
}

# 体裁尾巴：以此收尾的复合碎片（计规范/坝设计规范/总承包管理）不是领域概念
_GENRE_TAILS = ("规范", "标准", "条例", "办法", "细则", "指南", "规程", "手册", "图集",
                "范本", "模板", "教材", "案例", "分析", "实务", "操作", "管理", "计价")


@dataclass
class DomainSchema:
    """三层领域 schema（上层概念 / 领域概念 / 应用类型）。"""

    upper: list[str]                # 上层概念（合规底线/技术标准/操作实务/参考工具）
    domain_concepts: list[dict]     # [{"name","parent","terms","doc_count"}]
    application_types: list[str]    # 应用类型（标准项/法规/案例/模板/工具书）
    raw: dict                       # 完整 JSON-LD 兼容结构（独立工件）
    version: str = SCHEMA_VERSION


# ── 内部工具 ───────────────────────────────────────────────────────────────
def _titles(documents: list) -> list:
    return [getattr(d, "title", "") or "" for d in documents]


def _doc_types(documents: list) -> list:
    return [getattr(d, "doc_type", "") or "其他" for d in documents]


def _title_substrings(title: str) -> set:
    """标题 CJK 片段的全部 ≥2 字子串（不设上限 ⇒ 极大重复短语挖掘；
    非 CJK 如 GB/T、EPC 天然被切掉）。"""
    subs = set()
    for run in _CJK_RUN.findall(title):
        for i in range(len(run)):
            for j in range(i + _MIN_SUBSTR, len(run) + 1):
                subs.add(run[i:j])
    return subs


def _sub_or_super(a: str, b: str) -> bool:
    return a in b or b in a


def _trim_name(seed: str, df: dict) -> str:
    """展示名修剪：循环剥掉通用尾巴，要求每次截短形自身 df≥_MIN_DF。"""
    name = seed
    while True:
        for tail in _NAME_TRIM_TAILS:
            stem = name[:-len(tail)]
            if name.endswith(tail) and len(stem) >= 2 \
                    and stem not in _CONCEPT_STOP and len(df.get(stem, ())) >= _MIN_DF:
                name = stem
                break
        else:
            return name


def _is_boundary_window(g: str, s: set, df: dict) -> bool:
    """等频超串判碎片（极大重复短语挖掘核心）：g 是某等频更长子串的子串
    ⇔ g 的每次出现都被同一更长短语完全吞没 ⇒ 跨词边界窗口。

    例 华人民共和国 ⊂ 中华人民共和国 且两者 df 相同 ⇒ 碎片；
       水利水电工程 无等频超串（更长形 df 均更低）⇒ 极大真词。
    """
    return any(h != g and g in h and len(df[h]) == len(s) for h in df)


def _jaccard(a: set, b: set) -> float:
    union = a | b
    return len(a & b) / len(union) if union else 0.0


def _majority_upper(doc_idx: list, doc_types: list) -> str:
    """概念父层 = 其成员文档 doc_type 的多数上层（平票按语料顺序先到先得）。

    成员全部不可分类时返回 ""（语料无上层概念，schema 中省略 broader）。
    """
    votes = Counter(_TYPE_TO_UPPER[doc_types[i]] for i in doc_idx
                    if doc_types[i] in _TYPE_TO_UPPER)
    return votes.most_common(1)[0][0] if votes else ""


def _extract_concepts(titles: list, doc_types: list) -> list[dict]:
    """TF 高频术语聚类 → 领域概念（名称/父层/术语）。stdlib 无分词器，防碎片三招：

    1) 候选 = df≥_MIN_DF、非停用词、非体裁尾巴收尾、且无等频超串的标题 CJK 子串
       （极大重复短语：中华人民共和国 吞灭 华人民共和国 等边界窗口）；
    2) 选种 = df 降序（同频取长词）；与已选互为子/超串时，更长且支持度≥75%者替换
       （更具体优先：水电 df8 ← 水利水电工程 df6=75%；75% 门同时阻断
       df 6→4→2 的链式侵蚀，弱超串并入原概念）；Jaccard≥0.5 的近重复跳过；
    3) 展示名修剪 + 同名合并：循环剥通用尾巴（水利水电工程施工组织设计→水利水电），
       修剪后撞名的种子合并文档集重算；
    术语 = [名] + 种子文档内共现≥_MIN_DF 的其余候选（含子/超串表面变体），取前 _MAX_TERMS。
    """
    subs_by_doc = [_title_substrings(t) for t in titles]
    df: dict[str, set] = {}
    for i, subs in enumerate(subs_by_doc):
        for g in subs:
            df.setdefault(g, set()).add(i)

    cands = {g: s for g, s in df.items()
             if len(s) >= _MIN_DF and g not in _CONCEPT_STOP
             and not g.endswith(_GENRE_TAILS)
             and not _is_boundary_window(g, s, df)}

    seeds: list[tuple[str, set]] = []
    for g, s in sorted(cands.items(), key=lambda x: (-len(x[1]), -len(x[0]), x[0])):
        hit = next(((k, h, hs) for k, (h, hs) in enumerate(seeds)
                    if _sub_or_super(g, h)), None)
        if hit:
            k, h, hs = hit
            if h in g and len(s) * 4 >= len(hs) * 3:   # 更长更具体且支持度≥75% → 替换
                seeds[k] = (g, s)
            continue
        if any(_jaccard(s, hs) >= 0.5 for _, hs in seeds):
            continue
        seeds.append((g, s))
        if len(seeds) >= _MAX_CONCEPTS:
            break

    # 展示名修剪 + 同名合并（水利水电工程施工→水利水电，与水利水电种子合并文档集）
    merged: dict[str, set] = {}
    for seed, s in seeds:
        name = _trim_name(seed, df)
        merged[name] = merged.get(name, set()) | s

    concept_names = set(merged)
    concepts = []
    for name, doc_set in merged.items():
        co: Counter = Counter()
        for i in doc_set:
            for g in subs_by_doc[i]:
                co[g] += 1
        terms = [name] + [g for g, _ in sorted(
                     ((g, c) for g, c in co.items()
                      if c >= _MIN_DF and g in cands and g not in concept_names),
                     key=lambda x: (-x[1], -len(x[0]), x[0]))][:_MAX_TERMS]
        concepts.append({
            "name": name,
            "parent": _majority_upper(sorted(doc_set), doc_types),
            "terms": terms,
            "doc_count": len(doc_set),
        })
    concepts.sort(key=lambda c: (-c["doc_count"], c["name"]))
    return concepts


def _build_raw(upper: list, concepts: list[dict], app_types: list[str],
               n_docs: int, type_counts: Counter) -> dict:
    """组装 JSON-LD 兼容的完整 schema 结构（@context/@type/@id + broader 引用）。"""
    upper_ids = {name: f"kb:upper/{i}" for i, name in enumerate(upper, 1)}
    upper_nodes = [
        {"@id": upper_ids[layer["name"]], "@type": "kb:UpperConcept",
         "name": layer["name"], "description": layer["desc"],
         "docTypes": [dt for dt in layer["doc_types"] if dt in type_counts]}
        for layer in UPPER_LAYERS if layer["name"] in upper
    ]
    concept_nodes = []
    for i, c in enumerate(concepts, 1):
        node = {"@id": f"kb:concept/{i}", "@type": "kb:DomainConcept",
                "name": c["name"], "terms": c["terms"], "docCount": c["doc_count"]}
        if c["parent"] in upper_ids:
            node["broader"] = {"@id": upper_ids[c["parent"]]}
        concept_nodes.append(node)
    app_nodes = [
        {"@id": f"kb:app/{name}", "@type": "kb:ApplicationType", "name": name,
         "docTypes": sorted(dt for dt, app in APPLICATION_TYPE_OF.items()
                            if app == name and dt in type_counts)}
        for name in app_types
    ]
    return {
        "@context": {
            "kb": "https://kb.zongbao.dev/vocab#",
            "name": "http://schema.org/name",
            "broader": {"@id": "http://www.w3.org/2004/02/skos/core#broader",
                        "@type": "@id"},
        },
        "@type": "kb:DomainSchema",
        "name": "领域知识库 Schema",
        "version": SCHEMA_VERSION,
        "upper": upper_nodes,
        "domain_concepts": concept_nodes,
        "application_types": app_nodes,
        "stats": {"documents": n_docs, "doc_types": dict(type_counts)},
    }


# ── 对外 API ───────────────────────────────────────────────────────────────
def synthesize_schema(documents: list) -> DomainSchema:
    """从 DocFile 列表合成三层领域 schema。

    按文件类型分组识别上层概念；从标题 TF 高频术语聚类提取领域概念；
    输出独立可评审的 JSON-LD 工件（DomainSchema.raw）。
    """
    titles = _titles(documents)
    doc_types = _doc_types(documents)
    type_counts = Counter(t for t in doc_types if t in _TYPE_TO_UPPER)

    upper = [layer["name"] for layer in UPPER_LAYERS
             if any(dt in type_counts for dt in layer["doc_types"])]
    app_types = [app for app in APPLICATION_TYPE_ORDER
                 if app in {APPLICATION_TYPE_OF[dt] for dt in type_counts}]
    concepts = _extract_concepts(titles, doc_types)
    raw = _build_raw(upper, concepts, app_types, len(documents), type_counts)
    return DomainSchema(upper=upper, domain_concepts=concepts,
                        application_types=app_types, raw=raw)


def validate_schema(schema: DomainSchema, documents: list) -> dict:
    """检查 schema 覆盖率：文档能被 doc_type 归入某上层，或标题命中概念术语。"""
    known_types = {dt for node in schema.raw.get("upper", [])
                   for dt in node.get("docTypes", [])}
    terms = [t for c in schema.domain_concepts for t in c.get("terms", []) if t]

    unclassified = []
    for title, dtype in zip(_titles(documents), _doc_types(documents)):
        if dtype not in known_types and not any(t in title for t in terms):
            unclassified.append(title)

    n = len(documents)
    coverage = round((n - len(unclassified)) / n, 2) if n else 0.0
    nodes = len(schema.upper) + len(schema.domain_concepts) + len(schema.application_types)
    return {"coverage": coverage, "unclassified": unclassified, "schema_nodes": nodes}


def save_schema(schema: DomainSchema, path) -> str:
    """把 schema 落盘为独立可评审 JSON 工件，返回路径字符串。"""
    p = Path(path)
    p.write_text(json.dumps(schema.raw, ensure_ascii=False, indent=2), encoding="utf-8")
    return str(p)


def load_schema(path) -> DomainSchema:
    """从独立 JSON 工件重建 DomainSchema（save_schema 的逆操作）。"""
    raw = json.loads(Path(path).read_text(encoding="utf-8"))
    return DomainSchema(
        upper=[n["name"] for n in raw.get("upper", [])],
        domain_concepts=[{"name": n["name"],
                          "parent": _id_to_name(raw, (n.get("broader") or {}).get("@id", "")),
                          "terms": list(n["terms"]), "doc_count": n.get("docCount", 0)}
                         for n in raw.get("domain_concepts", [])],
        application_types=[n["name"] for n in raw.get("application_types", [])],
        raw=raw,
        version=raw.get("version", SCHEMA_VERSION),
    )


def _id_to_name(raw: dict, node_id: str) -> str:
    for node in raw.get("upper", []):
        if node["@id"] == node_id:
            return node["name"]
    return ""
