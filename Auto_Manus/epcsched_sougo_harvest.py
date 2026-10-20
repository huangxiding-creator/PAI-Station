# -*- coding: utf-8 -*-
"""EPC-SCHED 搜狗产物归位器 — SouGouWeDown2/output → SCHED 池 (wechat:sogou).

匹配: 文件名含 SCHED 词表词 (工期/赶工/停工/签证/网络计划/关键线路/进度偏差/
施工组织/索赔 等) 的 md; 归位战场 = ResearchTopics/《工程工期管理与延误索赔
实战指南》/20_微信文章 (按 superline 惯例落 02 初次网络调研).
幂等: 目标已存在同名件则跳过. ingest engine=wechat:sogou → C轴sougo渠道点亮.
"""
import io
import json
import shutil
import sys
import time
from pathlib import Path

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8",
                              errors="replace")
sys.path.insert(0, r"E:\AI-Station\reforge_factory")

SRC = Path(r"E:\AI-Station\ResearchFactory-Eng\SouGouWeDown2\output")
OUT = Path(r"E:\AI-Station\ResearchFactory-Eng\ResearchTopics"
           r"\《工程工期管理与延误索赔实战指南》\02 初次网络调研\20_微信文章")
MATCH = ("工期", "赶工", "停工", "签证", "网络计划", "关键线路",
         "进度", "施工组织", "索赔", "延误")


def main() -> int:
    import ammo_pool as ap
    OUT.mkdir(parents=True, exist_ok=True)
    moved, ingested = [], 0
    for f in sorted(SRC.glob("*.md")):
        if f.name.startswith("合并_"):
            continue
        if not any(k in f.name for k in MATCH):
            continue
        text = f.read_text(encoding="utf-8", errors="replace")
        dest = OUT / f.name
        if not dest.exists():
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
            ap.ingest("EPC-SCHED", str(dest), "wechat:sogou", "",
                      "media", "")
            ingested += 1
        except Exception as e:  # noqa: BLE001
            print(f"[ingest✗] {f.name}: {type(e).__name__}")
    print(f"[归位] {len(moved)} 件 → {OUT.name} | ingest {ingested}")
    if moved:
        print(ap.judge("EPC-SCHED", 100))
    return 0


if __name__ == "__main__":
    sys.exit(main())
