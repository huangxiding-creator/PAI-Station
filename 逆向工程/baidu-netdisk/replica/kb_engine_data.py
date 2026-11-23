# -*- coding: utf-8 -*-
"""kb_engine_data.py — 生成引擎 C1/C2 数据面（kb_catalog.json + kb_updates.json）。
数据源：plan.json（45 库体系）+ ledger.jsonl（就位账）+ changelog.jsonl（更新流）。
买家面口径：只出价值数字与库树，内部运维细节（errno/失败清单）不出境。
每次 update/index 收官后跑一次；镜像部署时随 KB_CONTENT_DIR 上船。"""
import sys, os, json, datetime, collections

HERE = os.path.dirname(os.path.abspath(__file__))
KB_DIR = os.path.join(HERE, "_kb_build")

p = json.load(open(os.path.join(KB_DIR, "plan.json"), encoding="utf-8"))
led = [json.loads(l) for l in open(os.path.join(KB_DIR, "ledger.jsonl"), encoding="utf-8")]
chg = []
cl_path = os.path.join(KB_DIR, "changelog.jsonl")
if os.path.exists(cl_path):
    chg = [json.loads(l) for l in open(cl_path, encoding="utf-8")]

libs = p["libs"]                       # {"00": "00. 项目管理体系库", ...}
desc = p.get("lib_desc") or {}
units = p.get("units") or []

placed_srcs = {x["src"] for x in led if x.get("status") == "copied"}

# 每库就位单元数（主挂载：unit.src 在 ledger copied 中）
lib_units = collections.Counter()
for u in units:
    key = u.get("lib")
    if key and key in libs and u.get("src") in placed_srcs:
        lib_units[key] += 1

kb_libs = []
for no in sorted(libs):
    kb_libs.append({
        "no": no,
        "name": libs[no],
        "desc": desc.get(no, ""),
        "mounted": lib_units.get(no, 0),
    })

catalog = {
    "version": "1.0.0",
    "title": "超级总包知识库（动态更新）",
    "generated": datetime.datetime.now().isoformat(timespec="seconds"),
    "stats": {
        "libs_total": len(libs),
        "units_total": len(units),
        "units_placed": len(placed_srcs),
        "backbone": len(p.get("backbone") or []),
    },
    "libs": kb_libs,
}
json.dump(catalog, open(os.path.join(KB_DIR, "kb_catalog.json"), "w", encoding="utf-8"),
          ensure_ascii=False, indent=1)

# 更新流：买家视角价值事件（复制入库按库聚合 / 索引发布 / 清理瘦身）
upd = []
for x in chg[-400:]:
    op = x.get("op")
    ts = x.get("ts", "")
    if op in ("copy", "apply") or (op is None and x.get("src")):
        src = x.get("src") or ""
        name = src.rsplit("/", 1)[-1]
        upd.append({"ts": ts, "kind": "mount", "title": f"新入库：{name}",
                    "detail": x.get("dst_dir", "")})
    elif op == "index":
        upd.append({"ts": ts, "kind": "index", "title": "索引与导航更新发布",
                    "detail": f"上传 {x.get('uploaded', '?')} 件索引"})
    elif op == "purge_orig":
        upd.append({"ts": ts, "kind": "slim", "title": f"库体瘦身：{x.get('lib','')} 原件并档",
                    "detail": "单一副本原则，容量腾给新内容"})
# 按天聚合 mount 事件，保留明细最近 60 条
day = collections.Counter(e["ts"][:10] for e in upd if e["kind"] == "mount")
summary = [{"date": d, "mounted": n} for d, n in sorted(day.items(), reverse=True)[:30]]
updates = {
    "generated": datetime.datetime.now().isoformat(timespec="seconds"),
    "stats": {"total_mount_events": sum(day.values()), "active_days": len(day)},
    "daily": summary,
    "entries": upd[-60:],
}
json.dump(updates, open(os.path.join(KB_DIR, "kb_updates.json"), "w", encoding="utf-8"),
          ensure_ascii=False, indent=1)
print(f"kb_catalog.json: {len(kb_libs)} libs, placed {catalog['stats']['units_placed']}/{catalog['stats']['units_total']}")
print(f"kb_updates.json: {len(upd[-60:])} entries, {len(day)} active days")
