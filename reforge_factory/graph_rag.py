# -*- coding: utf-8 -*-
"""graph_rag — P1-1 LightRAG 图谱层集成件 (终极提案 P1-1, 1028 用户已批).

思想来源: HKUDS/LightRAG (MIT, 40,369★, vendors/lightrag 本地只读镜像) —
双层检索 (低层实体 + 高层主题) + 增量更新, 移植到 reforge_factory 弹药池.

最小可用面 (读 vendors/lightrag/README.md + docs 实测口径):
  - 存储: 内置 JsonKVStorage + NanoVectorDBStorage + NetworkXStorage
    (零 Neo4j / 零 Postgres / 零 Redis — 落盘 JSON + graphml);
  - LLM: 自带 llm_model_func 接口 → 本件接智谱 GLM-4-flash 免费档
    (data/secrets/zhipu.secret 双钥轮换, 直连, ≤4 并发信号量, 智谱双账号强制令);
  - Embedding: 免费宪法 → 本地确定性 char-bigram 哈希嵌入 (512 维, numpy,
    零 API 零下载); 检索以实体名/关键词命中为主, 语义面弱于付费嵌入,
    如实声明 (数字零造假);
  - 依赖纪律: pip install --no-deps ./vendors/lightrag (1.5.8) + 手动装
    aiohttp/nano-vectordb/networkx/json_repair/python-dotenv 五件必需
    (pydantic/PyYAML/tenacity/numpy/pandas 池内已有), 不装 19 项全量。

用法:
  py reforge_factory/graph_rag.py build --campaign EPC-TOP50 [--per-file-cap 6000]
  py reforge_factory/graph_rag.py query --campaign EPC-TOP50 \
      --question "央企设计院转型的共同路径" --mode local|global
  py reforge_factory/graph_rag.py stats --campaign EPC-TOP50
  py reforge_factory/graph_rag.py annotate --campaign EPC-TOP50 [--dates 日期map.json]
      (P2-4 双时间轴: graphiti bi-temporal 思想蒸馏 — 给每实体/关系补
       source_date=文档日期 + ingest_date=入图日期, graphml 原位加注先备份)
  py reforge_factory/graph_rag.py timeslice --campaign EPC-TOP50 \
      --from 2024-01-01 --to 2025-12-31 [--json]
      (按 source_date 时间范围过滤子图, 实测落账 completeness/)

产物: reforge_factory/graph_rag_store/<战役>/ (LightRAG 工作目录, 只增不删)
      reforge_factory/completeness/graph_rag_<战役>.json (建图/查询实测账)
铁律: 免费宪法 / 数字零造假 / 只增不删 / 密钥不进仓不进日志 / ≤4 并发。
"""
from __future__ import annotations

import argparse
import asyncio
import hashlib
import json
import re
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, str(Path(__file__).resolve().parent))

REPO = Path(__file__).resolve().parents[1]                # E:\AI-Station
STORE_ROOT = Path(__file__).resolve().parent / "graph_rag_store"
COMPLETENESS = Path(__file__).resolve().parent / "completeness"
SECRET = REPO / "data" / "secrets" / "zhipu.secret"       # gitignored
ZHIPU_ENDPOINT = "https://open.bigmodel.cn/api/paas/v4/chat/completions"
DEFAULT_MODEL = "glm-4-flash"          # 免费档 (双钥轮换, 智谱双账号强制令)
MAX_CONCURRENCY = 4                    # 铁律: ≤4 并发
EMBED_DIM = 512                        # 本地哈希嵌入维度 (免费, 确定性)


def load_keys() -> list[str]:
    out: list[str] = []
    for line in SECRET.read_text(encoding="utf-8", errors="replace").splitlines():
        line = line.strip()
        for k in ("api_key_2=", "api_key=", "key="):
            if line.startswith(k) and len(line) > len(k) + 8:
                out.append(line[len(k):])
    return list(dict.fromkeys(out))


# ---------------- GLM 免费档 LLM (httpx 直连, 双钥轮换, 信号量4) ----------------
#: 模块级态 (LightRAG 会 deepcopy llm_model_func — 纯函数是原子安全, 带锁对象会炸)
_GLM: dict = {"client": None, "sem": None, "keys": [], "calls": 0, "fails": 0}


