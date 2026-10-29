"""框架级自纠环：generate→apply→critique→repair，修复对象是分类蓝图本身。

把蓝图"套回"全量文档做体检（critique），按体检结果修蓝图（repair），
交替迭代直到达标（self_correct）。评估四轴：覆盖率/一致性/冗余度/深度均衡。

蓝图格式（canonical，纯 dict，stdlib only）::

    bp = {
        "name": "顶层名称",                # 可选
        "children": [                      # L1 层
            {
                "name": "水工建筑物",
                "children": [              # L2 层
                    {"name": "大坝工程", "keywords": ["大坝"],
                     "cross_refs": [...]},  # cross_refs 由 repair 合并冗余时写入
                ],
            },
        ],
    }

文档：``list[str] | list[dict]``。dict 支持 name/title/filename/path（名称类）、
type/category（显式同类型标记，供一致性判定）、text/content/description（正文摘要，
截前 2000 字参与关键词匹配）。
"""
from __future__ import annotations

import copy
import math
import re
from collections import Counter, defaultdict
from dataclasses import dataclass, field

__all__ = ["CritiqueResult", "critique", "repair", "self_correct"]

#: 自纠收敛门槛：overall 超过即停
OVERALL_TARGET = 0.8
#: overall 五轴权重（和为 1.0）
W_COVERAGE, W_CONSISTENCY, W_NON_REDUNDANCY, W_BALANCE, W_NON_EMPTY = 0.35, 0.25, 0.15, 0.10, 0.15
#: 无显式 type 时，名称 bigram Jaccard 相似度达到该阈值视为同类文档
SAME_TYPE_SIMILARITY = 0.5
#: 两个 L2 的文档归属重叠达到较小者集合的该比例即合并
MERGE_OVERLAP_RATIO = 0.5

_NAME_KEYS = ("name", "title", "filename", "file_name", "path")
_TYPE_KEYS = ("type", "category")
_TEXT_KEYS = ("text", "content", "description")
_MISCELLANEOUS_L1 = "其他"
_EXT_RE = re.compile(r"\.[A-Za-z0-9]{1,5}$")


@dataclass
class CritiqueResult:
    """一次蓝图体检结果。"""

    coverage: float  # 文档覆盖率（被分类到某 L2 的文档/总文档）
    consistency: float  # 一致性（同类文档被分到同一 L2 的比率）
    redundancy: float  # 冗余度（重复文件在多个 L2 出现的比率，越低越好）
    empty_nodes: int  # 空 L2 节点数
    depth_balance: float  # 深度均衡（各 L1 下 L2 数的标准差倒数）
    overall: float  # 加权综合分
    issues: list[str] = field(default_factory=list)  # 具体问题描述


# ---------------------------------------------------------------- 文档侧工具


def _norm(s: str) -> str:
    return re.sub(r"\s+", "", str(s).lower())


def _clean_name(s: str) -> str:
    """去路径取基名、去扩展名——扩展名（.pdf/.docx…）对主题无信号，
    不剥离会把 ".p"/"pd"/"df" 之类 bigram 当成关键词污染全链。"""
    s = str(s).replace("\\", "/").rsplit("/", 1)[-1]
    return _EXT_RE.sub("", s)


def _field(doc, key, default=None):
    """取文档字段：dict 按键、对象按属性（DocFile 等 v2 文档）两界通吃。"""
    if isinstance(doc, dict):
        return doc.get(key, default)
    return getattr(doc, key, default)


def _doc_name(doc) -> str:
    """文档名称类字段（不做正文匹配，只供分型/命名）。"""
    if isinstance(doc, str):
        return _clean_name(doc)
    return " ".join(
        _clean_name(v) for k in _NAME_KEYS
        if isinstance(v := _field(doc, k), str) and v
    )


