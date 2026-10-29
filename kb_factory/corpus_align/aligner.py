# -*- coding: utf-8 -*-
"""corpus_align.aligner — BERTopic 语料对齐校验腿（KB-FACTORY v2.7 #14）。

职责：整库文档列表 × 蓝图 L2 主题组的语义对齐审计——
  bge-small-zh 嵌入 + BERTopic 主题簇层级 → 对齐蓝图 L2，产出两张清单：
    1) 盲区清单  blind_spots —— 语料里成簇、但蓝图种子（L2）接不住的主题 → 建议加目录
    2) 待归位清单 outliers  —— BERTopic 判离群(topic=-1)的文档 → 人工/规则二次归位

宪法约束（与 catalog_engine 的 stdlib 纯规则宪法并行不悖）：
  1. 惰性依赖铁律：bertopic / sentence-transformers / torch 任一缺席 →
     fail-soft 返回 {available: False, reason: ...}，绝不抛异常、绝不自动安装
     （依赖安装是用户/部署侧决策，不在本模块权限内）。
  2. 引擎核心零污染：重依赖 import 全部收敛在本文件 _run_real_align() 函数体内；
     模块顶层只 import stdlib——catalog_engine 的 stdlib-only 宪法不受触碰。
  3. 蓝图只读：消费蓝图 JSON（tree/ratio/stats/quote/provenance），不改写任何字段；
     本模块产出独立对齐报告，蓝图渲染兼容天然保持（新增物只在输出侧）。
  4. 真跑不可得（bge-small-zh 约100MB 模型下载网络受限等）同样 fail-soft 如实记录，
     绝不假装跑过、绝不降级伪造聚类结果。

参照巨人：MaartenGr/BERTopic（MIT）。
"""
from __future__ import annotations

import importlib.util
import re

# ── 常量（对齐参数集中一处，报告 params 里如实回显） ────────────────────────
REQUIRED_DEPS = ("bertopic", "sentence_transformers", "torch")  # 任一缺席即 fail-soft
DEFAULT_MODEL = "BAAI/bge-small-zh"  # 中文小模型（约100MB，离线部署需预下载）
MIN_DOCS = 4  # 聚类下限：再少 HDBSCAN 无意义（fail-soft 拒跑而非硬跑）
DEFAULT_MATCH_THRESHOLD = 0.45  # 簇↔L2 综合相似度门：低于即盲区
DEFAULT_LEX_WEIGHT = 0.3  # 综合相似度 = (1-w)×语义cos + w×词面bigram_jaccard


# ── 依赖探测（惰性：find_spec 定位，不 import 不触发重载） ──────────────────
def probe_deps(extra=()):
    """探测 REQUIRED_DEPS + extra 是否可定位。缺席 → {available: False, missing, reason}。

    惰性铁律的入口：只看包在不在，绝不代装；探测本身异常也按缺席处理（保守面）。
    """
    missing = []
    for m in tuple(REQUIRED_DEPS) + tuple(extra):
        try:
            if importlib.util.find_spec(m) is None:
                missing.append(m)
        except Exception:  # noqa: BLE001 —— find_spec 异常按缺席算，fail-soft 保守面
            missing.append(m)
    if missing:
        return {"available": False, "missing": missing,
                "reason": "惰性依赖缺席（不自动安装，装齐后自动启用）：" + ", ".join(missing)}
    return {"available": True, "missing": [], "reason": None}


# ── 文档取值（doc 形态宽容：str / dict / DocFile 等对象） ───────────────────
def _first_nonempty(*vals):
    for v in vals:
        v = "" if v is None else str(v).strip()
        if v:
            return v
    return ""


def doc_text(doc) -> str:
    """文档 → 聚类文本：dict 取 text/content/title/name/path；对象取同名属性；str 原样。"""
    if isinstance(doc, str):
        return doc
    if isinstance(doc, dict):
        return _first_nonempty(doc.get("text"), doc.get("content"),
                               doc.get("title"), doc.get("name"), doc.get("path"))
    return _first_nonempty(getattr(doc, "text", None), getattr(doc, "content", None),
                           getattr(doc, "title", None), getattr(doc, "name", None))