def _glm_state() -> dict:
    if _GLM["client"] is None:
        import httpx
        _GLM["keys"] = load_keys()
        if not _GLM["keys"]:
            raise RuntimeError("无可用智谱密钥 (data/secrets/zhipu.secret)")
        # 420s: LightRAG 实体抽取 prompt 重 (4-6K in + 1-2K out), 180s 实测会撞超时重试
        _GLM["client"] = httpx.AsyncClient(timeout=420.0, trust_env=False)
        _GLM["sem"] = asyncio.Semaphore(MAX_CONCURRENCY)
    return _GLM


async def glm_llm_func(prompt: str, system_prompt: str | None = None,
                       **kwargs) -> str:
    """llm_model_func 体例: GLM-4-flash 免费档, 双钥轮换×3, 信号量≤4。"""
    st = _glm_state()
    messages = ([{"role": "system", "content": system_prompt}]
                if system_prompt else []) \
        + [{"role": "user", "content": prompt}]
    last_err: Exception | None = None
    for attempt in range(3):                        # 双钥×3 轮换重试
        key = st["keys"][(attempt + st["calls"]) % len(st["keys"])]
        async with st["sem"]:                       # ≤4 并发铁律
            try:
                r = await st["client"].post(
                    ZHIPU_ENDPOINT,
                    headers={"Authorization": f"Bearer {key}",
                             "Content-Type": "application/json"},
                    json={"model": DEFAULT_MODEL, "temperature": 0.1,
                          "messages": messages})
                r.raise_for_status()
                txt = r.json()["choices"][0]["message"]["content"]
                st["calls"] += 1
                return txt
            except Exception as e:                  # 如实计败, 不伪造
                last_err = e
                st["fails"] += 1
                await asyncio.sleep(2 + attempt * 3)
    raise RuntimeError("GLM 调用失败 3 轮: %s" % (last_err,))


async def _glm_aclose() -> None:
    if _GLM["client"] is not None:
        await _GLM["client"].aclose()
        _GLM["client"] = None


# ---------------- 本地确定性嵌入 (免费宪法: 零API零下载) ----------------
async def local_hash_embed(texts: list[str], **kwargs) -> "list":
    """char-bigram 哈希 → 512 维 L2 归一化向量 (numpy)。

    确定性 (同文本同向量, 可增量重建); 中文实体名/关键词检索可用,
    深层语义弱于付费嵌入 — 如实声明, 检索主路走 LightRAG 实体图。
    """
    import numpy as np
    out = np.zeros((len(texts), EMBED_DIM), dtype=np.float32)
    for i, t in enumerate(texts):
        s = re.sub(r"\s+", "", str(t))
        grams = [s[j:j + 2] for j in range(max(0, len(s) - 1))] or [s]
        for g in grams:
            h = int(hashlib.md5(g.encode("utf-8")).hexdigest()[:8], 16)
            out[i, h % EMBED_DIM] += 1.0
        n = float(np.linalg.norm(out[i]))
        if n > 0:
            out[i] /= n
    return out


class _CharTokenCore:
    """字符级 TokenizerInterface 核 (线程安全纯函数): 1 token = 1 字。"""

    def encode(self, content: str) -> list[int]:
        return [ord(c) for c in str(content)]

    def decode(self, tokens: list[int]) -> str:
        return "".join(chr(t) for t in tokens)


def make_tokenizer():
    """LightRAG 自带 Tokenizer 包装 (自带 truncate/split_by_token_limit 泛型实现)。"""
    from lightrag.utils import Tokenizer
    return Tokenizer("char-level", _CharTokenCore())


def ensure_rag(working_dir: Path, chunk_chars: int = 2400):
    from lightrag import LightRAG
    from lightrag.utils import EmbeddingFunc
    working_dir.mkdir(parents=True, exist_ok=True)
    return LightRAG(
        working_dir=str(working_dir),
        llm_model_func=glm_llm_func,
        embedding_func=EmbeddingFunc(
            embedding_dim=EMBED_DIM, max_token_size=100_000,
            func=local_hash_embed),
        tokenizer=make_tokenizer(),
        chunk_token_size=chunk_chars,   # 字符级 tokenizer 下 = 字/块 (2400≈LightRAG默认1200token中文面)
        entity_extract_max_gleaning=0,   # 冒烟提速: 关 gleaning 补抽轮 (1块1调用)
    )


