# -*- coding: utf-8 -*-
"""multistore（P2 #7）——类型化多库 + 路由（MIRIX / Akasha / claude-memory-compiler 模式）。

KB 不再是一棵平面树，而是四个类型化库 + 路由规则 + 跨库引用：
  registry   核心登记库：标准清单/法规目录/制度文件（权威、稳定）
  events     事件流库：案例/事故/变更记录/新闻（时效、按时间线）
  semantic   语义知识库：方法/流程/指南/最佳实践（演进、可更新）
  resources  资源库：模板/工具/数据集/软件（可直接使用）

确定性纪律（同 catalog_engine）：无随机源、无时钟；同输入必同输出。

P2 并行期说明：本模块经 try 导入兄弟任务 document_engine.DocFile；当工作副本尚未
合入该文件时，使用下方字段逐一对齐的本地兜底，保证独立可测。合入后兜底即失效。
"""
from __future__ import annotations

import copy
import re
from dataclasses import dataclass, asdict
from typing import Optional

MULTISTORE_VERSION = "kb-multistore/1.0.0"

try:
    from .document_engine import DocFile, classify_doc  # 主干版（合入后常态）
    _classify_doc = classify_doc
except ImportError:  # P2 并行期：本分支未含兄弟任务文件
    _classify_doc = None
    @dataclass
    class DocFile:  # 与 document_engine.DocFile 字段逐一对齐，勿增删
        title: str
        source: str = "wenku"          # wenku / gb / ima / local
        fmt: str = "pdf"
        pages: Optional[int] = None
        badge: str = "green_free"
        perm: str = "green"
        url: Optional[str] = None
        doc_type: str = "其他"
        size_kb: int = 500


# ── 四库定义 ────────────────────────────────────────────────────────────

STORE_REGISTRY = "registry"    # 核心登记库：标准清单/法规目录/制度文件（权威、稳定）
STORE_EVENTS = "events"        # 事件流库：案例/事故/变更记录/新闻（时效、按时间线）
STORE_SEMANTIC = "semantic"    # 语义知识库：方法/流程/指南/最佳实践（演进、可更新）
STORE_RESOURCES = "resources"  # 资源库：模板/工具/数据集/软件（可直接使用）

STORE_ORDER = (STORE_REGISTRY, STORE_EVENTS, STORE_SEMANTIC, STORE_RESOURCES)

STORES_META = {
    STORE_REGISTRY: {"name": "核心登记库", "traits": "权威、稳定",
                     "desc": "标准清单/法规目录/制度文件"},
    STORE_EVENTS: {"name": "事件流库", "traits": "时效、按时间线",
                   "desc": "案例/事故/变更记录/新闻"},
    STORE_SEMANTIC: {"name": "语义知识库", "traits": "演进、可更新",
                     "desc": "方法/流程/指南/最佳实践"},
    STORE_RESOURCES: {"name": "资源库", "traits": "可直接使用",
                      "desc": "模板/工具/数据集/软件"},
}

# ── 路由规则（标题特征优先级链 R1→R5，R6 为 doc_type 兜底+默认库） ────────
# 关键取向：文档的"本质特征"（法规形态/案例/指南）先于标准号引用——
# 『SL 253-2018某重力坝裂缝事故案例』是事件（只是引用了标准号），不是标准本身；
# 这正是跨库引用的来源：事件库里的案例 ↔ 登记库里的 SL 253。

