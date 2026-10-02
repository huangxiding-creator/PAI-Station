# -*- coding: utf-8 -*-
"""#49 RSS 本地库定向检索 — 零成本通道 (0930).

源: data/rss_harvest/articles/YYYY-MM-DD/*.md (905源OPML同步, 只读)
     ResearchFactory-Eng/公众号RSS/ (第二库)
作: 关键词命中件 → 复制到 #49 战场 02/75_RSS本地库/ + 三行元数据头保持;
    输出命中清单 JSON 供 ingest+judge 回灌.
只读源库, 命中件复制不剪切 (harvest 只增不删纪律).
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

SOURCES = [
    Path(r"E:\AI-Station\data\rss_harvest\articles"),
    Path(r"E:\AI-Station\ResearchFactory-Eng\公众号RSS"),
]
OUT = Path(r"E:\AI-Station\ResearchFactory-Eng\ResearchTopics"
           r"\《四川电力设计咨询有限责任公司怎么干EPC总承包？》"
           r"\02 初次网络调研\75_RSS本地库")

# 命中词分两档: 强命中=公司本体; 弱命中=需组合电建语境再细筛
STRONG = ["四川电力设计咨询", "中电建四川院", "四川电力设计院", "SEDC"]
WEAK = ["四川院", "电建", "电力设计"]

CLIP = 220


def main() -> int:
    OUT.mkdir(parents=True, exist_ok=True)
    hits = []
    scanned = 0
    for src in SOURCES:
        if not src.is_dir():
            print(f"[skip] 源不存在: {src}")
            continue
        files = [f for f in src.rglob("*") if f.is_file()
                 and f.suffix.lower() in (".md", ".txt", ".html")]
        print(f"[scan] {src} → {len(files)} 件")
        for f in files:
            scanned += 1
            try:
                head = f.read_text(encoding="utf-8",
                                   errors="replace")[:4000]
            except Exception:
                continue
            strong = next((k for k in STRONG if k in head), None)
            if not strong:
                if "四川院" in head and any(
                        k in head for k in ("电力", "电建", "设计院")):
                    strong = "四川院+语境"
                else:
                    continue
            weak_ctx = [k for k in WEAK if k in head]
            # 标题行优先 (RSS md 首行常为标题)
            first = head.splitlines()[0][:CLIP] if head else ""
            hits.append({
                "kw": strong,
                "ctx": weak_ctx,
                "title": first,
                "src": str(f),
                "rel": str(f.relative_to(f.parents[2])) if len(
                    f.parents) >= 3 else f.name,
            })
    print(f"\n[命中] {len(hits)} / 扫描 {scanned} 件")
    for h in hits[:40]:
        print(f"  [{h['kw']}] {h['title'][:80]}")
        print(f"        {h['src']}")
    manifest = OUT / "rss_hits_manifest.json"
    manifest.write_text(json.dumps(
        {"ts": time.strftime("%Y-%m-%dT%H:%M:%S"), "scanned": scanned,
         "hits": hits}, ensure_ascii=False, indent=1), encoding="utf-8")
    print(f"[落盘] {manifest}")
    # 命中件复制 (强命中才复制; 四川院+语境也复制)
    n_copy = 0
    for h in hits:
        sp = Path(h["src"])
        try:
            if sp.suffix.lower() == ".html":
                text = sp.read_text(encoding="utf-8", errors="replace")
                # 粗转文本: 去标签
                text = re.sub(r"<[^>]+>", " ", text)
                dest = OUT / (sp.stem + ".md")
                dest.write_text(
                    f"来源URL: RSS本地库/{h['rel']}\n抓取日期: "
                    f"{time.strftime('%Y-%m-%d')}(RSS同步)\n标题: "
                    f"{h['title']}\n\n(由RSS HTML粗转文本)\n\n{text}",
                    encoding="utf-8")
            else:
                dest = OUT / sp.name
                if not dest.exists():
                    shutil.copy2(sp, dest)
            n_copy += 1
        except Exception as e:  # noqa: BLE001
            print(f"  [copy✗] {sp.name}: {type(e).__name__}")
    print(f"[复制] {n_copy} 件 → {OUT}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
