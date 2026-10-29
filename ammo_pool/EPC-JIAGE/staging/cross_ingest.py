# -*- coding: utf-8 -*-
"""EPC-JIAGE 跨池灌采腿 (S1 基建三件之三) — 1025.

照 EPC-OVERSEAS 在役模式 (resource_sweep.py + ingest_files 批量入池; 其
pool_state by_engine corpus_stores 455M 即此法), 五路切灌:
  ① EPC-BID26 manifest 切片 (计价/定额/评标/清单) → crosspool:EPC-BID26
  ② EPC-CONTRACT manifest 切片 (合同计价/结算) → crosspool:EPC-CONTRACT
  ③ F1-BLUEBOOK standards/policy 切片 → crosspool:F1-BLUEBOOK
  ④ corpus_stores 站内存量扫掠 (定额造价类) → corpus_stores
  ⑤ KB-HARVEST 文库池 (ima 知识库超市 778 件里计价类 + wenku 收割件) → kb_harvest:wenku

判词带扩义词 (老教训: 国别词漏判; 本战役=定额站名/造价词变体/计价规范号):
  CORE 一词即中: 工程造价|造价|计价|定额|信息价|清单计价|概预算|概算|组价|估价
  EXPAND 一词即中(站名/变体/规范号): 标准定额司|造价管理总站|造价管理站|定额站|
    标准定额研究所|造价管理协会|建标|GB.?50500|50500-2013|51262-2017|全统|
    全国统一|基础定额|预算定额|施工定额|企业定额|消耗量定额|概算定额|估算指标|
    造价员|造价师|工程价款|价款结算|定额测定|计价规范
  EXTRA 需≥2个不同词 (防泛词过采): 结算|预算|决算|签证|变更|争议|评标|工程量清单|
    综合单价|招标控制价|投标报价|措施项目|暂列金额|台班|价差|估算|计日工

铁律: 只增不删 (manifest append); 入池=待审不计数, 判有效才计 (judge 续跑);
  幂等 = source_path + dedup_key 双查重 (重跑零重复).
用法: py -X utf8 E:/AI-Station/ammo_pool/EPC-JIAGE/staging/cross_ingest.py [--wenku-only]
"""
from __future__ import annotations

import argparse
import json
import re
import sys
import warnings
from pathlib import Path

warnings.filterwarnings("ignore")
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
REPO = Path(r"E:\AI-Station")
sys.path.insert(0, str(REPO / "reforge_factory"))
from ammo_pool import ingest_files  # noqa: E402

CID = "EPC-JIAGE"

CORE = re.compile(
    r"工程造价|造价|计价|定额|信息价|清单计价|概预算|概算|组价|估价")
EXPAND = re.compile(
    r"标准定额司|造价管理总站|造价管理站|定额站|标准定额研究所|"
    r"造价管理协会|建标|GB[ \-]?50500|50500-2013|GB/T[ \-]?51262|"
    r"51262-2017|全统|全国统一|基础定额|预算定额|施工定额|企业定额|"
    r"消耗量定额|概算定额|估算指标|造价员|造价师|工程价款|价款结算|"
    r"定额测定|计价规范")
EXTRA = re.compile(
    r"竣工结算|结算|预算|决算|签证|变更|争议|评标|工程量清单|综合单价|"
    r"招标控制价|投标报价|措施项目|暂列金额|台班|价差|估算|计日工|"
    r"不平衡报价|量价")


def kw_hit(hay: str) -> bool:
    """启发式判词: CORE/EXPAND 一词即中; EXTRA 需≥2个不同词."""
    if CORE.search(hay) or EXPAND.search(hay):
        return True
    hits = set(EXTRA.findall(hay))
    return len(hits) >= 2


# ---------- ①②③ 既有池 manifest 切片 ----------
def slice_pool(pool: str, engines: set[str] | None, cap: int) -> list[dict]:
    src = REPO / "ammo_pool" / pool / "manifest.jsonl"
    items, seen_path = [], set()
    if not src.is_file():
        print(f"[slice] {pool} 无 manifest, 跳过", flush=True)
        return items
    with src.open(encoding="utf-8") as f:
        for line in f:
            if len(items) >= cap:
                break
            if not line.strip():
                continue
            r = json.loads(line)
            if engines and r.get("engine") not in engines:
                continue
            sp = r.get("source_path", "")
            if not sp or sp in seen_path:
                continue
            hay = sp + " " + (r.get("text_head") or "")[:400]
            if not kw_hit(hay):
                continue
            seen_path.add(sp)
            items.append({"file": sp,
                          "engine": f"crosspool:{pool}",
                          "cred": r.get("credibility", "unknown")})
    print(f"[slice] {pool}: 切中 {len(items)}/{cap}", flush=True)
    return items