def _doc_text(doc) -> str:
    """参与关键词匹配的文本 = 名称类字段 + 正文摘要（截断）。"""
    if isinstance(doc, str):
        return doc
    parts = [_doc_name(doc)]
    for k in _TEXT_KEYS:
        v = _field(doc, k)
        if isinstance(v, str) and v:
            parts.append(v[:2000])
    return " ".join(parts)


def _doc_type(doc) -> str | None:
    if isinstance(doc, str):
        return None
    for k in _TYPE_KEYS:
        v = _field(doc, k)
        if isinstance(v, str) and v and v != "其他":
            return v
    return None


def _bigrams(text: str) -> set[str]:
    s = _norm(text)
    if len(s) < 2:
        return {s} if s else set()
    return {s[i : i + 2] for i in range(len(s) - 1)}


def _jaccard(a: set, b: set) -> float:
    union = a | b
    return len(a & b) / len(union) if union else 0.0


def _doc_groups(documents: list):
    """同类文档分组（union-find）：显式 type 相同，或名称 bigram 足够相似。

    返回 (groups, names, bigram_sets)；groups 为下标列表的列表。
    """
    n = len(documents)
    names = [_doc_name(d) for d in documents]
    bgs = [_bigrams(x) for x in names]
    types = [_doc_type(d) for d in documents]
    parent = list(range(n))

    def find(i: int) -> int:
        while parent[i] != i:
            parent[i] = parent[parent[i]]
            i = parent[i]
        return i

    for i in range(n):
        for j in range(i + 1, n):
            same_explicit = types[i] is not None and types[i] == types[j]
            if same_explicit or _jaccard(bgs[i], bgs[j]) >= SAME_TYPE_SIMILARITY:
                ri, rj = find(i), find(j)
                if ri != rj:
                    parent[max(ri, rj)] = min(ri, rj)

    groups = defaultdict(list)
    for i in range(n):
        groups[find(i)].append(i)
    return list(groups.values()), names, bgs


# ---------------------------------------------------------------- 蓝图侧工具


def _children(node: dict) -> list[dict]:
    return [c for c in (node.get("children") or []) if isinstance(c, dict)]


def _l2_nodes(bp: dict) -> list[tuple[dict, dict]]:
    """扁平化为 [(l1_node, l2_node), ...]，按蓝图遍历序（决定平分打破次序）。"""
    return [(l1, l2) for l1 in _children(bp) for l2 in _children(l1)]


def _keywords(node: dict) -> list[str]:
    kws = [str(k) for k in (node.get("keywords") or []) if str(k)]
    return kws or [str(node.get("name") or "")]


def _classify(bp: dict, documents: list):
    """把蓝图套回文档。

    返回 (placements, primaries, l2_list)：
    placements[i] = 文档 i 命中的 L2 下标列表；primaries[i] = 最高分 L2 下标（无命中为 None）。
    得分 = 命中关键词数；平分取蓝图遍历序更前者。
    """
    l2_list = _l2_nodes(bp)
    kws_list = [[k.lower() for k in _keywords(l2)] for _, l2 in l2_list]
    placements: list[list[int]] = []
    primaries: list[int | None] = []
    for doc in documents:
        text = _norm(_doc_text(doc))
        scores = [sum(1 for k in kws if k in text) for kws in kws_list]
        hit = [i for i, s in enumerate(scores) if s > 0]
        placements.append(hit)
        primaries.append(max(hit, key=lambda i: (scores[i], -i)) if hit else None)
    return placements, primaries, l2_list


def _pstdev(xs: list) -> float:
    if not xs:
        return 0.0
    mu = sum(xs) / len(xs)
    return math.sqrt(sum((x - mu) ** 2 for x in xs) / len(xs))


def _remove_l2(bp: dict, l2: dict) -> None:
    """摘除指定 L2 节点；L1 因此无子则一并修剪。"""
    bp["children"] = [
        {**l1, "children": [c for c in _children(l1) if c is not l2]}
        for l1 in _children(bp)
    ]
    bp["children"] = [l1 for l1 in bp["children"] if _children(l1)]


