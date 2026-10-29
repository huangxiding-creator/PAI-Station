# -*- coding: utf-8 -*-
"""SKOS 中间表示导出（KB-FACTORY v2.7 #15）。

巨人肩膀：NatLibFi/Skosmos（MIT）——SKOS 概念体系浏览器；本模块产出其可消费的
SKOS 中间表示（远期挂 Skosmos 浏览器浏览知识库蓝图与种子分类法）。词表本体
= W3C SKOS Core（http://www.w3.org/2004/02/skos/core#，标识符语境非请求）。

入口：
  to_skos(bp)              蓝图 tree → SKOS dict（@graph JSON-LD 兼容）
  from_taxonomy(yaml_path) seeds/taxonomy/<域>.yaml → SKOS（经 taxonomy_loader 读）
  to_jsonld / dump_jsonld / export_blueprint    JSON-LD 序列化与落盘
  validate_skos(sk)        结构合法性查（悬空 broader/缺 prefLabel/@id 重复/
                           顶层↔hasTopConcept 不闭合；纯本地结构查，非 W3C 全量校验）

蓝图 → SKOS 映射律：
  域（bp.domain）      → skos:ConceptScheme（prefLabel=域；hasTopConcept=L1 概念）
  L1/L2 容器节点       → skos:Concept（层级经 broader/narrower 双向落边，L1 顶层
                        概念带 topConceptOf；prefLabel=展示名——数字前缀按
                        blueprint.display_name 剥离，「01-堤防」→「堤防」）
  文件槽               → skos:Concept（叶层；files 优先、split_dirs 拍平——同
                        cataloging._group_slots 口径：分拆目录是文件系统扇出机制
                        非语义层，概念树深恒为 L1→L2→文件）
  notation（中图法类号）→ L1：code 是 CLC 22 大类字母（T/F/D…）直取；文件槽：
                        slot["catalog"]["clc_no"]；无来源不落键（禁编造类号）
  prefLabel            → 文件槽取 title（缺则 name）；容器取展示名
  altLabel             → slot["catalog"]["tags"] 数组原样（无 catalog 不落键）
  readme_slot          → 不入概念（v2 立法索引槽=指针卡非交付内容，同 stats 口径）

概念数守恒律：蓝图树节点数（L1 + L2 + 文件槽拍平，导览层计入——它就是 L1/L2/槽）
= Concept 数，一个不多一个不少（测试独立重数对账，不信本模块自述）。

@context 沿 schema_synth.py 既有 kb vocab 写法（kb=https://kb.zongbao.dev/vocab#）
——context 里的 URL 全部是标识符语境（IRI 命名空间），不发起任何网络请求。
纪律：纯 stdlib、零网络、零 LLM；无随机源无时钟，同输入必同输出；
纯读不改入参蓝图（to_skos 前后入参逐字节不变）。

接线说明（收口波挂 build 可选导出位；engine.py/blueprint.py 禁碰，本模块零接线）：
  在收口波构建产物落盘处（与 cataloging.dump_group_tsv / schema_synth.save_schema
  同位），可选挂一行：
      from catalog_engine.skos_export import export_blueprint
      path = export_blueprint(bp, out_dir)      # → <域>-skos.jsonld，返回路径
  建议开关 env KB_SKOS_EXPORT=1（默认关=既有 build 输出零漂移）；挂后 provenance
  记账（stage_log 追加一行）由收口波自行落，本模块不动 provenance——独立模块纪律。
"""
from __future__ import annotations

import copy
import json
import re
from pathlib import Path

from .blueprint import display_name
from .taxonomy import CLC_22

SKOS_NS = "http://www.w3.org/2004/02/skos/core#"          # W3C SKOS Core 命名空间
KB_VOCAB = "https://kb.zongbao.dev/vocab#"                # schema_synth.py 既有 kb vocab（同源不另起）
EXPORT_SUFFIX = "-skos.jsonld"                            # 导出件名尾（<域>-skos.jsonld）

