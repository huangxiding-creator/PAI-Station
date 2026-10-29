# -*- coding: utf-8 -*-
"""证据树引擎（W3 核心件）：研究报告产线 API 化调研能力 → 知识库三级编目树。

用户令（铁律）：编目树必须基于真实调研生成（非种子预置）。本引擎消费
channel_adapters 渠道适配器（wenku/djyanbao/doc88/chinca/ima，W5 元数据层）
实测产出的 FileMeta 文档池——从真实标题聚类出主题簇（L2），上卷中图法大类
（L1），组内文件槽全部为真实检索结果；种子只在「某 L1 大类下簇<2」时补 1 组
结构性兜底组，占位槽以「检索未覆盖·示例占位」+ badge=seed_fallback 如实标注，
绝不冒充真实检索文件。

管线（纯规则：零 LLM、零网络——网络腿全在渠道适配器内，本件只消费其产出）：
  cluster_pool(metas)              真实文档池 → TopK 主题簇
                                  （分词=thuocl 词表最长命中优先 + 未命中段 CJK bigram；
                                   K=8-16 按池规模自适应；无命中文档归「综合资料」兜底簇）
  build_evidence_tree(text, metas, need)
                                  簇 → L2 组（组内=真实文件槽：title/fmt/pages/source_url
                                  全真实，缺如实 None）→ 中图法大类 L1 上卷（taxonomy.CLC_22
                                  别名命中；未命中→「行业实务/参考资料」通用类）→ 种子兜底
                                  补组（taxonomy_loader 六库 49 分组取该类就近种子）→
                                  配比/统计/报价（tier_counts 纯函数 + engine.QUOTE_PARAMS
                                  A 档公式沿用）→ validate_tree 防环护栏（既有件复用）。

纪律（W3 通用纪律，逐条在案）：
  - engine.py / blueprint.py 现有逻辑零改动：本件只 import 其纯函数与常量
    （blueprint.tier_counts / split_files / validate_tree / assemble_blueprint、
    engine.QUOTE_PARAMS / RATIO_BY_SIZE / validate_need），不碰不覆写；
  - 零造假：空池 raise ValueError 禁空树（检索不到如实计 0，不虚构树）；
    pages/source_url 渠道缺字段如实 None；size_kb 为保守估算（engine 占位槽
    EXT_BYTES 同口径，provenance 显式注明估算属性）；渠道不可知如实记 unknown；
  - 确定性：无随机源、无时钟，同输入必同输出；
  - provenance.evidence_tree 如实记账：pool_size / per_channel_counts /
    clusters_from_evidence / clusters_fallback / real_file_ratio（真实槽/总槽，
    真实计算不手填）。
"""
from __future__ import annotations

import re

from . import evidence as _evidence
from .blueprint import (MAX_FILES_PER_DIR, TIERS, assemble_blueprint, split_files,
                        tier_counts, validate_tree)
from .engine import QUOTE_PARAMS, RATIO_BY_SIZE, validate_need
from .metadata import EXT_BYTES, sanitize_filename
from .taxonomy import CLC_22
from .thuocl_lex import load_thuocl, word_df_index
from .industry_lexicon import humanize  # B2 行业话术命名（轴③）：簇名→行业话语，接线见 industry_lexicon.py 模块头说明

# taxonomy_loader 位于 kb_factory 根（本包上级）：两种导入模式（kb_factory.catalog_engine.*
# 全限定 与 kb_factory/ 入 sys.path 的 catalog_engine.*）都合法接线，与
# taxonomy_loader.py 自身回退 import 同款双轨。
try:
    from .. import taxonomy_loader as _taxonomy_loader
except ImportError:  # pragma: no cover - sys.path 直挂 kb_factory/ 的测试/CLI 模式
    import taxonomy_loader as _taxonomy_loader

__all__ = ["cluster_pool", "build_evidence_tree",
           "FALLBACK_CLUSTER", "GENERIC_L1", "SEED_FALLBACK_BADGE", "PLACEHOLDER_MARK"]

EVIDENCE_TREE_VERSION = "evidence_tree/1.0.0"
TREE_MODE = "evidence_tree"

