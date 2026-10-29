# -*- coding: utf-8 -*-
"""structure_miner — 结构优先种子挖掘器（KB-FACTORY 编目引擎 v2 P0 #2，2026-10-22）。

Top 模式 #2（OntologyAutoGeneration 调研结论）：与其让 LLM/规则从零造目录树，
不如先挖掘文档既有结构——标准/规范的条款编号体系（章/条、1.1、5.2.1）本身就是
现成的 2-3 级权威分类法，目录页是现成的树，标题术语是现成的领域种子词。

三件能力（全部纯正则、纯 stdlib、零 LLM、零随机源；同输入必同输出）：
- mine_clause_hierarchy(text)   法规/标准正文 → 条款层级节点
- mine_toc_structure(text)      目录页文本 → 目录树节点
- extract_domain_seeds(docs)    DocFile 列表 → 领域种子词/编号暗示/类型分布
"""
from __future__ import annotations

import re
from collections import Counter

from .document_engine import DocFile, classify_doc

__all__ = ["mine_clause_hierarchy", "mine_toc_structure", "extract_domain_seeds"]

# ── 通用正则 ─────────────────────────────────────────────────────────────

_CN = "一二三四五六七八九十百千零〇两"

# 中文序数标题：第X章 / 第X节 / 第X条（行首，题可在同行或下一行）
_CH_RE = re.compile(rf"^(第[{_CN}]+章)[ \t　]*(.*)$")
_JIE_RE = re.compile(rf"^(第[{_CN}]+节)[ \t　]*(.*)$")
_TIAO_RE = re.compile(rf"^(第[{_CN}]+条)[ \t　]*(.*)$")

# 小数编号标题：1 / 1.1 / 5.2.1（行首 + 分隔 + 非空标题）
_DOTTED_RE = re.compile(r"^(\d{1,3}(?:\.\d{1,3}){0,3})[ \t　]+(\S.*)$")

# 标题句读截断：条款标题取到首个句号/分号为止
_SENT_END_RE = re.compile(r"[。；;]")

# 编号行判定（用于"标题在下一行"时的前瞻排除）
_IS_NUMBERED_RE = re.compile(
    rf"^(第[{_CN}]+[章节条]|\d{{1,3}}(?:\.\d{{1,3}}){{0,3}}[ \t　]+\S|附录)"
)

_TITLE_MAX = 60  # 条款标题截断上限（条文体取首句，超过则截断）


def _clean_title(raw: str, first_sentence: bool = False) -> str:
    """清洗标题：去首尾空白与点线，按需取首句，截断到 _TITLE_MAX。"""
    t = raw.strip().strip("：:，, ").rstrip(".。·… ")
    if first_sentence:
        m = _SENT_END_RE.search(t)
        if m:
            t = t[: m.start()]
    if len(t) > _TITLE_MAX:
        t = t[:_TITLE_MAX]
    return t


def _next_line_as_title(lines: list[str], i: int) -> str:
    """章/节标题为空时，前瞻最近的非空行（短且自身非编号行）作为标题。"""
    for j in range(i + 1, min(i + 4, len(lines))):
        cand = lines[j].strip()
        if not cand:
            continue
        if _IS_NUMBERED_RE.match(cand) or len(cand) > 30:
            return ""
        return cand
    return ""


# ── 1. 条款层级挖掘 ──────────────────────────────────────────────────────