# ---------------------------------------------------------------- critique


def critique(bp: dict, documents: list) -> CritiqueResult:
    """体检：把蓝图套回全量文档，量出五轴分数与问题清单。"""
    n = len(documents)
    placements, primaries, l2_list = _classify(bp, documents)

    covered = sum(1 for p in placements if p)
    coverage = covered / n if n else 1.0
    duplicated = sum(1 for p in placements if len(p) >= 2)
    redundancy = duplicated / n if n else 0.0

    assigned = {i for p in placements for i in p}
    empty_names = [
        str(l2.get("name") or "?") for i, (_, l2) in enumerate(l2_list) if i not in assigned
    ]
    empty_nodes = len(empty_names)
    non_empty_ratio = 1.0 - (empty_nodes / len(l2_list) if l2_list else 0.0)

    counts = [len(_children(l1)) for l1 in _children(bp)]
    std = _pstdev(counts)
    depth_balance = 1.0 / (1.0 + std) if counts else 1.0

    groups, _, _ = _doc_groups(documents)
    consistent_total = consistent_major = 0
    split_groups = 0
    for g in groups:
        prim = [primaries[i] for i in g if primaries[i] is not None]
        if len(prim) < 2:
            continue
        _, top_cnt = Counter(prim).most_common(1)[0]
        consistent_total += len(prim)
        consistent_major += top_cnt
        if top_cnt < len(prim):
            split_groups += 1
    consistency = consistent_major / consistent_total if consistent_total else 1.0

    overall = (
        W_COVERAGE * coverage
        + W_CONSISTENCY * consistency
        + W_NON_REDUNDANCY * (1.0 - redundancy)
        + W_BALANCE * depth_balance
        + W_NON_EMPTY * non_empty_ratio
    )

    issues: list[str] = []
    if covered < n:
        miss = [_doc_name(d) for d, p in zip(documents, placements) if not p]
        head = ", ".join(miss[:5])
        issues.append(f"覆盖缺口: {n - covered}/{n} 份文档未归入任何L2: {head}{'...' if len(miss) > 5 else ''}")
    if empty_nodes:
        issues.append(f"空L2节点 {empty_nodes} 个: {', '.join(empty_names)}")
    if duplicated:
        issues.append(f"冗余: {duplicated}/{n} 份文档同时落入多个L2")
    if split_groups:
        issues.append(f"同类文档分裂到不同L2: {split_groups} 组")
    if counts and std > 1.0:
        issues.append(f"深度失衡: 各L1下L2数 {counts} (std={std:.2f})")

    return CritiqueResult(
        coverage, consistency, redundancy, empty_nodes, depth_balance, overall, issues
    )


# ---------------------------------------------------------------- repair


def repair(bp: dict, cr: CritiqueResult, documents: list) -> dict:
    """按体检结果修蓝图：删空节点 → 合并冗余（留交叉引用）→ 补覆盖。返回修复后的新蓝图。"""
    new = copy.deepcopy(bp)
    if cr.empty_nodes > 0:
        _drop_empty_nodes(new, documents)
    if cr.redundancy > 0:
        _merge_redundant_nodes(new, documents)
    if cr.coverage < 1.0:
        _extend_for_coverage(new, documents)
    return new


def _drop_empty_nodes(bp: dict, documents: list) -> None:
    placements, _, l2_list = _classify(bp, documents)
    assigned = {i for p in placements for i in p}
    for i, (_, l2) in enumerate(l2_list):
        if i not in assigned:
            _remove_l2(bp, l2)