# ---------- ④ corpus_stores 存量扫掠 (resource_sweep 同法) ----------
TEXT_EXT = {".md", ".txt", ".html", ".docx"}
ROOTS = [
    ("ima_public", REPO / "data" / "harvest" / "ima_public", 200),
    ("智库", REPO / "04 智库", 800),
    ("research", REPO / "research", 600),
    ("topics", REPO / "ResearchFactory-Eng" / "ResearchTopics", 1200),
    ("rss_articles", REPO / "data" / "rss_harvest" / "articles", 800),
    ("bid26_state", REPO / "data" / "state", 400),
    ("harvest", REPO / "data" / "harvest", 400),
    ("corpus", REPO / "corpus", 150),
    ("weread", REPO / "data" / "weread", 200),
    ("创新院", Path(r"F:/新建文件夹/AI总包创新院"), 200),
]


def sweep_root(name: str, root: Path, cap: int) -> list[dict]:
    items = []
    if not root.is_dir():
        print(f"[sweep:{name}] 根不存在, 跳过", flush=True)
        return items
    try:
        for p in root.rglob("*"):
            if len(items) >= cap:
                break
            if (not p.is_file()) or p.suffix.lower() not in TEXT_EXT:
                continue
            try:
                sz = p.stat().st_size
            except OSError:
                continue
            if sz < 3000 or sz > 8_000_000:
                continue
            if p.name.startswith("manifest"):
                continue
            try:
                head = p.read_text(encoding="utf-8", errors="replace")[:4000]
            except Exception:
                continue
            if kw_hit(head) or kw_hit(p.name) or kw_hit(str(p.parent)):
                items.append({"file": str(p), "engine": "corpus_stores",
                              "cred": "research",
                              "_src": f"crossingest:{name}"})
    except Exception as e:
        print(f"[sweep:{name}] 根异常: {type(e).__name__}", flush=True)
    print(f"[sweep:{name}] 扫中 {len(items)}/{cap}", flush=True)
    return items


# ---------- ⑤ KB-HARVEST 文库池 (计价类) ----------
WENKU_DIRS = [
    REPO / "corpus" / "ima_overseas_1022",          # ima 知识库超市整库 (778件)
    REPO / "corpus" / "wenku_harvest",              # wenku 收割件
    REPO / "kb_factory" / "harvest_engine" / "e2e" / "artifacts" / "wenku_store",
    REPO / "kb_harvest_out" / "wenku",
]
WENKU_EXT = {".pdf", ".docx", ".pptx", ".md", ".txt", ".html"}
WENKU_MAX_BYTES = 120 * 1024 * 1024                 # 超大件不采, 如实留痕


def sweep_wenku() -> list[dict]:
    items, skipped_big = [], []
    for root in WENKU_DIRS:
        if not root.is_dir():
            continue
        for p in root.rglob("*"):
            if (not p.is_file()) or p.suffix.lower() not in WENKU_EXT:
                continue
            if p.name.startswith("manifest"):
                continue
            if not (kw_hit(p.name) or kw_hit(str(p.parent))):
                continue                             # 文库池按名+目录判 (PDF 全读太贵)
            try:
                sz = p.stat().st_size
            except OSError:
                continue
            if sz > WENKU_MAX_BYTES:
                skipped_big.append(f"{p.name}({sz:,}B)")
                continue
            items.append({"file": str(p), "engine": "kb_harvest:wenku",
                          "cred": "research",
                          "_src": f"wenku:{root.name}"})
    if skipped_big:
        print(f"[wenku] 超大件跳过 {len(skipped_big)}: "
              f"{'; '.join(skipped_big[:5])}", flush=True)
    print(f"[wenku] 文库池扫中 {len(items)}", flush=True)
    return items


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--wenku-only", action="store_true")
    args = ap.parse_args()

    groups: list[tuple[str, list[dict]]] = []
    if not args.wenku_only:
        groups.append(("BID26切片",
                       slice_pool("EPC-BID26", None, 2600)))
        groups.append(("CONTRACT切片",
                       slice_pool("EPC-CONTRACT", None, 900)))
        groups.append(("F1蓝皮书standards/policy切片",
                       slice_pool("F1-BLUEBOOK",
                                  {"cross:standards", "cross:policy"}, 120)))
        for name, root, cap in ROOTS:
            groups.append((f"corpus:{name}", sweep_root(name, root, cap)))
    groups.append(("wenku池", sweep_wenku()))

    total_a = total_s = 0
    for gname, items in groups:
        if not items:
            print(f"[ingest:{gname}] 0 件, 跳过", flush=True)
            continue
        print(f"[ingest:{gname}] {len(items)} 件入池 …", flush=True)
        a, s = ingest_files(CID, items)
        total_a += a
        total_s += s
        print(f"[ingest:{gname}] +{a} 跳{s}", flush=True)
    print(f"\n[cross_ingest] 总入池 +{total_a} / 跳过 {total_s} "
          f"(判有效账由 judge 续跑, 如实计数)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
