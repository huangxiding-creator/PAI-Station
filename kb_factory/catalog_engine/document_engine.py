# -*- coding: utf-8 -*-
"""DocumentDrivenEngine — 文件驱动编目引擎（1022 用户令：从真实文件提炼框架并超越）。

与 taxonomy 模式的区别：
- taxonomy: 通用分类法扇出占位槽 → wenku 回填
- document_driven: 检索该领域真实法规/标准/规范 → 从文件体系提炼目录 → 超越层
"""
from __future__ import annotations

import re
from dataclasses import dataclass, field
from typing import Optional

from .metadata import make_slot, sanitize_filename

# ── 领域关键词提取 ─────────────────────────────────────────────────────────

_DOMAIN_PATTERNS = [
    # (正则, 领域标签, 法规搜索词, 标准搜索词)
    (r"水利|水电|水库|大坝|防洪|灌溉", "水利水电", "水法|防洪法|水污染防治法",
     "SL|水利水电工程"),
    (r"EPC|总承包|工程总承包", "工程总承包", "建筑法|招标投标法|建设工程质量管理条例",
     "GB/T 50358|建设项目工程总承包管理规范"),
    (r"建筑|施工|工地|房建", "建筑施工", "建筑法|安全生产法|建设工程安全生产管理条例",
     "GB 50300|建筑施工质量验收统一标准"),
    (r"律师|法律|诉讼|合规|律所", "法律实务", "民法典|公司法|劳动法|刑法",
     "法律实务"),
    (r"财务|会计|税务|审计", "财务管理", "会计法|税法|企业所得税法|增值税暂行条例",
     "企业会计准则"),
    (r"安全|EHS|环保|职业健康", "安全环保", "安全生产法|环保法|职业病防治法",
     "GB/T 33000|企业安全生产标准化基本规范"),
    (r"P6|Primavera|进度|计划", "项目管理", "建设项目管理条例",
     "GB/T 50326|建设工程项目管理规范"),
    (r"造价|预算|计量|定额|结算", "工程造价", "建设工程工程量清单计价规范",
     "GB 50500|建设工程工程量清单计价规范"),
    (r"跨境|电商|外贸|选品", "跨境电商", "电子商务法|海关法|对外贸易法",
     "跨境电子商务"),
    (r"科研|文献|课题|基金", "科研管理", "科学技术进步法|专利法",
     "学术规范"),
    (r"教育|备课|教案|教师|教学", "教育教学", "教育法|教师法|义务教育法",
     "课程标准"),
    (r"监理|监督|检测", "工程监理", "建设工程监理规范",
     "GB/T 50319|建设工程监理规范"),
]

# 文件类型分类器
_DOC_TYPE_PATTERNS = [
    (r"^.{0,5}(GB|GB/T|GB/Z)\s*\d+", "国家标准"),
    (r"^(SL|DL|JGJ|JT|TB|YB|QB|SY|SH|HG|CJJ|CJ|WS|YY|NB|DL/T)\s*\d+", "行业标准"),
    (r"^(ISO|IEC|ASTM|EN|DIN|JIS)\s*\d+", "国际标准"),
    (r"法[》）\)]?$|法[（(]|条例[》）\)]?$|条例[（(]|管理办法$|管理规定$|实施细则$|中华人民共和国", "法律法规"),
    (r"规范$|标准$|规程$|导则$|指南$|指引$", "技术规范"),
    (r"图集|图说|手册|全书|宝典", "工具书"),
    (r"案例|实例|实战|实务|操作", "案例实务"),
    (r"教程|培训|课件|教案|讲义", "培训教材"),
    (r"模板|范本|合同|协议|文书", "模板范本"),
]


@dataclass
class DocFile:
    """检索到的真实文件（非占位槽）。"""
    title: str
    source: str = "wenku"          # wenku / gb / ima / local
    fmt: str = "pdf"
    pages: Optional[int] = None
    badge: str = "green_free"      # green_free / wenku_vip / gb_free / ima_public
    perm: str = "green"            # green / yellow / red
    url: Optional[str] = None
    doc_type: str = "其他"         # 由 classify_doc 决定
    size_kb: int = 500             # 估算


def classify_doc(title: str) -> str:
    for pattern, label in _DOC_TYPE_PATTERNS:
        if re.search(pattern, title):
            return label
    return "其他"


def extract_domain(need_text: str) -> dict:
    """从需求文本提取领域信息。"""
    text = need_text or ""
    for pattern, domain, law_kw, std_kw in _DOMAIN_PATTERNS:
        if re.search(pattern, text):
            return {
                "domain": domain,
                "matched": True,
                "law_keywords": law_kw.split("|"),
                "std_keywords": std_kw.split("|"),
                "raw_need": text,
            }
    return {
        "domain": "综合",
        "matched": False,
        "law_keywords": [text[:10]] if text else ["综合管理"],
        "std_keywords": [text[:10]] if text else ["通用标准"],
        "raw_need": text,
    }