# @context（schema_synth 式：前缀定义 + 术语映射；URL=标识符语境，零请求）
SKOS_CONTEXT = {
    "kb": KB_VOCAB,
    "skos": SKOS_NS,
    "prefLabel": {"@id": "skos:prefLabel"},
    "altLabel": {"@id": "skos:altLabel"},
    "notation": {"@id": "skos:notation"},
    "definition": {"@id": "skos:definition"},
    "inScheme": {"@id": "skos:inScheme", "@type": "@id"},
    "hasTopConcept": {"@id": "skos:hasTopConcept", "@type": "@id"},
    "topConceptOf": {"@id": "skos:topConceptOf", "@type": "@id"},
    "broader": {"@id": "skos:broader", "@type": "@id"},
    "narrower": {"@id": "skos:narrower", "@type": "@id"},
    "code": {"@id": "kb:code"},       # 蓝图 code / 槽 identifier（溯源键）
    "path": {"@id": "kb:path"},       # 蓝图节点 path / 槽全路径（溯源键）
    "slots": {"@id": "kb:slots"},     # 种子分组实测槽位数（taxonomy 侧真值）
}

_CLC_TOP = {c["code"] for c in CLC_22}                    # 中图法 22 大类字母
_SLUG_RE = re.compile(r"[\\/:*?\"<>|\s]+")


def _slug(text: str) -> str:
    """IRI/文件名安全形：空白与 Windows 非法字符压成 -，剥首尾，空回退 kb。"""
    s = _SLUG_RE.sub("-", str(text or "")).strip("-")
    return s or "kb"


def _group_slots(l2: dict) -> list:
    """L2 组文件槽（files 优先、分拆组拍平；同 cataloging._group_slots 口径，只读）。"""
    if l2.get("files"):
        return list(l2["files"])
    return [f for sd in l2.get("split_dirs") or [] for f in sd.get("files") or []]


def _scheme(domain: str) -> tuple:
    """造 ConceptScheme 骨架：返回 (scheme_id, scheme_node)。"""
    sid = f"kb:scheme/{_slug(domain)}"
    node = {"@id": sid, "@type": "skos:ConceptScheme",
            "prefLabel": domain, "hasTopConcept": []}
    return sid, node


# ── to_skos：蓝图树 → SKOS ─────────────────────────────────────────────────

def to_skos(bp: dict) -> dict:
    """蓝图 → SKOS dict（ConceptScheme(域) + Concept 层级 + notation/altLabel）。

    纯读：不改入参蓝图；确定性：概念 id 按树前序 kb:concept/1..N 逐个派发。
    树缺失/空树 → 仅 ConceptScheme（防御不崩，零概念如实可查）。"""
    if not isinstance(bp, dict):
        raise ValueError("bp 必须是 dict")
    domain = str(bp.get("domain") or "").strip() or "kb"
    sid, scheme = _scheme(domain)
    graph = [scheme]
    counter = [0]

    def _next_id() -> str:
        counter[0] += 1
        return f"kb:concept/{counter[0]}"

    tree = bp.get("tree")
    l1_nodes = tree.get("l1") if isinstance(tree, dict) else None
    if not isinstance(l1_nodes, list):
        return _wrap(scheme, graph)                        # 缺树=仅 scheme（不造结构）

    for l1 in l1_nodes:
        if not isinstance(l1, dict):
            continue
        c1 = _next_id()
        code = str(l1.get("code") or "")
        node = {"@id": c1, "@type": "skos:Concept",
                "prefLabel": display_name(l1),
                "inScheme": {"@id": sid}, "topConceptOf": {"@id": sid}}
        if code in _CLC_TOP:                               # L1 大类字母 → notation（直取）
            node["notation"] = code
        if code:
            node["code"] = code
        if l1.get("path"):
            node["path"] = str(l1["path"])
        children = []
        for l2 in l1.get("l2") or []:
            if not isinstance(l2, dict):
                continue
            slots = _group_slots(l2)
            c2 = _next_id()                                # 前序派发：L2 先、槽后，确定性编号
            slot_ids = [_next_id() for _ in slots]
            n2 = {"@id": c2, "@type": "skos:Concept",
                  "prefLabel": display_name(l2),
                  "inScheme": {"@id": sid}, "broader": {"@id": c1}}
            if l2.get("code"):
                n2["code"] = str(l2["code"])
            if l2.get("path"):
                n2["path"] = str(l2["path"])
            if slot_ids:
                n2["narrower"] = [{"@id": i} for i in slot_ids]
            graph.append(n2)
            children.append(c2)
            for s, sid_slot in zip(slots, slot_ids):
                graph.append(_slot_concept(s, sid_slot, sid, c2))
        if children:
            node["narrower"] = [{"@id": i} for i in children]
        scheme["hasTopConcept"].append({"@id": c1})
        graph.append(node)
    return _wrap(scheme, graph)


