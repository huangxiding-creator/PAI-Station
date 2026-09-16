# -*- coding: utf-8 -*-
"""观点维 v1：ima 九库收藏清单拉取 → 缓存 → topic 实体 + 观点分布报告。

收藏行为=观点认同信号（他亲手筛入知识库的内容）。官方 OpenAPI，轻节流 0.5s。
用法：python tools/cx_opinions.py
"""
from __future__ import annotations

import json
import subprocess
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

REPO = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(REPO / "src"))

from paistation.cx.entities import EntityStore  # noqa: E402

CACHE = REPO / "data/cx/collect_cache/ima_knowledge.json"
REPORT = REPO / "SELF_PROFILE/cx_观点维_知识库收藏_20260916.md"
SKILL = Path.home() / ".claude/skills/ima-skill/ima_api.cjs"


def call_api(path: str, body: dict) -> dict:
    proc = subprocess.run(
        ["node", str(SKILL), path, json.dumps(body, ensure_ascii=False), "{}"],
        capture_output=True, text=True, encoding="utf-8", errors="replace",
        creationflags=0x08000000, timeout=60)
    try:
        return json.loads(proc.stdout)
    except ValueError:
        return {"code": -999, "msg": proc.stdout[:200]}


def list_kb(kb_id: str, folder_id: str = "") -> tuple[list[dict], list[dict]]:
    """一个文件夹全量分页。返回 (条目, 子文件夹)。"""
    items: list[dict] = []
    folders: list[dict] = []
    cursor = ""
    while True:
        body = {"knowledge_base_id": kb_id, "limit": 50, "cursor": cursor}
        if folder_id:
            body["folder_id"] = folder_id
        d = call_api("openapi/wiki/v1/get_knowledge_list", body)
        data = d.get("data") or {}
        items += data.get("knowledge_list") or []
        folders += data.get("folder_list") or []
        if data.get("is_end"):
            break
        cursor = data.get("next_cursor") or ""
        if not cursor:
            break
        time.sleep(0.5)
    return items, folders


def main() -> int:
    d = call_api("openapi/wiki/v1/get_addable_knowledge_base_list",
                 {"limit": 20, "cursor": ""})
    kbs = (d.get("data") or {}).get("addable_knowledge_base_list") or []
    print(f"知识库: {len(kbs)} 个")

    cache = json.loads(CACHE.read_text(encoding="utf-8")) if CACHE.exists() else {}
    total = 0
    for kb in kbs:
        name = kb["name"].removeprefix("知识库：")
        if name in cache:
            n = cache[name]["count"]
            total += n
            print(f"  {name}: {n}（缓存）")
            continue
        # 根目录 + 递归子文件夹（BFS）
        all_items, queue = [], [""]
        seen: set[str] = set()
        while queue:
            fid = queue.pop(0)
            if fid in seen:
                continue
            seen.add(fid)
            items, folders = list_kb(kb["id"], fid)
            all_items += items
            queue += [f["folder_id"] for f in folders if f.get("folder_id")]
            time.sleep(0.5)
        # media_id 去重（跨文件夹同名收录）
        uniq = {i["media_id"]: i for i in all_items}
        cache[name] = {"kb_id": kb["id"], "count": len(uniq),
                       "items": list(uniq.values())}
        total += len(uniq)
        print(f"  {name}: {len(uniq)}")
        CACHE.write_text(json.dumps(cache, ensure_ascii=False), encoding="utf-8")

    # topic 实体 + curated_by 边（收藏=观点策展）
    store = EntityStore(REPO / "data/cx/entities.db")
    for name, blob in cache.items():
        store.register("topic", name, aliases=[blob.get("kb_id", "")],
                       source="ima_kb")
        store.register_link(f"topic/{name}", "person/总包君",
                            "curated_by", "ima_kb")
    store._conn.commit()

    lines = [
        "# 观点维 v1：ima 知识库收藏分布（策展=观点认同）",
        "",
        f"> 2026-09-16 · 九库 {total} 条收藏 · 收藏行为是最稳定的观点信号",
        "",
        "| 知识库 | 条数 | 类型分布 |", "|---|---|---|",
    ]
    from collections import Counter
    for name, blob in cache.items():
        kinds = Counter(("网页" if i.get("media_type") == 2 else "文档")
                        for i in blob.get("items", []))
        mix = "/".join(f"{k}{v}" for k, v in kinds.most_common())
        lines.append(f"| {name} | {blob['count']} | {mix} |")
    for name in ("总包君的知识库", "水利工程建设-449"):
        titles = [i["title"] for i in cache.get(name, {}).get("items", [])
                  if i.get("title")][:0]
    # 主库标题样本（水利主业视角）
    main_titles = [i["title"][:50] for i in
                   cache.get("水利工程建设-449", {}).get("items", [])
                   if i.get("title")][:15]
    lines += ["", "## 水利工程建设库·标题样本（主业关注焦点）", ""]
    lines += [f"- {t}" for t in main_titles]
    REPORT.write_text("\n".join(lines) + "\n", encoding="utf-8")
    print(f"合计 {total} 条 → {REPORT.name}")
    print("topics:", store.count("topic"), "| stats:",
          json.dumps(store.link_stats(), ensure_ascii=False))
    store.close()
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