ROUTING_RULES = [
    {"id": "R1", "store": STORE_REGISTRY, "priority": 1,
     "patterns": [r"(?<![工方算])(?:法|条例|办法|规定|细则|制度)》?$",   # 法规/制度后缀（工法/方法/算法除外）
                  r"(?:标准|规范|规程)$"],                          # 权威技术文件后缀
     "match": "法规/制度后缀（法/条例/办法/规定/细则/制度）| 权威后缀（标准/规范/规程）",
     "desc": "以权威文件形态收尾的登记性事实进核心登记库"},
    {"id": "R2", "store": STORE_EVENTS, "priority": 2,
     "patterns": [r"案例", r"事故", r"事件", r"复盘", r"调查报告", r"通报", r"纪实",
                  r"警示", r"教训", r"变更", r"新闻", r"实录", r"特稿", r"汇编"],
     "match": "案例|事故|事件|复盘|调查报告|通报|纪实|警示|教训|变更|新闻|实录|特稿|汇编",
     "desc": "带时间属性的一次性事实进事件流库（优先于标准号与资源库：『合同纠纷案例』是事件不是模板）"},
    {"id": "R3", "store": STORE_SEMANTIC, "priority": 3,
     "patterns": [r"指南", r"导则", r"指引", r"流程", r"方法", r"最佳实践",
                  r"作业指导", r"教程", r"培训", r"课件", r"讲义", r"工法"],
     "match": "指南|导则|指引|流程|方法|最佳实践|作业指导|教程|培训|课件|讲义|工法",
     "desc": "『怎么做』的演进性知识进语义库（无权威后缀的指南/导则不进登记库，与 classify_doc 的『技术规范』分流）"},
    {"id": "R4", "store": STORE_REGISTRY, "priority": 4,
     "patterns": [r"(?<![A-Za-z])(?:GB|SL|DL|JGJ|JT|TB|CJJ|ISO|IEC|ASTM|EN|DIN|WS|YY|NB)"
                  r"(?:/T)?\s*\d{2,5}"],
     "match": "标准号（GB/SL/DL/JGJ/ISO…，位置任意）",
     "desc": "弱特征：题名带标准号而无事件/指南本质 → 登记库（bare 编号件如『ISO 9001 质量管理体系要求』）"},
    {"id": "R5", "store": STORE_RESOURCES, "priority": 5,
     "patterns": [r"模板", r"范本", r"合同", r"协议", r"文书", r"手册", r"图集",
                  r"表格", r"工具", r"软件", r"数据集", r"定额", r"结算书"],
     "match": "模板|范本|合同|协议|文书|手册|图集|表格|工具|软件|数据集|定额|结算书",
     "desc": "拿来即用的成品件进资源库"},
    {"id": "R6", "store": STORE_SEMANTIC, "priority": 6, "kind": "fallback",
     "fallback_by_doc_type": {
         "国家标准": STORE_REGISTRY, "行业标准": STORE_REGISTRY, "国际标准": STORE_REGISTRY,
         "法律法规": STORE_REGISTRY, "技术规范": STORE_REGISTRY,
         "案例实务": STORE_EVENTS, "培训教材": STORE_SEMANTIC,
         "模板范本": STORE_RESOURCES, "工具书": STORE_RESOURCES,
     },
     "default": STORE_SEMANTIC,
     "desc": "标题特征全未命中时按 classify_doc 的 doc_type 兜底；仍未知默认落语义库"},
]

_STD_CODE_RE = re.compile(ROUTING_RULES[3]["patterns"][0])

_RULE_CHAIN = [(r["store"], r["patterns"]) for r in ROUTING_RULES if r.get("patterns")]

# 跨库共享特征词（常量序=确定性；命中同一特征的不同库文件自动建交叉引用）
XREF_KEYWORDS = (
    "大坝", "重力坝", "土石坝", "水电站", "水库", "水利", "水电", "防洪", "安全", "监测",
    "质量", "EPC", "工程总承包", "总承包", "造价", "计量", "招投标", "合同", "监理",
    "施工", "混凝土", "结算", "变更", "移民", "环保",
)
MAX_XREFS = 80  # 确定性上限，防特征词过热导致引用爆炸


# ── 路由 ────────────────────────────────────────────────────────────────

def _field(doc, name, default=None):
    """DocFile 属性 / dict 键 双态取值。"""
    if isinstance(doc, dict):
        return doc.get(name, default)
    return getattr(doc, name, default)


def _doc_title(doc) -> str:
    if doc is None:
        raise TypeError("doc 不能为 None，须为 DocFile（或含 title 键的 dict）")
    title = _field(doc, "title")
    if not isinstance(title, str) or not title.strip():
        raise TypeError("doc.title 必须是非空 str")
    return title.strip()