# ── 目录树构建 ────────────────────────────────────────────────────────────

# 超越层：按使用场景重组（用户看到的第一层）
TRANSCEND_LAYERS = [
    {"name": "合规底线", "desc": "法律法规与强制性标准——必须遵守的红线",
     "types": ["法律法规", "国家标准"]},
    {"name": "技术标准", "desc": "行业技术标准与规范——工作开展的技术依据",
     "types": ["行业标准", "国际标准", "技术规范"]},
    {"name": "操作实务", "desc": "案例、模板、操作指南——从理论到实践的桥梁",
     "types": ["案例实务", "模板范本", "培训教材"]},
    {"name": "参考工具", "desc": "手册、图集、工具书——日常查阅的案头书",
     "types": ["工具书", "其他"]},
]


def build_tree_from_docs(docs: list[DocFile], domain: str) -> list:
    """从真实文件构建三级目录树。

    L1 = 超越层（合规底线/技术标准/操作实务/参考工具）
    L2 = 文件类型子类（或按主题聚类）
    L3 = 真实文件列表
    """
    tree = []
    for layer in TRANSCEND_LAYERS:
        layer_docs = [d for d in docs if d.doc_type in layer["types"]]
        if not layer_docs:
            continue

        l1 = {
            "code": f"D-{len(tree)+1:02d}",
            "dir": f"{len(tree)+1:02d}",
            "path": f"D-{len(tree)+1:02d}/",
            "name": layer["name"],
            "theme": layer["desc"],
            "source": "document_driven",
            "open": False,
            "l2": [],
        }

        # L2 按文件类型分组
        by_type = {}
        for d in layer_docs:
            by_type.setdefault(d.doc_type, []).append(d)

        for j, (dtype, dlist) in enumerate(sorted(by_type.items(), key=lambda x: -len(x[1]))):
            l2 = {
                "code": f"{l1['code']}/{j+1:02d}",
                "dir": f"{j+1:02d}",
                "path": f"{l1['code']}/{j+1:02d}/",
                "name": dtype,
                "theme": f"{dtype}（{len(dlist)}件）",
                "open": False,
                "files": [],
                "file_count": len(dlist),
            }
            for d in dlist[:200]:  # 单目录上限
                fname = sanitize_filename(d.title) or "untitled"
                ext = d.fmt if d.fmt else "pdf"
                if not fname.endswith(f".{ext}"):
                    fname = f"{fname}.{ext}"
                l2["files"].append({
                    "name": fname,
                    "fmt": ext,
                    "size_kb": d.size_kb,
                    "badge": d.badge,
                    "perm": d.perm,
                    "url": d.url,
                    "real": True,  # 标记为真实检索结果（非占位）
                })
            l1["l2"].append(l2)

        if l1["l2"]:
            tree.append(l1)

    return tree


def build_blueprint_document_driven(need: dict, docs: list[DocFile]) -> dict:
    """文件驱动蓝图生成入口。"""
    domain_info = extract_domain(
        " ".join(filter(None, [need.get("domain", ""), " ".join(need.get("keywords", [])),
                                need.get("intent", "")]))
    )
    domain = domain_info["domain"]

    # 对 docs 做分类
    for d in docs:
        d.doc_type = classify_doc(d.title)

    tree = build_tree_from_docs(docs, domain)

    # 统计
    total_files = sum(len(l2["files"]) for l1 in tree for l2 in l1["l2"])
    total_kb = sum(f.get("size_kb", 500) for l1 in tree for l2 in l1["l2"] for f in l2["files"])
    total_gb = round(total_kb / 1024 / 1024, 2)
    l1_count = len(tree)
    l2_count = sum(len(l1["l2"]) for l1 in tree)

    # 配比（文件驱动模式按超越层自然分布，不硬编 phi-1）
    layer_counts = {l1["name"]: sum(len(l2["files"]) for l2 in l1["l2"]) for l1 in tree}
    total = max(total_files, 1)
    ratio = {k: round(v * 100 // total) for k, v in layer_counts.items()}

    # 报价（A 档）
    quote = {
        "base": 29.0,
        "per_gb": 2.0,
        "total": round(29 + total_gb * 2, 1),
        "md_factor": 1.5,
        "import_add": 19.0,
    }

    return {
        "domain": domain,
        "need": need,
        "mode": "document_driven",
        "tree": {
            "mode": "document_driven",
            "root": f"{domain}知识库",
            "l1": tree,
        },
        "ratio": ratio,
        "stats": {
            "files": total_files,
            "gb": total_gb,
            "l1_count": l1_count,
            "l2_count": l2_count,
            "real_docs": sum(1 for l1 in tree for l2 in l1["l2"] for f in l2["files"] if f.get("real")),
            "dir_count": l1_count + l2_count,
        },
        "quote": quote,
        "provenance": {
            "engine": "document_driven_v1",
            "domain_matched": domain_info["matched"],
            "sources": list(set(d.source for d in docs)),
            "doc_types": list(set(d.doc_type for d in docs)),
        },
    }
