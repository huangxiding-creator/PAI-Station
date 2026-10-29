# -*- coding: utf-8 -*-
"""生成 v2 文件驱动样本蓝图（替换旧 v1 分类法样本）。"""
import sys, json, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
sys.stdout.reconfigure(encoding="utf-8", errors="replace")

from kb_factory.catalog_engine.engine import build_blueprint
from kb_factory.catalog_engine.doc_search import search_all_sources

SAMPLES = [
    {"domain": "水利EPC工程知识库", "keywords": ["EPC", "水利水电", "总承包", "施工"],
     "intent": "项目部技术管理", "size_hint": "small"},
    {"domain": "律师事务所知识库", "keywords": ["诉讼", "合规", "合同审查"],
     "intent": "执业与团队培训", "size_hint": "small"},
]

OUT_DIR = os.path.join(os.path.dirname(os.path.abspath(__file__)),
                       "..", "微信小程序", "zongbao-ai", "pages", "kbfactory", "samples")

for i, need in enumerate(SAMPLES):
    slug = "water" if "水利" in need["domain"] else "law"
    print(f"\n=== {need['domain']} ===")
    bp = build_blueprint(dict(need), mode="document_driven")
    mode = bp["tree"]["mode"]
    print(f"mode: {mode}")
    if mode == "document_driven":
        l1_names = [l["name"] for l in bp["tree"]["l1"]]
        print(f"L1: {l1_names}")
        total = bp["stats"]["files"]
        real = bp["stats"].get("real_docs", 0)
        print(f"files: {total}, real: {real}")
        # 打印每层的文件样例
        for l1 in bp["tree"]["l1"][:4]:
            for l2 in l1["l2"][:2]:
                files = l2.get("files", [])[:3]
                names = [f["name"][:30] for f in files if isinstance(f, dict)]
                print(f"  {l1['name']} > {l2['name']}: {names}")

        # 生成 JS 包装
        out = "// document_driven engine v2 生成（1023）\nmodule.exports = "
        out += json.dumps(bp, ensure_ascii=False, separators=(",", ":"))
        out += ";\n"
        fname = f"sample_{slug}_v2.js"
        fpath = os.path.join(OUT_DIR, fname)
        with open(fpath, "w", encoding="utf-8") as f:
            f.write(out)
        sz = os.path.getsize(fpath)
        print(f"saved: {fname} ({sz} bytes)")
    else:
        print(f"FALLBACK to {mode} — 文件驱动引擎未激活")
