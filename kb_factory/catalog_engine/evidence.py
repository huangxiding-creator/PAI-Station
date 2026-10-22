# -*- coding: utf-8 -*-
"""evidence.py — 证据锚定一等公民（KB-FACTORY 编目引擎 v2 P0 #6）。

调研 Top 模式 #6（jevgraph + textbook-to-note）：每个知识库节点必须携带
溯源字段（源文件 + 页码 + 条款号 + 置信度），无证据链接的节点直接拒收——
把「数字零造假」从纪律变成结构保证。

置信度标尺（闭集，写死不猜）：
  1.0  直接引用原文（页码 + 条款号已实证）
  0.9  渠道元数据锚定（doc_id/URL 可点验，或本地文件在盘可验）
  0.7  渠道元数据缺 URL（仅标识/标题匹配）
  0.5  推断（无渠道事实）

零造假锚：未知页码/条款号一律 None；文档总页数（pages）≠引用页码，不得冒充。
"""
from __future__ import annotations

import re
from dataclasses import asdict, dataclass
from typing import Optional

from .metadata import sanitize_filename

SOURCES = ("wenku", "gb", "ima", "local")

CONF_VERBATIM = 1.0    # 直接引用原文
CONF_ANCHORED = 0.9    # 元数据锚定（doc_id/URL/本地文件可点验）
CONF_MATCHED = 0.7     # 无 URL 的元数据匹配
CONF_INFERRED = 0.5    # 推断

# 标准号提取（doc_id 回退链）：GB/T 50358、SL 252-2017、DL/T 5144、ISO 9001…
_STD_NO_RE = re.compile(
    r"(GB(?:/[TZ])?|SL|DL(?:/T)?|JGJ|JT|TB|YB|CJJ|NB|WS|YY|"
    r"ISO(?:/\w+)?|IEC|ASTM|EN|DIN|JIS)\s?\d+(?:\.\d+)*(?:[-—－]\d{2,4})?",
    re.IGNORECASE,
)


@dataclass
class Evidence:
    """单条溯源锚点（知识库节点 → 源文件的证据链接）。"""
    doc_id: str                      # wenku docID / GB标准号 / ima kb_id / 本地文件名
    source: str                      # wenku / gb / ima / local
    title: str = ""                  # 来源文件标题
    page: Optional[int] = None       # 引用页码；未知=None（零造假）
    clause: Optional[str] = None     # 条款号（如"第5.2.1条"）；未知=None
    confidence: float = CONF_INFERRED
    url: Optional[str] = None        # 来源 URL

    def __post_init__(self) -> None:
        if not isinstance(self.doc_id, str) or not self.doc_id.strip():
            raise ValueError("doc_id 不可为空：无标识即无证据（零造假）")
        if self.source not in SOURCES:
            raise ValueError(f"source 越界: {self.source!r}（闭集 {SOURCES}）")
        if not (0.0 <= self.confidence <= 1.0):
            raise ValueError(f"confidence 越界: {self.confidence}（须 0.0-1.0）")

    def to_dict(self) -> dict:
        """序列化为 JSON 可存的 dict（蓝图文件槽内嵌格式）。"""
        return asdict(self)

    @classmethod
    def from_dict(cls, d: dict) -> "Evidence":
        return cls(doc_id=d["doc_id"], source=d["source"], title=d.get("title", ""),
                   page=d.get("page"), clause=d.get("clause"),
                   confidence=d.get("confidence", CONF_INFERRED), url=d.get("url"))


# ── doc_id 回退链 ──────────────────────────────────────────────────────

def extract_std_no(title: str) -> Optional[str]:
    """从标题提取标准号（GB/T 50358 / SL 252 等）；无则 None。"""
    m = _STD_NO_RE.search(title or "")
    return m.group(0).replace("—", "-").replace("－", "-") if m else None


def derive_doc_id(*, doc_id: Optional[str] = None, title: str = "",
                  url: Optional[str] = None) -> str:
    """doc_id 回退链：显式 id → 标准号 → 标题净名 → URL；全空抛错不造标识。"""
    if doc_id and doc_id.strip():
        return doc_id.strip()
    std = extract_std_no(title)
    if std:
        return std
    stem = sanitize_filename(title or "")
    if stem:
        return stem
    if url:
        return url
    raise ValueError("无法锚定：doc_id/title/url 全空，拒绝造标识（零造假）")


# ── 文件槽锚定 ─────────────────────────────────────────────────────────

def _stem(fname: str) -> str:
    return fname.rsplit(".", 1)[0] if "." in fname else fname


def _auto_confidence(source: str, url: Optional[str]) -> float:
    if source == "local":
        return CONF_ANCHORED  # 本地文件在盘可直接点验
    return CONF_ANCHORED if url else CONF_MATCHED