# ---------------- 输入面: 弹药池 top valid 件 ----------------
def collect_campaign_texts(cid: str, per_file_cap: int,
                           engine_hint: str = "ent") -> list[dict]:
    """manifest.jsonl 里 judge=valid 且 engine 命中 hint 的件 → 文本清单。

    数字零造假: chars/条目数全取 manifest 实测值; cap 截断如实标注。
    """
    mdir = REPO / "ammo_pool" / cid
    manifest = mdir / "manifest.jsonl"
    if not manifest.is_file():
        raise FileNotFoundError("manifest 不存在: %s" % manifest)
    picked: list[dict] = []
    for line in manifest.read_text(encoding="utf-8", errors="replace").splitlines():
        try:
            m = json.loads(line)
        except json.JSONDecodeError:
            continue
        if m.get("judge") != "valid":
            continue
        if engine_hint and engine_hint not in str(m.get("engine", "")):
            continue
        fp = Path(str(m.get("source_path", "")))
        if not fp.is_file():
            continue
        picked.append({"file": str(fp), "chars": int(m.get("chars", 0)),
                       "engine": m.get("engine", ""),
                       "text_head": str(m.get("text_head", ""))[:80]})
    picked.sort(key=lambda x: -x["chars"])
    return picked


async def cmd_build(ns) -> int:
    cid = ns.campaign
    work = STORE_ROOT / cid
    rag = ensure_rag(work)
    await rag.initialize_storages()      # 1.5.8 需显式初始化 (pipeline namespace)
    _glm_state()
    files = collect_campaign_texts(cid, ns.per_file_cap)
    if ns.limit:
        files = files[:ns.limit]
    print("[graph_rag] 战役=%s | valid 件 %d | cap=%d字/件 | 工作目录=%s"
          % (cid, len(files), ns.per_file_cap, work))
    t0 = time.time()
    used = 0
    texts, names = [], []
    for f in files:
        text = Path(f["file"]).read_text(encoding="utf-8", errors="replace")
        capped = text[:ns.per_file_cap] if ns.per_file_cap else text
        texts.append(capped)
        names.append(Path(f["file"]).name)
        used += len(capped)
    # 批量管线: 多文档并发块抽取 (单文档内块串行, 批模式跨文档并行 — 实测串行 ainsert
    # 单文件 1.8min/块, 28件全量要5h+; 批管线+关gleaning 为冒烟可行速率)
    track = await rag.apipeline_enqueue_documents(texts, file_paths=names)
    print("[graph_rag] 批量入队 %d 件 (track=%s, %.1f万字符) → 处理…"
          % (len(texts), str(track or "")[:16], used / 10000))
    await rag.apipeline_process_enqueue_documents()
    for i, n in enumerate(names, 1):
        print("  [%02d/%d] %s" % (i, len(names), n))
    stats = graph_stats(work)
    report = {
        "campaign": cid, "ts": time.strftime("%Y-%m-%d %H:%M"),
        "files": len(files), "per_file_cap": ns.per_file_cap,
        "chars_indexed": used, "elapsed_sec": round(time.time() - t0, 1),
        "llm_calls": _GLM["calls"], "llm_fails": _GLM["fails"],
        "embedding": "local char-bigram hash 512d (免费, 确定性; 语义面弱于付费嵌入, 如实)",
        "storage": "JsonKVStorage+NanoVectorDBStorage+NetworkXStorage (零Neo4j)",
        "graph": stats,
    }
    (COMPLETENESS / ("graph_rag_%s.json" % cid)).write_text(
        json.dumps(report, ensure_ascii=False, indent=1), encoding="utf-8")
    await _glm_aclose()
    print("[graph_rag] 建图完成: %s (LLM调用%d/败%d, %.0fs) → %s"
          % (stats, _GLM["calls"], _GLM["fails"], time.time() - t0,
             COMPLETENESS / ("graph_rag_%s.json" % cid)))
    return 0