def mine_clause_hierarchy(text: str) -> list[dict]:
    """从法规/标准正文提取条款层级。

    识别两类编号体系（可混排，按行序输出）：
    - 中文序数：第X章(层1) / 第X节(层2) / 第X条(末层)——按实际出现的族压缩层级
    - 小数编号：段数即层级（1→1，1.1→2，5.2.1→3）；裸一级号须 ≤99 且只前进，
      以拒收正文中的数字噪声（如"500 元以上罚款"）

    返回 [{"level": int, "num": str, "title": str}, ...]，按文本行序。
    """
    if not text:
        return []
    lines = text.splitlines()

    # 第一遍：识别实际出现的中文族（章 < 节 < 条），决定各自层级
    fam = {k: bool(re.search(rf"^第[{_CN}]+{k}", text, re.M)) for k in ("章", "节", "条")}
    present = [k for k in ("章", "节", "条") if fam[k]]
    fam_level = {k: rank + 1 for rank, k in enumerate(present)}

    nodes: list[dict] = []
    bare_last: int | None = None  # 裸一级号序列检查（1,2,3,...）

    for i, line in enumerate(lines):
        line = line.rstrip()
        if not line.strip():
            continue

        m = _CH_RE.match(line) or _JIE_RE.match(line)
        if m:
            kind = "章" if m.group(1).endswith("章") else "节"
            title = _clean_title(m.group(2)) or _next_line_as_title(lines, i)
            nodes.append({"level": fam_level[kind], "num": m.group(1), "title": title})
            continue

        m = _TIAO_RE.match(line)
        if m:
            title = _clean_title(m.group(2), first_sentence=True)
            nodes.append({"level": fam_level["条"], "num": m.group(1), "title": title})
            continue

        m = _DOTTED_RE.match(line)
        if m:
            num, title = m.group(1), _clean_title(m.group(2), first_sentence=True)
            depth = num.count(".") + 1
            if depth == 1:
                # 裸一级号防噪：号须 ≤99（标题级号不可能上千）且只前进不后退，
                # 拒收正文数字（如"500 元以上罚款"、表格行）
                n = int(num)
                if n > 99 or (bare_last is not None and n <= bare_last):
                    continue
                bare_last = n
            nodes.append({"level": depth, "num": num, "title": title})

    return nodes


# ── 2. 目录树挖掘 ────────────────────────────────────────────────────────

# 目录行尾页码：点线引导（...... / ………… / ····）或多空白 + 页号
_TOC_PAGE_TAIL_RE = re.compile(r"(?:[.。·…]{2,}[ \t　]*|[ \t　]+)(\d{1,4})[ \t　]*$")

# 目录条目编号：第X部分/篇/章/卷/册 → 层1；第X节 → 层2；附录X → 层1；小数编号 → 段数即层
_TOC_CN_RE = re.compile(rf"^(第[{_CN}]+(?:部分|篇|章|卷|册|节))[ \t　]*(.*)$")
_TOC_APPENDIX_RE = re.compile(r"^(附录[ \t　]*[A-Za-z0-9一二三四五六七八九十]?)[ \t　]*(.*)$")
_TOC_DOTTED_RE = re.compile(r"^(\d{1,3}(?:\.\d{1,3}){0,3})[ \t　]+(\S.*)$")


def mine_toc_structure(text: str) -> list[dict]:
    """从目录页文本提取目录树节点。

    条目形如「第一章 概述…………1」「  1.1 编制目的……2」「附录A 用表……98」。
    返回 [{"level": int, "num": str, "title": str, "page": int|None}, ...]，
    层级规则：第X章/部分/篇/卷/册、附录=1；第X节=2；小数编号段数即层（1.1→2，5.2.1→3）。
    无编号行（含"目 录"头）跳过。
    """
    if not text:
        return []
    nodes: list[dict] = []
    for line in text.splitlines():
        entry = line.strip(" \t　")
        if not entry or re.fullmatch(r"目\s*录", entry):
            continue

        page = None
        m = _TOC_PAGE_TAIL_RE.search(entry)
        if m:
            page = int(m.group(1))
            entry = entry[: m.start()].rstrip(".。·… \t　")

        m = _TOC_CN_RE.match(entry)
        if m:
            level = 2 if m.group(1).endswith("节") else 1
            num, title = m.group(1), _clean_title(m.group(2))
        elif _TOC_APPENDIX_RE.match(entry):
            m2 = _TOC_APPENDIX_RE.match(entry)
            level, num, title = 1, m2.group(1).replace(" ", ""), _clean_title(m2.group(2))
        else:
            m2 = _TOC_DOTTED_RE.match(entry)
            if not m2:
                continue  # 无编号行不是目录条目
            num, title = m2.group(1), _clean_title(m2.group(2))
            level = num.count(".") + 1
        nodes.append({"level": level, "num": num, "title": title, "page": page})
    return nodes


# ── 3. 领域种子提取 ──────────────────────────────────────────────────────

# 停用词：虚词 + 结构性套话（非领域词）
_STOPWORDS = {
    "中华人民共和国", "中华人民共和国的", "的总则", "总则", "附则", "目录", "适用",
    "范围", "范围及", "下列", "规定", "应当", "以下", "以上", "本规范", "本标准",
    "本书", "中的", "以及", "根据", "按照", "要求", "及其", "有关", "用于",
}
_ASCII_STOP = {"SL", "GB", "GBT", "T", "A"}