# ── 簇参数（K=8-16 自适应；池内文档频率下限）──────────────────────────────
K_MIN, K_MAX = 8, 16          # TopK 主题簇上下限（按池规模自适应：K=clamp(池//4)）
MIN_POOL_DF = 2               # 主题词须命中 >=2 个标题（孤词不成簇）
MAX_LEX_WORD_LEN = 8          # thuocl 词表最长匹配窗口（THUOCL 词长上界实测口径）

# ── 兜底与标注常量（如实区分真实槽与占位槽）───────────────────────────────
FALLBACK_CLUSTER = "综合资料"            # 无命中文档兜底簇名（任务令口径）
GENERIC_L1 = ("Z", "行业实务/参考资料")  # 中图法未命中 → 通用类（Z=综合图书就近，名按任务令）
SEED_FALLBACK_BADGE = "seed_fallback"   # 种子兜底占位槽徽章（区别于渠道徽章闭集，占位专用标记）
PLACEHOLDER_MARK = "检索未覆盖·示例占位"  # 占位槽标题必含的如实标注
SEED_GROUP_SLOTS = 3                     # 兜底组占位槽数（对齐 engine._MIN_SLOTS=3 保底口径）
DEFAULT_SLOT_KB = 500                    # fmt 不在 EXT_BYTES 表时的保守估算（document_engine 同口径）

_CJK_RUN_RE = re.compile(r"[一-鿿]+")
_LATIN_RE = re.compile(r"[A-Za-z][A-Za-z0-9\-+/.]{0,23}")
_EXT_NORMALIZE = {"doc": "docx", "xls": "xlsx"}   # 渠道 fmt → 蓝图 ext 族（enrich.EXT_NORMALIZE 同款）

# 词表索引进程级缓存（143433 词一次载入，重复调用零重读；确定性不受影响）
_LEX_CACHE: dict = {}


def _lexicon_index() -> dict:
    """thuocl 倒排索引 {词: {领域: df}} 惰性缓存（词表命中优先 + DF 加权的取材源）。"""
    if "idx" not in _LEX_CACHE:
        _LEX_CACHE["idx"] = word_df_index(load_thuocl())
    return _LEX_CACHE["idx"]


def reset_lexicon_cache() -> None:
    """清词表缓存（测试注入小词表后复原用；生产链路无需调用）。"""
    _LEX_CACHE.clear()


# ── 一、FileMeta 取值垫片（dict 与 dataclass 双兼容，只读不改入参）─────────

def _m(meta, key, default=None):
    """FileMeta-like（dict 或对象）取字段：dict 走 get，对象走 getattr。"""
    if isinstance(meta, dict):
        return meta.get(key, default)
    return getattr(meta, key, default)


def _meta_title(meta) -> str:
    return str(_m(meta, "title") or "")


def _meta_channel(meta) -> str:
    """渠道名：top-level channel → extra.channel → 如实 unknown（不猜渠道）。"""
    ch = _m(meta, "channel")
    if not ch:
        extra = _m(meta, "extra") or {}
        if isinstance(extra, dict):
            ch = extra.get("channel")
    return str(ch) if ch else "unknown"


def _meta_doc_id(meta):
    extra = _m(meta, "extra") or {}
    if isinstance(extra, dict):
        return extra.get("doc_id") or extra.get("kb_id")
    return None


# ── 二、标题分词（thuocl 词表命中优先 + 未命中段 CJK bigram）──────────────

def _lex_scan(run: str, lex_idx: dict) -> list:
    """单段 CJK：贪心最长匹配词表词（len>=2）；未覆盖区段滑窗出 2-4 连 gram
    （bigram 为基，连 3/4 gram 供长主题词成簇——「水利水电」级主题才能整词成簇）。"""
    n = len(run)
    tokens, spans, i = [], [], 0
    while i < n:
        hit = None
        for ln in range(min(MAX_LEX_WORD_LEN, n - i), 1, -1):
            w = run[i:i + ln]
            if w in lex_idx:
                hit = w
                break
        if hit:
            tokens.append(hit)
            spans.append((i, i + len(hit)))
            i += len(hit)
        else:
            i += 1
    covered = set()
    for a, b in spans:
        covered.update(range(a, b))
    j = 0
    while j < n:                      # 未匹配区段 → 滑窗 2-4 gram（孤字不成词）
        if j in covered:
            j += 1
            continue
        k = j
        while k < n and k not in covered:
            k += 1
        seg = run[j:k]
        for ln in (2, 3, 4):
            for t in range(len(seg) - ln + 1):
                tokens.append(seg[t:t + ln])
        j = k
    return tokens