def graph_stats(work: Path) -> dict:
    import networkx as nx
    from collections import Counter
    gml = work / "graph_chunk_entity_relation.graphml"
    if not gml.is_file():
        return {"entities": 0, "relations": 0, "note": "graphml 未生成"}
    g = nx.read_graphml(gml)
    types = Counter((d.get("entity_type") or "?") for _, d in g.nodes(data=True))
    out = {"entities": g.number_of_nodes(), "relations": g.number_of_edges(),
           "entity_types": dict(types.most_common(8))}
    if any("source_date" in d for _, d in g.nodes(data=True)):   # P2-4
        sd = [d["source_date"] for _, d in g.nodes(data=True)
              if d.get("source_date") not in (None, "unknown")]
        out["temporal"] = {
            "annotated": True,
            "source_date_min": min(sd) if sd else None,
            "source_date_max": max(sd) if sd else None,
            "dated_entities": len(sd)}
    return out


async def cmd_query(ns) -> int:
    cid = ns.campaign
    work = STORE_ROOT / cid
    if not work.is_dir():
        print("[graph_rag] 无图谱工作目录: %s (先 build)" % work)
        return 2
    from lightrag import QueryParam
    rag = ensure_rag(work)
    await rag.initialize_storages()
    t0 = time.time()
    answer = await rag.aquery(
        ns.question, param=QueryParam(mode=ns.mode, top_k=ns.top_k))
    rec = {"campaign": cid, "ts": time.strftime("%Y-%m-%d %H:%M"),
           "question": ns.question, "mode": ns.mode,
           "answer": str(answer), "elapsed_sec": round(time.time() - t0, 1),
           "llm_calls": _GLM["calls"]}
    hist = COMPLETENESS / ("graph_rag_%s_queries.jsonl" % cid)
    with hist.open("a", encoding="utf-8") as fh:
        fh.write(json.dumps(rec, ensure_ascii=False) + "\n")
    await _glm_aclose()
    print("[graph_rag] 查询(%s, %.0fs): %s" % (ns.mode, time.time() - t0, ns.question))
    print(answer)
    return 0


def cmd_stats(ns) -> int:
    stats = graph_stats(STORE_ROOT / ns.campaign)
    print(json.dumps(stats, ensure_ascii=False, indent=1))
    return 0


# ---------------- P2-4 graphiti 式双时间轴 (bi-temporal) ----------------
#: 思想来源: getzep/graphiti (32,283★) — 事件时间轴(文档日期)与摄取时间轴
#: (入图日期)分离, 支持时点查询。不装全量依赖, 蒸馏其时间维度到 LightRAG
#: graphml: 每实体/关系补 source_date (文档最早日期) + ingest_date (入图日)。
import datetime as _dt                                   # noqa: E402

_DATE_PATTERNS = (
    re.compile(r"date:\s*(\d{4})[-/.](\d{1,2})[-/.](\d{1,2})"),    # front-matter
    re.compile(r"发布日期[:：]\s*(\d{4})[-/.年](\d{1,2})[-/.月](\d{1,2})"),
    re.compile(r"(\d{4})年(\d{1,2})月(\d{1,2})日"),
    re.compile(r"(\d{4})-(\d{2})-(\d{2})"),
)
_PATH_DATE = re.compile(r"(\d{4})(\d{2})(\d{2})")                 # 路径 20261028


def _find_source_file(camp_dir: Path, fname: str) -> Path | None:
    """按名找源文件: 战役 staging 递归 → m2 产线根 (缓存)。"""
    key = ("_ff", str(camp_dir))
    cache = _find_source_file.__dict__.setdefault(key, {})
    if fname in cache:
        return cache[fname]
    hits: list[Path] = []
    for root in (camp_dir, REPO / "_proposals" / "flagship-paid-report-1007"
                 / "work" / "m2"):
        if not root.is_dir():
            continue
        hits += [p for p in root.rglob(fname) if p.is_file()]
    found = hits[0] if hits else None
    cache[fname] = found
    return found


def resolve_source_date(camp_dir: Path, fname: str, dates_map: dict,
                        manifest_ts: dict) -> tuple[str, str]:
    """文件 → (source_date, 判定链)。链: 显式map → 文内日期 → 路径日期 →
    manifest 入池日 (兜底, 如实标 basis) → unknown。"""
    if fname in dates_map:
        return str(dates_map[fname]), "explicit_map"
    p = _find_source_file(camp_dir, fname)
    if p is not None:
        try:
            head = p.read_text(encoding="utf-8", errors="replace")[:4000]
        except OSError:
            head = ""
        for rx in _DATE_PATTERNS:
            m = rx.search(head)
            if m:
                y, mo, d = (int(x) for x in m.groups())
                if 1990 <= y <= 2100 and 1 <= mo <= 12 and 1 <= d <= 31:
                    return "%04d-%02d-%02d" % (y, mo, d), "content_date"
        m = _PATH_DATE.search(str(p))
        if m:
            y, mo, d = int(m.group(1)), int(m.group(2)), int(m.group(3))
            if 1990 <= y <= 2100 and 1 <= mo <= 12 and 1 <= d <= 31:
                return "%04d-%02d-%02d" % (y, mo, d), "path_date"
    ts = manifest_ts.get(fname)
    if ts:
        return str(ts)[:10], "manifest_ingest_ts(fallback)"
    return "unknown", "unresolved"