def _slot_concept(slot: dict, cid: str, scheme_id: str, parent_id: str) -> dict:
    """文件槽 → 叶概念：prefLabel(title)/notation(catalog.clc_no)/altLabel(tags)。"""
    name = str(slot.get("name") or "")
    node = {"@id": cid, "@type": "skos:Concept",
            "prefLabel": str(slot.get("title") or name),
            "inScheme": {"@id": scheme_id}, "broader": {"@id": parent_id}}
    cat = slot.get("catalog") if isinstance(slot.get("catalog"), dict) else {}
    clc = str(cat.get("clc_no") or "").strip()
    if clc:                                                # 有类号才落（禁编造）
        node["notation"] = clc
    tags = [str(t) for t in (cat.get("tags") or []) if str(t).strip()]
    if tags:                                               # altLabel=受控标签数组
        node["altLabel"] = tags
    ident = str(slot.get("identifier") or "")
    if ident:
        node["code"] = ident
    if slot.get("path") or name:
        node["path"] = f"{slot.get('path') or ''}{name}"
    return node


def _wrap(scheme: dict, graph: list) -> dict:
    return {"@context": copy.deepcopy(SKOS_CONTEXT), "@graph": graph}


# ── from_taxonomy：种子分类法 YAML → SKOS ──────────────────────────────────

_EPC_STEM = "engineering_epc"                              # 六库 49 分组家族（loader 有回退链）


def _loader():
    """taxonomy_loader 兼容导入：kb_factory 包式（仓库根上级在 path）与
    顶层目录式（kb_factory/ 在 path）两种部署都可。"""
    try:
        from kb_factory import taxonomy_loader as tl
    except ImportError:                                    # catalog_engine 作顶层包导入时
        import taxonomy_loader as tl
    return tl


def from_taxonomy(yaml_path) -> dict:
    """seeds/taxonomy/<域>.yaml → SKOS（经 taxonomy_loader 读，供远期 Skosmos 浏览器）。

    - YAML 在位：loader._load_yaml 读器直读 tree（YAML≡旧真源由
      test_taxonomy_migration 的深度相等契约保证），通用树走读：root→ConceptScheme，
      children 递归→Concept；notation=节点 id、definition=desc、kb:slots=slots、
      altLabel=mapped_groups——全部 YAML 真值，无名节点如实跳过不编造。
    - YAML 缺位：engineering_epc 家族回退 loader.six_domains()（loader 既有回退链，
      旧真源产同形六库 49 分组 SKOS——缺文件不缺结构）；其余家族如实
      FileNotFoundError（不静默造数据）。"""
    p = Path(yaml_path)
    tl = _loader()
    doc = tl._load_yaml(p.name, p.parent)                  # loader 读器：缺/坏文件→None
    if doc is not None:
        return _skos_from_seed(doc, fallback_label=p.stem)
    if p.stem == _EPC_STEM:
        return _skos_from_six_domains(tl.six_domains(p.parent), p.stem)
    raise FileNotFoundError(f"taxonomy seed 不存在且无回退: {p}")