def route_document(doc) -> str:
    """按文件类型+内容特征把文档路由到四库之一，返回库代码。

    优先级：R1 法规/权威后缀 → R2 事件流 → R3 语义 → R4 标准号弱特征
    → R5 资源 → R6 doc_type 兜底 → 默认语义库。
    """
    title = _doc_title(doc)
    for store, patterns in _RULE_CHAIN:
        for p in patterns:
            if re.search(p, title):
                return store
    dtype = _field(doc, "doc_type", "其他") or "其他"
    for rule in ROUTING_RULES:
        if rule.get("kind") == "fallback":
            return rule["fallback_by_doc_type"].get(dtype, rule["default"])
    return STORE_SEMANTIC  # 不可达，保险


# ── 蓝图 ────────────────────────────────────────────────────────────────

@dataclass
class MultiStoreBlueprint:
    """多库蓝图：四库 + 路由规则 + 跨库引用。"""
    registry: dict      # 核心登记库（标准树+法规清单）
    events: dict        # 事件流库（案例时间线）
    semantic: dict      # 语义知识库（方法流程图）
    resources: dict     # 资源库（模板+工具）
    routing_rules: list[dict]     # 路由规则
    cross_references: list[dict]  # 跨库引用（如"标准SL252 ↔ 案例#123"）

    def store_counts(self) -> dict:
        return {code: len(getattr(self, code)["files"]) for code in STORE_ORDER}

    def to_dict(self) -> dict:
        return asdict(self)


def _file_name(doc) -> str:
    title, fmt = _doc_title(doc), (_field(doc, "fmt") or "pdf")
    return title if title.endswith(f".{fmt}") else f"{title}.{fmt}"


def _store_dtype(doc) -> str:
    """库内树分组键：doc_type 优先；未分类时用 document_engine.classify_doc（合入后常态）。"""
    dtype = _field(doc, 'doc_type', '其他') or '其他'
    if dtype == '其他' and _classify_doc is not None:
        dtype = _classify_doc(_doc_title(doc)) or '其他'
    return dtype


def _build_store(code: str, docs: list) -> dict:
    meta = STORES_META[code]
    files = []
    for d in docs:
        files.append({
            "name": _file_name(d),
            "title": _doc_title(d),
            "doc_type": _store_dtype(d),
            "fmt": _field(d, "fmt") or "pdf",
            "size_kb": _field(d, "size_kb", 500) or 500,
            "badge": _field(d, "badge", "green_free"),
            "perm": _field(d, "perm", "green"),
            "url": _field(d, "url"),
            "source": _field(d, "source", "wenku"),
        })
    # 库内目录树：L1=doc_type 分组（-件数, 名称 双键排序=确定性）
    by_type: dict[str, list[dict]] = {}
    for f in files:
        by_type.setdefault(f["doc_type"], []).append(f)
    tree = [
        {"name": dtype, "file_count": len(flist), "files": [f["name"] for f in flist]}
        for dtype, flist in sorted(by_type.items(), key=lambda x: (-len(x[1]), x[0]))
    ]
    store = {
        "code": code, "name": meta["name"], "traits": meta["traits"], "desc": meta["desc"],
        "files": files,
        "tree": tree,
        "stats": {"files": len(files),
                  "size_kb": sum(f["size_kb"] for f in files),
                  "doc_types": {k: len(v) for k, v in sorted(by_type.items())}},
    }
    if code == STORE_EVENTS:  # 事件流库专属：案例时间线（题名年份升序，未知年份垫底）
        def _year(t):
            m = re.search(r"(?:19|20)\d{2}", t)
            return int(m.group(0)) if m else None
        store["timeline"] = [
            {"year": y, "title": f["title"]}
            for y, f in sorted(((_year(f["title"]), f) for f in files),
                               key=lambda x: (x[0] is None, x[0] or 0, x[1]["title"]))
        ]
    return store


def _title_tokens(title: str) -> list[str]:
    """标准号 token + 命中的共享特征词（常量序）。"""
    tokens = [m.group(0).strip() for m in _STD_CODE_RE.finditer(title)]
    tokens += [k for k in XREF_KEYWORDS if k in title]
    return tokens