def _iso_from_unix(ts: str) -> str:
    try:
        return _dt.datetime.fromtimestamp(int(float(ts)), _dt.timezone.utc
                                          ).strftime("%Y-%m-%d")
    except (ValueError, OSError):
        return "unknown"


def cmd_annotate(ns) -> int:
    """graphml 双时间轴加注 (graphml 先备份 .bak-pre-temporal, 只增不改语义)。"""
    import networkx as nx
    work = STORE_ROOT / ns.campaign
    gml = work / "graph_chunk_entity_relation.graphml"
    if not gml.is_file():
        print("[graph_rag] 无 graphml: %s (先 build)" % gml)
        return 2
    camp_dir = REPO / "ammo_pool" / ns.campaign
    dates_map: dict = {}
    if ns.dates:
        dates_map = json.loads(Path(ns.dates).read_text(encoding="utf-8"))
    manifest_ts: dict = {}
    mf = camp_dir / "manifest.jsonl"
    if mf.is_file():
        for line in mf.read_text(encoding="utf-8", errors="replace").splitlines():
            try:
                m = json.loads(line)
            except json.JSONDecodeError:
                continue
            manifest_ts[Path(str(m.get("source_path", ""))).name] = \
                str(m.get("ts", ""))
    g = nx.read_graphml(gml)
    basis_tally: dict = {}
    file_dates: dict = {}

    def date_of_files(raw: str) -> str:
        names = [x for x in str(raw or "").split("<SEP>") if x
                 and x != "unknown_source"]
        known = []
        for n in names:
            if n not in file_dates:
                file_dates[n] = resolve_source_date(
                    camp_dir, n, dates_map, manifest_ts)
            d, basis = file_dates[n]
            basis_tally[basis] = basis_tally.get(basis, 0) + 1
            if d != "unknown":
                known.append(d)
        return min(known) if known else "unknown"

    for _, d in g.nodes(data=True):
        d["source_date"] = date_of_files(d.get("file_path", ""))
        d["ingest_date"] = _iso_from_unix(str(d.get("created_at", "")))
    for _, _, d in g.edges(data=True):
        d["source_date"] = date_of_files(d.get("file_path", ""))
        d["ingest_date"] = _iso_from_unix(str(d.get("created_at", "")))
    bak = gml.with_suffix(".graphml.bak-pre-temporal")
    if not bak.exists():
        bak.write_bytes(gml.read_bytes())          # 只增: 一次备份
    nx.write_graphml(g, gml)
    n_dated = sum(1 for _, d in g.nodes(data=True)
                  if d.get("source_date") != "unknown")
    report = {"campaign": ns.campaign,
              "ts": time.strftime("%Y-%m-%d %H:%M"),
              "nodes": g.number_of_nodes(), "edges": g.number_of_edges(),
              "nodes_with_source_date": n_dated,
              "edges_with_source_date": sum(
                  1 for _, _, d in g.edges(data=True)
                  if d.get("source_date") != "unknown"),
              "date_basis_tally": basis_tally,
              "file_dates": {k: v[0] for k, v in sorted(
                  file_dates.items())},
              "file_date_basis": {k: v[1] for k, v in file_dates.items()},
              "backup": str(bak),
              "note": "graphiti bi-temporal 思想蒸馏 (P2-4): source_date="
                      "文档日期(事件轴), ingest_date=入图日期(摄取轴), "
                      "dates 来源链见 date_basis_tally"}
    out = COMPLETENESS / ("graph_rag_%s_temporal.json" % ns.campaign)
    out.write_text(json.dumps(report, ensure_ascii=False, indent=1),
                   encoding="utf-8")
    print("[graph_rag] 双时间轴加注: 节点%d (带源日期%d) 边%d | 判定链 %s → %s"
          % (g.number_of_nodes(), n_dated, g.number_of_edges(),
             json.dumps(basis_tally, ensure_ascii=False), out))
    return 0