def _skos_from_seed(doc: dict, fallback_label: str) -> dict:
    """taxonomy_seed_v1 通用树走读（engineering_epc/thuocl/fibo 三家族同律）。"""
    root = doc.get("tree") if isinstance(doc.get("tree"), dict) else {}
    label = str(root.get("name") or fallback_label or "taxonomy").strip()
    sid, scheme = _scheme(label)
    graph = [scheme]
    counter = [0]

    def walk(nodes: list, parent_id):
        out = []
        for node in nodes:
            if not isinstance(node, dict):
                continue
            label_n = str(node.get("name") or "").strip()
            if not label_n:                                # 无名节点不入概念（在库 YAML 均有名）
                continue
            counter[0] += 1
            cid = f"kb:concept/{counter[0]}"
            concept = {"@id": cid, "@type": "skos:Concept", "prefLabel": label_n,
                       "inScheme": {"@id": sid}}
            if parent_id is None:
                concept["topConceptOf"] = {"@id": sid}
                scheme["hasTopConcept"].append({"@id": cid})
            else:
                concept["broader"] = {"@id": parent_id}
            nid = node.get("id")
            if isinstance(nid, str) and nid.strip():
                concept["notation"] = nid.strip()          # 分组真 id（MK/KN-01/…）
            desc = node.get("desc")
            if isinstance(desc, str) and desc.strip():
                concept["definition"] = desc.strip()
            if isinstance(node.get("slots"), int):
                concept["slots"] = node["slots"]           # 实测槽位（kb vocab 真值）
            mg = node.get("mapped_groups")
            if isinstance(mg, list):
                tags = [str(g) for g in mg if str(g).strip()]
                if tags:
                    concept["altLabel"] = tags             # THUOCL 域的映射分组
            kids = [c for c in (node.get("children") or []) if isinstance(c, dict)]
            sub = walk(kids, cid)
            if sub:
                concept["narrower"] = [{"@id": i} for i in sub]
            graph.append(concept)
            out.append(cid)
        return out

    walk([c for c in (root.get("children") or []) if isinstance(c, dict)], None)
    return _wrap(scheme, graph)


def _skos_from_six_domains(domains: list, label: str) -> dict:
    """YAML 缺位回退：loader.six_domains()（六库 [{code,name,desc,groups}]）→ SKOS。
    loader 公共 API 不携分组 id → 分组概念无 notation（如实，loader 契约限制在案）。"""
    sid, scheme = _scheme(label)
    scheme["definition"] = "六库 49 分组（YAML 缺位，经 taxonomy_loader 回退旧真源）"
    graph = [scheme]
    counter = [0]

    def _next():
        counter[0] += 1
        return f"kb:concept/{counter[0]}"

    for dom in domains:
        if not isinstance(dom, dict):
            continue
        name = str(dom.get("name") or "").strip()
        if not name:
            continue                                       # 无名域如实跳过
        c1 = _next()
        node = {"@id": c1, "@type": "skos:Concept", "prefLabel": name,
                "inScheme": {"@id": sid}, "topConceptOf": {"@id": sid}}
        if dom.get("code"):
            node["notation"] = str(dom["code"])
        if dom.get("desc"):
            node["definition"] = str(dom["desc"])
        kids = []
        for g in dom.get("groups") or []:
            c2 = _next()
            gn = {"@id": c2, "@type": "skos:Concept", "prefLabel": str(g),
                  "inScheme": {"@id": sid}, "broader": {"@id": c1}}
            graph.append(gn)
            kids.append(c2)
        if kids:
            node["narrower"] = [{"@id": i} for i in kids]
        scheme["hasTopConcept"].append({"@id": c1})
        graph.append(node)
    return _wrap(scheme, graph)


# ── JSON-LD 序列化与落盘 ───────────────────────────────────────────────────

def to_jsonld(sk: dict) -> str:
    """JSON-LD 文本序列化（utf-8 直出中文，indent=2；确定性键序=构造序）。"""
    return json.dumps(sk, ensure_ascii=False, indent=2)


def dump_jsonld(sk: dict, path) -> str:
    """落盘 JSON-LD 工件（自动建父目录），返回路径字符串。"""
    p = Path(path)
    p.parent.mkdir(parents=True, exist_ok=True)
    p.write_text(to_jsonld(sk) + "\n", encoding="utf-8")
    return str(p)


