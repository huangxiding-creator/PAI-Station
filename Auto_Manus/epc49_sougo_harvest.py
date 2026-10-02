# -*- coding: utf-8 -*-
"""EPC49 搜狗产物归位器 — SouGouWeDown2/output → #49 战场 20_微信文章 + 回灌弹药池.

匹配: 文件名或正文含四川院关键词 (四川电力设计咨询/四川院/中电建四川院/SEDC)
的 md; 归位时补三行元数据头 (SouGouWeDown2 产物自带链接信息则保留原文).
幂等: 战场目标已存在同名件则跳过.
"""
import io
import json
import re
import shutil
import sys
import time
from pathlib import Path

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8",
                              errors="replace")
sys.path.insert(0, r"E:\AI-Station\reforge_factory")

SRC = Path(r"E:\AI-Station\ResearchFactory-Eng\SouGouWeDown2\output")
OUT = Path(r"E:\AI-Station\ResearchFactory-Eng\ResearchTopics"
           r"\《四川电力设计咨询有限责任公司怎么干EPC总承包？》"
           r"\02 初次网络调研\20_微信文章")
STRONG = ("四川电力设计咨询", "四川院", "中电建四川院", "SEDC")


def main() -> int:
    import ammo_pool as ap
    OUT.mkdir(parents=True, exist_ok=True)
    moved, ingested = [], 0
    for f in sorted(SRC.glob("*.md")):
        if f.name.startswith("合并_"):
            continue
        text = f.read_text(encoding="utf-8", errors="replace")
        kw = next((k for k in STRONG if k in f.name or k in text[:2000]), None)
        if not kw:
            continue
        dest = OUT / f.name
        if not dest.exists():
            # 补元数据头 (原文可能自带链接行, 追加头部不破坏)
            if not text.startswith("来源URL"):
                src_url = next(
                    (l.strip() for l in text.splitlines()
                     if l.strip().startswith(("http", "链接"))), "搜狗微信搜索")
                text = (f"来源URL: {src_url}\n抓取日期: "
                        f"{time.strftime('%Y-%m-%d')}(搜狗微信)\n"
                        f"标题: {f.stem}\n\n{text}")
                dest.write_text(text, encoding="utf-8")
            else:
                shutil.copy2(f, dest)
        moved.append(f.name)
        try:
            ap.ingest("EPC49-SEPDC", str(dest), "wechat:sogou", "",
                      "media", "")
            ingested += 1
        except Exception as e:  # noqa: BLE001
            print(f"[ingest✗] {f.name}: {type(e).__name__}")
    print(f"[归位] {len(moved)} 件 → {OUT.name} | ingest {ingested}")
    if moved:
        print(ap.judge("EPC49-SEPDC", 100))
    return 0


if __name__ == "__main__":
    sys.exit(main())