def cmd_timeslice(ns) -> int:
    """按 source_date 范围过滤子图 (graphiti 式时点查询, 实测落账)。"""
    import networkx as nx
    work = STORE_ROOT / ns.campaign
    gml = work / "graph_chunk_entity_relation.graphml"
    if not gml.is_file():
        print("[graph_rag] 无 graphml: %s (先 build+annotate)" % gml)
        return 2
    g = nx.read_graphml(gml)
    if not any("source_date" in d for _, d in g.nodes(data=True)):
        print("[graph_rag] 图未加注时间轴 (先 annotate)")
        return 2
    lo, hi = ns.date_from, ns.date_to
    nodes = [n for n, d in g.nodes(data=True)
             if d.get("source_date", "unknown") != "unknown"
             and lo <= d["source_date"] <= hi]
    sub = g.subgraph(nodes)
    edges = [e for e in sub.edges(data=True)
             if e[2].get("source_date", "unknown") != "unknown"
             and lo <= e[2]["source_date"] <= hi]
    top = sorted(nodes, key=lambda n: -sub.degree(n))[:20]
    rec = {"campaign": ns.campaign,
           "ts": time.strftime("%Y-%m-%d %H:%M"),
           "range": [lo, hi], "entities": len(nodes), "edges": len(edges),
           "total_entities": g.number_of_nodes(),
           "top_entities": [{"name": n,
                             "degree": sub.degree(n),
                             "source_date": g.nodes[n].get("source_date"),
                             "type": g.nodes[n].get("entity_type")}
                            for n in top]}
    hist = COMPLETENESS / ("graph_rag_%s_timeslices.jsonl" % ns.campaign)
    with hist.open("a", encoding="utf-8") as fh:   # 只增
        fh.write(json.dumps(rec, ensure_ascii=False) + "\n")
    print("[graph_rag] 时点切片 %s~%s: 实体 %d/%d, 关系 %d"
          % (lo, hi, len(nodes), g.number_of_nodes(), len(edges)))
    for t in rec["top_entities"][:10]:
        print("  - %s (度%d, %s, 源日期%s)"
              % (t["name"], t["degree"], t["type"], t["source_date"]))
    if ns.json_out:
        print(json.dumps(rec, ensure_ascii=False, indent=1))
    return 0


def main() -> int:
    ap = argparse.ArgumentParser(description="LightRAG 图谱层 (P1-1)")
    sub = ap.add_subparsers(dest="cmd", required=True)
    b = sub.add_parser("build")
    b.add_argument("--campaign", required=True)
    b.add_argument("--per-file-cap", type=int, default=6000,
                   help="每件入图字符上限 (冒烟预算; 0=全文)")
    b.add_argument("--limit", type=int, default=0)
    q = sub.add_parser("query")
    q.add_argument("--campaign", required=True)
    q.add_argument("--question", required=True)
    q.add_argument("--mode", default="local",
                   choices=["local", "global", "hybrid", "mix", "naive"])
    q.add_argument("--top-k", type=int, default=30)
    s = sub.add_parser("stats")
    s.add_argument("--campaign", required=True)
    a = sub.add_parser("annotate", help="P2-4 双时间轴加注")
    a.add_argument("--campaign", required=True)
    a.add_argument("--dates", default="", help="文件名→YYYY-MM-DD map json")
    t = sub.add_parser("timeslice", help="P2-4 时点切片查询")
    t.add_argument("--campaign", required=True)
    t.add_argument("--from", dest="date_from", required=True,
                   help="起始日 YYYY-MM-DD (含)")
    t.add_argument("--to", dest="date_to", required=True,
                   help="截止日 YYYY-MM-DD (含)")
    t.add_argument("--json", dest="json_out", action="store_true")
    ns = ap.parse_args()
    if ns.cmd == "build":
        return asyncio.run(cmd_build(ns))
    if ns.cmd == "query":
        return asyncio.run(cmd_query(ns))
    if ns.cmd == "annotate":
        return cmd_annotate(ns)
    if ns.cmd == "timeslice":
        return cmd_timeslice(ns)
    return cmd_stats(ns)


if __name__ == "__main__":
    raise SystemExit(main())
