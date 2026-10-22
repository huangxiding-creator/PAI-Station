# -*- coding: utf-8 -*-
"""resource_sweep — 全资源扫掠腿 (1022 用户令: 调研搜集时所有渠道所有资源都动用).

资源根清单 (站内全部大语料库, 逐根关键词滤采 → EPC-OVERSEAS 池):
  04 智库 (1.2万件) · research (2万+件) · 逆向工程 (1.5万件) · corpus ·
  data/weread · F:/AI总包创新院 · ima 个人库 998+ · 既有九弹药池(已灌)
节流: 文本件(md/txt/html/docx) + 英文词族 + 每根限量; 判账由编排方续跑。
用法: py -X utf8 resource_sweep.py EPC-OVERSEAS [--per-root 400]
"""
from __future__ import annotations

import json
import sys
import warnings
from pathlib import Path

warnings.filterwarnings("ignore")
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
REPO = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(REPO / "reforge_factory"))
from ammo_pool import ingest_files  # noqa: E402

KW = re.compile(r"海外|出海|国际工程|一带一路|FIDIC|对外承包|国际电力|"
                r"[Ii]nternational|overseas|FIDIC|[Tt]urnkey|国别|境外",
                )
import re  # noqa: E402

ROOTS = [
    ("04智库", REPO / "04 智库"),
    ("research", REPO / "research"),
    ("逆向工程", REPO / "逆向工程"),
    ("corpus", REPO / "corpus"),
    ("weread", REPO / "data" / "weread"),
    ("创新院", Path(r"F:/新建文件夹/AI总包创新院")),
]
TEXT_EXT = {".md", ".txt", ".html", ".docx"}


def sweep_root(name: str, root: Path, per_root: int) -> list[dict]:
    items = []
    try:
        for p in root.rglob("*"):
            if len(items) >= per_root:
                break
            if (not p.is_file()) or p.suffix.lower() not in TEXT_EXT:
                continue
            if p.stat().st_size < 3000 or p.stat().st_size > 8_000_000:
                continue
            try:
                head = p.read_text(encoding="utf-8", errors="replace")[:4000]
            except Exception:
                continue
            if KW.search(head) or KW.search(p.name):
                items.append({"file": str(p), "engine": "corpus_stores",
                              "cred": "research",
                              "_src": f"resourcesweep:{name}"})
    except Exception as e:
        print(f"[{name}] 根异常: {type(e).__name__}", flush=True)
    return items


def main() -> int:
    campaign = sys.argv[1] if len(sys.argv) > 1 else "EPC-OVERSEAS"
    per_root = 400
    if "--per-root" in sys.argv:
        per_root = int(sys.argv[sys.argv.index("--per-root") + 1])
    total_a = 0
    for name, root in ROOTS:
        if not root.is_dir():
            print(f"[{name}] 根不存在, 跳过", flush=True)
            continue
        items = sweep_root(name, root, per_root)
        print(f"[{name}] 命中 {len(items)}", flush=True)
        for i in range(0, len(items), 200):
            try:
                a, s = ingest_files(campaign, items[i:i + 200])
            except Exception as e:
                print(f"  [块] {type(e).__name__}", flush=True)
                continue
            total_a += a
            print(f"  +{a} (战役累计+{a})", flush=True)
    print(f"== 全资源扫掠完成: 入池 {total_a}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