def evidence_from_doc(doc) -> Evidence:
    """DocFile（duck-typed：title/source/url/doc_id）→ Evidence。

    页码/条款号如实 None：检索只锚定「文件存在于此源」，不实证内容位置。
    """
    title = getattr(doc, "title", "")
    url = getattr(doc, "url", None)
    source = getattr(doc, "source", "local") or "local"
    return Evidence(
        doc_id=derive_doc_id(doc_id=getattr(doc, "doc_id", None), title=title, url=url),
        source=source, title=title,
        page=None, clause=None,
        confidence=_auto_confidence(source, url),
        url=url,
    )


def anchor_file(file_slot: dict, evidence: Optional[Evidence] = None) -> dict:
    """给蓝图文件槽附加 evidence 字段（就地更新并返回该槽）。

    - 显式传入 Evidence → 直接锚定（覆盖旧值）
    - 未传且 file_slot.real=True → 从槽内渠道元数据（doc_id/url/title/source）提取
    - 未传且非真实槽 → 原样返回：占位不造证据，由 validate_evidence 拒收
    """
    if evidence is None and file_slot.get("real"):
        title = file_slot.get("title") or _stem(file_slot.get("name", ""))
        url = file_slot.get("url")
        source = file_slot.get("source") or "wenku"
        evidence = Evidence(
            doc_id=derive_doc_id(doc_id=file_slot.get("doc_id"), title=title, url=url),
            source=source, title=title,
            page=None,  # 槽内 pages=文档总页数，非引用页码（零造假）
            clause=None,
            confidence=_auto_confidence(source, url),
            url=url,
        )
    if evidence is not None:
        file_slot["evidence"] = evidence.to_dict()
    return file_slot


# ── 蓝图验收门 ─────────────────────────────────────────────────────────

def _iter_file_slots(bp: dict):
    """蓝图 {tree:{l1:[{l2:[{files:[…]}]}]}} → 逐文件槽产出。"""
    for l1 in bp.get("tree", {}).get("l1", []):
        for l2 in l1.get("l2", []):
            yield from l2.get("files", [])


def validate_evidence(bp: dict) -> dict:
    """验收蓝图所有文件槽是否都有 evidence；零证据节点拒收（pass=False 并点名）。"""
    total = with_ev = 0
    missing = []
    for f in _iter_file_slots(bp):
        total += 1
        ev = f.get("evidence")
        if isinstance(ev, dict) and ev.get("doc_id"):
            with_ev += 1
        else:
            missing.append(f.get("name", "?"))
    without = total - with_ev
    return {
        "total": total,
        "with_evidence": with_ev,
        "without_evidence": without,
        "evidence_rate": round(with_ev / total, 4) if total else 1.0,
        "pass": without == 0,
        "missing": missing,  # pass=False 时即缺证据节点点名清单
    }


# ── 附录渲染 ───────────────────────────────────────────────────────────

def render_evidence_appendix(bp: dict) -> str:
    """生成「节点→条款」锚点附录（Markdown）。

    每个 L1 列出其 L2 的证据源；每个 L2 列出其文件的证据源
    （doc_id + 页码 + 条款号）；未知如实标「未定位」，缺证据标「拒收」。
    """
    lines = [
        "# 证据锚点附录（节点→条款）",
        "",
        "- 锚律：无证据节点拒收；页码/条款号未实证时如实标注「未定位」，不填猜测值。",
        "",
    ]
    for l1 in bp.get("tree", {}).get("l1", []):
        lines.append(f"## {l1.get('code', '')} {l1.get('name', '')}".strip())
        lines.append("")
        for l2 in l1.get("l2", []):
            files = l2.get("files", [])
            anchored = sum(1 for f in files if f.get("evidence"))
            lines.append(f"### {l2.get('code', '')} {l2.get('name', '')}"
                         f"（{len(files)}件·{anchored}件已锚）".strip())
            lines.append("")
            lines += ["| # | 文件 | 来源 | doc_id | 页码 | 条款号 | 置信度 |",
                      "|---|------|------|--------|------|--------|--------|"]
            for i, f in enumerate(files, 1):
                ev = f.get("evidence")
                if not ev:
                    lines.append(f"| {i} | {f.get('name', '')} | - | 缺证据·拒收 | - | - | - |")
                    continue
                if not isinstance(ev, dict):
                    ev = ev.to_dict() if hasattr(ev, "to_dict") else dict(ev)
                page = ev.get("page") if ev.get("page") is not None else "未定位"
                clause = ev.get("clause") or "未定位"
                lines.append(f"| {i} | {f.get('name', '')} | {ev.get('source', '')} "
                             f"| {ev.get('doc_id', '')} | {page} | {clause} "
                             f"| {float(ev.get('confidence', 0)):.1f} |")
            lines.append("")
    return "\n".join(lines).rstrip() + "\n"
