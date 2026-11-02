# -*- coding: utf-8 -*-
"""把 bdn_staging 子目录入池 — 用法: py -X utf8 ingest_staging.py <staging子目录名> <engine标签>"""
import sys
from pathlib import Path

sys.path.insert(0, r"E:\AI-Station\reforge_factory")
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.stderr.reconfigure(encoding="utf-8", errors="replace")
import ammo_pool                                      # noqa: E402

WS = Path(r"E:\AI-Station\07 任务\福米电站EPC管理策划\05 Super-Skill工作区")
EXTS = {".md", ".txt", ".markdown", ".docx", ".pdf", ".pptx", ".xlsx",
        ".html", ".htm", ".epub", ".mobi", ".chm"}

sub = sys.argv[1]
engine = sys.argv[2] if len(sys.argv) > 2 else ("bdn:" + sub)
root = WS / "bdn_staging" / sub
items = [{"file": str(p), "engine": engine, "cred": "research"}
         for p in root.rglob("*")
         if p.is_file() and p.suffix.lower() in EXTS]
print("[ingest-staging] %s 候选 %d 件" % (sub, len(items)))
added, skipped = ammo_pool.ingest_files("FOMI-EPC", items)
print("[ingest-staging] %s 入池 +%d 跳过 %d" % (sub, added, skipped))