def _tokenize(title: str, lex_idx: dict) -> list:
    """标题 → token 列表：CJK 段走词表优先扫描；拉丁串整串（统一大写，EPC/P6/GB50500）。"""
    tokens: list = []
    for run in _CJK_RUN_RE.findall(title or ""):
        tokens.extend(_lex_scan(run, lex_idx))
    for m in _LATIN_RE.finditer(title or ""):
        tokens.append(m.group(0).upper())
    return tokens


# ── 三、聚类：真实文档池 → TopK 主题簇 ────────────────────────────────────

def _adaptive_k(pool_size: int) -> int:
    """K=8-16 按池规模自适应：clamp(池//4, 8, 16)（30 池→8，64 池→16，再大封顶）。"""
    return min(K_MAX, max(K_MIN, pool_size // 4))


def _make_df(titles: list):
    """标题包含计数器（带记忆化）：df(s)=标题包含 s 为子串的篇数（确定性）。"""
    memo: dict = {}

    def df(term: str) -> int:
        if term not in memo:
            memo[term] = sum(1 for t in titles if term in t)
        return memo[term]

    return df


_CJK_CHAR_RE = re.compile(r"[一-鿿]")


def _neighbor_chars(term: str, titles: list, left: bool) -> list:
    """term 在各标题中出现处的左/右邻 CJK 字（去重排序，确定性；跨出 CJK 不扩）。"""
    chars = set()
    for t in titles:
        pos = t.find(term)
        while pos >= 0:
            ch = t[pos - 1] if left else (t[pos + len(term)] if pos + len(term) < len(t) else "")
            if ch and _CJK_CHAR_RE.match(ch):
                chars.add(ch)
            pos = t.find(term, pos + 1)
    return sorted(chars)


def _maximal_phrase(seed: str, titles: list, df) -> str:
    """种子词 → 支持度不变的最大短语：逐字向右/左扩（扩后 df 不降即并入），
    「水利水电」级主题词由此整词成簇（右扩优先，确定性）。
    只沿 CJK 字扩展（不吞 EPC 等拉丁前缀，防跨文字混并）。"""
    term = seed
    while True:
        cur_df = df(term)
        grown = False
        for ch in _neighbor_chars(term, titles, left=False):
            if df(term + ch) == cur_df:
                term += ch
                grown = True
                break
        if grown:
            continue
        for ch in _neighbor_chars(term, titles, left=True):
            if df(ch + term) == cur_df:
                term = ch + term
                grown = True
                break
        if not grown:
            return term


def _claim_clusters(titles: list, token_docs: dict, lex_idx: dict, pool_size: int) -> list:
    """TopK 主题簇遴选+归簇（确定性，最长优先认领）：
    ① 候选=分词 token 种子经最大短语化（df>=MIN_POOL_DF 才入局）；
    ② 排序=词长降序 → 词频降序 → thuocl DF 降序 → 字典序——长而具体的主题词
       先认领文档，「工程」级泛词吞不了「工程总承包/水利水电工程」的文档；
    ③ 认领互斥：每文档只归首个（最长）认领簇；短词剩余可认领文档 <MIN_POOL_DF
       则不成簇（子串分票/泛词大簇两大坑同时杜绝）；
    ④ 簇数截 K=自适应档（8-16）。返回簇列表（docs=本簇认领的池内序号）。"""
    df = _make_df(titles)
    phrases, seen = [], set()
    for seed in token_docs:                       # 种子=词表词+2-4 gram（词频门槛内）
        if len(seed) < 2 or df(seed) < MIN_POOL_DF:
            continue
        p = _maximal_phrase(seed, titles, df)
        if p not in seen:
            seen.add(p)
            phrases.append(p)
    ranked = sorted(phrases, key=lambda p: (-len(p), -df(p),
                                            -(max(lex_idx.get(p, {}).values(), default=0)
                                              if lex_idx else 0), p))
    selected, claimed = [], set()
    k = _adaptive_k(pool_size)
    for term in ranked:
        if len(selected) >= k:
            break
        docs = {i for i, t in enumerate(titles) if term in t}
        fresh = docs - claimed
        if len(fresh) < MIN_POOL_DF:
            continue                              # 剩余可认领不足 → 不成簇（防泛词残簇）
        selected.append({"name": term, "docs": sorted(fresh), "pool_df": df(term),
                         "thuocl_df": max(lex_idx.get(term, {}).values(), default=0)
                         if lex_idx else 0})
        claimed |= docs
    return selected


def cluster_pool(metas: list, lex_idx: dict | None = None) -> list:
    """真实文档池 → 主题簇列表（纯函数，metas 只读不改）。

    分词（thuocl 词表命中优先+未命中段 2-4 gram）→ 种子最大短语化 → 最长优先
    认领。返回 [{"name": 主题词, "size": 组内文档数, "pool_df": 词频,
    "thuocl_df": 词表DF, "docs": [池内文档序号]}, ...]——docs 互斥分区
    （零遗漏零重复）；无认领文档归「综合资料」兜底簇（零文档不产出兜底簇）。
    空池如实返回 []（造树层的空池拒收见 build_evidence_tree）。"""
    if not metas:
        return []
    lex_idx = _lexicon_index() if lex_idx is None else lex_idx
    titles = [_meta_title(m) for m in metas]
    token_docs: dict = {}
    for i, t in enumerate(titles):          # 词频统计：token → 命中标题集合（种子源）
        for tok in set(_tokenize(t, lex_idx)):
            token_docs.setdefault(tok, set()).add(i)
    clusters = _claim_clusters(titles, token_docs, lex_idx, len(metas))
    for c in clusters:
        c["size"] = len(c["docs"])
    taken = {i for c in clusters for i in c["docs"]}
    rest = [i for i in range(len(titles)) if i not in taken]
    if rest:                                # 无命中 → 「综合资料」兜底簇（真实文档，如实归集）
        clusters.append({"name": FALLBACK_CLUSTER, "size": len(rest),
                         "pool_df": len(rest), "thuocl_df": 0, "docs": rest,
                         "fallback": True})
    return clusters


# ── 四、中图法大类上卷（簇 → L1）与种子兜底 ───────────────────────────────

def _clc_rollup(cluster: dict, titles: list):
    """簇 → 中图法大类码：簇名别名命中（权重 10，簇名=真实主题词最可信）+
    组内标题别名命中（每处权重 1）打分；全零 → None（调用方落通用类）。
    平分取 CLC_22 表序（taxonomy 静态表序，确定性）。"""
    docs_text = "|".join(titles[i] for i in cluster["docs"])
    name = cluster["name"]
    best, best_key = 0, None
    for idx, c in enumerate(CLC_22):
        score = 0
        for a in c["aliases"]:
            if a in name:
                score += 10
            score += docs_text.count(a)
        if score > 0 and (best_key is None or score > best):
            best, best_key = score, (c["code"], idx)
    return best_key[0] if best_key else None


def _l1_identity(code):
    """簇的中图法大类身份：命中 → (类码, CLC_22 类名)；未命中 → 通用类
    （Z=综合图书就近，类名按任务令「行业实务/参考资料」）。"""
    if code is None:
        return GENERIC_L1
    return (code, next(x["name"] for x in CLC_22 if x["code"] == code))


def _bigrams(text: str) -> set:
    out = set()
    for run in _CJK_RUN_RE.findall(text or ""):
        for i in range(len(run) - 1):
            out.add(run[i:i + 2])
    return out


def _seed_group_for(l1_name: str, probe_terms: list, taken: set):
    """种子兜底组名：从 taxonomy_loader 六库 49 分组取该类就近种子——
    分组名与（L1 类名+组内簇名）共享 CJK bigram 数最高者（平分取六库表序）；
    零命中 → 「综合资料」通用组在册名兜底；全部同名被占 → 首个未占组。
    返回 (组名, 命中分) 或 (None, 0)（taxonomy_loader 缺席/49 组全被占，如实不造名）。"""
    try:
        libs = _taxonomy_loader.six_domains()
    except Exception:
        return None, 0                     # 种子源不可用 → 如实无兜底（provenance 记缺席）
    probe = _bigrams(l1_name + "".join(probe_terms))
    best_name, best_score = None, 0
    first_free = None
    for lib in libs:
        for g in lib["groups"]:
            if g in taken:
                continue
            if first_free is None:
                first_free = g
            score = len(probe & _bigrams(g))
            if score > best_score:
                best_name, best_score = g, score
    if best_name is not None and best_score > 0:
        return best_name, best_score
    # 零命中 → 六库在册通用组「综合资料」兜底（被占则首个未占组）
    generic = next((g for lib in libs for g in lib["groups"] if g == FALLBACK_CLUSTER), None)
    if generic is not None and generic not in taken:
        return generic, 0
    return (first_free, 0) if first_free else (None, 0)


# ── 五、文件槽（真实槽 / 种子占位槽，字段口径如实区分）────────────────────

def _real_slot(meta, idx: int, tier: str, name_used: set) -> dict:
    """FileMeta → 真实文件槽（title/fmt/pages/source_url 全真实，缺如实 None）。
    size_kb 为保守估算（EXT_BYTES 口径，非实测——provenance 显式注明）；
    渠道属 evidence.SOURCES 闭集（wenku/gb/ima/local）时按既有锚定律挂 evidence。"""
    title = _meta_title(meta)
    fmt = str(_m(meta, "fmt") or "unknown")
    ext = _EXT_NORMALIZE.get(fmt, fmt)
    pages = _m(meta, "pages")
    source_url = _m(meta, "source_url")
    channel = _meta_channel(meta)
    doc_id = _meta_doc_id(meta)
    nbytes = EXT_BYTES.get(ext, DEFAULT_SLOT_KB * 1024)
    stem = sanitize_filename(title)[:80] or sanitize_filename(
        str(doc_id) if doc_id else f"未命名_{idx:03d}") or f"未命名_{idx:03d}"
    fname = f"{stem}.{ext}"
    k = 2
    while fname in name_used:              # 组内重名防撞（真实件两份都保留，只改文件名）
        fname = f"{stem}__{k:02d}.{ext}"
        k += 1
    name_used.add(fname)
    slot = {"name": fname, "title": title, "fmt": fmt, "ext": ext,
            "pages": pages, "source_url": source_url, "url": source_url,
            "channel": channel, "doc_id": doc_id,
            "size_kb": nbytes // 1024, "tier": tier,
            "badge": str(_m(meta, "badge") or "green_free"),
            "perm": str(_m(meta, "perm") or "green"),
            "real": True}
    if channel in _evidence.SOURCES and (doc_id or title or source_url):
        # 证据锚定（P0 #6 既有件复用）：渠道在 SOURCES 闭集（wenku/gb/ima/local）且
        # 有可锚标识才挂 evidence；渠道不在闭集/无可锚点不硬锚（零造假）
        slot["source"] = channel
        _evidence.anchor_file(slot)
    return slot


def _placeholder_slot(group_name: str, k: int) -> dict:
    """种子兜底占位槽：零体积零来源，标题/徽章双标注「检索未覆盖·示例占位」，
    real=False——结构性规划位，绝不冒充真实检索文件。"""
    stem = sanitize_filename(group_name)
    return {"name": f"{stem}_检索未覆盖_{k:02d}.md",
            "title": f"{group_name}·{PLACEHOLDER_MARK} {k:02d}",
            "fmt": "md", "ext": "md", "pages": None, "source_url": None, "url": None,
            "channel": None, "doc_id": None, "size_kb": 0, "tier": "guide",
            "badge": SEED_FALLBACK_BADGE, "perm": "green",
            "real": False, "origin": "seed_fallback"}


def _tier_tags(n: int, ratio: dict) -> list:
    """n 个槽的档位标签序列（blueprint.tier_counts 纯函数派发，TIERS 序，确定性）。"""
    counts = tier_counts(n, ratio)
    return [t for t in TIERS for _ in range(counts[t])]


def _percent(counts: dict) -> dict:
    """三档实数 → 百分比配比（最大余数法，和恒=100；口径同 engine._ratio_from_tiers）。"""
    total = sum(counts.get(t, 0) for t in TIERS)
    floors = {t: counts.get(t, 0) * 100 // total for t in TIERS}
    rem = 100 - sum(floors.values())
    order = sorted(TIERS, key=lambda t: (-(counts.get(t, 0) * 100 / total - floors[t]),
                                         TIERS.index(t)))
    for t in order[:rem]:
        floors[t] += 1
    return floors


# ── 六、造树入口：真实文档池 → 三级编目树蓝图 ─────────────────────────────

def build_evidence_tree(text, metas: list, need: dict | None = None,
                        clusters: list | None = None) -> dict:
    """证据树蓝图入口（契约同现有蓝图：tree.l1/l2+文件槽/ratio/stats/quote/provenance）。

    - text：一句话需求/域文本（如实入 provenance.text 供审计）；
    - metas：渠道适配器实测 FileMeta 文档池（dict 或 FileMeta 对象均可）；
    - need：引擎 need JSON（{domain,keywords,intent,size_hint}；None 时由 text 派生
      最小 need）。空池 → ValueError（零造假：检索 0 件即拒产树，不虚构）。
    - 真实性铁律：L2 组内文件槽全部来自真实池；种子兜底组如实标注占位；
      real_file_ratio=真实槽/总槽 真实计算。"""
    if not metas:
        raise ValueError("证据树禁空树：真实文档池为空（零造假——检索不到如实计 0，"
                         "不得虚构编目树；请先跑渠道适配器取真实 FileMeta）")
    text = re.sub(r"\s+", " ", str(text or "")).strip()
    if need is None:
        need = {"domain": text[:16] or "证据树知识库", "keywords": [],
                "intent": "真实调研编目", "size_hint": "small"}
    elif isinstance(need, dict):
        need = dict(need)
        need.setdefault("size_hint", "small")   # 轻量补位：只兜 size_hint，其余交引擎门
    else:
        raise ValueError("need 必须是引擎 need dict 或 None")
    need = validate_need(need)                  # 复用引擎需求门（纯函数，非法如实报错）
    base_ratio = RATIO_BY_SIZE[need["size_hint"]]

    titles = [_meta_title(m) for m in metas]
    stage_log = [
        f"S1 池解析: pool={len(metas)} 真实渠道文档（"
        + ",".join(f"{c}:{n}" for c, n in sorted(_channel_counts(metas).items())) + ")"]

    # S2 聚类：真实标题 → TopK 主题簇（无命中→综合资料兜底簇）
    if clusters:
        # B1 轴③接线位（KB-FACTORY 2.0）：evidence_cli 建树前经
        # ontology_align.align_clusters 三重校准的簇原样接管（docs 仍为
        # metas 下标，槽位真源不变）；None/空=旧行为内部自聚——纯增量
        # 形参位，既有调用契约与 engine 开关零改动。
        stage_log.append(f"S2 证据聚类: 外部注入本体对齐簇 {len(clusters)} 簇"
                         "（KB_ONTOLOGY_ALIGN 建树前校准·ontology_align/1.0.0）")
    else:
        clusters = cluster_pool(metas)
        stage_log.append(f"S2 证据聚类: {len(clusters)} 簇（K 自适应={_adaptive_k(len(metas))}，"
                         f"词频>={MIN_POOL_DF}；兜底簇 "
                         f"{sum(c.get('size', 0) for c in clusters if c.get('fallback'))} 件）")

    # S3 上卷：簇 → 中图法大类 L1（别名命中打分；未命中→通用类 Z 行业实务/参考资料）
    l1_order: list = []
    l1_clusters: dict = {}
    cluster_l1 = {}
    for c in clusters:
        key = _l1_identity(_clc_rollup(c, titles))
        if key not in l1_clusters:
            l1_clusters[key] = []
            l1_order.append(key)
        l1_clusters[key].append(c)
        cluster_l1[c["name"]] = key[0]
    l1_order.sort(key=lambda k: (-sum(c["size"] for c in l1_clusters[k]), k[0], k[1]))
    stage_log.append("S3 中图法上卷: " + "、".join(
        f"{k[0]}{k[1]}({len(l1_clusters[k])}簇)" for k in l1_order))

    # S4 造树：L1/L2/真实文件槽（配额=tier_counts 按真实文档数派发）
    l1_nodes, ctx = [], {"files": 0, "real": 0, "ph": 0, "kb": 0, "dirs": 0, "splits": 0,
                         "by_tier": {t: 0 for t in TIERS}, "by_ext": {}, "anchored": 0}
    for i, key in enumerate(l1_order, 1):
        code, cname = key
        l1_dir = f"{code}-{i:02d}"
        l1 = {"code": code, "dir": l1_dir, "path": f"{l1_dir}/", "name": cname,
              "theme": (f"{cname}：真实调研证据上卷（中图法 {code} 类）" if key != GENERIC_L1
                        else f"{cname}：中图法未命中的真实调研证据归集"),
              "source": TREE_MODE, "open": False, "l2": []}
        for j, c in enumerate(l1_clusters[key], 1):
            tags = _tier_tags(len(c["docs"]), base_ratio)
            name_used: set = set()
            slots = [_real_slot(metas[di], di, tags[k] if k < len(tags) else "guide", name_used)
                     for k, di in enumerate(c["docs"])]
            l2 = {"code": f"{l1_dir}/{j:02d}", "dir": f"{j:02d}",
                  "path": f"{l1_dir}/{j:02d}/", "name": humanize(c["name"], need["domain"]),
                  "theme": f"证据聚类组：{c['size']} 件真实检索文档（词频 {c['pool_df']}）",
                  "source": TREE_MODE, "open": False}
            if len(slots) > MAX_FILES_PER_DIR:      # 受控扇出律：>200 自动分拆（既有纯函数）
                safe = sanitize_filename(c["name"])
                l2["split_dirs"] = split_files(safe, slots, base_path=l2["path"])
                l2["files"] = []
                ctx["splits"] += len(l2["split_dirs"])
                ctx["dirs"] += len(l2["split_dirs"])
            else:
                l2["files"] = slots
                ctx["dirs"] += 1
            l2["file_count"] = len(slots)
            _tally(ctx, slots)
            l1["l2"].append(l2)
        l1_nodes.append(l1)
    stage_log.append(f"S4 造树: L1 {len(l1_nodes)} / L2 {sum(len(x['l2']) for x in l1_nodes)}，"
                     f"真实槽 {ctx['real']}（证据锚定 {ctx['anchored']} 件）")

    # S5 种子兜底：某 L1 大类下簇<2 → taxonomy_loader 取该类种子补 1 组（占位如实标注）
    seed_records = []
    for l1 in l1_nodes:
        if len(l1["l2"]) >= 2:
            continue
        taken = {g["name"] for g in l1["l2"]}
        probe_terms = [g["name"] for g in l1["l2"] if g["source"] == TREE_MODE]
        gname, score = _seed_group_for(l1["name"], probe_terms, taken)
        if gname is None:
            seed_records.append({"l1": l1["name"], "group": None, "origin": "seed_fallback",
                                 "note": "taxonomy_loader 种子源不可用/无未占组，如实不补"})
            continue
        j = len(l1["l2"]) + 1
        path = f"{l1['dir']}/{j:02d}/"
        slots = [_placeholder_slot(gname, k) for k in range(1, SEED_GROUP_SLOTS + 1)]
        l2 = {"code": f"{l1['dir']}/{j:02d}", "dir": f"{j:02d}", "path": path,
              "name": gname,
              "theme": f"种子兜底组（检索未覆盖：本类证据簇<2，自 taxonomy_loader 就近补位）",
              "source": "seed_fallback", "origin": "seed_fallback", "open": False,
              "files": slots, "file_count": len(slots)}
        l1["l2"].append(l2)
        ctx["dirs"] += 1
        _tally(ctx, slots)
        seed_records.append({"l1": l1["name"], "group": gname, "origin": "seed_fallback",
                             "match_score": score})
    if seed_records:
        stage_log.append(f"S4b 种子兜底: {len(seed_records)} 组补位（占位槽标注"
                         f"「{PLACEHOLDER_MARK}」badge={SEED_FALLBACK_BADGE}，不冒充真实件）")

    # S5 槽位配比 + S6 统计与报价（报价沿用引擎 A 档公式：QUOTE_PARAMS 纯常量导入，不改不抄数值）
    gb = round(ctx["kb"] / 1024 / 1024, 2)
    stats = {"files": ctx["files"], "real_docs": ctx["real"], "placeholder_slots": ctx["ph"],
             "size_kb": ctx["kb"], "gb": gb,
             "l1_count": len(l1_nodes), "l2_count": sum(len(x["l2"]) for x in l1_nodes),
             "dir_count": ctx["dirs"], "split_dir_count": ctx["splits"],
             "by_tier": ctx["by_tier"], "by_ext": ctx["by_ext"]}
    quote = dict(QUOTE_PARAMS, total=round(QUOTE_PARAMS["base"] + gb * QUOTE_PARAMS["per_gb"], 1))
    stage_log.append(f"S5 槽位配比: 真实 {ctx['real']} 槽 / 占位 {ctx['ph']} 槽，"
                     f"三档 {'/'.join(str(ctx['by_tier'][t]) for t in TIERS)}")
    stage_log.append(f"S6 统计与报价: gb={gb} quote.total={quote['total']}"
                     f"（size_kb 为 EXT_BYTES 口径保守估算，非实测体积）")

    total_slots = ctx["real"] + ctx["ph"]
    provenance = {
        "engine_version": EVIDENCE_TREE_VERSION, "mode": TREE_MODE, "text": text,
        "sources": sorted(_channel_counts(metas)),
        "evidence_tree": {
            "pool_size": len(metas),
            "per_channel_counts": _channel_counts(metas),
            "clusters_from_evidence": sum(1 for x in l1_nodes for g in x["l2"]
                                          if g["source"] == TREE_MODE),
            "clusters_fallback": len(seed_records),
            "real_file_ratio": round(ctx["real"] / total_slots, 4) if total_slots else 0.0,
            "adaptive_k": _adaptive_k(len(metas)),
            "evidence_anchored": ctx["anchored"],
            "cluster_l1": cluster_l1,
            "seed_fallback": seed_records,
            "size_kb_note": "size_kb 为保守估算（metadata.EXT_BYTES 口径，"
                            "缺省 500KB），非渠道实测体积",
        },
        "stage_log": stage_log,
    }

    tree = {"mode": TREE_MODE, "root": need["domain"], "l1": l1_nodes}
    bpd = assemble_blueprint(need["domain"], need, tree, _percent(ctx["by_tier"]),
                             stats, quote, provenance)

    # S7 防环护栏（既有 validate_tree 四查复用；有问题记账不阻断，engine 同款纪律）
    problems = validate_tree(bpd)
    if problems:
        provenance["lint"] = {"tree_problems": problems}
        print(f"[evidence_tree] 警告: 树结构护栏发现 {len(problems)} 处问题（不阻断）")
    stage_log.append(f"S7 防环护栏: validate_tree "
                     f"{'全绿' if not problems else f'{len(problems)} 处问题已记 provenance.lint'}")
    return bpd


def _channel_counts(metas: list) -> dict:
    """池内渠道分布（真实计数；渠道不可知如实归 unknown）。"""
    out: dict = {}
    for m in metas:
        ch = _meta_channel(m)
        out[ch] = out.get(ch, 0) + 1
    return out


def _tally(ctx: dict, slots: list) -> None:
    """槽位入账（真实/占位分计，数字零造假：估算体积只进 size_kb 不冒充实测）。"""
    for s in slots:
        ctx["files"] += 1
        ctx["kb"] += s.get("size_kb", 0)
        if s.get("real"):
            ctx["real"] += 1
            if s.get("evidence"):
                ctx["anchored"] += 1
        else:
            ctx["ph"] += 1
        ctx["by_tier"][s.get("tier", "guide")] = ctx["by_tier"].get(s.get("tier", "guide"), 0) + 1
        ext = s.get("ext") or s.get("fmt") or "unknown"
        ctx["by_ext"][ext] = ctx["by_ext"].get(ext, 0) + 1
