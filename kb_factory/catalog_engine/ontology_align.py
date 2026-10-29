# -*- coding: utf-8 -*-
"""ontology_align —— B1 本体对齐校准（KB-FACTORY 2.0 百倍质量战役·轴③）。

对 evidence_tree.cluster_pool 产出的主题簇做建树前三重校准（纯规则：
零 LLM、零网络、零随机——同输入必同输出）：
  ① CLC_22 别名归位：簇名恰为 taxonomy.CLC_22 某大类别名、且该别名是
     规范名的连续子串时，改名为中图法规范名（如 哲学→哲学宗教、
     法律→政治法律）。纯域词别名（造价/成本/施工等非子串别名）不动，
     保住 L2 主题粒度不被大类吞并。
  ② fibo/Brick 术语命中校准：簇名命中 fibo_lex / brick_lex 种子注册表——
     zh 精确命中→只挂 aligned_to（概念名即簇名）；en 命中→归中文规范名；
     后缀变体（簇名+设备/管理/系统/工程 在库）→靠拢本体概念名。
     aligned_to 只挂种子注册表里真实存在的 module/concept id（零造假：
     注册表缺席或未命中如实跳过，不硬造对齐）。
  ③ 簇归并：①②改名后的同名簇、人工同义词表、包含簇（名互为连续子串）、
     编辑距离≤1（≥4 字簇名）四路并查集归并；幸存簇=文件数多者（平手取
     原序靠前者，确定性），docs 并集去重、size=len(docs) 重算、pool_df 取大。
如实账：每簇落 provenance.ontology_align = {merged, renamed, aligned_to}
（没动也是空账，一样落键——证明「跑过而无改动」，不冒充没跑）。
接线（evidence_cli 建树前调用；KB_ONTOLOGY_ALIGN=1 默认开，0/false/off/no 关）：
    clusters = tree_mod.cluster_pool(metas_flat)
    clusters = ontology_align.align_clusters(clusters, metas_flat)
    tree_mod.build_evidence_tree(text, metas_flat, need=need, clusters=clusters)
纪律：engine.py / evidence_tree.py 既有开关与行为零改动（evidence_tree 仅增
可选 clusters 形参位，None/空=旧行为不变）；本件只读种子与 taxonomy 常量。
"""
from __future__ import annotations

import os

__all__ = ["align_clusters", "align_summary", "align_enabled",
           "ONTOLOGY_ALIGN_ENV", "ONTOLOGY_ALIGN_VERSION"]

ONTOLOGY_ALIGN_VERSION = "ontology-align/1.0.0"
ONTOLOGY_ALIGN_ENV = "KB_ONTOLOGY_ALIGN"

# ② 后缀变体：簇名+后缀 命中注册表 zh 时靠拢本体概念名（变体名真实在库才改）
_ALIGN_SUFFIXES = ("设备", "管理", "系统", "工程")

# ③ 人工同义词表（工程域常用对，双向等价；仅当两名为当前簇名时才归并）
_SYNONYMS = (
    ("招标投标", "招投标"),
    ("工程造价", "造价"),
    ("施工组织设计", "施组设计"),
    ("安全生产管理", "安全管理"),
    ("水利水电工程", "水利水电"),
)

try:  # 包全限定模式（kb_factory.catalog_engine.ontology_align）
    from .taxonomy import CLC_22
    from . import brick_lex, fibo_lex
except ImportError:  # pragma: no cover - sys.path 直挂 kb_factory/ 的 CLI/测试形态
    from taxonomy import CLC_22  # type: ignore
    import brick_lex  # type: ignore
    import fibo_lex  # type: ignore


def align_enabled() -> bool:
    """KB_ONTOLOGY_ALIGN 默认开（未设/空=1=开）；显式 0/false/off/no 才关。"""
    flag = (os.environ.get(ONTOLOGY_ALIGN_ENV) or "1").strip().lower()
    return flag not in ("0", "false", "off", "no")


# ── ① CLC_22 别名归位表 ────────────────────────────────────────────────────

def _clc_alias_index() -> dict:
    """别名→(大类码, 规范名)。只收「别名是规范名连续子串」的保守归位对
    （哲学→哲学宗教 收；造价→经济 不收——大类名不该吞掉具体主题粒度）。"""
    out: dict = {}
    for c in CLC_22:
        canon = str(c.get("name") or "")
        for alias in c.get("aliases") or ():
            if alias and alias != canon and alias in canon:
                out.setdefault(alias, (c.get("code") or "?", canon))
    return out


# ── ② fibo / Brick 种子注册表索引（懒载缓存；缺席如实记 err 不造假） ────────

_FIBO_IDX: dict = {}
_BRICK_IDX: dict = {}


def _fibo_terms():
    """fibo 种子注册表 → (module, concept_id, zh, en) 迭代器。"""
    reg = fibo_lex.load_registry()
    for cid, rec in reg["concepts"].items():
        yield rec.get("module") or "?", cid, rec.get("zh"), rec.get("en")


def _brick_terms():
    """Brick 工程域种子注册表 → (domain, concept_id, zh, en) 迭代器。"""
    for t in brick_lex.engineering_terms():
        yield t.get("domain") or "?", t["id"], t.get("zh"), t.get("en")