def _merge_redundant_nodes(bp: dict, documents: list) -> None:
    """反复合并文档归属高度重叠的 L2 对：关键词并集，被并者名记入幸存者 cross_refs。"""
    while True:
        placements, _, l2_list = _classify(bp, documents)
        m = len(l2_list)
        if m < 2:
            return
        docsets = [{d for d, p in enumerate(placements) if i in p} for i in range(m)]
        best = None  # (-overlap, i, j)
        for i in range(m):
            for j in range(i + 1, m):
                ov = len(docsets[i] & docsets[j])
                if ov and ov >= MERGE_OVERLAP_RATIO * min(len(docsets[i]), len(docsets[j])):
                    key = (-ov, i, j)
                    if best is None or key < best:
                        best = key
        if best is None:
            return
        _, i, j = best
        keep, drop = (i, j) if len(docsets[i]) >= len(docsets[j]) else (j, i)
        survivor = l2_list[keep][1]
        absorbed = l2_list[drop][1]
        survivor["keywords"] = list(dict.fromkeys(_keywords(survivor) + _keywords(absorbed)))
        refs = list(survivor.get("cross_refs") or [])
        name = str(absorbed.get("name") or "")
        if name and name not in refs:
            refs.append(name)
        survivor["cross_refs"] = refs  # 重复处留交叉引用
        _remove_l2(bp, absorbed)


def _extend_for_coverage(bp: dict, documents: list) -> None:
    """从未分类文档提取新 L2 主题：同类分组 → 共有 bigram 做关键词 → 挂到最合适的 L1。"""
    placements, _, _ = _classify(bp, documents)
    unclassified = [d for d, p in zip(documents, placements) if not p]
    if not unclassified:
        return
    corpus_freq = Counter()
    for d in documents:
        corpus_freq.update(_bigrams(_doc_name(d)))

    groups, names, bgs = _doc_groups(unclassified)
    groups.sort(key=lambda g: (-len(g), names[g[0]]))
    for g in groups:
        member_bgs = [bgs[i] for i in g]
        shared = set.intersection(*member_bgs)
        if shared:
            kws = sorted(shared, key=lambda b: (-corpus_freq[b], b))[:3]
        else:  # 成员名称无共有 bigram（显式 type 分组才可能到这）：按成员覆盖数取
            cnt = Counter(b for s in member_bgs for b in s)
            kws = sorted(cnt, key=lambda b: (-cnt[b], -corpus_freq[b], b))[:3]
        t = next((_doc_type(unclassified[i]) for i in g if _doc_type(unclassified[i])), None)
        name = t or (kws[0] if kws else (names[g[0]] or _MISCELLANEOUS_L1))

        group_bgs = set().union(*member_bgs)
        cands = [l1 for l1 in _children(bp) if _bigrams(str(l1.get("name") or "")) & group_bgs]
        if cands:
            host = min(cands, key=lambda l1: (len(_children(l1)), str(l1.get("name") or "")))
        else:
            host = next((l1 for l1 in _children(bp) if l1.get("name") == _MISCELLANEOUS_L1), None)
            if host is None:
                host = {"name": _MISCELLANEOUS_L1, "children": []}
                bp.setdefault("children", []).append(host)
        host.setdefault("children", []).append({"name": name, "keywords": kws})


# ---------------------------------------------------------------- self_correct


def self_correct(
    bp: dict, documents: list, max_iterations: int = 3
) -> tuple[dict, list[CritiqueResult]]:
    """完整自纠环：critique → repair → critique → ... 直到 overall > OVERALL_TARGET 或迭代耗尽。

    每轮只接受让 overall 变好的修复（防振荡）；history[-1] 恒为返回蓝图的体检结果。
    """
    current = copy.deepcopy(bp)
    history: list[CritiqueResult] = []
    for _ in range(max_iterations):
        c = critique(current, documents)
        history.append(c)
        if c.overall > OVERALL_TARGET:
            return current, history
        repaired = repair(current, c, documents)
        c_after = critique(repaired, documents)
        if c_after.overall <= c.overall:
            return current, history  # 修复不再增益，停在当前最优
        current = repaired
    history.append(critique(current, documents))
    return current, history
