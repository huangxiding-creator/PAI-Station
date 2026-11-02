# -*- coding: utf-8 -*-
"""FOMI-EPC 本地档案收割编排件 (1102 用户令: 兰州专著/创新院/福米原件入库).
只建新件不改产线件; 增量幂等 (source_path+dedup_key 双查重内建).
用法:
  py -X utf8 harvest_fomi_local.py fast          # md/txt/docx 快道
  py -X utf8 harvest_fomi_local.py slow          # pdf/pptx/xlsx/html 慢道
  py -X utf8 harvest_fomi_local.py all --dry     # 干跑看清单
"""
import argparse
import sys
from pathlib import Path

sys.path.insert(0, r"E:\AI-Station\reforge_factory")
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.stderr.reconfigure(encoding="utf-8", errors="replace")
import ammo_pool                                      # noqa: E402

CAMPAIGN = "FOMI-EPC"
FOMI = Path(r"E:\AI-Station\07 任务\福米电站EPC管理策划")

#: (族, 根, 可信级) — 05 工作区(我的抽取件)不入池防重复计账
ROOTS = [
    ("lanzhou_monograph", Path(r"D:\兰州水源地专著"), "official"),
    ("zbcx_institute", Path(r"F:\新建文件夹\AI总包创新院"), "research"),
    ("fomi_project_0104", FOMI / "01 编写管理策划的沟通", "official"),
    ("fomi_project_0104", FOMI / "02 管理策划编写需求", "official"),
    ("fomi_project_0104", FOMI / "03 福米电站项目资料", "official"),
    ("fomi_project_0104", FOMI / "04 管理策划参考资料", "official"),
]
FAST = {".md", ".txt", ".markdown", ".docx"}
SLOW = {".pdf", ".pptx", ".xlsx", ".html", ".htm"}


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("pass_", nargs="?", default="fast")
    ap.add_argument("--dry", action="store_true")
    ns = ap.parse_args()
    exts = {"fast": FAST, "slow": SLOW}.get(ns.pass_, FAST | SLOW)

    items, per_root = [], {}
    for fam, root, cred in ROOTS:
        if not root.is_dir():
            print("[root missing]", root)
            continue
        n = 0
        for fp in root.rglob("*"):
            if fp.is_file() and fp.suffix.lower() in exts:
                items.append({"file": str(fp),
                              "engine": "localfiles:%s" % fam, "cred": cred})
                n += 1
        per_root[fam] = per_root.get(fam, 0) + n
    print("[fomi-local] pass=%s 候选 %d 件 | 分根 %s"
          % (ns.pass_, len(items), per_root))
    if ns.dry:
        for it in items[:30]:
            print("   ", it["file"][-90:])
        return 0
    added, skipped = ammo_pool.ingest_files(CAMPAIGN, items)
    print("[fomi-local] 入池 +%d | 跳过 %d (短件/snippet/重复/缺文件)"
          % (added, skipped))
    return 0


if __name__ == "__main__":
    sys.exit(main())