def _build_index(cache: dict, loader) -> dict:
    """zh 精确索引 / en(小写) 索引 / id→zh 反查表；失败如实记 err。"""
    if cache:
        return cache
    zh: dict = {}
    en: dict = {}
    zh_by_id: dict = {}
    try:
        for mod, cid, z, e in loader():
            if z:
                zh.setdefault(z, (mod, cid))
                zh_by_id.setdefault(cid, z)
            if e:
                en.setdefault(str(e).strip().lower(), (mod, cid))
    except Exception as exc:  # 种子缺席/损坏：②如实降级（err 进 summary 对账）
        cache.update({"zh": {}, "en": {}, "zh_by_id": {},
                      "err": f"{type(exc).__name__}: {exc}"})
        return cache
    cache.update({"zh": zh, "en": en, "zh_by_id": zh_by_id, "err": None})
    return cache


def _lexicon_status() -> dict:
    """两注册表可用性如实账（ok / 缺席原因），进 align_summary 供审计。"""
    out: dict = {}
    for name, cache, loader in (("fibo", _FIBO_IDX, _fibo_terms),
                                ("brick", _BRICK_IDX, _brick_terms)):
        idx = _build_index(cache, loader)
        if idx.get("err"):
            out[name] = str(idx["err"])
        elif idx.get("zh"):
            out[name] = "ok"
        else:
            out[name] = "absent"
    return out


def _ontology_hit(name: str):
    """② 命中判定：返回 (规范名, aligned_to 标签, 是否改名) 或 None。
    源序 fibo(财务域) 先于 brick(建筑域)；命中以注册表真实条目为准（零编造）。"""
    for source, cache, loader in (("fibo", _FIBO_IDX, _fibo_terms),
                                  ("brick", _BRICK_IDX, _brick_terms)):
        idx = _build_index(cache, loader)
        if idx.get("err"):
            continue
        hit = idx["zh"].get(name)
        if hit:  # zh 精确命中：概念名即簇名，不改名只挂账
            return name, f"{source}:{hit[0]}/{hit[1]}", False
        hit = idx["en"].get(name.strip().lower())
        if hit:  # en 命中 → 归该概念中文规范名（无 zh 如实不硬造）
            zh_name = idx["zh_by_id"].get(hit[1])
            if zh_name:
                return zh_name, f"{source}:{hit[0]}/{hit[1]}", zh_name != name
        for suffix in _ALIGN_SUFFIXES:  # 后缀变体靠拢（变体名真实在库才改）
            cand = name + suffix
            hit = idx["zh"].get(cand)
            if hit:
                return cand, f"{source}:{hit[0]}/{hit[1]}", True
    return None


# ── ③ 归并工具 ─────────────────────────────────────────────────────────────

def _edit_le1(a: str, b: str) -> bool:
    """编辑距离≤1 判定（纯字符级：等长恰一位不同 / 长差 1 恰一增删）。"""
    if a == b or abs(len(a) - len(b)) > 1:
        return False
    if len(a) == len(b):
        return sum(1 for x, y in zip(a, b) if x != y) == 1
    if len(a) > len(b):
        a, b = b, a
    i = j = 0
    skipped = False
    while i < len(a) and j < len(b):
        if a[i] == b[j]:
            i += 1
            j += 1
        elif skipped:
            return False
        else:
            skipped = True
            j += 1
    return True


def _size(cluster: dict) -> int:
    """簇文件数：优先 size 键，缺则数 docs（都没=0，如实）。"""
    v = cluster.get("size")
    if isinstance(v, int) and v >= 0:
        return v
    d = cluster.get("docs")
    return len(d) if isinstance(d, list) else 0


# ── 主入口 ─────────────────────────────────────────────────────────────────

