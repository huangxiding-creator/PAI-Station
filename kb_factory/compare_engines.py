# -*- coding: utf-8 -*-
"""端到端对比：document_driven vs taxonomy 同域蓝图差异。"""
import sys, os, json
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
sys.stdout.reconfigure(encoding="utf-8", errors="replace")

from kb_factory.catalog_engine.engine import build_blueprint

NEED = {"domain": "水利EPC工程知识库", "keywords": ["EPC", "水利水电", "总承包", "施工"],
        "intent": "项目部技术管理", "size_hint": "small"}

print("=" * 60)
print("【旧引擎 · 分类法驱动】")
print("=" * 60)
bp_old = build_blueprint(dict(NEED), mode="taxonomy")
for l1 in bp_old["tree"]["l1"][:5]:
    l2s = [l2["name"] for l2 in l1["l2"][:3]]
    print(f"  L1: {l1['name']} ({len(l1['l2'])} 组)")
    for l2 in l1["l2"][:3]:
        files = (l2.get("files") or l2.get("split_dirs", [{}])[0].get("files", []))[:2]
        names = [f["name"][:25] for f in files if isinstance(f, dict)]
        print(f"    L2: {l2['name']} → {names}")
print(f"  总计: {bp_old['stats']['files']} 槽位, {bp_old['stats']['gb']}GB, ¥{bp_old['quote']['total']}")

print()
print("=" * 60)
print("【新引擎 · 文件驱动】")
print("=" * 60)
bp_new = build_blueprint(dict(NEED), mode="document_driven")
if bp_new["tree"]["mode"] == "document_driven":
    for l1 in bp_new["tree"]["l1"]:
        l2s = [l2["name"] for l2 in l1["l2"][:3]]
        print(f"  L1: {l1['name']} ({len(l1['l2'])} 组)")
        for l2 in l1["l2"][:3]:
            files = l2.get("files", [])
            real = sum(1 for f in files if f.get("real"))
            names = [f["name"][:30] for f in files[:3]]
            print(f"    L2: {l2['name']} ({real}/{len(files)} 真实) → {names}")
    print(f"  总计: {bp_new['stats']['files']} 文件, {bp_new['stats']['real_docs']} 真实, "
          f"{bp_new['stats']['gb']}GB, ¥{bp_new['quote']['total']}")
    print(f"  来源: {bp_new['provenance']['sources']}")
    print(f"  文件类型: {bp_new['provenance'].get('doc_types', [])}")
else:
    print(f"  降级到 {bp_new['tree']['mode']}（检索不足）")

# 保存两份蓝图供对比
outdir = os.path.join(os.path.dirname(os.path.abspath(__file__)), "compare")
os.makedirs(outdir, exist_ok=True)
json.dump(bp_old, open(os.path.join(outdir, "old_taxonomy.json"), "w", encoding="utf-8"),
          ensure_ascii=False, indent=1)
json.dump(bp_new, open(os.path.join(outdir, "new_document_driven.json"), "w", encoding="utf-8"),
          ensure_ascii=False, indent=1)
print(f"\n蓝图已保存到 kb_factory/compare/")
