# -*- coding: utf-8 -*-
"""#49 RSS 命中件回灌弹药池 (ingest 逐件 + judge)."""
import io
import sys
from pathlib import Path

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8",
                              errors="replace")
sys.path.insert(0, r"E:\AI-Station\reforge_factory")
import ammo_pool as ap  # noqa: E402

CID = "EPC49-SEPDC"
D = Path(r"E:\AI-Station\ResearchFactory-Eng\ResearchTopics"
         r"\《四川电力设计咨询有限责任公司怎么干EPC总承包？》"
         r"\02 初次网络调研\75_RSS本地库")
for f in sorted(D.glob("*.md")):
    r = ap.ingest(CID, str(f), "rss:local", "",
                  "media", "")
    print(f"[ingest] {f.name[:50]} → {r}")
print(ap.judge(CID, 50))
print(ap.status(CID))