def align_clusters(clusters, metas=None):
    """三重校准主入口（纯函数：逐簇浅拷贝加工，不改入参对象）。
    - clusters：cluster_pool 形态簇列表（name/size/pool_df/docs…；docs=metas 下标）；
    - metas：文档池（任务契约位；本版仅作审计上下文，不参与改写——docs 下标
      对 metas 恒有效，零漂移）；
    - 返回：新簇列表（幸存簇按其首成员原序输出，确定性）；每簇
      provenance.ontology_align={merged:[被并入者入参原名], renamed:[旧名,新名]|[],
      aligned_to:标签|None} 如实记账（无动作=空账，证明跑过）。
    """
    work: list = []
    orig_names: list = []
    for c in clusters or ():
        if not isinstance(c, dict):
            continue  # 非法形状如实跳过（与 evidence_cli 剔非 dict 同纪律）
        work.append(dict(c))
        orig_names.append(str(c.get("name") or "").strip())
    n = len(work)
    tags = [None] * n
    clc_idx = _clc_alias_index()
    clc_canon = {str(c.get("name") or "") for c in CLC_22}

    # ①② 逐簇改名/挂账（fallback 兜底簇与空名簇如实不动）
    for i, w in enumerate(work):
        if w.get("fallback") or not orig_names[i]:
            continue
        clc_hit = clc_idx.get(orig_names[i])
        if clc_hit:
            code, canon = clc_hit
            w["name"] = canon
            tags[i] = f"CLC_22:{code}"
            continue
        ont = _ontology_hit(orig_names[i])
        if ont:
            new_name, tag, _ = ont
            w["name"] = new_name
            tags[i] = tag

    # ③ 四路并查集归并（同名/同义词/包含/编辑距离——并查集对次序不敏感）
    parent = list(range(n))

    def find(x: int) -> int:
        while parent[x] != x:
            parent[x] = parent[parent[x]]
            x = parent[x]
        return x

    def union(x: int, y: int) -> None:
        rx, ry = find(x), find(y)
        if rx != ry:
            parent[max(rx, ry)] = min(rx, ry)  # 小根优先：确定性

    active = [i for i in range(n)
              if not work[i].get("fallback") and work[i].get("name")]
    by_name: dict = {}
    for i in active:
        by_name.setdefault(work[i]["name"], []).append(i)
    for idxs in by_name.values():  # 改名后同名簇
        for k in idxs[1:]:
            union(idxs[0], k)
    names = {i: work[i]["name"] for i in active}
    syn_pairs = {frozenset(p) for p in _SYNONYMS}
    for a in range(len(active)):  # 同义词表 + 包含簇 + 编辑距离（两两一遍过）
        for b in range(a + 1, len(active)):
            i, j = active[a], active[b]
            ni, nj = names[i], names[j]
            if ni == nj or ni in clc_canon or nj in clc_canon:
                continue  # 大类规范名不参与吞并（保粒度；同名已在上一路归并）
            if frozenset((ni, nj)) in syn_pairs:
                union(i, j)
                continue
            if len(ni) >= 2 and len(nj) >= 2 and (ni in nj or nj in ni):
                union(i, j)  # 包含簇：短名是长名连续子串
                continue
            if len(ni) >= 4 and len(nj) >= 4 and _edit_le1(ni, nj):
                union(i, j)  # 编辑距离≤1 的近形簇（≥4 字防误伤短词）

    # 组装幸存簇（组内=文件数多者胜，平手取原序靠前；输出按首成员原序）
    groups: dict = {}
    for i in range(n):
        groups.setdefault(find(i), []).append(i)
    out: list = []
    for root in sorted(groups):
        members = groups[root]
        winner = min(members, key=lambda i: (-_size(work[i]), i))
        w = dict(work[winner])
        seen = set()
        merged_docs = None
        for m in members:  # docs 并集去重（下标升序，仍指向同一 metas 池）
            d = work[m].get("docs")
            if not isinstance(d, list):
                continue
            if merged_docs is None:
                merged_docs = []
            for x in d:
                if x not in seen:
                    seen.add(x)
                    merged_docs.append(x)
        if merged_docs is not None:
            merged_docs.sort()
            w["docs"] = merged_docs
            w["size"] = len(merged_docs)  # size 以并集实数重算（数字零造假）
        else:
            sizes = [work[m].get("size") for m in members
                     if isinstance(work[m].get("size"), int)]
            w["size"] = sum(sizes) if sizes else w.get("size", 0)
        dfs = [work[m].get("pool_df") for m in members
               if isinstance(work[m].get("pool_df"), int)]
        if dfs:
            w["pool_df"] = max(dfs)
        account = {
            "merged": [orig_names[m] for m in members if m != winner],
            "renamed": ([orig_names[winner], w["name"]]
                        if orig_names[winner] != w["name"] else []),
            "aligned_to": tags[winner],
        }
        prov = w.get("provenance")
        if not isinstance(prov, dict):
            prov = {}
        prov["ontology_align"] = account
        w["provenance"] = prov
        out.append(w)
    return out


def align_summary(clusters, clusters_in=None) -> dict:
    """从对齐后簇列表提取总账（evidence_cli 落 provenance.ontology_align 用）。
    merged/renamed 为 [入参原名, 幸存名] 对清单；aligned_to 为 幸存名→标签 映射。"""
    merged, renamed, aligned_to = [], [], {}
    for c in clusters or ():
        if not isinstance(c, dict):
            continue
        account = ((c.get("provenance") or {}).get("ontology_align") or {})
        name = c.get("name")
        for absorbed in account.get("merged") or ():
            merged.append([absorbed, name])
        pair = account.get("renamed") or []
        if isinstance(pair, (list, tuple)) and len(pair) == 2:
            renamed.append([pair[0], pair[1]])
        if account.get("aligned_to"):
            aligned_to[name] = account["aligned_to"]
    seq = list(clusters or ())
    n_in = clusters_in if clusters_in is not None else len(seq)
    stage = (f"in={n_in} out={len(seq)} merged={len(merged)} "
             f"renamed={len(renamed)} aligned={len(aligned_to)}")
    return {
        "enabled": True,
        "clusters_in": n_in,
        "clusters_out": len(seq),
        "merged": merged,
        "renamed": renamed,
        "aligned_to": aligned_to,
        "lexicons": _lexicon_status(),
        "version": ONTOLOGY_ALIGN_VERSION,
        "stage": stage,
    }