def _build_cross_references(buckets: dict) -> list[dict]:
    """同特征跨库 → 引用对（每特征×每库对取首件，确定性、上限 MAX_XREFS）。"""
    token_first: dict[str, dict[str, str]] = {}  # token -> {store: 首件题名}
    for code in STORE_ORDER:
        for d in buckets[code]:
            for tok in _title_tokens(_doc_title(d)):
                token_first.setdefault(tok, {}).setdefault(code, _doc_title(d))
    xrefs = []
    for tok, stores in token_first.items():  # dict 插入序=输入序，确定性
        present = [c for c in STORE_ORDER if c in stores]
        for i in range(len(present)):
            for j in range(i + 1, len(present)):
                a, b = present[i], present[j]
                xrefs.append({
                    "a": {"store": a, "doc": stores[a]},
                    "b": {"store": b, "doc": stores[b]},
                    "kind": f"{STORES_META[a]['name']}↔{STORES_META[b]['name']}",
                    "reason": f"共享特征: {tok}",
                })
        if len(xrefs) >= MAX_XREFS:
            return xrefs[:MAX_XREFS]
    return xrefs


def build_multistore(documents: list) -> MultiStoreBlueprint:
    """路由全部文档 → 四库各建目录树 → 生成跨库引用。"""
    buckets: dict[str, list] = {code: [] for code in STORE_ORDER}
    for doc in documents:
        buckets[route_document(doc)].append(doc)
    return MultiStoreBlueprint(
        registry=_build_store(STORE_REGISTRY, buckets[STORE_REGISTRY]),
        events=_build_store(STORE_EVENTS, buckets[STORE_EVENTS]),
        semantic=_build_store(STORE_SEMANTIC, buckets[STORE_SEMANTIC]),
        resources=_build_store(STORE_RESOURCES, buckets[STORE_RESOURCES]),
        routing_rules=copy.deepcopy(ROUTING_RULES),
        cross_references=_build_cross_references(buckets),
    )


# ── 多库视图 ────────────────────────────────────────────────────────────

_CN_NUM = "一二三四五"


def render_multistore_view(msb: MultiStoreBlueprint) -> str:
    """渲染多库视图为 Markdown：四个专业库 + 交叉引用。"""
    counts = msb.store_counts()
    total = sum(counts.values())
    lines = [
        f"# 多库知识库视图（{total}件 · {sum(1 for c in counts.values() if c)}库 · "
        f"{len(msb.cross_references)}条跨库引用）",
        "",
    ]
    for i, code in enumerate(STORE_ORDER):
        store = getattr(msb, code)
        meta = STORES_META[code]
        kb = store["stats"]["size_kb"]
        lines += [
            f"## {_CN_NUM[i]}、{meta['name']}（{code} · {counts[code]}件 · {kb}KB）",
            f"> {meta['traits']} —— {meta['desc']}",
            "",
        ]
        if code == STORE_EVENTS and store.get("timeline"):
            lines.append("**时间线**")
            for t in store["timeline"]:
                lines.append(f"- {t['year'] if t['year'] else '—'} {t['title']}")
            lines.append("")
        for node in store["tree"]:
            lines.append(f"- {node['name']}（{node['file_count']}件）")
            for name in node["files"]:
                lines.append(f"  - {name}")
        lines.append("")
    lines.append(f"## {_CN_NUM[len(STORE_ORDER)]}、跨库引用（{len(msb.cross_references)}条）")
    lines.append("")
    for x in msb.cross_references:
        lines.append(f"- [{STORES_META[x['a']['store']]['name']}] {x['a']['doc']} "
                     f"↔ [{STORES_META[x['b']['store']]['name']}] {x['b']['doc']}"
                     f"（{x['reason']}）")
    lines.append("")
    return "\n".join(lines)


__all__ = [
    "MULTISTORE_VERSION",
    "STORE_REGISTRY", "STORE_EVENTS", "STORE_SEMANTIC", "STORE_RESOURCES",
    "STORES_META", "ROUTING_RULES",
    "MultiStoreBlueprint", "DocFile",
    "route_document", "build_multistore", "render_multistore_view",
]