# 标准号/编号剥离（GB/T 50358、SL 303、5.2.1 等不进种子词）
_CODE_RE = re.compile(r"[A-Za-z]{1,6}\s*/?\s*[A-Za-z]?\s*\d+(?:[.-]\d+)*")
_PUNCT_RE = re.compile(r"[《》〈〉\[\]（）()【】、，。：:；;！!？?“”\"'‘’·—\-—/\\|]+")
_CJK_RUN_RE = re.compile(r"[一-鿿]+")
_ASCII_TOKEN_RE = re.compile(r"[A-Za-z][A-Za-z0-9/-]{1,9}")

# 标题编号暗示 → 归一化标签（小数编号单独按最深深度归报，见下）
_HINT_PATTERNS = [
    (re.compile(rf"第[{_CN}]+部分"), "第X部分"),
    (re.compile(rf"第[{_CN}]+章"), "第X章"),
    (re.compile(rf"第[{_CN}]+节"), "第X节"),
    (re.compile(rf"第[{_CN}]+条"), "第X条"),
    (re.compile(r"附录"), "附录"),
]
_DOTTED_IN_TITLE_RE = re.compile(r"\d+(?:\.\d+){1,3}")

_TOP_TERMS = 20      # core_terms 上限
_MIN_TF = 2          # 领域词最低文档内词频
_NGRAM_LO, _NGRAM_HI = 2, 8   # 中文复合术语最长到 8 字（如"建设工程质量管理"）


def _title_terms(title: str) -> list[str]:
    """单个标题 → 候选词袋：CJK n-gram(2-4) + ASCII 专词（EPC/P6 等）。"""
    cleaned = _CODE_RE.sub(" ", title)
    cleaned = _PUNCT_RE.sub(" ", cleaned)
    bag: list[str] = []
    for run in _CJK_RUN_RE.findall(cleaned):
        if len(run) < _NGRAM_LO:
            continue
        run = run[:16]
        for n in range(_NGRAM_LO, min(_NGRAM_HI, len(run)) + 1):
            bag.extend(run[i: i + n] for i in range(len(run) - n + 1))
    for tok in _ASCII_TOKEN_RE.findall(cleaned):
        if tok.upper() not in _ASCII_STOP and len(tok) >= 2:
            bag.append(tok.upper())
    return bag


def extract_domain_seeds(documents: list) -> dict:
    """从 DocFile 列表（标题+分类）提取领域种子词。

    返回:
        core_terms: 高频专业术语（标题 TF≥2，排除停用词；最大频繁序列语义——
                    凡被等频更长词完全覆盖的短词/跨界碎片一律剪枝，如
                    "水利水电工程"在则"水利水电工""利水电工"不进；按
                    频次↓/词长↓/字典序 排序，≤20 个）
        hierarchy_hints: 标题中出现的编号体系暗示（"第X章""附录""两级编号(x.y)"…）
        type_distribution: 文档类型 → 份数（doc_type 为默认值时按 classify_doc 重判）
    """
    titles: list[str] = []
    dist: Counter = Counter()
    for doc in documents:
        title = (getattr(doc, "title", "") or "").strip()
        if not title:
            continue
        titles.append(title)
        dtype = getattr(doc, "doc_type", "其他") or "其他"
        if dtype == "其他":
            dtype = classify_doc(title)
        dist[dtype] += 1

    # core_terms：TF 统计 + 停用词过滤 + 子串剪枝
    tf: Counter = Counter()
    for title in titles:
        tf.update(t for t in _title_terms(title) if t not in _STOPWORDS)
    pruned = {
        t: c for t, c in tf.items()
        if c >= _MIN_TF
        and not any(t != u and t in u and tf[u] == c for u in tf)
    }
    core_terms = sorted(pruned, key=lambda t: (-pruned[t], -len(t), t))[:_TOP_TERMS]

    # hierarchy_hints：编号体系暗示（小数编号取标题内最深处，不叠报）
    hints: Counter = Counter()
    for title in titles:
        for pat, label in _HINT_PATTERNS:
            if pat.search(title):
                hints[label] += 1
        dotted = _DOTTED_IN_TITLE_RE.findall(title)
        if dotted:
            depth = max(d.count(".") for d in dotted) + 1
            hints["三级编号(x.y.z)" if depth >= 3 else "两级编号(x.y)"] += 1
    hierarchy_hints = [label for label, _ in sorted(hints.items(), key=lambda x: (-x[1], x[0]))]

    return {
        "core_terms": core_terms,
        "hierarchy_hints": hierarchy_hints,
        "type_distribution": dict(sorted(dist.items(), key=lambda x: (-x[1], x[0]))),
    }