def doc_name(doc) -> str:
    """文档 → 展示名（两张清单里给人读的短标识）。"""
    if isinstance(doc, str):
        return doc[:40]
    if isinstance(doc, dict):
        return _first_nonempty(doc.get("name"), doc.get("title"),
                               doc.get("path"), doc.get("text"))[:40]
    return _first_nonempty(getattr(doc, "name", None), getattr(doc, "title", None),
                           getattr(doc, "path", None))[:40]


# ── 蓝图 L2 展平（只读，纯函数，离线可测） ─────────────────────────────────
def _dedup_words(parts) -> list:
    """拼接词面描述面时去重保序（避免同名重复词虚增词面相似度）。"""
    seen, out = set(), []
    for p in parts:
        for w in str(p).split():
            if w and w not in seen:
                seen.add(w)
                out.append(w)
    return out


def iter_l2(bp) -> list:
    """蓝图 L2 主题组展平（只读）：[{code,dir,path,name,theme,l1_code,l1_name,text}]。

    text = L2名+L2主题句+L1名+L1主题句+根域 的去重词拼接——簇↔L2 语义/词面比对用的
    L2 描述面。蓝图形状异常（None/缺 tree/l1 混入非 dict）一律宽容跳过，全空返回 []。
    """
    out = []
    tree = (bp or {}).get("tree") or {} if isinstance(bp, dict) else {}
    root = (bp.get("domain") or tree.get("root") or "") if isinstance(bp, dict) else ""
    for l1 in tree.get("l1") or []:
        if not isinstance(l1, dict):
            continue
        for l2 in l1.get("l2") or []:
            if not isinstance(l2, dict):
                continue
            text = " ".join(_dedup_words([l2.get("name", ""), l2.get("theme", ""),
                                          l1.get("name", ""), l1.get("theme", ""), root]))
            out.append({"code": l2.get("code") or l2.get("path") or "", "dir": l2.get("dir", ""),
                        "path": l2.get("path", ""), "name": l2.get("name", ""),
                        "theme": l2.get("theme", ""), "l1_code": l1.get("code", ""),
                        "l1_name": l1.get("name", ""), "text": text})
    return out


# ── 词面相似（中文二元组 Jaccard，纯函数，离线可测） ───────────────────────
_JUNK_PAT = re.compile(r"[^\w\u4e00-\u9fff]+")
_CJK_RE = re.compile(r"[\u4e00-\u9fff]")      # top_words 可读门：含汉字
_ASCII_WORD_RE = re.compile(r"[A-Za-z]{2}")   # 或含 ≥2 连字母（英文语料兼容）


_TEXT_ONLY_PAT = re.compile(r"[^A-Za-z\u4e00-\u9fff]+")  # 只留汉字与字母


def _text_only(s: str) -> str:
    """可读门预处理器：数字/标点/空白全替空格——top_words 排名层面即剔碎片。"""
    return _TEXT_ONLY_PAT.sub(" ", str(s).lower())


def _clean_topic_words(raw, limit: int) -> list:
    """簇词面清理：strip 边界空白碎片、可读门（含汉字或 ≥2 连字母）、去重保序。"""
    out = []
    for w, _ in raw or []:
        w = w.strip()
        if w and (_CJK_RE.search(w) or _ASCII_WORD_RE.search(w)) and w not in out:
            out.append(w)
        if len(out) >= limit:
            break
    return out



def _norm_tokens(s: str) -> list:
    s = _JUNK_PAT.sub(" ", str(s).lower())
    return [t for t in s.split() if t]


def bigrams(s: str) -> set:
    """中文友好二元组集：逐 token 出 2-gram；单字 token 原样保留。"""
    out = set()
    for t in _norm_tokens(s):
        if len(t) >= 2:
            out.update(t[i:i + 2] for i in range(len(t) - 1))
        else:
            out.add(t)
    return out


