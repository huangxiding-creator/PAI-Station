# -*- coding: utf-8 -*-
"""harvest_localfiles — 本地文件库收割腿 (1015 用户批 B/C 补采 · B 轴
技术方案/组织人事/国际对标/渠道生态四面 + C 轴 localfiles 渠道).

纪律 (数字零造假):
  1. 双重相关门: 文件名命中面关键词 ∧ 正文头 2000 字命中面关键词 ∧
     命中 BID26 域词 (工程总承包/招投标/EPC/评标/采购…) — 缺一不入;
  2. 只收未入池件: source_path 已在 manifest 的跳过 (增量语义);
  3. engine=localfiles:<族> (C 轴 resolve_engine 子串命中 localfiles 渠道);
  4. --tree 按 face→EEI 映射挂正面槽, stance=support;
  5. snippet 门/查重由 ammo_pool.ingest 内建 (硬拒如实计数)。

用法: py reforge_factory/harvest_localfiles.py --campaign EPC-BID26
        [--per-facet 30] [--dry]
"""
from __future__ import annotations

import argparse
import json
import re
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, str(Path(__file__).resolve().parent))
import ammo_pool                                        # noqa: E402

REPO = Path(__file__).resolve().parents[1]

ROOTS: list[tuple[str, Path]] = [          # (族标签, 根)
    ("rss", REPO / "data" / "rss_harvest" / "articles"),
    ("topics", REPO / "ResearchFactory-Eng" / "ResearchTopics"),
    ("stock", Path(r"F:/新建文件夹/AI总包创新院")),
]

# 面 → (文件名/正文头正则, 正面槽 EEI)
FACETS: dict[str, tuple[str, str]] = {
    "国际对标": ("FIDIC|国际工程|海外工程|国际招标|世行|国际承包|对外承包|国际咨购",
              "Q23-E1"),
    "技术方案": ("电子招投标|评标系统|智慧评审|数字化招|智能评标|电子保函|BIM",
              "Q19-E1"),
    "渠道生态": ("招标代理|招标平台|采购平台|公共资源交易|招标采购网|交易平台",
              "Q25-E1"),
    "组织人事": ("评标专家|招标师|造价工程师|从业资格|注册建造师|招标从业人员",
              "Q21-E1"),
}
DOMAIN_RE = re.compile(
    r"工程总承包|招投标|招标|投标|EPC|评标|定标|采购|承包")
FOLLOWUP_EEI = {"国际对标": "Q24-E1",       # 第二槽: 前半批满后同面文件挂此 (海外实践等)
                "技术方案": "Q18-E1", "渠道生态": "Q26-E1", "组织人事": "Q22-E1"}

MAX_HEAD = 2000


def load_pool_paths(cid: str) -> set[str]:
    mp = Path(ammo_pool._camp_dir(cid)) / "manifest.jsonl"
    out: set[str] = set()
    if mp.is_file():
        for ln in mp.read_text(encoding="utf-8").splitlines():
            if ln.strip():
                try:
                    out.add(json.loads(ln).get("source_path", ""))
                except json.JSONDecodeError:
                    pass
    return out


def run(cid: str, per_facet: int = 30, dry: bool = False) -> int:
    in_pool = load_pool_paths(cid)
    facet_n = {f: 0 for f in FACETS}
    stats = {"scanned": 0, "name_hit": 0, "text_pass": 0, "already": 0,
             "ingested": 0, "snippet_refused": 0}
    per_root: dict[str, int] = {}
    batch: list[tuple[Path, str, str, str]] = []   # (fp, family, facet, eei)

    for family, root in ROOTS:
        if not root.is_dir():
            print(f"[lf] 根缺席跳过: {root}")
            continue
        for fp in root.rglob("*"):
            if not fp.is_file() or fp.suffix.lower() not in (".md", ".txt",
                                                             ".docx", ".pdf"):
                continue
            stats["scanned"] += 1
            name = fp.name
            for facet, (pat, eei) in FACETS.items():
                if facet_n[facet] >= per_facet:
                    continue
                if not re.search(pat, name):
                    continue
                stats["name_hit"] += 1
                if str(fp) in in_pool:
                    stats["already"] += 1
                    continue
                try:
                    head = fp.read_text(encoding="utf-8", errors="replace")[:MAX_HEAD]
                except OSError:
                    continue
                if (not re.search(pat, head) or not DOMAIN_RE.search(name + head)):
                    continue                      # 文件名误报 → 正文门挡下
                stats["text_pass"] += 1
                slot = (FOLLOWUP_EEI[facet] if facet_n[facet] >= per_facet // 2
                        else eei)                 # 后半批挂第二槽 (海外实践等)
                batch.append((fp, family, facet, slot))
                facet_n[facet] += 1
                break                             # 一件只归一面 (防跨面重复)

    print(f"[lf] 扫描 {stats['scanned']} | 名中 {stats['name_hit']} | "
          f"正文门过 {stats['text_pass']} | 已在池 {stats['already']} | "
          f"配额 {facet_n}")
    for fp, family, facet, eei in batch:
        if dry:
            print(f"  [dry] {facet}→{eei} {fp.name[:56]}")
            continue
        rc = ammo_pool.ingest(
            cid, str(fp), engine=f"localfiles:{family}", url="",
            cred="media", tree=eei, stance="support")
        if rc == 0:
            stats["ingested"] += 1
            per_root[family] = per_root.get(family, 0) + 1
    if not dry:
        print(f"[lf] 入池 rc0 {stats['ingested']} | 分根 {per_root} "
              f"(snippet 硬拒/查重跳过含于差值, ingest 内建如实计数)")
    return 0


def main() -> int:
    ap = argparse.ArgumentParser(description="本地文件库收割腿 (B 四面+C localfiles)")
    ap.add_argument("--campaign", default="EPC-BID26")
    ap.add_argument("--per-facet", type=int, default=30)
    ap.add_argument("--dry", action="store_true")
    ns = ap.parse_args()
    return run(ns.campaign, ns.per_facet, ns.dry)


if __name__ == "__main__":
    sys.exit(main())