def export_blueprint(bp: dict, out_dir, filename: str | None = None) -> str:
    """收口波可选导出位：蓝图 → <域>-skos.jsonld（to_skos + 落盘一站式）。"""
    sk = to_skos(bp)
    domain = str((bp or {}).get("domain") or "").strip() or "kb"
    fname = filename or f"{_slug(domain)}{EXPORT_SUFFIX}"
    return dump_jsonld(sk, Path(out_dir) / fname)


# ── 结构合法性查（防环护栏的 SKOS 对应物；纯本地，非 W3C 全量校验）──────────

def _types(node: dict) -> set:
    t = node.get("@type")
    return {t} if isinstance(t, str) else set(t or [])


def _ref(value):
    """{"@id": x} / "x" → x（宽容读引用）。"""
    if isinstance(value, dict):
        return value.get("@id")
    return value if isinstance(value, str) else None


def validate_skos(sk: dict) -> list:
    """SKOS 结构查：@context/@graph 齐、@id 唯一、恰一 ConceptScheme、概念
    prefLabel 非空、inScheme 归一、broader/narrower 不悬空且互逆、顶层概念与
    hasTopConcept 双向闭合、无 broader 者必为顶层。返回问题清单（空=健康）。"""
    problems = []
    if not isinstance(sk, dict):
        return ["顶层非 dict"]
    ctx = sk.get("@context")
    if not isinstance(ctx, dict) or "skos" not in ctx:
        problems.append("缺 @context 或 skos 前缀定义")
    graph = sk.get("@graph")
    if not isinstance(graph, list) or not graph:
        problems.append("@graph 缺失或为空")
        return problems

    seen, ids = set(), set()
    for n in graph:
        if not isinstance(n, dict) or not n.get("@id"):
            problems.append("节点缺 @id")
            continue
        if n["@id"] in seen:
            problems.append(f"@id 重复: {n['@id']}")
        seen.add(n["@id"])
        ids.add(n["@id"])
    schemes = [n for n in graph if isinstance(n, dict)
               and "skos:ConceptScheme" in _types(n)]
    if len(schemes) != 1:
        problems.append(f"ConceptScheme 应恰 1 个，实得 {len(schemes)}")
        return problems
    scheme = schemes[0]
    sid = scheme["@id"]
    concepts = [n for n in graph if isinstance(n, dict)
                and "skos:Concept" in _types(n)]
    cids = {c["@id"] for c in concepts}
    tops = {r for r in (_ref(x) for x in (scheme.get("hasTopConcept") or [])) if r}
    narrow = {c["@id"]: {r for r in (_ref(x) for x in (c.get("narrower") or [])) if r}
              for c in concepts}

    for t in tops - cids:
        problems.append(f"hasTopConcept 悬空: {t}")
    for c in concepts:
        cid = c["@id"]
        label = c.get("prefLabel")
        if not isinstance(label, str) or not label.strip():
            problems.append(f"概念 {cid} 缺 prefLabel")
        ins = _ref(c.get("inScheme"))
        if ins != sid:
            problems.append(f"概念 {cid} inScheme 非 {sid}")
        br = _ref(c.get("broader"))
        tc = _ref(c.get("topConceptOf"))
        if br is None:
            if tc != sid:
                problems.append(f"概念 {cid} 无 broader 且非 topConceptOf")
            elif cid not in tops:
                problems.append(f"概念 {cid} 自称顶层但不在 hasTopConcept")
        else:
            if tc is not None:
                problems.append(f"概念 {cid} 同时带 broader 与 topConceptOf")
            elif br == sid:
                problems.append(f"概念 {cid} broader 指向 ConceptScheme")
            elif br not in cids:
                problems.append(f"概念 {cid} broader 悬空: {br}")
            elif cid not in narrow.get(br, set()):
                problems.append(f"概念 {cid} broader {br} 未回指 narrower")
        for r in narrow[cid] - cids:
            problems.append(f"概念 {cid} narrower 悬空: {r}")
    return problems