def bigram_jaccard(a: str, b: str) -> float:
    """词面相似度 ∈ [0,1]：bigram 集 Jaccard；任一侧退化为空时按字符集比。"""
    A, B = bigrams(a), bigrams(b)
    if not A or not B:  # 单字/空串退化面：字符集兜底，避免空面恒 0 主导裁定
        A = set("".join(_norm_tokens(a)))
        B = set("".join(_norm_tokens(b)))
    u = A | B
    return len(A & B) / len(u) if u else 0.0


# ── 簇×L2 裁定（纯函数，离线可测） ────────────────────────────────────────
def match_clusters_to_l2(sims, threshold=DEFAULT_MATCH_THRESHOLD) -> dict:
    """相似度矩阵 → 匹配裁定。

    sims[i][j] = 簇 i 对 L2 j 的综合相似度。规则（确定性）：
      - 每簇取 argmax（并列取小下标）；≥threshold 记 matched
      - 未过门 = 盲区（blind）；被任一簇认领的 L2 = covered，其余 uncovered
    """
    assignments, blind, covered = [], [], set()
    for i, row in enumerate(sims):
        best_j, best_s = -1, -1.0
        for j, s in enumerate(row):
            if s > best_s:  # 严格大于 → 并列保留小下标
                best_j, best_s = j, s
        ok = best_j >= 0 and best_s >= threshold
        assignments.append({"cluster": i, "l2_index": best_j if best_j >= 0 else None,
                            "similarity": round(best_s, 4), "matched": ok})
        if ok:
            covered.add(best_j)
        else:
            blind.append(i)
    n_l2 = max((len(r) for r in sims), default=0)
    return {"assignments": assignments, "blind": blind, "covered_l2": sorted(covered),
            "uncovered_l2": [j for j in range(n_l2) if j not in covered]}


# ── 对齐入口（惰性依赖 + fail-soft，永不向上抛） ───────────────────────────
def align_corpus(docs, bp, *, model_name=DEFAULT_MODEL,
                 match_threshold=DEFAULT_MATCH_THRESHOLD, min_topic_size=None,
                 top_n_words=10, lex_weight=DEFAULT_LEX_WEIGHT, seed=42) -> dict:
    """整库文档列表 × 蓝图 L2 语义对齐（BERTopic 聚类腿）。

    docs：文档列表（str / dict(text|content|title|name|path) / DocFile 对象均可）
    bp：蓝图 JSON（只读；消费 tree.l1[*].l2[*]）

    返回（两种形态，全 JSON 可序列化）：
      可跑：{available: True, clusters, hierarchy, blind_spots, outliers,
             l2_coverage, coverage, params, notes, ...}
      不可跑：{available: False, stage: input|deps|runtime, reason, doc_count, l2_count}
      stage 语义：input=语料/蓝图不达标（纯规则）；deps=重依赖缺席；
      runtime=真跑失败（模型下载网络受限等，如实记录，绝不假装跑过）。
    """
    docs = list(docs or [])
    n = len(docs)
    l2_list = iter_l2(bp)
    base = {"doc_count": n, "l2_count": len(l2_list)}

    # 纯规则先行校验（离线可测，不触重依赖）
    if n < MIN_DOCS:
        return {"available": False, "stage": "input",
                "reason": f"语料不足：{n} < {MIN_DOCS}（BERTopic 聚类下限）", **base}
    if not l2_list:
        return {"available": False, "stage": "input",
                "reason": "蓝图无 L2 主题组（tree.l1[*].l2 为空或缺 tree 结构）", **base}
    texts = [doc_text(d) for d in docs]
    names = [doc_name(d) for d in docs]
    if not any(t.strip() for t in texts):
        return {"available": False, "stage": "input",
                "reason": "文档均无可聚类文本（text/content/title/name/path 全空）", **base}

    probe = probe_deps()
    if not probe["available"]:
        return {"available": False, "stage": "deps", "missing": probe["missing"],
                "reason": probe["reason"], **base}

    try:  # 真跑区：任何异常（含模型下载网络受限）→ fail-soft 如实记录，绝不向上抛
        return _run_real_align(texts, names, l2_list, model_name=model_name,
                               match_threshold=match_threshold, min_topic_size=min_topic_size,
                               top_n_words=top_n_words, lex_weight=lex_weight, seed=seed)
    except Exception as exc:  # noqa: BLE001 —— fail-soft 铁律要求吞全谱异常并留 reason
        return {"available": False, "stage": "runtime",
                "reason": f"对齐执行失败({type(exc).__name__}): {exc}", **base}


