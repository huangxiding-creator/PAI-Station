"""框架合成器（PROPOSAL_V2.md 5.2②）：多框架 → master_framework。

复用 e7b6acc 聚类纪律的本地化版本：节点聚类合并且**字段合并在本地完成**。
默认相似度合并（difflib，模型缺席时服务不停摆）；可注入 cluster_fn
（GLM 判组号模式）以提升同义合并精度。输出节点带频次（出现率）与
来源清单——共识簇（全框架出现）与独家簇（单一来源）自动标记。
"""
from __future__ import annotations

from dataclasses import dataclass, field
from difflib import SequenceMatcher

_SIMILAR_FLOOR = 0.62  # 字符相似度合并阈值（工程目录标题实测调优）


def _similar(a: str, b: str) -> float:
    return SequenceMatcher(None, a, b).ratio()


@dataclass
class _Cluster:
    title: str
    members: list[tuple[str, dict]] = field(default_factory=list)  # (来源框架名, 节点)


def _merge_into(clusters: list[_Cluster], title: str, source: str, node: dict,
                floor: float) -> None:
    for cl in clusters:
        if _similar(cl.title, title) >= floor or title in cl.title or cl.title in title:
            cl.members.append((source, node))
            return
    clusters.append(_Cluster(title=title, members=[(source, node)]))


def synthesize(frames: list[tuple[str, list[dict]]] | list[list[dict]],
               cluster_fn=None, similar_floor: float = _SIMILAR_FLOOR) -> list[dict]:
    """多框架节点合成 master_framework。

    frames: [(框架名, 节点列表), ...] 或裸节点列表的列表。
    cluster_fn: 可注入的语义聚类函数（签名 (titles) -> 分组索引列表）；
    缺席时用本地字符相似度（确定性、零依赖）。
    返回：[{id, title, level, frequency, sources, consensus}]，按频次降序。
    """
    if not frames:
        raise ValueError("框架列表为空——先完成初级调研（框架提取）再合成")

    normalized: list[tuple[str, list[dict]]] = []
    for idx, item in enumerate(frames):
        if isinstance(item, tuple):
            normalized.append((str(item[0]), list(item[1])))
        else:
            normalized.append((f"框架{idx + 1}", list(item)))

    all_nodes = [(name, node) for name, nodes in normalized for node in nodes]
    if not all_nodes:
        return []

    clusters: list[_Cluster] = []
    if cluster_fn is not None:
        groups = cluster_fn([node["title"] for _, node in all_nodes])
        buckets: list[_Cluster] = [_Cluster(title="") for _ in groups]
        for (name, node), group_idx in zip(all_nodes, groups):
            buckets[group_idx].members.append((name, node))
        for b in buckets:
            if b.members:
                b.title = max((m[1]["title"] for m in b.members),
                              key=len)  # 规范名取最长（信息最全）
        clusters = [b for b in buckets if b.members]
    else:
        for name, node in all_nodes:
            _merge_into(clusters, node["title"], name, node, similar_floor)

    total_frames = len(normalized)
    master: list[dict] = []
    for i, cl in enumerate(clusters, start=1):
        sources = sorted({name for name, _ in cl.members})
        frequency = round(len(sources) / total_frames, 3)
        levels = [m[1].get("level", "节") for m in cl.members]
        master.append({
            "id": f"m{i:02d}",
            "title": cl.title,
            "level": max(set(levels), key=levels.count),
            "frequency": frequency,
            "sources": sources,
            "consensus": len(sources) == total_frames,
        })
    master.sort(key=lambda n: (-n["frequency"], n["title"]))
    for i, node in enumerate(master, start=1):
        node["id"] = f"m{i:02d}"
    return master