# ── 真聚类+对齐（全模块唯一重依赖区；引擎核心零污染） ──────────────────────
def _run_real_align(texts, names, l2_list, *, model_name, match_threshold,
                    min_topic_size, top_n_words, lex_weight, seed) -> dict:
    """真跑区：惰性 import bertopic/sentence-transformers（巨人 MaartenGr/BERTopic, MIT）。"""
    import numpy as np
    from bertopic import BERTopic
    from sentence_transformers import SentenceTransformer
    from sklearn.feature_extraction.text import CountVectorizer
    from umap import UMAP

    n = len(texts)
    notes = []

    # 1) 嵌入：bge-small-zh（归一化；网络受限时 SentenceTransformer 构造即抛 → 外层 fail-soft）
    encoder = SentenceTransformer(model_name)
    doc_emb = np.asarray(encoder.encode(texts, normalize_embeddings=True, show_progress_bar=False))
    l2_emb = np.asarray(encoder.encode([x["text"] for x in l2_list],
                                       normalize_embeddings=True, show_progress_bar=False))

    # 2) 主题簇：UMAP 降维（小语料参数自适配 + 固定 seed 可复现）+ HDBSCAN（BERTopic 默认）
    mts = min_topic_size or max(2, min(10, n // 6))
    umap_model = UMAP(n_neighbors=max(2, min(15, n - 1)), n_components=max(2, min(5, n - 2)),
                      metric="cosine", random_state=seed, low_memory=True)
    # 中文分词替身：字符二元组向量化（零分词依赖，top_words 出可读二字词）
    vectorizer = CountVectorizer(analyzer="char", ngram_range=(2, 2), min_df=1,
                                 preprocessor=_text_only)  # 可读门内建：排名只认汉字/字母
    # 大坑在案：BERTopic 缺省 language="english" 会在 c-TF-IDF 前剔光非 A-Za-z0-9 字符，
    # 中文语料只剩数字碎片——必须显式声明中文（嵌入已自备，language 只影响预处理）
    tm = BERTopic(min_topic_size=mts, top_n_words=top_n_words, umap_model=umap_model,
                  vectorizer_model=vectorizer, calculate_probabilities=False,
                  language="chinese (simplified)")
    topics = list(tm.fit_transform(texts, embeddings=doc_emb)[0])

    # 3) 主题簇层级（细→粗两级行）：细簇数 > L2 数时按 c-TF-IDF 归并到 ≤L2 数的粗层
    fine_ids = sorted({t for t in topics if t != -1})
    fine_map = {t: t for t in fine_ids}  # 细→粗（不归并时恒等）
    if len(fine_ids) > max(1, len(l2_list)):
        fine_of_doc = topics[:]
        tm.reduce_topics(texts, embeddings=doc_emb, nr_topics=max(2, len(l2_list)))
        topics = list(tm.topics_)
        votes = {}  # 归并映射按文档共现多数票回填（并列取小簇号，确定性）
        for f, c in zip(fine_of_doc, topics):
            if f != -1 and c != -1:
                votes.setdefault(f, {})
                votes[f][c] = votes[f].get(c, 0) + 1
        for f, cnt in votes.items():
            fine_map[f] = max(sorted(cnt), key=lambda c: cnt[c])
        notes.append(f"主题簇层级：细簇 {len(fine_ids)} → 粗簇归并（目标 ≤L2 数 {len(l2_list)}）")
    else:
        notes.append("主题簇层级：细簇数 ≤ L2 数，粗层=细层（无需归并）")

    # 4) 粗簇成员与描述
    coarse_ids = sorted({t for t in topics if t != -1})
    clusters = []
    for cid in coarse_ids:
        idxs = [i for i, t in enumerate(topics) if t == cid]
        words = _clean_topic_words(tm.get_topic(cid), top_n_words)  # 可读门：剔碎片+去重
        clusters.append({"topic": cid, "count": len(idxs), "top_words": words,
                         "doc_indices": idxs, "doc_names": [names[i] for i in idxs],
                         "fine_topics": sorted(f for f, c in fine_map.items() if c == cid)})

    # 5) 簇×L2 综合相似度：语义（簇质心×L2嵌入 cos，双方已归一化）+ 词面（bigram jaccard）
    sims = []
    for cl in clusters:
        cent = doc_emb[cl["doc_indices"]].mean(axis=0)
        norm = float(np.linalg.norm(cent))
        cent = cent / norm if norm > 0 else cent
        cos = (l2_emb @ cent).astype(float)
        lex = [bigram_jaccard(" ".join(cl["top_words"]), x["text"]) for x in l2_list]
        sims.append([float((1 - lex_weight) * c + lex_weight * l) for c, l in zip(cos, lex)])
    verdict = match_clusters_to_l2(sims, match_threshold)

    # 6) 盲区清单（种子缺的簇 → 建议加目录）与待归位清单（离群文档）
    blind_spots = []
    for i in verdict["blind"]:
        cl = clusters[i]
        j = verdict["assignments"][i]["l2_index"]
        near = l2_list[j] if j is not None and j >= 0 else None
        top = "、".join(cl["top_words"][:5]) or "（空词面）"
        blind_spots.append({
            "cluster": cl["topic"], "count": cl["count"], "top_words": cl["top_words"],
            "nearest_l2": ({"code": near["code"], "name": near["name"],
                            "l1_name": near["l1_name"]} if near else None),
            "similarity": verdict["assignments"][i]["similarity"],
            "suggestion": (f"语料主题簇（top: {top}；{cl['count']}件）在蓝图 L2 无 "
                           f"≥{match_threshold} 对齐目标——建议增补目录组，候选挂靠 L1："
                           f"{near['l1_name'] if near else '无（蓝图 L1 均不相邻，建议新开一级）'}")})
    out_idx = [i for i, t in enumerate(topics) if t == -1]
    outliers = {"count": len(out_idx),
                "docs": [{"index": i, "name": names[i], "excerpt": texts[i][:50]} for i in out_idx]}

    # 7) 簇对齐明细回填 + L2 覆盖面 + 总覆盖率
    for i, cl in enumerate(clusters):
        a = verdict["assignments"][i]
        cl["matched_l2"] = ({"code": l2_list[a["l2_index"]]["code"],
                             "name": l2_list[a["l2_index"]]["name"],
                             "l1_name": l2_list[a["l2_index"]]["l1_name"]} if a["matched"] else None)
        cl["similarity"] = a["similarity"]
    l2_coverage = {
        "matched": [{"code": l2_list[j]["code"], "name": l2_list[j]["name"]}
                    for j in verdict["covered_l2"]],
        "unmatched": [{"code": l2_list[j]["code"], "name": l2_list[j]["name"]}
                      for j in verdict["uncovered_l2"]]}

    return {
        "available": True,
        "engine": "bertopic+sentence_transformers",
        "model": model_name,
        "doc_count": n,
        "l2_count": len(l2_list),
        "topic_count": len(clusters),
        "params": {"min_topic_size": mts, "match_threshold": match_threshold,
                   "lex_weight": lex_weight, "top_n_words": top_n_words, "seed": seed},
        "hierarchy": {"fine_topic_count": len(fine_ids), "coarse_topic_count": len(clusters),
                      "fine_to_coarse": {str(k): v for k, v in sorted(fine_map.items())}},
        "clusters": clusters,
        "blind_spots": blind_spots,
        "outliers": outliers,
        "l2_coverage": l2_coverage,
        "coverage": {"docs_total": n, "docs_in_topics": n - len(out_idx),
                     "outlier_ratio": round(len(out_idx) / n, 4) if n else 0.0,
                     "l2_total": len(l2_list), "l2_matched": len(verdict["covered_l2"]),
                     "l2_hit_rate": (round(len(verdict["covered_l2"]) / len(l2_list), 4)
                                     if l2_list else 0.0)},
        "notes": notes,
    }
